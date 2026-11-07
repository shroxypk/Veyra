-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.Animate
-- Class: LocalScript
-- bytes: 14812

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local Modules = ReplicatedStorage.Modules
local Animations = ReplicatedStorage.Animations
local _ = require(Modules.ByteNetMax)
local Packets_m = require(Modules.Packets)
local StateManager_m = require(Modules.StateManager)
local AllItems = require(Modules.Items).AllItems
local StatManager_m = require(Modules.StatManager)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StateManager_m.require(v3)
local v5 = StatManager_m.require(v2)
local Inventory = v2:WaitForChild("Inventory")
local Humanoid = v3.Humanoid
local Animator = Humanoid:FindFirstChildWhichIsA("Animator")
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
local t = {
    Dagger = Animations.Movement.Walk.DaggerWalk,
    Greataxe = Animations.Movement.Walk.GreataxeWalk,
    Greatsword = Animations.Movement.Walk.GreatswordWalk,
    Scythe = Animations.Movement.Walk.ScytheWalk,
    Katana = Animations.Movement.Walk.KatanaWalk,
    Fist = Animations.Movement.Walk.FistWalk,
    Normal = Animations.Movement.Human.Walk,
    Rapier = Animations.Movement.Walk.RapierWalk,
    Spear = Animations.Movement.Walk.SpearWalk,
    Staff = Animations.Movement.Walk.SpearWalk,
    Sword = Animations.Movement.Walk.SwordWalk,
    Trident = Animations.Movement.Walk.TridentWalk,
    Crouch = Animations.Movement.CrouchWalk
}
local t_1 = {
    Dagger = Animations.Movement.Run.DaggerRun,
    Greataxe = Animations.Movement.Run.GreatswordRun,
    Greatsword = Animations.Movement.Run.GreatswordRun,
    Scythe = Animations.Movement.Run.ScytheRun,
    Katana = Animations.Movement.Run.KatanaRun,
    Fist = Animations.Movement.Run.Run,
    Normal = Animations.Movement.Run.Run,
    Spear = Animations.Movement.Run.SpearRun,
    Staff = Animations.Movement.Run.SpearRun,
    Sword = Animations.Movement.Run.SwordRun,
    Rapier = Animations.Movement.Run.RapierRun,
    Trident = Animations.Movement.Run.TridentRun
}
local v6 = nil
local v7 = nil
local v8 = nil
local t_2 = {}
local v9 = nil
local v10 = 0
local v11 = ""
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = 1
local t_3 = {
    fall = Animations.Movement.Human.Fall,
    climb = Animations.Movement.Human.Climb,
    sit = Animations.Movement.Human.Sit,
    jump = Animations.Movement.Human.Jump,
    idle = Animations.Movement.Human.StandIdle
}
local t_4 = {
    [Enum.Material.Sand] = true,
    [Enum.Material.Grass] = true,
    [Enum.Material.Slate] = true,
    [Enum.Material.Pebble] = true
}
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { v3, workspace.Effects }
local SoundId = HumanoidRootPart:WaitForChild("Running").SoundId
local WalkSounds_m = require(script.WalkSounds)

local function footStep(arg1) -- line: 99
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Services_m (copy)
    --  [4] HumanoidRootPart (copy)
    --  [5] raycastParams (copy)
    --  [6] t_4 (copy)

    local v16 = v4:IsSliding()

    if _G.LowPerformance or v16 then
        return
    end

    local v17 = ReplicatedStorage.Effects.MovementDust:Clone()
    Services_m.Debris(v17, 1)
    v17.Anchored = false
    local v18 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -4, 0), raycastParams)

    if v18 and t_4[v18.Material] then
        for _, child in v17:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Color = ColorSequence.new(v18.Instance.Color)
                child:Emit(3)
            end
        end

        local Weld = Instance.new("Weld")
        Weld.Part0 = v17
        Weld.Part1 = HumanoidRootPart
        Weld.C0 = CFrame.new(arg1, 2.5, 0)
        Weld.Parent = Weld.Part0
        v17.Parent = workspace.Effects
        task.delay(0.125, function() -- line: 126
            -- upvalues:
            --  [1] Weld (copy)
            --  [2] v17 (copy)

            Weld:Destroy()
            v17.Anchored = true
        end)

        return
    end

    v17:Destroy()
