-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.GamepadLayer
-- Class: ModuleScript
-- bytes: 19024

local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local t = { HOLD_TIME = 0.25 }

if not game:GetService("RunService"):IsClient() then
    return t
end

local t_1 = { L2 = Enum.KeyCode.ButtonL2, R2 = Enum.KeyCode.ButtonR2 }
t.TRIGGER_TAP_TIME = 0.4
local t_2 = {
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonB,
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.ButtonY,
    Enum.KeyCode.ButtonL1,
    Enum.KeyCode.ButtonR1,
    Enum.KeyCode.ButtonL3,
    Enum.KeyCode.ButtonR3,
    Enum.KeyCode.DPadUp,
    Enum.KeyCode.DPadDown,
    Enum.KeyCode.DPadLeft,
    Enum.KeyCode.DPadRight
}
local t_3 = { L2 = {}, R2 = {}, Both = {} }
local t_4 = {}
local t_5 = { L2 = false, R2 = false }
local v1 = nil
local t_6 = {}
local t_7 = { L2 = true, R2 = true }
local t_8 = { L2 = 0, R2 = 0 }
local v2 = nil
local t_9 = {}
local t_10 = {}
local Zero = Vector2.zero
local _ = false
local BindableEvent = Instance.new("BindableEvent")
t.ModifierChanged = BindableEvent.Event
local BindableEvent_1 = Instance.new("BindableEvent")
t.InputModeChanged = BindableEvent_1.Event

local _ = function(arg1) --[[ isEnd ]] -- line: 101
    return arg1 == Enum.UserInputState.End or arg1 == Enum.UserInputState.Cancel
end

local function layerHandler(_, arg3, arg4) -- line: 109
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] v1 (ref)
    --  [3] t_3 (copy)
    --  [4] t_4 (copy)

    local KeyCode = arg4.KeyCode
    local v5

    if arg3 == Enum.UserInputState.Begin then
        t_7.L2 = true
        t_7.R2 = true
        v5 = v1

        if v5 then
            v5 = t_3[v1][KeyCode]
        end

        if not v5 then
            return Enum.ContextActionResult.Pass
        end

        t_4[KeyCode] = { handler = v5 }

        if v5 then
            task.spawn(v5, arg3, arg4)
        end

        return Enum.ContextActionResult.Sink
    else
        v5 = arg3 == Enum.UserInputState.End or arg3 == Enum.UserInputState.Cancel

        if v5 then
            v5 = t_4[KeyCode]

            if not v5 then
                return Enum.ContextActionResult.Pass
            end

            t_4[KeyCode] = nil

            if v5.handler then
                task.spawn(v5.handler, arg3, arg4)
            end

            return Enum.ContextActionResult.Sink
        else
            if t_4[KeyCode] then
                return Enum.ContextActionResult.Sink
            end

            return Enum.ContextActionResult.Pass
        end
    end
end

local function updateLayer() -- line: 152
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] v1 (ref)
    --  [3] ContextActionService (copy)
    --  [4] layerHandler (copy)
    --  [5] t_2 (copy)
    --  [6] t_4 (copy)
    --  [7] BindableEvent (copy)

    local v6 = nil
    v6 = if not t_5.L2 then if not t_5.L2 then if not t_5.R2 then v6 else "R2" else "L2" else if not t_5.R2 then if not t_5.L2 then if not t_5.R2 then v6 else "R2" else "L2" else "Both"

    if v6 == v1 then
        return
    end

    local v7 = v1 ~= nil
    v1 = v6

    if v6 and not v7 then
        ContextActionService:BindActionAtPriority(
            "GamepadLayer",
            layerHandler,
            false,
            2600,
            table.unpack(t_2)
        )
    elseif not v6 then
        ContextActionService:UnbindAction("GamepadLayer")

        for key, val in t_4 do
            t_4[key] = nil

            if val.handler then
                task.spawn(val.handler, Enum.UserInputState.End, nil)
            end
        end
    end

    BindableEvent:Fire(v6)
end

