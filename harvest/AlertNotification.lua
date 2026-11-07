-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.AlertNotification
-- Class: ModuleScript
-- bytes: 801

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local BaseNotification_m = require(Modules.UI.BaseNotification)
local _ = require(Modules.UI.UIEffects)
local t = {}
local MiddleAlerts = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Notification").Window["Middle Alerts"]

function t.new(arg1, arg2) -- line: 19
    -- upvalues:
    --  [1] BaseNotification_m (copy)
    --  [2] MiddleAlerts (copy)

    local v2 = BaseNotification_m.new(script.Alert, MiddleAlerts, 4)
    v2.Gui.Display.Label.Text = `{arg1}`

    if arg2 then
        arg2:Play()
    end

    return v2
end

return t
