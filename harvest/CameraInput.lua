-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.CameraInput
-- Class: ModuleScript
-- bytes: 17405

local v6, v7
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local VRService = game:GetService("VRService")
local UserCameraInputDt = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
).getUserFlag("UserCameraInputDt")
local Value = Enum.ContextActionPriority.Medium.Value
local LocalPlayer = Players.LocalPlayer
local v1 = Vector2.new(1, 0.77) * 0.06981317007977318
local v2 = Vector2.new(1, 0.77) * 0.008726646259971648
local v3 = Vector2.new(1, 0.77) * 0.12217304763960307
local v4 = Vector2.new(1, 0.66) * 0.017453292519943295

if UserCameraInputDt then
    v1 *= 60
end

local Success, Result = pcall(function() -- line: 48
    return UserSettings():IsUserFeatureEnabled("UserResetTouchStateOnMenuOpen")
end)
local v5 = Success and Result
local g_pcall = pcall
g_pcall, v6 = g_pcall(function() -- line: 56
    return UserSettings():IsUserFeatureEnabled("UserClearPanOnCameraDisable")
end)
local g_pcall_1 = pcall
g_pcall_1, v7 = g_pcall_1(function() -- line: 64
    return UserSettings():IsUserFeatureEnabled("UserFixGamepadSensitivity")
end)
local BindableEvent = Instance.new("BindableEvent")
local BindableEvent_1 = Instance.new("BindableEvent")
local Event = BindableEvent.Event
local Event_1 = BindableEvent_1.Event
UserInputService.InputBegan:Connect(function(input_2, gameProcessedEvent) -- line: 78
    -- upvalues:
    --  [1] BindableEvent (copy)

    if not gameProcessedEvent and input_2.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire()
    end
end)
UserInputService.InputEnded:Connect(function(arg3, _) -- line: 84
    -- upvalues:
    --  [1] BindableEvent_1 (copy)

    if arg3.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent_1:Fire()
    end
end)

local function thumbstickCurve(arg5) -- line: 95
    local v8 = (math.exp((math.abs(arg5) - 0.1) / 0.9 * 2) - 1) / 6.38905609893065

    return math.sign(arg5) * math.clamp(v8, 0, 1)
end

