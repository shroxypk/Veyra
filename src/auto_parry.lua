-- Auto Parry: predicts an attack's impact from animation markers, then opens
-- exactly one short block session per predicted impact.
--
-- Mechanics measured in-game (see the notes at the bottom of this file):
--   * a Block Input grants State_Parrying after roughly the round-trip latency,
--   * the granted parry lives about PARRY_WINDOW seconds and survives End Block,
--   * ParryCooldown then gates the next grant,
--   * repeating Block Input while already blocking cannot create a second parry.
-- Marker timings are candidates, not proof that an attack is parryable.
--
-- Lead derivation (why the press is centred where it is):
--   * the animation track is delayed by the inbound leg, so an impact authored
--     at marker time m happens, on this client's clock, at trackStart+m exactly
--     (the inbound delay cancels out);
--   * a press sent at local time S opens the parry at S+outbound;
--   * therefore the press must land outbound..outbound+PARRY_WINDOW before the
--     impact, i.e. centred at outbound+PARRY_WINDOW/2;
--   * `outbound` is measured exactly, and without any clock-sync assumption, by
--     reading StateEnd_Parrying (server clock) and StateDuration_Parrying on the
--     grant: grant_time = StateEnd - StateDuration, so outbound = grant_time -
--     GetServerTimeNow() sampled at send. The observed grant latency is longer
--     (it also carries the inbound leg) and is only used to keep the block
--     session open long enough to see the grant.
-- Marker->impact equality is measured, not assumed: passive observation of
-- other fights put the residual at +0.002s median (tests/data).
local G=getgenv()
if G.VeyraParry then G.VeyraParry.stop() end
local profiles=loadstring(readfile("Veyra/src/parry_profiles.lua"),"parry_profiles.lua")()
local timing=loadstring(readfile("Veyra/src/parry_math.lua"),"parry_math.lua")()
local Players=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local storage=game:GetService("ReplicatedStorage")
local player=Players.LocalPlayer

local wasAttacking=false
local resumeAt=0

local PARRY_WINDOW=0.25   -- how long a granted parry stays active
local SESSION_MIN=0.16    -- keep blocking at least this long so the grant lands
local PULSE_DEADLINE=0.55 -- hard cap on one block session
local PRESS_RATE=0.35     -- minimum spacing between sessions
local ATTACK_RELEASE_HORIZON=0.8 -- release a held attack this early before an inbound impact

local profiles_=profiles
local profileCount=0
for _ in pairs(profiles_) do profileCount+=1 end

local state={enabled=false,alive=true,status="Parry off",profiles=profileCount,
 range=14,leadOffset=0,lead=0.1,grantLag=0.15,attempts=0,grants=0,confirmed=0,damageEvents=0,
 unknown=0,missed=0,covered=0,gated=0,learned=0,calibrated=true,bias={},hitResiduals={},
 unparryable={},unparryableSkips=0,cooldownWait=0,
 unobservedGrants=0,successByAsset={},
 unknownAssets={},derived=0,log={}}
G.VeyraParry=state

local animators,watches,pending={},{},{}
local discoveryAdded,discoveryRemoved
local seen=setmetatable({},{__mode="k"})
local worker,packet,manager,character,healthConnection,attributeConnection
local session=nil
local lastSent=-math.huge
local nextScan=0
-- outbound send->grant (scheduling lead); observed grant lag (session length)
local lead=0.1
local grantLag=0.15
local pendingGate
local activeAttempt
local serverAnimations={}
local suitOnly={} -- Hit/Blocks/Parrys reaction animations are not attacks

local animations=storage:FindFirstChild("Animations")
local function index(folder,table_)
 if not folder then return end
 for _,animation in ipairs(folder:GetDescendants()) do
  if animation:IsA("Animation") then
   local id=animation.AnimationId:match("%d+")
   if id then table_[id]=true end
  end
 end
end
if animations then
 index(animations:FindFirstChild("Server"),serverAnimations)
 for _,name in ipairs({"Hit","Blocks","Parrys"}) do index(animations:FindFirstChild(name),suitOnly) end
 -- Reaction clips that are not under those folders but must never be read as
 -- an incoming swing (dodges, rolls, parry poses).
 for _,id in ipairs({"14417052527","13355016261","13355019718","8502285198",
  "8495698342","8495708006","132555387434309","93087728991591"}) do
  suitOnly[id]=true
 end
end

local function log(message)
 if #state.log>=120 then table.remove(state.log,1) end
 table.insert(state.log,string.format("%.3f %s",os.clock(),message))
