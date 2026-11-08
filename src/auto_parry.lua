-- Auto Parry: predicts an attack's impact from animation markers, then opens
-- exactly one short block session per predicted impact.
--
-- SELF-IMPROVING SYSTEM:
--   * lead/grantLag: calibrated from every observed grant (StateEnd_Parrying - StateDuration_Parrying - sendServerTime)
--   * bias: per-asset timing correction from damage residuals (early/late when grant observed)
--   * mobReach: learned from distance at impact when grant+damage confirm a hit
--   * unparryable: tri-state - true = confirmed unparryable, false = verified
--     parryable (never re-suppressed), nil = base list / unknown
--   * unparryableStrikes: ambiguous hits per asset before it is confirmed
--   * parryWindow: learned from StateDuration_Parrying (default 0.30s)
--   * clusterThreshold: per-asset, learned from hit spacing in profile
--   * derivedHitOffset: per-asset offset used when deriving new profiles
--   * attackClassification: pose-velocity threshold (6 studs/s) + name filter
--   * All learned data persists in Veyra/config.json and Veyra/parry_derived.json
--
-- Mechanics measured in-game:
--   * Block Input grants State_Parrying after ~round-trip latency
--   * Granted parry lives for StateDuration_Parrying (~0.30s) and survives End Block
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

-- Config-driven constants (with measured defaults)
local prefs=G.VeyraConfig and G.VeyraConfig.values and G.VeyraConfig.values.parry or {}
local function cfg(key,def) return prefs[key] or def end

local PARRY_WINDOW=cfg("parryWindow",0.3)
local ROLL_DURATION=cfg("rollDuration",0.275)
local OUTBOUND=cfg("outbound",0.056)
local ALLOW_CANCEL=cfg("allowCancel",0.206)
local DASH_COOLDOWN=cfg("dashCooldown",1.5)
local SESSION_MIN=cfg("sessionMin",0.3)
local GRANT_MARGIN=cfg("grantMargin",0.12)
local UNPARRY_CONFIRM=cfg("unparryConfirm",2)
local PULSE_DEADLINE=cfg("pulseDeadline",0.55)
local PRESS_RATE=cfg("pressRate",0.35)
local ATTACK_RELEASE_HORIZON=cfg("releaseHorizon",0.8)
local WHIFF_LOCK=cfg("whiffLock",1.25)
local GRACE_LOCK=cfg("graceLock",0.75)

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
        parryWindow = saved.parryWindow or PARRY_WINDOW,
        bias = saved.bias or {},
        mobReach = saved.mobReach or {},
        unparryable = saved.unparryable or {},
        unparryableStrikes = saved.unparryableStrikes or {},
        clusterThreshold = saved.clusterThreshold or {},
        derivedHitOffset = saved.derivedHitOffset or {},
        calibrated = saved.calibrated or false,
    }
end

local si = loadSelfImproving()

local state={enabled=false,alive=true,status="Parry off",profiles=profileCount,
 range=cfg("range",14),leadOffset=0,lead=si.lead,grantLag=si.grantLag,
 parryWindow=si.parryWindow,
 rollDuration=ROLL_DURATION,
 rollLead=ROLL_DURATION/2+OUTBOUND,
 attempts=0,grants=0,confirmed=0,damageEvents=0,
 unknown=0,missed=0,covered=0,gated=0,learned=0,calibrated=si.calibrated,
 bias=si.bias,hitResiduals={},
 unparryable={},unparryableSkips=0,cooldownWait=0,
 unobservedGrants=0,successByAsset={},
 unknownAssets={},derived=0,log={},
 orphans={},lockKind=nil,impactIsOrphan=false,pressing=false,
 -- Self-improving runtime state
 mobReach = si.mobReach,           -- id -> reach (learned from confirmed deflections)
 unparryableVerified = si.unparryable, -- id -> true/false (confirmed unparryable / verified parryable)
 unparryableStrikes = si.unparryableStrikes, -- id -> ambiguous hit count
 clusterThreshold = si.clusterThreshold, -- id -> threshold (learned from hit spacing)
 derivedHitOffset = si.derivedHitOffset, -- id -> offset (learned from residuals)
}
G.VeyraParry=state

-- The granted window is measured, not assumed: every grant carries
-- StateDuration_Parrying, so the model uses the observed value once it has one.
local function parryWindow()
 return state.parryWindow or PARRY_WINDOW
end

-- F4: Roll duration, learned the same way from StateDuration_Rolling.
local function getAssetRollDuration()
 return state.rollDuration or ROLL_DURATION
end

-- C15: Roll lead derived from measured roll window.
-- The impact should land mid-roll and before AllowCancel, so:
-- rollLead = rollDur/2 + outbound
local function rollLead() return getAssetRollDuration()/2 + OUTBOUND end

-- ============================================================
-- PER-ASSET PARAMETER STORE (C1)
-- ============================================================
local HttpService=game:GetService("HttpService")
local LEARNED_PATH="Veyra/parry_learned.json"
local LEARNED_VERSION=1
local learned={version=LEARNED_VERSION,placeVersion=0,assets={}}

-- F1: Forward-declare saveLearned so loadLearned's migration path can call it.
local saveLearned

