-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRCamera
-- Class: ModuleScript
-- bytes: 13567

local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local _ = UserSettings():GetService("UserGameSettings")
local _ = require(script.Parent:WaitForChild("CameraInput"))
local _ = require(script.Parent:WaitForChild("CameraUtils"))
local VRBaseCamera_m = require(script.Parent:WaitForChild("VRBaseCamera"))
local t = setmetatable({}, VRBaseCamera_m)
t.__index = t

function t.new() -- line: 28
    -- upvalues:
    --  [1] VRBaseCamera_m (copy)
    --  [2] t (copy)
    --  [3] Players (copy)

    local t_1 = setmetatable(VRBaseCamera_m.new(), t)
    t_1.lastUpdate = tick()
    t_1.focusOffset = CFrame.new()
    t_1:Reset()
    t_1.controlModule = require(
        Players.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule")
    )
    t_1.savedAutoRotate = true

    return t_1
end

function t.Reset(arg1) -- line: 41
    -- upvalues:
    --  [1] VRBaseCamera_m (copy)

    arg1.needsReset = true
    arg1.needsBlackout = true
    arg1.motionDetTime = 0
    arg1.blackOutTimer = 0
    arg1.lastCameraResetPosition = nil
    VRBaseCamera_m.Reset(arg1)
end

function t.Update(arg2, arg3) -- line: 50
    -- upvalues:
    --  [1] Players (copy)
    --  [2] VRService (copy)

    local CurrentCamera = workspace.CurrentCamera
    local v5 = CurrentCamera.CFrame
    local v6 = CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer
    local _ = arg2:GetHumanoid()
    local _ = CurrentCamera.CameraSubject

    if arg2.lastUpdate == nil or arg3 > 1 then
        arg2.lastCameraTransform = nil
    end

    arg2:UpdateFadeFromBlack(arg3)
    arg2:UpdateEdgeBlur(LocalPlayer, arg3)
    local LastSubjectPosition = arg2.lastSubjectPosition
    local v8 = arg2:GetSubjectPosition()

    if arg2.needsBlackout then
        arg2:StartFadeFromBlack()
        arg2.blackOutTimer += math.clamp(arg3, 0.0001, 0.1)

        if arg2.blackOutTimer > 0.1 and game:IsLoaded() then
            arg2.needsBlackout = false
            arg2.needsReset = true
        end
    end

    if v8 and LocalPlayer and CurrentCamera then
        v6 = arg2:GetVRFocus(v8, arg3)

        if arg2:IsInFirstPerson() then
            if VRService.AvatarGestures then
                v5, v6 = arg2:UpdateImmersionCamera(
                    arg3,
                    v5,
                    v6,
                    LastSubjectPosition,
                    v8
                )
            else
                v5, v6 = arg2:UpdateFirstPersonTransform(
                    arg3,
                    v5,
                    v6,
                    LastSubjectPosition,
                    v8
                )
            end
        elseif VRService.ThirdPersonFollowCamEnabled then
            v5, v6 = arg2:UpdateThirdPersonFollowTransform(
                arg3,
                v5,
                v6,
                LastSubjectPosition,
                v8
            )
        else
            v5, v6 = arg2:UpdateThirdPersonComfortTransform(
                arg3,
                v5,
                v6,
                LastSubjectPosition,
                v8
            )
        end

        arg2.lastCameraTransform = v5
        arg2.lastCameraFocus = v6
    end

    arg2.lastUpdate = tick()

    return v5, v6
end

function t.GetAvatarFeetWorldYValue(_) -- line: 112
    local CameraSubject_1 = workspace.CurrentCamera.CameraSubject

    if not CameraSubject_1 then
        return nil
    end

    if CameraSubject_1:IsA("Humanoid") and CameraSubject_1.RootPart then
        local RootPart = CameraSubject_1.RootPart

        return RootPart.Position.Y - RootPart.Size.Y / 2 - CameraSubject_1.HipHeight
    end

    return nil
end

function t.UpdateFirstPersonTransform(
    arg5,
    arg6,
    _,
    arg8,
    arg9,
    arg10
) -- line: 127
    -- upvalues:
    --  [1] Players (copy)

    if arg5.needsReset then
        arg5:StartFadeFromBlack()
        arg5.needsReset = false
    end

    if (arg9 - arg10).magnitude > 0.01 then
        arg5:StartVREdgeBlur(Players.LocalPlayer)
    end

    local P = arg8.p
    local v10 = arg5:GetCameraLookVector()
    local Unit = Vector3.new(v10.X, 0, v10.Z).Unit
    local v11 = arg5:getRotation(arg6)
    local v12 = arg5:CalculateNewLookVectorFromArg(Unit, Vector2.new(v11, 0))

    return CFrame.new(P - 0.5 * v12, P), arg8
end

