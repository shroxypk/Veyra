-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Bone
-- Class: ModuleScript
-- bytes: 24547

local Dependencies: any = script.Parent.Parent:WaitForChild("Dependencies")
local Config_m: any = require(Dependencies:WaitForChild("Config"))
local Gizmo_m: any = require(Dependencies:WaitForChild("Gizmo"))
local Utilities_m: any = require(Dependencies:WaitForChild("Utilities"))

if game:GetService("RunService"):IsStudio() or Config_m.ALLOW_LIVE_GAME_DEBUG then
    Gizmo_m.Init()
end

local Constraints: any = script.Parent:WaitForChild("Constraints")
local AxisConstraint_m: any = require(Constraints:WaitForChild("AxisConstraint"))
local CollisionConstraint_m: any = require(Constraints:WaitForChild("CollisionConstraint"))
local DistanceConstraint_m: any = require(Constraints:WaitForChild("DistanceConstraint"))
local FrictionConstraint_m: any = require(Constraints:WaitForChild("FrictionConstraint"))
local RopeConstraint_m: any = require(Constraints:WaitForChild("RopeConstraint"))
local RotationConstraint_m: any = require(Constraints:WaitForChild("RotationConstraint"))
local SpringConstraint_m: any = require(Constraints:WaitForChild("SpringConstraint"))

local _: any = function(arg1) --[[ IsNaN ]] -- line: 73
    if arg1 ~= arg1 then
        return true
    end

    return false
end

local t: any = {}

local function QueryTransformedWorldCFrameNonSmartbone(u1: userdata) -- line: 86
    -- upvalues:
    --  [1] t (copy)
    --  [2] QueryTransformedWorldCFrameNonSmartbone (copy)

    debug.profilebegin("QueryTransformedWorldCFrameNonSmartbone")
    local v11: any = t[u1]

    if v11 and v11.Frame == shared.FrameCounter then
        return v11.CFrame
    end

    local Parent: userdata = u1.Parent
    local v13: any = (if Parent:IsA("Bone") then QueryTransformedWorldCFrameNonSmartbone(Parent) else Parent.CFrame) * u1.TransformedCFrame
    local t_1 = { Frame = shared.FrameCounter, CFrame = v13 }
    t[u1] = t_1
    debug.profileend()

    return v13
end

local function QueryTransformedWorldCFrame(arg2: any, t1: table) -- line: 113
    -- upvalues:
    --  [1] QueryTransformedWorldCFrameNonSmartbone (copy)
    --  [2] QueryTransformedWorldCFrame (copy)

    debug.profilebegin("QueryTransformedWorldCFrame")
    t1.SolvedAnimatedCFrame = true
    local ParentIndex: number = t1.ParentIndex
    local Bone: userdata = t1.Bone

    if ParentIndex < 1 then
        debug.profileend()

        return (QueryTransformedWorldCFrameNonSmartbone(Bone))
    end

    local v14 = arg2.Bones[ParentIndex]

    if not v14.SolvedAnimatedCFrame then
        v14.AnimatedWorldCFrame = QueryTransformedWorldCFrame(arg2, v14)
    end

    debug.profileend()

    return v14.AnimatedWorldCFrame * Bone.TransformedCFrame
end

local _: any = function(vec1: Vector3, vec2: Vector3, vec3: Vector3) --[[ ClipVector ]] -- line: 135
    return vec1 * (Vector3.new(1, 1, 1) - vec3) + vec2 * vec3
end

local _: any = function(u2: userdata, u3: userdata) --[[ GetFriction ]] -- line: 141
    local CurrentPhysicalProperties: any = u2.CurrentPhysicalProperties
    local CurrentPhysicalProperties_1: any = u3.CurrentPhysicalProperties
    local FrictionWeight: any = CurrentPhysicalProperties.FrictionWeight
    local FrictionWeight_1: any = CurrentPhysicalProperties_1.FrictionWeight

    return (CurrentPhysicalProperties.Friction * FrictionWeight + CurrentPhysicalProperties_1.Friction * FrictionWeight_1) / (FrictionWeight + FrictionWeight_1)
end

