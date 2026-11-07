-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Professions
-- Class: ModuleScript
-- bytes: 16329

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
    MaxLevel = 30,
    Version = 2,
    Ranks = {
        { Name = "Novice", Level = 1 },
        { Name = "Apprentice", Level = 5 },
        { Name = "Journeyman", Level = 10 },
        { Name = "Adept", Level = 15 },
        { Name = "Expert", Level = 20 },
        { Name = "Master", Level = 25 },
        { Name = "Grandmaster", Level = 30 }
    },
    TotalLevelRewards = {
        { Level = 25, LockedEssence = 200 },
        { Level = 50, LockedEssence = 300, Title = "Tradesman" },
        { Level = 75, LockedEssence = 400 },
        { Level = 100, LockedEssence = 500, Title = "Polymath" },
        { Level = 125, LockedEssence = 600 },
        { Level = 150, LockedEssence = 1000, Title = "Jack of All Trades" }
    },
    LegacyMaxLevel = 6
}
local t_1 = {
    { 1, 0, 0, 0 },
    { 5, 0.15, 0, 0 },
    { 10, 0.28, 0, 0 },
    { 15, 0.38, 0.08, 0 },
    { 20, 0.48, 0.16, 0 },
    { 25, 0.55, 0.24, 0.03 },
    { 30, 0.6, 0.3, 0.06 }
}
local t_2 = { LockedEssence = 15, PlayerXP = 0.05 }
local t_3 = { LockedEssence = 75, PlayerXP = 0.25 }
local t_4 = { LockedEssence = 200, PlayerXP = 0.5 }
local t_5 = {}
local t_6 = {}

for _, child in script:GetChildren() do
    if child:IsA("ModuleScript") then
        local Success, Result = pcall(require, child)

        if Success then
            if type(Result) == "table" then
                if Result.Skills then
                    t_5[child.Name] = Result
                else
                    t_6[child.Name] = Result
                end
            else
                warn(`[Professions] failed to load {child.Name}: {Result}`)
            end
        else
            warn(`[Professions] failed to load {child.Name}: {Result}`)
        end
    end
end

function t.GetProfessions(_) -- line: 93
    -- upvalues:
    --  [1] t_5 (copy)

    return t_5
end

function t.GetLegacy(_) -- line: 98
    -- upvalues:
    --  [1] t_6 (copy)

    return t_6
end

function t.GetAllProfessions(_) -- line: 103
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] t_6 (copy)

    local t_7 = table.clone(t_5)

    for key_1, val in t_6 do
        t_7[key_1] = val
    end

    return t_7
end

function t.IsLegacy(_, arg5) -- line: 111
    -- upvalues:
    --  [1] t_6 (copy)

    return t_6[arg5] ~= nil
end

function t.Get(_, arg7) -- line: 115
    -- upvalues:
    --  [1] t_5 (copy)

    return t_5[arg7]
end

function t.IsMilestone(_, arg9) -- line: 119
    -- upvalues:
    --  [1] t (copy)

    return if arg9 % 5 ~= 0 then false else arg9 >= 5 and arg9 <= t.MaxLevel
end

function t.GetRank(_, arg11) -- line: 124
    -- upvalues:
    --  [1] t (copy)

    local v3 = t.Ranks[1]
    local v4 = 1

    for key_2, val_1 in t.Ranks do
        if arg11 >= val_1.Level then
            v3 = val_1
            v4 = key_2
        end
    end

    return v3, v4
end

t.TitleRanks = {}

for key_3, val_2 in t.Ranks do
    if val_2.Level == math.floor(t.MaxLevel / 2) or key_3 == #t.Ranks then
        t.TitleRanks[key_3] = true
    end
end

function t.GetRankTitle(_, arg13, arg14, arg15) -- line: 144
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] t (copy)

    local v5 = t_5[arg13]

    if not v5 then
        return nil
    end

    local v6 = arg14

    if arg15 then
        local _, v8 = t:GetRank(arg14)
        v6 = v8
    end

    if v6 <= 1 or not t.TitleRanks[v6] then
        return nil
    end

    if v6 >= #t.Ranks then
        return v5.Title
    end

    return `{t.Ranks[v6].Name} {v5.Noun}`
end

function t.GetAllTitles(_) -- line: 164
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] t (copy)

    local t_8 = {}

    for key_4, _ in t_5 do
        for index = 2, #t.Ranks do
            local _ = #t.Ranks
            local v10 = t:GetRankTitle(key_4, index)

            if v10 then
                t_8[v10] = { Profession = key_4, Rank = index }
            end
        end
    end

    for _, val_4 in t.TotalLevelRewards do
        if val_4.Title then
            local t_10 = { Total = val_4.Level }
            t_8[val_4.Title] = t_10
        end
    end

    return t_8
