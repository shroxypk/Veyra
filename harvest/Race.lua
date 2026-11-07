-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Race
-- Class: ModuleScript
-- bytes: 5493

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local rng = Random.new()
local t = {}
local Arena = require(script.Parent.PlaceFlags).Arena
t.__index = t
local t_1 = {}
local t_2 = {
    Rarity = "Common",
    Chance = 0.52,
    Description = "The most prominent race in the land, possessing a strong thirst for knowledge and innovation.",
    Traits = {
        Entrepreneur = "Enhanced ability to negotiate and persuade NPCs. The price you sell items for is increased by 15%."
    }
}
t_1.Human = t_2
local t_4 = {
    Rarity = "Uncommon",
    Chance = 0.2,
    Description = "Graceful and long-lived, they carry the wisdom of generations while ever seeking to learn more.",
    Traits = { ["World Tree's Blessing"] = "Spells cost 15% less mana to use" },
    Bonuses = { EnergyBonus = 20 }
}
t_1.Elf = t_4
local t_7 = {
    Rarity = "Rare",
    Chance = 0.1,
    Description = "Strange and enigmatic beings, they possess an innate understanding of forces that few others dare to comprehend.",
    Traits = { ["Corrupt Physique"] = "Physical damage deals 2.5% more damage." },
    Bonuses = { MaxResolve = 2, HealthBonus = 10 }
}
t_1.Eldritch = t_7
local t_10 = {
    Rarity = "Rare",
    Chance = 0.1,
    Description = "Shrouded in mystery, they are cunning and resourceful, thriving where others would falter.",
    Traits = { Spellcaster = "Spells do 5% more damage" },
    Bonuses = { EnergyBonus = 10, ManaRegen = 10 }
}
t_1["Dark Elf"] = t_10
local t_13 = {
    Rarity = "Rare",
    Chance = 0.06,
    Description = "Children of the natural world, they share a deep bond with the forests and the life that flourishes within them.",
    Traits = {
        ["Nature's Grace"] = "When wounded, invoke a grace that briefly increases health regenration."
    },
    Bonuses = { EnergyBonus = 10 }
}
t_1.Dryad = t_13
local t_16 = {
    Rarity = "Legendary",
    Chance = 0.01,
    Description = "Born from the depths, they possess a fierce nature and an innate affinity for the powers that dwell within them.",
    Traits = {
        Hellsworn = "Quicker Devil Contract progression & increased devil mode duration.",
        ["Wrath Unbound"] = "Increases physical damage by 2.5% each melee hit without being hit, up to 10 stacks."
    },
    Bonuses = { HealthBonus = 20, Physical = 5 }
}
t_1["Lesser Demon"] = t_16
local t_19 = {
    Rarity = "Legendary",
    Chance = 0.01,
    Description = "Blessed with divine grace, guided by a purpose known only to them.",
    Traits = {
        Heavenbound = "Quicker Spirit Contract progression & increased Spirit Surge Mode duration",
        ["Divine Retribution"] = "Once a life, when you would take lethal damage, regen 15% of your health instead."
    },
    Bonuses = { EnergyBonus = 40, Magic = 10 },
    Elements = nil
}
t_1["Lesser Angel"] = t_19
local t_22 = {
    Rarity = "Legendary",
    Chance = 0,
    Unobtainable = true,
    Description = "Heaven's chosen, touched by the radiance of Luminos and sent forth with a purpose beyond mortal understanding.",
    Traits = {
        Heavenbound = "Quicker Spirit Contract progression & increased Spirit Surge Mode duration",
        ["Divine Retribution"] = "Once a life, when you would take lethal damage, regen 15% of your health instead.",
        Hellsworn = "Quicker Devil Contract progression & increased devil mode duration.",
        ["Wrath Unbound"] = "Increases physical damage by 2.5% each melee hit without being hit, up to 10 stacks.",
        ["Nature's Grace"] = "When wounded, invoke a grace that briefly increases health regenration.",
        Spellcaster = "Spells do 5% more damage",
        ["World Tree's Blessing"] = "Spells cost 15% less mana to use",
        Entrepreneur = "Enhanced ability to negotiate and persuade NPCs. The price you sell items for is increased by 15%."
    },
    Bonuses = { EnergyBonus = 40, Magic = 10 },
    Elements = nil
}
t_1.Archangel = t_22
t.Races = t_1

function t.GetRace(arg1) -- line: 125
    -- upvalues:
    --  [1] rng (copy)

    local t_25 = {}
    local v2 = 0

    for key, val in arg1.Races do
        if not val.Unobtainable and val.Chance > 0 then
            table.insert(t_25, key)
            v2 += val.Chance
        end
    end

    table.sort(t_25)
    local v3 = rng:NextNumber() * v2

    for _, val_1 in t_25 do
        v2 = arg1.Races[val_1].Chance

        if v2 > v3 then
            return val_1, v2
        end

        v3 -= v2
    end

    v3 = t_25[#t_25]

    return v3, arg1.Races[v3].Chance
end

function t.LoadRaceStats(t1: table, s1: string, u1: userdata, b1: boolean?) -- line: 150
    -- upvalues:
    --  [1] Arena (copy)

    local t_26 = {}
    local t_27 = {}
    local v4 = t1.Races[s1]

    if v4 then
        if v4.Traits and not b1 then
            if not Arena then
                for key_2 in v4.Traits do
                    local BoolValue = Instance.new("BoolValue")
                    BoolValue.Name = key_2
                    BoolValue.Parent = u1
                end
            end

            u1:SetAttribute("RaceTraitsLoaded", true)
        end

        if v4.Bonuses then
            for key_3, val_2 in v4.Bonuses do
                t_26[key_3] = val_2
            end
        end

        if v4.Elements then
            for key_4, val_3 in v4.Elements do
                t_27[key_4] = val_3
            end
        end
    end

    return t_26, t_27
end

return t
