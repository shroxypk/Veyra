-- Veyra collector v4: impact residuals + missing markers + duration probes.
-- Passive by default. Never writes game state, never touches CFrame.
-- Stop with getgenv().__col.stop().

local G=getgenv()
if G.__col and G.__col.stop then pcall(G.__col.stop) end

local Players=game:GetService("Players")
local RS=game:GetService("ReplicatedStorage")
local HS=game:GetService("HttpService")
local KSP=game:GetService("KeyframeSequenceProvider")
local UIS=game:GetService("UserInputService")
local player=Players.LocalPlayer
local started=os.clock()
local stopping=false
local stopRequested=false
local PROBE_ROLLS=true
local TARGET_UNIVERSE=3164482049
local MAX_SECONDS=600
local FETCH_DELAY=0.14
local DIR="Veyra/recon"

print("[col] v4 starting")
if game.GameId~=TARGET_UNIVERSE then
 print(("[col] WARNING universe %d place %d"):format(game.GameId,game.PlaceId))
else
 print(("[col] universe %d place %d confirmed"):format(game.GameId,game.PlaceId))
end
if type(writefile)~="function" then print("[col] no writefile") return end
pcall(function() if type(makefolder)=="function" then makefolder("Veyra") makefolder(DIR) end end)

local function save(name,tbl)
 local ok,enc=pcall(function() return HS:JSONEncode(tbl) end)
 if not ok then return false end
 pcall(writefile,DIR.."/"..name,enc)
 return true
end
local function expired() return os.clock()-started>MAX_SECONDS end

local meta={scriptVersion=4,gameId=game.GameId,placeId=game.PlaceId,player=player.Name,counts={}}
local function bump(k) meta.counts[k]=(meta.counts[k] or 0)+1 end

local profiles={}
pcall(function()
 local raw=readfile("Veyra/src/parry_profiles.lua")
 local ok,res=pcall(loadstring(raw,"p"))
 if ok and type(res)=="table" then profiles=res end
end)

local records={}
local durations={}
local markers={}
local animators={}
local active={}

local function rootOf(model)
 return model and model:FindFirstChild("HumanoidRootPart")
end

