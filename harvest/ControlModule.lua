-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule
-- Class: ModuleScript
-- bytes: 25509

local t = {}
t.__index = t
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local VRService = game:GetService("VRService")
local _ = script.Parent:WaitForChild("CommonUtils")
local Keyboard_m = require(script:WaitForChild("Keyboard"))
local Gamepad_m = require(script:WaitForChild("Gamepad"))
local DynamicThumbstick_m = require(script:WaitForChild("DynamicThumbstick"))
local Success, Result = pcall(function() -- line: 34
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v4 = Success and Result
local TouchThumbstick_m = require(script:WaitForChild("TouchThumbstick"))
local ClickToMoveController_m = require(script:WaitForChild("ClickToMoveController"))
local TouchJump_m = require(script:WaitForChild("TouchJump"))
local VehicleController_m = require(script:WaitForChild("VehicleController"))
local Value = Enum.ContextActionPriority.Medium.Value
local t_1 = {
    [Enum.TouchMovementMode.DPad] = DynamicThumbstick_m,
    [Enum.DevTouchMovementMode.DPad] = DynamicThumbstick_m,
    [Enum.TouchMovementMode.Thumbpad] = DynamicThumbstick_m,
    [Enum.DevTouchMovementMode.Thumbpad] = DynamicThumbstick_m,
    [Enum.TouchMovementMode.Thumbstick] = TouchThumbstick_m,
    [Enum.DevTouchMovementMode.Thumbstick] = TouchThumbstick_m,
    [Enum.TouchMovementMode.DynamicThumbstick] = DynamicThumbstick_m,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = DynamicThumbstick_m,
    [Enum.TouchMovementMode.ClickToMove] = ClickToMoveController_m,
    [Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController_m,
    [Enum.TouchMovementMode.Default] = DynamicThumbstick_m,
    [Enum.ComputerMovementMode.Default] = Keyboard_m,
    [Enum.ComputerMovementMode.KeyboardMouse] = Keyboard_m,
    [Enum.DevComputerMovementMode.KeyboardMouse] = Keyboard_m,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController_m,
    [Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController_m
}
local t_2 = {
    [Enum.UserInputType.Keyboard] = Keyboard_m,
    [Enum.UserInputType.MouseButton1] = Keyboard_m,
    [Enum.UserInputType.MouseButton2] = Keyboard_m,
    [Enum.UserInputType.MouseButton3] = Keyboard_m,
    [Enum.UserInputType.MouseWheel] = Keyboard_m,
    [Enum.UserInputType.MouseMovement] = Keyboard_m,
    [Enum.UserInputType.Gamepad1] = Gamepad_m,
    [Enum.UserInputType.Gamepad2] = Gamepad_m,
    [Enum.UserInputType.Gamepad3] = Gamepad_m,
    [Enum.UserInputType.Gamepad4] = Gamepad_m
}
local v9 = nil

function t.new() -- line: 93
    -- upvalues:
    --  [1] t (copy)
    --  [2] Players (copy)
    --  [3] VehicleController_m (copy)
    --  [4] Value (copy)
    --  [5] RunService (copy)
    --  [6] UserInputService (copy)
    --  [7] UserGameSettings (copy)
    --  [8] GuiService (copy)

    local t_3 = setmetatable({}, t)
    t_3.controllers = {}
    t_3.activeControlModule = nil
    t_3.activeController = nil
    t_3.touchJumpController = nil
    t_3.moveFunction = Players.LocalPlayer.Move
    t_3.humanoid = nil
    t_3.lastInputType = Enum.UserInputType.None
    t_3.controlsEnabled = true
    t_3.humanoidSeatedConn = nil
    t_3.vehicleController = nil
    t_3.touchControlFrame = nil
    t_3.currentTorsoAngle = 0
    t_3.inputMoveVector = Vector3.new(0, 0, 0)
    t_3.vehicleController = VehicleController_m.new(Value)
    Players.LocalPlayer.CharacterAdded:Connect(function(character) -- line: 119
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:OnCharacterAdded(character)
    end)
    Players.LocalPlayer.CharacterRemoving:Connect(function(character_1) -- line: 120
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:OnCharacterRemoving(character_1)
    end)

    if Players.LocalPlayer.Character then
        t_3:OnCharacterAdded(Players.LocalPlayer.Character)
    end

    RunService:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(
        arg3
    ) -- line: 125
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:OnRenderStepped(arg3)
    end)
    UserInputService.LastInputTypeChanged:Connect(function(lastInputType) -- line: 129
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:OnLastInputTypeChanged(lastInputType)
    end)
    UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- line: 134
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:OnTouchMovementModeChange()
    end)
    Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- line: 137
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:OnTouchMovementModeChange()
    end)
    UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() -- line: 141
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:OnComputerMovementModeChange()
    end)
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- line: 144
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:OnComputerMovementModeChange()
    end)
    t_3.playerGui = nil
    t_3.touchGui = nil
    t_3.playerGuiAddedConn = nil
    GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() -- line: 153
        -- upvalues:
        --  [1] t_3 (copy)

        t_3:UpdateTouchGuiVisibility()
        t_3:UpdateActiveControlModuleEnabled()
    end)

    if UserInputService.TouchEnabled then
        t_3.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

        if t_3.playerGui then
            t_3:CreateTouchGuiContainer()
            t_3:OnLastInputTypeChanged(UserInputService:GetLastInputType())

            return t_3
        end

        t_3.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(child) -- line: 164
            -- upvalues:
            --  [1] t_3 (copy)
            --  [2] UserInputService (ref)

            if child:IsA("PlayerGui") then
                t_3.playerGui = child
                t_3:CreateTouchGuiContainer()
                t_3.playerGuiAddedConn:Disconnect()
                t_3.playerGuiAddedConn = nil
                t_3:OnLastInputTypeChanged(UserInputService:GetLastInputType())
            end
        end)

        return t_3
    else
        t_3:OnLastInputTypeChanged(UserInputService:GetLastInputType())

        return t_3
    end