local function bindModifiers() -- line: 192
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] ContextActionService (copy)
    --  [3] t_5 (copy)
    --  [4] t_8 (copy)
    --  [5] t_7 (copy)
    --  [6] updateLayer (copy)
    --  [7] t_6 (copy)
    --  [8] t (copy)

    for key_1, val_1 in t_1 do
        ContextActionService:BindActionAtPriority(
            "GamepadModifier_" .. key_1,
            function(_, arg6) -- line: 194
                -- upvalues:
                --  [1] key_1 (copy)
                --  [2] t_5 (ref)
                --  [3] t_8 (ref)
                --  [4] t_7 (ref)
                --  [5] updateLayer (ref)
                --  [6] t_6 (ref)
                --  [7] t (ref)

                local v11 = if key_1 ~= "L2" then "L2" else "R2"

                if arg6 == Enum.UserInputState.Begin then
                    t_5[key_1] = true
                    t_8[key_1] = os.clock()
                    t_7[key_1] = false

                    if t_5[v11] then
                        t_7[key_1] = true
                        t_7[v11] = true
                    end

                    updateLayer()
                elseif arg6 == Enum.UserInputState.End or arg6 == Enum.UserInputState.Cancel then
                    local v15 = t_5[key_1]
                    t_5[key_1] = false
                    updateLayer()
                    local v16 = t_6[key_1]

                    if v15 and v16 and arg6 == Enum.UserInputState.End and not t_7[key_1] then
                        if os.clock() - t_8[key_1] <= t.TRIGGER_TAP_TIME then
                            task.spawn(function() -- line: 220
                                -- upvalues:
                                --  [1] v16 (copy)

                                v16(Enum.UserInputState.Begin, nil)
                                v16(Enum.UserInputState.End, nil)
                            end)
                        end
                    end

                    t_7[key_1] = true
                end

                return Enum.ContextActionResult.Pass
            end,
            false,
            2500,
            val_1
        )
    end
end

local function onFocusReleased() -- line: 234
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] t_7 (copy)
    --  [3] updateLayer (copy)

    t_5.L2 = false
    t_5.R2 = false
    t_7.L2 = true
    t_7.R2 = true
    updateLayer()
end

function t.setTriggerTap(s1: string, arg7: any) -- line: 245
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] v2 (ref)

    t_6[s1] = arg7
    v2()
end

function t.getTriggerTap(s2: string) -- line: 250
    -- upvalues:
    --  [1] t_6 (copy)

    return t_6[s2]
end

function t.isChorded(arg8) -- line: 256
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] t_3 (copy)

    return if v1 == nil then false else t_3[v1][arg8] ~= nil
end

function t.isModifierHeld(s3: string?) -- line: 262
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] v1 (ref)

    return if not s3 then v1 ~= nil else t_5[s3] == true
end

function t.getLayer() -- line: 270
    -- upvalues:
    --  [1] v1 (ref)

    return v1
end

function t.setChord(s4: string, arg9: any, arg10: any) -- line: 277
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] v2 (ref)

    t_3[s4][arg9] = arg10
    v2()
end

function t.getChord(s5: string, arg11: any) -- line: 283
    -- upvalues:
    --  [1] t_3 (copy)

    return t_3[s5] and t_3[s5][arg11]
end

local _ = function(arg12, arg13) --[[ bindButton ]] -- line: 291
    -- upvalues:
    --  [1] ContextActionService (copy)

    ContextActionService:BindActionAtPriority(
        "GamepadButton_" .. arg12.Name,
        function(_, arg15) -- line: 292
            -- upvalues:
            --  [1] arg13 (copy)

            if arg15 == Enum.UserInputState.Begin then
                arg13.down = true

                if arg13.beginFn then
                    task.spawn(arg13.beginFn)
                end
            elseif (arg15 == Enum.UserInputState.End or arg15 == Enum.UserInputState.Cancel) and arg13.down then
                arg13.down = false

                if arg13.endFn then
                    task.spawn(arg13.endFn)
                end
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        20,
        arg12
    )
end

function t.setButton(arg16, arg17, arg18) -- line: 310
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] v2 (ref)

    local v21 = t_9[arg16]

    if not v21 then
        v21 = { down = false }
        t_9[arg16] = v21
    end

    v21.beginFn = arg17
    v21.endFn = arg18
    v2()
end

local _ = function(arg19, arg20) --[[ bindTapHold ]] -- line: 327
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] t (copy)

    ContextActionService:BindActionAtPriority(
        "GamepadTapHold_" .. arg19.Name,
        function(_, arg22) -- line: 328
            -- upvalues:
            --  [1] arg20 (copy)
            --  [2] t (ref)

            if arg22 == Enum.UserInputState.Begin then
                local v23 = arg20
                v23.token += 1
                local Token = arg20.token

                if not arg20.holdBegin then
                    arg20.pressed = false

                    if arg20.tap then
                        task.spawn(arg20.tap)
                    end

                    return Enum.ContextActionResult.Sink
                end

                arg20.pressed = true
                arg20.holding = false
                task.delay(t.HOLD_TIME, function() -- line: 345
                    -- upvalues:
                    --  [1] arg20 (ref)
                    --  [2] Token (copy)

                    if arg20.token == Token and arg20.pressed then
                        arg20.holding = true

                        if arg20.holdBegin then
                            task.spawn(arg20.holdBegin)
                        end
                    end
                end)
            elseif arg22 == Enum.UserInputState.End or arg22 == Enum.UserInputState.Cancel then
                if not arg20.pressed then
                    return Enum.ContextActionResult.Sink
                end

                arg20.pressed = false

                if arg20.holding then
                    arg20.holding = false

                    if arg20.holdEnd then
                        task.spawn(arg20.holdEnd)
                    end
                elseif arg22 == Enum.UserInputState.End and arg20.tap then
                    task.spawn(arg20.tap)
                end
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        20,
        arg19
    )
