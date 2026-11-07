-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.BoneTree
-- Class: ModuleScript
-- bytes: 11555

local rng: any = Random.new(1029410295159813)
local Lighting: any = game:GetService("Lighting")
local Dependencies: any = script.Parent.Parent:WaitForChild("Dependencies")
local _: any = require(script.Parent:WaitForChild("Bone"))
local Config_m: any = require(Dependencies:WaitForChild("Config"))
local DefaultObjectSettings_m: any = require(Dependencies:WaitForChild("DefaultObjectSettings"))
local Gizmo_m: any = require(Dependencies:WaitForChild("Gizmo"))
local Utilities_m: any = require(Dependencies:WaitForChild("Utilities"))

if game:GetService("RunService"):IsStudio() or Config_m.ALLOW_LIVE_GAME_DEBUG then
    Gizmo_m.Init()
end

local _: any = function(vec1: Vector3) --[[ SafeUnit ]] -- line: 49
    if vec1.Magnitude == 0 then
        return Vector3.new(0, 0, 0)
    end

    return vec1.Unit
end

local _: any = function(
    n1: number,
    n2: number,
    n3: number,
    n4: number,
    n5: number,
    b1: boolean
) --[[ map ]] -- line: 58
    local v6: number = (n1 - n2) / (n3 - n2) * (n5 - n4) + n4

    if not b1 then
        return v6
    end

    local v7, v8

    if n4 < n5 then
        v7 = n5 > v6 and v6 or n5
        v8 = if not (n4 < v7) then n4 else n5 > v6 and v6 or (n5 or n4)

        return v8
    end

    v7 = n4 > v6 and v6 or n4
    v8 = if not (n5 < v7) then n5 else n4 > v6 and v6 or (n4 or n5)

    return v8
end

local t: any = {}
local SBVERBOSELOG = Utilities_m.SB_VERBOSE_LOG
t.__index = t

function t.new(u1: userdata, u2: userdata) -- line: 160
    -- upvalues:
    --  [1] rng (copy)
    --  [2] t (copy)
    --  [3] DefaultObjectSettings_m (copy)

    local t_2: any = setmetatable(
        {
            WindOffset = rng:NextNumber(0, 1000000),
            Root = u1:IsA("Bone") and u1 or nil,
            RootPart = u2,
            RootPartSize = u2.Size,
            Bones = {},
            Settings = {},
            UpdateRate = 0,
            InView = true,
            AccumulatedDelta = 0,
            BoundingBoxCFrame = u2.CFrame,
            BoundingBoxSize = u2.Size,
            Destroyed = false,
            FirstSkipUpdate = false,
            Force = Vector3.new(0, 0, 0),
            ObjectMove = Vector3.new(0, 0, 0),
            ObjectVelocity = Vector3.new(0, 0, 0),
            ObjectAcceleration = Vector3.new(0, 0, 0),
            ObjectPreviousPosition = u2.Position
        },
        t
    )
    t_2.DestroyConnection = u2.AncestryChanged:Connect(function() -- line: 184
        -- upvalues:
        --  [1] u2 (copy)
        --  [2] t_2 (copy)

        if not u2:IsDescendantOf(game) then
            t_2.Destroyed = true
        end
    end)
    t_2.AttributeConnection = u2.AttributeChanged:Connect(function(attribute) -- line: 190
        -- upvalues:
        --  [1] t_2 (copy)
        --  [2] u2 (copy)
        --  [3] DefaultObjectSettings_m (ref)

        local Settings = t_2.Settings
        Settings[attribute] = u2:GetAttribute(attribute) or DefaultObjectSettings_m[attribute]
    end)

    return t_2
end

function t.UpdateBoundingBox(arg2) -- line: 201
    debug.profilebegin("BoneTree::UpdateBoundingBox")

    if not arg2.InView then
        arg2.BoundingBoxCFrame = arg2.RootPart.CFrame
        arg2.BoundingBoxSize = arg2.RootPart.Size
        debug.profileend()

        return
    end

    local v11 = Vector3.new(Infinity, Infinity, Infinity)
    local v12 = Vector3.new(-Infinity, -Infinity, -Infinity)
    debug.profilebegin("Max Min Bones")

    for _, val in arg2.Bones do
        debug.profilebegin("Max Min Bone")
        local Position = val.Position
        v11 = v11:Min(Position)
        v12 = v12:Max(Position)
        debug.profileend()
    end

    debug.profileend()
    arg2.BoundingBoxCFrame = CFrame.new((v11 + v12) / 2)
    arg2.BoundingBoxSize = arg2.RootPartSize:Max(v12 - v11)
    debug.profileend()
end

