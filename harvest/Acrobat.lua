-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TraitInfo.Acrobat
-- Class: ModuleScript
-- bytes: 1689

local t = {}
local t_1 = {
    Class = "Acrobat",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Performing an aerial attack toward a nearby player who is airborne or moving with their back turned teleports you to them, closing the distance.",
    Type = "Trait",
    Image = _G.agil_icon,
    Required = nil,
    Restrictions = nil
}
local t_2 = {}
t_2.Stat = { Agility = 20, Level = 14 }
t_1.Required = t_2
t_1.Restrictions = {}
t["Aerial Pursuit"] = t_1
local t_4 = {
    Class = "Acrobat",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Perform a quick dash in any direction while airborne.",
    Type = "Trait",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_5 = {}
t_5.Stat = { AirDashUnlocked = 1 }
t_4.Required = t_5
t_4.Restrictions = {}
t["Air Dash"] = t_4
local t_7 = {
    Class = "Acrobat",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Increases the user's climbing ability by 15%.",
    Type = "Trait",
    Image = _G.agil_icon,
    Required = nil,
    Restrictions = nil
}
local t_8 = {}
t_8.Stat = { Agility = 10 }
t_8.Points = 4
t_7.Required = t_8
t_7.Restrictions = {}
t["Climbing Mastery"] = t_7
local t_10 = {
    Class = "Acrobat",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Damage taken from fall damage is cut in half.",
    Type = "Trait",
    Image = _G.agil_icon,
    Required = nil,
    Restrictions = nil
}
local t_11 = {}
t_11.Stat = { Agility = 15 }
t_11.Points = 4
t_10.Required = t_11
t_10.Restrictions = {}
t["Soft Landing"] = t_10

return t
