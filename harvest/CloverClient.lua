-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient
-- Class: LocalScript
-- bytes: 57230

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Modules = ReplicatedStorage.Modules
local Remotes = ReplicatedStorage.Remotes
local Cloned = ReplicatedStorage.Cloned
local _ = require(Modules.ByteNetMax)
local Packets_m = require(Modules.Packets)
local StateManager_m = require(Modules.StateManager)
local Utility_m = require(Modules.Utility)
local Bezier_m = require(Modules.Bezier)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local VFX = Services_m.VFX
local rng = Random.new()
local LocalPlayer = Players.LocalPlayer
local PCharacters = workspace.pCharacters
local FightableNPCS = workspace.FightableNPCS
local NPCS = workspace.NPCS
local Settings = LocalPlayer:WaitForChild("Settings")
local _ = LocalPlayer:GetMouse()
local CurrentCamera = workspace.CurrentCamera
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include
local BoatTween = Services_m.BoatTween
local t_1 = {}

function _G.Tween(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 44
    -- upvalues:
    --  [1] BoatTween (copy)

    if not arg1 then
        return
    end

    if arg1:IsA("BasePart") then
        if not _G.CanRender(arg1) then
            arg1:Destroy()

            return
        end
    end

    local v4 = BoatTween:Create(
        arg1,
        {
            Time = arg2[1],
            EasingStyle = string.gsub(tostring(arg2[2]), "Enum.EasingStyle.", ""),
            EasingDirection = string.gsub(tostring(arg2[3]), "Enum.EasingDirection.", ""),
            Reverses = arg2[4],
            DelayTime = arg2[5],
            RepeatCount = arg2[6],
            StepType = "Heartbeat",
            Goal = arg3
        }
    )
    v4:Play()
    local _ = tostring(arg2[3])

    if arg5 then
        v4.Completed:Wait()
        v4 = nil

        if arg4 then
            arg1:Destroy()
        end
    else
        v4.Completed:Connect(function() -- line: 78
            -- upvalues:
            --  [1] v4 (ref)
            --  [2] arg4 (copy)
            --  [3] arg1 (copy)

            v4 = nil

            if arg4 then
                arg1:Destroy()
            end
        end)
    end

    return v4
end

function _G.GetModule(arg6) -- line: 89
    -- upvalues:
    --  [1] t_1 (copy)

    if t_1[arg6] then
        return t_1[arg6]
    end

    for _, val in script:QueryDescendants(`ModuleScript[Name="{arg6}"]`) do
        t_1[arg6] = require(val)

        return t_1[arg6]
    end
end

function _G.CanRender(arg7, arg8) -- line: 102
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] CurrentCamera (copy)

    if not arg7 then
        if RunService:IsStudio() then
            print("\226\150\182 No pos argument. <within Render>")
        end

        return
    end

    local v7 = if not _G.LowPerformance then arg8 or 1750 else 400

    if typeof(arg7) == "Instance" then
        if arg7:IsA("BasePart") then
            arg7 = arg7.Position
        elseif arg7:IsA("Model") then
            if arg7.PrimaryPart then
                arg7 = arg7.PrimaryPart.Position
            elseif arg7:FindFirstChildWhichIsA("BasePart") then
                arg7 = arg7:FindFirstChildWhichIsA("BasePart").Position
            end
        elseif arg7:IsA("Bone") then
            arg7 = arg7.WorldPosition
        else
            return
        end
    elseif typeof(arg7) == "CFrame" then
        arg7 = arg7.Position
    end

    if typeof(arg7) ~= "Vector3" then
        return
    end

    if v7 < (arg7 - CurrentCamera.CFrame.Position).Magnitude then
        return false
    end

    return true
end

local DebrisCircle = _G.GetModule("DebrisCircle")
local Effects = _G.GetModule("Effects")
_G.PlaySound = Services_m.PlaySound
Packets_m.Combat.packets.slamForce.listen(function(arg9) -- line: 151
    -- upvalues:
    --  [1] Services_m (copy)

    local v8 = arg9.Character
    local PrimaryPart = v8.PrimaryPart
    local raycastParams_1 = RaycastParams.new()
    raycastParams_1.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams_1.FilterDescendantsInstances = { v8 }
    v8 = nil
    local v10 = workspace:Raycast(
        (PrimaryPart.CFrame * CFrame.new(0, 0, -0.5)).Position,
        Vector3.new(0, -20, 0),
        raycastParams_1
    )

    if v10 then
        v8 = v10.Position
    end

    local BodyPosition = Instance.new("BodyPosition")
    local v11 = v8 or (PrimaryPart.CFrame * CFrame.new(0, -20, 0)).Position
    BodyPosition.Position = v11
    BodyPosition.P = 2000
    BodyPosition.D = 200
    BodyPosition.MaxForce = Vector3.new(Infinity, Infinity, Infinity)
    BodyPosition.Parent = PrimaryPart
    Services_m.Debris(BodyPosition, 0.1)
end)
Packets_m.Combat.packets.aerialForce.listen(function(arg10) -- line: 178
    -- upvalues:
    --  [1] Services_m (copy)

    local PrimaryPart_1 = arg10.Character.PrimaryPart

    if arg10.Action then
        Services_m.RemoveMovers(PrimaryPart_1)
        local v12 = script:GetAttribute("Force") or Vector3.new(25000, 25000, 25000)
        local v13 = script:GetAttribute("Forward") or 35
        local AerialM1Velocity_BodyVelocity = Instance.new("BodyVelocity")
        AerialM1Velocity_BodyVelocity.Name = "AerialM1Velocity"
        AerialM1Velocity_BodyVelocity.MaxForce = v12
        AerialM1Velocity_BodyVelocity.Velocity = PrimaryPart_1.CFrame.LookVector * v13 - Vector3.new(0, 7, 0)
        AerialM1Velocity_BodyVelocity.Parent = PrimaryPart_1

        return
    end

    for _, val_1 in PrimaryPart_1:QueryDescendants("[Name=\"AerialM1Velocity\"]") do
        val_1:Destroy()
    end
end)
Packets_m.Magic.packets.Client.listen(function(arg11, _) -- line: 205
    if not arg11.Module then
        return warn(`Module not found {arg11.Module}`)
    end

    _G.GetModule(arg11.Module)(arg11)
end)
Remotes.Magic.Client.OnClientEvent:Connect(function(arg13, ...) -- line: 213
    if not arg13 then
        warn(arg13, "Not Found")

        return
    end

    if not ... then
        return
    end

    _G.GetModule(arg13)(...)
end)
Remotes.Weapon.Client.OnClientEvent:Connect(function(arg14, ...) -- line: 222
    if not arg14 then
        return
    end

    if not ... then
        return
    end

    _G.GetModule(arg14)(...)
end)
Remotes.Client.WeaponFX.OnClientEvent:Connect(function(arg15, ...) -- line: 231
    if not arg15 then
        return
    end

    if not ... then
        return
    end

    _G.GetModule(arg15)(...)
end)
Remotes.Client.SFX.OnClientEvent:Connect(function(arg16, ...) -- line: 240
    -- upvalues:
    --  [1] Services_m (copy)

    Services_m.PlaySound(arg16, ...)
end)
Remotes.Client.Velocity.OnClientEvent:Connect(function(arg17, arg18, arg19) -- line: 244
    -- upvalues:
    --  [1] StateManager_m (copy)
    --  [2] LocalPlayer (copy)
    --  [3] CollectionService (copy)

    if StateManager_m.require(LocalPlayer.Character):HasState("Airborne") then
        return
    end

    if CollectionService:HasTag(arg17.Parent, "slowEffect") then
        arg19 *= 0.5
    end

    while arg18 do
        if not arg18.Parent then
            break
        end

        arg18.Velocity = arg17.CFrame.LookVector * arg19
        task.wait()
    end
end)