end

function t.GetMaxLevel(_, arg18) -- line: 182
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] t (copy)

    if t_6[arg18] then
        return 6
    end

    return t.MaxLevel
end

function t.GetRequiredXP(_, arg20, arg21) -- line: 186
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] t_5 (copy)
    --  [3] t (copy)

    if t_6[arg20] then
        local v11 = math.clamp(arg21, 1, 6) / 5

        return (math.floor(v11 * v11 * 45000 + 5000))
    end

    local v12 = t_5[arg20]
    local v13 = v12 and v12.XPMultiplier or 1

    return (math.floor(
        (1500 + (math.clamp(arg21, 1, t.MaxLevel - 1) / (t.MaxLevel - 1)) ^ 2 * 7500) * v13
    ))
end

local _ = function(arg22, arg23, arg24) --[[ addBonus ]] -- line: 199
    if typeof(arg24) == "number" then
        arg22[arg23] = (arg22[arg23] or 0) + arg24

        return
    end

    if arg24 ~= nil then
        arg22[arg23] = arg24
    end
end

function t.FormatCore(_, arg26, arg27) -- line: 208
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] t (copy)

    local v14 = t_5[arg26]
    local v15 = v14

    if v15 then
        v15 = v14.Core
    end

    if not v15 then
        return ""
    end

    arg27 = arg27 or v15.PerLevel

    if v15.Flat then
        v14 = math.abs(arg27 - math.round(arg27)) < 0.001 and tostring((math.round(arg27))) or string.format(
            "%.1f",
            arg27
        )

        return `+{v14}{v15.Suffix or ""} {v15.Label}`
    end

    local v18 = t.FormatPercent(arg27)

    return `+{v18} {v15.Label}`
end

local t_11 = {}

function t.GetBenefits(_, arg29, arg30) -- line: 224
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] t_5 (copy)
    --  [3] t (copy)
    --  [4] t_11 (copy)

    if not arg29 or not arg30 then
        return {}
    end

    local v19 = t_6[arg29]

    if v19 then
        local t_12 = {}

        for index_1 = 2, math.min(tonumber(arg30) or 1, 6) do
            local v20 = v19.Levels
            local _ = math.min(tonumber(arg30) or 1, 6)

            if v20 then
                v20 = v19.Levels[index_1]
            end

            if v20 and v20.Attributes then
                for key_6, val_5 in v20.Attributes do
                    if typeof(val_5) == "number" then
                        t_12[key_6] = (t_12[key_6] or 0) + val_5
                    elseif val_5 ~= nil then
                        t_12[key_6] = val_5
                    end
                end
            end
        end

        return t_12
    end

    local v22 = t_5[arg29]

    if not v22 then
        return {}
    end

    arg30 = math.clamp(math.floor(tonumber(arg30) or 1), 1, t.MaxLevel)
    local v24 = arg29 .. "_" .. arg30

    if t_11[v24] then
        return table.clone(t_11[v24])
    end

    local t_13 = {}

    if v22.Core then
        local Key = v22.Core.Key
        local v25 = v22.Core.PerLevel * (arg30 - 1)

        if typeof(v25) == "number" then
            t_13[Key] = (t_13[Key] or 0) + v25
        elseif v25 ~= nil then
            t_13[Key] = v25
        end
    end

    for key_7, val_6 in v22.Skills do
        if arg30 >= key_7 and val_6.Attributes then
            for key_8, val_7 in val_6.Attributes do
                if typeof(val_7) == "number" then
                    t_13[key_8] = (t_13[key_8] or 0) + val_7
                elseif val_7 ~= nil then
                    t_13[key_8] = val_7
                end
            end
        end
    end

    t_11[v24] = t_13

    return table.clone(t_13)
end

function t.GetPlayerLevel(_, arg32, arg33) -- line: 274
    local v26 = arg32

    if v26 then
        v26 = arg32:FindFirstChild("Professions")
    end

    local v27 = v26

    if v27 then
        v27 = v26:FindFirstChild(arg33)
    end

    return v27 and v27.Value or 1
end

function t.GetCraftRequirement(_, arg35) -- line: 283
    -- upvalues:
    --  [1] t_5 (copy)

    local v29 = arg35._craftsettings

    if type(arg35) ~= "table" or not v29 then
        v29 = {}
    end

    local CraftProfession = v29.CraftProfession

    if type(CraftProfession) == "string" and (CraftProfession ~= "" and t_5[CraftProfession]) then
        return CraftProfession, tonumber(v29.CraftProfessionLevel) or 1
    end

    local v30 = v29.CraftLevel or 1
    v29 = t_5.Crafting

    if v29 then
        v29 = t_5.Crafting.RecipeLevels
    end

    return "Crafting", v29 and v29[v30] or v30
