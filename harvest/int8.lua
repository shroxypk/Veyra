-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.int8
-- Class: ModuleScript
-- bytes: 372

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = {
    write = BufferWriter_m.i8,
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 9
        return buffer.readi8(buf1, n1), 1
    end
}

return function() -- line: 14
    -- upvalues:
    --  [1] t (copy)

    return t
end
