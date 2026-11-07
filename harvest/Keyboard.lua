-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.Keyboard
-- Class: ModuleScript
-- bytes: 6345

local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local _ = script.Parent.Parent:WaitForChild("CommonUtils")
local vec3 = Vector3.new()
local BaseCharacterController_m = require(script.Parent:WaitForChild("BaseCharacterController"))
local t = setmetatable({}, BaseCharacterController_m)
t.__index = t

function t.new(arg1) -- line: 22
    -- upvalues:
    --  [1] BaseCharacterController_m (copy)
    --  [2] t (copy)

    local t_1 = setmetatable(BaseCharacterController_m.new(), t)
    t_1.CONTROL_ACTION_PRIORITY = arg1
    t_1.forwardValue = 0
    t_1.backwardValue = 0
    t_1.leftValue = 0
    t_1.rightValue = 0
    t_1.jumpEnabled = true

    return t_1
end

function t.Enable(t1: table, b1: boolean) -- line: 37
    -- upvalues:
    --  [1] vec3 (copy)

    if b1 == t1.enabled then
        return true
    end

    t1.forwardValue = 0
    t1.backwardValue = 0
    t1.leftValue = 0
    t1.rightValue = 0
    t1.moveVector = vec3
    t1.jumpRequested = false
    t1:UpdateJump()

    if b1 then
        t1:BindContextActions()
        t1:ConnectFocusEventListeners()
    else
        t1._connectionUtil:disconnectAll()
    end

    t1.enabled = b1

    return true
end

function t.UpdateMovement(arg2, arg3) -- line: 64
    -- upvalues:
    --  [1] vec3 (copy)

    if arg3 == Enum.UserInputState.Cancel then
        arg2.moveVector = vec3

        return
    end

    arg2.moveVector = Vector3.new(
        arg2.leftValue + arg2.rightValue,
        0,
        arg2.forwardValue + arg2.backwardValue
    )
end

function t.UpdateJump(arg4) -- line: 72
    arg4.isJumping = arg4.jumpRequested
end

function t.BindContextActions(arg5) -- line: 76
    -- upvalues:
    --  [1] ContextActionService (copy)

    ContextActionService:BindActionAtPriority(
        "moveForwardAction",
        function(_, arg7, _) -- line: 82
            -- upvalues:
            --  [1] arg5 (copy)

            arg5.forwardValue = if arg7 ~= Enum.UserInputState.Begin then 0 else -1
            arg5:UpdateMovement(arg7)

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg5.CONTROL_ACTION_PRIORITY,
        Enum.PlayerActions.CharacterForward
    )
    ContextActionService:BindActionAtPriority(
        "moveBackwardAction",
        function(_, arg10, _) -- line: 88
            -- upvalues:
            --  [1] arg5 (copy)

            arg5.backwardValue = if arg10 ~= Enum.UserInputState.Begin then 0 else 1
            arg5:UpdateMovement(arg10)

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg5.CONTROL_ACTION_PRIORITY,
        Enum.PlayerActions.CharacterBackward
    )
    ContextActionService:BindActionAtPriority(
        "moveLeftAction",
        function(_, arg13, _) -- line: 94
            -- upvalues:
            --  [1] arg5 (copy)

            arg5.leftValue = if arg13 ~= Enum.UserInputState.Begin then 0 else -1
            arg5:UpdateMovement(arg13)

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg5.CONTROL_ACTION_PRIORITY,
        Enum.PlayerActions.CharacterLeft
    )
    ContextActionService:BindActionAtPriority(
        "moveRightAction",
        function(_, arg16, _) -- line: 100
            -- upvalues:
            --  [1] arg5 (copy)

            arg5.rightValue = if arg16 ~= Enum.UserInputState.Begin then 0 else 1
            arg5:UpdateMovement(arg16)

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg5.CONTROL_ACTION_PRIORITY,
        Enum.PlayerActions.CharacterRight
    )
    ContextActionService:BindActionAtPriority(
        "jumpAction",
        function(_, arg19, _) -- line: 106
            -- upvalues:
            --  [1] arg5 (copy)

            local v7 = arg5.jumpEnabled and arg19 == Enum.UserInputState.Begin
            arg5.jumpRequested = v7
            arg5:UpdateJump()

            return Enum.ContextActionResult.Pass
        end,
        false,
        arg5.CONTROL_ACTION_PRIORITY,
        Enum.PlayerActions.CharacterJump
    )
    arg5._connectionUtil:trackBoundFunction("moveForwardAction", function() -- line: 125
        -- upvalues:
        --  [1] ContextActionService (ref)

        ContextActionService:UnbindAction("moveForwardAction")
    end)
    arg5._connectionUtil:trackBoundFunction("moveBackwardAction", function() -- line: 126
        -- upvalues:
        --  [1] ContextActionService (ref)

        ContextActionService:UnbindAction("moveBackwardAction")
    end)
    arg5._connectionUtil:trackBoundFunction("moveLeftAction", function() -- line: 127
        -- upvalues:
        --  [1] ContextActionService (ref)

        ContextActionService:UnbindAction("moveLeftAction")
    end)
    arg5._connectionUtil:trackBoundFunction("moveRightAction", function() -- line: 128
        -- upvalues:
        --  [1] ContextActionService (ref)

        ContextActionService:UnbindAction("moveRightAction")
    end)
    arg5._connectionUtil:trackBoundFunction("jumpAction", function() -- line: 129
        -- upvalues:
        --  [1] ContextActionService (ref)

        ContextActionService:UnbindAction("jumpAction")
    end)
end

function t.ConnectFocusEventListeners(arg21) -- line: 132
    -- upvalues:
    --  [1] vec3 (copy)
    --  [2] UserInputService (copy)

    local function onFocusReleased() -- line: 133
        -- upvalues:
        --  [1] arg21 (copy)
        --  [2] vec3 (ref)

        arg21.moveVector = vec3
        arg21.forwardValue = 0
        arg21.backwardValue = 0
        arg21.leftValue = 0
        arg21.rightValue = 0
        arg21.jumpRequested = false
        arg21:UpdateJump()
    end

    local function onTextFocusGained(_) -- line: 143
        -- upvalues:
        --  [1] arg21 (copy)

        arg21.jumpRequested = false
        arg21:UpdateJump()
    end

    arg21._connectionUtil:trackConnection(
        "textBoxFocusReleased",
        UserInputService.TextBoxFocusReleased:Connect(onFocusReleased)
    )
    arg21._connectionUtil:trackConnection(
        "textBoxFocused",
        UserInputService.TextBoxFocused:Connect(onTextFocusGained)
    )
    arg21._connectionUtil:trackConnection(
        "windowFocusReleased",
        UserInputService.WindowFocused:Connect(onFocusReleased)
    )
end

return t
