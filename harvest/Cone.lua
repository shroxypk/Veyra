-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Cone
-- Class: ModuleScript
-- bytes: 2137

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

    u1 *= CFrame.Angles(-1.5707963267948966, 0, 0)
    local v1 = u1.Position + u1.UpVector * (n2 * 0.5)
    local v2 = u1.Position + -u1.UpVector * (n2 * 0.5)
    local cframe = CFrame.lookAt(v1, v1 + u1.UpVector)
    local cframe_1 = CFrame.lookAt(v2, v2 - u1.UpVector)
    local v3 = nil
    local v4 = nil

    for index = 0, 360, math.floor(360 / n3) do
        local v6 = math.sin((math.rad(index))) * n1
        local v8 = cframe_1.Position + (u1.LookVector * (math.cos((math.rad(index))) * n1) + u1.RightVector * v6)
        local _ = math.floor(360 / n3)

        if not v3 then
            v3 = v8
            v4 = v8
            Ceive.Ray:Draw(v8, cframe.Position)
        else
            Ceive.Ray:Draw(v8, cframe.Position)
            Ceive.Ray:Draw(v3, v8)
            v3 = v8
        end
    end

    Ceive.Ray:Draw(v3, v4)
end

function t.Create(
    t2: table,
    u2: CFrame,
    n4: number,
    n5: number,
    n6: number
) -- line: 63
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

function t.Update(arg6, arg7) -- line: 81
    local Ceive_1 = arg6.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg7.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg7.Transparency)
    Ceive_1.PushProperty("Color3", arg7.Color3)
    arg6:Draw(arg7.Transform, arg7.Radius, arg7.Length, arg7.Subdivisions)
end

return t
