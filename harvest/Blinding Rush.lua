-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Light.Blinding Rush
-- Class: ModuleScript
-- bytes: 7217

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rng = Random.new()
local Effects = _G.GetModule("Effects")
local DebrisCircle = _G.GetModule("DebrisCircle")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local _ = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function main(arg1, arg2, arg3, arg4) -- line: 17
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] raycastParams (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] DebrisCircle (copy)
    --  [5] Effects (copy)
    --  [6] Services_m (copy)
    --  [7] rng (copy)

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
        local Magnitude = (arg3.Position - arg4.Position).Magnitude
        local cframe = CFrame.lookAt(arg3.Position, arg4.Position)
        local v4 = workspace:Raycast(cframe.Position, Vector3.new(0, -10, 0), raycastParams)

        if v4 then
            local Position = v4.Position
            local v5 = v4.Instance
            task.spawn(function() -- line: 36
                -- upvalues:
                --  [1] ReplicatedStorage (ref)
                --  [2] v5 (copy)
                --  [3] cframe (copy)
                --  [4] Position (copy)
                --  [5] arg4 (copy)

                local v6 = ReplicatedStorage.Effects.GroundLines:Clone()
                v6.Name = math.random()
                v6.Color = v5.Color
                v6.Material = v5.Material
                v6.CFrame = cframe * CFrame.new(0, 0, -27)
                v6.Position = Vector3.new(v6.Position.X, Position.Y - 2, v6.Position.Z)
                v6.Parent = workspace.Effects
                local t = {
                    Size = Vector3.new(v6.Size.X + 10, v6.Size.Y, (cframe.p - arg4.p).magnitude - 2),
                    Position = Vector3.new(v6.Position.X, Position.Y + 3, v6.Position.Z)
                }
                _G.Tween(v6, { 0.15, "Linear", Enum.EasingDirection.Out }, t)
                _G.Tween(
                    v6,
                    { 0.25, "Linear", Enum.EasingDirection.Out, nil, 1 },
                    { Transparency = 1 },
                    true
                )
            end)
        end

        local v8 = ReplicatedStorage.Effects.CurvyRing:Clone()
        v8.Anchored = true
        v8.Color = Color3.fromRGB(255, 255, 255)
        v8.Material = Enum.Material.Neon
        v8.Size = Vector3.new(2, 1.5, 2)
        v8.CFrame = arg3 * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0)
        v8.Parent = workspace.Effects
        _G.Tween(
            v8,
            { 0.25, "Quad", Enum.EasingDirection.Out },
            { Size = Vector3.new(22, 0, 22), Transparency = 1 },
            true
        )
        DebrisCircle.RockPath(
            nil,
            12,
            Vector3.new(3, 3, 3),
            3,
            nil,
            arg3,
            arg4
        )
        local v9 = script["LIGHT SPARK"]:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v9, v2)
        v9.CFrame = arg3
        v9.Parent = workspace.Effects
        Effects:EmitParticle(v9, 1)
        Services_m.Debris(v9, 0.75)

        for _ = 1, 10 do
            task.spawn(function() -- line: 82
                -- upvalues:
                --  [1] ReplicatedStorage (ref)
                --  [2] rng (ref)
                --  [3] Magnitude (copy)
                --  [4] arg3 (copy)
                --  [5] v3 (copy)

                local v10 = ReplicatedStorage.Effects.BP:Clone()
                v10.Transparency = 0
                v10.Material = Enum.Material.Neon
                local v11 = rng:NextNumber(0.3, 0.35)
                local v12 = rng:NextNumber(0.3, 0.35)
                v10.Size = Vector3.new(v11, v12, Magnitude / 3.5 + rng:NextInteger(-5, 5))
                local v14 = arg3
                local New = CFrame.new
                local v15 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(-6, -3) or rng:NextInteger(
                    3,
                    6
                )
                v10.CFrame = v14 * New(v15, rng:NextInteger(-1, 3), 0)
                local v16 = v3

                if rng:NextInteger(1, 2) ~= 1 or not v16 then
                    v16 = Color3.fromRGB(0, 0, 0)
                end

                v10.Color = v16
                Instance.new("SpecialMesh", v10).MeshType = "Sphere"
                v10.Parent = workspace.Effects
                local t_2 = { CFrame = nil }
                local Tween_1 = _G.Tween
                local t_3 = { 0.275, "Smooth", Enum.EasingDirection.Out }
                t_2.CFrame = v10.CFrame * CFrame.new(0, 0, -Magnitude)
                Tween_1(v10, t_3, t_2)
                task.wait(0.18181818181818182)
                _G.Tween(
                    v10,
                    { 0.25, "Smoother", Enum.EasingDirection.Out },
                    { Size = Vector3.new(0, 0, 0), Transparency = 1 },
                    true
                )
            end)
        end
    elseif arg1 == "Trail" then
        local _ = CFrame.lookAt((arg3.Position + arg4.Position) / 2, arg4.Position)
        local Magnitude_1 = (arg3.Position - arg4.Position).Magnitude
        local v18 = script.Trail:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v18, v2)
        v18.Size = Vector3.new(2.5, 2.5, Magnitude_1)
        v18.CFrame = CFrame.lookAt(arg3.Position:Lerp(arg4.Position, 0.5), arg4.Position)
        v18.Parent = workspace.Effects
        local t_4 = { Size = Vector3.new(0, 0, 2), CFrame = nil }
        local Tween_2 = _G.Tween
        local t_5 = { 0.35, "Quad", Enum.EasingDirection.Out }
        t_4.CFrame = v18.CFrame * CFrame.new(0, 0, -Magnitude_1 / 2)
        Tween_2(v18, t_5, t_4, true)
        local v21 = ReplicatedStorage.Effects.LightTrail:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v21, v2)
        v21.Size = Vector3.new(3, 3, Magnitude_1)
        v21.CFrame = CFrame.lookAt(arg3.Position:Lerp(arg4.Position, 0.5), arg4.Position)
        v21.Parent = workspace.Effects
        Services_m.Debris(v21, 2)
        Effects:EmitParticle(v21, if Magnitude_1 > 35 then 35 else 25)
        local v25 = script.LightFollowUp:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v25, v2)
        v25.CFrame = arg4
        v25.Parent = workspace.Effects
        Effects:EmitParticle(v25, 12)
        Services_m.Debris(v25, 2)
        local v26 = script.Explosion:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v26, v2)
        v26.CFrame = arg4
        v26.Parent = workspace.Effects
        Effects:EmitParticle(v26, 4, "Ring")
        Effects:EmitParticle(v26, 5, "Twinkle")
        Effects:EmitParticle(v26, 1, nil, "Ring")
        Services_m.Debris(v26, 2)
    end
end

return main
