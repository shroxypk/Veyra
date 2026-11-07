-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.TraitInfo
-- Class: ModuleScript
-- bytes: 6332

local _ = require(game:GetService("ReplicatedStorage").Modules.Basic)
local t = {}
local t_1 = {
    Class = "Magus",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Parrying or dodging an attack now restores 5% of your mana.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_2 = {}
local _ = {}
t_2.Stat = { Level = 30, Intelligence = 10 }
t_2.Points = 9
t_2.Marks = 50
t_1.Required = t_2
t_1.Restrictions = {}
t["Arcane Rebound"] = t_1
local t_5 = {
    Class = "Silver Tongue",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your overwhelming influence ensures 15% higher rates when selling goods to merchants.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Image = _G.misc_icon,
    Required = { Points = 3 },
    Restrictions = {}
}
t["Bargain Master"] = t_5
local t_7 = {
    Class = "Cataclyst",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your mana bombs now scale with your Intelligence, allowing each explosion to reflect the Bombmaker's calculated power.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Required = { Quest = "Asami", Points = 4 },
    Restrictions = {}
}
t["Bombmaker's Manifesto"] = t_7
local t_9 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "While out of combat with your grimoire hidden, the next spell you use will deal 15% more damage.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Image = _G.mob_icon,
    Required = nil,
    Restrictions = nil
}
local t_10 = {}
t_10.Stat = { ["Magic Power"] = 30 }
t_10.Points = 4
t_9.Required = t_10
t_9.Restrictions = {}
t["Dirty Casting"] = t_9
local t_12 = {
    Class = "Cataclyst",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "You have a 25% chance to not consume a bomb when using it.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_13 = {}
t_13.Prereq = { ["Bombmaker's Manifesto"] = 0 }
t_13.Points = 4
t_12.Required = t_13
t_12.Restrictions = {}
t["Efficient Ignition"] = t_12
local t_15 = {
    Class = "Hardhat",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Grants a 30% chance to yield double the ore when mining.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Image = _G.misc_icon,
    Required = nil,
    Restrictions = nil
}
local t_16 = {}
t_16.Stat = { Level = 35 }
t_16.Points = 4
t_15.Required = t_16
t_15.Restrictions = {}
t["Lucky Miner"] = t_15
local t_18 = {
    Class = "Magus",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Gain 5% damage reduction towards magic-based attacks.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Image = "",
    Required = { Quest = "Ragnar", Points = 9 },
    Restrictions = {}
}
t.Spellguard = t_18
local t_20 = {
    Class = "Monster Hunter",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Deal 10% more damage to mobs.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Image = _G.mob_icon,
    Required = nil,
    Restrictions = nil
}
local t_21 = {}
t_21.Stat = { NPCKills = 150 }
t_21.Points = 4
t_20.Required = t_21
t_20.Restrictions = {}
t["Mob Slayer"] = t_20
local t_23 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "While out of combat, you regenerate health twice as fast.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_24 = {}
t_24.Stat = { Vitality = 15 }
t_24.Points = 4
t_24.Marks = 200
t_23.Required = t_24
t_23.Restrictions = {}
t.Pacifist = t_23
local t_26 = {
    Class = "",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your resolve meter passively decreases 20% faster.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Image = _G.weapon_icon,
    Required = nil,
    Restrictions = nil
}
local t_27 = {}
t_27.Stat = { Level = 30, Endurance = 10 }
t_27.Points = 4
t_26.Required = t_27
t_26.Restrictions = {}
t.Steadfast = t_26
local t_29 = {
    Class = "Magus",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "When attacking an opponent with the same magic as you, deal 5% more damage.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_30 = {}
t_30.Stat = { Intelligence = 20 }
t_30.Points = 4
t_29.Required = t_30
t_29.Restrictions = {}
t["Superiority Complex"] = t_29
local t_32 = {
    Class = "Executioner",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Execution speed is 20% faster.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Image = _G.agil_icon,
    Required = nil,
    Restrictions = nil
}
local t_33 = {}
t_33.Stat = { PlayerKills = 10 }
t_33.Points = 4
t_32.Required = t_33
t_32.Restrictions = {}
t["Swift Execution"] = t_32
local t_35 = {
    Class = "Misc",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "Your flying speed on a broom is increased by 15%.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Image = _G.misc_icon,
    Required = { Quest = "Daeron the Darling", Points = 1 },
    Restrictions = {}
}
t.Tailwind = t_35
local t_37 = {
    Class = "Weaponmaster",
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "You are a natural with weapons. You gain weapon proficiency 50% faster.",
    Skillset = "Trait Passive",
    Type = "Trait",
    Required = nil,
    Restrictions = nil
}
local t_38 = {}
t_38.Stat = { Level = 8 }
t_38.Points = 1
t_37.Required = t_38
t_37.Restrictions = {}
t["Weapons Expert"] = t_37
local v1 = t

local function init() -- line: 327
    -- upvalues:
    --  [1] v1 (ref)

    for _, val in script:QueryDescendants("ModuleScript") do
        for key_1, val_1 in require(val) do
            v1[key_1] = val_1
            v1[key_1].Skillset = "Trait Passive"
            v1[key_1].Type = "Trait"
        end
    end
end

init()

return v1
