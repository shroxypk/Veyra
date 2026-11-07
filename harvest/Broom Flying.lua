-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Professions.Broom Flying
-- Class: ModuleScript
-- bytes: 3065

local t = {
    Title = "Air Savant",
    Noun = "Flier",
    Icon = "rbxassetid://133095840864168",
    Color = Color3.fromRGB(211, 240, 255),
    Desc = "Command the skies: speed, altitude and control through experience.",
    XPMultiplier = 1.25,
    Gathers = false,
    Core = { Key = "speed", PerLevel = 0.0075, Label = "Flight Speed" },
    Skills = nil,
    Challenges = nil
}
local t_1 = {}
t_1[2] = { Desc = "No fall damage when dismounting mid-air", Attributes = { soft_landing = 1 } }
t_1[4] = { Desc = "Broom re-summon cooldown 50% shorter", Attributes = { mount_speed = 0.5 } }
t_1[5] = { Desc = "+10% max altitude", Attributes = { altitude = 0.1 } }
t_1[7] = { Desc = "Speed Orbs give 10% more speed", Attributes = { orb_strength = 0.1 } }
t_1[9] = { Desc = "+10% Broom Flying XP from races", Attributes = { race_bonus = 0.1 } }
t_1[10] = { Desc = "+5% flight speed", Attributes = { speed = 0.05 } }
t_1[12] = { Desc = "+10% max altitude (20% total)", Attributes = { altitude = 0.1 } }
t_1[14] = { Desc = "Speed Orb effects last 15% longer", Attributes = { orb_duration = 0.15 } }
t_1[15] = {
    Name = "Gust Wave",
    Desc = "Block while flying knocks nearby riders off their brooms",
    Attributes = { gust_wave = 1 }
}
t_1[17] = {
    Desc = "Speed Orbs give +10% more speed (20% total)",
    Attributes = { orb_strength = 0.1 }
}
t_1[19] = {
    Desc = "Speed Orb effects last +15% longer (30% total)",
    Attributes = { orb_duration = 0.15 }
}
t_1[20] = {
    Name = "Interceptor",
    Desc = "Gust Wave radius +50% and cooldown -25%",
    Attributes = { interceptor = 1 }
}
t_1[22] = { Desc = "+10% max altitude (30% total)", Attributes = { altitude = 0.1 } }
t_1[24] = {
    Desc = "+10% Broom Flying XP from races (20% total)",
    Attributes = { race_bonus = 0.1 }
}
t_1[25] = { Desc = "+5% flight speed (10% total)", Attributes = { speed = 0.05 } }
t_1[26] = { Desc = "+5% flight speed (15% total)", Attributes = { speed = 0.05 } }
t_1[27] = {
    Desc = "Speed Orbs give +10% more speed (30% total)",
    Attributes = { orb_strength = 0.1 }
}
t_1[28] = {
    Desc = "Speed Orb effects last +15% longer (45% total)",
    Attributes = { orb_duration = 0.15 }
}
t_1[29] = { Desc = "+5% flight speed (20% total)", Attributes = { speed = 0.05 } }
t_1[30] = {
    Name = "Slipstream",
    Desc = "Allies (party and guild members) flying behind you get +10% speed, and you get +5% while drafting behind an ally",
    Attributes = { slipstream = 1 }
}
t.Skills = t_1
t.Challenges = {
    [5] = { Type = "Race", Race = "Kamo Broom Blitz", Region = "Kamo", TargetTime = 16 },
    [10] = { Type = "Race", Race = "Dewfall Dash Derby", Region = "Kamo", TargetTime = 15 },
    [15] = { Type = "Race", Race = "Larceny Lap", Region = "Kamo", TargetTime = 14 },
    [20] = { Type = "Race", Race = "Broomshroom Zoom", Region = "Mushroom", TargetTime = 15 },
    [25] = { Type = "Race", Race = "Elden Derby", Region = "Eldritch", TargetTime = 21 },
    [30] = { Type = "Race", Race = "Bayou Broomba", Region = "Eldritch", TargetTime = 13.5 }
}

return t
