-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Lightning.Dragon Impact
-- Class: ModuleScript
-- bytes: 4237

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local rng = Random.new()
local Effects = _G.GetModule("Effects")
local DebrisCircle = _G.GetModule("DebrisCircle")
local LightningExplosion_m = require(ReplicatedStorage.LightningBolt.LightningExplosion)
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function Attack(arg1, arg2, arg3) -- line: 22
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] raycastParams (copy)
    --  [5] DebrisCircle (copy)
    --  [6] Utility_m (copy)
    --  [7] LightningExplosion_m (copy)
    --  [8] rng (copy)
    --  [9] Effects (copy)

    if (CurrentCamera.CFrame.Position - arg3.Position).Magnitude > 400 then
        return
    end

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg2)
    local v3 = v2.Primary

    if not v2 or not v3 then
        v3 = Color3.fromRGB(170, 85, 255)
    end

    if arg1 == "Place" then
        local v4 = ReplicatedStorage.Effects.CurvyRing:Clone()
        v4.Anchored = true
        v4.Color = Color3.fromRGB(255, 0, 0)
        v4.Material = Enum.Material.ForceField
        v4.Size = Vector3.new(30, 2, 30)
        v4.CFrame = arg3 * CFrame.fromEulerAnglesXYZ(3.141592653589793, 0, 0)
        v4.Parent = workspace.Effects
        local t = { CFrame = nil, Size = nil, Transparency = 1 }
        local Tween = _G.Tween
        local t_1 = { 0.75, "EntranceExpressive", Enum.EasingDirection.Out }
        t.CFrame = v4.CFrame * CFrame.new(0, -10, 0)
        t.Size = v4.Size + Vector3.new(5, -1, 5)
        Tween(v4, t_1, t, true)

        return
    end

    if arg1 == "Explosion" then
        local v6 = workspace:Raycast(arg3.Position, Vector3.new(0, -10, 0), raycastParams)

        if v6 and v6.Instance then
            local cframe = CFrame.new(v6.Position)
            _G.GetModule("RockParts")(
                cframe,
                8,
                NumberRange.new(2, 5),
                { XZ = 25, Y = 80, Y2 = 100 }
            )
        end

        DebrisCircle.ConnectedCircle(
            nil,
            10,
            4,
            18,
            nil,
            arg3 * CFrame.new(0, 1, 0)
        )
        local v7 = GrimoireRarity_m:GetPlayerVariant(arg2)
        local v8 = script.Explosion:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v8, v7)
        v8.Position = arg3.Position
        v8.Parent = workspace.Effects
        Utility_m.EmitParticles(v8)
        LightningExplosion_m.new(
            arg3.Position,
            1.25,
            4,
            v3,
            v3
        )

        for index = 1, 3 do
            local v9 = index / 2 * 22
            task.spawn(function() -- line: 74
                -- upvalues:
                --  [1] rng (ref)
                --  [2] v9 (copy)
                --  [3] arg3 (copy)
                --  [4] Effects (ref)
                --  [5] v3 (copy)

                for _ = 1, 4 do
                    local v11 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(v9 / 1.5, v9) or rng:NextInteger(
                        -v9,
                        -v9 / 1.5
                    )
                    local v15 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(v9 / 1.5, v9) or rng:NextInteger(
                        -v9,
                        -v9 / 1.5
                    )
                    Effects:Lightning3(
                        (arg3 * CFrame.new(0, rng:NextInteger(-2, 2), 0)).p,
                        (arg3 * CFrame.new(v11, rng:NextInteger(10, 18), v15)).p,
                        10,
                        { Min = 0.25, Max = 1.45 },
                        v3
                    )
                    task.wait()
                end
            end)
            task.wait(0.05)
        end
    end
end

return Attack
