-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Window
-- Class: ModuleScript
-- bytes: 39119

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local function relocateTooltips() -- line: 4
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        if arg1._rootInstance == nil then
            return
        end

        local PopupScreenGui = arg1._rootInstance:FindFirstChild("PopupScreenGui")

        if not PopupScreenGui then
            return
        end

        local TooltipContainer = PopupScreenGui.TooltipContainer
        local v2 = arg2.findBestWindowPosForPopup(
            arg2.getMouseLocation(),
            TooltipContainer.AbsoluteSize,
            arg1._config.DisplaySafeAreaPadding,
            PopupScreenGui.AbsoluteSize
        )
        TooltipContainer.Position = UDim2.fromOffset(v2.X, v2.Y)
    end

    arg2.UserInputService.InputChanged:Connect(relocateTooltips)
    local t = {
        hasState = false,
        hasChildren = false,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil
    }
    local t_1 = { Text = 1 }
    local WidgetConstructor = arg1.WidgetConstructor
    t.Args = t_1
    t.Events = {}

    function t.Generate(arg3) -- line: 32
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        arg3.parentWidget = arg1._rootWidget
        local IrisTooltip_Frame = Instance.new("Frame")
        IrisTooltip_Frame.Name = "Iris_Tooltip"
        IrisTooltip_Frame.Size = UDim2.new(arg1._config.ContentWidth, UDim.new(0, 0))
        IrisTooltip_Frame.AutomaticSize = Enum.AutomaticSize.Y
        IrisTooltip_Frame.BorderSizePixel = 0
        IrisTooltip_Frame.BackgroundTransparency = 1
        IrisTooltip_Frame.ZIndex = arg3.ZIndex + 1
        IrisTooltip_Frame.LayoutOrder = arg3.ZIndex + 1
        local TooltipText_TextLabel = Instance.new("TextLabel")
        TooltipText_TextLabel.Name = "TooltipText"
        TooltipText_TextLabel.Size = UDim2.fromOffset(0, 0)
        TooltipText_TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TooltipText_TextLabel.BackgroundColor3 = arg1._config.WindowBgColor
        TooltipText_TextLabel.BackgroundTransparency = arg1._config.WindowBgTransparency
        TooltipText_TextLabel.BorderSizePixel = arg1._config.PopupBorderSize
        TooltipText_TextLabel.TextWrapped = true
        TooltipText_TextLabel.ZIndex = arg3.ZIndex + 1
        TooltipText_TextLabel.LayoutOrder = arg3.ZIndex + 1
        arg2.applyTextStyle(TooltipText_TextLabel)
        arg2.UIStroke(
            TooltipText_TextLabel,
            arg1._config.WindowBorderSize,
            arg1._config.BorderActiveColor,
            arg1._config.BorderActiveTransparency
        )
        arg2.UIPadding(TooltipText_TextLabel, arg1._config.WindowPadding)

        if arg1._config.PopupRounding > 0 then
            arg2.UICorner(TooltipText_TextLabel, arg1._config.PopupRounding)
        end

        TooltipText_TextLabel.Parent = IrisTooltip_Frame

        return IrisTooltip_Frame
    end

    function t.Update(arg4) -- line: 66
        -- upvalues:
        --  [1] relocateTooltips (copy)

        local TooltipText = arg4.Instance.TooltipText

        if arg4.arguments.Text == nil then
            error("Iris.Text Text Argument is required", 5)
        end

        TooltipText.Text = arg4.arguments.Text
        relocateTooltips()
    end

    function t.Discard(arg5) -- line: 75
        arg5.Instance:Destroy()
    end

    WidgetConstructor("Tooltip", t)
    local v3 = 0
    local v4 = nil
    local v5 = false
    local v6 = nil
    local v7 = nil
    local v8 = false
    local v9 = false
    local v10 = false
    local TopBottom_Top = Enum.TopBottom.Top
    local LeftRight_Left = Enum.LeftRight.Left
    local v11 = nil
    local v12 = false
    local t_3 = {}

    local function quickSwapWindows() -- line: 99
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] t_3 (copy)

        if arg1._config.UseScreenGUIs == false then
            return
        end

        local v13 = 65535
        local v14 = nil

        for _, val in t_3 do
            if val.state.isOpened.value and not val.arguments.NoNav and val.Instance:IsA(
                "ScreenGui"
            ) then
                local DisplayOrder = val.Instance.DisplayOrder

                if v13 > DisplayOrder then
                    v13 = DisplayOrder
                    v14 = val
                end
            end
        end

        if v14.state.isUncollapsed.value == false then
            v14.state.isUncollapsed:set(true)
        end

        arg1.SetFocusedWindow(v14)
    end

    local function fitSizeToWindowBounds(arg6: any, u1: Vector2) -- line: 126
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local vec2 = Vector2.new(arg6.state.position.value.X, arg6.state.position.value.Y)
        local v15 = (arg1._config.TextSize + arg1._config.FramePadding.Y * 2) * 2
        local v16 = arg2.getScreenSizeForWindow(arg6)
        local vec2_1 = Vector2.new(
            arg1._config.WindowBorderSize + arg1._config.DisplaySafeAreaPadding.X,
            arg1._config.WindowBorderSize + arg1._config.DisplaySafeAreaPadding.Y
        )
        local v17 = v16 - vec2 - vec2_1
        local New_1 = Vector2.new
        local X = u1.X
        local v18 = math.max(v17.X, v15)
        local v19 = math.clamp(X, v15, v18)
        local Y = u1.Y
        local v20 = math.max(v17.Y, v15)

        return New_1(v19, (math.clamp(Y, v15, v20)))
    end

    local function fitPositionToWindowBounds(arg7: any, u2: Vector2) -- line: 142
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        local v21 = arg7.Instance
        local v22 = arg2.getScreenSizeForWindow(arg7)
        local vec2_2 = Vector2.new(
            arg1._config.WindowBorderSize + arg1._config.DisplaySafeAreaPadding.X,
            arg1._config.WindowBorderSize + arg1._config.DisplaySafeAreaPadding.Y
        )
        local New_2 = Vector2.new
        local X_1 = u2.X
        local X_2 = vec2_2.X
        local v23 = math.max(vec2_2.X, v22.X - v21.WindowButton.AbsoluteSize.X - vec2_2.X)
        local v24 = math.clamp(X_1, X_2, v23)
        local Y_1 = u2.Y
        local Y_2 = vec2_2.Y
        local v25 = math.max(vec2_2.Y, v22.Y - v21.WindowButton.AbsoluteSize.Y - vec2_2.Y)

        return New_2(v24, (math.clamp(Y_1, Y_2, v25)))
    end

    function arg1.SetFocusedWindow(arg8) -- line: 164
        -- upvalues:
        --  [1] v11 (ref)
        --  [2] v12 (ref)
        --  [3] t_3 (copy)
        --  [4] arg1 (copy)
        --  [5] v3 (ref)
        --  [6] arg2 (copy)

        if v11 == arg8 then
            return
        end

        if v12 and v11 ~= nil then
            if t_3[v11.ID] then
                local WindowButton = v11.Instance.WindowButton
                local TitleBar = WindowButton.TitleBar

                if v11.state.isUncollapsed.value then
                    TitleBar.BackgroundColor3 = arg1._config.TitleBgColor
                    TitleBar.BackgroundTransparency = arg1._config.TitleBgTransparency
                else
                    TitleBar.BackgroundColor3 = arg1._config.TitleBgCollapsedColor
                    TitleBar.BackgroundTransparency = arg1._config.TitleBgCollapsedTransparency
                end

                WindowButton.UIStroke.Color = arg1._config.BorderColor
            end

            v12 = false
            v11 = nil
        end

        if arg8 ~= nil then
            v12 = true
            v11 = arg8
            local v26 = arg8.Instance
            local WindowButton_1 = v26.WindowButton
            local TitleBar_1 = WindowButton_1.TitleBar
            TitleBar_1.BackgroundColor3 = arg1._config.TitleBgActiveColor
            TitleBar_1.BackgroundTransparency = arg1._config.TitleBgActiveTransparency
            WindowButton_1.UIStroke.Color = arg1._config.BorderActiveColor
            v3 += 1

            if arg8.usesScreenGUI then
                v26.DisplayOrder = v3 + arg1._config.DisplayOrderOffset
            end

            if arg8.state.isUncollapsed.value == false then
                arg8.state.isUncollapsed:set(true)
            end

            if arg2.GuiService.SelectedObject then
                if TitleBar_1.Visible then
                    arg2.GuiService:Select(TitleBar_1)

                    return
                end

                arg2.GuiService:Select(v26.ChildContainer)
            end
        end
    end

    arg2.UserInputService.InputBegan:Connect(function(
        input_3: userdata,
        gameProcessedEvent: boolean
    ) -- line: 221
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)
        --  [3] quickSwapWindows (copy)
        --  [4] v9 (ref)
        --  [5] v10 (ref)
        --  [6] v12 (ref)
        --  [7] v11 (ref)
        --  [8] TopBottom_Top (ref)
        --  [9] LeftRight_Left (ref)
        --  [10] v8 (ref)
        --  [11] v7 (ref)

        if not gameProcessedEvent and input_3.UserInputType == Enum.UserInputType.MouseButton1 then
            arg1.SetFocusedWindow(nil)
        end

        if input_3.KeyCode == Enum.KeyCode.Tab then
            if not arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                if arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                    quickSwapWindows()
                end
            else
                quickSwapWindows()
            end
        end

        if input_3.UserInputType == Enum.UserInputType.MouseButton1 and v9 and not v10 and v12 and v11 then
            local v28 = arg2.getMouseLocation() - (v11.state.position.value + v11.state.size.value * 0.5)

            if math.abs(v28.X) * v11.state.size.value.Y >= math.abs(v28.Y) * v11.state.size.value.X then
                TopBottom_Top = Enum.TopBottom.Center
                LeftRight_Left = if math.sign(v28.X) == -1 then Enum.LeftRight.Left else Enum.LeftRight.Right
            else
                LeftRight_Left = Enum.LeftRight.Center
                TopBottom_Top = if math.sign(v28.Y) == -1 then Enum.TopBottom.Top else Enum.TopBottom.Bottom
            end

            v8 = true
            v7 = v11
        end
    end)
    arg2.UserInputService.TouchTapInWorld:Connect(function(_: any, b2: boolean) -- line: 252
        -- upvalues:
        --  [1] arg1 (copy)

        if not b2 then
            arg1.SetFocusedWindow(nil)
        end
    end)
    local v33 = nil
    arg2.UserInputService.InputChanged:Connect(function(input_4: userdata) -- line: 258
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] v4 (ref)
        --  [3] arg2 (copy)
        --  [4] v6 (ref)
        --  [5] fitPositionToWindowBounds (copy)
        --  [6] v8 (ref)
        --  [7] v7 (ref)
        --  [8] v33 (ref)
        --  [9] LeftRight_Left (ref)
        --  [10] TopBottom_Top (ref)
        --  [11] fitSizeToWindowBounds (copy)

        if v5 and v4 then
            local v34 = if input_4.UserInputType ~= Enum.UserInputType.Touch then arg2.getMouseLocation() else Vector2.new(
                input_4.Position.X,
                input_4.Position.Y
            )
            local WindowButton_2 = v4.Instance.WindowButton
            v34 = fitPositionToWindowBounds(v4, v34 - v6)
            WindowButton_2.Position = UDim2.fromOffset(v34.X, v34.Y)
            v4.state.position.value = v34
        end

        if v8 and v7 and v7.arguments.NoResize ~= true then
            local WindowButton_3 = v7.Instance.WindowButton
            local vec2_3 = Vector2.new(WindowButton_3.Size.X.Offset, WindowButton_3.Size.Y.Offset)
            local v35 = if input_4.UserInputType ~= Enum.UserInputType.Touch then arg2.getMouseLocation() - v33 else input_4.Delta
            local v36 = if LeftRight_Left ~= Enum.LeftRight.Left then 0 else v35.X
            local v38 = Vector2.new(
                WindowButton_3.Position.X.Offset,
                WindowButton_3.Position.Y.Offset
            ) + Vector2.new(v36, if TopBottom_Top == Enum.TopBottom.Top then v35.Y else 0)
            v36 = if LeftRight_Left ~= Enum.LeftRight.Left then if LeftRight_Left ~= Enum.LeftRight.Right then 0 else v35.X else -v35.X
            local v39 = if TopBottom_Top ~= Enum.TopBottom.Top then if TopBottom_Top ~= Enum.TopBottom.Bottom then 0 else v35.Y else -v35.Y
            v35 = fitSizeToWindowBounds(v7, vec2_3 + Vector2.new(v36, v39))
            local v40 = fitPositionToWindowBounds(v7, v38)
            WindowButton_3.Size = UDim2.fromOffset(v35.X, v35.Y)
            v7.state.size.value = v35
            WindowButton_3.Position = UDim2.fromOffset(v40.X, v40.Y)
            v7.state.position.value = v40
        end

        v33 = arg2.getMouseLocation()
    end)
    arg2.UserInputService.InputEnded:Connect(function(arg10, _) -- line: 319
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] v4 (ref)
        --  [3] v8 (ref)
        --  [4] v7 (ref)
        --  [5] quickSwapWindows (copy)

        if (arg10.UserInputType == Enum.UserInputType.MouseButton1 or arg10.UserInputType == Enum.UserInputType.Touch) and v5 and v4 then
            local WindowButton_4 = v4.Instance.WindowButton
            v5 = false
            v4.state.position:set(
                Vector2.new(WindowButton_4.Position.X.Offset, WindowButton_4.Position.Y.Offset)
            )
        end

        if (arg10.UserInputType == Enum.UserInputType.MouseButton1 or arg10.UserInputType == Enum.UserInputType.Touch) and v8 and v7 then
            local v41 = v7.Instance
            v8 = false
            v7.state.size:set(v41.WindowButton.AbsoluteSize)
        end

        if arg10.KeyCode == Enum.KeyCode.ButtonX then
            quickSwapWindows()
        end
    end)
    local t_4 = {
        hasState = true,
        hasChildren = true,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil,
        ChildAdded = nil,
        UpdateState = nil,
        GenerateState = nil
    }
    local WidgetConstructor_1 = arg1.WidgetConstructor
    t_4.Args = {
        Title = 1,
        NoTitleBar = 2,
        NoBackground = 3,
        NoCollapse = 4,
        NoClose = 5,
        NoMove = 6,
        NoScrollbar = 7,
        NoResize = 8,
        NoNav = 9,
        NoMenu = 10
    }
    local t_6 = {}
    local t_7 = {
        Init = function(_) -- line: 362
        end
    }

    function t_7.Get(arg13) -- line: 363
        -- upvalues:
        --  [1] arg1 (copy)

        return arg13.lastClosedTick == arg1._cycleTick
    end

    t_6.closed = t_7
    local t_8 = {
        Init = function(_) -- line: 368
        end
    }

    function t_8.Get(arg15) -- line: 369
        -- upvalues:
        --  [1] arg1 (copy)

        return arg15.lastOpenedTick == arg1._cycleTick
    end

    t_6.opened = t_8
    local t_9 = {
        Init = function(_) -- line: 374
        end
    }

    function t_9.Get(arg17) -- line: 375
        -- upvalues:
        --  [1] arg1 (copy)

        return arg17.lastCollapsedTick == arg1._cycleTick
    end

    t_6.collapsed = t_9
    local t_10 = {
        Init = function(_) -- line: 380
        end
    }

    function t_10.Get(arg19) -- line: 381
        -- upvalues:
        --  [1] arg1 (copy)

        return arg19.lastUncollapsedTick == arg1._cycleTick
    end

    t_6.uncollapsed = t_10
    t_6.hovered = arg2.EVENTS.hover(function(arg20) -- line: 385
        return arg20.Instance.WindowButton
    end)
    t_4.Events = t_6

    function t_4.Generate(arg21) -- line: 390
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] t_3 (copy)
        --  [3] arg2 (copy)
        --  [4] v4 (ref)
        --  [5] v5 (ref)
        --  [6] v6 (ref)
        --  [7] v12 (ref)
        --  [8] v11 (ref)
        --  [9] v8 (ref)
        --  [10] TopBottom_Top (ref)
        --  [11] LeftRight_Left (ref)
        --  [12] v7 (ref)
        --  [13] v9 (ref)
        --  [14] v10 (ref)

        arg21.parentWidget = arg1._rootWidget
        arg21.usesScreenGUI = arg1._config.UseScreenGUIs
        t_3[arg21.ID] = arg21
        local v46

        if arg21.usesScreenGUI then
            v46 = Instance.new("ScreenGui")
            v46.ResetOnSpawn = false
            v46.DisplayOrder = arg1._config.DisplayOrderOffset
            v46.IgnoreGuiInset = arg1._config.IgnoreGuiInset
        else
            v46 = Instance.new("Folder")
        end

        v46.Name = "Iris_Window"
        local WindowButton_TextButton = Instance.new("TextButton")
        WindowButton_TextButton.Name = "WindowButton"
        WindowButton_TextButton.Size = UDim2.fromOffset(0, 0)
        WindowButton_TextButton.BackgroundTransparency = 1
        WindowButton_TextButton.BorderSizePixel = 0
        WindowButton_TextButton.Text = ""
        WindowButton_TextButton.ClipsDescendants = false
        WindowButton_TextButton.AutoButtonColor = false
        WindowButton_TextButton.Selectable = false
        WindowButton_TextButton.SelectionImageObject = arg1.SelectionImageObject
        WindowButton_TextButton.ZIndex = arg21.ZIndex + 1
        WindowButton_TextButton.LayoutOrder = arg21.ZIndex + 1
        WindowButton_TextButton.SelectionGroup = true
        WindowButton_TextButton.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        WindowButton_TextButton.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        WindowButton_TextButton.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
        WindowButton_TextButton.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        arg2.UIStroke(
            WindowButton_TextButton,
            arg1._config.WindowBorderSize,
            arg1._config.BorderColor,
            arg1._config.BorderTransparency
        )
        WindowButton_TextButton.Parent = v46
        WindowButton_TextButton.InputBegan:Connect(function(input: userdata) -- line: 430
            -- upvalues:
            --  [1] arg21 (copy)
            --  [2] arg1 (ref)
            --  [3] v4 (ref)
            --  [4] v5 (ref)
            --  [5] v6 (ref)
            --  [6] arg2 (ref)

            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Keyboard then
                return
            end

            if arg21.state.isUncollapsed.value then
                arg1.SetFocusedWindow(arg21)
            end

            if not arg21.arguments.NoMove and input.UserInputType == Enum.UserInputType.MouseButton1 then
                v4 = arg21
                v5 = true
                v6 = arg2.getMouseLocation() - arg21.state.position.value
            end
        end)
        local ChildContainer_ScrollingFrame = Instance.new("ScrollingFrame")
        ChildContainer_ScrollingFrame.Name = "ChildContainer"
        ChildContainer_ScrollingFrame.Size = UDim2.fromScale(1, 1)
        ChildContainer_ScrollingFrame.Position = UDim2.fromOffset(0, 0)
        ChildContainer_ScrollingFrame.BackgroundColor3 = arg1._config.WindowBgColor
        ChildContainer_ScrollingFrame.BackgroundTransparency = arg1._config.WindowBgTransparency
        ChildContainer_ScrollingFrame.BorderSizePixel = 0
        ChildContainer_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        ChildContainer_ScrollingFrame.ScrollBarImageTransparency = arg1._config.ScrollbarGrabTransparency
        ChildContainer_ScrollingFrame.ScrollBarImageColor3 = arg1._config.ScrollbarGrabColor
        ChildContainer_ScrollingFrame.CanvasSize = UDim2.fromScale(0, 1)
        ChildContainer_ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        ChildContainer_ScrollingFrame.ZIndex = arg21.ZIndex + 3
        ChildContainer_ScrollingFrame.LayoutOrder = arg21.ZIndex + 3
        ChildContainer_ScrollingFrame.ClipsDescendants = true
        arg2.UIPadding(ChildContainer_ScrollingFrame, arg1._config.WindowPadding)
        ChildContainer_ScrollingFrame.Parent = WindowButton_TextButton
        ChildContainer_ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- line: 466
            -- upvalues:
            --  [1] arg21 (copy)
            --  [2] ChildContainer_ScrollingFrame (copy)

            arg21.state.scrollDistance.value = ChildContainer_ScrollingFrame.CanvasPosition.Y
        end)
        ChildContainer_ScrollingFrame.InputBegan:Connect(function(input_1: userdata) -- line: 471
            -- upvalues:
            --  [1] arg21 (copy)
            --  [2] arg1 (ref)

            if input_1.UserInputType == Enum.UserInputType.MouseMovement or input_1.UserInputType == Enum.UserInputType.Keyboard then
                return
            end

            if arg21.state.isUncollapsed.value then
                arg1.SetFocusedWindow(arg21)
            end
        end)
        local Frame_1 = Instance.new("Frame")
        Frame_1.Name = "TerminatingFrame"
        Frame_1.Size = UDim2.fromOffset(
            0,
            arg1._config.WindowPadding.Y + arg1._config.FramePadding.Y
        )
        Frame_1.BackgroundTransparency = 1
        Frame_1.BorderSizePixel = 0
        Frame_1.LayoutOrder = 2147483632
        arg2.UIListLayout(
            ChildContainer_ScrollingFrame,
            Enum.FillDirection.Vertical,
            UDim.new(0, arg1._config.ItemSpacing.Y)
        ).VerticalAlignment = Enum.VerticalAlignment.Top
        Frame_1.Parent = ChildContainer_ScrollingFrame
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "TitleBar"
        Frame_2.Size = UDim2.fromScale(1, 0)
        Frame_2.AutomaticSize = Enum.AutomaticSize.Y
        Frame_2.BorderSizePixel = 0
        Frame_2.ZIndex = arg21.ZIndex + 1
        Frame_2.LayoutOrder = arg21.ZIndex + 1
        Frame_2.ClipsDescendants = true
        Frame_2.Parent = WindowButton_TextButton
        Frame_2.InputBegan:Connect(function(input_2: userdata) -- line: 504
            -- upvalues:
            --  [1] arg21 (copy)
            --  [2] v4 (ref)
            --  [3] v5 (ref)
            --  [4] v6 (ref)

            if input_2.UserInputType == Enum.UserInputType.Touch and not arg21.arguments.NoMove then
                v4 = arg21
                v5 = true
                local Position_1 = input_2.Position
                v6 = Vector2.new(Position_1.X, Position_1.Y) - arg21.state.position.value
            end
        end)
        local v49 = arg1._config.TextSize + (arg1._config.FramePadding.Y - 1) * 2
        local TextButton_1 = Instance.new("TextButton")
        TextButton_1.Name = "CollapseButton"
        TextButton_1.AnchorPoint = Vector2.new(0, 0.5)
        TextButton_1.Size = UDim2.fromOffset(v49, v49)
        TextButton_1.Position = UDim2.new(0, arg1._config.FramePadding.X + 1, 0.5, 0)
        TextButton_1.AutomaticSize = Enum.AutomaticSize.None
        TextButton_1.BackgroundTransparency = 1
        TextButton_1.BorderSizePixel = 0
        TextButton_1.AutoButtonColor = false
        TextButton_1.Text = ""
        TextButton_1.ZIndex = arg21.ZIndex + 4
        arg2.UICorner(TextButton_1)
        TextButton_1.Parent = Frame_2
        TextButton_1.MouseButton1Click:Connect(function() -- line: 533
            -- upvalues:
            --  [1] arg21 (copy)

            arg21.state.isUncollapsed:set(not arg21.state.isUncollapsed.value)
        end)
        arg2.applyInteractionHighlights(
            TextButton_1,
            TextButton_1,
            {
                ButtonColor = arg1._config.ButtonColor,
                ButtonTransparency = 1,
                ButtonHoveredColor = arg1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency,
                ButtonActiveColor = arg1._config.ButtonActiveColor,
                ButtonActiveTransparency = arg1._config.ButtonActiveTransparency
            }
        )
        local Arrow_ImageLabel = Instance.new("ImageLabel")
        Arrow_ImageLabel.Name = "Arrow"
        Arrow_ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        Arrow_ImageLabel.Size = UDim2.fromOffset(math.floor(v49 * 0.7), (math.floor(v49 * 0.7)))
        Arrow_ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
        Arrow_ImageLabel.BackgroundTransparency = 1
        Arrow_ImageLabel.BorderSizePixel = 0
        Arrow_ImageLabel.Image = arg2.ICONS.MULTIPLICATION_SIGN
        Arrow_ImageLabel.ImageColor3 = arg1._config.TextColor
        Arrow_ImageLabel.ImageTransparency = arg1._config.TextTransparency
        Arrow_ImageLabel.ZIndex = arg21.ZIndex + 5
        Arrow_ImageLabel.Parent = TextButton_1
        local TextButton_2 = Instance.new("TextButton")
        TextButton_2.Name = "CloseButton"
        TextButton_2.AnchorPoint = Vector2.new(1, 0.5)
        TextButton_2.Size = UDim2.fromOffset(v49, v49)
        TextButton_2.Position = UDim2.new(1, -(arg1._config.FramePadding.X + 1), 0.5, 0)
        TextButton_2.AutomaticSize = Enum.AutomaticSize.None
        TextButton_2.BackgroundTransparency = 1
        TextButton_2.BorderSizePixel = 0
        TextButton_2.Text = ""
        TextButton_2.ZIndex = arg21.ZIndex + 4
        TextButton_2.AutoButtonColor = false
        arg2.UICorner(TextButton_2)
        TextButton_2.MouseButton1Click:Connect(function() -- line: 574
            -- upvalues:
            --  [1] arg21 (copy)

            arg21.state.isOpened:set(false)
        end)
        arg2.applyInteractionHighlights(
            TextButton_2,
            TextButton_2,
            {
                ButtonColor = arg1._config.ButtonColor,
                ButtonTransparency = 1,
                ButtonHoveredColor = arg1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency,
                ButtonActiveColor = arg1._config.ButtonActiveColor,
                ButtonActiveTransparency = arg1._config.ButtonActiveTransparency
            }
        )
        TextButton_2.Parent = Frame_2
        local ImageLabel_1 = Instance.new("ImageLabel")
        ImageLabel_1.Name = "Icon"
        ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel_1.Size = UDim2.fromOffset(math.floor(v49 * 0.7), (math.floor(v49 * 0.7)))
        ImageLabel_1.Position = UDim2.fromScale(0.5, 0.5)
        ImageLabel_1.BackgroundTransparency = 1
        ImageLabel_1.BorderSizePixel = 0
        ImageLabel_1.Image = arg2.ICONS.MULTIPLICATION_SIGN
        ImageLabel_1.ImageColor3 = arg1._config.TextColor
        ImageLabel_1.ImageTransparency = arg1._config.TextTransparency
        ImageLabel_1.ZIndex = arg21.ZIndex + 5
        ImageLabel_1.Parent = TextButton_2
        local v52 = if arg1._config.WindowTitleAlign == Enum.LeftRight.Left then 0 else if arg1._config.WindowTitleAlign ~= Enum.LeftRight.Center then 1 else 0.5
        local TextLabel_1 = Instance.new("TextLabel")
        TextLabel_1.Name = "Title"
        TextLabel_1.AnchorPoint = Vector2.new(v52, 0)
        TextLabel_1.Position = UDim2.fromScale(v52, 0)
        TextLabel_1.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel_1.BorderSizePixel = 0
        TextLabel_1.BackgroundTransparency = 1
        TextLabel_1.ZIndex = arg21.ZIndex + 3
        arg2.applyTextStyle(TextLabel_1)
        arg2.UIPadding(TextLabel_1, arg1._config.FramePadding)
        TextLabel_1.Parent = Frame_2
        v52 = arg1._config.TextSize + arg1._config.FramePadding.X
        local TextButton_3 = Instance.new("TextButton")
        TextButton_3.Name = "ResizeGrip"
        TextButton_3.AnchorPoint = Vector2.new(1, 1)
        TextButton_3.Size = UDim2.fromOffset(v52, v52)
        TextButton_3.Position = UDim2.fromScale(1, 1)
        TextButton_3.AutoButtonColor = false
        TextButton_3.BorderSizePixel = 0
        TextButton_3.BackgroundTransparency = 1
        TextButton_3.Text = arg2.ICONS.BOTTOM_RIGHT_CORNER
        TextButton_3.TextSize = v52
        TextButton_3.TextColor3 = arg1._config.ButtonColor
        TextButton_3.TextTransparency = arg1._config.ButtonTransparency
        TextButton_3.LineHeight = 1.1
        TextButton_3.Selectable = false
        TextButton_3.ZIndex = arg21.ZIndex + 3
        TextButton_3.Parent = WindowButton_TextButton
        arg2.applyTextInteractionHighlights(
            TextButton_3,
            TextButton_3,
            {
                ButtonColor = arg1._config.ButtonColor,
                ButtonTransparency = arg1._config.ButtonTransparency,
                ButtonHoveredColor = arg1._config.ButtonHoveredColor,
                ButtonHoveredTransparency = arg1._config.ButtonHoveredTransparency,
                ButtonActiveColor = arg1._config.ButtonActiveColor,
                ButtonActiveTransparency = arg1._config.ButtonActiveTransparency
            }
        )
        TextButton_3.MouseButton1Down:Connect(function() -- line: 655
            -- upvalues:
            --  [1] v12 (ref)
            --  [2] v11 (ref)
            --  [3] arg21 (copy)
            --  [4] arg1 (ref)
            --  [5] v8 (ref)
            --  [6] TopBottom_Top (ref)
            --  [7] LeftRight_Left (ref)
            --  [8] v7 (ref)

            if not v12 or v11 ~= arg21 then
                arg1.SetFocusedWindow(arg21)
            end

            v8 = true
            TopBottom_Top = Enum.TopBottom.Bottom
            LeftRight_Left = Enum.LeftRight.Right
            v7 = arg21
        end)
        local TextButton_4 = Instance.new("TextButton")
        TextButton_4.Name = "ResizeBorder"
        TextButton_4.Size = UDim2.new(
            1,
            arg1._config.WindowResizePadding.X * 2,
            1,
            arg1._config.WindowResizePadding.Y * 2
        )
        TextButton_4.Position = UDim2.fromOffset(
            -arg1._config.WindowResizePadding.X,
            -arg1._config.WindowResizePadding.Y
        )
        TextButton_4.BackgroundTransparency = 1
        TextButton_4.BorderSizePixel = 0
        TextButton_4.Text = ""
        TextButton_4.AutoButtonColor = false
        TextButton_4.Active = true
        TextButton_4.Selectable = false
        TextButton_4.ZIndex = arg21.ZIndex
        TextButton_4.LayoutOrder = arg21.ZIndex
        TextButton_4.ClipsDescendants = false
        TextButton_4.Parent = WindowButton_TextButton
        TextButton_4.MouseEnter:Connect(function() -- line: 681
            -- upvalues:
            --  [1] v11 (ref)
            --  [2] arg21 (copy)
            --  [3] v9 (ref)

            if v11 == arg21 then
                v9 = true
            end
        end)
        TextButton_4.MouseLeave:Connect(function() -- line: 686
            -- upvalues:
            --  [1] v11 (ref)
            --  [2] arg21 (copy)
            --  [3] v9 (ref)

            if v11 == arg21 then
                v9 = false
            end
        end)
        WindowButton_TextButton.MouseEnter:Connect(function() -- line: 692
            -- upvalues:
            --  [1] v11 (ref)
            --  [2] arg21 (copy)
            --  [3] v10 (ref)

            if v11 == arg21 then
                v10 = true
            end
        end)
        WindowButton_TextButton.MouseLeave:Connect(function() -- line: 697
            -- upvalues:
            --  [1] v11 (ref)
            --  [2] arg21 (copy)
            --  [3] v10 (ref)

            if v11 == arg21 then
                v10 = false
            end
        end)

        return v46
    end

    function t_4.Update(arg22) -- line: 705
        -- upvalues:
        --  [1] arg1 (copy)

        local v53 = arg22.Instance.WindowButton
        local TitleBar_2 = v53.TitleBar
        local Title = TitleBar_2.Title
        local MenuBar = v53:FindFirstChild("MenuBar")
        local ChildContainer = v53.ChildContainer
        local ResizeGrip = v53.ResizeGrip
        v53 = 0
        local v54 = 0

        if arg22.arguments.NoResize ~= true then
            ResizeGrip.Visible = true
        else
            ResizeGrip.Visible = false
        end

        if arg22.arguments.NoScrollbar then
            ChildContainer.ScrollBarThickness = 0
        else
            ChildContainer.ScrollBarThickness = arg1._config.ScrollbarSize
        end

        if arg22.arguments.NoTitleBar then
            TitleBar_2.Visible = false
        else
            TitleBar_2.Visible = true
            local Y_3 = TitleBar_2.AbsoluteSize.Y
            v53 += Y_3
            v54 += Y_3
        end

        if MenuBar then
            if arg22.arguments.NoMenu then
                MenuBar.Visible = false
            else
                MenuBar.Visible = true
                v53 += MenuBar.AbsoluteSize.Y
            end

            MenuBar.Position = UDim2.fromOffset(0, v54)
        end

        if arg22.arguments.NoBackground then
            ChildContainer.BackgroundTransparency = 1
        else
            ChildContainer.BackgroundTransparency = arg1._config.WindowBgTransparency
        end

        v54 = arg1._config.FramePadding.X + arg1._config.TextSize + arg1._config.FramePadding.X * 2

        if arg22.arguments.NoCollapse then
            TitleBar_2.CollapseButton.Visible = false
            TitleBar_2.Title.UIPadding.PaddingLeft = UDim.new(0, arg1._config.FramePadding.X)
        else
            TitleBar_2.CollapseButton.Visible = true
            TitleBar_2.Title.UIPadding.PaddingLeft = UDim.new(0, v54)
        end

        if arg22.arguments.NoClose then
            TitleBar_2.CloseButton.Visible = false
            TitleBar_2.Title.UIPadding.PaddingRight = UDim.new(0, arg1._config.FramePadding.X)
        else
            TitleBar_2.CloseButton.Visible = true
            TitleBar_2.Title.UIPadding.PaddingRight = UDim.new(0, v54)
        end

        ChildContainer.Size = UDim2.new(1, 0, 1, -v53)
        ChildContainer.CanvasSize = UDim2.new(0, 0, 1, -v53)
        ChildContainer.Position = UDim2.fromOffset(0, v53)
        Title.Text = arg22.arguments.Title or ""
    end

    function t_4.Discard(arg23) -- line: 775
        -- upvalues:
        --  [1] v11 (ref)
        --  [2] v12 (ref)
        --  [3] v4 (ref)
        --  [4] v5 (ref)
        --  [5] v7 (ref)
        --  [6] v8 (ref)
        --  [7] t_3 (copy)
        --  [8] arg2 (copy)

        if v11 == arg23 then
            v11 = nil
            v12 = false
        end

        if v4 == arg23 then
            v4 = nil
            v5 = false
        end

        if v7 == arg23 then
            v7 = nil
            v8 = false
        end

        t_3[arg23.ID] = nil
        arg23.Instance:Destroy()
        arg2.discardState(arg23)
    end

    function t_4.ChildAdded(arg24) -- line: 792
        return arg24.Instance.WindowButton.ChildContainer
    end

    function t_4.UpdateState(arg25) -- line: 797
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local Value = arg25.state.size.value
        local Value_1 = arg25.state.position.value
        local Value_2 = arg25.state.isUncollapsed.value
        local Value_3 = arg25.state.isOpened.value
        local Value_4 = arg25.state.scrollDistance.value
        local v55 = arg25.Instance
        local WindowButton_5 = v55.WindowButton
        local TitleBar_3 = WindowButton_5.TitleBar
        local ChildContainer_1 = WindowButton_5.ChildContainer
        local ResizeGrip_1 = WindowButton_5.ResizeGrip
        WindowButton_5.Size = UDim2.fromOffset(Value.X, Value.Y)
        WindowButton_5.Position = UDim2.fromOffset(Value_1.X, Value_1.Y)

        if Value_3 then
            if arg25.usesScreenGUI then
                v55.Enabled = true
                WindowButton_5.Visible = true
            else
                WindowButton_5.Visible = true
            end

            arg25.lastOpenedTick = arg1._cycleTick + 1
        else
            if arg25.usesScreenGUI then
                v55.Enabled = false
                WindowButton_5.Visible = false
            else
                WindowButton_5.Visible = false
            end

            arg25.lastClosedTick = arg1._cycleTick + 1
        end

        if Value_2 then
            TitleBar_3.CollapseButton.Arrow.Image = arg2.ICONS.DOWN_POINTING_TRIANGLE
            ChildContainer_1.Visible = true

            if arg25.arguments.NoResize ~= true then
                ResizeGrip_1.Visible = true
            end

            WindowButton_5.AutomaticSize = Enum.AutomaticSize.None
            arg25.lastUncollapsedTick = arg1._cycleTick + 1
        else
            local Y_4 = TitleBar_3.AbsoluteSize.Y
            TitleBar_3.CollapseButton.Arrow.Image = arg2.ICONS.RIGHT_POINTING_TRIANGLE
            ChildContainer_1.Visible = false
            ResizeGrip_1.Visible = false
            WindowButton_5.Size = UDim2.fromOffset(Value.X, Y_4)
            arg25.lastCollapsedTick = arg1._cycleTick + 1
        end

        if Value_3 and Value_2 then
            arg1.SetFocusedWindow(arg25)
        else
            TitleBar_3.BackgroundColor3 = arg1._config.TitleBgCollapsedColor
            TitleBar_3.BackgroundTransparency = arg1._config.TitleBgCollapsedTransparency
            WindowButton_5.UIStroke.Color = arg1._config.BorderColor
            arg1.SetFocusedWindow(nil)
        end

        if Value_4 and Value_4 ~= 0 then
            local v56 = #arg1._postCycleCallbacks + 1
            local v57 = arg1._cycleTick + 1

            arg1._postCycleCallbacks[v56] = function() -- line: 863
                -- upvalues:
                --  [1] arg1 (ref)
                --  [2] v57 (copy)
                --  [3] ChildContainer_1 (copy)
                --  [4] Value_4 (copy)
                --  [5] v56 (copy)

                if arg1._cycleTick == v57 then
                    ChildContainer_1.CanvasPosition = Vector2.new(0, Value_4)
                    arg1._postCycleCallbacks[v56] = nil
                end
            end
        end
    end

    function t_4.GenerateState(arg26) -- line: 871
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v12 (ref)
        --  [3] v11 (ref)
        --  [4] fitPositionToWindowBounds (copy)
        --  [5] fitSizeToWindowBounds (copy)

        if arg26.state.size == nil then
            arg26.state.size = arg1._widgetState(arg26, "size", Vector2.new(400, 300))
        end

        if arg26.state.position == nil then
            local v59 = if not v12 then Vector2.new(150, 250) else if not v11 then Vector2.new(
                150,
                250
            ) else v11.state.position.value + Vector2.new(15, 45)
            arg26.state.position = arg1._widgetState(arg26, "position", v59)
        end

        arg26.state.position.value = fitPositionToWindowBounds(arg26, arg26.state.position.value)
        arg26.state.size.value = fitSizeToWindowBounds(arg26, arg26.state.size.value)

        if arg26.state.isUncollapsed == nil then
            arg26.state.isUncollapsed = arg1._widgetState(arg26, "isUncollapsed", true)
        end

        if arg26.state.isOpened == nil then
            arg26.state.isOpened = arg1._widgetState(arg26, "isOpened", true)
        end

        if arg26.state.scrollDistance == nil then
            arg26.state.scrollDistance = arg1._widgetState(arg26, "scrollDistance", 0)
        end
    end

    WidgetConstructor_1("Window", t_4)
end
