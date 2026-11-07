-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Capsule
-- Class: ModuleScript
-- bytes: 2742

local t = {}
t.__index = t

function t.Init(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 6
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
    u1: CFrame,
    n1: number,
    n2: number,
    n3: number
) -- line: 18
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    local v1 = u1.Position + u1.UpVector * (n2 * 0.5)
    local v2 = u1.Position - u1.UpVector * (n2 * 0.5)
    local cframe = CFrame.lookAt(v1, v1 + u1.UpVector)
    local cframe_1 = CFrame.lookAt(v2, v2 - u1.UpVector)
    local v3 = nil
    local v4 = nil
    local v5 = nil
    local v6 = nil

    for index = 0, 360, math.floor(360 / n3) do
        local v8 = math.sin((math.rad(index))) * n1
        local v10 = u1.LookVector * (math.cos((math.rad(index))) * n1) + u1.RightVector * v8
        local v11 = cframe.Position + v10
        local v12 = cframe_1.Position + v10
        Ceive.Ray:Draw(v11, v12)
        Ceive.Circle:Draw(
            CFrame.new(cframe.Position) * u1.Rotation * CFrame.Angles(0, math.rad(index), 0),
            n1,
            n3 * 0.5,
            90,
            false
        )
        Ceive.Circle:Draw(
            CFrame.new(cframe_1.Position) * u1.Rotation * CFrame.Angles(
                3.141592653589793,
                math.rad(index),
                0
            ),
            n1,
            n3 * 0.5,
            90,
            false
        )
        local _ = math.floor(360 / n3)

        if not v3 then
            v3 = v11
            v4 = v12
            v5 = v11
            v6 = v12
        else
            Ceive.Ray:Draw(v3, v11)
            Ceive.Ray:Draw(v4, v12)
            v3 = v11
            v4 = v12
        end
    end

    Ceive.Ray:Draw(v3, v5)
    Ceive.Ray:Draw(v4, v6)
end

function t.Create(
    t2: table,
    u2: CFrame,
    n4: number,
    n5: number,
    n6: number
) -- line: 88
    local t_2 = {
        Transform = u2,
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

function t.Update(arg6, arg7) -- line: 106
    local Ceive_1 = arg6.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg7.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg7.Transparency)
    Ceive_1.PushProperty("Color3", arg7.Color3)
    arg6:Draw(arg7.Transform, arg7.Radius, arg7.Length, arg7.Subdivisions)
end

return t
