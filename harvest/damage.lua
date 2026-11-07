-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.damage
-- Class: ModuleScript
-- bytes: 343

return {
    Name = "damage",
    Aliases = { "hurt" },
    Description = "Damages one or more player(s).",
    Group = "DefaultAdmin",
    Args = {
        { Type = "players", Name = "targets", Description = "The player(s) to hurt." },
        { Type = "number", Name = "Damage", Description = "The damage to deal to their health." }
    }
}
