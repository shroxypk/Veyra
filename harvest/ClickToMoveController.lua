-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.ClickToMoveController
-- Class: ModuleScript
-- bytes: 52406

local Success, Result = pcall(function() -- line: 10
    return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding")
end)
local Success_1, Result_1 = pcall(function() -- line: 14
    return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2")
end)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local _ = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local UserRaycastPerformanceImprovements = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
).getUserFlag("UserRaycastPerformanceImprovements")
local v1 = true
local v2 = true
local v3 = false
local v4 = 1
local v5 = 8
local t = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true
}
local LocalPlayer = Players.LocalPlayer
local ClickToMoveDisplay_m = require(script.Parent:WaitForChild("ClickToMoveDisplay"))
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local t_1 = {}
local PathfindingService = game:GetService("PathfindingService")

if not UserRaycastPerformanceImprovements then
    local function FindCharacterAncestor(arg1) -- line: 65
        -- upvalues:
        --  [1] FindCharacterAncestor (copy)

        if arg1 then
            local Humanoid = arg1:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                return arg1, Humanoid
            end

            return FindCharacterAncestor(arg1.Parent)
        else
            return
        end
    end

    t_1.FindCharacterAncestor = FindCharacterAncestor

    local function Raycast(arg2: any, b1: boolean, t1: table) -- line: 77
        -- upvalues:
        --  [1] Workspace (copy)
        --  [2] FindCharacterAncestor (copy)
        --  [3] Raycast (copy)

        local v10, v8, v9
        local v7 = t1 or {}
        t1 = v7
        v7, v8, v9, v10 = Workspace:FindPartOnRayWithIgnoreList(arg2, t1)

        if v7 then
            if b1 and v7.CanCollide == false then
                local v11

                if v7 then
                    local Humanoid_1 = v7:FindFirstChildOfClass("Humanoid")

                    if Humanoid_1 then
                        v11 = Humanoid_1
                    else
                        local _ = v7.CanCollide
                        local _, v13 = FindCharacterAncestor(v7.Parent)
                        v11 = v13
                    end
                else
                    v11 = nil
                end

                if v11 == nil then
                    table.insert(t1, v7)

                    return Raycast(arg2, b1, t1)
                end
            else
                return v7, v8, v9, v10
            end
        else
            return nil, nil
        end
    end

    t_1.Raycast = Raycast
end

local t_2 = {}

local _ = function(u1: userdata) --[[ findPlayerHumanoid ]] -- line: 99
    -- upvalues:
    --  [1] t_2 (copy)

    local v14 = u1

    if v14 then
        v14 = u1.Character
    end

    if v14 then
        local v15 = t_2[u1]

        if v15 and v15.Parent == v14 then
            return v15
        end

        t_2[u1] = nil
        local Humanoid_2 = v14:FindFirstChildOfClass("Humanoid")

        if Humanoid_2 then
            t_2[u1] = Humanoid_2
        end

        return Humanoid_2
    end
end

local t_11 = nil
local v17 = nil

local _ = function() --[[ GetCharacter ]] -- line: 123
    -- upvalues:
    --  [1] LocalPlayer (copy)

    return LocalPlayer and LocalPlayer.Character
end

local v19 = nil
local v20 = nil

