-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRBaseCamera
-- Class: ModuleScript
-- bytes: 12322

local Success, Result = pcall(function() -- line: 17
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
end)
local v1 = Success and Result
local VRService = game:GetService("VRService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local ZoomController_m = require(script.Parent:WaitForChild("ZoomController"))
local UserCameraInputDt = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
).getUserFlag("UserCameraInputDt")
local BaseCamera_m = require(script.Parent:WaitForChild("BaseCamera"))
local t = setmetatable({}, BaseCamera_m)
t.__index = t

function t.new() -- line: 41
    -- upvalues:
    --  [1] BaseCamera_m (copy)
    --  [2] t (copy)

    local t_1 = setmetatable(BaseCamera_m.new(), t)
    t_1.gamepadZoomLevels = { 0, 7 }
    t_1.headScale = 1
    t_1:SetCameraToSubjectDistance(7)
    t_1.VRFadeResetTimer = 0
    t_1.VREdgeBlurTimer = 0
    t_1.gamepadResetConnection = nil
    t_1.needsReset = true
    t_1.recentered = false
    t_1:Reset()

    return t_1
end

function t.Reset(arg1) -- line: 67
    arg1.stepRotateTimeout = 0
end

function t.GetModuleName(_) -- line: 71
    return "VRBaseCamera"
end

function t.GamepadZoomPress(arg3) -- line: 75
    -- upvalues:
    --  [1] BaseCamera_m (copy)

    BaseCamera_m.GamepadZoomPress(arg3)
    arg3:GamepadReset()
    arg3:ResetZoom()
end

function t.GamepadReset(arg4) -- line: 83
    arg4.stepRotateTimeout = 0
    arg4.needsReset = true
end

function t.ResetZoom(arg5) -- line: 88
    -- upvalues:
    --  [1] ZoomController_m (copy)

    ZoomController_m.SetZoomParameters(arg5.currentSubjectDistance, 0)
    ZoomController_m.ReleaseSpring()
end

function t.OnEnabledChanged(arg6) -- line: 93
    -- upvalues:
    --  [1] BaseCamera_m (copy)
    --  [2] CameraInput_m (copy)
    --  [3] VRService (copy)
    --  [4] v1 (ref)
    --  [5] LocalPlayer (copy)
    --  [6] Lighting (copy)

    BaseCamera_m.OnEnabledChanged(arg6)

    if arg6.enabled then
        arg6.gamepadResetConnection = CameraInput_m.gamepadReset:Connect(function() -- line: 97
            -- upvalues:
            --  [1] arg6 (copy)

            arg6:GamepadReset()
        end)
        arg6.thirdPersonOptionChanged = VRService:GetPropertyChangedSignal(
            "ThirdPersonFollowCamEnabled"
        ):Connect(function() -- line: 102
            -- upvalues:
            --  [1] v1 (ref)
            --  [2] arg6 (copy)

            if v1 then
                arg6:Reset()

                return
            end

            if not arg6:IsInFirstPerson() then
                arg6:Reset()
            end
        end)
        arg6.vrRecentered = VRService.UserCFrameChanged:Connect(function(arg7, _) -- line: 113
            -- upvalues:
            --  [1] arg6 (copy)

            if arg7 == Enum.UserCFrame.Floor then
                arg6.recentered = true
            end
        end)

        return
    end

    if arg6.inFirstPerson then
        arg6:GamepadZoomPress()
    end

    if arg6.thirdPersonOptionChanged then
        arg6.thirdPersonOptionChanged:Disconnect()
        arg6.thirdPersonOptionChanged = nil
    end

    if arg6.vrRecentered then
        arg6.vrRecentered:Disconnect()
        arg6.vrRecentered = nil
    end

    if arg6.cameraHeadScaleChangedConn then
        arg6.cameraHeadScaleChangedConn:Disconnect()
        arg6.cameraHeadScaleChangedConn = nil
    end

    if arg6.gamepadResetConnection then
        arg6.gamepadResetConnection:Disconnect()
        arg6.gamepadResetConnection = nil
    end

    arg6.VREdgeBlurTimer = 0
    arg6:UpdateEdgeBlur(LocalPlayer, 1)
    local VRFade = Lighting:FindFirstChild("VRFade")

    if VRFade then
        VRFade.Brightness = 0
    end
end

