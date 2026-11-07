-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.VRNavigation
-- Class: ModuleScript
-- bytes: 17769

local VRService = game:GetService("VRService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")
local ContextActionService = game:GetService("ContextActionService")
local StarterGui = game:GetService("StarterGui")
local FlagUtil_m = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
)
local v2 = nil
local LocalPlayer = Players.LocalPlayer
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local UserRaycastPerformanceImprovements = FlagUtil_m.getUserFlag(
    "UserRaycastPerformanceImprovements"
)

local _ = function(n1: number) --[[ IsFinite ]] -- line: 42
    return if n1 ~= n1 then false else if n1 == math.huge then false else n1 ~= -math.huge
end

local _ = function(arg1) --[[ IsFiniteVector3 ]] -- line: 46
    local X = arg1.x

    return (if X ~= X then false else if X == math.huge then false else X ~= -math.huge) and (if arg1.y ~= arg1.y then false and (if arg1.z ~= arg1.z then false else if arg1.z == math.huge then false else arg1.z ~= -math.huge) else if arg1.y == math.huge then false and (if arg1.z ~= arg1.z then false else if arg1.z == math.huge then false else arg1.z ~= -math.huge) else if arg1.y ~= -math.huge then true and (if arg1.z ~= arg1.z then false else if arg1.z == math.huge then false else arg1.z ~= -math.huge) else false and (if arg1.z ~= arg1.z then false else if arg1.z == math.huge then false else arg1.z ~= -math.huge))
end

local MovementUpdate_BindableEvent = Instance.new("BindableEvent")
MovementUpdate_BindableEvent.Name = "MovementUpdate"
MovementUpdate_BindableEvent.Parent = script
coroutine.wrap(function() -- line: 54
    -- upvalues:
    --  [1] v2 (ref)

    local PathDisplay = script.Parent:WaitForChild("PathDisplay")

    if PathDisplay then
        v2 = require(PathDisplay)
    end
end)()
local BaseCharacterController_m = require(script.Parent:WaitForChild("BaseCharacterController"))
local t = setmetatable({}, BaseCharacterController_m)
t.__index = t

function t.new(arg2) -- line: 67
    -- upvalues:
    --  [1] BaseCharacterController_m (copy)
    --  [2] t (copy)

    local t_1 = setmetatable(BaseCharacterController_m.new(), t)
    t_1.CONTROL_ACTION_PRIORITY = arg2
    t_1.navigationRequestedConn = nil
    t_1.heartbeatConn = nil
    t_1.currentDestination = nil
    t_1.currentPath = nil
    t_1.currentPoints = nil
    t_1.currentPointIdx = 0
    t_1.expectedTimeToNextPoint = 0
    t_1.timeReachedLastPoint = tick()
    t_1.moving = false
    t_1.isJumpBound = false
    t_1.moveLatch = false
    t_1.userCFrameEnabledConn = nil

    return t_1
end

function t.SetLaserPointerMode(_, arg4) -- line: 92
    -- upvalues:
    --  [1] StarterGui (copy)

    pcall(function() -- line: 93
        -- upvalues:
        --  [1] StarterGui (ref)
        --  [2] arg4 (copy)

        StarterGui:SetCore("VRLaserPointerMode", arg4)
    end)
end

function t.GetLocalHumanoid(_) -- line: 98
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    for _, val in pairs(Character:GetChildren()) do
        if val:IsA("Humanoid") then
            return val
        end
    end

    return nil
end

function t.HasBothHandControllers(_) -- line: 112
    -- upvalues:
    --  [1] VRService (copy)

    local v8 = VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand)

    if v8 then
        v8 = VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
    end

    return v8
end

function t.HasAnyHandControllers(_) -- line: 116
    -- upvalues:
    --  [1] VRService (copy)

    return VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or VRService:GetUserCFrameEnabled(
        Enum.UserCFrame.LeftHand
    )
end

function t.IsMobileVR(_) -- line: 120
    -- upvalues:
    --  [1] UserInputService (copy)

    return UserInputService.TouchEnabled
end

function t.HasGamepad(_) -- line: 124
    -- upvalues:
    --  [1] UserInputService (copy)

    return UserInputService.GamepadEnabled
end

function t.ShouldUseNavigationLaser(arg10) -- line: 128
    if arg10:IsMobileVR() then
        return true
    end

    if arg10:HasBothHandControllers() then
        return false
    end

    if not arg10:HasAnyHandControllers() then
        return not arg10:HasGamepad()
    end

    return true
