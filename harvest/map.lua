-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.map
-- Class: ModuleScript
-- bytes: 1182

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local U16 = BufferWriter_m.u16

return function(arg1, arg2) -- line: 7
    -- upvalues:
    --  [1] U16 (copy)

    local t = { read = nil, write = nil }

    function t.read(buf1: buffer, n1: number) -- line: 16
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local t_1 = {}
        local v1 = n1
        local buf = buffer.readu16(buf1, v1)
        v1 += 2

        for _ = 1, buf do
            local v2, v3 = arg1.read(buf1, v1)
            v1 += v3
            local v4, v5 = arg2.read(buf1, v1)
            v1 += v5
            t_1[v2] = v4
        end

        return t_1, v1 - n1
    end

    local Write = arg1.write
    local Write_1 = arg2.write

    function t.write(arg3) -- line: 38
        -- upvalues:
        --  [1] U16 (ref)
        --  [2] Write (copy)
        --  [3] Write_1 (copy)

        local v6 = 0

        for _ in arg3 do
            v6 += 1
        end

        U16(v6)

        for key_1, val in arg3 do
            Write(key_1)
            Write_1(val)
        end
    end

    return t
end
