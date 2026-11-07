-- Decompiled with Veyra harvester
-- Instance: StarterGui.TraitUI.Main.Window.SP.Amount.SkillPointsDisplay
-- Class: LocalScript
-- bytes: 718

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local Modules = game:GetService("ReplicatedStorage").Modules
local StatManager_m = require(Modules.StatManager)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)

local function DisplaySP() -- line: 14
    -- upvalues:
    --  [1] v4 (copy)

    local Parent = script.Parent
    local SkillPoints = v4:GetStat("SkillPoints")
    Parent.Text = `Skill Points Available: {SkillPoints}`
end

v4:OnStatChanged("SkillPoints", DisplaySP)
local Parent_1 = script.Parent
local SkillPoints_1 = v4:GetStat("SkillPoints")
Parent_1.Text = `Skill Points Available: {SkillPoints_1}`
