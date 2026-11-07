-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.GrimoireMastery
-- Class: ModuleScript
-- bytes: 2251

local Players = game:GetService("Players")
local t = { PREFIX = "GrimoireMastery" }
t.LevelStat = t.PREFIX
t.XPStat = t.PREFIX .. "XP"
t.MXPStat = t.PREFIX .. "MXP"
t.PointsStat = t.PREFIX .. "Points"
t.EvolveBonusStat = t.PREFIX .. "EvolveBonus"
t.TotalXP = 50000
t.Steps = 10
t.PointsPerStep = 1
t.EvolveBonus = 5
t.XPPerCast = 0
t.XPPerDamage = 1
t.MaxXPPerHit = 150

function t.GetProgress(n1: number) -- line: 36
    -- upvalues:
    --  [1] t (copy)

    return (math.clamp((tonumber(n1) or 0) / t.TotalXP, 0, 1))
end

function t.GetStepsReached(n2: number) -- line: 41
    -- upvalues:
    --  [1] t (copy)

    local v1 = t.GetProgress(n2)

    return (math.floor(v1 * t.Steps + 1E-09))
end

t.Attributes = {
    { Key = "Damage", PerPoint = 0.01 },
    { Key = "Cooldown", PerPoint = 0.01 },
    { Key = "EnergyCost", PerPoint = 0.01 },
    { Key = "Penetration", PerPoint = 1 }
}
t.MaxReduction = 0.5
t.AttributeByKey = {}

for _, val in t.Attributes do
    t.AttributeByKey[val.Key] = val
end

function t.AttributeStat(s1: string) -- line: 65
    -- upvalues:
    --  [1] t (copy)

    return t.PREFIX .. s1
end

local _ = function(arg1) --[[ toPlayer ]] -- line: 69
    -- upvalues:
    --  [1] Players (copy)

    if typeof(arg1) ~= "Instance" then
        return nil
    end

    if arg1:IsA("Player") then
        return arg1
    end

    return Players:GetPlayerFromCharacter(arg1)
end

function t.GetAttributePoints(arg2: any, s2: string) -- line: 81
    -- upvalues:
    --  [1] Players (copy)
    --  [2] t (copy)

    local v2 = if typeof(arg2) ~= "Instance" then nil else if arg2:IsA("Player") then arg2 else Players:GetPlayerFromCharacter(
        arg2
    )
    local v3 = v2

    if v3 then
        v3 = v2:FindFirstChild("PlayerFolder")
    end

    if not v3 then
        return 0
    end

    return tonumber(v3:GetAttribute(t.AttributeStat(s2))) or 0
end

function t.GetBonus(arg3: any, s3: string) -- line: 92
    -- upvalues:
    --  [1] t (copy)

    local v4 = t.AttributeByKey[s3]

    if not v4 then
        return 0
    end

    local v6 = t.GetAttributePoints(arg3, s3) * v4.PerPoint

    if s3 == "Cooldown" or s3 == "EnergyCost" then
        v6 = math.min(v6, t.MaxReduction)
    end

    return v6
end

return t