end

function t.GetMoveVector(arg6) -- line: 184
    if arg6.activeController then
        return arg6.activeController:GetMoveVector()
    end

    return Vector3.new(0, 0, 0)
end

local _ = function(arg7) --[[ NormalizeAngle ]] -- line: 191
    arg7 = (arg7 + 12.566370614359172) % 6.283185307179586
    arg7 = if not (arg7 > 3.141592653589793) then arg7 else arg7 - 6.283185307179586

    return arg7
end

local _ = function(arg8, arg9) --[[ AverageAngle ]] -- line: 199
    local v11 = (arg9 - arg8 + 12.566370614359172) % 6.283185307179586
    v11 = if not (v11 > 3.141592653589793) then v11 else v11 - 6.283185307179586
    local v12 = (arg8 + v11 / 2 + 12.566370614359172) % 6.283185307179586
    v12 = if not (v12 > 3.141592653589793) then v12 else v12 - 6.283185307179586

    return v12
end

function t.GetEstimatedVRTorsoFrame(arg10) -- line: 204
    -- upvalues:
    --  [1] VRService (copy)

    local v13 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
    local _, v15, _ = v13:ToEulerAnglesYXZ()
    v15 = -v15
    local v18, v19, v20, v21, v22, v23, v24, v25

    if VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) then
        if not VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
            arg10.currentTorsoAngle = v15
        else
            v18 = v13.Position - VRService:GetUserCFrame(Enum.UserCFrame.LeftHand).Position
            v19 = v13.Position - VRService:GetUserCFrame(Enum.UserCFrame.RightHand).Position
            v20 = -math.atan2(v18.X, v18.Z)
            v21 = (-math.atan2(v19.X, v19.Z) - v20 + 12.566370614359172) % 6.283185307179586

            if v21 > 3.141592653589793 then
                v21 -= 6.283185307179586
            end

            v22 = (v20 + v21 / 2 + 12.566370614359172) % 6.283185307179586
            v22 = if not (v22 > 3.141592653589793) then v22 else v22 - 6.283185307179586
            v23 = (v15 - arg10.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
            v23 = if not (v23 > 3.141592653589793) then v23 else v23 - 6.283185307179586
            v24 = (v22 - arg10.currentTorsoAngle + 12.566370614359172) % 6.283185307179586

            if v24 > 3.141592653589793 then
                v24 -= 6.283185307179586
            end

            v22 = v24 > -1.5707963267948966 and v24 < 1.5707963267948966

            if not v22 then
                v24 = v23
            end

            v22 = math.min(v24, v23)
            v25 = math.max(v24, v23)
            v23 = 0

            if v22 > 0 then
                v23 = v22
            elseif v25 < 0 then
                v23 = v25
            end

            arg10.currentTorsoAngle = v23 + arg10.currentTorsoAngle
        end
    else
        arg10.currentTorsoAngle = v15
        v18 = v13.Position - VRService:GetUserCFrame(Enum.UserCFrame.LeftHand).Position
        v19 = v13.Position - VRService:GetUserCFrame(Enum.UserCFrame.RightHand).Position
        v20 = -math.atan2(v18.X, v18.Z)
        v21 = (-math.atan2(v19.X, v19.Z) - v20 + 12.566370614359172) % 6.283185307179586

        if v21 > 3.141592653589793 then
            v21 -= 6.283185307179586
        end

        v22 = (v20 + v21 / 2 + 12.566370614359172) % 6.283185307179586
        v22 = if not (v22 > 3.141592653589793) then v22 else v22 - 6.283185307179586
        v23 = (v15 - arg10.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
        v23 = if not (v23 > 3.141592653589793) then v23 else v23 - 6.283185307179586
        v24 = (v22 - arg10.currentTorsoAngle + 12.566370614359172) % 6.283185307179586

        if v24 > 3.141592653589793 then
            v24 -= 6.283185307179586
        end

        v22 = v24 > -1.5707963267948966 and v24 < 1.5707963267948966

        if not v22 then
            v24 = v23
        end

        v22 = math.min(v24, v23)
        v25 = math.max(v24, v23)
        v23 = 0

        if v22 > 0 then
            v23 = v22
        elseif v25 < 0 then
            v23 = v25
        end

        arg10.currentTorsoAngle = v23 + arg10.currentTorsoAngle
    end

    return CFrame.new(v13.Position) * CFrame.fromEulerAnglesYXZ(0, -arg10.currentTorsoAngle, 0)
end

function t.GetActiveController(arg11) -- line: 248
    return arg11.activeController
end

function t.UpdateActiveControlModuleEnabled(arg12) -- line: 253
    -- upvalues:
    --  [1] Players (copy)
    --  [2] ClickToMoveController_m (copy)
    --  [3] TouchThumbstick_m (copy)
    --  [4] DynamicThumbstick_m (copy)
    --  [5] TouchJump_m (copy)
    --  [6] GuiService (copy)
    --  [7] UserInputService (copy)

    local _ = function() -- line: 255
        -- upvalues:
        --  [1] arg12 (copy)
        --  [2] Players (ref)

        arg12.activeController:Enable(false)

        if arg12.touchJumpController then
            arg12.touchJumpController:Enable(false)
        end

        if arg12.moveFunction then
            arg12.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true)
        end
    end

    if not arg12.activeController then
        return
    end

    if not arg12.controlsEnabled then
        arg12.activeController:Enable(false)

        if arg12.touchJumpController then
            arg12.touchJumpController:Enable(false)
        end

        if arg12.moveFunction then
            arg12.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true)
        end

        return
    end

    if not GuiService.TouchControlsEnabled and (UserInputService.TouchEnabled and (arg12.activeControlModule == ClickToMoveController_m or (arg12.activeControlModule == TouchThumbstick_m or arg12.activeControlModule == DynamicThumbstick_m))) then
        arg12.activeController:Enable(false)

        if arg12.touchJumpController then
            arg12.touchJumpController:Enable(false)
        end

        if arg12.moveFunction then
            arg12.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true)
        end

        return
    end

    (function() -- line: 266
        -- upvalues:
        --  [1] arg12 (copy)
        --  [2] ClickToMoveController_m (ref)
        --  [3] TouchThumbstick_m (ref)
        --  [4] DynamicThumbstick_m (ref)
        --  [5] TouchJump_m (ref)
        --  [6] Players (ref)

        if arg12.touchControlFrame and (arg12.activeControlModule == ClickToMoveController_m or (arg12.activeControlModule == TouchThumbstick_m or arg12.activeControlModule == DynamicThumbstick_m)) then
            if not arg12.controllers[TouchJump_m] then
                arg12.controllers[TouchJump_m] = TouchJump_m.new()
            end

            arg12.touchJumpController = arg12.controllers[TouchJump_m]
            arg12.touchJumpController:Enable(true, arg12.touchControlFrame)
        elseif arg12.touchJumpController then
            arg12.touchJumpController:Enable(false)
        end

        if arg12.activeControlModule == ClickToMoveController_m then
            local v28 = Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice
            arg12.activeController:Enable(true, v28, arg12.touchJumpController)

            return
        end

        if arg12.touchControlFrame then
            arg12.activeController:Enable(true, arg12.touchControlFrame)

            return
        end

        arg12.activeController:Enable(true)
    end)()
