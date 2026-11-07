-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.HalloweenRewards
-- Class: ModuleScript
-- bytes: 9639

local t = { HUSK_ENABLED = false, THRALL_ENABLED = false }
t.Shop = {
    ROTATION = 1800,
    SLOTS = 4,
    Items = {
        { Item = "Jack-o'-Mask", Price = 8000 },
        { Item = "Jack-o'-Bag", Price = 8000 },
        { Item = "Button Head", Price = 8000 },
        { Item = "Bloodchaser Mask", Price = 6000 },
        { Item = "Hex Goggles", Price = 6000 },
        { Item = "Starbuckle Hat", Price = 15000 },
        { Item = "Nightwing Mantle", Price = 12000 },
        { Item = "Coffin Pack", Price = 10000 },
        { Item = "Jack-o'-Lantern", Price = 8000 },
        { Item = "Gloomheart Earrings", Price = 6000 },
        { Item = "Runebound Wraps", Price = 8000 },
        { Item = "Hexfeather Broom", Price = 15000 }
    },
    Chest = {
        Name = "Horseman's Hoard",
        Description = "7-12 of the Headless Horseman's spoils, 2 pieces of end-game gear and extra supplies, for you alone.",
        Price = 40000
    }
}
local t_2 = {
    Drops = { 3, 5 },
    Items = {
        Manaheart = 20,
        Stone = 14,
        Wood = 14,
        Silver = 12,
        Gold = 10,
        Ashenstone = 10,
        Diamond = 8,
        Cloth = 8,
        Mournite = 6,
        ["Black Eyepatch"] = 5,
        Eyeglasses = 5,
        ["Valmerian Eyepatch"] = 4,
        ["Marauder's Bandana"] = 3,
        ["Face Wrap"] = 2,
        ["Green Sorcerer's Hat"] = 1.5,
        ["Millennium Pendant"] = 1,
        ["Family Name Reroll"] = 0.5
    }
}
t.Filler = t_2
local t_4 = {
    Drops = { 2, 2 },
    Items = {
        ["Ebonheart Chestplate"] = 6,
        ["Ebonheart Greaves"] = 6,
        ["Ebonheart Helmet"] = 4,
        ["Saurith Chestplate"] = 6,
        ["Saurith Helmet"] = 6,
        ["Saurith Legplates"] = 6,
        ["Goliath's Cuirass"] = 6,
        ["Goliath's Legplates"] = 6,
        ["Wolfcrest Cloak"] = 5,
        ["Arachne's Breastplate"] = 2,
        ["Arachne's Crown"] = 2,
        ["Arachne's Greaves"] = 2,
        ["Wolfcrest Blade"] = 3,
        Cinderblade = 3,
        ["Vulcan's Greatsword"] = 3,
        ["Buster Sword"] = 3,
        Wyvernmaul = 3,
        ["Carnage Cleaver"] = 3,
        ["Highland Axe"] = 3,
        ["Executioner's Axe"] = 2.5,
        ["Primeval Battleaxe"] = 2.5,
        Splinterspike = 2.5,
        ["Greenbone Reaver"] = 2,
        Mournblade = 2,
        ["Ceremonial Greataxe"] = 2
    }
}
t.HoardGear = t_4

function t.AddRoll(
    arg1: any,
    arg2: any,
    arg3: any,
    n1: number?,
    n2: number?
) -- line: 112
    local v1 = math.random(arg3.Drops[1], arg3.Drops[2])

    for key, val in (arg1.new(
        arg3.Items,
        v1,
        v1,
        n1,
        n2
    )) do
        local v2 = arg2[key]

        if v2 then
            if typeof(v2) == "table" then
                if typeof(val) == "table" and (v2.Stock and val.Stock) then
                    v2.Stock += val.Stock
                elseif not v2 then
                    arg2[key] = val
                end
            elseif not v2 then
                arg2[key] = val
            end
        elseif not v2 then
            arg2[key] = val
        end
    end

    return arg2
end

function t.RollChance(arg4: any, s1: string) -- line: 128
    local v3 = arg4.Items[s1]

    if not v3 then
        return 0
    end

    local v4 = 0

    for _, val_1 in arg4.Items do
        v4 += val_1
    end

    local v5 = v3 / v4
    local v6 = 0
    local v7 = 0

    for index = arg4.Drops[1], arg4.Drops[2] do
        v6 += 1 - (1 - v5) ^ index
        v7 += 1
    end

    return v6 / v7
end

function t.Shop.Rotation(n3: number) -- line: 146
    -- upvalues:
    --  [1] t (copy)

    return n3 // t.Shop.ROTATION
end

function t.Shop.TimeLeft(n4: number) -- line: 150
    -- upvalues:
    --  [1] t (copy)

    return t.Shop.ROTATION - n4 % t.Shop.ROTATION
end

