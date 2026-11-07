-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Ultimates.LightUltimate_FX
-- Class: ModuleScript
-- bytes: 20152

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local _ = require(Modules.CameraShaker)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local rng = Random.new()
local CameraShaker_m_1 = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
local v3 = CameraShaker_m_1.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 22
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v3:Start()
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { workspace.Effects }
VFX_m.init()

local function debrisExplosion(
    vec1: Vector3,
    n1: number,
    n2: number,
    u1: userdata,
    u2: userdata
) -- line: 37
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] rng (copy)

    for _ = 1, n2 do
        local v4 = u2:Clone()
        Services_m.Debris(v4, 6)
        v4.Color = u1.Color
        v4.Material = u1.Material
        v4.MaterialVariant = u1.MaterialVariant
        local v5 = rng:NextNumber(0.5, 2)
        v4.Size = Vector3.new(v5, rng:NextNumber(0.5, 2), rng:NextNumber(0.5, 2))
        v4.Position = vec1
        local v8 = rng:NextNumber(-n1, n1)
        local v10 = rng:NextNumber(n1, n1 * 2)
        v4.AssemblyLinearVelocity = Vector3.new(v8, v10, rng:NextNumber(-n1, n1))
        local v12 = rng:NextNumber(-10, 10)
        v4.AssemblyAngularVelocity = Vector3.new(
            v12,
            rng:NextNumber(-10, 10),
            rng:NextNumber(-10, 10)
        )
        v4.Parent = workspace.Effects
        task.delay(rng:NextNumber(2, 4.4), function() -- line: 60
            -- upvalues:
            --  [1] v4 (copy)

            _G.Tween(
                v4,
                { 1.5, "Linear", Enum.EasingDirection.Out },
                { Size = Vector3.new(0, 0, 0) }
            )
        end)
    end
end

local function debrisCircle(vec2: Vector3, n3: number, u3: Ray) -- line: 66
    -- upvalues:
    --  [1] rng (copy)
    --  [2] Services_m (copy)

    local v15 = vec2 + Vector3.new(0, -8, 0)

    for index_1 = 1, 15 do
        local v17 = 0.41887902047863906 * index_1 + rng:NextNumber(
            -0.1256637061435917,
            0.1256637061435917
        )
        local v18 = n3 + rng:NextInteger(3, 12)
        local v19 = vec2.X + math.cos(v17) * v18
        local v20 = Vector3.new(v19, vec2.Y - 2.4, vec2.Z + math.sin(v17) * v18) + Vector3.new(0, 0.75, 0)
        local CircleDebris_Part = Instance.new("Part")
        Services_m.Debris(CircleDebris_Part, 6)
        CircleDebris_Part.Size = Vector3.new(0, 0, 0)
        CircleDebris_Part.CFrame = CFrame.lookAt(v20, v15)
        CircleDebris_Part.Anchored = true
        CircleDebris_Part.CanCollide = false
        CircleDebris_Part.CanQuery = false
        CircleDebris_Part.CanTouch = false
        CircleDebris_Part.CastShadow = false
        CircleDebris_Part.Name = "Circle_Debris"
        CircleDebris_Part.Color = u3.Instance.Color
        CircleDebris_Part.Material = u3.Instance.Material
        CircleDebris_Part.Parent = workspace.Effects
        _G.Tween(
            CircleDebris_Part,
            { 0.3, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(7, 5, 3) }
        )
        task.delay(rng:NextNumber(2, 4), function() -- line: 100
            -- upvalues:
            --  [1] CircleDebris_Part (copy)

            _G.Tween(
                CircleDebris_Part,
                { 1.5, "Linear", Enum.EasingDirection.Out },
                { Position = CircleDebris_Part.Position + Vector3.new(0, -3, 0) }
            )
        end)
    end
end

local t_1 = {}

