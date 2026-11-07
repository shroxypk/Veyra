-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.BaseCamera
-- Class: ModuleScript
-- bytes: 25931

local FlagUtil_m = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
)
local Success, Result = pcall(function() -- line: 15
    return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom")
end)
local v2 = Success and Result
local UserFixCameraOffsetJitter2 = FlagUtil_m.getUserFlag("UserFixCameraOffsetJitter2")
local CameraUtils_m = require(script.Parent:WaitForChild("CameraUtils"))
local ZoomController_m = require(script.Parent:WaitForChild("ZoomController"))
local CameraToggleStateController_m = require(
    script.Parent:WaitForChild("CameraToggleStateController")
)
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI_m = require(script.Parent:WaitForChild("CameraUI"))
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local _ = game:GetService("StarterGui")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local LocalPlayer = Players.LocalPlayer
local t = {}
t.__index = t

function t.new() -- line: 72
    -- upvalues:
    --  [1] t (copy)
    --  [2] LocalPlayer (copy)
    --  [3] UserGameSettings (copy)

    local t_1 = setmetatable({}, t)
    t_1.gamepadZoomLevels = { 0, 10, 20 }
    t_1.FIRST_PERSON_DISTANCE_THRESHOLD = 1
    t_1.cameraType = nil
    t_1.cameraMovementMode = nil
    t_1.lastCameraTransform = nil
    t_1.lastUserPanCamera = tick()
    t_1.humanoidRootPart = nil
    t_1.humanoidCache = {}
    t_1.lastSubject = nil
    t_1.lastSubjectPosition = Vector3.new(0, 5, 0)
    t_1.lastSubjectCFrame = CFrame.new(t_1.lastSubjectPosition)
    t_1.currentSubjectDistance = math.clamp(
        12.5,
        LocalPlayer.CameraMinZoomDistance,
        LocalPlayer.CameraMaxZoomDistance
    )
    t_1.inFirstPerson = false
    t_1.inMouseLockedMode = false
    t_1.portraitMode = false
    t_1.isSmallTouchScreen = false
    t_1.resetCameraAngle = true
    t_1.enabled = false
    t_1.PlayerGui = nil
    t_1.cameraChangedConn = nil
    t_1.viewportSizeChangedConn = nil
    t_1.shouldUseVRRotation = false
    t_1.VRRotationIntensityAvailable = false
    t_1.lastVRRotationIntensityCheckTime = 0
    t_1.lastVRRotationTime = 0
    t_1.vrRotateKeyCooldown = {}
    t_1.cameraTranslationConstraints = Vector3.new(1, 1, 1)
    t_1.humanoidJumpOrigin = nil
    t_1.trackingHumanoid = nil
    t_1.cameraFrozen = false
    t_1.subjectStateChangedConn = nil
    t_1.gamepadZoomPressConnection = nil
    t_1.mouseLockOffset = Vector3.new(0, 0, 0)

    if LocalPlayer.Character then
        t_1:OnCharacterAdded(LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(function(character) -- line: 137
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:OnCharacterAdded(character)
    end)

    if t_1.playerCameraModeChangeConn then
        t_1.playerCameraModeChangeConn:Disconnect()
    end

    local CameraMode = LocalPlayer:GetPropertyChangedSignal("CameraMode")
    t_1.playerCameraModeChangeConn = CameraMode:Connect(function() -- line: 142
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:OnPlayerCameraPropertyChange()
    end)

    if t_1.minDistanceChangeConn then
        t_1.minDistanceChangeConn:Disconnect()
    end

    local CameraMinZoomDistance = LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance")
    t_1.minDistanceChangeConn = CameraMinZoomDistance:Connect(function() -- line: 147
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:OnPlayerCameraPropertyChange()
    end)

    if t_1.maxDistanceChangeConn then
        t_1.maxDistanceChangeConn:Disconnect()
    end

    local CameraMaxZoomDistance = LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance")
    t_1.maxDistanceChangeConn = CameraMaxZoomDistance:Connect(function() -- line: 152
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:OnPlayerCameraPropertyChange()
    end)

    if t_1.playerDevTouchMoveModeChangeConn then
        t_1.playerDevTouchMoveModeChangeConn:Disconnect()
    end

    local DevTouchMovementMode = LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode")
    t_1.playerDevTouchMoveModeChangeConn = DevTouchMovementMode:Connect(function() -- line: 157
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:OnDevTouchMovementModeChanged()
    end)
    t_1:OnDevTouchMovementModeChanged()

    if t_1.gameSettingsTouchMoveMoveChangeConn then
        t_1.gameSettingsTouchMoveMoveChangeConn:Disconnect()
    end

    local TouchMovementMode = UserGameSettings:GetPropertyChangedSignal("TouchMovementMode")
    t_1.gameSettingsTouchMoveMoveChangeConn = TouchMovementMode:Connect(function() -- line: 163
        -- upvalues:
        --  [1] t_1 (copy)

        t_1:OnGameSettingsTouchMovementModeChanged()
    end)
    t_1:OnGameSettingsTouchMovementModeChanged()
    UserGameSettings:SetCameraYInvertVisible()
    UserGameSettings:SetGamepadCameraSensitivityVisible()
    t_1.hasGameLoaded = game:IsLoaded()

    if not t_1.hasGameLoaded then
        t_1.gameLoadedConn = game.Loaded:Connect(function() -- line: 173
            -- upvalues:
            --  [1] t_1 (copy)

            t_1.hasGameLoaded = true
            t_1.gameLoadedConn:Disconnect()
            t_1.gameLoadedConn = nil
        end)
    end

    t_1:OnPlayerCameraPropertyChange()

    return t_1
end

function t.GetModuleName(_) -- line: 185
    return "BaseCamera"
end

function t.OnCharacterAdded(arg3, arg4) -- line: 189
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] LocalPlayer (copy)

    arg3.resetCameraAngle = arg3.resetCameraAngle or arg3:GetEnabled()
    arg3.humanoidRootPart = nil

    if UserInputService.TouchEnabled then
        arg3.PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

        for _, val in ipairs(arg4:GetChildren()) do
            if val:IsA("Tool") then
                arg3.isAToolEquipped = true
            end
        end

        arg4.ChildAdded:Connect(function(child) -- line: 199
            -- upvalues:
            --  [1] arg3 (copy)

            if child:IsA("Tool") then
                arg3.isAToolEquipped = true
            end
        end)
        arg4.ChildRemoved:Connect(function(child_1) -- line: 204
            -- upvalues:
            --  [1] arg3 (copy)

            if child_1:IsA("Tool") then
                arg3.isAToolEquipped = false
            end
        end)
    end
