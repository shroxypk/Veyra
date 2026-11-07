-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.StateManager.displayTags
-- Class: ModuleScript
-- bytes: 2122

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BackpackUtils_m = require(ReplicatedStorage.Modules.BackpackUtils)
local t = {
    Combat = Color3.fromRGB(255, 255, 255),
    Misc = Color3.fromRGB(),
    Actions = Color3.fromRGB(147, 185, 255),
    Enchant = Color3.fromRGB(255, 88, 88),
    Trait = Color3.fromRGB(255, 193, 172),
    Grimoire = Color3.fromRGB(255, 210, 110)
}
local t_1 = {
    ChaseDebounce = { text = "Aerial Pursuit", color = t.Combat },
    MisdirectCooldown = { text = "Misdirect", color = t.Combat },
    ["Aerial Cooldown"] = { text = "Aerial Attack", color = t.Combat },
    ["Aerial Critical Cooldown"] = { text = "Aerial Critical Attack", color = t.Combat },
    HeavyAttackCooldown = { text = "Critical Attack", color = t.Combat },
    ChronoSurgeCD = { text = "Chrono Surge", color = t.Combat },
    SprintAttackCooldown = { text = "Sprint Attack", color = t.Actions },
    BROOM_COOLDOWN = { text = "Broom Flight", color = t.Actions },
    DashCooldown = { text = "Dash Cooldown", color = t.Combat },
    ["Crippling Fakeout Cooldown"] = { text = "Crippling Fakeout", color = t.Trait },
    ["Unyielding Bastion Cooldown"] = { text = "Unyielding Bastion", color = t.Trait },
    SixthSenseCooldown = { text = "Sixth Sense", color = t.Trait },
    ["Infernal DefianceCooldown"] = { text = "Infernal Defiance", color = t.Trait },
    ShatteringEmberCooldown = { text = "Shattering Ember", color = t.Trait },
    BombCooldown = { text = "Mana Bomb Cooldown", color = t.Combat },
    ParryCooldown = { text = "Parry Cooldown", color = t.Combat }
}
t_1.Feared = { text = "Feared", color = Color3.fromRGB(170, 110, 230) }

for _, val in { "Light", "Lightning", "Flame", "Shadow", "Wind", "Time" } do
    t_1[val .. " UltimateCooldown"] = { text = "Grimoire Ultimate", color = t.Grimoire }
end

for key_1, val_1 in require(ReplicatedStorage.Modules.Alchemy).Potions do
    t_1["Potion_" .. key_1] = { text = val_1.Short, color = val_1.Color }
end

for key_2, _ in BackpackUtils_m._enchants do
    t_1[key_2 .. "_Cooldown"] = { text = key_2, color = t.Enchant }
end

return t_1
