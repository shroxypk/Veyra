-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.LightningInfo
-- Class: ModuleScript
-- bytes: 3455

local t = {
    ["Electro Beam"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 30,
        Description = "Release a devastating beam of lightning.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Lightning",
        Cooldown = 11,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175901260"
    },
    ["Thunder Strike"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 35,
        Description = "Slam targets under you with a lightning-infused kick.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Lightning",
        Cooldown = 11,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175901260"
    },
    ["Dragon Impact"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 40,
        Description = "Calls forth a lightning dragon from the heavens.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Lightning",
        Cooldown = 16,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175901260"
    },
    ["Volt Surge"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 30,
        Description = "...",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Lightning",
        Cooldown = 15,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175901260"
    },
    ["Lightning Barrage"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 5,
        Description = "Deliver a flurry of electric strikes",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Lightning",
        Cooldown = 10,
        WindUp = 0.1,
        Type = "Magic",
        Image = "rbxassetid://16175901260"
    },
    ["Lightning Shroud"] = {
        ReqType = "Gameplay",
        Requirement = 8,
        EnergyCost = 1,
        Description = "A fierce electrical aura that strengthens you.",
        Style = "Transform",
        Stat = "",
        Skillset = "Lightning",
        Cooldown = 25,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175901260"
    }
}
local t_1 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Your abilities now deal more damage when it's raining.",
    Skillset = "Lightning Passive",
    Type = "Magic",
    Image = "rbxassetid://16175901260",
    Required = { Points = 4 }
}
t["Rain Dancer"] = t_1
local t_3 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "After landing a lightning ability, there is a 40% chance your M1s are imbued with thunder for 10 seconds. (8 Sec. Cooldown)",
    Skillset = "Lightning Passive",
    Type = "Magic",
    Image = "rbxassetid://16175901260",
    Required = { Points = 4, Marks = 300 }
}
t["Stormcaller's Respite"] = t_3
local t_5 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "While 'Lightning Shroud' is active, your dodges are powered with lightning.",
    Skillset = "Lightning Passive",
    Type = "Magic",
    Image = "rbxassetid://16175901260",
    Required = { Points = 4, Marks = 100 }
}
t["Lightning Pulse"] = t_5

return t
