-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.State Handler.Client.Dash
-- Class: ModuleScript
-- bytes: 15666

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Modules = ReplicatedStorage.Modules
local StateManager_m = require(Modules.StateManager)
local Packets_m = require(Modules.Packets)
local CreateBindableAction_m = require(Modules.CreateBindableAction)
local GamepadLayer_m = require(Modules.GamepadLayer)
local t = {}
t.__index = t
local LocalPlayer_1 = Players.LocalPlayer
local KeyCode_ButtonX = Enum.KeyCode.ButtonX
local t_4 = { "Parried", "Occupied", "Stunned", "ParriedAttack", "Attacking" }
local t_5 = { "Roll_" }

function t.new() -- line: 56
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StateManager_m (copy)
    --  [3] t (copy)
    --  [4] ReplicatedStorage (copy)

    local LocalPlayer = Players.LocalPlayer
    local v2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = v2:WaitForChild("Humanoid")
    local Animator = Humanoid:WaitForChild("Animator")
    local HumanoidRootPart = v2:WaitForChild("HumanoidRootPart")
    local Agility = LocalPlayer:WaitForChild("Skills"):WaitForChild("Agility")
    local Settings = LocalPlayer:WaitForChild("Settings")
    local Binds = LocalPlayer:WaitForChild("Binds")
    local t_2 = setmetatable(
        {
            Player = LocalPlayer,
            Character = v2,
            Humanoid = Humanoid,
            Animator = Animator,
            Root = HumanoidRootPart,
            State = StateManager_m.require(v2),
            Agility = Agility,
            Settings = Settings,
            RollBind = Binds:WaitForChild("Roll"),
            CharacterStates = v2:WaitForChild("States"),
            DashConnection = nil,
            InputConnection = nil,
            CancelListener = nil,
            AncestryConnection = nil,
            StateConnection = nil,
            AwaitingServerSince = nil,
            ActiveVelocity = nil,
            ActiveAnimation = nil
        },
        t
    )
    t_2.Animations = {
        AirDash = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.Roll_Air),
        Front = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.Roll_Front),
        Back = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.Roll_Back),
        Left = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.Roll_Left),
        Right = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.Roll_Right),
        CancelLeft = Animator:LoadAnimation(ReplicatedStorage.Animations.Misc.RollCancelLeft),
        CancelRight = Animator:LoadAnimation(ReplicatedStorage.Animations.Misc.RollCancelRight)
    }

    return t_2
end

function t.IsLowHealth(arg1) -- line: 132
    return arg1.Humanoid.Health < arg1.Humanoid.MaxHealth / 2
end

function t.GetDashSpeed(arg2) -- line: 136
    local v4 = 55

    if arg2:IsLowHealth() then
        v4 *= 0.6
    end

    if arg2.State:HasState("Airborne") then
        v4 *= 0.5
    end

    return v4 + arg2.Agility.Level.Value * 0.06
end

function t.GetDashDirection(arg3) -- line: 150
    -- upvalues:
    --  [1] UserInputService (copy)

    local MoveDirection = arg3.Humanoid.MoveDirection

    if MoveDirection == Vector3.new(0, 0, 0) then
        return "Front"
    end

    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return "Front"
    end

    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        return "Front"
    end

    local v5 = CurrentCamera.CFrame:VectorToObjectSpace(MoveDirection)

    if v5.Z > 0.5 then
        return "Back"
    end

    return if not (v5.Z < -0.5) then if not (v5.X > 0.5) then "Left" else "Right" else "Front"
end

function t.GetCancelDirection(arg4) -- line: 179
    local AssemblyLinearVelocity = arg4.Root.AssemblyLinearVelocity
    local vec3 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z)

    if vec3.Magnitude <= 0.1 then
        return "Back"
    end

    local v6 = arg4.Root.CFrame:VectorToObjectSpace(vec3.Unit)

    if v6.Z > 0.5 then
        return "Back"
    end

    return if not (v6.Z < -0.5) then if not (v6.X > 0.5) then "Left" else "Right" else "Front"
end

local KeyCode_ButtonL3 = Enum.KeyCode.ButtonL3

