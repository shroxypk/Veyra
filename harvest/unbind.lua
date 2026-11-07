-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.unbind
-- Class: ModuleScript
-- bytes: 688

return {
    Name = "unbind",
    Aliases = {},
    Description = "Unbinds an input previously bound with Bind",
    Group = "DefaultUtil",
    Args = {
        {
            Type = "userInput ! bindableResource @ player",
            Name = "Input/Key",
            Description = "The key or input type you'd like to unbind."
        }
    },
    ClientRun = function(arg1, arg2) --[[ ClientRun ]] -- line: 14
        local CMDRBinds = arg1:GetStore("CMDR_Binds")

        if CMDRBinds[arg2] then
            CMDRBinds[arg2]:Disconnect()
            CMDRBinds[arg2] = nil

            return "Unbound command from input."
        end

        return "That input wasn't bound."
    end
}
