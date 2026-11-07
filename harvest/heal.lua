-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.heal
-- Class: ModuleScript
-- bytes: 311

return {
    Name = "heal",
    Aliases = { "heal" },
    Description = "Heals one or more player(s).",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "players",
            Name = "targets",
            Description = "The players to heal.",
            Optional = true
        }
    }
}