local function UpdateIgnoreTag(arg3) -- line: 127
    -- upvalues:
    --  [1] v17 (ref)
    --  [2] v19 (ref)
    --  [3] v20 (ref)
    --  [4] t_11 (ref)
    --  [5] LocalPlayer (copy)
    --  [6] CollectionService (copy)

    if arg3 == v17 then
        return
    end

    if v19 then
        v19:Disconnect()
        v19 = nil
    end

    if v20 then
        v20:Disconnect()
        v20 = nil
    end

    v17 = arg3
    local v21 = LocalPlayer and LocalPlayer.Character
    t_11 = { v21 }

    if v17 ~= nil then
        for _, val in ipairs((CollectionService:GetTagged(v17))) do
            table.insert(t_11, val)
        end

        v19 = CollectionService:GetInstanceAddedSignal(v17):Connect(function(arg4) -- line: 147
            -- upvalues:
            --  [1] t_11 (ref)

            table.insert(t_11, arg4)
        end)
        v20 = CollectionService:GetInstanceRemovedSignal(v17):Connect(function(arg5) -- line: 151
            -- upvalues:
            --  [1] t_11 (ref)

            for index = 1, #t_11 do
                if t_11[index] == arg5 then
                    local _ = #t_11
                    t_11[index] = t_11[#t_11]
                    table.remove(t_11)

                    return
                end
            end
        end)
    end
end

local _ = function() --[[ getIgnoreList ]] -- line: 163
    -- upvalues:
    --  [1] t_11 (ref)
    --  [2] LocalPlayer (copy)

    if t_11 then
        return t_11
    end

    t_11 = {}
    assert(t_11, "")
    local v26 = LocalPlayer
    local v27 = t_11

    if v26 then
        v26 = LocalPlayer.Character
    end

    table.insert(v27, v26)

    return t_11
end

local _ = function(vec1: Vector3, vec2: Vector3) --[[ minV ]] -- line: 173
    local v28 = math.min(vec1.X, vec2.X)
    local v29 = math.min(vec1.Y, vec2.Y)
    local v30 = math.min(vec1.Z, vec2.Z)

    return (Vector3.new(v28, v29, v30))
end

local _ = function(arg6, arg7) --[[ maxV ]] -- line: 176
    local v31 = math.max(arg6.X, arg7.X)
    local v32 = math.max(arg6.Y, arg7.Y)
    local v33 = math.max(arg6.Z, arg7.Z)

    return (Vector3.new(v31, v32, v33))
end

local function getCollidableExtentsSize(u2: userdata?) -- line: 179
    if u2 == nil or u2.PrimaryPart == nil then
        return
    end

    assert(u2, "")
    assert(u2.PrimaryPart, "")
    local v34 = u2.PrimaryPart.CFrame:Inverse()
    local v35 = Vector3.new(Infinity, Infinity, Infinity)
    local v36 = Vector3.new(-Infinity, -Infinity, -Infinity)

    for _, descendant in pairs(u2:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            local v38 = v34 * descendant.CFrame
            local vec3 = Vector3.new(
                descendant.Size.X / 2,
                descendant.Size.Y / 2,
                descendant.Size.Z / 2
            )

            for _, val_1 in ipairs(
                {
                    Vector3.new(vec3.X, vec3.Y, vec3.Z),
                    Vector3.new(vec3.X, vec3.Y, -vec3.Z),
                    Vector3.new(vec3.X, -vec3.Y, vec3.Z),
                    Vector3.new(vec3.X, -vec3.Y, -vec3.Z),
                    Vector3.new(-vec3.X, vec3.Y, vec3.Z),
                    Vector3.new(-vec3.X, vec3.Y, -vec3.Z),
                    Vector3.new(-vec3.X, -vec3.Y, vec3.Z),
                    (Vector3.new(-vec3.X, -vec3.Y, -vec3.Z))
                }
            ) do
                local v39 = v38 * val_1
                local v40 = v35
                local v41 = math.min(v40.X, v39.X)
                local v42 = math.min(v40.Y, v39.Y)
                v35 = Vector3.new(v41, v42, (math.min(v40.Z, v39.Z)))
                local v44 = v36
                local v45 = math.max(v44.X, v39.X)
                local v46 = math.max(v44.Y, v39.Y)
                v36 = Vector3.new(v45, v46, (math.max(v44.Z, v39.Z)))
            end
        end
    end

    local v48 = v36 - v35

    if v48.X < 0 or v48.Y < 0 or v48.Z < 0 then
        return nil
    end

    return v48
end

local v49 = Success and Result
local v50 = Success_1 and Result_1

local function Pather(arg8: any, arg9: any, b2: boolean?) -- line: 214
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] LocalPlayer (copy)
    --  [3] t_2 (copy)
    --  [4] v4 (ref)
    --  [5] v49 (copy)
    --  [6] getCollidableExtentsSize (copy)
    --  [7] v50 (copy)
    --  [8] PathfindingService (copy)
    --  [9] v1 (ref)
    --  [10] ClickToMoveDisplay_m (copy)
    --  [11] v5 (ref)
    --  [12] UserRaycastPerformanceImprovements (copy)
    --  [13] raycastParams (copy)
    --  [14] t_11 (ref)
    --  [15] Workspace (copy)

    local t_4 = {
        Cancelled = false,
        Started = false,
        Finished = Instance.new("BindableEvent"),
        PathFailed = Instance.new("BindableEvent"),
        PathComputing = false,
        PathComputed = false,
        OriginalTargetPoint = arg8,
        TargetPoint = arg8,
        TargetSurfaceNormal = arg9,
        DiedConn = nil,
        SeatedConn = nil,
        BlockedConn = nil,
        TeleportedConn = nil,
        CurrentPoint = 0,
        HumanoidOffsetFromPath = Vector3.new(0, 0, 0),
        CurrentWaypointPosition = nil,
        CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0),
        CurrentWaypointPlaneDistance = 0,
        CurrentWaypointNeedsJump = false,
        CurrentHumanoidPosition = Vector3.new(0, 0, 0),
        CurrentHumanoidVelocity = 0,
        NextActionMoveDirection = Vector3.new(0, 0, 0),
        NextActionJump = false,
        Timeout = 0
    }
    local v51, v52

    if b2 ~= nil then
        v51 = b2
        v52 = b2
    else
        v51 = v3
        v52 = true
    end

    local v53 = LocalPlayer
    local v54 = v53

    if v54 then
        v54 = v53.Character
    end

    local v55, v56

    if v54 then
        v55 = t_2[v53]

        if v55 and v55.Parent == v54 then
            v56 = v55
        else
            t_2[v53] = nil
            local Humanoid_3 = v54:FindFirstChildOfClass("Humanoid")

            if Humanoid_3 then
                t_2[v53] = Humanoid_3
            end

            v56 = Humanoid_3
        end
    else
        v56 = nil
    end

    t_4.Humanoid = v56
    t_4.OriginPoint = nil
    t_4.AgentCanFollowPath = false
    t_4.DirectPath = false
    t_4.DirectPathRiseFirst = false
    t_4.stopTraverseFunc = nil
    t_4.setPointFunc = nil
    t_4.pointList = nil
    local v57 = t_4.Humanoid

    if v57 then
        v57 = t_4.Humanoid.RootPart
    end

    if v57 then
        t_4.OriginPoint = v57.CFrame.Position
        local v58 = 2
        v54 = 5
        v55 = true
        local SeatPart = t_4.Humanoid.SeatPart
        local v59, v62

        if SeatPart then
            if SeatPart:IsA("VehicleSeat") then
                v59 = SeatPart:FindFirstAncestorOfClass("Model")

                if v59 then
                    local PrimaryPart = v59.PrimaryPart
                    v59.PrimaryPart = SeatPart

                    if v52 then
                        local v60 = v59:GetExtentsSize()
                        v58 = v4 * 0.5 * math.sqrt(v60.X * v60.X + v60.Z * v60.Z)
                        v54 = v4 * v60.Y
                        v55 = false
                        t_4.AgentCanFollowPath = true
                        t_4.DirectPath = v52
                    end

                    v59.PrimaryPart = PrimaryPart
                end
            else
                v59 = nil

                if v49 then
                    v62 = LocalPlayer

                    if v62 then
                        v62 = LocalPlayer.Character
                    end

                    if v62 ~= nil then
                        v59 = getCollidableExtentsSize(v62)
                    end
                end

                if v59 == nil then
                    v62 = LocalPlayer and LocalPlayer.Character
                    v59 = v62:GetExtentsSize()
                end

                assert(v59, "")
                v58 = v4 * 0.5 * math.sqrt(v59.X * v59.X + v59.Z * v59.Z)
                v54 = v4 * v59.Y
                v55 = t_4.Humanoid.JumpPower > 0 and true
                t_4.AgentCanFollowPath = true
                t_4.DirectPath = v51
                t_4.DirectPathRiseFirst = t_4.Humanoid.Sit
            end
        else
            v59 = nil

            if v49 then
                v62 = LocalPlayer

                if v62 then
                    v62 = LocalPlayer.Character
                end

                if v62 ~= nil then
                    v59 = getCollidableExtentsSize(v62)
                end
            end

            if v59 == nil then
                v62 = LocalPlayer and LocalPlayer.Character
                v59 = v62:GetExtentsSize()
            end

            assert(v59, "")
            v58 = v4 * 0.5 * math.sqrt(v59.X * v59.X + v59.Z * v59.Z)
            v54 = v4 * v59.Y
            v55 = t_4.Humanoid.JumpPower > 0 and true
            t_4.AgentCanFollowPath = true
            t_4.DirectPath = v51
            t_4.DirectPathRiseFirst = t_4.Humanoid.Sit
        end

        if v50 then
            t_4.pathResult = PathfindingService:CreatePath(
                { AgentRadius = v58, AgentHeight = v54, AgentCanJump = v55, AgentCanClimb = true }
            )
        else
            t_4.pathResult = PathfindingService:CreatePath(
                { AgentRadius = v58, AgentHeight = v54, AgentCanJump = v55 }
            )
        end
    end

    function t_4.Cleanup(_) -- line: 332
        -- upvalues:
        --  [1] t_4 (copy)

        if t_4.stopTraverseFunc then
            t_4.stopTraverseFunc()
            t_4.stopTraverseFunc = nil
        end

        if t_4.BlockedConn then
            t_4.BlockedConn:Disconnect()
            t_4.BlockedConn = nil
        end

        if t_4.DiedConn then
            t_4.DiedConn:Disconnect()
            t_4.DiedConn = nil
        end

        if t_4.SeatedConn then
            t_4.SeatedConn:Disconnect()
            t_4.SeatedConn = nil
        end

        if t_4.TeleportedConn then
            t_4.TeleportedConn:Disconnect()
            t_4.TeleportedConn = nil
        end

        t_4.Started = false
    end

    function t_4.Cancel(_) -- line: 361
        -- upvalues:
        --  [1] t_4 (copy)

        t_4.Cancelled = true
        t_4:Cleanup()
    end

    function t_4.IsActive(_) -- line: 366
        -- upvalues:
        --  [1] t_4 (copy)

        return t_4.AgentCanFollowPath and (t_4.Started and not t_4.Cancelled)
    end

    function t_4.OnPathInterrupted(_) -- line: 370
        -- upvalues:
        --  [1] t_4 (copy)

        t_4.Cancelled = true
        t_4:OnPointReached(false)
    end

    function t_4.ComputePath(_) -- line: 376
        -- upvalues:
        --  [1] t_4 (copy)

        if t_4.OriginPoint then
            if t_4.PathComputed or t_4.PathComputing then
                return
            end

            t_4.PathComputing = true

            if t_4.AgentCanFollowPath then
                if t_4.DirectPath then
                    local v65 = t_4
                    local waypoint = PathWaypoint.new(t_4.OriginPoint, Enum.PathWaypointAction.Walk)
                    local v66 = t_4.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk
                    v65.pointList = { waypoint, PathWaypoint.new(t_4.TargetPoint, v66) }
                    t_4.PathComputed = true
                else
                    t_4.pathResult:ComputeAsync(t_4.OriginPoint, t_4.TargetPoint)
                    t_4.pointList = t_4.pathResult:GetWaypoints()
                    t_4.BlockedConn = t_4.pathResult.Blocked:Connect(function(blockedWaypointIdx) -- line: 390
                        -- upvalues:
                        --  [1] t_4 (ref)

                        t_4:OnPathBlocked(blockedWaypointIdx)
                    end)
                    t_4.PathComputed = if t_4.pathResult.Status ~= Enum.PathStatus.Success then false else true
                end
            end

            t_4.PathComputing = false
        end
    end

    function t_4.IsValidPath(_) -- line: 398
        -- upvalues:
        --  [1] t_4 (copy)

        t_4:ComputePath()
        local v71 = t_4.PathComputed

        if v71 then
            v71 = t_4.AgentCanFollowPath
        end

        return v71
    end

    t_4.Recomputing = false

    function t_4.OnPathBlocked(_, arg18) -- line: 404
        -- upvalues:
        --  [1] t_4 (copy)
        --  [2] v1 (ref)
        --  [3] ClickToMoveDisplay_m (ref)

        if not (if not (arg18 >= t_4.CurrentPoint) then false else true) or t_4.Recomputing then
            return
        end

        t_4.Recomputing = true

        if t_4.stopTraverseFunc then
            t_4.stopTraverseFunc()
            t_4.stopTraverseFunc = nil
        end

        t_4.OriginPoint = t_4.Humanoid.RootPart.CFrame.p
        t_4.pathResult:ComputeAsync(t_4.OriginPoint, t_4.TargetPoint)
        t_4.pointList = t_4.pathResult:GetWaypoints()

        if #t_4.pointList > 0 then
            t_4.HumanoidOffsetFromPath = t_4.pointList[1].Position - t_4.OriginPoint
        end

        t_4.PathComputed = t_4.pathResult.Status == Enum.PathStatus.Success

        if v1 then
            t_4.stopTraverseFunc, t_4.setPointFunc = ClickToMoveDisplay_m.CreatePathDisplay(
                t_4.pointList
            )
        end

        if t_4.PathComputed then
            t_4.CurrentPoint = 1
            t_4:OnPointReached(true)
        else
            t_4.PathFailed:Fire()
            t_4:Cleanup()
        end

        t_4.Recomputing = false
    end

    function t_4.OnRenderStepped(_: table, n1: number) -- line: 440
        -- upvalues:
        --  [1] t_4 (copy)
        --  [2] v5 (ref)

        if t_4.Started and not t_4.Cancelled then
            t_4.Timeout += n1

            if t_4.Timeout > v5 then
                t_4:OnPointReached(false)

                return
            end

            t_4.CurrentHumanoidPosition = t_4.Humanoid.RootPart.Position + t_4.HumanoidOffsetFromPath
            t_4.CurrentHumanoidVelocity = t_4.Humanoid.RootPart.Velocity

            while true do
                if not t_4.Started then
                    break
                end

                if not t_4:IsCurrentWaypointReached() then
                    break
                end

                t_4:OnPointReached(true)
            end

            if t_4.Started then
                t_4.NextActionMoveDirection = t_4.CurrentWaypointPosition - t_4.CurrentHumanoidPosition

                if t_4.NextActionMoveDirection.Magnitude > 1E-06 then
                    t_4.NextActionMoveDirection = t_4.NextActionMoveDirection.Unit
                else
                    t_4.NextActionMoveDirection = Vector3.new(0, 0, 0)
                end

                if t_4.CurrentWaypointNeedsJump then
                    t_4.NextActionJump = true
                    t_4.CurrentWaypointNeedsJump = false

                    return
                end

                t_4.NextActionJump = false
            end
        end
    end

    function t_4.IsCurrentWaypointReached(_) -- line: 478
        -- upvalues:
        --  [1] t_4 (copy)

        local v79

        if t_4.CurrentWaypointPlaneNormal ~= Vector3.new(0, 0, 0) then
            v79 = t_4.CurrentWaypointPlaneNormal:Dot(t_4.CurrentHumanoidPosition) - t_4.CurrentWaypointPlaneDistance < math.max(
                1,
                0.0625 * -t_4.CurrentWaypointPlaneNormal:Dot(t_4.CurrentHumanoidVelocity)
            ) and true
        else
            v79 = true
        end

        if v79 then
            t_4.CurrentWaypointPosition = nil
            t_4.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            t_4.CurrentWaypointPlaneDistance = 0
        end

        return v79
    end

    function t_4.OnPointReached(_, arg21) -- line: 504
        -- upvalues:
        --  [1] t_4 (copy)

        if arg21 and not t_4.Cancelled then
            if t_4.setPointFunc then
                t_4.setPointFunc(t_4.CurrentPoint)
            end

            local v80 = t_4.CurrentPoint + 1

            if v80 > #t_4.pointList then
                if t_4.stopTraverseFunc then
                    t_4.stopTraverseFunc()
                end

                t_4.Finished:Fire()
                t_4:Cleanup()

                return
            end

            local v81 = t_4.pointList[t_4.CurrentPoint]
            local v82 = t_4.pointList[v80]
            local v83 = t_4.Humanoid:GetState()

            if if v83 ~= Enum.HumanoidStateType.FallingDown then if v83 == Enum.HumanoidStateType.Freefall then true else if v83 == Enum.HumanoidStateType.Jumping then true else false else true then
                v83 = if v82.Action ~= Enum.PathWaypointAction.Jump then false else true

                if not v83 and t_4.CurrentPoint > 1 then
                    local v85 = v81.Position - t_4.pointList[t_4.CurrentPoint - 1].Position
                    local v86 = v82.Position - v81.Position
                    v83 = Vector2.new(v85.x, v85.z).Unit:Dot(Vector2.new(v86.x, v86.z).Unit) < 0.996 and true
                end

                if v83 then
                    t_4.Humanoid.FreeFalling:Wait()
                    wait(0.1)
                end
            end

            t_4:MoveToNextWayPoint(v81, v82, v80)

            return
        end

        t_4.PathFailed:Fire()
        t_4:Cleanup()
    end

    function t_4.MoveToNextWayPoint(_: table, u3: userdata, u4: userdata, n2: number) -- line: 567
        -- upvalues:
        --  [1] t_4 (copy)
        --  [2] v50 (ref)

        t_4.CurrentWaypointPlaneNormal = u3.Position - u4.Position

        if not v50 or u4.Label ~= "Climb" then
            t_4.CurrentWaypointPlaneNormal = Vector3.new(
                t_4.CurrentWaypointPlaneNormal.X,
                0,
                t_4.CurrentWaypointPlaneNormal.Z
            )
        end

        if t_4.CurrentWaypointPlaneNormal.Magnitude > 1E-06 then
            t_4.CurrentWaypointPlaneNormal = t_4.CurrentWaypointPlaneNormal.Unit
            t_4.CurrentWaypointPlaneDistance = t_4.CurrentWaypointPlaneNormal:Dot(u4.Position)
        else
            t_4.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            t_4.CurrentWaypointPlaneDistance = 0
        end

        t_4.CurrentWaypointNeedsJump = u4.Action == Enum.PathWaypointAction.Jump
        t_4.CurrentWaypointPosition = u4.Position
        t_4.CurrentPoint = n2
        t_4.Timeout = 0
    end

    function t_4.Start(_, arg23) -- line: 599
        -- upvalues:
        --  [1] t_4 (copy)
        --  [2] ClickToMoveDisplay_m (ref)
        --  [3] v1 (ref)

        if not t_4.AgentCanFollowPath then
            t_4.PathFailed:Fire()

            return
        end

        if t_4.Started then
            return
        end

        t_4.Started = true
        ClickToMoveDisplay_m.CancelFailureAnimation()

        if v1 and (arg23 == nil or arg23) then
            t_4.stopTraverseFunc, t_4.setPointFunc = ClickToMoveDisplay_m.CreatePathDisplay(
                t_4.pointList,
                t_4.OriginalTargetPoint
            )
        end

        if #t_4.pointList > 0 then
            t_4.HumanoidOffsetFromPath = Vector3.new(
                0,
                t_4.pointList[1].Position.Y - t_4.OriginPoint.Y,
                0
            )
            t_4.CurrentHumanoidPosition = t_4.Humanoid.RootPart.Position + t_4.HumanoidOffsetFromPath
            t_4.CurrentHumanoidVelocity = t_4.Humanoid.RootPart.Velocity
            t_4.SeatedConn = t_4.Humanoid.Seated:Connect(function(_, _) -- line: 626
                -- upvalues:
                --  [1] t_4 (ref)

                t_4:OnPathInterrupted()
            end)
            t_4.DiedConn = t_4.Humanoid.Died:Connect(function() -- line: 627
                -- upvalues:
                --  [1] t_4 (ref)

                t_4:OnPathInterrupted()
            end)
            t_4.TeleportedConn = t_4.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(
                function() -- line: 628
                    -- upvalues:
                    --  [1] t_4 (ref)

                    t_4:OnPathInterrupted()
                end
            )
            t_4.CurrentPoint = 1
            t_4:OnPointReached(true)

            return
        end

        t_4.PathFailed:Fire()

        if t_4.stopTraverseFunc then
            t_4.stopTraverseFunc()
        end
    end

    v57 = t_4.TargetPoint + t_4.TargetSurfaceNormal * 1.5

    if UserRaycastPerformanceImprovements then
        local v97 = raycastParams

        if t_11 then
            v54 = t_11
        else
            t_11 = {}
            assert(t_11, "")
            local v98 = LocalPlayer
            local v99 = t_11

            if v98 then
                v98 = LocalPlayer.Character
            end

            table.insert(v99, v98)
            v54 = t_11
        end

        v97.FilterDescendantsInstances = v54
        v52 = Workspace:Raycast(v57, Vector3.new(-0, -50, -0), raycastParams)

        if v52 then
            t_4.TargetPoint = v52.Position
        end
    else
        local v100 = Workspace
        local ray = Ray.new(v57, Vector3.new(0, -50, 0))
        local v101

        if t_11 then
            v101 = t_11
        else
            t_11 = {}
            assert(t_11, "")
            local v102 = LocalPlayer
            local v103 = t_11

            if v102 then
                v102 = LocalPlayer.Character
            end

            table.insert(v103, v102)
            v101 = t_11
        end

        local v104, v105 = v100:FindPartOnRayWithIgnoreList(ray, v101)

        if v104 then
            t_4.TargetPoint = v105
        end
    end

    t_4:ComputePath()

    return t_4
