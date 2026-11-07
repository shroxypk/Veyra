-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.WeatherZones
-- Class: ModuleScript
-- bytes: 1400

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.Players
local _ = Services_m.ReplicatedStorage
local t = {
    Regions = {},
    InWeatherZone = function(t1: table, u1: userdata) --[[ InWeatherZone ]] -- line: 22
        if script:GetAttribute("ServerWeather") then
            return true
        end

        local v3 = nil

        for key_2, val_1 in t1.Regions do
            local v4 = val_1.Position:Inverse() * u1.PrimaryPart.Position
            local v5 = true

            for _, val_2 in ipairs({ "X", "Y", "Z" }) do
                if math.abs(v4[val_2]) >= val_1.Size[val_2] / 2 then
                    v5 = false
                end
            end

            if v5 then
                v3 = key_2
                break
            end
        end

        local v7 = v3

        if v7 then
            v7 = script.Zones:FindFirstChild(v3)
        end

        if v7 then
            return v7:GetAttribute("HasWeather")
        end

        return v3
    end
}

for _, descendant in script:GetDescendants() do
    if descendant:IsA("Configuration") then
        local Name = descendant.Name
        local t_1 = {}

        for _, val in pairs(descendant:GetChildren()) do
            if val:IsA("ValueBase") then
                t_1[val.Name] = val.Value
            end
        end

        t.Regions[Name] = t_1
    end
end

return t
