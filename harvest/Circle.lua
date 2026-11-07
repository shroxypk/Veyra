-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Circle
-- Class: ModuleScript
-- bytes: 2232

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
    u1: CFrame,
    n1: number,
    n2: number,
    n3: number,
    b1: boolean?
) -- line: 16
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    local v1 = nil
    local v2 = nil
    local v3 = 0

    for index = 0, n3, math.floor(n3 / n2) do
        local v5 = math.sin((math.rad(index))) * n1
        local v7 = u1.Position + (u1.UpVector * (math.cos((math.rad(index))) * n1) + u1.RightVector * v5)
        local _ = math.floor(n3 / n2)

        if v1 == nil then
            v1 = v7
            v2 = v7
            v3 = index
        else
            Ceive.Ray:Draw(v1, v7)
            v1 = v7
            v3 = index
        end
    end

    if v3 ~= n3 then
        local v10 = math.sin((math.rad(n3))) * n1
        Ceive.Ray:Draw(
            v1,
            u1.Position + (u1.UpVector * (math.cos((math.rad(n3))) * n1) + u1.RightVector * v10)
        )
    end

    if b1 ~= false then
        Ceive.Ray:Draw(v1, v2)
    end

    return v1
end

function t.Create(
    t2: table,
    u2: CFrame,
    n4: number,
    n5: number,
    n6: number,
    b2: boolean?
) -- line: 64
    local t_2 = {
        Transform = u2,
        Radius = n4,
        Subdivisions = n5,
        Angle = n6,
        ConnectToStart = b2,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg6, arg7) -- line: 83
    local Ceive_1 = arg6.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg7.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg7.Transparency)
    Ceive_1.PushProperty("Color3", arg7.Color3)
    arg6:Draw(
        arg7.Transform,
        arg7.Radius,
        arg7.Subdivisions,
        arg7.Angle,
        arg7.ConnectToStart
    )
end

return t
