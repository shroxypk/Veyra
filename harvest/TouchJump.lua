-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.TouchJump
-- Class: ModuleScript
-- bytes: 12304

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils")
local UserUpdateTouchJump = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag(
    "UserUpdateTouchJump"
)
local ConnectionUtil_m = nil
local CharacterUtil_m = nil

if UserUpdateTouchJump then
    ConnectionUtil_m = require(CommonUtils:WaitForChild("ConnectionUtil"))
    CharacterUtil_m = require(CommonUtils:WaitForChild("CharacterUtil"))
end

local _ = {
    HUMANOID_STATE_ENABLED_CHANGED = "HUMANOID_STATE_ENABLED_CHANGED",
    HUMANOID_JUMP_POWER = "HUMANOID_JUMP_POWER",
    HUMANOID = "HUMANOID",
    JUMP_INPUT_ENDED = "JUMP_INPUT_ENDED",
    MENU_OPENED = "MENU_OPENED"
}
local BaseCharacterController_m = require(script.Parent:WaitForChild("BaseCharacterController"))
local t_1 = setmetatable({}, BaseCharacterController_m)
t_1.__index = t_1

function t_1.new() -- line: 54
    -- upvalues:
    --  [1] BaseCharacterController_m (copy)
    --  [2] t_1 (copy)
    --  [3] UserUpdateTouchJump (copy)
    --  [4] ConnectionUtil_m (ref)

    local t_2 = setmetatable(BaseCharacterController_m.new(), t_1)
    t_2.parentUIFrame = nil
    t_2.jumpButton = nil

    if not UserUpdateTouchJump then
        t_2.characterAddedConn = nil
        t_2.humanoidStateEnabledChangedConn = nil
        t_2.humanoidJumpPowerConn = nil
        t_2.humanoidParentConn = nil
        t_2.jumpPower = 0
        t_2.jumpStateEnabled = true
        t_2.humanoid = nil
    end

    t_2.externallyEnabled = false
    t_2.isJumping = false

    if UserUpdateTouchJump then
        t_2._connectionUtil = ConnectionUtil_m.new()
    end

    return t_2
end

if UserUpdateTouchJump then
    function t_1._reset(arg1) -- line: 80
        arg1.isJumping = false
        arg1.touchObject = nil

        if arg1.jumpButton then
            arg1.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        end
    end
end

function t_1.EnableButton(arg2, arg3) -- line: 89
    -- upvalues:
    --  [1] UserUpdateTouchJump (copy)
    --  [2] GuiService (copy)
    --  [3] Players (copy)

    if UserUpdateTouchJump then
        if arg3 then
            if not arg2.jumpButton then
                arg2:Create()
            end

            arg2.jumpButton.Visible = true
            arg2._connectionUtil:trackConnection("JUMP_INPUT_ENDED", arg2.jumpButton.InputEnded:Connect(
                function(input) -- line: 101
                    -- upvalues:
                    --  [1] arg2 (copy)

                    if input == arg2.touchObject then
                        arg2:_reset()
                    end
                end
            ))
            arg2._connectionUtil:trackConnection("MENU_OPENED", GuiService.MenuOpened:Connect(function() -- line: 111
                -- upvalues:
                --  [1] arg2 (copy)

                if arg2.touchObject then
                    arg2:_reset()
                end
            end))
        else
            if arg2.jumpButton then
                arg2.jumpButton.Visible = false
            end

            arg2._connectionUtil:disconnect("JUMP_INPUT_ENDED")
            arg2._connectionUtil:disconnect("MENU_OPENED")
        end

        arg2:_reset()

        return
    end

    if arg3 then
        if not arg2.jumpButton then
            arg2:Create()
        end

        local v5 = Players.LocalPlayer.Character

        if v5 then
            v5 = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        end

        if v5 and arg2.externallyEnabled and arg2.externallyEnabled and v5.JumpPower > 0 then
            arg2.jumpButton.Visible = true

            return
        end
    else
        arg2.jumpButton.Visible = false
        arg2.touchObject = nil
        arg2.isJumping = false
        arg2.jumpButton.ImageRectOffset = Vector2.new(1, 146)
    end
end

