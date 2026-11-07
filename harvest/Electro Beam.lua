-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Lightning.Electro Beam
-- Class: ModuleScript
-- bytes: 1580

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local rng = Random.new()
local _ = require(ReplicatedStorage.Modules.Utility)
local _ = require(ReplicatedStorage.LightningBolt.LightningExplosion)
local Effects = _G.GetModule("Effects")
local _ = _G.GetModule("DebrisCircle")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)

local function Attack(arg1, arg2, arg3, arg4) -- line: 15
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] rng (copy)
    --  [3] Effects (copy)

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg2)
    local v3 = v2 and v2.Primary or Color3.fromRGB(170, 85, 255)

    if arg1 == "FX" then
        for _ = 1, 2 do
            v2 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(2, 3) or rng:NextInteger(-3, -2)
            local v4 = rng:NextInteger(1, 2) == 1 and rng:NextInteger(2, 3) or rng:NextInteger(
                -3,
                -2
            )
            local v5 = arg4 * CFrame.new(v2, rng:NextInteger(4, 7), v4)
            Effects.GenerateLightning(
                arg3,
                v5,
                {
                    Speed = 4.25,
                    Length = rng:NextNumber(0.75, 1),
                    Radius = 3,
                    Color = v3,
                    Unit = 2,
                    Curve = 10,
                    Thickness = rng:NextNumber(1, 2)
                }
            )
            task.wait()
        end
    end
end

return Attack
