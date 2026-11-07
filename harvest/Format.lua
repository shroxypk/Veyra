-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Format
-- Class: ModuleScript
-- bytes: 5691

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local t = {
        hasState = false,
        hasChildren = false,
        Args = {},
        Events = {},
        Generate = nil,
        Update = nil,
        Discard = nil
    }

    function t.Generate(arg3) -- line: 9
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local IrisSeparator_Frame = Instance.new("Frame")
        IrisSeparator_Frame.Name = "Iris_Separator"
        IrisSeparator_Frame.BackgroundColor3 = arg1._config.SeparatorColor
        IrisSeparator_Frame.BackgroundTransparency = arg1._config.SeparatorTransparency
        IrisSeparator_Frame.BorderSizePixel = 0

        if arg3.parentWidget.type == "SameLine" then
            IrisSeparator_Frame.Size = UDim2.new(0, 1, 1, 0)
        else
            IrisSeparator_Frame.Size = UDim2.new(1, 0, 0, 1)
        end

        IrisSeparator_Frame.ZIndex = arg3.ZIndex
        IrisSeparator_Frame.LayoutOrder = arg3.ZIndex
        arg2.UIListLayout(IrisSeparator_Frame, Enum.FillDirection.Vertical, UDim.new(0, 0))

        return IrisSeparator_Frame
    end

    local WidgetConstructor = arg1.WidgetConstructor

    function t.Update(_) -- line: 28
    end

    function t.Discard(arg5) -- line: 29
        arg5.Instance:Destroy()
    end

    WidgetConstructor("Separator", t)
    local t_1 = {
        hasState = false,
        hasChildren = true,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil,
        ChildAdded = nil
    }
    local WidgetConstructor_1 = arg1.WidgetConstructor
    t_1.Args = { Width = 1 }
    t_1.Events = {}

    function t_1.Generate(arg6) -- line: 41
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        local Frame_1 = Instance.new("Frame")
        Frame_1.Name = "Iris_Indent"
        Frame_1.BackgroundTransparency = 1
        Frame_1.BorderSizePixel = 0
        Frame_1.Size = UDim2.fromScale(1, 0)
        Frame_1.AutomaticSize = Enum.AutomaticSize.Y
        Frame_1.ZIndex = arg6.ZIndex
        Frame_1.LayoutOrder = arg6.ZIndex
        arg2.UIListLayout(
            Frame_1,
            Enum.FillDirection.Vertical,
            UDim.new(0, arg1._config.ItemSpacing.Y)
        )
        arg2.UIPadding(Frame_1, Vector2.new(0, 0))

        return Frame_1
    end

    function t_1.Update(arg7) -- line: 56
        -- upvalues:
        --  [1] arg1 (copy)

        local v1 = arg7.arguments.Width or arg1._config.IndentSpacing
        arg7.Instance.UIPadding.PaddingLeft = UDim.new(0, v1)
    end

    function t_1.Discard(arg8) -- line: 67
        arg8.Instance:Destroy()
    end

    function t_1.ChildAdded(arg9, _) -- line: 70
        return arg9.Instance
    end

    WidgetConstructor_1("Indent", t_1)
    local t_3 = {
        hasState = false,
        hasChildren = true,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil,
        ChildAdded = nil
    }
    local WidgetConstructor_2 = arg1.WidgetConstructor
    t_3.Args = { Width = 1, VerticalAlignment = 2 }
    t_3.Events = {}

    function t_3.Generate(arg11) -- line: 83
        -- upvalues:
        --  [1] arg2 (copy)

        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Iris_SameLine"
        Frame_2.BackgroundTransparency = 1
        Frame_2.BorderSizePixel = 0
        Frame_2.Size = UDim2.fromScale(1, 0)
        Frame_2.AutomaticSize = Enum.AutomaticSize.Y
        Frame_2.ZIndex = arg11.ZIndex
        Frame_2.LayoutOrder = arg11.ZIndex
        arg2.UIListLayout(Frame_2, Enum.FillDirection.Horizontal, UDim.new(0, 0))

        return Frame_2
    end

    function t_3.Update(arg12) -- line: 97
        -- upvalues:
        --  [1] arg1 (copy)

        local UIListLayout_3 = arg12.Instance.UIListLayout
        local v2 = arg12.arguments.Width or arg1._config.ItemSpacing.X
        UIListLayout_3.Padding = UDim.new(0, v2)

        if arg12.arguments.VerticalAlignment then
            UIListLayout_3.VerticalAlignment = arg12.arguments.VerticalAlignment

            return
        end

        UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center
    end

    function t_3.Discard(arg13) -- line: 113
        arg13.Instance:Destroy()
    end

    function t_3.ChildAdded(arg14, _) -- line: 116
        return arg14.Instance
    end

    WidgetConstructor_2("SameLine", t_3)
    local t_5 = {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = nil,
        Update = nil,
        Discard = nil,
        ChildAdded = nil
    }

    function t_5.Generate(arg16) -- line: 126
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        local Frame_3 = Instance.new("Frame")
        Frame_3.Name = "Iris_Group"
        Frame_3.BackgroundTransparency = 1
        Frame_3.BorderSizePixel = 0
        Frame_3.Size = UDim2.fromOffset(0, 0)
        Frame_3.AutomaticSize = Enum.AutomaticSize.XY
        Frame_3.ZIndex = arg16.ZIndex
        Frame_3.LayoutOrder = arg16.ZIndex
        Frame_3.ClipsDescendants = true
        arg2.UIListLayout(
            Frame_3,
            Enum.FillDirection.Vertical,
            UDim.new(0, arg1._config.ItemSpacing.X)
        )

        return Frame_3
    end

    local WidgetConstructor_3 = arg1.WidgetConstructor

    function t_5.Update(_) -- line: 141
    end

    function t_5.Discard(arg18) -- line: 142
        arg18.Instance:Destroy()
    end

    function t_5.ChildAdded(arg19, _) -- line: 145
        return arg19.Instance
    end

    WidgetConstructor_3("Group", t_5)
end
