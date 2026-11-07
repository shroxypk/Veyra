-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Beast.FeralImpact_FX
-- Class: ModuleScript
-- bytes: 4099

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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("TweenService")
local _ = workspace.CurrentCamera
local _ = Random.new()
local Effects = _G.GetModule("Effects")
local _ = _G.GetModule("DebrisCircle")
local _ = Color3.fromRGB(255, 245, 165)

local function main(arg4, arg5, arg6) -- line: 27
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Services_m (copy)
    --  [4] Effects (copy)

    local v3 = if typeof(arg5) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg5,
        "Beast"
    )
    local v4 = arg5

    if v4 then
        v4 = arg5.PrimaryPart
    end

    if not v4 or (v4.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    if arg4 == "Teleport" then
        local v5 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Beast_Teleport:Clone()

        if v3 and typeof(v5) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v5, v3)

            if not v5:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v5, v3, true)
            end
        end

        v5.CFrame = arg6
        v5.Parent = workspace.Effects
        Services_m.Debris(v5, 2)
        Effects:CleanEmitParticle(v5, 3)

        return
    end

    if arg4 == "Appear" then
        local v6 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Hunting_Appear:Clone()

        if v3 and typeof(v6) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v6, v3)

            if not v6:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v6, v3, true)
            end
        end

        v6.CFrame = arg6
        v6.Parent = workspace.Effects
        Services_m.Debris(v6, 2)
        Effects:CleanEmitParticle(v6, 3)

        return
    end

    if arg4 == "Windup" then
        local v7 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Hunting_Appear:Clone()

        if v3 and typeof(v7) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v7, v3)

            if not v7:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v7, v3, true)
            end
        end

        v7.Anchored = false
        v7:PivotTo(v4.CFrame)
        local WeldConstraint = Instance.new("WeldConstraint")
        WeldConstraint.Part0 = v7
        WeldConstraint.Part1 = v4
        WeldConstraint.Parent = v7
        v7.Parent = workspace.Effects
        Services_m.Debris(v7, 2)
        Effects:CleanEmitParticle(v7, 3)

        return
    end

    if arg4 == "Kick" then
        local v8 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Feral_Kick_FX:Clone()

        if v3 and typeof(v8) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v8, v3)

            if not v8:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v8, v3, true)
            end
        end

        v8.CFrame = v4.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
        v8.Parent = workspace.Effects
        Effects:CleanEmitParticle(v8, 2, false)
        Services_m.Debris(v8, 3)
        v8.WELD.Part0 = v4

        return
    end

    if arg4 == "Impact" then
    end
end

return main
