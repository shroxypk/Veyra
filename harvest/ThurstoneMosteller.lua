-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService.OpenSkill.Models.ThurstoneMosteller
-- Class: ModuleScript
-- bytes: 1855

local Util_m = require(script.Parent.Parent.Util)
local Constants_m = require(script.Parent.Parent.Constants)
local Statistics_m = require(script.Parent.Parent.Statistics)

return function(arg1, arg2) -- line: 5
    -- upvalues:
    --  [1] Constants_m (copy)
    --  [2] Util_m (copy)
    --  [3] Statistics_m (copy)

    local v1 = arg2 or {}
    arg2 = v1
    v1 = Constants_m.betaSq(arg2) * 2
    local v2 = Constants_m.epsilon(arg2)
    local v3 = Util_m.teamRating(arg1, arg2)
    local t = {}

    for key, val in ipairs(v3) do
        local v4, v5, v6, v7 = unpack(val)
        local v8 = 0
        local v9 = 0

        for key_1, val_1 in ipairs(v3) do
            local v10, v11, _, v13 = unpack(val_1)

            if key ~= key_1 then
                local v14 = math.sqrt(v5 + v11 + v1)
                local v15 = (v4 - v10) / v14
                local v16 = v5 / v14
                local v17 = Util_m.gamma(v14, v5)

                if v7 < v13 then
                    v8 += v16 * Statistics_m.v(v15, v2 / v14)
                    v9 += v17 * v16 / v14 * Statistics_m.w(v15, v2 / v14)
                elseif v7 > v13 then
                    v8 += -v16 * Statistics_m.v(-v15, v2 / v14)
                    v9 += v17 * v16 / v14 * Statistics_m.w(-v15, v2 / v14)
                else
                    v8 += v16 * Statistics_m.vt(v15, v2 / v14)
                    v9 += v17 * v16 / v14 * Statistics_m.wt(v15, v2 / v14)
                end
            end
        end

        local t_1 = {}

        for _, val_2 in ipairs(v6) do
            table.insert(
                t_1,
                {
                    val_2.mu + val_2.sigma ^ 2 / v5 * v8,
                    val_2.sigma * math.sqrt((math.max(1 - val_2.sigma ^ 2 / v5 * v9, v2)))
                }
            )
        end

        t[key] = t_1
    end

    return t
end
