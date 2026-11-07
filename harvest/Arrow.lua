-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Arrow
-- Class: ModuleScript
-- bytes: 1537

local t = {}
t.__index = t

function t.Init(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 4
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.Ceive = arg1
    t_1.Propertys = arg2
    t_1.Request = arg3
    t_1.Release = arg4
    t_1.Retain = arg5

    return t_1
end

function t.Draw(
    t1: table,
    vec1: Vector3,
    vec2: Vector3,
    n1: number,
    n2: number,
    n3: number
) -- line: 16
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    Ceive.Ray:Draw(vec1, vec2)
    Ceive.Cone:Draw(CFrame.lookAt(vec2 + (vec1 - vec2).Unit * (n2 * 0.5), vec2), n1, n2, n3)
end

function t.Create(
    t2: table,
    vec3: Vector3,
    vec4: Vector3,
    n4: number,
    n5: number,
    n6: number
) -- line: 29
    local t_2 = {
        Origin = vec3,
        End = vec4,
        Radius = n4,
        Length = n5,
        Subdivisions = n6,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg6, arg7) -- line: 48
    local Ceive_1 = arg6.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg7.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg7.Transparency)
    Ceive_1.PushProperty("Color3", arg7.Color3)
    arg6:Draw(
        arg7.Origin,
        arg7.End,
        arg7.Radius,
        arg7.Length,
        arg7.Subdivisions
    )
end

return t
