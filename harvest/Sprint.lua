-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.State Handler.Client.Sprint
-- Class: ModuleScript
-- bytes: 13686

local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local StateManager_m = require(Modules.StateManager)
local GamepadLayer_m = require(Modules.GamepadLayer)
local t = {}
t.__index = t
local t_1 = { Enum.KeyCode.W, Enum.KeyCode.Up }
local t_3 = {
    "Attacking",
    "Swinging",
    "Using Skill",
    "SkillActive",
    "Blocking",
    "SwordBlocking",
    "Parrying",
    "Parried"
}
local t_4 = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift }
local t_5 = {
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Up,
    Enum.KeyCode.Left,
    Enum.KeyCode.Down,
    Enum.KeyCode.Right
}

function t.new() -- line: 43
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StateManager_m (copy)
    --  [3] t (copy)

    local LocalPlayer = Players.LocalPlayer
    local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = v1:WaitForChild("Humanoid")
    local _ = Humanoid:WaitForChild("Animator")
    local HumanoidRootPart = v1:WaitForChild("HumanoidRootPart")
    local Settings = LocalPlayer:WaitForChild("Settings")
    local v2 = StateManager_m.require(v1)
    local v3 = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild(
        "CameraModule",
        10
    )
    local v4 = v3

    if v4 then
        v4 = v3:WaitForChild("MouseLockController", 10)
    end

    v3 = v4

    if v3 then
        v3 = v4:WaitForChild("BoundKeys", 5)
    end

    return (setmetatable(
        {
            State = v2,
            Settings = Settings,
            BoundKeys = v3,
            Character = v1,
            Humanoid = Humanoid,
            Root = HumanoidRootPart,
            LastCombatAt = 0,
            PadHeld = false,
            PadToggled = false,
            LastTapTime = 0,
            LastTapKey = nil,
            Connections = {},
            BehaviorConnections = {}
        },
        t
    ))
end

function t.IsSprinting(arg1) -- line: 87
    return arg1.State:IsSprinting()
end

function t.SetSprintKeyUsed(t1: table, b1: boolean) -- line: 93
    t1.Character:SetAttribute("SprintKeyUsed", b1 or nil)
end

function t.StartSprinting(t2: table, b2: boolean?) -- line: 98
    if not b2 then
        t2:SetSprintKeyUsed(true)
    end

    if t2.State:IsSprinting() then
        return
    end

    if not t2.State:CanSprint() then
        return
    end

    t2.State:AddState("Sprinting")
end

function t.StopSprinting(arg2) -- line: 114
    arg2:SetSprintKeyUsed(false)

    if not arg2.State:IsSprinting() then
        return
    end

    arg2.State:RemoveState("Sprinting")
end

function t.IsAutoRunOn(arg3) -- line: 124
    local AutoRun = arg3.Settings:FindFirstChild("AutoRun")

    return if AutoRun ~= nil then AutoRun.Value == true else false
end

function t.IsMovingForward(arg4) -- line: 131
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] UserInputService (copy)

    local MoveDirection = arg4.Humanoid.MoveDirection

    if MoveDirection.Magnitude <= 0 then
        return false
    end

    for _, val in t_5 do
        if UserInputService:IsKeyDown(val) then
            return UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(
                Enum.KeyCode.Up
            )
        end
    end

    return not (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter or not arg4.Humanoid.AutoRotate) or MoveDirection.Unit:Dot(
        arg4.Root.CFrame.LookVector
    ) >= 0.5 and true
end

function t.UpdateAutoRun(arg5) -- line: 149
    -- upvalues:
    --  [1] t_3 (copy)

    if not arg5:IsAutoRunOn() then
        return
    end

    if arg5.State:HasAnyState(table.unpack(t_3)) then
        arg5.LastCombatAt = os.clock()
    end

    local v9 = arg5.Humanoid.MoveDirection.Magnitude > 0
    local v10 = arg5:IsMovingForward()
    local v11 = if arg5.Character:GetAttribute("SprintKeyUsed") ~= true then false else true

    if v10 then
        if not arg5.State:IsSprinting() then
            if os.clock() - arg5.LastCombatAt >= 0.75 then
                arg5:StartSprinting(true)

                return
            end
        elseif arg5.State:IsSprinting() and (not v9 or not v10 and not v11) then
            arg5:StopSprinting()
        end

        return
    end

    if arg5.State:IsSprinting() and (not v9 or not v10 and not v11) then
        arg5:StopSprinting()
    end
end

