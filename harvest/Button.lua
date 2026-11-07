-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Button
-- Class: ModuleScript
-- bytes: 3181

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local t = {
        hasState = false,
        hasChildren = false,
        Args = { Text = 1 },
        Events = {
            clicked = arg2.EVENTS.click(function(arg3) -- line: 11
                return arg3.Instance
            end),
            rightClicked = arg2.EVENTS.rightClick(function(arg4) -- line: 14
                return arg4.Instance
            end),
            doubleClicked = arg2.EVENTS.doubleClick(function(arg5) -- line: 17
                return arg5.Instance
            end),
            ctrlClicked = arg2.EVENTS.ctrlClick(function(arg6) -- line: 20
                return arg6.Instance
            end),
            hovered = arg2.EVENTS.hover(function(arg7) -- line: 23
                return arg7.Instance
            end)
        },
        Generate = nil,
        Update = nil,
        Discard = nil
    }

    function t.Generate(arg8) -- line: 27
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.fromOffset(0, 0)
        TextButton.BackgroundColor3 = arg1._config.ButtonColor
        TextButton.BackgroundTransparency = arg1._config.ButtonTransparency
        TextButton.AutoButtonColor = false
        arg2.applyTextStyle(TextButton)
        TextButton.AutomaticSize = Enum.AutomaticSize.XY
        arg2.applyFrameStyle(TextButton)
        arg2.applyInteractionHighlights(
            TextButton,
            TextButton,
            {
                ButtonColor = arg1._config.ButtonColor,
                ButtonTransparency = arg1._config.ButtonTransparency,
                ButtonHoveredColor = arg1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency,
                ButtonActiveColor = arg1._config.ButtonActiveColor,
                ButtonActiveTransparency = arg1._config.ButtonActiveTransparency
            }
        )
        TextButton.ZIndex = arg8.ZIndex
        TextButton.LayoutOrder = arg8.ZIndex

        return TextButton
    end

    function t.Update(arg9) -- line: 53
        arg9.Instance.Text = arg9.arguments.Text or "Button"
    end

    function t.Discard(arg10) -- line: 57
        arg10.Instance:Destroy()
    end

    arg2.abstractButton = t
    local t_4 = { Generate = nil }

    function t_4.Generate(arg11) -- line: 66
        -- upvalues:
        --  [1] t (copy)

        local v1 = t.Generate(arg11)
        v1.Name = "Iris_Button"

        return v1
    end

    arg1.WidgetConstructor("Button", arg2.extend(t, t_4))
    local t_5 = { Generate = nil }

    function t_5.Generate(arg12) -- line: 78
        -- upvalues:
        --  [1] t (copy)

        local v2 = t.Generate(arg12)
        v2.Name = "Iris_SmallButton"
        local UIPadding = v2.UIPadding
        UIPadding.PaddingLeft = UDim.new(0, 2)
        UIPadding.PaddingRight = UDim.new(0, 2)
        UIPadding.PaddingTop = UDim.new(0, 0)
        UIPadding.PaddingBottom = UDim.new(0, 0)

        return v2
    end

    arg1.WidgetConstructor("SmallButton", arg2.extend(t, t_5))
end
