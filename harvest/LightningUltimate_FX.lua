-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Ultimates.LightningUltimate_FX
-- Class: ModuleScript
-- bytes: 23729

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local _ = require(Modules.CameraShaker)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local _ = require(Modules.Utility)
local _ = require(Modules.Packages.ForgeVFX.effects.lightning)
local _ = require(Modules.Packages.ForgeVFX.effects.mesh)
local rng = Random.new()
local LocalPlayer = game.Players.LocalPlayer
local mouse = Players.LocalPlayer:GetMouse()
local Effects = _G.GetModule("Effects")
local CameraShaker_m_1 = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
local v3 = CameraShaker_m_1.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 31
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v3:Start()
VFX_m.init()

local _ = function(arg2) --[[ newRayParams ]] -- line: 38
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = arg2

    return raycastParams
end

local v4 = Vector3.new(0, 0, 0)
local v5 = nil

local _ = function(arg3) --[[ startLeapCamera ]] -- line: 51
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] RunService (copy)
    --  [3] v4 (ref)
    --  [4] CurrentCamera (copy)

    v5 = RunService.RenderStepped:Connect(function() -- line: 52
        -- upvalues:
        --  [1] arg3 (copy)
        --  [2] v4 (ref)
        --  [3] CurrentCamera (ref)

        local _ = arg3.PrimaryPart.Position
        v4 = v4:Lerp(Vector3.new(0, 0, 0), 0.12)
        CurrentCamera.CFrame += v4
    end)
end

local _ = function() --[[ stopLeapCamera ]] -- line: 59
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] v4 (ref)

    if v5 then
        v5:Disconnect()
        v5 = nil
        v4 = Vector3.new(0, 0, 0)
    end
end

local function ModelTransparency(arg4, arg5) -- line: 67
    local Humanoid = arg4:FindFirstChild("Humanoid")

    if Humanoid then
        Humanoid.NameDisplayDistance = if not arg5 then 0 else 1
    end

    for _, val in arg4:QueryDescendants("BasePart, Decal") do
        val:SetAttribute(
            "OriginalTransparency",
            val:GetAttribute("OriginalTransparency") or val.Transparency
        )

        if arg5 then
            local OriginalTransparency = val:GetAttribute("OriginalTransparency")
            val.Transparency = if val:GetAttribute("Hidden") then 1 else if OriginalTransparency == nil then val.Transparency else OriginalTransparency or val.Transparency
        else
            val.Transparency = 1
        end
    end
end

local _ = function(arg6, arg7, arg8) --[[ MousePosition ]] -- line: 88
    local raycastParams_1 = RaycastParams.new()
    raycastParams_1.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams_1.FilterDescendantsInstances = arg7
    local v9 = arg6 or 1000
    local v10 = arg8.UnitRay.Origin + arg8.UnitRay.Direction * v9
    local v12 = workspace:Raycast(arg8.UnitRay.Origin, arg8.UnitRay.Direction * v9, raycastParams_1)

    if v12 then
        v10 = v12.Position
    end

    return v10
end

local function GeneratePoints(arg9, arg10, arg11) -- line: 99
    -- upvalues:
    --  [1] rng (copy)

    local Points = arg9.Points
    local children = Points:GetChildren()
    local v13 = (arg10 - arg11).Magnitude / #children

    for index = 1, #children do
        local v14 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(2, 3) or rng:NextInteger(-3, -2)
        local v15 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(2, 3) or rng:NextInteger(-3, -2)
        local v16 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(2, 3) or rng:NextInteger(-3, -2)
        Points[index].WorldCFrame = CFrame.lookAt(arg10, arg11)
        local v18 = Points[index]
        v18.WorldPosition += Points[index].WorldCFrame.LookVector * (index * v13)
        local v19 = Points[index]
        v19.WorldPosition = v19.WorldPosition + Vector3.new(v14, v15, v16)
    end
end