local _ = function(arg20, arg21) --[[ toggleParticles ]] -- line: 263
    for _, val_2 in arg20:QueryDescendants("ParticleEmitter") do
        val_2.Enabled = arg21
    end
end

ReplicatedStorage.Remotes.createEffect.OnClientEvent:Connect(function(arg22, arg23) -- line: 269
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] StateManager_m (copy)
    --  [3] Services_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] raycastParams (copy)
    --  [6] Utility_m (copy)
    --  [7] GrimoireRarity_m (copy)
    --  [8] Effects (copy)
    --  [9] rng (copy)
    --  [10] LocalPlayer (copy)
    --  [11] RunService (copy)

    local v17

    if arg22 == "RollDust" then
        local Character = arg23.Character
        v17 = Character

        if v17 then
            v17 = Character.PrimaryPart
        end

        if not v17 then
            return
        end

        local Position = v17.Position
        local _, v19 = CurrentCamera:WorldToScreenPoint(Position)

        if not v19 or (CurrentCamera.CFrame.Position - Position).Magnitude > 150 then
            return
        end

        local v20 = StateManager_m.require(Character)
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Misc.Dash,
            v17,
            nil,
            nil,
            nil,
            0.05
        )
        local v21 = v17.CFrame
        local v22 = ReplicatedStorage.Effects.DashDust:Clone()
        v22:PivotTo(v21 * CFrame.new(0, -1.85, 0.225))
        v22.Parent = workspace.Effects

        for _, val_3 in v22:QueryDescendants("ParticleEmitter") do
            val_3.Enabled = true
        end

        local v23 = workspace:Raycast(v21.Position, Vector3.new(0, -10, 0), raycastParams)

        if v23 and v23.Instance and (v23.Position - v21.Position).Magnitude < 30 then
            local Material = v23.Material
            local v24 = v23.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v23.Instance.Color

            for _, val_4 in v22:QueryDescendants("ParticleEmitter") do
                val_4.Color = ColorSequence.new(v24)
            end
        end

        v22.Anchored = false
        local WeldConstraint = Instance.new("WeldConstraint")
        WeldConstraint.Part0 = v17
        WeldConstraint.Part1 = v22
        WeldConstraint.Parent = v22

        while true do
            if not v20:IsDodging() then
                break
            end

            task.wait()
        end

        for _, val_5 in v22:QueryDescendants("ParticleEmitter") do
            val_5.Enabled = false
        end

        Services_m.Debris(v22, 2)

        return
    else
        local v25

        if arg22 == "AirDash" then
            v25 = arg23.Character
            v17 = v25

            if v17 then
                v17 = v25.PrimaryPart
            end

            if not v17 then
                return
            end

            v25 = arg23.cframe or v17.CFrame
            local _, v27 = CurrentCamera:WorldToScreenPoint(v25.Position)

            if v27 and (CurrentCamera.CFrame.Position - v25.Position).Magnitude < 200 then
                Services_m.PlaySound(ReplicatedStorage.SFX.Misc.DashAir, v17)
                local v28 = ReplicatedStorage.Effects.airdashvfx:Clone()
                Services_m.Debris(v28, 2)
                v28.CFrame = v25 * CFrame.new(0, 0, 0.225)
                local WeldConstraint_1 = Instance.new("WeldConstraint")
                WeldConstraint_1.Part0 = v17
                WeldConstraint_1.Part1 = v28
                WeldConstraint_1.Parent = v28
                v28.Parent = workspace.Effects
                Utility_m.EmitParticles(v28)
                task.wait(0.15)
                WeldConstraint_1:Destroy()
                v28.Anchored = true

                return
            end
        elseif arg22 == "LightningDash" then
            v25 = arg23.Character
            v17 = v25

            if v17 then
                v17 = v25.PrimaryPart
            end

            local Start = arg23.Start
            local t_2, _

            if v17 then
                if typeof(Start) ~= "Vector3" then
                    return
                end

                local v30
                _, v30 = CurrentCamera:WorldToScreenPoint(Start)

                if not v30 or (CurrentCamera.CFrame.Position - Start).Magnitude > 200 then
                    return
                end

                local v32 = GrimoireRarity_m:GetPlayerVariant(v25)
                local v31 = v32 and v32.Primary or Color3.fromRGB(170, 85, 255)
                local v33 = ReplicatedStorage.SFX.Effects.LightningStrike:Clone()
                v33.PlayOnRemove = true
                v33.Volume = 0.5
                v33.TimePosition = 0.808
                v33.Parent = v17
                v33:Destroy()
                local v34 = workspace:Raycast(Start, Vector3.new(0, -10, 0), raycastParams)

                if v34 and v34.Instance then
                    v25 = v34.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                        v34.Material
                    ) or v34.Instance.Color
                    Effects:CreateSmokeCloud(
                        CFrame.new(v34.Position),
                        v25,
                        Vector3.new(4, 2, 4),
                        NumberSequence.new(1),
                        6
                    )
                end

                task.wait(0.3)

                if not v17.Parent then
                    return
                end

                for _ = 1, 2 do
                    t_2 = {
                        Speed = 7,
                        Length = 1,
                        Radius = 2,
                        Color = v31,
                        Unit = 2,
                        Curve = 5,
                        Thickness = rng:NextNumber(0.75, 1.5)
                    }
                    Effects.GenerateLightning(CFrame.new(Start), v17.CFrame, t_2)
                end
            else
                return
            end
        elseif arg22 == "LurkFace" then
            function v25() --[[ faceTarget ]] -- line: 402
                -- upvalues:
                --  [1] LocalPlayer (ref)
                --  [2] arg23 (copy)

                local CurrentCamera_1 = workspace.CurrentCamera

                if not CurrentCamera_1 or CurrentCamera_1.CameraType == Enum.CameraType.Scriptable then
                    return
                end

                local Character_1 = LocalPlayer.Character
                local Target = arg23.Target
                local v38 = arg23.Look

                if typeof(v38) ~= "Vector3" then
                    return
                end

                if typeof(Target) == "Instance" and Target:IsA("BasePart") and Target.Parent and Character_1 then
                    local v39 = Target.Position - Character_1:GetPivot().Position

                    if v39:Dot(v38) > 0 then
                        v38 = v39
                    end
                end

                local vec3 = Vector3.new(v38.X, 0, v38.Z)

                if vec3.Magnitude < 0.001 then
                    return
                end

                local Unit = vec3.Unit
                v38 = math.asin((math.clamp(CurrentCamera_1.CFrame.LookVector.Y, -1, 1)))
                local v41 = Unit * math.cos(v38)
                local Position_2 = CurrentCamera_1.Focus.Position
                CurrentCamera_1.CFrame = CFrame.lookAt(
                    Position_2 - (v41 + Vector3.new(0, 1, 0) * math.sin(v38)) * (CurrentCamera_1.CFrame.Position - Position_2).Magnitude,
                    Position_2
                )
            end

            v25()
            RunService.RenderStepped:Wait()
            v25()
        end

        return
    end
