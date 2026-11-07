-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.HalloweenWeapons
-- Class: ModuleScript
-- bytes: 2663

local Items_m = require(script.Parent.Items)
local t = {
    MAX_LEVEL = 8,
    ATTRIBUTE = "Level",
    BLACKSMITH = "Mortimer the Gravesmith",
    COSTS = { 1500, 2500, 3500, 5000, 7000, 9500, 12000 },
    Is = function(arg2) --[[ Is ]] -- line: 51
        return if type(arg2) == "table" then arg2.HalloweenWeapon == true else false
    end
}

local function requirementOf(arg1) -- line: 24
    local v1 = arg1.Required or {}

    for key, val in v1 do
        if string.find(key, "Proficiency") then
            return val
        end
    end

    return nil
end

local t_1 = {}

local function topOf(s1: string) -- line: 35
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Items_m (copy)
    --  [3] requirementOf (copy)
    --  [4] t (copy)

    if t_1[s1] then
        return t_1[s1]
    end

    local t_2 = { BaseDamage = 0, Scale = 0 }

    for _, val_1 in Items_m.Swords do
        if val_1.MasteryType == s1 and not val_1.HalloweenWeapon then
            if requirementOf(val_1) == t.MAX_LEVEL and typeof(val_1.BaseDamage) == "number" and val_1.BaseDamage < 1000 then
                t_2.BaseDamage = math.max(t_2.BaseDamage, val_1.BaseDamage)
                t_2.Scale = math.max(t_2.Scale, val_1.Scale or 0)
            end
        end
    end

    t_1[s1] = t_2

    return t_2
end

function t.LevelOf(u1: userdata?) -- line: 56
    -- upvalues:
    --  [1] t (copy)

    local v4 = u1

    if v4 then
        v4 = u1:GetAttribute(t.ATTRIBUTE)
    end

    local v5 = math.floor(tonumber(v4) or 1)

    return (math.clamp(v5, 1, t.MAX_LEVEL))
end

function t.Stats(arg3: any, n1: number) -- line: 62
    -- upvalues:
    --  [1] topOf (copy)
    --  [2] t (copy)

    local v6 = topOf(arg3.MasteryType)
    local v7 = (math.clamp(n1, 1, t.MAX_LEVEL) - 1) / (t.MAX_LEVEL - 1)
    local v8 = arg3.BaseDamage or 0
    local v9 = arg3.Scale or 0
    local v10 = v8 + (math.max(v6.BaseDamage, v8) - v8) * v7
    local v11 = v9 + (math.max(v6.Scale, v9) - v9) * v7

    return math.floor(v10 * 10 + 0.5) / 10, math.floor(v11 * 100 + 0.5) / 100
end

function t.AtLevel(arg4: any, n2: number) -- line: 73
    -- upvalues:
    --  [1] t (copy)

    local t_3 = table.clone(arg4)
    t_3.BaseDamage, t_3.Scale = t.Stats(arg4, n2)
    t_3.Required = { [`{arg4.MasteryType} Proficiency`] = n2 }
    t_3.HalloweenLevel = n2

    return t_3
end

function t.Apply(arg5: any, u2: userdata?) -- line: 82
    -- upvalues:
    --  [1] t (copy)

    if not t.Is(arg5) then
        return arg5
    end

    return t.AtLevel(arg5, t.LevelOf(u2))
end

function t.Cost(n3: number) -- line: 90
    -- upvalues:
    --  [1] t (copy)

    return t.COSTS[n3]
end

return t