end

function t.GetHumanoidRootPart(arg7) -- line: 212
    -- upvalues:
    --  [1] LocalPlayer (copy)

    if not arg7.humanoidRootPart and LocalPlayer.Character then
        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            arg7.humanoidRootPart = Humanoid.RootPart
        end
    end

    return arg7.humanoidRootPart
end

function t.GetBodyPartToFollow(_: table, u1: userdata, _: boolean) -- line: 224
    if u1:GetState() == Enum.HumanoidStateType.Dead then
        local Parent = u1.Parent

        if Parent and Parent:IsA("Model") then
            return Parent:FindFirstChild("Head") or u1.RootPart
        end
    end

    return u1.RootPart
end

function t.GetSubjectCFrame(arg8) -- line: 236
    -- upvalues:
    --  [1] UserFixCameraOffsetJitter2 (copy)

    local v11 = arg8.lastSubjectCFrame
    local v12 = workspace.CurrentCamera
    local v13 = v12

    if v13 then
        v13 = v12.CameraSubject
    end

    if not v13 then
        return v11
    end

    if v13:IsA("Humanoid") then
        local v14 = v13:GetState()
        v12 = if v14 ~= Enum.HumanoidStateType.Dead then false else true
        v14 = if UserFixCameraOffsetJitter2 and arg8:GetIsMouseLocked() then Vector3.new() else v13.CameraOffset
        local v15 = v13.RootPart

        if v12 and v13.Parent and v13.Parent:IsA("Model") then
            v15 = v13.Parent:FindFirstChild("Head") or v15
        end

        if v15 and v15:IsA("BasePart") then
            local v16

            if v13.RigType == Enum.HumanoidRigType.R15 then
                if v13.AutomaticScalingEnabled then
                    v16 = Vector3.new(0, 1.5, 0)
                    local RootPart = v13.RootPart

                    if v15 == RootPart then
                        v16 += Vector3.new(0, (RootPart.Size.Y - 2) / 2, 0)
                    end
                else
                    v16 = Vector3.new(0, 2, 0)
                end
            else
                v16 = Vector3.new(0, 1.5, 0)
            end

            if v12 then
                v16 = Vector3.new(0, 0, 0)
            end

            v11 = v15.CFrame * CFrame.new(v16 + v14)
        end
    elseif v13:IsA("BasePart") then
        v11 = v13.CFrame
    elseif v13:IsA("Model") then
        v11 = if v13.PrimaryPart then v13:GetPrimaryPartCFrame() else CFrame.new()
    end

    if v11 then
        arg8.lastSubjectCFrame = v11
    end

    return v11
