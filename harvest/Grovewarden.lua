-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Grovewarden
-- Class: ModuleScript
-- bytes: 3901

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local VFX = Services_m.VFX
local rng = Random.new()
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 11
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local _ = require(ReplicatedStorage.Modules.Utility)
local Effects = _G.GetModule("Effects")
local DebrisCircle = _G.GetModule("DebrisCircle")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include
local Utility_m_1 = require(ReplicatedStorage.Modules.Utility)

function Attack(arg2, ...) -- line: 26
    -- upvalues:
    --  [1] Utility_m_1 (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Effects (copy)
    --  [4] rng (copy)
    --  [5] DebrisCircle (copy)
    --  [6] VFX (copy)

    local v3 = ...

    if (v3.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg2 == "Slam" then
        local _, v5, _, v7 = ...
        local v8 = script.Rupture:Clone()
        v8.CFrame = v3
        v8.Parent = workspace.Effects
        _G.Debris(v8, 4)
        wait()

        for _, val in pairs(v8:GetDescendants()) do
            if val:IsA("ParticleEmitter") then
                if not val.Name:match("Smoke") then
                    if val.Name:match("Rock") then
                        val.Color = ColorSequence.new(v5)
                    end
                else
                    val.Color = ColorSequence.new(v5)
                end
            end
        end

        Utility_m_1.EmitParticles(v8)
        _G.PlaySound(
            ReplicatedStorage.SFX.Explosions.Explosion8,
            v8,
            250,
            0.8,
            Random.new():NextNumber(1.2, 1.4),
            nil
        )
        Effects:CreateSmokeCloud(
            v3 * CFrame.new(0, -4, 0),
            v5,
            Vector3.new(16, 2, 13),
            NumberSequence.new(5),
            10,
            10
        )
        _G.GetModule("RockParts")(
            v3,
            rng:NextInteger(5, 7),
            NumberRange.new(2, 4),
            { XZ = 25, Y = 45, Y2 = 60 },
            v7
        )
        DebrisCircle.new(
            nil,
            rng:NextInteger(3, 7),
            Vector3.new(4, 4, 4),
            rng:NextInteger(7, 8),
            nil,
            v3 * CFrame.new(0, 1, 0)
        )

        return
    end

    if arg2 == "OrbExplosion" then
        local Position = v3.Position
        local v15 = ReplicatedStorage.Effects.NPC.Grovewarden.Impact:Clone()
        v15.Position = Position + Vector3.new(0, 0.5, 0)
        v15.Parent = workspace.Effects
        VFX.Emit2(v15, true)
        _G.Debris(v15, 4)
        _G.PlaySound(
            ReplicatedStorage.SFX.Explosions.Explosion8,
            v15,
            nil,
            nil,
            nil,
            nil
        )

        return
    end

    if arg2 == "Swipe" then
        _G.PlaySound(
            script.SwipeSFX,
            v3,
            nil,
            nil,
            nil,
            nil
        )
        local v16 = script.VFX1:Clone()
        v16.CFrame = v3
        v16.Parent = workspace.Effects
        _G.Debris(v16, 3)
        VFX.Emit2(v16, true)

        return
    end

    if arg2 == "Pounce" then
        _G.PlaySound(
            script.Dash,
            v3,
            nil,
            nil,
            nil,
            nil
        )
        local v17 = script.VFX2:Clone()
        v17.CFrame = v3
        v17.Parent = workspace.Effects
        _G.Debris(v17, 3)
        VFX.Emit2(v17, true)
    end
end

return Attack
