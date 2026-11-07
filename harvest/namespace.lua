-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.namespaces.namespace
-- Class: ModuleScript
-- bytes: 1918

local RunService = game:GetService("RunService")
local Values_m = require(script.Parent.Parent.replicated.values)
local _ = require(script.Parent.Parent.types)
local NamespacesDependencies_m = require(script.Parent.namespacesDependencies)
local PacketIDs_m = require(script.Parent.packetIDs)
local QueryIDs_m = require(script.Parent.queryIDs)
local v1 = if RunService:IsServer() then "server" else "client"
local v2 = 0
local v3 = 0

return function(s1: string, f1: (...any) -> ...any) -- line: 21
    -- upvalues:
    --  [1] Values_m (copy)
    --  [2] NamespacesDependencies_m (copy)
    --  [3] v1 (copy)
    --  [4] v2 (ref)
    --  [5] PacketIDs_m (copy)
    --  [6] v3 (ref)
    --  [7] QueryIDs_m (copy)

    local v4 = Values_m.access(s1)
    NamespacesDependencies_m.start(s1)
    local v5 = f1()
    local v6 = v5.packets or {}
    local v7 = v5.queries or {}
    local v8 = NamespacesDependencies_m.empty()
    local t = {}
    local t_1 = {}

    if v1 == "server" then
        local t_2 = { structs = {}, packets = {}, queries = {} }

        for key in v6 do
            v2 += 1
            t_2.packets[key] = v2
            t[key] = v6[key](v2)
            PacketIDs_m.set(v2, t[key])
        end

        for key_1 in v7 do
            v3 += 1
            t_2.queries[key_1] = v3
            t_1[key_1] = v7[key_1](v3)
            QueryIDs_m.set(v3, t_1[key_1])
        end

        for key_2, val in v8 do
            t_2.structs[key_2] = val
        end

        v4:write(t_2)
    elseif v1 == "client" then
        local v9 = v4:read()

        for key_3, val_1 in v6 do
            t[key_3] = val_1(v9.packets[key_3])
            PacketIDs_m.set(v9.packets[key_3], t[key_3])
        end

        for key_4, val_2 in v7 do
            t_1[key_4] = val_2(v9.queries[key_4])
            QueryIDs_m.set(v9.queries[key_4], t_1[key_4])
        end
    end

    return { packets = t, queries = t_1 }
end
