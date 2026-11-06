-- Auto Parry: predicts an attack's impact from animation markers, then opens
-- exactly one short block session per predicted impact.
--
-- SELF-IMPROVING SYSTEM:
--   * lead/grantLag: calibrated from every observed grant (StateEnd_Parrying - StateDuration_Parrying - sendServerTime)
--   * bias: per-asset timing correction from damage residuals (early/late when grant observed)
--   * mobReach: learned from distance at impact when grant+damage confirm a hit
--   * unparryable: verified - if State_ParriedAttack fires for listed ID, it's removed
--   * clusterThreshold: per-asset, learned from hit spacing in profile
--   * derivedHitOffset: per-asset, learned from calibration grant residuals
--   * attackClassification: pose-velocity threshold (6 studs/s) + name filter
--   * All learned data persists in Veyra/config.json and Veyra/parry_derived.json
--
-- Mechanics measured in-game:
--   * Block Input grants State_Parrying after ~round-trip latency
--   * Granted parry lives PARRY_WINDOW seconds and survives End Block
--   * ParryCooldown gates next grant
--   * Repeating Block Input while blocking cannot create second parry

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

-- Config-driven constants (with measured defaults)
local prefs=G.VeyraConfig and G.VeyraConfig.values and G.VeyraConfig.values.parry or {}
local function cfg(key,def) return prefs[key] or def end

local PARRY_WINDOW=cfg("parryWindow",0.25)
local SESSION_MIN=cfg("sessionMin",0.16)
local PULSE_DEADLINE=cfg("pulseDeadline",0.55)
local PRESS_RATE=cfg("pressRate",0.35)
local ATTACK_RELEASE_HORIZON=cfg("releaseHorizon",0.8)

local profiles_=profiles
local profileCount=0
for _ in pairs(profiles_) do profileCount+=1 end

-- ============================================================
-- SELF-IMPROVING STATE (persisted via config)
-- ============================================================
local function loadSelfImproving()
    local saved = prefs.selfImproving or {}
    return {
        lead = saved.lead or cfg("lead",0.1),
        grantLag = saved.grantLag or cfg("grantLag",0.15),
        bias = saved.bias or {},
        mobReach = saved.mobReach or {},
        unparryable = saved.unparryable or {},
        clusterThreshold = saved.clusterThreshold or {},
        derivedHitOffset = saved.derivedHitOffset or {},
        calibrated = saved.calibrated or false,
    }
end

local si = loadSelfImproving()

local state={enabled=false,alive=true,status="Parry off",profiles=profileCount,
 range=cfg("range",14),leadOffset=0,lead=si.lead,grantLag=si.grantLag,
 attempts=0,grants=0,confirmed=0,damageEvents=0,
 unknown=0,missed=0,covered=0,gated=0,learned=0,calibrated=si.calibrated,
 bias=si.bias,hitResiduals={},
 unparryable={},unparryableSkips=0,cooldownWait=0,
 unobservedGrants=0,successByAsset={},
 unknownAssets={},derived=0,log={},
 -- Self-improving runtime state
 mobReach = si.mobReach,           -- id -> reach (learned from impacts)
 unparryableVerified = si.unparryable, -- id -> true (verified unparryable)
 clusterThreshold = si.clusterThreshold, -- id -> threshold (learned from hit spacing)
 derivedHitOffset = si.derivedHitOffset, -- id -> offset (learned from residuals)
}
G.VeyraParry=state

-- ============================================================
-- PERSISTENCE HELPERS
-- ============================================================
local function saveSelfImproving()
    if not G.VeyraConfig or not G.VeyraConfig.set then return end
    G.VeyraConfig.patch("parry", {
        selfImproving = {
            lead = state.lead,
            grantLag = state.grantLag,
            bias = state.bias,
            mobReach = state.mobReach,
            unparryable = state.unparryableVerified,
            clusterThreshold = state.clusterThreshold,
            derivedHitOffset = state.derivedHitOffset,
            calibrated = state.calibrated,
        }
    })
end

-- Debounced save (every 5s when dirty)
local siDirty = false
local siSaveAt = 0
local function markSiDirty()
    siDirty = true
    siSaveAt = os.clock() + 5
end

local function flushSiIfNeeded()
    if siDirty and os.clock() >= siSaveAt then
        siDirty = false
        saveSelfImproving()
    end
end

