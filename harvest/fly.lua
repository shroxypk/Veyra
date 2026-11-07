-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.fly
-- Class: ModuleScript
-- bytes: 638

return {
    Name = "fly",
    Description = "Enables flight on one or more player(s).",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "players",
            Name = "targets",
            Description = "The player(s) to give flight.",
            Optional = true
        },
        {
            Type = "number",
            Name = "Speed",
            Description = "The flight speed, defaults to 256.",
            Optional = true
        },
        {
            Type = "boolean",
            Name = "noclip",
            Description = "Whether to noclip or not.",
            Optional = true
        }
    }
}
