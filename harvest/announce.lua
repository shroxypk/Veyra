-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.announce
-- Class: ModuleScript
-- bytes: 230

return {
    Name = "announce",
    Aliases = { "m" },
    Description = "Makes a server-wide announcement.",
    Group = "DefaultAdmin",
    Args = { { Type = "string", Name = "text", Description = "The announcement text." } }
}
