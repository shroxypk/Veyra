-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Products
-- Class: ModuleScript
-- bytes: 2821

local t = {}
t.Gamepass = {
    EmotePack = { GamepassId = 83806155, Product = 0 },
    EmotePack2 = { GamepassId = 152217782, Product = 0 }
}
local t_2 = {
    Spin1 = { Product = 1287390207 },
    Spin5 = { Product = 1287390271 },
    Spin10 = { Product = 1287390365 },
    FamilySpin1 = { Product = 3721352148 },
    FamilySpin5 = { Product = 3721352954 },
    FamilySpin10 = { Product = 3721353052 },
    NewSaveSlot = { Product = 1304808812 },
    MagicVariant = { Product = 3591966907 },
    VariantReroll1 = { Product = 3591966907 },
    VariantReroll5 = { Product = 3729021351 },
    VariantReroll10 = { Product = 3729021863 },
    ResetPoints = { Product = 1842105671 },
    ResetAugments = { Product = 3719844977 },
    ProficiencyReset = { Product = 3722633892, Item = "Proficiency Reset" },
    PortableMerchant = { Product = 3720849338, Price = 649, Unlock = "PortableMerchantUnlocked" },
    PortableBanker = { Product = 3720849048, Price = 649, Unlock = "PortableBankerUnlocked" },
    ResetGrimoireMastery = { Product = 0 }
}
local t_3 = {
    Product = 3721676472,
    Price = 379,
    Bundle = true,
    Owned = "StarterPackPurchased",
    Contents = {
        Items = {
            { "Race Reroll", 5 },
            { "Magic Reroll", 2 },
            { "Family Name Reroll", 5 },
            { "Minor Potion of Clarity", 2 },
            { "Minor Potion of Ironskin", 2 },
            { "Minor Potion of Slaying", 2 },
            { "Minor Potion of Swiftness", 2 },
            { "Minor Potion of Vitality", 2 },
            { "Minor Potion of Warding", 2 }
        }
    }
}
t_2.StarterPack = t_3
local t_5 = {
    Product = 3721676917,
    Price = 1699,
    Bundle = true,
    Owned = "ReleasePackPurchased",
    EndsAt = 1793419140,
    Contents = {
        Title = "Primordial",
        Items = { { "Race Reroll", 10 }, { "Magic Reroll", 5 }, { "Family Name Reroll", 10 } },
        Essence = 1000,
        SaveSlots = 1
    }
}
t_2.ReleasePack = t_5
local t_7 = {
    Product = 3727559813,
    Price = 2199,
    Worth = 2950,
    Bundle = true,
    Owned = "HalloweenPackPurchased",
    Contents = {
        Title = "Hallowed",
        Items = {
            { "Emberwitch Broom", 1 },
            { "Emberwitch Hat", 1 },
            { "Emberwitch Robe", 1 },
            { "Emberwitch Boots", 1 },
            { "Race Reroll", 5 },
            { "Magic Reroll", 5 },
            { "Family Name Reroll", 5 }
        }
    }
}
t_2.HalloweenPack = t_7
t.Products = t_2
t.Donation = {
    { Product = 3711190233 },
    { Product = 3711190258 },
    { Product = 3711191789 },
    { Product = 3711193787 }
}
t.SubstituteEssencePerRobux = 3.282828282828283
t.Essence = {
    { Product = 1842104394 },
    { Product = 1842104574 },
    { Product = 1842105189 },
    { Product = 1842105273 }
}

return t