end

function t.GetSubjectVelocity(_) -- line: 310
    local CurrentCamera = workspace.CurrentCamera
    local v18 = CurrentCamera

    if v18 then
        v18 = CurrentCamera.CameraSubject
    end

    if not v18 then
        return Vector3.new(0, 0, 0)
    end

    if v18:IsA("BasePart") then
        return v18.Velocity
    end

    if v18:IsA("Humanoid") then
        local RootPart_1 = v18.RootPart

        if RootPart_1 then
            return RootPart_1.Velocity
        end
    elseif v18:IsA("Model") then
        local PrimaryPart = v18.PrimaryPart

        if PrimaryPart then
            return PrimaryPart.Velocity
        end
    end

    return Vector3.new(0, 0, 0)
end

function t.GetSubjectRotVelocity(_) -- line: 339
    local CurrentCamera_1 = workspace.CurrentCamera
    local v19 = CurrentCamera_1

    if v19 then
        v19 = CurrentCamera_1.CameraSubject
    end

    if not v19 then
        return Vector3.new(0, 0, 0)
    end

    if v19:IsA("BasePart") then
        return v19.RotVelocity
    end

    if v19:IsA("Humanoid") then
        local RootPart_2 = v19.RootPart

        if RootPart_2 then
            return RootPart_2.RotVelocity
        end
    elseif v19:IsA("Model") then
        local PrimaryPart_1 = v19.PrimaryPart

        if PrimaryPart_1 then
            return PrimaryPart_1.RotVelocity
        end
    end

    return Vector3.new(0, 0, 0)
end

function t.StepZoom(arg11) -- line: 368
    -- upvalues:
    --  [1] CameraInput_m (copy)
    --  [2] ZoomController_m (copy)

    local CurrentSubjectDistance = arg11.currentSubjectDistance
    local v20 = CameraInput_m.getZoomDelta()

    if math.abs(v20) > 0 then
        local v21 = if v20 > 0 then math.max(
            CurrentSubjectDistance + v20 * (CurrentSubjectDistance * 0.5 + 1),
            arg11.FIRST_PERSON_DISTANCE_THRESHOLD
        ) else math.max((CurrentSubjectDistance + v20) / (1 - v20 * 0.5), 0.5)

        if v21 < arg11.FIRST_PERSON_DISTANCE_THRESHOLD then
            v21 = 0.5
        end

        arg11:SetCameraToSubjectDistance(v21)
    end

    return ZoomController_m.GetZoomRadius()
