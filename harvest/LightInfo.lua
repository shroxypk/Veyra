-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.LightInfo
-- Class: ModuleScript
-- bytes: 3305

local t = {
    ["Slashes of Light"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 3,
        Description = "Unleash a devastating barrage of light slashes.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Light",
        Cooldown = 11,
        WindUp = 0.1,
        Type = "Magic",
        Image = "rbxassetid://8270289488"
    },
    ["Falling Lance"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 25,
        Description = "Throw down a luminous lance from the skies.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Light",
        Cooldown = 9,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://8270289488"
    },
    ["Blinding Rush"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 30,
        Description = "Charge forward, causing a burst of light.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Light",
        Cooldown = 9,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://8270289488"
    },
    ["Aerial Assault"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 25,
        Description = "User launches the opponent into the air, ascends using light, and delivers a powerful kick, slamming them back to the ground.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Light",
        Cooldown = 13,
        WindUp = 0.15,
        Type = "Magic",
        Image = "rbxassetid://8270289488"
    },
    ["Swords of Conviction"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 20,
        Description = "User summons three light blades that hover behind them. Recast to launch them one at a time toward the user's mouse.",
        Style = "DoubleClick",
        Stat = "",
        Skillset = "Light",
        Cooldown = 10,
        WindUp = 0.15,
        Type = "Magic",
        Image = "rbxassetid://8270289488"
    },
    ["Divine Light"] = {
        ReqType = "Gameplay",
        Requirement = 1,
        EnergyCost = 8,
        Description = "User emits a radiant aura that replenishes the user's health.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Light",
        Cooldown = 60,
        CooldownAfterEnd = true,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://8270289488"
    }
}
local t_1 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Holding RMB when activating Divine Light creates a field of light that heals allies within it's radius.",
    Skillset = "Light Passive",
    Type = "Magic",
    Image = "rbxassetid://8270289488",
    Required = { Points = 4, Marks = 200 },
    Restrictions = {}
}
t["Divine Field"] = t_1
local t_3 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Your magic abilities now apply blind to anyone they hit. (7 Sec. Cooldown)",
    Skillset = "Light Passive",
    Type = "Magic",
    Image = "rbxassetid://8270289488",
    Required = { Points = 4, Marks = 100 },
    Restrictions = {}
}
t.Blindstrike = t_3

return t