local function isSurgeHeld() -- line: 210
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] KeyCode_ButtonL3 (copy)

    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        return true
    end

    for _, val in UserInputService:GetConnectedGamepads() do
        if UserInputService:IsGamepadButtonDown(val, KeyCode_ButtonL3) then
            return true
        end
    end

    return false
end

function t.CanSurge(arg5) -- line: 222
    if not arg5.Character:FindFirstChild("Chrono Surge") then
        return false
    end

    if arg5.State:HasState("ChronoSurgeCD") then
        return false
    end

    return arg5.CharacterStates.Energy.Value > 10
end

function t.CanLightningDash(arg6) -- line: 234
    if not arg6.Character:FindFirstChild("Lightning Pulse") then
        return false
    end

    local v8 = arg6.State:HasState("Lightning Shroud")

    if v8 then
        v8 = not arg6.State:IsSwimming()
    end

    return v8
end

function t.GetRequestedSpecialDash(arg7) -- line: 242
    -- upvalues:
    --  [1] isSurgeHeld (copy)

    local v9 = arg7.State:IsSwimming()
    local v10 = arg7.Settings.UseAirDash.Value

    if v10 then
        v10 = false

        if arg7.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            v10 = not v9

            if v10 then
                v10 = if arg7.Character:FindFirstChild("Air Dash") == nil then false else true
            end
        end
    end

    if arg7:CanSurge() and isSurgeHeld() then
        return "Surge"
    end

    if v10 then
        return "AirDash"
    end

    if arg7:CanLightningDash() then
        return "Lightning Dash"
    end

    return nil
end

function t.SetVelocity(t1: table, u1: userdata, n1: number, b1: boolean?) -- line: 266
    local MoveDirection_1 = t1.Humanoid.MoveDirection

    if MoveDirection_1 ~= Vector3.new(0, 0, 0) then
        u1.Velocity = MoveDirection_1 * n1

        return
    end

    if not b1 then
        return
    end

    local LookVector = t1.Root.CFrame.LookVector
    local vec3_1 = Vector3.new(LookVector.X, 0, LookVector.Z)

    if vec3_1.Magnitude > 0 then
        u1.Velocity = vec3_1.Unit * n1
    end
end

function t.StopDash(arg8) -- line: 290
    if arg8.DashConnection then
        arg8.DashConnection:Disconnect()
        arg8.DashConnection = nil
    end

    if arg8.ActiveVelocity then
        if arg8.ActiveVelocity.Parent then
            arg8.ActiveVelocity:Destroy()
        end

        arg8.ActiveVelocity = nil
    end

    if arg8.ActiveAnimation then
        arg8.ActiveAnimation:Stop()
        arg8.ActiveAnimation = nil
    end

    arg8.Humanoid.AutoRotate = true
end

function t.ShouldStopDash(arg9) -- line: 312
    -- upvalues:
    --  [1] t_4 (copy)

    if arg9.State:HasAnyState(table.unpack(t_4)) then
        return true
    end

    if arg9.State:IsRagdolled() then
        return true
    end

    if arg9.State:IsIncapacitated() then
        return true
    end

    return false
end

function t.StartGroundDash(t2: table, n2: number?) -- line: 328
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] RunService (copy)

    t2:StopDash()
    Services_m.RemoveMovers(t2.Root)
    local v12 = t2:GetDashSpeed() * (n2 or 1)
    local v13 = t2:GetDashDirection()
    local RollVelocity_BodyVelocity = Instance.new("BodyVelocity")
    RollVelocity_BodyVelocity.Name = "RollVelocity"
    RollVelocity_BodyVelocity.P = math.huge
    local v14, v15
    RollVelocity_BodyVelocity.MaxForce, v14, v15 = Vector3.new(25000, 0, 25000), RollVelocity_BodyVelocity, v12
    t2:SetVelocity(v14, v15, true)
    RollVelocity_BodyVelocity.Parent = t2.Root
    t2.ActiveVelocity = RollVelocity_BodyVelocity
    local v16 = t2.Animations[v13]

    if not t2.State:IsSwimming() then
        local v17 = if v13 ~= "Front" then 1 else 1.25
        v16.Priority = Enum.AnimationPriority.Action2
        v16:Play(0.15, nil, v17)
        t2.ActiveAnimation = v16
    end

    local v18 = time()
    t2.DashConnection = RunService.Heartbeat:Connect(function() -- line: 360
        -- upvalues:
        --  [1] RollVelocity_BodyVelocity (copy)
        --  [2] t2 (copy)
        --  [3] v18 (copy)
        --  [4] v12 (copy)

        if not RollVelocity_BodyVelocity.Parent then
            t2:StopDash()

            return
        end

        if t2:ShouldStopDash() then
            t2:StopDash()

            return
        end

        if time() - v18 >= 0.3 then
            t2:StopDash()

            return
        end

        t2:SetVelocity(RollVelocity_BodyVelocity, v12)
    end)
