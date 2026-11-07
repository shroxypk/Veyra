-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.WeaponInfo
-- Class: ModuleScript
-- bytes: 4661

local t = {}
local t_1 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 20,
    Description = "Unleash a flurry of rapid jabs at your foe, dealing multiple hits of damage.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Weapon",
    Cooldown = 8,
    WindUp = 0,
    Type = { "Rapier" },
    Image = _G.weapon_icon,
    Required = { Points = 9, Marks = 1000, Proficiency = { Type = "Light", Amount = 4 } },
    Restrictions = {}
}
t["Piercing Flurry"] = t_1
local t_3 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 20,
    Description = "Soaring, weapon in hand, shattering the ground below.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Weapon",
    Cooldown = 8,
    WindUp = 0,
    Type = { "Greatsword", "Greataxe" },
    Image = _G.weapon_icon,
    Required = { Points = 9, Marks = 1000, Proficiency = { Type = "Heavy", Amount = 8 } },
    Restrictions = {}
}
t["Vertical Strike"] = t_3
local t_5 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 20,
    Description = "Spinning like a hurricane, cutting through all foes.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Weapon",
    Cooldown = 8,
    WindUp = 0,
    Type = { "Greatsword", "Greataxe" },
    Image = _G.weapon_icon,
    Required = { Points = 9, Marks = 1000, Proficiency = { Type = "Heavy", Amount = 4 } },
    Restrictions = {}
}
t["Relentless Rush"] = t_5
local t_7 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 25,
    Description = "Heave your weapon in one mighty sweep, carving through everything in its path.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Weapon",
    Cooldown = 10,
    WindUp = 0,
    Type = { "Greatsword", "Greataxe" },
    Image = _G.weapon_icon,
    Required = { Points = 9, Marks = 200, Proficiency = { Type = "Heavy", Amount = 6 } },
    Restrictions = {}
}
t["Rending Slash"] = t_7
local t_9 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 25,
    Description = "Charge forward with lightning speed and send your foes reeling.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Weapon",
    Cooldown = 12,
    WindUp = 0,
    Type = { "Combat" },
    Image = _G.weapon_icon,
    Required = { Points = 10, Marks = 1000, Proficiency = { Type = "Light", Amount = 5 } },
    Restrictions = {}
}
t["Vault Breaker"] = t_9
local t_11 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 20,
    Description = "Whirl your weapon over your head, resulting in a broad arc of strikes.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Weapon",
    Cooldown = 8,
    WindUp = 0,
    Type = { "Spear", "Staff" },
    Image = _G.weapon_icon,
    Required = { Points = 10, Marks = 1000, Proficiency = { Type = "Medium", Amount = 4 } },
    Restrictions = {}
}
t.Cyclone = t_11
local t_13 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 5,
    Description = "Slashes their foe with speed, followed by a decisive thrust.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Weapon",
    Cooldown = 8,
    WindUp = 0.1,
    Type = { "Spear" },
    Image = _G.weapon_icon,
    Required = { Points = 10, Marks = 1000, Proficiency = { Type = "Light", Amount = 2 } },
    Restrictions = {}
}
t["Flashy Finish"] = t_13
local t_15 = {
    ReqType = "Trainer",
    Requirement = 0,
    EnergyCost = 25,
    Description = "User teleports behind the nearest enemy and slashes them with their weapon.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Weapon",
    Cooldown = 10,
    WindUp = 0,
    Type = { "Spear", "Rapier", "Sword" },
    Image = _G.weapon_icon,
    Required = { Points = 10, Marks = 1000, Proficiency = { Type = "Medium", Amount = 4 } },
    Restrictions = {}
}
t["Vanishing Strike"] = t_15
local t_17 = {
    ReqType = "Trainer",
    Requirement = 0,
    RequirementText = "",
    Description = "When wielding a dagger, your critical attacks deal an additional 15% damage.",
    Skillset = "Weapon Passive",
    Type = { "Dagger" },
    Image = _G.weapon_icon,
    Required = { Points = 4, Marks = 300, Proficiency = { Type = "Light", Amount = 4 } },
    Restrictions = {}
}
t["Deadly Precision"] = t_17
local t_19 = {
    ReqType = "Trainer",
    Requirement = 0,
    RequirementText = "",
    Description = "When wielding a spear, sword, staff or trident while below 20% health, gain 10% physical armor penetration.",
    Skillset = "Weapon Passive",
    Type = { "Spear", "Sword", "Staff", "Trident" },
    Image = _G.weapon_icon,
    Required = { Points = 4, Marks = 300, Proficiency = { Type = "Medium", Amount = 6 } },
    Restrictions = {}
}
t["Enraged Warrior"] = t_19

return t
