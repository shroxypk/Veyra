-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Beast.ApexClaw_FX
-- Class: ModuleScript
-- bytes: 3286

local GrimoireRarity_m = require(game:GetService("ReplicatedStorage").Modules.GrimoireRarity)

local _ = function(arg1) --[[ __getVariant ]] -- line: 3
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if typeof(arg1) ~= "Instance" then
        return nil
    end

    return GrimoireRarity_m:GetSkillVariant(arg1, "Beast")
end

local _ = function(arg2, arg3) --[[ __tintVariant ]] -- line: 7
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if arg3 then
        if typeof(arg2) ~= "Instance" then
            return
        end

        GrimoireRarity_m:ApplyVariantEffect(arg2, arg3)

        if not arg2:IsA("BasePart") then
            GrimoireRarity_m:ApplyVariantEffect(arg2, arg3, true)
        end

        return
    else
        return
    end
end

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local _ = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera
local Effects = _G.GetModule("Effects")

local function main(arg4, arg5) -- line: 22
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] CurrentCamera (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Effects (copy)
    --  [5] Services_m (copy)

    local v3 = if typeof(arg4) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg4,
        "Beast"
    )
    local PrimaryPart_2

    if arg4 then
        if (arg4:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
            return
        end

        if arg5 == 1 then
            local _ = arg4.PrimaryPart
            task.wait(0.1)
            local v4 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Claw_Hand:Clone()

            if v3 and typeof(v4) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v4, v3)

                if not v4:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v4, v3, true)
                end
            end

            v4.Parent = arg4
            v4.Weld.Part1 = arg4["Right Arm"]
            Effects:CleanEmitParticle(v4, 5, false)
            Services_m.Debris(v4, 0.6)

            return
        end

        if arg5 == 2 then
            local PrimaryPart_1 = arg4.PrimaryPart
            local v5 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Beast_Claw:Clone()

            if v3 and typeof(v5) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v5, v3)

                if not v5:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v5, v3, true)
                end
            end

            PrimaryPart_2 = v5.PrimaryPart
            PrimaryPart_2.CFrame = PrimaryPart_1.CFrame * CFrame.new(-1.5, -2.5, 0)
            PrimaryPart_2.Anchored = true
            v5.Parent = workspace.Effects
            Services_m.Debris(v5, 2)
            Effects:CleanEmitParticle(PrimaryPart_2, 5)
            Effects:BeamSlash(
                PrimaryPart_2,
                0.2,
                0.1,
                -2,
                0,
                0,
                0,
                0,
                false
            )
        end

        return
    else
        return
    end
end

return main
