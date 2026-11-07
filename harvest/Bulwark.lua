-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TraitInfo.Bulwark
-- Class: ModuleScript
-- bytes: 2204

local t = {}
local t_1 = {
    Class = "Bulwark",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Gain 5% damage reduction towards physical-based attacks.",
    Type = "Trait",
    Image = "",
    Required = nil,
    Restrictions = nil
}
local t_2 = { Quest = "Aric" }
t_2.Stat = { Vitality = 20 }
t_2.Points = 9
t_1.Required = t_2
t_1.Restrictions = {}
t["Tempered Body"] = t_1
local t_4 = {
    Class = "Bulwark",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "The time it takes for you to recover after being knocked is cut in half.",
    Type = "Trait",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_5 = {}
t_5.Stat = { Vitality = 10 }
t_5.Points = 4
t_4.Required = t_5
t_4.Restrictions = {}
t["Rapid Recovery"] = t_4
local t_7 = {
    Class = "Bulwark",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Upon being block broken, gain 10% damage resistance for a short amount of time.",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_8 = {}
t_8.Stat = { Endurance = 20, Vitality = 25 }
t_8.Points = 3
t_7.Required = t_8
t_7.Restrictions = {}
t["Strong Core"] = t_7
local t_10 = {
    Class = "Bulwark",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your body adapts to impacts, reducing ragdoll effects. The duration of all ragdoll effects are decreased by 15%.",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_11 = {}
t_11.Prereq = { ["Rapid Recovery"] = 0 }
t_11.Stat = { Vitality = 30, Endurance = 15 }
t_11.Points = 3
t_10.Required = t_11
t_10.Restrictions = {}
t["Iron Rebound"] = t_10
local t_14 = {
    Class = "Bulwark",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "After being ragdolled, gain immunity to ragdoll effects for a short duration. (40 second cooldown)",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_15 = {}
t_15.Prereq = { ["Iron Rebound"] = 0 }
t_15.Points = 3
t_14.Required = t_15
t_14.Restrictions = {}
t["Unyielding Bastion"] = t_14

return t
