-- Decompiled with Veyra harvester
-- Instance: StarterGui.StarterQuest.StarterWeapon.StarterQuestClient
-- Class: LocalScript
-- bytes: 3388

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local StatManager_m = require(Modules.StatManager)
local v1, _ = require(Modules.scriptObjs).GetPlayerCharacter()

if StatManager_m.require(v1):GetStat("StarterWeaponChosen") then
    return
end

local Parent = script.Parent
local Confirm = Parent.Confirm
local Options = Parent.Options
local v4 = ""

local function UnHighlight() -- line: 27
    -- upvalues:
    --  [1] Options (copy)

    for _, descendant in Options:GetDescendants() do
        if descendant:GetAttribute("Highlighted") ~= nil then
            descendant:SetAttribute("Highlighted", false)
        end
    end
end

local function StarterQuestUI() -- line: 35
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] Parent (copy)

    if v1:GetAttribute("ChooseWeapon") then
        task.wait(2)
        Parent.Visible = true
    end
end

for _, child in Options:GetChildren() do
    if child:IsA("GuiButton") then
        local Name = child.Name
        local BackgroundColor3 = child.BackgroundColor3
        local ImageColor3 = child.Outline.ImageColor3
        script.Texture:Clone().Parent = child
        child:GetAttributeChangedSignal("Highlighted"):Connect(function() -- line: 52
            -- upvalues:
            --  [1] child (copy)
            --  [2] TweenService (copy)
            --  [3] v4 (ref)
            --  [4] Name (copy)
            --  [5] BackgroundColor3 (copy)
            --  [6] ImageColor3 (copy)

            local Highlighted_1 = child:GetAttribute("Highlighted")
            local v8 = if Highlighted_1 then 0 else 0.5
            child:TweenSize(
                Highlighted_1 and UDim2.fromOffset(135, 135) or UDim2.fromOffset(125, 125, 125),
                Enum.EasingDirection.In,
                Enum.EasingStyle.Linear,
                0.05,
                true
            )

            for _, child_1 in child:GetChildren() do
                if child_1:IsA("TextLabel") then
                    TweenService:Create(child_1, TweenInfo.new(0.2), { TextTransparency = v8 }):Play()
                end
            end

            if Highlighted_1 then
                v4 = Name
                child.BackgroundColor3 = BackgroundColor3
                child.Outline.ImageColor3 = ImageColor3

                return
            end

            child.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
            child.Outline.ImageColor3 = Color3.fromRGB(120, 120, 120)
        end)
        child:SetAttribute("Highlighted", false)
        child.MouseButton1Up:Connect(function() -- line: 80
            -- upvalues:
            --  [1] UnHighlight (copy)
            --  [2] child (copy)
            --  [3] Confirm (copy)

            UnHighlight()
            child:SetAttribute("Highlighted", true)
            Confirm.Visible = true
        end)
    end
end

Confirm.MouseButton1Up:Connect(function() -- line: 89
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] v4 (ref)
    --  [3] Parent (copy)

    if ReplicatedStorage.Remotes.StarterQuest:InvokeServer(v4) then
        Parent.Visible = false
    end
end)
v1:GetAttributeChangedSignal("ChooseWeapon"):Connect(StarterQuestUI)
local _ = script.Texture:Clone()

if v1:GetAttribute("ChooseWeapon") then
    task.wait(2)
    Parent.Visible = true
end
