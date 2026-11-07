-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.alias
-- Class: ModuleScript
-- bytes: 811

return {
    Name = "alias",
    Aliases = {},
    Description = "Creates a new, single command out of a command and given arguments.",
    Group = "DefaultUtil",
    Args = {
        {
            Type = "string",
            Name = "Alias name",
            Description = "The key or input type you'd like to bind the command to."
        },
        {
            Type = "string",
            Name = "Command string",
            Description = "The command text you want to run. Separate multiple commands with \"&&\". Accept arguments with $1, $2, $3, etc."
        }
    },
    ClientRun = function(arg1, arg2, arg3) --[[ ClientRun ]] -- line: 19
        arg1.Cmdr.Registry:RegisterCommandObject(arg1.Cmdr.Util.MakeAliasCommand(arg2, arg3), true)

        return ("Created alias %q"):format(arg2)
    end
}
