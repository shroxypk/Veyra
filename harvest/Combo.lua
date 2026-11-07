-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Combo
-- Class: ModuleScript
-- bytes: 21107

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local _ = function(arg3) --[[ onSelectionChange ]] -- line: 4
        if type(arg3.state.index.value) == "boolean" then
            arg3.state.index:set(not arg3.state.index.value)

            return
        end

        arg3.state.index:set(arg3.arguments.Index)
    end

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
    t.Args = { Text = 1, Index = 2, NoClick = 3 }
    local t_2 = {}
    local t_3 = {
        Init = function(_) -- line: 22
        end
    }

    function t_3.Get(arg5) -- line: 23
        -- upvalues:
        --  [1] arg1 (copy)

        return arg5.lastSelectedTick == arg1._cycleTick
    end

    t_2.selected = t_3
    local t_4 = {
        Init = function(_) -- line: 28
        end
    }

    function t_4.Get(arg7) -- line: 29
        -- upvalues:
        --  [1] arg1 (copy)

        return arg7.lastUnselectedTick == arg1._cycleTick
    end

    t_2.unselected = t_4
    t_2.active = {
        Init = function(_) -- line: 34
        end,
        Get = function(arg9) -- line: 35
            return arg9.state.index.value == arg9.arguments.Index
        end
    }
    t_2.clicked = arg2.EVENTS.click(function(arg10) -- line: 39
        return arg10.Instance.SelectableButton
    end)
    t_2.rightClicked = arg2.EVENTS.rightClick(function(arg11) -- line: 43
        return arg11.Instance.SelectableButton
    end)
    t_2.doubleClicked = arg2.EVENTS.doubleClick(function(arg12) -- line: 47
        return arg12.Instance.SelectableButton
    end)
    t_2.ctrlClicked = arg2.EVENTS.ctrlClick(function(arg13) -- line: 51
        return arg13.Instance.SelectableButton
    end)
    t_2.hovered = arg2.EVENTS.hover(function(arg14) -- line: 55
        return arg14.Instance.SelectableButton
    end)
    t.Events = t_2

    function t.Generate(arg15) -- line: 60
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local IrisSelectable_Frame = Instance.new("Frame")
        IrisSelectable_Frame.Name = "Iris_Selectable"
        IrisSelectable_Frame.Size = UDim2.new(
            arg1._config.ItemWidth,
            UDim.new(0, arg1._config.TextSize)
        )
        IrisSelectable_Frame.AutomaticSize = Enum.AutomaticSize.None
        IrisSelectable_Frame.BackgroundTransparency = 1
        IrisSelectable_Frame.BorderSizePixel = 0
        IrisSelectable_Frame.ZIndex = arg15.ZIndex
        IrisSelectable_Frame.LayoutOrder = arg15.ZIndex
        local SelectableButton_TextButton = Instance.new("TextButton")
        SelectableButton_TextButton.Name = "SelectableButton"
        SelectableButton_TextButton.Size = UDim2.new(1, 0, 1, arg1._config.ItemSpacing.Y - 1)
        SelectableButton_TextButton.Position = UDim2.fromOffset(
            0,
            -bit32.rshift(arg1._config.ItemSpacing.Y, 1)
        )
        SelectableButton_TextButton.BackgroundColor3 = arg1._config.HeaderColor
        SelectableButton_TextButton.ZIndex = arg15.ZIndex + 1
        SelectableButton_TextButton.LayoutOrder = arg15.ZIndex + 1
        arg2.applyFrameStyle(SelectableButton_TextButton)
        arg2.applyTextStyle(SelectableButton_TextButton)
        arg15.ButtonColors = {
            ButtonColor = arg1._config.HeaderColor,
            ButtonTransparency = 1,
            ButtonHoveredColor = arg1._config.HeaderHoveredColor,
            ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency,
            ButtonActiveColor = arg1._config.HeaderActiveColor,
            ButtonActiveTransparency = arg1._config.HeaderActiveTransparency
        }
        arg2.applyInteractionHighlights(
            SelectableButton_TextButton,
            SelectableButton_TextButton,
            arg15.ButtonColors
        )
        SelectableButton_TextButton.MouseButton1Click:Connect(function() -- line: 92
            -- upvalues:
            --  [1] arg15 (copy)

            if arg15.arguments.NoClick ~= true then
                local v4 = arg15

                if type(v4.state.index.value) == "boolean" then
                    v4.state.index:set(not v4.state.index.value)

                    return
                end

                v4.state.index:set(v4.arguments.Index)
            end
        end)
        SelectableButton_TextButton.Parent = IrisSelectable_Frame

        return IrisSelectable_Frame
    end

    function t.Update(arg16) -- line: 102
        arg16.Instance.SelectableButton.Text = arg16.arguments.Text or "Selectable"
    end

    function t.Discard(arg17) -- line: 107
        -- upvalues:
        --  [1] arg2 (copy)

        arg17.Instance:Destroy()
        arg2.discardState(arg17)
    end

    function t.GenerateState(arg18) -- line: 111
        -- upvalues:
        --  [1] arg1 (copy)

        if arg18.state.index == nil then
            if arg18.arguments.Index ~= nil then
                error("a shared state index is required for Selectables with an Index argument", 5)
            end

            arg18.state.index = arg1._widgetState(arg18, "index", false)
        end
    end

    function t.UpdateState(arg19) -- line: 119
        -- upvalues:
        --  [1] arg1 (copy)

        local SelectableButton = arg19.Instance.SelectableButton

        if arg19.state.index.value == (arg19.arguments.Index or true) then
            arg19.ButtonColors.ButtonTransparency = arg1._config.HeaderTransparency
            SelectableButton.BackgroundTransparency = arg1._config.HeaderTransparency
            arg19.lastSelectedTick = arg1._cycleTick + 1

            return
        end

        arg19.ButtonColors.ButtonTransparency = 1
        SelectableButton.BackgroundTransparency = 1
        arg19.lastUnselectedTick = arg1._cycleTick + 1
    end

    WidgetConstructor("Selectable", t)
    local v5 = false
    local v6 = -1
    local v7 = nil

    local function UpdateChildContainerTransform(arg20) -- line: 138
        -- upvalues:
        --  [1] arg1 (copy)

        local PreviewContainer = arg20.Instance.PreviewContainer
        local PreviewLabel = PreviewContainer.PreviewLabel
        local ChildContainer = arg20.ChildContainer
        local v8 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
        local PopupBorderSize = arg1._config.PopupBorderSize
        local v9 = v8 * math.min(arg20.ComboChildrenHeight, 8) - PopupBorderSize * 2 + 3 * arg1._config.FramePadding.Y
        local udim = UDim.new(0, PreviewContainer.AbsoluteSize.X - PopupBorderSize * 2)
        ChildContainer.Size = UDim2.new(udim, UDim.new(0, v9))

        if PreviewLabel.AbsolutePosition.Y + v8 + v9 > ChildContainer.Parent.AbsoluteSize.Y then
            ChildContainer.Position = UDim2.new(
                0,
                PreviewLabel.AbsolutePosition.X + PopupBorderSize,
                0,
                PreviewLabel.AbsolutePosition.Y - PopupBorderSize - v9
            )

            return
        end

        ChildContainer.Position = UDim2.new(
            0,
            PreviewLabel.AbsolutePosition.X + PopupBorderSize,
            0,
            PreviewLabel.AbsolutePosition.Y + v8 + PopupBorderSize
        )
    end

    arg2.UserInputService.InputBegan:Connect(function(input_1: userdata) -- line: 161
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] v6 (ref)
        --  [3] arg1 (copy)
        --  [4] arg2 (copy)
        --  [5] v7 (ref)

        if input_1.UserInputType ~= Enum.UserInputType.MouseButton1 and (input_1.UserInputType ~= Enum.UserInputType.MouseButton2 and input_1.UserInputType ~= Enum.UserInputType.Touch) then
            return
        end

        if v5 == false then
            return
        end

        if v6 == arg1._cycleTick then
            return
        end

        local v10 = arg2.getMouseLocation()
        local ChildContainer_1 = v7.ChildContainer

        if not arg2.isPosInsideRect(
            v10,
            ChildContainer_1.AbsolutePosition - Vector2.new(0, v7.LabelHeight),
            ChildContainer_1.AbsolutePosition + ChildContainer_1.AbsoluteSize
        ) then
            v7.state.isOpened:set(false)
        end
    end)
    local t_7 = {
        hasState = true,
        hasChildren = true,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        ChildAdded = nil,
        ChildDiscarded = nil,
        GenerateState = nil,
        UpdateState = nil,
        Discard = nil
    }
    local WidgetConstructor_1 = arg1.WidgetConstructor
    t_7.Args = { Text = 1, NoButton = 2, NoPreview = 3 }
    local t_9 = {}
    local t_10 = {
        Init = function(_) -- line: 190
        end
    }

    function t_10.Get(arg22) -- line: 191
        -- upvalues:
        --  [1] arg1 (copy)

        return arg22.lastOpenedTick == arg1._cycleTick
    end

    t_9.opened = t_10
    local t_11 = {
        Init = function(_) -- line: 196
        end
    }

    function t_11.Get(arg24) -- line: 197
        -- upvalues:
        --  [1] arg1 (copy)

        return arg24.lastClosedTick == arg1._cycleTick
    end

    t_9.closed = t_11
    t_9.clicked = arg2.EVENTS.click(function(arg25) -- line: 201
        return arg25.Instance
    end)
    t_9.hovered = arg2.EVENTS.hover(function(arg26) -- line: 204
        return arg26.Instance
    end)
    t_7.Events = t_9

    function t_7.Generate(arg27) -- line: 208
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)
        --  [3] v5 (ref)
        --  [4] v7 (ref)

        local v13 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
        arg27.ComboChildrenHeight = 0
        local Frame_1 = Instance.new("Frame")
        Frame_1.Name = "Iris_Combo"
        Frame_1.Size = UDim2.fromScale(1, 0)
        Frame_1.AutomaticSize = Enum.AutomaticSize.Y
        Frame_1.BackgroundTransparency = 1
        Frame_1.BorderSizePixel = 0
        Frame_1.ZIndex = arg27.ZIndex
        Frame_1.LayoutOrder = arg27.ZIndex
        arg2.UIListLayout(
            Frame_1,
            Enum.FillDirection.Horizontal,
            UDim.new(0, arg1._config.ItemInnerSpacing.Y + 1)
        )
        local TextButton_1 = Instance.new("TextButton")
        TextButton_1.Name = "PreviewContainer"
        TextButton_1.Size = UDim2.new(arg1._config.ContentWidth, UDim.new(0, 0))
        TextButton_1.AutomaticSize = Enum.AutomaticSize.Y
        TextButton_1.BackgroundTransparency = 1
        TextButton_1.Text = ""
        TextButton_1.ZIndex = arg27.ZIndex + 2
        TextButton_1.LayoutOrder = arg27.ZIndex + 2
        TextButton_1.AutoButtonColor = false
        arg2.applyFrameStyle(TextButton_1, true, true)
        arg2.UIListLayout(TextButton_1, Enum.FillDirection.Horizontal, UDim.new(0, 0))
        TextButton_1.Parent = Frame_1
        local PreviewLabel_TextLabel = Instance.new("TextLabel")
        PreviewLabel_TextLabel.Name = "PreviewLabel"
        PreviewLabel_TextLabel.Size = UDim2.new(1, 0, 0, 0)
        PreviewLabel_TextLabel.AutomaticSize = Enum.AutomaticSize.Y
        PreviewLabel_TextLabel.BackgroundColor3 = arg1._config.FrameBgColor
        PreviewLabel_TextLabel.BackgroundTransparency = arg1._config.FrameBgTransparency
        PreviewLabel_TextLabel.BorderSizePixel = 0
        PreviewLabel_TextLabel.ZIndex = arg27.ZIndex + 3
        PreviewLabel_TextLabel.LayoutOrder = arg27.ZIndex + 3
        arg2.applyTextStyle(PreviewLabel_TextLabel)
        arg2.UIPadding(PreviewLabel_TextLabel, arg1._config.FramePadding)
        PreviewLabel_TextLabel.Parent = TextButton_1
        local TextLabel_1 = Instance.new("TextLabel")
        TextLabel_1.Name = "DropdownButton"
        TextLabel_1.Size = UDim2.new(0, v13, 0, v13)
        TextLabel_1.BorderSizePixel = 0
        TextLabel_1.BackgroundColor3 = arg1._config.ButtonColor
        TextLabel_1.BackgroundTransparency = arg1._config.ButtonTransparency
        TextLabel_1.Text = ""
        TextLabel_1.ZIndex = arg27.ZIndex + 4
        TextLabel_1.LayoutOrder = arg27.ZIndex + 4
        local v14 = math.round(v13 * 0.2)
        local v15 = v13 - v14 * 2
        local Dropdown_ImageLabel = Instance.new("ImageLabel")
        Dropdown_ImageLabel.Name = "Dropdown"
        Dropdown_ImageLabel.Size = UDim2.fromOffset(v15, v15)
        Dropdown_ImageLabel.Position = UDim2.fromOffset(v14, v14)
        Dropdown_ImageLabel.BackgroundTransparency = 1
        Dropdown_ImageLabel.BorderSizePixel = 0
        Dropdown_ImageLabel.ImageColor3 = arg1._config.TextColor
        Dropdown_ImageLabel.ImageTransparency = arg1._config.TextTransparency
        Dropdown_ImageLabel.ZIndex = arg27.ZIndex + 5
        Dropdown_ImageLabel.LayoutOrder = arg27.ZIndex + 5
        Dropdown_ImageLabel.Parent = TextLabel_1
        TextLabel_1.Parent = TextButton_1
        arg2.applyInteractionHighlightsWithMultiHighlightee(
            TextButton_1,
            {
                {
                    PreviewLabel_TextLabel,
                    {
                        ButtonColor = arg1._config.FrameBgColor,
                        ButtonTransparency = arg1._config.FrameBgTransparency,
                        ButtonHoveredColor = arg1._config.FrameBgHoveredColor,
                        ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency,
                        ButtonActiveColor = arg1._config.FrameBgActiveColor,
                        ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency
                    }
                },
                {
                    TextLabel_1,
                    {
                        ButtonColor = arg1._config.ButtonColor,
                        ButtonTransparency = arg1._config.ButtonTransparency,
                        ButtonHoveredColor = arg1._config.ButtonHoveredColor,
                        ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency,
                        ButtonActiveColor = arg1._config.ButtonHoveredColor,
                        ButtonActiveTransparency = arg1._config.ButtonHoveredColor
                    }
                }
            }
        )
        TextButton_1.InputBegan:Connect(function(input) -- line: 308
            -- upvalues:
            --  [1] v5 (ref)
            --  [2] v7 (ref)
            --  [3] arg27 (copy)

            if v5 and v7 ~= arg27 then
                return
            end

            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                arg27.state.isOpened:set(not arg27.state.isOpened.value)
            end
        end)
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Name = "TextLabel"
        TextLabel_2.Size = UDim2.fromOffset(0, v13)
        TextLabel_2.AutomaticSize = Enum.AutomaticSize.X
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.BorderSizePixel = 0
        TextLabel_2.ZIndex = arg27.ZIndex + 5
        TextLabel_2.LayoutOrder = arg27.ZIndex + 5
        arg2.applyTextStyle(TextLabel_2)
        TextLabel_2.Parent = Frame_1
        local ChildContainer_ScrollingFrame = Instance.new("ScrollingFrame")
        ChildContainer_ScrollingFrame.Name = "ChildContainer"
        ChildContainer_ScrollingFrame.BackgroundColor3 = arg1._config.WindowBgColor
        ChildContainer_ScrollingFrame.BackgroundTransparency = arg1._config.WindowBgTransparency
        ChildContainer_ScrollingFrame.BorderSizePixel = 0
        ChildContainer_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        ChildContainer_ScrollingFrame.ScrollBarImageTransparency = arg1._config.ScrollbarGrabTransparency
        ChildContainer_ScrollingFrame.ScrollBarImageColor3 = arg1._config.ScrollbarGrabColor
        ChildContainer_ScrollingFrame.ScrollBarThickness = arg1._config.ScrollbarSize
        ChildContainer_ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0)
        ChildContainer_ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        ChildContainer_ScrollingFrame.ZIndex = arg27.ZIndex + 6
        ChildContainer_ScrollingFrame.LayoutOrder = arg27.ZIndex + 6
        ChildContainer_ScrollingFrame.ClipsDescendants = true
        arg2.UIStroke(
            ChildContainer_ScrollingFrame,
            arg1._config.WindowBorderSize,
            arg1._config.BorderColor,
            arg1._config.BorderTransparency
        )
        arg2.UIPadding(
            ChildContainer_ScrollingFrame,
            Vector2.new(2, 2 * arg1._config.FramePadding.Y)
        )
        arg2.UIListLayout(
            ChildContainer_ScrollingFrame,
            Enum.FillDirection.Vertical,
            UDim.new(0, arg1._config.ItemSpacing.Y)
        ).VerticalAlignment = Enum.VerticalAlignment.Top
        local v16 = arg1._rootInstance

        if v16 then
            v16 = arg1._rootInstance:WaitForChild("PopupScreenGui")
        end

        ChildContainer_ScrollingFrame.Parent = v16
        arg27.ChildContainer = ChildContainer_ScrollingFrame

        return Frame_1
    end

    function t_7.Update(arg29) -- line: 365
        -- upvalues:
        --  [1] arg1 (copy)

        local v17 = arg29.Instance
        local PreviewContainer_1 = v17.PreviewContainer
        local PreviewLabel_1 = PreviewContainer_1.PreviewLabel
        local DropdownButton = PreviewContainer_1.DropdownButton
        v17.TextLabel.Text = arg29.arguments.Text or "Combo"

        if arg29.arguments.NoButton then
            DropdownButton.Visible = false
            PreviewLabel_1.Size = UDim2.new(1, 0, 0, 0)
        else
            DropdownButton.Visible = true
            PreviewLabel_1.Size = UDim2.new(
                1,
                -(arg1._config.TextSize + 2 * arg1._config.FramePadding.Y),
                0,
                0
            )
        end

        if arg29.arguments.NoPreview then
            PreviewLabel_1.Visible = false
            PreviewContainer_1.Size = UDim2.new(0, 0, 0, 0)
            PreviewContainer_1.AutomaticSize = Enum.AutomaticSize.X

            return
        end

        PreviewLabel_1.Visible = true
        PreviewContainer_1.Size = UDim2.new(arg1._config.ContentWidth, UDim.new(0, 0))
        PreviewContainer_1.AutomaticSize = Enum.AutomaticSize.Y
    end

    function t_7.ChildAdded(arg30, arg31) -- line: 393
        -- upvalues:
        --  [1] UpdateChildContainerTransform (copy)

        if arg31.type ~= "Selectable" then
            arg30.ComboChildrenHeight += 10
        else
            arg30.ComboChildrenHeight += 1
        end

        UpdateChildContainerTransform(arg30)

        return arg30.ChildContainer
    end

    function t_7.ChildDiscarded(arg32, arg33) -- line: 403
        if arg33.type ~= "Selectable" then
            arg32.ComboChildrenHeight -= 10

            return
        end

        arg32.ComboChildrenHeight -= 1
    end

    function t_7.GenerateState(arg34) -- line: 410
        -- upvalues:
        --  [1] arg1 (copy)

        if arg34.state.index == nil then
            arg34.state.index = arg1._widgetState(arg34, "index", "No Selection")
        end

        arg34.state.index:onChange(function() -- line: 414
            -- upvalues:
            --  [1] arg34 (copy)

            if arg34.state.isOpened.value then
                arg34.state.isOpened:set(false)
            end
        end)

        if arg34.state.isOpened == nil then
            arg34.state.isOpened = arg1._widgetState(arg34, "isOpened", false)
        end
    end

    function t_7.UpdateState(arg35) -- line: 423
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] v7 (ref)
        --  [3] v6 (ref)
        --  [4] arg1 (copy)
        --  [5] arg2 (copy)
        --  [6] UpdateChildContainerTransform (copy)

        local PreviewContainer_2 = arg35.Instance.PreviewContainer
        local Dropdown = PreviewContainer_2.DropdownButton.Dropdown
        local ChildContainer_2 = arg35.ChildContainer
        local PreviewLabel_2 = PreviewContainer_2.PreviewLabel

        if arg35.state.isOpened.value then
            v5 = true
            v7 = arg35
            v6 = arg1._cycleTick
            arg35.lastOpenedTick = arg1._cycleTick + 1
            Dropdown.Image = arg2.ICONS.RIGHT_POINTING_TRIANGLE
            ChildContainer_2.Visible = true
            UpdateChildContainerTransform(arg35)
        else
            if v5 then
                v5 = false
                v7 = nil
                arg35.lastClosedTick = arg1._cycleTick + 1
            end

            Dropdown.Image = arg2.ICONS.DOWN_POINTING_TRIANGLE
            ChildContainer_2.Visible = false
        end

        local Value = arg35.state.index.value
        PreviewLabel_2.Text = if typeof(Value) == "EnumItem" then Value.Name else tostring(Value)
    end

    function t_7.Discard(arg36) -- line: 455
        -- upvalues:
        --  [1] arg2 (copy)

        arg36.Instance:Destroy()
        arg2.discardState(arg36)
    end

    WidgetConstructor_1("Combo", t_7)
end