end

function t.StartFollowingPath(arg11, arg12) -- line: 150
    -- upvalues:
    --  [1] MovementUpdate_BindableEvent (copy)

    currentPath = arg12
    currentPoints = currentPath:GetPointCoordinates()
    currentPointIdx = 1
    moving = true
    timeReachedLastPoint = tick()
    local v10 = arg11:GetLocalHumanoid()

    if v10 and v10.Torso and #currentPoints >= 1 then
        expectedTimeToNextPoint = (currentPoints[1] - v10.Torso.Position).magnitude / v10.WalkSpeed
    end

    MovementUpdate_BindableEvent:Fire("targetPoint", arg11.currentDestination)
end

function t.GoToPoint(arg13, arg14) -- line: 167
    -- upvalues:
    --  [1] MovementUpdate_BindableEvent (copy)

    currentPath = true
    currentPoints = { arg14 }
    currentPointIdx = 1
    moving = true
    local v11 = arg13:GetLocalHumanoid()
    local v12 = (v11.Torso.Position - arg14).magnitude / v11.WalkSpeed
    timeReachedLastPoint = tick()
    expectedTimeToNextPoint = v12
    MovementUpdate_BindableEvent:Fire("targetPoint", arg14)
end

function t.StopFollowingPath(arg15) -- line: 183
    currentPath = nil
    currentPoints = nil
    currentPointIdx = 0
    moving = false
    arg15.moveVector = Vector3.new(0, 0, 0)
end

function t.TryComputePath(_: table, vec1: Vector3, vec2: Vector3) -- line: 191
    -- upvalues:
    --  [1] PathfindingService (copy)

    local v13 = 0
    local v14 = nil

    while not v14 do
        if not (v13 < 5) then
            break
        end

        v14 = PathfindingService:ComputeSmoothPathAsync(vec1, vec2, 200)
        v13 += 1

        if v14.Status == Enum.PathStatus.ClosestNoPath or v14.Status == Enum.PathStatus.ClosestOutOfRange then
            return nil
        end

        if v14 and v14.Status == Enum.PathStatus.FailStartNotEmpty then
            vec1 += (vec2 - vec1).Unit
            v14 = nil
        end

        if not v14 then
            continue
        end

        if v14.Status ~= Enum.PathStatus.FailFinishNotEmpty then
            continue
        end

        vec2 += Vector3.new(0, 1, 0)
        v14 = nil
    end

    return v14
end

