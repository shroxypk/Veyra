-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone.OldSignal
-- Class: ModuleScript
-- bytes: 2753

local HttpService = game:GetService("HttpService")
local t = {}
local Heartbeat = game:GetService("RunService").Heartbeat
t.__index = t
t.ClassName = "Signal"
t.totalConnections = 0

function t.new(arg1) -- line: 12
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)

    if arg1 then
        t_1.connectionsChanged = t.new()
    end

    t_1.connections = {}
    t_1.totalConnections = 0
    t_1.waiting = {}
    t_1.totalWaiting = 0

    return t_1
end

function t.Fire(arg2, ...) -- line: 30
    for _, val in pairs(arg2.connections) do
        task.spawn(val.Handler, ...)
    end

    if arg2.totalWaiting > 0 then
        local t_2 = table.pack(...)

        for key_1, _ in pairs(arg2.waiting) do
            arg2.waiting[key_1] = t_2
        end
    end
end

t.fire = t.Fire

function t.Connect(arg3, arg4) -- line: 44
    -- upvalues:
    --  [1] HttpService (copy)

    if type(arg4) ~= "function" then
        error(("connect(%s)"):format((typeof(arg4))), 2)
    end

    local v2 = HttpService:GenerateGUID(false)
    local t_3 = { Connected = true, ConnectionId = v2, Handler = arg4 }
    arg3.connections[v2] = t_3

    function t_3.Disconnect(_) -- line: 57
        -- upvalues:
        --  [1] arg3 (copy)
        --  [2] v2 (copy)
        --  [3] t_3 (copy)

        arg3.connections[v2] = nil
        t_3.Connected = false
        local v3 = arg3
        v3.totalConnections -= 1

        if arg3.connectionsChanged then
            arg3.connectionsChanged:Fire(-1)
        end
    end

    t_3.Destroy = t_3.Disconnect
    t_3.destroy = t_3.Disconnect
    t_3.disconnect = t_3.Disconnect
    arg3.totalConnections += 1

    if arg3.connectionsChanged then
        arg3.connectionsChanged:Fire(1)
    end

    return t_3
end

t.connect = t.Connect

function t.Wait(arg6) -- line: 77
    -- upvalues:
    --  [1] HttpService (copy)
    --  [2] Heartbeat (copy)

    local v4 = HttpService:GenerateGUID(false)
    arg6.waiting[v4] = true
    arg6.totalWaiting += 1

    repeat
        Heartbeat:Wait()
    until arg6.waiting[v4] ~= true

    arg6.totalWaiting -= 1
    local v5 = arg6.waiting[v4]
    arg6.waiting[v4] = nil

    return unpack(v5)
end

t.wait = t.Wait

function t.Destroy(arg7) -- line: 89
    if arg7.bindableEvent then
        arg7.bindableEvent:Destroy()
        arg7.bindableEvent = nil
    end

    if arg7.connectionsChanged then
        arg7.connectionsChanged:Fire(-arg7.totalConnections)
        arg7.connectionsChanged:Destroy()
        arg7.connectionsChanged = nil
    end

    arg7.totalConnections = 0

    for key_2, _ in pairs(arg7.connections) do
        arg7.connections[key_2] = nil
    end
end

t.destroy = t.Destroy
t.Disconnect = t.Destroy
t.disconnect = t.Destroy

return t
