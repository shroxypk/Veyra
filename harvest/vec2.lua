-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.vec2
-- Class: ModuleScript
-- bytes: 660

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = {
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 12
        return Vector2.new(buffer.readf32(buf1, n1), (buffer.readf32(buf1, n1 + 4))), 8
    end,
    write = nil
}
local Alloc = BufferWriter_m.alloc
local F32NoAlloc = BufferWriter_m.f32NoAlloc

function t.write(u1: Vector2) -- line: 16
    -- upvalues:
    --  [1] Alloc (copy)
    --  [2] F32NoAlloc (copy)

    Alloc(8)
    F32NoAlloc(u1.X)
    F32NoAlloc(u1.Y)
end

return function() -- line: 23
    -- upvalues:
    --  [1] t (copy)

    return t
end
