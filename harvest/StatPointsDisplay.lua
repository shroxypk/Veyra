-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.Stats.F1.StatPoints.Amount.StatPointsDisplay
-- Class: LocalScript
-- bytes: 581

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local Modules = game:GetService("ReplicatedStorage").Modules
local StatManager_m = require(Modules.StatManager)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)

function DisplaySP() -- line: 14
    -- upvalues:
    --  [1] v4 (copy)

    local Parent = script.Parent
    local StatPoints = v4:GetStat("StatPoints")
    Parent.Text = `{StatPoints} Stat Points Available`
end

v4:OnStatChanged("StatPoints", DisplaySP)
DisplaySP()
