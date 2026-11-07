-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.HalloweenQuestInfo
-- Class: ModuleScript
-- bytes: 3367

local t = { ROTATION = 36000, ACTIVE = 3 }
t.Quests = {
    {
        Id = "SurviveBloodMoon",
        Kind = "SurviveBloodMoon",
        Goal = 1,
        Title = "Under the Red Moon",
        Description = "Survive a Blood Moon from rise to set without dying.",
        Reward = { CandyCorn = 1500, Insight = 30 }
    },
    {
        Id = "KillCorrupted15",
        Kind = "KillCorrupted",
        Goal = 15,
        Title = "Cleanse the Corrupted",
        Description = "Defeat 15 corrupted monsters during a Blood Moon.",
        Reward = { CandyCorn = 1000, Insight = 20 }
    },
    {
        Id = "KillCorrupted40",
        Kind = "KillCorrupted",
        Goal = 40,
        Title = "Corruption Purge",
        Description = "Defeat 40 corrupted monsters during a Blood Moon.",
        Reward = { CandyCorn = 2500, Insight = 50 }
    },
    {
        Id = "Harvest20",
        Kind = "Harvest",
        Goal = 20,
        Title = "Autumn Harvest",
        Description = "Harvest 20 candy plants.",
        Reward = { CandyCorn = 800, Insight = 15 },
        Items = {},
        Disabled = true
    },
    {
        Id = "Harvest50",
        Kind = "Harvest",
        Goal = 50,
        Title = "Bountiful Harvest",
        Description = "Harvest 50 candy plants.",
        Reward = { CandyCorn = 1800, Insight = 35 },
        Items = {},
        Disabled = true
    },
    {
        Id = "HeadlessDamage",
        Kind = "HeadlessDamage",
        Goal = 2000,
        Title = "Headhunter",
        Description = "Deal 2,000 damage to Headless.",
        Reward = { CandyCorn = 1500, Insight = 30 }
    },
    {
        Id = "HeadlessDefeat",
        Kind = "HeadlessDefeat",
        Goal = 1,
        Title = "Lay Him to Rest",
        Description = "Help defeat Headless.",
        Reward = { CandyCorn = 2500, Insight = 50 }
    },
    {
        Id = "TrickOrTreat15",
        Kind = "TrickOrTreat",
        Goal = 15,
        Title = "Door to Door",
        Description = "Trick-or-treat 15 times.",
        Reward = { CandyCorn = 1200, Insight = 20 },
        Disabled = true
    },
    {
        Id = "ReturnLostChild3",
        Kind = "ReturnLostChild",
        Goal = 3,
        Title = "Lost and Found",
        Description = "Walk 3 Lost Trick-or-Treaters back to a village.",
        Reward = { CandyCorn = 2000, Insight = 40 },
        Disabled = true
    }
}
t.ById = {}

for _, val in t.Quests do
    t.ById[val.Id] = val
end

function t.Rotation(n1: number) -- line: 108
    -- upvalues:
    --  [1] t (copy)

    return n1 // t.ROTATION
end

function t.TimeLeft(n2: number) -- line: 113
    -- upvalues:
    --  [1] t (copy)

    return t.ROTATION - n2 % t.ROTATION
end

function t.Active(n3: number) -- line: 118
    -- upvalues:
    --  [1] t (copy)

    local rng = Random.new(n3)
    local t_8 = {}

    for _, val_1 in t.Quests do
        if not val_1.Disabled then
            table.insert(t_8, val_1)
        end
    end

    local t_9 = {}
    local t_10 = {}

    while true do
        if not (#t_9 < t.ACTIVE) then
            break
        end

        if not (#t_8 > 0) then
            break
        end

        local v2 = table.remove(t_8, rng:NextInteger(1, #t_8))

        if t_10[v2.Kind] then
            continue
        end

        t_10[v2.Kind] = true
        table.insert(t_9, v2)
    end

    return t_9
end

return t
