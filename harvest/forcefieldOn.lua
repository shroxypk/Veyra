-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.forcefieldOn
-- Class: ModuleScript
-- bytes: 334

return {
    Name = "forcefield",
    Aliases = { "ff" },
    Description = "Gives a ForceField to one or more player(s).",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "players",
            Name = "targets",
            Description = "The players to protect.",
            Optional = true
        }
    }
}