end

function t.GetSubjectPosition(arg12) -- line: 393
    -- upvalues:
    --  [1] UserFixCameraOffsetJitter2 (copy)

    local v22 = arg12.lastSubjectPosition
    local v23 = game.Workspace.CurrentCamera
    local v24 = v23

    if v24 then
        v24 = v23.CameraSubject
    end

    if v24 then
        if v24:IsA("Humanoid") then
            local v25 = v24:GetState()
            v23 = if v25 ~= Enum.HumanoidStateType.Dead then false else true
            v25 = if UserFixCameraOffsetJitter2 and arg12:GetIsMouseLocked() then Vector3.new() else v24.CameraOffset
            local v26 = v24.RootPart

            if v23 and v24.Parent and v24.Parent:IsA("Model") then
                v26 = v24.Parent:FindFirstChild("Head") or v26
            end

            if v26 and v26:IsA("BasePart") then
                local v27

                if v24.RigType == Enum.HumanoidRigType.R15 then
                    if v24.AutomaticScalingEnabled then
                        v27 = Vector3.new(0, 1.5, 0)

                        if v26 == v24.RootPart then
                            v27 += Vector3.new(0, v24.RootPart.Size.Y / 2 - 1, 0)
                        end
                    else
                        v27 = Vector3.new(0, 2, 0)
                    end
                else
                    v27 = Vector3.new(0, 1.5, 0)
                end

                if v23 then
                    v27 = Vector3.new(0, 0, 0)
                end

                v22 = v26.CFrame.p + v26.CFrame:vectorToWorldSpace(v27 + v25)
            end
        elseif v24:IsA("VehicleSeat") then
            v22 = v24.CFrame.p + v24.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0))
        elseif v24:IsA("SkateboardPlatform") then
            v22 = v24.CFrame.p + Vector3.new(0, 5, 0)
        elseif v24:IsA("BasePart") then
            v22 = v24.CFrame.p
        elseif v24:IsA("Model") then
            v22 = if v24.PrimaryPart then v24:GetPrimaryPartCFrame().p else v24:GetModelCFrame().p
        end
    else
        return nil
    end

    arg12.lastSubject = v24
    arg12.lastSubjectPosition = v22

    return v22
end

function t.OnViewportSizeChanged(arg13) -- line: 470
    -- upvalues:
    --  [1] UserInputService (copy)

    local ViewportSize = game.Workspace.CurrentCamera.ViewportSize
    arg13.portraitMode = ViewportSize.X < ViewportSize.Y and true
    local v29 = UserInputService.TouchEnabled and (ViewportSize.Y < 500 or ViewportSize.X < 700)
    arg13.isSmallTouchScreen = v29
end

function t.OnCurrentCameraChanged(arg14) -- line: 478
    -- upvalues:
    --  [1] UserInputService (copy)

    if UserInputService.TouchEnabled then
        if arg14.viewportSizeChangedConn then
            arg14.viewportSizeChangedConn:Disconnect()
            arg14.viewportSizeChangedConn = nil
        end

        local CurrentCamera_2 = game.Workspace.CurrentCamera

        if CurrentCamera_2 then
            arg14:OnViewportSizeChanged()
            arg14.viewportSizeChangedConn = CurrentCamera_2:GetPropertyChangedSignal("ViewportSize"):Connect(
                function() -- line: 489
                    -- upvalues:
                    --  [1] arg14 (copy)

                    arg14:OnViewportSizeChanged()
                end
            )
        end
    end

    if arg14.cameraSubjectChangedConn then
        arg14.cameraSubjectChangedConn:Disconnect()
        arg14.cameraSubjectChangedConn = nil
    end

    local CurrentCamera_3 = game.Workspace.CurrentCamera

    if CurrentCamera_3 then
        arg14.cameraSubjectChangedConn = CurrentCamera_3:GetPropertyChangedSignal("CameraSubject"):Connect(
            function() -- line: 503
                -- upvalues:
                --  [1] arg14 (copy)

                arg14:OnNewCameraSubject()
            end
        )
        arg14:OnNewCameraSubject()
    end