local function SolveWind(t2: table, arg3: any) -- line: 154
    local Settings: any = arg3.Settings
    local WindType: any = Settings.WindType

    if WindType ~= "Sine" and (WindType ~= "Noise" and WindType ~= "Hybrid") then
        return Vector3.new(0, 0, 0)
    end

    local v15: any = arg3.WindOffset + (os.clock() - t2.HeirarchyLength * 0.2 + (t2.TransformOffset.Position - arg3.Root.WorldPosition).Magnitude * 0.2) * Settings.WindInfluence
    local v16: any = nil

    local _: any = function(arg4, arg5, arg6, arg7) --[[ GetNoise ]] -- line: 170
        local v17: any = math.noise(arg4, arg5, arg6)
        v17 = math.clamp(v17, -1, 1)

        if arg7 then
            v17 ^= 2
        end

        return v17
    end

    local _: any = function() --[[ SampleGust ]] -- line: 181
        -- upvalues:
        --  [1] v15 (copy)

        return math.sin(v15 * 1) * 0.3 + 0.7
    end

    local _: any = function() --[[ SampleSin ]] -- line: 187
        -- upvalues:
        --  [1] Settings (copy)
        --  [2] v15 (copy)

        local v18: any = Settings.WindStrength ^ 0.8
        local v19: any = Settings.WindSpeed * 2
        local v20: number = math.sin(v15 * v18) ^ 2
        local v21: number = math.cos(v15 * v18) ^ 2

        return Settings.WindDirection * ((v20 + (v21 - v20) * v21) * v19)
    end

    local function SampleNoise(arg8, arg9) -- line: 196
        -- upvalues:
        --  [1] Settings (copy)
        --  [2] arg3 (copy)

        arg8 = arg8 or 0
        local v22: any = Settings.WindStrength ^ 0.8
        local v23: any = Settings.WindSpeed * 2
        local WindOffset_1: any = arg3.WindOffset
        local v24 = math.noise(v22, 0, WindOffset_1)
        v24 = math.clamp(v24, -1, 1)

        if arg9 then
            v24 ^= 2
        end

        local v25: any = v24 * (v23 + arg8)
        local v26 = math.noise(0, v22, WindOffset_1)
        v26 = math.clamp(v26, -1, 1)

        if arg9 then
            v26 ^= 2
        end

        v24 = v26 * (v23 + arg8)
        local v27 = math.noise(WindOffset_1, 0, v22)
        v27 = math.clamp(v27, -1, 1)

        if arg9 then
            v27 ^= 2
        end

        return Settings.WindDirection * Vector3.new(v25, v24, v27 * (v23 + arg8))
    end

    if Settings.WindType == "Sine" then
        local v28 = Settings.WindStrength ^ 0.8
        local v29 = Settings.WindSpeed * 2
        local v30 = math.sin(v15 * v28) ^ 2
        local v31 = math.cos(v15 * v28) ^ 2
        v16 = Settings.WindDirection * ((v30 + (v31 - v30) * v31) * v29) * (math.sin(v15 * 1) * 0.3 + 0.7)
    elseif Settings.WindType == "Noise" then
        v16 = SampleNoise(0, true) * (math.sin(v15 * 1) * 0.3 + 0.7)
    elseif Settings.WindType == "Hybrid" then
        local v34 = Settings.WindStrength ^ 0.8
        local v35 = Settings.WindSpeed * 2
        local v36 = math.sin(v15 * v34) ^ 2
        local v37 = math.cos(v15 * v34) ^ 2
        v16 = (Settings.WindDirection * ((v36 + (v37 - v36) * v37) * v35) * (math.sin(v15 * 1) * 0.3 + 0.7) + SampleNoise(
            0.5,
            true
        ) * (math.sin(v15 * 1) * 0.3 + 0.7)) * 0.5
    end

    v16 /= math.max(t2.FreeLength, 0.01)

    return v16 * (Settings.WindInfluence * (Settings.WindStrength * 0.01) * (math.clamp(
        t2.HeirarchyLength,
        1,
        10
    ) * 0.1)) * t2.Weight
end

local t_2: any = {}
local SBASSERTCB = Utilities_m.SB_ASSERT_CB
local SBVERBOSELOG = Utilities_m.SB_VERBOSE_LOG
t_2.__index = t_2

