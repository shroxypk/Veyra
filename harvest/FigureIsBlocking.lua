-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.FigureIsBlocking
-- Class: ModuleScript
-- bytes: 8193

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local _ = game:GetService("ServerScriptService")
local _ = game:GetService("CollectionService")
local GameModules = ServerStorage.GameModules
local StateManager_m = require(ReplicatedStorage.Modules.StateManager)

local _ = function(arg1) --[[ getBlade ]] -- line: 13
    local Welds = arg1:FindFirstChild("Welds")

    if not Welds then
        return
    end

    for _, val in Welds:QueryDescendants("#Blade") do
        return val
    end
end

local function PUNISH_FIGURE(arg2, arg3) -- line: 22
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StateManager_m (copy)
    --  [3] ReplicatedStorage (copy)

    local playerFromCharacter = Players:GetPlayerFromCharacter(arg3)
    local Humanoid = arg3.Humanoid
    local Animator = Humanoid.Animator
    local PrimaryPart = arg3.PrimaryPart
    local v1 = StateManager_m.require(arg2)
    local v2 = StateManager_m.require(arg3)
    v2:RemoveState("Blocking")
    v2:RemoveState("SwordBlocking")
    local t = { Overflow = nil, StrongCore = nil }

    function t.Overflow() -- line: 36
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] v1 (copy)

        if arg2:FindFirstChild("Overflow") then
            v1:AddState("Overflow", 4)
        end
    end

    function t.StrongCore() -- line: 42
        -- upvalues:
        --  [1] arg3 (copy)
        --  [2] v2 (copy)

        if arg3:FindFirstChild("Strong Core") and not v2:HasState("Strong Core Cooldown") then
            v2:AddState("Strong Core", 2)
            v2:AddState("Strong Core Cooldown", 30)
        end
    end

    for _, val_1 in t do
        val_1()
    end

    ReplicatedStorage.Remotes.Client.ClientVFX:FireAllClients("BlockBreak", PrimaryPart)
    ReplicatedStorage.Remotes.Combat:FireAllClients("Dizzy", arg3)

    if playerFromCharacter then
        ReplicatedStorage.Remotes.Client.ClientVFX:FireClient(playerFromCharacter, "Stun")
    end

    local v3 = ReplicatedStorage.SFX.Combat.BlockBreak:Clone()
    v3.PlayOnRemove = true
    v3.Parent = PrimaryPart
    v3:Destroy()
    Humanoid.AutoRotate = false
    local t_1 = {}

    for _, val_2 in { "Stunned", "Occupied", "BlockBroken" } do
        table.insert(t_1, v2:HoldState(val_2))
    end

    local v4 = Animator:LoadAnimation(ReplicatedStorage.Animations.Hit.Dizzy)
    v4:Play()
    task.delay(1.25, function() -- line: 81
        -- upvalues:
        --  [1] v4 (copy)
        --  [2] Humanoid (copy)
        --  [3] t_1 (copy)

        v4:Stop(0.1)
        Humanoid.AutoRotate = true

        for _, val_3 in t_1 do
            val_3()
        end
    end)
end

local AirCombat_m = require(GameModules.AirCombat)