-- C11: Store placeVersion; on change, mark all authored profiles stale.
local function initPlaceVersion()
  local pv=game.PlaceId or 0
  if learned.placeVersion~=pv then
   learned.placeVersion=pv
   for id,_ in pairs(learned.assets) do
    learned.assets[id].stale=true
   end
  end
end

local function loadLearned()
    if type(readfile)~="function" then return end
    local ok,raw=pcall(readfile,LEARNED_PATH)
    if not ok or type(raw)~="string" or #raw==0 then return end
    local okDecode,data=pcall(function() return HttpService:JSONDecode(raw) end)
    if not okDecode or type(data)~="table" then return end
    if data.version~=LEARNED_VERSION then return end
    learned=data
    -- One-shot migration from old config.json selfImproving
    local old=prefs.selfImproving
    if old and type(old)=="table" and not learned.migrated then
        for id,val in pairs(old.bias or {}) do
            learned.assets[id]=learned.assets[id] or {}
            learned.assets[id].parryOffset=val
        end
        for id,val in pairs(old.derivedHitOffset or {}) do
            learned.assets[id]=learned.assets[id] or {}
            learned.assets[id].derivedHitOffset=val
        end
        for id,val in pairs(old.mobReach or {}) do
            learned.assets[id]=learned.assets[id] or {}
            learned.assets[id].reach=val
        end
        for id,val in pairs(old.unparryable or {}) do
            learned.assets[id]=learned.assets[id] or {}
            if val==true then learned.assets[id].unparryable=true end
        end
        for id,val in pairs(old.unparryableStrikes or {}) do
            learned.assets[id]=learned.assets[id] or {}
            learned.assets[id].strikes=val
        end
        for id,val in pairs(old.clusterThreshold or {}) do
            learned.assets[id]=learned.assets[id] or {}
            learned.assets[id].clusterThreshold=val
        end
        learned.migrated=true
        saveLearned()
    end
end

saveLearned=function()
    if type(writefile)~="function" then return end
    local ok,encoded=pcall(function() return HttpService:JSONEncode(learned) end)
    if not ok or type(encoded)~="string" then return end
    if type(makefolder)=="function" then pcall(makefolder,"Veyra") end
    pcall(writefile,LEARNED_PATH,encoded)
end

loadLearned()
initPlaceVersion()

-- F2: Debounced save for learned store (same pattern as markSiDirty).
local learnedDirty=false
local learnedSaveAt=0
local function markLearnedDirty()
  learnedDirty=true
  learnedSaveAt=os.clock()+5
end
local function flushLearnedIfNeeded()
  if learnedDirty and os.clock()>=learnedSaveAt then
    learnedDirty=false
    saveLearned()
  end
end

-- Fallback chain: learned asset value -> static table -> class default -> hard default
local function getAsset(id,key,classDefault,hardDefault)
    local a=learned.assets[id]
    if a and a[key]~=nil then return a[key] end
    local p=profiles_[id] or derived[id]
    if p and p[key]~=nil then return p[key] end
    return classDefault or hardDefault
end

local function setAsset(id,key,value)
    learned.assets[id]=learned.assets[id] or {}
    learned.assets[id][key]=value
    markLearnedDirty()
end

local function incAssetStat(id,key,delta)
    learned.assets[id]=learned.assets[id] or {}
    learned.assets[id][key]=(learned.assets[id][key] or 0)+delta
    markLearnedDirty()
end

