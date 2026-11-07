-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Professions.Mining
-- Class: ModuleScript
-- bytes: 3507

local t = {
    Title = "Deepdelver",
    Noun = "Miner",
    Icon = "rbxassetid://114620712318762",
    Color = Color3.fromRGB(131, 126, 190),
    Desc = "Your skill at uncovering ores and valuable materials hidden beneath the surface.",
    XPMultiplier = 1,
    Gathers = true,
    Tracker = "Ore",
    Core = { Key = "power", PerLevel = 0.015, Label = "Mining Power" },
    Skills = nil,
    Challenges = nil
}
local t_1 = {}
t_1[2] = {
    Name = "Ore Tracker Unlocked",
    Desc = "Track one ore type within 500m",
    Attributes = { tracker = 1 }
}
t_1[3] = { Desc = "Timing zones 10% wider", Attributes = { timing_size = 0.1 } }
t_1[4] = { Desc = "+5% rare ore chance", Attributes = { rare_chance = 0.05 } }
t_1[5] = {
    Name = "Second Wind",
    Desc = "Lose 1 fewer momentum level on a miss",
    Attributes = { timing_miss_guard = 1 }
}
t_1[7] = { Desc = "-10% mining cooldown", Attributes = { cd_reduction = 0.1 } }
t_1[8] = { Desc = "Crit zone 25% wider", Attributes = { timing_crit_size = 0.25 } }
t_1[9] = {
    Name = "Ore Tracker Tier II",
    Desc = "Range 1,000 studs, shows how many nodes are in range",
    Attributes = { tracker = 1 }
}
t_1[10] = {
    Name = "Heavy Hands",
    Desc = "+50% crit damage",
    Attributes = { timing_crit_damage = 0.5 }
}
t_1[12] = { Desc = "+5% double ore chance", Attributes = { duplicate_chance = 0.05 } }
t_1[13] = { Desc = "Timing pointer 10% slower", Attributes = { timing_slow = 0.1 } }
t_1[14] = { Desc = "+5% rare ore chance (10% total)", Attributes = { rare_chance = 0.05 } }
t_1[15] = { Desc = "-10% mining cooldown (20% total)", Attributes = { cd_reduction = 0.1 } }
t_1[17] = { Desc = "2% chance per node to find a gem", Attributes = { gem_chance = 0.02 } }
t_1[18] = { Desc = "Timing zones +10% wider (20% total)", Attributes = { timing_size = 0.1 } }
t_1[19] = {
    Name = "Ore Tracker Tier III",
    Desc = "Track 2 ore types; tracked nodes outline through walls",
    Attributes = { tracker = 1 }
}
t_1[20] = { Desc = "+5% double ore (10% total)", Attributes = { duplicate_chance = 0.05 } }
t_1[22] = { Desc = "+10% damage on every hit", Attributes = { timing_damage = 0.1 } }
t_1[23] = {
    Desc = "Lose 1 more fewer momentum level on a miss (2 total)",
    Attributes = { timing_miss_guard = 1 }
}
t_1[24] = { Desc = "+2% gem chance (4% total)", Attributes = { gem_chance = 0.02 } }
t_1[25] = { Desc = "Crit zone +25% wider (50% total)", Attributes = { timing_crit_size = 0.25 } }
t_1[27] = {
    Name = "Ore Tracker Tier IV",
    Desc = "Range 2,000 studs, shows respawn timers on depleted nodes",
    Attributes = { tracker = 1 }
}
t_1[28] = { Desc = "Timing pointer +10% slower (20% total)", Attributes = { timing_slow = 0.1 } }
t_1[29] = { Desc = "+5% double ore (15% total)", Attributes = { duplicate_chance = 0.05 } }
t_1[30] = {
    Name = "Earthshaker",
    Desc = "Perfect crits chip 25% off other ore nodes within 25 studs",
    Attributes = { earthshaker = 1 }
}
t.Skills = t_1
t.Challenges = {
    [5] = { Type = "Mining", Hits = 6, Misses = 3, Zone = 1, Speed = 1 },
    [10] = { Type = "Mining", Hits = 8, Misses = 3, Zone = 0.9, Speed = 1.1 },
    [15] = { Type = "Mining", Hits = 10, Misses = 2, Zone = 0.8, Speed = 1.18 },
    [20] = { Type = "Mining", Hits = 10, Crits = 3, Misses = 2, Zone = 0.72, Speed = 1.26 },
    [25] = { Type = "Mining", Hits = 12, Crits = 5, Misses = 2, Zone = 0.64, Speed = 1.35 },
    [30] = { Type = "Mining", Hits = 12, Crits = 8, Misses = 2, Zone = 0.58, Speed = 1.45 }
}

return t
