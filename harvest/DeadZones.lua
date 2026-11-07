-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.DeadZones
-- Class: ModuleScript
-- bytes: 1272

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("ReplicatedStorage")
local t = {}
local t_1 = {}

for _, descendant in script:GetDescendants() do
    if descendant:IsA("Configuration") then
        local Name = descendant.Name
        local t_2 = {}

        for _, val in pairs(descendant:GetChildren()) do
            if val:IsA("ValueBase") then
                t_2[val.Name] = val.Value
            end
        end

        t[Name] = t_2
    end
end

local t_3 = {}

for _, val_1 in pairs(t) do
    if val_1.Position and val_1.Size then
        table.insert(t_3, { inverse = val_1.Position:Inverse(), half = val_1.Size / 2 })
    end
end

function t_1.InDeadZone(_, arg2) -- line: 34
    -- upvalues:
    --  [1] t_3 (copy)

    local v3 = arg2

    if v3 then
        v3 = arg2.PrimaryPart
    end

    if not v3 then
        return
    end

    local Position = v3.Position

    for _, val_2 in t_3 do
        v3 = val_2.inverse * Position
        local Half = val_2.half

        if math.abs(v3.X) < Half.X then
            if math.abs(v3.Y) < Half.Y then
                if math.abs(v3.Z) < Half.Z then
                    return true
                end
            end
        end
    end

    return nil
end

return t_1
