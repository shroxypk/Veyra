-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Admin.killServer
-- Class: ModuleScript
-- bytes: 219

return function(_, arg2) -- line: 1
    for _, val in pairs(arg2) do
        if val.Character then
            val.Character.Humanoid.Health = -5
        end
    end

    return ("Killed %d players."):format(#arg2)
end
