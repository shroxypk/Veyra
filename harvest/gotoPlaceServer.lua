-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Admin.gotoPlaceServer
-- Class: ModuleScript
-- bytes: 607

local TeleportService = game:GetService("TeleportService")

return function(arg1, arg2, arg3, arg4) -- line: 3
    -- upvalues:
    --  [1] TeleportService (copy)

    arg2 = arg2 or { arg1.Executor }

    if arg3 <= 0 then
        return "Invalid place ID"
    end

    if arg4 == "-" then
        return "Invalid job ID"
    end

    arg1:Reply("Commencing teleport...")

    if arg4 then
        for _, val in ipairs(arg2) do
            TeleportService:TeleportToPlaceInstance(arg3, arg4, val)
        end
    else
        TeleportService:TeleportAsync(arg3, arg2)
    end

    return "Teleported."
end
