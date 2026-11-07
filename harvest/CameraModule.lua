-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule
-- Class: ModuleScript
-- bytes: 20283

local t = {}
t.__index = t
local t_1 = {
    "CameraMinZoomDistance",
    "CameraMaxZoomDistance",
    "CameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMode",
    "DevTouchCameraMode",
    "DevComputerMovementMode",
    "DevTouchMovementMode",
    "DevEnableMouseLock"
}
local t_2 = {
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "GamepadCameraSensitivity",
    "MouseSensitivity",
    "RotationType",
    "TouchCameraMovementMode",
    "TouchMovementMode"
}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CameraUtils_m = require(script:WaitForChild("CameraUtils"))
local CameraInput_m = require(script:WaitForChild("CameraInput"))
local ClassicCamera_m = require(script:WaitForChild("ClassicCamera"))
local OrbitalCamera_m = require(script:WaitForChild("OrbitalCamera"))
local LegacyCamera_m = require(script:WaitForChild("LegacyCamera"))
local VehicleCamera_m = require(script:WaitForChild("VehicleCamera"))
local VRCamera_m = require(script:WaitForChild("VRCamera"))
local VRVehicleCamera_m = require(script:WaitForChild("VRVehicleCamera"))
local Invisicam_m = require(script:WaitForChild("Invisicam"))
local Poppercam_m = require(script:WaitForChild("Poppercam"))
local TransparencyController_m = require(script:WaitForChild("TransparencyController"))
local MouseLockController_m = require(script:WaitForChild("MouseLockController"))
local t_3 = {}
local t_4 = {}
local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)

function t.new() -- line: 95
    -- upvalues:
    --  [1] t (copy)
    --  [2] Players (copy)
    --  [3] TransparencyController_m (copy)
    --  [4] UserInputService (copy)
    --  [5] MouseLockController_m (copy)
    --  [6] RunService (copy)
    --  [7] t_1 (copy)
    --  [8] t_2 (copy)
    --  [9] UserGameSettings (copy)

    local t_5 = setmetatable({}, t)
    t_5.activeCameraController = nil
    t_5.activeOcclusionModule = nil
    t_5.activeTransparencyController = nil
    t_5.activeMouseLockController = nil
    t_5.currentComputerCameraMovementMode = nil
    t_5.cameraSubjectChangedConn = nil
    t_5.cameraTypeChangedConn = nil

    for _, val in pairs(Players:GetPlayers()) do
        t_5:OnPlayerAdded(val)
    end

    Players.PlayerAdded:Connect(function(player) -- line: 116
        -- upvalues:
        --  [1] t_5 (copy)

        t_5:OnPlayerAdded(player)
    end)
    t_5.activeTransparencyController = TransparencyController_m.new()
    t_5.activeTransparencyController:Enable(true)

    if not UserInputService.TouchEnabled or UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled then
        t_5.activeMouseLockController = MouseLockController_m.new()
        local v14 = t_5.activeMouseLockController:GetBindableToggleEvent()

        if v14 then
            v14:Connect(function() -- line: 129
                -- upvalues:
                --  [1] t_5 (copy)

                t_5:OnMouseLockToggled()
            end)
        end
    end

    t_5:ActivateCameraController(t_5:GetCameraControlChoice())
    t_5:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode)
    t_5:OnCurrentCameraChanged()
    RunService:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(
        arg2
    ) -- line: 138
        -- upvalues:
        --  [1] t_5 (copy)

        t_5:Update(arg2)
    end)

    for _, val_1 in pairs(t_1) do
        Players.LocalPlayer:GetPropertyChangedSignal(val_1):Connect(function() -- line: 142
            -- upvalues:
            --  [1] t_5 (copy)
            --  [2] val_1 (copy)

            t_5:OnLocalPlayerCameraPropertyChanged(val_1)
        end)
    end

    for _, val_2 in pairs(t_2) do
        UserGameSettings:GetPropertyChangedSignal(val_2):Connect(function() -- line: 148
            -- upvalues:
            --  [1] t_5 (copy)
            --  [2] val_2 (copy)

            t_5:OnUserGameSettingsPropertyChanged(val_2)
        end)
    end

    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- line: 152
        -- upvalues:
        --  [1] t_5 (copy)

        t_5:OnCurrentCameraChanged()
    end)

    return t_5
