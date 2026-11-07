-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.health
-- Class: ModuleScript
-- bytes: 421

return {
    Name = "health",
    Aliases = { "maxhealth" },
    Description = "Changes the maximum health of one or more player(s).",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "players",
            Name = "targets",
            Description = "The player(s) whose health to change."
        },
        { Type = "number", Name = "Max Health", Description = "The new maximum health." }
    }
}
