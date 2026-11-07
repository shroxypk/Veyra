-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.FlourishNotification
-- Class: ModuleScript
-- bytes: 948

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local UIEffects_m = require(ReplicatedStorage.Modules.UI.UIEffects)
local t = {}
t.__index = t

function t.new(arg1, arg2) -- line: 18
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.Gui = script.Flourish:Clone()
    t_1.Sound = arg2
    t_1.Gui.Label.Text = ""
    t_1.Text = arg1

    return t_1
end

function t.Play(arg3, arg4) -- line: 29
    -- upvalues:
    --  [1] UIEffects_m (copy)

    local Gui = arg3.Gui
    Gui.Parent = arg4
    UIEffects_m.FadeOut(Gui, true)
    UIEffects_m.FadeIn(Gui)
    UIEffects_m.Typewrite(Gui.Label, `{arg3.Text}`)

    if arg3.Sound then
        arg3.Sound:Play()
    end

    task.wait(3)
    UIEffects_m.FadeOut(Gui)
    task.wait(0.5)
    Gui:Destroy()
end

return t
