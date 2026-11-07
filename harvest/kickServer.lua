-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Admin.kickServer
-- Class: ModuleScript
-- bytes: 167

return function(_, arg2) -- line: 1
    for _, val in pairs(arg2) do
        val:Kick("Kicked by admin.")
    end

    return ("Kicked %d players."):format(#arg2)
end
