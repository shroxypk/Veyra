-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.QueueData
-- Class: ModuleScript
-- bytes: 11813

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local _ = game:GetService("ServerStorage")
local _ = game:GetService("HttpService")
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)
local t = {}
local t_1 = {}
t_1.__index = t_1
t_1.Ratings = { "F", "D", "C", "B", "A" }
local t_2 = {
    index = "F",
    description = "Introduction to missions",
    requirements = { level = 0, rank = 1 },
    missions = nil,
    pool = nil,
    TicketRequired = false
}
local t_3 = {}
t_3.Tutorial = {
    index = "First Assignment",
    description = "Travelers have reported attacks along the nearby roads. Find those responsible and put an end to them.",
    timeToComplete = 480,
    maxPlayers = 1,
    rewards = { XP = 245, MissionXP = 175, Marks = 15 },
    difficulty = 1
}
t_2.missions = t_3
t_2.pool = { index = "Missions E", Min = 7 }
local t_6 = {
    index = "E",
    description = "Participate in low-level missions",
    requirements = { level = 1, rank = 2 },
    missions = nil,
    promotion = "Promotion1",
    pool = nil,
    TicketRequired = true
}
local t_7 = {}
t_7.BossHunt1 = {
    index = "Boss Hunt",
    description = "Hunt down and defeat a powerful mini-boss located somewhere within the region.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 180, MissionXP = 130, Marks = 15 },
    difficulty = 1,
    rigData = { Health = 280, HealthIncrement = 100, Rank = "Easy" }
}
local t_9 = {
    index = "Monster Extermination",
    description = "Eliminate several groups of randomly selected monsters native to the region.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 175, MissionXP = 125, Marks = 15 },
    difficulty = 1,
    rigData = nil
}
local t_10 = { HealthIncrement = 50, npcs = { { Wolf_Event = 2 } } }
t_9.rigData = t_10
t_7.MonsterExtermination1 = t_9
local t_12 = {
    index = "Elite Elimination",
    description = "Defeat several elite enemies that have been terrorizing the surrounding area.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 175, MissionXP = 125, Marks = 15 },
    difficulty = 1,
    rigData = nil
}
local t_13 = { HealthIncrement = 50, npcs = { ["Thief Brute"] = 2 } }
t_12.rigData = t_13
t_7.EliteElimination1 = t_12
t_7.OutpostAssault = {
    index = "Outpost Assault",
    description = "Assault a hostile outpost occupied by enemy forces.",
    timeToComplete = 320,
    maxPlayers = 4,
    rewards = { XP = 260, MissionXP = 185, Marks = 15 },
    difficulty = 2,
    rigData = { Health = 140, HealthIncrement = 25 }
}
t_6.missions = t_7
t_6.pool = { index = "Missions E", Min = 7 }
local t_16 = {
    index = "D",
    description = "Participate in intermediate-level missions",
    requirements = { level = 18, rank = 3 },
    missions = nil,
    promotion = "Promotion2",
    pool = nil,
    TicketRequired = true
}
local t_17 = {}
t_17.BossHunt2 = {
    index = "Boss Hunt",
    description = "Hunt down and defeat a powerful mini-boss located somewhere within the region.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 295, MissionXP = 210, Marks = 15 },
    difficulty = 2,
    rigData = { Health = 400, HealthIncrement = 125, Rank = "Intermediate" }
}
local t_19 = {
    index = "Monster Extermination",
    description = "Eliminate several groups of randomly selected monsters native to the region.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 245, MissionXP = 175, Marks = 15 },
    difficulty = 2,
    rigData = nil
}
local t_20 = {
    HealthIncrement = 50,
    npcs = { { ["Blackfyre Boar Event"] = 2 }, { Wolf_Event = 4 }, { GolemAssemblyMission = 1 } }
}
t_19.rigData = t_20
t_17.MonsterExtermination2 = t_19
local t_24 = {
    index = "Elite Elimination",
    description = "Defeat several elite enemies that have been terrorizing the surrounding area.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 265, MissionXP = 190, Marks = 15 },
    difficulty = 1,
    rigData = nil
}
local t_25 = { HealthIncrement = 50, npcs = { ["Sentinel Brute"] = 3 } }
t_24.rigData = t_25
t_17.EliteElimination2 = t_24
local t_27 = {
    index = "Corrupted Zone Purge",
    description = "A powerful Corrupted monster is spreading terror throughout the area.",
    timeToComplete = 270,
    maxPlayers = 4,
    rewards = { XP = 335, MissionXP = 240, Marks = 15 },
    difficulty = 3,
    rigData = { HealthIncrement = 50, npcs = { "GolemAssemblyMission" } }
}
t_17.CorruptedZonePurge1 = t_27
t_17.RescueOperation = {
    index = "Rescue Operation",
    description = "Locate captured civilians within an enemy encampment.",
    timeToComplete = 420,
    maxPlayers = 4,
    rewards = { XP = 365, MissionXP = 260, Marks = 15 },
    difficulty = 3,
    rigData = { HealthIncrement = 25 }
}
t_16.missions = t_17
t_16.pool = { index = "Missions D", Min = 7, MaxBonus = 1 }
local t_30 = {
    index = "C",
    description = "Participate in advanced-level missions",
    requirements = { level = 36, rank = 4 },
    missions = nil,
    promotion = "Promotion3",
    pool = nil,
    TicketRequired = true
}
local t_31 = {}
t_31.BossHunt3 = {
    index = "Boss Hunt",
    description = "Hunt down and defeat a powerful mini-boss located somewhere within the region.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 352, MissionXP = 230, Marks = 15 },
    difficulty = 2,
    rigData = {
        Health = 650,
        HealthIncrement = 150,
        Strength = nil,
        Rank = "Hard",
        DamageMultiplier = 0.8
    }
}
local t_33 = {
    index = "Monster Extermination",
    description = "Eliminate several groups of randomly selected monsters native to the region.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 352, MissionXP = 230, Marks = 15 },
    difficulty = 2,
    rigData = nil
}
local t_34 = {
    HealthIncrement = 50,
    npcs = {
        { AlkeEvent = 2 },
        { MushmiteRed = 3 },
        { MushmiteRed = 1, MushknightPurple = 1 },
        { MushknightBlue = 1, MushknightRed = 1 }
    },
    DamageMultiplier = 0.8
}
t_33.rigData = t_34
t_31.MonsterExtermination3 = t_33
local t_39 = {
    index = "Arcane Containment",
    description = "An unstable magical anomaly has formed in the region. Defeat waves of creatures drawn to the anomaly.",
    timeToComplete = 300,
    maxPlayers = 4,
    rewards = { XP = 418, MissionXP = 270, Marks = 15 },
    difficulty = 3,
    rigData = {
        HealthIncrement = 50,
        Strength = nil,
        npcs = {
            "AlkeEvent",
            "MushknightBlue",
            "MushknightPurple",
            "MushknightRed",
            "MushmiteGold"
        },
        DamageMultiplier = 0.8
    }
}
t_31["Arcane Containment"] = t_39
local t_41 = {
    index = "Village Defense",
    description = "Defend a village from multiple waves of invading monsters.",
    timeToComplete = 420,
    maxPlayers = 4,
    rewards = { XP = 616, MissionXP = 400, Marks = 15 },
    difficulty = 4,
    rigData = nil
}
local t_42 = {
    HealthIncrement = 100,
    DamageMultiplier = 0.8,
    Waves = {
        { AlkeEvent = 1, MushmiteRed = 1 },
        { MushknightPurple = 1, MushknightRed = 1 },
        { AlkeEvent = 1 }
    }
}
t_41.rigData = t_42
t_31["Village Defense"] = t_41
t_30.missions = t_31
t_30.pool = { index = "Missions C", Min = 8 }
local t_46 = {
    index = "B",
    description = "Participate in expert-level missions",
    requirements = { level = 50, rank = 5 },
    missions = nil,
    promotion = nil,
    pool = nil,
    TicketRequired = true
}
local t_47 = {}
t_47.BossHunt4 = {
    index = "Boss Hunt",
    description = "Hunt down and defeat a powerful mini-boss located somewhere within the region.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 540, MissionXP = 295, Marks = 15 },
    difficulty = 1,
    rigData = {
        Health = 850,
        HealthIncrement = 150,
        Strength = nil,
        Rank = "Master",
        DamageMultiplier = 0.85
    }
}
local t_49 = {
    index = "Monster Extermination",
    description = "Eliminate several groups of randomly selected monsters native to the region.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 495, MissionXP = 270, Marks = 15 },
    difficulty = 2,
    rigData = nil
}
local t_50 = {
    HealthIncrement = 50,
    npcs = {
        { Hollowseer = 1, ["Eldritch Brute"] = 1 },
        { ["High Ogre"] = 1 },
        { Grovewarden = 2 },
        { Blightseeker = 1 }
    },
    DamageMultiplier = 0.85
}
t_49.rigData = t_50
t_47.MonsterExtermination4 = t_49
local t_55 = {
    index = "Elite Elimination",
    description = "Defeat several elite enemies that have been terrorizing the surrounding area.",
    timeToComplete = 240,
    maxPlayers = 4,
    rewards = { XP = 505, MissionXP = 280, Marks = 15 },
    difficulty = 1,
    rigData = nil
}
local t_56 = { HealthIncrement = 50, npcs = { ["Eldritch Brute"] = 3 }, DamageMultiplier = 0.85 }
t_55.rigData = t_56
t_47.EliteElimination3 = t_55
local t_58 = {
    index = "Corrupted Zone Purge",
    description = "A powerful Corrupted monster is spreading terror throughout the area.",
    timeToComplete = 300,
    maxPlayers = 4,
    rewards = { XP = 735, MissionXP = 405, Marks = 15 },
    difficulty = 2,
    rigData = {
        HealthIncrement = 50,
        npcs = { "BlightseekerEvent", "Hollowseer", "High Ogre" },
        DamageMultiplier = 0.85
    }
}
t_47.CorruptedZonePurge2 = t_58
t_46.missions = t_47
t_46.pool = { index = "Missions B", Min = 9 }
t_1.Ranks = { t_2, t_6, t_16, t_30, t_46 }

