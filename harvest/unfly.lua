-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.unfly
-- Class: ModuleScript
-- bytes: 315

return {
    Name = "unfly",
    Description = "Disables flight on one or more player(s).",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "players",
            Name = "targets",
            Description = "The player(s) to remove flight from.",
            Optional = true
        }
    }
}
