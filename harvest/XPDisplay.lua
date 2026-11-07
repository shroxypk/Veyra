-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.XPBar.XPDisplay
-- Class: LocalScript
-- bytes: 971

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local Modules = game:GetService("ReplicatedStorage").Modules
local StatManager_m = require(Modules.StatManager)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Parent = script.Parent

local function Display() -- line: 16
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] Parent (copy)

    local XP = v4:GetStat("XP")
    local MXP = v4:GetStat("MXP")
    local v5 = math.floor(XP / MXP * 100)
    local Level = Parent.Level
    local Level_1 = v4:GetStat("Level")
    Level.Text = `Level {Level_1}`
    Parent.Percent.Text = `{v5}%`
    Parent.Front:TweenSize(
        UDim2.fromScale(XP / MXP, 1),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.4,
        true
    )
end

v4:OnStatChanged("Level", Display)
v4:OnStatChanged("XP", Display)
v4:OnStatChanged("MXP", Display)
Display()
