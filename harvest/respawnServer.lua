-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Admin.respawnServer
-- Class: ModuleScript
-- bytes: 416

return function(arg1, arg2) -- line: 1
    if not arg2 then
        local Executor = arg1.Executor

        if Executor.Character then
            Executor:LoadCharacter()

            return
        end
    else
        for _, val in pairs(arg2) do
            if val.Character then
                val:LoadCharacter()
            end
        end

        return ("Respawned %d players."):format(#arg2)
    end
end