function t.OnCurrentCameraChanged(arg9) -- line: 155
    -- upvalues:
    --  [1] BaseCamera_m (copy)

    BaseCamera_m.OnCurrentCameraChanged(arg9)

    if arg9.cameraHeadScaleChangedConn then
        arg9.cameraHeadScaleChangedConn:Disconnect()
        arg9.cameraHeadScaleChangedConn = nil
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        arg9.cameraHeadScaleChangedConn = CurrentCamera:GetPropertyChangedSignal("HeadScale"):Connect(
            function() -- line: 167
                -- upvalues:
                --  [1] arg9 (copy)

                arg9:OnHeadScaleChanged()
            end
        )
        arg9:OnHeadScaleChanged()
    end
end

function t.OnHeadScaleChanged(arg10) -- line: 172
    local HeadScale_1 = workspace.CurrentCamera.HeadScale

    for key, val in arg10.gamepadZoomLevels do
        arg10.gamepadZoomLevels[key] = val * HeadScale_1 / arg10.headScale
    end

    arg10:SetCameraToSubjectDistance(
        arg10:GetCameraToSubjectDistance() * HeadScale_1 / arg10.headScale
    )
    arg10.headScale = HeadScale_1
end

function t.GetVRFocus(arg11, arg12, arg13) -- line: 188
    local v7 = arg11.lastCameraFocus or arg12
    local X = arg11.cameraTranslationConstraints.x
    local v8 = math.min(1, arg11.cameraTranslationConstraints.y + arg13)
    arg11.cameraTranslationConstraints = Vector3.new(X, v8, arg11.cameraTranslationConstraints.z)
    local v9 = arg11:GetCameraHeight()
    local vec3 = Vector3.new(0, v9, 0)

    return (CFrame.new(
        Vector3.new(arg12.x, v7.y, arg12.z):Lerp(arg12 + vec3, arg11.cameraTranslationConstraints.y)
    ))
end

function t.StartFadeFromBlack(arg14) -- line: 204
    -- upvalues:
    --  [1] UserGameSettings (copy)
    --  [2] Lighting (copy)

    if UserGameSettings.VignetteEnabled == false then
        return
    end

    local v11 = Lighting:FindFirstChild("VRFade")

    if not v11 then
        v11 = Instance.new("ColorCorrectionEffect")
        v11.Name = "VRFade"
        v11.Parent = Lighting
    end

    v11.Brightness = -1
    arg14.VRFadeResetTimer = 0.1
end

function t.UpdateFadeFromBlack(t1: table, n1: number) -- line: 219
    -- upvalues:
    --  [1] Lighting (copy)

    local VRFade_1 = Lighting:FindFirstChild("VRFade")

    if t1.VRFadeResetTimer > 0 then
        t1.VRFadeResetTimer = math.max(t1.VRFadeResetTimer - n1, 0)
        local VRFade_2 = Lighting:FindFirstChild("VRFade")

        if VRFade_2 and VRFade_2.Brightness < 0 then
            VRFade_2.Brightness = math.min(VRFade_2.Brightness + n1 * 10, 0)

            return
        end
    elseif VRFade_1 then
        VRFade_1.Brightness = 0
    end
end

function t.StartVREdgeBlur(arg15, arg16) -- line: 235
    -- upvalues:
    --  [1] UserGameSettings (copy)
    --  [2] RunService (copy)
    --  [3] VRService (copy)

    if UserGameSettings.VignetteEnabled == false then
        return
    end

    local v12 = nil
    v12 = workspace.CurrentCamera:FindFirstChild("VRBlurPart")

    if not v12 then
        v12 = Instance.new("Part")
        v12.Name = "VRBlurPart"
        v12.Parent = workspace.CurrentCamera
        v12.CanTouch = false
        v12.CanCollide = false
        v12.CanQuery = false
        v12.Anchored = true
        v12.Size = Vector3.new(0.44, 0.47, 1)
        v12.Transparency = 1
        v12.CastShadow = false
        RunService.RenderStepped:Connect(function(_) -- line: 255
            -- upvalues:
            --  [1] VRService (ref)
            --  [2] v12 (ref)

            local v13 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
            local v15 = workspace.CurrentCamera.CFrame * (CFrame.new(
                v13.p * workspace.CurrentCamera.HeadScale
            ) * (v13 - v13.p))
            v12.CFrame = v15 * CFrame.Angles(0, 3.141592653589793, 0) + v15.LookVector * (1.05 * workspace.CurrentCamera.HeadScale)
            v12.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale
        end)
    end

    local v17 = arg16.PlayerGui:FindFirstChild("VRBlurScreen")
    local v18 = if v17 then v17:FindFirstChild("VRBlur") else nil

    if not v18 then
        if not v17 then
            v17 = Instance.new("SurfaceGui") or Instance.new("ScreenGui")
        end

        v17.Name = "VRBlurScreen"
        v17.Parent = arg16.PlayerGui
        v17.Adornee = v12
        v18 = Instance.new("ImageLabel")
        v18.Name = "VRBlur"
        v18.Parent = v17
        v18.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
        v18.AnchorPoint = Vector2.new(0.5, 0.5)
        v18.Position = UDim2.new(0.5, 0, 0.5, 0)
        v18.Size = UDim2.fromScale(
            workspace.CurrentCamera.ViewportSize.X * 2.3 / 512,
            workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512
        )
        v18.BackgroundTransparency = 1
        v18.Active = true
        v18.ScaleType = Enum.ScaleType.Stretch
    end

    v18.Visible = true
    v18.ImageTransparency = 0
    arg15.VREdgeBlurTimer = 0.14