function t.SetSprinting(t3: table, b3: boolean) -- line: 171
    if b3 then
        t3:StartSprinting()

        return
    end

    t3:StopSprinting()
end

function t.IsMovementInputDown(arg6) -- line: 179
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] t_1 (copy)

    if (arg6.PadHeld or arg6.PadToggled) and arg6.Humanoid.MoveDirection.Magnitude > 0 then
        return true
    end

    if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        return UserInputService:IsKeyDown(Enum.KeyCode.W)
    end

    for _, val_1 in t_1 do
        if UserInputService:IsKeyDown(val_1) then
            return true
        end

        if UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, val_1) then
            return true
        end
    end

    return false
end

function t.Reevaluate(arg7) -- line: 205
    if not arg7:IsMovementInputDown() then
        arg7:StopSprinting()
    end
end

function t.ClearBehaviorConnections(arg8) -- line: 211
    for _, val_2 in arg8.BehaviorConnections do
        val_2:Disconnect()
    end

    table.clear(arg8.BehaviorConnections)
end

function t.BindHoldSprint(arg9) -- line: 219
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] t_4 (copy)
    --  [3] UserInputService (copy)
    --  [4] t_1 (copy)

    arg9:ClearBehaviorConnections()
    ContextActionService:UnbindAction("Sprint")

    if arg9.BoundKeys then
        arg9.BoundKeys.Value = "LeftAlt,RightAlt,ButtonR3"
    end

    ContextActionService:BindAction("Sprint", function(_, arg11) -- line: 231
        -- upvalues:
        --  [1] arg9 (copy)

        if arg11 == Enum.UserInputState.Begin then
            if arg9:IsMovementInputDown() then
                arg9:StartSprinting()
            end
        elseif arg11 == Enum.UserInputState.End then
            arg9:StopSprinting()
        end

        return Enum.ContextActionResult.Pass
    end, false, table.unpack(t_4))
    table.insert(arg9.BehaviorConnections, UserInputService.InputBegan:Connect(function(
        input,
        gameProcessedEvent
    ) -- line: 249
        -- upvalues:
        --  [1] t_1 (ref)
        --  [2] ContextActionService (ref)
        --  [3] UserInputService (ref)
        --  [4] arg9 (copy)

        if gameProcessedEvent then
            return
        end

        if table.find(t_1, input.KeyCode) then
            if ContextActionService:GetButton("Sprint") then
                return
            end

            if not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                if UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                    arg9:StartSprinting()
                end
            else
                arg9:StartSprinting()
            end
        end
    end))
    table.insert(arg9.BehaviorConnections, UserInputService.InputEnded:Connect(function(input_1) -- line: 270
        -- upvalues:
        --  [1] t_1 (ref)
        --  [2] arg9 (copy)

        if table.find(t_1, input_1.KeyCode) then
            arg9:Reevaluate()
        end
    end))
    local BehaviorConnections_2 = arg9.BehaviorConnections
    local MouseBehavior = UserInputService:GetPropertyChangedSignal("MouseBehavior")
    table.insert(BehaviorConnections_2, MouseBehavior:Connect(function() -- line: 281
        -- upvalues:
        --  [1] arg9 (copy)

        arg9:Reevaluate()
    end))
end

function t.BindDoubleTapSprint(arg15) -- line: 287
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] UserInputService (copy)
    --  [3] t_1 (copy)

    arg15:ClearBehaviorConnections()
    ContextActionService:UnbindAction("Sprint")

    if arg15.BoundKeys then
        arg15.BoundKeys.Value = "LeftShift,RightShift,ButtonR3"
    end

    table.insert(arg15.BehaviorConnections, UserInputService.InputBegan:Connect(function(
        input_2,
        gameProcessedEvent_1
    ) -- line: 298
        -- upvalues:
        --  [1] t_1 (ref)
        --  [2] UserInputService (ref)
        --  [3] arg15 (copy)

        if gameProcessedEvent_1 and input_2.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return
        end

        local KeyCode = input_2.KeyCode

        if not table.find(t_1, KeyCode) then
            return
        end

        if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter and KeyCode ~= Enum.KeyCode.W then
            return
        end

        local v13 = time()

        if arg15.LastTapKey == KeyCode and v13 - arg15.LastTapTime <= 0.25 then
            arg15:StartSprinting()
            arg15.LastTapKey = nil
            arg15.LastTapTime = 0

            return
        end

        arg15.LastTapKey = KeyCode
        arg15.LastTapTime = v13
    end))
    table.insert(arg15.BehaviorConnections, UserInputService.InputEnded:Connect(function(input_3) -- line: 335
        -- upvalues:
        --  [1] t_1 (ref)
        --  [2] arg15 (copy)

        if table.find(t_1, input_3.KeyCode) then
            arg15:Reevaluate()
        end
    end))
    local BehaviorConnections_5 = arg15.BehaviorConnections
    local MouseBehavior_1 = UserInputService:GetPropertyChangedSignal("MouseBehavior")
    table.insert(BehaviorConnections_5, MouseBehavior_1:Connect(function() -- line: 346
        -- upvalues:
        --  [1] arg15 (copy)

        arg15:Reevaluate()
    end))
