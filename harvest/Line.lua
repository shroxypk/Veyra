-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Line
-- Class: ModuleScript
-- bytes: 1251

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

function t.Draw(t1: table, u1: CFrame, n1: number) -- line: 16
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    Ceive.Ray:Draw(
        u1.Position + u1.LookVector * (-n1 * 0.5),
        u1.Position + u1.LookVector * (n1 * 0.5)
    )
end

function t.Create(t2: table, u2: CFrame, n2: number) -- line: 29
    local t_2 = {
        Transform = u2,
        Length = n2,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg6, arg7) -- line: 45
    local Ceive_1 = arg6.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg7.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg7.Transparency)
    Ceive_1.PushProperty("Color3", arg7.Color3)
    arg6:Draw(arg7.Transform, arg7.Length)
end

return t
