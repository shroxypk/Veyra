-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.InRegion
-- Class: ModuleScript
-- bytes: 1802

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.Players
local ReplicatedStorage = Services_m.ReplicatedStorage
local Locations = ReplicatedStorage._Locations
local Locations_m = require(ReplicatedStorage.Locations)
local t = {
    Zones = {},
    GetClosestRegion = function(arg5, arg6) --[[ GetClosestRegion ]] -- line: 43
        local Position = arg6.PrimaryPart.Position
        local Name = nil
        local v6 = math.huge

        for _, val in pairs(arg5.Zones) do
            local Magnitude = (val.Position.Position - Position).Magnitude

            if v6 > Magnitude then
                Name = val._name
                v6 = Magnitude
            end
        end

        return Name
    end
}

function AddRegion(arg1) -- line: 13
    -- upvalues:
    --  [1] Locations_m (copy)
    --  [2] t (copy)

    local v2 = Locations_m:GetInfo(arg1)

    if not v2 or not v2.Position or not v2.Size then
        return
    end

    local v3 = v2.Orientation or CFrame.Angles(0, 0, 0)
    t.Zones[arg1] = { Size = v2.Size, Position = CFrame.new(v2.Position) * v3, _name = arg1 }
end

function RemoveRegion(arg2) -- line: 23
    -- upvalues:
    --  [1] t (copy)

    t.Zones[arg2] = nil
end

Locations.DescendantAdded:Connect(function(descendant_1) -- line: 27
    if not descendant_1:IsA("Folder") then
        return
    end

    task.wait(0.5)
    AddRegion(descendant_1.Name)
end)
Locations.DescendantRemoving:Connect(function(descendant_2) -- line: 32
    if not descendant_2:IsA("Folder") then
        return
    end

    RemoveRegion(descendant_2.Name)
end)

for _, descendant in pairs(Locations:GetDescendants()) do
    if descendant:IsA("Folder") and descendant.Name ~= "template" then
        AddRegion(descendant.Name)
    end
end

return t
