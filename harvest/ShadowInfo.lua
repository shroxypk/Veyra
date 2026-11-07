-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.ShadowInfo
-- Class: ModuleScript
-- bytes: 3124

local t = {
    ["Dark Haste"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 25,
        Description = "User concentrates shadow into their palms, unwinding a close-range outburst that briefly cripples the enemy.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Shadow",
        Cooldown = 10,
        WindUp = 0,
        Type = "Magic"
    },
    ["Dark Cyclone"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "User delivers a wide circular slash of shadow, before following up with a brutal vertical finisher.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Shadow",
        Cooldown = 10,
        WindUp = 0.05,
        Type = "Magic"
    },
    ["Void Beam"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 25,
        Description = "User unveils a shadowy hand behind themselves, allowing them to release devastating beams of shadow upon recast.",
        Style = "DoubleClick",
        Stat = "",
        Skillset = "Shadow",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic"
    },
    ["Shadow Tendril"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 4,
        Description = "User musters several dark tendrils, slowing their opponent and tethering them.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Shadow",
        Cooldown = 50,
        WindUp = 0,
        Type = "Magic"
    },
    ["Shadow Annihilation"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "User summons three lingering dark orbs that encompass the enemy, which hone in after a short interval. ",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Shadow",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic"
    },
    ["Dark Piercer"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 20,
        Description = "User blitzes forward, unleashing a relentless torrent of darkness upon the enemy. ",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Shadow",
        Cooldown = 12,
        WindUp = 0.1,
        Type = "Magic"
    }
}
local t_1 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Your shadow abilities do more damage during the night-time.",
    Skillset = "Shadow Passive",
    Type = "Magic",
    Image = "rbxassetid://",
    Required = { Points = 4, Marks = 100 },
    Restrictions = {}
}
t["Fear The Shadows"] = t_1
local t_3 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Holding RMB when activating Void Beam transforms the barrage into a single, more powerful shot.",
    Skillset = "Shadow Passive",
    Type = "Magic",
    Image = "rbxassetid://",
    Required = { Points = 4, Marks = 100 },
    Restrictions = {}
}
t["Focused Beam"] = t_3

return t