end

local _ = function() --[[ CheckAlive ]] -- line: 664
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] t_2 (copy)

    local v106 = LocalPlayer
    local v107 = v106

    if v107 then
        v107 = v106.Character
    end

    local v109

    if v107 then
        local v108 = t_2[v106]

        if v108 and v108.Parent == v107 then
            v109 = v108
        else
            t_2[v106] = nil
            local Humanoid_4 = v107:FindFirstChildOfClass("Humanoid")

            if Humanoid_4 then
                t_2[v106] = Humanoid_4
            end

            v109 = Humanoid_4
        end
    else
        v109 = nil
    end

    v106 = if v109 == nil then false else v109.Health > 0

    return v106
end

local function GetEquippedTool(u5: userdata?) -- line: 669
    if u5 ~= nil then
        for _, val_2 in pairs(u5:GetChildren()) do
            if val_2:IsA("Tool") then
                return val_2
            end
        end
    end
end

local v111 = nil
local v112 = nil
local v113 = nil

local _ = function() --[[ CleanupPath ]] -- line: 684
    -- upvalues:
    --  [1] v111 (ref)
    --  [2] v112 (ref)
    --  [3] v113 (ref)

    if v111 then
        v111:Cancel()
        v111 = nil
    end

    if v112 then
        v112:Disconnect()
        v112 = nil
    end

    if v113 then
        v113:Disconnect()
        v113 = nil
    end
