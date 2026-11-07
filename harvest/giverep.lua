-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.giverep
-- Class: ModuleScript
-- bytes: 447

return {
    Name = "giverep",
    Aliases = {},
    Description = "Gives reputation to one or more player(s).",
    Group = "GameCommands",
    Args = {
        { Type = "players", Name = "targets", Description = "The players to give reputation to." },
        { Type = "string", Name = "Faction", Description = "The desired faction." },
        { Type = "number", Name = "Amount", Description = "The number to increase reputation by." }
    }
}