end

function stopAllAnimations() -- line: 135
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] v12 (ref)
    --  [3] v14 (ref)
    --  [4] v13 (ref)

    local v19 = v11
    v11 = ""
    v12 = nil

    if v14 ~= nil then
        v14:disconnect()
    end

    if v13 ~= nil then
        v13:Stop(0.1)
        v13:Destroy()
        v13 = nil
    end

    return v19
end

function setAnimationSpeed(arg2) -- line: 153
    -- upvalues:
    --  [1] v15 (ref)
    --  [2] v13 (ref)

    if arg2 ~= v15 and v13 then
        v15 = arg2
        v13:AdjustSpeed(v15)
    end
end

function keyFrameReachedFunc(arg3) -- line: 160
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] v15 (ref)
    --  [3] Humanoid (copy)

    if arg3 == "End" then
        local v20 = v15
        playAnimation(v11, 0, Humanoid)
        setAnimationSpeed(v20)
    end
end

function GetWalkAnimation() -- line: 170
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] v9 (ref)
    --  [3] t (copy)
    --  [4] v6 (ref)

    local v21 = v4:IsCrouching()
    local v23

    if v9 then
        local v22 = v9:GetAttribute("Sword") or v9:GetAttribute("Combat")
        v23 = if t[v22] then t[v22] else t.Normal
    else
        v23 = t.Normal
    end

    if v21 then
        v23 = t.Crouch
    end

    if v6 ~= v23 then
        v6 = v23
    end
end

function GetRunAnimation() -- line: 195
    -- upvalues:
    --  [1] v9 (ref)
    --  [2] t_1 (copy)
    --  [3] v7 (ref)

    local v25

    if v9 then
        local v24 = v9:GetAttribute("Sword") or v9:GetAttribute("Combat")
        v25 = if t_1[v24] then t_1[v24] else t_1.Normal
    else
        v25 = t_1.Normal
    end

    if v7 ~= v25 then
        v7 = v25
    end
end

function GetIdleAnimation() -- line: 214
    -- upvalues:
    --  [1] v9 (ref)
    --  [2] Animations (copy)
    --  [3] t_3 (copy)
    --  [4] v8 (ref)

    local v28

    if v9 then
        local v26 = v9:GetAttribute("Sword") or v9:GetAttribute("Combat")
        local v27 = v26 .. "Idle"
        v28 = if Animations.Idles:FindFirstChild(v27) then Animations.Idles[v26 .. "Idle"] else t_3.idle
    else
        v28 = t_3.idle
    end

    if v8 ~= v28 then
        v8 = v28
    end
end