end

function t.OnDynamicThumbstickEnabled(arg15) -- line: 510
    -- upvalues:
    --  [1] UserInputService (copy)

    if UserInputService.TouchEnabled then
        arg15.isDynamicThumbstickEnabled = true
    end
end

function t.OnDynamicThumbstickDisabled(arg16) -- line: 516
    arg16.isDynamicThumbstickEnabled = false
end

function t.OnGameSettingsTouchMovementModeChanged(arg17) -- line: 520
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] UserGameSettings (copy)

    if LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        if UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.DynamicThumbstick or UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.Default then
            arg17:OnDynamicThumbstickEnabled()

            return
        end

        arg17:OnDynamicThumbstickDisabled()
    end
end

function t.OnDevTouchMovementModeChanged(arg18) -- line: 531
    -- upvalues:
    --  [1] LocalPlayer (copy)

    if LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.DynamicThumbstick then
        arg18:OnDynamicThumbstickEnabled()

        return
    end

    arg18:OnGameSettingsTouchMovementModeChanged()
end

function t.OnPlayerCameraPropertyChange(arg19) -- line: 539
    arg19:SetCameraToSubjectDistance(arg19.currentSubjectDistance)
end

function t.InputTranslationToCameraAngleChange(_, arg21, arg22) -- line: 544
    return arg21 * arg22
end

function t.GamepadZoomPress(arg23) -- line: 550
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] v2 (ref)

    local v30 = arg23:GetCameraToSubjectDistance()
    local v31 = LocalPlayer.CameraMaxZoomDistance

    for index = #arg23.gamepadZoomLevels, 1, -1 do
        local v32 = arg23.gamepadZoomLevels[index]

        if not (v31 < v32) then
            v32 = LocalPlayer.CameraMinZoomDistance

            if v32 < LocalPlayer.CameraMinZoomDistance and (v2 and v31 == v32) then
                break
            end

            if not v2 and v31 == v32 then
                break
            end

            if v30 > v32 + (v31 - v32) / 2 then
                arg23:SetCameraToSubjectDistance(v32)

                return
            end

            v31 = v32
        end
    end

    arg23:SetCameraToSubjectDistance(arg23.gamepadZoomLevels[#arg23.gamepadZoomLevels])
end

function t.Enable(t2: table, b2: boolean) -- line: 595
    if t2.enabled ~= b2 then
        t2.enabled = b2
        t2:OnEnabledChanged()
    end
end

function t.OnEnabledChanged(arg24) -- line: 603
    -- upvalues:
    --  [1] CameraInput_m (copy)
    --  [2] LocalPlayer (copy)

    if arg24.enabled then
        CameraInput_m.setInputEnabled(true)
        arg24.gamepadZoomPressConnection = CameraInput_m.gamepadZoomPress:Connect(function() -- line: 607
            -- upvalues:
            --  [1] arg24 (copy)

            arg24:GamepadZoomPress()
        end)

        if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
            arg24.currentSubjectDistance = 0.5

            if not arg24.inFirstPerson then
                arg24:EnterFirstPerson()
            end
        end

        if arg24.cameraChangedConn then
            arg24.cameraChangedConn:Disconnect()
            arg24.cameraChangedConn = nil
        end

        arg24.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- line: 619
            -- upvalues:
            --  [1] arg24 (copy)

            arg24:OnCurrentCameraChanged()
        end)
        arg24:OnCurrentCameraChanged()

        return
    end

    CameraInput_m.setInputEnabled(false)

    if arg24.gamepadZoomPressConnection then
        arg24.gamepadZoomPressConnection:Disconnect()
        arg24.gamepadZoomPressConnection = nil
    end

    arg24:Cleanup()
end

function t.GetEnabled(arg25) -- line: 635
    return arg25.enabled
end

function t.Cleanup(arg26) -- line: 639
    -- upvalues:
    --  [1] CameraUtils_m (copy)

    if arg26.subjectStateChangedConn then
        arg26.subjectStateChangedConn:Disconnect()
        arg26.subjectStateChangedConn = nil
    end

    if arg26.viewportSizeChangedConn then
        arg26.viewportSizeChangedConn:Disconnect()
        arg26.viewportSizeChangedConn = nil
    end

    if arg26.cameraChangedConn then
        arg26.cameraChangedConn:Disconnect()
        arg26.cameraChangedConn = nil
    end

    arg26.lastCameraTransform = nil
    arg26.lastSubjectCFrame = nil
    CameraUtils_m.restoreMouseBehavior()
end

function t.UpdateMouseBehavior(arg27) -- line: 660
    -- upvalues:
    --  [1] UserGameSettings (copy)
    --  [2] CameraUI_m (copy)
    --  [3] CameraInput_m (copy)
    --  [4] CameraToggleStateController_m (copy)
    --  [5] CameraUtils_m (copy)

    local v33 = UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove

    if arg27.isCameraToggle and v33 == false then
        CameraUI_m.setCameraModeToastEnabled(true)
        CameraInput_m.enableCameraToggleInput()
        CameraToggleStateController_m(arg27.inFirstPerson)

        return
    end

    CameraUI_m.setCameraModeToastEnabled(false)
    CameraInput_m.disableCameraToggleInput()

    if arg27.inFirstPerson or arg27.inMouseLockedMode then
        CameraUtils_m.setRotationTypeOverride(Enum.RotationType.CameraRelative)
        CameraUtils_m.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)

        return
    end

    CameraUtils_m.restoreRotationType()

    if CameraInput_m.getRotationActivated() then
        CameraUtils_m.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)

        return
    end

    CameraUtils_m.restoreMouseBehavior()
