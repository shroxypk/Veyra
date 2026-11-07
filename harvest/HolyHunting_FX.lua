-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Beast.HolyHunting_FX
-- Class: ModuleScript
-- bytes: 11207

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
local ZenPhysics_m = require(ReplicatedStorage.Modules.Zen_Physics)

local function main(arg4, arg5) -- line: 24
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] CurrentCamera (copy)
    --  [3] Services_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] Effects (copy)
    --  [6] TweenService (copy)
    --  [7] ZenPhysics_m (copy)

    local v3 = if typeof(arg4) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg4,
        "Beast"
    )
    local CreateCloneFor

    if arg4 then
        if (arg4:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
            return
        end

        local PrimaryPart = arg4.PrimaryPart

        if arg5 == 1 then
            Services_m.PlaySound(ReplicatedStorage.SFX.Magic.Beast.HuntingCast, PrimaryPart)
            task.delay(0.7, function() -- line: 36
                -- upvalues:
                --  [1] ReplicatedStorage (ref)
                --  [2] v3 (copy)
                --  [3] GrimoireRarity_m (ref)
                --  [4] PrimaryPart (copy)
                --  [5] Services_m (ref)
                --  [6] Effects (ref)

                local v4 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Hunting_Dissapear:Clone()
                local v5 = v3

                if v5 and typeof(v4) == "Instance" then
                    GrimoireRarity_m:ApplyVariantEffect(v4, v5)

                    if not v4:IsA("BasePart") then
                        GrimoireRarity_m:ApplyVariantEffect(v4, v5, true)
                    end
                end

                v4.CFrame = PrimaryPart.CFrame
                v4.Parent = workspace.Effects
                Services_m.Debris(v4, 2)
                Effects:CleanEmitParticle(v4, 3)
            end)

            return
        end

        if arg5 == 2 then
            local v6 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Rotate_Part:Clone()

            if v3 and typeof(v6) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v6, v3)

                if not v6:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v6, v3, true)
                end
            end

            local Rotor = v6.Rotor
            local children = v6.Clone_Parts:GetChildren()
            v6.Massless = true
            v6.Rotor.Part0 = PrimaryPart
            arg4:GetAttributeChangedSignal("Beast_Hunting"):Once(function() -- line: 56
                -- upvalues:
                --  [1] arg4 (copy)
                --  [2] ReplicatedStorage (ref)
                --  [3] v3 (copy)
                --  [4] GrimoireRarity_m (ref)
                --  [5] PrimaryPart (copy)
                --  [6] Services_m (ref)
                --  [7] Effects (ref)
                --  [8] v6 (copy)
                --  [9] children (copy)
                --  [10] TweenService (ref)

                if arg4:GetAttribute("Beast_Hunting") == false then
                    local v7 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Hunting_Appear:Clone()
                    local v8 = v3

                    if v8 and typeof(v7) == "Instance" then
                        GrimoireRarity_m:ApplyVariantEffect(v7, v8)

                        if not v7:IsA("BasePart") then
                            GrimoireRarity_m:ApplyVariantEffect(v7, v8, true)
                        end
                    end

                    v7.CFrame = PrimaryPart.CFrame
                    v7.Parent = workspace.Effects
                    Services_m.Debris(v7, 2)
                    Effects:CleanEmitParticle(v7, 3)
                    Effects:CleanEmitParticle(v6, 0, false)
                    Effects:BeamSlash(
                        v6,
                        0.2,
                        0.1,
                        -2,
                        0,
                        0,
                        0,
                        0,
                        false
                    )

                    for _, val in ipairs(children) do
                        if val:IsA("Part") then
                            TweenService:Create(
                                val.Inner_Weld,
                                TweenInfo.new(0.25, Enum.EasingStyle.Back),
                                { C0 = CFrame.new(0, 0, 0) }
                            ):Play()
                            Services_m.Debris(val.CLONE_VAL.Value, 0.15)
                        end
                    end

                    Services_m.Debris(v6, 0.25)
                end
            end)

            local function Spin() -- line: 84
                -- upvalues:
                --  [1] Rotor (copy)
                --  [2] TweenService (ref)
                --  [3] Spin (copy)

                if not Rotor.Parent then
                    return
                end

                local v10 = TweenService
                local v11 = Rotor
                local tweenInfo_1 = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
                local v12 = v10:Create(
                    v11,
                    tweenInfo_1,
                    { C0 = Rotor.C0 * CFrame.Angles(0, 360, 0) }
                )
                v12.Completed:Once(Spin)
                v12:Play()
            end

            Spin()

            function CreateCloneFor(_, arg7) -- line: 99
                -- upvalues:
                --  [1] arg4 (copy)
                --  [2] ZenPhysics_m (ref)

                local InnerWeld_1 = arg7.Inner_Weld
                InnerWeld_1:SetAttribute("MainPos", InnerWeld_1.C0)
                InnerWeld_1.C0 = CFrame.new()
                arg4.Archivable = true
                local v13 = arg4:Clone()
                v13.Name = arg4.Name .. "_Cloned"
                v13:SetAttribute("Beast_Hunting", nil)
                local CLONEVAL_ObjectValue = Instance.new("ObjectValue")
                CLONEVAL_ObjectValue.Name = "CLONE_VAL"
                CLONEVAL_ObjectValue.Value = v13
                CLONEVAL_ObjectValue.Parent = arg7

                for _, descendant in v13:GetDescendants() do
                    if not descendant:IsA("Script") then
                        if not descendant:IsA("LocalScript") then
                            if not descendant:IsA("BillboardGui") then
                                if descendant:IsA("Sound") then
                                    descendant:Destroy()
                                elseif descendant:IsA("BasePart") then
                                    descendant.CanCollide = false
                                end
                            else
                                descendant:Destroy()

                                if descendant:IsA("BasePart") then
                                    descendant.CanCollide = false
                                end
                            end
                        else
                            descendant:Destroy()

                            if descendant:IsA("BasePart") then
                                descendant.CanCollide = false
                            end
                        end
                    else
                        descendant:Destroy()

                        if descendant:IsA("BasePart") then
                            descendant.CanCollide = false
                        end
                    end
                end

                ZenPhysics_m.weldPhysics(v13, true, true)
                v13.PrimaryPart = v13.HumanoidRootPart
                v13:PivotTo(arg7.CFrame)
                local WeldConstraint = Instance.new("WeldConstraint")
                WeldConstraint.Part0 = arg7
                WeldConstraint.Part1 = v13.PrimaryPart
                WeldConstraint.Parent = WeldConstraint.Part1
                v13.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                v13.Humanoid.HealthDisplayDistance = 0
                v13.Humanoid.NameDisplayDistance = 0
                local _

                for _, descendant_1 in v13:GetDescendants() do
                    if not descendant_1:IsA("BasePart") then
                        if descendant_1:IsA("Decal") then
                            descendant_1.Transparency = if descendant_1:GetAttribute("Hidden") then 1 else descendant_1:GetAttribute(
                                "OriginalTransparency"
                            ) or descendant_1.Transparency
                        end
                    else
                        descendant_1.Transparency = if descendant_1:GetAttribute("Hidden") then 1 else descendant_1:GetAttribute(
                            "OriginalTransparency"
                        ) or descendant_1.Transparency
                    end
                end

                v13.Parent = workspace.Effects
                task.delay(0.1, function() -- line: 146
                    -- upvalues:
                    --  [1] v13 (copy)

                    for _, descendant_2 in ipairs(v13:GetDescendants()) do
                        if descendant_2:IsA("BasePart") then
                            descendant_2.CanCollide = false
                        end
                    end
                end)
                local v16 = v13.Humanoid.Animator:LoadAnimation(script:WaitForChild("Hunting_2"))
                v16.Priority = Enum.AnimationPriority.Action4
                v16.Looped = true
                v16:Play()

                return InnerWeld_1
            end

            for key_4, val_1 in ipairs(children) do
                if val_1:IsA("Part") then
                    local v17 = CreateCloneFor(key_4, val_1)
                    TweenService:Create(
                        v17,
                        TweenInfo.new(1.5, Enum.EasingStyle.Back),
                        { C0 = v17:GetAttribute("MainPos") }
                    ):Play()
                    Effects:CleanEmitParticle(v6, 0, true)
                end
            end

            v6.Parent = workspace.Effects

            return
        end

        warn("No Args for Hunter Move")

        return
    else
        return
    end
end

return main