function playAnimation(arg4, arg5) -- line: 233
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] t_3 (copy)
    --  [3] v7 (ref)
    --  [4] v6 (ref)
    --  [5] v12 (ref)
    --  [6] v13 (ref)
    --  [7] v15 (ref)
    --  [8] Animator (copy)
    --  [9] v11 (ref)
    --  [10] HumanoidRootPart (copy)
    --  [11] t_2 (copy)
    --  [12] footStep (copy)
    --  [13] v3 (copy)
    --  [14] v8 (ref)
    --  [15] v14 (ref)

    local v29 = v4:IsSprinting()
    local v30 = false

    if v29 and (arg4 == "fall" or arg4 == "jump") then
        arg4 = "walk"
        v30 = true
    end

    local v31 = t_3[arg4]

    if arg4 == "walk" then
        GetWalkAnimation()
        GetRunAnimation()
        local v32 = v4:IsSliding()
        v31 = v29 and v7 or v6

        if v30 then
            setAnimationSpeed(0.3)
        else
            setAnimationSpeed(if not v29 then 0.9 else 1)
        end

        if v31 ~= v12 and v31 then
            if v13 ~= nil then
                v13:Stop(arg5)
                v13:Destroy()
            end

            v15 = 1
            v13 = Animator:LoadAnimation(v31)
            v13.Priority = Enum.AnimationPriority.Movement
            v13:Play(arg5)
            v11 = arg4
            v12 = v31

            if v32 and v29 then
                HumanoidRootPart.Running.PlaybackSpeed = 0
            end

            for _, val in t_2 do
                val:Disconnect()
            end

            table.clear(t_2)

            for _, val_1 in { "RightFootUp", "LeftFootDown", "RightFootDown", "LeftFootDown" } do
                table.insert(t_2, v13:GetMarkerReachedSignal(val_1):Connect(function() -- line: 286
                    -- upvalues:
                    --  [1] v29 (copy)
                    --  [2] val_1 (copy)
                    --  [3] footStep (ref)
                    --  [4] v3 (ref)

                    if v29 then
                        if val_1 ~= "RightFootUp" then
                            if val_1 == "LeftFootDown" then
                                footStep(v3, if val_1:match("Right") then -0.5 else 0.5)

                                return
                            end
                        else
                            footStep(v3, if val_1:match("Right") then -0.5 else 0.5)

                            return
                        end
                    elseif val_1 == "RightFootDown" or val_1 == "LeftFootDown" then
                        footStep(v3, if val_1:match("Right") then -0.5 else 0.5)
                    end
                end))
            end

            return
        end
    else
        if arg4 == "idle" then
            GetIdleAnimation()
            v31 = v8
            setAnimationSpeed(0.5)
        end

        if v31 ~= v12 and v31 then
            if v13 ~= nil then
                v13:Stop(arg5)
                v13:Destroy()
            end

            v15 = 1
            v13 = Animator:LoadAnimation(v31)
            v13.Priority = Enum.AnimationPriority.Core
            v13:Play(arg5)
            v11 = arg4
            v12 = v31

            if v14 ~= nil then
                v14:disconnect()
            end

            v14 = v13.KeyframeReached:connect(keyFrameReachedFunc)
        end
    end
end

function onFloorChanged() -- line: 339
    -- upvalues:
    --  [1] Humanoid (copy)
    --  [2] WalkSounds_m (copy)
    --  [3] HumanoidRootPart (copy)
    --  [4] SoundId (copy)

    local FloorMaterial = Humanoid.FloorMaterial

    if WalkSounds_m[FloorMaterial] then
        HumanoidRootPart.Running.Volume = WalkSounds_m[FloorMaterial].volume
        HumanoidRootPart.Running.SoundId = WalkSounds_m[FloorMaterial].id

        return
    end

    HumanoidRootPart.Running.Volume = 0.5
    HumanoidRootPart.Running.SoundId = SoundId
end

function onRunning(arg6) -- line: 350
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] HumanoidRootPart (copy)
    --  [3] WalkSounds_m (copy)
    --  [4] Humanoid (copy)

    if arg6 > 0.01 then
        playAnimation("walk", 0.2)
        pose = "Running"
    else
        playAnimation("idle", 0.1)
        pose = "Standing"
    end

    if v4:IsSliding() then
        HumanoidRootPart.Running.PlaybackSpeed = 0

        return
    end

    local v40 = WalkSounds_m[Humanoid.FloorMaterial]

    if v40 then
        if v4:IsSprinting() then
            local Sprintspeed = v40.sprintspeed
            local v41 = Sprintspeed and math.clamp(arg6 - 16, Sprintspeed, 2) or math.clamp(
                math.abs(arg6 - 16) / 2,
                1,
                1.5
            )
            HumanoidRootPart.Running.PlaybackSpeed = v40.speed * v41

            return
        end

        HumanoidRootPart.Running.PlaybackSpeed = v40.speed

        return
    else
        HumanoidRootPart.Running.PlaybackSpeed = 1.85

        return
    end