end

function t.Enable(t1: table, b1: boolean?) -- line: 325
    if b1 == nil then
        b1 = true
    end

    t1.controlsEnabled = b1

    if not t1.activeController then
        return
    end

    t1:UpdateActiveControlModuleEnabled()
end

function t.Disable(arg13) -- line: 339
    arg13.controlsEnabled = false
    arg13:UpdateActiveControlModuleEnabled()
end

function t.SelectComputerMovementModule(_) -- line: 347
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] Players (copy)
    --  [3] t_2 (copy)
    --  [4] v9 (ref)
    --  [5] UserGameSettings (copy)
    --  [6] Keyboard_m (copy)
    --  [7] ClickToMoveController_m (copy)
    --  [8] t_1 (copy)

    if not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled then
        return nil, false
    end

    local DevComputerMovementMode_1 = Players.LocalPlayer.DevComputerMovementMode
    local v29

    if DevComputerMovementMode_1 == Enum.DevComputerMovementMode.UserChoice then
        v29 = t_2[v9]

        if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v29 == Keyboard_m then
            v29 = ClickToMoveController_m
        end
    else
        v29 = t_1[DevComputerMovementMode_1]

        if not v29 and DevComputerMovementMode_1 ~= Enum.DevComputerMovementMode.Scriptable then
            warn(
                "No character control module is associated with DevComputerMovementMode ",
                DevComputerMovementMode_1
            )
        end
    end

    if v29 then
        return v29, true
    end

    if DevComputerMovementMode_1 == Enum.DevComputerMovementMode.Scriptable then
        return nil, true
    end

    return nil, false
