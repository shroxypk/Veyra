-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Professions.Crafting
-- Class: ModuleScript
-- bytes: 2479

local t = {
    Title = "Forgemaster",
    Noun = "Smith",
    Icon = "rbxassetid://94742182801052",
    Color = Color3.fromRGB(245, 255, 194),
    Desc = "Rise through the ranks to unlock advanced recipes and forge higher-quality gear.",
    XPMultiplier = 1,
    Gathers = false,
    Core = { Key = "star_boost", PerLevel = 0.005, Label = "\226\152\133 Chance" },
    RecipeLevels = nil,
    Skills = nil,
    Challenges = nil
}
local t_1 = { 1, 5, 10, 15, 20 }
t_1[6] = 25
t.RecipeLevels = t_1
local t_2 = {}
t_2[2] = { Desc = "Craft up to 5 at once", Attributes = { bulk_craft = 5 } }
t_2[4] = { Desc = "Smelting gives +10% more scrap", Attributes = { smelt_return = 0.1 } }
t_2[5] = { Desc = "Crafted items can roll 1\226\152\133", Attributes = { star_capability = 1 } }
t_2[7] = {
    Desc = "5% chance per material not to be consumed",
    Attributes = { material_save = 0.05 }
}
t_2[9] = { Desc = "+5% duplicate chance", Attributes = { duplicate_chance = 0.05 } }
t_2[10] = { Name = "Artisan", Desc = "+10% \226\152\133 chance", Attributes = { star_boost = 0.1 } }
t_2[12] = { Desc = "Craft up to 10 at once", Attributes = { bulk_craft = 5 } }
t_2[14] = {
    Desc = "Smelting gives +10% more scrap (20% total)",
    Attributes = { smelt_return = 0.1 }
}
t_2[15] = { Desc = "Crafted items can roll 2\226\152\133", Attributes = { star_capability = 1 } }
t_2[17] = { Desc = "+5% material save (10% total)", Attributes = { material_save = 0.05 } }
t_2[19] = { Desc = "+5% duplicate (10% total)", Attributes = { duplicate_chance = 0.05 } }
t_2[20] = {
    Name = "Quality Eye",
    Desc = "The \226\152\133 bonus from high-quality materials is 25% stronger",
    Attributes = { quality_eye = 0.25 }
}
t_2[22] = {
    Desc = "The craft screen shows your \226\152\133 odds before you craft",
    Attributes = { star_preview = 1 }
}
t_2[24] = {
    Desc = "Smelting gives +10% more scrap (30% total)",
    Attributes = { smelt_return = 0.1 }
}
t_2[25] = { Desc = "Crafted items can roll 3\226\152\133", Attributes = { star_capability = 1 } }
t_2[27] = { Desc = "Craft up to 25 at once", Attributes = { bulk_craft = 15 } }
t_2[28] = { Desc = "+5% duplicate (15% total)", Attributes = { duplicate_chance = 0.05 } }
t_2[29] = { Desc = "+5% material save (15% total)", Attributes = { material_save = 0.05 } }
t_2[30] = {
    Name = "Perfectionist",
    Desc = "\226\152\133 rolls twice and keeps the better result",
    Attributes = { perfectionist = 1 }
}
t.Skills = t_2

return t