local function adjustTouchPitchSensitivity(u1: Vector2) -- line: 109
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return u1
    end

    local v10 = CurrentCamera.CFrame:ToEulerAnglesYXZ()

    if u1.Y * v10 >= 0 then
        return u1
    end

    return Vector2.new(1, (1 - (math.abs(v10) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25) * u1
end

local function isInDynamicThumbstickArea(vec1: Vector3) -- line: 135
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local v11 = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local v12 = v11

    if v12 then
        v12 = v11:FindFirstChild("TouchGui")
    end

    v11 = v12

    if v11 then
        v11 = v12:FindFirstChild("TouchControlFrame")
    end

    local v13 = v11

    if v13 then
        v13 = v11:FindFirstChild("DynamicThumbstickFrame")
    end

    return if v13 then if v12.Enabled then vec1.X >= v13.AbsolutePosition.X and (vec1.Y >= v13.AbsolutePosition.Y and (vec1.X <= (v13.AbsolutePosition + v13.AbsoluteSize).X and vec1.Y <= (v13.AbsolutePosition + v13.AbsoluteSize).Y)) else false else false
end

local v14 = 0.016666666666666666
RunService.Stepped:Connect(function(_, arg7) -- line: 160
    -- upvalues:
    --  [1] v14 (ref)

    v14 = arg7
end)
local t = {}
local t_1 = {}
local v15 = 0

local _ = function() --[[ incPanInputCount ]] -- line: 170
    -- upvalues:
    --  [1] v15 (ref)

    v15 = math.max(0, v15 + 1)
end

local _ = function() --[[ decPanInputCount ]] -- line: 174
    -- upvalues:
    --  [1] v15 (ref)

    v15 = math.max(0, v15 - 1)
end

local _ = function() --[[ resetPanInputCount ]] -- line: 178
    -- upvalues:
    --  [1] v15 (ref)

    v15 = 0
end

local t_2 = { Thumbstick2 = Vector2.new() }
local t_3 = { Left = 0, Right = 0, I = 0, O = 0 }
local t_4 = { Movement = Vector2.new(), Wheel = 0, Pan = Vector2.new(), Pinch = 0 }
local t_5 = { Move = Vector2.new(), Pinch = 0 }
local t_6 = { Held = false, Used = false }
local BindableEvent_2 = Instance.new("BindableEvent")
t.gamepadZoomPress = BindableEvent_2.Event
local v16 = VRService.VREnabled and Instance.new("BindableEvent") or nil

if VRService.VREnabled then
    t.gamepadReset = v16.Event
end

function t.getRotationActivated() -- line: 217
    -- upvalues:
    --  [1] v15 (ref)
    --  [2] t_2 (copy)

    return v15 > 0 or t_2.Thumbstick2.Magnitude > 0
end

local v18 = g_pcall_1 and v7

function t.getRotation(arg8: any, b1: boolean?) -- line: 221
    -- upvalues:
    --  [1] UserGameSettings (copy)
    --  [2] UserCameraInputDt (copy)
    --  [3] t_3 (copy)
    --  [4] v14 (ref)
    --  [5] v18 (ref)
    --  [6] t_2 (copy)
    --  [7] t_6 (copy)
    --  [8] t_4 (copy)
    --  [9] adjustTouchPitchSensitivity (copy)
    --  [10] t_5 (copy)
    --  [11] v1 (ref)
    --  [12] v2 (copy)
    --  [13] v3 (copy)
    --  [14] v4 (copy)

    local vec2 = Vector2.new(1, UserGameSettings:GetCameraYInvertValue())
    local v20 = if UserCameraInputDt then Vector2.new(t_3.Right - t_3.Left, 0) * arg8 else Vector2.new(
        t_3.Right - t_3.Left,
        0
    ) * v14
    local v21 = if not v18 then t_2.Thumbstick2 else t_2.Thumbstick2 * UserGameSettings.GamepadCameraSensitivity

    if UserCameraInputDt then
        v21 *= arg8
    end

    if t_6.Held then
        v21 = Vector2.zero
    end

    local Movement = t_4.Movement
    local Pan = t_4.Pan
    local v22 = adjustTouchPitchSensitivity(t_5.Move)

    if b1 then
        v20 = Vector2.new()
    end

    return (v20 * 2.0943951023931953 + v21 * v1 + Movement * v2 + Pan * v3 + v22 * v4) * vec2
end

function t.getZoomDelta() -- line: 265
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t_4 (copy)
    --  [3] t_5 (copy)
    --  [4] t_6 (copy)
    --  [5] t_2 (copy)

    local v23 = t_3.O - t_3.I
    local v24 = -t_4.Wheel + t_4.Pinch
    local v25 = -t_5.Pinch
    local v26 = 0

    if t_6.Held and math.abs(t_2.Thumbstick2.Y) > 0.2 then
        v26 = t_2.Thumbstick2.Y
        t_6.Used = true
    end

    return v23 * 0.1 + v24 * 1 + v25 * 0.04 + v26 * 0.15
end

function t.getGamepadZoomUsed() -- line: 281
    -- upvalues:
    --  [1] t_6 (copy)

    return t_6.Used
end

local function thumbstick(_, _, arg11) -- line: 286
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] thumbstickCurve (ref)

    local Position = arg11.Position
    t_2[arg11.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y))

    return Enum.ContextActionResult.Pass
end

local _ = function(arg12) --[[ mouseMovement ]] -- line: 292
    -- upvalues:
    --  [1] t_4 (copy)

    local Delta = arg12.Delta
    t_4.Movement = Vector2.new(Delta.X, Delta.Y)
end