local function ownStates()
 local c=player.Character
 if not c then return "" end
 local out={}
 for name,value in pairs(c:GetAttributes()) do
  if value==true and name:sub(1,6)=="State_" then out[#out+1]=name:sub(7) end
 end
 table.sort(out)
 return table.concat(out,",")
end

local function noteDuration(name,value)
 if type(value)~="number" then return end
 local row=durations[name] or {samples={}}
 durations[name]=row
 if #row.samples<40 then row.samples[#row.samples+1]=value end
 bump("durations")
end

local function watchHumanoid(hum)
 local last=hum.Health
 hum.HealthChanged:Connect(function(value)
  local damage=last-value
  last=value
  if damage<=0 or stopping then return end
  local victim=hum.Parent
  local victimRoot=rootOf(victim)
  if not victimRoot then return end
  local isSelf=victim==player.Character
  local now=os.clock()
  local best,bestFit
  for _,entry in ipairs(active) do
   if now-entry.start<=6 and entry.model~=victim then
    local ar=rootOf(entry.model)
    local profile=profiles[entry.id]
    if ar and profile then
     local dist=(victimRoot.Position-ar.Position).Magnitude
     if dist<30 then
      local elapsed=now-entry.start
      for _,hit in ipairs(profile.hits) do
       local marker=hit/entry.speed
       local fit=math.abs(elapsed-marker)
       if not bestFit or fit<bestFit then
        best={asset=entry.id,name=profile.name,elapsed=elapsed,marker=marker,
         residual=elapsed-marker,dist=dist,attacker=entry.model.Name,
         damage=damage,self=isSelf,states=ownStates()}
        bestFit=fit
       end
      end
     end
    end
   end
  end
  if best and #records<5000 then
   best.t=now
   records[#records+1]=best
   bump("records")
  end
 end)
end

local function watchAnimator(animator)
 animator.AnimationPlayed:Connect(function(track)
  local id
  pcall(function() id=tostring(track.Animation and track.Animation.AnimationId or ""):match("%d+") end)
  if not id then return end
  local model=animator:FindFirstAncestorOfClass("Model")
  if model then
   active[#active+1]={model=model,id=id,start=os.clock(),speed=track.Speed>0.01 and track.Speed or 1}
   bump("tracks")
  end
 end)
end

local function watchAttributes(c)
 c.AttributeChanged:Connect(function(name)
  if stopping then return end
  local value=c:GetAttribute(name)
  if name:sub(1,14)=="StateDuration_" then noteDuration(name,value) end
  if name:sub(1,9)=="StateEnd_" and type(value)=="number" then
   local ok,server=pcall(function() return workspace:GetServerTimeNow() end)
   if ok and type(server)=="number" then
    noteDuration("LEAD_"..name,value-server)
   end
  end
 end)
end

-- ===== markers for the gap set =====
local function collectMarkers()
 local anims=RS:FindFirstChild("Animations")
 if not anims then return end
 local seen={}
 local queue={}
 for _,folderName in ipairs({"NPCS","Halloween","Server","Combat"}) do
  local folder=anims:FindFirstChild(folderName)
  if folder then
   for _,a in ipairs(folder:GetDescendants()) do
    if a:IsA("Animation") then
     local id=a.AnimationId:match("%d+")
     if id and not seen[id] then seen[id]=true queue[#queue+1]=id end
    end
   end
  end
 end
 print("[col] marker queue "..#queue)
 for _,id in ipairs(queue) do
  if stopping then break end
  local ok,seq=pcall(function() return KSP:GetKeyframeSequenceAsync("rbxassetid://"..id) end)
  if ok and seq then
   pcall(function()
    local frames,keyframes={},{}
    for _,child in ipairs(seq:GetChildren()) do
     if child:IsA("Keyframe") then keyframes[#keyframes+1]=child end
    end
    table.sort(keyframes,function(a,b) return a.Time<b.Time end)
    local previous,previousTime={},nil
    local maxSpeed,lastTime=0,0
    for _,kf in ipairs(keyframes) do
     local current={}
     for _,pose in ipairs(kf:GetDescendants()) do
      if pose:IsA("Pose") then
       local cf=pose.CFrame
       local node=pose.Parent
       local guard=0
       while node and node:IsA("Pose") and guard<8 do cf=node.CFrame*cf node=node.Parent guard+=1 end
       current[pose.Name]=cf.Position
      end
     end
     local dt=previousTime and (kf.Time-previousTime) or 0
     local speed=0
     if dt>0 then
      for name,pos in pairs(current) do
       local old=previous[name]
       if old then
        local v=(pos-old).Magnitude/dt
        if v>speed then speed=v end
       end
      end
     end
     if speed>maxSpeed then maxSpeed=speed end
     previous=current previousTime=kf.Time lastTime=kf.Time
     frames[#frames+1]={t=math.floor(kf.Time*1000)/1000,s=math.floor(speed*100)/100}
    end
    if #frames>1 then
     markers[id]={length=lastTime,maxSpeed=math.floor(maxSpeed*100)/100,frames=frames}
     bump("markers")
    end
   end)
   pcall(function() seq:Destroy() end)
  end
  local t=os.clock()
  while os.clock()-t<FETCH_DELAY do task.wait() end
 end
end

-- ===== wiring =====
for _,item in ipairs(workspace:GetDescendants()) do
 if item:IsA("Animator") then animators[item]=true watchAnimator(item)
 elseif item:IsA("Humanoid") then watchHumanoid(item) end
end
workspace.DescendantAdded:Connect(function(item)
 if item:IsA("Animator") then watchAnimator(item)
 elseif item:IsA("Humanoid") then watchHumanoid(item) end
end)
if player.Character then watchAttributes(player.Character) end
player.CharacterAdded:Connect(function(c) task.wait(0.4) if not stopping then watchAttributes(c) end end)

task.spawn(function()
 while not stopping and not expired() do
  local now=os.clock()
  for i=#active,1,-1 do if now-active[i].start>6 then table.remove(active,i) end end
  task.wait(0.5)
 end
end)

if PROBE_ROLLS then
 task.spawn(function()
  local ok,packet=pcall(function()
   return require(RS.Modules.Packets).Combat.packets.RollInput
  end)
  if not ok or not packet then return end
  task.wait(3)
  while not stopping and not expired() do
   local c=player.Character
   if c and not UIS:GetFocusedTextBox() then
    pcall(function() packet.send({Action="Roll",typeOf=""}) end)
   end
   task.wait(4)
  end
 end)
end

task.spawn(function()
 while not stopRequested and not expired() do task.wait(1) end
 -- Collect markers while the clock is still live: stopping is only set after
 -- the marker pass, so a manual stop still produces markers2.json.
 collectMarkers()
 stopping=true
 meta.elapsed=os.clock()-started
 meta.complete=not expired()
 save("impacts.json",{records=records})
 save("markers2.json",{profiles=markers})
 save("durations.json",durations)
 save("meta2.json",meta)
 print(("[col] done %.0fs | records %d | markers %d | durations %d")
  :format(meta.elapsed,#records,#markers,meta.counts.durations or 0))
end)

G.__col={stop=function() stopRequested=true print("[col] stopping") end}
print("[col] recording — fight normally")
