-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.StateManager
-- Class: ModuleScript
-- bytes: 31432

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local Modules = ReplicatedStorage.Modules
local Animations = ReplicatedStorage.Animations
local Basic_m = require(Modules.Basic)
local GoodSignal_m = require(Modules.GoodSignal)
local DisplayTags_m = require(script.displayTags)
local FLYINGTAG = Basic_m.FLYING_TAG
local v2 = nil

local function tagDamage(arg1, arg2, arg3) -- line: 21
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] v2 (ref)

    if not RunService:IsServer() or not arg2 or not arg2.Parent then
        return
    end

    if arg1:FindFirstChildWhichIsA("ForceField") then
        return
    end

    if v2 == nil then
        local v3 = game:GetService("ReplicatedFirst"):FindFirstChild("Services")
        local v4 = v3

        if v4 then
            v4 = v3:FindFirstChild("Cast")
        end

        v3 = v4

        if v3 then
            v3 = v4:FindFirstChild("Functions")
        end

        v4 = v3

        if v4 then
            v4 = v3:FindFirstChild("DamageTag")
        end

        v2 = if not v4 then false else require(v4)
    end

    if v2 then
        v2(
            arg1,
            arg2,
            arg3,
            nil,
            true
        )
    end
end

local t = {}
local t_1 = {}

local _ = function(arg4) --[[ getStateId ]] -- line: 46
    -- upvalues:
    --  [1] t_1 (copy)

    local v6 = t_1[arg4]

    if v6 then
        return v6
    end

    local v7 = arg4:gsub("%W", "_")
    t_1[arg4] = v7

    return v7
end

local t_2 = {}

for key in DisplayTags_m do
    local v8 = t_1[key]

    if not v8 then
        v8 = key:gsub("%W", "_")
        t_1[key] = v8
    end

    t_2[v8] = key
end

local t_3 = {}
t_3.__index = t_3

function t_3.new(arg5) -- line: 66
    -- upvalues:
    --  [1] t (copy)
    --  [2] GoodSignal_m (copy)
    --  [3] t_3 (copy)
    --  [4] RunService (copy)

    if not arg5 then
        return
    end

    if t[arg5] then
        return t[arg5]
    end

    local t_6 = setmetatable(
        {
            Model = arg5,
            Key = arg5,
            Humanoid = arg5:FindFirstChildWhichIsA("Humanoid"),
            Root = arg5.PrimaryPart,
            States = {},
            Timers = {},
            Holds = {},
            Plain = {},
            Display = {},
            Connections = {},
            Animations = {},
            Runtime = {},
            Signals = { StateAdded = GoodSignal_m.new(), StateRemoved = GoodSignal_m.new() }
        },
        t_3
    )
    t_6.Connections.AncestryChanged = arg5.AncestryChanged:Connect(function(_, arg7) -- line: 96
        -- upvalues:
        --  [1] t_6 (copy)

        if not arg7 then
            t_6:Destroy()
        end
    end)
    t[arg5] = t_6

    if RunService:IsClient() then
        t_6:SetupClientDisplay()
    end

    return t_6
end

function t_3.get(arg8) -- line: 111
    -- upvalues:
    --  [1] t (copy)

    return t[arg8]
end

function t_3.require(arg9) -- line: 115
    -- upvalues:
    --  [1] t_3 (copy)

    return t_3.get(arg9) or t_3.new(arg9)
end

function t_3.ObserveStateAdded(arg10, arg11) -- line: 119
    return arg10.Signals.StateAdded:Connect(arg11)
end

function t_3.ObserveStateRemoved(arg12, arg13) -- line: 123
    return arg12.Signals.StateRemoved:Connect(arg13)
end

function t_3.ObserveReplicatedState(arg14, arg15, arg16) -- line: 127
    local v10 = "State_" .. arg15
    arg16(if arg14.Model:GetAttribute(v10) ~= true then false else true)

    return arg14.Model:GetAttributeChangedSignal(v10):Connect(function() -- line: 132
        -- upvalues:
        --  [1] arg16 (copy)
        --  [2] arg14 (copy)
        --  [3] v10 (copy)

        arg16(if arg14.Model:GetAttribute(v10) ~= true then false else true)
    end)
