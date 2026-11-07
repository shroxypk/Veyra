-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.VehicleController
-- Class: ModuleScript
-- bytes: 5357

local ContextActionService = game:GetService("ContextActionService")
local t = {}
t.__index = t

function t.new(arg1) -- line: 27
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.CONTROL_ACTION_PRIORITY = arg1
    t_1.enabled = false
    t_1.vehicleSeat = nil
    t_1.throttle = 0
    t_1.steer = 0
    t_1.acceleration = 0
    t_1.decceleration = 0
    t_1.turningRight = 0
    t_1.turningLeft = 0
    t_1.vehicleMoveVector = Vector3.new(0, 0, 0)
    t_1.autoPilot = {}
    t_1.autoPilot.MaxSpeed = 0
    t_1.autoPilot.MaxSteeringAngle = 0

    return t_1
end

function t.BindContextActions(arg2) -- line: 51
    -- upvalues:
    --  [1] ContextActionService (copy)

    ContextActionService:BindActionAtPriority(
        "throttleAccel",
        function(arg3, arg4, arg5) -- line: 53
            -- upvalues:
            --  [1] arg2 (copy)

            arg2:OnThrottleAccel(arg3, arg4, arg5)

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg2.CONTROL_ACTION_PRIORITY,
        Enum.KeyCode.ButtonR2
    )
    ContextActionService:BindActionAtPriority(
        "throttleDeccel",
        function(arg6, arg7, arg8) -- line: 57
            -- upvalues:
            --  [1] arg2 (copy)

            arg2:OnThrottleDeccel(arg6, arg7, arg8)

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg2.CONTROL_ACTION_PRIORITY,
        Enum.KeyCode.ButtonL2
    )
    ContextActionService:BindActionAtPriority(
        "arrowSteerRight",
        function(arg9, arg10, arg11) -- line: 62
            -- upvalues:
            --  [1] arg2 (copy)

            arg2:OnSteerRight(arg9, arg10, arg11)

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg2.CONTROL_ACTION_PRIORITY,
        Enum.KeyCode.Right
    )
    ContextActionService:BindActionAtPriority(
        "arrowSteerLeft",
        function(arg12, arg13, arg14) -- line: 66
            -- upvalues:
            --  [1] arg2 (copy)

            arg2:OnSteerLeft(arg12, arg13, arg14)

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg2.CONTROL_ACTION_PRIORITY,
        Enum.KeyCode.Left
    )
end

function t.Enable(t1: table, b1: boolean, u1: userdata) -- line: 72
    -- upvalues:
    --  [1] ContextActionService (copy)

    if b1 == t1.enabled and u1 == t1.vehicleSeat then
        return
    end

    t1.enabled = b1
    t1.vehicleMoveVector = Vector3.new(0, 0, 0)

    if b1 then
        if u1 then
            t1.vehicleSeat = u1
            t1:SetupAutoPilot()
            t1:BindContextActions()

            return
        end
    else
        ContextActionService:UnbindAction("throttleAccel")
        ContextActionService:UnbindAction("throttleDeccel")
        ContextActionService:UnbindAction("arrowSteerRight")
        ContextActionService:UnbindAction("arrowSteerLeft")
        t1.vehicleSeat = nil
    end
end

function t.OnThrottleAccel(arg15, _, arg17, _) -- line: 98
    if arg17 == Enum.UserInputState.End or arg17 == Enum.UserInputState.Cancel then
        arg15.acceleration = 0
    else
        arg15.acceleration = -1
    end

    arg15.throttle = arg15.acceleration + arg15.decceleration
end

function t.OnThrottleDeccel(arg19, _, arg21, _) -- line: 107
    if arg21 == Enum.UserInputState.End or arg21 == Enum.UserInputState.Cancel then
        arg19.decceleration = 0
    else
        arg19.decceleration = 1
    end

    arg19.throttle = arg19.acceleration + arg19.decceleration
end

function t.OnSteerRight(arg23, _, arg25, _) -- line: 116
    if arg25 == Enum.UserInputState.End or arg25 == Enum.UserInputState.Cancel then
        arg23.turningRight = 0
    else
        arg23.turningRight = 1
    end

    arg23.steer = arg23.turningRight + arg23.turningLeft
end

function t.OnSteerLeft(arg27, _, arg29, _) -- line: 125
    if arg29 == Enum.UserInputState.End or arg29 == Enum.UserInputState.Cancel then
        arg27.turningLeft = 0
    else
        arg27.turningLeft = -1
    end

    arg27.steer = arg27.turningRight + arg27.turningLeft
end

function t.Update(t2: table, vec1: Vector3, b2: boolean, b3: boolean) -- line: 135
    if t2.vehicleSeat then
        if b2 then
            vec1 += Vector3.new(t2.steer, 0, t2.throttle)

            if b3 then
                t2.vehicleSeat.ThrottleFloat = -t2.throttle
            end

            t2.vehicleSeat.ThrottleFloat = -vec1.Z
            t2.vehicleSeat.SteerFloat = vec1.X

            return vec1, true
        end

        local v1 = t2.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(vec1)
        t2.vehicleSeat.ThrottleFloat = t2:ComputeThrottle(v1)
        t2.vehicleSeat.SteerFloat = t2:ComputeSteer(v1)

        return Vector3.new(0, 0, 0), true
    else
        return vec1, false
    end
end

function t.ComputeThrottle(_, arg32) -- line: 161
    if arg32 ~= Vector3.new(0, 0, 0) then
        return -arg32.Z
    end

    return 0
end

function t.ComputeSteer(arg33, arg34) -- line: 170
    if arg34 ~= Vector3.new(0, 0, 0) then
        return -math.atan2(-arg34.x, -arg34.z) * 57.29577951308232 / arg33.autoPilot.MaxSteeringAngle
    end

    return 0
end

function t.SetupAutoPilot(arg35) -- line: 179
    arg35.autoPilot.MaxSpeed = arg35.vehicleSeat.MaxSpeed
    arg35.autoPilot.MaxSteeringAngle = 35
end

return t
