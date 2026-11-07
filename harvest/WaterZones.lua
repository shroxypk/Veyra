-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.WaterZones
-- Class: ModuleScript
-- bytes: 2610

local CollectionService = game:GetService("CollectionService")
local DeadZones_m = require(game:GetService("ReplicatedStorage").Modules.DeadZones)
local t = { TAG = "SwimWater", SEA_LEVEL = 1, SURFACE_DEPTH = 1 }
local t_1 = {}
local SEALEVEL = t.SEA_LEVEL
local v1 = -math.huge

local function addLake(arg1) -- line: 22
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] v1 (ref)

    if arg1:IsA("BasePart") then
        t_1[arg1] = true
        v1 = -math.huge
    end
end

local function removeLake(arg2) -- line: 29
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] v1 (ref)

    t_1[arg2] = nil
    v1 = -math.huge
end

for _, val in CollectionService:GetTagged(t.TAG) do
    if val:IsA("BasePart") then
        t_1[val] = true
        v1 = -math.huge
    end
end

CollectionService:GetInstanceAddedSignal(t.TAG):Connect(addLake)
CollectionService:GetInstanceRemovedSignal(t.TAG):Connect(removeLake)

function t.GetLakeLevel(_: table, vec1: Vector3) -- line: 45
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t (copy)

    local v2 = nil

    for key_1 in t_1 do
        if key_1.Parent then
            local v3 = key_1.Size / 2
            local v4 = key_1.CFrame:PointToObjectSpace(vec1)
            v2 = if not (if math.abs(v4.X) <= v3.X then if math.abs(v4.Z) <= v3.Z then v4.Y >= -v3.Y - 2 and true else false else false) then v2 else if not v2 then key_1.Position.Y + v3.Y - t.SURFACE_DEPTH else if not (v2 < key_1.Position.Y + v3.Y - t.SURFACE_DEPTH) then v2 else key_1.Position.Y + v3.Y - t.SURFACE_DEPTH
        end
    end

    return v2
end

function t.GetSwimLevel(t2: table, u1: userdata?, vec2: Vector3) -- line: 74
    -- upvalues:
    --  [1] DeadZones_m (copy)
    --  [2] t (copy)

    local v8 = t2:GetLakeLevel(vec2)

    if v8 then
        return v8
    end

    if u1 and DeadZones_m:InDeadZone(u1) then
        return nil
    end

    return t.SEA_LEVEL
end

function t.GetMaxLevel(_) -- line: 90
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] t (copy)
    --  [3] t_1 (copy)
    --  [4] SEALEVEL (ref)

    local clock = os.clock()

    if clock - v1 >= 1 then
        v1 = clock
        local v9 = t.SEA_LEVEL

        for key_2 in t_1 do
            if key_2.Parent then
                v9 = math.max(v9, key_2.Position.Y + key_2.Size.Y / 2 - t.SURFACE_DEPTH)
            end
        end

        SEALEVEL = v9
    end

    return SEALEVEL
end

function t.IsFloatingOnLake(t3: table, vec3: Vector3) -- line: 109
    local v10 = t3:GetLakeLevel(vec3)

    if not v10 then
        return false
    end

    return vec3.Y < v10 + 0.5 and vec3.Y > v10 - 1
end

return t
