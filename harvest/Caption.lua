-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Elements.Caption
-- Class: ModuleScript
-- bytes: 14956

local color = Color3.fromRGB(39, 41, 48)

return function(arg1) -- line: 3
    -- upvalues:
    --  [1] color (copy)

    local ClickRegion = arg1:getInstance("ClickRegion")
    local Caption_CanvasGroup = Instance.new("CanvasGroup")
    Caption_CanvasGroup.Name = "Caption"
    Caption_CanvasGroup.AnchorPoint = Vector2.new(0.5, 0)
    Caption_CanvasGroup.BackgroundTransparency = 1
    Caption_CanvasGroup.BorderSizePixel = 0
    Caption_CanvasGroup.GroupTransparency = 1
    Caption_CanvasGroup.Position = UDim2.fromOffset(0, 0)
    Caption_CanvasGroup.Visible = true
    Caption_CanvasGroup.ZIndex = 30
    Caption_CanvasGroup.Parent = ClickRegion
    local Box_Frame = Instance.new("Frame")
    Box_Frame.Name = "Box"
    Box_Frame.AutomaticSize = Enum.AutomaticSize.XY
    Box_Frame.BackgroundColor3 = color
    Box_Frame.Position = UDim2.fromOffset(4, 7)
    Box_Frame.ZIndex = 12
    Box_Frame.Parent = Caption_CanvasGroup
    local Header_TextLabel = Instance.new("TextLabel")
    Header_TextLabel.Name = "Header"
    Header_TextLabel.FontFace = Font.new(
        "rbxasset://fonts/families/BuilderSans.json",
        Enum.FontWeight.Medium,
        Enum.FontStyle.Normal
    )
    Header_TextLabel.Text = "Caption"
    Header_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header_TextLabel.TextSize = 15
    Header_TextLabel.TextTruncate = Enum.TextTruncate.None
    Header_TextLabel.TextWrapped = false
    Header_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    Header_TextLabel.AutomaticSize = Enum.AutomaticSize.X
    Header_TextLabel.BackgroundTransparency = 1
    Header_TextLabel.LayoutOrder = 1
    Header_TextLabel.Size = UDim2.fromOffset(0, 16)
    Header_TextLabel.ZIndex = 18
    Header_TextLabel.Parent = Box_Frame
    local Layout_UIListLayout = Instance.new("UIListLayout")
    Layout_UIListLayout.Name = "Layout"
    Layout_UIListLayout.Padding = UDim.new(0, 8)
    Layout_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout_UIListLayout.Parent = Box_Frame
    local CaptionCorner_UICorner = Instance.new("UICorner")
    CaptionCorner_UICorner.Name = "CaptionCorner"
    CaptionCorner_UICorner.Parent = Box_Frame
    local Padding_UIPadding = Instance.new("UIPadding")
    Padding_UIPadding.Name = "Padding"
    Padding_UIPadding.PaddingBottom = UDim.new(0, 12)
    Padding_UIPadding.PaddingLeft = UDim.new(0, 12)
    Padding_UIPadding.PaddingRight = UDim.new(0, 12)
    Padding_UIPadding.PaddingTop = UDim.new(0, 12)
    Padding_UIPadding.Parent = Box_Frame
    local Frame_1 = Instance.new("Frame")
    Frame_1.Name = "Hotkeys"
    Frame_1.AutomaticSize = Enum.AutomaticSize.Y
    Frame_1.BackgroundTransparency = 1
    Frame_1.LayoutOrder = 3
    Frame_1.Size = UDim2.fromScale(1, 0)
    Frame_1.Visible = false
    Frame_1.Parent = Box_Frame
    local UIListLayout_1 = Instance.new("UIListLayout")
    UIListLayout_1.Name = "Layout1"
    UIListLayout_1.Padding = UDim.new(0, 6)
    UIListLayout_1.FillDirection = Enum.FillDirection.Vertical
    UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_1.HorizontalFlex = Enum.UIFlexAlignment.None
    UIListLayout_1.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
    UIListLayout_1.VerticalFlex = Enum.UIFlexAlignment.None
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_1.Parent = Frame_1
    local Key1_ImageLabel = Instance.new("ImageLabel")
    Key1_ImageLabel.Name = "Key1"
    Key1_ImageLabel.Image = "rbxasset://textures/ui/Controls/key_single.png"
    Key1_ImageLabel.ImageTransparency = 0.7
    Key1_ImageLabel.ScaleType = Enum.ScaleType.Slice
    Key1_ImageLabel.SliceCenter = Rect.new(5, 5, 23, 24)
    Key1_ImageLabel.AutomaticSize = Enum.AutomaticSize.X
    Key1_ImageLabel.BackgroundTransparency = 1
    Key1_ImageLabel.LayoutOrder = 1
    Key1_ImageLabel.Size = UDim2.fromOffset(0, 30)
    Key1_ImageLabel.ZIndex = 15
    Key1_ImageLabel.Parent = Frame_1
    local UIPadding_1 = Instance.new("UIPadding")
    UIPadding_1.Name = "Inset"
    UIPadding_1.PaddingLeft = UDim.new(0, 8)
    UIPadding_1.PaddingRight = UDim.new(0, 8)
    UIPadding_1.Parent = Key1_ImageLabel
    local TextLabel_1 = Instance.new("TextLabel")
    TextLabel_1.AutoLocalize = false
    TextLabel_1.Name = "LabelContent"
    TextLabel_1.FontFace = Font.new(
        "rbxasset://fonts/families/GothamSSm.json",
        Enum.FontWeight.Medium,
        Enum.FontStyle.Normal
    )
    TextLabel_1.Text = ""
    TextLabel_1.TextColor3 = Color3.fromRGB(189, 190, 190)
    TextLabel_1.TextSize = 15
    TextLabel_1.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_1.BackgroundTransparency = 1
    TextLabel_1.Position = UDim2.fromOffset(0, -1)
    TextLabel_1.Size = UDim2.fromScale(1, 1)
    TextLabel_1.ZIndex = 16
    TextLabel_1.Parent = Key1_ImageLabel
    local ImageLabel_1 = Instance.new("ImageLabel")
    ImageLabel_1.Name = "Caret"
    ImageLabel_1.Image = "rbxassetid://101906294438076"
    ImageLabel_1.ImageColor3 = color
    ImageLabel_1.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel_1.BackgroundTransparency = 1
    ImageLabel_1.Position = UDim2.new(0, 0, 0, 4)
    ImageLabel_1.Size = UDim2.fromOffset(16, 8)
    ImageLabel_1.ZIndex = 12
    ImageLabel_1.Parent = Caption_CanvasGroup
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Visible = true
    ImageLabel_2.Name = "DropShadow"
    ImageLabel_2.Image = "rbxassetid://124920646932671"
    ImageLabel_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel_2.ImageTransparency = 0.45
    ImageLabel_2.ScaleType = Enum.ScaleType.Slice
    ImageLabel_2.SliceCenter = Rect.new(12, 12, 13, 13)
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Position = UDim2.fromOffset(0, 5)
    ImageLabel_2.Size = UDim2.new(1, 0, 0, 48)
    ImageLabel_2.Parent = Caption_CanvasGroup
    Box_Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 145
        -- upvalues:
        --  [1] ImageLabel_2 (copy)
        --  [2] Box_Frame (copy)

        ImageLabel_2.Size = UDim2.new(1, 0, 0, Box_Frame.AbsoluteSize.Y + 8)
    end)
    local CaptionJanitor = arg1.captionJanitor
    local _, v3 = arg1:clipOutside(Caption_CanvasGroup)
    v3.AutomaticSize = Enum.AutomaticSize.None

    local function matchSize() -- line: 155
        -- upvalues:
        --  [1] Caption_CanvasGroup (copy)
        --  [2] v3 (copy)

        local AbsoluteSize_1 = Caption_CanvasGroup.AbsoluteSize
        v3.Size = UDim2.fromOffset(AbsoluteSize_1.X, AbsoluteSize_1.Y)
    end

    CaptionJanitor:add(
        Caption_CanvasGroup:GetPropertyChangedSignal("AbsoluteSize"):Connect(matchSize)
    )
    local AbsoluteSize_2 = Caption_CanvasGroup.AbsoluteSize
    v3.Size = UDim2.fromOffset(AbsoluteSize_2.X, AbsoluteSize_2.Y)
    local v5 = false
    local Header = Caption_CanvasGroup.Box.Header
    local UserInputService = game:GetService("UserInputService")

    local function updateHotkey(arg2) -- line: 168
        -- upvalues:
        --  [1] UserInputService (copy)
        --  [2] Caption_CanvasGroup (copy)
        --  [3] arg1 (copy)
        --  [4] Header (copy)
        --  [5] TextLabel_1 (copy)
        --  [6] Frame_1 (copy)

        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v6 = Caption_CanvasGroup:GetAttribute("CaptionText") or ""
        local v7 = if v6 ~= "_hotkey_" then false else true

        if not KeyboardEnabled and v7 then
            arg1:setCaption()

            return
        end

        Header.Text = v6
        Header.Visible = not v7

        if arg2 then
            TextLabel_1.Text = arg2.Name
            Frame_1.Visible = true
        end

        if not KeyboardEnabled then
            Frame_1.Visible = false
        end
    end

    Caption_CanvasGroup:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey)
    local EasingStyle_Quad = Enum.EasingStyle.Quad
    local tweenInfo = TweenInfo.new(0.2, EasingStyle_Quad, Enum.EasingDirection.In)
    local tweenInfo_1 = TweenInfo.new(0.2, EasingStyle_Quad, Enum.EasingDirection.Out)
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")

    local _ = function(arg3) --[[ getCaptionPosition ]] -- line: 194
        -- upvalues:
        --  [1] v5 (ref)

        local v9 = if not (if arg3 ~= nil then arg3 else v5) then 2 else 10

        return UDim2.new(0.5, 0, 1, v9)
    end

    local function updatePosition(arg4) -- line: 201
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] ImageLabel_1 (copy)
        --  [3] Caption_CanvasGroup (copy)
        --  [4] ClickRegion (copy)
        --  [5] v3 (copy)
        --  [6] tweenInfo (copy)
        --  [7] tweenInfo_1 (copy)
        --  [8] TweenService (copy)
        --  [9] RunService (copy)

        if not v5 then
            return
        end

        local v10 = if arg4 == nil then v5 else arg4
        local v11 = not v10
        local v12 = if v11 ~= nil then v11 else v5
        local v13 = if not v12 then 2 else 10
        local udim2 = UDim2.new(0.5, 0, 1, v13)
        v12 = if v10 ~= nil then v10 else v5
        v13 = if not v12 then 2 else 10
        local udim2_1 = UDim2.new(0.5, 0, 1, v13)

        if v10 then
            ImageLabel_1.Position = UDim2.fromOffset(0, ImageLabel_1.Position.Y.Offset)
            Caption_CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY
            Caption_CanvasGroup.Size = UDim2.fromOffset(32, 53)
        else
            local AbsoluteSize_3 = Caption_CanvasGroup.AbsoluteSize
            Caption_CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y
            Caption_CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize_3.X, AbsoluteSize_3.Y)
        end

        local v18 = nil

        local function updateCaret() -- line: 230
            -- upvalues:
            --  [1] ClickRegion (ref)
            --  [2] Caption_CanvasGroup (ref)
            --  [3] ImageLabel_1 (ref)
            --  [4] v18 (ref)

            local v19 = ClickRegion.AbsolutePosition.X - Caption_CanvasGroup.AbsolutePosition.X + ClickRegion.AbsoluteSize.X / 2 - ImageLabel_1.AbsoluteSize.X / 2
            local Offset = ImageLabel_1.Position.Y.Offset
            local udim2_2 = UDim2.fromOffset(v19, Offset)

            if v18 ~= v19 then
                v18 = v19
                ImageLabel_1.Position = UDim2.fromOffset(0, Offset)
                task.wait()
            end

            ImageLabel_1.Position = udim2_2
        end

        local v21
        v3.Position, v21 = udim2, updateCaret
        v21()
        v10 = TweenService:Create(v3, v10 and tweenInfo or tweenInfo_1, { Position = udim2_1 })
        local v23 = RunService.Heartbeat:Connect(updateCaret)
        v10:Play()
        v10.Completed:Once(function() -- line: 253
            -- upvalues:
            --  [1] v23 (copy)

            v23:Disconnect()
        end)
    end

    CaptionJanitor:add(ClickRegion:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 258
        -- upvalues:
        --  [1] updatePosition (copy)

        updatePosition()
    end))
    updatePosition(false)
    CaptionJanitor:add(arg1.toggleKeyAdded:Connect(updateHotkey))
    local _ = arg1.toggleKeyAdded:Connect(updateHotkey)

    for key, _ in pairs(arg1.bindedToggleKeys) do
        local KeyboardEnabled_1 = UserInputService.KeyboardEnabled
        local v25 = Caption_CanvasGroup:GetAttribute("CaptionText") or ""
        local v26 = if v25 ~= "_hotkey_" then false else true

        if not KeyboardEnabled_1 and v26 then
            arg1:setCaption()
            break
        end

        Header.Text = v25
        Header.Visible = not v26

        if key then
            TextLabel_1.Text = key.Name
            Frame_1.Visible = true
        end

        if KeyboardEnabled_1 then
            break
        end

        Frame_1.Visible = false
        break
    end

    CaptionJanitor:add(arg1.fakeToggleKeyChanged:Connect(updateHotkey))
    local FakeToggleKey = arg1.fakeToggleKey

    if FakeToggleKey then
        local KeyboardEnabled_2 = UserInputService.KeyboardEnabled
        local v27 = Caption_CanvasGroup:GetAttribute("CaptionText") or ""
        local v28 = if v27 ~= "_hotkey_" then false else true

        if not KeyboardEnabled_2 and v28 then
            arg1:setCaption()
        else
            Header.Text = v27
            Header.Visible = not v28

            if FakeToggleKey then
                TextLabel_1.Text = FakeToggleKey.Name
                Frame_1.Visible = true
            end

            if not KeyboardEnabled_2 then
                Frame_1.Visible = false
            end
        end
    end

    local function setCaptionEnabled(arg5) -- line: 274
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] arg1 (copy)
        --  [3] tweenInfo (copy)
        --  [4] tweenInfo_1 (copy)
        --  [5] TweenService (copy)
        --  [6] Caption_CanvasGroup (copy)
        --  [7] v3 (copy)
        --  [8] updatePosition (copy)
        --  [9] UserInputService (copy)
        --  [10] Header (copy)
        --  [11] Frame_1 (copy)

        if v5 == arg5 then
            return
        end

        local v29 = arg1.joinedFrame
        arg5 = if not v29 then arg5 else if not string.match(v29.Name, "Dropdown") then arg5 else false
        v5 = arg5
        v29 = if not arg5 then 1 else 0
        local v30 = arg5 and tweenInfo or tweenInfo_1
        TweenService:Create(Caption_CanvasGroup, v30, { GroupTransparency = v29 }):Play()

        if arg5 then
            v3:SetAttribute("ForceUpdate", true)
        end

        updatePosition()
        local KeyboardEnabled_3 = UserInputService.KeyboardEnabled
        v30 = Caption_CanvasGroup:GetAttribute("CaptionText") or ""
        v29 = if v30 ~= "_hotkey_" then false else true

        if not KeyboardEnabled_3 and v29 then
            arg1:setCaption()

            return
        end

        Header.Text = v30
        Header.Visible = not v29

        if not KeyboardEnabled_3 then
            Frame_1.Visible = false
        end
    end

    local IconModule_m = require(arg1.iconModule)
    CaptionJanitor:add(arg1.stateChanged:Connect(function(arg6) -- line: 299
        -- upvalues:
        --  [1] IconModule_m (copy)
        --  [2] arg1 (copy)
        --  [3] setCaptionEnabled (copy)

        if arg6 == "Viewing" then
            local v31 = IconModule_m.captionLastClosedClock
            v31 = if not ((v31 and os.clock() - v31 or 999) < 0.3) then 0.5 else 0
            task.delay(v31, function() -- line: 304
                -- upvalues:
                --  [1] arg1 (ref)
                --  [2] setCaptionEnabled (ref)

                if arg1.activeState == "Viewing" then
                    setCaptionEnabled(true)
                end
            end)

            return
        end

        IconModule_m.captionLastClosedClock = os.clock()
        setCaptionEnabled(false)
    end))

    return Caption_CanvasGroup
end
