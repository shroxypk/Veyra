-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.BaseNotification
-- Class: ModuleScript
-- bytes: 1519

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local UIEffects_m = require(Modules.UI.UIEffects)
local NotificationStack_m = require(Modules.UI.NotificationStack)
local t = {}
t.__index = t

function t.new(arg1, arg2, arg3) -- line: 15
    -- upvalues:
    --  [1] t (copy)
    --  [2] Services_m (copy)
    --  [3] NotificationStack_m (copy)
    --  [4] UIEffects_m (copy)

    local t_1 = setmetatable({}, t)
    t_1.Maid = Services_m.Maid.new()
    NotificationStack_m:Push()
    t_1.Duration = NotificationStack_m:GetLifetime(arg3 or 4)
    t_1.Gui = arg1:Clone()
    t_1.Gui.Parent = arg2
    UIEffects_m.FadeOut(t_1.Gui, true)
    UIEffects_m.FadeIn(t_1.Gui)
    task.delay(t_1.Duration, function() -- line: 32
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:Destroy()
    end)

    return t_1
end

function t.Destroy(arg4) -- line: 39
    -- upvalues:
    --  [1] UIEffects_m (copy)
    --  [2] NotificationStack_m (copy)

    if not arg4.Gui then
        return
    end

    UIEffects_m.FadeOut(arg4.Gui)
    task.delay(0.75, function() -- line: 46
        -- upvalues:
        --  [1] arg4 (copy)

        if arg4.Gui then
            arg4.Gui:Destroy()
            arg4.Gui = nil
        end
    end)
    NotificationStack_m:Pop()
    arg4.Maid:Destroy()
    arg4.Maid = nil
end

return t