end

function t.UpdateEdgeBlur(arg18, arg19, arg20) -- line: 304
    local VRBlurScreen = arg19.PlayerGui:FindFirstChild("VRBlurScreen")
    local v20 = if VRBlurScreen then VRBlurScreen:FindFirstChild("VRBlur") else nil

    if v20 then
        if arg18.VREdgeBlurTimer > 0 then
            arg18.VREdgeBlurTimer -= arg20
            local VRBlurScreen_1 = arg19.PlayerGui:FindFirstChild("VRBlurScreen")

            if VRBlurScreen_1 then
                local VRBlur = VRBlurScreen_1:FindFirstChild("VRBlur")

                if VRBlur then
                    VRBlur.ImageTransparency = 1 - math.clamp(arg18.VREdgeBlurTimer, 0.01, 0.14) * 7.142857142857142

                    return
                end
            end
        else
            v20.Visible = false
        end
    end
end

function t.GetCameraHeight(arg21) -- line: 329
    if not arg21.inFirstPerson then
        return 0.25881904510252074 * arg21.currentSubjectDistance
    end

    return 0
end

function t.GetSubjectCFrame(arg22) -- line: 336
    -- upvalues:
    --  [1] BaseCamera_m (copy)

    local v21 = BaseCamera_m.GetSubjectCFrame(arg22)
    local v22 = workspace.CurrentCamera
    local v23 = v22

    if v23 then
        v23 = v22.CameraSubject
    end

    if not v23 then
        return v21
    end

    if v23:IsA("Humanoid") then
        v22 = if v23:GetState() ~= Enum.HumanoidStateType.Dead then false else true
        v21 = if not v22 then v21 else if v23 ~= arg22.lastSubject then v21 else arg22.lastSubjectCFrame
    end

    if v21 then
        arg22.lastSubjectCFrame = v21
    end

    return v21
end

function t.GetSubjectPosition(arg23) -- line: 362
    -- upvalues:
    --  [1] BaseCamera_m (copy)

    local v24 = BaseCamera_m.GetSubjectPosition(arg23)
    local CurrentCamera_1 = game.Workspace.CurrentCamera
    local v26 = CurrentCamera_1

    if v26 then
        v26 = CurrentCamera_1.CameraSubject
    end

    if v26 then
        if v26:IsA("Humanoid") then
            if (if v26:GetState() ~= Enum.HumanoidStateType.Dead then false else true) and v26 == arg23.lastSubject then
                v24 = arg23.lastSubjectPosition
            end
        elseif v26:IsA("VehicleSeat") then
            v24 = v26.CFrame.p + v26.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0))
        end
    else
        return nil
    end

    arg23.lastSubjectPosition = v24

    return v24
end

function t.getRotation(arg24, arg25) -- line: 391
    -- upvalues:
    --  [1] CameraInput_m (copy)
    --  [2] UserGameSettings (copy)
    --  [3] UserCameraInputDt (copy)

    local v27 = CameraInput_m.getRotation(arg25)

    if UserGameSettings.VRSmoothRotationEnabled then
        if UserCameraInputDt then
            return v27.X
        end

        return v27.X * 40 * arg25
    else
        if math.abs(v27.X) > 0.03 then
            if arg24.stepRotateTimeout > 0 then
                arg24.stepRotateTimeout -= arg25
            end

            if arg24.stepRotateTimeout <= 0 then
                local v28 = 1
                v28 = if not (v27.X < 0) then v28 else -1
                v28 *= 0.5235987755982988
                arg24:StartFadeFromBlack()
                arg24.stepRotateTimeout = 0.25

                return v28
            end
        elseif math.abs(v27.X) < 0.02 then
            arg24.stepRotateTimeout = 0
        end

        return 0
    end
end

return t