function t.Shop.Active(n5: number) -- line: 155
    -- upvalues:
    --  [1] t (copy)

    local rng = Random.new(n5)
    local t_6 = table.clone(t.Shop.Items)
    local t_7 = {}

    while true do
        if not (#t_7 < t.Shop.SLOTS) then
            break
        end

        if not (#t_6 > 0) then
            break
        end

        table.insert(t_7, table.remove(t_6, rng:NextInteger(1, #t_6)))
    end

    return t_7
end

local t_8 = { Tiers = nil }
local t_13 = {
    Id = "RavensDue",
    Goal = 115000,
    Name = "Raven's Due",
    Type = "Rerolls",
    Description = "The crows always come to collect.",
    Grants = { Items = { { "Locked Magic Reroll", 2 } }, LockedEssence = 600 },
    Contents = { "2 Locked Magic Rerolls", "600 Locked Essence" }
}
local t_19 = {
    Id = "FortunesFavor",
    Goal = 135000,
    Name = "Fortune's Favor",
    Type = "Spins",
    Description = "The night is generous to those who stay out late.",
    Grants = { Spins = 4, Items = { { "Locked Magic Reroll", 4 } } },
    Contents = { "4 Race Spins", "4 Locked Magic Rerolls" }
}
local t_22 = {
    Id = "WitchingHour",
    Goal = 200000,
    Name = "Witching Hour",
    Type = "Spins",
    Description = "When the clock strikes, fortune turns.",
    Grants = { Spins = 2, Items = { { "Locked Magic Reroll", 2 } }, LockedEssence = 600 },
    Contents = { "2 Race Spins", "2 Locked Magic Rerolls", "600 Locked Essence" }
}
t_8.Tiers = {
    {
        Id = "CandySatchel",
        Goal = 7500,
        Name = "Candy Satchel",
        Type = "Locked Essence",
        Description = "A little something for your first night out.",
        Grants = { LockedEssence = 150, Marks = 500 },
        Contents = { "150 Locked Essence", "500 Marks" }
    },
    {
        Id = "TrickOrTreater",
        Goal = 15000,
        Name = "Trick or Treater",
        Type = "Title",
        Description = "A sweet start to a darker season.",
        Grants = { Title = "Trick or Treater", Marks = 1000 },
        Contents = { "\"Trick or Treater\" Title", "1,000 Marks" }
    },
    {
        Id = "WitchsBrew",
        Goal = 30000,
        Name = "Witch's Brew",
        Type = "Rerolls",
        Description = "Stirred under a red moon.",
        Grants = { Items = { { "Locked Magic Reroll", 2 } }, LockedEssence = 350 },
        Contents = { "2 Locked Magic Rerolls", "350 Locked Essence" }
    },
    {
        Id = "HollowHarvest",
        Goal = 45000,
        Name = "Hollow Harvest",
        Type = "Locked Essence",
        Description = "The fields give up what they've grown in the dark.",
        Grants = { LockedEssence = 400, Marks = 1000 },
        Contents = { "400 Locked Essence", "1,000 Marks" }
    },
    {
        Id = "SpectralCompanions",
        Goal = 65000,
        Name = "Spectral Companions",
        Type = "Back Accessory",
        Description = "Restless spirits, drawn to those who embrace the night.",
        Grants = { Item = "Spectral Companions", Title = "Spirit Caller", Marks = 2500 },
        Contents = {
            "Spectral Companions (Back Accessory)",
            "\"Spirit Caller\" Title",
            "2,500 Marks"
        }
    },
    {
        Id = "LanternLight",
        Goal = 90000,
        Name = "Night Flight",
        Type = "Broom",
        Description = "Hold on tight and let the night wind carry you.",
        Grants = { Item = "Batwing Parasol", Spins = 2, LockedEssence = 400 },
        Contents = { "Batwing Parasol (Broom)", "2 Race Spins", "400 Locked Essence" }
    },
    t_13,
    t_19,
    {
        Id = "MoonlitHoard",
        Goal = 165000,
        Name = "Moonlit Hoard",
        Type = "Locked Essence",
        Description = "Everything the night left behind.",
        Grants = { LockedEssence = 900, Marks = 2500 },
        Contents = { "900 Locked Essence", "2,500 Marks" }
    },
    t_22,
    {
        Id = "GravesGift",
        Goal = 250000,
        Name = "Grave's Gift",
        Type = "Locked Essence",
        Description = "What the restless dead leave to the living.",
        Grants = { LockedEssence = 1600, Marks = 5000 },
        Contents = { "1,600 Locked Essence", "5,000 Marks" }
    },
    {
        Id = "HallowedBloodline",
        Goal = 300000,
        Name = "Haunted Bloodline",
        Type = "Race Variant",
        Preview = "RacePreview",
        Description = "Unlocks the Halloween variant of every race. You still need the race to wear it.",
        Grants = { RaceVariant = true, Title = "Haunted" },
        Contents = { "Halloween variant for every race", "\"Haunted\" Title" }
    }
}
t.Pass = t_8
local t_26 = { "TrickOrTreater", "SpectralCompanions", "FortunesFavor", "HallowedBloodline" }
local t_27 = {}
local _ = { "Halloween variant for every race", "\"Haunted\" Title" }

for key_2, val_2 in t.Pass.Tiers do
    t_27[val_2.Id] = key_2
end

function t.Pass.IndexOf(s2: string) -- line: 303
    -- upvalues:
    --  [1] t_27 (copy)

    return t_27[s2]
end

function t.Pass.ParseClaimed(s3: string?) -- line: 308
    -- upvalues:
    --  [1] t_26 (copy)
    --  [2] t_27 (copy)

    local t_29 = {}

    for _, val_3 in string.split(s3 or "", ",") do
        val_3 = string.gsub(val_3, "%s", "")
        local num = tonumber(val_3)
        local v9 = if num then t_26[num] else val_3

        if v9 and t_27[v9] then
            t_29[v9] = true
        end
    end

    return t_29
end

function t.Pass.FormatClaimed(arg5) -- line: 321
    -- upvalues:
    --  [1] t_27 (copy)

    local t_30 = {}

    for key_4 in arg5 do
        if t_27[key_4] then
            table.insert(t_30, key_4)
        end
    end

    table.sort(t_30, function(arg6, arg7) -- line: 328
        -- upvalues:
        --  [1] t_27 (ref)

        return t_27[arg6] < t_27[arg7]
    end)

    return table.concat(t_30, ",")
end

return t
