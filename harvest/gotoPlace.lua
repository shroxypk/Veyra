-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.gotoPlace
-- Class: ModuleScript
-- bytes: 743

return {
    Name = "goto-place",
    Aliases = {},
    Description = "Teleport to a Roblox place",
    Group = "DefaultAdmin",
    AutoExec = {
        "alias \"follow-player|Join a player in another server\" goto-place $1{players|Players} ${{get-player-place-instance $2{playerId|Target}}}"
    },
    Args = {
        { Type = "players", Name = "Players", Description = "The players you want to teleport" },
        {
            Type = "integer",
            Name = "Place ID",
            Description = "The Place ID you want to teleport to"
        },
        {
            Type = "string",
            Name = "JobId",
            Description = "The specific JobId you want to teleport to",
            Optional = true
        }
    }
}
