-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Debug.uptimeServer
-- Class: ModuleScript
-- bytes: 304

local now = os.time()

return function() -- line: 3
    -- upvalues:
    --  [1] now (copy)

    local v1 = os.time() - now

    return ("%dd %dh %dm %ds"):format(
        math.floor(v1 / 86400),
        math.floor(v1 / 3600) % 24,
        math.floor(v1 / 60) % 60,
        math.floor(v1) % 60
    )
end
