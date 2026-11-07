-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Debug.getPlayerPlaceInstanceServer
-- Class: ModuleScript
-- bytes: 954

local TeleportService = game:GetService("TeleportService")

return function(_, arg2, arg3) -- line: 3
    -- upvalues:
    --  [1] TeleportService (copy)

    arg3 = arg3 or "PlaceIdJobId"
    local Success, _, v1, v2, v3 = pcall(function() -- line: 6
        -- upvalues:
        --  [1] TeleportService (ref)
        --  [2] arg2 (copy)

        return TeleportService:GetPlayerPlaceInstanceAsync(arg2)
    end)

    if not Success or v1 and #v1 > 0 then
        if arg3 == "PlaceIdJobId" then
            return "0 -"
        end

        if arg3 == "PlaceId" then
            return "0"
        end

        if arg3 == "JobId" then
            return "-"
        end
    else
        if arg3 == "PlaceIdJobId" then
            return v2 .. " " .. v3
        end

        if arg3 == "PlaceId" then
            return (tostring(v2))
        end

        if arg3 == "JobId" then
            return (tostring(v3))
        end

        return
    end
end
