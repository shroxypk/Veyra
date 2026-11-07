-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Packages.GoodSignal
-- Class: ModuleScript
-- bytes: 3494

local v1 = nil

local function acquireRunnerThreadAndCallEventHandler(arg1, ...) -- line: 34
    -- upvalues:
    --  [1] v1 (ref)

    local v2 = v1
    v1 = nil
    arg1(...)
    v1 = v2
end

local function runEventHandlerInFreeThread() -- line: 45
    -- upvalues:
    --  [1] acquireRunnerThreadAndCallEventHandler (copy)

    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local t = {}
t.__index = t

function t.new(arg2, arg3) -- line: 60
    -- upvalues:
    --  [1] t (copy)

    return (setmetatable({ _connected = true, _signal = arg2, _fn = arg3, _next = false }, t))
end

function t.Disconnect(arg4) -- line: 69
    arg4._connected = false

    if arg4._signal._handlerListHead == arg4 then
        arg4._signal._handlerListHead = arg4._next

        return
    end

    local v4 = arg4._signal._handlerListHead

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

t.Destroy = t.Disconnect
setmetatable(t, {
    __index = function(_, arg6) --[[ __index ]] -- line: 92
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(arg6))), 2)
    end,
    __newindex = function(_, arg8, _) --[[ __newindex ]] -- line: 95
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(arg8))), 2)
    end
})
local t_3 = {}
t_3.__index = t_3

function t_3.new() -- line: 104
    -- upvalues:
    --  [1] t_3 (copy)

    return (setmetatable({ _handlerListHead = false }, t_3))
end

function t_3.Connect(arg10, arg11) -- line: 110
    -- upvalues:
    --  [1] t (copy)

    local v5 = t.new(arg10, arg11)

    if arg10._handlerListHead then
        v5._next = arg10._handlerListHead
        arg10._handlerListHead = v5

        return v5
    end

    arg10._handlerListHead = v5

    return v5
end

function t_3.DisconnectAll(arg12) -- line: 123
    arg12._handlerListHead = false
end

t_3.Destroy = t_3.DisconnectAll

function t_3.Fire(arg13, ...) -- line: 132
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] runEventHandlerInFreeThread (copy)

    local v6 = arg13._handlerListHead

    while v6 do
        if v6._connected then
            if not v1 then
                v1 = coroutine.create(runEventHandlerInFreeThread)
                coroutine.resume(v1)
            end

            task.spawn(v1, v6._fn, ...)
        end

        v6 = v6._next
    end
end

function t_3.Wait(arg14) -- line: 149
    local thread = coroutine.running()
    local v7 = nil
    v7 = arg14:Connect(function(...) -- line: 152
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] thread (copy)

        v7:Disconnect()
        task.spawn(thread, ...)
    end)

    return coroutine.yield()
end

function t_3.Once(arg15, arg16) -- line: 161
    local v8 = nil
    v8 = arg15:Connect(function(...) -- line: 163
        -- upvalues:
        --  [1] v8 (ref)
        --  [2] arg16 (copy)

        if v8._connected then
            v8:Disconnect()
        end

        arg16(...)
    end)

    return v8
end

setmetatable(t_3, {
    __index = function(_, arg18) --[[ __index ]] -- line: 174
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(arg18))), 2)
    end,
    __newindex = function(_, arg20, _) --[[ __newindex ]] -- line: 177
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(arg20))), 2)
    end
})

return t_3
