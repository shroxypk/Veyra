-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Elements.Container
-- Class: ModuleScript
-- bytes: 9681

local v1 = false
local v2 = 0

return function(arg1) -- line: 3
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v2 (ref)

    local GuiService = game:GetService("GuiService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local t = {}
    local v3 = require(script.Parent.Parent.Packages.GoodSignal).new()
    local v4 = GuiService:GetGuiInset()
    local v5 = 0
    local v6 = 0
    local v7 = 0
    local v8 = false
    local v9 = false
    local v10 = 0

    local function checkInset(arg2) -- line: 20
        -- upvalues:
        --  [1] GuiService (copy)
        --  [2] v8 (ref)
        --  [3] v9 (ref)
        --  [4] UserInputService (copy)
        --  [5] arg1 (copy)
        --  [6] v10 (ref)
        --  [7] checkInset (copy)
        --  [8] Players (copy)
        --  [9] v1 (ref)
        --  [10] v4 (ref)
        --  [11] v5 (ref)
        --  [12] v6 (ref)
        --  [13] v7 (ref)
        --  [14] v3 (copy)
        --  [15] v2 (ref)

        local Height = GuiService.TopbarInset.Height
        local v11 = Height <= 36
        v8 = GuiService:IsTenFootInterface()
        v9 = UserInputService.VREnabled
        arg1.isOldTopbar = v11
        v10 += 1

        if Height == 0 and arg2 == nil then
            task.defer(function() -- line: 33
                -- upvalues:
                --  [1] checkInset (ref)

                task.wait(8)
                checkInset("ForceConvertToOld")
            end)
        elseif v10 == 1 then
            task.delay(5, function() -- line: 38
                -- upvalues:
                --  [1] Players (ref)
                --  [2] v10 (ref)
                --  [3] checkInset (ref)

                Players.LocalPlayer:WaitForChild("PlayerGui")

                if v10 == 1 then
                    checkInset()
                end
            end)
        end

        if arg1.isOldTopbar and (not v8 and (not v9 and (v1 == false and (Height ~= 0 or arg2 == "ForceConvertToOld")))) then
            v1 = true
            task.defer(function() -- line: 50
                -- upvalues:
                --  [1] arg1 (ref)
                --  [2] GuiService (ref)

                local Classic_m = require(script.Parent.Parent.Features.Themes.Classic)
                arg1.modifyBaseTheme(Classic_m)

                local function decideToHideTopbar() -- line: 57
                    -- upvalues:
                    --  [1] GuiService (ref)
                    --  [2] arg1 (ref)

                    if GuiService.MenuIsOpen then
                        arg1.setTopbarEnabled(false, true)

                        return
                    end

                    arg1.setTopbarEnabled()
                end

                GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(decideToHideTopbar)

                if GuiService.MenuIsOpen then
                    arg1.setTopbarEnabled(false, true)

                    return
                end

                arg1.setTopbarEnabled()
            end)
        end

        v4 = GuiService:GetGuiInset()
        v5 = if v11 then 12 else v4.Y - 50
        v6 = if v11 then 2 else 0
        v7 = -2

        if v8 then
            v5 = 10
            v6 = 0
        end

        if GuiService.TopbarInset.Height == 0 and not v1 then
            v6 += 13
            v7 = 50
        end

        v3:Fire(v4)
        v11 = v4.Y

        if v11 ~= v2 then
            v2 = v11
            task.defer(function() -- line: 88
                -- upvalues:
                --  [1] arg1 (ref)
                --  [2] v11 (copy)

                arg1.insetHeightChanged:Fire(v11)
            end)
        end
    end

    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(checkInset)
    checkInset("FirstTime")
    local TopbarStandard_ScreenGui = Instance.new("ScreenGui")
    v3:Connect(function() -- line: 98
        -- upvalues:
        --  [1] TopbarStandard_ScreenGui (copy)
        --  [2] v5 (ref)

        TopbarStandard_ScreenGui:SetAttribute("StartInset", v5)
    end)
    TopbarStandard_ScreenGui.Name = "TopbarStandard"
    TopbarStandard_ScreenGui.Enabled = true
    TopbarStandard_ScreenGui.DisplayOrder = arg1.baseDisplayOrder
    TopbarStandard_ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    TopbarStandard_ScreenGui.IgnoreGuiInset = true
    TopbarStandard_ScreenGui.ResetOnSpawn = false
    TopbarStandard_ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    t[TopbarStandard_ScreenGui.Name] = TopbarStandard_ScreenGui
    arg1.baseDisplayOrderChanged:Connect(function() -- line: 109
        -- upvalues:
        --  [1] TopbarStandard_ScreenGui (copy)
        --  [2] arg1 (copy)

        TopbarStandard_ScreenGui.DisplayOrder = arg1.baseDisplayOrder
    end)
    local Holders_Frame = Instance.new("Frame")
    Holders_Frame.Name = "Holders"
    Holders_Frame.BackgroundTransparency = 1
    v3:Connect(function() -- line: 116
        -- upvalues:
        --  [1] v9 (ref)
        --  [2] v8 (ref)
        --  [3] v7 (ref)
        --  [4] Holders_Frame (copy)
        --  [5] v6 (ref)

        local v13 = if not v9 then 56 else 36
        local v14 = if not v8 then UDim2.new(1, 0, 1, v7) else UDim2.new(1, 0, 0, v13)
        Holders_Frame.Position = UDim2.new(0, 0, 0, v6)
        Holders_Frame.Size = v14
    end)
    Holders_Frame.Visible = true
    Holders_Frame.ZIndex = 1
    Holders_Frame.Parent = TopbarStandard_ScreenGui
    local v16 = TopbarStandard_ScreenGui:Clone()
    local Holders = v16.Holders

    local function updateCenteredHoldersHeight() -- line: 128
        -- upvalues:
        --  [1] Holders (copy)
        --  [2] GuiService (copy)
        --  [3] v7 (ref)

        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + v7)
    end

    v16.Name = "TopbarCentered"
    v16.DisplayOrder = arg1.baseDisplayOrder
    v16.ScreenInsets = Enum.ScreenInsets.None
    arg1.baseDisplayOrderChanged:Connect(function() -- line: 134
        -- upvalues:
        --  [1] v16 (copy)
        --  [2] arg1 (copy)

        v16.DisplayOrder = arg1.baseDisplayOrder
    end)
    t[v16.Name] = v16
    v3:Connect(updateCenteredHoldersHeight)
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + v7)
    local v18 = TopbarStandard_ScreenGui:Clone()
    v18.Name ..= "Clipped"
    v18.DisplayOrder = arg1.baseDisplayOrder + 1
    arg1.baseDisplayOrderChanged:Connect(function() -- line: 145
        -- upvalues:
        --  [1] v18 (copy)
        --  [2] arg1 (copy)

        v18.DisplayOrder = arg1.baseDisplayOrder + 1
    end)
    t[v18.Name] = v18
    local v19 = v16:Clone()
    v19.Name ..= "Clipped"
    v19.DisplayOrder = arg1.baseDisplayOrder + 1
    arg1.baseDisplayOrderChanged:Connect(function() -- line: 153
        -- upvalues:
        --  [1] v19 (copy)
        --  [2] arg1 (copy)

        v19.DisplayOrder = arg1.baseDisplayOrder + 1
    end)
    t[v19.Name] = v19
    local Left_ScrollingFrame = Instance.new("ScrollingFrame")
    Left_ScrollingFrame:SetAttribute("IsAHolder", true)
    Left_ScrollingFrame.Name = "Left"
    v3:Connect(function() -- line: 162
        -- upvalues:
        --  [1] Left_ScrollingFrame (copy)
        --  [2] v5 (ref)

        Left_ScrollingFrame.Position = UDim2.fromOffset(v5, 0)
    end)
    Left_ScrollingFrame.Size = UDim2.new(1, -24, 1, 0)
    Left_ScrollingFrame.BackgroundTransparency = 1
    Left_ScrollingFrame.Visible = true
    Left_ScrollingFrame.ZIndex = 1
    Left_ScrollingFrame.Active = false
    Left_ScrollingFrame.ClipsDescendants = true
    Left_ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    Left_ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    Left_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    Left_ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    Left_ScrollingFrame.ScrollBarThickness = 0
    Left_ScrollingFrame.BorderSizePixel = 0
    Left_ScrollingFrame.Selectable = false
    Left_ScrollingFrame.ScrollingEnabled = false
    Left_ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never
    Left_ScrollingFrame.Parent = Holders_Frame
    local UIListLayout = Instance.new("UIListLayout")
    v3:Connect(function() -- line: 183
        -- upvalues:
        --  [1] UIListLayout (copy)
        --  [2] v5 (ref)

        UIListLayout.Padding = UDim.new(0, v5)
    end)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.Parent = Left_ScrollingFrame
    local v22 = Left_ScrollingFrame:Clone()
    v3:Connect(function() -- line: 193
        -- upvalues:
        --  [1] v22 (copy)
        --  [2] v5 (ref)

        v22.UIListLayout.Padding = UDim.new(0, v5)
    end)
    v22.ScrollingEnabled = false
    v22.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v22.Name = "Center"
    v22.Parent = Holders
    local v23 = Left_ScrollingFrame:Clone()
    v3:Connect(function() -- line: 202
        -- upvalues:
        --  [1] v23 (copy)
        --  [2] v5 (ref)

        v23.UIListLayout.Padding = UDim.new(0, v5)
    end)
    v23.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    v23.Name = "Right"
    v23.AnchorPoint = Vector2.new(1, 0)
    v23.Position = UDim2.new(1, -12, 0, 0)
    v23.Parent = Holders_Frame
    local Template_m = require(script.Parent.Parent.Template)
    Template_m.applyToScreenGui(TopbarStandard_ScreenGui)
    Template_m.applyToScreenGui(v18)
    v3:Fire(v4)

    return t
end
