-- Read-only live probe for Clover RPG. Sends no packets and presses no keys.
-- Run with tools.madium.execute_luau (capture=true) and read the returned table.
local Players=game:GetService("Players")
local RS=game:GetService("ReplicatedStorage")
local paths=game:GetService("PathfindingService")
local player=Players.LocalPlayer
local out={}

local ok,place=pcall(function() return game.PlaceId end)
out.place=ok and place or nil
out.streaming=workspace.StreamingEnabled
out.streamRadius=(function()
 local ok2,v=pcall(function() return workspace.StreamingTargetRadius end)
 return ok2 and v or nil
end)()

local c=player.Character
local h=c and c:FindFirstChildOfClass("Humanoid")
local r=c and c:FindFirstChild("HumanoidRootPart")
out.character=c and {
 rig=h and tostring(h.RigType) or nil,
 hipHeight=h and h.HipHeight or nil,
 health=h and h.Health or nil,
 floor=h and tostring(h.FloorMaterial) or nil,
 rootSize=r and tostring(r.Size) or nil,
 legSize=(function()
  local leg=c and (c:FindFirstChild("Left Leg") or c:FindFirstChild("Right Leg"))
  return leg and tostring(leg.Size) or nil
 end)(),
} or nil

-- Character state attributes (parry/dodge gating reads these).
out.stateAttributes={}
if c then
 for name,value in pairs(c:GetAttributes()) do
  if string.find(name,"State_",1,true) then out.stateAttributes[name]=value end
 end
end

-- Bindable keys the panel reads.
out.binds={}
local binds=player:FindFirstChild("Binds")
if binds then
 for _,item in ipairs(binds:GetChildren()) do
  out.binds[item.Name]=tostring(item.Value)
 end
end

-- Packet shapes.
out.packets={}
local okp,packets=pcall(function() return require(RS.Modules.Packets) end)
out.packets.loaded=okp
if okp and packets then
 local function shape(ns,key)
  local entry=packets[ns] and packets[ns].packets and packets[ns].packets[key]
  if not entry then return nil end
  local t={}
  for name,value in pairs(entry) do t[name]=type(value) end
  return t
 end
 out.packets.roll=shape("Combat","RollInput")
 out.packets.block=shape("Combat","BlockInput")
 out.packets.cast=shape("Magic","Cast")
 out.packets.basic=shape("Tools","BasicTechnique")
end

-- State manager surface used by parry/dodge.
out.stateManager={}
local oks,manager=pcall(function() return require(RS.Modules.StateManager).require(c) end)
out.stateManager.loaded=oks and manager~=nil
if oks and manager then
 for _,name in ipairs({"CanDash","CanParry","CanBlock","CanUseSkill","HasState","HasAnyState",
  "IsAttacking","IsBlocking","IsParrying","IsDodging","IsFlying","IsIncapacitated","IsUsingSkill"}) do
  out.stateManager[name]=type(manager[name])
 end
 out.stateManager.canDash=manager:CanDash()
 out.stateManager.canParry=manager:CanParry()
end

-- Harvestable inventory.
local harvest=workspace:FindFirstChild("Map")
harvest=harvest and harvest:FindFirstChild("Harvestable")
out.harvest={}
if harvest then
 for _,kind in ipairs({"Ores","Crops"}) do
  local folder=harvest:FindFirstChild(kind)
  local entry={count=0,prompts={},samples={}}
  if folder then
   for _,item in ipairs(folder:GetDescendants()) do
    if item:IsA("ProximityPrompt") then
     entry.count+=1
     entry.prompts[item.Name]=(entry.prompts[item.Name] or 0)+1
     if #entry.samples<5 and item.Parent then
      local model=item.Parent.Parent
      entry.samples[#entry.samples+1]={
       node=model and model.Name or "?",
       prompt=item.Name,
       range=item.MaxActivationDistance,
       hold=item.HoldDuration,
       enabled=item.Enabled,
       partSize=tostring(item.Parent.Size),
       health=model and model:GetAttribute("Health") or nil,
       distance=r and math.floor((item.Parent.Position-r.Position).Magnitude) or nil,
      }
     end
    end
   end
  end
  out.harvest[kind]=entry
 end
end

-- Pathfinding reality check: five nearest ore prompts, standing point below.
out.paths={}
if harvest and harvest:FindFirstChild("Ores") and r then
 local list={}
 for _,item in ipairs(harvest.Ores:GetDescendants()) do
  if item:IsA("ProximityPrompt") and item.Parent then
   list[#list+1]={prompt=item,part=item.Parent,distance=(item.Parent.Position-r.Position).Magnitude}
  end
 end
 table.sort(list,function(a,b) return a.distance<b.distance end)
 local params=RaycastParams.new()
 params.FilterType=Enum.RaycastFilterType.Exclude
 params.FilterDescendantsInstances={c}
 for index=1,math.min(5,#list) do
  local entry=list[index]
  local target=entry.part.Position
  local floor=workspace:Raycast(target+Vector3.new(0,8,0),Vector3.new(0,-20,0),params)
  local point=floor and (floor.Position+Vector3.new(0,3,0))
  local row={node=entry.part.Parent and entry.part.Parent.Name or "?",distance=math.floor(entry.distance),
   floor=floor and tostring(floor.Material) or nil}
  if point then
   local path=paths:CreatePath({AgentRadius=2.25,AgentHeight=6,AgentCanJump=true,WaypointSpacing=3,
    Costs={Water=math.huge}})
   local okc=pcall(function() path:ComputeAsync(r.Position,point) end)
   row.status=okc and tostring(path.Status) or "error"
   local waypoints=okc and path:GetWaypoints() or {}
   row.waypoints=#waypoints
   local length,previous,drop=0,r.Position,0
   for _,waypoint in ipairs(waypoints) do
    length+=(waypoint.Position-previous).Magnitude
    drop=math.max(drop,previous.Y-waypoint.Position.Y)
    previous=waypoint.Position
   end
   row.length=math.floor(length)
   row.maxDrop=math.floor(drop)
  end
  out.paths[index]=row
 end
end

-- Nearby hostile animators: what dodge would see.
out.npcs={}
local seen={}
for _,model in ipairs(workspace:GetChildren()) do
 if #out.npcs>=8 then break end
 local humanoid=model:FindFirstChildOfClass("Humanoid")
 local other=model:FindFirstChild("HumanoidRootPart")
 if humanoid and other and r and not Players:GetPlayerFromCharacter(model) then
  local distance=(other.Position-r.Position).Magnitude
  if distance<=60 then
   local animator=humanoid:FindFirstChildOfClass("Animator")
   local entry={name=model.Name,distance=math.floor(distance),clips={}}
   if animator then
    for _,track in ipairs(animator:GetPlayingAnimationTracks()) do
     local anim=track.Animation
     if anim and #entry.clips<4 then
      entry.clips[#entry.clips+1]={name=anim.Name,id=anim.AnimationId:match("%d+"),
       length=math.floor(track.Length*100)/100,looped=track.Looped}
     end
    end
   end
   out.npcs[#out.npcs+1]=entry
  end
 end
end

return out