local function main(s1: string, u4: userdata, s2: string, ...) -- line: 106
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Services_m (copy)
    --  [5] t_1 (copy)
    --  [6] ForgeVFX_m (copy)
    --  [7] v3 (copy)
    --  [8] raycastParams (copy)
    --  [9] debrisCircle (copy)
    --  [10] debrisExplosion (copy)

    local PrimaryPart, Unit_1, Y, _, t_4, t_6, vec3_1, vec3_2

    if u4 then
        if u4.PrimaryPart then
            if (u4:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
                return
            end

            local Magnitude = (CurrentCamera.CFrame.Position - u4.PrimaryPart.Position).Magnitude
            local v23 = GrimoireRarity_m:GetPlayerVariant(u4)

            if not v23 or not v23.Primary then
                _ = Color3.fromRGB(255, 234, 129)
            end

            if s1 == "Windup" then
                PrimaryPart = u4.PrimaryPart
                local v24 = ReplicatedStorage.Effects.VFX.Light.Windup_FX:Clone()
                Services_m.Debris(v24, 4)
                v24.Parent = PrimaryPart
                v24.Middle.VFX.CFrame = PrimaryPart.CFrame
                GrimoireRarity_m:ApplyVariantEffect(v24, v23)
                t_1[s2 .. "_Windup"] = v24

                for _, val in v24:QueryDescendants(".Initial") do
                    if val:IsA("ParticleEmitter") then
                        local Transparency = val.Transparency
                        val.Transparency = NumberSequence.new(1)
                        val.TimeScale = 0.5
                        _G.Tween(
                            val,
                            { 0.7, "Linear", Enum.EasingDirection.Out },
                            { Transparency = Transparency }
                        )
                        ForgeVFX_m.enable(val)
                    else
                        _G.Tween(val, { 0.35, "Linear", Enum.EasingDirection.Out }, { Range = 12 })
                    end
                end

                return
            end

            if s1 == "Summon" then
                local v25 = ReplicatedStorage.Effects.VFX.Light.LightSaber_FX:Clone()
                Services_m.Debris(v25, 3)
                GrimoireRarity_m:ApplyVariantEffect(v25, v23)
                local Handle_Motor6D = Instance.new("Motor6D")
                Services_m.Debris(Handle_Motor6D, 3)
                Handle_Motor6D.Name = "handle"
                Handle_Motor6D.Part0 = u4["Right Arm"]
                Handle_Motor6D.Part1 = v25.Light.handle
                Handle_Motor6D.C0 = CFrame.new(0.039, -0.982, -0.003) * CFrame.Angles(
                    0,
                    1.5707963267948966,
                    -1.5707963267948966
                )
                Handle_Motor6D.Parent = u4["Right Arm"]
                v25.Parent = u4
                t_1[s2 .. "_Saber"] = v25
                t_1[s2 .. "_SaberHandle"] = Handle_Motor6D

                for _, val_1 in v25:QueryDescendants(".Initial") do
                    if not val_1:IsA("Attachment") then
                        local Transparency_1 = val_1.Transparency
                        val_1.Transparency = NumberSequence.new(1)
                        _G.Tween(
                            val_1,
                            { 0.15, "Linear", Enum.EasingDirection.Out },
                            { Transparency = Transparency_1 }
                        )
                        ForgeVFX_m.enable(val_1)
                    elseif val_1.Name == "Initial_Saber" then
                        val_1.Position = val_1.Position:Lerp(Vector3.new(0, -0.619, 0), 0.8)
                    elseif val_1.Name == "Initial_Swirl" then
                        val_1.Position = val_1.Position:Lerp(Vector3.new(0, 2.844, 0), 0.8)
                    end
                end

                return
            end

            local v27
            local v26

            if s1 == "Charged" then
                v26 = t_1[s2 .. "_Windup"]
                v27 = t_1[s2 .. "_Saber"]

                if not v26 or not v27 then
                    return
                end

                for _, val_2 in v26:QueryDescendants(".Initial") do
                    if val_2:IsA("ParticleEmitter") then
                        val_2.TimeScale = 1
                    else
                        _G.Tween(val_2, { 0.1, "Linear", Enum.EasingDirection.Out }, { Range = 24 })
                    end
                end

                for _, val_3 in v26.Middle:QueryDescendants(".Charged") do
                    ForgeVFX_m.enable(val_3)
                end

                for _, descendant in v27:GetDescendants() do
                    if descendant:HasTag("Initial") and descendant.Name ~= "Handle" then
                        ForgeVFX_m.disable(descendant)
                    elseif descendant:HasTag("Charged") then
                        if not descendant:IsA("Beam") then
                            ForgeVFX_m.enable(descendant)
                        elseif descendant.Name == "Charged_Saber" then
                            descendant.Position = descendant.Position:Lerp(
                                Vector3.new(0, 17.296, 0),
                                0.7
                            )
                            ForgeVFX_m.enable(descendant.Saber_Charged)
                        elseif descendant.Name == "Charged_Swirl" then
                            descendant.Position = descendant.Position:Lerp(
                                Vector3.new(0, 13.833, 0),
                                0.7
                            )
                            ForgeVFX_m.enable(descendant.Wave_Charged)
                        end
                    elseif descendant.Name == "Charged_Saber" then
                        descendant.Position = descendant.Position:Lerp(
                            Vector3.new(0, 17.296, 0),
                            0.7
                        )
                        ForgeVFX_m.enable(descendant.Saber_Charged)
                    elseif descendant.Name == "Charged_Swirl" then
                        descendant.Position = descendant.Position:Lerp(
                            Vector3.new(0, 13.833, 0),
                            0.7
                        )
                        ForgeVFX_m.enable(descendant.Wave_Charged)
                    end
                end

                ForgeVFX_m.emit(v27:FindFirstChild("BeamWaveEmit", true))
                v27:FindFirstChild("BeamSlash", true).Enabled = true

                return
            end

            if s1 == "Explosion" then
                v26, v27 = ...
                local v29 = t_1[s2 .. "_Windup"]
                local v30 = t_1[s2 .. "_Saber"]

                if v29 then
                    for _, val_4 in v29:QueryDescendants(".Initial, .Charged") do
                        if val_4:IsA("ParticleEmitter") then
                            t_4 = { Transparency = NumberSequence.new(1), TimeScale = 0.2 }
                            _G.Tween(val_4, { 0.6, "Linear", Enum.EasingDirection.Out }, t_4)
                        else
                            _G.Tween(
                                val_4,
                                { 0.6, "Linear", Enum.EasingDirection.Out },
                                { Range = 0 }
                            )
                        end
                    end
                end

                if v30 then
                    for _, val_5 in v30:QueryDescendants(".Initial, .Charged, Trail") do
                        if not val_5:IsA("Attachment") then
                            if val_5.Enabled == true then
                                if not val_5:IsA("Trail") then
                                    t_6 = { Transparency = NumberSequence.new(1) }
                                    _G.Tween(
                                        val_5,
                                        { 0.3, "Linear", Enum.EasingDirection.Out },
                                        t_6
                                    )
                                else
                                    val_5.Enabled = false
                                end
                            else
                                val_5.Enabled = false
                            end
                        end
                    end
                end

                local ExplosionFX = ReplicatedStorage.Effects.VFX.Light.Explosion_FX
                GrimoireRarity_m:ApplyVariantEffect(ExplosionFX, v23)
                local v31 = #v26
                task.delay(v27 or 0.52, function() -- line: 236
                    -- upvalues:
                    --  [1] Magnitude (copy)
                    --  [2] v3 (ref)
                    --  [3] v31 (copy)
                    --  [4] ExplosionFX (copy)
                    --  [5] Services_m (ref)
                    --  [6] v26 (copy)
                    --  [7] raycastParams (ref)
                    --  [8] debrisCircle (ref)
                    --  [9] debrisExplosion (ref)
                    --  [10] ReplicatedStorage (ref)
                    --  [11] ForgeVFX_m (ref)

                    if Magnitude < 100 then
                        v3:ShakeOnce(6, 20, 0, 0.7)
                    end

                    for index_2 = 1, v31 do
                        local _ = v31
                        local v33 = ExplosionFX:Clone()
                        Services_m.Debris(v33, 6)
                        v33.CFrame = v26[index_2]
                        local v34 = workspace:Raycast(
                            v26[index_2].Position,
                            Vector3.new(0, -2.5, 0),
                            raycastParams
                        )

                        if v34 then
                            local vec3 = Vector3.new(v33.Position.X, v34.Position.Y, v33.Position.Z)
                            v33.Position = vec3
                            v33.Parent = workspace.Effects
                            debrisCircle(vec3, 13, v34)
                            debrisExplosion(
                                v33.Position,
                                65,
                                9,
                                v34.Instance,
                                ReplicatedStorage.Effects.VFX.Light.Debris
                            )
                            ForgeVFX_m.emit(v33.GroundAttachment.GroundDebris)

                            for _, val_6 in v33:QueryDescendants(".GroundFX") do
                                ForgeVFX_m.enable(val_6)
                            end
                        else
                            v33.Parent = workspace.Effects
                        end

                        ForgeVFX_m.emit(v33.ExplosionAttachment)
                        task.delay(3.5, function() -- line: 262
                            -- upvalues:
                            --  [1] v33 (copy)
                            --  [2] ForgeVFX_m (ref)

                            for _, val_7 in v33:QueryDescendants(".Fade") do
                                if val_7:IsA("PointLight") then
                                    _G.Tween(
                                        val_7,
                                        { 1.5, "Linear", Enum.EasingDirection.Out },
                                        { Range = 0 }
                                    )
                                else
                                    ForgeVFX_m.disable(val_7)
                                end
                            end
                        end)
                    end
                end)
                local v35 = ReplicatedStorage.Effects.VFX.Light.Line_FX:Clone()
                Services_m.Debris(v35, 3)
                GrimoireRarity_m:ApplyVariantEffect(v35, v23)
                local v36 = ReplicatedStorage.Effects.VFX.Light.LineAttachment_FX:Clone()
                Services_m.Debris(v36, 3)
                GrimoireRarity_m:ApplyVariantEffect(v36, v23)
                local v38 = u4.PrimaryPart.CFrame * CFrame.new(0, -2.5, -6)
                local v40 = v26[v31] * CFrame.new(0, 0, -20)
                local Unit = (v40.Position - v38.Position).Unit
                local v41 = CFrame.lookAt(v38.Position, v40.Position) * CFrame.Angles(
                    0,
                    0,
                    -1.5707963267948966
                )
                v38 = CFrame.lookAt(v40.Position, v40.Position + Unit) * CFrame.Angles(
                    0,
                    0,
                    -1.5707963267948966
                )
                local v42 = workspace:Raycast(
                    v26[1].Position,
                    Vector3.new(0, -2.5, 0),
                    raycastParams
                )

                if v42 then
                    Y = v42.Position.Y
                    vec3_1 = Vector3.new(v41.X, Y, v41.Z)
                    vec3_2 = Vector3.new(v38.X, Y, v38.Z)
                    Unit_1 = (vec3_2 - vec3_1).Unit
                    v41 = CFrame.lookAt(vec3_1, vec3_1 + Unit_1) * CFrame.Angles(
                        0,
                        0,
                        -1.5707963267948966
                    )
                    v38 = CFrame.lookAt(vec3_2, vec3_2 + Unit_1) * CFrame.Angles(
                        0,
                        0,
                        -1.5707963267948966
                    )
                    ForgeVFX_m.enable(v36.BeamGlow)
                end

                v36.WorldCFrame = v41
                v36.Parent = workspace.Effects
                local v43 = _G.Tween(
                    v36.Particles,
                    { 0.13, "Linear", Enum.EasingDirection.Out },
                    { WorldCFrame = v38 }
                )
                v38 = (v40.Position - v41.Position).Magnitude
                local v44 = (v40.Position + v41.Position) / 2
                v41 = 0.13 / (v38 / 2)

                while true do
                    if v43.PlaybackState == Enum.PlaybackState.Completed then
                        break
                    end

                    local v45 = v36.Particles:Clone()
                    Services_m.Debris(v45, 3)
                    v45.WorldCFrame = v36.Particles.WorldCFrame
                    v45.Parent = workspace.Effects

                    for _, val_8 in v45:QueryDescendants("ParticleEmitter") do
                        local v46 = math.max(
                            0,
                            1 - (v44 - v45.WorldPosition).Magnitude / (v38 / 2) * 0.6
                        )
                        local v47 = val_8.Speed.Min * v46
                        local v48 = val_8.Speed.Max * v46
                        val_8.Speed = NumberRange.new(math.min(v47, v48), (math.max(v47, v48)))
                        ForgeVFX_m.emit(val_8)
                    end

                    task.wait(v41)
                end

                task.delay(0.5, function() -- line: 324
                    -- upvalues:
                    --  [1] v36 (copy)

                    local t_9 = { Transparency = NumberSequence.new(1) }
                    _G.Tween(v36.BeamGlow, { 0.2, "Linear", Enum.EasingDirection.Out }, t_9)
                end)

                return
            end

            if s1 == "Cleanup" then
                for key_10 in t_1 do
                    if string.split(key_10, "_")[1] == tostring(s2) then
                        local v51 = t_1[key_10]
                        t_1[key_10] = nil
                        task.delay(2, function() -- line: 334
                            -- upvalues:
                            --  [1] v51 (copy)

                            if v51 then
                                v51:Destroy()
                            end
                        end)
                    end
                end
            end

            return
        else
            return
        end
    else
        return
    end
end

return main
