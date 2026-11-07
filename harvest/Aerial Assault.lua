-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Light.Aerial Assault
-- Class: ModuleScript
-- bytes: 4799

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local Effects = _G.GetModule("Effects")

local function main(arg1, arg2, arg3, arg4) -- line: 10
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Utility_m (copy)
    --  [3] Services_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] Effects (copy)

    local v2 = arg2

    if v2 then
        v2 = arg2.PrimaryPart
    end

    if not v2 or (v2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    v2 = GrimoireRarity_m:GetPlayerVariant(arg2)
    local v3 = v2 and v2.Primary or Color3.fromRGB(255, 245, 165)

    if arg1 == "Rush" then
        local v4 = script["LIGHT SPARK"]:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v4, v2)
        v4.CFrame = arg3
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
        Services_m.Debris(v4, 0.75)

        return
    end

    if arg1 == "Trail" then
        local Magnitude = (arg3.Position - arg4.Position).Magnitude
        local v5 = script.Trail:Clone()
        v5.Size = Vector3.new(2.5, 2.5, Magnitude)
        v5.CFrame = CFrame.lookAt(arg3.Position:Lerp(arg4.Position, 0.5), arg4.Position)
        v5.Parent = workspace.Effects
        local t = { Size = Vector3.new(0, 0, 2), CFrame = nil }
        local Tween = _G.Tween
        local t_1 = { 0.5, "Quad", Enum.EasingDirection.Out }
        t.CFrame = v5.CFrame * CFrame.new(0, 0, -Magnitude / 2)
        Tween(v5, t_1, t, true)
        local v8 = ReplicatedStorage.Effects.LightTrail:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v8, v2)
        v8.Size = Vector3.new(3, 3, Magnitude)
        v8.CFrame = CFrame.lookAt(arg3.Position:Lerp(arg4.Position, 0.5), arg4.Position)
        v8.Parent = workspace.Effects
        Services_m.Debris(v8, 2)
        Effects:EmitParticle(v8, 15)

        return
    end

    if arg1 == "Explosion" then
        Effects.AddLight(arg4, v3, 15, 10)
        local Magnitude_1 = (arg3.Position - arg4.Position).Magnitude
        local v10 = script.Trail:Clone()
        v10.Size = Vector3.new(2.5, 2.5, Magnitude_1)
        v10.Color = v3
        v10.CFrame = CFrame.lookAt(arg3.Position:Lerp(arg4.Position, 0.5), arg4.Position)
        v10.Parent = workspace.Effects
        local t_2 = { Size = Vector3.new(0, 0, 2), CFrame = nil }
        local Tween_1 = _G.Tween
        local t_3 = { 0.5, "EntranceExpressive", Enum.EasingDirection.Out }
        t_2.CFrame = v10.CFrame * CFrame.new(0, 0, -Magnitude_1 / 2)
        Tween_1(v10, t_3, t_2, true)
        local v13 = ReplicatedStorage.Effects.LightTrail:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v13, v2)
        v13.Size = Vector3.new(3, 3, Magnitude_1)
        v13.CFrame = CFrame.lookAt(arg3.Position:Lerp(arg4.Position, 0.5), arg4.Position)
        v13.Parent = workspace.Effects
        Effects:EmitParticle(v13, 25)
        Services_m.Debris(v13, 2)
        local v15 = ReplicatedStorage.Effects.Ball:Clone()
        v15.CFrame = arg4 * CFrame.new(0, 1.5, 0)
        v15.Color = v3
        v15.Material = Enum.Material.ForceField
        v15.Parent = workspace.Effects
        _G.Tween(
            v15,
            { 0.5, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(15, 15, 15), Transparency = 1 },
            true
        )
        local v16 = ReplicatedStorage.Effects.Ball:Clone()
        v16.CFrame = arg4 * CFrame.new(0, 1.5, 0)
        v16.Color = v3
        v16.Material = Enum.Material.Neon
        v16.Parent = workspace.Effects
        _G.Tween(
            v16,
            { 0.45, "Quad", Enum.EasingDirection.Out },
            { Size = Vector3.new(10, 10, 10) }
        )
        task.delay(0.25, function() -- line: 88
            -- upvalues:
            --  [1] v16 (copy)

            local t_4 = { Color = Color3.fromRGB(255, 95, 21) }
            _G.Tween(
                v16,
                { 0.2, "Quad", Enum.EasingDirection.Out },
                t_4,
                false,
                true
            )
            local t_6 = { Color = Color3.fromRGB(0, 0, 0), Transparency = 1 }
            _G.Tween(v16, { 0.2, "Quad", Enum.EasingDirection.Out }, t_6, true)
        end)
        local v19 = script.Explosion:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v19, v2)
        v19.CFrame = arg4
        v19.Parent = workspace.Effects
        Services_m.Debris(v19, 2)
        Effects:EmitParticle(v19, 8, "Ring")
        Effects:EmitParticle(v19, 5, "Twinkle")
        Effects:EmitParticle(v19, 1, nil, "Ring")
    end
end

return main
