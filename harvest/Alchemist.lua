-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TraitInfo.Alchemist
-- Class: ModuleScript
-- bytes: 763

local t = {}
local t_1 = {
    Class = "Alchemist",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "You drink potions 25% faster.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_2 = {}
t_2.Stat = { Intelligence = 25, Agility = 10 }
t_2.Points = 3
t_1.Required = t_2
t_1.Restrictions = {}
t["Mad Alchemist"] = t_1
local t_4 = {
    Class = "Alchemist",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Potions are 20% more effective.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_5 = {}
t_5.Stat = { Intelligence = 20 }
t_5.Points = 3
t_4.Required = t_5
t_4.Restrictions = {}
t["Potion Savant"] = t_4

return t
