-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Fear The Shadows
-- Class: ModuleScript
-- bytes: 1367

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Basic_m = require(ReplicatedStorage.Modules.Basic)

local _ = function() --[[ clockTime ]] -- line: 13
    -- upvalues:
    --  [1] Basic_m (copy)
    --  [2] Lighting (copy)

    if Basic_m.World and not Lighting:GetAttribute("ClockDisabled") then
        return (workspace:GetServerTimeNow() / 60 + 10) % 24
    end

    return Lighting.ClockTime
end

return function(arg1, _, arg3) -- line: 20
    -- upvalues:
    --  [1] Basic_m (copy)
    --  [2] Lighting (copy)
    --  [3] ReplicatedStorage (copy)

    local v1 = arg3.modules

    if v1 then
        v1 = table.find(arg3.modules, "Shadow")
    end

    if v1 then
        if not arg1:FindFirstChild("Fear The Shadows") then
            return 0
        end

        v1 = if Basic_m.World then if not Lighting:GetAttribute("ClockDisabled") then (workspace:GetServerTimeNow() / 60 + 10) % 24 else Lighting.ClockTime else Lighting.ClockTime

        if not (v1 >= 18) then
            if not (v1 < 6) then
                if ReplicatedStorage:GetAttribute("BloodMoon") then
                    return 0.1
                end

                return 0
            else
                return 0.1
            end
        else
            return 0.1
        end
    else
        return 0
    end
end
