-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.cframe
-- Class: ModuleScript
-- bytes: 1203

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = {
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 8
        local buf = buffer.readf32(buf1, n1)
        local buf_1 = buffer.readf32(buf1, n1 + 4)
        local buf_2 = buffer.readf32(buf1, n1 + 8)
        local buf_3 = buffer.readf32(buf1, n1 + 12)
        local buf_4 = buffer.readf32(buf1, n1 + 16)
        local buf_5 = buffer.readf32(buf1, n1 + 20)

        return CFrame.Angles(buf_3, buf_4, buf_5) + Vector3.new(buf, buf_1, buf_2), 24
    end,
    write = nil
}
local Alloc = BufferWriter_m.alloc
local F32NoAlloc = BufferWriter_m.f32NoAlloc

function t.write(u1: CFrame) -- line: 18
    -- upvalues:
    --  [1] Alloc (copy)
    --  [2] F32NoAlloc (copy)

    local X = u1.X
    local Y = u1.Y
    local Z = u1.Z
    local v1, v2 = u1:ToAxisAngle()
    v1 *= v2
    local X_1 = v1.X
    local Y_1 = v1.Y
    local Z_1 = v1.Z
    Alloc(24)
    F32NoAlloc(X)
    F32NoAlloc(Y)
    F32NoAlloc(Z)
    F32NoAlloc(X_1)
    F32NoAlloc(Y_1)
    F32NoAlloc(Z_1)
end

return function() -- line: 36
    -- upvalues:
    --  [1] t (copy)

    return t
end
