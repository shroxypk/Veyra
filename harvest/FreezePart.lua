-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Environment.FreezePart
-- Class: ModuleScript
-- bytes: 2328

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RotatedRegion3_m = require(ReplicatedStorage.Modules.RotatedRegion3)
local FREEZETAG = _G.FREEZE_TAG
local Map = workspace.Map
local color = Color3.fromRGB(184, 255, 247)
local t = {}
local t_1 = {}

function t.Freeze(
    _,
    arg2,
    arg3,
    arg4,
    _
) -- line: 16
    -- upvalues:
    --  [1] RotatedRegion3_m (copy)
    --  [2] Map (copy)
    --  [3] CollectionService (copy)
    --  [4] FREEZETAG (copy)
    --  [5] t_1 (copy)
    --  [6] ReplicatedStorage (copy)
    --  [7] color (copy)

    local v1 = RotatedRegion3_m.new(arg3, arg4):FindPartsInRegion3WithIgnoreList(arg2, 500)

    if not v1 then
        return
    end

    for _, val in pairs(v1) do
        if val:IsDescendantOf(Map) and not val.Parent.Name:match("Treez") and (not CollectionService:HasTag(
            val,
            FREEZETAG
        ) and (arg4.Magnitude >= val.Size.Magnitude / 1.5 and (arg4.X >= val.Size.X or arg4.Z >= val.Size.Z))) then
            CollectionService:AddTag(val, FREEZETAG)
            t_1[val] = tick()
            ReplicatedStorage.Remotes.Freeze:FireAllClients(val, "Freeze", { color })
        end
    end

    for key_1, _ in pairs(t_1) do
        if CollectionService:HasTag(key_1, _G.BURNING_TAG) then
            CollectionService:RemoveTag(key_1, _G.BURNING_TAG)
        end
    end
end

game:GetService("RunService").Stepped:Connect(function() -- line: 42
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] CollectionService (copy)
    --  [4] FREEZETAG (copy)

    for key_2, val_2 in pairs(t_1) do
        if tick() - val_2 > 20 then
            ReplicatedStorage.Remotes.Freeze:FireAllClients(
                key_2,
                "Thaw",
                { key_2.Material, key_2.Color, key_2.Transparency }
            )
            CollectionService:RemoveTag(key_2, FREEZETAG)
            t_1[key_2] = nil
        elseif not CollectionService:HasTag(key_2, FREEZETAG) then
            ReplicatedStorage.Remotes.Freeze:FireAllClients(
                key_2,
                "Thaw",
                { key_2.Material, key_2.Color, key_2.Transparency }
            )
            t_1[key_2] = nil
        end
    end
end)

return t
