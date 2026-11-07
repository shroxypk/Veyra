-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.HumanoidHandler
-- Class: LocalScript
-- bytes: 7089

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local StateManager_m = require(Modules.StateManager)
local Alchemy_m = require(Modules.Alchemy)
local Weight_m = require(Modules.Weight)
local BeastRageConfig_m = require(Modules.BeastRageConfig)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StateManager_m.require(v3)
local Humanoid = v3:WaitForChild("Humanoid")
local _ = v3:WaitForChild("HumanoidRootPart")
local Animator = Humanoid:FindFirstChildWhichIsA("Animator")
local States = v3:WaitForChild("States")
local t = {
    Swinging = { Speed = -3, jumpDisabled = true },
    JumpLocked = { Speed = nil, jumpDisabled = true },
    Stunned = { Speed = -10, jumpDisabled = true },
    Slowed = { Speed = -12, jumpDisabled = true },
    Feared = { Speed = -5, jumpDisabled = false },
    Parrying = { Speed = nil, jumpDisabled = true },
    Parried = { Speed = -5, jumpDisabled = true },
    ParriedAttack = { Speed = nil, jumpDisabled = true },
    Airborne = { Speed = -6, jumpDisabled = true },
    ParrySpeed = { Speed = 5, jumpDisabled = true },
    SoftStun = { Speed = -10, jumpDisabled = false },
    Detained = { Speed = -10, jumpDisabled = true },
    Boost = { Speed = 5, jumpDisabled = false },
    Flashstep = { Speed = 35, jumpDisabled = true },
    CantMove = { Speed = 0, jumpDisabled = true },
    BlockBroken = { Speed = 0, jumpDisabled = true },
    Locked = { Speed = 0, jumpDisabled = true },
    Knocked = { Speed = 0, jumpDisabled = true },
    Frozen = { Speed = 0, jumpDisabled = true }
}
local t_1 = {
    FeintQueued = true,
    Blocking = true,
    SwordBlocking = true,
    CombatDebounce = true,
    Attacking = true,
    RetributionCooldown = true,
    HoldingBlock = true,
    AllowMisdirect = true,
    TimeHaste = true,
    ParryRecovery = true,
    ParryCooldown = true
}

for key in t do
    t_1[key] = true
end

local _ = function(arg1) --[[ isLowHealth ]] -- line: 67
    -- upvalues:
    --  [1] Humanoid (copy)

    return Humanoid.Health < Humanoid.MaxHealth / (arg1 or 2)
end

local _ = function() --[[ getSprintSpeed ]] -- line: 72
    -- upvalues:
    --  [1] States (copy)
    --  [2] Humanoid (copy)

    return States.RunSpeed.Value - 4 * (1 - Humanoid.Health / Humanoid.MaxHealth)
end

for _, val in {
    Enum.HumanoidStateType.FallingDown,
    Enum.HumanoidStateType.Ragdoll,
    Enum.HumanoidStateType.Seated,
    Enum.HumanoidStateType.Swimming,
    Enum.HumanoidStateType.Flying,
    Enum.HumanoidStateType.StrafingNoPhysics,
    Enum.HumanoidStateType.GettingUp,
    Enum.HumanoidStateType.Climbing,
    Enum.HumanoidStateType.Physics
} do
    Humanoid:SetStateEnabled(val, false)
end

local Debugger = script.Debugger

if RunService:IsStudio() or v2.UserId == 52866742 then
    Debugger.Parent = v3.Head
    Debugger.Enabled = true
end

local v6 = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.LowHealth)
v6.Priority = Enum.AnimationPriority.Action
local PlayerColor_m = require(script.PlayerColor)