end
-- Runtime profile derivation ------------------------------------------------
-- Many mob attacks are played from asset IDs that are not present under
-- ReplicatedStorage.Animations, so no baked table can cover every mob. The
-- authored hit markers are stripped from fetched KeyframeSequences, but the
-- pose data is not: an impact lands on, or just after, the fastest pose
-- movement of the swing. Against the 25 marker-authored profiles the probe
-- also covers, `peak + 0.03` put 23 of 26 impacts within 0.125s (median
-- 0.030s), which fits the 0.25s granted parry window. The three misses belong
-- to assets that already ship an authored profile, so they never reach here.
local HttpService=game:GetService("HttpService")
local KeyframeSequences=game:GetService("KeyframeSequenceProvider")
local derived={}          -- id -> {name,length,hits,derived=true}
local deriveTried={}      -- id -> true once a fetch was attempted
local deriveDirty=false
local deriveSaveAt=0
local DERIVED_PATH="Veyra/parry_derived.json"

local function validProfile(profile)
 return type(profile)=="table" and type(profile.hits)=="table" and #profile.hits>0
  and type(profile.length)=="number" and profile.length>0 and profile.length<=30 and #profile.hits<=32
end

local function loadDerived()
 if type(readfile)~="function" then return end
 local ok,raw=pcall(readfile,DERIVED_PATH)
 if not ok or type(raw)~="string" or #raw==0 or #raw>1048576 then return end
 local okDecode,data=pcall(function() return HttpService:JSONDecode(raw) end)
 if not okDecode or type(data)~="table" or type(data.profiles)~="table" then return end
 local count=0
 for id,profile in pairs(data.profiles) do
  count+=1 if count>512 then break end
  if type(id)=="string" and id:match("^%d+$") and validProfile(profile) then
   local hits={}
   for _,value in ipairs(profile.hits) do
    if type(value)=="number" and value>=0.2 and value<=profile.length+0.05 then hits[#hits+1]=value end
   end
   if #hits>0 then
    table.sort(hits)
    derived[id]={name=type(profile.name)=="string" and profile.name or ("asset "..id),
     length=profile.length,hits=hits,derived=true}
   end
  end
 end
end

local function saveDerived()
 if not deriveDirty or type(writefile)~="function" then return end
 local ok,encoded=pcall(function()
  return HttpService:JSONEncode({version=1,profiles=derived})
 end)
 if not ok or type(encoded)~="string" then return end
 if type(makefolder)=="function" then pcall(makefolder,"Veyra") end
 if pcall(writefile,DERIVED_PATH,encoded) then deriveDirty=false end
end
loadDerived()

-- Words that identify a reaction, movement or emote rather than a swing.
local NON_ATTACK_NAMES={"idle","walk","run","jump","fall","land","sit","emote",
 "dance","salute","laugh","meditate","sleep","spawn","death","dead","downed",
 "stagger","flinch","hit","parry","block","dodge","roll","equip","sheathe",
 "draw","carry","victim","grabbed","stunned","vault","climb","swim","sing"}
local function nameIsAttack(name)
 local lower=string.lower(name or "")
 if lower=="" or lower=="animation" then return true end
 for _,word in ipairs(NON_ATTACK_NAMES) do
  if string.find(lower,word,1,true) then return false end
 end
 return true
end

local function attackLike(track)
 if track.Looped then return false end
 local length=track.Length or 0
 -- Boss ultimates and long skills can exceed 3.5s; allow up to 6s for profiled assets
 if length<0.2 or length>6 then return false end
 local animation=track.Animation
 if not animation then return false end
 local id=animation.AnimationId:match("%d+")
 if not id or suitOnly[id] then return false end
 return nameIsAttack(animation.Name),id
end

-- World-space position of every pose node per keyframe, then the fastest node's
-- speed between keyframes. Using every pose (not just R6 names) also covers
-- custom rigs such as the lizard and mushroom bosses.
local function poseFrames(sequence)
 local keyframes={}
 for _,child in ipairs(sequence:GetChildren()) do
  if child:IsA("Keyframe") then keyframes[#keyframes+1]=child end
 end
 -- GetChildren order is not guaranteed to be time order; a late keyframe can be
 -- returned last while its Time is earlier than the tail. Sort before deriving
 -- speeds, or dt goes negative and the peak lands on the wrong frame.
 table.sort(keyframes,function(a,b) return a.Time<b.Time end)
 local frames,previous,previousTime={},{},nil
 for _,keyframe in ipairs(keyframes) do
  local current={}
  for _,pose in ipairs(keyframe:GetDescendants()) do
   if pose:IsA("Pose") then
    local cframe=pose.CFrame
    local node=pose.Parent
    local guard=0
    while node and node:IsA("Pose") and guard<8 do
     cframe=node.CFrame*cframe node=node.Parent guard+=1
    end
    current[pose.Name]=cframe.Position
   end
  end
  local speed=0
  local dt=previousTime and (keyframe.Time-previousTime) or 0
  if dt>0 then
   for name,position in pairs(current) do
    local old=previous[name]
    if old then
     local value=(position-old).Magnitude/dt
     if value>speed then speed=value end
    end
   end
  end
  previous=current previousTime=keyframe.Time
  frames[#frames+1]={t=keyframe.Time,s=speed}
 end
 return frames,previousTime or 0
end

local function deriveHits(frames,length)
 local maxSpeed=0
 for _,frame in ipairs(frames) do if frame.s>maxSpeed then maxSpeed=frame.s end end
 if maxSpeed<6 then return nil end -- a sway, not a swing
 local threshold=math.max(4,maxSpeed*0.15)
 local peaks={}
 local index=1
 while index<=#frames do
  if frames[index].s>=threshold then
   local stop=index
   while stop<=#frames and frames[stop].s>=threshold*0.5 do stop+=1 end
   local peak=frames[index]
   for cursor=index,stop-1 do
    if frames[cursor].s>peak.s then peak=frames[cursor] end
   end
   peaks[#peaks+1]=peak.t
   index=stop
  else
   index+=1
  end
 end
 if #peaks==0 then return nil end
 -- Bursts closer than 0.28s belong to one swing: a single granted parry covers
 -- every impact inside that span, so schedule one press for the cluster centre.
 local hits,cluster={},{peaks[1]}
 for cursor=2,#peaks do
  if peaks[cursor]-cluster[#cluster]<=0.28 then
   cluster[#cluster+1]=peaks[cursor]
  else
   hits[#hits+1]=(cluster[1]+cluster[#cluster])/2+0.03
   cluster={peaks[cursor]}
  end
 end
 hits[#hits+1]=(cluster[1]+cluster[#cluster])/2+0.03
 local kept={}
 for _,hit in ipairs(hits) do
   -- Conservative cutoff for pose-derived guesses; early authored hits still
   -- use their original profiles and the scheduler's arrival deadline.
  if hit>=0.2 and hit<=length+0.05 then kept[#kept+1]=hit end
 end
 if #kept==0 then return nil end
 return kept
end

local function derive(id,name)
 if derived[id]~=nil or deriveTried[id] then return derived[id] end
 deriveTried[id]=true
 task.spawn(function()
  local ok,sequence=pcall(function()
   return KeyframeSequences:GetKeyframeSequenceAsync("rbxassetid://"..id)
  end)
  if not ok or not sequence then return end
  local parsed,frames,length=pcall(poseFrames,sequence)
  sequence:Destroy()
  if not state.alive or not parsed or #frames<2 then return end
  local hits=deriveHits(frames,length)
  if not hits then return end
  local profile={name=name or ("asset "..id),length=length,hits=hits,derived=true}
  if not validProfile(profile) then return end
  derived[id]=profile
  deriveDirty=true
  state.derived=(state.derived or 0)+1
  local times={}
  for _,hit in ipairs(hits) do times[#times+1]=string.format("%.2f",hit) end
  log(string.format("derived %s: %d hit(s) %s",derived[id].name,#hits,table.concat(times,",")))
 end)
end
local function send(action)
 if not packet then return false end
 local ok,err=pcall(function() packet.send({Action=action}) end)
 if not ok then log("send "..action..": "..tostring(err)) return false end
 return true
end
local function endSession(reason)
 if not session then return end
 send("End Block")
 if activeAttempt then activeAttempt.ended=os.clock() end
 if reason=="timeout" and not session.granted then
  if not session.calibration then state.unobservedGrants+=1 end
  log("no grant observed within session")
 end
 session=nil
end
local function clearCharacter()
 endSession("reset")
 table.clear(pending)
 table.clear(seen)
 activeAttempt=nil
 if healthConnection then healthConnection:Disconnect() healthConnection=nil end
 if attributeConnection then attributeConnection:Disconnect() attributeConnection=nil end
 wasAttacking=false
 resumeAt=0
 character,manager=nil,nil
end
local function bindCharacter(c)
 clearCharacter()
 character=c
 if not c then return end
 local ok,result=pcall(function() return require(storage.Modules.StateManager).require(c) end)
 if ok then manager=result else log("state manager: "..tostring(result)) end
 local humanoid=c:FindFirstChildOfClass("Humanoid")
 if humanoid then
  local previous=humanoid.Health
  healthConnection=humanoid.HealthChanged:Connect(function(value)
   if state.enabled and value<previous then
    state.damageEvents+=1
    local now=os.clock()
    local note="with no attempt"
    if activeAttempt then
     note=string.format("after %s (%.2fs)",activeAttempt.name,now-activeAttempt.time)
     if activeAttempt.impactAt and activeAttempt.asset then
       -- Health replication supplies neither the attacker nor the impact time.
       -- Record residuals for inspection; learn bias only when outcome is not "inside"
       -- (inside = impact landed during granted parry window -> unparryable attack).
      local residual=now-activeAttempt.impactAt
      if math.abs(residual)<=0.4 then
       local granted=activeAttempt.granted==true
       local oc=granted and timing.outcome(residual,PARRY_WINDOW,-0.02) or "unobserved"
       if granted and oc=="inside" then
        local strikes=(state.unparryable[activeAttempt.asset] or 0)+1
        state.unparryable[activeAttempt.asset]=strikes
        table.insert(state.hitResiduals,string.format("%s %+.3f near prediction -> ambiguous (%d)",
         activeAttempt.name,residual,strikes))
        note=note..string.format(" residual %+.3fs near prediction (ambiguous damage)",residual)
       else
         table.insert(state.hitResiduals,string.format("%s %+.3f %s damage",
          activeAttempt.name,residual,oc))
         note=note..string.format(" residual %+.3fs (%s)",residual,oc)
         -- Learn from early/late residuals when we had a grant (not inside/unobserved)
         if granted and (oc=="early" or oc=="late") then
          state.bias[activeAttempt.asset]=timing.learnBias(state.bias[activeAttempt.asset],residual)
          log(string.format("bias %s: %+.4f",activeAttempt.asset,state.bias[activeAttempt.asset]))
         end
       end
       while #state.hitResiduals>20 do table.remove(state.hitResiduals,1) end
      end
     end
    end
    log(string.format("damage %.1f %s",previous-value,note))
   end
   previous=value
   if value<=0 then endSession("dead") table.clear(pending) state.status="Parry: waiting for respawn" end
  end)
 end
 attributeConnection=c.AttributeChanged:Connect(function(name)
  if not state.enabled or c:GetAttribute(name)~=true then return end
  if name=="State_Parrying" then
   state.grants+=1
   if session and not session.granted then
    session.granted=true
    if activeAttempt and not session.calibration then activeAttempt.granted=true end
    local observed=os.clock()-session.sentAt
    if observed>0 and observed<1 then
     -- Observed lag: send -> attribute visible. Ends the block session.
     grantLag=grantLag*0.75+observed*0.25
     state.grantLag=grantLag
    end
    -- Exact send->grant lag in server time, free of clock-offset error.
    local endAt=c:GetAttribute("StateEnd_Parrying")
    local duration=c:GetAttribute("StateDuration_Parrying")
    if endAt and duration and session.sendServer then
     local outbound=(endAt-duration)-session.sendServer
     if outbound>-0.05 and outbound<0.4 then
      outbound=math.max(outbound,0)
      lead=math.clamp(lead*0.75+outbound*0.25,0.01,0.3)
      state.lead=lead state.learned+=1 state.calibrated=true
     end
    end
    log(string.format("grant in %.3fs (lead %.3f)",observed,lead))
    endSession("grant")
   else
    log("grant without an active session")
   end
  elseif name=="State_ParriedAttack" then
   state.confirmed+=1
   if activeAttempt and not activeAttempt.confirmed then
    activeAttempt.confirmed=true
    if activeAttempt.asset then
     local id=activeAttempt.asset
     state.successByAsset[id]=(state.successByAsset[id] or 0)+1
    end
   end
   log("CONFIRMED deflection"..(activeAttempt and (" near "..activeAttempt.name) or ""))
   endSession("parried")
  end
 end)
end

local function gateReason(c)
 for _,name in ipairs({"Attacking","ParryCooldown","Parrying","Blocking","SwordBlocking",
  "Stunned","SkillActive","Dodging","BlockBroken","Ragdoll","Occupied","Knocked","Downed",
  -- A successful parry leaves a ~0.5s APF grace where further hits are already
  -- negated, so pressing again only buys the ~1s lockout.
  "APF","Parried","ParriedAttack"}) do
  if c:GetAttribute("State_"..name)==true then return name end
 end
 return "CanParry=false"
end
local function ready(ignoreCooldown)
 local c=player.Character
 local h=c and c:FindFirstChildOfClass("Humanoid")
 if not h or h.Health<=0 then return nil,"waiting for respawn" end
 local root=c:FindFirstChild("HumanoidRootPart")
 if not root then return nil,"waiting for character" end
 local tool=c:FindFirstChildOfClass("Tool")
 if not tool or not (tool:GetAttribute("Sword") or tool:GetAttribute("Combat")) then return nil,"equip a combat weapon" end
 if UIS:GetFocusedTextBox() then return nil,"typing" end
 local bind=player:FindFirstChild("Binds")
 local block=bind and bind:FindFirstChild("Block")
 local key=block and tostring(block.Value) or "F"
 local code=Enum.KeyCode[key:match("[^.]+$") or "F"]
 if code and UIS:IsKeyDown(code) then return nil,"manual block" end
 if not manager then return nil,"state manager unavailable" end
 -- Damage is discarded inside a safezone, so a press there only costs the lockout.
 if h:GetAttribute("InSafezone")==true then return nil,"safezone" end
  if not manager:CanParry() then
   -- A cooldown timestamp may relax only the cooldown gate. Match the other
   -- CanParry predicates rather than trusting the first diagnostic reason.
   if not ignoreCooldown or not manager:HasState("ParryCooldown")
    or manager:IsBlocking() or manager:IsIncapacitated() or manager:IsDodging()
    or manager:IsParrying() or manager:IsUsingSkill() or manager:IsFlying()
    or manager:HasAnyState("Occupied","Attacking") then
    return nil,gateReason(c)
   end
  end
 -- Post-parry grace: hits are already negated for ~APF seconds.
 if c:GetAttribute("State_APF")==true then return nil,"APF grace" end
 return root
end
-- The replicated ParryCooldown state clears one inbound leg late, so a press
-- that waits for it lands ~2*outbound after the server is actually ready. The
-- server also publishes the cooldown's end time, which lets us aim the press at
-- the real expiry instead of at the stale attribute.
local function cooldownReadyAt(c,now)
 local endAt=c:GetAttribute("StateEnd_ParryCooldown")
 if type(endAt)~="number" then return -math.huge end
 local ok,server=pcall(function() return workspace:GetServerTimeNow() end)
 if not ok or type(server)~="number" then return -math.huge end
 return now+math.max(0,endAt-server)
end

local function observe(model,track)
 if seen[track] then return end
 seen[track]=true
 local id=track.Animation and track.Animation.AnimationId:match("%d+")
 if id and suitOnly[id] then return end
 local profile=id and (profiles_[id] or derived[id])
 -- No profile = no press. Derive in background for future plays; do not guess.
 if not profile and id then
  local attack,animId=attackLike(track)
  if attack and animId then derive(animId,track.Animation.Name) end
  -- Always attempt derivation for known server animations, even if attackLike filters them
  if serverAnimations[id] and not state.unknownAssets[id] then
   state.unknownAssets[id]=true state.unknown+=1 log("unsupported melee asset "..id)
   if not deriveTried[id] then derive(id,track.Animation.Name) end
  end
 end
 if not profile then return end
 if track.Looped then return end
 for _,hit in ipairs(profile.hits) do
  table.insert(pending,{model=model,track=track,hit=hit,name=profile.name,id=id,
   gate=profile.gate,length=profile.length,offset=profile.offset,
   expires=os.clock()+12})
 end
 log("observed "..model.Name.." / "..profile.name..(profile.gate and " (feint-gated)" or ""))
end
local function unwatch(animator)
 local watch=watches[animator]
 if watch then watch.connection:Disconnect() watches[animator]=nil end
end
local function scan()
 local c=player.Character
 local root=c and c:FindFirstChild("HumanoidRootPart")
 local keep={}
 if root then
  for item in pairs(animators) do
   if item.Parent then
    local h=item.Parent
    local model=h and h.Parent
    local other=model and model:FindFirstChild("HumanoidRootPart")
    if h:IsA("Humanoid") and h.Health>0 and model~=c and other
     and not Players:GetPlayerFromCharacter(model)
     and (other.Position-root.Position).Magnitude<=150 then
     keep[item]=true
     if not watches[item] then
      watches[item]={connection=item.AnimationPlayed:Connect(function(track)
       -- A reused track is a new attack even if no scan saw it stop.
       seen[track]=nil
        for i=#pending,1,-1 do if pending[i].track==track then table.remove(pending,i) end end
       observe(model,track)
      end)}
     end
     for _,track in ipairs(item:GetPlayingAnimationTracks()) do observe(model,track) end
    end
   end
  end
 end
 for animator in pairs(watches) do if not keep[animator] then unwatch(animator) end end
 for track in pairs(seen) do if not track.IsPlaying then seen[track]=nil end end
end
-- An interrupted attacker's swing will never resolve, so pressing for it only
-- burns the ~1s lockout.
local INTERRUPTED={"Stunned","Parried","ParriedAttack","Ragdoll","Downed","Knocked","BlockBroken"}
local function interrupted(model)
 for _,name in ipairs(INTERRUPTED) do
  if model:GetAttribute("State_"..name)==true then return true end
 end
 return false
end
-- Mob reach data: animation ID or mob name → reach (studs). Used as fallback when state.range is not set.
-- Values from wiki weapon tables + observed boss ranges. Unknown mobs default to 8.
-- UNPARRYABLE moves are excluded; they are blocked by isUnparryable() before range checks.
local MOB_REACH = {
	-- Bandit variants (dagger/sword ~7.5-9)
	["123693468061117"] = 8,   -- Punch1 / BanditSlashA
	["111510911006717"] = 8,   -- Punch2 / BanditSlashB
	["85570415456598"] = 8,    -- Punch3 / BanditSlashC
	["140664544166823"] = 8,   -- Vicious Assault / BanditSlashD
	["99787918237880"] = 8,    -- Knockback / BanditSlashE
	["9839879425"] = 8,        -- BanditAnimation
	["9839904022"] = 8,        -- Bandit/Wounded Alke
	["9839955546"] = 8,        -- Bandit
	["9873286798"] = 8,        -- Bandit
	-- Kamo Guard (spear/polearm ~8.5-9.5)
	["9839859772"] = 9,        -- KamoGuardAnimation
	["10028752861"] = 9,       -- KamoGuardAnimation2
	["18910040255"] = 9,       -- Kamo Guard Respawnable
	-- Wolf (melee bite ~7.5)
	["124023674688709"] = 8,   -- WolfAnimation
	["105273448305185"] = 8,   -- Wolf
	-- Heavy weapons (greatsword/axe ~9.5-10)
	["9557400534"] = 10,       -- HeavyDagger
	["10694823147"] = 10,      -- HeavyRapier
	["8314692364"] = 10,       -- HammerDown
	-- Alke (boss)
	["9924282016"] = 10,       -- AlkeCombo
	-- Thief / Bandit common
	["9839879425"] = 8,        -- BanditAnimation (Thief uses)
	-- Zombie
	["11892996649"] = 8,       -- Zombie1
	["11893001175"] = 8,       -- Zombie2
	["11893004134"] = 8,       -- ZombieKnockback
	-- Golem
	["14158890923"] = 9,       -- Golem 1
	["14158953103"] = 9,       -- Golem 2
	-- Fell Hunter
	["125612125612125"] = 9,   -- Fell Hunter (placeholder - will use name fallback)
}

local DEFAULT_REACH = 8

local function getReach(candidate)
	-- Prefer asset ID, fall back to mob name heuristic
	if candidate.id and MOB_REACH[candidate.id] then return MOB_REACH[candidate.id] end
	local name = (candidate.model and candidate.model.Name) or ""
	if name:find("Guard") or name:find("Sentinel") then return 9 end
	if name:find("Knight") or name:find("Brute") then return 10 end
	if name:find("Boss") or name:find("Alke") or name:find("Blight") then return 12 end
	if name:find("Thief") or name:find("Bandit") then return 8 end
	if name:find("Wolf") then return 8 end
	if name:find("Zombie") then return 8 end
	if name:find("Golem") then return 9 end
	if name:find("Fell") or name:find("Hunter") then return 9 end
	return DEFAULT_REACH
end

-- Clips that must never be treated as an attack. The reaction entries are
-- structural (they are the game's own parry/dodge/hit clips, never a mob swing);
-- the rest are reported grabs/guardbreaks and are advisory, not field-verified.
-- This list only ever *suppresses* a press, so an unverified entry can cost a
-- parry but can never invent one.
local UNPARRYABLE = {
	["14417052527"] = true,  -- Parry reaction
	["13355016261"] = true,  -- Dodge
	["13355019718"] = true,  -- Roll
	["8502285198"] = true,   -- Hit reaction
	["8495698342"] = true,   -- Hit reaction
	["8495708006"] = true,   -- Hit reaction
	-- Reported grabs/guardbreaks (advisory, unverified in the field; only suppress presses)
	["11469887779"] = true,  -- GrabLunge
	["9922542154"] = true,       -- AlkeRoar/AlkeSkill
}

local function isUnparryable(candidate)
	if candidate.id and UNPARRYABLE[candidate.id] then return true end
	-- Heuristic: grab/lunge/throw/slam/stomp names often unparryable
	local n = (candidate.name or ""):lower()
	if n:find("grab") or n:find("throw") or n:find("slam") or n:find("stomp")
	 or n:find("crush") or n:find("smash") or n:find("ground pound")
	 or (n:find("lunge") and not n:find("slash")) then return true end
	return false
end

-- Line-of-sight check: HRP to HRP raycast, ignore attacker and player
local function hasLOS(root, other)
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {player.Character, other.Parent}
	params.FilterType = Enum.RaycastFilterType.Exclude
	local dir = (other.Position - root.Position)
	local result = workspace:Raycast(root.Position, dir, params)
	return result == nil or (result.Instance and result.Instance:IsDescendantOf(other.Parent))
end

local function incoming(candidate,root,remaining)
 local model=candidate.model
 local h=model:FindFirstChildOfClass("Humanoid")
 local other=model:FindFirstChild("HumanoidRootPart")
 if not h or h.Health<=0 or not other then return false,"attacker unavailable" end
 if interrupted(model) then return false,"attacker interrupted" end
 if isUnparryable(candidate) then return false,"unparryable move" end
 local delta=root.Position-other.Position
 local distance=delta.Magnitude
 local reach = getReach(candidate)
 -- Spin/circle attacks at very close range: skip facing check but still require LOS/height
 local isCloseSpin = distance < 8
 if math.abs(delta.Y)>10 then return false,"height" end
 local direction=delta.Unit
 local closing=(other.AssemblyLinearVelocity-root.AssemblyLinearVelocity):Dot(direction)
 -- The slider caps how far away a reaction is allowed, but it must never
 -- stretch a swing beyond the mob's real reach: pressing at 14 studs for an
 -- 8-stud dagger whiffs the parry and burns the ~1s lockout.
 local effectiveRange = math.min(state.range or reach, reach+2)
 if not timing.inRange(distance,closing,remaining,effectiveRange) then return false,string.format("range %.1f/%.1f",distance,effectiveRange) end
 if not isCloseSpin and other.CFrame.LookVector:Dot(direction)<0.25 then return false,"attacker facing away" end
 if not hasLOS(root, other) then return false,"no LOS" end
 return true
end

local function startSession(now,name,calibration)
 local okServer,sendServer=pcall(function() return workspace:GetServerTimeNow() end)
 if not send("Block Input") then return false end
 lastSent=now
 -- Keep the session open long enough to observe the grant, then release.
 session={sentAt=now,sendServer=okServer and sendServer or nil,
  deadline=now+math.min(PULSE_DEADLINE,math.max(SESSION_MIN,grantLag+0.06)),
  calibration=calibration or nil}
 if not calibration then
  state.attempts+=1
  activeAttempt={name=name,time=now}
  log(string.format("input %s lead=%.3f gate=%s",name,lead,
   pendingGate and string.format("%.2f",pendingGate) or "-"))
 else
  log("calibration pulse; waiting for grant")
 end
 return true
end

local function step()
 local now=os.clock()
 if player.Character~=character then bindCharacter(player.Character) end
 if session and now>=session.deadline then endSession("timeout") end
 if deriveDirty and now>=deriveSaveAt then deriveSaveAt=now+2 saveDerived() end
 if now>=nextScan then nextScan=now+0.4 scan() end
 local root,reason=ready()
 local available=root~=nil
 local myRoot=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
 local nearestInbound,nearestInboundName,nearestInboundId
 local notBefore=-math.huge
 if root then
  state.status=string.format("Parry · %d inputs · %d parried · %d hit",state.attempts,state.confirmed,state.damageEvents)
  state.blockedReason=nil
 elseif reason=="ParryCooldown" then
  -- Still schedule: aim the press at the server's real cooldown expiry so the
  -- window opens when the server accepts it, not one round trip later.
  local c=player.Character
   local r=ready(true)
   if c and r then
   local readyAt=cooldownReadyAt(c,now)
   if readyAt>-math.huge then
    root=r
    -- send -> grant is `lead`; the server must receive it after the expiry.
    notBefore=readyAt-lead+0.02
    state.cooldownWait=math.max(0,notBefore-now)
   end
  end
  state.status="Parry: "..reason
  if state.blockedReason~=reason then log("waiting: "..reason) end
  state.blockedReason=reason
 else
  state.status="Parry: "..reason
  if state.blockedReason~=reason then log("waiting: "..reason) end
  state.blockedReason=reason
 end
 if session then
  -- Published for Auto Dodge: a session is in flight, so a roll would cancel it.
  state.pressing=true state.impactIn=nil state.impactId=nil
  return
 end
 state.pressing=false
 -- No idle calibration: a whiff can impose recovery lag. Only press on profiles.
 -- No defensive hold: unknown attacks may be unparryable or guardbreaking.
  -- Calibration is optional: a pending attack must never be blocked by it.
 local best,bestLatest
 for i=#pending,1,-1 do
  local candidate=pending[i]
  local track=candidate.track
  local position=track.TimePosition
  if not candidate.model:IsDescendantOf(workspace) or not track.IsPlaying or now>candidate.expires
   or timing.stale(position,candidate.hit,candidate.length,0.3) then
   table.remove(pending,i)
  else
   local remaining=(candidate.hit-position)/track.Speed
    -- Soonest inbound swing, regardless of press timing: a held attack may
    -- have to be released well before the press is due.
    if myRoot and remaining<=ATTACK_RELEASE_HORIZON then
     local ok2,inb=pcall(incoming,candidate,myRoot,remaining)
     if ok2 and inb and (not nearestInbound or remaining<nearestInbound) then
      nearestInbound=remaining
      nearestInboundName=candidate.name
      nearestInboundId=candidate.id
     end
    end
   -- Learned per-asset shift: runtime misses override the baked measurement.
   local effective=lead+state.leadOffset+(state.bias[candidate.id] or candidate.offset or 0)
   local at,latest=timing.window(position,track.Speed,candidate.hit,effective,
    PARRY_WINDOW/2,candidate.gate)
   if latest and latest< -0.05 then
    table.remove(pending,i)
    state.missed+=1
    log("missed "..candidate.name..": "..(candidate.blocked or "no eligible frame observed"))
    elseif at and at<=0 and latest>=0 then
     local eligible,why=false,reason
     if root then eligible,why=incoming(candidate,root,remaining) end
     if not eligible then
      candidate.blocked=why or "not ready"
     elseif now<notBefore then
      candidate.blocked="cooldown arrival deadline"
     elseif now-lastSent<PRESS_RATE then
      candidate.blocked="input rate limit"
     elseif not bestLatest or latest<bestLatest then
      best,bestLatest=candidate,latest
      best.remaining=remaining
     end
   end
  end
 end
 -- Published for Auto Dodge: the soonest profiled impact this module knows
 -- about, and whether its own gates let it press right now.
 state.impactIn=nearestInbound
 state.impactId=nearestInboundId
  -- Release a held attack early: the server keeps Attacking until the current
  -- swing finishes, and CanParry is false while Attacking, so M1 must drop
  -- ahead of the press deadline (which is only lead+window before impact).
  -- Never steal the button during a minigame round: mining and harvesting use
  -- the same held input, and yanking it mid-round fails the minigame for the
  -- player. The hub's other modules must not fight over one mouse button.
  local minigames=G.VeyraMinigames
  local busy=minigames~=nil and (minigames.active==true or minigames.round~=nil)
  if nearestInbound and not wasAttacking and manager and myRoot and not busy then
   local okA,isAttacking=pcall(function() return manager:HasState("Attacking") end)
   if okA and isAttacking then
    local vim=game:GetService("VirtualInputManager")
    local ok=pcall(function() vim:SendMouseButtonEvent(0,0,0,false,game,0) end)
    if ok then
     wasAttacking=true
     resumeAt=now+nearestInbound+0.25
     log(string.format("released attack for inbound %s (%.2fs)",nearestInboundName,nearestInbound))
    end
   end
  end
  -- Resume after the impact passes and nothing else is inbound, or straight
  -- away if a minigame round started and needs the button back.
  if wasAttacking and (busy or (now>=resumeAt and not nearestInbound)) then
   local vim=game:GetService("VirtualInputManager")
   pcall(function() vim:SendMouseButtonEvent(0,0,0,true,game,0) end)
   wasAttacking=false
   log("resumed attack")
  end

   if best and now-lastSent>=PRESS_RATE and now>=notBefore then
  pendingGate=best.gate
   if startSession(now,best.name,false) then
   activeAttempt.asset=best.id
   activeAttempt.offset=best.offset
   activeAttempt.impactAt=now+best.remaining
    -- Sending input is not a grant. Keep other attacks eligible for subsequent
    -- evaluation; cooldown/state gates prevent redundant presses.
   for i=#pending,1,-1 do
    local candidate=pending[i]
    if candidate.track==best.track and candidate.hit==best.hit then
     table.remove(pending,i)
    end
   end
  end
  pendingGate=nil
 end
   if activeAttempt and now-activeAttempt.time>1 then activeAttempt=nil end
 end

function state.setEnabled(on)
 if not state.alive then return false end
 on=on==true
 if on==state.enabled then return on end
 if not on then
  state.enabled=false
  if worker then worker:Disconnect() worker=nil end
  if discoveryAdded then discoveryAdded:Disconnect() discoveryAdded=nil end
  if discoveryRemoved then discoveryRemoved:Disconnect() discoveryRemoved=nil end
  table.clear(animators)
  for animator in pairs(watches) do unwatch(animator) end
  clearCharacter()
  state.status="Parry off"
  return false
 end
 local ok,result=pcall(function() return require(storage.Modules.Packets).Combat.packets.BlockInput end)
 if not ok or not result or type(result.send)~="function" then
  state.status="Parry: input unavailable" log(tostring(result)) return false
 end
 packet=result state.enabled=true nextScan=0
 discoveryAdded=workspace.DescendantAdded:Connect(function(item)
  if item:IsA("Animator") then animators[item]=true end
 end)
 discoveryRemoved=workspace.DescendantRemoving:Connect(function(item)
  if animators[item] then animators[item]=nil unwatch(item) end
 end)
  for _,name in ipairs({"FightableNPCS","NPCS"}) do
   local folder=workspace:FindFirstChild(name)
   if folder then
    for index,model in ipairs(folder:GetChildren()) do
     if index>512 then break end
     local humanoid=model:FindFirstChildOfClass("Humanoid")
     local animator=humanoid and humanoid:FindFirstChildOfClass("Animator")
     if animator then animators[animator]=true end
    end
   end
  end
 bindCharacter(player.Character)
 worker=RS.Heartbeat:Connect(function()
  local success,err=pcall(step)
  if not success then
   state.setEnabled(false)
   state.status="Parry error: "..tostring(err)
   log(state.status)
  end
 end)
 return true
end
function state.stop()
 state.setEnabled(false)
 saveDerived()
 state.alive=false
 if G.VeyraParry==state then G.VeyraParry=nil end
end
-- Auto Dodge asks this before rolling: an animation this module has a profile
-- for is left to parry, everything else is dodge's problem.
function state.knows(id) return id~=nil and (profiles_[id]~=nil or derived[id]~=nil) end
function state.isWorking() return worker~=nil end
return state
