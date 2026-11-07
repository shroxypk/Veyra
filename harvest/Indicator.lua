-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Elements.Indicator
-- Class: ModuleScript
-- bytes: 4083

return function(arg1, _) -- line: 1
    local Widget = arg1.widget
    local Contents = arg1:getInstance("Contents")
    local Indicator_Frame = Instance.new("Frame")
    Indicator_Frame.Name = "Indicator"
    Indicator_Frame.LayoutOrder = 9999999
    Indicator_Frame.ZIndex = 6
    Indicator_Frame.Size = UDim2.new(0, 42, 0, 42)
    Indicator_Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Indicator_Frame.BackgroundTransparency = 1
    Indicator_Frame.Position = UDim2.new(1, 0, 0.5, 0)
    Indicator_Frame.BorderSizePixel = 0
    Indicator_Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Indicator_Frame.Parent = Contents
    local Frame_1 = Instance.new("Frame")
    Frame_1.Name = "IndicatorButton"
    Frame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_1.BorderSizePixel = 0
    Frame_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame_1.Parent = Indicator_Frame
    local GuiService = game:GetService("GuiService")
    local GamepadService = game:GetService("GamepadService")
    local ClickRegion = arg1:getInstance("ClickRegion")

    local function selectionChanged() -- line: 28
        -- upvalues:
        --  [1] GuiService (copy)
        --  [2] ClickRegion (copy)
        --  [3] Frame_1 (copy)

        if GuiService.SelectedObject == ClickRegion then
            Frame_1.BackgroundTransparency = 1
            Frame_1.Position = UDim2.new(0.5, -2, 0.5, 0)
            Frame_1.Size = UDim2.fromScale(1.2, 1.2)

            return
        end

        Frame_1.BackgroundTransparency = 0.75
        Frame_1.Position = UDim2.new(0.5, 2, 0.5, 0)
        Frame_1.Size = UDim2.fromScale(1, 1)
    end

    arg1.janitor:add(
        GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(selectionChanged)
    )
    selectionChanged()
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
    ImageLabel.Parent = Frame_1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame_1
    local UserInputService = game:GetService("UserInputService")

    local function setIndicatorVisible(arg3) -- line: 58
        -- upvalues:
        --  [1] Indicator_Frame (copy)
        --  [2] GamepadService (copy)
        --  [3] arg1 (copy)

        if arg3 == nil then
            arg3 = Indicator_Frame.Visible
        end

        if GamepadService.GamepadCursorEnabled then
            arg3 = false
        end

        if arg3 then
            arg1:modifyTheme({ "PaddingRight", "Size", UDim2.new(0, 0, 1, 0) }, "IndicatorPadding")
        elseif Indicator_Frame.Visible then
            arg1:removeModification("IndicatorPadding")
        end

        arg1:modifyTheme({ "Indicator", "Visible", arg3 })
        arg1.updateSize:Fire()
    end

    arg1.janitor:add(
        GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(setIndicatorVisible)
    )
    arg1.indicatorSet:Connect(function(arg4) -- line: 74
        -- upvalues:
        --  [1] ImageLabel (copy)
        --  [2] UserInputService (copy)
        --  [3] setIndicatorVisible (copy)

        local v6 = false

        if arg4 then
            ImageLabel.Image = UserInputService:GetImageForKeyCode(arg4)
            v6 = true
        end

        setIndicatorVisible(v6)
    end)

    local function updateSize() -- line: 83
        -- upvalues:
        --  [1] Widget (copy)
        --  [2] Indicator_Frame (copy)

        local v8 = Widget.AbsoluteSize.Y * 0.96
        Indicator_Frame.Size = UDim2.new(0, v8, 0, v8)
    end

    Widget:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)
    local v10 = Widget.AbsoluteSize.Y * 0.96
    Indicator_Frame.Size = UDim2.new(0, v10, 0, v10)

    return Indicator_Frame
end
