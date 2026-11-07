-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Elements.Widget
-- Class: ModuleScript
-- bytes: 21879

return function(arg1, arg2) -- line: 6
    local Widget_Frame = Instance.new("Frame")
    Widget_Frame:SetAttribute("WidgetUID", arg1.UID)
    Widget_Frame.Name = "Widget"
    Widget_Frame.BackgroundTransparency = 1
    Widget_Frame.Visible = true
    Widget_Frame.ZIndex = 20
    Widget_Frame.Active = false
    Widget_Frame.ClipsDescendants = true
    local Frame_1 = Instance.new("Frame")
    Frame_1.Name = "IconButton"
    Frame_1.Visible = true
    Frame_1.ZIndex = 2
    Frame_1.BorderSizePixel = 0
    Frame_1.Parent = Widget_Frame
    Frame_1.ClipsDescendants = true
    Frame_1.Active = false
    local Template_m = require(script.Parent.Parent.Template)
    local v1 = if Template_m.iconButton then Template_m.iconButton.ClipsDescendants else true
    arg1.deselected:Connect(function() -- line: 27
        -- upvalues:
        --  [1] Frame_1 (copy)
        --  [2] v1 (copy)
        --  [3] arg1 (copy)

        local v2 = v1 or #arg1.menuIcons > 0
        Frame_1.ClipsDescendants = v2
        task.delay(0.2, function() -- line: 30
            -- upvalues:
            --  [1] arg1 (ref)
            --  [2] Frame_1 (ref)

            if arg1.isSelected then
                Frame_1.ClipsDescendants = false
            end
        end)
    end)
    local GuiService = game:GetService("GuiService")
    arg1:setBehaviour("IconButton", "BackgroundTransparency", function(arg3) -- line: 39
        -- upvalues:
        --  [1] GuiService (copy)

        if arg3 == 1 then
            return arg3
        end

        return arg3 * GuiService.PreferredTransparency
    end)
    arg1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- line: 47
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] Frame_1 (copy)

        arg1:refreshAppearance(Frame_1, "BackgroundTransparency")
    end))
    local UICorner = Instance.new("UICorner")
    UICorner:SetAttribute("Collective", "IconCorners")
    UICorner.Name = "UICorner"
    UICorner.Parent = Frame_1
    local v3 = require(script.Parent.Menu)(arg1)
    local MenuUIListLayout = v3.MenuUIListLayout
    local MenuGap = v3.MenuGap
    v3.Parent = Frame_1
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "IconSpot"
    Frame_2.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
    Frame_2.BackgroundTransparency = 0.9
    Frame_2.Visible = true
    Frame_2.AnchorPoint = Vector2.new(0, 0.5)
    Frame_2.ZIndex = 5
    Frame_2.Parent = v3
    UICorner:Clone().Parent = Frame_2
    local v4 = Frame_2:Clone()
    v4.UICorner.Name = "OverlayUICorner"
    v4.Name = "IconOverlay"
    v4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v4.ZIndex = Frame_2.ZIndex + 1
    v4.Size = UDim2.new(1, 0, 1, 0)
    v4.Position = UDim2.new(0, 0, 0, 0)
    v4.AnchorPoint = Vector2.new(0, 0)
    v4.Visible = false
    v4.Parent = Frame_2
    local ClickRegion_TextButton = Instance.new("TextButton")
    ClickRegion_TextButton:SetAttribute("CorrespondingIconUID", arg1.UID)
    ClickRegion_TextButton.Name = "ClickRegion"
    ClickRegion_TextButton.BackgroundTransparency = 1
    ClickRegion_TextButton.Visible = true
    ClickRegion_TextButton.Text = ""
    ClickRegion_TextButton.ZIndex = 20
    ClickRegion_TextButton.Selectable = true
    ClickRegion_TextButton.SelectionGroup = true
    ClickRegion_TextButton.Parent = Frame_2
    require(script.Parent.Parent.Features.Gamepad).registerButton(ClickRegion_TextButton)
    UICorner:Clone().Parent = ClickRegion_TextButton
    local Frame_3 = Instance.new("Frame")
    Frame_3.Name = "Contents"
    Frame_3.BackgroundTransparency = 1
    Frame_3.Size = UDim2.fromScale(1, 1)
    Frame_3.Parent = Frame_2
    local ContentsList_UIListLayout = Instance.new("UIListLayout")
    ContentsList_UIListLayout.Name = "ContentsList"
    ContentsList_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    ContentsList_UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ContentsList_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentsList_UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
    ContentsList_UIListLayout.Padding = UDim.new(0, 3)
    ContentsList_UIListLayout.Parent = Frame_3
    local Frame_4 = Instance.new("Frame")
    Frame_4.Name = "PaddingLeft"
    Frame_4.LayoutOrder = 1
    Frame_4.ZIndex = 5
    Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_4.BackgroundTransparency = 1
    Frame_4.BorderSizePixel = 0
    Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_4.Parent = Frame_3
    local Frame_5 = Instance.new("Frame")
    Frame_5.Name = "PaddingCenter"
    Frame_5.LayoutOrder = 3
    Frame_5.ZIndex = 5
    Frame_5.Size = UDim2.new(0, 0, 1, 0)
    Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_5.BackgroundTransparency = 1
    Frame_5.BorderSizePixel = 0
    Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_5.Parent = Frame_3
    local Frame_6 = Instance.new("Frame")
    Frame_6.Name = "PaddingRight"
    Frame_6.LayoutOrder = 5
    Frame_6.ZIndex = 5
    Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_6.BackgroundTransparency = 1
    Frame_6.BorderSizePixel = 0
    Frame_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_6.Parent = Frame_3
    local Frame_7 = Instance.new("Frame")
    Frame_7.Name = "IconLabelContainer"
    Frame_7.LayoutOrder = 4
    Frame_7.ZIndex = 3
    Frame_7.AnchorPoint = Vector2.new(0, 0.5)
    Frame_7.Size = UDim2.new(0, 0, 0.5, 0)
    Frame_7.BackgroundTransparency = 1
    Frame_7.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame_7.Parent = Frame_3
    local IconLabel_TextLabel = Instance.new("TextLabel")
    local v5 = workspace.CurrentCamera.ViewportSize.X + 200
    IconLabel_TextLabel.Name = "IconLabel"
    IconLabel_TextLabel.LayoutOrder = 4
    IconLabel_TextLabel.ZIndex = 15
    IconLabel_TextLabel.AnchorPoint = Vector2.new(0, 0)
    IconLabel_TextLabel.Size = UDim2.new(0, v5, 1, 0)
    IconLabel_TextLabel.ClipsDescendants = false
    IconLabel_TextLabel.BackgroundTransparency = 1
    IconLabel_TextLabel.Position = UDim2.fromScale(0, 0)
    IconLabel_TextLabel.RichText = true
    IconLabel_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    IconLabel_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    IconLabel_TextLabel.Text = ""
    IconLabel_TextLabel.TextWrapped = true
    IconLabel_TextLabel.TextWrap = true
    IconLabel_TextLabel.TextScaled = false
    IconLabel_TextLabel.Active = false
    IconLabel_TextLabel.AutoLocalize = true
    IconLabel_TextLabel.Parent = Frame_7
    local IconImage_ImageLabel = Instance.new("ImageLabel")
    IconImage_ImageLabel.Name = "IconImage"
    IconImage_ImageLabel.LayoutOrder = 2
    IconImage_ImageLabel.ZIndex = 15
    IconImage_ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
    IconImage_ImageLabel.Size = UDim2.new(0, 0, 0.5, 0)
    IconImage_ImageLabel.BackgroundTransparency = 1
    IconImage_ImageLabel.Position = UDim2.new(0, 11, 0.5, 0)
    IconImage_ImageLabel.ScaleType = Enum.ScaleType.Stretch
    IconImage_ImageLabel.Active = false
    IconImage_ImageLabel.Parent = Frame_3
    local v6 = UICorner:Clone()
    v6:SetAttribute("Collective", nil)
    v6.CornerRadius = UDim.new(0, 0)
    v6.Name = "IconImageCorner"
    v6.Parent = IconImage_ImageLabel
    local TweenService = game:GetService("TweenService")
    local v7 = 0

    local function handleLabelAndImageChangesUnstaggered(_) -- line: 198
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] IconLabel_TextLabel (copy)
        --  [3] IconImage_ImageLabel (copy)
        --  [4] Frame_7 (copy)
        --  [5] Frame_4 (copy)
        --  [6] Frame_5 (copy)
        --  [7] Frame_6 (copy)
        --  [8] Frame_1 (copy)
        --  [9] ContentsList_UIListLayout (copy)
        --  [10] Frame_3 (copy)
        --  [11] Widget_Frame (copy)
        --  [12] v5 (copy)
        --  [13] v3 (copy)
        --  [14] Frame_2 (copy)
        --  [15] MenuUIListLayout (copy)
        --  [16] MenuGap (copy)
        --  [17] TweenService (copy)
        --  [18] ClickRegion_TextButton (copy)
        --  [19] v7 (ref)
        --  [20] arg2 (copy)

        task.defer(function() -- line: 205
            -- upvalues:
            --  [1] arg1 (ref)
            --  [2] IconLabel_TextLabel (ref)
            --  [3] IconImage_ImageLabel (ref)
            --  [4] Frame_7 (ref)
            --  [5] Frame_4 (ref)
            --  [6] Frame_5 (ref)
            --  [7] Frame_6 (ref)
            --  [8] Frame_1 (ref)
            --  [9] ContentsList_UIListLayout (ref)
            --  [10] Frame_3 (ref)
            --  [11] Widget_Frame (ref)
            --  [12] v5 (ref)
            --  [13] v3 (ref)
            --  [14] Frame_2 (ref)
            --  [15] MenuUIListLayout (ref)
            --  [16] MenuGap (ref)
            --  [17] TweenService (ref)
            --  [18] ClickRegion_TextButton (ref)
            --  [19] v7 (ref)
            --  [20] arg2 (ref)

            local v8 = arg1.indicator
            local v9 = v8 and v8.Visible
            v8 = v9 or IconLabel_TextLabel.Text ~= ""
            local v10 = if IconImage_ImageLabel.Image == "" then false else IconImage_ImageLabel.Image ~= nil
            local _ = Enum.HorizontalAlignment.Center
            local udim2 = UDim2.fromScale(1, 1)

            if v10 and not v8 then
                Frame_7.Visible = false
                IconImage_ImageLabel.Visible = true
                Frame_4.Visible = false
                Frame_5.Visible = false
                Frame_6.Visible = false
            elseif not v10 and v8 then
                Frame_7.Visible = true
                IconImage_ImageLabel.Visible = false
                Frame_4.Visible = true
                Frame_5.Visible = false
                Frame_6.Visible = true
            elseif v10 and v8 then
                Frame_7.Visible = true
                IconImage_ImageLabel.Visible = true
                Frame_4.Visible = true
                Frame_5.Visible = not v9
                Frame_6.Visible = not v9
                local _ = Enum.HorizontalAlignment.Left
            end

            Frame_1.Size = udim2

            local _ = function(arg5) --[[ getItemWidth ]] -- line: 235
                return arg5:GetAttribute("TargetWidth") or arg5.AbsoluteSize.X
            end

            local Offset = ContentsList_UIListLayout.Padding.Offset
            v10 = Offset
            Frame_7.Size = UDim2.new(
                0,
                IconLabel_TextLabel.TextBounds.X,
                IconLabel_TextLabel.Size.Y.Scale,
                0
            )

            for _, child in pairs(Frame_3:GetChildren()) do
                if child:IsA("GuiObject") and child.Visible == true then
                    v9 = child:GetAttribute("TargetWidth") or child.AbsoluteSize.X
                    v10 += v9 + Offset
                end
            end

            local MinimumWidth = Widget_Frame:GetAttribute("MinimumWidth")
            v8 = Widget_Frame:GetAttribute("MinimumHeight")
            local BorderSize = Widget_Frame:GetAttribute("BorderSize")
            local v14 = math.clamp(v10, MinimumWidth, v5)
            local v15 = 0
            v10 = #arg1.menuIcons > 0 and true

            if v10 then
                v10 = arg1.isSelected
            end

            if v10 then
                for _, val in pairs(v3:GetChildren()) do
                    if val ~= Frame_2 and val:IsA("GuiObject") and val.Visible then
                        local v18 = val:GetAttribute("TargetWidth") or val.AbsoluteSize.X
                        v15 += v18 + MenuUIListLayout.Padding.Offset
                    end
                end

                if not Frame_2.Visible then
                    local v19 = Frame_2
                    local v20 = v19:GetAttribute("TargetWidth") or v19.AbsoluteSize.X
                    v14 -= v20 + MenuUIListLayout.Padding.Offset * 2 + BorderSize
                end

                v15 -= BorderSize * 0.5
                v14 += v15 - BorderSize * 0.75
            end

            local v21 = MenuGap
            local v22 = v10 and Frame_2.Visible
            v21.Visible = v22
            local DesiredWidth = Widget_Frame:GetAttribute("DesiredWidth")

            if DesiredWidth and v14 < DesiredWidth then
                v14 = DesiredWidth
            end

            arg1.updateMenu:Fire()
            v15 = math.max(v14 - v15, MinimumWidth) - BorderSize * 2
            local MenuWidth = v3:GetAttribute("MenuWidth")
            v10 = MenuWidth

            if v10 then
                v10 = MenuWidth + v15 + MenuUIListLayout.Padding.Offset + 10
            end

            if v10 then
                local MaxWidth = v3:GetAttribute("MaxWidth")

                if MaxWidth then
                    v10 = math.max(MaxWidth, MinimumWidth)
                end

                v3:SetAttribute("MenuCanvasWidth", v14)

                if v10 < v14 then
                    v14 = v10
                end
            end

            local EasingStyle_Quint = Enum.EasingStyle.Quint
            v10 = Enum.EasingDirection.Out
            local v24 = Frame_2
            local v25 = v24:GetAttribute("TargetWidth") or v24.AbsoluteSize.X
            local v26 = math.max(v15, v25, Frame_2.AbsoluteSize.X)
            local v27 = Widget_Frame
            local v28 = v27:GetAttribute("TargetWidth") or v27.AbsoluteSize.X
            local v29 = math.max(v14, v28, Widget_Frame.AbsoluteSize.X)
            local tweenInfo = TweenInfo.new(v26 / 750, EasingStyle_Quint, v10)
            local tweenInfo_1 = TweenInfo.new(v29 / 750, EasingStyle_Quint, v10)
            TweenService:Create(
                Frame_2,
                tweenInfo,
                {
                    Position = UDim2.new(0, BorderSize, 0.5, 0),
                    Size = UDim2.new(0, v15, 1, -BorderSize * 2)
                }
            ):Play()
            TweenService:Create(
                ClickRegion_TextButton,
                tweenInfo,
                { Size = UDim2.new(0, v15, 1, 0) }
            ):Play()
            local udim2_1 = UDim2.fromOffset(v14, v8)

            if if Widget_Frame.Size.Y.Offset == v8 then false else true then
                Widget_Frame.Size = udim2_1
            end

            Widget_Frame:SetAttribute("TargetWidth", udim2_1.X.Offset)
            TweenService:Create(Widget_Frame, tweenInfo_1, { Size = udim2_1 }):Play()
            v7 += 1

            for index = 1, tweenInfo_1.Time * 100 do
                local _ = tweenInfo_1.Time * 100
                task.delay(index / 100, function() -- line: 317
                    -- upvalues:
                    --  [1] arg2 (ref)
                    --  [2] arg1 (ref)

                    arg2.iconChanged:Fire(arg1)
                end)
            end

            task.delay(tweenInfo_1.Time - 0.2, function() -- line: 321
                -- upvalues:
                --  [1] v7 (ref)
                --  [2] arg1 (ref)

                v7 -= 1
                task.defer(function() -- line: 323
                    -- upvalues:
                    --  [1] v7 (ref)
                    --  [2] arg1 (ref)

                    if v7 == 0 then
                        arg1.resizingComplete:Fire()
                    end
                end)
            end)
            arg1:updateParent()
        end)
    end

    local v35 = require(script.Parent.Parent.Utility).createStagger(
        0.01,
        handleLabelAndImageChangesUnstaggered
    )
    arg1:setBehaviour("IconLabel", "Text", v35)
    local v36 = true
    arg1:setBehaviour("IconLabel", "FontFace", function(arg6) -- line: 336
        -- upvalues:
        --  [1] IconLabel_TextLabel (copy)
        --  [2] v35 (copy)
        --  [3] v36 (ref)

        if IconLabel_TextLabel.FontFace == arg6 then
            return
        end

        task.spawn(function() -- line: 341
            -- upvalues:
            --  [1] v35 (ref)
            --  [2] v36 (ref)

            v35()

            if v36 then
                v36 = false

                for _ = 1, 10 do
                    task.wait(1)
                    v35()
                end
            end
        end)
    end)

    local function updateBorderSize() -- line: 363
        -- upvalues:
        --  [1] Widget_Frame (copy)
        --  [2] arg1 (copy)
        --  [3] Frame_2 (copy)
        --  [4] v3 (copy)
        --  [5] MenuGap (copy)
        --  [6] MenuUIListLayout (copy)
        --  [7] v35 (copy)

        task.defer(function() -- line: 364
            -- upvalues:
            --  [1] Widget_Frame (ref)
            --  [2] arg1 (ref)
            --  [3] Frame_2 (ref)
            --  [4] v3 (ref)
            --  [5] MenuGap (ref)
            --  [6] MenuUIListLayout (ref)
            --  [7] v35 (ref)

            local BorderSize_1 = Widget_Frame:GetAttribute("BorderSize")
            v3.Position = UDim2.new(
                0,
                if Frame_2.Visible == false then 0 else if arg1.alignment ~= "Right" then BorderSize_1 else -BorderSize_1 or BorderSize_1,
                0,
                0
            )
            MenuGap.Size = UDim2.fromOffset(BorderSize_1, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            v35()
        end)
    end

    arg1:setBehaviour("Widget", "BorderSize", updateBorderSize)
    arg1:setBehaviour("IconSpot", "Visible", updateBorderSize)
    arg1.startMenuUpdate:Connect(v35)
    arg1.updateSize:Connect(v35)
    arg1:setBehaviour("ContentsList", "HorizontalAlignment", v35)
    arg1:setBehaviour("Widget", "Visible", v35)
    arg1:setBehaviour("Widget", "DesiredWidth", v35)
    arg1:setBehaviour("Widget", "MinimumWidth", v35)
    arg1:setBehaviour("Widget", "MinimumHeight", v35)
    arg1:setBehaviour("Indicator", "Visible", v35)
    arg1:setBehaviour("IconImageRatio", "AspectRatio", v35)
    arg1:setBehaviour("IconImage", "Image", function(arg7) -- line: 385
        -- upvalues:
        --  [1] IconImage_ImageLabel (copy)
        --  [2] v35 (copy)

        local v41 = tonumber(arg7) and "http://www.roblox.com/asset/?id=" .. arg7 or (arg7 or "")

        if IconImage_ImageLabel.Image ~= v41 then
            v35()
        end

        return v41
    end)
    arg1.alignmentChanged:Connect(function(arg8) -- line: 392
        -- upvalues:
        --  [1] MenuUIListLayout (copy)
        --  [2] Widget_Frame (copy)
        --  [3] arg1 (copy)
        --  [4] Frame_2 (copy)
        --  [5] v3 (copy)
        --  [6] MenuGap (copy)
        --  [7] v35 (copy)

        if arg8 == "Center" then
            arg8 = "Left"
        end

        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[arg8]
        task.defer(function() -- line: 364
            -- upvalues:
            --  [1] Widget_Frame (ref)
            --  [2] arg1 (ref)
            --  [3] Frame_2 (ref)
            --  [4] v3 (ref)
            --  [5] MenuGap (ref)
            --  [6] MenuUIListLayout (ref)
            --  [7] v35 (ref)

            local BorderSize_2 = Widget_Frame:GetAttribute("BorderSize")
            v3.Position = UDim2.new(
                0,
                if Frame_2.Visible == false then 0 else if arg1.alignment ~= "Right" then BorderSize_2 else -BorderSize_2 or BorderSize_2,
                0,
                0
            )
            MenuGap.Size = UDim2.fromOffset(BorderSize_2, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            v35()
        end)
    end)
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local LocaleId = LocalPlayer.LocaleId
    arg1.janitor:add(LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(function() -- line: 404
        -- upvalues:
        --  [1] LocalPlayer (copy)
        --  [2] LocaleId (ref)
        --  [3] arg1 (copy)

        task.delay(0.2, function() -- line: 405
            -- upvalues:
            --  [1] LocalPlayer (ref)
            --  [2] LocaleId (ref)
            --  [3] arg1 (ref)

            local LocaleId_2 = LocalPlayer.LocaleId

            if LocaleId_2 ~= LocaleId then
                LocaleId = LocaleId_2
                arg1:refresh()
                task.wait(0.5)
                arg1:refresh()
            end
        end)
    end))
    local IconImageScale_NumberValue = Instance.new("NumberValue")
    IconImageScale_NumberValue.Name = "IconImageScale"
    IconImageScale_NumberValue.Parent = IconImage_ImageLabel
    IconImageScale_NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- line: 419
        -- upvalues:
        --  [1] IconImage_ImageLabel (copy)
        --  [2] IconImageScale_NumberValue (copy)

        IconImage_ImageLabel.Size = UDim2.new(
            IconImageScale_NumberValue.Value,
            0,
            IconImageScale_NumberValue.Value,
            0
        )
    end)
    local IconImageRatio_UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    IconImageRatio_UIAspectRatioConstraint.Name = "IconImageRatio"
    IconImageRatio_UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    IconImageRatio_UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    IconImageRatio_UIAspectRatioConstraint.Parent = IconImage_ImageLabel
    local IconGradient_UIGradient = Instance.new("UIGradient")
    IconGradient_UIGradient.Name = "IconGradient"
    IconGradient_UIGradient.Enabled = true
    IconGradient_UIGradient.Parent = Frame_1
    local UIGradient_1 = Instance.new("UIGradient")
    UIGradient_1.Name = "IconSpotGradient"
    UIGradient_1.Enabled = true
    UIGradient_1.Parent = Frame_2

    if Template_m.iconButton then
        Template_m.applyToButton(Frame_1)
        Frame_1.ClipsDescendants = v1

        if Template_m.widget then
            Widget_Frame.ClipsDescendants = Template_m.widget.ClipsDescendants
        end
    end

    return Widget_Frame
end