end

function t.GetCameraMovementModeFromSettings(_) -- line: 159
    -- upvalues:
    --  [1] Players (copy)
    --  [2] CameraUtils_m (copy)
    --  [3] UserInputService (copy)
    --  [4] UserGameSettings (copy)

    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils_m.ConvertCameraModeEnumToStandard(
            Enum.ComputerCameraMovementMode.Classic
        )
    end

    local v15, v16

    if UserInputService.TouchEnabled then
        v15 = CameraUtils_m.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode)
        v16 = CameraUtils_m.ConvertCameraModeEnumToStandard(
            UserGameSettings.TouchCameraMovementMode
        )
    else
        v15 = CameraUtils_m.ConvertCameraModeEnumToStandard(
            Players.LocalPlayer.DevComputerCameraMode
        )
        v16 = CameraUtils_m.ConvertCameraModeEnumToStandard(
            UserGameSettings.ComputerCameraMovementMode
        )
    end

    if v15 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v16
    end

    return v15
end

function t.ActivateOcclusionModule(arg4, arg5) -- line: 184
    -- upvalues:
    --  [1] Poppercam_m (copy)
    --  [2] Invisicam_m (copy)
    --  [3] t_4 (copy)
    --  [4] Players (copy)

    local v17

    if arg5 == Enum.DevCameraOcclusionMode.Zoom then
        v17 = Poppercam_m
    elseif arg5 == Enum.DevCameraOcclusionMode.Invisicam then
        v17 = Invisicam_m
    else
        warn("CameraScript ActivateOcclusionModule called with unsupported mode")

        return
    end

    arg4.occlusionMode = arg5

    if arg4.activeOcclusionModule and arg4.activeOcclusionModule:GetOcclusionMode() == arg5 then
        if not arg4.activeOcclusionModule:GetEnabled() then
            arg4.activeOcclusionModule:Enable(true)
        end

        return
    end

    local ActiveOcclusionModule = arg4.activeOcclusionModule
    arg4.activeOcclusionModule = t_4[v17]

    if not arg4.activeOcclusionModule then
        arg4.activeOcclusionModule = v17.new()

        if arg4.activeOcclusionModule then
            t_4[v17] = arg4.activeOcclusionModule
        end
    end

    if arg4.activeOcclusionModule then
        if arg4.activeOcclusionModule:GetOcclusionMode() ~= arg5 then
            warn(
                "CameraScript ActivateOcclusionModule mismatch: ",
                arg4.activeOcclusionModule:GetOcclusionMode(),
                "~=",
                arg5
            )
        end

        if ActiveOcclusionModule then
            if ActiveOcclusionModule ~= arg4.activeOcclusionModule then
                ActiveOcclusionModule:Enable(false)
            else
                warn(
                    "CameraScript ActivateOcclusionModule failure to detect already running correct module"
                )
            end
        end

        if arg5 == Enum.DevCameraOcclusionMode.Invisicam then
            if Players.LocalPlayer.Character then
                arg4.activeOcclusionModule:CharacterAdded(
                    Players.LocalPlayer.Character,
                    Players.LocalPlayer
                )
            end
        else
            for _, val_3 in pairs(Players:GetPlayers()) do
                if val_3 and val_3.Character then
                    arg4.activeOcclusionModule:CharacterAdded(val_3.Character, val_3)
                end
            end

            arg4.activeOcclusionModule:OnCameraSubjectChanged(
                game.Workspace.CurrentCamera.CameraSubject
            )
        end

        arg4.activeOcclusionModule:Enable(true)
    end
