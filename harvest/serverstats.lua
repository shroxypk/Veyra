-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.serverstats
-- Class: ModuleScript
-- bytes: 526

return {
    Name = "serverstats",
    Aliases = { "memstats" },
    Description = "Server memory and part counts, compared with a baseline, to find what grows in a long-running server. show (default): the reading and its change since the baseline (the first reading is the baseline). reset: a new baseline. log: turn a reading every 30 minutes in the server output on or off.",
    Group = "DefaultAdmin",
    Args = {
        { Type = "string", Name = "Action", Description = "show, reset or log", Optional = true }
    }
}