end)
Remotes.gameEvents.OnClientEvent:Connect(function(arg24, ...) -- line: 439
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] Effects (copy)
    --  [3] DebrisCircle (copy)
    --  [4] ReplicatedStorage (copy)

    if arg24 == "Star" then
        local v42, _ = ...

        if not _G.CanRender(v42.Position) then
            return
        end

        local v44 = workspace:Raycast(v42.Position, Vector3.new(0, -20, 0), raycastParams)

        if v44 and v44.Instance then
            local Color = v44.Instance.Color
            local cframe_1 = CFrame.new(v44.Position)
            _G.GetModule("RockParts")(
                cframe_1,
                4,
                NumberRange.new(1, 3),
                { XZ = 25, Y = 70, Y2 = 80 }
            )
            local v45 = script.RockErupt:Clone()
            v45.CFrame = cframe_1
            v45.Size = Vector3.new(10, 0, 10)
            v45.Parent = workspace.Effects
            Effects:SetParticleColor(v45, Color)
            Effects:EmitParticle(v45, 20)
            Effects:CreateSmokeCloud(
                cframe_1,
                Color,
                Vector3.new(16, 5, 16),
                NumberSequence.new(10),
                10
            )
            Effects:CreateGroundCrack(cframe_1, Vector3.new(15, 0, 15))
        end

        DebrisCircle.ConnectedCircle(
            nil,
            10,
            3.5,
            12,
            nil,
            v42 * CFrame.new(0, 1, 0)
        )
        Effects.BeamEffect(v42, Color3.fromRGB(253, 234, 141))
        local v47 = ReplicatedStorage.Effects.Ball:Clone()
        v47.CFrame = v42 * CFrame.new(0, -1, 0)
        v47.Color = Color3.fromRGB(255, 255, 127)
        v47.Material = Enum.Material.ForceField
        v47.Parent = workspace.Effects
        _G.Tween(
            v47,
            { 0.5, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(22, 22, 22), Transparency = 1 },
            true
        )
    end
