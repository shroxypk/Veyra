-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Menu
-- Class: ModuleScript
-- bytes: 27449

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local v1 = false
    local v2 = nil
    local t = {}

    local function EmptyMenuStack(n1: number?) -- line: 8
        -- upvalues:
        --  [1] t (copy)
        --  [2] arg1 (copy)
        --  [3] v1 (ref)
        --  [4] v2 (ref)

        local v3 = #t
        local v4 = n1 and n1 + 1 or 1

        for index = v3, v4, -1 do
            local v5 = t[index]
            v5.state.isOpened:set(false)
            v5.Instance.BackgroundColor3 = arg1._config.HeaderColor
            v5.Instance.BackgroundTransparency = 1
            table.remove(t, index)
        end

        if #t == 0 then
            v1 = false
            v2 = nil
        end
    end

    local function UpdateChildContainerTransform(arg3) -- line: 25
        -- upvalues:
        --  [1] arg1 (copy)

        local v6 = arg3.parentWidget.type == "Menu"
        local v7 = arg3.Instance
        local ChildContainer = arg3.ChildContainer
        ChildContainer.Size = UDim2.fromOffset(
            math.max(ChildContainer.AbsoluteSize.X, v7.AbsoluteSize.X),
            (math.max(ChildContainer.AbsoluteSize.Y, v7.AbsoluteSize.Y))
        )

        if ChildContainer.Parent == nil then
            return
        end

        local AbsolutePosition = v7.AbsolutePosition
        local AbsoluteSize = v7.AbsoluteSize
        local AbsoluteSize_1 = ChildContainer.AbsoluteSize
        local PopupBorderSize = arg1._config.PopupBorderSize
        local AbsoluteSize_2 = ChildContainer.Parent.AbsoluteSize
        local v9 = AbsolutePosition.X + PopupBorderSize

        if arg3.parentWidget.type == "Menu" then
            local v10

            if AbsolutePosition.X + AbsoluteSize_1.X > AbsoluteSize_2.X then
                v10 = v6 and AbsoluteSize_1.X or 0
                v9 = AbsolutePosition.X - PopupBorderSize - v10
            else
                v10 = v6 and AbsoluteSize.X or 0
                v9 = AbsolutePosition.X + PopupBorderSize + v10
            end
        end

        local v11, v12

        if AbsolutePosition.Y + AbsoluteSize_1.Y > AbsoluteSize_2.Y then
            v11 = v6 and AbsoluteSize.Y or 0
            v12 = AbsolutePosition.Y - PopupBorderSize - AbsoluteSize_1.Y + v11
        else
            v11 = if not v6 then AbsoluteSize.Y else 0
            v12 = AbsolutePosition.Y + PopupBorderSize + v11
        end

        ChildContainer.Position = UDim2.fromOffset(v9, v12)
    end

    arg2.UserInputService.InputBegan:Connect(function(input: userdata) -- line: 62
        -- upvalues:
        --  [1] v1 (ref)
        --  [2] v2 (ref)
        --  [3] arg2 (copy)
        --  [4] t (copy)
        --  [5] EmptyMenuStack (copy)

        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return
        end

        if v1 == false then
            return
        end

        if v2 == nil then
            return
        end

        local v13 = false
        local v14 = arg2.getMouseLocation()

        for _, val in t do
            for _, val_1 in { val.ChildContainer, val.Instance } do
                local AbsolutePosition_1 = val_1.AbsolutePosition

                if arg2.isPosInsideRect(
                    v14,
                    AbsolutePosition_1,
                    AbsolutePosition_1 + val_1.AbsoluteSize
                ) then
                    v13 = true
                    break
                end
            end
        end

        if not v13 then
            EmptyMenuStack()
        end
    end)
    local t_1 = {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = nil,
        Update = nil,
        ChildAdded = nil,
        Discard = nil
    }

    function t_1.Generate(arg4) -- line: 97
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local MenuBar_Frame = Instance.new("Frame")
        MenuBar_Frame.Name = "MenuBar"
        MenuBar_Frame.Size = UDim2.fromScale(1, 0)
        MenuBar_Frame.AutomaticSize = Enum.AutomaticSize.Y
        MenuBar_Frame.BackgroundColor3 = arg1._config.MenubarBgColor
        MenuBar_Frame.BackgroundTransparency = arg1._config.MenubarBgTransparency
        MenuBar_Frame.BorderSizePixel = 0
        MenuBar_Frame.ZIndex = arg4.ZIndex
        MenuBar_Frame.LayoutOrder = arg4.ZIndex
        MenuBar_Frame.ClipsDescendants = true
        arg2.UIPadding(MenuBar_Frame, Vector2.new(arg1._config.ItemSpacing.X, 2))
        arg2.UIListLayout(MenuBar_Frame, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center

        return MenuBar_Frame
    end

    function t_1.Update(arg5) -- line: 114
        -- upvalues:
        --  [1] arg1 (copy)

        local ParentWidget = arg5.parentWidget

        if ParentWidget.type == "Window" then
            local v16 = ParentWidget.Instance

            if v16 then
                v16 = ParentWidget.Instance:FindFirstChild("WindowButton")
            end

            if v16 then
                arg5.Instance.Parent = v16
                local v17 = #arg1._postCycleCallbacks + 1
                local v18 = arg1._cycleTick + 1

                arg1._postCycleCallbacks[v17] = function() -- line: 125
                    -- upvalues:
                    --  [1] arg1 (ref)
                    --  [2] v18 (copy)
                    --  [3] ParentWidget (copy)
                    --  [4] v17 (copy)

                    if arg1._cycleTick == v18 then
                        arg1._widgets.Window.Update(ParentWidget)
                        arg1._postCycleCallbacks[v17] = nil
                    end
                end
            end

            return
        end

        if ParentWidget.type == "Root" then
            return
        end

        error("The MenuBar was not created directly under a window or root.")
    end

    local WidgetConstructor = arg1.WidgetConstructor

    function t_1.ChildAdded(arg6) -- line: 139
        return arg6.Instance
    end

    function t_1.Discard(arg7) -- line: 142
        -- upvalues:
        --  [1] arg1 (copy)

        local ParentWidget_1 = arg7.parentWidget
        arg7.Instance:Destroy()
        arg1._widgets.Window.Update(ParentWidget_1)
    end

    WidgetConstructor("MenuBar", t_1)
    local t_2 = {
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
    t_2.Args = { Text = 1 }
    local t_4 = {
        clicked = arg2.EVENTS.click(function(arg8) -- line: 157
            return arg8.Instance
        end),
        hovered = arg2.EVENTS.hover(function(arg9) -- line: 160
            return arg9.Instance
        end)
    }
    local t_5 = {
        Init = function(_) -- line: 164
        end
    }

    function t_5.Get(arg11) -- line: 165
        -- upvalues:
        --  [1] arg1 (copy)

        return arg11.lastOpenedTick == arg1._cycleTick
    end

    t_4.opened = t_5
    local t_6 = {
        Init = function(_) -- line: 170
        end
    }

    function t_6.Get(arg13) -- line: 171
        -- upvalues:
        --  [1] arg1 (copy)

        return arg13.lastClosedTick == arg1._cycleTick
    end

    t_4.closed = t_6
    t_2.Events = t_4

    function t_2.Generate(arg14) -- line: 176
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)
        --  [3] t (copy)
        --  [4] v1 (ref)
        --  [5] v2 (ref)
        --  [6] EmptyMenuStack (copy)

        arg14.ButtonColors = {
            ButtonColor = arg1._config.HeaderColor,
            ButtonTransparency = 1,
            ButtonHoveredColor = arg1._config.HeaderHoveredColor,
            ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency,
            ButtonActiveColor = arg1._config.HeaderHoveredColor,
            ButtonActiveTransparency = arg1._config.HeaderHoveredTransparency
        }
        local Menu_TextButton

        if arg14.parentWidget.type == "Menu" then
            Menu_TextButton = Instance.new("TextButton")
            Menu_TextButton.Name = "Menu"
            Menu_TextButton.BackgroundColor3 = arg1._config.HeaderColor
            Menu_TextButton.BackgroundTransparency = 1
            Menu_TextButton.BorderSizePixel = 0
            Menu_TextButton.Size = UDim2.fromScale(1, 0)
            Menu_TextButton.Text = ""
            Menu_TextButton.AutomaticSize = Enum.AutomaticSize.Y
            Menu_TextButton.ZIndex = arg14.ZIndex
            Menu_TextButton.LayoutOrder = arg14.ZIndex
            Menu_TextButton.AutoButtonColor = false
            local v22 = arg2.UIPadding(Menu_TextButton, arg1._config.FramePadding)
            v22.PaddingTop = v22.PaddingTop - UDim.new(0, 1)
            arg2.UIListLayout(
                Menu_TextButton,
                Enum.FillDirection.Horizontal,
                UDim.new(0, arg1._config.ItemInnerSpacing.X)
            ).VerticalAlignment = Enum.VerticalAlignment.Center
            local TextLabel = Instance.new("TextLabel")
            TextLabel.Name = "TextLabel"
            TextLabel.AnchorPoint = Vector2.new(0, 0)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            TextLabel.ZIndex = arg14.ZIndex + 2
            TextLabel.LayoutOrder = arg14.ZIndex + 2
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY
            arg2.applyTextStyle(TextLabel)
            TextLabel.Parent = Menu_TextButton
            local v24 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
            local v25 = v24 - math.round(v24 * 0.2) * 2
            local Icon_ImageLabel = Instance.new("ImageLabel")
            Icon_ImageLabel.Name = "Icon"
            Icon_ImageLabel.Size = UDim2.fromOffset(v25, v25)
            Icon_ImageLabel.BackgroundTransparency = 1
            Icon_ImageLabel.BorderSizePixel = 0
            Icon_ImageLabel.ImageColor3 = arg1._config.TextColor
            Icon_ImageLabel.ImageTransparency = arg1._config.TextTransparency
            Icon_ImageLabel.Image = arg2.ICONS.RIGHT_POINTING_TRIANGLE
            Icon_ImageLabel.ZIndex = arg14.ZIndex + 3
            Icon_ImageLabel.LayoutOrder = arg14.ZIndex + 3
            Icon_ImageLabel.Parent = Menu_TextButton
        else
            Menu_TextButton = Instance.new("TextButton")
            Menu_TextButton.Name = "Menu"
            Menu_TextButton.Size = UDim2.fromScale(0, 0)
            Menu_TextButton.AutomaticSize = Enum.AutomaticSize.XY
            Menu_TextButton.BackgroundColor3 = arg1._config.HeaderColor
            Menu_TextButton.BackgroundTransparency = 1
            Menu_TextButton.BorderSizePixel = 0
            Menu_TextButton.Text = ""
            Menu_TextButton.LayoutOrder = arg14.ZIndex
            Menu_TextButton.ZIndex = arg14.ZIndex
            Menu_TextButton.AutoButtonColor = false
            Menu_TextButton.ClipsDescendants = true
            arg2.applyTextStyle(Menu_TextButton)
            arg2.UIPadding(
                Menu_TextButton,
                Vector2.new(arg1._config.ItemSpacing.X, arg1._config.FramePadding.Y)
            )
        end

        arg2.applyInteractionHighlights(Menu_TextButton, Menu_TextButton, arg14.ButtonColors)
        Menu_TextButton.MouseButton1Click:Connect(function() -- line: 252
            -- upvalues:
            --  [1] t (ref)
            --  [2] arg14 (copy)
            --  [3] v1 (ref)
            --  [4] v2 (ref)

            local v26 = if #t <= 1 then not arg14.state.isOpened.value else true
            arg14.state.isOpened:set(v26)
            v1 = v26
            v2 = v26 and arg14 or nil

            if #t <= 1 then
                if v26 then
                    table.insert(t, arg14)

                    return
                end

                table.remove(t)
            end
        end)
        Menu_TextButton.MouseEnter:Connect(function() -- line: 267
            -- upvalues:
            --  [1] v1 (ref)
            --  [2] v2 (ref)
            --  [3] arg14 (copy)
            --  [4] t (ref)
            --  [5] EmptyMenuStack (ref)

            if v1 and v2 and v2 ~= arg14 then
                EmptyMenuStack((table.find(t, arg14.parentWidget)))
                arg14.state.isOpened:set(true)
                v2 = arg14
                v1 = true
                table.insert(t, arg14)
            end
        end)
        local ChildContainer_ScrollingFrame = Instance.new("ScrollingFrame")
        ChildContainer_ScrollingFrame.Name = "ChildContainer"
        ChildContainer_ScrollingFrame.BackgroundColor3 = arg1._config.WindowBgColor
        ChildContainer_ScrollingFrame.BackgroundTransparency = arg1._config.WindowBgTransparency
        ChildContainer_ScrollingFrame.BorderSizePixel = 0
        ChildContainer_ScrollingFrame.Size = UDim2.fromOffset(0, 0)
        ChildContainer_ScrollingFrame.AutomaticSize = Enum.AutomaticSize.XY
        ChildContainer_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        ChildContainer_ScrollingFrame.ScrollBarImageTransparency = arg1._config.ScrollbarGrabTransparency
        ChildContainer_ScrollingFrame.ScrollBarImageColor3 = arg1._config.ScrollbarGrabColor
        ChildContainer_ScrollingFrame.ScrollBarThickness = arg1._config.ScrollbarSize
        ChildContainer_ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0)
        ChildContainer_ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        ChildContainer_ScrollingFrame.ZIndex = arg14.ZIndex + 6
        ChildContainer_ScrollingFrame.LayoutOrder = arg14.ZIndex + 6
        ChildContainer_ScrollingFrame.ClipsDescendants = true
        arg2.UIListLayout(
            ChildContainer_ScrollingFrame,
            Enum.FillDirection.Vertical,
            UDim.new(0, 1)
        ).VerticalAlignment = Enum.VerticalAlignment.Top
        local v29 = arg1._rootInstance

        if v29 then
            v29 = arg1._rootInstance:FindFirstChild("PopupScreenGui")
        end

        ChildContainer_ScrollingFrame.Parent = v29
        arg14.ChildContainer = ChildContainer_ScrollingFrame
        arg2.UIStroke(
            ChildContainer_ScrollingFrame,
            arg1._config.WindowBorderSize,
            arg1._config.BorderColor,
            arg1._config.BorderTransparency
        )
        arg2.UIPadding(
            ChildContainer_ScrollingFrame,
            Vector2.new(2, arg1._config.WindowPadding.Y - arg1._config.ItemSpacing.Y)
        )

        return Menu_TextButton
    end

    function t_2.Update(arg15) -- line: 316
        local v30 = arg15.Instance
        local v31 = if arg15.parentWidget.type ~= "Menu" then v30 else v30.TextLabel
        v31.Text = arg15.arguments.Text or "Menu"
    end

    function t_2.ChildAdded(arg16, _) -- line: 326
        -- upvalues:
        --  [1] UpdateChildContainerTransform (copy)

        UpdateChildContainerTransform(arg16)

        return arg16.ChildContainer
    end

    function t_2.ChildDiscarded(arg18, _) -- line: 330
        -- upvalues:
        --  [1] UpdateChildContainerTransform (copy)

        UpdateChildContainerTransform(arg18)
    end

    function t_2.GenerateState(arg20) -- line: 333
        -- upvalues:
        --  [1] arg1 (copy)

        if arg20.state.isOpened == nil then
            arg20.state.isOpened = arg1._widgetState(arg20, "isOpened", false)
        end
    end

    function t_2.UpdateState(arg21) -- line: 338
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] UpdateChildContainerTransform (copy)

        local ChildContainer_1 = arg21.ChildContainer

        if arg21.state.isOpened.value then
            arg21.lastOpenedTick = arg1._cycleTick + 1
            arg21.ButtonColors.ButtonTransparency = arg1._config.HeaderTransparency
            ChildContainer_1.Visible = true
            UpdateChildContainerTransform(arg21)

            return
        end

        arg21.lastClosedTick = arg1._cycleTick + 1
        arg21.ButtonColors.ButtonTransparency = 1
        ChildContainer_1.Visible = false
    end

    function t_2.Discard(arg22) -- line: 353
        -- upvalues:
        --  [1] arg2 (copy)

        arg22.Instance:Destroy()
        arg2.discardState(arg22)
    end

    WidgetConstructor_1("Menu", t_2)
    local t_8 = {
        hasState = false,
        hasChildren = false,
        Args = { Text = 1, KeyCode = 2, ModifierKey = 3 },
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil
    }
    local t_9 = {
        clicked = arg2.EVENTS.click(function(arg23) -- line: 368
            return arg23.Instance
        end),
        hovered = arg2.EVENTS.hover(function(arg24) -- line: 371
            return arg24.Instance
        end)
    }
    local WidgetConstructor_2 = arg1.WidgetConstructor
    t_8.Events = t_9

    function t_8.Generate(arg25) -- line: 375
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)
        --  [3] EmptyMenuStack (copy)
        --  [4] v1 (ref)
        --  [5] v2 (ref)
        --  [6] t (copy)

        local MenuItem_TextButton = Instance.new("TextButton")
        MenuItem_TextButton.Name = "MenuItem"
        MenuItem_TextButton.BackgroundTransparency = 1
        MenuItem_TextButton.BorderSizePixel = 0
        MenuItem_TextButton.Size = UDim2.fromScale(1, 0)
        MenuItem_TextButton.Text = ""
        MenuItem_TextButton.AutomaticSize = Enum.AutomaticSize.Y
        MenuItem_TextButton.ZIndex = arg25.ZIndex
        MenuItem_TextButton.LayoutOrder = arg25.ZIndex
        MenuItem_TextButton.AutoButtonColor = false
        local v32 = arg2.UIPadding(MenuItem_TextButton, arg1._config.FramePadding)
        v32.PaddingTop = v32.PaddingTop - UDim.new(0, 1)
        arg2.UIListLayout(
            MenuItem_TextButton,
            Enum.FillDirection.Horizontal,
            UDim.new(0, arg1._config.ItemInnerSpacing.X)
        )
        arg2.applyInteractionHighlights(
            MenuItem_TextButton,
            MenuItem_TextButton,
            {
                ButtonColor = arg1._config.HeaderColor,
                ButtonTransparency = 1,
                ButtonHoveredColor = arg1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency,
                ButtonActiveColor = arg1._config.HeaderHoveredColor,
                ButtonActiveTransparency = arg1._config.HeaderHoveredTransparency
            }
        )
        MenuItem_TextButton.MouseButton1Click:Connect(function() -- line: 400
            -- upvalues:
            --  [1] EmptyMenuStack (ref)

            EmptyMenuStack()
        end)
        MenuItem_TextButton.MouseEnter:Connect(function() -- line: 404
            -- upvalues:
            --  [1] arg25 (copy)
            --  [2] v1 (ref)
            --  [3] v2 (ref)
            --  [4] t (ref)
            --  [5] EmptyMenuStack (ref)

            local ParentWidget_2 = arg25.parentWidget

            if v1 and v2 and v2 ~= ParentWidget_2 then
                EmptyMenuStack((table.find(t, ParentWidget_2)))
                v2 = ParentWidget_2
                v1 = true
            end
        end)
        local TextLabel_1 = Instance.new("TextLabel")
        TextLabel_1.Name = "TextLabel"
        TextLabel_1.AnchorPoint = Vector2.new(0, 0)
        TextLabel_1.BackgroundTransparency = 1
        TextLabel_1.BorderSizePixel = 0
        TextLabel_1.ZIndex = arg25.ZIndex + 2
        TextLabel_1.LayoutOrder = arg25.ZIndex + 2
        TextLabel_1.AutomaticSize = Enum.AutomaticSize.XY
        arg2.applyTextStyle(TextLabel_1)
        TextLabel_1.Parent = MenuItem_TextButton
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Name = "Shortcut"
        TextLabel_2.AnchorPoint = Vector2.new(0, 0)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.BorderSizePixel = 0
        TextLabel_2.ZIndex = arg25.ZIndex + 3
        TextLabel_2.LayoutOrder = arg25.ZIndex + 3
        TextLabel_2.AutomaticSize = Enum.AutomaticSize.XY
        arg2.applyTextStyle(TextLabel_2)
        TextLabel_2.Text = ""
        TextLabel_2.TextColor3 = arg1._config.TextDisabledColor
        TextLabel_2.TextTransparency = arg1._config.TextDisabledTransparency
        TextLabel_2.Parent = MenuItem_TextButton

        return MenuItem_TextButton
    end

    function t_8.Update(arg26) -- line: 447
        local v33 = arg26.Instance
        local Shortcut = v33.Shortcut
        v33.TextLabel.Text = arg26.arguments.Text

        if arg26.arguments.KeyCode then
            Shortcut.Text = arg26.arguments.ModifierKey.Name .. " + " .. arg26.arguments.KeyCode.Name
        end
    end

    function t_8.Discard(arg27) -- line: 457
        arg27.Instance:Destroy()
    end

    WidgetConstructor_2("MenuItem", t_8)
    local t_11 = {
        hasState = true,
        hasChildren = false,
        Args = { Text = 1, KeyCode = 2, ModifierKey = 3 },
        Events = nil,
        Generate = nil,
        GenerateState = nil,
        Update = nil,
        UpdateState = nil,
        Discard = nil
    }
    local t_12 = {}
    local t_13 = {
        Init = function(_) -- line: 472
        end
    }

    function t_13.Get(arg29) -- line: 473
        -- upvalues:
        --  [1] arg1 (copy)

        return arg29.lastCheckedTick == arg1._cycleTick
    end

    local WidgetConstructor_3 = arg1.WidgetConstructor
    t_12.checked = t_13
    local t_14 = {
        Init = function(_) -- line: 478
        end
    }

    function t_14.Get(arg31) -- line: 479
        -- upvalues:
        --  [1] arg1 (copy)

        return arg31.lastUncheckedTick == arg1._cycleTick
    end

    t_12.unchecked = t_14
    t_12.hovered = arg2.EVENTS.hover(function(arg32) -- line: 483
        return arg32.Instance
    end)
    t_11.Events = t_12

    function t_11.Generate(arg33) -- line: 487
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)
        --  [3] EmptyMenuStack (copy)
        --  [4] v1 (ref)
        --  [5] v2 (ref)
        --  [6] t (copy)

        local TextButton_1 = Instance.new("TextButton")
        TextButton_1.Name = "MenuItem"
        TextButton_1.BackgroundTransparency = 1
        TextButton_1.BorderSizePixel = 0
        TextButton_1.Size = UDim2.fromScale(1, 0)
        TextButton_1.Text = ""
        TextButton_1.AutomaticSize = Enum.AutomaticSize.Y
        TextButton_1.ZIndex = arg33.ZIndex
        TextButton_1.LayoutOrder = arg33.ZIndex
        TextButton_1.AutoButtonColor = false
        local v36 = arg2.UIPadding(TextButton_1, arg1._config.FramePadding)
        v36.PaddingTop = v36.PaddingTop - UDim.new(0, 1)
        arg2.UIListLayout(
            TextButton_1,
            Enum.FillDirection.Horizontal,
            UDim.new(0, arg1._config.ItemInnerSpacing.X)
        ).VerticalAlignment = Enum.VerticalAlignment.Center
        arg2.applyInteractionHighlights(
            TextButton_1,
            TextButton_1,
            {
                ButtonColor = arg1._config.HeaderColor,
                ButtonTransparency = 1,
                ButtonHoveredColor = arg1._config.HeaderHoveredColor,
                ButtonHoveredTransparency = arg1._config.HeaderHoveredTransparency,
                ButtonActiveColor = arg1._config.HeaderHoveredColor,
                ButtonActiveTransparency = arg1._config.HeaderHoveredTransparency
            }
        )
        TextButton_1.MouseButton1Click:Connect(function() -- line: 512
            -- upvalues:
            --  [1] arg33 (copy)
            --  [2] EmptyMenuStack (ref)

            arg33.state.isChecked:set(not arg33.state.isChecked.value)
            EmptyMenuStack()
        end)
        TextButton_1.MouseEnter:Connect(function() -- line: 518
            -- upvalues:
            --  [1] arg33 (copy)
            --  [2] v1 (ref)
            --  [3] v2 (ref)
            --  [4] t (ref)
            --  [5] EmptyMenuStack (ref)

            local ParentWidget_3 = arg33.parentWidget

            if v1 and v2 and v2 ~= ParentWidget_3 then
                EmptyMenuStack((table.find(t, ParentWidget_3)))
                v2 = ParentWidget_3
                v1 = true
            end
        end)
        local TextLabel_3 = Instance.new("TextLabel")
        TextLabel_3.Name = "TextLabel"
        TextLabel_3.AnchorPoint = Vector2.new(0, 0)
        TextLabel_3.BackgroundTransparency = 1
        TextLabel_3.BorderSizePixel = 0
        TextLabel_3.ZIndex = arg33.ZIndex + 2
        TextLabel_3.LayoutOrder = arg33.ZIndex + 2
        TextLabel_3.AutomaticSize = Enum.AutomaticSize.XY
        arg2.applyTextStyle(TextLabel_3)
        TextLabel_3.Parent = TextButton_1
        local TextLabel_4 = Instance.new("TextLabel")
        TextLabel_4.Name = "Shortcut"
        TextLabel_4.AnchorPoint = Vector2.new(0, 0)
        TextLabel_4.BackgroundTransparency = 1
        TextLabel_4.BorderSizePixel = 0
        TextLabel_4.ZIndex = arg33.ZIndex + 3
        TextLabel_4.LayoutOrder = arg33.ZIndex + 3
        TextLabel_4.AutomaticSize = Enum.AutomaticSize.XY
        arg2.applyTextStyle(TextLabel_4)
        TextLabel_4.Text = ""
        TextLabel_4.TextColor3 = arg1._config.TextDisabledColor
        TextLabel_4.TextTransparency = arg1._config.TextDisabledTransparency
        TextLabel_4.Parent = TextButton_1
        local v38 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
        local v39 = v38 - math.round(v38 * 0.2) * 2
        local ImageLabel_1 = Instance.new("ImageLabel")
        ImageLabel_1.Name = "Icon"
        ImageLabel_1.Size = UDim2.fromOffset(v39, v39)
        ImageLabel_1.BackgroundTransparency = 1
        ImageLabel_1.BorderSizePixel = 0
        ImageLabel_1.ImageColor3 = arg1._config.TextColor
        ImageLabel_1.ImageTransparency = arg1._config.TextTransparency
        ImageLabel_1.Image = arg2.ICONS.CHECK_MARK
        ImageLabel_1.ZIndex = arg33.ZIndex + 4
        ImageLabel_1.LayoutOrder = arg33.ZIndex + 4
        ImageLabel_1.Parent = TextButton_1

        return TextButton_1
    end

    function t_11.GenerateState(arg34) -- line: 578
        -- upvalues:
        --  [1] arg1 (copy)

        if arg34.state.isChecked == nil then
            arg34.state.isChecked = arg1._widgetState(arg34, "isChecked", false)
        end
    end

    function t_11.Update(arg35) -- line: 583
        local v40 = arg35.Instance
        local Shortcut_1 = v40.Shortcut
        v40.TextLabel.Text = arg35.arguments.Text

        if arg35.arguments.KeyCode then
            Shortcut_1.Text = arg35.arguments.ModifierKey.Name .. " + " .. arg35.arguments.KeyCode.Name
        end
    end

    function t_11.UpdateState(arg36) -- line: 593
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        local Icon = arg36.Instance.Icon

        if arg36.state.isChecked.value then
            Icon.Image = arg2.ICONS.CHECK_MARK
            arg36.lastCheckedTick = arg1._cycleTick + 1

            return
        end

        Icon.Image = ""
        arg36.lastUncheckedTick = arg1._cycleTick + 1
    end

    function t_11.Discard(arg37) -- line: 605
        -- upvalues:
        --  [1] arg2 (copy)

        arg37.Instance:Destroy()
        arg2.discardState(arg37)
    end

    WidgetConstructor_3("MenuToggle", t_11)
end