end

local function HandleMoveTo(
    arg26,
    arg27,
    arg28,
    arg29,
    arg30
) -- line: 702
    -- upvalues:
    --  [1] v111 (ref)
    --  [2] v112 (ref)
    --  [3] v113 (ref)
    --  [4] GetEquippedTool (copy)
    --  [5] v2 (ref)
    --  [6] ClickToMoveDisplay_m (copy)

    if v111 then
        if v111 then
            v111:Cancel()
            v111 = nil
        end

        if v112 then
            v112:Disconnect()
            v112 = nil
        end

        if v113 then
            v113:Disconnect()
            v113 = nil
        end
    end

    v111 = arg26
    arg26:Start(arg30)
    v112 = arg26.Finished.Event:Connect(function() -- line: 709
        -- upvalues:
        --  [1] v111 (ref)
        --  [2] v112 (ref)
        --  [3] v113 (ref)
        --  [4] arg28 (copy)
        --  [5] GetEquippedTool (ref)
        --  [6] arg29 (copy)

        if v111 then
            v111:Cancel()
            v111 = nil
        end

        if v112 then
            v112:Disconnect()
            v112 = nil
        end

        if v113 then
            v113:Disconnect()
            v113 = nil
        end

        if arg28 then
            local v114 = GetEquippedTool(arg29)

            if v114 then
                v114:Activate()
            end
        end
    end)
    v113 = arg26.PathFailed.Event:Connect(function() -- line: 718
        -- upvalues:
        --  [1] v111 (ref)
        --  [2] v112 (ref)
        --  [3] v113 (ref)
        --  [4] arg30 (copy)
        --  [5] v2 (ref)
        --  [6] ClickToMoveDisplay_m (ref)
        --  [7] arg27 (copy)

        if v111 then
            v111:Cancel()
            v111 = nil
        end

        if v112 then
            v112:Disconnect()
            v112 = nil
        end

        if v113 then
            v113:Disconnect()
            v113 = nil
        end

        if arg30 == nil or arg30 then
            local v115 = v2

            if v115 then
                local v116 = v111

                if v116 then
                    v116 = v111:IsActive()
                end

                v115 = not v116
            end

            if v115 then
                ClickToMoveDisplay_m.PlayFailureAnimation()
            end

            ClickToMoveDisplay_m.DisplayFailureWaypoint(arg27)
        end
    end)
