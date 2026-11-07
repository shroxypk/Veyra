-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.RotatedRegion3
-- Class: ModuleScript
-- bytes: 6181

local GJK_m = require(script:WaitForChild("GJK"))
local Supports_m = require(script:WaitForChild("Supports"))
local Vertices_m = require(script:WaitForChild("Vertices"))
local t = {}
t.__index = t

local function getCorners(arg1, arg2) -- line: 86
    local _ = {}

    return {
        arg1:PointToWorldSpace((Vector3.new(-arg2.x, arg2.y, arg2.z))),
        arg1:PointToWorldSpace((Vector3.new(-arg2.x, -arg2.y, arg2.z))),
        arg1:PointToWorldSpace((Vector3.new(-arg2.x, -arg2.y, -arg2.z))),
        arg1:PointToWorldSpace((Vector3.new(arg2.x, -arg2.y, -arg2.z))),
        arg1:PointToWorldSpace((Vector3.new(arg2.x, arg2.y, -arg2.z))),
        arg1:PointToWorldSpace((Vector3.new(arg2.x, arg2.y, arg2.z))),
        arg1:PointToWorldSpace((Vector3.new(arg2.x, -arg2.y, arg2.z))),
        arg1:PointToWorldSpace((Vector3.new(-arg2.x, arg2.y, -arg2.z)))
    }
end

local function worldBoundingBox(arg3) -- line: 99
    local t_2 = {}
    local t_3 = {}
    local t_4 = {}

    for index = 1, #arg3 do
        t_2[index], t_3[index], t_4[index] = arg3[index].x, arg3[index].y, arg3[index].z
    end

    local v11 = math.min(unpack(t_2))
    local v12 = math.min(unpack(t_3))
    local v13 = math.min(unpack(t_4))
    local vec3_8 = Vector3.new(v11, v12, v13)
    local v14 = math.max(unpack(t_2))
    local v15 = math.max(unpack(t_3))
    local v16 = math.max(unpack(t_4))

    return vec3_8, (Vector3.new(v14, v15, v16))
end

function t.new(arg4, arg5) -- line: 109
    -- upvalues:
    --  [1] t (copy)
    --  [2] Vertices_m (copy)
    --  [3] Supports_m (copy)
    --  [4] worldBoundingBox (copy)

    local t_5 = setmetatable({}, t)
    t_5.CFrame = arg4
    t_5.Size = arg5
    t_5.Shape = "Block"
    t_5.Set = Vertices_m.Block(arg4, arg5 / 2)
    t_5.Support = Supports_m.PointCloud
    t_5.Centroid = arg4.p
    t_5.AlignedRegion3 = Region3.new(worldBoundingBox(t_5.Set))

    return t_5
end

t.Block = t.new

function t.Wedge(arg6, arg7) -- line: 127
    -- upvalues:
    --  [1] t (copy)
    --  [2] Vertices_m (copy)
    --  [3] Supports_m (copy)
    --  [4] worldBoundingBox (copy)

    local t_6 = setmetatable({}, t)
    t_6.CFrame = arg6
    t_6.Size = arg7
    t_6.Shape = "Wedge"
    t_6.Set = Vertices_m.Wedge(arg6, arg7 / 2)
    t_6.Support = Supports_m.PointCloud
    t_6.Centroid = Vertices_m.GetCentroid(t_6.Set)
    t_6.AlignedRegion3 = Region3.new(worldBoundingBox(t_6.Set))

    return t_6
end

function t.CornerWedge(arg8, arg9) -- line: 143
    -- upvalues:
    --  [1] t (copy)
    --  [2] Vertices_m (copy)
    --  [3] Supports_m (copy)
    --  [4] worldBoundingBox (copy)

    local t_7 = setmetatable({}, t)
    t_7.CFrame = arg8
    t_7.Size = arg9
    t_7.Shape = "CornerWedge"
    t_7.Set = Vertices_m.CornerWedge(arg8, arg9 / 2)
    t_7.Support = Supports_m.PointCloud
    t_7.Centroid = Vertices_m.GetCentroid(t_7.Set)
    t_7.AlignedRegion3 = Region3.new(worldBoundingBox(t_7.Set))

    return t_7