local _ = function(_, _, arg15) --[[ mouseWheel ]] -- line: 297
    -- upvalues:
    --  [1] t_4 (copy)

    t_4.Wheel = arg15.Position.Z

    return Enum.ContextActionResult.Pass
end

local function keypress(_, arg17, arg18) -- line: 302
    -- upvalues:
    --  [1] t_3 (copy)

    t_3[arg18.KeyCode.Name] = if arg17 ~= Enum.UserInputState.Begin then 0 else 1
end

local _ = function(_, arg20, _) --[[ gamepadZoomPress ]] -- line: 306
    -- upvalues:
    --  [1] BindableEvent_2 (copy)

    if arg20 == Enum.UserInputState.Begin then
        BindableEvent_2:Fire()
    end
end

local function gamepadReset(_, arg23, _) -- line: 312
    -- upvalues:
    --  [1] v16 (copy)

    if arg23 == Enum.UserInputState.Begin then
        v16:Fire()
    end
end

local v31 = g_pcall and v6

local function resetInputDevices() -- line: 318
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t_3 (copy)
    --  [3] t_4 (copy)
    --  [4] t_5 (copy)
    --  [5] t_6 (copy)
    --  [6] v31 (ref)
    --  [7] v15 (ref)

    for _, val in pairs({ t_2, t_3, t_4, t_5, t_6 }) do
        for key_1, val_1 in pairs(val) do
            if type(val_1) == "boolean" then
                val[key_1] = false
            else
                val[key_1] *= 0
            end
        end
    end

    if v31 then
        v15 = 0
    end
end

local t_7 = {}
local v32 = nil
local v33 = nil

local function touchBegan(u2: userdata, b2: boolean) -- line: 347
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] isInDynamicThumbstickArea (copy)
    --  [3] v15 (ref)
    --  [4] t_7 (ref)

    assert(u2.UserInputType == Enum.UserInputType.Touch)
    assert(if u2.UserInputState ~= Enum.UserInputState.Begin then false else true)

    if v32 == nil and (isInDynamicThumbstickArea(u2.Position) and not b2) then
        v32 = u2

        return
    end

    if not b2 then
        v15 = math.max(0, v15 + 1)
    end

    t_7[u2] = b2
end

local function touchEnded(u3: userdata, _: boolean) -- line: 367
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] t_7 (ref)
    --  [3] v33 (ref)
    --  [4] v15 (ref)

    assert(u3.UserInputType == Enum.UserInputType.Touch)
    assert(if u3.UserInputState ~= Enum.UserInputState.End then false else true)

    if u3 == v32 then
        v32 = nil
    end

    if t_7[u3] == false then
        v33 = nil
        v15 = math.max(0, v15 - 1)
    end

    t_7[u3] = nil
end

local function touchChanged(arg25, arg26) -- line: 386
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] t_7 (ref)
    --  [3] t_5 (copy)
    --  [4] v33 (ref)

    assert(arg25.UserInputType == Enum.UserInputType.Touch)
    assert(if arg25.UserInputState ~= Enum.UserInputState.Change then false else true)

    if arg25 == v32 then
        return
    end

    if t_7[arg25] == nil then
        t_7[arg25] = arg26
    end

    local t_8 = {}

    for key_2, val_2 in pairs(t_7) do
        if not val_2 then
            table.insert(t_8, key_2)
        end
    end

    if #t_8 == 1 and t_7[arg25] == false then
        local Delta_1 = arg25.Delta
        local v37 = t_5
        v37.Move = v37.Move + Vector2.new(Delta_1.X, Delta_1.Y)
    end

    if #t_8 == 2 then
        local Magnitude = (t_8[1].Position - t_8[2].Position).Magnitude

        if v33 then
            local v38 = t_5
            v38.Pinch += Magnitude - v33
        end

        v33 = Magnitude

        return
    end

    v33 = nil
end

