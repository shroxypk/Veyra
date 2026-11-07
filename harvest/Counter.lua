-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Counter
-- Class: ModuleScript
-- bytes: 29868

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local _ = game:GetService("ServerScriptService")
local GameModules = ServerStorage.GameModules
local StateManager_m = require(ReplicatedStorage.Modules.StateManager)
local DisableAnimations_m = require(script.Parent.DisableAnimations)
local ManaGain_m = require(script.Parent.ManaGain)
local AirCombat_m = require(GameModules.AirCombat)
local PlayerStats_m = require(GameModules.PlayerStats)
local CombatProfessionXP_m = require(GameModules.CombatProfessionXP)

local _ = function(arg1) --[[ getBlade ]] -- line: 27
    local Welds = arg1:FindFirstChild("Welds")

    if not Welds then
        return
    end

    for _, val in Welds:QueryDescendants("#Blade") do
        return val
    end
end

local rng = Random.new()

local function parryVisual(arg2, arg3) -- line: 36
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] rng (copy)

    local Humanoid = arg2:FindFirstChild("Humanoid")
    local PrimaryPart = arg2.PrimaryPart
    local ParryCounter = arg2.States.ParryCounter
    local PrimaryPart_1 = arg3.PrimaryPart
    local v3 = Humanoid.Animator:LoadAnimation(
        ReplicatedStorage.Animations.Misc[if ParryCounter.Value == 1 then "ParryRight" else "ParryLeft"]
    )
    v3.Priority = Enum.AnimationPriority.Action2
    v3:Play()
    ParryCounter.Value = if ParryCounter.Value == 1 then 2 else 1
    local v5 = ReplicatedStorage.SFX.Sword.Parry1:Clone()
    v5.PlayOnRemove = true
    v5.PlaybackSpeed = rng:NextNumber(0.9, 1.1)
    v5.Parent = PrimaryPart_1
    v5:Destroy()
    local Welds_1 = arg2:FindFirstChild("Welds")

    if not Welds_1 then
        v5 = nil
    else
        for _, val_1 in Welds_1:QueryDescendants("#Blade") do
            v5 = val_1
        end

        v5 = nil
    end

    local v6 = v5 or PrimaryPart.CFrame * CFrame.new(0, 0, -1)
    ReplicatedStorage.Remotes.Sword:FireAllClients("Parry", arg2, v6)
end

local _ = function(arg4) --[[ emitParticles ]] -- line: 61
    task.delay(0.01, function() -- line: 62
        -- upvalues:
        --  [1] arg4 (copy)

        for _, val_2 in arg4:QueryDescendants("ParticleEmitter") do
            local EmitDelay = val_2:GetAttribute("EmitDelay")

            if EmitDelay then
                task.delay(EmitDelay, function() -- line: 66
                    -- upvalues:
                    --  [1] val_2 (copy)

                    val_2:Emit(val_2:GetAttribute("EmitCount"))
                end)
            else
                val_2:Emit(val_2:GetAttribute("EmitCount"))
            end
        end
    end)
end

local _ = function(arg5, arg6, arg7) --[[ Weld ]] -- line: 76
    local Weld = Instance.new("Weld")
    Weld.Name = arg5.Name .. "Weld"
    Weld.Part0 = arg5
    Weld.Part1 = arg6
    Weld.C0 = arg7
    Weld.Parent = arg6
end

