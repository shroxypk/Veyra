-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.color3
-- Class: ModuleScript
-- bytes: 734

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = { write = nil, read = nil }
local Alloc = BufferWriter_m.alloc
local U8NoAlloc = BufferWriter_m.u8NoAlloc

function t.write(u1: Color3) -- line: 8
    -- upvalues:
    --  [1] Alloc (copy)
    --  [2] U8NoAlloc (copy)

    Alloc(3)
    U8NoAlloc(u1.R * 255)
    U8NoAlloc(u1.G * 255)
    U8NoAlloc(u1.B * 255)
end

function t.read(buf1: buffer, n1: number) -- line: 14
    return Color3.fromRGB(
        buffer.readu8(buf1, n1),
        buffer.readu8(buf1, n1 + 1),
        (buffer.readu8(buf1, n1 + 2))
    ), 3
end

return function() -- line: 19
    -- upvalues:
    --  [1] t (copy)

    return t
end