end

function t.UpdateForDistancePropertyChange(arg28) -- line: 688
    arg28:SetCameraToSubjectDistance(arg28.currentSubjectDistance)
end

function t.SetCameraToSubjectDistance(t3: table, n1: number) -- line: 694
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] ZoomController_m (copy)

    local CurrentSubjectDistance_1 = t3.currentSubjectDistance

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        t3.currentSubjectDistance = 0.5

        if not t3.inFirstPerson then
            t3:EnterFirstPerson()
        end
    else
        local v34 = math.clamp(
            n1,
            LocalPlayer.CameraMinZoomDistance,
            LocalPlayer.CameraMaxZoomDistance
        )

        if v34 < 1 then
            t3.currentSubjectDistance = 0.5

            if not t3.inFirstPerson then
                t3:EnterFirstPerson()
            end
        else
            t3.currentSubjectDistance = v34

            if t3.inFirstPerson then
                t3:LeaveFirstPerson()
            end
        end
    end

    ZoomController_m.SetZoomParameters(
        t3.currentSubjectDistance,
        (math.sign(n1 - CurrentSubjectDistance_1))
    )

    return t3.currentSubjectDistance
end

function t.SetCameraType(arg29, arg30) -- line: 728
    arg29.cameraType = arg30
end

function t.GetCameraType(arg31) -- line: 733
    return arg31.cameraType
end

function t.SetCameraMovementMode(arg32, arg33) -- line: 738
    arg32.cameraMovementMode = arg33
end

function t.GetCameraMovementMode(arg34) -- line: 742
    return arg34.cameraMovementMode
end

function t.SetIsMouseLocked(t4: table, b3: boolean) -- line: 746
    t4.inMouseLockedMode = b3
end

function t.GetIsMouseLocked(arg35) -- line: 750
    return arg35.inMouseLockedMode
end

function t.SetMouseLockOffset(arg36, arg37) -- line: 754
    arg36.mouseLockOffset = arg37
end