end

local _ = function(arg31) --[[ ShowPathFailedFeedback ]] -- line: 730
    -- upvalues:
    --  [1] v111 (ref)
    --  [2] v2 (ref)
    --  [3] ClickToMoveDisplay_m (copy)

    if v111 and v111:IsActive() then
        v111:Cancel()
    end

    if v2 then
        ClickToMoveDisplay_m.PlayFailureAnimation()
    end

    ClickToMoveDisplay_m.DisplayFailureWaypoint(arg31)
end

function OnTap(t4: table, vec4: Vector3?, b3: boolean?) -- line: 740
    -- upvalues:
    --  [1] Workspace (copy)
    --  [2] LocalPlayer (copy)
    --  [3] t_2 (copy)
    --  [4] UserRaycastPerformanceImprovements (copy)
    --  [5] t_11 (ref)
    --  [6] raycastParams (copy)
    --  [7] StarterGui (copy)
    --  [8] Players (copy)
    --  [9] v111 (ref)
    --  [10] v112 (ref)
    --  [11] v113 (ref)
    --  [12] Pather (copy)
    --  [13] HandleMoveTo (copy)
    --  [14] v2 (ref)
    --  [15] ClickToMoveDisplay_m (copy)
    --  [16] t_1 (copy)
    --  [17] GetEquippedTool (copy)

    local CurrentCamera = Workspace.CurrentCamera
    local Character = LocalPlayer.Character
    local v117 = LocalPlayer
    local v118 = v117

    if v118 then
        v118 = v117.Character
    end

    local v119, v120

    if v118 then
        v119 = t_2[v117]

        if v119 and v119.Parent == v118 then
            v120 = v119
        else
            t_2[v117] = nil
            local Humanoid_5 = v118:FindFirstChildOfClass("Humanoid")

            if Humanoid_5 then
                t_2[v117] = Humanoid_5
            end

            v120 = Humanoid_5
        end
    else
        v120 = nil
    end

    if not (if v120 == nil then false else v120.Health > 0) then
        return
    end

    if #t4 == 1 or vec4 then
        if CurrentCamera then
            local v122 = CurrentCamera:ScreenPointToRay(t4[1].X, t4[1].Y)
            local v123, v131

            if UserRaycastPerformanceImprovements then
                v123 = nil
                local v124 = nil

                if t_11 then
                    v119 = t_11
                else
                    t_11 = {}
                    assert(t_11, "")
                    local v125 = t_11
                    local v126 = LocalPlayer

                    if v126 then
                        v126 = LocalPlayer.Character
                    end

                    table.insert(v125, v126)
                    v119 = t_11
                end

                if not v119 then
                    v119 = {}
                end

                local v129

                repeat
                    local v127 = true
                    raycastParams.FilterDescendantsInstances = v119
                    v129 = Workspace:Raycast(v122.Origin, v122.Direction * 1000, raycastParams)

                    if v129 then
                        local v130 = v129.Instance

                        if not v130.CanCollide then
                            repeat
                                v123 = v130:FindFirstChildOfClass("Humanoid")
                                v124 = v130
                                v130 = v130.Parent

                                if v123 then
                                    break
                                end
                            until not v130 or v130 == Workspace

                            if not v123 then
                                v124 = nil
                                v127 = false
                                table.insert(v119, v130)
                            end
                        end
                    end
                until v127

                if b3 and v123 and StarterGui:GetCore("AvatarContextMenuEnabled") and Players:GetPlayerFromCharacter(
                    v123.Parent
                ) then
                    if v111 then
                        v111:Cancel()
                        v111 = nil
                    end

                    if v112 then
                        v112:Disconnect()
                        v112 = nil
                    end

                    if v113 then
                        v113:Disconnect()
                        v113 = nil
                    end

                    return
                end

                if not v129 or not Character then
                    return
                end

                v123 = v129.Position

                if vec4 then
                    v123 = vec4
                    v124 = nil
                end

                if v111 then
                    v111:Cancel()
                    v111 = nil
                end

                if v112 then
                    v112:Disconnect()
                    v112 = nil
                end

                if v113 then
                    v113:Disconnect()
                    v113 = nil
                end

                v131 = Pather(v123, v129.Normal)

                if v131:IsValidPath() then
                    HandleMoveTo(v131, v123, v124, Character)

                    return
                end

                v131:Cleanup()

                if v111 and v111:IsActive() then
                    v111:Cancel()
                end

                if v2 then
                    ClickToMoveDisplay_m.PlayFailureAnimation()
                end

                ClickToMoveDisplay_m.DisplayFailureWaypoint(v123)

                return
            else
                v123 = Ray.new(v122.Origin, v122.Direction * 1000)
                local Raycast_1 = t_1.Raycast

                if t_11 then
                    v131 = t_11
                else
                    t_11 = {}
                    assert(t_11, "")
                    local v132 = LocalPlayer
                    local v133 = t_11

                    if v132 then
                        v132 = LocalPlayer.Character
                    end

                    table.insert(v133, v132)
                    v131 = t_11
                end

                local v134, v135, v136 = Raycast_1(v123, true, v131)
                local v137
                v131, v137 = t_1.FindCharacterAncestor(v134)

                if b3 and v137 and StarterGui:GetCore("AvatarContextMenuEnabled") and Players:GetPlayerFromCharacter(
                    v137.Parent
                ) then
                    if v111 then
                        v111:Cancel()
                        v111 = nil
                    end

                    if v112 then
                        v112:Disconnect()
                        v112 = nil
                    end

                    if v113 then
                        v113:Disconnect()
                        v113 = nil
                    end

                    return
                end

                if vec4 then
                    v135 = vec4
                    v131 = nil
                end

                if v135 and Character then
                    if v111 then
                        v111:Cancel()
                        v111 = nil
                    end

                    if v112 then
                        v112:Disconnect()
                        v112 = nil
                    end

                    if v113 then
                        v113:Disconnect()
                        v113 = nil
                    end

                    local v138 = Pather(v135, v136)

                    if v138:IsValidPath() then
                        HandleMoveTo(v138, v135, v131, Character)

                        return
                    end

                    v138:Cleanup()

                    if v111 and v111:IsActive() then
                        v111:Cancel()
                    end

                    if v2 then
                        ClickToMoveDisplay_m.PlayFailureAnimation()
                    end

                    ClickToMoveDisplay_m.DisplayFailureWaypoint(v135)

                    return
                end
            end
        end
    elseif #t4 >= 2 and CurrentCamera then
        local v139 = GetEquippedTool(Character)

        if v139 then
            v139:Activate()
        end
    end
