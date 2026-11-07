-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.StarterInfo
-- Class: ModuleScript
-- bytes: 1300

return {
    ["Vital Pulse"] = {
        ReqType = "Trainer",
        Requirement = 0,
        EnergyCost = 20,
        Description = "Release a pulse of mana that restores the health of nearby allies.",
        Skillset = "Starter",
        Cooldown = 15,
        WindUp = 0,
        Image = ""
    },
    ["Mana Shield"] = {
        ReqType = "Trainer",
        Requirement = 0,
        EnergyCost = 20,
        Description = "Form a barrier of mana that reduces incoming damage for a short time.",
        Skillset = "Starter",
        Cooldown = 12,
        CooldownAfterEnd = true,
        WindUp = 0,
        Image = ""
    },
    ["Charged Strike"] = {
        ReqType = "Trainer",
        Requirement = 0,
        EnergyCost = 15,
        Description = "Deliver a powerful kick infused with concentrated mana.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Starter",
        Cooldown = 10,
        WindUp = 0,
        Image = ""
    },
    Rampage = {
        ReqType = "Trainer",
        Requirement = 0,
        EnergyCost = 20,
        Description = "Charge forward, ending with a devastating slam that crushes your foes.",
        Style = "NoGyro",
        Stat = "",
        Skillset = "Starter",
        Cooldown = 10,
        WindUp = 0,
        Image = ""
    }
}
