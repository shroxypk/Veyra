-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Wind.Tempest
-- Class: ModuleScript
-- bytes: 2193

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local _ = Services_m.VFX
local _ = ReplicatedStorage.Effects.WindFX.Tempest
local CurrentCamera = workspace.CurrentCamera

function Weld(arg1, arg2, arg3, arg4) -- line: 16
    arg1.Anchored = false
    local Weld = Instance.new("Weld")
    Weld.Part0 = arg2
    Weld.Part1 = arg1
    Weld.C0 = arg3 or CFrame.new()
    Weld.C1 = arg4 or CFrame.new()
    Weld.Parent = arg1

    return Weld
end

local function main(arg5, arg6, arg7, arg8) -- line: 27
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] Services_m (copy)
    --  [4] Utility_m (copy)

    if (CurrentCamera.CFrame.Position - arg7.Position).Magnitude > 300 then
        return
    end

    local v3 = GrimoireRarity_m:GetPlayerVariant(arg6)

    if arg5 == "Charge" then
        Services_m.PlaySound(script.Windup, arg7)
        local v4 = script.Charge:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v4, v3)
        v4.CFrame = arg7 * CFrame.new(0, 1, 0)
        Weld(v4, arg8)
        Services_m.Debris(v4, 3)
        v4.Parent = workspace.Effects
        Utility_m.Toggle(v4, true)
        task.wait(0.3)
        Utility_m.Toggle(v4, false)

        return
    end

    if arg5 == "Dash" then
        Services_m.PlaySound(script.Slashes, arg7)
        local v5 = script.Dash:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v5, v3)
        v5.CFrame = arg7 * CFrame.new(0, 0, -25)
        v5.Parent = workspace.Effects
        Services_m.Debris(v5, 4)
        Utility_m.EmitParticles(v5)

        return
    end

    if arg5 == "Flashstep" then
        local v6 = script.FlashSteps:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v6, v3)
        v6.CFrame = arg7 * CFrame.new(0, -2, 0)
        v6.Parent = workspace.Effects
        Services_m.Debris(v6, 4)
        Utility_m.EmitParticles(v6)
    end
end

return main
