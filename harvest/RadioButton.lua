-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.RadioButton
-- Class: ModuleScript
-- bytes: 5786

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
    t.Args = { Text = 1, Index = 2 }
    local t_2 = {}
    local t_3 = {
        Init = function(_) -- line: 13
        end
    }

    function t_3.Get(arg4) -- line: 14
        -- upvalues:
        --  [1] arg1 (copy)

        return arg4.lastSelectedTick == arg1._cycleTick
    end

    t_2.selected = t_3
    local t_4 = {
        Init = function(_) -- line: 19
        end
    }

    function t_4.Get(arg6) -- line: 20
        -- upvalues:
        --  [1] arg1 (copy)

        return arg6.lastUnselectedTick == arg1._cycleTick
    end

    t_2.unselected = t_4
    t_2.active = {
        Init = function(_) -- line: 25
        end,
        Get = function(arg8) -- line: 26
            return arg8.state.index.value == arg8.arguments.Index
        end
    }
    t_2.hovered = arg2.EVENTS.hover(function(arg9) -- line: 30
        return arg9.Instance
    end)
    t.Events = t_2

    function t.Generate(arg10) -- line: 34
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local IrisRadioButton_TextButton = Instance.new("TextButton")
        IrisRadioButton_TextButton.Name = "Iris_RadioButton"
        IrisRadioButton_TextButton.BackgroundTransparency = 1
        IrisRadioButton_TextButton.BorderSizePixel = 0
        IrisRadioButton_TextButton.Size = UDim2.fromOffset(0, 0)
        IrisRadioButton_TextButton.Text = ""
        IrisRadioButton_TextButton.AutomaticSize = Enum.AutomaticSize.XY
        IrisRadioButton_TextButton.ZIndex = arg10.ZIndex
        IrisRadioButton_TextButton.AutoButtonColor = false
        IrisRadioButton_TextButton.LayoutOrder = arg10.ZIndex
        local v4 = arg1._config.TextSize + 2 * (arg1._config.FramePadding.Y - 1)
        local Button_Frame = Instance.new("Frame")
        Button_Frame.Name = "Button"
        Button_Frame.Size = UDim2.fromOffset(v4, v4)
        Button_Frame.ZIndex = arg10.ZIndex + 1
        Button_Frame.LayoutOrder = arg10.ZIndex + 1
        Button_Frame.Parent = IrisRadioButton_TextButton
        Button_Frame.BackgroundColor3 = arg1._config.FrameBgColor
        Button_Frame.BackgroundTransparency = arg1._config.FrameBgTransparency
        arg2.UICorner(Button_Frame)
        local Frame_1 = Instance.new("Frame")
        Frame_1.Name = "Circle"
        Frame_1.Position = UDim2.fromOffset(
            arg1._config.FramePadding.Y,
            arg1._config.FramePadding.Y
        )
        Frame_1.Size = UDim2.fromOffset(arg1._config.TextSize - 2, arg1._config.TextSize - 2)
        Frame_1.ZIndex = arg10.ZIndex + 1
        Frame_1.LayoutOrder = arg10.ZIndex + 1
        Frame_1.Parent = Button_Frame
        Frame_1.BackgroundColor3 = arg1._config.CheckMarkColor
        Frame_1.BackgroundTransparency = arg1._config.CheckMarkTransparency
        arg2.UICorner(Frame_1)
        arg2.applyInteractionHighlights(
            IrisRadioButton_TextButton,
            Button_Frame,
            {
                ButtonColor = arg1._config.FrameBgColor,
                ButtonTransparency = arg1._config.FrameBgTransparency,
                ButtonHoveredColor = arg1._config.FrameBgHoveredColor,
                ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency,
                ButtonActiveColor = arg1._config.FrameBgActiveColor,
                ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency
            }
        )
        IrisRadioButton_TextButton.MouseButton1Click:Connect(function() -- line: 78
            -- upvalues:
            --  [1] arg10 (copy)

            arg10.state.index:set(arg10.arguments.Index)
        end)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        arg2.applyTextStyle(TextLabel)
        TextLabel.Position = UDim2.new(0, v4 + arg1._config.ItemInnerSpacing.X, 0.5, 0)
        TextLabel.ZIndex = arg10.ZIndex + 1
        TextLabel.LayoutOrder = arg10.ZIndex + 1
        TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel.AnchorPoint = Vector2.new(0, 0.5)
        TextLabel.BackgroundTransparency = 1
        TextLabel.BorderSizePixel = 0
        TextLabel.Parent = IrisRadioButton_TextButton

        return IrisRadioButton_TextButton
    end

    function t.Update(arg11) -- line: 96
        -- upvalues:
        --  [1] arg1 (copy)

        arg11.Instance.TextLabel.Text = arg11.arguments.Text or "Radio Button"

        if arg11.state then
            arg1._widgets[arg11.type].UpdateState(arg11)
        end
    end

    function t.Discard(arg12) -- line: 105
        -- upvalues:
        --  [1] arg2 (copy)

        arg12.Instance:Destroy()
        arg2.discardState(arg12)
    end

    function t.GenerateState(arg13) -- line: 109
        -- upvalues:
        --  [1] arg1 (copy)

        if arg13.state.index == nil then
            arg13.state.index = arg1._widgetState(arg13, "index", arg13.arguments.Value)
        end
    end

    function t.UpdateState(arg14) -- line: 114
        -- upvalues:
        --  [1] arg1 (copy)

        local Circle = arg14.Instance.Button.Circle

        if arg14.state.index.value == arg14.arguments.Index then
            Circle.BackgroundTransparency = arg1._config.CheckMarkTransparency
            arg14.lastSelectedTick = arg1._cycleTick + 1

            return
        end

        Circle.BackgroundTransparency = 1
        arg14.lastUnselectedTick = arg1._cycleTick + 1
    end

    WidgetConstructor("RadioButton", t)
end
