-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Debug.fetchServer
-- Class: ModuleScript
-- bytes: 179

local HttpService = game:GetService("HttpService")

return function(_, arg2) -- line: 3
    -- upvalues:
    --  [1] HttpService (copy)

    return HttpService:GetAsync(arg2)
end
