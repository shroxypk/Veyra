-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TraitInfo.Misc
-- Class: ModuleScript
-- bytes: 3030

local t = {}
local t_1 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "All physical attacks have +5% more PEN.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_2 = {}
t_2.Stat = { Strength = 20 }
t_2.Points = 4
t_1.Required = t_2
t_1.Restrictions = {}
t["Reinforced Blade"] = t_1
local t_4 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "You lose 40% less items on death.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_5 = {}
t_5.Stat = { Level = 21 }
t_5.Points = 3
t_4.Required = t_5
t_4.Restrictions = {}
t["Pick-Me-Up"] = t_4
local t_7 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your misdirect now deals 20% more damage.",
    Type = "Trait",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_8 = {}
t_8.Stat = { Strength = 25 }
t_8.Points = 3
t_7.Required = t_8
t_7.Restrictions = {}
t["Liver Shot"] = t_7
local t_10 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Landing a misdirect now grants a brief speed boost.",
    Type = "Trait",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_11 = {}
t_11.Stat = { Strength = 20, Agility = 10 }
t_11.Points = 3
t_10.Required = t_11
t_10.Restrictions = {}
t["Follow Through"] = t_10
local t_13 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "When below 25%, deal 10% more damage.",
    Required = nil,
    Restrictions = nil
}
local t_14 = {}
t_14.Stat = { Vitality = 25, Strength = 10 }
t_14.Points = 4
t_13.Required = t_14
t_13.Restrictions = {}
t["Survivor's Fury"] = t_13
local t_16 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "When below 25%, incoming damage is reduced by 10%.",
    Required = nil,
    Restrictions = nil
}
local t_17 = {}
t_17.Stat = { Vitality = 30 }
t_17.Points = 4
t_16.Required = t_17
t_16.Restrictions = {}
t["Hyper Adrenaline"] = t_16
local t_19 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Blockbreaking an opponent grants +15% Physical PEN for 4 seconds.",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_20 = {}
t_20.Stat = { Strength = 30 }
t_20.Points = 4
t_19.Required = t_20
t_19.Restrictions = {}
t.Overflow = t_19
local t_22 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Increases your carry weight by 10.",
    Type = "Trait",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_23 = {}
t_23.Stat = { Strength = 15 }
t_23.Points = 3
t_22.Required = t_23
t_22.Restrictions = {}
t["Pack Mule"] = t_22

return t
