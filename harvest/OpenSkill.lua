-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService.OpenSkill
-- Class: ModuleScript
-- bytes: 2710

local t = { Settings = { DefaultModel = "PlackettLuce" } }
local Constants_m = require(script.Constants)
local _ = require(script.Gaussian)
local Statistics_m = require(script.Statistics)
local Util_m = require(script.Util)
local Models_m = require(script.Models)

function t.Ordinal(t1: table, arg1: any) -- line: 54
    -- upvalues:
    --  [1] Constants_m (copy)

    local v1 = arg1 or {}

    return t1.mu - Constants_m.z(v1) * t1.sigma
end

function t.Rating(n1: number?, n2: number?, arg2: any) -- line: 59
    -- upvalues:
    --  [1] Constants_m (copy)

    local v3 = arg2 or {}
    arg2 = v3
    v3 = { mu = n1 }

    for key, val in next, arg2 do
        v3[key] = val
    end

    return { mu = n1 or Constants_m.mu(arg2), sigma = n2 or Constants_m.sigma(v3) }
end

function t.Rate(t2: table, arg3: any) -- line: 72
    -- upvalues:
    --  [1] Models_m (copy)
    --  [2] t (copy)
    --  [3] Util_m (copy)

    local v5 = arg3 or {}
    arg3 = v5
    v5 = Models_m[arg3.model or t.Settings.DefaultModel]
    local v8

    if arg3.rank == nil and arg3.score == nil then
        v8 = v5(t2, arg3)

        for key_1, val_1 in ipairs(v8) do
            for key_2, val_2 in ipairs(val_1) do
                t2[key_1][key_2].mu = val_2[1]
                t2[key_1][key_2].sigma = val_2[2]
            end
        end

        return v8
    end

    v8 = arg3.rank

    if not v8 then
        v8 = {}

        for key_3, val_3 in ipairs(arg3.score) do
            v8[key_3] = -val_3
        end
    end

    local v9, v10 = Util_m.unwind(t2, v8)
    local t_2 = { rank = v8 }

    for key_4, val_4 in next, arg3 do
        t_2[key_4] = val_4
    end

    table.sort(v8)
    local v11 = Util_m.unwind(v5(v9, t_2), v10)

    for key_5, val_5 in ipairs(v11) do
        for key_6, val_6 in ipairs(val_5) do
            t2[key_5][key_6].mu = val_6[1]
            t2[key_5][key_6].sigma = val_6[2]
        end
    end

    return v11
end

function t.WinProbability(t3: table, arg4: any) -- line: 110
    -- upvalues:
    --  [1] Util_m (copy)
    --  [2] Constants_m (copy)
    --  [3] Statistics_m (copy)

    local v12 = arg4 or {}
    arg4 = v12
    v12 = Util_m.teamRating(t3, arg4)
    local v13 = Constants_m.betaSq(arg4)
    local v14 = #t3
    local v15 = v14 * (v14 - 1) / 2
    local t_3 = {}

    for key_7, val_7 in ipairs(v12) do
        local v16 = 0

        for key_8, val_8 in ipairs(v12) do
            if key_7 ~= key_8 then
                v16 += Statistics_m.phiMajor(
                    (val_7[1] - val_8[1]) / math.sqrt(v14 * v13 + val_7[2] ^ 2 + val_8[2] ^ 2)
                )
            end
        end

        table.insert(t_3, v16 / v15)
    end

    return t_3
end

return t
