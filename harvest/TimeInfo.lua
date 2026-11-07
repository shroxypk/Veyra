-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TimeInfo
-- Class: ModuleScript
-- bytes: 3707

local t = {
    ["Warping Blitz"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 25,
        Description = "Teleports the caster above a target to slam them down with a stasis orb.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Time",
        Cooldown = 13,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://"
    },
    Chronostasis = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 40,
        Description = "Envelopes the caster in a time bubble to fly forward, transferring the bubble to the first enemy hit and unleashing a barrage of slashes.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Time",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://"
    },
    ["Palm Thrust"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "A quick strike that traps an enemy in a time bubble before it explodes.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Time",
        Cooldown = 12,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://"
    },
    Rewind = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "Reverses time to undo any damage taken in the last few seconds.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Time",
        Cooldown = 16,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://"
    },
    ["Slow Zone"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 25,
        Description = "Warps time in an area around the caster, slowing all enemies caught within it.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Time",
        Cooldown = 26,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://"
    },
    ["Time Stop"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 35,
        Description = "Summons a floating clock that ensnares nearby enemies, suspending them in a bubble while slowly draining their life.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Time",
        Cooldown = 15,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://"
    }
}
local t_1 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Time abilities enhanced by a time orb consume less mana.",
    Skillset = "Time Passive",
    Type = "Magic",
    Image = "rbxassetid://",
    Required = { Points = 4, Marks = 100 },
    Restrictions = {}
}
t.Timeflux = t_1
local t_3 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Holding RMB and dodging consumes mana, but allows the user to instantly shift through space for a quick reposition.",
    Skillset = "Time Passive",
    Type = "Magic",
    Image = "rbxassetid://",
    Required = { Points = 4, Marks = 100 },
    Restrictions = {}
}
t["Chrono Surge"] = t_3
local t_5 = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "Visit your Grimoire Echo in the Inner Realm to learn more.",
    Description = "Every 15 magic intensity grants the user the ability to store an additional time orb, expanding their capacity to manipulate time.",
    Skillset = "Time Passive",
    Type = "Magic",
    Image = "rbxassetid://",
    Required = { Points = 4, Marks = 100 },
    Restrictions = {}
}
t["Temporal Overflow"] = t_5

return t
