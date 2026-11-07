-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.AlkeBoss
-- Class: ModuleScript
-- bytes: 10259

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.VFX
local rng = Random.new()
local g_require_1 = require
local CurrentCamera = workspace.CurrentCamera
local v2 = g_require_1(ReplicatedStorage.Modules:FindFirstChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(
    arg1
) -- line: 11
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v2:Start()
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include
local Utility_m = require(ReplicatedStorage.Modules.Utility)

function Attack(arg2, ...) -- line: 25
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Utility_m (copy)
    --  [3] v2 (copy)
    --  [4] raycastParams (copy)
    --  [5] Effects (copy)
    --  [6] rng (copy)

    local v3, v4, _ = ...

    if (v3.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg2 == "Slam" then
        local v6 = ReplicatedStorage.Effects.NPC.AlkeBoss.VenomSlam:Clone()
        _G.Debris(v6, 5)
        v6.Position = v3.Position
        v6.Parent = workspace.Effects
        wait()
        Utility_m.EmitParticles(v6)
        _G.PlaySound(
            ReplicatedStorage.SFX.Explosions.Explosion8,
            v6,
            250,
            0.8,
            Random.new():NextNumber(1.2, 1.4),
            nil
        )
        _G.PlaySound(
            ReplicatedStorage.SFX.Skills.acidsplash,
            v6,
            250,
            nil,
            nil,
            nil
        )

        if (v3.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 250 then
            v2:ShakeOnce(3, 3, 0, 0.1)

            return
        end
    elseif arg2 == "RockEruption" then
        local v7 = ReplicatedStorage.Effects.NPC.AlkeBoss.RockExplosion:Clone()
        _G.Debris(v7, 3)
        local v8 = workspace:Raycast(v3.Position, Vector3.new(0, -25, 0), raycastParams)

        if v8 then
            if v8.Instance then
                v7.CFrame = CFrame.new(v8.Position)
                Effects:SetParticleColor(v7, v8.Instance.Color, "RocMis")
                v7.Parent = workspace.Effects
                Utility_m.EmitParticles(v7)

                if rng:NextInteger(1, 2) == 1 then
                    _G.PlaySound(
                        ReplicatedStorage.SFX.Explosions.RockImpact,
                        v7,
                        250,
                        0.75,
                        rng:NextNumber(0.8, 1.25),
                        nil
                    )
                end

                if rng:NextInteger(1, 3) == 1 and (v3.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 250 then
                    v2:ShakeOnce(4, 4, 0, 0.1)

                    return
                end
            else
                v7:Destroy()

                return
            end
        else
            v7:Destroy()

            return
        end
    elseif arg2 == "ConsecutiveDebris" then
        local v9 = v3.Position + Vector3.new(0, 1, 0)
        local v10 = workspace:Raycast(v9, Vector3.new(0, -40, 0), raycastParams)

        if v10 and v10.Instance then
            local v11 = 10
            v9 = 20

            if v4 == "Left" then
                v11 = -20
                v9 = -10
            end

            local v14 = CFrame.new(v10.Position) * CFrame.new(
                rng:NextInteger(v11, v9),
                0,
                rng:NextInteger(-15, 15)
            ) * CFrame.new(0, 1, 0)
            v9 = v10.Material
            v11 = v10.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(v9) or v10.Instance.Color
            local v15 = script.SlamContact:Clone()
            v15.CFrame = v14
            v15.Parent = workspace.Effects
            _G.Debris(v15, 4)
            _G.PlaySound(
                ReplicatedStorage.SFX.Misc.MeteorVolcano,
                v15,
                500,
                0.4,
                rng:NextNumber(1.1, 1.3),
                nil
            )
            wait()

            for _, val in pairs(v15:GetDescendants()) do
                if val:IsA("ParticleEmitter") then
                    if not val.Name:match("Smoke") then
                        if val.Name:match("Rock") then
                            val.Color = ColorSequence.new(v11)
                        end
                    else
                        val.Color = ColorSequence.new(v11)
                    end
                end
            end

            Utility_m.EmitParticles(v15)

            if (v14.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 250 then
                v2:ShakeOnce(3, 3, 0, 0.1)
            end

            for _ = 1, 2 do
                local _ = { XZ = 11, Y = 30, Y2 = 45 }
                local Briks_Part = Instance.new("Part")
                Briks_Part.Name = "briks"
                Briks_Part.CastShadow = false
                Briks_Part.Anchored = false
                Briks_Part.CanCollide = true
                Briks_Part.TopSurface = Enum.SurfaceType.Smooth
                Briks_Part.BottomSurface = Enum.SurfaceType.Smooth
                Briks_Part.Color = v11
                Briks_Part.Material = v9

                if v10.Instance.MaterialVariant ~= "" then
                    Briks_Part.MaterialVariant = v10.Instance.MaterialVariant
                end

                local v18 = rng:NextNumber(0.75, 2.5)
                Briks_Part.Size = Vector3.new(
                    v18,
                    rng:NextInteger(0.75, 2.5),
                    rng:NextNumber(0.75, 2.5)
                )
                local v20 = math.random(-100, 100)
                Briks_Part.Orientation = Vector3.new(
                    v20,
                    math.random(-100, 100),
                    math.random(-100, 100)
                )
                Briks_Part.Position = v14.Position
                Briks_Part.CollisionGroup = "Debris"
                Briks_Part.Parent = workspace.Effects.Debris
                _G.Debris(Briks_Part, 4)
                Briks_Part.CanCollide = false
                task.delay(0.1, function() -- line: 153
                    -- upvalues:
                    --  [1] Briks_Part (copy)

                    Briks_Part.CanCollide = true
                end)
                local v22 = rng:NextInteger(-11, 11)
                Briks_Part.Velocity = Vector3.new(
                    v22,
                    rng:NextInteger(30, 45),
                    rng:NextInteger(-11, 11)
                )
                local BodyVelocity = Instance.new("BodyVelocity")
                local v24 = rng:NextInteger(-11, 11)
                BodyVelocity.Velocity = Vector3.new(
                    v24,
                    rng:NextInteger(30, 45),
                    rng:NextInteger(-11, 11)
                )
                BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                BodyVelocity.Parent = Briks_Part
                _G.Debris(BodyVelocity, 0.25)
            end
        end
    else
        local v27, v28, v29, v30

        if arg2 == "CombatDebris" then
            v27 = workspace:Raycast(
                v3.Position + Vector3.new(0, 1, 0),
                Vector3.new(0, -40, 0),
                raycastParams
            )

            if v27 and v27.Instance then
                v28 = CFrame.new(v27.Position) * CFrame.new(0, 1, 0)
                local Material = v27.Material
                v29 = v27.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v27.Instance.Color
                v30 = script.SlamContact:Clone()
                v30.CFrame = v28
                v30.Parent = workspace.Effects
                _G.Debris(v30, 4)
                _G.PlaySound(
                    ReplicatedStorage.SFX.Explosions.AerialSlam,
                    v30,
                    500,
                    0.15,
                    rng:NextNumber(1.25, 1.75),
                    nil
                )
                wait()

                for _, val_1 in pairs(v30:GetDescendants()) do
                    if val_1:IsA("ParticleEmitter") then
                        if not val_1.Name:match("Smoke") then
                            if val_1.Name:match("Rock") then
                                val_1.Color = ColorSequence.new(v29)
                            end
                        else
                            val_1.Color = ColorSequence.new(v29)
                        end
                    end
                end

                Utility_m.EmitParticles(v30)

                if (v28.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 250 then
                    v2:ShakeOnce(2, 2, 0, 0.1)

                    return
                end
            end
        elseif arg2 == "Rupture" then
            v27, v28, v30, v29 = ...
            local v32 = script.Rupture:Clone()
            v32.CFrame = v3
            v32.Parent = workspace.Effects
            _G.Debris(v32, 4)
            wait()

            for _, val_2 in pairs(v32:GetDescendants()) do
                if val_2:IsA("ParticleEmitter") then
                    if not val_2.Name:match("Smoke") then
                        if val_2.Name:match("Rock") then
                            val_2.Color = ColorSequence.new(v28)
                        end
                    else
                        val_2.Color = ColorSequence.new(v28)
                    end
                end
            end

            Utility_m.EmitParticles(v32)
            _G.PlaySound(
                ReplicatedStorage.SFX.Explosions.Explosion8,
                v32,
                250,
                0.8,
                Random.new():NextNumber(1.2, 1.4),
                nil
            )
            _G.GetModule("RockParts")(
                v3,
                rng:NextInteger(5, 7),
                NumberRange.new(5, 7),
                { XZ = 35, Y = 125, Y2 = 165 },
                v29
            )
        end
    end
end

return Attack
