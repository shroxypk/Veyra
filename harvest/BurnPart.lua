-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Environment.BurnPart
-- Class: ModuleScript
-- bytes: 2051

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local RotatedRegion3_m = require(ReplicatedStorage.Modules.RotatedRegion3)
local BURNINGTAG = _G.BURNING_TAG
local t = {
    [Enum.Material.Wood] = true,
    [Enum.Material.WoodPlanks] = true,
    [Enum.Material.Grass] = true
}
local Map = workspace.Map
local color = Color3.fromRGB(255, 52, 25)
local t_1 = { Parts = {} }
local v1 = if RunService:IsStudio() then 7 else 20

function t_1.Burn(
    _,
    arg2,
    arg3,
    arg4,
    _
) -- line: 26
    -- upvalues:
    --  [1] RotatedRegion3_m (copy)
    --  [2] Map (copy)
    --  [3] CollectionService (copy)
    --  [4] BURNINGTAG (copy)
    --  [5] t (copy)
    --  [6] v1 (copy)

    local v2 = RotatedRegion3_m.new(arg3, arg4):FindPartsInRegion3WithIgnoreList(arg2, 500)

    if not v2 then
        return
    end

    for _, val in pairs(v2) do
        if val:IsDescendantOf(Map) and not val.Parent.Name:match("Treez") and CollectionService:HasTag(
            val,
            BURNINGTAG
        ) == false and arg4.Magnitude >= val.Size.Magnitude / 1.5 and (arg4.X >= val.Size.X or arg4.Z >= val.Size.Z) and t[val.Material] then
            val:AddTag(BURNINGTAG)
            val:RemoveTag(_G.FREEZE_TAG)
            task.delay(v1, function() -- line: 40
                -- upvalues:
                --  [1] val (copy)
                --  [2] BURNINGTAG (ref)

                val:RemoveTag(BURNINGTAG)
            end)
        end
    end
end

CollectionService:GetInstanceAddedSignal(BURNINGTAG):Connect(function(arg6) -- line: 49
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] color (copy)

    ReplicatedStorage.Remotes.Burn:FireAllClients(arg6, "Burn", color)
end)
CollectionService:GetInstanceRemovedSignal(BURNINGTAG):Connect(function(arg7) -- line: 52
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.Burn:FireAllClients(arg7, "Off")
end)

return t_1
