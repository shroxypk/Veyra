-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Professions.Harvesting
-- Class: ModuleScript
-- bytes: 3939

local t = {
    Title = "Herbalist",
    Noun = "Harvester",
    Icon = "rbxassetid://89961015476007",
    Color = Color3.fromRGB(142, 171, 99),
    Desc = "Your skill at harvesting the land's natural growth and organic materials.",
    XPMultiplier = 1,
    Gathers = true,
    Tracker = "Harvest",
    Core = { Key = "speed", PerLevel = 0.015, Label = "Harvest Speed" },
    Skills = nil,
    Challenges = nil
}
local t_1 = {}
t_1[2] = {
    Name = "Harvest Tracker Unlocked",
    Desc = "Track one plant type within 500m",
    Attributes = { tracker = 1 }
}
t_1[3] = { Desc = "Rings spin 20% slower", Attributes = { timing_spin_slow = 0.2 } }
t_1[4] = { Desc = "Timing zones 10% wider", Attributes = { timing_size = 0.1 } }
t_1[5] = { Desc = "+5% double crop chance", Attributes = { duplicate_chance = 0.05 } }
t_1[7] = { Desc = "+5% instant harvest chance", Attributes = { chance = 0.05 } }
t_1[8] = { Desc = "Lose 1 fewer momentum level on a miss", Attributes = { timing_miss_guard = 1 } }
t_1[9] = {
    Name = "Harvest Tracker Tier II",
    Desc = "Range 1,000 studs, shows how many plants are in range",
    Attributes = { tracker = 1 }
}
t_1[10] = {
    Name = "Head Start",
    Desc = "Every harvest starts at momentum level 1",
    Attributes = { head_start = 1 }
}
t_1[12] = { Desc = "Crit zone 25% wider", Attributes = { timing_crit_size = 0.25 } }
t_1[13] = { Desc = "+5% double crop (10% total)", Attributes = { duplicate_chance = 0.05 } }
t_1[14] = { Desc = "Rings +20% slower (40% total)", Attributes = { timing_spin_slow = 0.2 } }
t_1[15] = { Desc = "+5% instant harvest (10% total)", Attributes = { chance = 0.05 } }
t_1[17] = {
    Desc = "5% chance a plant you harvest regrows instantly",
    Attributes = { regrow_chance = 0.05 }
}
t_1[18] = { Desc = "Timing zones +10% wider (20% total)", Attributes = { timing_size = 0.1 } }
t_1[19] = {
    Name = "Harvest Tracker Tier III",
    Desc = "Track 2 plant types; tracked plants outline through walls",
    Attributes = { tracker = 1 }
}
t_1[20] = {
    Name = "Gatherer",
    Desc = "5% chance to triple the yield",
    Attributes = { triple_chance = 0.05 }
}
t_1[22] = {
    Desc = "+2% 1\226\152\133 and +1% 2\226\152\133 chance, on top of rank odds",
    Attributes = { quality_bonus1 = 0.02, quality_bonus2 = 0.01 }
}
t_1[23] = {
    Desc = "Lose 1 more fewer momentum level on a miss (2 total)",
    Attributes = { timing_miss_guard = 1 }
}
t_1[24] = { Desc = "Crit zone +25% wider (50% total)", Attributes = { timing_crit_size = 0.25 } }
t_1[25] = { Desc = "+5% double crop (15% total)", Attributes = { duplicate_chance = 0.05 } }
t_1[27] = {
    Name = "Harvest Tracker Tier IV",
    Desc = "Range 2,000 studs, shows regrow timers on harvested plants",
    Attributes = { tracker = 1 }
}
t_1[28] = { Desc = "+5% regrow chance (10% total)", Attributes = { regrow_chance = 0.05 } }
t_1[29] = { Desc = "+5% instant harvest (15% total)", Attributes = { chance = 0.05 } }
t_1[30] = {
    Name = "Overgrowth",
    Desc = "Each harvest has a 10% chance to also give a random herb from that area",
    Attributes = { overgrowth = 0.1 }
}
t.Skills = t_1
t.Challenges = {
    [5] = { Type = "Harvesting", Hits = 6, Misses = 3, Gap = 1, Speed = 1, Spin = 0.6 },
    [10] = { Type = "Harvesting", Hits = 8, Misses = 3, Gap = 0.92, Speed = 1.06, Spin = 0.75 },
    [15] = { Type = "Harvesting", Hits = 10, Misses = 2, Gap = 0.88, Speed = 1.1, Spin = 0.85 },
    [20] = {
        Type = "Harvesting",
        Hits = 10,
        Crits = 3,
        Misses = 2,
        Gap = 0.82,
        Speed = 1.14,
        Spin = 0.95
    },
    [25] = {
        Type = "Harvesting",
        Hits = 12,
        Crits = 4,
        Misses = 2,
        Gap = 0.76,
        Speed = 1.18,
        Spin = 1.05
    },
    [30] = {
        Type = "Harvesting",
        Hits = 12,
        Crits = 5,
        Misses = 2,
        Gap = 0.72,
        Speed = 1.22,
        Spin = 1.1
    }
}

return t
