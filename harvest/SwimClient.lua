-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.SwimClient
-- Class: LocalScript
-- bytes: 5313

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.DeadZones)
local StateManager_m = require(Modules.StateManager)
local WaterZones_m = require(Modules.WaterZones)
local _, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StateManager_m.require(v3)
local Animator = v3:WaitForChild("Humanoid").Animator
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
local v5 = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.SwimIdle)
v5.Priority = Enum.AnimationPriority.Movement
local SEALEVEL = WaterZones_m.SEA_LEVEL
local CurrentCamera = workspace.CurrentCamera
local WaterVision = Lighting.WaterVision
local WaterBlur = Lighting.WaterBlur
WaterBlur.Enabled = false
WaterVision.TintColor = Color3.fromRGB(255, 255, 255)
local SwimPosition_AlignPosition = Instance.new("AlignPosition")
SwimPosition_AlignPosition.Name = "SwimPosition"
SwimPosition_AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
SwimPosition_AlignPosition.ForceLimitMode = Enum.ForceLimitMode.PerAxis
SwimPosition_AlignPosition.MaxAxesForce = Vector3.new(0, Infinity, 0)
SwimPosition_AlignPosition.Position = Vector3.new(0, SEALEVEL, 0)
SwimPosition_AlignPosition.Responsiveness = 10
SwimPosition_AlignPosition.Attachment0 = HumanoidRootPart.RootAttachment
SwimPosition_AlignPosition:AddTag("Ignore")
local v6 = script
local v7 = false
local v8 = false

local function syncAttribute() -- line: 53
    -- upvalues:
    --  [1] v6 (copy)
    --  [2] TweenService (copy)
    --  [3] WaterVision (copy)
    --  [4] WaterBlur (copy)

    local EffectActive = v6:GetAttribute("EffectActive")
    local v9 = EffectActive and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 255, 255)
    TweenService:Create(
        WaterVision,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { TintColor = v9 }
    ):Play()
    WaterBlur.Enabled = EffectActive
end

local _ = function(arg1) --[[ controlSwimming ]] -- line: 63
    -- upvalues:
    --  [1] v4 (copy)

    if arg1 and not v4:IsSwimming() then
        v4:AddState("Swimming")

        return
    end

    if arg1 == false then
        v4:RemoveState("Swimming")
    end
end

local function setSwimmingState(arg2) -- line: 71
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] v4 (copy)
    --  [3] SwimPosition_AlignPosition (copy)
    --  [4] HumanoidRootPart (copy)
    --  [5] v5 (copy)
    --  [6] ReplicatedStorage (copy)

    if arg2 == v7 then
        return
    end

    v7 = arg2

    if arg2 then
        if not v4:IsSwimming() then
            v4:AddState("Swimming")
        end

        SwimPosition_AlignPosition.Parent = HumanoidRootPart

        if not v5.IsPlaying then
            v5:Play(0.2)
        end

        ReplicatedStorage.Remotes.Splash:FireServer()

        return
    end

    v4:RemoveState("Swimming")

    if v5.IsPlaying then
        v5:Stop(0.1)
    end

    SwimPosition_AlignPosition.Parent = nil
end

local _ = function(arg3) --[[ setCameraUnderwater ]] -- line: 99
    -- upvalues:
    --  [1] v8 (ref)
    --  [2] v6 (copy)

    if arg3 == v8 then
        return
    end

    v8 = arg3
    v6:SetAttribute("EffectActive", arg3 or nil)
end

local function onStep() -- line: 108
    -- upvalues:
    --  [1] HumanoidRootPart (copy)
    --  [2] CurrentCamera (copy)
    --  [3] WaterZones_m (copy)
    --  [4] v3 (copy)
    --  [5] v8 (ref)
    --  [6] v6 (copy)
    --  [7] SwimPosition_AlignPosition (copy)
    --  [8] setSwimmingState (copy)

    local Position = HumanoidRootPart.Position
    local Position_1 = CurrentCamera.CFrame.Position
    local v10 = WaterZones_m:GetSwimLevel(v3, Position)
    local v11 = WaterZones_m:GetSwimLevel(v3, Position_1)
    local v12 = if v11 ~= nil then v11 >= Position_1.Y and true else false

    if v12 ~= v8 then
        v8 = v12
        v6:SetAttribute("EffectActive", v12 or nil)
    end

    v12 = if v10 == nil then false else v10 > Position.Y

    if v12 then
        SwimPosition_AlignPosition.Position = Vector3.new(0, v10, 0)
    end

    setSwimmingState(v12)
end

local function onClientEvent(arg4) -- line: 128
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] WaterZones_m (copy)
    --  [4] SEALEVEL (copy)
    --  [5] Services_m (copy)

    if not arg4 or (CurrentCamera.CFrame.Position - arg4.Position).Magnitude > 250 then
        return
    end

    local v14 = ReplicatedStorage.Effects.Splash:Clone()
    local v15 = WaterZones_m:GetLakeLevel(arg4.Position) or SEALEVEL
    v14.CFrame = CFrame.new(arg4.CFrame.X, v15 - 2, arg4.CFrame.Z)
    v14.Parent = workspace.Effects
    Services_m.Debris(v14, 2)

    for _, val in v14:QueryDescendants("ParticleEmitter") do
        val:Emit(9)
    end

    Services_m.PlaySound(ReplicatedStorage.SFX.Splash, arg4)
end

ReplicatedStorage.Remotes.Splash.OnClientEvent:Connect(onClientEvent)
v6:GetAttributeChangedSignal("EffectActive"):Connect(syncAttribute)
RunService.Stepped:Connect(onStep)
