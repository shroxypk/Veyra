-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.queries.defineQuery
-- Class: ModuleScript
-- bytes: 348

local _: any = require(script.Parent.Parent.types)
local Query_m: any = require(script.Parent.query)

return function(arg1) -- line: 7
    -- upvalues:
    --  [1] Query_m (copy)

    return function(n1: number) -- line: 8
        -- upvalues:
        --  [1] Query_m (ref)
        --  [2] arg1 (copy)

        return Query_m(arg1, n1)
    end
end
