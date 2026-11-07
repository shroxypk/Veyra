-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.grantskill
-- Class: ModuleScript
-- bytes: 246

return {
    Name = "grantskill",
    Aliases = { "giveskill", "giveability" },
    Description = "Grants skill to the user.",
    Group = "GameCommands",
    Args = { { Type = "string", Name = "Ability", Description = "The skill to give." } }
}