end)
Remotes.Combat.OnClientEvent:Connect(function(arg25, arg26, ...) -- line: 489
    -- upvalues:
    --  [1] DebrisCircle (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Effects (copy)
    --  [4] rng (copy)
    --  [5] Services_m (copy)
    --  [6] Utility_m (copy)

    if not _G.CanRender(arg26) or not arg26.PrimaryPart then
        return
    end

    local _ = arg26.PrimaryPart
    local _ = { ... }
    local v51

    if arg25 == "GroundContact" then
        local v48, v49, v50 = ...

        if not v48 then
            return
        end

        DebrisCircle.new(
            nil,
            10,
            Vector3.new(3.5, 3.5, 3.5),
            6,
            nil,
            CFrame.new(v49) * CFrame.new(0, 1, 0)
        )
        v51 = ReplicatedStorage.Effects.CurvyRing:Clone()
        v51.Anchored = true
        v51.Color = Color3.fromRGB(255, 255, 255)
        v51.Material = Enum.Material.Neon
        v51.Size = Vector3.new(12, 1, 12)
        v51.CFrame = v50 * CFrame.Angles(1.5707963267948966, 0, 0)
        v51.Parent = workspace.Effects
        local t_4 = { CFrame = nil, Transparency = 1 }
        local Tween = _G.Tween
        local t_5 = { 0.4, "EntranceExpressive", Enum.EasingDirection.Out }
        t_4.CFrame = v50 * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -10, 0)
        Tween(v51, t_5, t_4, true)
        Effects:CreateSmokeCloud(
            v50,
            v48.Color,
            Vector3.new(8, 8, 8),
            NumberSequence.new(5),
            10
        )
        task.spawn(function() -- line: 526
            -- upvalues:
            --  [1] ReplicatedStorage (ref)
            --  [2] Effects (ref)
            --  [3] v48 (copy)
            --  [4] arg26 (copy)
            --  [5] rng (ref)
            --  [6] v50 (copy)
            --  [7] Services_m (ref)

            for _ = 1, 7 do
                local v54 = ReplicatedStorage.Effects.SmokeBlock:Clone()
                Effects:SetParticleColor(v54, v48.Color)
                v54.Name = arg26.Name .. " briks"
                local v55 = rng:NextInteger(1, 3)
                v54.Size = Vector3.new(v55, rng:NextInteger(1, 3), rng:NextInteger(1, 3))
                v54.CFrame = v50 * CFrame.new(rng:NextInteger(-2, 2), 12, rng:NextInteger(-2, 2))
                v54.CanCollide = false
                v54.Massless = true
                v54.Color = v48.Color
                v54.Material = v48.Material

                if v48.MaterialVariant ~= "" then
                    v54.MaterialVariant = v48.MaterialVariant
                end

                v54.TopSurface = Enum.SurfaceType.Smooth
                v54.BottomSurface = Enum.SurfaceType.Smooth
                local v59 = v54.Velocity * rng:NextInteger(10, 20)
                local v60 = rng:NextInteger(-40, 40)
                v54.Velocity = v59 + Vector3.new(
                    v60,
                    rng:NextInteger(-100, 100),
                    rng:NextInteger(-40, 40)
                )
                v54.Parent = workspace.Effects
                task.delay(3, function() -- line: 546
                    -- upvalues:
                    --  [1] v54 (copy)

                    _G.Tween(
                        v54,
                        { 0.25, "Smooth", Enum.EasingDirection.Out },
                        { Transparency = 1 }
                    )

                    for _, child in pairs(v54:GetChildren()) do
                        if child:IsA("ParticleEmitter") then
                            child.Enabled = false
                        end
                    end
                end)
                Services_m.Debris(v54, 6)
            end
        end)

        return
    else
        if arg25 == "AerialSlam" then
            local v63, v64, v65
            v63, v51, v64, v65 = ...

            if not _G.CanRender(v63) then
                return
            end

            local v66 = v51 or Color3.fromRGB(150, 150, 150)
            local v67 = v66
            v66 = v64 or Enum.Material.Slate
            local v68 = v66
            local v69 = CFrame.new(v63) * CFrame.new(0, 1, 0)
            local v70 = script.SlamContact:Clone()
            v70.CFrame = v69
            v70.Parent = workspace.Effects
            Services_m.Debris(v70, 4)
            wait()

            for _, val_6 in v70:QueryDescendants("ParticleEmitter") do
                if not val_6.Name:match("Smoke") then
                    if val_6.Name:match("Rock") then
                        val_6.Color = ColorSequence.new(v67)
                    end
                else
                    val_6.Color = ColorSequence.new(v67)
                end
            end

            Utility_m.EmitParticles(v70)

            for _ = 1, 4 do
                local _ = { XZ = 11, Y = 20, Y2 = 35 }
                v69 = Instance.new("Part")
                v69.Name = "briks"
                v69.CastShadow = false
                v69.Anchored = false
                v69.CanCollide = true
                v69.TopSurface = Enum.SurfaceType.Smooth
                v69.BottomSurface = Enum.SurfaceType.Smooth
                v69.Color = v67
                v69.Material = v68

                if v65 ~= "" then
                    v69.MaterialVariant = v65
                end

                local v71 = rng:NextNumber(0.75, 1.5)
                v69.Size = Vector3.new(v71, rng:NextInteger(0.75, 1.5), rng:NextNumber(0.75, 1.5))
                local v73 = math.random(-100, 100)
                v69.Orientation = Vector3.new(v73, math.random(-100, 100), math.random(-100, 100))
                v69.Position = v63
                v69.CollisionGroup = "Debris"
                v69.CanCollide = false
                v69.Parent = workspace.Effects.Debris
                Services_m.Debris(v69, 4)
                task.delay(0.1, function() -- line: 609
                    -- upvalues:
                    --  [1] v69 (copy)

                    v69.CanCollide = true
                end)
                local v75 = rng:NextInteger(-11, 11)
                v69.Velocity = Vector3.new(v75, rng:NextInteger(20, 35), rng:NextInteger(-11, 11))
                local BodyVelocity_1 = Instance.new("BodyVelocity")
                local v77 = rng:NextInteger(-11, 11)
                BodyVelocity_1.Velocity = Vector3.new(
                    v77,
                    rng:NextInteger(20, 35),
                    rng:NextInteger(-11, 11)
                )
                BodyVelocity_1.MaxForce = Vector3.new(100000, 100000, 100000)
                BodyVelocity_1.Parent = v69
                Services_m.Debris(BodyVelocity_1, 0.25)
            end
        elseif arg25 == "Dizzy" then
            local Attachment = Instance.new("Attachment")
            local Attachment_1 = Instance.new("Attachment")
            Attachment.Parent = arg26.Head
            Attachment_1.Parent = arg26.Head
            Attachment.Position = Vector3.new(0, 0, -0.75)
            Attachment_1.Position = Vector3.new(0, 0, 0.75)
            local v79 = ReplicatedStorage.Effects.StarStun:Clone()
            local Weld = Instance.new("Weld", v79)
            Weld.Part0 = v79
            Weld.Part1 = arg26.Head
            Weld.C0 = CFrame.new(0, 0, 0)
            v79.StarBeam1.Attachment0 = Attachment
            v79.StarBeam1.Attachment1 = Attachment_1
            v79.StarBeam2.Attachment0 = Attachment
            v79.StarBeam2.Attachment1 = Attachment_1
            v79.StarBeam1.Enabled = true
            v79.StarBeam2.Enabled = true
            v79.Parent = workspace.Effects
            task.wait(1.5)
            v79.StarBeam1.Enabled = false
            v79.StarBeam2.Enabled = false
            task.wait(1)
            v79:Destroy()
            Attachment:Destroy()
            Attachment_1:Destroy()
        end

        return
    end
end)
Remotes.Sword.OnClientEvent:Connect(function(arg27, arg28, ...) -- line: 663
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] VFX (copy)

    if not _G.CanRender(arg28) or not arg28.PrimaryPart then
        return
    end

    local _ = arg28.PrimaryPart

    if arg27 == "Parry" then
        local v80 = ({ ... })[1]
        local v81 = v80
        local v82

        if typeof(v80) ~= "CFrame" then
            if typeof(v80) == "Vector3" then
                v81 = Instance.new("Part")
                v81.Transparency = 1
                v81.CanCollide = false
                v81.Anchored = true
                v81.CanQuery = false
                v82 = v80

                if typeof(v80) ~= "CFrame" or not v82 then
                    v82 = CFrame.new(v80)
                end

                v81.CFrame = v82
                v81.Parent = workspace.Effects
                Services_m.Debris(v81, 2)
            end
        else
            v81 = Instance.new("Part")
            v81.Transparency = 1
            v81.CanCollide = false
            v81.Anchored = true
            v81.CanQuery = false
            v82 = v80

            if typeof(v80) ~= "CFrame" or not v82 then
                v82 = CFrame.new(v80)
            end

            v81.CFrame = v82
            v81.Parent = workspace.Effects
            Services_m.Debris(v81, 2)
        end

        local v83 = ReplicatedStorage.Effects.ParryFX:Clone()
        Services_m.Debris(v83, 2)
        v83.Size = v81.Size
        v83.CFrame = v81.CFrame
        v83.Parent = workspace.Effects
        VFX.Emit2(v83, true)
        v81 = ReplicatedStorage.Effects.LightningLight:Clone()
        Services_m.Debris(v81, 2)
        v81.Light.Color = Color3.fromRGB(255, 112, 64)
        v81.Color = v81.Light.Color
        v81.CFrame = v83.CFrame
        v81.Light.Range = 16
        v81.Light.Brightness = 1.25
        v81.Parent = workspace.Effects
        task.wait(0.15)
        _G.Tween(
            v81.Light,
            { 0.125, "Quad", Enum.EasingDirection.In },
            { Range = 0, Brightness = 0 },
            true,
            true
        )
    end
end)
Remotes.Client.Highlight.OnClientEvent:Connect(function(arg29, arg30, arg31) -- line: 704
    -- upvalues:
    --  [1] Services_m (copy)

    local v84 = arg30:Clone()
    v84.Parent = arg29

    if arg31 then
        Services_m.Debris(v84, arg31)
    end
end)
Remotes.Ragdoll.OnClientEvent:Connect(function(arg32, arg33) -- line: 712
    -- upvalues:
    --  [1] StateManager_m (copy)

    if not arg32 or not arg33 then
        return
    end

    local v85 = StateManager_m.require(arg32)

    if not v85:IsRagdolled() then
        if v85:HasState("Downed") then
            arg33:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
            arg33:ChangeState(Enum.HumanoidStateType.Ragdoll)

            return
        end

        arg33:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        arg33:ChangeState(Enum.HumanoidStateType.GettingUp)

        return
    else
        arg33:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        arg33:ChangeState(Enum.HumanoidStateType.Ragdoll)

        return
    end
end)

function calcvel(arg34, arg35, arg36, arg37) -- line: 727
    return (arg34 - arg35 - 0.5 * arg36 * arg37 * arg37) / arg37
end

