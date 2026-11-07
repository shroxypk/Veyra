-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Slider
-- Class: ModuleScript
-- bytes: 11301

local t = { Sliders = {} }
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
assert(RunService:IsClient(), "Slider module can only be used on the Client!")
local Utils = script.Utils
local Signal_m = require(Utils.Signal)
local SliderFuncs_m = require(Utils.SliderFuncs)

function t.__index(arg1, arg2) -- line: 28
    -- upvalues:
    --  [1] t (copy)

    for _, val in ipairs({ { ".OnChange", ".Changed", (rawget(arg1, "Changed")) } }) do
        if string.sub(val[1], 2) == arg2 then
            warn(string.format("%s is deprecated, please use %s instead", val[1], val[2]))

            return val[3]
        end
    end

    return t[arg2]
end

function t.new(u1: userdata, t1: table) -- line: 54
    -- upvalues:
    --  [1] t (copy)
    --  [2] SliderFuncs_m (copy)
    --  [3] Signal_m (copy)

    assert(pcall(function() -- line: 55
        -- upvalues:
        --  [1] u1 (copy)

        return u1.AbsoluteSize, u1.AbsolutePosition
    end), "Holder argument does not have an AbsoluteSize/AbsolutePosition")
    local v2 = false

    for _, val_1 in ipairs(t.Sliders) do
        if val_1._holder == u1 then
            v2 = true
            break
        end
    end

    assert(not v2, "Cannot set two sliders with same frame!")
    assert(
        if t1.SliderData.Increment == nil then false else true,
        "Failed to find Increment in SliderData table"
    )
    assert(
        if t1.SliderData.Start == nil then false else true,
        "Failed to find Start in SliderData table"
    )
    assert(
        if t1.SliderData.End == nil then false else true,
        "Failed to find End in SliderData table"
    )
    assert(
        if not (t1.SliderData.Increment > 0) then false else true,
        "SliderData.Increment must be greater than 0"
    )
    assert(
        if not (t1.SliderData.End > t1.SliderData.Start) then false else true,
        string.format(
            "Slider end value must be greater than its start value! (%.1f <= %.1f)",
            t1.SliderData.End,
            t1.SliderData.Start
        )
    )
    v2 = setmetatable({}, t)
    v2._holder = u1
    local t_3 = {
        Button = nil,
        HolderButton = nil,
        _clickOverride = false,
        _mainConnection = nil,
        _clickConnections = {},
        _otherConnections = {},
        _inputPos = nil,
        _percent = 0,
        _value = 0,
        _scaleIncrement = 0,
        _currentTween = nil,
        _allowBackgroundClick = if t1.AllowBackgroundClick == false then false else true
    }
    v2._data = t_3
    v2._config = t1
    v2._config.Axis = string.upper(t1.Axis or "X")
    v2._config.Padding = t1.Padding or -1
    local v5 = t1.MoveInfo or TweenInfo.new(0.2)
    v2._config.MoveInfo = v5
    v2._config.MoveType = t1.MoveType or "Tween"
    v2.IsHeld = false
    local Slider = u1:FindFirstChild("Slider")
    assert(if Slider == nil then false else true, "Failed to find slider button.")
    assert(Slider:IsA("GuiButton"), "Slider is not a GuiButton")
    v2._data.Button = Slider

    if v2._data._allowBackgroundClick then
        local HolderClickButton_TextButton = Instance.new("TextButton")
        HolderClickButton_TextButton.BackgroundTransparency = 1
        HolderClickButton_TextButton.Text = ""
        HolderClickButton_TextButton.Name = "HolderClickButton"
        HolderClickButton_TextButton.Size = UDim2.fromScale(1, 1)
        HolderClickButton_TextButton.ZIndex = -1
        HolderClickButton_TextButton.Parent = v2._holder
        v2._data.HolderButton = HolderClickButton_TextButton
    end

    v2._data._percent = 0

    if t1.SliderData.DefaultValue then
        t1.SliderData.DefaultValue = math.clamp(
            t1.SliderData.DefaultValue,
            t1.SliderData.Start,
            t1.SliderData.End
        )
        v2._data._percent = SliderFuncs_m.getAlphaBetween(
            t1.SliderData.Start,
            t1.SliderData.End,
            t1.SliderData.DefaultValue
        )
    end

    v2._data._percent = math.clamp(v2._data._percent, 0, 1)
    v2._data._value = SliderFuncs_m.getNewValue(v2)
    v2._data._increment = t1.SliderData.Increment
    v2._data._scaleIncrement = SliderFuncs_m.getScaleIncrement(v2)
    v2.Changed = Signal_m.new()
    v2.Dragged = Signal_m.new()
    v2.Released = Signal_m.new()
    v2._data._percent = SliderFuncs_m.snapToScale(v2._data._percent, v2._data._scaleIncrement)
    v2:Move()
    local OtherConnections = v2._data._otherConnections
    local AbsoluteSize = Slider:GetPropertyChangedSignal("AbsoluteSize")
    table.insert(OtherConnections, AbsoluteSize:Connect(function() -- line: 144
        -- upvalues:
        --  [1] v2 (copy)

        v2:Move("Instant")
    end))
    table.insert(t.Sliders, v2)

    return v2
