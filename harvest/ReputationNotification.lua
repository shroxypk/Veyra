-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.ReputationNotification
-- Class: ModuleScript
-- bytes: 1924

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local _ = require(Modules.Factions)
local _ = require(Modules.UI.BaseNotification)
local UIEffects_m = require(Modules.UI.UIEffects)
local _ = require(Modules.Formatter)
local _ = require(Modules.Items)
local _ = require(Modules.BackpackUtils).Categories
local MaxReputation = Basic_m.MaxReputation
local _ = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Notification").Window["Side Alerts"]
local t = {}
t.__index = t

function t.new(arg1) -- line: 30
    -- upvalues:
    --  [1] t (copy)
    --  [2] MaxReputation (copy)

    local t_1 = setmetatable({}, t)
    t_1.Data = arg1
    t_1.Gui = script.Template:Clone()
    local v2 = arg1.Increment < 0 and true
    t_1.OldPercent = math.clamp((arg1.Value - arg1.Increment) / MaxReputation / 2, -0.5, 0.5)
    t_1.NewPercent = math.clamp(arg1.Value / MaxReputation / 2, -0.5, 0.5)
    local Display = t_1.Gui.Display
    Display.Header.Text = arg1.Message
    Display.Bar.Front.Size = UDim2.new(t_1.OldPercent, 0, 1, 0)
    local Front_1 = Display.Bar.Front
    Front_1.BackgroundColor3 = v2 and Color3.fromRGB(255, 74, 58) or Color3.fromRGB(120, 206, 123)

    return t_1
end

function t.Play(arg2, arg3) -- line: 70
    -- upvalues:
    --  [1] UIEffects_m (copy)

    local Gui = arg2.Gui
    Gui.Parent = arg3
    UIEffects_m.FadeOut(Gui, true)
    UIEffects_m.FadeIn(Gui)
    task.wait(0.3)
    Gui.Display.Bar.Front:TweenSize(
        UDim2.new(arg2.NewPercent, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        1,
        true
    )
    task.wait(3)
    UIEffects_m.FadeOut(Gui)
    task.wait(0.5)
    Gui:Destroy()
end

return t