function t_2.new(u4: userdata, u5: userdata, u6: userdata) -- line: 321
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] Utilities_m (copy)

    local v41: any = u4.Parent:IsA("Bone") and u4.Parent.TransformedWorldCFrame or u6.CFrame
    local t_4: any = setmetatable(
        {
            Bone = u4,
            FreeLength = -1,
            Weight = 0.7,
            ParentIndex = -1,
            HeirarchyLength = 0,
            Transform = u4.TransformedWorldCFrame:ToObjectSpace(v41):Inverse(),
            LocalTransform = u4.TransformedCFrame:ToObjectSpace(u5.TransformedCFrame):Inverse(),
            RootPart = u6,
            RootBone = u5,
            Radius = 0,
            Friction = 0,
            RotationLimit = 0,
            Force = nil,
            Gravity = nil,
            SolvedAnimatedCFrame = false,
            HasChild = false,
            AnimatedWorldCFrame = u4.TransformedWorldCFrame,
            StartingCFrame = u4.TransformedCFrame,
            TransformOffset = CFrame.identity,
            LocalTransformOffset = CFrame.identity,
            RestPosition = Vector3.new(0, 0, 0),
            CalculatedWorldCFrame = u4.TransformedWorldCFrame,
            Position = u4.TransformedWorldCFrame.Position,
            LastPosition = u4.TransformedWorldCFrame.Position,
            WeldPosition = Vector3.new(0, 0, 0),
            ActiveWeld = false,
            RigidWeld = false,
            Anchored = false,
            AxisLocked = { false, false, false },
            XAxisLimits = NumberRange.new(-math.huge, math.huge),
            YAxisLimits = NumberRange.new(-math.huge, math.huge),
            ZAxisLimits = NumberRange.new(-math.huge, math.huge),
            FirstSkipUpdate = false,
            CollisionHits = {},
            CollisionsData = {}
        },
        t_2
    )
    t_4.AttributeConnection = u4.AttributeChanged:Connect(function(_) -- line: 371
        -- upvalues:
        --  [1] Utilities_m (ref)
        --  [2] u4 (copy)
        --  [3] t_4 (copy)

        for key, val in (Utilities_m.GatherBoneSettings(u4)) do
            t_4[key] = if val == "\194\172" then nil else val or nil
        end
    end)

    return t_4
end

function t_2.ClipVelocity(t3: table, vec4: Vector3, vec5: Vector3) -- line: 388
    t3.LastPosition = t3.LastPosition * (Vector3.new(1, 1, 1) - vec5) + vec4 * vec5
end

function t_2.PreUpdate(arg11, arg12) -- line: 394
    -- upvalues:
    --  [1] QueryTransformedWorldCFrame (copy)
    --  [2] QueryTransformedWorldCFrameNonSmartbone (copy)

    debug.profilebegin("Bone::PreUpdate")
    local v43 = arg12.Bones[1]
    local v44 = arg12.Bones[arg11.ParentIndex]
    arg11.AnimatedWorldCFrame = QueryTransformedWorldCFrame(arg12, arg11)
    local SmartWeld: any = arg11.Bone:FindFirstChild("SmartWeld")
    arg11.ActiveWeld = false

    if SmartWeld and SmartWeld:IsA("ObjectValue") then
        local Value = SmartWeld.Value
        arg11.RigidWeld = if SmartWeld:GetAttribute("Rigid") ~= true then false else true

        if Value then
            if Value:IsA("Attachment") then
                arg11.WeldPosition = Value.WorldPosition
                arg11.ActiveWeld = true
            elseif Value:IsA("BasePart") then
                arg11.WeldPosition = Value.Position
                arg11.ActiveWeld = true
            end
        end
    end

    if arg11.ParentIndex < 1 then
        arg11.Anchored = true
    end

    if arg11.Bone == arg11.RootBone then
        arg11.TransformOffset = (if arg11.Bone.Parent:IsA("Bone") then QueryTransformedWorldCFrameNonSmartbone(
            arg11.Bone.Parent
        ) else arg11.RootPart.CFrame) * arg11.Transform
    else
        arg11.TransformOffset = v44.AnimatedWorldCFrame * arg11.Transform
    end

    arg11.LocalTransformOffset = v43.Bone.CFrame * arg11.LocalTransform
    debug.profileend()
