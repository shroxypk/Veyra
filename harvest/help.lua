-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.help
-- Class: ModuleScript
-- bytes: 2258

return {
    Name = "help",
    Description = "Displays a list of all commands, or inspects one command.",
    Group = "Help",
    Args = {
        {
            Type = "command",
            Name = "Command",
            Description = "The command to view information on",
            Optional = true
        }
    },
    ClientRun = function(arg1, arg2) --[[ ClientRun ]] -- line: 31
        local v5

        if arg2 then
            local v1 = arg1.Cmdr.Registry:GetCommand(arg2)
            arg1:Reply(`Command: {v1.Name}`, Color3.fromRGB(230, 126, 34))

            if v1.Aliases and #v1.Aliases > 0 then
                local v3 = table.concat(v1.Aliases, ", ")
                arg1:Reply(`Aliases: {v3}`, Color3.fromRGB(230, 230, 230))
            end

            arg1:Reply(v1.Description, Color3.fromRGB(230, 230, 230))

            for key, val in ipairs(v1.Args) do
                v5 = if val.Optional ~= true then "" else "?"
                arg1:Reply(`#{key} {val.Name}{v5}: {val.Type} - {val.Description}`)
            end
        else
            arg1:Reply(
                "Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n"
            )
            arg1:Reply(
                "Tips\n----\n\226\128\162 Utilize the Tab key to automatically complete commands\n\226\128\162 Easily select and copy command output\n"
            )
            local v7 = arg1.Cmdr.Registry:GetCommands()
            table.sort(v7, function(arg3, arg4) -- line: 49
                return arg3.Group and (if not arg4.Group then arg3.Group else arg3.Group < arg4.Group)
            end)
            local Group_1 = nil

            for _, val_1 in ipairs(v7) do
                val_1.Group = val_1.Group or "No Group"

                if Group_1 ~= val_1.Group then
                    local Group = val_1.Group
                    v5 = string.rep("-", #val_1.Group)
                    arg1:Reply(`\n{Group}\n{v5}`)
                    Group_1 = val_1.Group
                end

                arg1:Reply(
                    if val_1.Description then `{val_1.Name} - {val_1.Description}` else val_1.Name
                )
            end
        end

        return ""
    end
}
