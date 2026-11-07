-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.array
-- Class: ModuleScript
-- bytes: 962

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local U16 = BufferWriter_m.u16

return function(arg1) -- line: 9
    -- upvalues:
    --  [1] U16 (copy)

    local t = { read = nil, write = nil }
    local Read = arg1.read

    function t.read(buf1: buffer, n1: number) -- line: 14
        -- upvalues:
        --  [1] Read (copy)

        local buf = buffer.readu16(buf1, n1)
        local v1 = n1 + 2
        local t_1 = {}

        for _ = 1, buf do
            local v2, v3 = Read(buf1, v1)
            table.insert(t_1, v2)
            v1 += v3
        end

        return t_1, v1 - n1
    end

    local Write = arg1.write

    function t.write(arg2) -- line: 28
        -- upvalues:
        --  [1] U16 (ref)
        --  [2] Write (copy)

        local v4 = #arg2
        U16(v4)

        for index_1 = 1, v4 do
            Write(arg2[index_1])
        end
    end

    return t
end
