-- Resource navigation; VeyraMinigames exclusively owns minigame input.
local G=getgenv()
if G.VeyraGather then G.VeyraGather.stop() end
local player=game:GetService("Players").LocalPlayer
local paths=game:GetService("PathfindingService")
local UIS=game:GetService("UserInputService")
local VIM=game:GetService("VirtualInputManager")
local state={alive=true,enabled=false,mining=true,harvesting=true,broom=false,radius=300,status="Gathering off"}
G.VeyraGather=state
local generation=0
local nodes={}
local skipped=setmetatable({},{__mode="k"})
local connections={}
local held={}
local promptHeld,walking,blockedConnection,cameraSnapshot,worker
local function character()
 local c=player.Character
 return c,c and c:FindFirstChildOfClass("Humanoid"),c and c:FindFirstChild("HumanoidRootPart")
end
local function key(code,on)
 if on and held[code] or not on and not held[code] then return end
 held[code]=on or nil
 VIM:SendKeyEvent(on,code,false,game)
end
local function release()
 for code in pairs(held) do pcall(key,code,false) end
 if promptHeld then pcall(function() promptHeld:InputHoldEnd() end) promptHeld=nil end
 if walking then
  pcall(function() walking:Move(Vector3.zero) local root=walking.RootPart if root then walking:MoveTo(root.Position) end end)
  walking=nil
 end
 if blockedConnection then blockedConnection:Disconnect() blockedConnection=nil end
 if cameraSnapshot then
  local old=cameraSnapshot cameraSnapshot=nil
  pcall(function() old.camera.CameraType=old.kind old.camera.CameraSubject=old.subject old.camera.CFrame=old.frame end)
 end
end
local function active(id)
 return state.alive and state.enabled and generation==id
end
local function ready(id)
 if not active(id) then return false end
 local c,h,r=character()
 local mg=G.VeyraMinigames
 if not c or not h or not r or h.Health<=0 then state.status="Waiting for character" return false end
 if UIS:GetFocusedTextBox() then state.status="Paused for typing" return false end
 if player:GetAttribute("InCombat") or c:GetAttribute("InCombat") or h.Health<h.MaxHealth*0.3 then
  state.status="Paused: combat / low health" return false
 end
 if not mg or not mg.enabled or mg.paused then state.status="Enable Auto Minigames to gather" return false end
 if mg.active or mg.mine or mg.harvest then state.status="Waiting for minigame" return false end
 return true
end
local function params(c)
 local p=RaycastParams.new()
 p.FilterType=Enum.RaycastFilterType.Exclude
 p.FilterDescendantsInstances={c}
 p.RespectCanCollide=true
 return p
end
local function register(p)
 if not p:IsA("ProximityPrompt") then return end
 local map=workspace:FindFirstChild("Map")
 local harvest=map and map:FindFirstChild("Harvestable")
 if not harvest or not p.Parent:IsA("BasePart") then return end
 local ores=harvest:FindFirstChild("Ores")
 local crops=harvest:FindFirstChild("Crops")
 if ores and p.Name=="MinePrompt" and p:IsDescendantOf(ores) then nodes[p]="mining" end
 if crops and p.Name=="HarvestPrompt" and p:IsDescendantOf(crops) then nodes[p]="harvesting" end
end
local function available(p)
 local kind=nodes[p]
 if not kind or not state[kind] or not p.Parent or not p.Enabled then return false end
 if not p:IsDescendantOf(workspace) or (skipped[p] or 0)>os.clock() then return false end
 local model=p.Parent.Parent
 local health=model and model:GetAttribute("Health")
 return type(health)~="number" or health>0
end
local function inRange(p,r)
 return p.Parent and (r.Position-p.Parent.Position).Magnitude<=math.max(1,p.MaxActivationDistance-1)
end
local function sight(p,r,c)
 local hit=workspace:Raycast(r.Position,p.Parent.Position-r.Position,params(c))
 return not hit or hit.Instance:IsDescendantOf(p.Parent.Parent)
