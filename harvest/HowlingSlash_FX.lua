-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Beast.HowlingSlash_FX
-- Class: ModuleScript
-- bytes: 4775

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
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera
local Effects = _G.GetModule("Effects")
local _ = _G.GetModule("DebrisCircle")
local _ = Color3.fromRGB(255, 245, 165)

local function main(arg4, arg5, ...) -- line: 25
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] CurrentCamera (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Services_m (copy)
    --  [5] Effects (copy)
    --  [6] TweenService (copy)

    local v3 = if typeof(arg4) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg4,
        "Beast"
    )
    local _, PrimaryPart_1, t, t_1, tweenInfo, _

    if arg4 then
        if (arg4:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
            return
        end

        t = { ... }

        if arg5 == 1 then
            local PrimaryPart = arg4.PrimaryPart
            local v4 = ReplicatedStorage.Effects.MagicFX.Beast_FX.HowlingSlash_None:Clone()

            if v3 and typeof(v4) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v4, v3)

                if not v4:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v4, v3, true)
                end
            end

            PrimaryPart_1 = v4.PrimaryPart
            PrimaryPart_1.CFrame = PrimaryPart.CFrame * CFrame.new(0, -2, 0)
            PrimaryPart_1.Anchored = true
            v4.Parent = workspace.Effects
            Services_m.Debris(v4, 2)
            Effects:CleanEmitParticle(PrimaryPart_1, 5)
            Effects:BeamSlash(
                PrimaryPart_1,
                0.2,
                0.1,
                -2,
                0,
                0,
                0,
                0,
                false
            )

            return
        end

        if arg5 == 3 then
            local v6 = t[2]
            _ = t[3]
            local v8 = t[1]
            local v9 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Howling_Downward:Clone()

            if v3 and typeof(v9) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v9, v3)

                if not v9:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v9, v3, true)
                end
            end

            _ = v6.Magnitude
            local v10 = v8 + v6
            v9.CFrame = CFrame.lookAt(v10, v10 + v6.Unit)
            v9.CFrame = v9.CFrame * CFrame.new(0, 0, -25)
            v9.Parent = workspace.Effects
            Services_m.Debris(v9, 3)
            local v12 = TweenService
            tweenInfo = TweenInfo.new(0.74, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            t_1 = { CFrame = v9.CFrame * CFrame.Angles(0, 0, 3.141592653589793) }
            v12:Create(v9, tweenInfo, t_1):Play()
            Effects:CleanEmitParticle(v9, 5)
            Effects:BeamSlash(
                v9,
                0.2,
                0.1,
                -2,
                0,
                0,
                -1,
                7.5,
                true
            )

            return
        end

        if arg5 == 4 then
            local v14 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Howling_Explosion:Clone()

            if v3 and typeof(v14) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v14, v3)

                if not v14:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v14, v3, true)
                end
            end

            v14.CFrame = t[1].CFrame * CFrame.new(0, -2.8, -4)
            v14.Parent = workspace.Effects
            Effects:CleanEmitParticle(v14, 3)
            Services_m.Debris(v14, 2)

            return
        end

        warn("No Args for Howling Move")

        return
    else
        return
    end
end

return main
