-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.MouseLockController
-- Class: ModuleScript
-- bytes: 8797

local FlagUtil_m = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
)
local Value = Enum.ContextActionPriority.Medium.Value
local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local GameSettings = UserSettings().GameSettings
local CameraUtils_m = require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local UserFixCameraOffsetJitter2 = FlagUtil_m.getUserFlag("UserFixCameraOffsetJitter2")
local t = {}
t.__index = t

function t.new() -- line: 37
    -- upvalues:
    --  [1] t (copy)
    --  [2] GameSettings (copy)
    --  [3] Players (copy)
    --  [4] UserInputService (copy)

    local t_1 = setmetatable({}, t)
    t_1.isMouseLocked = false
    t_1.savedMouseCursor = nil
    t_1.boundKeys = { Enum.KeyCode.LeftAlt, Enum.KeyCode.RightAlt, Enum.KeyCode.ButtonR3 }
    t_1.mouseLockToggledEvent = Instance.new("BindableEvent")
    local v4 = script:FindFirstChild("BoundKeys")

    if v4 then
        if not v4:IsA("StringValue") then
            if v4 then
                v4:Destroy()
            end

            v4 = Instance.new("StringValue")
            assert(v4, "")
            v4.Name = "BoundKeys"
            v4.Value = "LeftAlt,RightAlt,ButtonR3"
            v4.Parent = script
        end
    else
        if v4 then
            v4:Destroy()
        end

        v4 = Instance.new("StringValue")
        assert(v4, "")
        v4.Name = "BoundKeys"
        v4.Value = "LeftAlt,RightAlt,ButtonR3"
        v4.Parent = script
    end

    if v4 then
        v4.Changed:Connect(function(arg1) -- line: 62
            -- upvalues:
            --  [1] t_1 (copy)

            t_1:OnBoundKeysObjectChanged(arg1)
        end)
        t_1:OnBoundKeysObjectChanged(v4.Value)
    end

    GameSettings.Changed:Connect(function(arg2) -- line: 69
        -- upvalues:
        --  [1] t_1 (copy)

        if arg2 == "ControlMode" or arg2 == "ComputerMovementMode" then
            t_1:UpdateMouseLockAvailability()
        end
    end)
    Players.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function() -- line: 76
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:UpdateMouseLockAvailability()
    end)
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- line: 81
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:UpdateMouseLockAvailability()
    end)
    UserInputService.GamepadConnected:Connect(function() -- line: 86
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:UpdateMouseLockAvailability()
    end)
    UserInputService.GamepadDisconnected:Connect(function() -- line: 89
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:UpdateMouseLockAvailability()
    end)
    t_1:UpdateMouseLockAvailability()

    return t_1
end

function t.GetIsMouseLocked(arg3) -- line: 98
    return arg3.isMouseLocked
end

function t.GetBindableToggleEvent(arg4) -- line: 102
    return arg4.mouseLockToggledEvent.Event
end

function t.GetMouseLockOffset(_) -- line: 106
    -- upvalues:
    --  [1] UserFixCameraOffsetJitter2 (copy)

    if UserFixCameraOffsetJitter2 then
        return Vector3.new(1.75, 0, 0)
    end

    local CameraOffset = script:FindFirstChild("CameraOffset")

    if CameraOffset and CameraOffset:IsA("Vector3Value") then
        return CameraOffset.Value
    end

    if CameraOffset then
        CameraOffset:Destroy()
    end

    local CameraOffset_Vector3Value = Instance.new("Vector3Value")
    assert(CameraOffset_Vector3Value, "")
    CameraOffset_Vector3Value.Name = "CameraOffset"
    CameraOffset_Vector3Value.Value = Vector3.new(1.75, 0, 0)
    CameraOffset_Vector3Value.Parent = script

    if CameraOffset_Vector3Value and CameraOffset_Vector3Value.Value then
        return CameraOffset_Vector3Value.Value
    end

    return Vector3.new(1.75, 0, 0)
end

function t.UpdateMouseLockAvailability(arg6) -- line: 133
    -- upvalues:
    --  [1] Players (copy)
    --  [2] GameSettings (copy)
    --  [3] UserInputService (copy)

    local v5 = Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
    local v6 = GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch
    local v7 = GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    local v8 = Players.LocalPlayer.DevEnableMouseLock and (if v6 then not v7 and not v5 else UserInputService.GamepadEnabled and (not v7 and not v5))

    if v8 ~= arg6.enabled then
        arg6:EnableMouseLock(v8)
    end