local function isFigureBlocking(arg4, arg5, arg6) -- line: 92
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StateManager_m (copy)
    --  [3] PUNISH_FIGURE (copy)
    --  [4] GameModules (copy)
    --  [5] AirCombat_m (copy)
    --  [6] ReplicatedStorage (copy)

    local v5 = (arg6.Damage or 0) * 0.15
    local v6 = not arg6.BlockDisabled
    local Humanoid_1 = arg4:FindFirstChild("Humanoid")
    local PrimaryPart_1 = arg4.PrimaryPart
    local playerFromCharacter_1 = Players:GetPlayerFromCharacter(arg5)
    local Humanoid_2 = arg5:FindFirstChild("Humanoid")
    local PrimaryPart_2 = arg5.PrimaryPart
    local Type = arg6.Type
    local DotPosition = arg6.DotPosition
    local v7 = arg6.isBlade or Type and Type:match("Slash")
    local v8 = arg6.Weight
    local THREESIXTY = arg6.THREESIXTY
    local BLOCKBREAK = arg6.BLOCKBREAK

    if not v8 then
        v8 = Random.new():NextInteger(2, 5)
    end

    local v9 = DotPosition and (DotPosition - PrimaryPart_2.Position).Unit or (PrimaryPart_1.Position - PrimaryPart_2.Position).Unit
    local States = arg4:FindFirstChild("States")
    local States_1 = arg5:FindFirstChild("States")
    local _ = StateManager_m.require(arg4)
    local v11 = StateManager_m.require(arg5)
    local v12 = v11:IsBlocking()

    if v12 then
        v12 = THREESIXTY or (not Type or v9:Dot(PrimaryPart_2.CFrame.LookVector) > -0.1)
    end

    if not v12 or not v6 then
        return false
    end

    v12 = States.Resolve
    local Resolve = States_1.Resolve
    local Value = States_1.MaxResolve.Value
    local Value_1 = States.MaxResolve.Value

    if arg4:FindFirstChild("Panic Attack") and Humanoid_1.Health < Humanoid_1.MaxHealth then
        v8 *= 1.1
    end

    Resolve.Value = math.clamp(Resolve.Value + v8, 0, Value)

    if if not (Value <= Resolve.Value) then BLOCKBREAK else true then
        if arg4:FindFirstChild("Exhaustion Strike") then
            Resolve.Value = Value * 0.25
        else
            Resolve.Value = 0
        end

        if arg4:FindFirstChild("Exhaustion Blow") then
            v12.Value = math.clamp(v12.Value - v12.Value / 2, 0, Value_1)
        end

        if playerFromCharacter_1 then
            if v5 >= Humanoid_2.Health + 5 or v5 >= Humanoid_2.Health then
                Humanoid_2.Health = 5
            else
                Humanoid_2:TakeDamage(v5)
            end

            v11:AddState("Stunned", 0.35)
        else
            Humanoid_2:TakeDamage(v5)
        end

        PUNISH_FIGURE(arg4, arg5)

        if arg4:FindFirstChild("Shattering Ember") then
            task.spawn(require(GameModules.Damage.Utils.Magic.ShatteringEmber), arg4, arg5)
        end

        return false
    end

    AirCombat_m:UpdateAerialHold(arg4, arg4, "Block")
    AirCombat_m:UpdateAerialHold(arg4, arg5, "Block")
    local _, _ = pcall(function() -- line: 183
        -- upvalues:
        --  [1] v7 (copy)
        --  [2] v11 (copy)
        --  [3] ReplicatedStorage (ref)
        --  [4] PrimaryPart_2 (copy)
        --  [5] arg5 (copy)

        if v7 and v11:HasState("SwordBlocking") then
            local v13 = ReplicatedStorage.SFX.Sword.Clash:Clone()
            v13.Ended:Once(function() -- line: 187
                -- upvalues:
                --  [1] v13 (copy)

                v13:Destroy()
            end)
            v13.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
            v13.Parent = PrimaryPart_2
            v13:Play()
            local Welds_1 = arg5:FindFirstChild("Welds")
            local v14

            if not Welds_1 then
                v14 = nil
            else
                for _, val_4 in Welds_1:QueryDescendants("#Blade") do
                    v14 = val_4
                end

                v14 = nil
            end

            if v14 then
                local v15 = ReplicatedStorage.Effects.SwordClash:Clone()
                _G.Debris(v15, 1.5)
                v15.Size = v14.Size
                v15.CFrame = v14.CFrame
                v15.Parent = workspace.Effects
                task.delay(0.01, function() -- line: 199
                    -- upvalues:
                    --  [1] v15 (copy)

                    for _, val_5 in v15:QueryDescendants("ParticleEmitter") do
                        val_5:Emit(val_5:GetAttribute("EmitCount"))
                    end
                end)
            end

            return
        end

        local v16 = ReplicatedStorage.SFX.Combat.guardhit:Clone()
        v16.Ended:Once(function() -- line: 210
            -- upvalues:
            --  [1] v16 (copy)

            v16:Destroy()
        end)
        v16.PlaybackSpeed = Random.new():NextNumber(0.9, 1.1)
        v16.Parent = PrimaryPart_2
        v16:Play()
        local v17 = ReplicatedStorage.Effects.MeleeBlockHit:Clone()
        _G.Debris(v17, 1.5)
        v17.CFrame = PrimaryPart_2.CFrame
        local Weld = Instance.new("Weld")
        Weld.Part0 = v17
        Weld.Part1 = PrimaryPart_2
        Weld.C0 = CFrame.new(0, 0, 1)
        Weld.Parent = Weld.Part0
        v17.Parent = workspace.Effects
        task.delay(0.01, function() -- line: 224
            -- upvalues:
            --  [1] v17 (copy)

            for _, val_6 in v17:QueryDescendants("ParticleEmitter") do
                val_6:Emit(val_6:GetAttribute("EmitCount"))
            end
        end)
    end)

    return true
end

return isFigureBlocking
