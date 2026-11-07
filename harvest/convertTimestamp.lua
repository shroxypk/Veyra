-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.convertTimestamp
-- Class: ModuleScript
-- bytes: 590

return {
    Name = "convertTimestamp",
    Aliases = { "date" },
    Description = "Convert a timestamp to a human-readable format.",
    Group = "DefaultUtil",
    Args = {
        {
            Type = "number",
            Name = "timestamp",
            Description = "A numerical representation of a specific moment in time.",
            Optional = true
        }
    },
    ClientRun = function(_, arg2) --[[ ClientRun ]] -- line: 14
        arg2 = arg2 or os.time()
        local v2 = os.date("%x", arg2)
        local v3 = os.date("%X", arg2)

        return `{v2} {v3}`
    end
}