end

local _ = function(arg32) --[[ DisconnectEvent ]] -- line: 850
    if arg32 then
        arg32:Disconnect()
    end
end

local Keyboard_m = require(script.Parent:WaitForChild("Keyboard"))
local t_8 = setmetatable({}, Keyboard_m)
t_8.__index = t_8

function t_8.new(arg33) -- line: 861
    -- upvalues:
    --  [1] Keyboard_m (copy)
    --  [2] t_8 (copy)

    local t_9 = setmetatable(Keyboard_m.new(arg33), t_8)
    t_9.fingerTouches = {}
    t_9.numUnsunkTouches = 0
    t_9.mouse1Down = tick()
    t_9.mouse1DownPos = Vector2.new()
    t_9.mouse2DownTime = tick()
    t_9.mouse2DownPos = Vector2.new()
    t_9.mouse2UpTime = tick()
    t_9.keyboardMoveVector = Vector3.new(0, 0, 0)
    t_9.tapConn = nil
    t_9.inputBeganConn = nil
    t_9.inputChangedConn = nil
    t_9.inputEndedConn = nil
    t_9.humanoidDiedConn = nil
    t_9.characterChildAddedConn = nil
    t_9.onCharacterAddedConn = nil
    t_9.characterChildRemovedConn = nil
    t_9.renderSteppedConn = nil
    t_9.menuOpenedConnection = nil
    t_9.running = false
    t_9.wasdEnabled = false

    return t_9
end

function t_8.DisconnectEvents(arg34) -- line: 893
    local TapConn = arg34.tapConn

    if TapConn then
        TapConn:Disconnect()
    end

    local InputBeganConn = arg34.inputBeganConn

    if InputBeganConn then
        InputBeganConn:Disconnect()
    end

    local InputChangedConn = arg34.inputChangedConn

    if InputChangedConn then
        InputChangedConn:Disconnect()
    end

    local InputEndedConn = arg34.inputEndedConn

    if InputEndedConn then
        InputEndedConn:Disconnect()
    end

    local HumanoidDiedConn = arg34.humanoidDiedConn

    if HumanoidDiedConn then
        HumanoidDiedConn:Disconnect()
    end

    local CharacterChildAddedConn = arg34.characterChildAddedConn

    if CharacterChildAddedConn then
        CharacterChildAddedConn:Disconnect()
    end

    local OnCharacterAddedConn = arg34.onCharacterAddedConn

    if OnCharacterAddedConn then
        OnCharacterAddedConn:Disconnect()
    end

    local RenderSteppedConn = arg34.renderSteppedConn

    if RenderSteppedConn then
        RenderSteppedConn:Disconnect()
    end

    local CharacterChildRemovedConn = arg34.characterChildRemovedConn

    if CharacterChildRemovedConn then
        CharacterChildRemovedConn:Disconnect()
    end

    local MenuOpenedConnection = arg34.menuOpenedConnection

    if MenuOpenedConnection then
        MenuOpenedConnection:Disconnect()
    end
end

function t_8.OnTouchBegan(arg35, arg36, arg37) -- line: 906
    if arg35.fingerTouches[arg36] == nil and not arg37 then
        arg35.numUnsunkTouches += 1
    end

    arg35.fingerTouches[arg36] = arg37
end

function t_8.OnTouchChanged(arg38, arg39, arg40) -- line: 913
    if arg38.fingerTouches[arg39] == nil then
        arg38.fingerTouches[arg39] = arg40

        if not arg40 then
            arg38.numUnsunkTouches += 1
        end
    end
