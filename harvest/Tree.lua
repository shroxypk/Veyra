-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Tree
-- Class: ModuleScript
-- bytes: 12951

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local t = {
        hasState = true,
        hasChildren = true,
        Events = nil,
        Discard = nil,
        ChildAdded = nil,
        UpdateState = nil,
        GenerateState = nil
    }
    local t_1 = {}
    local t_2 = {
        Init = function(_) -- line: 9
        end
    }

    function t_2.Get(arg4) -- line: 10
        -- upvalues:
        --  [1] arg1 (copy)

        return arg4.lastCollapsedTick == arg1._cycleTick
    end

    t_1.collasped = t_2
    local t_3 = {
        Init = function(_) -- line: 15
        end
    }

    function t_3.Get(arg6) -- line: 16
        -- upvalues:
        --  [1] arg1 (copy)

        return arg6.lastUncollapsedTick == arg1._cycleTick
    end

    t_1.uncollapsed = t_3
    t_1.hovered = arg2.EVENTS.hover(function(arg7) -- line: 20
        return arg7.Instance
    end)
    t.Events = t_1

    function t.Discard(arg8) -- line: 24
        -- upvalues:
        --  [1] arg2 (copy)

        arg8.Instance:Destroy()
        arg2.discardState(arg8)
    end

    function t.ChildAdded(arg9) -- line: 28
        local ChildContainer = arg9.Instance.ChildContainer
        ChildContainer.Visible = arg9.state.isUncollapsed.value

        return ChildContainer
    end

    function t.UpdateState(arg10) -- line: 36
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        local Value = arg10.state.isUncollapsed.value
        local v3 = arg10.Instance
        local v4 = Value and arg2.ICONS.DOWN_POINTING_TRIANGLE or arg2.ICONS.RIGHT_POINTING_TRIANGLE
        local ChildContainer_1 = v3.ChildContainer
        v3.Header.Button.Arrow.Image = v4

        if Value then
            arg10.lastUncollapsedTick = arg1._cycleTick + 1
        else
            arg10.lastCollapsedTick = arg1._cycleTick + 1
        end

        ChildContainer_1.Visible = Value
    end

    function t.GenerateState(arg11) -- line: 53
        -- upvalues:
        --  [1] arg1 (copy)

        if arg11.state.isUncollapsed == nil then
            arg11.state.isUncollapsed = arg1._widgetState(arg11, "isUncollapsed", false)
        end
    end

    local t_4 = { Args = nil, Generate = nil, Update = nil }
    local WidgetConstructor = arg1.WidgetConstructor
    local Extend = arg2.extend
    t_4.Args = { Text = 1, SpanAvailWidth = 2, NoIndent = 3 }

    function t_4.Generate(arg12) -- line: 68
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local IrisTree_Frame = Instance.new("Frame")
        IrisTree_Frame.Name = "Iris_Tree"
        IrisTree_Frame.Size = UDim2.new(arg1._config.ItemWidth, UDim.new(0, 0))
        IrisTree_Frame.AutomaticSize = Enum.AutomaticSize.Y
        IrisTree_Frame.BackgroundTransparency = 1
        IrisTree_Frame.BorderSizePixel = 0
        IrisTree_Frame.ZIndex = arg12.ZIndex
        IrisTree_Frame.LayoutOrder = arg12.ZIndex
        arg2.UIListLayout(IrisTree_Frame, Enum.FillDirection.Vertical, UDim.new(0, 0))
        local Frame_1 = Instance.new("Frame")
        Frame_1.Name = "ChildContainer"
        Frame_1.Size = UDim2.fromScale(1, 0)
        Frame_1.AutomaticSize = Enum.AutomaticSize.Y
        Frame_1.BackgroundTransparency = 1
        Frame_1.BorderSizePixel = 0
        Frame_1.ZIndex = arg12.ZIndex + 1
        Frame_1.LayoutOrder = arg12.ZIndex + 1
        Frame_1.Visible = false
        arg2.UIListLayout(
            Frame_1,
            Enum.FillDirection.Vertical,
            UDim.new(0, arg1._config.ItemSpacing.Y)
        )
        arg2.UIPadding(Frame_1, Vector2.new(0, 0)).PaddingTop = UDim.new(
            0,
            arg1._config.ItemSpacing.Y
        )
        Frame_1.Parent = IrisTree_Frame
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Header"
        Frame_2.Size = UDim2.fromScale(1, 0)
        Frame_2.AutomaticSize = Enum.AutomaticSize.Y
        Frame_2.BackgroundTransparency = 1
        Frame_2.BorderSizePixel = 0
        Frame_2.ZIndex = arg12.ZIndex
        Frame_2.LayoutOrder = arg12.ZIndex
        Frame_2.Parent = IrisTree_Frame
        local Button_TextButton = Instance.new("TextButton")
        Button_TextButton.Name = "Button"
        Button_TextButton.BackgroundTransparency = 1
        Button_TextButton.BorderSizePixel = 0
        Button_TextButton.Text = ""
        Button_TextButton.ZIndex = arg12.ZIndex
        Button_TextButton.LayoutOrder = arg12.ZIndex
        Button_TextButton.AutoButtonColor = false
        local t_6 = {
            ButtonColor = Color3.fromRGB(0, 0, 0),
            ButtonTransparency = 1,
            ButtonHoveredColor = arg1._config.HeaderHoveredColor,
            ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency,
            ButtonActiveColor = arg1._config.HeaderActiveColor,
            ButtonActiveTransparency = arg1._config.HeaderActiveTransparency
        }
        arg2.applyInteractionHighlights(Button_TextButton, Frame_2, t_6)
        arg2.UIPadding(Button_TextButton, Vector2.zero).PaddingLeft = UDim.new(
            0,
            arg1._config.FramePadding.X
        )
        arg2.UIListLayout(
            Button_TextButton,
            Enum.FillDirection.Horizontal,
            UDim.new(0, arg1._config.FramePadding.X)
        ).VerticalAlignment = Enum.VerticalAlignment.Center
        Button_TextButton.Parent = Frame_2
        local Arrow_ImageLabel = Instance.new("ImageLabel")
        Arrow_ImageLabel.Name = "Arrow"
        Arrow_ImageLabel.Size = UDim2.fromOffset(
            arg1._config.TextSize,
            (math.floor(arg1._config.TextSize * 0.7))
        )
        Arrow_ImageLabel.BackgroundTransparency = 1
        Arrow_ImageLabel.BorderSizePixel = 0
        Arrow_ImageLabel.ImageColor3 = arg1._config.TextColor
        Arrow_ImageLabel.ImageTransparency = arg1._config.TextTransparency
        Arrow_ImageLabel.ScaleType = Enum.ScaleType.Fit
        Arrow_ImageLabel.ZIndex = arg12.ZIndex
        Arrow_ImageLabel.LayoutOrder = arg12.ZIndex
        Arrow_ImageLabel.Parent = Button_TextButton
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "TextLabel"
        TextLabel.Size = UDim2.fromOffset(0, 0)
        TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel.BackgroundTransparency = 1
        TextLabel.BorderSizePixel = 0
        TextLabel.ZIndex = arg12.ZIndex
        TextLabel.LayoutOrder = arg12.ZIndex
        arg2.UIPadding(TextLabel, Vector2.new(0, 0)).PaddingRight = UDim.new(0, 21)
        arg2.applyTextStyle(TextLabel)
        TextLabel.Parent = Button_TextButton
        Button_TextButton.MouseButton1Click:Connect(function() -- line: 160
            -- upvalues:
            --  [1] arg12 (copy)

            arg12.state.isUncollapsed:set(not arg12.state.isUncollapsed.value)
        end)

        return IrisTree_Frame
    end

    function t_4.Update(arg13) -- line: 166
        -- upvalues:
        --  [1] arg1 (copy)

        local v9 = arg13.Instance
        local Button = v9.Header.Button
        local UIPadding_2 = v9.ChildContainer.UIPadding
        Button.TextLabel.Text = arg13.arguments.Text or "Tree"

        if arg13.arguments.SpanAvailWidth then
            Button.AutomaticSize = Enum.AutomaticSize.Y
            Button.Size = UDim2.fromScale(1, 0)
        else
            Button.AutomaticSize = Enum.AutomaticSize.XY
            Button.Size = UDim2.fromScale(0, 0)
        end

        if arg13.arguments.NoIndent then
            UIPadding_2.PaddingLeft = UDim.new(0, 0)

            return
        end

        UIPadding_2.PaddingLeft = UDim.new(0, arg1._config.IndentSpacing)
    end

    WidgetConstructor("Tree", Extend(t, t_4))
    local t_7 = { Args = nil, Generate = nil, Update = nil }
    local WidgetConstructor_1 = arg1.WidgetConstructor
    local Extend_1 = arg2.extend
    t_7.Args = { Text = 1 }

    function t_7.Generate(arg14) -- line: 198
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local Frame_3 = Instance.new("Frame")
        Frame_3.Name = "Iris_CollapsingHeader"
        Frame_3.Size = UDim2.new(arg1._config.ItemWidth, UDim.new(0, 0))
        Frame_3.AutomaticSize = Enum.AutomaticSize.Y
        Frame_3.BackgroundTransparency = 1
        Frame_3.BorderSizePixel = 0
        Frame_3.ZIndex = arg14.ZIndex
        Frame_3.LayoutOrder = arg14.ZIndex
        arg2.UIListLayout(Frame_3, Enum.FillDirection.Vertical, UDim.new(0, 0))
        local Frame_4 = Instance.new("Frame")
        Frame_4.Name = "ChildContainer"
        Frame_4.Size = UDim2.fromScale(1, 0)
        Frame_4.AutomaticSize = Enum.AutomaticSize.Y
        Frame_4.BackgroundTransparency = 1
        Frame_4.BorderSizePixel = 0
        Frame_4.ZIndex = arg14.ZIndex + 1
        Frame_4.LayoutOrder = arg14.ZIndex + 1
        Frame_4.Visible = false
        arg2.UIListLayout(
            Frame_4,
            Enum.FillDirection.Vertical,
            UDim.new(0, arg1._config.ItemSpacing.Y)
        )
        arg2.UIPadding(Frame_4, Vector2.new(0, 0)).PaddingTop = UDim.new(
            0,
            arg1._config.ItemSpacing.Y
        )
        Frame_4.Parent = Frame_3
        local Frame_5 = Instance.new("Frame")
        Frame_5.Name = "Header"
        Frame_5.Size = UDim2.fromScale(1, 0)
        Frame_5.AutomaticSize = Enum.AutomaticSize.Y
        Frame_5.BackgroundTransparency = 1
        Frame_5.BorderSizePixel = 0
        Frame_5.ZIndex = arg14.ZIndex
        Frame_5.LayoutOrder = arg14.ZIndex
        Frame_5.Parent = Frame_3
        local TextButton_1 = Instance.new("TextButton")
        TextButton_1.Name = "Button"
        TextButton_1.Size = UDim2.new(1, 2 * arg1._config.FramePadding.X, 0, 0)
        TextButton_1.Position = UDim2.fromOffset(-4, 0)
        TextButton_1.AutomaticSize = Enum.AutomaticSize.Y
        TextButton_1.BackgroundColor3 = arg1._config.HeaderColor
        TextButton_1.BackgroundTransparency = arg1._config.HeaderTransparency
        TextButton_1.BorderSizePixel = 0
        TextButton_1.Text = ""
        TextButton_1.ZIndex = arg14.ZIndex
        TextButton_1.LayoutOrder = arg14.ZIndex
        TextButton_1.AutoButtonColor = false
        TextButton_1.ClipsDescendants = true
        arg2.UIPadding(
            TextButton_1,
            Vector2.new(2 * arg1._config.FramePadding.X, arg1._config.FramePadding.Y)
        )
        arg2.applyFrameStyle(TextButton_1, true, true)
        arg2.UIListLayout(
            TextButton_1,
            Enum.FillDirection.Horizontal,
            UDim.new(0, 2 * arg1._config.FramePadding.X)
        ).VerticalAlignment = Enum.VerticalAlignment.Center
        arg2.applyInteractionHighlights(
            TextButton_1,
            TextButton_1,
            {
                ButtonColor = arg1._config.HeaderColor,
                ButtonTransparency = arg1._config.HeaderTransparency,
                ButtonHoveredColor = arg1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency,
                ButtonActiveColor = arg1._config.HeaderActiveColor,
                ButtonActiveTransparency = arg1._config.HeaderActiveTransparency
            }
        )
        TextButton_1.Parent = Frame_5
        local ImageLabel_1 = Instance.new("ImageLabel")
        ImageLabel_1.Name = "Arrow"
        ImageLabel_1.Size = UDim2.fromOffset(
            arg1._config.TextSize,
            (math.ceil(arg1._config.TextSize * 0.8))
        )
        ImageLabel_1.AutomaticSize = Enum.AutomaticSize.Y
        ImageLabel_1.BackgroundTransparency = 1
        ImageLabel_1.BorderSizePixel = 0
        ImageLabel_1.ImageColor3 = arg1._config.TextColor
        ImageLabel_1.ImageTransparency = arg1._config.TextTransparency
        ImageLabel_1.ScaleType = Enum.ScaleType.Fit
        ImageLabel_1.ZIndex = arg14.ZIndex
        ImageLabel_1.LayoutOrder = arg14.ZIndex
        ImageLabel_1.Parent = TextButton_1
        local TextLabel_1 = Instance.new("TextLabel")
        TextLabel_1.Name = "TextLabel"
        TextLabel_1.Size = UDim2.fromOffset(0, 0)
        TextLabel_1.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_1.BackgroundTransparency = 1
        TextLabel_1.BorderSizePixel = 0
        TextLabel_1.ZIndex = arg14.ZIndex
        TextLabel_1.LayoutOrder = arg14.ZIndex
        arg2.UIPadding(TextLabel_1, Vector2.new(0, 0)).PaddingRight = UDim.new(0, 21)
        arg2.applyTextStyle(TextLabel_1)
        TextLabel_1.Parent = TextButton_1
        TextButton_1.MouseButton1Click:Connect(function() -- line: 296
            -- upvalues:
            --  [1] arg14 (copy)

            arg14.state.isUncollapsed:set(not arg14.state.isUncollapsed.value)
        end)

        return Frame_3
    end

    function t_7.Update(arg15) -- line: 302
        arg15.Instance.Header.Button.TextLabel.Text = arg15.arguments.Text or "Collapsing Header"
    end

    WidgetConstructor_1("CollapsingHeader", Extend_1(t, t_7))
end
