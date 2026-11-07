-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.Gamepad
-- Class: ModuleScript
-- bytes: 6633

local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local _ = script.Parent.Parent:WaitForChild("CommonUtils")
local UserInputType_None = Enum.UserInputType.None
local BaseCharacterController_m = require(script.Parent:WaitForChild("BaseCharacterController"))
local t = setmetatable({}, BaseCharacterController_m)
t.__index = t

function t.new(arg1) -- line: 23
    -- upvalues:
    --  [1] BaseCharacterController_m (copy)
    --  [2] t (copy)
    --  [3] UserInputType_None (copy)

    local t_1 = setmetatable(BaseCharacterController_m.new(), t)
    t_1.CONTROL_ACTION_PRIORITY = arg1
    t_1.forwardValue = 0
    t_1.backwardValue = 0
    t_1.leftValue = 0
    t_1.rightValue = 0
    t_1.activeGamepad = UserInputType_None
    t_1.gamepadConnectedConn = nil
    t_1.gamepadDisconnectedConn = nil

    return t_1
end

function t.Enable(t1: table, b1: boolean) -- line: 39
    -- upvalues:
    --  [1] UserInputType_None (copy)

    if b1 == t1.enabled then
        return true
    end

    t1.forwardValue = 0
    t1.backwardValue = 0
    t1.leftValue = 0
    t1.rightValue = 0
    t1.moveVector = Vector3.new(0, 0, 0)
    t1.isJumping = false

    if b1 then
        t1.activeGamepad = t1:GetHighestPriorityGamepad()

        if t1.activeGamepad ~= UserInputType_None then
            t1:BindContextActions()
            t1:ConnectGamepadConnectionListeners()
        else
            return false
        end
    else
        t1:UnbindContextActions()
        t1:DisconnectGamepadConnectionListeners()
        t1.activeGamepad = UserInputType_None
    end

    t1.enabled = b1

    return true
end

function t.GetHighestPriorityGamepad(_) -- line: 75
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] UserInputType_None (copy)

    local v3 = UserInputService:GetConnectedGamepads()
    local v4 = UserInputType_None

    for _, val in pairs(v3) do
        if val.Value < v4.Value then
            v4 = val
        end
    end

    return v4
end

function t.BindContextActions(arg3) -- line: 86
    -- upvalues:
    --  [1] UserInputType_None (copy)
    --  [2] ContextActionService (copy)

    if arg3.activeGamepad == UserInputType_None then
        return false
    end

    ContextActionService:BindActivate(arg3.activeGamepad, Enum.KeyCode.ButtonR2)
    ContextActionService:BindActionAtPriority(
        "jumpAction",
        function(_, arg5, _) -- line: 93
            -- upvalues:
            --  [1] arg3 (copy)

            arg3.isJumping = arg5 == Enum.UserInputState.Begin

            return Enum.ContextActionResult.Sink
        end,
        false,
        arg3.CONTROL_ACTION_PRIORITY,
        Enum.KeyCode.ButtonA
    )
    ContextActionService:BindActionAtPriority(
        "moveThumbstick",
        function(_, arg8, arg9) -- line: 98
            -- upvalues:
            --  [1] arg3 (copy)

            if arg8 == Enum.UserInputState.Cancel then
                arg3.moveVector = Vector3.new(0, 0, 0)

                return Enum.ContextActionResult.Sink
            end

            if arg3.activeGamepad ~= arg9.UserInputType then
                return Enum.ContextActionResult.Pass
            end

            if arg9.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                return
            end

            if arg9.Position.magnitude > 0.2 then
                arg3.moveVector = Vector3.new(arg9.Position.X, 0, -arg9.Position.Y)
            else
                arg3.moveVector = Vector3.new(0, 0, 0)
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        arg3.CONTROL_ACTION_PRIORITY,
        Enum.KeyCode.Thumbstick1
    )

    return true
end

function t.UnbindContextActions(arg10) -- line: 127
    -- upvalues:
    --  [1] UserInputType_None (copy)
    --  [2] ContextActionService (copy)

    if arg10.activeGamepad ~= UserInputType_None then
        ContextActionService:UnbindActivate(arg10.activeGamepad, Enum.KeyCode.ButtonR2)
    end

    ContextActionService:UnbindAction("moveThumbstick")
    ContextActionService:UnbindAction("jumpAction")
end

function t.OnNewGamepadConnected(arg11) -- line: 135
    -- upvalues:
    --  [1] UserInputType_None (copy)

    local v7 = arg11:GetHighestPriorityGamepad()

    if v7 == arg11.activeGamepad then
        return
    end

    if v7 == UserInputType_None then
        warn("Gamepad:OnNewGamepadConnected found no connected gamepads")
        arg11:UnbindContextActions()

        return
    end

    if arg11.activeGamepad ~= UserInputType_None then
        arg11:UnbindContextActions()
    end

    arg11.activeGamepad = v7
    arg11:BindContextActions()
end

function t.OnCurrentGamepadDisconnected(arg12) -- line: 162
    -- upvalues:
    --  [1] UserInputType_None (copy)
    --  [2] ContextActionService (copy)

    if arg12.activeGamepad ~= UserInputType_None then
        ContextActionService:UnbindActivate(arg12.activeGamepad, Enum.KeyCode.ButtonR2)
    end

    local v8 = arg12:GetHighestPriorityGamepad()

    if arg12.activeGamepad ~= UserInputType_None and v8 == arg12.activeGamepad then
        warn(
            "Gamepad:OnCurrentGamepadDisconnected found the supposedly disconnected gamepad in connectedGamepads."
        )
        arg12:UnbindContextActions()
        arg12.activeGamepad = UserInputType_None

        return
    end

    if v8 == UserInputType_None then
        arg12:UnbindContextActions()
        arg12.activeGamepad = UserInputType_None

        return
    end

    arg12.activeGamepad = v8
    ContextActionService:BindActivate(arg12.activeGamepad, Enum.KeyCode.ButtonR2)
end

function t.ConnectGamepadConnectionListeners(arg13) -- line: 187
    -- upvalues:
    --  [1] UserInputService (copy)

    arg13.gamepadConnectedConn = UserInputService.GamepadConnected:Connect(function(_) -- line: 188
        -- upvalues:
        --  [1] arg13 (copy)

        arg13:OnNewGamepadConnected()
    end)
    arg13.gamepadDisconnectedConn = UserInputService.GamepadDisconnected:Connect(function(
        gamepadNum
    ) -- line: 192
        -- upvalues:
        --  [1] arg13 (copy)

        if arg13.activeGamepad == gamepadNum then
            arg13:OnCurrentGamepadDisconnected()
        end
    end)
end

function t.DisconnectGamepadConnectionListeners(arg16) -- line: 200
    if arg16.gamepadConnectedConn then
        arg16.gamepadConnectedConn:Disconnect()
        arg16.gamepadConnectedConn = nil
    end

    if arg16.gamepadDisconnectedConn then
        arg16.gamepadDisconnectedConn:Disconnect()
        arg16.gamepadDisconnectedConn = nil
    end
end

return t
