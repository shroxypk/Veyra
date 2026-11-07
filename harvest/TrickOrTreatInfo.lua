-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.TrickOrTreatInfo
-- Class: ModuleScript
-- bytes: 6084

local t = {
    ENABLED = false,
    STAT = "HalloweenTrickJournal",
    CATEGORY = "Trick-or-Treat",
    Sections = {
        { Id = "Npcs", Name = "Trick-or-Treaters", Title = "Nightwalker" },
        { Id = "Tricks", Name = "Tricks", Title = "Dreadbringer" },
        { Id = "Treats", Name = "Treats", Title = "Harvester" }
    },
    JournalTitle = "Witchborn",
    Entries = {
        {
            Id = "KamoGiver",
            Section = "Npcs",
            Name = "Kamo Villager",
            Hint = "Someone in Kamo Village has a full candy bowl.",
            Description = "Kamo's villagers hand candy to anyone brave enough to knock, as long as they ask nicely."
        },
        {
            Id = "DewcapGiver",
            Section = "Npcs",
            Name = "Dewcap Mushmite",
            Hint = "Little caps in Dewcap Village carry baskets tonight.",
            Description = "The Mushmites of Dewcap Village fill their baskets with candy grown in the damp. Most of it is safe to eat."
        },
        {
            Id = "ForsakenGiver",
            Section = "Npcs",
            Name = "Forsaken Resident",
            Hint = "A lantern glows where nobody should still live.",
            Description = "The ghosts of the Forsaken Village still keep the old custom. They trick more often, and pay better when they don't."
        },
        {
            Id = "LostChild",
            Section = "Npcs",
            Name = "Lost Trick-or-Treater",
            Hint = "A small voice crying in the wild, far from any village.",
            Description = "A child who wandered off with an empty bag. Walk them back to any village and their family pays well, more the further you came."
        },
        {
            Id = "Witch",
            Section = "Npcs",
            Name = "Wandering Witch",
            Hint = "Smoke rises from a cauldron out in the wilds.",
            Description = "A witch on the road between villages. Ask for a treat, or ask what's brewing: ingredients, or a sip of something strange."
        },
        {
            Id = "Peddler",
            Section = "Npcs",
            Name = "Hollow Peddler",
            Hint = "A merchant with no face sells mystery treats.",
            Description = "He takes 500 Candy Corn for a wrapped treat. What's inside is up to luck. Some say he once sold a Harvest Effigy."
        },
        {
            Id = "Spooked",
            Section = "Tricks",
            Name = "Spooked",
            Hint = "Some villagers would rather scare you than feed you.",
            Description = "A sudden scare leaves you frozen with fear for a few seconds. The prankster runs off laughing and drops a little candy."
        },
        {
            Id = "ThrallAmbush",
            Section = "Tricks",
            Name = "Thrall Ambush",
            Hint = "Knock on the wrong door and the dead answer.",
            Description = "The ground opens and the Horseman's servants climb out: a Headless Thrall, or a pack of Pumpkin Shades."
        },
        {
            Id = "ManaLeech",
            Section = "Tricks",
            Name = "Mana Leech",
            Hint = "Not every treat bag holds candy.",
            Description = "A Mana Leech pours out of the bag and goes straight for your mana."
        },
        {
            Id = "CandyThief",
            Section = "Tricks",
            Name = "Candy Thief",
            Hint = "Keep a hand on your Candy Corn.",
            Description = "An imp snatches some of your Candy Corn and flies off with it. Catch it on a broom to get it back, with interest."
        },
        {
            Id = "Riddle",
            Section = "Treats",
            Name = "Riddle Answered",
            Hint = "Some would rather test your wits than your manners.",
            Description = "Answer a trick-or-treat riddle right for a double treat. Get it wrong and they play a small trick instead."
        },
        {
            Id = "Pouch",
            Section = "Treats",
            Name = "Candy Corn Pouch",
            Hint = "Sometimes they give a little more than a handful.",
            Description = "A whole pouch of Candy Corn from a generous trick-or-treat."
        },
        {
            Id = "Sack",
            Section = "Treats",
            Name = "Candy Corn Sack",
            Hint = "A rare, very generous door.",
            Description = "A sack of Candy Corn from a trick-or-treat. Someone emptied their whole pantry."
        },
        {
            Id = "Trove",
            Section = "Treats",
            Name = "Candy Corn Trove",
            Hint = "Legends tell of a door that never stops giving.",
            Description = "A trove of Candy Corn, the rarest treat of the night."
        }
    },
    ById = {}
}

for key, val in t.Entries do
    val.Order = key
    t.ById[val.Id] = val
end

function t.Parse(arg1) -- line: 136
    -- upvalues:
    --  [1] t (copy)

    local t_1 = {}

    if typeof(arg1) ~= "string" then
        return t_1
    end

    for key_1, val_1 in string.gmatch(arg1, "([%w_]+):(%d+)") do
        if t.ById[key_1] then
            t_1[key_1] = tonumber(val_1)
        end
    end

    return t_1
end

function t.Format(t1: table) -- line: 149
    -- upvalues:
    --  [1] t (copy)

    local t_2 = {}

    for _, val_2 in t.Entries do
        local v1 = t1[val_2.Id]

        if v1 and v1 > 0 then
            table.insert(t_2, `{val_2.Id}:{v1}`)
        end
    end

    return table.concat(t_2, ",")
end

function t.EarnedTitles(t2: table) -- line: 161
    -- upvalues:
    --  [1] t (copy)

    local t_3 = {}
    local v3 = true

    for _, val_3 in t.Sections do
        local v4 = true

        for _, val_4 in t.Entries do
            if val_4.Section == val_3.Id and (not t2[val_4.Id] or not (t2[val_4.Id] > 0)) then
                v4 = false
                v3 = false
            end
        end

        if v4 then
            table.insert(t_3, val_3.Title)
        end
    end

    if v3 then
        table.insert(t_3, t.JournalTitle)
    end

    return t_3
end

return t
