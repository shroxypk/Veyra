-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.DictionaryRandom
-- Class: ModuleScript
-- bytes: 613

return {
    ArraySelectRandom = function(arg1) --[[ ArraySelectRandom ]] -- line: 11
        if #arg1 == 1 then
            return arg1[1]
        end

        return arg1[Random.new():NextInteger(1, #arg1)]
    end,
    DictionarySelectRandom = function(arg2) --[[ DictionarySelectRandom ]] -- line: 21
        local t_1 = {}

        for key, _ in pairs(arg2) do
            table.insert(t_1, key)
        end

        if #t_1 == 1 then
            local v2 = t_1[1]

            return arg2[v2], v2
        end

        local v4 = t_1[Random.new():NextInteger(1, #t_1)]

        return arg2[v4], v4
    end
}
