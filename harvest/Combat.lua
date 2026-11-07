-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Professions.Combat
-- Class: ModuleScript
-- bytes: 2769

local t = {
    Title = "Combat Warrior",
    Noun = "Fighter",
    Icon = "rbxassetid://124934889121434",
    Color = Color3.fromRGB(175, 91, 95),
    Desc = "Your mastery of combat against the hostile creatures of the world.",
    XPMultiplier = 1.5,
    Gathers = true,
    Core = { Key = "pve_damage", PerLevel = 0.005, Label = "PvE Damage" },
    Skills = nil,
    Challenges = nil
}
local t_1 = {}
t_1[3] = { Desc = "Out-of-combat regen starts 3s sooner", Attributes = { regen_delay = 3 } }
t_1[4] = { Desc = "+5% Marks from NPC kills", Attributes = { marks_bonus = 0.05 } }
t_1[5] = { Desc = "In-combat time from NPCs -5s", Attributes = { combat_tag_reduction = 5 } }
t_1[7] = { Desc = "NPC kills restore 10% energy", Attributes = { energy_on_kill = 0.1 } }
t_1[8] = {
    Name = "Hunter's Mark",
    Desc = "The last NPC you hit is visible through walls for 10s",
    Attributes = { hunters_mark = 1 }
}
t_1[10] = {
    Name = "Bloodthirst",
    Desc = "Health packs from NPCs heal 15% more",
    Attributes = { healthpack_bonus = 0.15 }
}
t_1[12] = { Desc = "-5% damage taken from NPCs", Attributes = { npc_damage_reduction = 0.05 } }
t_1[13] = { Desc = "+5% Marks from NPCs (10% total)", Attributes = { marks_bonus = 0.05 } }
t_1[14] = { Desc = "+5% damage to bosses", Attributes = { boss_damage = 0.05 } }
t_1[15] = {
    Name = "Executioner",
    Desc = "+15% damage to NPCs under 30% HP",
    Attributes = { execute_damage = 0.15 }
}
t_1[17] = { Desc = "Regen starts another 3s sooner (6s total)", Attributes = { regen_delay = 3 } }
t_1[18] = {
    Desc = "-5% NPC damage taken (10% total)",
    Attributes = { npc_damage_reduction = 0.05 }
}
t_1[20] = {
    Name = "Treasure Sense",
    Desc = "Gear from boss and elite chests rolls with +10% quality boost",
    Attributes = { boss_loot_quality = 0.1 }
}
t_1[22] = { Desc = "+5% energy on kill (15% total)", Attributes = { energy_on_kill = 0.05 } }
t_1[23] = { Desc = "+5% boss damage (10% total)", Attributes = { boss_damage = 0.05 } }
t_1[24] = {
    Desc = "In-combat time another -5s (10s total)",
    Attributes = { combat_tag_reduction = 5 }
}
t_1[25] = {
    Desc = "Health packs heal +10% more (25% total)",
    Attributes = { healthpack_bonus = 0.1 }
}
t_1[27] = {
    Desc = "+5% boss and elite loot quality boost (15% total)",
    Attributes = { boss_loot_quality = 0.05 }
}
t_1[28] = {
    Name = "Warlord",
    Desc = "Each NPC kill gives +3% damage for 6s, stacking 3 times",
    Attributes = { warlord = 1 }
}
t_1[29] = {
    Desc = "+10% damage to NPCs under 30% HP (25% total)",
    Attributes = { execute_damage = 0.1 }
}
t_1[30] = {
    Name = "Unbroken",
    Desc = "Once every 2 min, a lethal NPC hit leaves you at 1 HP",
    Attributes = { unbroken = 1 }
}
t.Skills = t_1

return t
