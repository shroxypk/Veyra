-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Beast.PrimalRoar_FX
-- Class: ModuleScript
-- bytes: 3809

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
local Players = game:GetService("Players")
local _ = game:GetService("TweenService")
local _ = workspace.CurrentCamera
local _ = game.Debris
local ReplicatedStorage = Services_m.ReplicatedStorage
local Effects = _G.GetModule("Effects")
local _ = _G.GetModule("DebrisCircle")
local _ = Color3.fromRGB(255, 245, 165)

function Attack(arg4, ...) -- line: 25
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Players (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Effects (copy)

    local v3 = if typeof(arg4) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg4,
        "Beast"
    )
    local t = { ... }
    local _ = arg4:FindFirstChild("HumanoidRootPart")
    local playerFromCharacter = Players:GetPlayerFromCharacter(arg4)

    if t[1] == 1 then
        local PrimaryPart = arg4.PrimaryPart
        local v4 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Roar_Box:Clone()

        if v3 then
            if typeof(v4) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v4, v3)

                if not v4:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v4, v3, true)
                end
            end
        end

        game.Debris:AddItem(v4, 10)
        v4.Weld.Part1 = PrimaryPart
        v4.Name = playerFromCharacter.Name .. "ROAR"
        v4.Parent = arg4

        return
    end

    if t[1] == 3 then
        local v11 = arg4:FindFirstChild(playerFromCharacter.Name .. "ROAR")

        if v11 then
            v11.Name = "Null"
            v11.Parent = workspace.Effects
            Effects:CleanEmitParticle(v11.roarwaves, 5, true)
            Effects:CleanEmitParticle(v11.Start_Floor, 1, true)
            Effects:CleanEmitParticle(v11.End_Floor, 1, false)
            local v17 = pairs

            for _, val in v17(v11:GetChildren()) do
                if val:IsA("ParticleEmitter") then
                    val.Enabled = true
                end
            end

            local _ = true
            task.delay(1.3 / (tonumber(t[2]) or 1), function() -- line: 54
                -- upvalues:
                --  [1] v11 (copy)
                --  [2] Effects (ref)
                --  [3] _ (ref)

                v11.Weld:Destroy()
                v11.Anchored = true
                Effects:CleanEmitParticle(v11.End_Floor, 0, false)
                Effects:CleanEmitParticle(v11.roarwaves, 0, false)
                Effects:CleanEmitParticle(v11.Start_Floor, 0, false)
                Effects:CleanEmitParticle(v11.End_Roar, 10, false)

                for _, child in pairs(v11:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Enabled = false
                    end
                end

                game.Debris:AddItem(v11, 3)
                _ = false
            end)

            return
        end
    else
        warn("No Args for Primal Move")
    end
end

return Attack