end

function t.GetPlayerBenefits(_, arg37, arg38) -- line: 297
    -- upvalues:
    --  [1] t (copy)

    local v33 = t:GetBenefits(arg38, t:GetPlayerLevel(arg37, arg38))

    if arg38 == "Mining" then
        local v34 = arg37

        if v34 then
            v34 = arg37.Character
        end

        if v34 and v34:FindFirstChild("Lucky Miner") then
            v33.duplicate_chance = 1 - (1 - (v33.duplicate_chance or 0)) * 0.7
        end
    end

    return v33
end

function t.AdjustNPCDamage(_, arg40, arg41) -- line: 317
    -- upvalues:
    --  [1] t (copy)

    local Combat, Humanoid, playerFromCharacter

    if typeof(arg41) == "number" then
        if not (arg41 <= 0) then
            if typeof(arg40) ~= "Instance" then
                return arg41
            end

            playerFromCharacter = game:GetService("Players"):GetPlayerFromCharacter(arg40)

            if not playerFromCharacter then
                return arg41
            end

            Combat = t:GetPlayerBenefits(playerFromCharacter, "Combat")
            arg41 *= 1 - (Combat.npc_damage_reduction or 0)

            if (Combat.unbroken or 0) > 0 then
                Humanoid = arg40:FindFirstChildWhichIsA("Humanoid")

                if Humanoid and (if not ((arg40:GetAttribute("UnbrokenReady") or 0) <= os.clock()) then false else true) and Humanoid.Health > 1 and Humanoid.Health - arg41 <= 0 then
                    arg40:SetAttribute("UnbrokenReady", os.clock() + 120)
                    arg41 = Humanoid.Health - 1
                end
            end

            return arg41
        else
            return arg41
        end
    else
        return arg41
    end
end

function t.GetQualityOdds(_, arg43, arg44) -- line: 342
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)

    arg43 = math.clamp(arg43 or 1, 1, t.MaxLevel)
    local t_14 = { 0, 0, 0 }

    for index_2 = 1, #t_1 do
        local v40 = t_1[index_2]
        local v41 = t_1[index_2 + 1]

        if arg43 >= v40[1] and (not v41 or arg43 < v41[1]) then
            for index_3 = 1, 3 do
                local v42 = v40[index_3 + 1]

                if v42 > 0 and v41 then
                    local _ = #t_1
                    t_14[index_3] = v42 + (v41[index_3 + 1] - v42) * ((arg43 - v40[1]) / (v41[1] - v40[1])) * 0.6
                else
                    local _ = #t_1
                    t_14[index_3] = v42
                end
            end
        end
    end

    if arg44 then
        if t_14[1] > 0 then
            t_14[1] = t_14[1] + (arg44.quality_bonus1 or 0)
        end

        if t_14[2] > 0 then
            t_14[2] = t_14[2] + (arg44.quality_bonus2 or 0)
        end
    end

    return t_14
end

function t.RollQuality(_, arg46, arg47) -- line: 375
    -- upvalues:
    --  [1] t (copy)

    local v45 = t:GetQualityOdds(arg46, arg47)
    local v46 = math.random()

    if v46 < v45[3] then
        return 3
    end

    return if not (v46 < v45[3] + v45[2]) then if not (v46 < v45[3] + v45[2] + v45[1]) then 0 else 1 else 2
end

function t.RollQualities(_, arg49, arg50, arg51) -- line: 389
    -- upvalues:
    --  [1] t (copy)

    local t_15 = { 0, 0, 0 }
    local v47 = math.floor(arg51 or 1)

    for _ = 1, math.max(v47, 0) do
        local v48 = t:RollQuality(arg49, arg50)
        local _ = math.max(v47, 0)

        if v48 > 0 then
            t_15[v48] += 1
        end
    end

    return t_15
end

function t.RollPlayerQualities(_, arg53, arg54, arg55) -- line: 401
    -- upvalues:
    --  [1] t (copy)

    return t:RollQualities(t:GetPlayerLevel(arg53, arg54), t:GetPlayerBenefits(arg53, arg54), arg55)
end

t.CraftStarChances = { 0.25, 0.08, 0.015 }
t.MaterialStarBonus = 1
t.SmeltBaseReturn = 0.35

