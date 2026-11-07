-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.PvE_Scale
-- Class: ModuleScript
-- bytes: 2229

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local Modules = game:GetService("ReplicatedStorage").Modules
local StatManager_m = require(Modules.StatManager)
local Basic_m = require(Modules.Basic)

local _ = function(arg1) --[[ levelBonus ]] -- line: 19
    -- upvalues:
    --  [1] Basic_m (copy)

    local v2 = math.clamp(((tonumber(arg1) or 1) - 1) / (Basic_m.MaxLevel - 1), 0, 1)

    return v2 * 0.1975 + 0.01 + v2 * -0.272 * v2 + v2 * 0.1945 * v2 * v2
end

local t = nil

local function getWeight(arg2, arg3) -- line: 29
    -- upvalues:
    --  [1] t (ref)
    --  [2] Modules (copy)

    if type(arg2) == "table" and type(arg2.PvEWeight) == "number" then
        return arg2.PvEWeight
    end

    if type(arg3) ~= "string" then
        return 1
    end

    if not t then
        t = {}

        for key, val in require(Modules.Skills).Skills do
            if type(val) == "table" and type(val.PvEWeight) == "number" then
                t[string.gsub(key, "[^%w]", "")] = val.PvEWeight
            end
        end
    end

    return string.match(arg3, "^(.-)/") and t[string.gsub(string.match(arg3, "^(.-)/"), "[^%w]", "")] or 1
end

local function factorScale(arg4, arg5, arg6, arg7) -- line: 51
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StatManager_m (copy)
    --  [3] Basic_m (copy)
    --  [4] getWeight (copy)

    if not arg4 then
        return arg5
    end

    local playerFromCharacter = Players:GetPlayerFromCharacter(arg4)

    if not playerFromCharacter then
        return arg5
    end

    local States = arg4:FindFirstChild("States")
    local v7 = States

    if v7 then
        v7 = States:FindFirstChild("Armor")
    end

    local v8 = math.clamp(
        ((tonumber((StatManager_m.require(playerFromCharacter):GetStat("Level"))) or 1) - 1) / (Basic_m.MaxLevel - 1),
        0,
        1
    )
    local v10 = (v8 * 0.1975 + 0.01 + v8 * -0.272 * v8 + v8 * 0.1945 * v8 * v8) * getWeight(
        arg6,
        arg7
    )
    local v11 = v7

    if v11 then
        v11 = v7:FindFirstChild("MonsterBonus")
    end

    if v11 then
        v10 += v11.Value / 100
    end

    return arg5 * (1 + v10)
end

return factorScale
