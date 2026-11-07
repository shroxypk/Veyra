-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Elements.Dropdown
-- Class: ModuleScript
-- bytes: 16161

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Themes_m = require(script.Parent.Parent.Features.Themes)

return function(arg1) -- line: 5
    -- upvalues:
    --  [1] Themes_m (copy)
    --  [2] TweenService (copy)
    --  [3] RunService (copy)

    local Dropdown_Frame = Instance.new("Frame")
    Dropdown_Frame.Name = "Dropdown"
    Dropdown_Frame.AutomaticSize = Enum.AutomaticSize.X
    Dropdown_Frame.BackgroundTransparency = 1
    Dropdown_Frame.BorderSizePixel = 0
    Dropdown_Frame.AnchorPoint = Vector2.new(0.5, 0)
    Dropdown_Frame.Position = UDim2.new(0.5, 0, 1, 10)
    Dropdown_Frame.ZIndex = -2
    Dropdown_Frame.ClipsDescendants = true
    Dropdown_Frame.Parent = arg1.widget
    local GuiService = game:GetService("GuiService")
    arg1:setBehaviour("Dropdown", "BackgroundTransparency", function(arg2) -- line: 20
        -- upvalues:
        --  [1] GuiService (copy)

        if arg2 == 1 then
            return arg2
        end

        return arg2 * GuiService.PreferredTransparency
    end)
    arg1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- line: 28
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] Dropdown_Frame (copy)

        arg1:refreshAppearance(Dropdown_Frame, "BackgroundTransparency")
    end))
    local DropdownCorner_UICorner = Instance.new("UICorner")
    DropdownCorner_UICorner.Name = "DropdownCorner"
    DropdownCorner_UICorner.CornerRadius = UDim.new(0, 10)
    DropdownCorner_UICorner.Parent = Dropdown_Frame
    local DropdownScroller_ScrollingFrame = Instance.new("ScrollingFrame")
    DropdownScroller_ScrollingFrame.Name = "DropdownScroller"
    DropdownScroller_ScrollingFrame.AutomaticSize = Enum.AutomaticSize.X
    DropdownScroller_ScrollingFrame.BackgroundTransparency = 1
    DropdownScroller_ScrollingFrame.BorderSizePixel = 0
    DropdownScroller_ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
    DropdownScroller_ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    DropdownScroller_ScrollingFrame.ZIndex = -1
    DropdownScroller_ScrollingFrame.ClipsDescendants = true
    DropdownScroller_ScrollingFrame.Visible = true
    DropdownScroller_ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None
    DropdownScroller_ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    DropdownScroller_ScrollingFrame.Active = false
    DropdownScroller_ScrollingFrame.ScrollingEnabled = true
    DropdownScroller_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    DropdownScroller_ScrollingFrame.ScrollBarThickness = 5
    DropdownScroller_ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    DropdownScroller_ScrollingFrame.ScrollBarImageTransparency = 0.8
    DropdownScroller_ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    DropdownScroller_ScrollingFrame.Selectable = false
    DropdownScroller_ScrollingFrame.Active = true
    DropdownScroller_ScrollingFrame.Parent = Dropdown_Frame
    local DropdownSpeed_NumberValue = Instance.new("NumberValue")
    DropdownSpeed_NumberValue.Name = "DropdownSpeed"
    DropdownSpeed_NumberValue.Value = 0.07
    DropdownSpeed_NumberValue.Parent = Dropdown_Frame
    local DropdownPadding_UIPadding = Instance.new("UIPadding")
    DropdownPadding_UIPadding.Name = "DropdownPadding"
    DropdownPadding_UIPadding.PaddingTop = UDim.new(0, 0)
    DropdownPadding_UIPadding.PaddingBottom = UDim.new(0, 0)
    DropdownPadding_UIPadding.Parent = DropdownScroller_ScrollingFrame
    local DropdownList_UIListLayout = Instance.new("UIListLayout")
    DropdownList_UIListLayout.Name = "DropdownList"
    DropdownList_UIListLayout.FillDirection = Enum.FillDirection.Vertical
    DropdownList_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DropdownList_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    DropdownList_UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
    DropdownList_UIListLayout.Parent = DropdownScroller_ScrollingFrame
    local DropdownJanitor = arg1.dropdownJanitor
    local IconModule_m = require(arg1.iconModule)
    arg1.dropdownChildAdded:Connect(function(arg3) -- line: 81
        local _, v2 = arg3:modifyTheme(
            {
                { "Widget", "BorderSize", 0 },
                { "IconCorners", "CornerRadius", UDim.new(0, 10) },
                { "Widget", "MinimumWidth", 190 },
                { "Widget", "MinimumHeight", 58 },
                { "IconLabel", "TextSize", 20 },
                { "IconOverlay", "Size", UDim2.new(1, 0, 1, 0) },
                { "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
                { "Notice", "Position", UDim2.new(1, -24, 0, 5) },
                { "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
                { "Selection", "Size", UDim2.new(1, -0, 1, -0) },
                { "Selection", "Position", UDim2.new(0, 0, 0, 0) }
            }
        )
        task.defer(function() -- line: 95
            -- upvalues:
            --  [1] arg3 (copy)
            --  [2] v2 (copy)

            arg3.joinJanitor:add(function() -- line: 96
                -- upvalues:
                --  [1] arg3 (ref)
                --  [2] v2 (ref)

                arg3:removeModification(v2)
            end)
        end)
    end)
    arg1.dropdownSet:Connect(function(arg4) -- line: 101
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] IconModule_m (copy)

        for _, val in pairs(arg1.dropdownIcons) do
            IconModule_m.getIconByUID(val):destroy()
        end

        if type(arg4) == "table" then
            for _, val_1 in pairs(arg4) do
                val_1:joinDropdown(arg1)
            end
        end
    end)

    local function updateMaxIcons() -- line: 113
        -- upvalues:
        --  [1] Dropdown_Frame (copy)
        --  [2] DropdownScroller_ScrollingFrame (copy)
        --  [3] DropdownPadding_UIPadding (copy)

        local MaxIcons = Dropdown_Frame:GetAttribute("MaxIcons")

        if not MaxIcons then
            return 0
        end

        local t_12 = {}

        for _, val_2 in pairs(DropdownScroller_ScrollingFrame:GetChildren()) do
            if val_2:IsA("GuiObject") and val_2.Visible then
                table.insert(t_12, val_2)
            end
        end

        table.sort(t_12, function(arg5, arg6) -- line: 124
            return arg5.AbsolutePosition.Y < arg6.AbsolutePosition.Y
        end)
        local v5 = 0
        local v6 = math.ceil(MaxIcons)

        for index = 1, v6 do
            local v7 = t_12[index]

            if not v7 then
                break
            end

            local Y = v7.AbsoluteSize.Y
            v7 = if index ~= v6 then false else v6 ~= MaxIcons

            if v7 then
                Y *= MaxIcons - v6 + 1
            end

            v5 += Y
        end

        return v5 + (DropdownPadding_UIPadding.PaddingTop.Offset + DropdownPadding_UIPadding.PaddingBottom.Offset)
    end

    local v8 = nil
    local v9 = nil
    local v10 = nil
    local v11 = nil

    local _ = function() --[[ getTweenInfo ]] -- line: 145
        -- upvalues:
        --  [1] Themes_m (ref)
        --  [2] Dropdown_Frame (copy)
        --  [3] v10 (ref)
        --  [4] v11 (ref)
        --  [5] DropdownSpeed_NumberValue (copy)

        local v12 = Themes_m.getInstanceValue(Dropdown_Frame, "MaxIcons") or 1

        if v10 and (v10 == v12 and v11) then
            return v11
        end

        local tweenInfo = TweenInfo.new(
            DropdownSpeed_NumberValue.Value * v12,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out
        )
        v11 = tweenInfo
        v10 = v12

        return tweenInfo
    end

    local function updateVisibility() -- line: 159
        -- upvalues:
        --  [1] Themes_m (ref)
        --  [2] Dropdown_Frame (copy)
        --  [3] v10 (ref)
        --  [4] v11 (ref)
        --  [5] DropdownSpeed_NumberValue (copy)
        --  [6] v8 (ref)
        --  [7] v9 (ref)
        --  [8] arg1 (copy)
        --  [9] updateMaxIcons (copy)
        --  [10] TweenService (ref)

        local v13 = Themes_m.getInstanceValue(Dropdown_Frame, "MaxIcons") or 1
        local v14

        if v10 and (v10 == v13 and v11) then
            v14 = v11
        else
            local tweenInfo_1 = TweenInfo.new(
                DropdownSpeed_NumberValue.Value * v13,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out
            )
            v11 = tweenInfo_1
            v10 = v13
            v14 = tweenInfo_1
        end

        if v8 then
            v8:Cancel()
            v8 = nil
        end

        if v9 then
            v9:Cancel()
            v9 = nil
        end

        if arg1.isSelected then
            local v15 = updateMaxIcons()
            Dropdown_Frame.Visible = true
            Dropdown_Frame.BackgroundTransparency = 0
            Dropdown_Frame.Size = UDim2.new(0, Dropdown_Frame.Size.X.Offset, 0, 0)
            local t_13 = { Size = UDim2.new(0, Dropdown_Frame.Size.X.Offset, 0, v15) }
            v8 = TweenService:Create(Dropdown_Frame, v14, t_13)
            v8:Play()
            v8.Completed:Connect(function() -- line: 180
                -- upvalues:
                --  [1] v8 (ref)

                v8 = nil
            end)

            return
        end

        local t_14 = { Size = UDim2.new(0, Dropdown_Frame.Size.X.Offset, 0, 0) }
        local tweenInfo_2 = TweenInfo.new(0)
        v9 = TweenService:Create(Dropdown_Frame, tweenInfo_2, t_14)
        v9:Play()
        v9.Completed:Connect(function() -- line: 187
            -- upvalues:
            --  [1] v9 (ref)

            v9 = nil
        end)
    end

    DropdownJanitor:add(arg1.toggled:Connect(updateVisibility))
    updateVisibility()

    local function updateChildSize() -- line: 197
        -- upvalues:
        --  [1] Themes_m (ref)
        --  [2] Dropdown_Frame (copy)
        --  [3] v10 (ref)
        --  [4] v11 (ref)
        --  [5] DropdownSpeed_NumberValue (copy)
        --  [6] arg1 (copy)
        --  [7] v8 (ref)
        --  [8] v9 (ref)
        --  [9] RunService (ref)
        --  [10] updateMaxIcons (copy)
        --  [11] TweenService (ref)

        local v21 = Themes_m.getInstanceValue(Dropdown_Frame, "MaxIcons") or 1
        local v22

        if v10 and (v10 == v21 and v11) then
            v22 = v11
        else
            local tweenInfo_3 = TweenInfo.new(
                DropdownSpeed_NumberValue.Value * v21,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out
            )
            v11 = tweenInfo_3
            v10 = v21
            v22 = tweenInfo_3
        end

        if not arg1.isSelected then
            return
        end

        if v8 then
            v8:Cancel()
            v8 = nil
        end

        if v9 then
            v9:Cancel()
            v9 = nil
        end

        RunService.Heartbeat:Wait()
        local t_15 = { Size = UDim2.new(0, Dropdown_Frame.Size.X.Offset, 0, (updateMaxIcons())) }
        v8 = TweenService:Create(Dropdown_Frame, v22, t_15)
        v8:Play()
        v8.Completed:Connect(function() -- line: 215
            -- upvalues:
            --  [1] v8 (ref)

            v8 = nil
        end)
    end

    DropdownJanitor:add(arg1.toggled:Connect(updateVisibility))
    local v26 = 0
    local v27 = false

    local function updateMaxIconsListener() -- line: 228
        -- upvalues:
        --  [1] v26 (ref)
        --  [2] v27 (ref)
        --  [3] updateMaxIconsListener (copy)
        --  [4] Dropdown_Frame (copy)
        --  [5] DropdownScroller_ScrollingFrame (copy)
        --  [6] IconModule_m (copy)
        --  [7] arg1 (copy)
        --  [8] DropdownPadding_UIPadding (copy)

        v26 += 1

        if v27 then
            return
        end

        local v28 = v26
        v27 = true
        task.defer(function() -- line: 233
            -- upvalues:
            --  [1] v27 (ref)
            --  [2] v26 (ref)
            --  [3] v28 (copy)
            --  [4] updateMaxIconsListener (ref)

            v27 = false

            if v26 ~= v28 then
                updateMaxIconsListener()
            end
        end)
        local MaxIcons_1 = Dropdown_Frame:GetAttribute("MaxIcons")

        if not MaxIcons_1 then
            return
        end

        local t_16 = {}

        for _, val_3 in pairs(DropdownScroller_ScrollingFrame:GetChildren()) do
            if val_3:IsA("GuiObject") and val_3.Visible then
                table.insert(t_16, { val_3, val_3.AbsolutePosition.Y })
            end
        end

        table.sort(t_16, function(arg7, arg8) -- line: 248
            return arg7[2] < arg8[2]
        end)
        local v31 = 0
        local v32 = false
        local v33 = math.ceil(MaxIcons_1)

        for index_1 = 1, v33 do
            local v34 = t_16[index_1]

            if not v34 then
                break
            end

            local v35 = v34[1]
            local v36 = v35.AbsoluteSize.Y
            local v37 = if index_1 ~= v33 then false else v33 ~= MaxIcons_1

            if v37 then
                v36 *= MaxIcons_1 - v33 + 1
            end

            v31 += v36

            if not v37 then
                v37 = v35:GetAttribute("WidgetUID")
                v35 = v37

                if v35 then
                    v35 = IconModule_m.getIconByUID(v37)
                end

                if v35 then
                    v37 = nil

                    if not v32 then
                        v32 = true
                        v37 = arg1:getInstance("ClickRegion")
                    end

                    v35:getInstance("ClickRegion").NextSelectionUp = v37
                end
            end
        end

        DropdownScroller_ScrollingFrame.Size = UDim2.fromOffset(
            0,
            v31 + (DropdownPadding_UIPadding.PaddingTop.Offset + DropdownPadding_UIPadding.PaddingBottom.Offset)
        )
    end

    DropdownJanitor:add(
        DropdownScroller_ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(
            updateMaxIconsListener
        )
    )
    DropdownJanitor:add(DropdownScroller_ScrollingFrame.ChildAdded:Connect(updateMaxIconsListener))
    DropdownJanitor:add(DropdownScroller_ScrollingFrame.ChildRemoved:Connect(updateChildSize))
    DropdownJanitor:add(
        DropdownScroller_ScrollingFrame.ChildRemoved:Connect(updateMaxIconsListener)
    )
    DropdownJanitor:add(
        Dropdown_Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateMaxIconsListener)
    )
    DropdownJanitor:add(
        Dropdown_Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateChildSize)
    )
    DropdownJanitor:add(arg1.childThemeModified:Connect(updateMaxIconsListener))
    updateMaxIconsListener()

    local _ = function(arg9) --[[ connectVisibilityListeners ]] -- line: 293
        -- upvalues:
        --  [1] updateChildSize (copy)

        if arg9:IsA("GuiObject") then
            arg9:GetPropertyChangedSignal("Visible"):Connect(updateChildSize)
            arg9:GetPropertyChangedSignal("Size"):Connect(updateChildSize)
        end
    end

    local v39 = pairs
    local _ = arg1.childThemeModified:Connect(updateMaxIconsListener)

    for _, child in v39(DropdownScroller_ScrollingFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child:GetPropertyChangedSignal("Visible"):Connect(updateChildSize)
            child:GetPropertyChangedSignal("Size"):Connect(updateChildSize)
        end
    end

    DropdownScroller_ScrollingFrame.ChildAdded:Connect(function(child_1) -- line: 305
        -- upvalues:
        --  [1] RunService (ref)
        --  [2] updateChildSize (copy)

        RunService.Heartbeat:Wait()

        if child_1:IsA("GuiObject") then
            child_1:GetPropertyChangedSignal("Visible"):Connect(updateChildSize)
            child_1:GetPropertyChangedSignal("Size"):Connect(updateChildSize)
        end

        updateChildSize()
    end)
    Dropdown_Frame.Visible = false

    return Dropdown_Frame
end
