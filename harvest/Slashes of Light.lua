-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Light.Slashes of Light
-- Class: ModuleScript
-- bytes: 5842

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = require(ReplicatedStorage.Modules.Utility)
local StateManager_m = require(ReplicatedStorage.Modules.StateManager)
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local rng = Random.new()
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace:FindFirstChild("MapMisc") }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function main(arg1, arg2) -- line: 18
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] StateManager_m (copy)
    --  [3] Services_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] rng (copy)
    --  [6] raycastParams (copy)
    --  [7] Effects (copy)

    if not arg1 or not arg1.PrimaryPart or not arg2 then
        return
    end

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg1)
    local v3

    if not v2 or not v2.Primary then
        v3 = Color3.fromRGB(170, 85, 255)
    end

    v3 = 1
    local v4 = StateManager_m.require(arg1)

    while arg1 do
        if not arg1.Parent then
            break
        end

        if not v4:HasState("UsingBarrage") then
            break
        end

        Services_m.PlaySound(ReplicatedStorage.SFX.Sword.Swing1, arg2)

        for index = 1, 3 do
            local v5 = v3 == 1 and rng:NextInteger(-90, -5) or rng:NextInteger(5, 90)
            local v6 = script.Slash:Clone()
            GrimoireRarity_m:ApplyVariantEffect(v6, v2)
            v6.Parent = workspace.Effects
            local v7 = rng:NextNumber(0.15, 0.225)

            if index == 1 then
                local v9 = arg2.CFrame * CFrame.new(0, 0, -1)
                v6.CFrame = v9 * CFrame.Angles(0, 3.141592653589793, (math.rad(v5)))
                task.spawn(function() -- line: 46
                    -- upvalues:
                    --  [1] v6 (copy)
                    --  [2] v7 (copy)
                    --  [3] rng (ref)

                    local t_1 = { CFrame = nil }
                    local Tween = _G.Tween
                    local v10 = v6
                    local t_2 = { v7, "Quad", Enum.EasingDirection.Out }
                    t_1.CFrame = v6.CFrame * CFrame.new(0, 0, rng:NextInteger(2, 4))
                    Tween(v10, t_2, t_1)
                    _G.Tween(
                        v6.Mesh,
                        { 0.3, "Quad", Enum.EasingDirection.Out },
                        { Scale = v6.Mesh.Scale + Vector3.new(-7, 0, 7) }
                    )
                    task.wait(0.05)
                    _G.Tween(
                        v6.Decal,
                        { v7, "Linear", Enum.EasingDirection.Out },
                        { Transparency = 1 },
                        false,
                        true
                    )
                    v6:Destroy()
                end)
            else
                local v13 = arg2.CFrame * CFrame.new(0, 0, -5)
                v6.CFrame = v13 * CFrame.Angles(
                    1.5707963267948966,
                    math.rad(rng:NextInteger(60, 160) * v3),
                    1.5707963267948966
                )
                v6.Mesh.Scale *= 2
                v6.Decal.Transparency = 0.75
                task.spawn(function() -- line: 57
                    -- upvalues:
                    --  [1] v6 (copy)
                    --  [2] v7 (copy)

                    local t_4 = { CFrame = nil }
                    local Tween_1 = _G.Tween
                    local v14 = v6
                    local t_5 = { v7, "Quad", Enum.EasingDirection.Out }
                    t_4.CFrame = v6.CFrame * CFrame.new(-2, 0, 2)
                    Tween_1(v14, t_5, t_4)
                    _G.Tween(
                        v6.Mesh,
                        { 0.15, "Quad", Enum.EasingDirection.Out },
                        { Scale = v6.Mesh.Scale + Vector3.new(-4, 0, 3) }
                    )
                    _G.Tween(
                        v6.Decal,
                        { v7, "Linear", Enum.EasingDirection.Out },
                        { Transparency = 1 },
                        false,
                        true
                    )
                    v6:Destroy()
                end)
            end

            v6.Attachment.Shine:Emit(1)
            v6.Attachment.Shine2:Emit(1)
            v6.Attachment.Sparks:Emit(3)
            Services_m.TweenService:Create(
                v6.Attachment.PointLight,
                TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { Brightness = 3, Range = 2 }
            ):Play()
            v3 *= -1
        end

        local v16 = workspace:Raycast(arg2.Position, Vector3.new(0, -5, 0), raycastParams)

        if v16 and v16.Instance then
            local Material = v16.Material
            local v17 = v16.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v16.Instance.Color
            local v18 = script.Wind:Clone()
            v18.CFrame = arg2.CFrame * CFrame.new(0, -2, 0)
            v18.Parent = workspace.Effects
            Services_m.Debris(v18, 1)
            Effects:SetParticleColor(v18, v17)
            Effects:EmitParticle(v18, 3)
            local v20 = script.Dust:Clone()
            v20.CFrame = arg2.CFrame * CFrame.new(0, -2.5, -1)
            v20.Parent = workspace.Effects
            Services_m.Debris(v20, 4)
            Effects:SetParticleColor(v20, v17)
            Effects:EmitParticle(v20, 12)
        end

        task.wait(0.15)
    end
end

return main
