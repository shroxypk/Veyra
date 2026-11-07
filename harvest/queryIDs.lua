-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.namespaces.queryIDs
-- Class: ModuleScript
-- bytes: 290

local t: any = {}

return {
    set = function(n1: number, arg1: any) --[[ set ]] -- line: 10
        -- upvalues:
        --  [1] t (copy)

        t[n1] = arg1
    end,
    ref = function() --[[ ref ]] -- line: 14
        -- upvalues:
        --  [1] t (copy)

        return t
    end
}
