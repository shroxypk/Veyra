-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.FireArtillery
-- Class: ModuleScript
-- bytes: 1469

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.ReplicatedStorage
local _ = Services_m.VFX
local _ = Random.new()
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(arg1, ...) -- line: 15
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] Effects (copy)

    if arg1 == "FX" then
        local v3 = workspace:Raycast(
            (...).Position + Vector3.new(0, 1, 0),
            Vector3.new(0, -20, 0),
            raycastParams
        )

        if v3 and v3.Instance then
            local Color = v3.Instance.Color
            local cframe = CFrame.new(v3.Position)
            _G.GetModule("RockParts")(
                cframe,
                4,
                NumberRange.new(6, 8),
                { XZ = 60, Y = 120, Y2 = 150 }
            )
            local v4 = script.RockErupt:Clone()
            v4.CFrame = cframe
            v4.Size = Vector3.new(30, 0, 30)
            v4.Parent = workspace.Effects
            Effects:SetParticleColor(v4, Color)
            Effects:EmitParticle(v4, 20)
            Effects:CreateSmokeCloud(
                cframe,
                Color,
                Vector3.new(25, 5, 25),
                NumberSequence.new(10),
                15
            )
        end
    end
end

return Attack