function t.GetMouseLockOffset(arg38) -- line: 758
    return arg38.mouseLockOffset
end

function t.InFirstPerson(arg39) -- line: 762
    return arg39.inFirstPerson
end

function t.EnterFirstPerson(arg40) -- line: 766
    arg40.inFirstPerson = true
    arg40:UpdateMouseBehavior()
end

function t.LeaveFirstPerson(arg41) -- line: 771
    arg41.inFirstPerson = false
    arg41:UpdateMouseBehavior()
end

function t.GetCameraToSubjectDistance(arg42) -- line: 777
    return arg42.currentSubjectDistance
end

function t.GetMeasuredDistanceToFocus(_) -- line: 784
    local CurrentCamera_5 = game.Workspace.CurrentCamera

    if CurrentCamera_5 then
        return (CurrentCamera_5.CoordinateFrame.p - CurrentCamera_5.Focus.p).magnitude
    end

    return nil
end

function t.GetCameraLookVector(_) -- line: 792
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1)
end

function t.CalculateNewLookCFrameFromArg(t5: table, vec1: Vector3?, u2: Vector2) -- line: 796
    local v36 = vec1 or t5:GetCameraLookVector()
    local v37 = math.asin(v36.Y)
    local v38 = math.clamp(u2.Y, v37 + -1.3962634015954636, v37 + 1.3962634015954636)
    local vec2 = Vector2.new(u2.X, v38)
    local cframe = CFrame.new(Vector3.new(0, 0, 0), v36)

    return CFrame.Angles(0, -vec2.X, 0) * cframe * CFrame.Angles(-vec2.Y, 0, 0)
end

function t.CalculateNewLookVectorFromArg(t6: table, vec3: Vector3?, u3: Vector2) -- line: 806
    return t6:CalculateNewLookCFrameFromArg(vec3, u3).LookVector
end

function t.CalculateNewLookVectorVRFromArg(t7: table, u4: Vector2) -- line: 811
    local Unit = ((t7:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit
    local vec2_1 = Vector2.new(u4.X, 0)
    local cframe_1 = CFrame.new(Vector3.new(0, 0, 0), Unit)

    return ((CFrame.Angles(0, -vec2_1.X, 0) * cframe_1 * CFrame.Angles(-vec2_1.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end

function t.GetHumanoid(arg45) -- line: 821
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local v42 = LocalPlayer

    if v42 then
        v42 = LocalPlayer.Character
    end

    if v42 then
        local v43 = arg45.humanoidCache[LocalPlayer]

        if v43 and v43.Parent == v42 then
            return v43
        end

        arg45.humanoidCache[LocalPlayer] = nil
        local Humanoid_1 = v42:FindFirstChildOfClass("Humanoid")

        if Humanoid_1 then
            arg45.humanoidCache[LocalPlayer] = Humanoid_1
        end

        return Humanoid_1
    end

    return nil
end

function t.GetHumanoidPartToFollow(_: table, u5: userdata, arg46: any) -- line: 839
    if arg46 == Enum.HumanoidStateType.Dead then
        local Parent_1 = u5.Parent

        if Parent_1 then
            return Parent_1:FindFirstChild("Head") or u5.Torso
        end

        return u5.Torso
    else
        return u5.Torso
    end
end

function t.OnNewCameraSubject(arg47) -- line: 853
    if arg47.subjectStateChangedConn then
        arg47.subjectStateChangedConn:Disconnect()
        arg47.subjectStateChangedConn = nil
    end
end

function t.IsInFirstPerson(arg48) -- line: 860
    return arg48.inFirstPerson
end

function t.Update(_, _) -- line: 864
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end

function t.GetCameraHeight(arg51) -- line: 868
    -- upvalues:
    --  [1] VRService (copy)

    return if not VRService.VREnabled then 0 else if arg51.inFirstPerson then 0 else 0.25881904510252074 * arg51.currentSubjectDistance
end

return t
