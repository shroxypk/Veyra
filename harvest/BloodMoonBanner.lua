-- Decompiled with Veyra harvester
-- Instance: StarterGui.HalloweenUI.BloodMoonBanner
-- Class: LocalScript
-- bytes: 4058

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local BackpackUtils_m = require(ReplicatedStorage.Modules.BackpackUtils)
local Parent = script.Parent
local udim2 = UDim2.fromOffset(112, 26)
local color = Color3.fromRGB(110, 30, 30)
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local t = {
    key = "Blood Moon",
    color = Color3.fromRGB(220, 60, 50),
    text = "Monsters may become corrupted: tougher, but worth 2.5x XP, 2x Insight, extra drops and Candy Corn. Respawns are faster, and Halloween gear hits corrupted monsters harder."
}
local BloodMoonBanner_ScreenGui = Instance.new("ScreenGui")
BloodMoonBanner_ScreenGui.Name = "BloodMoonBanner"
BloodMoonBanner_ScreenGui.ResetOnSpawn = false
BloodMoonBanner_ScreenGui.IgnoreGuiInset = true
BloodMoonBanner_ScreenGui.DisplayOrder = 5
BloodMoonBanner_ScreenGui.Enabled = false
local v1 = Parent:WaitForChild("Pass"):WaitForChild("EndsTimer"):Clone()
v1.Name = "Plate"
v1.AnchorPoint = Vector2.new(0.5, 0)
v1.Position = UDim2.new(0.5, 0, 0, 54)
v1.Size = udim2
v1.ImageColor3 = color
v1.Label:Destroy()
v1.Time.Text = "Blood Moon"
v1.Time.TextSize = 14
v1.Time.AnchorPoint = Vector2.new(0, 0.5)
v1.Time.Position = UDim2.fromScale(0, 0.5)
v1.Time.Size = UDim2.new(1, 0, 0, 18)
v1.Parent = BloodMoonBanner_ScreenGui
local t_1 = { [v1] = { ImageTransparency = 0.3, BackgroundTransparency = 1 } }

for _, descendant in v1:GetDescendants() do
    if descendant:IsA("TextLabel") then
        t_1[descendant] = { TextTransparency = 0.15 }
    elseif descendant:IsA("ImageLabel") then
        local t_2 = { ImageTransparency = math.max(descendant.ImageTransparency, 0.3) }
        t_1[descendant] = t_2
    end
end

local function fade(arg1) -- line: 61
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] TweenService (copy)
    --  [3] tweenInfo (copy)

    for key_1, val in t_1 do
        local t_3 = {}

        for key_2, val_1 in val do
            t_3[key_2] = arg1 and val_1 or 1
        end

        TweenService:Create(key_1, tweenInfo, t_3):Play()
    end
end

for key_3, val_2 in t_1 do
    for key_4 in val_2 do
        key_3[key_4] = 1
    end
end

BloodMoonBanner_ScreenGui.Parent = Parent.Parent
local v7 = false

local function showHover() -- line: 81
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] BackpackUtils_m (copy)
    --  [3] t (copy)

    v7 = true
    BackpackUtils_m:ShowHover(t)
end

local function hideHover() -- line: 85
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] BackpackUtils_m (copy)

    if v7 then
        v7 = false
        BackpackUtils_m:HideHover()
    end
end

v1.MouseEnter:Connect(showHover)
v1.MouseLeave:Connect(hideHover)
v1.InputBegan:Connect(function(input) -- line: 93
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] BackpackUtils_m (copy)
    --  [3] t (copy)
    --  [4] hideHover (copy)

    if input.UserInputType == Enum.UserInputType.Touch then
        v7 = true
        BackpackUtils_m:ShowHover(t)
        task.delay(4, hideHover)
    end
end)
local v8 = false

local function update() -- line: 101
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] v8 (ref)
    --  [3] BloodMoonBanner_ScreenGui (copy)
    --  [4] v7 (ref)
    --  [5] BackpackUtils_m (copy)
    --  [6] fade (copy)
    --  [7] tweenInfo (copy)

    local v9 = if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then false else true

    if v9 == v8 then
        return
    end

    v8 = v9

    if v9 then
        BloodMoonBanner_ScreenGui.Enabled = true
    elseif v7 then
        v7 = false
        BackpackUtils_m:HideHover()
    end

    fade(v9)

    if not v9 then
        task.delay(tweenInfo.Time, function() -- line: 114
            -- upvalues:
            --  [1] v8 (ref)
            --  [2] BloodMoonBanner_ScreenGui (ref)

            if not v8 then
                BloodMoonBanner_ScreenGui.Enabled = false
            end
        end)
    end
end

ReplicatedStorage:GetAttributeChangedSignal("BloodMoon"):Connect(update)
update()