end

function t.Cylinder(arg10, arg11) -- line: 159
    -- upvalues:
    --  [1] t (copy)
    --  [2] Supports_m (copy)
    --  [3] worldBoundingBox (copy)
    --  [4] getCorners (copy)

    local t_8 = setmetatable({}, t)
    t_8.CFrame = arg10
    t_8.Size = arg11
    t_8.Shape = "Cylinder"
    t_8.Set = { arg10, arg11 / 2 }
    t_8.Support = Supports_m.Cylinder
    t_8.Centroid = arg10.p
    t_8.AlignedRegion3 = Region3.new(worldBoundingBox((getCorners(unpack(t_8.Set)))))

    return t_8
end

function t.Ball(arg12, arg13) -- line: 175
    -- upvalues:
    --  [1] t (copy)
    --  [2] Supports_m (copy)
    --  [3] worldBoundingBox (copy)
    --  [4] getCorners (copy)

    local t_9 = setmetatable({}, t)
    t_9.CFrame = arg12
    t_9.Size = arg13
    t_9.Shape = "Ball"
    t_9.Set = { arg12, arg13 / 2 }
    t_9.Support = Supports_m.Ellipsoid
    t_9.Centroid = arg12.p
    t_9.AlignedRegion3 = Region3.new(worldBoundingBox((getCorners(unpack(t_9.Set)))))

    return t_9
end

function t.FromPart(arg14) -- line: 191
    -- upvalues:
    --  [1] t (copy)
    --  [2] Vertices_m (copy)

    return t[Vertices_m.Classify(arg14)](arg14.CFrame, arg14.Size)
end

function t.CastPoint(arg15, arg16) -- line: 197
    -- upvalues:
    --  [1] GJK_m (copy)
    --  [2] Supports_m (copy)

    return GJK_m.new(
        arg15.Set,
        { arg16 },
        arg15.Centroid,
        arg16,
        arg15.Support,
        Supports_m.PointCloud
    ):IsColliding()
end

function t.CastPart(arg17, arg18) -- line: 202
    -- upvalues:
    --  [1] t (copy)
    --  [2] GJK_m (copy)

    local v22 = t.FromPart(arg18)

    return GJK_m.new(
        arg17.Set,
        v22.Set,
        arg17.Centroid,
        v22.Centroid,
        arg17.Support,
        v22.Support
    ):IsColliding()
end

function t.FindPartsInRegion3(arg19, arg20, arg21) -- line: 208
    local t_10 = {}
    local v23 = game.Workspace:FindPartsInRegion3(arg19.AlignedRegion3, arg20, arg21)

    for index_1 = 1, #v23 do
        if arg19:CastPart(v23[index_1]) then
            table.insert(t_10, v23[index_1])
        end
    end

    return t_10
end

function t.FindPartsInRegion3WithIgnoreList(arg22, arg23, arg24) -- line: 219
    local v24 = arg23

    if type(arg23) ~= "table" or not v24 then
        v24 = { arg23 }
    end

    local v25 = v24
    v24 = {}

    for _, val in pairs(
        workspace:FindPartsInRegion3WithIgnoreList(arg22.AlignedRegion3, v25, arg24)
    ) do
        if arg22:CastPart(val) then
            table.insert(v24, val)
        end
    end

    return v24
end

function t.FindPartsInRegion3WithWhiteList(arg25, arg26, arg27) -- line: 232
    local v27 = arg26

    if type(arg26) ~= "table" or not v27 then
        v27 = { arg26 }
    end

    local v28 = v27
    v27 = {}

    for _, val_1 in pairs(
        workspace:FindPartsInRegion3WithWhiteList(arg25.AlignedRegion3, v28, arg27)
    ) do
        if arg25:CastPart(val_1) then
            table.insert(v27, val_1)
        end
    end

    return v27
end

function t.Cast(arg28, arg29, arg30) -- line: 245
    local v30 = arg29

    if type(arg29) ~= "table" or not v30 then
        v30 = { arg29 }
    end

    return arg28:FindPartsInRegion3WithIgnoreList(v30, arg30)
end

return t