end

function t.GetAirDashVelocity(t3: table, u2: userdata) -- line: 382
    -- upvalues:
    --  [1] LocalPlayer_1 (copy)

    local MoveDirection_2 = t3.Humanoid.MoveDirection

    if MoveDirection_2.Magnitude < 0.1 then
        return LocalPlayer_1:GetMouse().Hit.LookVector * 50
    end

    local RightVector = u2.CFrame.RightVector
    local vec3_2 = Vector3.new(RightVector.X, 0, RightVector.Z)

    if vec3_2.Magnitude < 0.001 then
        return MoveDirection_2.Unit * 50
    end

    vec3_2 = vec3_2.Unit
    local v19 = (Vector3.new(0, 1, 0)):Cross(vec3_2)
    local v20 = MoveDirection_2:Dot(v19)
    local v21 = MoveDirection_2:Dot(vec3_2)
    local v23 = u2.CFrame.LookVector * math.max(v20, 0) + v19 * math.min(v20, 0) + vec3_2 * v21

    if v23.Magnitude < 0.01 then
        v23 = MoveDirection_2
    end

    return v23.Unit * 50
end

function t.StartAirDash(arg10) -- line: 414
    -- upvalues:
    --  [1] Services_m (copy)

    arg10:StopDash()
    Services_m.RemoveMovers(arg10.Root)
    local CurrentCamera_1 = workspace.CurrentCamera

    if not CurrentCamera_1 then
        return
    end

    local BodyVelocity_1 = Instance.new("BodyVelocity")
    BodyVelocity_1.Name = "RollVelocity"
    BodyVelocity_1.MaxForce = Vector3.new(80000, 80000, 80000)
    local v24
    BodyVelocity_1.P, v24 = 5000, CurrentCamera_1
    BodyVelocity_1.Velocity = arg10:GetAirDashVelocity(v24)
    BodyVelocity_1.Parent = arg10.Root
    arg10.ActiveVelocity = BodyVelocity_1

    if not arg10.State:IsSwimming() then
        local v25 = arg10:GetDashDirection()
        local v26 = if v25 == "Front" then arg10.Animations.AirDash else arg10.Animations[v25]
        v26.Priority = Enum.AnimationPriority.Action2
        v26:Play(0.1, nil, 1.5)
        arg10.ActiveAnimation = v26
    end

    task.delay(0.2, function() -- line: 445
        -- upvalues:
        --  [1] arg10 (copy)
        --  [2] BodyVelocity_1 (copy)

        if arg10.ActiveVelocity == BodyVelocity_1 then
            arg10:StopDash()
        end
    end)
end

function t.RequestDash(arg11) -- line: 452
    -- upvalues:
    --  [1] Packets_m (copy)

    if arg11.AwaitingServerSince then
        if time() - arg11.AwaitingServerSince < 1.5 then
            return
        end

        arg11.AwaitingServerSince = nil
    end

    if not arg11.State:CanDash() then
        return
    end

    local v28 = arg11:GetRequestedSpecialDash()
    arg11.AwaitingServerSince = time()
    Packets_m.Combat.packets.RollInput.send({ Action = "Roll", typeOf = v28 or "" })

    if v28 == "Surge" then
        return
    end

    if v28 == "AirDash" then
        arg11:StartAirDash()

        return
    end

    arg11:StartGroundDash(if v28 ~= "Lightning Dash" then nil else 1.5)
