-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.EnvironmentMaterials
-- Class: ModuleScript
-- bytes: 2475

local MaterialService = game:GetService("MaterialService")
local Lighting = game:GetService("Lighting")
local Terrain = workspace.Terrain
local t = { Realm = nil }
local t_1 = { Overrides = { [Enum.Material.Ground] = "Dirt" }, Colors = nil, Lighting = nil }
local t_3 = {}
t_3[Enum.Material.Grass] = Color3.fromRGB(77, 79, 81)
t_3[Enum.Material.Ground] = Color3.fromRGB(118, 95, 75)
t_1.Colors = t_3
t_1.Lighting = { GeographicLatitude = 88.257 }
t.Realm = t_1
local t_5 = {}
local v1 = nil
local t_6 = {}
local t_7 = {}
local t_8 = {}

local function restore() -- line: 45
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] MaterialService (copy)
    --  [3] t_7 (copy)
    --  [4] Terrain (copy)
    --  [5] t_8 (copy)
    --  [6] Lighting (copy)
    --  [7] v1 (ref)

    for key, val in t_6 do
        MaterialService:SetBaseMaterialOverride(key, val)
    end

    for key_1, val_1 in t_7 do
        Terrain:SetMaterialColor(key_1, val_1)
    end

    for key_2, val_2 in t_8 do
        Lighting[key_2] = val_2
    end

    table.clear(t_6)
    table.clear(t_7)
    table.clear(t_8)
    v1 = nil
end

local function apply(arg1, arg2) -- line: 61
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] MaterialService (copy)
    --  [3] t_7 (copy)
    --  [4] Terrain (copy)
    --  [5] t_8 (copy)
    --  [6] Lighting (copy)
    --  [7] v1 (ref)

    local v2 = arg2.Overrides or {}

    for key_3, val_3 in v2 do
        if t_6[key_3] == nil then
            t_6[key_3] = MaterialService:GetBaseMaterialOverride(key_3)
        end

        MaterialService:SetBaseMaterialOverride(key_3, val_3)
    end

    local v2 = arg2.Colors or {}

    for key_4, val_4 in v2 do
        if t_7[key_4] == nil then
            t_7[key_4] = Terrain:GetMaterialColor(key_4)
        end

        Terrain:SetMaterialColor(key_4, val_4)
    end

    local v2 = arg2.Lighting or {}

    for key_5, val_5 in v2 do
        if t_8[key_5] == nil then
            t_8[key_5] = Lighting[key_5]
        end

        Lighting[key_5] = val_5
    end

    v1 = arg1
end

function t_5.Set(s1: string?) -- line: 84
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] restore (copy)
    --  [3] t (copy)
    --  [4] apply (copy)

    if s1 == v1 then
        return
    end

    restore()
    local v5 = s1

    if v5 then
        v5 = t[s1]
    end

    if v5 then
        apply(s1, v5)
    end
end

function t_5.GetActive() -- line: 99
    -- upvalues:
    --  [1] v1 (ref)

    return v1
end

return t_5
