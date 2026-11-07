-- Decompiled with Veyra harvester
-- Instance: Workspace.ChatObjects.MUSHROOMFOREST.MushroomAltar.SummonEvent.Challenges
-- Class: ModuleScript
-- bytes: 663

local t = {
    text = "Treasure Chest [5 Fungite]",
    Rewards = { Treasure = { Amount = 1, Type = "Chest" } },
    Requirements = { Fungite = { Amount = 5, Type = "Item" } },
    Waves = { { MushknightBlue = 1 }, { MushknightBlue = 1, MushmiteRed = 1, MushmiteBlue = 1 } }
}
local t_6 = {
    text = "15x Arcane Powder [100 Insight]",
    Rewards = { ["Arcane Powder"] = { Amount = 15, Type = "Item" } },
    Requirements = { Insight = { Amount = 100, Type = "Insight" } },
    Waves = {
        { MushmiteRed = 3, MushmiteBlue = 3 },
        { MushknightBlue = 1, MushmiteGold = 1 },
        { MushknightBlue = 1, MushmiteRed = 2 }
    }
}

return { t, t_6 }
