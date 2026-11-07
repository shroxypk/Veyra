-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Collision.Collider
-- Class: ModuleScript
-- bytes: 6665

local HttpService = game:GetService("HttpService")
local v1 = script.Parent.Parent.Parent:WaitForChild("Dependencies")
local Colliders = script.Parent:WaitForChild("Colliders")
local Box_m = require(Colliders:WaitForChild("Box"))
local Capsule_m = require(Colliders:WaitForChild("Capsule"))
local Cylinder_m = require(Colliders:WaitForChild("Cylinder"))
local Sphere_m = require(Colliders:WaitForChild("Sphere"))
local Config_m = require(
    script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Config")
)
local SBVERBOSELOG = require(
    script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")
).SB_VERBOSE_LOG
local Gizmo_m = require(v1:WaitForChild("Gizmo"))
v1 = game:GetService("RunService"):IsStudio() or Config_m.ALLOW_LIVE_GAME_DEBUG

if v1 or Config_m.ALLOW_LIVE_GAME_DEBUG then
    Gizmo_m.Init()
end

local t = {}
t.__index = t

function t.new() -- line: 76
    -- upvalues:
    --  [1] HttpService (copy)
    --  [2] t (copy)

    return (setmetatable(
        {
            Type = "Box",
            Scale = Vector3.new(0, 0, 0),
            Offset = Vector3.new(0, 0, 0),
            Rotation = Vector3.new(0, 0, 0),
            Radius = 0,
            PreviousScale = Vector3.new(0, 0, 0),
            PreviousOffset = Vector3.new(0, 0, 0),
            PreviousRotation = Vector3.new(0, 0, 0),
            PreviousObjectPosition = Vector3.new(0, 0, 0),
            PreviousObjectRotation = Vector3.new(0, 0, 0),
            m_Object = nil,
            InNarrowphase = false,
            Transform = CFrame.identity,
            Size = Vector3.new(0, 0, 0),
            GUID = HttpService:GenerateGUID(false)
        },
        t
    ))
end

function t.SetObject(t1: table, u1: userdata) -- line: 105
    t1.m_Object = u1
    t1:UpdateTransform()
end

function t.UpdateTransform(arg1) -- line: 112
    debug.profilebegin("Update Transform")
    local MObject = arg1.m_Object
    local Size = MObject.Size
    local Rotation = arg1.Rotation
    local v8 = Size * arg1.Offset
    local v9 = Size * arg1.Scale
    local v10 = MObject.CFrame
    local cframe = CFrame.Angles(
        Rotation.X * 0.017453,
        Rotation.Y * 0.017453,
        Rotation.Z * 0.017453
    )
    arg1.Transform = v10 * CFrame.new(v8) * cframe
    arg1.Size = v9
    arg1.Radius = math.sqrt((math.max(v9.X, v9.Y, v9.Z) * 0.5) ^ 2 * 2)
    debug.profileend()
end

function t.GetClosestPoint(arg2, arg3, arg4) -- line: 137
    -- upvalues:
    --  [1] Box_m (copy)
    --  [2] Capsule_m (copy)
    --  [3] Sphere_m (copy)
    --  [4] Cylinder_m (copy)

    if arg2.m_Object == nil then
        return
    end

    arg2.InNarrowphase = false

    if (arg3 - arg2.Transform.Position).Magnitude - arg4 > arg2.Radius then
        return
    end

    debug.profilebegin("Narrowphase")
    arg2.InNarrowphase = true
    local Type = arg2.Type
    local v11 = nil
    local v12 = nil
    local v13 = nil

    if Type == "Box" then
        v11, v12, v13 = Box_m(arg2.Transform, arg2.Size, arg3, arg4)
    end

    if Type == "Capsule" then
        v11, v12, v13 = Capsule_m(arg2.Transform, arg2.Size, arg3, arg4)
    end

    if Type == "Sphere" then
        v11, v12, v13 = Sphere_m(arg2.Transform, arg2.Size, arg3, arg4)
    end

    if Type == "Cylinder" then
        v11, v12, v13 = Cylinder_m(arg2.Transform, arg2.Size, arg3, arg4)
    end

    debug.profileend()

    return v11, v12, v13
