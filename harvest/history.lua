-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.history
-- Class: ModuleScript
-- bytes: 874

return {
    Name = "history",
    Aliases = {},
    AutoExec = {
        "alias \"!|Displays previous command from history.\" run ${history $1{number|Line Number}}",
        "alias \"^|Runs the previous command, replacing all occurrences of A with B.\" run ${run replace ${history -1} $1{string|A} $2{string|B}}",
        "alias \"!!|Reruns the last command.\" ! -1"
    },
    Description = "Displays previous commands from history.",
    Group = "DefaultUtil",
    Args = {
        {
            Type = "integer",
            Name = "Line Number",
            Description = "Command line number (can be negative to go from end)"
        }
    },
    ClientRun = function(arg1, arg2) --[[ ClientRun ]] -- line: 19
        local v1 = arg1.Dispatcher:GetHistory()

        if arg2 <= 0 then
            arg2 = #v1 + arg2
        end

        return v1[arg2] or ""
    end
}
