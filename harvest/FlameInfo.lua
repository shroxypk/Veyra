-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.FlameInfo
-- Class: ModuleScript
-- bytes: 4334

local t = {
    ["Burst Pistol"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "Unleash an explosive fireball that inflicts damage and causes a fiery explosion.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Flame",
        Cooldown = 12,
        WindUp = 0.05,
        Type = "Magic",
        Image = "rbxassetid://16175888362"
    },
    ["Binding Flame"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 45,
        Description = "User snaps their fingers, binding any humanoid in the vicinity.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Flame",
        Cooldown = 18,
        WindUp = 0.15,
        Type = "Magic",
        Image = "rbxassetid://16175888362"
    },
    ["Fire Stomp"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 25,
        Description = "Stomp the ground, creating a powerful eruption of flames that damages and stuns enemies.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Flame",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175888362"
    },
    ["Blazing Dive"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 25,
        Description = "Launch into the air and crash down in a fiery explosion, scorching all nearby enemies.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Flame",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175888362"
    },
    ["Scorching Barrage"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 35,
        Description = "Summon a relentless rain of fiery meteors from the sky, causing widespread devastation.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Flame",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175888362"
    },
    ["Fiery Grapple"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 25,
        Description = "User dashes forward with a flame-charged hand, grabbing the target and triggering a fiery explosion.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Flame",
        Cooldown = 10,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://16175888362"
    }
}
local t_1 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Holding RMB when activating Scorching Barrage transforms the barrage into a singular, much larger meteor.",
    Skillset = "Flame Passive",
    Type = "Magic",
    Image = "rbxassetid://16175888362",
    Required = { Points = 4 },
    Restrictions = {}
}
t["Blazing Meteor"] = t_1
local t_3 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Breaking an enemy's block sets off a fiery explosion on them, damaging, burning and knocking back everyone nearby. Scales with Magic Power. (60s cooldown)",
    Skillset = "Flame Passive",
    Type = "Magic",
    Image = "rbxassetid://16175888362",
    Required = { Points = 4, Insight = 25 },
    Restrictions = {}
}
t["Shattering Ember"] = t_3
local t_5 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "When an enemy attempts to execute you, unleash a burst of flames that disrupts the execution and stuns nearby foes briefly (60s cooldown).",
    Skillset = "Flame Passive",
    Type = "Magic",
    Image = "rbxassetid://16175888362",
    Required = { Points = 3, Insight = 25 },
    Restrictions = {}
}
t["Infernal Defiance"] = t_5
local t_7 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "If a person is on fire, deal extra damage with your M1s.",
    Skillset = "Flame Passive",
    Type = "Magic",
    Image = "rbxassetid://16175888362",
    Required = { Points = 3, Insight = 25, Marks = 250 },
    Restrictions = {}
}
t["Amplified Wrath"] = t_7

return t
