-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Names.Last
-- Class: ModuleScript
-- bytes: 2578

return {
    MagicAffinity = 5,
    Tiers = {
        {
            Name = "Legendary",
            Chance = 5,
            Color = Color3.fromRGB(255, 190, 60),
            Names = { "Anchor", "Morningstar", "Chrono", "Clover" }
        },
        {
            Name = "Epic",
            Chance = 15,
            Color = Color3.fromRGB(180, 110, 255),
            Names = { "Raijin", "Tempest", "Vermillion", "Eclipse", "Sable", "Solstice" }
        },
        {
            Name = "Uncommon",
            Chance = 30,
            Color = Color3.fromRGB(110, 200, 110),
            Names = {
                "Hemlock",
                "Kravitz",
                "Aspen",
                "Silver",
                "Marigold",
                "Steele",
                "Willow",
                "Starling"
            }
        },
        {
            Name = "Common",
            Chance = 50,
            Color = Color3.fromRGB(200, 200, 200),
            Names = { "Angel", "Swallow", "Wren", "Rook", "Crowe", "Warren", "Vitesse", "Rapual" }
        }
    },
    Buffs = {
        Anchor = { PhysicalDamage = 5, PhysicalResistance = 5, Health = 20, HealthRegen = 10 },
        Morningstar = { MagicDamage = 5, MagicResistance = 5, HealthRegen = 15 },
        Chrono = { Magic = "Time", Energy = 15, EnergyRegen = 15 },
        Clover = { LevelXP = 10, MasteryXP = 10, ProficiencyXP = 10, AllProfessionXP = 10 },
        Raijin = { Magic = "Lightning", PhysicalDamage = 4 },
        Tempest = { Magic = "Wind", EnergyRegen = 10 },
        Vermillion = { Magic = "Flame", Health = 15 },
        Eclipse = { Magic = "Shadow", MagicResistance = 4 },
        Sable = { Magic = "Beast", HealthRegen = 10 },
        Solstice = { Magic = "Light", Energy = 12 },
        Hemlock = { MagicDamage = 2 },
        Kravitz = { PhysicalDamage = 2 },
        Aspen = { Health = 8 },
        Silver = { MagicResistance = 2 },
        Marigold = { HealthRegen = 5 },
        Steele = { PhysicalResistance = 2 },
        Willow = { EnergyRegen = 5 },
        Starling = { Energy = 6 }
    },
    Renamed = {
        Sukehiro = "Anchor",
        Zogratis = "Morningstar",
        Novachrono = "Chrono",
        Voltia = "Raijin",
        Grinberryall = "Tempest",
        Faust = "Eclipse",
        Vetto = "Sable",
        Licht = "Solstice",
        Agrippa = "Hemlock",
        Silva = "Silver",
        Vangeance = "Marigold",
        Roselei = "Steele",
        Vaude = "Willow",
        Enoteca = "Starling",
        Whomalt = "Wren",
        Code = "Rook",
        Leto = "Crowe"
    }
}