end

function t_3.ObserveReplicatedStateAdded(arg17, arg18) -- line: 137
    local Model = arg17.Model

    return Model.AttributeChanged:Connect(function(attribute) -- line: 140
        -- upvalues:
        --  [1] Model (copy)
        --  [2] arg18 (copy)

        local v15 = attribute:match("^State_(.+)$")

        if not v15 then
            return
        end

        if Model:GetAttribute(attribute) == true then
            arg18(v15)
        end
    end)
end

function t_3.ObserveReplicatedStateRemoved(arg20, arg21) -- line: 152
    local Model_1 = arg20.Model

    return Model_1.AttributeChanged:Connect(function(attribute_1) -- line: 155
        -- upvalues:
        --  [1] Model_1 (copy)
        --  [2] arg21 (copy)

        local v16 = attribute_1:match("^State_(.+)$") or (attribute_1:match("^StateEnd_(.+)$") or attribute_1:match(
            "^StateDuration_(.+)$"
        ))

        if not v16 then
            return
        end

        if Model_1:GetAttribute(attribute_1) ~= true then
            arg21(v16)
        end
    end)
end

function t_3.ObserveState(arg23, arg24, arg25) -- line: 167
    local v17 = arg23.Signals.StateAdded:Connect(function(arg26) -- line: 168
        -- upvalues:
        --  [1] arg24 (copy)
        --  [2] arg25 (copy)

        if arg26 == arg24 then
            arg25(true)
        end
    end)
    local v18 = arg23.Signals.StateRemoved:Connect(function(arg27) -- line: 174
        -- upvalues:
        --  [1] arg24 (copy)
        --  [2] arg25 (copy)

        if arg27 == arg24 then
            arg25(false)
        end
    end)

    return function() -- line: 180
        -- upvalues:
        --  [1] v17 (copy)
        --  [2] v18 (copy)

        v17:Disconnect()
        v18:Disconnect()
    end
end

function t_3.HasState(arg28, arg29) -- line: 186
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] t_1 (copy)

    if RunService:IsClient() then
        local v19 = t_1[arg29]
        local Model_2 = arg28.Model

        if not v19 then
            v19 = arg29:gsub("%W", "_")
            t_1[arg29] = v19
        end

        return if Model_2:GetAttribute(`State_{v19}`) ~= true then false else true
    end

    return arg28.States[arg29] == true
end

function t_3.AddState(arg30, arg31, arg32, arg33) -- line: 194
    -- upvalues:
    --  [1] t_1 (copy)

    if not arg31 then
        return
    end

    if not arg32 then
        arg30.Plain[arg31] = true
    end

    local v22 = arg30.States[arg31] == true
    local v23 = t_1[arg31]

    if not v23 then
        v23 = arg31:gsub("%W", "_")
        t_1[arg31] = v23
    end

    arg30.States[arg31] = true

    if arg32 then
        arg30.Timers[arg31] = workspace:GetServerTimeNow() + arg32
        arg30:SetDisplay(arg31, arg32)
    end

    if arg33 ~= false then
        if arg32 then
            local v24 = workspace:GetServerTimeNow() + arg32
            arg30.Model:SetAttribute(`StateDuration_{v23}`, arg32)
            arg30.Model:SetAttribute(`StateEnd_{v23}`, v24)
        end

        arg30.Model:SetAttribute(`State_{v23}`, true)
    end

    if not v22 then
        arg30.Signals.StateAdded:Fire(arg31)
    end
end

function t_3.RemoveState(arg34, arg35, arg36) -- line: 229
    -- upvalues:
    --  [1] t_1 (copy)

    if not arg34.States[arg35] then
        return
    end

    local v28 = t_1[arg35]

    if not v28 then
        v28 = arg35:gsub("%W", "_")
        t_1[arg35] = v28
    end

    arg34.Plain[arg35] = nil

    if arg34.Holds[arg35] then
        arg34.Timers[arg35] = nil
        arg34.Display[arg35] = nil

        if arg36 ~= false then
            arg34.Model:SetAttribute(`StateEnd_{v28}`, nil)
            arg34.Model:SetAttribute(`StateDuration_{v28}`, nil)
        end

        return
    end

    arg34.States[arg35] = nil
    arg34.Timers[arg35] = nil
    arg34.Display[arg35] = nil

    if arg36 ~= false then
        arg34.Model:SetAttribute(`State_{v28}`, nil)
        arg34.Model:SetAttribute(`StateEnd_{v28}`, nil)
        arg34.Model:SetAttribute(`StateDuration_{v28}`, nil)
    end

    arg34.Signals.StateRemoved:Fire(arg35)