end

function t.UpdateBehavior(arg19) -- line: 352
    arg19:StopSprinting()

    if arg19.Settings.DoubleTapToSprint.Value then
        arg19:BindDoubleTapSprint()

        return
    end

    arg19:BindHoldSprint()
end

function t.Start(arg20) -- line: 362
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] GamepadLayer_m (copy)

    local Connections = arg20.Connections
    local Value = arg20.Settings.DoubleTapToSprint:GetPropertyChangedSignal("Value")
    table.insert(Connections, Value:Connect(function() -- line: 367
        -- upvalues:
        --  [1] arg20 (copy)

        arg20:UpdateBehavior()
    end))
    arg20:UpdateBehavior()
    local AutoRun_1 = arg20.Settings:FindFirstChild("AutoRun")

    if AutoRun_1 then
        table.insert(arg20.Connections, AutoRun_1:GetPropertyChangedSignal("Value"):Connect(function() -- line: 379
            -- upvalues:
            --  [1] arg20 (copy)

            arg20:StopSprinting()
        end))
    end

    local Connections_2 = arg20.Connections
    table.insert(Connections_2, RunService.Heartbeat:Connect(function() -- line: 386
        -- upvalues:
        --  [1] arg20 (copy)

        arg20:UpdateAutoRun()
    end))
    local v16 = 0
    local v17 = false

    local function refreshGamepadSprint() -- line: 398
        -- upvalues:
        --  [1] arg20 (copy)

        if not arg20.PadHeld and not arg20.PadToggled then
            return
        end

        if arg20.Humanoid.MoveDirection.Magnitude > 0 then
            arg20:StartSprinting()

            return
        end

        arg20:StopSprinting()

        if not arg20.PadHeld then
            arg20.PadToggled = false
        end
    end

    GamepadLayer_m.setButton(Enum.KeyCode.ButtonL3, function() -- line: 413
        -- upvalues:
        --  [1] v16 (ref)
        --  [2] v17 (ref)
        --  [3] arg20 (copy)

        v16 = os.clock()
        v17 = arg20.PadToggled
        arg20.PadHeld = true

        if not arg20.PadHeld and not arg20.PadToggled then
            return
        end

        if arg20.Humanoid.MoveDirection.Magnitude > 0 then
            arg20:StartSprinting()

            return
        end

        arg20:StopSprinting()

        if not arg20.PadHeld then
            arg20.PadToggled = false
        end
    end, function() -- line: 418
        -- upvalues:
        --  [1] arg20 (copy)
        --  [2] v16 (ref)
        --  [3] GamepadLayer_m (ref)
        --  [4] v17 (ref)

        arg20.PadHeld = false

        if os.clock() - v16 < GamepadLayer_m.HOLD_TIME then
            arg20.PadToggled = not v17
        else
            arg20.PadToggled = false
        end

        if arg20.PadToggled then
            if not arg20.PadHeld and not arg20.PadToggled then
                return
            end

            if arg20.Humanoid.MoveDirection.Magnitude > 0 then
                arg20:StartSprinting()

                return
            end

            arg20:StopSprinting()

            if not arg20.PadHeld then
                arg20.PadToggled = false

                return
            end
        else
            arg20:StopSprinting()
        end
    end)
    table.insert(
        arg20.Connections,
        arg20.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(refreshGamepadSprint)
    )
end

function t.Stop(arg21) -- line: 442
    -- upvalues:
    --  [1] ContextActionService (copy)

    arg21:StopSprinting()
    arg21:ClearBehaviorConnections()
    ContextActionService:UnbindAction("Sprint")
end

function t.Destroy(arg22) -- line: 450
    arg22:Stop()

    for _, val_3 in arg22.Connections do
        val_3:Disconnect()
    end

    table.clear(arg22.Connections)
end

return t
