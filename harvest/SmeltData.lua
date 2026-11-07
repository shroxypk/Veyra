-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmeltData
-- Class: ModuleScript
-- bytes: 23454

local Items_m = require(game:GetService("ReplicatedStorage").Modules.Items)
local t = { ScrapSuffix = " Scrap" }
t.Ores = {
    Kamo = { "Copper", "Tin", "Silver", "Gold", "Steel" },
    Mushroom = { "Moldstone", "Fungite", "Gloomium" },
    Eldritch = {
        "Ashenstone",
        "Witherclay",
        "Mournite",
        "Netherite",
        "Spectrite",
        "Viridium",
        "Oblivium"
    }
}

function t.ScrapName(s1: string) -- line: 15
    -- upvalues:
    --  [1] t (copy)

    return s1 .. t.ScrapSuffix
end

function t.OreOfScrap(s2: string) -- line: 19
    -- upvalues:
    --  [1] t (copy)
    --  [2] Items_m (copy)

    if typeof(s2) ~= "string" then
        return nil
    end

    local ScrapSuffix = t.ScrapSuffix

    if string.sub(s2, -(#ScrapSuffix)) ~= ScrapSuffix then
        return nil
    end

    local v1 = string.sub(s2, 1, #s2 - #ScrapSuffix)
    local v2 = Items_m.AllItems[s2]

    if v2 and v2.ScrapOf == v1 then
        return v1
    end

    return nil
end

local t_2 = {
    Kamo = {
        { Copper = 45, Tin = 35, Silver = 20 },
        { Copper = 32, Tin = 26, Silver = 30, Gold = 10, Steel = 2 },
        { Copper = 24, Tin = 18, Silver = 30, Gold = 18, Steel = 10 },
        Rare = { Gold = 8, Steel = 14 }
    },
    Mushroom = {
        { Moldstone = 62, Fungite = 35, Gloomium = 3 },
        { Moldstone = 48, Fungite = 40, Gloomium = 12 },
        { Moldstone = 38, Fungite = 42, Gloomium = 20 },
        Rare = { Gloomium = 18 }
    },
    Eldritch = {
        { Ashenstone = 55, Witherclay = 32, Mournite = 13 },
        { Ashenstone = 42, Witherclay = 16, Mournite = 28, Netherite = 14 },
        { Ashenstone = 32, Witherclay = 6, Mournite = 34, Netherite = 28 },
        Rare = { Viridium = 10, Spectrite = 6, Oblivium = 4 }
    }
}
t.ScrapPools = t_2
t.BiasWeight = 40
local t_6 = { Kamo = nil, Mushroom = nil, Eldritch = nil, Weapon = nil }
local t_7 = { Bamboo = 40, Wood = 30, Wolfsbane = 15, ["Blood Petal"] = 15 }
t_7.Wheat = 10
t_6.Kamo = t_7
t_6.Mushroom = {
    ["Red Mushroom"] = 30,
    ["Blue Glowshroom"] = 15,
    ["Purple Glowshroom"] = 15,
    ["Red Glowshroom"] = 15,
    ["Yellow Glowshroom"] = 15,
    ["Mana Wheat"] = 10
}
local t_9 = { Lumivine = 30, Duskroot = 30, ["Corrupt Lumivine"] = 20 }
t_9["Spirit Lumivine"] = 20
t_6.Eldritch = t_9
t_6.Weapon = { Wood = 70, Bamboo = 30 }
t.SoftPools = t_6
t.ClothChance = 0.35
t.WeaponBase = { Heavy = 8, Medium = 6, Light = 4 }
t.ArmorBase = { Chest = 7, Legs = 5, Helmet = 4, Back = 3, Face = 2, Neck = 2 }
t.SoftShare = 0.7
t.RarityMultiplier = {
    Common = 1,
    Uncommon = 1.15,
    Unique = 1.3,
    Legendary = 1.5,
    Exclusive = 1.2,
    Event = 1.1
}
t.YieldMultiplier = 0.4
t.CraftedOreCap = 0.5
t.ScrapPerOre = { Viridium = 4, Oblivium = 4 }
t.DefaultScrapPerOre = 3
t.BlockedRarities = { Premium = true }
local t_10 = { Fist = true, ["Special Fist"] = true }
t_10["Death Dealer"] = true
t.BlockedItems = t_10

local _ = function(arg1, arg2, arg3) --[[ X ]] -- line: 100
    return { Item = arg1, Chance = arg2, Min = 1, Max = arg3 or 1 }
end

local t_12 = {}
t.Items = t_12

local function def(
    arg4,
    arg5,
    arg6,
    arg7,
    arg8
) -- line: 107
    -- upvalues:
    --  [1] t_12 (copy)

    if type(arg4) == "string" then
        arg4 = { arg4 }
    end

    for _, val in arg4 do
        local t_13 = { Region = arg5, Tier = arg6, Metal = arg7 }

        if arg8 then
            for key_1, val_1 in arg8 do
                t_13[key_1] = val_1
            end
        end

        t_12[val] = t_13
    end
end

def(
    {
        "Dull Dagger",
        "Dull Gauntlets",
        "Dull Longsword",
        "Dull Rapier",
        "Novice Blade",
        "LegendaryKata"
    },
    "Kamo",
    1,
    1
)
def({ "Katana", "Iron Mace" }, "Kamo", 1, 1)
def("Kamo Spear", "Kamo", 1, 0.5)
def("Rustic Spear", "Kamo", 1, 0.4)
def(
    "Primal Spear",
    "Kamo",
    1,
    0.4,
    { Extras = { { Item = "Wolf Pelt", Chance = 0.12, Min = 1, Max = 1 } } }
)
def("Crude Greathammer", "Kamo", 1, 0.8)
def(
    { "Assembly Blade", "Assembly Fang" },
    "Kamo",
    2,
    1,
    { Extras = { { Item = "Arcane Powder", Chance = 0.12, Min = 1, Max = 1 } } }
)
def(
    { "Bronze Ironclad Gauntlets", "Rose Ironclad Gauntlets" },
    "Kamo",
    2,
    1,
    { Bias = "Copper" }
)
def({ "Claymore", "Iron Curtain", "LegendaryBlade" }, "Kamo", 2, 1)
def("Highland Axe", "Kamo", 2, 0.8)
def(
    "Gold Trishula",
    "Kamo",
    2,
    1,
    { Bias = "Gold" }
)
def(
    "Silver Trishula",
    "Kamo",
    2,
    1,
    { Bias = "Silver" }
)
def("LegendarySpear", "Kamo", 2, 0.6)
def("Wayfarer's Scimitar", "Kamo", 2, 1)
def("Winding Thorn", "Kamo", 2, 0.8)
def(
    { "Vulcan's Knife", "Vulcan's Rapier", "Vulcan's Cutlass", "Vulcan's Greatsword" },
    "Kamo",
    2,
    1,
    { Bias = "Steel" }
)
def(
    "Vulcan's Spear",
    "Kamo",
    2,
    0.7,
    { Bias = "Steel" }
)
def({ "Purple Hachiman", "Red Hachiman" }, "Kamo", 3, 1)
def(
    "Buster Sword",
    "Kamo",
    3,
    1,
    { Rare = true, Bias = "Steel" }
)
def(
    "Cinderblade",
    "Kamo",
    3,
    0.9,
    {
        Rare = true,
        Extras = {
            { Item = "Ember Bloom", Chance = 0.35, Min = 1, Max = 2 },
            { Item = "Cinderhide", Chance = 0.12, Min = 1, Max = 1 },
            { Item = "Fiery Core", Chance = 0.08, Min = 1, Max = 1 }
        }
    }
)
def(
    { "GolemAxe", "Primeval Battleaxe" },
    "Kamo",
    3,
    0.6,
    {
        Soft = { Stone = 100 },
        Extras = { { Item = "Arcane Tear", Chance = 0.12, Min = 1, Max = 1 } }
    }
)
def(
    { "Blue Mystbloom Staff", "Pink Mystbloom Staff" },
    "Mushroom",
    2,
    0.25,
    {
        Soft = t.SoftPools.Mushroom,
        Extras = {
            { Item = "Glow Lily", Chance = 0.12, Min = 1, Max = 1 },
            { Item = "Mana Bloom", Chance = 0.1, Min = 1, Max = 1 }
        }
    }
)
def(
    { "Purple Widowbane", "Red Widowbane" },
    "Mushroom",
    2,
    0.6,
    { Extras = { { Item = "Alke Fur", Chance = 0.12, Min = 1, Max = 1 } } }
)
def("Greenbone Reaver", "Mushroom", 2, 0.6)
def("Splinterspike", "Mushroom", 3, 0.8)
def(
    "Luminous Thorn",
    "Mushroom",
    3,
    0.7,
    { Extras = { { Item = "Astral Shard", Chance = 0.1, Min = 1, Max = 1 } } }
)
def(
    { "Arachne's Venom Fang", "Aurelian Fang" },
    "Mushroom",
    3,
    0.5,
    {
        Rare = true,
        Extras = {
            { Item = "Alke Core", Chance = 0.25, Min = 1, Max = 1 },
            { Item = "Queen's Fang", Chance = 0.05, Min = 1, Max = 1 }
        }
    }
)
def(
    { "Eldrean Sickle", "Retribution Mace", "Ritual Dagger", "Skullsplitter", "Mourning Edge" },
    "Eldritch",
    1,
    1
)
def(
    "Eldritch Staff",
    "Eldritch",
    1,
    0.3,
    {
        Soft = t.SoftPools.Eldritch,
        Extras = { { Item = "Duskroot", Chance = 0.15, Min = 1, Max = 1 } }
    }
)
def(
    "Iron Suture",
    "Eldritch",
    1,
    0.6,
    { Extras = { { Item = "Elder Horn", Chance = 0.1, Min = 1, Max = 1 } } }
)
def(
    {
        "Balmung",
        "Bloodthorne",
        "Dragnipur",
        "Skullspire Blade",
        "Executioner's Axe",
        "Carnage Cleaver",
        "Wyvernmaul"
    },
    "Eldritch",
    2,
    1
)
def(
    "Wolfcrest Blade",
    "Eldritch",
    2,
    1,
    { Extras = { { Item = "Wolf Pelt", Chance = 0.1, Min = 1, Max = 1 } } }
)
def("Bone Reaper", "Eldritch", 2, 0.6)
def(
    "Elderthorne",
    "Eldritch",
    2,
    0.5,
    { Bias = "Silver", Extras = { { Item = "Elder Horn", Chance = 0.15, Min = 1, Max = 1 } } }
)
def(
    "Spectrite Sword",
    "Eldritch",
    2,
    0.8,
    { Bias = "Spectrite" }
)
def(
    "Viridium Greatsword",
    "Eldritch",
    2,
    1,
    { Bias = "Viridium" }
)
def(
    { "Elkstrider", "Wanderer's Edge" },
    "Eldritch",
    3,
    0.8,
    {
        Rare = true,
        Bias = "Silver",
        Extras = {
            { Item = "Elk Thorn", Chance = 0.15, Min = 1, Max = 1 },
            { Item = "Manaheart", Chance = 0.1, Min = 1, Max = 1 }
        }
    }
)
def(
    "Mournblade",
    "Eldritch",
    3,
    1,
    { Rare = true, Bias = "Mournite" }
)
def(
    { "Ceremonial Greataxe", "LegendaryScythe" },
    "Eldritch",
    3,
    1,
    { Rare = true }
)
def(
    {
        "Stealthy Shroud",
        "Plain Leg Wraps",
        "Faded Black Hood",
        "Veil of Stealth",
        "Twin Capes",
        "Face Wrap",
        "Marauder's Bandana"
    },
    "Kamo",
    1,
    0
)
def(
    { "Black Phantom Cape", "Green Phantom Cape", "Red Phantom Cape", "White Phantom Cape" },
    "Kamo",
    1,
    0
)
def("Rogue's Raiment", "Kamo", 1, 0.1)
def({ "Black Strider Boots", "Brown Strider Boots", "White Strider Boots" }, "Kamo", 1, 0.2)
def("Padded Bracers", "Kamo", 1, 0.3)
def({ "Eyeglasses", "Tarnished Boots" }, "Kamo", 1, 0.5)
def("Black Eyepatch", "Kamo", 1, 0.1)
def("Novice Leg Brace", "Kamo", 1, 0.6)
def({ "Stout Sabatons", "Ravager Pauldrons" }, "Kamo", 1, 0.9)
def(
    "Wolfcrest Cloak",
    "Kamo",
    1,
    0.2,
    { Extras = { { Item = "Wolf Pelt", Chance = 0.25, Min = 1, Max = 1 } } }
)
def({ "Black Apprentice Cloak", "Green Apprentice Cloak", "White Apprentice Cloak" }, "Kamo", 2, 0)
def(
    { "Black Sorcerer's Hat", "Green Sorcerer's Hat" },
    "Kamo",
    2,
    0,
    { Extras = { { Item = "Manaheart", Chance = 0.08, Min = 1, Max = 1 } } }
)
def(
    "Grand Magus Assembly Cloak",
    "Kamo",
    2,
    0,
    { Extras = { { Item = "Arcane Powder", Chance = 0.12, Min = 1, Max = 1 } } }
)
def({ "Hauno's Fitted", "Nightwing Mantle" }, "Kamo", 2, 0)
def("Primera\194\160Coat", "Kamo", 2, 0.2)
def(
    {
        "Black Enigma Mask",
        "Green Enigma Mask",
        "Red Enigma Mask",
        "White Enigma Mask",
        "Valmerian Eyepatch"
    },
    "Kamo",
    2,
    0.3
)
def(
    {
        "Bloodchaser Mask",
        "Hex Goggles",
        "Button Head",
        "Jack-o'-Bag",
        "Jack-o'-Mask",
        "Starbuckle Hat"
    },
    "Kamo",
    2,
    0.2
)
def(
    { "Earthspring Celebration Mask", "Tidal Celebration Mask", "Verdant Celebration Mask" },
    "Kamo",
    2,
    0.2
)
def(
    {
        "Black Ironclad Coat",
        "Blue Ironclad Coat",
        "Red Ironclad Coat",
        "White Ironclad Coat",
        "Midnight Coat"
    },
    "Kamo",
    2,
    0.5
)
def({ "Brigand Bracers", "Brigand Greaves", "Anti-Magic Mask" }, "Kamo", 2, 0.6)
def(
    "Millennium Pendant",
    "Kamo",
    2,
    0.8,
    { Bias = "Gold" }
)
def("Kamo Warplate", "Kamo", 2, 0.9)
def(
    "Crimson Assassin Wraps",
    "Kamo",
    3,
    0.1,
    { Extras = { { Item = "Ember Bloom", Chance = 0.35, Min = 1, Max = 2 } } }
)
def(
    "ShunEarrings",
    "Kamo",
    3,
    0.5,
    { Bias = "Gold" }
)
def("Vanguard Armguard", "Kamo", 3, 0.9)
def("Iron Lantern", "Kamo", 3, 1)
def(
    "Gold Boar Helm",
    "Kamo",
    3,
    1,
    { Bias = "Gold", Extras = { { Item = "Cinderhide", Chance = 0.12, Min = 1, Max = 1 } } }
)
def(
    "Silver Boar Helm",
    "Kamo",
    3,
    1,
    { Bias = "Silver", Extras = { { Item = "Cinderhide", Chance = 0.12, Min = 1, Max = 1 } } }
)
def(
    "Imp Helm",
    "Mushroom",
    1,
    0.7,
    { Extras = { { Item = "Nightmare Core", Chance = 0.1, Min = 1, Max = 1 } } }
)
def(
    "Alke Cape",
    "Mushroom",
    2,
    0,
    { Extras = { { Item = "Alke Fur", Chance = 0.25, Min = 1, Max = 1 } } }
)
def({ "Black Eyewraps", "Red Eyewraps", "White Eyewraps" }, "Mushroom", 2, 0)
def(
    { "Goldshroom Hat", "Loveshroom Hat", "Redshroom Hat", "Voidshroom Hat" },
    "Mushroom",
    2,
    0,
    { Extras = { { Item = "Hearthstone", Chance = 0.1, Min = 1, Max = 1 } } }
)
def(
    "Imp Mask",
    "Mushroom",
    2,
    0.5,
    { Extras = { { Item = "Nightmare Core", Chance = 0.1, Min = 1, Max = 1 } } }
)
def(
    {
        "Purple Gravitas Cuirass",
        "Purple Gravitas Cuisses",
        "Red Gravitas Cuirass",
        "Red Gravitas Cuisses"
    },
    "Mushroom",
    3,
    0.9
)
def(
    { "Arachne's Breastplate", "Arachne's Crown" },
    "Mushroom",
    3,
    0.7,
    {
        Rare = true,
        Bias = "Steel",
        Extras = {
            { Item = "Alke Core", Chance = 0.2, Min = 1, Max = 1 },
            { Item = "Alke Fur", Chance = 0.15, Min = 1, Max = 1 }
        }
    }
)
def(
    "Arachne's Greaves",
    "Mushroom",
    3,
    0.5,
    {
        Rare = true,
        Bias = "Steel",
        Extras = {
            { Item = "Alke Core", Chance = 0.2, Min = 1, Max = 1 },
            { Item = "Alke Fur", Chance = 0.2, Min = 1, Max = 1 }
        }
    }
)
def({ "Eldritch Battle Garb" }, "Eldritch", 1, 0.5)
def({ "Eldritch Legplates", "Goliath's Cuirass", "Goliath's Legplates" }, "Eldritch", 1, 0.9)
def({ "Black Warrior's Headband", "White Warrior's Headband" }, "Eldritch", 2, 0.2)
def({ "Sandveil Raiment", "Sandveil Greaves", "Traveler's Backpack" }, "Eldritch", 2, 0.3)
def("Earthsong Pendant", "Eldritch", 2, 0.8)
def({ "Black Inquisitor's Helm", "White Inquisitor's Helm" }, "Eldritch", 2, 1)
def(
    "Blightseeker's Head",
    "Eldritch",
    3,
    0.3,
    {
        Extras = {
            { Item = "Blightseeker Eye", Chance = 0.15, Min = 1, Max = 1 },
            { Item = "Plaguegourd", Chance = 0.3, Min = 1, Max = 2 }
        }
    }
)
def(
    "Warden Mask",
    "Eldritch",
    3,
    0.5,
    { Extras = { { Item = "Warden's Mask", Chance = 0.08, Min = 1, Max = 1 } } }
)
def(
    { "Saurith Chestplate", "Saurith Helmet", "Saurith Legplates" },
    "Eldritch",
    3,
    0.8,
    { Extras = { { Item = "Duskroot", Chance = 0.25, Min = 1, Max = 2 } } }
)
def(
    { "Ash Guard Breastplate", "Ash Guard Greaves", "Ash Guard Helm" },
    "Eldritch",
    3,
    0.9,
    { Extras = { { Item = "Plaguegourd", Chance = 0.25, Min = 1, Max = 2 } } }
)
def({ "Black Mongrel's Helm", "Red Mongrel's Helm" }, "Eldritch", 3, 1)
def(
    { "Ebonheart Chestplate", "Ebonheart Greaves", "Ebonheart Helmet" },
    "Eldritch",
    3,
    1,
    { Rare = true }
)

local _ = function(arg9) --[[ getInfo ]] -- line: 241
    -- upvalues:
    --  [1] Items_m (copy)

    local v3 = Items_m.AllItems[arg9]
    local v4 = v3

    if type(v3) ~= "table" or not v4 then
        v4 = nil
    end

    return v4
end

local function requiredValue(arg10) -- line: 246
    local Required = arg10.Required

    if type(Required) ~= "table" then
        return nil
    end

    if Required.Level then
        return Required.Level, "Level"
    end

    for key_2, val_2 in Required do
        if typeof(key_2) == "string" and string.find(key_2, "Proficiency") and typeof(val_2) == "number" then
            return val_2, "Proficiency"
        end
    end

    return nil
end

local function fallbackProfile(arg11) -- line: 262
    -- upvalues:
    --  [1] requiredValue (copy)

    local v5, v6 = requiredValue(arg11)
    local v7 = if arg11.Type ~= "Weapon" then 0.6 else 1

    if v6 == "Proficiency" then
        if v5 <= 2 then
            return { Region = "Kamo", Tier = 1, Metal = v7 }
        end

        if v5 <= 4 then
            return { Region = "Kamo", Tier = 2, Metal = v7 }
        end

        if v5 <= 6 then
            return { Region = "Eldritch", Tier = 2, Metal = v7 }
        end

        return { Region = "Eldritch", Tier = 3, Metal = v7 }
    else
        v5 = v5 or 10

        if v5 <= 12 then
            return { Region = "Kamo", Tier = 1, Metal = v7 }
        end

        if v5 <= 22 then
            return { Region = "Kamo", Tier = 2, Metal = v7 }
        end

        if v5 <= 31 then
            return { Region = "Mushroom", Tier = 2, Metal = v7 }
        end

        if v5 <= 40 then
            return { Region = "Eldritch", Tier = 2, Metal = v7 }
        end

        return { Region = "Eldritch", Tier = 3, Metal = v7 }
    end
end

local t_52 = { Armor = true, Weapon = true }

function t.GetBaseProfile(s3: string) -- line: 288
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] t_12 (copy)
    --  [3] fallbackProfile (copy)

    local v8 = Items_m.AllItems[s3]
    local v9 = v8

    if type(v8) ~= "table" or not v9 then
        v9 = nil
    end

    if not v9 then
        return nil
    end

    return t_12[s3] or fallbackProfile(v9), v9
end

function t.CanSmelt(s4: string) -- line: 296
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] t_52 (copy)
    --  [3] t (copy)

    local v11 = Items_m.AllItems[s4]
    local v12 = v11

    if type(v11) ~= "table" or not v12 then
        v12 = nil
    end

    if not v12 or not t_52[v12.Type] then
        return false, "Only armor and weapons can be smelted."
    end

    if t.BlockedItems[s4] or v12.Soulbound == true then
        return false, "This item is bound to you and can't be smelted."
    end

    if t.BlockedRarities[v12.Rarity] then
        return false, "Premium items can't be smelted."
    end

    return true
end

local _ = function(arg12) --[[ round ]] -- line: 310
    return (math.floor(arg12 + 0.5))
end

local function recipeOre(arg13) -- line: 315
    -- upvalues:
    --  [1] t (copy)

    local Craftsettings = arg13._craftsettings
    local v13 = Craftsettings

    if v13 then
        v13 = Craftsettings.Materials
    end

    local t_53 = {}

    if not v13 then
        return 0, t_53
    end

    local v14 = 0

    for key_3, val_3 in v13 do
        local v15 = string.match(key_3, "^(.+) Ingot$")

        if v15 then
            if t.IsOre(v15) then
                v14 += val_3 * 2
                t_53[v15] = (t_53[v15] or 0) + val_3 * 2
            elseif t.IsOre(key_3) then
                v14 += val_3
                t_53[key_3] = (t_53[key_3] or 0) + val_3
            end
        elseif t.IsOre(key_3) then
            v14 += val_3
            t_53[key_3] = (t_53[key_3] or 0) + val_3
        end
    end

    return v14, t_53
end

local t_54 = {}

for _, val_4 in t.Ores do
    for _, val_5 in val_4 do
        t_54[val_5] = true
    end
end

function t.IsOre(s5: string) -- line: 343
    -- upvalues:
    --  [1] t_54 (copy)

    return t_54[s5] == true
end

function t.GetScrapPerOre(s6: string) -- line: 347
    -- upvalues:
    --  [1] t (copy)

    return t.ScrapPerOre[s6] or t.DefaultScrapPerOre
end

local function normalize(arg14) -- line: 351
    local v18 = 0

    for _, val_6 in arg14 do
        v18 += val_6
    end

    local t_55 = {}

    if v18 <= 0 then
        return t_55
    end

    for key_7, val_7 in arg14 do
        if val_7 > 0 then
            t_55[key_7] = val_7 / v18
        end
    end

    return t_55
end

local _ = function(arg15, arg16) --[[ isRare ]] -- line: 368
    return if arg15.Rare == nil then arg16.Rarity == "Legendary" or (if arg16.Rarity ~= "Unique" then false else arg15.Tier >= 3) else arg15.Rare == true
end

function t.GetProfile(s7: string, n1: number?, n2: number?) -- line: 375
    -- upvalues:
    --  [1] t (copy)
    --  [2] recipeOre (copy)
    --  [3] normalize (copy)
    --  [4] Items_m (copy)

    local v19, v20 = t.CanSmelt(s7)

    if not v19 then
        return nil, v20
    end

    local v21, v22 = t.GetBaseProfile(s7)

    if not v21 then
        return nil, "Unknown item."
    end

    local Region = v21.Region
    local v23 = math.clamp(v21.Tier or 1, 1, 3)
    local v24 = math.clamp(v21.Metal or 1, 0, 1)
    local v25 = if v21.Rare ~= nil then if v21.Rare ~= true then false else true else v22.Rarity == "Legendary" or (if v22.Rarity ~= "Unique" then false else v21.Tier >= 3)
    local v26 = if v22.Type ~= "Weapon" then t.ArmorBase[v22.ArmorType] or 3 else t.WeaponBase[v22.MasteryType] or 6
    local v27 = t.RarityMultiplier[v22.Rarity] or 1
    local v28 = v26 * v24
    v28 = if not (v24 >= 0.5) then v28 else v28 + (v23 - 1)
    v28 = math.floor(v28 * v27 * t.YieldMultiplier + 0.5)

    if v24 >= 0.15 then
        v28 = math.max(v28, 1)
    end

    if v28 > 0 then
        v28 += math.clamp(math.floor(n1 or 0), 0, 3)
    end

    local v30 = math.floor(v26 * (1 - v24) * t.SoftShare * v27 * t.YieldMultiplier + 0.5)

    if v22.Buyable == true then
        v28 = math.ceil(v28 / 2)
        v30 = math.ceil(v30 / 2)
    end

    local v31, v32 = recipeOre(v22)

    if v31 > 0 then
        v28 = math.min(
            v28,
            (math.max(1, (math.floor(v31 * t.DefaultScrapPerOre * t.CraftedOreCap))))
        )
    end

    if v28 > 0 and (n2 or 0) > 0 then
        v28 += math.floor(v28 * n2 + 0.5)
    end

    local v35 = {}

    if v31 > 0 then
        for key_8, val_8 in v32 do
            v35[key_8] = val_8
        end
    else
        v26 = t.ScrapPools[Region]

        for key_9, val_9 in v26[v23] do
            v35[key_9] = (v35[key_9] or 0) + val_9
        end

        if v25 and v26.Rare then
            for key_10, val_10 in v26.Rare do
                v35[key_10] = (v35[key_10] or 0) + val_10
            end
        end

        if v21.Bias and t.IsOre(v21.Bias) then
            v35[v21.Bias] = (v35[v21.Bias] or 0) + t.BiasWeight
        end
    end

    local t_56 = {}

    for key_11, val_11 in normalize(v35) do
        local v36 = t.ScrapName(key_11)

        if Items_m.AllItems[v36] then
            t_56[v36] = val_11
        end
    end

    v35 = v21.Soft
    local v37

    if not v35 then
        v37 = if v22.Type ~= "Weapon" then t.SoftPools[Region] else t.SoftPools.Weapon or t.SoftPools[Region]
        v35 = v37
    end

    v37 = {}

    for key_12, val_12 in normalize(v35) do
        if Items_m.AllItems[key_12] then
            v37[key_12] = val_12
        end
    end

    v35 = {}
    local v38 = v21.Extras or {}

    for _, val_13 in v38 do
        if Items_m.AllItems[val_13.Item] then
            table.insert(v35, val_13)
        end
    end

    if v22.Type == "Armor" and v24 <= 0.2 and v30 > 0 and Items_m.AllItems.Cloth then
        table.insert(v35, { Item = "Cloth", Chance = t.ClothChance, Min = 1, Max = 1 })
    end

    if v28 <= 0 and v30 <= 0 then
        return nil, "Smelting this wouldn't return anything."
    end

    return {
        Item = s7,
        Region = Region,
        Tier = v23,
        Rare = v25,
        ScrapCount = v28,
        ScrapOdds = t_56,
        SoftCount = v30,
        SoftOdds = v37,
        Extras = v35
    }
end

local function pick(arg17, arg18) -- line: 494
    local v40 = arg18:NextNumber()
    local v41 = nil
    local t_58 = {}

    for key_14 in arg17 do
        table.insert(t_58, key_14)
    end

    table.sort(t_58)

    for _, val_14 in t_58 do
        v41 = val_14
        v40 -= arg17[val_14]

        if v40 <= 0 then
            return val_14
        end
    end

    return v41
end

function t.Roll(arg19: any, u1: userdata?) -- line: 512
    -- upvalues:
    --  [1] pick (copy)

    local v42 = u1 or Random.new()
    u1 = v42
    v42 = {}

    for _ = 1, arg19.ScrapCount do
        local _ = arg19.ScrapCount
        local v43 = pick(arg19.ScrapOdds, u1)

        if v43 then
            v42[v43] = (v42[v43] or 0) + 1
        end
    end

    for _ = 1, arg19.SoftCount do
        local _ = arg19.SoftCount
        local v44 = pick(arg19.SoftOdds, u1)

        if v44 then
            v42[v44] = (v42[v44] or 0) + 1
        end
    end

    for _, val_15 in arg19.Extras do
        if u1:NextNumber() < val_15.Chance then
            v42[val_15.Item] = (v42[val_15.Item] or 0) + u1:NextInteger(
                val_15.Min or 1,
                (math.max(val_15.Min or 1, val_15.Max or 1))
            )
        end
    end

    return v42
end

return t
