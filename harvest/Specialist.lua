-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TraitInfo.Specialist
-- Class: ModuleScript
-- bytes: 880

local t = {}
local t_1 = {
    Class = "Specialist",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your misdirects have a chance to align perfectly, multiplying their force into a devastating blow.",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_2 = {}
t_2.Stat = { Strength = 50 }
t_2.Points = 4
t_1.Required = t_2
t_1.Restrictions = {}
t["Blunt Alignment"] = t_1
local t_4 = {
    Class = "Specialist",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Gain 0.5% magic armor penetration for each point your intelligence exceeds vitality.",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_5 = {}
t_5.Stat = { Intelligence = 30, ["Magic Power"] = 30 }
t_5.Points = 4
t_4.Required = t_5
t_4.Restrictions = {}
t["Glass Cannon"] = t_4

return t