local function resetTouchState() -- line: 430
    -- upvalues:
    --  [1] t_7 (ref)
    --  [2] v32 (ref)
    --  [3] v33 (ref)
    --  [4] v5 (ref)
    --  [5] v15 (ref)

    t_7 = {}
    v32 = nil
    v33 = nil

    if v5 then
        v15 = 0
    end
end

local function pointerAction(arg27, arg28, arg29, arg30) -- line: 440
    -- upvalues:
    --  [1] t_4 (copy)

    if not arg30 then
        t_4.Wheel = arg27
        t_4.Pan = arg28
        t_4.Pinch = -arg29
    end
end

local function inputBegan(arg31, arg32) -- line: 448
    -- upvalues:
    --  [1] touchBegan (ref)
    --  [2] v15 (ref)

    if arg31.UserInputType == Enum.UserInputType.Touch then
        touchBegan(arg31, arg32)

        return
    end

    if arg31.UserInputType == Enum.UserInputType.MouseButton2 and not arg32 then
        v15 = math.max(0, v15 + 1)
    end
end

local function inputChanged(arg33, arg34) -- line: 457
    -- upvalues:
    --  [1] touchChanged (ref)
    --  [2] t_4 (copy)

    if arg33.UserInputType == Enum.UserInputType.Touch then
        touchChanged(arg33, arg34)

        return
    end

    if arg33.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta_2 = arg33.Delta
        t_4.Movement = Vector2.new(Delta_2.X, Delta_2.Y)
    end
end

local function inputEnded(arg35, arg36) -- line: 466
    -- upvalues:
    --  [1] touchEnded (ref)
    --  [2] v15 (ref)

    if arg35.UserInputType == Enum.UserInputType.Touch then
        touchEnded(arg35, arg36)

        return
    end

    if arg35.UserInputType == Enum.UserInputType.MouseButton2 then
        v15 = math.max(0, v15 - 1)
    end
end

local v40 = false

function t.setInputEnabled(arg37) -- line: 477
    -- upvalues:
    --  [1] v40 (ref)
    --  [2] resetInputDevices (copy)
    --  [3] resetTouchState (ref)
    --  [4] ContextActionService (copy)
    --  [5] thumbstick (copy)
    --  [6] Value (copy)
    --  [7] keypress (copy)
    --  [8] VRService (copy)
    --  [9] gamepadReset (copy)
    --  [10] t_1 (ref)
    --  [11] UserInputService (copy)
    --  [12] t_6 (copy)
    --  [13] inputBegan (copy)
    --  [14] inputChanged (copy)
    --  [15] inputEnded (copy)
    --  [16] pointerAction (copy)
    --  [17] v5 (ref)

    if v40 == arg37 then
        return
    end

    v40 = arg37
    resetInputDevices()
    resetTouchState()

    if v40 then
        ContextActionService:BindActionAtPriority(
            "RbxCameraThumbstick",
            thumbstick,
            false,
            Value,
            Enum.KeyCode.Thumbstick2
        )
        ContextActionService:BindActionAtPriority(
            "RbxCameraKeypress",
            keypress,
            false,
            Value,
            Enum.KeyCode.Left,
            Enum.KeyCode.Right,
            Enum.KeyCode.I,
            Enum.KeyCode.O
        )

        if VRService.VREnabled then
            ContextActionService:BindAction(
                "RbxCameraGamepadReset",
                gamepadReset,
                false,
                Enum.KeyCode.ButtonL3
            )
        end

        table.insert(t_1, UserInputService.InputBegan:Connect(function(input) -- line: 524
            -- upvalues:
            --  [1] t_6 (ref)

            if input.KeyCode == Enum.KeyCode.ButtonR3 then
                t_6.Held = true
                t_6.Used = false
            end
        end))
        table.insert(t_1, UserInputService.InputEnded:Connect(function(input_1) -- line: 530
            -- upvalues:
            --  [1] t_6 (ref)

            if input_1.KeyCode == Enum.KeyCode.ButtonR3 then
                t_6.Held = false
            end
        end))
        table.insert(t_1, UserInputService.InputBegan:Connect(inputBegan))
        table.insert(t_1, UserInputService.InputChanged:Connect(inputChanged))
        table.insert(t_1, UserInputService.InputEnded:Connect(inputEnded))
        table.insert(t_1, UserInputService.PointerAction:Connect(pointerAction))

        if v5 then
            table.insert(t_1, game:GetService("GuiService").MenuOpened:connect(resetTouchState))

            return
        end
    else
        ContextActionService:UnbindAction("RbxCameraThumbstick")
        ContextActionService:UnbindAction("RbxCameraMouseMove")
        ContextActionService:UnbindAction("RbxCameraMouseWheel")
        ContextActionService:UnbindAction("RbxCameraKeypress")
        ContextActionService:UnbindAction("RbxCameraGamepadZoom")

        if VRService.VREnabled then
            ContextActionService:UnbindAction("RbxCameraGamepadReset")
        end

        for _, val_3 in pairs(t_1) do
            val_3:Disconnect()
        end

        t_1 = {}
    end