end

function t.SelectTouchModule(_) -- line: 385
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] Players (copy)
    --  [3] t_1 (copy)
    --  [4] UserGameSettings (copy)

    if not UserInputService.TouchEnabled then
        return nil, false
    end

    local DevTouchMovementMode_1 = Players.LocalPlayer.DevTouchMovementMode
    local v30

    if DevTouchMovementMode_1 == Enum.DevTouchMovementMode.UserChoice then
        v30 = t_1[UserGameSettings.TouchMovementMode]
    else
        if DevTouchMovementMode_1 == Enum.DevTouchMovementMode.Scriptable then
            return nil, true
        end

        v30 = t_1[DevTouchMovementMode_1]
    end

    return v30, true
end

local function getGamepadRightThumbstickPosition() -- line: 401
    -- upvalues:
    --  [1] UserInputService (copy)

    for _, val in pairs((UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1))) do
        if val.KeyCode == Enum.KeyCode.Thumbstick2 then
            return val.Position
        end
    end

    return Vector3.new(0, 0, 0)
end

function t.calculateRawMoveVector(t2: table, u1: userdata, vec1: Vector3) -- line: 411
    -- upvalues:
    --  [1] Workspace (copy)
    --  [2] VRService (copy)
    --  [3] getGamepadRightThumbstickPosition (copy)

    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return vec1
    end

    local v32 = CurrentCamera.CFrame

    if VRService.VREnabled and u1.RootPart then
        local _ = VRService:GetUserCFrame(Enum.UserCFrame.Head)
        local v34 = t2:GetEstimatedVRTorsoFrame()

        if (CurrentCamera.Focus.Position - v32.Position).Magnitude < 3 then
            v32 *= v34
        else
            v32 = CurrentCamera.CFrame * (v34.Rotation + v34.Position * CurrentCamera.HeadScale)
        end
    end

    if u1:GetState() == Enum.HumanoidStateType.Swimming then
        if VRService.VREnabled then
            vec1 = Vector3.new(vec1.X, 0, vec1.Z)

            if vec1.Magnitude < 0.01 then
                return Vector3.new(0, 0, 0)
            end

            local v35 = -getGamepadRightThumbstickPosition().Y * 1.3962634015954636
            local v36 = math.atan2(-vec1.X, -vec1.Z)
            local _, v38, _ = v32:ToEulerAnglesYXZ()

            return CFrame.fromEulerAnglesYXZ(v35, v36 + v38, 0).LookVector
        else
            return v32:VectorToWorldSpace(vec1)
        end
    else
        local _, _, _, v43, v44, v45, _, _, v48, _, _, v51 = v32:GetComponents()
        local v52, v53

        if v48 < 1 and v48 > -1 then
            v52 = v51
            v53 = v45
        else
            v52 = v43
            v53 = -v44 * math.sign(v48)
        end

        local v55 = math.sqrt(v52 * v52 + v53 * v53)

        return (Vector3.new(
            (v52 * vec1.X + v53 * vec1.Z) / v55,
            0,
            (v52 * vec1.Z - v53 * vec1.X) / v55
        ))
    end