end

function t.Track(arg3) -- line: 153
    -- upvalues:
    --  [1] UserInputService (copy)

    for _, val_2 in ipairs(arg3._data._clickConnections) do
        val_2:Disconnect()
    end

    table.insert(arg3._data._clickConnections, arg3._data.Button.MouseButton1Down:Connect(function() -- line: 158
        -- upvalues:
        --  [1] arg3 (copy)

        arg3.IsHeld = true
    end))
    table.insert(arg3._data._clickConnections, arg3._data.Button.MouseButton1Up:Connect(function() -- line: 162
        -- upvalues:
        --  [1] arg3 (copy)

        if arg3.IsHeld then
            arg3.Released:Fire(arg3._data._value)
        end

        arg3.IsHeld = false
    end))

    if arg3._data._allowBackgroundClick then
        table.insert(arg3._data._clickConnections, arg3._data.HolderButton.Activated:Connect(function(
            u2: userdata
        ) -- line: 170
            -- upvalues:
            --  [1] arg3 (copy)

            if u2.UserInputType == Enum.UserInputType.MouseButton1 or u2.UserInputType == Enum.UserInputType.Touch then
                arg3._data._inputPos = u2.Position
                arg3._data._clickOverride = true
                arg3:Update()
                arg3._data._clickOverride = false
            end
        end))
    end

    if arg3.Changed then
        arg3.Changed:Fire(arg3._data._value)
    end

    if arg3._data._mainConnection then
        arg3._data._mainConnection:Disconnect()
    end

    arg3._data._mainConnection = UserInputService.InputChanged:Connect(function(arg4, _) -- line: 188
        -- upvalues:
        --  [1] arg3 (copy)

        if arg4.UserInputType == Enum.UserInputType.MouseMovement or arg4.UserInputType == Enum.UserInputType.Touch then
            arg3._data._inputPos = arg4.Position
            arg3:Update()
        end
    end)
end

function t.Update(arg6) -- line: 196
    -- upvalues:
    --  [1] SliderFuncs_m (copy)

    if (arg6.IsHeld or arg6._data._clickOverride) and arg6._data._inputPos then
        local v7 = arg6._data._inputPos[arg6._config.Axis]

        if v7 then
            arg6._data._percent = math.clamp(
                SliderFuncs_m.snapToScale(
                    (v7 - arg6._holder.AbsolutePosition[arg6._config.Axis]) / arg6._holder.AbsoluteSize[arg6._config.Axis],
                    arg6._data._scaleIncrement
                ),
                0,
                1
            )
            arg6.Dragged:Fire(arg6._data._value)
            arg6:Move()
        end
    end
end

function t.Untrack(arg7) -- line: 215
    for _, val_3 in ipairs(arg7._data._clickConnections) do
        val_3:Disconnect()
    end

    if arg7._data._mainConnection then
        arg7._data._mainConnection:Disconnect()
    end

    arg7.IsHeld = false
end