end

function t_3.HoldState(arg37, arg38) -- line: 273
    if not arg38 then
        return function() -- line: 275
        end
    end

    local v34 = arg37.Holds[arg38]

    if not v34 then
        v34 = {}
        arg37.Holds[arg38] = v34
    end

    local t_7 = {}
    v34[t_7] = true
    local v36 = arg37.Plain[arg38]
    arg37:AddState(arg38)
    arg37.Plain[arg38] = v36
    local v37 = false

    return function() -- line: 293
        -- upvalues:
        --  [1] v37 (ref)
        --  [2] arg37 (copy)
        --  [3] arg38 (copy)
        --  [4] t_7 (copy)

        if v37 then
            return
        end

        v37 = true
        local v38 = arg37.Holds[arg38]

        if not v38 then
            return
        end

        v38[t_7] = nil

        if next(v38) == nil then
            arg37.Holds[arg38] = nil

            if not arg37.Plain[arg38] and not arg37.Timers[arg38] then
                arg37:RemoveState(arg38)
            end
        end
    end
end

function t_3.ClearState(arg39, arg40, arg41) -- line: 315
    arg39.Holds[arg40] = nil
    local v39, v40
    arg39.Plain[arg40], v39, v40 = nil, arg40, arg41
    arg39:RemoveState(v39, v40)
end

function t_3.SetDisplay(arg42, arg43, arg44) -- line: 321
    -- upvalues:
    --  [1] DisplayTags_m (copy)

    local v41 = DisplayTags_m[arg43]

    if not v41 then
        arg42.Display[arg43] = nil

        return
    end

    arg42.Display[arg43] = { Time = arg44, InitialTime = arg44, Color = v41.color, Text = v41.text }
end

function t_3.SyncClientDisplay(arg45, arg46) -- line: 337
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] DisplayTags_m (copy)

    local v42 = t_1[arg46]

    if not v42 then
        v42 = arg46:gsub("%W", "_")
        t_1[arg46] = v42
    end

    local v44 = if arg45.Model:GetAttribute(`State_{v42}`) ~= true then false else true
    local v45 = arg45.Display[arg46] ~= nil

    if not v44 then
        arg45.Timers[arg46] = nil
        arg45.Display[arg46] = nil

        if v45 then
            arg45.Signals.StateRemoved:Fire(arg46)
        end

        return
    end

    v44 = DisplayTags_m[arg46]

    if not v44 then
        return
    end

    local attribute_2 = arg45.Model:GetAttribute(`StateDuration_{v42}`)
    local attribute_3 = arg45.Model:GetAttribute(`StateEnd_{v42}`)

    if not attribute_2 or not attribute_3 then
        return
    end

    arg45.Timers[arg46] = attribute_3
    arg45.Display[arg46] = {
        Time = math.max(attribute_3 - workspace:GetServerTimeNow(), 0),
        InitialTime = attribute_2,
        EndTime = attribute_3,
        Color = v44.color,
        Text = v44.text
    }

    if not v45 then
        arg45.Signals.StateAdded:Fire(arg46)
    end
end

function t_3.SetupClientDisplay(arg47) -- line: 387
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] DisplayTags_m (copy)
    --  [3] t_2 (copy)

    if not RunService:IsClient() then
        return
    end

    for key_1 in DisplayTags_m do
        arg47:SyncClientDisplay(key_1)
    end

    arg47.Connections.ClientDisplay = arg47.Model.AttributeChanged:Connect(function(attribute_4) -- line: 396
        -- upvalues:
        --  [1] t_2 (ref)
        --  [2] arg47 (copy)

        local v48 = attribute_4:match("^State_(.+)$") or (attribute_4:match("^StateEnd_(.+)$") or attribute_4:match(
            "^StateDuration_(.+)$"
        ))

        if not v48 then
            return
        end

        local v49 = t_2[v48]

        if v49 then
            arg47:SyncClientDisplay(v49)
        end
    end)