end

function t.OnRenderStepped(arg16, arg17) -- line: 470
    -- upvalues:
    --  [1] Gamepad_m (copy)
    --  [2] VRService (copy)
    --  [3] Players (copy)

    if arg16.activeController and arg16.activeController.enabled and arg16.humanoid then
        local v56 = arg16.activeController:GetMoveVector()
        local v57 = arg16.activeController:IsMoveVectorCameraRelative()
        local v58 = arg16:GetClickToMoveController()

        if arg16.activeController == v58 then
            v58:OnRenderStepped(arg17)
        elseif v56.magnitude > 0 then
            v58:CleanupPath()
        else
            v58:OnRenderStepped(arg17)
            v56 = v58:GetMoveVector()
            v57 = v58:IsMoveVectorCameraRelative()
        end

        if arg16.vehicleController then
            local v59 = arg16.activeControlModule == Gamepad_m
            local _
            v56, _ = arg16.vehicleController:Update(v56, v57, v59)
        end

        if v57 then
            v56 = arg16:calculateRawMoveVector(arg16.humanoid, v56)
        end

        arg16.inputMoveVector = v56

        if VRService.VREnabled then
            v56 = arg16:updateVRMoveVector(v56)
        end

        arg16.moveFunction(Players.LocalPlayer, v56, false)
        local Humanoid = arg16.humanoid
        Humanoid.Jump = arg16.activeController:GetIsJumping() or arg16.touchJumpController and arg16.touchJumpController:GetIsJumping()
    end
end

function t.updateVRMoveVector(arg18, arg19) -- line: 519
    -- upvalues:
    --  [1] VRService (copy)

    local CurrentCamera_1 = workspace.CurrentCamera
    local v62 = (CurrentCamera_1.Focus.Position - CurrentCamera_1.CFrame.Position).Magnitude < 5 and true

    if arg19.Magnitude == 0 and (v62 and (VRService.AvatarGestures and (arg18.humanoid and not arg18.humanoid.Sit))) then
        local v63 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
        local v65 = (CurrentCamera_1.CFrame * (v63.Rotation + v63.Position * CurrentCamera_1.HeadScale) * CFrame.new(
            0,
            -0.7 * arg18.humanoid.RootPart.Size.Y / 2,
            0
        )).Position - arg18.humanoid.RootPart.CFrame.Position

        return (Vector3.new(v65.x, 0, v65.z))
    end

    return arg19
end

function t.OnHumanoidSeated(t3: table, b2: boolean, u2: userdata) -- line: 544
    -- upvalues:
    --  [1] Value (copy)

    if b2 then
        if u2 and u2:IsA("VehicleSeat") then
            if not t3.vehicleController then
                t3.vehicleController = t3.vehicleController.new(Value)
            end

            t3.vehicleController:Enable(true, u2)

            return
        end
    elseif t3.vehicleController then
        t3.vehicleController:Enable(false, u2)
    end
end