end

function t_2.StepPhysics(t4: table, arg13: any, vec6: Vector3, n1: number) -- line: 451
    -- upvalues:
    --  [1] SolveWind (copy)

    debug.profilebegin("Bone::StepPhysics")

    if t4.Anchored then
        t4.LastPosition = t4.AnimatedWorldCFrame.Position
        t4.Position = t4.AnimatedWorldCFrame.Position
        debug.profileend()

        return
    end

    local v48

    if t4.Force or t4.Gravity then
        local v47 = t4.Gravity or arg13.Settings.Gravity
        v48 = t4.Force or arg13.Settings.Force
        vec6 = (v47 + v48) * n1
    end

    local Settings_1 = arg13.Settings
    v48 = t4.Position - t4.LastPosition
    local v49 = arg13.ObjectAcceleration * Settings_1.Inertia
    local v50 = SolveWind(t4, arg13)
    t4.LastPosition = t4.Position
    t4.Position += v48 * (1 - Settings_1.Damping) + vec6 + v49 + v50
    debug.profileend()
end

function t_2.Constrain(t5: table, arg14: any, arg15: any, n2: number) -- line: 484
    -- upvalues:
    --  [1] FrictionConstraint_m (copy)
    --  [2] CollisionConstraint_m (copy)
    --  [3] SpringConstraint_m (copy)
    --  [4] DistanceConstraint_m (copy)
    --  [5] RopeConstraint_m (copy)
    --  [6] AxisConstraint_m (copy)
    --  [7] RotationConstraint_m (copy)

    debug.profilebegin("Bone::Constrain")

    if t5.Anchored then
        debug.profileend()

        return
    end

    local v51 = t5.RootPart.CFrame
    local v52 = FrictionConstraint_m(t5, t5.Position, t5.LastPosition)
    v52 = if #arg15 == 0 then v52 else CollisionConstraint_m(t5, v52, arg15)
    v52 = if arg14.Settings.Constraint ~= "Spring" then if arg14.Settings.Constraint ~= "Distance" then if arg14.Settings.Constraint ~= "Rope" then t5.AnimatedWorldCFrame.Position else RopeConstraint_m(
        t5,
        v52,
        arg14
    ) else DistanceConstraint_m(t5, v52, arg14) else SpringConstraint_m(
        t5,
        v52,
        nil,
        arg14,
        n2
    )
    v52 = RotationConstraint_m(t5, AxisConstraint_m(t5, v52, t5.LastPosition, v51), arg14)

    if t5.ActiveWeld then
        v52 = if t5.RigidWeld then DistanceConstraint_m(t5, t5.WeldPosition, arg14) else SpringConstraint_m(
            t5,
            v52,
            t5.WeldPosition,
            arg14,
            n2
        )
    end

    t5.Friction = 0

    for _, val_1 in t5.CollisionHits do
        local CurrentPhysicalProperties_2 = t5.RootPart.CurrentPhysicalProperties
        local CurrentPhysicalProperties_3 = val_1.CurrentPhysicalProperties
        local FrictionWeight_2 = CurrentPhysicalProperties_2.FrictionWeight
        local FrictionWeight_3 = CurrentPhysicalProperties_3.FrictionWeight
        t5.Friction = math.max(
            (CurrentPhysicalProperties_2.Friction * FrictionWeight_2 + CurrentPhysicalProperties_3.Friction * FrictionWeight_3) / (FrictionWeight_2 + FrictionWeight_3),
            t5.Friction
        )
    end

    t5.Position = v52
    debug.profileend()
end

function t_2.SkipUpdate(arg16) -- line: 538
    -- upvalues:
    --  [1] Config_m (copy)
    --  [2] SBVERBOSELOG (copy)

    if arg16.FirstSkipUpdate == false and Config_m.RESET_TRANSFORM_ON_SKIP then
        SBVERBOSELOG("Skipping bone, resetting transform.")
        arg16.CalculatedWorldCFrame = arg16.AnimatedWorldCFrame
        arg16.FirstSkipUpdate = true
    end

    arg16.Position = arg16.Bone.WorldPosition
    arg16.LastPosition = arg16.Position