local function init() -- line: 570
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t (copy)

    for _, val in t_1.Ranks do
        local Requirements = val.requirements
        local Missions = val.missions

        if Missions then
            for key_1, val_1 in Missions do
                val_1.level = Requirements.level
                val_1.rank = Requirements.rank
                t[key_1] = val_1
            end
        end
    end
end

init()

function t_1.GetMission(_, arg2) -- line: 586
    -- upvalues:
    --  [1] t (copy)

    for _, val_2 in t do
        if val_2.index == arg2 then
            return val_2
        end
    end

    return t[arg2]
end

function t_1.GetRankMissions(arg3, arg4) -- line: 596
    local v2 = arg3.Ranks[arg4]

    if v2 then
        return v2.missions
    end
end

function t_1.GetPromotion(arg5, arg6) -- line: 603
    -- upvalues:
    --  [1] StatManager_m (copy)

    local MissionRank = StatManager_m.require(arg6):GetStat("MissionRank")
    local v3 = arg5.Ranks[MissionRank]

    if v3 then
        return v3.promotion
    end
end

function t_1.IsMissionInRank(_, _, _) -- line: 615
end

function t_1.CanPromote(_, arg11) -- line: 618
    -- upvalues:
    --  [1] StatManager_m (copy)

    local v4 = StatManager_m.require(arg11)

    return v4:GetStat("MissionXP") >= v4:GetStat("MissionMXP") and true
end

function t_1.CanDoMission(arg12, arg13, arg14) -- line: 627
    -- upvalues:
    --  [1] StatManager_m (copy)

    if not tonumber(arg14) then
        return
    end

    local v6 = StatManager_m.require(arg13)
    local _ = v6:GetStat("MissionRank")
    local v7 = arg12.Ranks[arg14]
    local TicketRequired = v7.TicketRequired
    local Level = v7.requirements.level
    local Rank = v7.requirements.rank
    local MissionRank_2 = v6:GetStat("MissionRank")

    if TicketRequired and v6:GetStat("MissionTickets") < 1 then
        return false
    end

    if v6:GetStat("Level") >= Level and Rank <= MissionRank_2 then
        return true
    end
end

return t_1