function t.OnCharacterAdded(arg20, arg21) -- line: 559
    arg20.humanoid = arg21:FindFirstChildOfClass("Humanoid")

    while true do
        if arg20.humanoid then
            break
        end

        arg21.ChildAdded:wait()
        arg20.humanoid = arg21:FindFirstChildOfClass("Humanoid")
    end

    arg20:UpdateTouchGuiVisibility()

    if arg20.humanoidSeatedConn then
        arg20.humanoidSeatedConn:Disconnect()
        arg20.humanoidSeatedConn = nil
    end

    arg20.humanoidSeatedConn = arg20.humanoid.Seated:Connect(function(active, currentSeatPart) -- line: 572
        -- upvalues:
        --  [1] arg20 (copy)

        arg20:OnHumanoidSeated(active, currentSeatPart)
    end)
end

function t.OnCharacterRemoving(arg24, _) -- line: 577
    arg24.humanoid = nil
    arg24:UpdateTouchGuiVisibility()
end

function t.UpdateTouchGuiVisibility(arg26) -- line: 583
    -- upvalues:
    --  [1] GuiService (copy)

    if arg26.touchGui then
        local v66 = arg26.humanoid and GuiService.TouchControlsEnabled
        arg26.touchGui.Enabled = not (not v66)
    end
end

function t.SwitchToController(arg27, arg28) -- line: 597
    -- upvalues:
    --  [1] Value (copy)

    if not arg28 then
        if arg27.activeController then
            arg27.activeController:Enable(false)
        end

        arg27.activeController = nil
        arg27.activeControlModule = nil

        return
    end

    if not arg27.controllers[arg28] then
        arg27.controllers[arg28] = arg28.new(Value)
    end

    if arg27.activeController ~= arg27.controllers[arg28] then
        if arg27.activeController then
            arg27.activeController:Enable(false)
        end

        arg27.activeController = arg27.controllers[arg28]
        arg27.activeControlModule = arg28
        arg27:UpdateActiveControlModuleEnabled()
    end
end

function t.OnLastInputTypeChanged(arg29, arg30) -- line: 625
    -- upvalues:
    --  [1] v9 (ref)
    --  [2] t_2 (copy)

    if v9 == arg30 then
        warn("LastInputType Change listener called with current type.")
    end

    v9 = arg30

    if v9 == Enum.UserInputType.Touch then
        local v67, v68 = arg29:SelectTouchModule()

        if v68 then
            while true do
                if arg29.touchControlFrame then
                    break
                end

                wait()
            end

            arg29:SwitchToController(v67)
        end
    elseif t_2[v9] ~= nil then
        local v69 = arg29:SelectComputerMovementModule()

        if v69 then
            arg29:SwitchToController(v69)
        end
    end

    arg29:UpdateTouchGuiVisibility()
end

function t.OnComputerMovementModeChange(arg31) -- line: 652
    local v70, v71 = arg31:SelectComputerMovementModule()

    if v71 then
        arg31:SwitchToController(v70)
    end
end

function t.OnTouchMovementModeChange(arg32) -- line: 659
    local v72, v73 = arg32:SelectTouchModule()

    if v73 then
        while true do
            if arg32.touchControlFrame then
                break
            end

            wait()
        end

        arg32:SwitchToController(v72)
    end
end

function t.CreateTouchGuiContainer(arg33) -- line: 669
    -- upvalues:
    --  [1] v4 (ref)

    if arg33.touchGui then
        arg33.touchGui:Destroy()
    end

    arg33.touchGui = Instance.new("ScreenGui")
    arg33.touchGui.Name = "TouchGui"
    arg33.touchGui.ResetOnSpawn = false
    arg33.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    arg33:UpdateTouchGuiVisibility()

    if v4 then
        arg33.touchGui.ClipToDeviceSafeArea = false
    end

    arg33.touchControlFrame = Instance.new("Frame")
    arg33.touchControlFrame.Name = "TouchControlFrame"
    arg33.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
    arg33.touchControlFrame.BackgroundTransparency = 1
    arg33.touchControlFrame.Parent = arg33.touchGui
    arg33.touchGui.Parent = arg33.playerGui
end

function t.GetClickToMoveController(arg34) -- line: 692
    -- upvalues:
    --  [1] ClickToMoveController_m (copy)
    --  [2] Value (copy)

    if not arg34.controllers[ClickToMoveController_m] then
        arg34.controllers[ClickToMoveController_m] = ClickToMoveController_m.new(Value)
    end

    return arg34.controllers[ClickToMoveController_m]
end

return t.new()