function t.Reset(arg8) -- line: 225
    -- upvalues:
    --  [1] SliderFuncs_m (copy)

    for _, val_4 in ipairs(arg8._data._clickConnections) do
        val_4:Disconnect()
    end

    if arg8._data._mainConnection then
        arg8._data._mainConnection:Disconnect()
    end

    arg8.IsHeld = false
    arg8._data._percent = 0

    if arg8._config.SliderData.DefaultValue then
        arg8._data._percent = SliderFuncs_m.getAlphaBetween(
            arg8._config.SliderData.Start,
            arg8._config.SliderData.End,
            arg8._config.SliderData.DefaultValue
        )
    end

    arg8._data._percent = math.clamp(arg8._data._percent, 0, 1)
    arg8:Move()
end

function t.OverrideValue(t2: table, n1: number) -- line: 243
    -- upvalues:
    --  [1] SliderFuncs_m (copy)

    t2.IsHeld = false
    t2._data._percent = SliderFuncs_m.getAlphaBetween(
        t2._config.SliderData.Start,
        t2._config.SliderData.End,
        n1
    )
    t2._data._percent = math.clamp(t2._data._percent, 0, 1)
    t2._data._percent = SliderFuncs_m.snapToScale(t2._data._percent, t2._data._scaleIncrement)
    t2:Move()
end

function t.Move(t3: table, s1: string) -- line: 251
    -- upvalues:
    --  [1] SliderFuncs_m (copy)
    --  [2] TweenService (copy)

    t3._data._value = SliderFuncs_m.getNewValue(t3)
    local v9 = if s1 ~= nil then s1 else t3._config.MoveType

    if v9 == "Tween" or v9 == nil then
        if t3._data._currentTween then
            t3._data._currentTween:Cancel()
        end

        local t_4 = { Position = SliderFuncs_m.getNewPosition(t3) }
        t3._data._currentTween = TweenService:Create(t3._data.Button, t3._config.MoveInfo, t_4)
        t3._data._currentTween:Play()
    elseif v9 == "Instant" then
        t3._data.Button.Position = SliderFuncs_m.getNewPosition(t3)
    end

    t3.Changed:Fire(t3._data._value)
end

function t.OverrideIncrement(t4: table, n2: number) -- line: 269
    -- upvalues:
    --  [1] SliderFuncs_m (copy)

    t4._config.SliderData.Increment = n2
    t4._data._increment = n2
    t4._data._scaleIncrement = SliderFuncs_m.getScaleIncrement(t4)
    t4._data._percent = math.clamp(t4._data._percent, 0, 1)
    t4._data._percent = SliderFuncs_m.snapToScale(t4._data._percent, t4._data._scaleIncrement)
    t4:Move()
end

function t.GetValue(arg9) -- line: 278
    return arg9._data._value
end

function t.GetIncrement(arg10) -- line: 282
    return arg10._data._increment
end

function t.Destroy(arg11) -- line: 286
    -- upvalues:
    --  [1] t (copy)

    for _, val_5 in ipairs(arg11._data._clickConnections) do
        val_5:Disconnect()
    end

    for _, val_6 in ipairs(arg11._data._otherConnections) do
        val_6:Disconnect()
    end

    if arg11._data._mainConnection then
        arg11._data._mainConnection:Disconnect()
    end

    if arg11._data.HolderButton then
        arg11._data.HolderButton:Destroy()
        arg11._data.HolderButton = nil
    end

    arg11.Changed:Destroy()
    arg11.Dragged:Destroy()
    arg11.Released:Destroy()

    for index = 1, #t.Sliders do
        local _ = #t.Sliders

        if t.Sliders[index] == arg11 then
            table.remove(t.Sliders, index)
        end
    end

    setmetatable(arg11, nil)
end

UserInputService.InputEnded:Connect(function(u3: userdata, _: boolean) -- line: 317
    -- upvalues:
    --  [1] t (copy)

    if u3.UserInputType == Enum.UserInputType.MouseButton1 or u3.UserInputType == Enum.UserInputType.Touch then
        for _, val_7 in ipairs(t.Sliders) do
            if val_7.IsHeld then
                val_7.Released:Fire(val_7._data._value)
            end

            val_7.IsHeld = false
        end
    end
end)

return t
