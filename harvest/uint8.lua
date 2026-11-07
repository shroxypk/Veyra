-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.uint8
-- Class: ModuleScript
-- bytes: 334

local _ = require(script.Parent.Parent.types)
local t = {
    write = require(script.Parent.Parent.process.bufferWriter).u8,
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 9
        return buffer.readu8(buf1, n1), 1
    end
}

return function() -- line: 14
    -- upvalues:
    --  [1] t (copy)

    return t
end
