-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.forcefieldOff
-- Class: ModuleScript
-- bytes: 344

return {
    Name = "unforcefield",
    Aliases = { "unff" },
    Description = "Removes a ForceField from one or more player(s).",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "players",
            Name = "targets",
            Description = "The players to unprotect.",
            Optional = true
        }
    }
}
