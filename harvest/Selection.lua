-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Elements.Selection
-- Class: ModuleScript
-- bytes: 1861

return function(_) -- line: 1
    local SelectionContainer_Frame = Instance.new("Frame")
    SelectionContainer_Frame.Name = "SelectionContainer"
    SelectionContainer_Frame.Visible = false
    local Frame_1 = Instance.new("Frame")
    Frame_1.Name = "Selection"
    Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_1.BackgroundTransparency = 1
    Frame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_1.BorderSizePixel = 0
    Frame_1.Parent = SelectionContainer_Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Thickness = 3
    UIStroke.Parent = Frame_1
    local SelectionGradient_UIGradient = Instance.new("UIGradient")
    SelectionGradient_UIGradient.Name = "SelectionGradient"
    SelectionGradient_UIGradient.Parent = UIStroke
    local UICorner = Instance.new("UICorner")
    UICorner:SetAttribute("Collective", "IconCorners")
    UICorner.Name = "UICorner"
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame_1
    local RunService = game:GetService("RunService")
    local GuiService = game:GetService("GuiService")
    local v1 = 1
    Frame_1:GetAttributeChangedSignal("RotationSpeed"):Connect(function() -- line: 37
        -- upvalues:
        --  [1] v1 (ref)
        --  [2] Frame_1 (copy)

        v1 = Frame_1:GetAttribute("RotationSpeed")
    end)
    RunService.Heartbeat:Connect(function() -- line: 40
        -- upvalues:
        --  [1] GuiService (copy)
        --  [2] SelectionGradient_UIGradient (copy)
        --  [3] v1 (ref)

        if not GuiService.SelectedObject then
            return
        end

        SelectionGradient_UIGradient.Rotation = os.clock() * v1 * 100 % 360
    end)

    return SelectionContainer_Frame
end