end

function t.Step(arg5) -- line: 182
    debug.profilebegin("Collider::Step")
    arg5:UpdateTransform()
    debug.profileend()
end

function t.DrawDebug(
    arg6,
    arg7,
    arg8,
    arg9,
    arg10,
    arg11
) -- line: 194
    -- upvalues:
    --  [1] Gizmo_m (copy)

    local v14 = Color3.new(0.509803, 0.933333, 0.42745)
    local v15 = Color3.new(0.90196, 0.784313, 0.513725)
    local color = Color3.new(1, 0, 1)
    local color_1 = Color3.new(0, 1, 1)
    local color_2 = Color3.new(1, 0.3, 0.3)
    local Type_1 = arg6.Type
    local Transform = arg6.Transform
    local Size_1 = arg6.Size
    v14 = if arg7.m_Awake then v14 else if not arg10 then v14 else color
    v15 = if arg6.InNarrowphase ~= false then v15 else if not arg11 then v15 else color_1

    if arg9 then
        Gizmo_m.SetStyle(color_2, 0, false)
        Gizmo_m.Sphere:Draw(Transform, arg6.Radius, 25, 360)
    end

    if Type_1 == "Box" then
        Gizmo_m.SetStyle(v14, 0, false)
        Gizmo_m.Box:Draw(Transform, Size_1)

        if arg8 then
            Gizmo_m.SetStyle(v15, 0.75, false)
            Gizmo_m.VolumeBox:Draw(Transform, Size_1)
            Gizmo_m.PushProperty("Transparency", 0)
        end

        return
    end

    if Type_1 == "Capsule" then
        local v16 = math.min(Size_1.Y, Size_1.Z) * 0.5
        local X = Size_1.X
        local v17 = Transform * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)
        Gizmo_m.SetStyle(v14, 0, false)
        Gizmo_m.Capsule:Draw(v17, v16, X, 15)

        if arg8 then
            local v18 = v17.Position + v17.UpVector * (X * 0.5)
            local v19 = v17.Position - v17.UpVector * (X * 0.5)
            Gizmo_m.SetStyle(v15, 0.75, false)
            Gizmo_m.VolumeCylinder:Draw(Transform, v16, X)
            Gizmo_m.VolumeSphere:Draw(CFrame.new(v18), v16)
            Gizmo_m.VolumeSphere:Draw(CFrame.new(v19), v16)
            Gizmo_m.PushProperty("Transparency", 0)
        end

        return
    end

    if Type_1 == "Sphere" then
        local v20 = math.min(Size_1.X, Size_1.Y, Size_1.Z) * 0.5
        Gizmo_m.SetStyle(v14, 0, false)
        Gizmo_m.Sphere:Draw(Transform, v20, 15, 360)

        if arg8 then
            Gizmo_m.SetStyle(v15, 0.75, false)
            Gizmo_m.VolumeSphere:Draw(Transform, v20)
            Gizmo_m.PushProperty("Transparency", 0)
        end

        return
    end

    if Type_1 == "Cylinder" then
        local v21 = math.min(Size_1.Y, Size_1.Z) * 0.5
        Gizmo_m.SetStyle(v14, 0, false)
        Gizmo_m.Cylinder:Draw(
            Transform * CFrame.Angles(0, 0, 1.5707963267948966),
            v21,
            Size_1.X,
            15
        )

        if arg8 then
            Gizmo_m.SetStyle(v15, 0.75, false)
            Gizmo_m.VolumeCylinder:Draw(
                Transform * CFrame.Angles(0, -1.5707963267948966, 0),
                v21,
                Size_1.X,
                0,
                360
            )
            Gizmo_m.PushProperty("Transparency", 0)
        end

        return
    end
end

function t.Destroy(arg12) -- line: 286
    -- upvalues:
    --  [1] SBVERBOSELOG (copy)

    SBVERBOSELOG(`Collider destroying, object: {arg12.m_Object}`)
    setmetatable(arg12, nil)
end

return t
