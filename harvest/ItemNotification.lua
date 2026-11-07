-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.ItemNotification
-- Class: ModuleScript
-- bytes: 1345

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local BaseNotification_m = require(Modules.UI.BaseNotification)
local UIEffects_m = require(Modules.UI.UIEffects)
local Formatter_m = require(Modules.Formatter)
local Items_m = require(Modules.Items)
local Categories = require(Modules.BackpackUtils).Categories
local t = {}
local SideAlerts = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Notification").Window["Side Alerts"]

function t.new(arg1, arg2, arg3) -- line: 26
    -- upvalues:
    --  [1] Formatter_m (copy)
    --  [2] Items_m (copy)
    --  [3] Categories (copy)
    --  [4] BaseNotification_m (copy)
    --  [5] SideAlerts (copy)
    --  [6] UIEffects_m (copy)

    local v2 = Formatter_m.formatItem(arg1)
    local v3, v4, v5 = Categories[Items_m:LookupItem(v2).Type].Color:ToHSV()
    local v6 = BaseNotification_m.new(script.ItemNotification, SideAlerts, 4)
    v6.Gui.Item.Text = ""
    v6.Gui.Item.TextColor3 = Color3.fromHSV(v3, math.min(v4 * 2, 1), (math.min(v5 * 2.1, 1)))
    UIEffects_m.Typewrite(v6.Gui.Item, `+ {v2} ({arg2}x)`)

    if arg3 then
        arg3:Play()
    end

    return v6
end

return t
