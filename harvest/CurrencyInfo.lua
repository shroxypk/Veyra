-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.CurrencyInfo
-- Class: ModuleScript
-- bytes: 2762

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("UserInputService")
local t = {}
local t_1 = { Marks = nil, Insight = nil, Essence = nil, LockedEssence = nil, CandyCorn = nil }
local t_2 = {
    Title = "Marks",
    Color = Color3.fromRGB(229, 191, 97),
    Text = "Main currency. Earned through play and selling items. Spent at shops and NPCs."
}
local BackpackUtils_m = require(ReplicatedStorage.Modules.BackpackUtils)
t_1.Marks = t_2
t_1.Insight = {
    Title = "Insight",
    Color = Color3.fromRGB(255, 120, 190),
    Text = "Used to unlock skills and traits. Earned from events, raids and defeating enemies."
}
t_1.Essence = {
    Title = "Essence",
    Color = Color3.fromRGB(21, 152, 235),
    Text = "Shop currency for accessories, brooms and rerolls."
}
t_1.LockedEssence = {
    Title = "Locked Essence",
    Color = Color3.fromRGB(205, 190, 255),
    Text = "Spends like Essence in the shop, but anything bought with it is untradable."
}
t_1.CandyCorn = {
    Title = "Candy Corn",
    Color = Color3.fromRGB(255, 160, 60),
    Text = "Halloween currency. Spent in the Halloween Shop. Every Candy Corn earned also counts toward the Halloween Pass."
}
t.Descriptions = t_1

function t.AttachHover(u1: userdata, s1: string) -- line: 42
    -- upvalues:
    --  [1] t (copy)
    --  [2] BackpackUtils_m (copy)

    local v1 = t.Descriptions[s1]

    if not v1 then
        return
    end

    local v2 = false

    local function show() -- line: 50
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] BackpackUtils_m (ref)
        --  [3] v1 (copy)

        v2 = true
        BackpackUtils_m:ShowHover({ key = v1.Title, text = v1.Text, color = v1.Color })
    end

    local function hide() -- line: 55
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] BackpackUtils_m (ref)

        if v2 then
            v2 = false
            BackpackUtils_m:HideHover()
        end
    end

    u1.MouseEnter:Connect(show)
    u1.MouseLeave:Connect(hide)
    u1.InputBegan:Connect(function(input) -- line: 64
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] BackpackUtils_m (ref)
        --  [3] v1 (copy)
        --  [4] hide (copy)

        if input.UserInputType == Enum.UserInputType.Touch then
            v2 = true
            BackpackUtils_m:ShowHover({ key = v1.Title, text = v1.Text, color = v1.Color })
            task.delay(2.5, hide)
        end
    end)
    u1:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 70
        -- upvalues:
        --  [1] u1 (copy)
        --  [2] v2 (ref)
        --  [3] BackpackUtils_m (ref)

        if not u1.Visible and v2 then
            v2 = false
            BackpackUtils_m:HideHover()
        end
    end)
end

return t