Remotes.Blood.OnClientEvent:Connect(function(arguments) -- line: 731
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)
    --  [3] Utility_m (copy)
    --  [4] raycastParams (copy)
    --  [5] rng (copy)

    if not _G.CanRender(arguments) or _G.Xbox then
        return
    end

    local v86 = ReplicatedStorage.Effects.BloodGush:Clone()
    Services_m.Debris(v86, 2)
    v86.CFrame = arguments:IsA("Bone") and CFrame.new(arguments.WorldPosition) or arguments.CFrame
    v86.Parent = workspace.Effects
    wait()
    Utility_m.EmitParticles(v86)
    local v90, v92

    for _ = 1, 2 do
        local v88 = arguments.CFrame
        local v89 = math.random(-2, 2) * 2
        v90 = math.random(1, 1) * 2
        local v91 = v88 * Vector3.new(v89, v90, math.random(-2, 2) * 2)
        v92 = v91
        local _ = raycastParams.FilterDescendantsInstances
        local v93 = workspace:Raycast(
            v92,
            CFrame.lookAt(v92, v91 - Vector3.new(0, 30, 0)).LookVector * 200,
            raycastParams
        )

        if v93 and (arguments.Position - v93.Position).Magnitude <= 15 then
            local Position_4 = v93.Position
            local v92 = v93.Normal
            local Position_3 = arguments.Position
            local v95 = calcvel(Position_4, Position_3, Vector3.new(0, -workspace.Gravity, 0), 0.35)
            local v90 = ReplicatedStorage.Effects.BleedPart:Clone()
            v90.CFrame = CFrame.new(Position_3)
            v90.Velocity = v95
            v90.Parent = workspace.Effects
            task.delay(0.35, function() -- line: 764
                -- upvalues:
                --  [1] v90 (copy)

                v90.Anchored = true
            end)
            Services_m.Debris(v90, 1.35)
            task.delay(0.35, function() -- line: 769
                -- upvalues:
                --  [1] ReplicatedStorage (ref)
                --  [2] rng (ref)
                --  [3] Position_4 (copy)
                --  [4] v92 (copy)
                --  [5] Services_m (ref)

                local v96 = ReplicatedStorage.Effects.BloodPool:Clone()
                v96.Size = Vector3.new(rng:NextNumber(0.75, 1.5), 0, rng:NextNumber(0.75, 1.5))
                v96.TopSurface = Enum.SurfaceType.SmoothNoOutlines
                v96.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
                local cframe_3 = CFrame.new(Position_4, Position_4 - v92)
                local Angles = CFrame.Angles
                local v97 = math.random(-90, 90)
                local v98 = cframe_3 * Angles(1.5707963267948966, math.rad(v97), 0)
                local New_2 = CFrame.new
                local v99 = math.random(-1, 1) / 2
                v96.CFrame = v98 * New_2(v99, 0, math.random(-1, 1) / 2)
                local v100 = ReplicatedStorage.Effects.BloodSplash:Clone()
                Services_m.Debris(v100, 1.5)
                v100.CFrame = v96.CFrame
                v100.Parent = workspace.Effects

                for _, descendant in pairs(v100:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(2)
                    end
                end

                v96.Parent = workspace.Effects
                local v102 = rng:NextNumber(4, 5)
                local t_7 = { Size = nil }
                local Tween_1 = _G.Tween
                local t_8 = { 0.3, "EntranceExpressive", Enum.EasingDirection.Out }
                t_7.Size = v96.Size + Vector3.new(v102, 0, v102)
                Tween_1(v96, t_8, t_7)
                task.delay(math.random(7, 8), function() -- line: 789
                    -- upvalues:
                    --  [1] Services_m (ref)
                    --  [2] v96 (copy)

                    Services_m.Debris(v96, 2)
                    _G.Tween(
                        v96:FindFirstChild("GoreDecal"),
                        { 1, "Linear", Enum.EasingDirection.Out },
                        { Transparency = 1 },
                        false,
                        true
                    )
                end)
            end)
        end
    end
end)
Remotes.Freeze.OnClientEvent:Connect(function(arg39, arg40, arg41, arg42) -- line: 798
    if not _G.CanRender(arg39) then
        return
    end

    if arg40 == "Freeze" then
        if arg42 then
            return
        end

        _G.Tween(
            arg39,
            { 0.5, "Quad", Enum.EasingDirection.Out },
            { Color = arg41[1], Transparency = 0 }
        )
        arg39.Material = Enum.Material.Ice

        return
    else
        if arg40 == "Thaw" then
            local t_10 = { Color = arg41[2], Transparency = arg41[3] }
            local v104 = arg41[1]
            _G.Tween(arg39, { 0.5, "Quad", Enum.EasingDirection.Out }, t_10)
            arg39.Material = v104

            return
        end

        return
    end
end)
Remotes.Burn.OnClientEvent:Connect(function(arg43, arg44, arg45, arg46) -- line: 816
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if not _G.CanRender(arg43) then
        return
    end

    if arg44 == "Burn" then
        local v105 = arg43.Size.Magnitude / 20

        if not arg46 then
            local v106 = ReplicatedStorage.Effects.Statuses.StatusFire:Clone()
            v106.Name = "Flame"
            v106.Rate = 1
            v106.Color = arg45 and ColorSequence.new(arg45, Color3.fromRGB(208, 54, 33)) or ColorSequence.new(
                255,
                255,
                255
            )
            v106.Size = NumberSequence.new(math.clamp(2 + v105, 1, 4), 0)
            v106.Parent = arg43
        end

        local v108 = script.Smoke:Clone()
        v108.Size = NumberSequence.new(math.clamp(1.5 + v105, 1, 4), 0)
        v108.Parent = arg43

        return
    end

    if arg44 == "Off" then
        if arg43:FindFirstChild("Flame") then
            arg43.Flame:Destroy()
        end

        if arg43:FindFirstChild("Smoke") then
            arg43.Smoke:Destroy()
        end
    end
end)
Remotes.TreeDestroy.OnClientEvent:Connect(function(
    arg47,
    arg48,
    arg49,
    arg50,
    arg51
) -- line: 843
    -- upvalues:
    --  [1] Settings (copy)
    --  [2] rng (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] VFX (copy)
    --  [5] Services_m (copy)

    if not Settings.Destruction.Value then
        return
    end

    local ClientDebris = workspace.Map:WaitForChild("client_debris")

    if arg47 == "Destroy" and arg48 and typeof(arg48) == "Instance" then
        if (arg50 - workspace.CurrentCamera.CFrame.Position).Magnitude > 850 then
            return
        end

        local v109 = arg48:Clone()
        v109.Name = arg49
        v109:RemoveTag("WindShake")

        for _, descendant_1 in v109:GetDescendants() do
            descendant_1:RemoveTag("WindShake")
        end

        for _, val_7 in v109:QueryDescendants("BasePart") do
            val_7.CastShadow = true
            val_7.CanQuery = true
            val_7.CanTouch = val_7:GetAttribute("OriginalTouch")
            val_7.CanCollide = true
            val_7.Transparency = val_7:GetAttribute("OriginalTransparency")
        end

        v109.Parent = ClientDebris
        local v118

        for _, val_8 in v109:QueryDescendants("BasePart") do
            val_8.Anchored = false
            local v111 = val_8.Velocity * rng:NextInteger(10, 15)
            local v112 = rng:NextInteger(-30, 30)
            local v110 = v111 + Vector3.new(
                v112,
                rng:NextInteger(-30, 30),
                rng:NextInteger(-30, 30)
            )
            val_8.Velocity = v110

            if arg51 == "Burning" then
                v110 = Color3.fromRGB(255, 52, 25)
                local v114 = val_8.Size.Magnitude / 20
                local v115 = ReplicatedStorage.Effects.Statuses.StatusFire:Clone()
                v115.Name = "Flame"
                v115.Rate = 1
                v115.Color = v110 and ColorSequence.new(v110, Color3.fromRGB(208, 54, 33)) or ColorSequence.new(
                    255,
                    255,
                    255
                )
                v115.Size = NumberSequence.new(math.clamp(2 + v114, 1, 4), 0)
                v115.Parent = val_8
                local v117 = script.Smoke:Clone()
                v117.Size = NumberSequence.new(math.clamp(1.5 + v114, 1, 4), 0)
                v117.Parent = val_8
                task.delay(6, function() -- line: 895
                    -- upvalues:
                    --  [1] VFX (ref)
                    --  [2] val_8 (copy)

                    VFX.Enable(val_8, false, true)
                end)
            end

            v118 = nil

            if val_8.Name:match("Leaf") then
                val_8.CollisionGroup = "Mobs"
                v118 = script.leaves:Clone()
                _G.Tween(
                    val_8,
                    { 0.75, "Quad", Enum.EasingDirection.Out },
                    { Size = val_8.Size / 2 }
                )
            else
                v118 = script.DirtParticle:Clone()
            end

            v118.Color = ColorSequence.new(val_8.Color)
            v118.Parent = val_8
            v118:Emit(v118:GetAttribute("EmitCount") or 3)
            task.delay(1, function() -- line: 911
                -- upvalues:
                --  [1] v118 (ref)
                --  [2] Services_m (ref)

                v118.Enabled = false
                Services_m.Debris(v118, 1.5)
            end)
        end

        Services_m.PlaySound(
            ReplicatedStorage.SFX.Explosions.TreeCrash,
            arg50,
            220,
            nil,
            nil,
            nil
        )
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Explosions.TreeFall,
            arg50,
            200,
            nil,
            nil,
            nil
        )

        return
    end

    if arg47 == "Restore" then
        local v121 = ClientDebris:FindFirstChild(arg49)

        if not v121 then
            return
        end

        v121.Name = tick()

        for _, val_9 in v121:QueryDescendants("BasePart") do
            _G.Tween(
                val_9,
                { 0.75, "Quad", Enum.EasingDirection.Out },
                { Size = Vector3.new(0, 0, 0), Transparency = 1 }
            )
        end

        Services_m.Debris(v121, 2)
    end