function t.UpdateImmersionCamera(
    arg11,
    arg12,
    arg13,
    _,
    _,
    arg16
) -- line: 153
    -- upvalues:
    --  [1] Players (copy)
    --  [2] VRService (copy)

    local v13 = arg11:GetSubjectCFrame()
    local CurrentCamera_1 = workspace.CurrentCamera
    local Character = Players.LocalPlayer.Character
    local v14 = arg11:GetHumanoid()

    if not v14 then
        return CurrentCamera_1.CFrame, CurrentCamera_1.Focus
    end

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then
        return CurrentCamera_1.CFrame, CurrentCamera_1.Focus
    end

    arg11.characterOrientation = HumanoidRootPart:FindFirstChild("CharacterAlignOrientation")

    if not arg11.characterOrientation then
        local RootAttachment = HumanoidRootPart:FindFirstChild("RootAttachment")

        if not RootAttachment then
            return
        end

        arg11.characterOrientation = Instance.new("AlignOrientation")
        arg11.characterOrientation.Name = "CharacterAlignOrientation"
        arg11.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
        arg11.characterOrientation.Attachment0 = RootAttachment
        arg11.characterOrientation.RigidityEnabled = true
        arg11.characterOrientation.Parent = HumanoidRootPart
    end

    if arg11.characterOrientation.Enabled == false then
        arg11.characterOrientation.Enabled = true
    end

    if arg11.needsReset then
        arg11.needsReset = false
        arg11.savedAutoRotate = v14.AutoRotate
        v14.AutoRotate = false

        if arg11.NoRecenter then
            arg11.NoRecenter = false
            VRService:RecenterUserHeadCFrame()
        end

        arg11:StartFadeFromBlack()
        arg13 = v13
    elseif v14.Sit then
        arg13 = v13

        if (arg13.Position - CurrentCamera_1.CFrame.Position).Magnitude > 0.01 then
            arg11:StartVREdgeBlur(Players.LocalPlayer)
        end
    else
        arg11.characterOrientation.CFrame = CurrentCamera_1.CFrame * arg11.controlModule:GetEstimatedVRTorsoFrame()

        if arg11.controlModule.inputMoveVector.Magnitude > 0 then
            arg11.motionDetTime = 0.1
        end

        if arg11.controlModule.inputMoveVector.Magnitude > 0 or arg11.motionDetTime > 0 then
            arg11.motionDetTime -= arg12
            arg11:StartVREdgeBlur(Players.LocalPlayer)
            local v16 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
            local HumanoidRootPart_1 = Character.HumanoidRootPart
            local v18 = CurrentCamera_1.CFrame * (v16.Rotation + v16.Position * CurrentCamera_1.HeadScale) * CFrame.new(
                0,
                -0.7 * HumanoidRootPart_1.Size.Y / 2,
                0
            )
            local LookVector = HumanoidRootPart_1.CFrame.LookVector
            local v19 = arg16 - (v18 - Vector3.new(LookVector.X, 0, LookVector.Z).Unit * HumanoidRootPart_1.Size.Y * 0.125).Position + CurrentCamera_1.CFrame.Position
            arg13 = CurrentCamera_1.CFrame.Rotation + Vector3.new(v19.X, arg16.Y, v19.Z)
        else
            arg13 = CurrentCamera_1.CFrame.Rotation + Vector3.new(
                CurrentCamera_1.CFrame.Position.X,
                arg16.Y,
                CurrentCamera_1.CFrame.Position.Z
            )
        end

        local v20 = arg11:getRotation(arg12)

        if math.abs(v20) > 0 then
            local v21 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
            local v22 = v21.Rotation + v21.Position * CurrentCamera_1.HeadScale
            local v23 = arg13 * v22
            arg13 = CFrame.new(v23.Position) * CFrame.Angles(0, -math.rad(v20 * 90), 0) * v23.Rotation * v22:Inverse()
        end
    end

    return arg13, arg13 * CFrame.new(0, 0, -0.5)
end