end

function t_2.SolveTransform(t6: table, arg17: any, n3: number) -- line: 553
    -- upvalues:
    --  [1] Utilities_m (copy)
    --  [2] SBASSERTCB (copy)

    debug.profilebegin("Bone::SolveTransform")

    if t6.ParentIndex < 1 then
        debug.profileend()

        return
    end

    t6.FirstSkipUpdate = false
    local v53 = arg17.Bones[t6.ParentIndex]
    local Bone_1 = v53.Bone

    if v53 and Bone_1 then
        local TransformOffset = v53.TransformOffset
        local v54 = Utilities_m.GetRotationBetween(
            TransformOffset.UpVector,
            t6.Position - v53.Position
        ).Rotation * TransformOffset.Rotation

        if v53.ActiveWeld and v53.RigidWeld then
            v53.CalculatedWorldCFrame = CFrame.new(v53.Position) * v54
        else
            local v55 = math.min(1 - 1E-05 ^ n3, 1)
            v53.CalculatedWorldCFrame = Bone_1.WorldCFrame:Lerp(CFrame.new(v53.Position) * v54, v55)
        end

        SBASSERTCB(
            not (if v53.CalculatedWorldCFrame.Position == v53.CalculatedWorldCFrame.Position then false else true),
            warn,
            "If you see this report this as a bug, (NaN Calc world cframe)"
        )
    end

    debug.profileend()
end

function t_2.ApplyTransform(arg18, arg19) -- line: 587
    debug.profilebegin("Bone::ApplyTransform")
    arg18.SolvedAnimatedCFrame = false

    if arg18.ParentIndex < 1 then
        debug.profileend()

        return
    end

    local v57 = arg19.Bones[arg18.ParentIndex]
    local Bone_2 = v57.Bone

    if v57 and Bone_2 then
        if v57.Anchored and arg19.Settings.AnchorsRotate == false then
            Bone_2.WorldCFrame = v57.TransformOffset
        else
            if v57.Anchored and arg19.Settings.AnchorsRotate == true then
                Bone_2.WorldCFrame = v57.TransformOffset * v57.CalculatedWorldCFrame.Rotation
                debug.profileend()

                return
            end

            if v57.Anchored then
                Bone_2.WorldCFrame = v57.TransformOffset
                debug.profileend()

                return
            end

            Bone_2.WorldCFrame = v57.CalculatedWorldCFrame
        end
    end

    debug.profileend()
end