end)
Remotes.PropDestroy.OnClientEvent:Connect(function(
    arg52,
    arg53,
    arg54,
    arg55,
    _
) -- line: 947
    -- upvalues:
    --  [1] Settings (copy)
    --  [2] Services_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] rng (copy)

    if not Settings.Destruction.Value then
        return
    end

    local ClientDebris_1 = workspace.Map:WaitForChild("client_debris")

    if arg52 == "Destroy" and arg53 and typeof(arg53) == "Instance" then
        if (arg55 - workspace.CurrentCamera.CFrame.Position).Magnitude > 850 then
            return
        end

        Services_m.PlaySound(
            ReplicatedStorage.SFX.Explosions.RockImpact,
            arg55,
            220,
            nil,
            nil,
            nil
        )
        local v123 = 0
        local v124 = 15

        for _, val_10 in arg53:QueryDescendants("BasePart") do
            if v123 >= v124 then
                break
            end

            for _, child_1 in script.PropVFX:GetChildren() do
                if child_1:IsA("ParticleEmitter") then
                    local v125 = child_1:Clone()
                    v125.Color = ColorSequence.new(val_10.Color)
                    v125.Parent = val_10
                    v125:Emit(v125:GetAttribute("EmitCount") or 8)
                    Services_m.Debris(v125, 3)
                end
            end

            local v126 = val_10.Size.X / 2
            local v127 = val_10.Size.Y / 2
            local v128 = val_10.Size.Z / 2

            for _ = 1, 6 do
                if v123 >= v124 then
                    break
                end

                local _ = { XZ = 8, Y = 40, Y2 = 50 }
                local Part = Instance.new("Part")
                Part.Name = arg54
                Part.CastShadow = false
                Part.Anchored = false
                Part.CanCollide = true
                Part.TopSurface = Enum.SurfaceType.Smooth
                Part.BottomSurface = Enum.SurfaceType.Smooth
                Part.Color = val_10.Color
                Part.Material = val_10.Material

                if val_10.MaterialVariant ~= "" then
                    Part.MaterialVariant = val_10.MaterialVariant
                end

                local v129 = rng:NextNumber(0.1, 1.75)
                Part.Size = Vector3.new(v129, rng:NextNumber(0.1, 1.75), rng:NextNumber(0.1, 1.75))
                Part.Position = val_10.Position + Vector3.new(0, rng:NextNumber(v127 / 2, v127), 0)
                Part.CFrame = Part.CFrame * CFrame.new(
                    rng:NextNumber(-v126, v126),
                    0,
                    rng:NextNumber(-v128, v128)
                ) * CFrame.fromEulerAnglesXYZ(
                    rng:NextInteger(-90, 90),
                    rng:NextInteger(-90, 90),
                    rng:NextInteger(-90, 90)
                )
                Part.CollisionGroup = "Debris"
                Part.Parent = ClientDebris_1
                Services_m.Debris(Part, 4)
                local v140 = rng:NextNumber(-8, 8)
                Part.Velocity = Vector3.new(v140, rng:NextNumber(40, 50), rng:NextNumber(-8, 8))
                local BodyVelocity_2 = Instance.new("BodyVelocity")
                local v142 = rng:NextInteger(-8, 8)
                BodyVelocity_2.Velocity = Vector3.new(
                    v142,
                    rng:NextInteger(40, 50),
                    rng:NextInteger(-8, 8)
                )
                BodyVelocity_2.Parent = Part
                BodyVelocity_2:Destroy()
                v123 += 1
            end
        end

        task.delay(7, function() -- line: 1019
            -- upvalues:
            --  [1] ClientDebris_1 (copy)
            --  [2] arg54 (copy)

            for _, val_11 in ClientDebris_1:QueryDescendants(`BasePart[Name="{arg54}"]`) do
                _G.Tween(
                    val_11,
                    { 0.75, "Quad", Enum.EasingDirection.Out },
                    { Size = Vector3.new(0, 0, 0), Transparency = 1 },
                    true
                )
            end
        end)
    end
