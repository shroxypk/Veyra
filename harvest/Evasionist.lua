-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TraitInfo.Evasionist
-- Class: ModuleScript
-- bytes: 1621

local t = {}
local t_1 = {
    Class = "Evasionist",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Upon roll canceling, gain the ability to dodge again. Doing so increases your dodge cooldown.",
    Image = _G.agil_icon,
    Required = nil,
    Restrictions = nil
}
local t_2 = {}
t_2.Stat = { Agility = 35 }
t_2.Points = 4
t_2.Marks = 100
t_1.Required = t_2
t_1.Restrictions = {}
t["Rapid Reflex"] = t_1
local t_4 = {
    Class = "Evasionist",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your dodge frames are increased by 10%.",
    Image = _G.agil_icon,
    Required = nil,
    Restrictions = nil
}
local t_5 = {}
t_5.Stat = { Agility = 25 }
t_5.Points = 4
t_4.Required = t_5
t_4.Restrictions = {}
t["Graceful Escape"] = t_4
local t_7 = {
    Class = "Evasionist",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "When out of combat, automatically evade the first attack that hits you (120s cooldown).",
    Required = nil,
    Restrictions = nil
}
local t_8 = {}
t_8.Stat = { Agility = 50 }
t_8.Points = 13
t_7.Required = t_8
t_7.Restrictions = {}
t["Sixth Sense"] = t_7
local t_10 = {
    Class = "Evasionist",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Landing a misdirect allows you to roll again.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_11 = {}
t_11.Stat = { Agility = 15, Strength = 15 }
t_11.Points = 4
t_10.Required = t_11
t_10.Restrictions = {}
t["Deceptive Momentum"] = t_10

return t
