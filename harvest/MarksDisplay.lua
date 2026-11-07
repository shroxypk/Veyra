-- Decompiled with Veyra harvester
-- Instance: StarterGui.AllianceUI.Clans.CreateFrame.Purchase.Marks.Amount.MarksDisplay
-- Class: LocalScript
-- bytes: 313

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local Modules = game:GetService("ReplicatedStorage").Modules
local Formatter_m = require(Modules.Formatter)
local Basic_m = require(Modules.Basic)
script.Parent.Text = Formatter_m.addCommas(Basic_m.CreateClanFee)
