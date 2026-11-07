-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Flame.Flame Trap
-- Class: ModuleScript
-- bytes: 3412

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Random.new()
local Effects = _G.GetModule("Effects")
local color = Color3.fromRGB(255, 122, 89)
local t = { workspace.Map }

return function(_, arg2, ...) -- line: 12
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] t (copy)
    --  [3] Effects (copy)
    --  [4] color (copy)
    --  [5] ReplicatedStorage (copy)

    local v2, v3 = ...

    if arg2 == "Explosion" then
        local _ = workspace:Raycast()
        local v5, v6 = Services_m.RayCastWhiteList(
            v3.Position + Vector3.new(0, 1, 0),
            Vector3.new(0, -10, 0),
            t
        )

        if v5 then
            local cframe = CFrame.new(v6)
            local v7 = script.RockErupt:Clone()
            _G.Debris(v7, 1)
            v7.CFrame = cframe
            v7.Size = Vector3.new(v2, 0, v2)
            v7.Parent = workspace.Effects
            Effects:SetParticleColor(v7, v5.Color)
            Effects:SetParticleSpeed(v7, NumberRange.new(60 + v2 * 4, 80 + v2 * 4))
            Effects:EmitParticle(v7, 3)
            local v9 = script.FireErupt:Clone()
            _G.Debris(v9, 1)
            v9.CFrame = cframe
            v9.Size = Vector3.new(v2, 0, v2)
            v9.Parent = workspace.Effects
            Effects:SetParticleSize(
                v9,
                NumberSequence.new(
                    { NumberSequenceKeypoint.new(0, 2 + v2, 1), NumberSequenceKeypoint.new(1, 0) }
                )
            )
            Effects:SetParticleSpeed(v9, NumberRange.new(70 + v2 * 4, 90 + v2 * 4))
            Effects:EmitParticle(v9, 10)
            local v12 = script.GroundFire:Clone()
            _G.Debris(v12, 1)
            v12.CFrame = cframe * CFrame.new(0, 0.5, 0)
            v12.Parent = workspace.Effects
            Effects:SetParticleSize(
                v12,
                NumberSequence.new(
                    { NumberSequenceKeypoint.new(0, v2 * 0.9, 1), NumberSequenceKeypoint.new(1, 0) }
                )
            )
            Effects:SetParticleSpeed(v12, NumberRange.new(20 + v2 * 2, 30 + v2 * 2))
            Effects:EmitParticle(v12, 10)

            return
        end
    elseif arg2 == "Ring" then
        Effects.AddLight(v3, color, v2, 3)
        local v15 = ReplicatedStorage.Effects.Ball:Clone()
        v15.CFrame = v3
        v15.Color = color
        v15.Size = Vector3.new(2, 2, 2)
        v15.Material = Enum.Material.ForceField
        v15.Parent = workspace.Effects
        _G.Tween(
            v15,
            { 0.5, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = v15.Size * v2, Transparency = 1 },
            true
        )
        local v16 = ReplicatedStorage.Effects.CurvyRing:Clone()
        v16.Anchored = true
        v16.Color = color
        v16.Material = Enum.Material.Neon
        v16.Size = Vector3.new(v2 + 3, 2, v2 + 3)
        v16.CFrame = v3 * CFrame.fromEulerAnglesXYZ(3.141592653589793, 0, 0)
        v16.Parent = workspace.Effects
        local t_4 = { CFrame = nil, Size = nil, Transparency = 1 }
        local Tween = _G.Tween
        local t_5 = { 0.75, "EntranceExpressive", Enum.EasingDirection.Out }
        t_4.CFrame = v16.CFrame * CFrame.new(0, -20, 0)
        t_4.Size = v16.Size + Vector3.new(15, -2, 15)
        Tween(v16, t_5, t_4, true)
    end
end