end
local function groundRoute(p,id)
 local c,h,r=character()
 if not c or not h or not r then return false end
 local target=p.Parent.Position
 local margin=math.clamp(p.MaxActivationDistance-2,2,5)
 -- Node centers may be inside solid ore. Try four stand-off positions.
 for attempt=1,4 do
  if not ready(id) or not available(p) then return false end
  if inRange(p,r) and sight(p,r,c) then return true end
  local angle=(attempt-1)*math.pi/2
  local offset=Vector3.new(math.cos(angle)*margin,0,math.sin(angle)*margin)
  local floor=workspace:Raycast(target+offset+Vector3.new(0,12,0),Vector3.new(0,-30,0),params(c))
  if floor and floor.Material~=Enum.Material.Water then
   local path=paths:CreatePath({AgentRadius=2,AgentHeight=5,AgentCanJump=true,WaypointSpacing=4,Costs={Water=math.huge}})
   local ok=pcall(function() path:ComputeAsync(r.Position,floor.Position) end)
   if not ready(id) then return false end
   if ok and path.Status==Enum.PathStatus.Success then
    local current=1
    local obstructed=false
    blockedConnection=path.Blocked:Connect(function(index) if index>=current then obstructed=true end end)
    walking=h
    local failed=false
    for i,waypoint in ipairs(path:GetWaypoints()) do
     current=i
     if not ready(id) or not available(p) or player.Character~=c then failed=true break end
     if inRange(p,r) and sight(p,r,c) then break end
     if waypoint.Action==Enum.PathWaypointAction.Jump then h.Jump=true end
     h:MoveTo(waypoint.Position)
     local began,lastProgress,best=os.clock(),os.clock(),math.huge
     local function reached()
      local delta=r.Position-waypoint.Position
      return Vector3.new(delta.X,0,delta.Z).Magnitude<=2 and math.abs(delta.Y)<=5
     end
     while not reached() do
      if not ready(id) or not available(p) or player.Character~=c then failed=true break end
      if inRange(p,r) and sight(p,r,c) then break end
      local distance=(r.Position-waypoint.Position).Magnitude
      if distance<best-0.35 then best=distance lastProgress=os.clock() end
      if obstructed or os.clock()-lastProgress>1.5 or os.clock()-began>6 then failed=true break end
      task.wait(0.1)
     end
     if failed then break end
    end
    release()
    if not failed and available(p) and inRange(p,r) and sight(p,r,c) then return true end
   end
  end
 end
 return false
end
local function broomKey()
 local binds=player:FindFirstChild("Binds")
 local bind=binds and binds:FindFirstChild("Broom")
 if not bind then return end
 local ok,value=pcall(function() return Enum.KeyCode[bind.Value] end)
 if ok and value~=Enum.KeyCode.Unknown then return value end
end
local function clear(a,b,c)
 if (b-a).Magnitude<0.05 then return true end
 return workspace:Blockcast(CFrame.new(a),Vector3.new(5,5,5),b-a,params(c))==nil
end
local function flightRoute(p,id)
 if not state.broom or _G.NOFLYZONE then return false end
 local c,_,r=character()
 local code=broomKey()
 if not c or not r or not code or c:GetAttribute("Flying") then return false end
 local target=p.Parent.Position
 local landing
 for i=0,7 do
  local a=i*math.pi/4
  local floor=workspace:Raycast(target+Vector3.new(math.cos(a)*5,15,math.sin(a)*5),Vector3.new(0,-35,0),params(c))
  if floor and floor.Normal.Y>0.8 and floor.Material~=Enum.Material.Water then landing=floor.Position+Vector3.new(0,6,0) break end
 end
 if not landing then return false end
 local route
 for _,height in ipairs({20,40,65,90}) do
  local y=math.max(r.Position.Y,landing.Y)+height
  local a,b=Vector3.new(r.Position.X,y,r.Position.Z),Vector3.new(landing.X,y,landing.Z)
  if clear(r.Position,a,c) and clear(a,b,c) and clear(b,landing,c) then route={a,b,landing} break end
 end
 if not route or not ready(id) then return false end
 state.status="Mounting broom"
 key(code,true) task.wait(0.1) key(code,false)
 local deadline=os.clock()+3
 repeat task.wait(0.1) until not ready(id) or c:GetAttribute("Flying") or os.clock()>deadline
 if not ready(id) or not available(p) or not state.broom or not c:GetAttribute("Flying") then release() return false end
 local camera=workspace.CurrentCamera
 cameraSnapshot={camera=camera,kind=camera.CameraType,subject=camera.CameraSubject,frame=camera.CFrame}
 camera.CameraType=Enum.CameraType.Scriptable
 for _,goal in ipairs(route) do
  local began,lastProgress,best=os.clock(),os.clock(),math.huge
  state.status="Broom route: "..p.Parent.Parent.Name
  while (goal-r.Position).Magnitude>3 do
   if not ready(id) or not state.broom or not available(p) or player.Character~=c or not c:GetAttribute("Flying") or _G.NOFLYZONE then release() return false end
   local delta=goal-r.Position
   local distance=delta.Magnitude
   if not clear(r.Position,goal,c) then state.status="Flight obstructed: paused" release() return false end
   if distance<best-0.5 then best=distance lastProgress=os.clock() end
   if os.clock()-began>25 or os.clock()-lastProgress>4 then release() return false end
   local view=r.Position+Vector3.new(0,2,0)
   -- Avoid a singular lookAt when ascending vertically.
   local up=math.abs(delta.Unit.Y)>0.98 and Vector3.xAxis or Vector3.yAxis
   camera.CFrame=CFrame.lookAt(view,view+delta.Unit,up)
   key(Enum.KeyCode.W,distance>math.max(3,r.AssemblyLinearVelocity.Magnitude*0.35))
   task.wait(0.05)
  end
  key(Enum.KeyCode.W,false)
  local settle=os.clock()+2
  repeat task.wait(0.05) until not ready(id) or r.AssemblyLinearVelocity.Magnitude<2 or os.clock()>settle
  if not ready(id) then release() return false end
 end
 release()
 if not ready(id) then return false end
 local floor=workspace:Raycast(r.Position,Vector3.new(0,-10,0),params(c))
 if not floor or floor.Material==Enum.Material.Water then state.status="Broom hovering: landing unavailable" return false end
 key(code,true) task.wait(0.1) key(code,false)
 deadline=os.clock()+3
 repeat task.wait(0.1) until not ready(id) or not c:GetAttribute("Flying") or os.clock()>deadline
 return ready(id) and not c:GetAttribute("Flying")
