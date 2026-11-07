-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.nothing
-- Class: ModuleScript
-- bytes: 280

local _ = require(script.Parent.Parent.types)
local t = {
    write = function() --[[ write ]] -- line: 4
    end,
    read = function() --[[ read ]] -- line: 6
        return nil, 0
    end
}

return function() -- line: 11
    -- upvalues:
    --  [1] t (copy)

    return t
end