end

function t_3.HasAnyState(arg49, ...) -- line: 410
    for _, val in ipairs({ ... }) do
        if arg49:HasState(val) then
            return true
        end
    end

    return false
end

function t_3.IsAlive(arg50) -- line: 420
    local Humanoid = arg50.Humanoid

    return Humanoid and Humanoid.Health > 0
end

function t_3.IsCarrying(arg51) -- line: 425
    local v51 = arg51:IsAlive()

    if v51 then
        v51 = arg51:HasState("Carrying")
    end

    return v51
end

function t_3.IsClimbing(arg52) -- line: 429
    local v52 = arg52:IsAlive()

    if v52 then
        v52 = arg52:HasState("Climbing")
    end

    return v52
end

function t_3.IsCrouching(arg53) -- line: 433
    local v53 = arg53:IsAlive()

    if v53 then
        v53 = arg53:HasState("Crouching")
    end

    return v53
end

function t_3.IsIncapacitated(arg54) -- line: 437
    if not arg54:IsAlive() then
        return true
    end

    return arg54:HasAnyState(
        "Knocked",
        "Downed",
        "Detained",
        "Ragdoll",
        "BlockBroken",
        "Incapacitated"
    ) or arg54:InGrabAction()
end

function t_3.IsSliding(arg55) -- line: 445
    local v55 = arg55:IsAlive()

    if v55 then
        v55 = arg55:HasState("Sliding")
    end

    return v55
end

function t_3.IsBlocking(arg56) -- line: 449
    local v56 = arg56:IsAlive()

    if v56 then
        v56 = arg56:HasAnyState("Blocking", "SwordBlocking")
    end

    return v56
end

function t_3.IsParrying(arg57) -- line: 453
    local v57 = arg57:IsAlive()

    if v57 then
        v57 = arg57:HasState("Parrying")
    end

    return v57
end

function t_3.IsDodging(arg58) -- line: 457
    local v58 = arg58:IsAlive()

    if v58 then
        v58 = arg58:HasState("Dodging")
    end

    return v58
end

function t_3.IsUsingSkill(arg59) -- line: 461
    local v59 = arg59:IsAlive()

    if v59 then
        v59 = arg59:HasState("SkillActive")
    end

    return v59
end

function t_3.IsSwimming(arg60) -- line: 465
    local v60 = arg60:IsAlive()

    if v60 then
        v60 = arg60:HasState("Swimming")
    end

    return v60
end

function t_3.IsSprinting(arg61) -- line: 469
    local v61 = arg61:IsAlive()

    if v61 then
        v61 = arg61:HasState("Sprinting")
    end

    return v61
end

function t_3.IsFlying(arg62) -- line: 473
    -- upvalues:
    --  [1] FLYINGTAG (copy)

    local Model_14 = arg62.Model

    if not Model_14 then
        return
    end

    local v62 = arg62:IsAlive()

    if v62 then
        v62 = Model_14:GetAttribute(FLYINGTAG)
    end

    return v62
end

function t_3.IsRagdolled(arg63) -- line: 480
    local v63 = arg63:IsAlive()

    if v63 then
        v63 = arg63:HasState("Ragdoll")
    end

    return v63
end

function t_3.IsBurning(arg64) -- line: 484
    local v64 = arg64:IsAlive()

    if v64 then
        v64 = arg64:HasState("StatusFire")
    end

    return v64
end

function t_3.IsUsingCombat(arg65) -- line: 488
    return arg65:HasAnyState("CombatDebounce", "Uppercutting")
end

function t_3.InGrabAction(arg66) -- line: 492
    local Root = arg66.Root

    if not arg66.Model or not Root then
        return
    end

    if not Root:FindFirstChild("GrabbingWeld") then
        if Root:FindFirstChild("GrabWeld") then
            return true
        end

        return
    else
        return true
    end