end

function t_8.OnTouchEnded(arg41, arg42, _) -- line: 922
    if arg41.fingerTouches[arg42] ~= nil and arg41.fingerTouches[arg42] == false then
        arg41.numUnsunkTouches -= 1
    end

    arg41.fingerTouches[arg42] = nil
end

function t_8.OnCharacterAdded(arg44, arg45) -- line: 930
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] t (copy)
    --  [3] v111 (ref)
    --  [4] v112 (ref)
    --  [5] v113 (ref)
    --  [6] ClickToMoveDisplay_m (copy)
    --  [7] GuiService (copy)

    arg44:DisconnectEvents()
    arg44.inputBeganConn = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- line: 933
        -- upvalues:
        --  [1] arg44 (copy)
        --  [2] t (ref)
        --  [3] v111 (ref)
        --  [4] v112 (ref)
        --  [5] v113 (ref)
        --  [6] ClickToMoveDisplay_m (ref)

        if input.UserInputType == Enum.UserInputType.Touch then
            arg44:OnTouchBegan(input, gameProcessedEvent)
        end

        if arg44.wasdEnabled and gameProcessedEvent == false and input.UserInputType == Enum.UserInputType.Keyboard and t[input.KeyCode] then
            if v111 then
                v111:Cancel()
                v111 = nil
            end

            if v112 then
                v112:Disconnect()
                v112 = nil
            end

            if v113 then
                v113:Disconnect()
                v113 = nil
            end

            ClickToMoveDisplay_m.CancelFailureAnimation()
        end

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            arg44.mouse1DownTime = tick()
            arg44.mouse1DownPos = input.Position
        end

        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            arg44.mouse2DownTime = tick()
            arg44.mouse2DownPos = input.Position
        end
    end)
    arg44.inputChangedConn = UserInputService.InputChanged:Connect(function(
        input_1,
        gameProcessedEvent_1
    ) -- line: 954
        -- upvalues:
        --  [1] arg44 (copy)

        if input_1.UserInputType == Enum.UserInputType.Touch then
            arg44:OnTouchChanged(input_1, gameProcessedEvent_1)
        end
    end)
    arg44.inputEndedConn = UserInputService.InputEnded:Connect(function(
        input_2,
        gameProcessedEvent_2
    ) -- line: 960
        -- upvalues:
        --  [1] arg44 (copy)
        --  [2] v111 (ref)

        if input_2.UserInputType == Enum.UserInputType.Touch then
            arg44:OnTouchEnded(input_2, gameProcessedEvent_2)
        end

        if input_2.UserInputType == Enum.UserInputType.MouseButton2 then
            arg44.mouse2UpTime = tick()
            local Position = input_2.Position
            local v145 = v111 or arg44.keyboardMoveVector.Magnitude <= 0

            if arg44.mouse2UpTime - arg44.mouse2DownTime < 0.25 and (Position - arg44.mouse2DownPos).magnitude < 5 and v145 then
                OnTap({ Position })
            end
        end
    end)
    arg44.tapConn = UserInputService.TouchTap:Connect(function(touchPositions, gameProcessedEvent_3) -- line: 977
        if not gameProcessedEvent_3 then
            OnTap(touchPositions, nil, true)
        end
    end)
    arg44.menuOpenedConnection = GuiService.MenuOpened:Connect(function() -- line: 983
        -- upvalues:
        --  [1] v111 (ref)
        --  [2] v112 (ref)
        --  [3] v113 (ref)

        if v111 then
            v111:Cancel()
            v111 = nil
        end

        if v112 then
            v112:Disconnect()
            v112 = nil
        end

        if v113 then
            v113:Disconnect()
            v113 = nil
        end
    end)

    local function OnCharacterChildAdded(arg54) -- line: 987
        -- upvalues:
        --  [1] UserInputService (ref)
        --  [2] arg44 (copy)

        if UserInputService.TouchEnabled and arg54:IsA("Tool") then
            arg54.ManualActivationOnly = true
        end

        if arg54:IsA("Humanoid") then
            local HumanoidDiedConn_1 = arg44.humanoidDiedConn

            if HumanoidDiedConn_1 then
                HumanoidDiedConn_1:Disconnect()
            end

            arg44.humanoidDiedConn = arg54.Died:Connect(function() -- line: 995
            end)
        end
    end

    arg44.characterChildAddedConn = arg45.ChildAdded:Connect(function(child_1) -- line: 1003
        -- upvalues:
        --  [1] OnCharacterChildAdded (copy)

        OnCharacterChildAdded(child_1)
    end)
    arg44.characterChildRemovedConn = arg45.ChildRemoved:Connect(function(child_2) -- line: 1006
        -- upvalues:
        --  [1] UserInputService (ref)

        if UserInputService.TouchEnabled and child_2:IsA("Tool") then
            child_2.ManualActivationOnly = false
        end
    end)

    for _, child in pairs(arg45:GetChildren()) do
        OnCharacterChildAdded(child)
    end
end

function t_8.Start(arg57) -- line: 1018
    arg57:Enable(true)
end

function t_8.Stop(arg58) -- line: 1022
    arg58:Enable(false)
end

function t_8.CleanupPath(_) -- line: 1026
    -- upvalues:
    --  [1] v111 (ref)
    --  [2] v112 (ref)
    --  [3] v113 (ref)

    if v111 then
        v111:Cancel()
        v111 = nil
    end

    if v112 then
        v112:Disconnect()
        v112 = nil
    end

    if v113 then
        v113:Disconnect()
        v113 = nil
    end
end

function t_8.Enable(t5: table, b4: boolean, b5: boolean, arg60: any) -- line: 1030
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] v111 (ref)
    --  [3] v112 (ref)
    --  [4] v113 (ref)
    --  [5] UserInputService (copy)
    --  [6] Keyboard_m (copy)

    if b4 then
        if not t5.running then
            if LocalPlayer.Character then
                t5:OnCharacterAdded(LocalPlayer.Character)
            end

            t5.onCharacterAddedConn = LocalPlayer.CharacterAdded:Connect(function(character) -- line: 1036
                -- upvalues:
                --  [1] t5 (copy)

                t5:OnCharacterAdded(character)
            end)
            t5.running = true
        end

        t5.touchJumpController = arg60

        if t5.touchJumpController then
            t5.touchJumpController:Enable(t5.jumpEnabled)
        end
    else
        if t5.running then
            t5:DisconnectEvents()

            if v111 then
                v111:Cancel()
                v111 = nil
            end

            if v112 then
                v112:Disconnect()
                v112 = nil
            end

            if v113 then
                v113:Disconnect()
                v113 = nil
            end

            if UserInputService.TouchEnabled then
                local Character_1 = LocalPlayer.Character

                if Character_1 then
                    for _, val_3 in pairs(Character_1:GetChildren()) do
                        if val_3:IsA("Tool") then
                            val_3.ManualActivationOnly = false
                        end
                    end
                end
            end

            t5.running = false
        end

        if t5.touchJumpController and not t5.jumpEnabled then
            t5.touchJumpController:Enable(true)
        end

        t5.touchJumpController = nil
    end

    Keyboard_m.Enable(t5, b4)
    t5.wasdEnabled = b4 and b5 or false
    t5.enabled = b4
