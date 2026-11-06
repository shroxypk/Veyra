-- Resource navigation; VeyraMinigames exclusively owns minigame input.
local G=getgenv()
if G.VeyraGather then G.VeyraGather.stop() end
local player=game:GetService("Players").LocalPlayer
local paths=game:GetService("PathfindingService")
local UIS=game:GetService("UserInputService")
local VIM=game:GetService("VirtualInputManager")
local state={alive=true,enabled=false,mining=true,harvesting=true,broom=false,radius=300,status="Gathering off",phase="off",opportunistic=nil,log={},stats={plans=0,stalls=0,skipped=0,sessions=0}}
G.VeyraGather=state
local generation=0
local nodes={}
local skipped=setmetatable({},{__mode="k"})
local failures=setmetatable({},{__mode="k"})
local approach=setmetatable({},{__mode="k"})
local connections={}
local held={}
local promptHeld,walking,blockedConnection,cameraSnapshot,worker
local sessionSince,lastSessionLog,lastSessionProgress
local function report(phase,message)
 state.phase=phase state.status=message
 if state.log[#state.log]~=message then
  table.insert(state.log,message)
  if #state.log>40 then table.remove(state.log,1) end
 end
end
local function cooldown(p,reason)
 approach[p]=nil
 failures[p]=math.min((failures[p] or 0)+1,4)
 local seconds=30*failures[p]
 skipped[p]=os.clock()+seconds
 state.stats.skipped+=1
 state.lastFailure=reason
 report("skipped",string.format("Skip %s: %s (%ds)",state.target or "node",reason,seconds))
end
local function sessionStatus(mg)
 local now=os.clock()
 sessionSince=sessionSince or now
 local entry=mg.log and mg.log[#mg.log]
 if not lastSessionProgress or entry~=lastSessionLog then
  lastSessionProgress=now lastSessionLog=entry
 end
 if mg.paused then lastSessionProgress=now end
 if now-lastSessionProgress>30 and not mg.paused then
  state.enabled=false
  report("session-timeout","Gather paused: minigame has no progress for 30s")
  return false
 end
 local name=mg.mine and "Mining" or mg.harvest and "Harvesting" or "Minigame"
 state.phase="session"
 state.status=string.format("%s %s · %ds%s",name,state.target or "",now-sessionSince,
  mg.paused and " · paused" or mg.lastResult and (" · "..mg.lastResult) or "")
 return true
end
local function character()
 local c=player.Character
 return c,c and c:FindFirstChildOfClass("Humanoid"),c and c:FindFirstChild("HumanoidRootPart")
end
local function rootOffset(c,h,r)
 local height=h.HipHeight+r.Size.Y/2
 if h.RigType==Enum.HumanoidRigType.R6 then
  local leg=c:FindFirstChild("Left Leg") or c:FindFirstChild("Right Leg")
  if leg then height+=leg.Size.Y end
 end
 return height
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
 if mg.active or mg.mine or mg.harvest then sessionStatus(mg) return false end
 sessionSince,lastSessionLog,lastSessionProgress=nil,nil,nil
 return true
end
local function params(c,exclude)
 local p=RaycastParams.new()
 p.FilterType=Enum.RaycastFilterType.Exclude
 p.FilterDescendantsInstances=exclude and {c,exclude} or {c}
 p.RespectCanCollide=true
 return p
end
local function register(p)
 if not p:IsA("ProximityPrompt") then return end
 local map=workspace:FindFirstChild("Map")
 local harvest=map and map:FindFirstChild("Harvestable")
 if not harvest or not p.Parent or not p.Parent:IsA("BasePart") then return end
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
 return p.Parent and (r.Position-p.Parent.Position).Magnitude<=math.max(1,p.MaxActivationDistance-0.75)
end
local function sight(p,r,c)
 local hit=workspace:Raycast(r.Position,p.Parent.Position-r.Position,params(c))
 return not hit or hit.Instance:IsDescendantOf(p.Parent.Parent)
end
-- Anything already within prompt reach is harvested before a trip is planned.
-- Without this the walker commits to a distant node and strolls past crops that
-- were one step away.
local function reachableNode(r,c,limit)
 local best,bestDistance
 for other in pairs(nodes) do
  if available(other) and other.Parent then
   local reach=math.min(limit,other.MaxActivationDistance-1.5)
   local distance=(other.Parent.Position-r.Position).Magnitude
   if distance<=reach and (not best or distance<bestDistance) and sight(other,r,c) then
    best,bestDistance=other,distance
   end
  end
 end
 return best
end
-- Torso-height sweep between two points. Used to cut corners across open ground
-- without clipping through walls; the floor sits below the box, so it is ignored.
local function walkClear(from,to,c)
 -- Sweep horizontally at torso height. The target waypoint sits on the floor, so
 -- using its real Y would drive the box into the ground and fail every time.
 local flat=Vector3.new(to.X,from.Y,to.Z)
 local delta=flat-from
 if delta.Magnitude<0.1 then return true end
 return workspace:Blockcast(CFrame.new(from+Vector3.new(0,1.2,0)),Vector3.new(1.6,3,1.6),delta,params(c))==nil
end
local LOOKAHEAD=12
local function standingPoint(p,offset,c,h,r)
 local target=p.Parent.Position
 -- Exclude the node: ore tops and decoration are not useful standing floors.
 local floor=workspace:Raycast(target+offset+Vector3.new(0,8,0),Vector3.new(0,-20,0),params(c,p.Parent.Parent))
 if not floor or floor.Material==Enum.Material.Water or floor.Normal.Y<0.7 then return end
 local rootHeight=rootOffset(c,h,r)
 local point=floor.Position+Vector3.new(0,rootHeight,0)
 if (point-target).Magnitude>p.MaxActivationDistance-1 then return end
 if not sight(p,{Position=point},c) then return end
 -- Mesh bounding boxes can enclose empty rooms. Test actual collision surfaces
 -- across the standing footprint instead of rejecting broad-phase overlaps.
 local height=math.max(5,rootHeight+2)
 for _,x in ipairs({-1.5,0,1.5}) do
  for _,z in ipairs({-1.5,0,1.5}) do
   local origin=floor.Position+Vector3.new(x,0.2,z)
   if workspace:Raycast(origin,Vector3.new(0,height,0),params(c)) then return end
  end
 end
 return floor.Position
end
local function retreat(point,c,h,r,id)
 if not point or not ready(id) or player.Character~=c then return end
 local delta=point-r.Position
 if delta.Magnitude<1 or delta.Magnitude>9 or math.abs(delta.Y)>6 then return end
 if workspace:Blockcast(CFrame.new(r.Position+Vector3.new(0,0.5,0)),Vector3.new(2,3,2),delta,params(c)) then return end
 local floor=workspace:Raycast(point,Vector3.new(0,-7,0),params(c))
 if not floor or floor.Material==Enum.Material.Water then return end
 report("recovering","Backing away from blocked route")
 walking=h h:MoveTo(point)
 local untilTime=os.clock()+1.2
 while ready(id) and player.Character==c and os.clock()<untilTime and (r.Position-point).Magnitude>1 do task.wait(0.1) end
 release()
end
local function tryStepJump(goal,c,h,r)
 if h.FloorMaterial==Enum.Material.Air then return false end
 local delta=goal-r.Position
 local flat=Vector3.new(delta.X,0,delta.Z)
 if flat.Magnitude<0.5 then return false end
 local direction=flat.Unit
 local query=params(c)
 -- Never jump under an overhang.
 if workspace:Raycast(r.Position+Vector3.new(0,1,0),Vector3.new(0,7,0),query) then return false end
 -- Probe at ankle, knee and waist height. A one-stud step is invisible from the
 -- root, which sits three studs above the floor.
 local hit=workspace:Raycast(r.Position+Vector3.new(0,-2.2,0),direction*3,query)
  or workspace:Raycast(r.Position+Vector3.new(0,-1.2,0),direction*3,query)
  or workspace:Raycast(r.Position,direction*3,query)
 if not hit then return false end
 -- There has to be standable floor beyond the obstruction, at a climbable height.
 local ahead=r.Position+direction*3
 local floor=workspace:Raycast(ahead+Vector3.new(0,7,0),Vector3.new(0,-14,0),query)
 if not floor or floor.Material==Enum.Material.Water or floor.Normal.Y<0.7 then return false end
 if floor.Position.Y-r.Position.Y>7 then return false end
 h.Jump=true
 state.stats.jumps=(state.stats.jumps or 0)+1
 return true
end
-- MoveTo can stall against doorframes and thin props that the pathfinder still
-- considers walkable. One short sideways step usually frees the capsule; it is
-- attempted once per waypoint and only onto real, non-water floor.
local function trySidestep(goal,c,h,r,id)
 if h.FloorMaterial==Enum.Material.Air then return false end
 local dx,dz=goal.X-r.Position.X,goal.Z-r.Position.Z
 local magnitude=math.sqrt(dx*dx+dz*dz)
 if magnitude<1 then return false end
 local sideX,sideZ=-dz/magnitude,dx/magnitude
 local origin=CFrame.new(r.Position+Vector3.new(0,0.5,0))
 local size=Vector3.new(2,3,2)
 local function clear(direction)
  return workspace:Blockcast(origin,size,direction,params(c))==nil
 end
 local function floorAt(offset)
  local point=r.Position+Vector3.new(sideX*offset,0,sideZ*offset)
  local hit=workspace:Raycast(point+Vector3.new(0,2,0),Vector3.new(0,-9,0),params(c))
  if hit and hit.Material~=Enum.Material.Water and hit.Normal.Y>=0.7 then return hit.Position end
 end
 local point,direction
 for _,offset in ipairs({3,-3,1.5,-1.5}) do
  local candidate=r.Position+Vector3.new(sideX*offset,0,sideZ*offset)
  local delta=candidate-r.Position
  if clear(delta) then
   local floor=floorAt(offset)
   if floor then point,direction=floor,floor-r.Position break end
  end
 end
 if not point then return false end
 report("recovering","Stepping around obstruction")
 walking=h h:MoveTo(point)
 local untilTime=os.clock()+0.7
 while ready(id) and player.Character==c and os.clock()<untilTime do task.wait(0.1) end
 -- Resume the original goal; leaving MoveTo on the sidestep point is what made
 -- the capsule wander away from the route.
 h:MoveTo(goal)
 return true
end
local function groundRoute(p,id)
 local c,h,r=character()
 if not c or not h or not r then return false end
 state.opportunistic=nil
 local margin=math.clamp(p.MaxActivationDistance-2,2,5)
 local totalDeadline=os.clock()+30
 local rejected,blockedGoals={},{}
 for attempt=1,3 do
  if not ready(id) or not available(p) then return false end
  if inRange(p,r) and sight(p,r,c) then return true end
  report("planning","Planning route: "..state.target.." ("..attempt.."/3)")
  local options={}
  local function addApproach(index,angle,radius)
   if rejected[index] then return end
   local point=standingPoint(p,Vector3.new(math.cos(angle)*radius,0,math.sin(angle)*radius),c,h,r)
   if point then table.insert(options,{index=index,point=point,distance=(point-r.Position).Magnitude}) end
  end
  for index=1,8 do addApproach(index,(index-1)*math.pi/4,margin) end
  -- Ore veins in cliffs, walls and tree trunks can leave all eight inner points
  -- occupied. Widen the ring before declaring the node unreachable.
  if #options<2 then
   for index=9,16 do addApproach(index,(index-9)*math.pi/4+math.pi/8,margin+3) end
  end
  table.sort(options,function(a,b) return a.distance<b.distance end)
  local chosen
  -- Compare bounded candidates by actual route length, not just distance through walls.
  for optionIndex=1,math.min(4,#options) do
   if not ready(id) or not available(p) or os.clock()>totalDeadline then return false end
   local option=options[optionIndex]
   local path=paths:CreatePath({AgentRadius=2.25,AgentHeight=math.max(5,rootOffset(c,h,r)+2),AgentCanJump=true,WaypointSpacing=6,Costs={Water=math.huge}})
   state.stats.plans+=1
   local ok=pcall(function() path:ComputeAsync(r.Position,option.point) end)
   if not ready(id) or not available(p) or player.Character~=c then return false end
   if ok and path.Status==Enum.PathStatus.Success then
    local waypoints=path:GetWaypoints()
    local length,previous,valid=0,r.Position-Vector3.new(0,rootOffset(c,h,r),0),true
    for _,waypoint in ipairs(waypoints) do
     length+=(waypoint.Position-previous).Magnitude
     -- A long descent used to invalidate the whole path, which stranded every
     -- node below a ledge. Accept it when there is real floor to land on.
     if previous.Y-waypoint.Position.Y>8 then
      local landing=workspace:Raycast(waypoint.Position+Vector3.new(0,2,0),Vector3.new(0,-30,0),params(c))
      if not landing or landing.Material==Enum.Material.Water or landing.Normal.Y<0.7 then valid=false end
     end
     for _,goal in ipairs(blockedGoals) do if (waypoint.Position-goal).Magnitude<3 then valid=false end end
     previous=waypoint.Position
    end
    if valid and #waypoints>0 and (not chosen or length<chosen.length) then
     chosen={path=path,waypoints=waypoints,length=length,index=option.index}
    end
   end
  end
  if not chosen then state.lastFailure="no clear walking route" return false end
  rejected[chosen.index]=true
  do
   local waypoints=chosen.waypoints
   local goalIndex=#waypoints>1 and 2 or 1
   local obstructed=false
   blockedConnection=chosen.path.Blocked:Connect(function(index) if index>=goalIndex-1 then obstructed=true end end)
   walking=h
   local failed=false
   local lastSafe=r.Position
   local began=os.clock()
   local lastMoved,lastPosition=os.clock(),r.Position
   local retriedJump,stepped,jumped=false,false,false
   local lastGoal
   local nextOpportunity=os.clock()+0.4
   local function arrived()
    local waypoint=waypoints[goalIndex]
    if not waypoint then return true end
    local delta=r.Position-waypoint.Position
    -- Waypoints sit on the walkable surface, so the root is roughly a body
    -- height above them. Comparing Y was what stalled every route before.
    return Vector3.new(delta.X,0,delta.Z).Magnitude<=1.8 and math.abs(delta.Y)<=8
   end
   while true do
    if not ready(id) or not available(p) or player.Character~=c then failed=true break end
    if inRange(p,r) and sight(p,r,c) then break end
    state.phase="walking"
    state.status=string.format("Walking to %s · %d/%d",state.target,goalIndex,#waypoints)
    -- Do not stroll past a crop that is already within reach.
    if os.clock()>=nextOpportunity then
     nextOpportunity=os.clock()+0.45
     local other=reachableNode(r,c,8)
     if other and other~=p then state.opportunistic=other break end
    end
    -- Honour the pathfinder's jump markers first. The marker sits at the foot
    -- of the ledge, so retarget to the landing waypoint and jump; targeting the
    -- marker itself makes the humanoid hop in place against the step.
    local waypoint=waypoints[goalIndex]
    local distance=waypoint and (r.Position-waypoint.Position).Magnitude or 0
    if waypoint and waypoint.Action==Enum.PathWaypointAction.Jump and distance<=4 and not jumped then
     jumped=true
     local landing=waypoints[goalIndex+1] or waypoint
     h:MoveTo(landing.Position)
     lastGoal=landing.Position
     if h.FloorMaterial~=Enum.Material.Air
      and not workspace:Raycast(r.Position+Vector3.new(0,1,0),Vector3.new(0,7,0),params(c)) then
      h.Jump=true
      state.stats.jumps=(state.stats.jumps or 0)+1
     end
     goalIndex=math.min(goalIndex+1,#waypoints)
     lastMoved=os.clock()
    end
    -- Rolling look-ahead: target the furthest clear waypoint instead of
    -- re-issuing MoveTo every few studs, which is what made the walk stutter.
    local advanced=goalIndex
    for j=goalIndex+1,math.min(#waypoints,goalIndex+8) do
     local ahead=waypoints[j]
     local flat=Vector3.new(ahead.Position.X-r.Position.X,0,ahead.Position.Z-r.Position.Z).Magnitude
     if flat>LOOKAHEAD then break end
     if math.abs(ahead.Position.Y-r.Position.Y)>6 then break end
     if ahead.Action==Enum.PathWaypointAction.Jump then break end
     if not walkClear(r.Position,ahead.Position,c) then break end
     advanced=j
    end
    if advanced~=goalIndex then goalIndex=advanced lastGoal=nil end
    local goal=waypoints[goalIndex].Position
    local goalDistance=(r.Position-goal).Magnitude
    -- MoveTo halts the humanoid when it reaches its goal, so only re-issue when
    -- the goal changes or the capsule is about to arrive.
    if not lastGoal or (lastGoal-goal).Magnitude>0.5 or goalDistance<1.5 then
     h:MoveTo(goal) lastGoal=goal
    end
    if arrived() then
     if goalIndex>=#waypoints then break end
     goalIndex+=1 lastGoal=nil jumped=false
     lastMoved=os.clock() lastPosition=r.Position
    end
    if (r.Position-lastPosition).Magnitude>0.25 then
     lastPosition=r.Position lastMoved=os.clock()
    end
    local stuck=os.clock()-lastMoved>1.1
    if stuck and not retriedJump then
     retriedJump=true
     if tryStepJump(goal,c,h,r) then lastMoved=os.clock() lastGoal=nil end
    end
    if stuck and not stepped and os.clock()-lastMoved>1.8 then
     stepped=true
     if trySidestep(goal,c,h,r,id) then
      lastMoved=os.clock() lastGoal=nil lastPosition=r.Position
     end
    end
    if obstructed or os.clock()-lastMoved>2.8 or os.clock()-began>12 or os.clock()>totalDeadline then
     failed=true state.stats.stalls+=1 state.lastFailure="blocked or stalled route"
     table.insert(blockedGoals,goal)
     break
    end
    task.wait(0.1)
   end
   if failed then
    release()
    retreat(lastSafe,c,h,r,id)
    break
   end
   lastSafe=r.Position
   release()
   if state.opportunistic then return true end
   if available(p) and inRange(p,r) and sight(p,r,c) then return true end
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
 local c,h,r=character()
 local code=broomKey()
 if not c or not r or not code or c:GetAttribute("Flying") then return false end
 local landing
 for i=0,7 do
  local a=i*math.pi/4
  local margin=math.clamp(p.MaxActivationDistance-2,2,5)
  local point=standingPoint(p,Vector3.new(math.cos(a)*margin,0,math.sin(a)*margin),c,h,r)
  if point then landing=point+Vector3.new(0,6,0) break end
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
 report("interacting","Interacting: "..p.Parent.Parent.Name)
 promptHeld=p
 p:InputHoldBegin()
 local deadline=os.clock()+p.HoldDuration+0.15
 while ready(id) and p.Parent and os.clock()<deadline do task.wait(0.05) end
 release()
 deadline=os.clock()+4
 while active(id) and os.clock()<deadline do
  local mg=G.VeyraMinigames
  if mg and (mg.active or mg.mine or mg.harvest) then
    state.stats.sessions+=1
    while active(id) and (mg.active or mg.mine or mg.harvest) do
     if not sessionStatus(mg) then return end
     if not mg.enabled then report("paused","Enable Auto Minigames to finish this session") return end
     task.wait(0.2)
    end
    failures[p]=nil
   skipped[p]=os.clock()+2
   return
  end
  task.wait(0.1)
 end
 if active(id) then cooldown(p,"interaction did not start") end
end
local function cycle(id)
 if not ready(id) then release() return end
 if not state.mining and not state.harvesting then report("waiting","Select Gather Ores or Gather Crops") return end
 local c,_,r=character()
 if c:GetAttribute("Flying") then state.status="Land to resume gathering" release() return end
 -- Harvest anything already in reach before planning a trip.
 local here=reachableNode(r,c,8)
 if here then
  state.target=here.Parent.Parent.Name
  report("interacting","Interacting: "..state.target)
  interact(here,id)
  release()
  return
 end
 local candidates={}
 for p in pairs(nodes) do
  if available(p) then
   local distance=(p.Parent.Position-r.Position).Magnitude
   if distance<=state.radius then table.insert(candidates,{prompt=p,distance=distance}) end
  end
 end
 table.sort(candidates,function(a,b) return a.distance<b.distance end)
 if #candidates==0 then report("waiting","Waiting for available resources · skipped "..state.stats.skipped) return end
 -- One unreachable node used to burn the whole cycle. Try the next nearest
 -- candidates instead, bounded so a bad region cannot stall the loop.
 local deadline=os.clock()+75
 local tried=0
 for _,candidate in ipairs(candidates) do
  if tried>=3 or os.clock()>deadline or not ready(id) then break end
  tried+=1
  local p=candidate.prompt
  state.target=p.Parent.Parent.Name
  state.lastFailure=nil
  report("planning","Routing: "..state.target)
  if state.broom and candidate.distance>100 then flightRoute(p,id) end
  if not ready(id) then release() return end
  c=player.Character
  if c and c:GetAttribute("Flying") then state.status="Land to resume gathering" return end
  local function harvestNow()
   local target=state.opportunistic
   state.opportunistic=nil
   local _,_,now=character()
   if target and now and available(target) and inRange(target,now) and sight(target,now,c) then
    state.target=target.Parent.Parent.Name
    interact(target,id)
   else
    interact(p,id)
   end
   release()
  end
  if groundRoute(p,id) then harvestNow() return end
  if ready(id) and available(p) and flightRoute(p,id) and groundRoute(p,id) then harvestNow() return end
  if ready(id) and available(p) then cooldown(p,state.lastFailure or "no usable route") end
 end
 release()
end
function state.setEnabled(on)
 generation+=1
 state.enabled=on==true and state.alive
 release()
 if worker then pcall(task.cancel,worker) worker=nil end
 sessionSince,lastSessionLog,lastSessionProgress=nil,nil,nil
 report(state.enabled and "waiting" or "off",state.enabled and "Looking for resources" or "Gathering off")
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
table.insert(connections,workspace.DescendantRemoving:Connect(function(v) nodes[v]=nil skipped[v]=nil failures[v]=nil end))
table.insert(connections,player.CharacterRemoving:Connect(function() state.setEnabled(false) end))
for _,v in ipairs(workspace:GetDescendants()) do register(v) end
return state