end

function t_3.CanCombat(arg67) -- line: 504
    if not arg67:IsAlive() then
        return
    end

    local v65 = arg67:IsBlocking()
    local v66 = arg67:IsIncapacitated()
    local v67 = arg67:IsUsingSkill()
    local v68 = arg67:IsFlying()
    local v69 = arg67:IsParrying()
    local v70 = arg67:IsDodging()
    local v71 = arg67:HasState("Downed")
    local v72 = arg67:HasAnyState(
        "MisdirectActive",
        "Attacking",
        "Parried",
        "Occupied",
        "Stunned",
        "CantCombat",
        "ParriedAttack",
        "ParryRecovery",
        "Feared"
    ) or arg67:IsUsingCombat()

    if not v71 and (not v66 and (not v65 and (not v69 and (not v70 and (not v68 and (not v67 and not v72)))))) then
        return true
    end
end

function t_3.CanParry(arg68) -- line: 524
    if not arg68:IsAlive() then
        return
    end

    local v73 = arg68:IsBlocking()
    local v74 = arg68:IsIncapacitated()
    local v75 = arg68:IsDodging()
    local v76 = arg68:IsParrying()
    local v77 = arg68:IsUsingSkill()
    local v78 = arg68:IsFlying()

    if not v73 and (not v74 and (not v75 and (not v76 and (not v78 and (not v77 and not arg68:HasAnyState(
        "ParryCooldown",
        "Occupied",
        "Attacking",
        "Critting",
        "MisdirectActive"
    )))))) then
        return true
    end
end

function t_3.CanBlock(arg69) -- line: 542
    if not arg69:IsAlive() then
        return
    end

    local v80 = arg69:IsBlocking()
    local v81 = arg69:IsDodging()
    local v82 = arg69:IsIncapacitated()
    local v83 = arg69:IsUsingSkill()
    local v84 = arg69:IsFlying()

    if not v80 and (not v82 and (not v84 and (not v83 and (not v81 and not arg69:HasAnyState(
        "Stunned",
        "Occupied",
        "Attacking",
        "Critting",
        "MisdirectActive"
    ))))) then
        return true
    end
end

function t_3.CanDash(arg70) -- line: 560
    if not arg70:IsAlive() then
        return
    end

    if not arg70:HasState("DashCooldown") then
        if not arg70:HasAnyState(
            "Parried",
            "Occupied",
            "Stunned",
            "ParriedAttack",
            "Attacking"
        ) then
            if not arg70:IsFlying() then
                if not arg70:IsIncapacitated() then
                    if not arg70:IsUsingSkill() then
                        if not arg70:IsDodging() then
                            if arg70:IsParrying() then
                                return
                            end

                            return true
                        else
                            return
                        end
                    else
                        return
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end

function t_3.CanSprint(arg71) -- line: 578
    if not arg71:IsAlive() then
        return
    end

    local v86 = arg71:IsBlocking()
    local v87 = arg71:IsIncapacitated()

    if not v86 and (not v87 and not arg71:HasAnyState(
        "Sprinting",
        "Attacking",
        "Using Skill",
        "Stunned",
        "Parried",
        "Airborne",
        "Swimming"
    )) then
        return true
    end
end

function t_3.CanSlide(arg72) -- line: 591
    if not arg72:IsAlive() then
        return
    end

    local v89 = arg72:IsIncapacitated()
    local v90 = arg72:IsSwimming()
    local v91 = arg72:IsDodging()
    local v92 = arg72:IsBlocking() or arg72:IsParrying()

    if not v89 and not v91 and not v92 and not v90 and not arg72:IsUsingCombat() and not arg72:HasAnyState(
        "Crouching",
        "Parried"
    ) then
        return true
    end
end

function t_3.CanMisdirect(arg73) -- line: 604
    if not arg73:IsAlive() then
        return
    end

    if arg73:HasState("AllowMisdirect") then
        if not arg73:HasState("FeintQueued") then
            return
        end

        local v93 = arg73:IsParrying()
        local v94 = arg73:IsBlocking()
        local v95 = arg73:IsIncapacitated()

        if not v94 and not v95 and not v93 and not arg73:IsUsingSkill() and not arg73:HasState(
            "Stunned"
        ) and not arg73:HasState("MisdirectActive") and not arg73:HasState("MisdirectCooldown") then
            return true
        end

        return
    else
        return
    end