function t.UpdateThirdPersonComfortTransform(
    arg17,
    arg18,
    arg19,
    arg20,
    arg21,
    arg22
) -- line: 265
    -- upvalues:
    --  [1] Players (copy)
    --  [2] VRService (copy)

    local v25 = arg17:GetCameraToSubjectDistance()

    if v25 < 0.5 then
        v25 = 0.5
    end

    if arg21 ~= nil and arg17.lastCameraFocus ~= nil then
        local _ = Players.LocalPlayer
        local v26 = arg21 - arg22
        local v27 = arg17.controlModule:GetMoveVector()
        local v28 = if not (v26.magnitude > 0.01) then v27.magnitude > 0.01 and true else true

        if v28 then
            arg17.motionDetTime = 0.1
        end

        arg17.motionDetTime -= arg18

        if arg17.motionDetTime > 0 then
            v28 = true
        end

        if v28 and not arg17.needsReset then
            local LastCameraFocus = arg17.lastCameraFocus
            arg17.VRCameraFocusFrozen = true

            return arg19, LastCameraFocus
        end

        v27 = arg17.lastCameraResetPosition == nil or (arg22 - arg17.lastCameraResetPosition).Magnitude > 1
        local v29 = arg17:getRotation(arg18)

        if math.abs(v29) > 0 then
            arg19 = arg20 * CFrame.Angles(0, -v29, 0) * arg20:ToObjectSpace(arg19)
        end

        if if not arg17.VRCameraFocusFrozen then arg17.needsReset else v27 or arg17.needsReset then
            VRService:RecenterUserHeadCFrame()
            arg17.VRCameraFocusFrozen = false
            arg17.needsReset = false
            arg17.lastCameraResetPosition = arg22
            arg17:ResetZoom()
            arg17:StartFadeFromBlack()
            local v31 = arg17:GetHumanoid()
            local v32 = v31.Torso and v31.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
            v32 = arg20.Position - Vector3.new(v32.X, 0, v32.Z) * v25
            arg19 = CFrame.new(v32, (Vector3.new(arg20.Position.X, v32.Y, arg20.Position.Z)))
        end
    end

    return arg19, arg20
end

function t.UpdateThirdPersonFollowTransform(
    arg23,
    arg24,
    arg25,
    arg26,
    arg27,
    arg28
) -- line: 332
    -- upvalues:
    --  [1] VRService (copy)
    --  [2] Players (copy)

    local CurrentCamera_2 = workspace.CurrentCamera
    local v33 = arg23:GetCameraToSubjectDistance()
    local v34 = arg23:GetVRFocus(arg28, arg24)

    if arg23.needsReset then
        arg23.needsReset = false
        VRService:RecenterUserHeadCFrame()
        arg23:ResetZoom()
        arg23:StartFadeFromBlack()
    end

    if arg23.recentered then
        local v35 = arg23:GetSubjectCFrame()

        if not v35 then
            return CurrentCamera_2.CFrame, CurrentCamera_2.Focus
        end

        arg25 = v34 * v35.Rotation * CFrame.new(0, 0, v33)
        arg23.focusOffset = v34:ToObjectSpace(arg25)
        local v36
        arg23.recentered, v36 = false, arg25

        return v36, v34
    else
        local v37 = v34:ToWorldSpace(arg23.focusOffset)
        local _ = Players.LocalPlayer
        local v38 = arg27 - arg28
        local ControlModule = arg23.controlModule
        local v39 = ControlModule:GetMoveVector()
        local LookVector_1
        local v40, v41

        if not (v38.magnitude > 0.01) then
            if v39.magnitude > 0 then
                v40 = ControlModule:GetEstimatedVRTorsoFrame()
                v41 = CurrentCamera_2.CFrame * (v40.Rotation + v40.Position * CurrentCamera_2.HeadScale)
                LookVector_1 = v41.LookVector
                arg25 = v37:Lerp(
                    CFrame.new(
                        CurrentCamera_2.CFrame.Position + (v34.Position - Vector3.new(
                            LookVector_1.X,
                            0,
                            LookVector_1.Z
                        ).Unit * v33) - v41.Position
                    ) * v37.Rotation,
                    0.01
                )
            else
                arg25 = v37
            end
        else
            v40 = ControlModule:GetEstimatedVRTorsoFrame()
            v41 = CurrentCamera_2.CFrame * (v40.Rotation + v40.Position * CurrentCamera_2.HeadScale)
            LookVector_1 = v41.LookVector
            arg25 = v37:Lerp(
                CFrame.new(
                    CurrentCamera_2.CFrame.Position + (v34.Position - Vector3.new(
                        LookVector_1.X,
                        0,
                        LookVector_1.Z
                    ).Unit * v33) - v41.Position
                ) * v37.Rotation,
                0.01
            )
            arg25 = v37
        end

        local v42 = arg23:getRotation(arg24)

        if math.abs(v42) > 0 then
            arg25 = v34 * CFrame.Angles(0, -v42, 0) * v34:ToObjectSpace(arg25)
        end

        arg23.focusOffset = v34:ToObjectSpace(arg25)
        arg26 = arg25 * CFrame.new(0, 0, -v33)

        if (arg26.Position - CurrentCamera_2.Focus.Position).Magnitude > 0.01 then
            arg23:StartVREdgeBlur(Players.LocalPlayer)
        end

        return arg25, arg26
    end
end

function t.LeaveFirstPerson(arg29) -- line: 410
    -- upvalues:
    --  [1] VRBaseCamera_m (copy)

    VRBaseCamera_m.LeaveFirstPerson(arg29)
    arg29.needsReset = true

    if arg29.VRBlur then
        arg29.VRBlur.Visible = false
    end

    if arg29.characterOrientation then
        arg29.characterOrientation.Enabled = false
    end

    local v44 = arg29:GetHumanoid()

    if v44 then
        v44.AutoRotate = arg29.savedAutoRotate
    end
end

return t
