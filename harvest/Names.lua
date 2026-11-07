-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Names
-- Class: ModuleScript
-- bytes: 3186

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = require(ReplicatedStorage.Modules.DictionaryRandom)
local t = {}
t.__index = t
t.First = require(script.First)
t.Last = require(script.Last)
local rng = Random.new()
local t_1 = table.freeze({})
local t_2 = {}

for _, val in t.Last.Tiers do
    for _, val_1 in val.Names do
        t_2[val_1] = val
    end
end

function t.GiveName(arg1) -- line: 25
    return arg1.First:GetName()
end

function t.GiveFamilyName(arg2) -- line: 30
    -- upvalues:
    --  [1] rng (copy)

    local Tiers = arg2.Last.Tiers
    local v1 = 0

    for _, val_2 in Tiers do
        v1 += val_2.Chance
    end

    local v2 = rng:NextNumber() * v1
    v1 = Tiers[#Tiers]

    for _, val_3 in Tiers do
        v2 -= val_3.Chance

        if v2 < 0 then
            v1 = val_3
            break
        end
    end

    return v1.Names[rng:NextInteger(1, #v1.Names)]
end

function t.GetFamilyName(_, arg4) -- line: 52
    local v4 = arg4

    if typeof(arg4) == "Instance" then
        local CustomizeFolder = arg4:FindFirstChild("CustomizeFolder")
        local v5 = CustomizeFolder

        if v5 then
            v5 = CustomizeFolder:FindFirstChild("CharacterName")
        end

        v4 = v5 and v5.Value
    end

    if type(v4) ~= "string" then
        return nil
    end

    local v7 = string.split(v4, " ")

    for index = #v7, 2, -1 do
        if v7[index] ~= "" then
            return v7[index]
        end
    end

    return nil
end

function t.GetFamilyTier(_: table, s1: string?) -- line: 73
    -- upvalues:
    --  [1] t_2 (copy)

    return s1 and t_2[s1] or nil
end

function t.GetFamilyBuffs(arg5, arg6) -- line: 78
    -- upvalues:
    --  [1] t_1 (copy)

    local v9 = arg6

    if typeof(arg6) ~= "Instance" then
        if type(arg6) == "string" and string.find(arg6, " ", 1, true) then
            v9 = arg5:GetFamilyName(arg6)
        end
    else
        v9 = arg5:GetFamilyName(arg6)
    end

    return v9 and arg5.Last.Buffs[v9] or t_1
end

function t.GetFamilyBonus(t2: table, arg7: any, s2: string) -- line: 87
    return tonumber(t2:GetFamilyBuffs(arg7)[s2]) or 0
end

function t.GetFamilyProfessionBonus(t3: table, arg8: any, s3: string) -- line: 92
    local v11 = t3:GetFamilyBuffs(arg8)

    return (v11.ProfessionXP and tonumber(v11.ProfessionXP[s3]) or 0) + (tonumber(
        v11.AllProfessionXP
    ) or 0)
end

function t.BoostAmount(_: table, n1: number, n2: number) -- line: 100
    if type(n1) == "number" then
        if not (n1 <= 0) then
            if type(n2) ~= "number" or n2 <= 0 then
                return n1
            end

            local v13 = n1 * (n2 / 100 + 1)
            local v14 = math.floor(v13)

            if math.random() < v13 - v14 then
                v14 += 1
            end

            return v14
        end

        return n1
    else
        return n1
    end
end

function t.GetFamilyMagicBonus(t5: table, arg9: any, s4: string?) -- line: 113
    if s4 and t5:GetFamilyBuffs(arg9).Magic == s4 then
        return t5.Last.MagicAffinity
    end

    return 0
end

return t
