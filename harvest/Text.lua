-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Text
-- Class: ModuleScript
-- bytes: 5458

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local t = {
        hasState = false,
        hasChildren = false,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil
    }
    local WidgetConstructor = arg1.WidgetConstructor
    t.Args = { Text = 1, Wrapped = 2, Color = 3, RichText = 4 }
    t.Events = {
        hovered = arg2.EVENTS.hover(function(arg3) -- line: 14
            return arg3.Instance
        end)
    }

    function t.Generate(arg4) -- line: 18
        -- upvalues:
        --  [1] arg2 (copy)

        local IrisText_TextLabel = Instance.new("TextLabel")
        IrisText_TextLabel.Name = "Iris_Text"
        IrisText_TextLabel.Size = UDim2.fromOffset(0, 0)
        IrisText_TextLabel.BackgroundTransparency = 1
        IrisText_TextLabel.BorderSizePixel = 0
        IrisText_TextLabel.ZIndex = arg4.ZIndex
        IrisText_TextLabel.LayoutOrder = arg4.ZIndex
        IrisText_TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        arg2.applyTextStyle(IrisText_TextLabel)
        arg2.UIPadding(IrisText_TextLabel, Vector2.new(0, 2))

        return IrisText_TextLabel
    end

    function t.Update(arg5) -- line: 33
        -- upvalues:
        --  [1] arg1 (copy)

        local v1 = arg5.Instance

        if arg5.arguments.Text == nil then
            error("Iris.Text Text Argument is required", 5)
        end

        if arg5.arguments.Wrapped then
            v1.TextWrapped = true
        else
            v1.TextWrapped = false
        end

        if arg5.arguments.Color then
            v1.TextColor3 = arg5.arguments.Color
        else
            v1.TextColor3 = arg1._config.TextColor
        end

        if arg5.arguments.RichText then
            v1.RichText = true
        else
            v1.RichText = false
        end

        v1.Text = arg5.arguments.Text
    end

    function t.Discard(arg6) -- line: 56
        arg6.Instance:Destroy()
    end

    WidgetConstructor("Text", t)
    local t_3 = {
        hasState = false,
        hasChildren = false,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil
    }
    local WidgetConstructor_1 = arg1.WidgetConstructor
    t_3.Args = { Text = 1 }
    t_3.Events = {
        hovered = arg2.EVENTS.hover(function(arg7) -- line: 68
            return arg7.Instance
        end)
    }

    function t_3.Generate(arg8) -- line: 72
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        local IrisSeparatorText_Frame = Instance.new("Frame")
        IrisSeparatorText_Frame.Name = "Iris_SeparatorText"
        IrisSeparatorText_Frame.Size = UDim2.fromScale(1, 0)
        IrisSeparatorText_Frame.BackgroundTransparency = 1
        IrisSeparatorText_Frame.BorderSizePixel = 0
        IrisSeparatorText_Frame.AutomaticSize = Enum.AutomaticSize.Y
        IrisSeparatorText_Frame.ZIndex = arg8.ZIndex
        IrisSeparatorText_Frame.LayoutOrder = arg8.ZIndex
        IrisSeparatorText_Frame.ClipsDescendants = true
        arg2.UIPadding(IrisSeparatorText_Frame, Vector2.new(0, arg1._config.SeparatorTextPadding.Y))
        arg2.UIListLayout(
            IrisSeparatorText_Frame,
            Enum.FillDirection.Horizontal,
            UDim.new(0, arg1._config.ItemSpacing.X)
        )
        IrisSeparatorText_Frame.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        local TextLabel_1 = Instance.new("TextLabel")
        TextLabel_1.Name = "TextLabel"
        TextLabel_1.BackgroundTransparency = 1
        TextLabel_1.BorderSizePixel = 0
        TextLabel_1.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_1.ZIndex = arg8.ZIndex + 1
        TextLabel_1.LayoutOrder = arg8.ZIndex + 1
        arg2.applyTextStyle(TextLabel_1)
        TextLabel_1.Parent = IrisSeparatorText_Frame
        local Frame_1 = Instance.new("Frame")
        Frame_1.Name = "Left"
        Frame_1.AnchorPoint = Vector2.new(1, 0.5)
        Frame_1.BackgroundColor3 = arg1._config.SeparatorColor
        Frame_1.BackgroundTransparency = arg1._config.SeparatorTransparency
        Frame_1.BorderSizePixel = 0
        Frame_1.Size = UDim2.fromOffset(
            arg1._config.SeparatorTextPadding.X - arg1._config.ItemSpacing.X,
            arg1._config.SeparatorTextBorderSize
        )
        Frame_1.ZIndex = arg8.ZIndex
        Frame_1.LayoutOrder = arg8.ZIndex
        Frame_1.Parent = IrisSeparatorText_Frame
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Right"
        Frame_2.AnchorPoint = Vector2.new(1, 0.5)
        Frame_2.BackgroundColor3 = arg1._config.SeparatorColor
        Frame_2.BackgroundTransparency = arg1._config.SeparatorTransparency
        Frame_2.BorderSizePixel = 0
        Frame_2.Size = UDim2.new(1, 0, 0, arg1._config.SeparatorTextBorderSize)
        Frame_2.ZIndex = arg8.ZIndex + 2
        Frame_2.LayoutOrder = arg8.ZIndex + 2
        Frame_2.Parent = IrisSeparatorText_Frame

        return IrisSeparatorText_Frame
    end

    function t_3.Update(arg9) -- line: 126
        local TextLabel_2 = arg9.Instance.TextLabel

        if arg9.arguments.Text == nil then
            error("Iris.Text Text Argument is required", 5)
        end

        TextLabel_2.Text = arg9.arguments.Text
    end

    function t_3.Discard(arg10) -- line: 134
        arg10.Instance:Destroy()
    end

    WidgetConstructor_1("SeparatorText", t_3)
end