function t.UpdateThrottling(t1: table, vec2: Vector3) -- line: 237
    debug.profilebegin("BoneTree::UpdateThrottling")
    local Settings_1: any = t1.Settings
    local Magnitude: any = (vec2 - workspace.CurrentCamera.CFrame.Position).Magnitude

    if Magnitude > Settings_1.ActivationDistance then
        t1.UpdateRate = 0
        debug.profileend()

        return
    end

    local ThrottleDistance = Settings_1.ThrottleDistance
    local v14 = (Magnitude - ThrottleDistance) / (Settings_1.ActivationDistance - ThrottleDistance) * 1 + 0
    local v16 = if not ((v14 < 1 and v14 or 1) > 0) then 0 else v14 < 1 and v14 or 1
    t1.UpdateRate = Settings_1.UpdateRate * (1 - v16)
    debug.profileend()
end

function t.PreUpdate(t2: table, n6: number) -- line: 258
    debug.profilebegin("BoneTree::PreUpdate")
    local Position_1: any = t2.RootPart.CFrame.Position
    local ObjectVelocity = t2.ObjectVelocity
    t2.ObjectMove = Position_1 - t2.ObjectPreviousPosition
    t2.ObjectVelocity = t2.ObjectVelocity:Lerp(t2.ObjectMove / n6 / 4, (math.min(n6 * 10, 1)))
    t2.ObjectAcceleration = (ObjectVelocity - t2.ObjectVelocity) * n6
    t2.ObjectPreviousPosition = Position_1
    local v19
    t2.RootPartSize, v19 = t2.RootPart.Size, Position_1
    t2:UpdateThrottling(v19)
    t2:UpdateBoundingBox()

    for _, val_1 in t2.Bones do
        val_1:PreUpdate(t2)
    end

    debug.profileend()
end

function t.StepPhysics(t3: table, n7: number) -- line: 283
    -- upvalues:
    --  [1] Lighting (copy)
    --  [2] DefaultObjectSettings_m (copy)

    debug.profilebegin("BoneTree::StepPhysics")
    local Settings_2: any = t3.Settings
    local v20: any = (Settings_2.Gravity + Settings_2.Force) * n7
    local v22

    if Settings_2.MatchWorkspaceWind == true then
        local GlobalWind = workspace.GlobalWind
        Settings_2.WindDirection = if GlobalWind.Magnitude ~= 0 then GlobalWind.Unit else Vector3.new(0, 0, 0)
        Settings_2.WindSpeed = GlobalWind.Magnitude
    else
        v22 = Lighting:GetAttribute("WindDirection") or DefaultObjectSettings_m.WindDirection
        local v23 = Lighting:GetAttribute("WindSpeed") or DefaultObjectSettings_m.WindSpeed
        Settings_2.WindDirection = if v22.Magnitude ~= 0 then v22.Unit else Vector3.new(0, 0, 0)
        Settings_2.WindSpeed = v23
    end

    v22 = Lighting:GetAttribute("WindStrength") or DefaultObjectSettings_m.WindStrength
    Settings_2.WindStrength = v22

    for _, val_2 in t3.Bones do
        val_2:StepPhysics(t3, v20, n7)
    end

    debug.profileend()
end

function t.Constrain(t4: table, arg3: any, n8: number) -- line: 315
    debug.profilebegin("BoneTree::Constrain")

    for _, val_3 in t4.Bones do
        val_3:Constrain(t4, arg3, n8)
    end

    debug.profileend()
end

function t.SkipUpdate(arg4) -- line: 325
    debug.profilebegin("BoneTree::SkipUpdate")

    for _, val_4 in arg4.Bones do
        val_4:SkipUpdate()
    end

    arg4.FirstSkipUpdate = true
    debug.profileend()
end

function t.SolveTransform(t5: table, n9: number) -- line: 337
    debug.profilebegin("BoneTree::SolveTransform")

    for _, val_5 in t5.Bones do
        val_5:SolveTransform(t5, n9)
    end

    t5.FirstSkipUpdate = false
    debug.profileend()
end

function t.ApplyTransform(arg5) -- line: 349
    debug.profilebegin("BoneTree::ApplyTransform")

    for _, val_6 in arg5.Bones do
        val_6:ApplyTransform(arg5)
    end

    debug.profileend()
end

