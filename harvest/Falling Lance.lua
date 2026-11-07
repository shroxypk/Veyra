-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Light.Falling Lance
-- Class: ModuleScript
-- bytes: 6527

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rng = Random.new()
local Effects = _G.GetModule("Effects")
local DebrisCircle = _G.GetModule("DebrisCircle")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include
local CurrentCamera = workspace.CurrentCamera

local function main(arg1, arg2, arg3) -- line: 19
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Effects (copy)
    --  [5] Services_m (copy)
    --  [6] Utility_m (copy)
    --  [7] raycastParams (copy)
    --  [8] DebrisCircle (copy)
    --  [9] rng (copy)

    if (CurrentCamera.CFrame.Position - arg3.Position).Magnitude > 350 then
        return
    end

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg2)
    local v3 = v2 and v2.Primary or Color3.fromRGB(255, 245, 165)

    if arg1 == "Place" then
        local v4 = ReplicatedStorage.Effects.CurvyRing:Clone()
        v4.Anchored = true
        v4.Color = Color3.fromRGB(255, 0, 0)
        v4.Material = Enum.Material.ForceField
        v4.Size = Vector3.new(20, 2, 20)
        v4.CFrame = arg3 * CFrame.fromEulerAnglesXYZ(3.141592653589793, 0, 0)
        v4.Parent = workspace.Effects
        local t = { CFrame = nil, Transparency = 1 }
        local Tween = _G.Tween
        local t_1 = { 0.5, "EntranceExpressive", Enum.EasingDirection.Out }
        t.CFrame = v4.CFrame * CFrame.new(0, -10, 0)
        Tween(v4, t_1, t, true)

        return
    end

    if arg1 == "Explosion" then
        Effects.AddLight(arg3, v3, 20, 10)
        local v6 = script.LIGHTEXPLOSION:Clone()
        v6.CFrame = arg3
        GrimoireRarity_m:ApplyVariantEffect(v6, v2)
        v6.Parent = workspace.Effects
        Services_m.Debris(v6, 2)
        Utility_m.EmitParticles(v6)
        local v7 = ReplicatedStorage.Effects.Ball:Clone()
        v7.CFrame = arg3 * CFrame.new(0, 1.5, 0)
        v7.Color = v3
        v7.Material = Enum.Material.ForceField
        v7.Parent = workspace.Effects
        _G.Tween(
            v7,
            { 0.5, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(30, 30, 30), Transparency = 1 },
            true
        )
        local v8 = ReplicatedStorage.Effects.Ball:Clone()
        v8.CFrame = arg3 * CFrame.new(0, 1.5, 0)
        v8.Color = v3
        v8.Material = Enum.Material.Neon
        v8.Parent = workspace.Effects
        _G.Tween(
            v8,
            { 0.45, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(20, 20, 20) }
        )
        task.delay(0.25, function() -- line: 67
            -- upvalues:
            --  [1] v8 (copy)

            local t_2 = { Color = Color3.fromRGB(255, 95, 21) }
            _G.Tween(
                v8,
                { 0.2, "EntranceExpressive", Enum.EasingDirection.Out },
                t_2,
                false,
                true
            )
            local t_4 = { Color = Color3.fromRGB(0, 0, 0), Transparency = 1 }
            _G.Tween(v8, { 0.2, "Quad", Enum.EasingDirection.Out }, t_4, true)
        end)
        local v11 = ReplicatedStorage.Effects.CurvyRing:Clone()
        v11.Anchored = true
        v11.Color = v3
        v11.Material = Enum.Material.Neon
        v11.Size = Vector3.new(27, 0.5, 27)
        v11.CFrame = arg3 * CFrame.new(0, 0, 0)
        v11.Parent = workspace.Effects
        _G.Tween(
            v11,
            { 0.5, "Quad", Enum.EasingDirection.Out },
            { Size = v11.Size + Vector3.new(5, 0, 5), Transparency = 1 },
            true
        )
        local v12 = workspace:Raycast(arg3.Position, Vector3.new(0, -10, 0), raycastParams)

        if v12 and v12.Instance then
            local cframe = CFrame.new(v12.Position)
            local Material = v12.Material
            local v13 = v12.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v12.Instance.Color
            local v14 = script.Rocks:Clone()
            v14.CFrame = cframe
            v14.Size = Vector3.new(12, 0, 12)
            v14.Parent = workspace.Effects
            Services_m.Debris(v14, 2)
            Effects:SetParticleColor(v14, v13)
            Effects:EmitParticle(v14, 8)
            Effects:CreateSmokeCloud(
                cframe,
                v13,
                Vector3.new(12, 5, 12),
                NumberSequence.new(10),
                20
            )
            _G.GetModule("RockParts")(
                cframe,
                5,
                NumberRange.new(1, 3),
                { XZ = 15, Y = 55, Y2 = 75 }
            )
        end

        DebrisCircle.new(
            nil,
            16,
            Vector3.new(5, 5, 5),
            12,
            nil,
            arg3 * CFrame.new(0, 1, 0)
        )

        return
    end

    if arg1 == "Splash" then
        for _ = 1, rng:NextInteger(5, 7) do
            local _ = rng:NextInteger(5, 7)
            local v17 = ReplicatedStorage.Effects.Ball:Clone()
            v17.CFrame = arg3 * CFrame.new(rng:NextInteger(-7, 7), 0.5, rng:NextInteger(-7, 7))
            v17.Color = v3
            v17.Material = Enum.Material.Neon
            v17.Size = Vector3.new(2, 2, 2)
            v17.Parent = workspace.Effects
            local v19 = rng:NextInteger(6, 10)
            local t_7 = { Size = Vector3.new(v19, v19, v19) }
            _G.Tween(v17, { 0.4, "Quad", Enum.EasingDirection.Out }, t_7)
            task.delay(0.1, function() -- line: 123
                -- upvalues:
                --  [1] v17 (copy)

                local t_9 = { Color = Color3.fromRGB(255, 95, 21) }
                _G.Tween(
                    v17,
                    { 0.2, "EntranceExpressive", Enum.EasingDirection.Out },
                    t_9,
                    false,
                    true
                )
                local t_11 = {
                    Size = Vector3.new(0, 0, 0),
                    Color = Color3.fromRGB(0, 0, 0),
                    Transparency = 1
                }
                _G.Tween(v17, { 0.25, "Linear", Enum.EasingDirection.Out }, t_11, true)
            end)
            task.wait()
        end
    end
end

return main
