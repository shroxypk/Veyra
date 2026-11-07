-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.SpatialInfo
-- Class: ModuleScript
-- bytes: 5849

local t = {
    Mark = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 10,
        Description = "Mark up to 2 locations. While in Spatial Dimension, ",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Spatial",
        Cooldown = 6,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://"
    },
    ["Spatial Dimension"] = {
        ReqType = "Gameplay",
        Requirement = 0,
        EnergyCost = 30,
        Description = "Slip into a pocket dimension away from the confines of reality.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Spatial",
        Cooldown = 20,
        WindUp = 0,
        Type = "Magic",
        Image = "rbxassetid://"
    }
}
local t_1 = {
    ReqType = "Gameplay",
    Requirement = 5,
    EnergyCost = 25,
    Description = "Manifests a series of portals in the air above the target location, then fires a rapid volley of magic bullets down into it.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Spatial",
    Cooldown = 12,
    WindUp = 0,
    Type = "Magic",
    Image = "rbxassetid://",
    Volley = {
        MaxRange = 100,
        ZoneRadius = 20,
        Height = 40,
        HeightJitter = 1,
        Duration = 2,
        ProjectilesPerSecond = 8,
        ProjectileSpeed = 160,
        ShotAngle = NumberRange.new(15, 35),
        YawJitter = 60,
        GroundProbeScale = 3,
        ImpactSize = Vector3.new(10, 8, 10),
        ProjectileDamageScale = 0.15
    }
}
t["Spatial Volley"] = t_1
local t_3 = {
    ReqType = "Gameplay",
    Requirement = 0,
    EnergyCost = 30,
    Description = "Warps forward and delivers a rising kick that launches the target airborne. A portal opens above them and a giant spectral sword spears them back down to the ground.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Spatial",
    Cooldown = 13,
    WindUp = 0,
    Type = "Magic",
    Image = "rbxassetid://",
    Ascent = {
        MaxRange = 40,
        AimRadius = 12,
        KickStandoff = 3.5,
        MaxWarpRise = 15,
        WarpDelay = 0.2,
        KickSize = Vector3.new(14, 14, 14),
        KickOffset = CFrame.new(0, 1, -3.5),
        KickDamageScale = 0.35,
        SpearDamageScale = 0.65,
        RiseSpeed = 100,
        HitHeight = 40,
        PortalLead = 0.4,
        PortalDistance = 20,
        SwordSpeed = 200,
        SpearSpeed = 140,
        LandDistance = 25,
        MaxDrop = 15,
        MinSpacing = 7,
        HeightStep = 3,
        KnockdownTime = 1
    }
}
t["Skyward Ascent"] = t_3
local t_5 = {
    ReqType = "Gameplay",
    Requirement = 0,
    EnergyCost = 25,
    Description = "Dashes in with a palm strike. If it lands, warps to the target's side for a second strike, then above them for an axe kick that slams them into the ground.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Spatial",
    Cooldown = 12,
    WindUp = 0,
    Type = "Magic",
    Image = "rbxassetid://",
    Flurry = {
        MaxRange = 12,
        AimRadius = 8,
        OpenerStandoff = 3,
        DashTime = 0.15,
        OpenerSize = Vector3.new(6, 6, 6),
        OpenerOffset = CFrame.new(0, 0, -3),
        FollowUpReach = 10,
        SideOffset = 4,
        AboveOffset = 8,
        WallClearance = 1.5,
        VanishTime = 0.1,
        Times = { Hit1 = 0.2, Blink1 = 0.4, Hit2 = 0.5, Blink2 = 0.7, Slam = 0.85 },
        DamageScale = { 0.25, 0.25, 0.5 },
        HitStun = 0.6,
        KnockdownTime = 0.8,
        AfterimageTime = 0.25
    }
}
t["Phase Flurry"] = t_5
t["Rift Dive"] = {
    ReqType = "Gameplay",
    Requirement = 0,
    EnergyCost = 30,
    Description = "Blinks through a portal high above, hangs in the air to pick a spot, then dives down onto it in a burst of spatial magic.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Spatial",
    Cooldown = 14,
    WindUp = 0,
    Type = "Magic",
    Image = "rbxassetid://",
    Dive = {
        RiseHeight = 35,
        CeilingClearance = 4,
        PortalGap = 5,
        AimWindow = 0.35,
        MinAimTime = 0.15,
        MaxRange = 45,
        MaxDrop = 30,
        DiveSpeed = 250,
        ImpactRadius = 12,
        ImpactHeight = 10,
        KnockbackForce = 60,
        KnockbackLift = 25,
        KnockdownTime = 0.6,
        LandingRecovery = 0.35
    }
}
t["Rift Bloom"] = {
    ReqType = "Gameplay",
    Requirement = 0,
    EnergyCost = 25,
    Description = "Plants your feet and blooms a ring of portals around you. Spectral swords thrust out of every one at once, striking and repelling everyone nearby.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Spatial",
    Cooldown = 14,
    WindUp = 0,
    Type = "Magic",
    Image = "rbxassetid://",
    Bloom = {
        PortalCount = 6,
        PortalRadius = 3,
        PortalHeight = 1.5,
        Telegraph = 0.3,
        ThrustReach = 6,
        ThrustTime = 0.08,
        HoldTime = 0.07,
        RetractTime = 0.1,
        Recovery = 0.05,
        HitRadius = 10,
        HitHeight = 7,
        KnockbackForce = 45,
        KnockbackLift = 8,
        KnockbackTime = 0.2,
        StunTime = 0.4
    }
}
t["Dimensional Comet"] = {
    ReqType = "Gameplay",
    Requirement = 0,
    EnergyCost = 35,
    Description = "Summons an orb of spatial magic that descends and delivers an intense, multi-pronged explosion.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Spatial",
    Cooldown = 16,
    WindUp = 0,
    Type = "Magic",
    Image = "rbxassetid://"
}
t["Spatial Counter"] = {
    ReqType = "Gameplay",
    Requirement = 0,
    EnergyCost = 25,
    Description = "Creates a spatial portal. When hit by an attack, warps behind the enemy and delivers an attack.",
    Style = "NoGyro",
    Stat = "",
    Skillset = "Spatial",
    Cooldown = 15,
    WindUp = 0,
    Type = "Magic",
    Image = "rbxassetid://"
}

return t