end

local _ = function(arg23) --[[ getTapHold ]] -- line: 374
    -- upvalues:
    --  [1] t_10 (copy)

    local v26 = t_10[arg23]

    if not v26 then
        v26 = {
            tap = nil,
            holdBegin = nil,
            holdEnd = nil,
            pressed = false,
            holding = false,
            token = 0
        }
        t_10[arg23] = v26
    end

    return v26
end

function t.setTap(arg24, arg25) -- line: 391
    -- upvalues:
    --  [1] t_10 (copy)
    --  [2] v2 (ref)

    local v27 = t_10[arg24]

    if not v27 then
        v27 = {
            tap = nil,
            holdBegin = nil,
            holdEnd = nil,
            pressed = false,
            holding = false,
            token = 0
        }
        t_10[arg24] = v27
    end

    v27.tap = arg25
    v2()
end

function t.setHold(arg26, arg27, arg28) -- line: 397
    -- upvalues:
    --  [1] t_10 (copy)
    --  [2] v2 (ref)

    local v28 = t_10[arg26]

    if not v28 then
        v28 = {
            tap = nil,
            holdBegin = nil,
            holdEnd = nil,
            pressed = false,
            holding = false,
            token = 0
        }
        t_10[arg26] = v28
    end

    v28.holdBegin = arg27
    v28.holdEnd = arg28
    v2()
end

function t.beginStickCapture() -- line: 409
    -- upvalues:
    --  [1] Zero (ref)
    --  [2] ContextActionService (copy)

    Zero = Vector2.zero
    ContextActionService:BindActionAtPriority(
        "GamepadStickCapture",
        function(_, arg30, arg31) -- line: 412
            -- upvalues:
            --  [1] Zero (ref)

            if arg30 == Enum.UserInputState.End or arg30 == Enum.UserInputState.Cancel then
                Zero = Vector2.zero
            else
                Zero = Vector2.new(arg31.Position.X, arg31.Position.Y)
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        2600,
        Enum.KeyCode.Thumbstick2
    )
end

function t.endStickCapture() -- line: 422
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] Zero (ref)

    ContextActionService:UnbindAction("GamepadStickCapture")
    Zero = Vector2.zero
end

function t.getStick() -- line: 428
    -- upvalues:
    --  [1] Zero (ref)

    return Zero
end

local function classify(arg32) -- line: 437
    local Name = arg32.Name

    return if not string.find(Name, "Gamepad", 1, true) then if arg32 == Enum.UserInputType.Keyboard then false else if arg32 == Enum.UserInputType.Touch then false else if not string.find(
        Name,
        "Mouse",
        1,
        true
    ) then nil else false else true
end

local v30 = true

if classify(UserInputService:GetLastInputType()) ~= true then
    v30 = UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled
end

local v31 = v30

local function onLastInputTypeChanged(arg33) -- line: 458
    -- upvalues:
    --  [1] classify (copy)
    --  [2] v31 (ref)
    --  [3] BindableEvent_1 (copy)

    local v32 = classify(arg33)

    if v32 == nil or v32 == v31 then
        return
    end

    v31 = v32
    BindableEvent_1:Fire(v32)
end

function t.isGamepadActive() -- line: 469
    -- upvalues:
    --  [1] v31 (ref)

    return v31
end

function t.getGlyph(arg34) -- line: 474
    -- upvalues:
    --  [1] UserInputService (copy)

    return UserInputService:GetImageForKeyCode(arg34)
end

local t_12 = {}

local _ = function(arg35, arg36, arg37) --[[ ensureConnection ]] -- line: 484
    -- upvalues:
    --  [1] t_12 (copy)

    local v33 = t_12[arg35]

    if v33 and v33.Connected then
        return
    end

    t_12[arg35] = arg36:Connect(arg37)
end

