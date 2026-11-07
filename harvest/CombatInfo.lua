-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.CombatInfo
-- Class: ModuleScript
-- bytes: 1325

local t = {}
local t_1 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 20,
    Description = "Surge forward in a quick burst of movement.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Combat",
    Cooldown = 10,
    WindUp = 0,
    Type = "Combat",
    Image = "",
    Required = nil
}
local t_2 = { Insight = 30, Points = 4 }
t_2.Stat = { Agility = 20 }
t_1.Required = t_2
t.Rush = t_1
local t_4 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 30,
    Description = "When struck in a defensive stance, release a burst and gain magic and physical resistance for a set duration.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Combat",
    Cooldown = 15,
    WindUp = 0,
    Type = "Combat",
    Image = "",
    Required = nil
}
local t_5 = { Insight = 30, Points = 4 }
t_5.Stat = { Strength = 20, Endurance = 25 }
t_4.Required = t_5
t["En Garde"] = t_4
local t_7 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 10,
    Description = "Dash forward and deliver a flying kick.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Combat",
    Cooldown = 8,
    WindUp = 0,
    Type = "Combat",
    Image = "",
    Required = nil
}
local t_8 = { Insight = 30, Points = 4 }
t_8.Stat = { Strength = 25 }
t_7.Required = t_8
t["Meteor Kick"] = t_7

return t