end

function t_3.CanCrouch(arg74) -- line: 621
    if not arg74:IsAlive() then
        return
    end

    local v97 = arg74:IsBlocking()
    local v98 = arg74:IsIncapacitated()

    if not v97 and not v98 and not arg74:IsFlying() and not arg74:HasState("Crouching") and not arg74:HasState(
        "Sprinting"
    ) and not arg74:HasState("Swimming") and not arg74:HasState("Airborne") and not arg74:HasState(
        "Sliding"
    ) then
        return true
    end
end

function t_3.CanClimb(arg75) -- line: 633
    if not arg75:IsAlive() then
        return
    end

    if not arg75:IsIncapacitated() and not arg75:IsFlying() then
        return true
    end
end

function t_3.CanUseSkill(arg76) -- line: 644
    if not arg76:IsAlive() then
        return
    end

    local v101 = arg76:IsIncapacitated()
    local v102 = arg76:IsFlying()
    local v103 = arg76:IsBlocking()
    local v104 = arg76:IsParrying()
    local v105 = arg76:IsDodging()
    local v106 = arg76:IsUsingSkill()
    local v107 = arg76:InGrabAction()

    if not v106 and not v107 and not v101 and not v102 and not v103 and not v104 and not v105 and (not arg76:IsUsingCombat() and not arg76:HasAnyState(
        "ParriedAttack",
        "Stunned",
        "Parried",
        "Occupied",
        "MisdirectActive",
        "ParryRecovery",
        "Feared"
    )) then
        return true
    end
end

function t_3.CanEmote(arg77) -- line: 665
    local Root_1 = arg77.Root

    if not arg77.Model or not Root_1 then
        return
    end

    local v109 = arg77:IsIncapacitated()
    local v110 = arg77:IsUsingSkill()
    local v111 = arg77:IsSwimming()
    local v112 = arg77:IsCrouching()
    local v113 = arg77:IsClimbing()

    if not v109 and not arg77:IsFlying() and not v110 and not v111 and not v112 and not v113 and not Root_1:FindFirstChildWhichIsA(
        "BodyMover"
    ) then
        return true
    end
end

function t_3.CanBeGripped(arg78) -- line: 684
    local Root_2 = arg78.Root

    if not Root_2 then
        return
    end

    if arg78:HasState("Downed") and not arg78:HasState("BeingGripped") and not Root_2:FindFirstChild(
        "CarryWeld"
    ) then
        return true
    end
end

function t_3.CanStillAttack(arg79) -- line: 695
    if not arg79:IsIncapacitated() and not arg79:HasState("Stunned") then
        return true
    end
end

function t_3.CanAction(t1: table, b1: boolean?) -- line: 701
    local Model_15 = t1.Model

    if not Model_15 then
        return
    end

    local PrimaryPart = Model_15.PrimaryPart
    local v114 = t1:IsIncapacitated()
    local v115 = t1:IsUsingSkill()
    local v116 = t1:InGrabAction()

    if not v114 then
        if not v116 then
            if not v115 then
                if t1:HasAnyState("Locked", "Swinging", "Disabled") or PrimaryPart.Anchored then
                    return
                end

                local v117 = t1:IsBlocking()
                local v118 = t1:IsDodging()
                local v119 = t1:IsParrying()

                if not Model_15:HasTag("HyperArmor") then
                    if t1:HasState("HyperArmor") and (not v117 and (not v118 and not v119)) then
                        return true
                    end

                    if b1 then
                        if not v117 and not v118 and not v119 and not t1:HasState("Occupied") then
                            return true
                        end

                        return
                    end

                    if not v117 and not v118 and not v119 and not t1:HasState("Stunned") and not t1:HasState(
                        "Parried"
                    ) and not t1:HasState("Occupied") then
                        return true
                    end

                    return
                else
                    if not v117 and (not v118 and not v119) then
                        return true
                    end

                    if b1 then
                        if not v117 and not v118 and not v119 and not t1:HasState("Occupied") then
                            return true
                        end

                        return
                    end

                    if not v117 and not v118 and not v119 and not t1:HasState("Stunned") and not t1:HasState(
                        "Parried"
                    ) and not t1:HasState("Occupied") then
                        return true
                    end

                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end