function t.OnNavigationRequest(t2: table, u1: CFrame, _: CFrame) -- line: 218
    -- upvalues:
    --  [1] v2 (ref)

    local Position = u1.Position
    local CurrentDestination = t2.currentDestination
    local X_1 = Position.x

    if not ((if X_1 ~= X_1 then false else if X_1 == math.huge then false else X_1 ~= -math.huge) and (if Position.y ~= Position.y then false and (if Position.z ~= Position.z then false else if Position.z == math.huge then false else Position.z ~= -math.huge) else if Position.y == math.huge then false and (if Position.z ~= Position.z then false else if Position.z == math.huge then false else Position.z ~= -math.huge) else if Position.y ~= -math.huge then true and (if Position.z ~= Position.z then false else if Position.z == math.huge then false else Position.z ~= -math.huge) else false and (if Position.z ~= Position.z then false else if Position.z == math.huge then false else Position.z ~= -math.huge))) then
        return
    end

    t2.currentDestination = Position
    local v16 = t2:GetLocalHumanoid()

    if not v16 or not v16.Torso then
        return
    end

    local Position_1 = v16.Torso.Position

    if (t2.currentDestination - Position_1).magnitude < 12 then
        t2:GoToPoint(t2.currentDestination)

        return
    end

    if not CurrentDestination or (t2.currentDestination - CurrentDestination).magnitude > 4 then
        local v17 = t2:TryComputePath(Position_1, t2.currentDestination)

        if v17 then
            t2:StartFollowingPath(v17)

            if v2 then
                v2.setCurrentPoints(t2.currentPoints)
                v2.renderPath()

                return
            end
        else
            t2:StopFollowingPath()

            if v2 then
                v2.clearRenderedPath()

                return
            end
        end
    else
        if moving then
            t2.currentPoints[#currentPoints] = t2.currentDestination

            return
        end

        t2:GoToPoint(t2.currentDestination)
    end
end

function t.OnJumpAction(arg16, _, arg18, _) -- line: 264
    if arg18 == Enum.UserInputState.Begin then
        arg16.isJumping = true
    end

    return Enum.ContextActionResult.Sink
end

function t.BindJumpAction(arg20, arg21) -- line: 270
    -- upvalues:
    --  [1] ContextActionService (copy)

    if arg21 then
        if not arg20.isJumpBound then
            arg20.isJumpBound = true
            ContextActionService:BindActionAtPriority(
                "VRJumpAction",
                function() -- line: 274
                    -- upvalues:
                    --  [1] arg20 (copy)

                    return arg20:OnJumpAction()
                end,
                false,
                arg20.CONTROL_ACTION_PRIORITY,
                Enum.KeyCode.ButtonA
            )

            return
        end
    elseif arg20.isJumpBound then
        arg20.isJumpBound = false
        ContextActionService:UnbindAction("VRJumpAction")
    end
end

function t.ControlCharacterGamepad(arg22, _, arg24, arg25) -- line: 285
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] MovementUpdate_BindableEvent (copy)

    if arg25.KeyCode ~= Enum.KeyCode.Thumbstick1 then
        return
    end

    if arg24 == Enum.UserInputState.Cancel then
        arg22.moveVector = Vector3.new(0, 0, 0)

        return
    end

    if arg24 ~= Enum.UserInputState.End then
        arg22:StopFollowingPath()

        if v2 then
            v2.clearRenderedPath()
        end

        if arg22:ShouldUseNavigationLaser() then
            arg22:BindJumpAction(true)
            arg22:SetLaserPointerMode("Hidden")
        end

        if arg25.Position.magnitude > 0.22 then
            arg22.moveVector = Vector3.new(arg25.Position.X, 0, -arg25.Position.Y)

            if arg22.moveVector.magnitude > 0 then
                arg22.moveVector = arg22.moveVector.unit * math.min(1, arg25.Position.magnitude)
            end

            arg22.moveLatch = true
        end
    else
        arg22.moveVector = Vector3.new(0, 0, 0)

        if arg22:ShouldUseNavigationLaser() then
            arg22:BindJumpAction(false)
            arg22:SetLaserPointerMode("Navigation")
        end

        if arg22.moveLatch then
            arg22.moveLatch = false
            MovementUpdate_BindableEvent:Fire("offtrack")
        end
    end

    return Enum.ContextActionResult.Sink
end

function t.OnHeartbeat(arg26, arg27) -- line: 328
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] UserRaycastPerformanceImprovements (copy)
    --  [3] raycastParams (copy)
    --  [4] MovementUpdate_BindableEvent (copy)

    local v18 = arg26.moveVector
    local v19 = arg26:GetLocalHumanoid()

    if not v19 or not v19.Torso then
        return
    end

    local v20

    if arg26.moving and arg26.currentPoints then
        v20 = v19.Torso.Position
        local v21 = (currentPoints[1] - v20) * Vector3.new(1, 0, 1)
        local Magnitude = v21.magnitude
        local v22 = v21 / Magnitude

        if Magnitude < 1 then
            v21 = 0
            local v23 = currentPoints[1]

            for key_1, val_1 in pairs(currentPoints) do
                if key_1 ~= 1 then
                    local Magnitude_1 = (val_1 - v23).magnitude
                    v23 = val_1
                    v21 += Magnitude_1 / v19.WalkSpeed
                end
            end

            table.remove(currentPoints, 1)
            currentPointIdx += 1

            if #currentPoints == 0 then
                arg26:StopFollowingPath()

                if v2 then
                    v2.clearRenderedPath()
                end

                return
            end

            if v2 then
                v2.setCurrentPoints(currentPoints)
                v2.renderPath()
            end

            expectedTimeToNextPoint = (currentPoints[1] - v20).magnitude / v19.WalkSpeed
            timeReachedLastPoint = tick()
        else
            if UserRaycastPerformanceImprovements then
                raycastParams.FilterDescendantsInstances = {
                    game.Players.LocalPlayer.Character,
                    workspace.CurrentCamera
                }
                local v27 = workspace:Raycast(v20 - Vector3.new(0, 1, 0), v22 * 3, raycastParams)

                if v27 then
                    local v29 = workspace:Raycast(
                        v27.Position + v22 * 0.5 + Vector3.new(0, 100, 0),
                        Vector3.new(-0, -100, -0),
                        raycastParams
                    ).Position.Y - v20.Y

                    if v29 < 6 and v29 > -2 then
                        v19.Jump = true
                    end
                end
            else
                local t_2 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
                local v30, v31, _ = workspace:FindPartOnRayWithIgnoreList(
                    Ray.new(v20 - Vector3.new(0, 1, 0), v22 * 3),
                    t_2
                )

                if v30 then
                    local _, v34, _ = workspace:FindPartOnRayWithIgnoreList(
                        Ray.new(v31 + v22 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0)),
                        t_2
                    )
                    local v36 = v34.Y - v20.Y

                    if v36 < 6 and v36 > -2 then
                        v19.Jump = true
                    end
                end
            end

            if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
                arg26:StopFollowingPath()

                if v2 then
                    v2.clearRenderedPath()
                end

                MovementUpdate_BindableEvent:Fire("offtrack")
            end

            v18 = arg26.moveVector:Lerp(v22, arg27 * 10)
        end
    end

    local X_2 = v18.x
    v20 = (if X_2 ~= X_2 then false else if X_2 == math.huge then false else X_2 ~= -math.huge) and (if v18.y ~= v18.y then false and (if v18.z ~= v18.z then false else if v18.z == math.huge then false else v18.z ~= -math.huge) else if v18.y == math.huge then false and (if v18.z ~= v18.z then false else if v18.z == math.huge then false else v18.z ~= -math.huge) else if v18.y ~= -math.huge then true and (if v18.z ~= v18.z then false else if v18.z == math.huge then false else v18.z ~= -math.huge) else false and (if v18.z ~= v18.z then false else if v18.z == math.huge then false else v18.z ~= -math.huge))

    if v20 then
        arg26.moveVector = v18
    end
