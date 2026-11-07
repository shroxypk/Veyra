-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.struct
-- Class: ModuleScript
-- bytes: 1724

local RunService = game:GetService("RunService")
local NamespacesDependencies_m = require(script.Parent.Parent.namespaces.namespacesDependencies)
local Values_m = require(script.Parent.Parent.replicated.values)
local v1 = require(script.Parent.Parent.types)
v1 = if RunService:IsServer() then "server" else "client"

return function(t1: table) -- line: 13
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] NamespacesDependencies_m (copy)
    --  [3] Values_m (copy)

    local t = {}
    local t_1 = {}

    if v1 == "server" then
        local t_2 = {}
        local v2 = 0

        for key in t1 do
            v2 += 1
            t_2[key] = v2
            t[v2] = t1[key]
            t_1[v2] = key
        end

        NamespacesDependencies_m.add(t_2)
    elseif v1 == "client" then
        NamespacesDependencies_m.add(t1)

        for key_1, val in Values_m.access((NamespacesDependencies_m.currentName())):read().structs[NamespacesDependencies_m.currentLength()] do
            t[val] = t1[key_1]
            t_1[val] = key_1
        end
    end

    local t_3 = { read = nil, write = nil }

    function t_3.read(arg1, arg2) -- line: 75
        -- upvalues:
        --  [1] t1 (copy)
        --  [2] t (copy)
        --  [3] t_1 (copy)

        local t_4 = table.clone(t1)
        local v4 = arg2

        for key_2, val_1 in t do
            local v5, v6 = val_1.read(arg1, v4)
            t_4[t_1[key_2]] = v5
            v4 += v6
        end

        return t_4, v4 - arg2
    end

    function t_3.write(arg3) -- line: 90
        -- upvalues:
        --  [1] t (copy)
        --  [2] t_1 (copy)

        for key_3, val_2 in t do
            val_2.write(arg3[t_1[key_3]])
        end
    end

    return t_3
end
