-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Checkbox
-- Class: ModuleScript
-- bytes: 5542

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local t = {
        hasState = true,
        hasChildren = false,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil,
        GenerateState = nil,
        UpdateState = nil
    }
    local WidgetConstructor = arg1.WidgetConstructor
    t.Args = { Text = 1 }
    local t_2 = {}
    local t_3 = {
        Init = function(_) -- line: 12
        end
    }

    function t_3.Get(arg4) -- line: 13
        -- upvalues:
        --  [1] arg1 (copy)

        return arg4.lastCheckedTick == arg1._cycleTick
    end

    t_2.checked = t_3
    local t_4 = {
        Init = function(_) -- line: 18
        end
    }

    function t_4.Get(arg6) -- line: 19
        -- upvalues:
        --  [1] arg1 (copy)

        return arg6.lastUncheckedTick == arg1._cycleTick
    end

    t_2.unchecked = t_4
    t_2.hovered = arg2.EVENTS.hover(function(arg7) -- line: 23
        return arg7.Instance
    end)
    t.Events = t_2

    function t.Generate(arg8) -- line: 27
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local IrisCheckbox_TextButton = Instance.new("TextButton")
        IrisCheckbox_TextButton.Name = "Iris_Checkbox"
        IrisCheckbox_TextButton.BackgroundTransparency = 1
        IrisCheckbox_TextButton.BorderSizePixel = 0
        IrisCheckbox_TextButton.Size = UDim2.fromOffset(0, 0)
        IrisCheckbox_TextButton.Text = ""
        IrisCheckbox_TextButton.AutomaticSize = Enum.AutomaticSize.XY
        IrisCheckbox_TextButton.ZIndex = arg8.ZIndex
        IrisCheckbox_TextButton.AutoButtonColor = false
        IrisCheckbox_TextButton.LayoutOrder = arg8.ZIndex
        local v3 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
        local CheckboxBox_Frame = Instance.new("Frame")
        CheckboxBox_Frame.Name = "CheckboxBox"
        CheckboxBox_Frame.Size = UDim2.fromOffset(v3, v3)
        CheckboxBox_Frame.BackgroundColor3 = arg1._config.FrameBgColor
        CheckboxBox_Frame.BackgroundTransparency = arg1._config.FrameBgTransparency
        CheckboxBox_Frame.ZIndex = arg8.ZIndex + 1
        CheckboxBox_Frame.LayoutOrder = arg8.ZIndex + 1
        arg2.applyFrameStyle(CheckboxBox_Frame, true)
        arg2.applyInteractionHighlights(
            IrisCheckbox_TextButton,
            CheckboxBox_Frame,
            {
                ButtonColor = arg1._config.FrameBgColor,
                ButtonTransparency = arg1._config.FrameBgTransparency,
                ButtonHoveredColor = arg1._config.FrameBgHoveredColor,
                ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency,
                ButtonActiveColor = arg1._config.FrameBgActiveColor,
                ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency
            }
        )
        CheckboxBox_Frame.Parent = IrisCheckbox_TextButton
        local v4 = math.ceil(v3 * 0.1)
        local v5 = v3 - v4 * 2
        local Checkmark_ImageLabel = Instance.new("ImageLabel")
        Checkmark_ImageLabel.Name = "Checkmark"
        Checkmark_ImageLabel.Size = UDim2.fromOffset(v5, v5)
        Checkmark_ImageLabel.Position = UDim2.fromOffset(v4, v4)
        Checkmark_ImageLabel.BackgroundTransparency = 1
        Checkmark_ImageLabel.ImageColor3 = arg1._config.CheckMarkColor
        Checkmark_ImageLabel.ImageTransparency = arg1._config.CheckMarkTransparency
        Checkmark_ImageLabel.ScaleType = Enum.ScaleType.Fit
        Checkmark_ImageLabel.ZIndex = arg8.ZIndex + 2
        Checkmark_ImageLabel.LayoutOrder = arg8.ZIndex + 2
        Checkmark_ImageLabel.Parent = IrisCheckbox_TextButton
        IrisCheckbox_TextButton.MouseButton1Click:Connect(function() -- line: 77
            -- upvalues:
            --  [1] arg8 (copy)

            arg8.state.isChecked:set(not arg8.state.isChecked.value)
        end)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        arg2.applyTextStyle(TextLabel)
        TextLabel.AnchorPoint = Vector2.new(0, 0.5)
        TextLabel.Position = UDim2.new(0, v3 + arg1._config.ItemInnerSpacing.X, 0.5, 0)
        TextLabel.ZIndex = arg8.ZIndex + 1
        TextLabel.LayoutOrder = arg8.ZIndex + 1
        TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel.BackgroundTransparency = 1
        TextLabel.BorderSizePixel = 0
        TextLabel.Parent = IrisCheckbox_TextButton

        return IrisCheckbox_TextButton
    end

    function t.Update(arg9) -- line: 96
        arg9.Instance.TextLabel.Text = arg9.arguments.Text or "Checkbox"
    end

    function t.Discard(arg10) -- line: 100
        -- upvalues:
        --  [1] arg2 (copy)

        arg10.Instance:Destroy()
        arg2.discardState(arg10)
    end

    function t.GenerateState(arg11) -- line: 104
        -- upvalues:
        --  [1] arg1 (copy)

        if arg11.state.isChecked == nil then
            arg11.state.isChecked = arg1._widgetState(arg11, "checked", false)
        end
    end

    function t.UpdateState(arg12) -- line: 109
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        local Checkmark = arg12.Instance.Checkmark

        if arg12.state.isChecked.value then
            Checkmark.Image = arg2.ICONS.CHECK_MARK
            arg12.lastCheckedTick = arg1._cycleTick + 1

            return
        end

        Checkmark.Image = ""
        arg12.lastUncheckedTick = arg1._cycleTick + 1
    end

    WidgetConstructor("Checkbox", t)
end