function t.CanCraftStars(_, arg57) -- line: 423
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if type(arg57) ~= "table" then
        return false
    end

    if arg57.Type == "Material" then
        return true
    end

    return not (require(ReplicatedStorage.Modules.Items).HardCoded[arg57.Type] or arg57.HardCoded)
end

function t.GetCraftQualityBoost(_, arg59, arg60) -- line: 435
    -- upvalues:
    --  [1] t (copy)

    arg59 = arg59 or {}

    return (arg59.star_boost or 0) + (arg60 or 0) * t.MaterialStarBonus * (1 + (arg59.quality_eye or 0))
end

function t.RollCraftStars(_, arg62) -- line: 442
    -- upvalues:
    --  [1] t (copy)

    for index_5 = 3, 1, -1 do
        if math.random() < t.CraftStarChances[index_5] * (1 + (arg62 or 0)) then
            return index_5
        end
    end

    return 0
end

function t.GetCraftStarOdds(_, arg64, arg65, arg66) -- line: 452
    -- upvalues:
    --  [1] t (copy)

    local v56 = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }
    local v57 = 1

    for index_6 = 3, 1, -1 do
        v56[index_6] = v57 * math.min(t.CraftStarChances[index_6] * (1 + (arg64 or 0)), 1)
        v57 -= v56[index_6]
    end

    v56[0] = v57
    arg65 = math.clamp(arg65 or 0, 0, 3)

    for index_7 = 3, arg65 + 1, -1 do
        v56[arg65] += v56[index_7]
        v56[index_7] = 0
    end

    if not arg66 then
        return v56
    end

    local t_16 = {}
    local t_17 = { [0] = t_16[0] ^ 2 - 0 }
    v57 = 0 + v56[0]
    t_16[0] = v57
    v57 += v56[1]
    t_16[1] = v57
    v57 += v56[2]
    t_16[2] = v57
    t_16[3] = v57 + v56[3]
    v57 = t_16[0] or 0
    t_17[1] = t_16[1] ^ 2 - v57 ^ 2
    v56 = t_16[1] or 0
    t_17[2] = t_16[2] ^ 2 - v56 ^ 2
    local v58 = t_16[2] or 0
    t_17[3] = t_16[3] ^ 2 - v58 ^ 2

    return t_17
end

function t.GetLevelReward(_, arg68) -- line: 487
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_4 (copy)
    --  [3] t_3 (copy)
    --  [4] t_2 (copy)

    if arg68 >= t.MaxLevel then
        return t_4
    end

    if t:IsMilestone(arg68) then
        return t_3
    end

    return t_2
end

function t.GetChallenge(_, arg70, arg71) -- line: 497
    -- upvalues:
    --  [1] t_5 (copy)

    local v59 = t_5[arg70]

    return if not v59 then nil else if v59.Challenges then v59.Challenges[arg71] else nil
end

function t.FormatPercent(arg72) --[[ pct ]] -- line: 505
    local v60 = arg72 * 100

    if math.abs(v60 - math.round(v60)) < 0.001 then
        return tostring((math.round(v60))) .. "%"
    end

    return string.format("%.1f%%", v60)
end

function t.GetLevelEntries(_, arg74) -- line: 524
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] t (copy)

    local v62 = t_5[arg74]
    local t_18 = {}

    if not v62 then
        return t_18
    end

    for index_8 = 1, t.MaxLevel do
        local _ = t.MaxLevel
        local v63 = t:IsMilestone(index_8)
        local t_19 = {
            Level = index_8,
            Milestone = v63,
            Core = index_8 > 1 and (v62.Core and t:FormatCore(arg74)) or nil,
            Skill = v62.Skills[index_8],
            Challenge = t:GetChallenge(arg74, index_8),
            Reward = index_8 > 1 and t:GetLevelReward(index_8) or nil
        }

        if v63 then
            t_19.Rank = t:GetRank(index_8).Name
            t_19.Title = t:GetRankTitle(arg74, index_8, true)

            if v62.Gathers then
                local v66 = t:GetQualityOdds(index_8)
                local t_20 = {}

                for index_9 = 1, 3 do
                    if v66[index_9] > 0 then
                        local v67 = v66[index_9] * 100
                        local v69 = if math.abs(v67 - math.round(v67)) < 0.001 then tostring(
                            (math.round(v67))
                        ) .. "%" else string.format("%.1f%%", v67)
                        table.insert(t_20, `{index_9}\226\152\133 {v69}`)
                    end
                end

                t_19.Quality = #t_20 > 0 and table.concat(t_20, ", ") or nil
            end
        end

        t_18[index_8] = t_19
    end

    return t_18
end

return t