end

function onDied() -- line: 380
    pose = "Dead"
end

function onJumping() -- line: 384
    -- upvalues:
    --  [1] v10 (ref)

    playAnimation("jump", 0.1)
    v10 = 0.3
    pose = "Jumping"
end

function onClimbing(arg7) -- line: 390
    local v42 = math.clamp(arg7, -5, 5)
    playAnimation("climb", 0.1)
    setAnimationSpeed(v42 / 5)
    pose = "Climbing"
end

function onGettingUp() -- line: 398
    pose = "GettingUp"
end

function onFreeFall() -- line: 402
    -- upvalues:
    --  [1] v10 (ref)

    if v10 <= 0 then
        playAnimation("fall", 0.25)
    end

    pose = "FreeFall"
end

function onFallingDown() -- line: 409
    pose = "FallingDown"
end

function onSeated() -- line: 413
    pose = "Seated"
end

function onPlatformStanding() -- line: 417
    pose = "PlatformStanding"
end

local v43 = 0

function move(arg8) -- line: 422
    -- upvalues:
    --  [1] v43 (ref)
    --  [2] v10 (ref)

    local v44 = arg8 - v43
    v43 = arg8

    if v10 > 0 then
        v10 -= v44
    end

    if pose == "FreeFall" and v10 <= 0 then
        playAnimation("fall", 0.25)

        return
    end

    if pose == "Seated" then
        playAnimation("sit", 0.5)

        return
    end

    if pose == "Running" then
        playAnimation("walk", 0.1)

        return
    end

    if pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding" then
        stopAllAnimations()
    end
end

local function childAdded(u1: userdata) -- line: 446
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] v9 (ref)
    --  [3] Packets_m (copy)
    --  [4] Inventory (copy)
    --  [5] AllItems (copy)

    local Name = u1.Name
    local t_5

    if u1:IsA("Tool") then
        if Name ~= v5:GetStat("FightingStyle") then
            return
        end

        local v45 = u1:GetAttribute("Sword") or u1:GetAttribute("Combat")

        if v45 then
            v9 = u1

            if pose ~= "Running" then
                playAnimation("idle", 0.1)
            end

            t_5 = { Action = "Draw", Item = Inventory:FindFirstChild(Name) }
            Packets_m.Inventory.packets.ToggleWeapon.send(t_5)
            _G.SetupUI(AllItems[Name:split("_")[1]].MasteryType, true)
        end

        return
    else
        return
    end
end

local function childRemoved(arg9) -- line: 471
    -- upvalues:
    --  [1] v9 (ref)
    --  [2] Packets_m (copy)
    --  [3] Inventory (copy)
    --  [4] AllItems (copy)

    if arg9:IsA("Tool") and arg9 == v9 then
        v9 = nil

        if pose ~= "Running" then
            playAnimation("idle", 0.1)
        end

        local t_6 = { Action = "Store", Item = Inventory:FindFirstChild(arg9.Name) }
        Packets_m.Inventory.packets.ToggleWeapon.send(t_6)
        _G.SetupUI(AllItems[arg9.Name:split("_")[1]].MasteryType, false)
    end
end

v3.ChildAdded:Connect(childAdded)
v3.ChildRemoved:Connect(childRemoved)
Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(onFloorChanged)
Humanoid.Died:Connect(onDied)
Humanoid.Running:Connect(onRunning)
Humanoid.Jumping:Connect(onJumping)
Humanoid.Climbing:Connect(onClimbing)
Humanoid.GettingUp:Connect(onGettingUp)
Humanoid.FreeFalling:Connect(onFreeFall)
Humanoid.FallingDown:Connect(onFallingDown)
Humanoid.Seated:Connect(onSeated)
Humanoid.PlatformStanding:Connect(onPlatformStanding)
playAnimation("idle", 0.1)
pose = "Standing"

while true do
    if v3.Parent == nil then
        break
    end

    local _, v49 = wait(0.1)
    move(v49)
end