end

function t.getInputEnabled() -- line: 563
    -- upvalues:
    --  [1] v40 (ref)

    return v40
end

function t.resetInputForFrameEnd() -- line: 567
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] t_5 (copy)

    t_4.Movement = Vector2.new()
    t_5.Move = Vector2.new()
    t_5.Pinch = 0
    t_4.Wheel = 0
    t_4.Pan = Vector2.new()
    t_4.Pinch = 0
end

UserInputService.WindowFocused:Connect(resetInputDevices)
UserInputService.WindowFocusReleased:Connect(resetInputDevices)
local v51 = false
local v52 = false
local v53 = 0

function t.getHoldPan() -- line: 588
    -- upvalues:
    --  [1] v51 (ref)

    return v51
end

function t.getTogglePan() -- line: 592
    -- upvalues:
    --  [1] v52 (ref)

    return v52
end

function t.getPanning() -- line: 596
    -- upvalues:
    --  [1] v52 (ref)
    --  [2] v51 (ref)

    return v52 or v51
end

function t.setTogglePan(b4: boolean) -- line: 600
    -- upvalues:
    --  [1] v52 (ref)

    v52 = b4
end

local v55 = false
local v56 = nil
local v57 = nil

function t.enableCameraToggleInput() -- line: 608
    -- upvalues:
    --  [1] v55 (ref)
    --  [2] v51 (ref)
    --  [3] v52 (ref)
    --  [4] v56 (ref)
    --  [5] v57 (ref)
    --  [6] Event (ref)
    --  [7] v53 (ref)
    --  [8] Event_1 (ref)
    --  [9] UserInputService (copy)

    if v55 then
        return
    end

    v55 = true
    v51 = false
    v52 = false

    if v56 then
        v56:Disconnect()
    end

    if v57 then
        v57:Disconnect()
    end

    v56 = Event:Connect(function() -- line: 625
        -- upvalues:
        --  [1] v51 (ref)
        --  [2] v53 (ref)

        v51 = true
        v53 = tick()
    end)
    v57 = Event_1:Connect(function() -- line: 630
        -- upvalues:
        --  [1] v51 (ref)
        --  [2] v53 (ref)
        --  [3] v52 (ref)
        --  [4] UserInputService (ref)

        v51 = false

        if tick() - v53 < 0.3 then
            if not v52 then
                if UserInputService:GetMouseDelta().Magnitude < 2 then
                    v52 = not v52
                end
            else
                v52 = not v52
            end
        end
    end)
end

function t.disableCameraToggleInput() -- line: 638
    -- upvalues:
    --  [1] v55 (ref)
    --  [2] v56 (ref)
    --  [3] v57 (ref)

    if not v55 then
        return
    end

    v55 = false

    if v56 then
        v56:Disconnect()
        v56 = nil
    end

    if v57 then
        v57:Disconnect()
        v57 = nil
    end
end

return t
