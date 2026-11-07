-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService.OpenSkill.Util
-- Class: ModuleScript
-- bytes: 4176

local Constants_m = require(script.Parent.Constants)
local t = {
    score = function(arg1, arg2) --[[ score ]] -- line: 4
        return if not (arg1 < arg2) then if not (arg1 > arg2) then 0.5 else 1 else 0
    end,
    rankings = function(arg3, arg4) --[[ rankings ]] -- line: 13
        local v1 = arg4 or {}
        arg4 = v1
        v1 = {}

        for key, _ in ipairs(arg3) do
            table.insert(v1, arg4[key] or key)
        end

        local t_1 = {}
        local v2 = 1

        for index = 1, #v1 do
            if index > 1 and v1[index - 1] < v1[index] then
                v2 = index
            end

            t_1[index] = v2
        end

        for key_1, _ in ipairs(t_1) do
            t_1[key_1] -= 1
        end

        return t_1
    end
}

function t.teamRating(arg5, arg6) -- line: 33
    -- upvalues:
    --  [1] t (copy)

    local v3 = t.rankings(arg5, arg6.rank)
    local t_2 = {}

    for key_2, val_2 in ipairs(arg5) do
        local v4 = 0
        local v5 = 0

        for _, val_3 in ipairs(val_2) do
            v4 += val_3.mu
            v5 += val_3.sigma ^ 2
        end

        table.insert(t_2, { v4, v5, val_2, v3[key_2] })
    end

    return t_2
end

function t.ladderPairs(arg7) -- line: 47
    local v6 = #arg7

    if v6 == 0 then
        return { {} }
    end

    local t_3 = {}
    table.move(
        arg7,
        1,
        v6 - 1,
        2,
        t_3
    )
    local t_4 = {}
    table.move(
        arg7,
        2,
        v6,
        1,
        t_4
    )
    local t_5 = {}

    for index_1 = 1, v6 do
        if t_3[index_1] then
            table.insert(t_5, { t_3[index_1], t_4[index_1] })
        else
            table.insert(t_5, { t_4[index_1] })
        end
    end

    return t_5
end

function t.permutations(arg8) -- line: 67
    local v7 = #arg8 + 1
    local t_6 = { { unpack(arg8) } }
    local t_8 = {}

    for _ = 1, v7 - 1 do
        table.insert(t_8, 1)
    end

    local v8 = 1

    while v7 > v8 do
        if v8 > t_8[v8] then
            if v8 % 2 == 1 then
                arg8[v8], arg8[1] = arg8[1], arg8[v8]
            else
                local v9 = t_8[v8]
                arg8[v8], arg8[v9] = arg8[v9], arg8[v8]
            end

            table.insert(t_6, { unpack(arg8) })
            t_8[v8] += 1
            v8 = 1
            continue
        end

        t_8[v8] = 1
        v8 += 1
    end

    return t_6
end

function t.c(arg9, arg10) -- line: 94
    -- upvalues:
    --  [1] Constants_m (copy)

    local v10 = Constants_m.betaSq(arg10)
    local v11 = 0

    for _, val_4 in ipairs(arg9) do
        v11 += val_4[2] + v10
    end

    return (math.sqrt(v11))
end

function t.sumQ(arg11, arg12) -- line: 103
    local t_10 = {}

    for _, val_5 in ipairs(arg11) do
        local v12 = 0

        for _, val_6 in ipairs(arg11) do
            if val_6[4] >= val_5[4] then
                v12 += math.exp(val_6[1] / arg12)
            end
        end

        table.insert(t_10, v12)
    end

    return t_10
end

function t.a(arg13) -- line: 117
    local t_11 = {}

    for _, val_7 in ipairs(arg13) do
        local t_12 = {}

        for _, val_8 in ipairs(arg13) do
            if val_7[4] == val_8[4] then
                table.insert(t_12, val_8)
            end
        end

        table.insert(t_11, #t_12)
    end

    return t_11
end

function t.gamma(arg14, arg15, arg16) -- line: 137
    if arg16 and arg16.gamma then
        return arg16.gamma(arg14, arg15, arg16)
    end

    return math.sqrt(arg15) / arg14
end

function t.unwind(t1: table, t2: table) -- line: 145
    local t_13 = {}
    local t_14 = {}
    local t_15 = {}
    local t_16 = {}

    for index_3 = 1, #t2 do
        local v13 = math.huge
        local v14 = nil

        for key_9, val_9 in ipairs(t2) do
            if not table.find(t_16, key_9) and v13 > val_9 then
                v13 = val_9
                v14 = key_9
            end
        end

        table.insert(t_16, v14)
        t_15[v14] = index_3
    end

    for key_10, val_10 in ipairs(t1) do
        t_13[t_15[key_10]] = val_10
        t_14[t_15[key_10]] = key_10
    end

    return t_13, t_14
end

return t