function t_1.UpdateEnabled(arg5) -- line: 147
    -- upvalues:
    --  [1] UserUpdateTouchJump (copy)
    --  [2] CharacterUtil_m (ref)

    if UserUpdateTouchJump then
        local Humanoid = CharacterUtil_m.getChild("Humanoid", "Humanoid")

        if Humanoid and arg5.externallyEnabled and Humanoid.JumpPower > 0 and Humanoid:GetStateEnabled(
            Enum.HumanoidStateType.Jumping
        ) then
            arg5:EnableButton(true)

            return
        end

        arg5:EnableButton(false)

        return
    end

    if arg5.jumpPower > 0 and arg5.jumpStateEnabled then
        arg5:EnableButton(true)

        return
    end

    arg5:EnableButton(false)
end

if UserUpdateTouchJump then
    function t_1._setupConfigurations(arg6) -- line: 165
        -- upvalues:
        --  [1] CharacterUtil_m (ref)

        local function update() -- line: 166
            -- upvalues:
            --  [1] arg6 (copy)

            arg6:UpdateEnabled()
        end

        local v6 = CharacterUtil_m.onChild("Humanoid", "Humanoid", function(arg7) -- line: 171
            -- upvalues:
            --  [1] arg6 (copy)
            --  [2] update (copy)

            arg6:UpdateEnabled()
            arg6._connectionUtil:trackConnection(
                "HUMANOID_JUMP_POWER",
                arg7:GetPropertyChangedSignal("JumpPower"):Connect(update)
            )
            arg6._connectionUtil:trackConnection(
                "HUMANOID_STATE_ENABLED_CHANGED",
                arg7.StateEnabledChanged:Connect(update)
            )
        end)
        arg6._connectionUtil:trackConnection("HUMANOID", v6)
    end
end

if not UserUpdateTouchJump then
    function t_1.HumanoidChanged(arg8, arg9) -- line: 187
        -- upvalues:
        --  [1] Players (copy)

        local v7 = Players.LocalPlayer.Character

        if v7 then
            v7 = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        end

        if v7 then
            if arg9 == "JumpPower" then
                arg8.jumpPower = v7.JumpPower
                arg8:UpdateEnabled()

                return
            end

            if arg9 == "Parent" and not v7.Parent then
                arg8.humanoidChangeConn:Disconnect()
            end
        end
    end

    function t_1.HumanoidStateEnabledChanged(arg10, arg11, arg12) -- line: 202
        if arg11 == Enum.HumanoidStateType.Jumping then
            arg10.jumpStateEnabled = arg12
            arg10:UpdateEnabled()
        end
    end

    function t_1.CharacterAdded(arg13, arg14) -- line: 209
        if arg13.humanoidChangeConn then
            arg13.humanoidChangeConn:Disconnect()
            arg13.humanoidChangeConn = nil
        end

        arg13.humanoid = arg14:FindFirstChildOfClass("Humanoid")

        while true do
            if arg13.humanoid then
                break
            end

            arg14.ChildAdded:wait()
            arg13.humanoid = arg14:FindFirstChildOfClass("Humanoid")
        end

        local JumpPower = arg13.humanoid:GetPropertyChangedSignal("JumpPower")
        arg13.humanoidJumpPowerConn = JumpPower:Connect(function() -- line: 221
            -- upvalues:
            --  [1] arg13 (copy)

            arg13.jumpPower = arg13.humanoid.JumpPower
            arg13:UpdateEnabled()
        end)
        local Parent = arg13.humanoid:GetPropertyChangedSignal("Parent")
        arg13.humanoidParentConn = Parent:Connect(function() -- line: 226
            -- upvalues:
            --  [1] arg13 (copy)

            if not arg13.humanoid.Parent then
                arg13.humanoidJumpPowerConn:Disconnect()
                arg13.humanoidJumpPowerConn = nil
                arg13.humanoidParentConn:Disconnect()
                arg13.humanoidParentConn = nil
            end
        end)
        arg13.humanoidStateEnabledChangedConn = arg13.humanoid.StateEnabledChanged:Connect(function(
            state,
            isEnabled
        ) -- line: 235
            -- upvalues:
            --  [1] arg13 (copy)

            arg13:HumanoidStateEnabledChanged(state, isEnabled)
        end)
        arg13.jumpPower = arg13.humanoid.JumpPower
        arg13.jumpStateEnabled = arg13.humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping)
        arg13:UpdateEnabled()
    end

    function t_1.SetupCharacterAddedFunction(arg17) -- line: 244
        -- upvalues:
        --  [1] Players (copy)

        arg17.characterAddedConn = Players.LocalPlayer.CharacterAdded:Connect(function(character) -- line: 245
            -- upvalues:
            --  [1] arg17 (copy)

            arg17:CharacterAdded(character)
        end)

        if Players.LocalPlayer.Character then
            arg17:CharacterAdded(Players.LocalPlayer.Character)
        end
    end
