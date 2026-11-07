-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.vec3
-- Class: ModuleScript
-- bytes: 800

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = {
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 11
        local buf = buffer.readf32(buf1, n1)
        local buf_1 = buffer.readf32(buf1, n1 + 4)
        local buf_2 = buffer.readf32(buf1, n1 + 8)

        return Vector3.new(buf, buf_1, buf_2), 12
    end,
    write = nil
}
local Alloc = BufferWriter_m.alloc
local F32NoAlloc = BufferWriter_m.f32NoAlloc

function t.write(vec1: Vector3) -- line: 15
    -- upvalues:
    --  [1] Alloc (copy)
    --  [2] F32NoAlloc (copy)

    Alloc(12)
    F32NoAlloc(vec1.X)
    F32NoAlloc(vec1.Y)
    F32NoAlloc(vec1.Z)
end

return function() -- line: 23
    -- upvalues:
    --  [1] t (copy)

    return t
end
