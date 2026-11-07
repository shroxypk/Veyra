-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.BaseQueue
-- Class: ModuleScript
-- bytes: 2189

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = ReplicatedStorage.Modules
local t = {}
t.__index = t

function t.new(u1: userdata, n1: number?) -- line: 15
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.Type = u1
    t_1.Queue = {}
    t_1.Running = false
    t_1.Current = nil
    t_1.Active = 0
    t_1.DelayPerItem = n1 or 0.75

    return t_1
end

function t.GetStackedDuration(t1: table, n2: number) -- line: 31
    return n2 + t1.Active * t1.DelayPerItem
end

function t.Process(arg1) -- line: 37
    if arg1.Running then
        return
    end

    arg1.Running = true

    while true do
        if not (#arg1.Queue > 0) then
            break
        end

        table.remove(arg1.Queue, 1)()
    end

    arg1.Running = false
end

function t.Push(arg2, arg3) -- line: 53
    if arg2.Type == "Sequential" then
        table.insert(arg2.Queue, arg3)

        if not arg2.Running then
            task.spawn(function() -- line: 59
                -- upvalues:
                --  [1] arg2 (copy)

                arg2:Process()
            end)
        end

        return
    end

    if arg2.Type == "Stacked" then
        arg2.Active += 1
        local v2 = arg3(arg2:GetStackedDuration(4))

        if v2 and v2.Destroyed then
            v2.Destroyed:Once(function() -- line: 76
                -- upvalues:
                --  [1] arg2 (copy)

                local v3 = arg2
                v3.Active -= 1
            end)

            return
        end

        task.delay(arg2:GetStackedDuration(4), function() -- line: 82
            -- upvalues:
            --  [1] arg2 (copy)

            local v5 = arg2
            v5.Active -= 1
        end)

        return
    end

    if arg2.Type == "Replace" then
        if arg2.Current then
            arg2.Current:Destroy()
            arg2.Current = nil
        end

        arg2.Current = arg3()

        return
    end

    if arg2.Type == "Parallel" then
        task.spawn(arg3)

        return
    end
end

return t
