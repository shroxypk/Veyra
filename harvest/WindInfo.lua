-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.WindInfo
-- Class: ModuleScript
-- bytes: 3377

local t = {
    Tornado = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 25,
        Description = "Unleash a powerful tornado that launches enemies away, preventing any chance of counterattack.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Wind",
        Cooldown = 16,
        WindUp = 0,
        Type = "Magic"
    },
    ["Tempest Palm"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "User seizes the target and hurls them skyward with a powerful gust, leaving them reeling.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Wind",
        Cooldown = 11,
        WindUp = 0.1,
        Type = "Magic"
    },
    ["Gale Rupture"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "Slam the ground to unleash a burst of wind, propelling you and surrounding foes skyward.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Wind",
        Cooldown = 11,
        WindUp = 0.1,
        Type = "Magic"
    },
    ["Rushing Tempest"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 35,
        Description = "User dashes forward with a burst of wind, striking the opponent and launching them.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Wind",
        Cooldown = 11,
        WindUp = 0,
        Type = "Magic"
    },
    ["Tempest Blade"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "User forms a wind blade and hurls it, sending any target in its path flying.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Wind",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic"
    },
    ["Gale Sphere"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 20,
        Description = "User generates a swirling wind around themselves, then releases it in a spin, forming a wind dome that knocks enemies back.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Wind",
        Cooldown = 11,
        WindUp = 0.125,
        Type = "Magic"
    },
    ["Gale Updraft"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 25,
        Description = "User summons a gust of wind, shaping it into a floating ark dense enough to launch them skyward.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Wind",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic"
    }
}
local t_1 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Holding RMB when activating Tempest Blade summons an additional 2 blades to the spell.",
    Skillset = "Wind Passive",
    Type = "Magic",
    Required = { Points = 4, Marks = 300 },
    Restrictions = {}
}
t["Blade Storm"] = t_1
local t_3 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "While airborne, your wind abilities take 30% less mana to cast.",
    Skillset = "Wind Passive",
    Type = "Magic",
    Required = { Points = 4, Marks = 300 },
    Restrictions = {}
}
t["Aerial Efficiency"] = t_3

return t
