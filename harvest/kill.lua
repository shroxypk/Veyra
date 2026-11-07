-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.kill
-- Class: ModuleScript
-- bytes: 231

return {
    Name = "kill",
    Aliases = { "slay" },
    Description = "Kills a player or set of players.",
    Group = "DefaultAdmin",
    Args = { { Type = "players", Name = "victims", Description = "The players to kill." } }
}
