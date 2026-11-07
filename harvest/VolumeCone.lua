-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.VolumeCone
-- Class: ModuleScript
-- bytes: 1650

local t = {}
local Terrain = workspace.Terrain
t.__index = t

function t.Init(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5,
    arg6
) -- line: 6
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

function t.Draw(t1: table, u1: CFrame, n1: number, n2: number) -- line: 19
    -- upvalues:
    --  [1] Terrain (copy)

    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    local v1 = t1.Request("ConeHandleAdornment")
    v1.Color3 = t1.Propertys.Color3
    v1.Transparency = t1.Propertys.Transparency
    v1.CFrame = u1
    v1.AlwaysOnTop = t1.Propertys.AlwaysOnTop
    v1.ZIndex = 1
    v1.Height = n2
    v1.Radius = n1
    v1.Adornee = Terrain
    v1.Parent = Terrain
    Ceive.ActiveInstances += 1
    t1.Register(v1)
end

function t.Create(t2: table, u2: CFrame, n3: number, n4: number) -- line: 43
    local t_2 = {
        Transform = u2,
        Radius = n3,
        Length = n4,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg7, arg8) -- line: 60
    local Ceive_1 = arg7.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg8.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg8.Transparency)
    Ceive_1.PushProperty("Color3", arg8.Color3)
    arg7:Draw(arg8.Transform, arg8.Radius, arg8.Length)
end

return t