end)
Remotes.Client.ClientVFX.OnClientEvent:Connect(function(arg57, arg58, ...) -- line: 1028
    -- upvalues:
    --  [1] PCharacters (copy)
    --  [2] FightableNPCS (copy)
    --  [3] NPCS (copy)
    --  [4] Services_m (copy)
    --  [5] ReplicatedStorage (copy)
    --  [6] Utility_m (copy)
    --  [7] StateManager_m (copy)
    --  [8] RunService (copy)
    --  [9] raycastParams (copy)
    --  [10] VFX (copy)
    --  [11] Cloned (copy)
    --  [12] Effects (copy)

    if arg58 and not _G.CanRender(arg58) then
        return
    end

    local t_13 = { arg58, workspace.Effects, PCharacters, FightableNPCS, NPCS }

    if arg57 == "Stun" then
        local BlurEffect = Instance.new("BlurEffect")
        BlurEffect.Size = 15
        BlurEffect.Parent = Services_m.Lighting
        task.wait(0.7)
        _G.Tween(
            BlurEffect,
            { 0.15, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = 0 },
            true
        )

        return
    end

    if arg57 == "BodyClone" and arg58 then
        local v145 = ...

        for _, val_12 in pairs(arg58:GetChildren()) do
            if val_12:IsA("BasePart") then
                local v147 = val_12:Clone()
                v147.Anchored = true
                v147.Massless = true
                v147.CanCollide = false
                v147.Material = Enum.Material.Neon
                v147.Transparency = 0.1

                if v145 == "Dodge" then
                    v147.Color = Color3.fromRGB(0, 0, 0)
                    v147.Transparency = 0.5
                elseif v145 == "Perfect" then
                    v147.Color = Color3.fromRGB(170, 170, 255)
                elseif v145 == "Block" then
                    v147.Color = Color3.fromRGB(180, 210, 228)
                else
                    v147.Color = Color3.fromRGB(255, 89, 89)
                end

                v147:ClearAllChildren()

                if val_12.Name == "Head" then
                    ReplicatedStorage.Effects.HeadMesh:Clone().Parent = v147
                end

                v147.Parent = workspace.Effects
                _G.Tween(
                    v147,
                    { 0.5, "EntranceExpressive", Enum.EasingDirection.Out },
                    { Transparency = 1 },
                    true
                )
            end
        end

        return
    end

    if arg57 == "CombatHit" and arg58 then
        local v148 = ReplicatedStorage.Effects.CombatHit:Clone()
        Services_m.Debris(v148, 2)
        v148.Parent = arg58
        wait()
        Utility_m.EmitParticles(v148)

        return
    end

    if arg57 == "BlackFlash" and arg58 then
        task.wait(0.2)
        local v149 = ReplicatedStorage.Effects.BlackFlash:Clone()
        v149:PivotTo(arg58.CFrame)
        v149.Parent = workspace.Effects
        Utility_m.EmitParticles(v149)
        Services_m.Debris(v149, 3)
        Services_m.PlaySound(ReplicatedStorage.SFX.Combat.BlackFlash, arg58)

        return
    end

    local v150, v151

    if arg57 == "BlockBreak" and arg58 then
        v150 = ReplicatedStorage.Effects.GB:Clone()
        Services_m.Debris(v150, 3)
        v151 = arg58:IsA("Bone") and CFrame.new(arg58.WorldPosition) or arg58.CFrame
        v150.CFrame = v151
        v150.Parent = workspace.Effects
        wait()
        Utility_m.EmitParticles(v150)

        return
    end

    if arg57 == "KnockSlide" then
        v150, v151 = ...

        if not v150 or not v151 then
            return
        end

        local v152 = StateManager_m.require(v150)
        local v153 = ReplicatedStorage.Effects.DustSino:Clone()
        local HeavySmoke = v153:FindFirstChild("HeavySmoke", true)
        HeavySmoke.Enabled = true
        local v154 = Services_m.Maid.new()
        v154:GiveTask(RunService.Heartbeat:Connect(function() -- line: 1118
            -- upvalues:
            --  [1] v151 (copy)
            --  [2] v152 (copy)
            --  [3] v154 (copy)
            --  [4] HeavySmoke (copy)
            --  [5] Services_m (ref)
            --  [6] v153 (copy)
            --  [7] raycastParams (ref)
            --  [8] VFX (ref)

            if v151 then
                if v151:IsDescendantOf(game) then
                    if not v152:HasState("KnockSlide") then
                        v154:Destroy()
                        HeavySmoke.Enabled = false
                        Services_m.Debris(v153, 3.5)

                        return
                    end

                    local v155 = v151.CFrame
                    local v156 = workspace:Raycast(
                        v155.Position,
                        Vector3.new(0, -50, 0),
                        raycastParams
                    )

                    if v156 and v156.Instance and (v156.Position - v155.Position).Magnitude < 15 then
                        local Material_1 = v156.Material
                        local v157 = v156.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                            Material_1
                        ) or v156.Instance.Color
                        HeavySmoke.Color = ColorSequence.new(v157)
                        v153.Position = v156.Position + Vector3.new(0, 0.25, 0)
                        VFX.Emit2(HeavySmoke, 20)
                    end

                    return
                else
                    v154:Destroy()
                    HeavySmoke.Enabled = false
                    Services_m.Debris(v153, 3.5)

                    return
                end
            else
                v154:Destroy()
                HeavySmoke.Enabled = false
                Services_m.Debris(v153, 3.5)

                return
            end
        end))
        v153.Parent = workspace.Effects

        return
    end

    if arg57 == "AlkeTripleSlam" and arg58 then
        local v161
        v151, v161 = ...

        if not arg58.PrimaryPart or not v151 or not v161 then
            return
        end

        local SlamFX = Cloned.SlamFX
        Services_m.Debris(SlamFX, 2)
        SlamFX.CFrame = v151
        SlamFX.Size = Vector3.new(13, 0, 13)
        SlamFX.Parent = workspace.Effects
        local SlamDust = Cloned.SlamDust
        Services_m.Debris(SlamDust, 3)
        SlamDust.CFrame = v151
        SlamDust.Parent = workspace.Effects
        Effects:SetParticleColor(SlamDust, v161.Color)
        Effects:CreateSmokeCloud(
            v151,
            v161.Color,
            Vector3.new(10, 10, 10),
            NumberSequence.new(5),
            10
        )

        for _, val_13 in pairs(SlamDust:GetDescendants()) do
            if val_13:IsA("ParticleEmitter") then
                val_13.Color = ColorSequence.new(v161.Color)
                val_13:Emit(12)
            end
        end

        for _, val_14 in pairs(SlamFX:GetDescendants()) do
            if val_14:IsA("ParticleEmitter") then
                if val_14.Name == "Ring" then
                    val_14:Emit(5)
                elseif val_14.Name == "DirtParticle" or val_14.Name == "RockParticle" then
                    val_14.Color = ColorSequence.new(v161.Color)
                    val_14:Emit(15)
                end
            end
        end

        _G.GetModule("RockParts")(v151, 5, NumberRange.new(1, 3), { XZ = 35, Y = 60, Y2 = 100 })

        return
    end

    if arg57 == "WarpTakeOff" then
        local v165 = ...
        local PrimaryPart_4 = arg58.PrimaryPart
        local v166, v167 = Services_m.RayCast(v165.Position, v165.upVector * -10, t_13)

        if v166 then
            local cframe_4 = CFrame.new(v167)
            local v168 = ReplicatedStorage.Effects.RuinCloud:Clone()
            v168.Name = "Ignore"
            v168.Color = v166.Color
            v168.CFrame = cframe_4
            v168.Size = Vector3.new(15, 2, 15)
            v168.Parent = workspace.Effects
            Services_m.Debris(v168, 5)

            for _, val_15 in pairs(v168:GetDescendants()) do
                if val_15:IsA("ParticleEmitter") then
                    val_15:Emit(25)
                end
            end
        end

        local PlaySound = Services_m.PlaySound
        local RockDebris1 = ReplicatedStorage.SFX.Explosions.RockDebris1
        local v170 = v167 or PrimaryPart_4.Position
        PlaySound(RockDebris1, v170)
        local PlaySound_1 = Services_m.PlaySound
        local WarpAway = ReplicatedStorage.SFX.Misc.WarpAway
        v170 = v167 or PrimaryPart_4.Position
        PlaySound_1(WarpAway, v170)

        return
    end

    if arg57 == "WarpLand" then
        local v171 = ...
        local _ = _G.Tween
        Services_m.PlaySound(ReplicatedStorage.SFX.Misc.WarpLand, v171)
        local v172, v173 = Services_m.RayCast(v171.Position, v171.upVector * -10, t_13)

        if v172 then
            local cframe_5 = CFrame.new(v173)
            local v174 = ReplicatedStorage.Effects.RuinCloud:Clone()
            v174.Name = "Ignore"
            v174.Color = v172.Color
            v174.CFrame = cframe_5
            v174.Size = Vector3.new(15, 6, 15)
            v174.Parent = workspace.Effects
            Services_m.Debris(v174, 5)

            for _, val_16 in pairs(v174:GetDescendants()) do
                if val_16:IsA("ParticleEmitter") then
                    val_16:Emit(25)
                end
            end

            return
        end
    elseif arg57 == "Outfit" then
        local _ = _G.Tween
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Items.Outfit,
            arg58,
            nil,
            nil,
            nil,
            0.25
        )
        local v176 = ReplicatedStorage.Effects.OutfitChange:Clone()
        v176.Parent = workspace.Effects
        local Weld_1 = Instance.new("Weld")
        Weld_1.Part0 = v176
        Weld_1.Part1 = arg58
        Weld_1.C0 = CFrame.new(0, 3, 0)
        Weld_1.Parent = Weld_1.Part0

        for _, val_17 in pairs(v176:GetDescendants()) do
            if val_17:IsA("ParticleEmitter") then
                if val_17.Name:match("Emit") then
                    val_17:Emit((tonumber(string.split(val_17.Name, "Emit")[2])))
                else
                    val_17:Emit(8)
                end
            end
        end

        Services_m.Debris(v176, 3)
    end