end

function t.OnBoundKeysObjectChanged(t1: table, s1: string) -- line: 148
    t1.boundKeys = {}

    for key in string.gmatch(s1, "[^%s,]+") do
        for _, val in pairs(Enum.KeyCode:GetEnumItems()) do
            if key == val.Name then
                t1.boundKeys[#t1.boundKeys + 1] = val
                break
            end
        end
    end

    t1:UnbindContextActions()

    if t1.enabled then
        t1:BindContextActions()
    end
end

function t.OnMouseLockToggled(arg7) -- line: 168
    -- upvalues:
    --  [1] CameraUtils_m (copy)

    arg7.isMouseLocked = not arg7.isMouseLocked

    if arg7.isMouseLocked then
        local CursorImage = script:FindFirstChild("CursorImage")
        local StringValue

        if CursorImage then
            if CursorImage:IsA("StringValue") and CursorImage.Value then
                CameraUtils_m.setMouseIconOverride(CursorImage.Value)
            else
                if CursorImage then
                    CursorImage:Destroy()
                end

                StringValue = Instance.new("StringValue")
                assert(StringValue, "")
                StringValue.Name = "CursorImage"
                StringValue.Value = "rbxasset://textures/MouseLockedCursor.png"
                StringValue.Parent = script
                CameraUtils_m.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png")
            end
        else
            if CursorImage then
                CursorImage:Destroy()
            end

            StringValue = Instance.new("StringValue")
            assert(StringValue, "")
            StringValue.Name = "CursorImage"
            StringValue.Value = "rbxasset://textures/MouseLockedCursor.png"
            StringValue.Parent = script
            CameraUtils_m.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png")
        end
    else
        CameraUtils_m.restoreMouseIcon()
    end

    arg7.mouseLockToggledEvent:Fire()
end

function t.DoMouseLockSwitch(arg8, _, arg10, arg11) -- line: 193
    -- upvalues:
    --  [1] CameraInput_m (copy)

    if arg11 and arg11.KeyCode == Enum.KeyCode.ButtonR3 then
        if arg10 == Enum.UserInputState.Begin then
            arg8.r3PressedAt = os.clock()
        elseif arg10 == Enum.UserInputState.End then
            if not (if arg8.r3PressedAt == nil then false else os.clock() - arg8.r3PressedAt < 0.3) then
                if not CameraInput_m.getGamepadZoomUsed() then
                    arg8:OnMouseLockToggled()
                end
            else
                arg8:OnMouseLockToggled()
            end

            arg8.r3PressedAt = nil
        end

        return Enum.ContextActionResult.Sink
    end

    if arg10 == Enum.UserInputState.Begin then
        arg8:OnMouseLockToggled()

        return Enum.ContextActionResult.Sink
    end

    return Enum.ContextActionResult.Pass
end

function t.BindContextActions(arg12) -- line: 216
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] Value (copy)

    ContextActionService:BindActionAtPriority(
        "MouseLockSwitchAction",
        function(arg13, arg14, arg15) -- line: 217
            -- upvalues:
            --  [1] arg12 (copy)

            return arg12:DoMouseLockSwitch(arg13, arg14, arg15)
        end,
        false,
        Value,
        unpack(arg12.boundKeys)
    )
end

function t.UnbindContextActions(_) -- line: 222
    -- upvalues:
    --  [1] ContextActionService (copy)

    ContextActionService:UnbindAction("MouseLockSwitchAction")
end

function t.IsMouseLocked(arg17) -- line: 226
    return arg17.enabled and arg17.isMouseLocked
end

function t.EnableMouseLock(t2: table, b1: boolean) -- line: 230
    -- upvalues:
    --  [1] CameraUtils_m (copy)

    if b1 ~= t2.enabled then
        t2.enabled = b1

        if t2.enabled then
            t2:BindContextActions()

            return
        end

        CameraUtils_m.restoreMouseIcon()
        t2:UnbindContextActions()

        if t2.isMouseLocked then
            t2.mouseLockToggledEvent:Fire()
        end

        t2.isMouseLocked = false
    end
end

return t