local function counterFunc(arg8, arg9, arg10, arg11) -- line: 85
    -- upvalues:
    --  [1] StateManager_m (copy)
    --  [2] Players (copy)
    --  [3] Services_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] ManaGain_m (copy)
    --  [6] AirCombat_m (copy)
    --  [7] PlayerStats_m (copy)
    --  [8] CombatProfessionXP_m (copy)
    --  [9] DisableAnimations_m (copy)
    --  [10] parryVisual (copy)

    local v8 = math.round(arg10.Damage or 0)
    local v9 = arg10.Weight or math.random(2, 5)
    local Parry = arg10.Parry
    local DisableAPF = arg10.DisableAPF
    local v10 = arg10.APF_TIME or 0.5
    local v11 = arg9:HasTag("NonHumanoid")
    local _ = nil
    local _ = nil
    local v14 = StateManager_m.require(arg8)
    local v15 = StateManager_m.require(arg9)
    local playerFromCharacter = Players:GetPlayerFromCharacter(arg8)
    local Humanoid_1 = arg8:FindFirstChild("Humanoid")
    local _ = arg8.PrimaryPart
    local playerFromCharacter_1 = Players:GetPlayerFromCharacter(arg9)
    local Humanoid_2 = arg9:FindFirstChild("Humanoid")
    local PrimaryPart_3 = arg9.PrimaryPart
    local States = arg8:FindFirstChild("States")
    local States_1 = arg9:FindFirstChild("States")

    if not States_1 then
        return
    end

    local v16 = playerFromCharacter and States.Resolve
    local v17 = playerFromCharacter and States.MaxResolve.Value
    local Resolve = States_1.Resolve
    local Value = States_1.MaxResolve.Value
    local v18 = States_1.ParryCounter
    v18 = false

    if playerFromCharacter then
        if Humanoid_2:GetAttribute("InSafezone") then
            v18 = true
        elseif playerFromCharacter_1 and Humanoid_1:GetAttribute("InSafezone") then
            v18 = true
        end
    elseif playerFromCharacter_1 and Humanoid_1:GetAttribute("InSafezone") then
        v18 = true
    end

    if v18 then
        return true
    end

    if playerFromCharacter then
        _G.IncreaseSpiritMeter(playerFromCharacter, v9)
    end

    if arg9:HasTag("PostureBreak") then
        Resolve.Value += v9
    elseif arg9:HasTag("HasBlockBreak") then
        Resolve.Value += v8
    end

    local v19

    if arg9:FindFirstChild("Arcane Rebound") then
        v19 = true
    end

    local v20

    if arg9:FindFirstChild("Sixth Sense") and not v15:HasState("SixthSenseCooldown") and playerFromCharacter_1 and not playerFromCharacter_1:GetAttribute(
        "InCombat"
    ) then
        v15:AddState("SixthSenseCooldown", 120)
        v20 = true
    end

    if v15:HasState("en garde") then
        v15:RemoveState("en garde")
        v14:AddState("Stunned", 0.175)
        Services_m.PlaySound(ReplicatedStorage.SFX.Skills.EnGardeProc, PrimaryPart_3)
        local v21 = ReplicatedStorage.Effects.Skills.EnGardeVFX:Clone()
        v21.CFrame = PrimaryPart_3.CFrame
        v21.Parent = workspace.Effects
        local cframe = CFrame.new(0, 0, 0)
        local Weld_2 = Instance.new("Weld")
        Weld_2.Name = PrimaryPart_3.Name .. "Weld"
        Weld_2.Part0 = PrimaryPart_3
        Weld_2.Part1 = v21
        Weld_2.C0 = cframe
        Weld_2.Parent = v21
        Services_m.Debris(v21, 2)
        task.delay(0.01, function() -- line: 62
            -- upvalues:
            --  [1] v21 (copy)

            for _, val_3 in v21:QueryDescendants("ParticleEmitter") do
                local EmitDelay_1 = val_3:GetAttribute("EmitDelay")

                if EmitDelay_1 then
                    task.delay(EmitDelay_1, function() -- line: 66
                        -- upvalues:
                        --  [1] val_3 (copy)

                        val_3:Emit(val_3:GetAttribute("EmitCount"))
                    end)
                else
                    val_3:Emit(val_3:GetAttribute("EmitCount"))
                end
            end
        end)
        v15:AddState("enGardeResistance", 6)

        return true
    end

    local Parry_Util
    local v24, v25

    if not v20 then
        if arg11 then
            if v15:HasState(`Negate {arg11}`) then
                if v20 then
                    _G.AddCombatTag(arg8, 40, playerFromCharacter_1)
                    v24 = Humanoid_2.Animator:LoadAnimation(
                        ReplicatedStorage.Animations.Misc.BackDodge
                    )
                    v24.Priority = Enum.AnimationPriority.Action2
                    v24:Play()
                end

                Services_m.PlaySound(
                    ReplicatedStorage.SFX.Misc.DodgeEvade,
                    PrimaryPart_3,
                    nil,
                    nil,
                    nil,
                    0.05
                )
                ReplicatedStorage.Remotes.Client.ClientVFX:FireAllClients(
                    "BodyClone",
                    arg9,
                    "Dodge"
                )
                v15:AddState("ParrySpeed", 0.25)
                v15:RemoveState("Stunned")
                v25 = script.DodgeEffect:Clone()
                _G.Debris(v25, 1)
                v25.CFrame = PrimaryPart_3.CFrame
                v25.Parent = workspace.Effects
                task.delay(0.01, function() -- line: 62
                    -- upvalues:
                    --  [1] v25 (copy)

                    for _, val_4 in v25:QueryDescendants("ParticleEmitter") do
                        local EmitDelay_2 = val_4:GetAttribute("EmitDelay")

                        if EmitDelay_2 then
                            task.delay(EmitDelay_2, function() -- line: 66
                                -- upvalues:
                                --  [1] val_4 (copy)

                                val_4:Emit(val_4:GetAttribute("EmitCount"))
                            end)
                        else
                            val_4:Emit(val_4:GetAttribute("EmitCount"))
                        end
                    end
                end)

                return true
            end
        end

        function Parry_Util() -- line: 203
            -- upvalues:
            --  [1] v19 (ref)
            --  [2] ManaGain_m (ref)
            --  [3] arg9 (copy)
            --  [4] Parry (copy)
            --  [5] arg8 (copy)
            --  [6] v14 (copy)
            --  [7] States (copy)
            --  [8] v9 (copy)
            --  [9] AirCombat_m (ref)

            if v19 then
                ManaGain_m(arg9, 0.03)
            end

            if Parry then
                local v27

                if arg8:HasTag("PostureBreak") then
                    if v14:HasState("NegatePosture") then
                        if arg8:GetAttribute("AutoParry") then
                            v14:AddState("NegatePosture", 0.1)
                            v27 = States

                            if v27 then
                                v27 = States:FindFirstChild("Resolve")
                            end

                            if v27 then
                                v27.Value += v9
                            end
                        end
                    else
                        v14:AddState("NegatePosture", 0.1)
                        v27 = States

                        if v27 then
                            v27 = States:FindFirstChild("Resolve")
                        end

                        if v27 then
                            v27.Value += v9
                        end
                    end
                elseif arg8:GetAttribute("AutoParry") then
                    v14:AddState("NegatePosture", 0.1)
                    v27 = States

                    if v27 then
                        v27 = States:FindFirstChild("Resolve")
                    end

                    if v27 then
                        v27.Value += v9
                    end
                end
            end

            AirCombat_m:RemoveAerialHold(arg8)
            AirCombat_m:RemoveAerialHold(arg9)
        end

        local v31, v32, v39

        if v15:IsParrying() then
            local _ = v15:IsParrying()

            if not Parry then
                if arg9:GetAttribute("AutoParry") then
                    if arg11 then
                        v15:AddState(`NegateSword {arg11}`, 3)
                    end

                    if not v15:HasState("APF") and not DisableAPF then
                        v15:AddState("APF", v10)
                    end

                    v15:AddState("ParriedAttack", 0.25)
                    v15:RemoveState("Parrying")
                    v15:RemoveState("Dodging")

                    if playerFromCharacter_1 then
                        PlayerStats_m:AddXP(
                            playerFromCharacter_1,
                            "Mastery",
                            math.clamp(Humanoid_1.MaxHealth / 100, 1, 8) + math.random(1, 3)
                        )
                        task.spawn(
                            CombatProfessionXP_m.Grant,
                            CombatProfessionXP_m,
                            playerFromCharacter_1,
                            arg8
                        )
                        Resolve.Value = math.clamp(Resolve.Value - v9 / 2, 0, Value - 1)

                        if v16 then
                            v16.Value = math.clamp(v16.Value + v9, 0, v17 - 1)
                        end
                    else
                        Resolve.Value = math.clamp(Resolve.Value + v9, 0, Value - 1)

                        if v16 then
                            v16.Value = math.clamp(v16.Value + v9, 0, v17 - 1)
                        end
                    end

                    DisableAnimations_m:DisableAnimation(Humanoid_2, "Dodge")
                    DisableAnimations_m:DisableAnimation(Humanoid_2, "Parry")
                    v31 = DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1)
                    DisableAnimations_m:DisableParriedAttacks(Humanoid_1)
                    parryVisual(arg9, arg8)
                    v15:RemoveState("Stunned")
                    v15:RemoveState("ParryCooldown")
                    v15:RemoveState("ParryRecovery")
                    v15:AddState("ParrySpeed", 0.25)

                    if not v31 then
                        if v11 then
                            v14:AddState("Parried")
                            v14:AddState("Parried", 0.35)
                        else
                            v14:AddState("Parried")
                            v32 = Humanoid_1.Animator:LoadAnimation(
                                ReplicatedStorage.Animations.Hit.Parried
                            )
                            v32.Priority = Enum.AnimationPriority.Action2
                            v32:Play()
                            v32:AdjustSpeed(0.95)
                            v32.Stopped:Once(function() -- line: 287
                                -- upvalues:
                                --  [1] v14 (copy)

                                v14:AddState("Parried", 0.3)
                            end)
                        end
                    end

                    Parry_Util()

                    return "parried"
                end

                if v15:IsDodging() then
                    local _ = v15:IsDodging()

                    if arg11 then
                        v15:AddState("Negate " .. arg11, 3)
                    end

                    if ReplicatedStorage:FindFirstChild("Tutorial") then
                        v15:AddState("TutorialDodge", 0.1)
                    end

                    v15:AddState("ParrySpeed", 0.25)
                    v15:RemoveState("Stunned")
                    Services_m.PlaySound(
                        ReplicatedStorage.SFX.Misc.DodgeEvade,
                        PrimaryPart_3,
                        nil,
                        nil,
                        nil,
                        0.05
                    )
                    ReplicatedStorage.Remotes.Client.ClientVFX:FireAllClients(
                        "BodyClone",
                        arg9,
                        "Dodge"
                    )
                    local v35 = script.DodgeEffect:Clone()
                    v35.CFrame = PrimaryPart_3.CFrame
                    v35.Parent = workspace.Effects
                    Services_m.Debris(v35, 1)
                    task.delay(0.01, function() -- line: 62
                        -- upvalues:
                        --  [1] v35 (copy)

                        for _, val_5 in v35:QueryDescendants("ParticleEmitter") do
                            local EmitDelay_3 = val_5:GetAttribute("EmitDelay")

                            if EmitDelay_3 then
                                task.delay(EmitDelay_3, function() -- line: 66
                                    -- upvalues:
                                    --  [1] val_5 (copy)

                                    val_5:Emit(val_5:GetAttribute("EmitCount"))
                                end)
                            else
                                val_5:Emit(val_5:GetAttribute("EmitCount"))
                            end
                        end
                    end)
                    Parry_Util()
                    task.spawn(
                        CombatProfessionXP_m.Grant,
                        CombatProfessionXP_m,
                        playerFromCharacter_1,
                        arg8
                    )

                    return "rolled"
                end

                local _ = v15:IsDodging()

                if arg11 then
                    if not v15:HasState(`NegateSword {arg11}`) then
                        if v15:HasState("APF") then
                            parryVisual(arg9, arg8)

                            if not v11 and not DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1) then
                                v39 = Humanoid_1.Animator:LoadAnimation(
                                    ReplicatedStorage.Animations.Hit.Parried
                                )
                                v39.Priority = Enum.AnimationPriority.Action3
                                v39:Play()
                                v39:AdjustSpeed(0.95)
                            end

                            return true
                        end

                        return
                    else
                        parryVisual(arg9, arg8)

                        if not v11 and not DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1) then
                            v39 = Humanoid_1.Animator:LoadAnimation(
                                ReplicatedStorage.Animations.Hit.Parried
                            )
                            v39.Priority = Enum.AnimationPriority.Action3
                            v39:Play()
                            v39:AdjustSpeed(0.95)
                        end

                        return true
                    end
                else
                    if v15:HasState("APF") then
                        parryVisual(arg9, arg8)

                        if not v11 and not DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1) then
                            v39 = Humanoid_1.Animator:LoadAnimation(
                                ReplicatedStorage.Animations.Hit.Parried
                            )
                            v39.Priority = Enum.AnimationPriority.Action3
                            v39:Play()
                            v39:AdjustSpeed(0.95)
                        end

                        return true
                    end

                    return
                end
            else
                if arg11 then
                    v15:AddState(`NegateSword {arg11}`, 3)
                end

                if not v15:HasState("APF") and not DisableAPF then
                    v15:AddState("APF", v10)
                end

                v15:AddState("ParriedAttack", 0.25)
                v15:RemoveState("Parrying")
                v15:RemoveState("Dodging")

                if playerFromCharacter_1 then
                    PlayerStats_m:AddXP(
                        playerFromCharacter_1,
                        "Mastery",
                        math.clamp(Humanoid_1.MaxHealth / 100, 1, 8) + math.random(1, 3)
                    )
                    task.spawn(
                        CombatProfessionXP_m.Grant,
                        CombatProfessionXP_m,
                        playerFromCharacter_1,
                        arg8
                    )
                    Resolve.Value = math.clamp(Resolve.Value - v9 / 2, 0, Value - 1)

                    if v16 then
                        v16.Value = math.clamp(v16.Value + v9, 0, v17 - 1)
                    end
                else
                    Resolve.Value = math.clamp(Resolve.Value + v9, 0, Value - 1)

                    if v16 then
                        v16.Value = math.clamp(v16.Value + v9, 0, v17 - 1)
                    end
                end

                DisableAnimations_m:DisableAnimation(Humanoid_2, "Dodge")
                DisableAnimations_m:DisableAnimation(Humanoid_2, "Parry")
                v31 = DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1)
                DisableAnimations_m:DisableParriedAttacks(Humanoid_1)
                parryVisual(arg9, arg8)
                v15:RemoveState("Stunned")
                v15:RemoveState("ParryCooldown")
                v15:RemoveState("ParryRecovery")
                v15:AddState("ParrySpeed", 0.25)

                if not v31 then
                    if v11 then
                        v14:AddState("Parried")
                        v14:AddState("Parried", 0.35)
                    else
                        v14:AddState("Parried")
                        v32 = Humanoid_1.Animator:LoadAnimation(
                            ReplicatedStorage.Animations.Hit.Parried
                        )
                        v32.Priority = Enum.AnimationPriority.Action2
                        v32:Play()
                        v32:AdjustSpeed(0.95)
                        v32.Stopped:Once(function() -- line: 287
                            -- upvalues:
                            --  [1] v14 (copy)

                            v14:AddState("Parried", 0.3)
                        end)
                    end
                end

                Parry_Util()

                return "parried"
            end
        else
            if arg9:GetAttribute("AutoParry") then
                local _ = v15:IsParrying()

                if arg11 then
                    v15:AddState(`NegateSword {arg11}`, 3)
                end

                if not v15:HasState("APF") and not DisableAPF then
                    v15:AddState("APF", v10)
                end

                v15:AddState("ParriedAttack", 0.25)
                v15:RemoveState("Parrying")
                v15:RemoveState("Dodging")

                if playerFromCharacter_1 then
                    PlayerStats_m:AddXP(
                        playerFromCharacter_1,
                        "Mastery",
                        math.clamp(Humanoid_1.MaxHealth / 100, 1, 8) + math.random(1, 3)
                    )
                    task.spawn(
                        CombatProfessionXP_m.Grant,
                        CombatProfessionXP_m,
                        playerFromCharacter_1,
                        arg8
                    )
                    Resolve.Value = math.clamp(Resolve.Value - v9 / 2, 0, Value - 1)

                    if v16 then
                        v16.Value = math.clamp(v16.Value + v9, 0, v17 - 1)
                    end
                else
                    Resolve.Value = math.clamp(Resolve.Value + v9, 0, Value - 1)

                    if v16 then
                        v16.Value = math.clamp(v16.Value + v9, 0, v17 - 1)
                    end
                end

                DisableAnimations_m:DisableAnimation(Humanoid_2, "Dodge")
                DisableAnimations_m:DisableAnimation(Humanoid_2, "Parry")
                v31 = DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1)
                DisableAnimations_m:DisableParriedAttacks(Humanoid_1)
                parryVisual(arg9, arg8)
                v15:RemoveState("Stunned")
                v15:RemoveState("ParryCooldown")
                v15:RemoveState("ParryRecovery")
                v15:AddState("ParrySpeed", 0.25)

                if not v31 then
                    if v11 then
                        v14:AddState("Parried")
                        v14:AddState("Parried", 0.35)
                    else
                        v14:AddState("Parried")
                        v32 = Humanoid_1.Animator:LoadAnimation(
                            ReplicatedStorage.Animations.Hit.Parried
                        )
                        v32.Priority = Enum.AnimationPriority.Action2
                        v32:Play()
                        v32:AdjustSpeed(0.95)
                        v32.Stopped:Once(function() -- line: 287
                            -- upvalues:
                            --  [1] v14 (copy)

                            v14:AddState("Parried", 0.3)
                        end)
                    end
                end

                Parry_Util()

                return "parried"
            end

            if v15:IsDodging() then
                local _ = v15:IsDodging()

                if arg11 then
                    v15:AddState("Negate " .. arg11, 3)
                end

                if ReplicatedStorage:FindFirstChild("Tutorial") then
                    v15:AddState("TutorialDodge", 0.1)
                end

                v15:AddState("ParrySpeed", 0.25)
                v15:RemoveState("Stunned")
                Services_m.PlaySound(
                    ReplicatedStorage.SFX.Misc.DodgeEvade,
                    PrimaryPart_3,
                    nil,
                    nil,
                    nil,
                    0.05
                )
                ReplicatedStorage.Remotes.Client.ClientVFX:FireAllClients(
                    "BodyClone",
                    arg9,
                    "Dodge"
                )
                local v46 = script.DodgeEffect:Clone()
                v46.CFrame = PrimaryPart_3.CFrame
                v46.Parent = workspace.Effects
                Services_m.Debris(v46, 1)
                task.delay(0.01, function() -- line: 62
                    -- upvalues:
                    --  [1] v46 (copy)

                    for _, val_7 in v46:QueryDescendants("ParticleEmitter") do
                        local EmitDelay_5 = val_7:GetAttribute("EmitDelay")

                        if EmitDelay_5 then
                            task.delay(EmitDelay_5, function() -- line: 66
                                -- upvalues:
                                --  [1] val_7 (copy)

                                val_7:Emit(val_7:GetAttribute("EmitCount"))
                            end)
                        else
                            val_7:Emit(val_7:GetAttribute("EmitCount"))
                        end
                    end
                end)
                Parry_Util()
                task.spawn(
                    CombatProfessionXP_m.Grant,
                    CombatProfessionXP_m,
                    playerFromCharacter_1,
                    arg8
                )

                return "rolled"
            end

            local _ = v15:IsDodging()

            if arg11 then
                if not v15:HasState(`NegateSword {arg11}`) then
                    if v15:HasState("APF") then
                        parryVisual(arg9, arg8)

                        if not v11 and not DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1) then
                            v39 = Humanoid_1.Animator:LoadAnimation(
                                ReplicatedStorage.Animations.Hit.Parried
                            )
                            v39.Priority = Enum.AnimationPriority.Action3
                            v39:Play()
                            v39:AdjustSpeed(0.95)
                        end

                        return true
                    end

                    return
                else
                    parryVisual(arg9, arg8)

                    if not v11 and not DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1) then
                        v39 = Humanoid_1.Animator:LoadAnimation(
                            ReplicatedStorage.Animations.Hit.Parried
                        )
                        v39.Priority = Enum.AnimationPriority.Action3
                        v39:Play()
                        v39:AdjustSpeed(0.95)
                    end

                    return true
                end
            else
                if v15:HasState("APF") then
                    parryVisual(arg9, arg8)

                    if not v11 and not DisableAnimations_m:IsSkillKeptOnParry(Humanoid_1) then
                        v39 = Humanoid_1.Animator:LoadAnimation(
                            ReplicatedStorage.Animations.Hit.Parried
                        )
                        v39.Priority = Enum.AnimationPriority.Action3
                        v39:Play()
                        v39:AdjustSpeed(0.95)
                    end

                    return true
                end

                return
            end
        end
    else
        if v20 then
            _G.AddCombatTag(arg8, 40, playerFromCharacter_1)
            v24 = Humanoid_2.Animator:LoadAnimation(ReplicatedStorage.Animations.Misc.BackDodge)
            v24.Priority = Enum.AnimationPriority.Action2
            v24:Play()
        end

        Services_m.PlaySound(
            ReplicatedStorage.SFX.Misc.DodgeEvade,
            PrimaryPart_3,
            nil,
            nil,
            nil,
            0.05
        )
        ReplicatedStorage.Remotes.Client.ClientVFX:FireAllClients("BodyClone", arg9, "Dodge")
        v15:AddState("ParrySpeed", 0.25)
        v15:RemoveState("Stunned")
        v25 = script.DodgeEffect:Clone()
        _G.Debris(v25, 1)
        v25.CFrame = PrimaryPart_3.CFrame
        v25.Parent = workspace.Effects
        task.delay(0.01, function() -- line: 62
            -- upvalues:
            --  [1] v25 (copy)

            for _, val_8 in v25:QueryDescendants("ParticleEmitter") do
                local EmitDelay_6 = val_8:GetAttribute("EmitDelay")

                if EmitDelay_6 then
                    task.delay(EmitDelay_6, function() -- line: 66
                        -- upvalues:
                        --  [1] val_8 (copy)

                        val_8:Emit(val_8:GetAttribute("EmitCount"))
                    end)
                else
                    val_8:Emit(val_8:GetAttribute("EmitCount"))
                end
            end
        end)

        return true
    end
end

return counterFunc