function t.DrawDebug(
    t6: table,
    b2: boolean,
    b3: boolean,
    b4: boolean,
    b5: boolean,
    b6: boolean,
    b7: boolean,
    b8: boolean,
    b9: boolean
) -- line: 367
    -- upvalues:
    --  [1] Gizmo_m (copy)

    debug.profilebegin("BoneTree::DrawDebug")
    local color: any = Color3.fromRGB(248, 168, 20)
    local color_1: any = Color3.fromRGB(76, 208, 223)
    local color_2: any = Color3.fromRGB(255, 89, 89)
    local color_3: any = Color3.new(1, 0, 0)
    local color_4: any = Color3.new(0, 1, 0)
    local color_5: any = Color3.new(0, 0, 1)

    if b9 then
        local v25 = t6.RootPart.Position + Vector3.new(0, t6.RootPart.Size.Y / 2 + 1, 0)
        Gizmo_m.SetStyle(color_3, 0, true)
        Gizmo_m.Arrow:Draw(
            v25,
            v25 + t6.ObjectMove,
            0.025,
            0.1,
            6
        )
        Gizmo_m.SetStyle(color_4, 0, true)
        Gizmo_m.Arrow:Draw(
            v25,
            v25 + t6.ObjectVelocity,
            0.025,
            0.1,
            6
        )
        Gizmo_m.SetStyle(color_5, 0, true)
        Gizmo_m.Arrow:Draw(
            v25,
            v25 + t6.ObjectAcceleration,
            0.025,
            0.1,
            6
        )
    end

    Gizmo_m.PushProperty("AlwaysOnTop", false)

    if b7 then
        Gizmo_m.PushProperty("Color3", color_1)
        Gizmo_m.Box:Draw(t6.BoundingBoxCFrame, t6.BoundingBoxSize, true)
    end

    if b6 then
        Gizmo_m.PushProperty("Color3", color_1)
        Gizmo_m.Box:Draw(t6.RootPart.CFrame, t6.RootPart.Size, true)
        Gizmo_m.SetStyle(color_2, 0.75, false)
        Gizmo_m.VolumeBox:Draw(t6.RootPart.CFrame, t6.RootPart.Size)
        Gizmo_m.PushProperty("Transparency", 0)
    end

    for key_7, val_7 in t6.Bones do
        local v29 = t6.Bones[val_7.ParentIndex]
        local Position_3 = val_7.Bone.TransformedWorldCFrame.Position
        val_7:DrawDebug(
            t6,
            b2,
            b3,
            b4,
            b5,
            b8
        )

        if b3 and key_7 ~= 1 then
            Gizmo_m.PushProperty("Color3", color)
            Gizmo_m.Ray:Draw(v29.Bone.TransformedWorldCFrame.Position, Position_3)
        end
    end

    debug.profileend()
end

function t.DrawOverlay(t7: table, t8: table) -- line: 432
    -- upvalues:
    --  [1] Config_m (copy)

    if Config_m.DEBUG_OVERLAY_TREE_INFO or Config_m.DEBUG_OVERLAY_TREE_OBJECTS then
        t8.Text(`Root Part: {t7.RootPart.Name}`)
        t8.Text(`Root Bone: {t7.Root.Name}`)
        local Text_2 = t8.Text
        local v30 = string.format(
            "%.3f, %.3f, %.3f",
            t7.RootPart.Size.X,
            t7.RootPart.Size.Y,
            t7.RootPart.Size.Z
        )
        Text_2(`Root Part Size: {v30}`)
    end

    if Config_m.DEBUG_OVERLAY_TREE_INFO or Config_m.DEBUG_OVERLAY_TREE_NUMERICS then
        local Text_3 = t8.Text
        local v31 = string.format("%.3f", t7.UpdateRate)
        Text_3(`Update Rate: {v31}`)
        t8.Text(`In View: {t7.InView}`)
        local Text_5 = t8.Text
        local v32 = string.format("%.3f", t7.AccumulatedDelta)
        Text_5(`Accumulated Delta: {v32}`)
        local Text_6 = t8.Text
        local v33 = string.format("%.3f, %.3f, %.3f", t7.Force.X, t7.Force.Y, t7.Force.Z)
        Text_6(`Force: {v33}`)
    end

    local color_6: any = Color3.new(0.486275, 0.431373, 1)
    local color_7: any = Color3.new(1, 1, 1)

    if Config_m.DEBUG_OVERLAY_BONE then
        for key_8, val_8 in t7.Bones do
            if Config_m.DEBUG_OVERLAY_MAX_BONES > 0 and key_8 >= Config_m.DEBUG_OVERLAY_BONE_OFFSET + Config_m.DEBUG_OVERLAY_MAX_BONES then
                break
            end

            if not (key_8 < Config_m.DEBUG_OVERLAY_BONE_OFFSET) then
                t8.Begin(`Bone {key_8}`, color_6, color_7)
                val_8:DrawOverlay(t8)
                t8.End()
            end
        end
    end
end

function t.Destroy(arg6) -- line: 468
    -- upvalues:
    --  [1] SBVERBOSELOG (copy)

    SBVERBOSELOG("Destroy BoneTree")
    task.synchronize()
    arg6.DestroyConnection:Disconnect()
    arg6.AttributeConnection:Disconnect()

    for _, val_9 in arg6.Bones do
        val_9:Destroy()
    end

    setmetatable(arg6, nil)
    task.desynchronize()
end

return t