local function updateHumanoid() -- line: 102
    -- upvalues:
    --  [1] Humanoid (copy)
    --  [2] Basic_m (copy)
    --  [3] v4 (copy)
    --  [4] v6 (copy)
    --  [5] States (copy)
    --  [6] t (copy)
    --  [7] Alchemy_m (copy)
    --  [8] v3 (copy)
    --  [9] BeastRageConfig_m (copy)
    --  [10] Weight_m (copy)
    --  [11] v2 (copy)
    --  [12] Debugger (copy)
    --  [13] t_1 (copy)
    --  [14] PlayerColor_m (copy)

    local v7 = Humanoid.MaxHealth * Basic_m.LowThreshold
    local v8 = v4:IsSprinting()
    local v9 = v4:IsBlocking()
    local v10 = v4:IsFlying()
    local v11 = v4:IsSwimming()
    local v12 = v4:IsCrouching()
    local v13 = v4:IsIncapacitated()
    local v14 = true
    local v15, v16

    if v7 > Humanoid.Health then
        if not v13 and not v6.IsPlaying then
            v6:Play()
        end

        v15 = if not v8 then 12 else 18
        v16 = v15
    else
        v15 = States.RunSpeed.Value - 4 * (1 - Humanoid.Health / Humanoid.MaxHealth)
        v16 = if not v11 then v8 and v15 or 16 else 12
    end

    if v10 then
        v16 = 0
        v14 = false
    elseif v12 then
        v16 = 8
        v14 = false
    end

    if v4:HasState("OneSpeed") then
        v16 = 1
        v14 = false
    end

    for key_2, val_1 in t do
        if v4:HasState(key_2) then
            local Speed = val_1.Speed

            if val_1.jumpDisabled then
                v14 = false
            end

            if Speed then
                if Speed == 0 then
                    v16 = 0
                    break
                end

                v16 += Speed
            end
        end
    end

    if v6.IsPlaying and (v13 or v7 < Humanoid.Health) then
        v6:Stop(0.2)
    end

    if v9 then
        v16 = 8
        v14 = false
    end

    v16 = if not (v16 > 1) then v16 else if v10 then v16 else if v12 then v16 else if v9 then v16 else v16 + Alchemy_m.GetEffect(
        v3,
        "Swiftness"
    )

    if v3:GetAttribute(BeastRageConfig_m.RAGE_ATTRIBUTE) then
        v16 = if not (v16 > 1) then v16 else if v10 then v16 else v16 * BeastRageConfig_m.WALKSPEED_MULTIPLIER
    end

    if v4:HasState("TimeHaste") then
        v16 = if not (v16 > 1) then v16 else if v10 then v16 else v16 * 1.35
    end

    v16 = if not Weight_m.IsOverencumbered(v2) then v16 else if not (v16 > 1) then v16 else if v10 then v16 else v16 * Weight_m.OVERENCUMBERED_SPEED
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, v14)
    Humanoid.WalkSpeed = math.max(v16, 0)
    Debugger.State.Text = ""

    for key_3, val_2 in v3:GetAttributes() do
        local v19 = t_1
        local v20 = key_3:gsub("State_", "")

        if v19[`{v20}`] then
            v16 = PlayerColor_m(key_3):ToHex()
            v14 = ""
            local v21 = key_3:split("_")

            if #v21 > 1 then
                v21[1] = `<font color='rgb(255, 255, 255)'>{v21[1]}</font><font color='rgb(50, 50, 50)'>_</font>`
            end

            for _, val_3 in v21 do
                v14 ..= `<font color='#{v16}'>{val_3}</font>`
            end

            Debugger.State.Text = Debugger.State.Text .. `{v14}: {val_2}\n`
        end
    end
end

v4:ObserveReplicatedStateAdded(updateHumanoid)
v4:ObserveReplicatedStateRemoved(updateHumanoid)
Humanoid.HealthChanged:Connect(updateHumanoid)
v3:GetAttributeChangedSignal("PotionPower_Swiftness"):Connect(updateHumanoid)
v3:GetAttributeChangedSignal(BeastRageConfig_m.RAGE_ATTRIBUTE):Connect(updateHumanoid)
v3:GetAttributeChangedSignal("PotionEnd_Swiftness"):Connect(updateHumanoid)
game:GetService("Players").LocalPlayer:GetAttributeChangedSignal("InCombat"):Connect(updateHumanoid)

for _, val_4 in { Weight_m.ATTR_CURRENT, Weight_m.ATTR_MAX, Weight_m.ATTR_UNLIMITED } do
    v2:GetAttributeChangedSignal(val_4):Connect(updateHumanoid)
end

updateHumanoid()
