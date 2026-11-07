-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.VolumeArrow
-- Class: ModuleScript
-- bytes: 1902

local t = {}
t.__index = t

function t.Init(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5,
    arg6
) -- line: 4
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.Ceive = arg1
    t_1.Propertys = arg2
    t_1.Request = arg3
    t_1.Release = arg4
    t_1.Retain = arg5
    t_1.Register = arg6

    return t_1
end

function t.Draw(
    t1: table,
    vec1: Vector3,
    vec2: Vector3,
    n1: number,
    n2: number,
    n3: number,
    b1: boolean?
) -- line: 17
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    local cframe = CFrame.lookAt(vec2 - (vec2 - vec1).Unit * (n3 * 0.5), vec2)

    if b1 == true then
        local Position = cframe.Position
        local Magnitude = (Position - vec1).Magnitude
        Ceive.VolumeCylinder:Draw(CFrame.lookAt((vec1 + Position) * 0.5, vec2), n1, Magnitude)
    else
        Ceive.Ray:Draw(vec1, vec2)
    end

    Ceive.VolumeCone:Draw(cframe, n2, n3)
end

function t.Create(
    t2: table,
    vec3: Vector3,
    vec4: Vector3,
    n4: number,
    n5: number,
    n6: number,
    b2: boolean?
) -- line: 39
    local t_2 = {
        Origin = vec3,
        End = vec4,
        CylinderRadius = n4,
        ConeRadius = n5,
        Length = n6,
        UseCylinder = b2,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg7, arg8) -- line: 59
    local Ceive_1 = arg7.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg8.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg8.Transparency)
    Ceive_1.PushProperty("Color3", arg8.Color3)
    arg7:Draw(
        arg8.Origin,
        arg8.End,
        arg8.Radius,
        arg8.Length,
        arg8.UseCylinder
    )
end

return t
