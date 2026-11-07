-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Weight
-- Class: ModuleScript
-- bytes: 3665

local Items_m = require(game:GetService("ReplicatedStorage").Modules.Items)
local t = { BASE_MAX_WEIGHT = 80, STRENGTH_SKILL = "Strength", WEIGHT_PER_STRENGTH = 1 }
t.TRAIT_BONUS = { ["Pack Mule"] = 10 }
t.EQUIPMENT_TRAIT_BONUS = { ["Tight Pockets"] = 30 }
t.OVERENCUMBERED_SPEED = 0.8
t.TYPE_WEIGHTS = { Weapon = 1, Armor = 1 }
t.COSMETIC_RARITIES = { Premium = true }
t.ATTR_CURRENT = "CarryWeight"
t.ATTR_MAX = "MaxCarryWeight"
t.ATTR_UNLIMITED = "UnlimitedCarryWeight"
t.BONUS_STAT = "BonusCarryWeight"

local function resolveInfo(arg1) -- line: 68
    -- upvalues:
    --  [1] Items_m (copy)

    if type(arg1) == "table" then
        return arg1
    end

    if typeof(arg1) == "Instance" then
        arg1 = arg1:GetAttribute("RealName") or arg1.Name
    end

    if type(arg1) ~= "string" then
        return nil
    end

    return Items_m:LookupItem(arg1) or Items_m.AllItems[arg1:split("_")[1]]
end

local _ = function(arg2) --[[ isBoundContainer ]] -- line: 81
    return if typeof(arg2) == "Instance" then if arg2:GetAttribute("Bounded") ~= true then false else true else false
end

function t.GetItemWeight(arg3: any, u1: userdata?) -- line: 87
    -- upvalues:
    --  [1] resolveInfo (copy)
    --  [2] t (copy)

    if not (if typeof(u1) == "Instance" then if u1:GetAttribute("Bounded") ~= true then false else true else false) then
        if if typeof(arg3) == "Instance" then if arg3:GetAttribute("Bounded") ~= true then false else true else false then
            return 0
        end

        local v5 = resolveInfo(arg3)

        if not v5 then
            return 0
        end

        if v5.Soulbound == true then
            return 0
        end

        if type(v5.CarryWeight) == "number" then
            return (math.max(v5.CarryWeight, 0))
        end

        local v6 = t.TYPE_WEIGHTS[v5.Type]

        if not v6 then
            return 0
        end

        if v5.Rarity and t.COSMETIC_RARITIES[v5.Rarity] then
            return 0
        end

        return v6
    else
        return 0
    end
end

function t.GetEquipBonus(arg4) -- line: 118
    -- upvalues:
    --  [1] resolveInfo (copy)
    --  [2] t (copy)

    local v7 = resolveInfo(arg4)
    local v8 = v7 and v7.Traits

    if type(v8) ~= "string" then
        return 0
    end

    v7 = 0

    for _, val in v8:split(",") do
        v7 += t.EQUIPMENT_TRAIT_BONUS[val:match("^%s*(.-)%s*$")] or 0
    end

    return v7
end

function t.GetInventoryWeight(u2: userdata?) -- line: 132
    -- upvalues:
    --  [1] t (copy)

    if not u2 then
        return 0
    end

    local v9 = 0

    for _, child in u2:GetChildren() do
        local v10 = t.GetItemWeight(child.Name, child)

        if v10 > 0 then
            v9 += v10 * math.max(tonumber(child:GetAttribute("Stock")) or 1, 1)
        end
    end

    return v9
end

function t.IsUnlimited(u3: userdata) -- line: 147
    -- upvalues:
    --  [1] t (copy)

    return if u3:GetAttribute(t.ATTR_UNLIMITED) ~= true then false else true
end

function t.GetMax(u4: userdata) -- line: 151
    -- upvalues:
    --  [1] t (copy)

    return u4:GetAttribute(t.ATTR_MAX) or t.BASE_MAX_WEIGHT
end

function t.GetCurrent(u5: userdata) -- line: 155
    -- upvalues:
    --  [1] t (copy)

    return u5:GetAttribute(t.ATTR_CURRENT) or 0
end

function t.IsOverencumbered(u6: userdata) -- line: 160
    -- upvalues:
    --  [1] t (copy)

    if t.IsUnlimited(u6) then
        return false
    end

    return t.GetCurrent(u6) > t.GetMax(u6) and true
end

function t.FormatNumber(n1: number) -- line: 167
    if n1 == math.floor(n1) then
        return (tostring(n1))
    end

    return string.format("%.1f", n1)
end

return t
