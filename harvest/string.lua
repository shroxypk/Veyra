-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.string
-- Class: ModuleScript
-- bytes: 769

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = {
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 11
        local buf = buffer.readu16(buf1, n1)

        return buffer.readstring(buf1, n1 + 2, buf), buf + 2
    end,
    write = nil
}
local U16 = BufferWriter_m.u16
local DynAlloc = BufferWriter_m.dyn_alloc
local Writestring = BufferWriter_m.writestring

function t.write(s1: string) -- line: 16
    -- upvalues:
    --  [1] U16 (copy)
    --  [2] DynAlloc (copy)
    --  [3] Writestring (copy)

    local v1 = string.len(s1)
    U16(v1)
    DynAlloc(v1)
    Writestring(s1)
end

return function() -- line: 25
    -- upvalues:
    --  [1] t (copy)

    return t
end