local function AfterImage(arg12, arg13, arg14, arg15) -- line: 118
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)

    local v20 = ReplicatedStorage.Effects.FXDummy:Clone()
    local v21 = arg12:GetPivot()

    for _, child in pairs(v20:GetChildren()) do
        local v23 = arg12:FindFirstChild(child.Name)

        if v23 then
            child.Color = arg13
            child.CFrame = arg14 * v21:ToObjectSpace(v23.CFrame)

            if arg15 then
                child.Transparency = 0.8
                _G.Tween(
                    child,
                    { 0.8, "Linear", Enum.EasingDirection.Out },
                    { Transparency = 1, Size = child.Size * 2 },
                    true
                )
            else
                _G.Tween(
                    child,
                    { 0.7, "EntranceExpressive", Enum.EasingDirection.Out },
                    { Transparency = 1 },
                    true
                )
            end
        end
    end

    v20.Parent = workspace.Effects
    Services_m.Debris(v20, 0.5)
end

local t_1 = {}

local function Attack(arg16) -- line: 141
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] Services_m (copy)
    --  [4] ForgeVFX_m (copy)
    --  [5] rng (copy)
    --  [6] Effects (copy)
    --  [7] v3 (copy)
    --  [8] ModelTransparency (copy)
    --  [9] AfterImage (copy)
    --  [10] v5 (ref)
    --  [11] RunService (copy)
    --  [12] v4 (ref)
    --  [13] t_1 (copy)
    --  [14] GeneratePoints (copy)
    --  [15] LocalPlayer (copy)
    --  [16] mouse (copy)

    local Character = arg16.Character
    local Action = arg16.Action
    local Position_1 = arg16.Position
    local BeamAttach1, LookVector, New_1, Position_2, PrimaryPart_1, RightArm, RightVector, VFXBeams, os_clock, t_3

    if Character then
        if (Character:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
            return
        end

        local v28 = GrimoireRarity_m:GetPlayerVariant(Character)
        local v29 = v28.Primary

        if not v28 or not v29 then
            v29 = Color3.fromRGB(115, 222, 251)
        end

        if Action == "Windup" then
            local v35 = Character.PrimaryPart.CFrame * CFrame.new(0, -2, 0)
            local v36 = script.WindupVFX_Model:Clone()
            Services_m.Debris(v36, 5)
            GrimoireRarity_m:ApplyVariantEffect(v36, v28)
            v36:PivotTo(Character.PrimaryPart.CFrame * CFrame.new(0, 0, 0))
            v36.Parent = workspace.Effects
            local v46 = "ParticleEmitter"

            for _, val_1 in v36:QueryDescendants(v46), nil, nil do
                ForgeVFX_m.emit(val_1)
            end

            task.delay(0.3, function() -- line: 166
                -- upvalues:
                --  [1] rng (ref)
                --  [2] v35 (copy)
                --  [3] Effects (ref)
                --  [4] v29 (copy)

                for index_1 = 1, 5 do
                    local v49 = index_1 / 2 * 9
                    task.spawn(function() -- line: 169
                        -- upvalues:
                        --  [1] rng (ref)
                        --  [2] v49 (copy)
                        --  [3] v35 (ref)
                        --  [4] Effects (ref)
                        --  [5] v29 (ref)

                        for _ = 1, 4 do
                            local v52 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(
                                math.floor(v49 / 1.5),
                                v49
                            ) or rng:NextInteger(-v49, -math.floor(v49 / 1.5))
                            local v59 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(
                                math.floor(v49 / 1.5),
                                v49
                            ) or rng:NextInteger(-v49, -math.floor(v49 / 1.5))
                            Effects:Lightning3(
                                (v35 * CFrame.new(0, 0, 0)).p,
                                (v35 * CFrame.new(v52, 0, v59)).p,
                                8,
                                { Min = 0.15, Max = 0.5 },
                                v29
                            )
                            task.wait()
                        end
                    end)
                    task.wait(0.03)
                end
            end)
            v3:ShakeOnce(5, 6)

            return
        end

        if Action == "Leap" then
            PrimaryPart_1 = Character.PrimaryPart
            ModelTransparency(Character, false)
            AfterImage(Character, v29, PrimaryPart_1.CFrame)
            Position_2 = PrimaryPart_1.Position
            local v78 = CFrame.lookAt(Position_2, Position_1)
            LookVector = v78.LookVector
            RightVector = v78.RightVector
            local v80 = (Position_1 - Position_2).Magnitude / 3
            local v79 = if rng:NextInteger(0, 1) == 0 then 1 else -1
            local v81 = rng:NextNumber(8, 15)
            local v82 = Position_2

            local function v83() -- line: 52
                -- upvalues:
                --  [1] Character (copy)
                --  [2] v4 (ref)
                --  [3] CurrentCamera (ref)

                local _ = Character.PrimaryPart.Position
                v4 = v4:Lerp(Vector3.new(0, 0, 0), 0.12)
                CurrentCamera.CFrame += v4
            end

            v5 = RunService.RenderStepped:Connect(v83)
            v83 = 1
            local v84

            for index_3 = v83, 3 do
                if index_3 == 3 then
                    v84 = Position_1
                else
                    local v85 = v81 * 0.6
                    local v88 = if v79 >= 0 then rng:NextNumber(-v81, -v85) else rng:NextNumber(
                        v85,
                        v81
                    )
                    v79 = v88
                    v84 = Position_2 + LookVector * (v80 * index_3) + RightVector * v88
                    v4 = (v84 - Character.PrimaryPart.Position).Unit * 6
                    AfterImage(Character, v29, CFrame.lookAt(v84, v84 + LookVector))
                end

                local v90 = script.CloneBeam:Clone()
                Services_m.Debris(v90, 30)
                GrimoireRarity_m:ApplyVariantEffect(v90, v28)
                BeamAttach1 = v90:FindFirstChild("BeamAttach1")
                BeamAttach1.WorldPosition = v82
                v90:FindFirstChild("BeamAttach2").WorldPosition = v82
                v90.Parent = workspace.Effects
                _G.Tween(
                    BeamAttach1,
                    { 0.14, "EntranceExpressive", Enum.EasingDirection.Out },
                    { WorldPosition = v84 }
                )

                for _, val_2 in v90:QueryDescendants("Beam") do
                    _G.Tween(
                        val_2,
                        { 0.32, "EntranceExpressive", Enum.EasingDirection.Out },
                        { Width1 = 0 }
                    )
                    _G.Tween(
                        val_2,
                        { 0.7, "EntranceExpressive", Enum.EasingDirection.Out },
                        { Width0 = 0 }
                    )
                end

                for _ = 1, 2 do
                    t_3 = {
                        Speed = 6,
                        Length = rng:NextNumber(0.75, 1),
                        Radius = 1,
                        Color = v29,
                        Unit = 2,
                        Curve = 4,
                        Thickness = rng:NextNumber(0.5, 1)
                    }
                    Effects.GenerateLightning(CFrame.new(v82), CFrame.new(v84), t_3)
                end

                v82 = v84
                task.wait(0.1)
            end

            if v5 then
                v5:Disconnect()
                v5 = nil
                v4 = Vector3.new(0, 0, 0)
            end

            ModelTransparency(Character, true)

            return
        end

        if Action == "Beam" then
            local v91 = Services_m.Maid.new()
            local v92 = Position_1
            RightArm = Character["Right Arm"].RightGripAttachment
            local v93 = script.LightningBeam:Clone()
            VFXBeams = v93["VFX/Beams"].StartingVFX.BeamParticles
            GrimoireRarity_m:ApplyVariantEffect(v93, v28)
            v93.Parent = workspace.Effects

            for _, descendant in v93:GetDescendants() do
                if descendant:IsA("Attachment") then
                    if descendant.Name ~= "Bezier" then
                        if descendant:IsA("ParticleEmitter") then
                            if descendant.Name == "SmokeDebris" then
                                if descendant:IsA("Model") then
                                    if descendant.Name ~= "Mesh" then
                                        if descendant:IsA("Beam") then
                                            ForgeVFX_m.enable(descendant)
                                        end
                                    else
                                        ForgeVFX_m.enable(descendant)
                                    end
                                elseif descendant:IsA("Beam") then
                                    ForgeVFX_m.enable(descendant)
                                end
                            else
                                ForgeVFX_m.enable(descendant)
                            end
                        elseif descendant:IsA("Model") then
                            if descendant.Name ~= "Mesh" then
                                if descendant:IsA("Beam") then
                                    ForgeVFX_m.enable(descendant)
                                end
                            else
                                ForgeVFX_m.enable(descendant)
                            end
                        elseif descendant:IsA("Beam") then
                            ForgeVFX_m.enable(descendant)
                        end
                    else
                        ForgeVFX_m.enable(descendant)
                    end
                elseif descendant:IsA("ParticleEmitter") then
                    if descendant.Name == "SmokeDebris" then
                        if descendant:IsA("Model") then
                            if descendant.Name ~= "Mesh" then
                                if descendant:IsA("Beam") then
                                    ForgeVFX_m.enable(descendant)
                                end
                            else
                                ForgeVFX_m.enable(descendant)
                            end
                        elseif descendant:IsA("Beam") then
                            ForgeVFX_m.enable(descendant)
                        end
                    else
                        ForgeVFX_m.enable(descendant)
                    end
                elseif descendant:IsA("Model") then
                    if descendant.Name ~= "Mesh" then
                        if descendant:IsA("Beam") then
                            ForgeVFX_m.enable(descendant)
                        end
                    else
                        ForgeVFX_m.enable(descendant)
                    end
                elseif descendant:IsA("Beam") then
                    ForgeVFX_m.enable(descendant)
                end
            end

            if (Character:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude < 100 then
                local v94 = v3:StartShake(1, 10)
                task.delay(3.5, function() -- line: 284
                    -- upvalues:
                    --  [1] v94 (copy)

                    v94:StartFadeOut(1)
                end)
            end

            local SmokeDebris = v93["VFX/Beams"].EndingVFX.SmokeDebris
            local v95 = script.GroundImpact:Clone()
            GrimoireRarity_m:ApplyVariantEffect(v95, v28)
            v95.Position = v92
            local v97 = Character
            New_1 = RaycastParams.new
            local t_4 = { v97, workspace.Effects, workspace.Terrain }
            local v98 = New_1()
            v98.FilterType = Enum.RaycastFilterType.Exclude
            v98.FilterDescendantsInstances = t_4
            local clock = os.clock()
            os_clock = os.clock()
            v91:GiveTask(Services_m.RunService.Heartbeat:Connect(function(deltaTime) -- line: 299
                -- upvalues:
                --  [1] clock (copy)
                --  [2] t_1 (ref)
                --  [3] Character (copy)
                --  [4] v91 (copy)
                --  [5] v93 (copy)
                --  [6] ForgeVFX_m (ref)
                --  [7] os_clock (ref)
                --  [8] v92 (ref)
                --  [9] v98 (copy)
                --  [10] SmokeDebris (copy)
                --  [11] v95 (copy)
                --  [12] GeneratePoints (ref)
                --  [13] LocalPlayer (ref)
                --  [14] mouse (ref)
                --  [15] RightArm (copy)
                --  [16] VFXBeams (copy)

                local v99 = os.clock()

                if v99 - clock > 3.5 then
                    t_1[Character] = nil
                    v91:Destroy()

                    for _, descendant_1 in v93:GetDescendants() do
                        if descendant_1:IsA("Attachment") then
                            if descendant_1.Name ~= "Bezier" then
                                if not descendant_1:IsA("ParticleEmitter") then
                                    if descendant_1:IsA("Model") then
                                        if descendant_1.Name ~= "Mesh" then
                                            if descendant_1:IsA("Beam") then
                                                ForgeVFX_m.disable(descendant_1)
                                            end
                                        else
                                            ForgeVFX_m.disable(descendant_1)
                                        end
                                    elseif descendant_1:IsA("Beam") then
                                        ForgeVFX_m.disable(descendant_1)
                                    end
                                else
                                    ForgeVFX_m.disable(descendant_1)
                                end
                            else
                                ForgeVFX_m.disable(descendant_1)
                            end
                        elseif not descendant_1:IsA("ParticleEmitter") then
                            if descendant_1:IsA("Model") then
                                if descendant_1.Name ~= "Mesh" then
                                    if descendant_1:IsA("Beam") then
                                        ForgeVFX_m.disable(descendant_1)
                                    end
                                else
                                    ForgeVFX_m.disable(descendant_1)
                                end
                            elseif descendant_1:IsA("Beam") then
                                ForgeVFX_m.disable(descendant_1)
                            end
                        else
                            ForgeVFX_m.disable(descendant_1)
                        end
                    end

                    _G.Tween(
                        v93:QueryDescendants("PointLight")[1],
                        { 1, "Linear", Enum.EasingDirection.Out },
                        { Range = 0 }
                    )
                    task.delay(4, function() -- line: 311
                        -- upvalues:
                        --  [1] v93 (ref)

                        v93:Destroy()
                    end)

                    return
                end

                if v99 - os_clock > 0.2 then
                    os_clock = v99
                    local v100 = workspace:Raycast(
                        v92 + Vector3.new(0, 5, 0),
                        Vector3.new(0, -8, 0),
                        v98
                    )

                    if v100 then
                        _G.GetModule("RockParts")(
                            v92,
                            1,
                            NumberRange.new(1, 3),
                            { XZ = 18, Y = 60, Y2 = 75 },
                            v100.Instance
                        )
                        ForgeVFX_m.emit(SmokeDebris)
                        v95.Position = v93["VFX/Beams"].EndingVFX.WorldPosition + Vector3.new(0, 1, 0)
                        ForgeVFX_m.emit(v95)
                    end

                    GeneratePoints(v93["VFX/Beams"].BezierLightning, v93.Position, v92)
                    ForgeVFX_m.emit(v93["VFX/Beams"].BezierLightning)
                    ForgeVFX_m.emit(v93["VFX/Beams"].BezierSource)
                    ForgeVFX_m.emit(v93.Meshes.Mesh)
                end

                if LocalPlayer.Character == Character then
                    local v102 = mouse
                    local t_5 = { Character, workspace.Effects, workspace.Terrain }
                    local raycastParams_2 = RaycastParams.new()
                    raycastParams_2.FilterType = Enum.RaycastFilterType.Exclude
                    raycastParams_2.FilterDescendantsInstances = t_5
                    v99 = v102.UnitRay.Origin + v102.UnitRay.Direction * 100
                    local v104 = workspace:Raycast(
                        v102.UnitRay.Origin,
                        v102.UnitRay.Direction * 100,
                        raycastParams_2
                    )

                    if v104 then
                        v99 = v104.Position
                    end

                    local v105 = workspace:Raycast(
                        RightArm.WorldPosition,
                        v99 - RightArm.WorldPosition,
                        v98
                    )

                    if v105 then
                        v99 = v105.Position
                    end

                    v92 = v92:Lerp(v99, 8.5 * deltaTime)
                else
                    local v106 = t_1[Character] or v92
                    v92 = v106
                end

                v93.CFrame = CFrame.lookAt(RightArm.WorldCFrame.Position, v92)
                v93["VFX/Beams"].EndingVFX.WorldCFrame = CFrame.lookAt(v92, v93.CFrame.Position)
                v93["VFX/Beams"].StartingVFX.WorldCFrame = CFrame.lookAt(v93.Position, v92)
                v93.Meshes.Mesh.Start.CFrame = v93.CFrame * CFrame.fromEulerAngles(
                    1.5707963267948966,
                    0,
                    0
                )
                v93.Meshes.Mesh.End.CFrame = CFrame.new(v92) * v93.Meshes.Mesh.Start.CFrame.Rotation
                VFXBeams.CFrame = CFrame.lookAt((v92 + Character.PrimaryPart.Position) / 2, v92)
                VFXBeams.Size = Vector3.new(
                    VFXBeams.Size.X,
                    VFXBeams.Size.Y,
                    (Character.PrimaryPart.Position - v92).Magnitude
                )
                Character.PrimaryPart.CFrame = CFrame.lookAt(Character.PrimaryPart.Position, v92)
            end))

            return
        end

        if Action == "UpdateMouse" then
            t_1[Character] = Position_1
        end

        return
    else
        return
    end
end

return Attack
