-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TraitInfo.Combat Warrior
-- Class: ModuleScript
-- bytes: 2019

local t = {}
local t_1 = {
    Class = "Combat Warrior",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your aerial M2 now block breaks.",
    Image = _G.misc_icon,
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_2 = {}
t_2.Stat = { Level = 30 }
t_2.Points = 9
t_2.Marks = 50
t_1.Required = t_2
t_1.Restrictions = {}
t["Critical Aerial"] = t_1
local t_4 = {
    Class = "Combat Warrior",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Landing a misdirect temporarily slows the target's movement (15s cooldown).",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_5 = {}
t_5.Stat = { Strength = 35 }
t_5.Points = 4
t_4.Required = t_5
t_4.Restrictions = {}
t["Crippling Fakeout"] = t_4
local t_7 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Block breaking an enemy decreases your resolve by 50%.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_8 = {}
t_8.Stat = { Strength = 20 }
t_8.Points = 3
t_7.Required = t_8
t_7.Restrictions = {}
t["Exhaustion Blow"] = t_7
local t_10 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Block breaking an enemy now resets their resolve to 25%.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_11 = {}
t_11.Stat = { Strength = 20, Endurance = 40 }
t_11.Points = 3
t_10.Required = t_11
t_10.Restrictions = {}
t["Exhaustion Strike"] = t_10
local t_13 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "When below 35% health, deal more posture damage.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_14 = {}
t_14.Stat = { Strength = 20, Endurance = 15 }
t_14.Points = 3
t_13.Required = t_14
t_13.Restrictions = {}
t["Panic Attack"] = t_13

return t