function t_2.DrawDebug(
    t7: table,
    arg20: any,
    b1: boolean,
    b2: boolean,
    b3: boolean,
    b4: boolean,
    b5: boolean
) -- line: 628
    -- upvalues:
    --  [1] Gizmo_m (copy)

    debug.profilebegin("Bone::DrawDebug")
    local color: any = Color3.fromRGB(255, 0, 0)
    local color_1: any = Color3.fromRGB(255, 94, 0)
    local color_2: any = Color3.fromRGB(234, 1, 255)
    local color_3: any = Color3.fromRGB(0, 255, 255)
    local color_4: any = Color3.fromRGB(255, 0, 0)
    local color_5: any = Color3.fromRGB(0, 255, 0)
    local color_6: any = Color3.fromRGB(0, 0, 255)
    local color_7: any = Color3.fromRGB(0, 183, 255)
    local color_8: any = Color3.fromRGB(255, 0, 0)
    local color_9: any = Color3.fromRGB(0, 255, 0)
    local color_10: any = Color3.fromRGB(0, 0, 255)
    local color_11: any = Color3.fromRGB(28, 41, 224)
    local v58: any = Color3.fromRGB(255, 27, 27)
    local v59: number = 1
    local AnimatedWorldCFrame: any = t7.AnimatedWorldCFrame
    local Position: any = AnimatedWorldCFrame.Position
    local cframe: any = CFrame.new(t7.Position)
    local cframe_1: any = CFrame.new(t7.LastPosition)

    if b3 then
        Gizmo_m.PushProperty("AlwaysOnTop", false)
        Gizmo_m.PushProperty("Color3", color)
        Gizmo_m.Sphere:Draw(cframe, t7.Radius, 10, 360)
        Gizmo_m.PushProperty("Color3", color_1)
        Gizmo_m.Sphere:Draw(cframe_1, t7.Radius, 10, 360)
        Gizmo_m.PushProperty("Color3", color_2)
        Gizmo_m.Ray:Draw(t7.Position, t7.LastPosition)
    end

    if b4 and not t7.Anchored then
        local RootPart = t7.RootPart
        local v60 = t7.AxisLocked[3]
        local v61 = t7.AxisLocked[2]
        local v62 = t7.AxisLocked[1]
        local v63 = RootPart.CFrame:PointToObjectSpace(Position)
        local RightVector = RootPart.CFrame.RightVector
        local UpVector = RootPart.CFrame.UpVector
        local LookVector = RootPart.CFrame.LookVector

        if not v62 then
            Gizmo_m.PushProperty("Color3", color_8)
            Gizmo_m.Arrow:Draw(
                Position - RightVector * 2,
                Position + RightVector * 2,
                0.05,
                0.15,
                9
            )
            local v66 = t7.XAxisLimits.Max - v63.X
            Gizmo_m.Plane:Draw(
                Position + RightVector * (t7.XAxisLimits.Min - v63.X),
                RightVector,
                Vector3.new(5, 5, 0)
            )
            Gizmo_m.Plane:Draw(Position + RightVector * v66, RightVector, Vector3.new(5, 5, 0))
        end

        if not v61 then
            Gizmo_m.PushProperty("Color3", color_9)
            Gizmo_m.Arrow:Draw(
                Position - UpVector * 2,
                Position + UpVector * 2,
                0.05,
                0.15,
                9
            )
            local v71 = t7.YAxisLimits.Max - v63.Y
            Gizmo_m.Plane:Draw(
                Position + UpVector * (t7.YAxisLimits.Min - v63.Y),
                UpVector,
                Vector3.new(5, 5, 0)
            )
            Gizmo_m.Plane:Draw(Position + UpVector * v71, UpVector, Vector3.new(5, 5, 0))
        end

        if not v60 then
            Gizmo_m.PushProperty("Color3", color_10)
            Gizmo_m.Arrow:Draw(
                Position - LookVector * 2,
                Position + LookVector * 2,
                0.05,
                0.15,
                9
            )
            local v76 = t7.ZAxisLimits.Max - v63.Z
            Gizmo_m.Plane:Draw(
                Position - LookVector * (t7.ZAxisLimits.Min - v63.Z),
                LookVector,
                Vector3.new(5, 5, 0)
            )
            Gizmo_m.Plane:Draw(Position - LookVector * v76, LookVector, Vector3.new(5, 5, 0))
        end
    end

    if b2 then
        Gizmo_m.PushProperty("Color3", color_3)
        Gizmo_m.Sphere:Draw(AnimatedWorldCFrame, 0.08, 5, 360)
        Gizmo_m.PushProperty("Color3", color_4)
        Gizmo_m.VolumeArrow:Draw(
            Position,
            Position + AnimatedWorldCFrame.LookVector * 0.25,
            0.005,
            0.015,
            0.05,
            true
        )
        Gizmo_m.PushProperty("Color3", color_5)
        Gizmo_m.VolumeArrow:Draw(
            Position,
            Position + AnimatedWorldCFrame.UpVector * 0.25,
            0.005,
            0.015,
            0.05,
            true
        )
        Gizmo_m.PushProperty("Color3", color_6)
        Gizmo_m.VolumeArrow:Draw(
            Position,
            Position + AnimatedWorldCFrame.RightVector * 0.25,
            0.005,
            0.015,
            0.05,
            true
        )
    end

    if b1 and not t7.Anchored then
        for _, val_2 in t7.CollisionsData do
            Gizmo_m.PushProperty("Color3", color_11)
            Gizmo_m.Sphere:Draw(CFrame.new(val_2.ClosestPoint), 0.08, 5, 360)
            Gizmo_m.PushProperty("Color3", v58)
            Gizmo_m.Arrow:Draw(
                val_2.ClosestPoint,
                val_2.ClosestPoint + val_2.Normal * 0.5,
                0.05,
                0.15,
                9
            )
        end
    end

    if b5 and t7.RotationLimit < 180 and t7.RotationLimit > 0 and t7.ParentIndex > 0 and t7.HasChild then
        v58 = 1
        local v84

        if t7.RotationLimit < 89.5 then
            v84 = v59 * math.tan((math.rad(t7.RotationLimit)))
        elseif t7.RotationLimit > 90 then
            v58 = -1
            v84 = v59 * math.tan((math.rad(180 - t7.RotationLimit)))
        else
            v59 = 0
            v84 = 5
        end

        v84 = math.min(v84, 5)

        if v84 == 5 then
            v59 = 0
        end

        local v86 = (t7.Position - arg20.Bones[t7.ParentIndex].Position).Unit * v58
        local cframe_3 = CFrame.lookAt(
            Position + v86 * (v59 / 2),
            Position + -v86 * 500,
            AnimatedWorldCFrame.LookVector
        )
        Gizmo_m.PushProperty("Color3", color_7)
        Gizmo_m.Cone:Draw(cframe_3, v84, v59, 8 + v84 * 2)
    end

    debug.profileend()
