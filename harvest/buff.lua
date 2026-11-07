-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.buff
-- Class: ModuleScript
-- bytes: 884

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = {
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 9
        local buf = buffer.readu16(buf1, n1)
        local buf_1 = buffer.create(buf)
        buffer.copy(
            buf_1,
            0,
            buf1,
            n1 + 2,
            buf
        )

        return buf_1, buf + 2
    end,
    write = nil
}
local U16 = BufferWriter_m.u16
local DynAlloc = BufferWriter_m.dyn_alloc
local Copy = BufferWriter_m.copy

function t.write(buf2: buffer) -- line: 18
    -- upvalues:
    --  [1] U16 (copy)
    --  [2] DynAlloc (copy)
    --  [3] Copy (copy)

    local buf_2 = buffer.len(buf2)
    U16(buf_2)
    DynAlloc(buf_2)
    Copy(buf2)
end

return function() -- line: 29
    -- upvalues:
    --  [1] t (copy)

    return t
end