end
local function interact(p,id)
 local c,_,r=character()
 if not ready(id) or not available(p) or not inRange(p,r) or not sight(p,r,c) then return end
 state.status="Interacting: "..p.Parent.Parent.Name
 promptHeld=p
 p:InputHoldBegin()
 local deadline=os.clock()+p.HoldDuration+0.15
 while ready(id) and p.Parent and os.clock()<deadline do task.wait(0.05) end
 release()
 deadline=os.clock()+4
 while active(id) and os.clock()<deadline do
  local mg=G.VeyraMinigames
  if mg and (mg.active or mg.mine or mg.harvest) then
   state.status="Gathering: minigame in progress"
   local finish=os.clock()+120
   while active(id) and (mg.active or mg.mine or mg.harvest) and os.clock()<finish do task.wait(0.2) end
   skipped[p]=os.clock()+2
   return
  end
  task.wait(0.1)
 end
 skipped[p]=os.clock()+30
end
local function cycle(id)
 if not ready(id) then release() return end
 local c,_,r=character()
 if c:GetAttribute("Flying") then state.status="Land to resume gathering" release() return end
 local candidates={}
 for p in pairs(nodes) do
  if available(p) then
   local distance=(p.Parent.Position-r.Position).Magnitude
   if distance<=state.radius then table.insert(candidates,{prompt=p,distance=distance}) end
  end
 end
 table.sort(candidates,function(a,b) return a.distance<b.distance end)
 local selected=candidates[1]
 if not selected then state.status="Waiting for nearby resources" return end
 local p=selected.prompt
 state.status="Routing: "..p.Parent.Parent.Name
 if state.broom and selected.distance>100 then flightRoute(p,id) end
 if not ready(id) then release() return end
 c=player.Character
 if c and c:GetAttribute("Flying") then state.status="Land to resume gathering" return end
 if groundRoute(p,id) then interact(p,id)
 elseif ready(id) and available(p) then
  if flightRoute(p,id) and groundRoute(p,id) then interact(p,id) else skipped[p]=os.clock()+45 end
 end
 release()
end
function state.setEnabled(on)
 generation+=1
 state.enabled=on==true and state.alive
 release()
 if worker then pcall(task.cancel,worker) worker=nil end
 state.status=state.enabled and "Looking for resources" or "Gathering off"
 if not state.enabled then return end
 local id=generation
 worker=task.spawn(function()
  while active(id) do
   local ok,err=pcall(cycle,id)
   if not ok then
    release() state.enabled=false state.status="Gathering error: "..tostring(err)
    warn("Veyra: "..state.status) break
   end
   task.wait(0.5)
  end
 end)
end
function state.stop()
 state.setEnabled(false)
 state.alive=false
 for _,c in ipairs(connections) do c:Disconnect() end
 table.clear(nodes)
 if G.VeyraGather==state then G.VeyraGather=nil end
end
table.insert(connections,workspace.DescendantAdded:Connect(register))
table.insert(connections,workspace.DescendantRemoving:Connect(function(v) nodes[v]=nil skipped[v]=nil end))
table.insert(connections,player.CharacterRemoving:Connect(function() state.setEnabled(false) end))
for _,v in ipairs(workspace:GetDescendants()) do register(v) end
return state
