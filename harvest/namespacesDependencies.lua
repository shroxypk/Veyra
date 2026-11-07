-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.namespaces.namespacesDependencies
-- Class: ModuleScript
-- bytes: 734

local v1 = nil
local v2 = nil
local t = {}

function t.start(s1: string) -- line: 10
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v2 (ref)

    v1 = {}
    v2 = s1
end

function t.add(arg1) -- line: 15
    -- upvalues:
    --  [1] v1 (ref)

    if not v1 then
        return
    end

    table.insert(v1, arg1)
end

function t.currentLength() -- line: 23
    -- upvalues:
    --  [1] v1 (ref)

    if v1 then
        return #v1
    end

    return 0
end

function t.currentName() -- line: 27
    -- upvalues:
    --  [1] v2 (ref)

    return v2
end

function t.empty() -- line: 31
    -- upvalues:
    --  [1] v1 (ref)

    if v1 == nil then
        return {}
    end

    local v3 = v1
    v1 = nil

    return v3
end

return t
