-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets
-- Class: ModuleScript
-- bytes: 21680

local _ = require(script.Parent.Types)
local t = {}

return function(arg1) -- line: 5
    -- upvalues:
    --  [1] t (copy)

    t.GuiService = game:GetService("GuiService")
    t.RunService = game:GetService("RunService")
    t.UserInputService = game:GetService("UserInputService")
    t.ContextActionService = game:GetService("ContextActionService")
    t.TextService = game:GetService("TextService")
    t.ICONS = {
        RIGHT_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
        DOWN_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
        MULTIPLICATION_SIGN = "rbxasset://textures/AnimationEditor/icon_close.png",
        BOTTOM_RIGHT_CORNER = "\226\151\162",
        CHECK_MARK = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
        ALPHA_BACKGROUND_TEXTURE = "rbxasset://textures/meshPartFallback.png"
    }
    t.GuiInset = t.GuiService:GetGuiInset()
    t.IS_STUDIO = t.RunService:IsStudio()

    function t.getTime() -- line: 24
        -- upvalues:
        --  [1] t (ref)

        if t.IS_STUDIO then
            return os.clock()
        end

        return time()
    end

    function t.getMouseLocation() -- line: 33
        -- upvalues:
        --  [1] t (ref)

        return t.UserInputService:GetMouseLocation() - t.GuiInset
    end

    function t.findBestWindowPosForPopup(u1: Vector2, u2: Vector2, u3: Vector2, u4: Vector2) -- line: 37
        u1 = if not (u1.X + u2.X + 20 > u4.X) then u1 + Vector2.new(20, 0) else if not (u1.Y + u2.Y + 20 > u4.Y) then u1 + Vector2.new(
            0,
            20
        ) else u1 + Vector2.new(0, -(20 + u2.Y))
        local New = Vector2.new
        local v9 = math.min(u1.X + u2.X, u4.X)
        local v10 = math.max(v9 - u2.X, u3.X)
        local v11 = math.min(u1.Y + u2.Y, u4.Y)

        return (New(v10, (math.max(v11 - u2.Y, u3.Y))))
    end

    function t.isPosInsideRect(u5: Vector2, u6: Vector2, u7: Vector2) -- line: 57
        return u5.X > u6.X and (u5.X < u7.X and (u5.Y > u6.Y and u5.Y < u7.Y))
    end

    function t.extend(arg2, arg3) -- line: 61
        local t_1 = table.clone(arg2)

        for key, val in arg3 do
            t_1[key] = val
        end

        return t_1
    end

    function t.UIPadding(u8: userdata, u9: Vector2) -- line: 69
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, u9.X)
        UIPadding.PaddingRight = UDim.new(0, u9.X)
        UIPadding.PaddingTop = UDim.new(0, u9.Y)
        UIPadding.PaddingBottom = UDim.new(0, u9.Y)
        UIPadding.Parent = u8

        return UIPadding
    end

    function t.UIListLayout(u10: userdata, arg4: any, u11: UDim) -- line: 79
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = u11
        UIListLayout.FillDirection = arg4
        UIListLayout.Parent = u10

        return UIListLayout
    end

    function t.UIStroke(u12: userdata, n1: number, u13: Color3, n2: number) -- line: 88
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = n1
        UIStroke.Color = u13
        UIStroke.Transparency = n2
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round
        UIStroke.Parent = u12

        return UIStroke
    end

    function t.UICorner(u14: userdata, n3: number?) -- line: 99
        local UICorner = Instance.new("UICorner")
        local v13 = if not n3 then 1 else 0
        UICorner.CornerRadius = UDim.new(v13, n3 or 0)
        UICorner.Parent = u14

        return UICorner
    end

    function t.UISizeConstraint(u15: userdata, u16: Vector2?, u17: Vector2?) -- line: 106
        local UISizeConstraint = Instance.new("UISizeConstraint")
        UISizeConstraint.MinSize = u16 or UISizeConstraint.MinSize
        UISizeConstraint.MaxSize = u17 or UISizeConstraint.MaxSize
        UISizeConstraint.Parent = u15

        return UISizeConstraint
    end

    function t.UIReference(u18: userdata, u19: userdata, s1: string) -- line: 114
        local ObjectValue = Instance.new("ObjectValue")
        ObjectValue.Name = s1
        ObjectValue.Value = u19
        ObjectValue.Parent = u18

        return ObjectValue
    end

    function t.getScreenSizeForWindow(arg5) -- line: 123
        if arg5.usesScreenGUI then
            return arg5.Instance.AbsoluteSize
        end

        local Parent = arg5.Instance.Parent

        if Parent:IsA("GuiBase2d") then
            return Parent.AbsoluteSize
        end

        if Parent.Parent:IsA("GuiBase2d") then
            return Parent.AbsoluteSize
        end

        return workspace.CurrentCamera.ViewportSize
    end

    local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
    GetTextBoundsParams.Font = arg1._config.TextFont
    GetTextBoundsParams.Size = arg1._config.TextSize
    GetTextBoundsParams.Width = math.huge

    function t.calculateTextSize(s2: string, n4: number?) -- line: 148
        -- upvalues:
        --  [1] GetTextBoundsParams (copy)
        --  [2] t (ref)

        if n4 then
            GetTextBoundsParams.Width = n4
        end

        GetTextBoundsParams.Text = s2
        local v15 = t.TextService:GetTextBoundsAsync(GetTextBoundsParams)

        if n4 then
            GetTextBoundsParams.Width = math.huge
        end

        return v15
    end

    function t.applyTextStyle(arg6) -- line: 163
        -- upvalues:
        --  [1] arg1 (copy)

        arg6.FontFace = arg1._config.TextFont
        arg6.TextSize = arg1._config.TextSize
        arg6.TextColor3 = arg1._config.TextColor
        arg6.TextTransparency = arg1._config.TextTransparency
        arg6.TextXAlignment = Enum.TextXAlignment.Left
        arg6.AutoLocalize = false
        arg6.RichText = false
    end

    function t.applyInteractionHighlights(u20: userdata, u21: userdata, t1: table) -- line: 174
        -- upvalues:
        --  [1] arg1 (copy)

        local v16 = false
        u20.MouseEnter:Connect(function() -- line: 176
            -- upvalues:
            --  [1] u21 (copy)
            --  [2] t1 (copy)
            --  [3] v16 (ref)

            u21.BackgroundColor3 = t1.ButtonHoveredColor
            u21.BackgroundTransparency = t1.ButtonHoveredTransparency
            v16 = false
        end)
        u20.MouseLeave:Connect(function() -- line: 183
            -- upvalues:
            --  [1] u21 (copy)
            --  [2] t1 (copy)
            --  [3] v16 (ref)

            u21.BackgroundColor3 = t1.ButtonColor
            u21.BackgroundTransparency = t1.ButtonTransparency
            v16 = true
        end)
        u20.InputBegan:Connect(function(input: userdata) -- line: 190
            -- upvalues:
            --  [1] u21 (copy)
            --  [2] t1 (copy)

            if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return
            end

            u21.BackgroundColor3 = t1.ButtonActiveColor
            u21.BackgroundTransparency = t1.ButtonActiveTransparency
        end)
        u20.InputEnded:Connect(function(input_1: userdata) -- line: 198
            -- upvalues:
            --  [1] v16 (ref)
            --  [2] u21 (copy)
            --  [3] t1 (copy)

            if if input_1.UserInputType == Enum.UserInputType.MouseButton1 then v16 else input_1.UserInputType ~= Enum.UserInputType.Gamepad1 or v16 then
                return
            end

            if input_1.UserInputType == Enum.UserInputType.MouseButton1 then
                u21.BackgroundColor3 = t1.ButtonHoveredColor
                u21.BackgroundTransparency = t1.ButtonHoveredTransparency
            end

            if input_1.UserInputType == Enum.UserInputType.Gamepad1 then
                u21.BackgroundColor3 = t1.ButtonColor
                u21.BackgroundTransparency = t1.ButtonTransparency
            end
        end)
        u20.SelectionImageObject = arg1.SelectionImageObject
    end

    function t.applyInteractionHighlightsWithMultiHighlightee(u24: userdata, t2: table) -- line: 215
        -- upvalues:
        --  [1] arg1 (copy)

        local v17 = false
        u24.MouseEnter:Connect(function() -- line: 217
            -- upvalues:
            --  [1] t2 (copy)
            --  [2] v17 (ref)

            for _, val_1 in t2 do
                val_1[1].BackgroundColor3 = val_1[2].ButtonHoveredColor
                val_1[1].BackgroundTransparency = val_1[2].ButtonHoveredTransparency
                v17 = false
            end
        end)
        u24.MouseLeave:Connect(function() -- line: 226
            -- upvalues:
            --  [1] t2 (copy)
            --  [2] v17 (ref)

            for _, val_2 in t2 do
                val_2[1].BackgroundColor3 = val_2[2].ButtonColor
                val_2[1].BackgroundTransparency = val_2[2].ButtonTransparency
                v17 = true
            end
        end)
        u24.InputBegan:Connect(function(input_2: userdata) -- line: 235
            -- upvalues:
            --  [1] t2 (copy)

            if input_2.UserInputType ~= Enum.UserInputType.MouseButton1 and input_2.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return
            end

            for _, val_3 in t2 do
                val_3[1].BackgroundColor3 = val_3[2].ButtonActiveColor
                val_3[1].BackgroundTransparency = val_3[2].ButtonActiveTransparency
            end
        end)
        u24.InputEnded:Connect(function(input_3: userdata) -- line: 245
            -- upvalues:
            --  [1] v17 (ref)
            --  [2] t2 (copy)

            if if input_3.UserInputType == Enum.UserInputType.MouseButton1 then v17 else input_3.UserInputType ~= Enum.UserInputType.Gamepad1 or v17 then
                return
            end

            for _, val_4 in t2 do
                if input_3.UserInputType == Enum.UserInputType.MouseButton1 then
                    val_4[1].BackgroundColor3 = val_4[2].ButtonHoveredColor
                    val_4[1].BackgroundTransparency = val_4[2].ButtonHoveredTransparency
                end

                if input_3.UserInputType == Enum.UserInputType.Gamepad1 then
                    val_4[1].BackgroundColor3 = val_4[2].ButtonColor
                    val_4[1].BackgroundTransparency = val_4[2].ButtonTransparency
                end
            end
        end)
        u24.SelectionImageObject = arg1.SelectionImageObject
    end

    function t.applyTextInteractionHighlights(u27: userdata, arg7: any, t3: table) -- line: 264
        -- upvalues:
        --  [1] arg1 (copy)

        local v18 = false
        u27.MouseEnter:Connect(function() -- line: 266
            -- upvalues:
            --  [1] arg7 (copy)
            --  [2] t3 (copy)
            --  [3] v18 (ref)

            arg7.TextColor3 = t3.ButtonHoveredColor
            arg7.TextTransparency = t3.ButtonHoveredTransparency
            v18 = false
        end)
        u27.MouseLeave:Connect(function() -- line: 273
            -- upvalues:
            --  [1] arg7 (copy)
            --  [2] t3 (copy)
            --  [3] v18 (ref)

            arg7.TextColor3 = t3.ButtonColor
            arg7.TextTransparency = t3.ButtonTransparency
            v18 = true
        end)
        u27.InputBegan:Connect(function(input_4: userdata) -- line: 280
            -- upvalues:
            --  [1] arg7 (copy)
            --  [2] t3 (copy)

            if input_4.UserInputType ~= Enum.UserInputType.MouseButton1 and input_4.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return
            end

            arg7.TextColor3 = t3.ButtonActiveColor
            arg7.TextTransparency = t3.ButtonActiveTransparency
        end)
        u27.InputEnded:Connect(function(input_5: userdata) -- line: 288
            -- upvalues:
            --  [1] v18 (ref)
            --  [2] arg7 (copy)
            --  [3] t3 (copy)

            if if input_5.UserInputType == Enum.UserInputType.MouseButton1 then v18 else input_5.UserInputType ~= Enum.UserInputType.Gamepad1 or v18 then
                return
            end

            if input_5.UserInputType == Enum.UserInputType.MouseButton1 then
                arg7.TextColor3 = t3.ButtonHoveredColor
                arg7.TextTransparency = t3.ButtonHoveredTransparency
            end

            if input_5.UserInputType == Enum.UserInputType.Gamepad1 then
                arg7.TextColor3 = t3.ButtonColor
                arg7.TextTransparency = t3.ButtonTransparency
            end
        end)
        u27.SelectionImageObject = arg1.SelectionImageObject
    end

    function t.applyFrameStyle(u30: userdata, b1: boolean?, b2: boolean?) -- line: 305
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] t (ref)

        local FrameBorderSize = arg1._config.FrameBorderSize
        local BorderColor = arg1._config.BorderColor
        local FrameRounding = arg1._config.FrameRounding

        if FrameBorderSize > 0 and FrameRounding > 0 then
            local _ = arg1._config.FramePadding
            local ButtonTransparency = arg1._config.ButtonTransparency
            u30.BorderSizePixel = 0
            local UIStroke_2 = Instance.new("UIStroke")
            UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            UIStroke_2.LineJoinMode = Enum.LineJoinMode.Round
            UIStroke_2.Transparency = ButtonTransparency
            UIStroke_2.Thickness = FrameBorderSize
            UIStroke_2.Color = BorderColor
            t.UICorner(u30, FrameRounding)
            UIStroke_2.Parent = u30

            if not b1 then
                t.UIPadding(u30, arg1._config.FramePadding)

                return
            end
        elseif FrameBorderSize < 1 and FrameRounding > 0 then
            local _ = arg1._config.FramePadding
            u30.BorderSizePixel = 0
            t.UICorner(u30, FrameRounding)

            if not b1 then
                t.UIPadding(u30, arg1._config.FramePadding)

                return
            end
        elseif FrameRounding < 1 then
            local FramePadding_2 = arg1._config.FramePadding
            u30.BorderSizePixel = FrameBorderSize
            u30.BorderColor3 = BorderColor
            u30.BorderMode = Enum.BorderMode.Inset

            if not b1 then
                t.UIPadding(u30, FramePadding_2 - Vector2.new(FrameBorderSize, FrameBorderSize))

                return
            end

            if not b2 then
                t.UIPadding(u30, -Vector2.new(FrameBorderSize, FrameBorderSize))
            end
        end
    end

    function t.discardState(arg8) -- line: 350
        for _, val_5 in arg8.state do
            val_5.ConnectedWidgets[arg8.ID] = nil
        end
    end

    local t_2 = {
        hover = function(f1: (...any) -> ...any) --[[ hover ]] -- line: 357
            local t_3 = {}

            function t_3.Init(arg9) -- line: 359
                -- upvalues:
                --  [1] f1 (copy)

                local v19 = f1(arg9)
                v19.MouseEnter:Connect(function() -- line: 361
                    -- upvalues:
                    --  [1] arg9 (copy)

                    arg9.isHoveredEvent = true
                end)
                v19.MouseLeave:Connect(function() -- line: 364
                    -- upvalues:
                    --  [1] arg9 (copy)

                    arg9.isHoveredEvent = false
                end)
                arg9.isHoveredEvent = false
            end

            function t_3.Get(arg10) -- line: 369
                return arg10.isHoveredEvent
            end

            return t_3
        end,
        click = nil,
        rightClick = nil,
        doubleClick = nil,
        ctrlClick = nil,
        shortcut = nil
    }

    function t_2.click(f2: (...any) -> ...any) -- line: 375
        -- upvalues:
        --  [1] arg1 (copy)

        local t_4 = {}

        function t_4.Init(arg11) -- line: 377
            -- upvalues:
            --  [1] f2 (copy)
            --  [2] arg1 (ref)

            local v20 = f2(arg11)
            arg11.lastClickedTick = -1
            v20.MouseButton1Click:Connect(function() -- line: 381
                -- upvalues:
                --  [1] arg11 (copy)
                --  [2] arg1 (ref)

                arg11.lastClickedTick = arg1._cycleTick + 1
            end)
        end

        function t_4.Get(arg12) -- line: 385
            -- upvalues:
            --  [1] arg1 (ref)

            return arg12.lastClickedTick == arg1._cycleTick
        end

        return t_4
    end

    function t_2.rightClick(f3: (...any) -> ...any) -- line: 391
        -- upvalues:
        --  [1] arg1 (copy)

        local t_5 = {}

        function t_5.Init(arg13) -- line: 393
            -- upvalues:
            --  [1] f3 (copy)
            --  [2] arg1 (ref)

            local v22 = f3(arg13)
            arg13.lastRightClickedTick = -1
            v22.MouseButton2Click:Connect(function() -- line: 397
                -- upvalues:
                --  [1] arg13 (copy)
                --  [2] arg1 (ref)

                arg13.lastRightClickedTick = arg1._cycleTick + 1
            end)
        end

        function t_5.Get(arg14) -- line: 401
            -- upvalues:
            --  [1] arg1 (ref)

            return arg14.lastRightClickedTick == arg1._cycleTick
        end

        return t_5
    end

    function t_2.doubleClick(f4: (...any) -> ...any) -- line: 407
        -- upvalues:
        --  [1] t (ref)
        --  [2] arg1 (copy)

        local t_6 = {}

        function t_6.Init(arg15) -- line: 409
            -- upvalues:
            --  [1] f4 (copy)
            --  [2] t (ref)
            --  [3] arg1 (ref)

            local v24 = f4(arg15)
            arg15.lastClickedTime = -1
            arg15.lastClickedPosition = Vector2.zero
            arg15.lastDoubleClickedTick = -1
            v24.MouseButton1Down:Connect(function(x: number, y: number) -- line: 415
                -- upvalues:
                --  [1] t (ref)
                --  [2] arg15 (copy)
                --  [3] arg1 (ref)

                local v25 = t.getTime()

                if if not (v25 - arg15.lastClickedTime < arg1._config.MouseDoubleClickTime) then false else true then
                    if (Vector2.new(x, y) - arg15.lastClickedPosition).Magnitude < arg1._config.MouseDoubleClickMaxDist then
                        arg15.lastDoubleClickedTick = arg1._cycleTick + 1

                        return
                    end
                end

                arg15.lastClickedTime = v25
                arg15.lastClickedPosition = Vector2.new(x, y)
            end)
        end

        function t_6.Get(arg16) -- line: 426
            -- upvalues:
            --  [1] arg1 (ref)

            return arg16.lastDoubleClickedTick == arg1._cycleTick
        end

        return t_6
    end

    function t_2.ctrlClick(f5: (...any) -> ...any) -- line: 432
        -- upvalues:
        --  [1] t (ref)
        --  [2] arg1 (copy)

        local t_7 = {}

        function t_7.Init(arg17) -- line: 434
            -- upvalues:
            --  [1] f5 (copy)
            --  [2] t (ref)
            --  [3] arg1 (ref)

            local v29 = f5(arg17)
            arg17.lastCtrlClickedTick = -1
            v29.MouseButton1Click:Connect(function() -- line: 438
                -- upvalues:
                --  [1] t (ref)
                --  [2] arg17 (copy)
                --  [3] arg1 (ref)

                if not t.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    if t.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                        arg17.lastCtrlClickedTick = arg1._cycleTick + 1
                    end
                else
                    arg17.lastCtrlClickedTick = arg1._cycleTick + 1
                end
            end)
        end

        function t_7.Get(arg18) -- line: 444
            -- upvalues:
            --  [1] arg1 (ref)

            return arg18.lastCtrlClickedTick == arg1._cycleTick
        end

        return t_7
    end

    function t_2.shortcut(f6: (...any) -> ...any) -- line: 450
        -- upvalues:
        --  [1] t (ref)
        --  [2] arg1 (copy)

        local t_8 = {}

        function t_8.Init(arg19) -- line: 452
            -- upvalues:
            --  [1] f6 (copy)
            --  [2] t (ref)
            --  [3] arg1 (ref)

            local v31, v32 = f6(arg19)
            arg19.lastShortcutTick = -1
            t.ContextActionService:BindAction(arg19.ID, function(_: any, arg21: any, u31: userdata) -- line: 456
                -- upvalues:
                --  [1] v32 (copy)
                --  [2] arg19 (copy)
                --  [3] arg1 (ref)

                if arg21 == Enum.UserInputState.Begin and u31:IsModifierKeyDown(v32) then
                    arg19.lastShortcutTick = arg1._cycleTick + 1
                end
            end, false, v31)
        end

        function t_8.Get(arg22) -- line: 464
            -- upvalues:
            --  [1] arg1 (ref)

            return arg22.lastShortcutTick == arg1._cycleTick
        end

        return t_8
    end

    t.EVENTS = t_2
    require(script.Root)(arg1, t)
    require(script.Window)(arg1, t)
    require(script.Menu)(arg1, t)
    require(script.Format)(arg1, t)
    require(script.Text)(arg1, t)
    require(script.Button)(arg1, t)
    require(script.Checkbox)(arg1, t)
    require(script.RadioButton)(arg1, t)
    require(script.Tree)(arg1, t)
    require(script.Input)(arg1, t)
    require(script.Combo)(arg1, t)
    require(script.Table)(arg1, t)
end