-- ============================================================
local animators,watches,pending={},{},{}
local discoveryAdded,discoveryRemoved
local seen=setmetatable({},{__mode="k"})
local worker,packet,manager,character,healthConnection,attributeConnection
local session=nil
local lastSent=-math.huge
local nextScan=0
local pendingGate
local activeAttempt
local serverAnimations={}
local suitOnly={}

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
 for _,id in ipairs({"14417052527","13355016261","13355019718","8502285198",
  "8495698342","8495708006"}) do
  suitOnly[id]=true
 end
end

local function log(message)
 if #state.log>=120 then table.remove(state.log,1) end
 table.insert(state.log,string.format("%.3f %s",os.clock(),message))
end

-- ============================================================
-- RUNTIME PROFILE DERIVATION
-- ============================================================
local HttpService=game:GetService("HttpService")
local KeyframeSequences=game:GetService("KeyframeSequenceProvider")
local derived={}
local deriveTried={}
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
  count+=1 if count>1024 then break end
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

-- ============================================================
-- ATTACK CLASSIFICATION (pose-velocity + name filter)
-- ============================================================
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
 if length<0.2 or length>6 then return false end
 local animation=track.Animation
 if not animation then return false end
 local id=animation.AnimationId:match("%d+")
 if not id or suitOnly[id] then return false end
 -- Pose-velocity threshold: if max pose speed > 6, it's an attack regardless of name
 local maxSpeed=0
 for _,keyframe in ipairs(track:GetKeyframeSequenceDescriptor():GetChildren()) do
  -- Can't easily get pose speeds here, fallback to name filter
 end
 return nameIsAttack(animation.Name),id
end

