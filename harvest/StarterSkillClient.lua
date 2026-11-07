-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.StarterSkill.Frame.StarterSkillClient
-- Class: LocalScript
-- bytes: 5513

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local Packets_m = require(Modules.Packets)
local Skills_m = require(Modules.Skills)
local _, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local Parent = script.Parent
local Parent_1 = Parent.Parent
local Confirm = Parent.Confirm
local Options = Parent.Options
local SkillPreview = Parent_1.SkillPreview
local Video = SkillPreview.Video
local t = {
    ["Charged Strike"] = "rbxassetid://128801241250544",
    ["Mana Shield"] = "rbxassetid://80484771441146",
    Rampage = "rbxassetid://98227290789449",
    ["Vital Pulse"] = "rbxassetid://87714656013308"
}
local v3 = nil
SkillPreview.Visible = false
Video.Looped = true
Video.Volume = 0

local _ = function() --[[ hidePreview ]] -- line: 43
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] SkillPreview (copy)
    --  [3] Video (copy)

    v3 = nil
    SkillPreview.Visible = false
    Video.Playing = false
end

local _ = function(arg1) --[[ placePreview ]] -- line: 50
    -- upvalues:
    --  [1] Parent_1 (copy)
    --  [2] SkillPreview (copy)

    local AbsolutePosition = arg1.AbsolutePosition
    local AbsoluteSize = arg1.AbsoluteSize
    local AbsoluteSize_1 = SkillPreview.AbsoluteSize
    local v4 = AbsolutePosition.X + AbsoluteSize.X / 2 - AbsoluteSize_1.X / 2
    local v5 = math.max(Parent_1.AbsoluteSize.X - AbsoluteSize_1.X, 0)
    local v6 = AbsolutePosition.Y - AbsoluteSize_1.Y - 8
    local v7 = math.clamp(v4, 0, v5)

    if v6 < 0 then
        v6 = AbsolutePosition.Y + AbsoluteSize.Y + 8
    end

    SkillPreview.Position = UDim2.fromOffset(v7, v6)
end

local function showPreview(arg2) -- line: 66
    -- upvalues:
    --  [1] t (copy)
    --  [2] v3 (ref)
    --  [3] SkillPreview (copy)
    --  [4] Video (copy)

    local v9 = t[arg2.Name]

    if not v9 or v9 == "" then
        v3 = nil
        SkillPreview.Visible = false
        Video.Playing = false

        return
    end

    v3 = arg2

    if Video.Video ~= v9 then
        Video.Video = v9
    end

    Video.TimePosition = 0
    Video.Playing = true
    SkillPreview.Visible = true
    task.delay(0.1, function() -- line: 86
        -- upvalues:
        --  [1] v3 (ref)
        --  [2] arg2 (copy)

        if v3 == arg2 then
        end
    end)
end

local v10 = ""

local function UnHighlight() -- line: 96
    -- upvalues:
    --  [1] Options (copy)

    for _, descendant in Options:GetDescendants() do
        if descendant:GetAttribute("Highlighted") ~= nil then
            descendant:SetAttribute("Highlighted", false)
        end
    end
end

for _, child in Options:GetChildren() do
    if child:IsA("GuiButton") then
        local Name = child.Name
        local BackgroundColor3 = child.BackgroundColor3
        local ImageColor3 = child.Outline.ImageColor3
        local _ = script.Texture:Clone()
        child.Description.Text = Skills_m:LookupSkill(Name).Description
        child:GetAttributeChangedSignal("Highlighted"):Connect(function() -- line: 116
            -- upvalues:
            --  [1] child (copy)
            --  [2] TweenService (copy)
            --  [3] v10 (ref)
            --  [4] Name (copy)
            --  [5] BackgroundColor3 (copy)
            --  [6] ImageColor3 (copy)

            local Highlighted_1 = child:GetAttribute("Highlighted")
            local v15 = if Highlighted_1 then 0 else 0.5
            child:TweenSize(
                Highlighted_1 and UDim2.fromOffset(135, 135) or UDim2.fromOffset(125, 125, 125),
                Enum.EasingDirection.In,
                Enum.EasingStyle.Linear,
                0.05,
                true
            )

            for _, child_1 in child:GetChildren() do
                if child_1:IsA("TextLabel") then
                    TweenService:Create(child_1, TweenInfo.new(0.2), { TextTransparency = v15 }):Play()
                end
            end

            if Highlighted_1 then
                v10 = Name
                TweenService:Create(
                    child,
                    TweenInfo.new(0.2),
                    { BackgroundColor3 = BackgroundColor3 }
                ):Play()
                TweenService:Create(
                    child.Outline,
                    TweenInfo.new(0.2),
                    { ImageColor3 = ImageColor3 }
                ):Play()

                return
            end

            TweenService:Create(
                child,
                TweenInfo.new(0.2),
                { BackgroundColor3 = Color3.fromRGB(74, 74, 74) }
            ):Play()
            TweenService:Create(
                child.Outline,
                TweenInfo.new(0.2),
                { ImageColor3 = Color3.fromRGB(120, 120, 120) }
            ):Play()
        end)
        child:SetAttribute("Highlighted", false)
        child.MouseButton1Up:Connect(function() -- line: 143
            -- upvalues:
            --  [1] UnHighlight (copy)
            --  [2] child (copy)
            --  [3] Confirm (copy)
            --  [4] showPreview (copy)

            UnHighlight()
            child:SetAttribute("Highlighted", true)
            Confirm.Visible = true
            showPreview(child)
        end)
    end
end

Confirm.MouseButton1Up:Connect(function() -- line: 153
    -- upvalues:
    --  [1] Packets_m (copy)
    --  [2] v10 (ref)
    --  [3] Parent (copy)

    Packets_m.Tools.packets.BasicTechnique.send({ Skill = v10 })
    Parent.Parent:Destroy()
end)
