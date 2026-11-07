-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Maid
-- Class: ModuleScript
-- bytes: 3744

local t = { ClassName = "Maid" }

function t.new() -- line: 37
    -- upvalues:
    --  [1] t (copy)

    return (setmetatable({ _tasks = {} }, t))
end

function t.isMaid(arg1) -- line: 54
    return if type(arg1) == "table" then arg1.ClassName == "Maid" else false
end

function t.__index(arg2, arg3) -- line: 73
    -- upvalues:
    --  [1] t (copy)

    if t[arg3] then
        return t[arg3]
    end

    return arg2._tasks[arg3]
end

function t.__newindex(arg4, arg5, arg6) -- line: 100
    -- upvalues:
    --  [1] t (copy)

    if t[arg5] ~= nil then
        error(("Cannot use '%s' as a Maid key"):format((tostring(arg5))), 2)
    end

    local Tasks = arg4._tasks
    local v2 = Tasks[arg5]

    if v2 == arg6 then
        return
    end

    Tasks[arg5] = arg6

    if v2 then
        if type(v2) == "function" then
            v2()

            return
        end

        if type(v2) == "thread" then
            if not (if coroutine.running() ~= v2 then pcall(function() -- line: 120
                -- upvalues:
                --  [1] v2 (copy)

                task.cancel(v2)
            end) else nil) then
                task.defer(function() -- line: 126
                    -- upvalues:
                    --  [1] v2 (copy)

                    task.cancel(v2)
                end)

                return
            end
        else
            if typeof(v2) == "RBXScriptConnection" then
                v2:Disconnect()

                return
            end

            if v2.Destroy then
                v2:Destroy()
            end
        end
    end
end

function t.Add(arg7, arg8) -- line: 144
    if not arg8 then
        error("Task cannot be false or nil", 2)
    end

    arg7[#arg7._tasks + 1] = arg8

    if type(arg8) == "table" and not arg8.Destroy then
        warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
    end

    return arg8
end

function t.GiveTask(arg9, arg10) -- line: 164
    if not arg10 then
        error("Task cannot be false or nil", 2)
    end

    local v4 = #arg9._tasks + 1
    arg9[v4] = arg10

    if type(arg10) == "table" and not arg10.Destroy then
        warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
    end

    return v4
end

function t.GivePromise(arg11, arg12) -- line: 185
    if not arg12:IsPending() then
        return arg12
    end

    local v5 = arg12.resolved(arg12)
    local v6 = arg11:GiveTask(v5)
    v5:Finally(function() -- line: 194
        -- upvalues:
        --  [1] arg11 (copy)
        --  [2] v6 (copy)

        arg11[v6] = nil
    end)

    return v5
end

function t.DoCleaning(arg13) -- line: 217
    local Tasks_1 = arg13._tasks

    for key, val in pairs(Tasks_1) do
        if typeof(val) == "RBXScriptConnection" then
            Tasks_1[key] = nil
            val:Disconnect()
        end
    end

    local v9, v10 = next(Tasks_1)

    while v10 ~= nil do
        Tasks_1[v9] = nil

        if type(v10) == "function" then
            v10()
        elseif type(v10) == "thread" then
            if not (if coroutine.running() ~= v10 then pcall(function() -- line: 237
                -- upvalues:
                --  [1] v10 (ref)

                task.cancel(v10)
            end) else nil) then
                local v12 = v10
                task.defer(function() -- line: 244
                    -- upvalues:
                    --  [1] v12 (copy)

                    task.cancel(v12)
                end)
            end
        elseif typeof(v10) == "RBXScriptConnection" then
            v10:Disconnect()
        elseif v10.Destroy then
            v10:Destroy()
        end

        v9, v10 = next(Tasks_1)
    end
end

t.Destroy = t.DoCleaning

return t
