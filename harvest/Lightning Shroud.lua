-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Lightning.Lightning Shroud
-- Class: ModuleScript
-- bytes: 3153

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local rng = Random.new()
local Effects = _G.GetModule("Effects")
local _ = _G.GetModule("DebrisCircle")
local _ = require(ReplicatedStorage.LightningBolt.LightningExplosion)
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(arg1, arg2, arg3) -- line: 19
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] rng (copy)
    --  [4] Effects (copy)
    --  [5] raycastParams (copy)

    if not arg3 then
        return
    end

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg2.Character)
    local v3 = v2.Primary

    if not v2 or not v3 then
        v3 = Color3.fromRGB(170, 85, 255)
    end

    if arg1 == "Transform" then
        local v4 = arg3.CFrame
        local v5 = ReplicatedStorage.SFX.Effects.LightningStrike:Clone()
        v5.PlayOnRemove = true
        v5.Volume = 0.4
        v5.PlaybackSpeed = 1
        v5.TimePosition = 0.808
        v5.Parent = arg3
        v5:Destroy()
        task.spawn(function() -- line: 39
            -- upvalues:
            --  [1] rng (ref)
            --  [2] arg3 (copy)
            --  [3] v3 (copy)
            --  [4] Effects (ref)

            for index = 1, 2 do
                local v6 = if index == 1 then -2 else 2
                local v7 = v6 < 0 and rng:NextInteger(-4, -2) or rng:NextInteger(2, 4)
                local v9 = arg3.CFrame * CFrame.new(v6, -3, rng:NextInteger(-4, 4))
                local v10 = v9 * CFrame.new(v7, rng:NextInteger(7, 8), v7)
                Effects.GenerateLightning(
                    v9,
                    v10,
                    { Speed = 2.5, Length = 0.5, Radius = 1, Color = v3, Unit = 2, Curve = 15 }
                )
            end
        end)
        local v11 = workspace:Raycast(v4.Position, Vector3.new(0, -10, 0), raycastParams)

        if v11 then
            Effects:CreateSmokeCloud(
                CFrame.new(v11.Position),
                v11.Instance.Color,
                Vector3.new(10, 6, 10),
                NumberSequence.new(5),
                10
            )
            local v13 = ReplicatedStorage.Effects.CurvyRing:Clone()
            v13.Anchored = true
            v13.Color = v3
            v13.Material = Enum.Material.ForceField
            v13.Size = Vector3.new(10, 1, 10)
            v13.CFrame = v4 * CFrame.fromEulerAnglesXYZ(3.141592653589793, 0, 0) * CFrame.new(
                0,
                1,
                0
            )
            v13.Parent = workspace.Effects
            local t = { CFrame = nil, Transparency = 1 }
            local Tween = _G.Tween
            local t_1 = { 0.75, "EntranceExpressive", Enum.EasingDirection.Out }
            t.CFrame = v13.CFrame * CFrame.new(0, -8, 0)
            Tween(v13, t_1, t, true)
        end
    end
end

return Attack