function t_3.SetupConnections(arg80) -- line: 739
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] ServerStorage (copy)
    --  [3] Players (copy)
    --  [4] Animations (copy)

    if not RunService:IsServer() then
        return
    end

    local Model_16 = arg80.Model

    if not Model_16 or not arg80.Humanoid or not arg80.Root then
        return
    end

    local _ = require(ServerStorage.GameModules.ZeroRagdoll)
    local _ = Players:GetPlayerFromCharacter(Model_16)
    local Humanoid_1 = Model_16:FindFirstChild("Humanoid")
    local _ = Model_16.PrimaryPart
    local Animator = Humanoid_1:FindFirstChildWhichIsA("Animator")

    if Animator then
        local v120 = Animator:LoadAnimation(Animations.Hit.Detained)
        v120.Priority = Enum.AnimationPriority.Action3
        local v121 = Animator:LoadAnimation(Animations.Hit.Knocked)
        v121.Priority = Enum.AnimationPriority.Action3
        arg80.Animations.Detained = v120
        arg80.Animations.Knocked = v121
    end

    local SkillVelocity_BodyVelocity = Instance.new("BodyVelocity")
    SkillVelocity_BodyVelocity.Name = "SkillVelocity"
    SkillVelocity_BodyVelocity.MaxForce = Vector3.new(1.0995116E+12, 1.0995116E+12, 1.0995116E+12)
    SkillVelocity_BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    SkillVelocity_BodyVelocity.P = math.huge
    arg80.Runtime.SkillVelocity = SkillVelocity_BodyVelocity
    arg80:ObserveStateAdded(function(arg81) -- line: 778
        -- upvalues:
        --  [1] arg80 (copy)

        if arg81 == "Ragdoll" or arg81 == "Downed" then
            arg80:SetRagdoll(true)

            return
        end

        if arg81 == "Knocked" then
            arg80:PlayAnimation("Knocked")

            return
        end

        if arg81 == "Detained" then
            arg80:PlayAnimation("Detained")

            return
        end

        if arg81 == "Locked" then
            arg80:SetLocked(true)

            return
        end

        if arg81 == "StatusFire" then
            arg80:StartBurning()
        end
    end)
    arg80:ObserveStateRemoved(function(arg82) -- line: 797
        -- upvalues:
        --  [1] arg80 (copy)

        if arg82 == "Ragdoll" or arg82 == "Downed" then
            arg80:SetRagdoll(false)

            return
        end

        if arg82 == "Knocked" then
            arg80:StopAnimation("Knocked")

            return
        end

        if arg82 == "Detained" then
            arg80:StopAnimation("Detained")

            return
        end

        if arg82 == "Locked" then
            arg80:SetLocked(false)

            return
        end

        if arg82 == "StatusFire" then
            arg80:StopBurning()
        end
    end)
end

function t_3.SetRagdoll(arg83, arg84) -- line: 817
    -- upvalues:
    --  [1] ServerStorage (copy)

    require(ServerStorage.GameModules.ZeroRagdoll).Ragdoll(arg83.Model, arg84)
    _G.ToggleCollisions(arg83.Model, not arg84)
end

function t_3.SetLocked(arg85, arg86) -- line: 824
    local Humanoid_2 = arg85.Humanoid
    local SkillVelocity = arg85.Runtime.SkillVelocity

    if not SkillVelocity or not SkillVelocity.Parent or not Humanoid_2 then
        return
    end

    Humanoid_2.AutoRotate = not arg86

    if arg86 then
        SkillVelocity.P = 100000
        SkillVelocity.Velocity = Vector3.new(0, 0, 0)
        SkillVelocity.Parent = arg85.Root

        return
    end

    SkillVelocity.Parent = nil
end

