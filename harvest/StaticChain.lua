-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.StaticChain
-- Class: ModuleScript
-- bytes: 3372

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local VFX = Services_m.VFX
local g_require_1 = require
local CurrentCamera = workspace.CurrentCamera
local v2 = g_require_1(ReplicatedStorage.Modules:FindFirstChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(
    arg1
) -- line: 9
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v2:Start()
local rng = Random.new()
local Effects = _G.GetModule("Effects")
local _ = _G.GetModule("DebrisCircle")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include
local _ = require(ReplicatedStorage.LightningBolt.LightningExplosion)
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local color = Color3.fromRGB(110, 153, 202)
local t = {}

for _, child in pairs(script.util:GetChildren()) do
    t[child.Name] = child.Value
end

function Attack(arg2, ...) -- line: 32
    -- upvalues:
    --  [1] t (copy)
    --  [2] Effects (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] rng (copy)
    --  [5] color (copy)
    --  [6] GrimoireRarity_m (copy)
    --  [7] VFX (copy)
    --  [8] v2 (copy)

    local v4, v5, v6 = ...

    if (v4.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    if arg2 == "FX" then
        local Position = v5.Position
        local v7 = t
        local Position_1 = v4.Position

        if v6 and v6.Primary then
            v7 = table.clone(t)
            v7.Color = v6.Primary
        end

        Effects.GenerateLightning(v4, v5, v7)
        _G.PlaySound(
            ReplicatedStorage.SFX.Effects.LightningStatic,
            Position_1,
            nil,
            1,
            nil,
            nil
        )

        for _ = 1, 3 do
            for _ = 1, 3 do
                v7 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(1.3333333333333333, 2) or rng:NextInteger(
                    -2,
                    -1.3333333333333333
                )
                local v8 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(1.3333333333333333, 2) or rng:NextInteger(
                    -2,
                    -1.3333333333333333
                )
                Effects:Lightning2(
                    (v4 * CFrame.new(v7, 0, v8)).Position,
                    Position,
                    rng:NextInteger(3, 5),
                    { Min = 0.5, Max = 0.75 }
                )
                task.wait()
            end

            task.wait(0.05)
        end

        task.wait(0.15)
        local v11 = v6 and v6.Primary or color
        Effects.AddLight(v5, v11, 9, 4)
        local v12 = script.LightningExplosion1:Clone()
        _G.Debris(v12, 4)
        GrimoireRarity_m:ApplyVariantEffect(v12, v6)
        v12:PivotTo(v5 * CFrame.new(0, -2, 0))
        v12.Parent = workspace.Effects
        VFX.Emit2(v12, true)

        if (v4.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 100 then
            v2:ShakeOnce(4, 4, 0, 0.2)
        end

        _G.PlaySound(
            ReplicatedStorage.SFX.Effects.Thunder_Explosion,
            v4,
            200,
            0.85,
            1,
            nil
        )
    end
end

return Attack
