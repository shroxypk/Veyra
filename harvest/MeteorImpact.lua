-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.MeteorImpact
-- Class: ModuleScript
-- bytes: 2228

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local VFX = Services_m.VFX
local Effects = _G.GetModule("Effects")
local DebrisCircle = _G.GetModule("DebrisCircle")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(arg1, ...) -- line: 15
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] Effects (copy)
    --  [3] VFX (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] DebrisCircle (copy)

    local v2 = ...

    if arg1 == "Land" then
        local Position = v2.Position
        local v4 = workspace:Raycast(Position, Vector3.new(0, -20, 0), raycastParams)

        if v4 and v4.Instance then
            local Color = v4.Instance.Color
            Position = v4.Position
            local cframe = CFrame.new(Position)
            _G.GetModule("RockParts")(
                cframe,
                4,
                NumberRange.new(1, 3),
                { XZ = 25, Y = 70, Y2 = 80 }
            )
            local v5 = script.RockErupt:Clone()
            v5.CFrame = cframe
            v5.Size = Vector3.new(10, 0, 10)
            v5.Parent = workspace.Effects
            Effects:SetParticleColor(v5, Color)
            Effects:EmitParticle(v5, 20)
            Effects:CreateSmokeCloud(
                cframe,
                Color,
                Vector3.new(16, 5, 16),
                NumberSequence.new(10),
                10
            )
            Effects:CreateGroundCrack(cframe, Vector3.new(15, 0, 15))
        end

        local v7 = script.MeteorExplosion:Clone()
        v7.Position = Position + Vector3.new(0, 0.5, 0)
        v7.Parent = workspace.Effects
        VFX.Emit2(v7, true)
        _G.Debris(v7, 2)
        _G.PlaySound(
            ReplicatedStorage.SFX.Explosions.Explosion8,
            v7,
            nil,
            nil,
            nil,
            nil
        )
        DebrisCircle.ConnectedCircle(
            nil,
            10,
            3.5,
            11,
            nil,
            v2 * CFrame.new(0, 1, 0)
        )
    end
end

return Attack