end

function t.OnUserCFrameEnabled(arg28) -- line: 426
    if arg28:ShouldUseNavigationLaser() then
        arg28:BindJumpAction(false)
        arg28:SetLaserPointerMode("Navigation")

        return
    end

    arg28:BindJumpAction(true)
    arg28:SetLaserPointerMode("Hidden")
end

function t.Enable(arg29, arg30) -- line: 436
    -- upvalues:
    --  [1] VRService (copy)
    --  [2] RunService (copy)
    --  [3] ContextActionService (copy)

    arg29.moveVector = Vector3.new(0, 0, 0)
    arg29.isJumping = false

    if arg30 then
        arg29.navigationRequestedConn = VRService.NavigationRequested:Connect(function(
            cframe,
            inputUserCFrame
        ) -- line: 442
            -- upvalues:
            --  [1] arg29 (copy)

            arg29:OnNavigationRequest(cframe, inputUserCFrame)
        end)
        arg29.heartbeatConn = RunService.Heartbeat:Connect(function(deltaTime) -- line: 443
            -- upvalues:
            --  [1] arg29 (copy)

            arg29:OnHeartbeat(deltaTime)
        end)
        ContextActionService:BindAction(
            "MoveThumbstick",
            function(arg34, arg35, arg36) -- line: 445
                -- upvalues:
                --  [1] arg29 (copy)

                return arg29:ControlCharacterGamepad(arg34, arg35, arg36)
            end,
            false,
            arg29.CONTROL_ACTION_PRIORITY,
            Enum.KeyCode.Thumbstick1
        )
        ContextActionService:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
        arg29.userCFrameEnabledConn = VRService.UserCFrameEnabled:Connect(function() -- line: 449
            -- upvalues:
            --  [1] arg29 (copy)

            arg29:OnUserCFrameEnabled()
        end)
        arg29:OnUserCFrameEnabled()
        VRService:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick)
        VRService:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY)
        arg29.enabled = true

        return
    end

    arg29:StopFollowingPath()
    ContextActionService:UnbindAction("MoveThumbstick")
    ContextActionService:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
    arg29:BindJumpAction(false)
    arg29:SetLaserPointerMode("Disabled")

    if arg29.navigationRequestedConn then
        arg29.navigationRequestedConn:Disconnect()
        arg29.navigationRequestedConn = nil
    end

    if arg29.heartbeatConn then
        arg29.heartbeatConn:Disconnect()
        arg29.heartbeatConn = nil
    end

    if arg29.userCFrameEnabledConn then
        arg29.userCFrameEnabledConn:Disconnect()
        arg29.userCFrameEnabledConn = nil
    end

    arg29.enabled = false
end

return t
