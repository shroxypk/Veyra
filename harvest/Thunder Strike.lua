-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Lightning.Thunder Strike
-- Class: ModuleScript
-- bytes: 5141

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local rng = Random.new()
local _ = workspace.CurrentCamera
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local Effects = _G.GetModule("Effects")
local DebrisCircle = _G.GetModule("DebrisCircle")
local _ = require(ReplicatedStorage.LightningBolt.LightningExplosion)
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function Attack(arg1, arg2, arg3, arg4) -- line: 21
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] raycastParams (copy)
    --  [4] DebrisCircle (copy)
    --  [5] Utility_m (copy)
    --  [6] Effects (copy)
    --  [7] Services_m (copy)
    --  [8] rng (copy)

    if not arg2 or not arg2.PrimaryPart then
        return
    end

    local PrimaryPart = arg2.PrimaryPart
    local v2 = GrimoireRarity_m:GetPlayerVariant(arg2)
    local v3 = v2 and v2.Primary or Color3.fromRGB(170, 85, 255)

    if arg1 == "Place" then
        local v4 = ReplicatedStorage.SFX.Effects.LightningStrike:Clone()
        v4.PlayOnRemove = true
        v4.Volume = 0.4
        v4.PlaybackSpeed = 1
        v4.TimePosition = 0.808
        v4.Parent = PrimaryPart
        v4:Destroy()
        local v5 = workspace:Raycast(arg3.Position, Vector3.new(0, -10, 0), raycastParams)

        if v5 and v5.Instance then
            local cframe = CFrame.new(v5.Position)
            DebrisCircle.ConnectedCircle(
                nil,
                12,
                2,
                6.5,
                nil,
                cframe * CFrame.new(0, 1, 0)
            )

            return
        end
    elseif arg1 == "Landing" then
        local v6 = script.GroundImpact:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v6, v2)
        v6.CFrame = arg3 * CFrame.new(0, 2, 0)
        v6.Parent = workspace.Effects
        wait()
        Utility_m.EmitParticles(v6)
        _G.Debris(v6, 4)
        local v7 = ReplicatedStorage.Effects.Ball:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v7, v2)
        v7.CFrame = arg3 * CFrame.new(0, 1.5, 0)
        v7.Color = v3
        v7.Material = Enum.Material.ForceField
        v7.Parent = workspace.Effects
        _G.Tween(
            v7,
            { 0.35, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(25, 25, 25), Transparency = 1 },
            true
        )
        local v8 = workspace:Raycast(arg3.Position, Vector3.new(0, -10, 0), raycastParams)

        if v8 and v8.Instance then
            local cframe_1 = CFrame.new(v8.Position)
            local Material = v8.Material
            local v9 = v8.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v8.Instance.Color
            local v10 = script.RockErupt:Clone()
            v10.CFrame = cframe_1
            v10.Size = Vector3.new(20, 3, 20)
            v10.Parent = workspace.Effects
            _G.Debris(v10, 3)
            Effects:SetParticleColor(v10, v9)
            Effects:EmitParticle(v10, 10)
            _G.GetModule("RockParts")(
                cframe_1,
                5,
                NumberRange.new(2, 4),
                { XZ = 35, Y = 60, Y2 = 80 }
            )
            Effects:CreateGroundCrack(CFrame.new(v8.Position), Vector3.new(15, 0, 15))
        end

        Effects.AddLight(arg3, v3, 10, 5)
        Services_m.PlaySound(ReplicatedStorage.SFX.Explosions.RockDebris1, arg3)
        Services_m.PlaySound(ReplicatedStorage.SFX.Effects.Lightning, arg3)

        for _ = 1, 4 do
            v8 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(6.666666666666667, 10) or rng:NextInteger(
                -10,
                -6.666666666666667
            )
            local v12 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(6.666666666666667, 10) or rng:NextInteger(
                -10,
                -6.666666666666667
            )
            local v13 = arg3 * CFrame.new(v8, rng:NextInteger(4, 7), v12)
            Effects.GenerateLightning(
                arg3,
                v13,
                {
                    Speed = 4.25,
                    Length = rng:NextNumber(0.75, 1),
                    Radius = 3,
                    Color = v3,
                    Unit = 2,
                    Curve = 15,
                    FadeLength = 0.25,
                    Thickness = rng:NextNumber(0.75, 2)
                }
            )
            task.wait()
        end
    elseif arg1 == "Trail" then
        Effects.GenerateLightning(
            arg3,
            arg4,
            {
                Speed = 4,
                Length = rng:NextNumber(0.75, 1),
                Radius = 3,
                Color = v3,
                Unit = 2,
                Curve = 10,
                Thickness = 2.5
            }
        )
    end
end

return Attack