end

function t.ShouldUseVehicleCamera(arg6) -- line: 263
    local v19 = workspace.CurrentCamera

    if not v19 then
        return false
    end

    local v20 = v19.CameraType
    local v21 = v19.CameraSubject
    v19 = v20 == Enum.CameraType.Custom or v20 == Enum.CameraType.Follow
    v20 = v21 and v21:IsA("VehicleSeat") or false
    v21 = arg6.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam

    return v20 and (v19 and v21)
end

function t.ActivateCameraController(arg7, arg8, arg9) -- line: 281
    -- upvalues:
    --  [1] LegacyCamera_m (copy)
    --  [2] VRService (copy)
    --  [3] VRCamera_m (copy)
    --  [4] ClassicCamera_m (copy)
    --  [5] OrbitalCamera_m (copy)
    --  [6] VRVehicleCamera_m (copy)
    --  [7] VehicleCamera_m (copy)
    --  [8] t_3 (copy)

    local v23 = nil

    if arg9 ~= nil then
        if arg9 == Enum.CameraType.Scriptable then
            if arg7.activeCameraController then
                arg7.activeCameraController:Enable(false)
                arg7.activeCameraController = nil
            end

            return
        end

        if arg9 == Enum.CameraType.Custom then
            arg8 = arg7:GetCameraMovementModeFromSettings()
        elseif arg9 == Enum.CameraType.Track then
            arg8 = Enum.ComputerCameraMovementMode.Classic
        elseif arg9 == Enum.CameraType.Follow then
            arg8 = Enum.ComputerCameraMovementMode.Follow
        elseif arg9 == Enum.CameraType.Orbital then
            arg8 = Enum.ComputerCameraMovementMode.Orbital
        elseif arg9 == Enum.CameraType.Attach or (arg9 == Enum.CameraType.Watch or arg9 == Enum.CameraType.Fixed) then
            v23 = LegacyCamera_m
        else
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", arg9)
        end
    end

    if not v23 then
        if VRService.VREnabled then
            v23 = VRCamera_m
        elseif arg8 == Enum.ComputerCameraMovementMode.Classic or (arg8 == Enum.ComputerCameraMovementMode.Follow or (arg8 == Enum.ComputerCameraMovementMode.Default or arg8 == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v23 = ClassicCamera_m
        elseif arg8 == Enum.ComputerCameraMovementMode.Orbital then
            v23 = OrbitalCamera_m
        else
            warn("ActivateCameraController did not select a module.")

            return
        end
    end

    if arg7:ShouldUseVehicleCamera() then
        v23 = if not VRService.VREnabled then VehicleCamera_m else VRVehicleCamera_m
    end

    local v24

    if not t_3[v23] then
        v24 = v23.new()
        t_3[v23] = v24
    else
        v24 = t_3[v23]

        if v24.Reset then
            v24:Reset()
        end
    end

    if arg7.activeCameraController then
        if arg7.activeCameraController ~= v24 then
            arg7.activeCameraController:Enable(false)
            arg7.activeCameraController = v24
            arg7.activeCameraController:Enable(true)
        elseif not arg7.activeCameraController:GetEnabled() then
            arg7.activeCameraController:Enable(true)
        end
    elseif v24 ~= nil then
        arg7.activeCameraController = v24
        arg7.activeCameraController:Enable(true)
    end

    if arg7.activeCameraController then
        if arg8 ~= nil then
            arg7.activeCameraController:SetCameraMovementMode(arg8)

            return
        end

        if arg9 ~= nil then
            arg7.activeCameraController:SetCameraType(arg9)
        end
    end
end

function t.OnCameraSubjectChanged(arg10) -- line: 386
    local CurrentCamera_1 = workspace.CurrentCamera
    local v25 = CurrentCamera_1 and CurrentCamera_1.CameraSubject

    if arg10.activeTransparencyController then
        arg10.activeTransparencyController:SetSubject(v25)
    end

    if arg10.activeOcclusionModule then
        arg10.activeOcclusionModule:OnCameraSubjectChanged(v25)
    end

    arg10:ActivateCameraController(nil, CurrentCamera_1.CameraType)
end

function t.OnCameraTypeChanged(arg11, arg12) -- line: 401
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] CameraUtils_m (copy)

    if arg12 == Enum.CameraType.Scriptable and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils_m.restoreMouseBehavior()
    end

    arg11:ActivateCameraController(nil, arg12)
end

function t.OnCurrentCameraChanged(arg13) -- line: 413
    local CurrentCamera_2 = game.Workspace.CurrentCamera

    if not CurrentCamera_2 then
        return
    end

    if arg13.cameraSubjectChangedConn then
        arg13.cameraSubjectChangedConn:Disconnect()
    end

    if arg13.cameraTypeChangedConn then
        arg13.cameraTypeChangedConn:Disconnect()
    end

    arg13.cameraSubjectChangedConn = CurrentCamera_2:GetPropertyChangedSignal("CameraSubject"):Connect(
        function() -- line: 425
            -- upvalues:
            --  [1] arg13 (copy)
            --  [2] CurrentCamera_2 (copy)

            arg13:OnCameraSubjectChanged(CurrentCamera_2.CameraSubject)
        end
    )
    arg13.cameraTypeChangedConn = CurrentCamera_2:GetPropertyChangedSignal("CameraType"):Connect(
        function() -- line: 429
            -- upvalues:
            --  [1] arg13 (copy)
            --  [2] CurrentCamera_2 (copy)

            arg13:OnCameraTypeChanged(CurrentCamera_2.CameraType)
        end
    )
    arg13:OnCameraSubjectChanged(CurrentCamera_2.CameraSubject)
    arg13:OnCameraTypeChanged(CurrentCamera_2.CameraType)
end

function t.OnLocalPlayerCameraPropertyChanged(t1: table, s1: string) -- line: 437
    -- upvalues:
    --  [1] Players (copy)
    --  [2] CameraUtils_m (copy)

    if s1 == "CameraMode" then
        if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
            if t1.activeCameraController then
                if t1.activeCameraController:GetModuleName() ~= "ClassicCamera" then
                    t1:ActivateCameraController(
                        CameraUtils_m.ConvertCameraModeEnumToStandard(
                            Enum.DevComputerCameraMovementMode.Classic
                        )
                    )
                end
            else
                t1:ActivateCameraController(
                    CameraUtils_m.ConvertCameraModeEnumToStandard(
                        Enum.DevComputerCameraMovementMode.Classic
                    )
                )
            end

            if t1.activeCameraController then
                t1.activeCameraController:UpdateForDistancePropertyChange()

                return
            end
        else
            if Players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                t1:ActivateCameraController(
                    CameraUtils_m.ConvertCameraModeEnumToStandard(
                        (t1:GetCameraMovementModeFromSettings())
                    )
                )

                return
            end

            warn("Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode)

            return
        end
    else
        if s1 == "DevComputerCameraMode" or s1 == "DevTouchCameraMode" then
            t1:ActivateCameraController(
                CameraUtils_m.ConvertCameraModeEnumToStandard(
                    (t1:GetCameraMovementModeFromSettings())
                )
            )

            return
        end

        if s1 == "DevCameraOcclusionMode" then
            t1:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode)

            return
        end

        if s1 == "CameraMinZoomDistance" or s1 == "CameraMaxZoomDistance" then
            if t1.activeCameraController then
                t1.activeCameraController:UpdateForDistancePropertyChange()

                return
            end
        else
            if s1 == "DevTouchMovementMode" then
                return
            end

            if s1 == "DevComputerMovementMode" then
                return
            end

            if s1 == "DevEnableMouseLock" then
            end
        end
    end
end

function t.OnUserGameSettingsPropertyChanged(t2: table, s2: string) -- line: 481
    -- upvalues:
    --  [1] CameraUtils_m (copy)

    if s2 == "ComputerCameraMovementMode" then
        t2:ActivateCameraController(
            CameraUtils_m.ConvertCameraModeEnumToStandard((t2:GetCameraMovementModeFromSettings()))
        )
    end
end

function t.Update(arg14, arg15) -- line: 494
    -- upvalues:
    --  [1] CameraInput_m (copy)

    if arg14.activeCameraController then
        arg14.activeCameraController:UpdateMouseBehavior()
        local v29, v30 = arg14.activeCameraController:Update(arg15)

        if arg14.activeOcclusionModule then
            v29, v30 = arg14.activeOcclusionModule:Update(arg15, v29, v30)
        end

        local CurrentCamera_3 = game.Workspace.CurrentCamera
        CurrentCamera_3.CFrame = v29
        CurrentCamera_3.Focus = v30

        if arg14.activeTransparencyController then
            arg14.activeTransparencyController:Update(arg15)
        end

        if CameraInput_m.getInputEnabled() then
            CameraInput_m.resetInputForFrameEnd()
        end
    end
end

function t.GetCameraControlChoice(_) -- line: 522
    -- upvalues:
    --  [1] Players (copy)
    --  [2] UserInputService (copy)
    --  [3] CameraUtils_m (copy)
    --  [4] UserGameSettings (copy)

    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer then
        if UserInputService:GetLastInputType() == Enum.UserInputType.Touch or UserInputService.TouchEnabled then
            if LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
                return CameraUtils_m.ConvertCameraModeEnumToStandard(
                    UserGameSettings.TouchCameraMovementMode
                )
            end

            return CameraUtils_m.ConvertCameraModeEnumToStandard(LocalPlayer.DevTouchCameraMode)
        end

        if LocalPlayer.DevComputerCameraMode == Enum.DevComputerCameraMovementMode.UserChoice then
            return CameraUtils_m.ConvertCameraModeEnumToStandard(
                (CameraUtils_m.ConvertCameraModeEnumToStandard(
                    UserGameSettings.ComputerCameraMovementMode
                ))
            )
        end

        return CameraUtils_m.ConvertCameraModeEnumToStandard(LocalPlayer.DevComputerCameraMode)
    else
        return
    end
end

function t.OnCharacterAdded(arg17, arg18, arg19) -- line: 545
    if arg17.activeOcclusionModule then
        arg17.activeOcclusionModule:CharacterAdded(arg18, arg19)
    end
end

function t.OnCharacterRemoving(arg20, arg21, arg22) -- line: 551
    if arg20.activeOcclusionModule then
        arg20.activeOcclusionModule:CharacterRemoving(arg21, arg22)
    end
end

function t.OnPlayerAdded(arg23, arg24) -- line: 557
    arg24.CharacterAdded:Connect(function(character) -- line: 558
        -- upvalues:
        --  [1] arg23 (copy)
        --  [2] arg24 (copy)

        arg23:OnCharacterAdded(character, arg24)
    end)
    arg24.CharacterRemoving:Connect(function(character_1) -- line: 561
        -- upvalues:
        --  [1] arg23 (copy)
        --  [2] arg24 (copy)

        arg23:OnCharacterRemoving(character_1, arg24)
    end)
end

function t.OnMouseLockToggled(arg27) -- line: 566
    if arg27.activeMouseLockController then
        local v33 = arg27.activeMouseLockController:GetIsMouseLocked()
        local v34 = arg27.activeMouseLockController:GetMouseLockOffset()

        if arg27.activeCameraController then
            arg27.activeCameraController:SetIsMouseLocked(v33)
            arg27.activeCameraController:SetMouseLockOffset(v34)
        end
    end
end

local _ = t.new()

return {}