local function flush() -- line: 494
    -- upvalues:
    --  [1] bindModifiers (copy)
    --  [2] t_9 (copy)
    --  [3] ContextActionService (copy)
    --  [4] t_10 (copy)
    --  [5] t (copy)
    --  [6] v1 (ref)
    --  [7] layerHandler (copy)
    --  [8] t_2 (copy)
    --  [9] UserInputService (copy)
    --  [10] onLastInputTypeChanged (copy)
    --  [11] t_12 (copy)
    --  [12] onFocusReleased (copy)

    bindModifiers()

    for key_2, val_2 in t_9 do
        ContextActionService:BindActionAtPriority(
            "GamepadButton_" .. key_2.Name,
            function(_, arg39) -- line: 292
                -- upvalues:
                --  [1] val_2 (copy)

                if arg39 == Enum.UserInputState.Begin then
                    val_2.down = true

                    if val_2.beginFn then
                        task.spawn(val_2.beginFn)
                    end
                elseif (arg39 == Enum.UserInputState.End or arg39 == Enum.UserInputState.Cancel) and val_2.down then
                    val_2.down = false

                    if val_2.endFn then
                        task.spawn(val_2.endFn)
                    end
                end

                return Enum.ContextActionResult.Sink
            end,
            false,
            20,
            key_2
        )
    end

    for key_3, val_3 in t_10 do
        ContextActionService:BindActionAtPriority(
            "GamepadTapHold_" .. key_3.Name,
            function(_, arg41) -- line: 328
                -- upvalues:
                --  [1] val_3 (copy)
                --  [2] t (ref)

                if arg41 == Enum.UserInputState.Begin then
                    local v38 = val_3
                    v38.token += 1
                    local Token_1 = val_3.token

                    if not val_3.holdBegin then
                        val_3.pressed = false

                        if val_3.tap then
                            task.spawn(val_3.tap)
                        end

                        return Enum.ContextActionResult.Sink
                    end

                    val_3.pressed = true
                    val_3.holding = false
                    task.delay(t.HOLD_TIME, function() -- line: 345
                        -- upvalues:
                        --  [1] val_3 (ref)
                        --  [2] Token_1 (copy)

                        if val_3.token == Token_1 and val_3.pressed then
                            val_3.holding = true

                            if val_3.holdBegin then
                                task.spawn(val_3.holdBegin)
                            end
                        end
                    end)
                elseif arg41 == Enum.UserInputState.End or arg41 == Enum.UserInputState.Cancel then
                    if not val_3.pressed then
                        return Enum.ContextActionResult.Sink
                    end

                    val_3.pressed = false

                    if val_3.holding then
                        val_3.holding = false

                        if val_3.holdEnd then
                            task.spawn(val_3.holdEnd)
                        end
                    elseif arg41 == Enum.UserInputState.End and val_3.tap then
                        task.spawn(val_3.tap)
                    end
                end

                return Enum.ContextActionResult.Sink
            end,
            false,
            20,
            key_3
        )
    end

    if v1 then
        ContextActionService:BindActionAtPriority(
            "GamepadLayer",
            layerHandler,
            false,
            2600,
            table.unpack(t_2)
        )
    end

    local LastInputTypeChanged = t_12.LastInputTypeChanged

    if not (LastInputTypeChanged and LastInputTypeChanged.Connected) then
        t_12.LastInputTypeChanged = UserInputService.LastInputTypeChanged:Connect(
            onLastInputTypeChanged
        )
    end

    local WindowFocusReleased = t_12.WindowFocusReleased

    if WindowFocusReleased and WindowFocusReleased.Connected then
        return
    end

    t_12.WindowFocusReleased = UserInputService.WindowFocusReleased:Connect(onFocusReleased)
end

local BindableEvent_2 = Instance.new("BindableEvent")
local v47 = false
local v48 = false

function v2() --[[ requestBind ]] -- line: 518
    -- upvalues:
    --  [1] v48 (ref)
    --  [2] v47 (ref)
    --  [3] BindableEvent_2 (copy)
    --  [4] flush (copy)

    if v48 then
        return
    end

    v48 = true

    if v47 then
        BindableEvent_2:Fire()

        return
    end

    task.defer(function() -- line: 527
        -- upvalues:
        --  [1] v48 (ref)
        --  [2] flush (ref)

        v48 = false
        flush()
    end)
end

function t._attachHost() -- line: 536
    -- upvalues:
    --  [1] v47 (ref)
    --  [2] BindableEvent_2 (copy)
    --  [3] v48 (ref)
    --  [4] flush (copy)

    if v47 then
        return
    end

    v47 = true
    BindableEvent_2.Event:Connect(function() -- line: 542
        -- upvalues:
        --  [1] v48 (ref)
        --  [2] flush (ref)

        v48 = false
        flush()
    end)
    flush()
end

v2()

return t
