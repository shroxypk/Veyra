-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Rain Dancer
-- Class: ModuleScript
-- bytes: 401

local WeatherZones_m = require(game:GetService("ReplicatedStorage").Modules.WeatherZones)

return function(arg1, _, arg3) -- line: 5
    -- upvalues:
    --  [1] WeatherZones_m (copy)

    local v1 = arg3.Effect == "Electric" or arg3.modules and table.find(arg3.modules, "Lightning")

    return if arg1:FindFirstChild("Rain Dancer") and v1 and WeatherZones_m:InWeatherZone(arg1) then 0.05 else 0
end
