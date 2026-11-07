-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Professions.Alchemy
-- Class: ModuleScript
-- bytes: 3500

local t = {
    Title = "Grand Alchemist",
    Noun = "Alchemist",
    Icon = "rbxassetid://76994426015118",
    Color = Color3.fromRGB(196, 160, 255),
    Desc = "Brew potions at a cauldron by combining up to three ingredients. Unknown mixtures are discovered by experimenting, and rarer combinations brew more reliably.",
    XPMultiplier = 1,
    Gathers = false,
    Core = {
        Key = "success_chance",
        PerLevel = 0.5,
        Label = "Brew Success",
        Flat = true,
        Suffix = "%"
    },
    Skills = nil,
    Challenges = nil
}
local t_1 = {}
t_1[2] = { Desc = "Brew up to 3 potions at once", Attributes = { bulk_brew = 3 } }
t_1[3] = { Desc = "Potions you drink last 5% longer", Attributes = { duration_bonus = 0.05 } }
t_1[4] = { Desc = "+3% brew success", Attributes = { success_bonus = 3 } }
t_1[5] = {
    Name = "Keen Distiller",
    Desc = "Brewed potions can roll 1\226\152\133",
    Attributes = { star_capability = 1 }
}
t_1[6] = {
    Desc = "5% chance per ingredient not to be used up",
    Attributes = { ingredient_save = 0.05 }
}
t_1[7] = { Desc = "Potions you drink are 5% stronger", Attributes = { potency_bonus = 0.05 } }
t_1[8] = {
    Desc = "Failed brews hand back 25% of their ingredients",
    Attributes = { salvage = 0.25 }
}
t_1[9] = { Desc = "+5% chance to brew a potion twice", Attributes = { double_chance = 0.05 } }
t_1[10] = {
    Name = "Alchemist's Intuition",
    Desc = "Failed experiments hint how many of their ingredients belong together",
    Attributes = { intuition = 1 }
}
t_1[12] = { Desc = "Brew up to 5 potions at once", Attributes = { bulk_brew = 2 } }
t_1[13] = {
    Desc = "Potions you drink last 5% longer (10% total)",
    Attributes = { duration_bonus = 0.05 }
}
t_1[14] = { Desc = "+3% brew success (6% total)", Attributes = { success_bonus = 3 } }
t_1[15] = { Desc = "Brewed potions can roll 2\226\152\133", Attributes = { star_capability = 1 } }
t_1[16] = { Desc = "+5% ingredient save (10% total)", Attributes = { ingredient_save = 0.05 } }
t_1[17] = {
    Desc = "Potions you drink are 5% stronger (10% total)",
    Attributes = { potency_bonus = 0.05 }
}
t_1[18] = {
    Name = "Steady Hand",
    Desc = "+4% brew success (10% total)",
    Attributes = { success_bonus = 4 }
}
t_1[19] = { Desc = "+5% double brew (10% total)", Attributes = { double_chance = 0.05 } }
t_1[20] = {
    Name = "Refined Palate",
    Desc = "Ingredient \226\152\133 count 25% more towards potion \226\152\133",
    Attributes = { quality_eye = 0.25 }
}
t_1[22] = { Desc = "Brew up to 10 potions at once", Attributes = { bulk_brew = 5 } }
t_1[23] = {
    Desc = "Potions you drink last 5% longer (15% total)",
    Attributes = { duration_bonus = 0.05 }
}
t_1[24] = { Desc = "+4% brew success (14% total)", Attributes = { success_bonus = 4 } }
t_1[25] = { Desc = "Brewed potions can roll 3\226\152\133", Attributes = { star_capability = 1 } }
t_1[26] = {
    Desc = "Potions you drink are 5% stronger (15% total)",
    Attributes = { potency_bonus = 0.05 }
}
t_1[27] = { Desc = "+5% ingredient save (15% total)", Attributes = { ingredient_save = 0.05 } }
t_1[28] = { Desc = "+5% double brew (15% total)", Attributes = { double_chance = 0.05 } }
t_1[29] = {
    Desc = "+25% chance of an extra potion \226\152\133",
    Attributes = { quality_bonus = 0.25 }
}
t_1[30] = {
    Name = "Philosopher's Touch",
    Desc = "10% chance a successful brew comes out one tier higher",
    Attributes = { tier_up = 0.1 }
}
t.Skills = t_1

return t
