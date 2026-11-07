-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.rejoin
-- Class: ModuleScript
-- bytes: 476

return {
    Name = "rejoin",
    Aliases = {},
    Description = "Rejoin game for testing fast.",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "players",
            Name = "targets",
            Description = "The players to rejoin",
            Optional = true
        },
        {
            Type = "boolean",
            Name = "reserved",
            Description = "Whether to reserve the server",
            Optional = true
        }
    }
}