-- ============================================================
-- PERSISTENCE HELPERS (legacy config.json for global lead/grantLag/parryWindow)
-- ============================================================
local function saveSelfImproving()
    if not G.VeyraConfig or not G.VeyraConfig.set then return end
    G.VeyraConfig.patch("parry", {
        selfImproving = {
            lead = state.lead,
            grantLag = state.grantLag,
            parryWindow = state.parryWindow,
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
local lastRTTUpdate=0
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
 -- Pose speed is only available from the keyframe provider, which is an async
 -- fetch; the name filter is the cheap synchronous classifier here and the
 -- derived profile gets the real pose pass in derive().
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

local function deriveHits(frames,length,id)
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
 -- Cluster threshold and scheduling offset are per-asset once the fight data
 -- has taught them; until then use the measured defaults.
 local clusterThresh=getAsset(id,"clusterThreshold",0.28)
 local offset=getAsset(id,"parryOffset",getAsset(id,"derivedHitOffset",0.03))
 local hits,cluster={},{peaks[1]}
 for cursor=2,#peaks do
  if peaks[cursor]-cluster[#cluster]<=clusterThresh then
   cluster[#cluster+1]=peaks[cursor]
  else
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
  local hits=deriveHits(frames,length,id)
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
  -- Reject inference (C5): if ParryCooldown is set but Parrying was never granted,
  -- the server rejected our Block Input.
  if character and character:GetAttribute("State_ParryCooldown")==true and character:GetAttribute("State_Parrying")~=true then
   local asset=activeAttempt and activeAttempt.asset
   if asset then
    local stats=learned.assets[asset] or {}
    stats.rejects=(stats.rejects or 0)+1
    stats.attempts=(stats.attempts or 0)+1
    setAsset(asset,"rejects",stats.rejects)
    setAsset(asset,"attempts",stats.attempts)
   end
   log("reject (ParryCooldown without Parrying)")
   local now=os.clock()
   if activeAttempt and activeAttempt.impactAt and activeAttempt.impactAt>now+0.05 then
    local prevImpactAt=activeAttempt.impactAt
    local prevName=activeAttempt.name
    local prevModel=activeAttempt.model
    local prevDistance=activeAttempt.distance
    session=nil
    if startSession(now,{name=prevName,model=prevModel},false) then
     if asset then
      activeAttempt.asset=asset
      activeAttempt.impactAt=prevImpactAt
      activeAttempt.distance=prevDistance
      activeAttempt.rejected=true
     end
     log(string.format("re-press for %s (%.2fs to impact)",prevName,prevImpactAt-now))
    end
    return
   end
  else
   log("no grant observed within session")
  end
 end
 session=nil
end

-- C10: Attribution scoring - score each candidate 0-1 from facing cone,
-- reach margin, LOS, track-position fit and damage-magnitude z-score.
local function scoreCandidate(candidate,damage,dmgTime,root)
  local model=candidate.model
  local other=model and model:FindFirstChild("HumanoidRootPart")
  if not other or not root then return 0 end
  local score=0
  local weight=0
  
  -- Facing cone (0.3 weight)
  local delta=root.Position-other.Position
  local dist=delta.Magnitude
  if dist>0.1 then
   local facing=delta.Unit:Dot(other.CFrame.LookVector)
   if facing>0.25 then score=score+facing*0.3 end
   weight=weight+0.3
  end
  
  -- Reach margin (0.2 weight)
  local reach=getReach(candidate)
  if dist<=reach+2 then
   local margin=1-(dist-reach)/(reach+2) -- 1 at reach, 0 at reach+2
   score=score+margin*0.2
   weight=weight+0.2
  else
   weight=weight+0.2 -- candidate too far, scores 0 for this component
  end
  
  -- LOS (0.2 weight)
  if hasLOS(root,other) then score=score+0.2 end
  weight=weight+0.2
  
  -- Track-position fit (0.2 weight) - how close is damage time to predicted impact?
  local remaining=(candidate.hit-candidate.track.TimePosition)/candidate.track.Speed
  local impactAt=dmgTime-remaining
  local residual=math.abs(dmgTime-impactAt)
  if residual<=0.4 then
   score=score+(1-residual/0.4)*0.2
   weight=weight+0.2
  else
   weight=weight+0.2
  end
  
  -- Damage-magnitude z-score (0.1 weight) - compare to asset's damage stats from C1
  local id=candidate.id
  if id then
   local stats=learned.assets[id]
   if stats and stats.damage and stats.damage.n>=3 then
    local mean=stats.damage.sum/stats.damage.n
    local var=(stats.damage.sumSq - stats.damage.n*mean*mean)/stats.damage.n
    var=math.max(var,1)
    local std=math.sqrt(var)
    local z=math.abs(damage-mean)/std
    -- z<2 is good fit
    if z<2 then score=score+(1-z/2)*0.1 end
    weight=weight+0.1
   end
  end
  
  if weight>0 then return score/weight else return 0 end
end

local function clearCharacter()
 endSession("reset")
 table.clear(pending)
 table.clear(seen)
 activeAttempt=nil
 if healthConnection then healthConnection:Disconnect() healthConnection=nil end
 if attributeConnection then attributeConnection:Disconnect() attributeConnection=nil end
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
    -- C10: Score all pending candidates, pick best, learn only if top beats runner-up by 0.25
    local root=c and c:FindFirstChild("HumanoidRootPart")
    local scored={}
    for _,cand in ipairs(pending) do
     if cand.model:IsDescendantOf(workspace) and cand.track.IsPlaying then
      local s=scoreCandidate(cand,previous-value,now,root)
      scored[#scored+1]={cand=cand,score=s}
     end
    end
    table.sort(scored,function(a,b) return a.score>b.score end)
    local bestCand=scored[1]
    local secondCand=scored[2]
    local learnAllowed=bestCand and (not secondCand or (bestCand.score-secondCand.score)>=0.25)
    if bestCand then
     local bestAsset=bestCand.cand.id
     -- Update damage stats for attribution
     if bestAsset then
      local stats=learned.assets[bestAsset] or {}
      stats.damage=stats.damage or {n=0,sum=0,sumSq=0}
      local dmg=previous-value
      stats.damage.n=stats.damage.n+1
      stats.damage.sum=stats.damage.sum+dmg
      stats.damage.sumSq=stats.damage.sumSq+dmg*dmg
      setAsset(bestAsset,"damage",stats.damage)
      -- C11: Track losses for profile decay
      incAssetStat(bestAsset,"losses",1)
      checkProfileDecay(bestAsset)
     end
     local residual=0
     local position=bestCand.cand.track.TimePosition
     local remaining=(bestCand.cand.hit-position)/bestCand.cand.track.Speed
     residual=now - (now - remaining) -- simplified: residual is 0 for best fit
     -- Actually compute properly:
     local impactAt=now-remaining
     residual=now-impactAt
     local granted=activeAttempt and activeAttempt.granted==true
     local oc=granted and timing.outcome(residual,parryWindow(),-0.02) or "unobserved"
     if learnAllowed then
      if granted and oc=="inside" then
       -- A hit that lands on the predicted frame while a parry was granted
       local strikes=(getAsset(bestAsset,"strikes",0))+1
       setAsset(bestAsset,"strikes",strikes)
       if strikes>=UNPARRY_CONFIRM and getAsset(bestAsset,"unparryable",nil)~=true then
        setAsset(bestAsset,"unparryable",true)
        log(string.format("unparryable confirmed: %s (%d strikes)",bestAsset,strikes))
       end
       table.insert(state.hitResiduals,string.format("%s %+.3f near prediction -> ambiguous (%d)",
        bestCand.cand.name,residual,strikes))
       note=note..string.format(" residual %+.3fs near prediction (ambiguous damage)",residual)
       markLearnedDirty()      else
       table.insert(state.hitResiduals,string.format("%s %+.3f %s damage",
        bestCand.cand.name,residual,oc))
       note=note..string.format(" residual %+.3fs (%s)",residual,oc)
       if granted and (oc=="early" or oc=="late") then
        local currentBias=getAsset(bestAsset,"parryOffset",0)
        local newBias=timing.learnBias(currentBias,residual)
        setAsset(bestAsset,"parryOffset",newBias)
        log(string.format("bias %s: %+.4f",bestAsset,newBias))
       end
      end
      -- Reach learning
      local candRoot=bestCand.cand.model:FindFirstChild("HumanoidRootPart")
      if root and candRoot then
       local dist=(root.Position-candRoot.Position).Magnitude
       local current=getAsset(bestAsset,"reach",8)
       local newReach=math.clamp(current*0.85+dist*0.15,5,14)
       setAsset(bestAsset,"reach",newReach)
       log(string.format("reach %s: %.1f",bestAsset,newReach))
      end
     else
      note=note.." (ambiguous, diagnostic only)"
      log(string.format("diagnostic only: %s score %.2f vs %.2f",bestCand.cand.name,bestCand.score,secondCand and secondCand.score or 0))
     end
     while #state.hitResiduals>20 do table.remove(state.hitResiduals,1) end
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
    if duration and duration>0.05 and duration<1.5 then
     -- The granted window is whatever the server says it is.
     state.parryWindow=state.parryWindow*0.8+duration*0.2
     markSiDirty()
    end
     -- C15: Learn roll length from StateDuration_Dodging first, then Rolling.
     local rollDur=c:GetAttribute("StateDuration_Dodging") or c:GetAttribute("StateDuration_Rolling")
     if rollDur and rollDur>0.05 and rollDur<1.5 then
      state.rollDuration=state.rollDuration*0.8+rollDur*0.2
      state.rollLead=rollLead()
      markSiDirty()
     end
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
     -- C11: Track wins for profile decay
     incAssetStat(id,"wins",1)
     -- A confirmed deflection is proof of parryability: clear both the strike
     -- counter and any confirmation, and record `false` so the base list can
     -- never re-suppress this asset.
     setAsset(id,"strikes",0)
     setAsset(id,"unparryable",false)
     log(string.format("verified parryable: %s",id))
    end
   end
   log("CONFIRMED deflection"..(activeAttempt and (" near "..activeAttempt.name) or ""))
   endSession("parried")
  end
 end)
end

-- States that make a Block Input pointless or actively harmful. CanBlock()
-- already covers Stunned/Occupied/Attacking/Critting/MisdirectActive plus
-- blocking, dodging, incapacity, skill use and flight; these are the extra
-- states the server refuses a parry in and CanBlock does not model.
local HARD_STATES={"Carrying","Ragdolled","Climbing","Burning","CantCombat",
 "CombatDebounce","BlockBroken","Ragdoll","Knocked","Downed","SkillActive",
 "Swinging","KnockSlide","Slowed"}
local function hardBlocked(c)
 for _,name in ipairs(HARD_STATES) do
  if c:GetAttribute("State_"..name)==true then return name end
 end
 return nil
end

local function ready(ignoreGrace)
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
 -- Name the reason precisely: CanBlock also refuses mid-swing, and "CanBlock=false"
 -- alone is ambiguous in the status line. Attacks cannot be cancelled client-side
 -- (verified: the attack packet has no cancel action), so the honest answer is "attacking".
 for _,name in ipairs({"Attacking","Critting"}) do
  local okA,busyState=pcall(function() return manager:HasState(name) end)
  if okA and busyState then return nil,name:lower() end
 end
 -- CanBlock, not CanParry: ParryCooldown and Parrying are the lock model's
 -- business, and gating on them here would make every cooldown look like a
 -- hard blocker. CanBlock is the authoritative "may I send Block Input" check.
 local ok,blockable=pcall(function() return manager:CanBlock() end)
 if not ok or not blockable then
  return nil,hardBlocked(c) or "CanBlock=false"
 end
 if c:GetAttribute("State_APF")==true and not ignoreGrace then return nil,"APF grace" end
 return root
end

local graceOverlapCount=0

local function lockEndsAt(c,now)
 local ok,server=pcall(function() return workspace:GetServerTimeNow() end)
 if not ok or type(server)~="number" then return nil end
 local endAt=c:GetAttribute("StateEnd_ParryCooldown")
 if type(endAt)=="number" then
  local at=now+math.max(0,endAt-server)
  if at>now then return at,"whiff" end
 end
 if c:GetAttribute("State_ParryCooldown")==true then return now+WHIFF_LOCK,"whiff" end
 -- Grace lock: use max of APF and ParriedAttack expiries, not sum.
 -- A successful parry removes ParryCooldown and applies APF (0.5s) + ParriedAttack (0.25s) simultaneously.
 -- The lockout is the later of the two, not their sum.
 local apfEnd=nil
 local paEnd=nil
 local e=c:GetAttribute("StateEnd_APF")
 if type(e)=="number" then apfEnd=now+math.max(0,e-server) end
 e=c:GetAttribute("StateEnd_ParriedAttack")
 if type(e)=="number" then paEnd=now+math.max(0,e-server) end
 local graceAt
 if apfEnd and paEnd then
  graceAt=math.max(apfEnd,paEnd)
  graceOverlapCount+=1
 elseif apfEnd then
  graceAt=apfEnd
 elseif paEnd then
  graceAt=paEnd
 end
 if graceAt and graceAt>now then return graceAt,"grace" end
 -- Fallbacks if StateEnd_* not present
 if c:GetAttribute("State_APF")==true then return now+GRACE_LOCK,"grace" end
 if c:GetAttribute("State_ParriedAttack")==true then return now+0.25,"grace" end
 return nil
end

-- Learn profile shape (clusterThreshold, derivedHitOffset) from static profile data.
-- Called once per asset when first observed.
local function learnProfileShape(id)
  if not id or learned.assets[id] and learned.assets[id].shapeLearned then return end
  local profile=profiles_[id] or derived[id]
  if not profile or not profile.hits or #profile.hits<2 then return end
  -- clusterThreshold: minimum gap between adjacent hits
  local minGap=math.huge
  for j=2,#profile.hits do
   minGap=math.min(minGap,profile.hits[j]-profile.hits[j-1])
  end
  if minGap>0 and minGap<2 then
   local ct=math.clamp(minGap*0.9,0.2,0.6)
   if not learned.assets[id] or math.abs((learned.assets[id].clusterThreshold or 0.28)-ct)>0.005 then
    setAsset(id,"clusterThreshold",ct)
   end
  end
  -- derivedHitOffset: not learnable from static data, keep default (0.03) until residuals teach it
  learned.assets[id]=learned.assets[id] or {}
  learned.assets[id].shapeLearned=true
  markLearnedDirty()
end

-- AoE classification (C7)
-- AoE attacks are rolled, not parried. NOTE: Lua patterns have no alternation —
-- the old pipe-joined pattern matched literally and never fired. Use plain
-- substring matching against the AoE-skill keywords instead.
-- NOTE: State_HyperArmor is NOT an AoE signal. In this game every FightableNPC
-- carries it as poise (verified live: all 8 Wolves have State_HyperArmor=true),
-- so treating it as unparryable blocks ALL mob parries. Removed.
local AOE_KEYWORDS = {"screech", "roar", "bomb", "summon", "explosion", "field", "rupture"}
local function isAOE(candidate)
  local id=candidate.id
  local name=(candidate.name or ""):lower()
  -- Name-based classification (plain substrings)
  for _,kw in ipairs(AOE_KEYWORDS) do
    if name:find(kw, 1, true) then return true end
  end
  -- Learned from C1 store
  if id and getAsset(id,"aoe",false) then return true end
  return false
end

-- C11: Profile decay - demote authored profile to derived when win rate is poor.
local function checkProfileDecay(id)
  local stats=learned.assets[id]
  if not stats then return end
  local wins=stats.wins or 0
  local losses=stats.losses or 0
  if losses>=5 then
    local total=wins+losses
    local winRate=total>0 and (wins/total) or 1
    if winRate<0.35 then
      if profiles_[id] and not stats.demoted then
        log(string.format("profile decay: %s demoted (win rate %.2f)",id,winRate))
        setAsset(id,"demoted",true)
        deriveTried[id]=nil
        derive(id,profiles_[id].name)
      end
    end
  end
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
 if id then learnProfileShape(id) end
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
 if candidate.id then
  local learned=getAsset(candidate.id,"reach",nil)
  if learned then return learned end
  if MOB_REACH[candidate.id] then return MOB_REACH[candidate.id] end
 end
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
 local id=candidate.id
 if id then
  local verdict=getAsset(id,"unparryable",nil)
  if verdict==true then return true end
  if verdict==false then return false end -- verified parryable, never re-suppress
  if UNPARRYABLE_BASE[id] then return true end -- base list, not yet tested
 end
 local n = (candidate.name or ""):lower()
 if n:find("grab") or n:find("throw") or n:find("slam") or n:find("stomp")
  or n:find("crush") or n:find("smash") or n:find("ground pound")
  or (n:find("lunge") and not n:find("slash")) then return true end
 return false
end

-- RTT estimation (C6): rolling median of 8 samples.
-- Pair workspace:GetServerTimeNow() with os.clock() to estimate round-trip time.
local rttSamples={}
local function updateRTT()
  local ok,server=pcall(function() return workspace:GetServerTimeNow() end)
  if not ok or type(server)~="number" then return end
  local localNow=os.clock()
  -- Poll a second time to estimate one-way leg; the delta between the two
  -- server times minus local elapsed gives the outbound leg.
  task.wait()
  local ok2,server2=pcall(function() return workspace:GetServerTimeNow() end)
  if not ok2 or type(server2)~="number" then return end
  local localNow2=os.clock()
  local rtt=(server2-server)-(localNow2-localNow)
  -- rtt here is (server elapsed) - (local elapsed). If clocks run at 1x, this
  -- approximates the extra network delay. We store it as a raw RTT estimate.
  -- Clamp to sane bounds (0..500ms).
  rtt=math.clamp(rtt*1000,0,500)
  rttSamples[#rttSamples+1]=rtt
  if #rttSamples>8 then table.remove(rttSamples,1) end
end

local function getRTT()
  if #rttSamples==0 then return 0.06 end -- default ~60ms outbound estimate
  -- Use median
  local sorted={}
  for _,v in ipairs(rttSamples) do sorted[#sorted+1]=v end
  table.sort(sorted)
  local mid=math.floor(#sorted/2)
  return (sorted[mid+1] or 60)/1000 -- convert ms to seconds
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
 if isAOE(candidate) then return false,"aoe move" end
 -- C6: Lag compensation - extrapolate attacker position by velocity * RTT/2.
 -- The attacker's root on this client is slightly behind where it is on the server.
 -- Clamp total extrapolation travel to 0.12s.
 local rtt=getRTT()
 local extrapolateTime=math.min(rtt/2,0.12)
 local vel=other.AssemblyLinearVelocity
 local extrapolatedPos=other.Position + vel*extrapolateTime
 local delta=root.Position-extrapolatedPos
 local distance=delta.Magnitude
 local reach = getReach(candidate)
 local isCloseSpin = distance < 8
 if math.abs(delta.Y)>10 then return false,"height" end
 local direction=delta.Unit
 local closing=(vel-root.AssemblyLinearVelocity):Dot(direction)
 local effectiveRange = math.min(state.range or reach, reach+2)
 if not timing.inRange(distance,closing,remaining,effectiveRange) then return false,string.format("range %.1f/%.1f",distance,effectiveRange) end
 -- Facing check uses extrapolated position but actual CFrame
 if not isCloseSpin and other.CFrame.LookVector:Dot(direction)<0.25 then return false,"attacker facing away" end
 if not hasLOS(root, other) then return false,"no LOS" end
 return true
end

local function startSession(now,candidate,calibration)
 local okServer,sendServer=pcall(function() return workspace:GetServerTimeNow() end)
 if not send("Block Input") then return false end
 lastSent=now
 -- C12: Key deadline to impact time, not grantLag. The session should end
 -- just after the expected impact, not after a lag-based guess.
 local impactIn=candidate and candidate.remaining or nil
 local deadline
 if impactIn then
  deadline=now+impactIn+parryWindow()+GRANT_MARGIN
 else
  local wait=math.max(SESSION_MIN,state.grantLag+GRANT_MARGIN)
  deadline=now+math.min(PULSE_DEADLINE,wait)
 end
 session={sentAt=now,sendServer=okServer and sendServer or nil,
  deadline=deadline,
  calibration=calibration or nil}
 if not calibration then
  state.attempts+=1
  local distance
  local myRoot=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
  local other=candidate.model and candidate.model:FindFirstChild("HumanoidRootPart")
  if myRoot and other then distance=(myRoot.Position-other.Position).Magnitude end
  activeAttempt={name=candidate.name,time=now,model=candidate.model,distance=distance}
  log(string.format("input %s lead=%.3f gate=%s",candidate.name,state.lead,
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
 -- Update RTT samples periodically (every ~2s)
 if not lastRTTUpdate or now-lastRTTUpdate>2 then
  lastRTTUpdate=now
  task.spawn(updateRTT)
 end
 flushSiIfNeeded()
 flushLearnedIfNeeded()

 local root,reason=ready()
 local myRoot=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
 local nearestInbound,nearestInboundName,nearestInboundId
 local notBefore=-math.huge
 local lockAt,lockKind
 local char=player.Character
 if not root and char then
  local unlocked=ready(true)
  if unlocked then
   lockAt,lockKind=lockEndsAt(char,now)
   if lockAt then
    root=unlocked
    notBefore=lockAt-state.lead+0.02
    state.cooldownWait=math.max(0,notBefore-now)
    state.lockKind=lockKind
   end
  end
 end
 if root then
  state.lockKind=lockKind
  state.cooldownWait=lockKind and state.cooldownWait or 0
  state.status=string.format("Parry Ã‚Â· %d in Ã‚Â· %d parried Ã‚Â· %d hit Ã‚Â· %s%s",
   state.attempts,state.confirmed,state.damageEvents,lockKind or "ready",
   lockKind=="grace" and (" graceOverlaps="..graceOverlapCount) or "")
  state.blockedReason=nil
 else
  state.lockKind=nil
  state.cooldownWait=0
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
 local best,bestLatest=nil,-math.huge
 local chainCands={}
 local aoeOrphans={}
 for i=#pending,1,-1 do
  local candidate=pending[i]
  local track=candidate.track
  local position=track.TimePosition
  if not candidate.model:IsDescendantOf(workspace) or not track.IsPlaying or now>candidate.expires
   or timing.stale(position,candidate.hit,candidate.length,0.3) then
   table.remove(pending,i)
  else
   local remaining=(candidate.hit-position)/track.Speed
   -- C7: AoE assets publish to orphans with kind="roll", never a parry press
   if isAOE(candidate) and remaining<=1.5 then
    -- C15: rollLead is rollDur/2 + outbound (learned roll duration), not a
    -- per-asset constant. No profile defines a per-asset rollLead, so fall
    -- back to the computed value rather than a stale literal.
    local orphanLead=getAsset(candidate.id,"rollLead",rollLead())
    aoeOrphans[#aoeOrphans+1]={kind="roll",remaining=remaining,rollLead=orphanLead,
     name=candidate.name,id=candidate.id}
   end
   if myRoot and remaining<=ATTACK_RELEASE_HORIZON then
    local ok2,inb=pcall(incoming,candidate,myRoot,remaining)
    if ok2 and inb and (not nearestInbound or remaining<nearestInbound) then
     nearestInbound=remaining
     nearestInboundName=candidate.name
     nearestInboundId=candidate.id
    end
   end
   local authored=getAsset(candidate.id,"parryOffset",nil)
   local effective=state.lead+state.leadOffset+((authored~=nil) and authored or candidate.offset or 0)
   local at,latest=timing.window(position,track.Speed,candidate.hit,effective,
    parryWindow()/2,candidate.gate)
   if latest and latest< -0.05 then
    table.remove(pending,i)
    if candidate.covered then
     candidate.covered=nil
    else
     state.missed+=1
     log("missed "..candidate.name..": "..(candidate.blocked or "no eligible frame observed"))
    end
   elseif at and at<=0 and latest>=0 then
    local okIn,why=false,reason
    if root then okIn,why=incoming(candidate,root,remaining) end
    if not okIn then
     candidate.blocked=why or "not ready"
    else
     if now<notBefore then candidate.blocked="cooldown arrival deadline"
     elseif now-lastSent<PRESS_RATE then candidate.blocked="input rate limit"
     else candidate.blocked=nil end
     chainCands[#chainCands+1]={candidate=candidate,at=at,latest=latest,remaining=remaining}
    end
   end
  end
 end

 -- Chain plan: coverage-maximising assignment (C4).
  -- For each pair of candidates within one lockout, compare parry-then-drop
  -- against roll-then-parry by covered-hit count and choose the better.
  -- Emit assignments as {kind="parry"|"roll", candidate} on state.orphans.
  -- kind="parry" entries still become presses. Break ties toward parry.
  -- C16: dashReadyAt computed once per frame.
  local dashReadyAt=now
  if char then
   local dcEnd=char:GetAttribute("StateEnd_DashCooldown")
   if type(dcEnd)=="number" then
    local ok,server=pcall(function() return workspace:GetServerTimeNow() end)
    if ok and type(server)=="number" then dashReadyAt=now+math.max(0,dcEnd-server) end
   elseif manager then
    local ok,canDash=pcall(function() return manager:CanDash() end)
    if not ok or not canDash then dashReadyAt=now+0.1 end
   end
  end
  table.sort(chainCands,function(a,b) return a.remaining<b.remaining end)
  local n=#chainCands
  local assign={} -- "parry" or "roll" for each candidate
  local i=1
  while i<=n do
   local entry=chainCands[i]
   local impactAt=now+entry.remaining
   -- Look ahead to find all candidates within GRACE_LOCK of this one
   local j=i+1
   local group={entry}
   while j<=n and (now+chainCands[j].remaining)<=impactAt+GRACE_LOCK+0.03 do
    group[#group+1]=chainCands[j]
    j+=1
   end
   if #group==1 then
     assign[i]="parry"
   else
    -- C16: forward-simulate both strategies with real gates.
    local GRACE=GRACE_LOCK+0.03
    local function parryAt(t) return t-state.lead-state.leadOffset end
    local function rollAt(t) return t-rollLead() end
    local ROLL_RECOVER=0.09
    local function simulate(mode)
      local freeAt=impactAt
      local dashAt=dashReadyAt
      local covered=1
      if mode=="roll" then
        freeAt=impactAt+ROLL_DURATION
        dashAt=impactAt+DASH_COOLDOWN
      else
        freeAt=impactAt+GRACE_LOCK
      end
      for k=2,#group do
        local t=now+group[k].remaining
        local p=parryAt(t)
        if p>=freeAt and p>=impactAt+ROLL_RECOVER then
          covered=covered+1
          freeAt=t+GRACE_LOCK
        else
          local r=rollAt(t)
          if r>=freeAt and r>=dashAt then
            covered=covered+1
            freeAt=t+ROLL_DURATION
            dashAt=t+DASH_COOLDOWN
          end
        end
      end
      return covered
    end
    -- Check if roll is sendable for hit1
    local canRollNow=false
    if manager and rollAt(impactAt)>=now then
     local ok,dash=pcall(function() return manager:CanDash() end)
     canRollNow=ok and dash==true
    end
    if canRollNow and simulate("roll")>simulate("parry") then
     -- Roll first, then parry rest where possible
     assign[i]="roll"
     for k=2,#group do assign[i+k-1]="parry" end
    else
     -- Parry first, drop rest
     assign[i]="parry"
     for k=2,#group do assign[i+k-1]="drop" end
    end
    end
   i=j
  end
  -- Build orphans with kind
  state.orphans={}
  for idx,entry in ipairs(chainCands) do
   local kind=assign[idx] or "roll"
   if kind=="parry" then
    if not best then
     best,bestLatest=entry.candidate,entry.latest
     best.remaining=entry.remaining
    end
    entry.candidate.covered=true
   end
   state.orphans[#state.orphans+1]={kind=kind,remaining=entry.remaining,
    name=entry.candidate.name,id=entry.candidate.id}
  end
  -- C7: AoE orphans come first (they're rolls, not parries)
  table.sort(aoeOrphans,function(a,b) return a.remaining<b.remaining end)
  for _,entry in ipairs(aoeOrphans) do
   table.insert(state.orphans,1,entry)
  end

 state.impactIn=nearestInbound
 state.impactId=nearestInboundId
 local orphanHead=state.orphans[1]
 if orphanHead and (not nearestInbound or orphanHead.remaining<nearestInbound) then
  state.impactIn=orphanHead.remaining
  state.impactId=orphanHead.id
  state.impactIsOrphan=true
 else
  state.impactIsOrphan=false
 end
 state.parryWindowEnd = state.impactIn and (now + state.impactIn + parryWindow()) or nil

 -- Chained presses are scheduled by later frames: a hit only enters the
 -- eligible set once its own press window opens, so a single press per frame
 -- is the whole scheduler. Nothing is pressed early for a future impact.
 -- C9: While Burning, suppress presses (burn ticks are unparryable) but
 -- keep the chain plan alive for real animations.
 local isBurning = char and char:GetAttribute("State_Burning")==true
 if best and not isBurning and now-lastSent>=PRESS_RATE and now>=notBefore then
  pendingGate=best.gate
  if startSession(now,best,false) then
   activeAttempt.asset=best.id
   activeAttempt.offset=best.offset
   activeAttempt.impactAt=now+best.remaining
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

 if activeAttempt and now-activeAttempt.time>1 then activeAttempt=nil end
end

function state.setEnabled(on)
 if not state.alive then return false end
 on=on==true
 if on==state.enabled then return on end
 if not on then
  state.enabled=false
  log("parry off")
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
  state.status="Parry: input unavailable" log("packet error: "..tostring(result)) return false
 end
 packet=result
 state.enabled=true nextScan=0
 discoveryAdded=workspace.DescendantAdded:Connect(function(item)
  if item:IsA("Animator") then animators[item]=true end
  -- C8: Projectile inbound detection
  if item:IsA("BasePart") and state.enabled then
   local char=player.Character
   local root=char and char:FindFirstChild("HumanoidRootPart")
   if root then
    local vel=item.AssemblyLinearVelocity
    local speed=vel.Magnitude
    if speed>1 then
     local dir=(root.Position-item.Position)
     local dist=dir.Magnitude
     if dist>0.1 and dist<100 then
      local toPlayer=dir.Unit
      local velDir=vel.Unit
      local dot=toPlayer:Dot(velDir)
      if dot>0.5 then
       local eta=dist/speed
       if eta<1.5 then
        for i=#state.orphans,1,-1 do
         if state.orphans[i].id=="projectile" then table.remove(state.orphans,i) end
        end
        state.orphans[#state.orphans+1]={kind="roll",remaining=eta,
         name="projectile",id="projectile",projectile=true}
        log(string.format("projectile inbound ETA %.2fs dist %.1f speed %.1f",eta,dist,speed))
       end
      end
     end
    end
   end
  end
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
 local animatorCount=0
 for _ in pairs(animators) do animatorCount+=1 end
 bindCharacter(player.Character)
 worker=RS.Heartbeat:Connect(function()
  local success,err=pcall(step)
  if not success then
   log("STEP ERROR: "..tostring(err))
   state.setEnabled(false)
   state.status="Parry error: "..tostring(err)
  end
 end)
 log(string.format("parry on · %d animators · %d profiles",animatorCount,profileCount))
 return true
end

function state.stop()
 state.setEnabled(false)
 saveDerived()
 saveLearned()
 saveSelfImproving() -- Force save on stop
 state.alive=false
 if G.VeyraParry==state then G.VeyraParry=nil end
end

function state.knows(id) return id~=nil and (profiles_[id]~=nil or derived[id]~=nil) end
function state.isWorking() return worker~=nil end
return state