end)
Remotes.Client.NPCVFX.OnClientEvent:Connect(function(arg59, ...) -- line: 1258
    if not arg59 then
        return
    end

    if not ... then
        return
    end

    _G.GetModule(arg59)(...)
end)
Remotes.Client.ScreenFX.OnClientEvent:Connect(function(arguments_1) -- line: 1267
    -- upvalues:
    --  [1] Lighting (copy)

    if arguments_1 == "BlindLight" then
        local v179 = script.LightBlind:Clone()
        v179.Size = 0
        local v180 = script.BlindVision:Clone()
        v180.Brightness = 0
        v180.Saturation = 0
        v180.TintColor = Color3.fromRGB(255, 255, 255)
        v179.Parent = Lighting
        _G.Tween(v179, { 0.25, "Quad", Enum.EasingDirection.Out }, { Size = 20 })
        local t_14 = {
            Brightness = 0.4,
            Saturation = 0.1,
            TintColor = Color3.fromRGB(255, 255, 255)
        }
        _G.Tween(v180, { 0.25, "Quad", Enum.EasingDirection.Out }, t_14)
        task.wait(1.5)
        _G.Tween(v179, { 0.25, "Quad", Enum.EasingDirection.Out }, { Size = 0 }, true)
        local t_16 = { Brightness = 0, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255) }
        _G.Tween(v180, { 0.25, "Quad", Enum.EasingDirection.Out }, t_16, true)
    end
end)
Remotes.Client.EXP.OnClientEvent:Connect(function(arg61, arg62, arg63) -- line: 1291
    -- upvalues:
    --  [1] Bezier_m (copy)

    local R3

    if not arg61 or not arg62 or not arg62.PrimaryPart then
        return
    end

    local v181 = arg61.CFrame

    if typeof(arg61) ~= "Instance" or not v181 then
        v181 = arg61
    end

    local v182 = if arg63 then script.InsightOrb:Clone() else script.ExpOrb:Clone()
    local v185 = v181 * CFrame.new(math.random(-3, 3), math.random(0, 5), math.random(-3, 3))
    local _ = CFrame.new
    local _ = math.random(-25, 25)
    local v187 = math.random(0, 5)
    v182.Anchored, v187 = true, v185
    v182:PivotTo(v187)
    v182.Parent = workspace.Effects
    local v188 = Bezier_m.new(v185.Position, R3, arg62:GetPivot().Position)
    local tweenInfo = TweenInfo.new(0.5)
    local v189 = v188:CreateCFrameTween(v182, { "CFrame" }, tweenInfo, true)
    v189:Play()
    v189.Completed:Once(function() -- line: 1315
        -- upvalues:
        --  [1] v182 (ref)

        v182:Destroy()
    end)
end)
Remotes.Client.Door.OnClientEvent:Connect(function(
    arg64,
    arg65,
    arg66,
    arg67,
    arg68
) -- line: 1320
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if not arg64 then
        return
    end

    local v190 = arg64:FindFirstChild("Man")

    if v190 then
        v190 = arg64.Man:FindFirstChild("HingeConstraint")
    end

    local TouchDetection = arg64:FindFirstChild("TouchDetection")

    if v190 and TouchDetection then
        if arg65.Opened then
            v190.AngularSpeed = arg66 or 2
            v190.TargetAngle = 90 * arg65.Direction

            if not arg67 then
                local v191 = (arg68 or ReplicatedStorage.SFX.Misc.DoorOpen):Clone()
                v191.PlayOnRemove = true
                v191.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                v191.Parent = TouchDetection
                v191:Destroy()

                return
            end
        else
            v190.AngularSpeed = 5
            v190.TargetAngle = 0
            task.delay(0.3, function() -- line: 1343
                -- upvalues:
                --  [1] arg67 (copy)
                --  [2] arg68 (copy)
                --  [3] ReplicatedStorage (ref)
                --  [4] TouchDetection (copy)

                if not arg67 then
                    local v192 = (arg68 or ReplicatedStorage.SFX.Misc.DoorClose):Clone()
                    v192.PlayOnRemove = true
                    v192.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
                    v192.Parent = TouchDetection
                    v192:Destroy()
                end
            end)
        end
    end
end)