function t_3.StartBurning(arg87) -- line: 842
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] RunService (copy)
    --  [3] Players (copy)
    --  [4] tagDamage (copy)

    if arg87.Runtime.BurningConnection then
        return
    end

    local Humanoid_3 = arg87.Humanoid
    local Root_3 = arg87.Root

    if not Humanoid_3 or not Root_3 then
        return
    end

    local os_clock = os.clock()
    local v122 = ReplicatedStorage.Effects.Statuses.StatusFire:Clone()
    v122.Parent = Root_3
    arg87.Runtime.BurningParticle = v122
    arg87.Runtime.BurningConnection = RunService.Heartbeat:Connect(function() -- line: 860
        -- upvalues:
        --  [1] arg87 (copy)
        --  [2] Humanoid_3 (copy)
        --  [3] os_clock (ref)
        --  [4] Players (ref)
        --  [5] tagDamage (ref)

        if not arg87:HasState("StatusFire") then
            arg87:StopBurning()

            return
        end

        local clock, playerFromCharacter_1

        if not (Humanoid_3.Health <= 0) then
            if Humanoid_3:GetState() == Enum.HumanoidStateType.Dead then
                arg87:StopBurning()

                return
            end

            clock = os.clock()

            if clock - os_clock < 0.5 then
                return
            end

            os_clock = clock
            playerFromCharacter_1 = Players:GetPlayerFromCharacter(arg87.Model)
            tagDamage(arg87.Model, arg87.Runtime.BurnSource, 2)

            if playerFromCharacter_1 and 2 >= Humanoid_3.Health then
                Humanoid_3.Health = 5

                return
            end

            Humanoid_3:TakeDamage(2)

            return
        else
            arg87:StopBurning()

            return
        end
    end)
end

function t_3.SetBurnSource(arg88, arg89) -- line: 895
    arg88.Runtime.BurnSource = arg89
end

function t_3.StopBurning(arg90) -- line: 899
    -- upvalues:
    --  [1] Services_m (copy)

    arg90.Runtime.BurnSource = nil

    if arg90.Runtime.BurningConnection then
        arg90.Runtime.BurningConnection:Disconnect()
        arg90.Runtime.BurningConnection = nil
    end

    local BurningParticle = arg90.Runtime.BurningParticle

    if BurningParticle then
        BurningParticle.Enabled = false
        Services_m.Debris(BurningParticle, 1.5)
        arg90.Runtime.BurningParticle = nil
    end
end

function t_3.PlayAnimation(arg91, arg92) -- line: 915
    local v123 = arg91.Animations[arg92]

    if v123 then
        v123:Play(0.2)
    end
end

function t_3.StopAnimation(arg93, arg94) -- line: 922
    local v124 = arg93.Animations[arg94]

    if v124 then
        v124:Stop(0.2)
    end
end

function t_3.Destroy(arg95) -- line: 929
    -- upvalues:
    --  [1] t (copy)

    arg95:StopBurning()

    for _, val_1 in arg95.Runtime do
        if typeof(val_1) == "RBXScriptConnection" then
            val_1:Disconnect()
        end
    end

    for _, val_2 in arg95.Connections do
        val_2:Disconnect()
    end

    table.clear(arg95.Connections)
    table.clear(arg95.States)
    table.clear(arg95.Timers)
    table.clear(arg95.Holds)
    table.clear(arg95.Plain)
    table.clear(arg95.Display)
    table.clear(arg95.Signals)
    table.clear(arg95.Animations)
    table.clear(arg95.Runtime)
    t[arg95.Key] = nil
end

function t_3.HeartbeatConnect(_) -- line: 957
    -- upvalues:
    --  [1] t (copy)

    local v125 = workspace:GetServerTimeNow()

    for _, val_3 in t do
        if not val_3.Model or not val_3.Model.Parent then
            val_3:Destroy()
        else
            for key_6, val_4 in val_3.Timers do
                local v126 = val_4 - v125

                if v126 <= 0 then
                    val_3:RemoveState(key_6)
                else
                    local v127 = val_3.Display[key_6]

                    if v127 then
                        v127.Time = v126
                    end
                end
            end
        end
    end
end

return t_3
