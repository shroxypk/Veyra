-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.process.bufferWriter
-- Class: ModuleScript
-- bytes: 5467

local _: any = require(script.Parent.Parent.types)
local v1: any = nil
local v2: number = nil
local v3: number = nil
local v4: buffer = nil
local References: table = nil

local function alloc(n1: number) -- line: 27
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if not (v3 + n1 >= v2) then
        return
    end

    v2 = math.floor(v2 * 1.5)
    local buf = buffer.create(v2)
    buffer.copy(buf, 0, v4)
    v4 = buf
end

local function dyn_alloc(n2: number) -- line: 40
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    while true do
        if not (v3 + n2 >= v2) then
            break
        end

        v2 = math.floor(v2 * 1.5)
    end

    local buf_1: any = buffer.create(v2)
    buffer.copy(buf_1, 0, v4)
    v4 = buf_1
end

local t: any = { alloc = alloc, dyn_alloc = dyn_alloc }

function t.u8NoAlloc(n3: number) -- line: 56
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] v3 (ref)

    buffer.writeu8(v4, v3, n3)
    v3 += 1
end

function t.u8(n4: number) -- line: 61
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 1 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_2 = buffer.create(v2)
        buffer.copy(buf_2, 0, v4)
        v4 = buf_2
    end

    buffer.writeu8(v4, v3, n4)
    v3 += 1
end

function t.i8(n5: number) -- line: 67
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 1 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_3 = buffer.create(v2)
        buffer.copy(buf_3, 0, v4)
        v4 = buf_3
    end

    buffer.writei8(v4, v3, n5)
    v3 += 1
end

function t.reference(arg1) -- line: 74
    -- upvalues:
    --  [1] References (ref)
    --  [2] v4 (ref)
    --  [3] v3 (ref)

    table.insert(References, arg1)
    buffer.writeu8(v4, v3, #References)
    v3 += 1
end

function t.u16(n6: number) -- line: 82
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 2 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_4 = buffer.create(v2)
        buffer.copy(buf_4, 0, v4)
        v4 = buf_4
    end

    buffer.writeu16(v4, v3, n6)
    v3 += 2
end

function t.i16(n7: number) -- line: 88
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 2 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_5 = buffer.create(v2)
        buffer.copy(buf_5, 0, v4)
        v4 = buf_5
    end

    buffer.writeu16(v4, v3, n7)
    v3 += 2
end

function t.u32(n8: number) -- line: 94
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 4 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_6 = buffer.create(v2)
        buffer.copy(buf_6, 0, v4)
        v4 = buf_6
    end

    buffer.writeu32(v4, v3, n8)
    v3 += 4
end

function t.writestring(s1: string) -- line: 100
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] v3 (ref)

    buffer.writestring(v4, v3, s1)
    v3 = v3 + string.len(s1)
end

function t.i32(n9: number) -- line: 105
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 4 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_7 = buffer.create(v2)
        buffer.copy(buf_7, 0, v4)
        v4 = buf_7
    end

    buffer.writei32(v4, v3, n9)
    v3 += 4
end

function t.f32NoAlloc(n10: number) -- line: 111
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] v3 (ref)

    buffer.writef32(v4, v3, n10)
    v3 += 4
end

function t.f64NoAlloc(n11: number) -- line: 116
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] v3 (ref)

    buffer.writef64(v4, v3, n11)
    v3 += 4
end

function t.f32(n12: number) -- line: 121
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 4 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_8 = buffer.create(v2)
        buffer.copy(buf_8, 0, v4)
        v4 = buf_8
    end

    buffer.writef32(v4, v3, n12)
    v3 += 4
end

function t.f64(n13: number) -- line: 127
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 8 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_9 = buffer.create(v2)
        buffer.copy(buf_9, 0, v4)
        v4 = buf_9
    end

    buffer.writef64(v4, v3, n13)
    v3 += 8
end

function t.copy(arg2) -- line: 133
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] v3 (ref)

    buffer.copy(v4, v3, arg2)
    v3 = v3 + buffer.len(arg2)
end

function t.bool(b1: boolean) -- line: 138
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v2 (ref)
    --  [3] v4 (ref)

    if v3 + 1 >= v2 then
        v2 = math.floor(v2 * 1.5)
        local buf_10 = buffer.create(v2)
        buffer.copy(buf_10, 0, v4)
        v4 = buf_10
    end

    local v8 = if not b1 then 0 else 1
    buffer.writeu8(v4, v3, v8)
    v3 += 1
end

function t.load(arg3) -- line: 144
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v2 (ref)
    --  [3] v3 (ref)
    --  [4] References (ref)
    --  [5] v4 (ref)

    v1 = arg3
    v2 = arg3.size
    v3 = arg3.cursor
    References = arg3.references
    v4 = arg3.buff
end

function t.export() -- line: 152
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v2 (ref)
    --  [3] v3 (ref)
    --  [4] References (ref)
    --  [5] v4 (ref)

    v1.size = v2
    v1.cursor = v3
    v1.references = References
    v1.buff = v4

    return v1
end

return t