end

function t_1.Enable(arg19, arg20, arg21) -- line: 254
    -- upvalues:
    --  [1] UserUpdateTouchJump (copy)

    if arg21 then
        arg19.parentUIFrame = arg21
    end

    arg19.externallyEnabled = arg20

    if UserUpdateTouchJump then
        arg19:UpdateEnabled()

        if arg20 then
            arg19:_setupConfigurations()

            return
        end

        arg19._connectionUtil:disconnectAll()

        return
    else
        arg19:EnableButton(arg20)

        return
    end
end

function t_1.Create(arg22) -- line: 272
    -- upvalues:
    --  [1] UserUpdateTouchJump (copy)
    --  [2] GuiService (copy)

    if not arg22.parentUIFrame then
        return
    end

    if arg22.jumpButton then
        arg22.jumpButton:Destroy()
        arg22.jumpButton = nil
    end

    if arg22.absoluteSizeChangedConn then
        arg22.absoluteSizeChangedConn:Disconnect()
        arg22.absoluteSizeChangedConn = nil
    end

    arg22.jumpButton = Instance.new("ImageButton")
    arg22.jumpButton.Name = "JumpButton"
    arg22.jumpButton.Visible = false
    arg22.jumpButton.BackgroundTransparency = 1
    arg22.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
    arg22.jumpButton.ImageRectOffset = Vector2.new(1, 146)
    arg22.jumpButton.ImageRectSize = Vector2.new(144, 144)

    local function ResizeJumpButton() -- line: 295
        -- upvalues:
        --  [1] arg22 (copy)

        local v8 = math.min(arg22.parentUIFrame.AbsoluteSize.x, arg22.parentUIFrame.AbsoluteSize.y) <= 500 and true
        local v9 = if not v8 then 120 else 70
        arg22.jumpButton.Size = UDim2.new(0, v9, 0, v9)
        arg22.jumpButton.Position = v8 and UDim2.new(1, -(v9 * 1.5 - 10), 1, -v9 - 20) or UDim2.new(
            1,
            -(v9 * 1.5 - 10),
            1,
            -v9 * 1.75
        )
    end

    ResizeJumpButton()
    arg22.absoluteSizeChangedConn = arg22.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        ResizeJumpButton
    )
    arg22.touchObject = nil
    arg22.jumpButton.InputBegan:connect(function(input_1) -- line: 309
        -- upvalues:
        --  [1] arg22 (copy)

        if arg22.touchObject or input_1.UserInputType ~= Enum.UserInputType.Touch or input_1.UserInputState ~= Enum.UserInputState.Begin then
            return
        end

        arg22.touchObject = input_1
        arg22.jumpButton.ImageRectOffset = Vector2.new(146, 146)
        arg22.isJumping = true
    end)

    if not UserUpdateTouchJump then
        local _ = function() -- line: 323
            -- upvalues:
            --  [1] arg22 (copy)

            arg22.touchObject = nil
            arg22.isJumping = false
            arg22.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        end

        arg22.jumpButton.InputEnded:connect(function(input_2: userdata) -- line: 329
            -- upvalues:
            --  [1] arg22 (copy)

            if input_2 == arg22.touchObject then
                arg22.touchObject = nil
                arg22.isJumping = false
                arg22.jumpButton.ImageRectOffset = Vector2.new(1, 146)
            end
        end)
        GuiService.MenuOpened:connect(function() -- line: 335
            -- upvalues:
            --  [1] arg22 (copy)

            if arg22.touchObject then
                arg22.touchObject = nil
                arg22.isJumping = false
                arg22.jumpButton.ImageRectOffset = Vector2.new(1, 146)
            end
        end)

        if not arg22.characterAddedConn then
            arg22:SetupCharacterAddedFunction()
        end
    end

    arg22.jumpButton.Parent = arg22.parentUIFrame
end

return t_1
