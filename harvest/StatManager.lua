-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.StatManager
-- Class: ModuleScript
-- bytes: 2379

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("ServerStorage")
local _ = ReplicatedStorage.Modules
local t = setmetatable({}, { __mode = "k" })
local t_1 = {}
t_1.__index = t_1

function t_1.new(arg1) -- line: 15
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)

    if not arg1 then
        return
    end

    if t[arg1] then
        return t[arg1]
    end

    local PlayerFolder = arg1:WaitForChild("PlayerFolder")

    if not PlayerFolder then
        return
    end

    local t_3 = setmetatable({ Player = arg1, Data = PlayerFolder, Connections = {} }, t_1)
    t_3.Connections.AncestryChanged = arg1.AncestryChanged:Connect(function(_, arg3) -- line: 33
        -- upvalues:
        --  [1] t_3 (copy)

        if not arg3 then
            t_3:Destroy()
        end
    end)
    t[arg1] = t_3

    return t_3
end

function t_1.get(arg4) -- line: 44
    -- upvalues:
    --  [1] t (copy)

    return t[arg4]
end

function t_1.require(arg5) -- line: 48
    -- upvalues:
    --  [1] t_1 (copy)

    return t_1.get(arg5) or t_1.new(arg5)
end

function t_1.GetStat(arg6, arg7) -- line: 52
    if not arg7 then
        return
    end

    return arg6.Data:GetAttribute(arg7)
end

function t_1.GetAllStats(arg8) -- line: 58
    return arg8.Data:GetAttributes()
end

function t_1.OnStatChanged(arg9, arg10, arg11) -- line: 62
    if not arg10 then
        return
    end

    local Data = arg9.Data

    return Data:GetAttributeChangedSignal(arg10):Connect(function() -- line: 67
        -- upvalues:
        --  [1] arg11 (copy)
        --  [2] Data (copy)
        --  [3] arg10 (copy)

        arg11(Data:GetAttribute(arg10))
    end)
end

function t_1.Destroy(arg12) -- line: 72
    -- upvalues:
    --  [1] t (copy)

    for _, val in arg12.Connections do
        val:Disconnect()
    end

    table.clear(arg12.Connections)
    t[arg12.Player] = nil
end

function t_1.SetStat(arg13, arg14, arg15) -- line: 83
    if not arg14 then
        return
    end

    arg13.Data:SetAttribute(arg14, arg15)
end

function t_1.IncrementStat(arg16, arg17, arg18) -- line: 89
    if not arg17 then
        return
    end

    arg16:SetStat(arg17, arg16:GetStat(arg17) + arg18)
end

return t_1