end

function t_2.DrawOverlay(t8: table, t9: table) -- line: 819
    -- upvalues:
    --  [1] Config_m (copy)

    t9.Text(`Bone: {t8.Bone.Name}`)

    if Config_m.DEBUG_OVERLAY_BONE_INFO or Config_m.DEBUG_OVERLAY_BONE_NUMERICS then
        t9.Text(`Free Length: {t8.FreeLength}`)
        t9.Text(`Weight: {t8.Weight}`)
        t9.Text(`Parent Index: {t8.ParentIndex}`)
        t9.Text(`Heirarchy Length: {t8.HeirarchyLength}`)
        t9.Text(`Radius: {t8.Radius}`)
        t9.Text(`Friction: {t8.Friction}`)
        t9.Text(`Rotation Limit: {t8.RotationLimit}`)
    end

    if Config_m.DEBUG_OVERLAY_BONE_INFO or Config_m.DEBUG_OVERLAY_BONE_CONSTRAIN then
        t9.Text(`Anchored: {t8.Anchored}`)
        t9.Text(`Axis Locked: {t8.AxisLocked[1]}, {t8.AxisLocked[2]}, {t8.AxisLocked[3]}`)
        t9.Text(`X Axis Limit: {t8.XAxisLimits}`)
        t9.Text(`Y Axis Limit: {t8.YAxisLimits}`)
        t9.Text(`Z Axis Limit: {t8.ZAxisLimits}`)
    end

    if Config_m.DEBUG_OVERLAY_BONE_INFO or Config_m.DEBUG_OVERLAY_BONE_WELD then
        t9.Text(`Active Weld: {t8.ActiveWeld}`)
        t9.Text(`Rigid Weld: {t8.RigidWeld}`)
        local Text_15 = t9.Text
        local v88 = string.format(
            "%.3f, %.3f, %.3f",
            t8.WeldPosition.X,
            t8.WeldPosition.Y,
            t8.WeldPosition.Z
        )
        Text_15(`Weld Position: {v88}`)
    end

    if Config_m.DEBUG_OVERLAY_BONE_INFO or Config_m.DEBUG_OVERLAY_BONE_FORCES then
        local v89 = t8.Force and string.format(
            "%.3f, %.3f, %.3f",
            t8.Force.X,
            t8.Force.Y,
            t8.Force.Z
        ) or "-, -, -"
        local v90 = t8.Gravity and string.format(
            "%.3f, %.3f, %.3f",
            t8.Gravity.X,
            t8.Gravity.Y,
            t8.Gravity.Z
        ) or "-, -, -"
        t9.Text(`Force: {v89}`)
        t9.Text(`Gravity: {v90}`)
    end
end

function t_2.Destroy(arg21) -- line: 855
    -- upvalues:
    --  [1] Config_m (copy)

    if Config_m.RESET_BONE_ON_DESTROY then
        task.synchronize()
        arg21.Bone.CFrame = arg21.StartingCFrame
    end

    arg21.AttributeConnection:Disconnect()
    setmetatable(arg21, nil)
end

return t_2