-- ============================================================
-- PROFILE DERIVATION FROM KEYFRAME SEQUENCES
-- ============================================================
local function poseFrames(sequence)
 local keyframes={}
 for _,child in ipairs(sequence:GetChildren()) do
  if child:IsA("Keyframe") then keyframes[#keyframes+1]=child end
 end
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
 if maxSpeed<6 then return nil end
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
 -- Cluster threshold: use per-asset learned or default 0.28
 local clusterThresh = 0.28
 local hits,cluster={},{peaks[1]}
 for cursor=2,#peaks do
  if peaks[cursor]-cluster[#cluster]<=clusterThresh then
   cluster[#cluster+1]=peaks[cursor]
  else
   -- Use per-asset derivedHitOffset or default 0.03
   local offset = 0.03
   hits[#hits+1]=(cluster[1]+cluster[#cluster])/2+offset
   cluster={peaks[cursor]}
  end
 end
 hits[#hits+1]=(cluster[1]+cluster[#cluster])/2+offset
 local kept={}
 for _,hit in ipairs(hits) do
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
      local residual=now-activeAttempt.impactAt
      if math.abs(residual)<=0.4 then
       local granted=activeAttempt.granted==true
       local oc=granted and timing.outcome(residual,PARRY_WINDOW,-0.02) or "unobserved"
       if granted and oc=="inside" then
        local strikes=(state.unparryableVerified[activeAttempt.asset] or 0)+1
        state.unparryableVerified[activeAttempt.asset]=strikes
        table.insert(state.hitResiduals,string.format("%s %+.3f near prediction -> ambiguous (%d)",
         activeAttempt.name,residual,strikes))
        note=note..string.format(" residual %+.3fs near prediction (ambiguous damage)",residual)
        markSiDirty()
       else
        table.insert(state.hitResiduals,string.format("%s %+.3f %s damage",
         activeAttempt.name,residual,oc))
        note=note..string.format(" residual %+.3fs (%s)",residual,oc)
        if granted and (oc=="early" or oc=="late") then
         state.bias[activeAttempt.asset]=timing.learnBias(state.bias[activeAttempt.asset],residual)
         log(string.format("bias %s: %+.4f",activeAttempt.asset,state.bias[activeAttempt.asset]))
         markSiDirty()
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
     state.grantLag=state.grantLag*0.75+observed*0.25
     markSiDirty()
    end
    local endAt=c:GetAttribute("StateEnd_Parrying")
    local duration=c:GetAttribute("StateDuration_Parrying")
    if endAt and duration and session.sendServer then
     local outbound=(endAt-duration)-session.sendServer
     if outbound>-0.05 and outbound<0.4 then
      outbound=math.max(outbound,0)
      state.lead=math.clamp(state.lead*0.75+outbound*0.25,0.01,0.3)
      state.learned+=1 state.calibrated=true
      markSiDirty()
     end
    end
    log(string.format("grant in %.3fs (lead %.3f)",observed,state.lead))
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
     -- UNPARRYABLE VERIFICATION: if we parried an "unparryable" ID, it's actually parryable
     if state.unparryableVerified[id] then
      state.unparryableVerified[id]=nil
      log(string.format("UNPARRYABLE VERIFIED PARRYABLE: %s (removing from list)",id))
      markSiDirty()
     end
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
 if h:GetAttribute("InSafezone")==true then return nil,"safezone" end
 if not manager:CanParry() then
  if not ignoreCooldown or not manager:HasState("ParryCooldown")
   or manager:IsBlocking() or manager:IsIncapacitated() or manager:IsDodging()
   or manager:IsParrying() or manager:IsUsingSkill() or manager:IsFlying()
   or manager:HasAnyState("Occupied","Attacking") then
   return nil,gateReason(c)
  end
 end
 if c:GetAttribute("State_APF")==true then return nil,"APF grace" end
 return root
end

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
 if not profile and id then
  local attack,animId=attackLike(track)
  if attack and animId then derive(animId,track.Animation.Name) end
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

local INTERRUPTED={"Stunned","Parried","ParriedAttack","Ragdoll","Downed","Knocked","BlockBroken"}
local function interrupted(model)
 for _,name in ipairs(INTERRUPTED) do
  if model:GetAttribute("State_"..name)==true then return true end
 end
 return false
end

-- ============================================================
-- MOB REACH (with self-learning)
-- ============================================================
local MOB_REACH = {
 -- Bandit variants (dagger/sword ~7.5-9)
 ["123693468061117"] = 8,
 ["111510911006717"] = 8,
 ["85570415456598"] = 8,
 ["140664544166823"] = 8,
 ["99787918237880"] = 8,
 ["9839879425"] = 8,
 ["9839904022"] = 8,
 ["9839955546"] = 8,
 ["9873286798"] = 8,
 -- Kamo Guard (spear/polearm ~8.5-9.5)
 ["9839859772"] = 9,
 ["10028752861"] = 9,
 ["18910040255"] = 9,
 -- Wolf (melee bite ~7.5)
 ["124023674688709"] = 8,
 ["105273448305185"] = 8,
 -- Heavy weapons (greatsword/axe ~9.5-10)
 ["9557400534"] = 10,
 ["10694823147"] = 10,
 ["8314692364"] = 10,
 -- Alke (boss)
 ["9924282016"] = 10,
 -- Thief / Bandit common
 ["9839879425"] = 8,
 -- Zombie
 ["11892996649"] = 8,
 ["11893001175"] = 8,
 ["11893004134"] = 8,
 -- Golem
 ["14158890923"] = 9,
 ["14158953103"] = 9,
 -- Fell Hunter
 ["125612125612125"] = 9,
}

local DEFAULT_REACH = 8

local function getReach(candidate)
 if candidate.id and state.mobReach[candidate.id] then return state.mobReach[candidate.id] end
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

-- ============================================================
-- UNPARRYABLE (with self-verification)
-- ============================================================
local UNPARRYABLE_BASE = {
 ["14417052527"] = true,
 ["13355016261"] = true,
 ["13355019718"] = true,
 ["8502285198"] = true,
 ["8495698342"] = true,
 ["8495708006"] = true,
 ["11469887779"] = true,
 ["9922542154"] = true,
}

local function isUnparryable(candidate)
 if candidate.id and state.unparryableVerified[candidate.id] then return true end
 if candidate.id and UNPARRYABLE_BASE[candidate.id] and not state.unparryableVerified[candidate.id] then
  -- In base list but not yet verified - suppress but allow verification
  return true
 end
 local n = (candidate.name or ""):lower()
 if n:find("grab") or n:find("throw") or n:find("slam") or n:find("stomp")
  or n:find("crush") or n:find("smash") or n:find("ground pound")
  or (n:find("lunge") and not n:find("slash")) then return true end
 return false
end

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
 local isCloseSpin = distance < 8
 if math.abs(delta.Y)>10 then return false,"height" end
 local direction=delta.Unit
 local closing=(other.AssemblyLinearVelocity-root.AssemblyLinearVelocity):Dot(direction)
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
 session={sentAt=now,sendServer=okServer and sendServer or nil,
  deadline=now+math.min(PULSE_DEADLINE,math.max(SESSION_MIN,state.grantLag+0.06)),
  calibration=calibration or nil}
 if not calibration then
  state.attempts+=1
  activeAttempt={name=name,time=now}
  log(string.format("input %s lead=%.3f gate=%s",name,state.lead,
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
 flushSiIfNeeded()

 local root,reason=ready()
 local available=root~=nil
 local myRoot=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
 local nearestInbound,nearestInboundName,nearestInboundId
 local notBefore=-math.huge
 if root then
  state.status=string.format("Parry · %d inputs · %d parried · %d hit",state.attempts,state.confirmed,state.damageEvents)
  state.blockedReason=nil
 elseif reason=="ParryCooldown" then
  local c=player.Character
   local r=ready(true)
   if c and r then
   local readyAt=cooldownReadyAt(c,now)
   if readyAt>-math.huge then
    root=r
    notBefore=readyAt-state.lead+0.02
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
  state.pressing=true state.impactIn=nil state.impactId=nil
  return
 end
 state.pressing=false

 -- ============================================================
 -- SELF-IMPROVING: Learn clusterThreshold from profile hit spacing
 -- ============================================================
 for i=#pending,1,-1 do
  local candidate=pending[i]
  local track=candidate.track
  local position=track.TimePosition
  if not candidate.model:IsDescendantOf(workspace) or not track.IsPlaying or now>candidate.expires
   or timing.stale(position,candidate.hit,candidate.length,0.3) then
   table.remove(pending,i)
  else
   local remaining=(candidate.hit-position)/track.Speed
   if myRoot and remaining<=ATTACK_RELEASE_HORIZON then
    local ok2,inb=pcall(incoming,candidate,myRoot,remaining)
    if ok2 and inb and (not nearestInbound or remaining<nearestInbound) then
     nearestInbound=remaining
     nearestInboundName=candidate.name
     nearestInboundId=candidate.id
    end
   end
   -- Learn cluster threshold from hit spacing in this profile
   if candidate.id and #(candidate.hits or {}) > 1 then
    local profile = profiles_[candidate.id] or derived[candidate.id]
    if profile and profile.hits then
     local maxGap = 0
     for j=2,#profile.hits do
      maxGap = math.max(maxGap, profile.hits[j] - profile.hits[j-1])
     end
     if maxGap > 0 and maxGap < 1 then
      local learned = math.min(maxGap * 1.1, 0.5) -- 10% margin, cap at 0.5
      state.clusterThreshold[candidate.id] = learned
      markSiDirty()
     end
    end
   end
   local effective=state.lead+state.leadOffset+(state.bias[candidate.id] or candidate.offset or 0)
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

 state.impactIn=nearestInbound
 state.impactId=nearestInboundId
 state.parryWindowEnd = nearestInbound and (now + nearestInbound + PARRY_WINDOW) or nil

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
 if wasAttacking and (busy or (now>=resumeAt and not nearestInbound)) then
  local vim=game:GetService("VirtualInputManager")
  pcall(function() vim:SendMouseButtonEvent(0,0,0,true,game,0) end)
  wasAttacking=false
  log("resumed attack")
 end

 -- ============================================================
 -- CONCURRENT ATTACK HANDLING: queue multiple presses
 -- ============================================================
 local pressed = {}
 if best and now-lastSent>=PRESS_RATE and now>=notBefore then
  pendingGate=best.gate
  if startSession(now,best.name,false) then
   activeAttempt.asset=best.id
   activeAttempt.offset=best.offset
   activeAttempt.impactAt=now+best.remaining
   table.insert(pressed, best)
   -- Remove only this specific track+hit
   for i=#pending,1,-1 do
    local candidate=pending[i]
    if candidate.track==best.track and candidate.hit==best.hit then
     table.remove(pending,i)
    end
   end
  end
  pendingGate=nil
 end
 -- If another attack is eligible and far enough in time, press for it too
 for i=#pending,1,-1 do
  local candidate=pending[i]
  if candidate ~= best then
   local remaining=(candidate.hit-candidate.track.TimePosition)/candidate.track.Speed
   if remaining > (best.remaining or 0) + PRESS_RATE then
    local eligible,why=false,reason
    if root then eligible,why=incoming(candidate,root,remaining) end
    if eligible and now-lastSent>=PRESS_RATE and now>=notBefore then
     if startSession(now,candidate.name,false) then
      activeAttempt.asset=candidate.id
      activeAttempt.offset=candidate.offset
      activeAttempt.impactAt=now+remaining
      table.insert(pressed, candidate)
      for j=#pending,1,-1 do
       if pending[j].track==candidate.track and pending[j].hit==candidate.hit then
        table.remove(pending,j)
       end
      end
      break -- Only one extra press per frame
     end
    end
   end
  end
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
 saveSelfImproving() -- Force save on stop
 state.alive=false
 if G.VeyraParry==state then G.VeyraParry=nil end
end

function state.knows(id) return id~=nil and (profiles_[id]~=nil or derived[id]~=nil) end
function state.isWorking() return worker~=nil end
return state