-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone.Signal
-- Class: ModuleScript
-- bytes: 3556

local v1 = nil

local function acquireRunnerThreadAndCallEventHandler(arg1, ...) -- line: 34
    -- upvalues:
    --  [1] v1 (ref)

    local v2 = v1
    v1 = nil
    arg1(...)
    v1 = v2
end

local function runEventHandlerInFreeThread(...) -- line: 45
    -- upvalues:
    --  [1] acquireRunnerThreadAndCallEventHandler (copy)

    acquireRunnerThreadAndCallEventHandler(...)

    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local t = {}
t.__index = t

function t.new(arg2, arg3) -- line: 56
    -- upvalues:
    --  [1] t (copy)

    return (setmetatable({ _connected = true, _signal = arg2, _fn = arg3, _next = false }, t))
end

function t.Disconnect(arg4) -- line: 65
    assert(arg4._connected, "Can't disconnect a connection twice.", 2)
    arg4._connected = false
    local Signal = arg4._signal

    if Signal._handlerListHead == arg4 then
        Signal._handlerListHead = arg4._next
    else
        local v4 = Signal._handlerListHead

        while v4 do
            if v4._next == arg4 then
                break
            end

            v4 = v4._next
        end

        if v4 then
            v4._next = arg4._next
        end
    end

    if Signal.connectionsChanged then
        Signal.totalConnections -= 1
        Signal.connectionsChanged:Fire(-1)
    end
end

setmetatable(t, {
    __index = function(_, arg6) --[[ __index ]] -- line: 94
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(arg6))), 2)
    end,
    __newindex = function(_, arg8, _) --[[ __newindex ]] -- line: 97
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(arg8))), 2)
    end
})
local t_3 = {}
t_3.__index = t_3

function t_3.new(arg10) -- line: 106
    -- upvalues:
    --  [1] t_3 (copy)

    local t_4 = setmetatable({ _handlerListHead = false }, t_3)

    if arg10 then
        t_4.totalConnections = 0
        t_4.connectionsChanged = t_3.new()
    end

    return t_4
end

function t_3.Connect(arg11, arg12) -- line: 117
    -- upvalues:
    --  [1] t (copy)

    local v5 = t.new(arg11, arg12)

    if arg11._handlerListHead then
        v5._next = arg11._handlerListHead
        arg11._handlerListHead = v5
    else
        arg11._handlerListHead = v5
    end

    if arg11.connectionsChanged then
        arg11.totalConnections += 1
        arg11.connectionsChanged:Fire(1)
    end

    return v5
end

function t_3.DisconnectAll(arg13) -- line: 135
    arg13._handlerListHead = false

    if arg13.connectionsChanged then
        arg13.connectionsChanged:Fire(-arg13.totalConnections)
        arg13.connectionsChanged:Destroy()
        arg13.connectionsChanged = nil
        arg13.totalConnections = 0
    end
end

t_3.Destroy = t_3.DisconnectAll
t_3.destroy = t_3.DisconnectAll

function t_3.Fire(arg14, ...) -- line: 152
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] runEventHandlerInFreeThread (copy)

    local v7 = arg14._handlerListHead

    while v7 do
        if v7._connected then
            if not v1 then
                v1 = coroutine.create(runEventHandlerInFreeThread)
            end

            task.spawn(v1, v7._fn, ...)
        end

        v7 = v7._next
    end
end

function t_3.Wait(arg15) -- line: 167
    local thread = coroutine.running()
    local v8 = nil
    v8 = arg15:Connect(function(...) -- line: 170
        -- upvalues:
        --  [1] v8 (ref)
        --  [2] thread (copy)

        v8:Disconnect()
        task.spawn(thread, ...)
    end)

    return coroutine.yield()
end

return t_3
