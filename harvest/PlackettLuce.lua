-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService.OpenSkill.Models.PlackettLuce
-- Class: ModuleScript
-- bytes: 1383

local Util_m = require(script.Parent.Parent.Util)
local Constants_m = require(script.Parent.Parent.Constants)

return function(arg1, arg2) -- line: 4
    -- upvalues:
    --  [1] Constants_m (copy)
    --  [2] Util_m (copy)

    local v1 = arg2 or {}
    arg2 = v1
    v1 = Constants_m.epsilon(arg2)
    local v2 = Util_m.teamRating(arg1, arg2)
    local v3 = Util_m.c(v2, arg2)
    local v4 = Util_m.sumQ(v2, v3)
    local v5 = Util_m.a(v2)
    local t = {}

    for key, val in ipairs(v2) do
        local v6, v7, v8, v9 = unpack(val)
        local v10 = math.exp(v6 / v3)
        local v11 = 0
        local v12 = 0

        for key_1, val_1 in ipairs(v2) do
            if v9 >= val_1[4] then
                local v13 = v10 / v4[key_1]
                v11 = if key ~= key_1 then v11 + -v13 / v5[key_1] else v11 + (1 - v13) / v5[key_1]
                v12 += v13 * (1 - v13) / v5[key_1]
            end
        end

        local v14 = v11 * (v7 / v3)
        v11 = Util_m.gamma(v3, v7, arg2) * v12 * (v7 / v3 ^ 2)
        v12 = {}

        for _, val_2 in ipairs(v8) do
            table.insert(
                v12,
                {
                    val_2.mu + val_2.sigma ^ 2 / v7 * v14,
                    val_2.sigma * math.sqrt((math.max(1 - val_2.sigma ^ 2 / v7 * v11, v1)))
                }
            )
        end

        t[key] = v12
    end

    return t
end