end

function t.PlayCancelAnimation(arg12) -- line: 484
    local v30 = arg12:GetCancelDirection()
    local v31 = if v30 == "Left" or v30 == "Front" then arg12.Animations.CancelLeft else arg12.Animations.CancelRight
    v31.Priority = Enum.AnimationPriority.Action2
    v31:Play(0.1, nil, 0.9)
end

function t.OnCancelled(arg13) -- line: 496
    -- upvalues:
    --  [1] t_5 (copy)

    arg13:StopDash()
    arg13.AwaitingServerSince = nil

    for _, val_1 in arg13.Animator:GetPlayingAnimationTracks() do
        for _, val_2 in t_5 do
            if string.find(val_1.Name, val_2, 1, true) then
                val_1:Stop()
                break
            end
        end
    end

    arg13:PlayCancelAnimation()
end

function t.OnRejected(arg14) -- line: 515
    if not arg14.AwaitingServerSince then
        return
    end

    arg14.AwaitingServerSince = nil
    arg14:StopDash()
end

function t.Cancel(arg15) -- line: 526
    -- upvalues:
    --  [1] Packets_m (copy)

    if not arg15.ActiveVelocity and not arg15.State:HasState("AllowCancel") then
        return
    end

    Packets_m.Combat.packets.RollInput.send({ Action = "Cancel" })
end

function t.Start(arg16) -- line: 536
    -- upvalues:
    --  [1] Packets_m (copy)
    --  [2] CreateBindableAction_m (copy)
    --  [3] UserInputService (copy)
    --  [4] GamepadLayer_m (copy)
    --  [5] KeyCode_ButtonX (copy)

    arg16.CancelListener = Packets_m.Combat.packets.RollInput.listen(function(arg17) -- line: 538
        -- upvalues:
        --  [1] arg16 (copy)

        if arg17.Action == "success" then
            arg16:OnCancelled()

            return
        end

        if arg17.Action == "rejected" then
            arg16:OnRejected()
        end
    end)
    arg16.AncestryConnection = arg16.Character.AncestryChanged:Connect(function(_, arg19) -- line: 546
        -- upvalues:
        --  [1] arg16 (copy)

        if not arg19 then
            arg16:Destroy()
        end
    end)
    arg16.StateConnection = arg16.Character.AttributeChanged:Connect(function() -- line: 553
        -- upvalues:
        --  [1] arg16 (copy)

        if arg16.AwaitingServerSince then
            if not arg16.State:HasState("DashCooldown") then
                if arg16.State:HasState("Dodging") then
                    arg16.AwaitingServerSince = nil
                end
            else
                arg16.AwaitingServerSince = nil
            end
        end
    end)
    CreateBindableAction_m("Roll", arg16.RollBind, function(_, arg21) -- line: 562
        -- upvalues:
        --  [1] arg16 (copy)

        if arg21 == Enum.UserInputState.Begin then
            arg16:RequestDash()
        end
    end)
    arg16.InputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- line: 571
        -- upvalues:
        --  [1] GamepadLayer_m (ref)
        --  [2] KeyCode_ButtonX (ref)
        --  [3] arg16 (copy)

        if gameProcessedEvent and input.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return
        end

        if input.UserInputType == Enum.UserInputType.Gamepad1 and GamepadLayer_m.isChorded(
            input.KeyCode
        ) then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseButton2 or input.KeyCode == KeyCode_ButtonX then
            arg16:Cancel()
        end
    end)
end

function t.Destroy(arg24) -- line: 592
    arg24:StopDash()

    if arg24.InputConnection then
        arg24.InputConnection:Disconnect()
        arg24.InputConnection = nil
    end

    if arg24.CancelListener then
        arg24.CancelListener()
        arg24.CancelListener = nil
    end

    if arg24.AncestryConnection then
        arg24.AncestryConnection:Disconnect()
        arg24.AncestryConnection = nil
    end

    if arg24.StateConnection then
        arg24.StateConnection:Disconnect()
        arg24.StateConnection = nil
    end
end

return t
