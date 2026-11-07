-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.uint16
-- Class: ModuleScript
-- bytes: 374

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = {
    write = BufferWriter_m.u16,
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 9
        return buffer.readu16(buf1, n1), 2
    end
}

return function() -- line: 14
    -- upvalues:
    --  [1] t (copy)

    return t
end
