-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Basic
-- Class: ModuleScript
-- bytes: 5358

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local QueueData_m = require(Modules.QueueData)
local t = {}
t.__index = t
local v1 = true
local StatManager_m = require(Modules.StatManager)

if game.PlaceId ~= 8248288152 then
    v1 = true

    if game.PlaceId ~= 16349555270 then
        v1 = RunService:IsStudio()

        if v1 then
            v1 = game.PlaceId == 87646366547227
        end
    end
end

t.World = v1
t.HalloweenEvent = t.World
t.MaxQuality = 3
t.EvolutionBreakthrough = 20000
t.MaxMissionRank = #QueueData_m.Ranks
t.MaxTickets = 4
t.TicketRegenInterval = 360
t.MaxProfession = 30
t.MaxLevel = 80
t.LegacyMaxLevel = 55
t.SkillPointsPerLevel = 1
t.LevelXPScale = 1.47
t.XPCurveTopUp = 35
t.LowThreshold = 0.2
t.WeaponScaling = 0.075
t.MaxMarks = 50000
t.MaxBankSlots = 25
t.BankBase = 0
t.BankIncrement = 250
t.MaxReputation = 200
t.ReputationGoodMin = 20
t.ReputationBadMin = -t.ReputationGoodMin
t.NameMinimum = 3
t.NameMaximum = 25
t.MaxClanReputation = 1000
t.CreateClanFee = 1000
t.DescriptionLimit = 200
t.MaxBuy = 15
t.MaxStock = 99
t.XPRate = 1
t.MarksRate = 1
t.MissionKillXPRate = 0.5
t.QuestUnderLevelGrace = 7
t.QuestUnderLevelPenalty = 0.034
t.QuestUnderLevelFloor = 0.8
t.QuestXPRate = 1.1
t.MaxMastery = 10
t.MaxInsight = 300
t.MasteryUncap = 3
t.MasterySP = 2
t.MasteryInsight = 15
t.MasteryBase = 250
t.MasteryIncrement = 250
t.RepairBaseCost = 1
t.RepairMultiplier = 0.03
t.SpiritMeterMax = 450
t.SpiritLevelCap = 5
t.ShrineProximity = 700
t.ExchangePointMarks = 100
t.ExchangePointInsight = 5
t.ExchangeInsight = 25
t.ExchangeItem = 500
t.ExchangeTechniqueInsight = 50
t.ExchangeTechniqueMarks = 2000
t.AugmentResetMarks = { 5000, 15000, 25000 }
t.AugmentResetInsight = { 100, 200, 300 }
t.FLYING_TAG = "Flying"
t.WeaponTypes = {
    TwoHand = { "Greataxe", "Greatsword", "Spear", "Trident", "Staff", "Scythe" },
    Medium = { "Sword" },
    Light = { "Dagger", "Fist", "Rapier", "Katana" }
}

function t.GetAnimationType(arg1) -- line: 119
    if not arg1 then
        return "Human"
    end

    if arg1:FindFirstChild("States") then
        if not arg1.States:FindFirstChild("AnimationType") then
            return "Human"
        end

        return arg1.Data.AnimationType.Value
    else
        return "Human"
    end
end

function t.GetRepairCost(arg2, arg3) -- line: 129
    local v2 = arg3

    if typeof(arg3) ~= "number" or not v2 then
        v2 = 10000
    end

    return (math.floor(arg2.RepairBaseCost + v2 * arg2.RepairMultiplier))
end

function t.GetRepResetCost(_, arg5) -- line: 136
    return (math.abs(arg5 * 2))
end

function round(arg6) -- line: 141
    return (tonumber((string.format("%.1f", arg6))))
end

function t.CalculateQualityDamage(_, arg8, arg9) -- line: 146
    if not arg9 then
        return arg8
    end

    local v4 = round(arg8 + arg8 * (arg9 * 0.05))

    return v4, v4, v4
end

function t.CalculateWeaponDamage(arg10, arg11, arg12, arg13) -- line: 162
    return round(arg11 + arg13 * (arg12 * arg10.WeaponScaling))
end

function t.OldEquivalentLevel(arg14) -- line: 169
    -- upvalues:
    --  [1] t (copy)

    return 1 + (arg14 - 1) * (t.LegacyMaxLevel - 1) / (t.MaxLevel - 1)
end

function t.TotalStatPoints(arg15) -- line: 174
    -- upvalues:
    --  [1] t (copy)

    local v5 = math.floor(tonumber(arg15) or 1)
    arg15 = math.clamp(v5, 1, t.MaxLevel)

    return 2 * (arg15 - 1) + (if arg15 >= t.MaxLevel then 4 else 0)
end

local _ = function(arg16, arg17) --[[ levelCurve ]] -- line: 179
    local v7 = 1
    v7 = if not (arg17 > 40) then if not (arg17 > 35) then v7 else 1 + 0.1 * (arg17 - 35) else 1.5 + 0.05 * (arg17 - 40)

    return arg16 * arg17 ^ 0.575 * v7
end

function t.GetLevelXP(arg18) -- line: 190
    -- upvalues:
    --  [1] t (copy)

    local v8 = t.OldEquivalentLevel(arg18)
    local v9 = 1

    if v8 > 40 then
        v9 = 1.5 + 0.05 * (v8 - 40)
    elseif v8 > 35 then
        v9 = 1 + 0.1 * (v8 - 35)
    end

    local v10 = math.floor(135.68 * v8 ^ 0.575 * v9)

    if arg18 == t.MaxLevel - 1 then
        v10 += t.XPCurveTopUp
    end

    return v10
end

function t.GetLegacyLevelXP(arg19) -- line: 199
    local v11 = 1
    v11 = if not (arg19 > 40) then if not (arg19 > 35) then v11 else 1 + 0.1 * (arg19 - 35) else 1.5 + 0.05 * (arg19 - 40)

    return (math.floor(200 * arg19 ^ 0.575 * v11))
end

function t.MeetsEvolutionRequirements(_, arg21) -- line: 203
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] t (copy)

    local v12 = StatManager_m.require(arg21)
    local EvoQuest2 = arg21.Quests:FindFirstChild("EvoQuest2")

    if not EvoQuest2 then
        return
    end

    local v13 = nil
    local EvolutionXP = v12:GetStat("EvolutionXP")
    local EvolutionBreakthrough = t.EvolutionBreakthrough

    for _, val in {
        EvoQuest2.Tasks["Eliminate players"],
        EvoQuest2.Tasks["Defeat bosses"],
        EvoQuest2.Tasks["Arcane mastery"]
    } do
        if val:GetAttribute("TaskProgress") < val:GetAttribute("TaskMax") then
            v13 = true
            break
        end
    end

    if EvolutionBreakthrough <= EvolutionXP and not v13 then
        return true
    end
end

function t.GetAugmentLimit(_, _) -- line: 237
    return 3
end

return t
