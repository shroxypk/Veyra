-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.optional
-- Class: ModuleScript
-- bytes: 870

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local Bool = BufferWriter_m.bool

return function(arg1) -- line: 6
    -- upvalues:
    --  [1] Bool (copy)

    local t = { read = nil, write = nil }
    local Read = arg1.read

    function t.read(buf1: buffer, n1: number) -- line: 16
        -- upvalues:
        --  [1] Read (copy)

        if buffer.readu8(buf1, n1) == 0 then
            return nil, 1
        end

        local v1, v2 = Read(buf1, n1 + 1)

        return v1, v2 + 1
    end

    local Write = arg1.write

    function t.write(arg2) -- line: 27
        -- upvalues:
        --  [1] Bool (ref)
        --  [2] Write (copy)

        local v3 = if arg2 == nil then false else true
        Bool(v3)

        if v3 then
            Write(arg2)
        end
    end

    return t
end