end

function t_8.OnRenderStepped(arg62, arg63) -- line: 1075
    -- upvalues:
    --  [1] v111 (ref)

    arg62.isJumping = false

    if v111 then
        v111:OnRenderStepped(arg63)

        if v111 then
            arg62.moveVector = v111.NextActionMoveDirection
            arg62.moveVectorIsCameraRelative = false

            if v111.NextActionJump then
                arg62.isJumping = true
            end
        else
            arg62.moveVector = arg62.keyboardMoveVector
            arg62.moveVectorIsCameraRelative = true
        end
    else
        arg62.moveVector = arg62.keyboardMoveVector
        arg62.moveVectorIsCameraRelative = true
    end

    if arg62.jumpRequested then
        arg62.isJumping = true
    end
end

function t_8.UpdateMovement(arg64, arg65) -- line: 1110
    if arg65 == Enum.UserInputState.Cancel then
        arg64.keyboardMoveVector = Vector3.new(0, 0, 0)

        return
    end

    if arg64.wasdEnabled then
        arg64.keyboardMoveVector = Vector3.new(
            arg64.leftValue + arg64.rightValue,
            0,
            arg64.forwardValue + arg64.backwardValue
        )
    end
end

function t_8.UpdateJump(_) -- line: 1119
end

function t_8.SetShowPath(_, arg68) -- line: 1124
    -- upvalues:
    --  [1] v1 (ref)

    v1 = arg68
end

function t_8.GetShowPath(_) -- line: 1128
    -- upvalues:
    --  [1] v1 (ref)

    return v1
end

function t_8.SetWaypointTexture(_, arg71) -- line: 1132
    -- upvalues:
    --  [1] ClickToMoveDisplay_m (copy)

    ClickToMoveDisplay_m.SetWaypointTexture(arg71)
end

function t_8.GetWaypointTexture(_) -- line: 1136
    -- upvalues:
    --  [1] ClickToMoveDisplay_m (copy)

    return ClickToMoveDisplay_m.GetWaypointTexture()
end

function t_8.SetWaypointRadius(_, arg74) -- line: 1140
    -- upvalues:
    --  [1] ClickToMoveDisplay_m (copy)

    ClickToMoveDisplay_m.SetWaypointRadius(arg74)
end

function t_8.GetWaypointRadius(_) -- line: 1144
    -- upvalues:
    --  [1] ClickToMoveDisplay_m (copy)

    return ClickToMoveDisplay_m.GetWaypointRadius()
end

function t_8.SetEndWaypointTexture(_, arg77) -- line: 1148
    -- upvalues:
    --  [1] ClickToMoveDisplay_m (copy)

    ClickToMoveDisplay_m.SetEndWaypointTexture(arg77)
end

function t_8.GetEndWaypointTexture(_) -- line: 1152
    -- upvalues:
    --  [1] ClickToMoveDisplay_m (copy)

    return ClickToMoveDisplay_m.GetEndWaypointTexture()
end

function t_8.SetWaypointsAlwaysOnTop(_, arg80) -- line: 1156
    -- upvalues:
    --  [1] ClickToMoveDisplay_m (copy)

    ClickToMoveDisplay_m.SetWaypointsAlwaysOnTop(arg80)
end

function t_8.GetWaypointsAlwaysOnTop(_) -- line: 1160
    -- upvalues:
    --  [1] ClickToMoveDisplay_m (copy)

    return ClickToMoveDisplay_m.GetWaypointsAlwaysOnTop()
end

function t_8.SetFailureAnimationEnabled(_, arg83) -- line: 1164
    -- upvalues:
    --  [1] v2 (ref)

    v2 = arg83
end

function t_8.GetFailureAnimationEnabled(_) -- line: 1168
    -- upvalues:
    --  [1] v2 (ref)

    return v2
end

function t_8.SetIgnoredPartsTag(_, arg86) -- line: 1172
    -- upvalues:
    --  [1] UpdateIgnoreTag (copy)

    UpdateIgnoreTag(arg86)
end

function t_8.GetIgnoredPartsTag(_) -- line: 1176
    -- upvalues:
    --  [1] v17 (ref)

    return v17
end

function t_8.SetUseDirectPath(_, arg89) -- line: 1180
    -- upvalues:
    --  [1] v3 (ref)

    v3 = arg89
end

function t_8.GetUseDirectPath(_) -- line: 1184
    -- upvalues:
    --  [1] v3 (ref)

    return v3
end

function t_8.SetAgentSizeIncreaseFactor(_: table, n3: number) -- line: 1188
    -- upvalues:
    --  [1] v4 (ref)

    v4 = n3 / 100 + 1
end

function t_8.GetAgentSizeIncreaseFactor(_) -- line: 1192
    -- upvalues:
    --  [1] v4 (ref)

    return (v4 - 1) * 100
end

function t_8.SetUnreachableWaypointTimeout(_, arg93) -- line: 1196
    -- upvalues:
    --  [1] v5 (ref)

    v5 = arg93
end

function t_8.GetUnreachableWaypointTimeout(_) -- line: 1200
    -- upvalues:
    --  [1] v5 (ref)

    return v5
end

function t_8.SetUserJumpEnabled(arg95, arg96) -- line: 1204
    arg95.jumpEnabled = arg96

    if arg95.touchJumpController then
        arg95.touchJumpController:Enable(arg96)
    end
end

function t_8.GetUserJumpEnabled(arg97) -- line: 1211
    return arg97.jumpEnabled
end

function t_8.MoveTo(_, arg99, arg100, arg101) -- line: 1215
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] Pather (copy)
    --  [3] HandleMoveTo (copy)

    local Character_2 = LocalPlayer.Character

    if Character_2 == nil then
        return false
    end

    local v150 = Pather(arg99, Vector3.new(0, 1, 0), arg101)

    if v150 and v150:IsValidPath() then
        HandleMoveTo(
            v150,
            arg99,
            nil,
            Character_2,
            arg100
        )

        return true
    end

    return false
end

return t_8
