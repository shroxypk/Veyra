-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRVehicleCamera
-- Class: ModuleScript
-- bytes: 14689

local Success, Result = pcall(function() -- line: 9
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
end)
local v1 = Success and Result
local t = { 0, 30 }
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local VRBaseCamera_m = require(script.Parent:WaitForChild("VRBaseCamera"))
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils_m = require(script.Parent:WaitForChild("CameraUtils"))
local _ = require(script.Parent:WaitForChild("VehicleCamera"))
local VehicleCameraCore_m = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraCore"))
local VehicleCameraConfig_m = require(
    script.Parent.VehicleCamera:FindFirstChild("VehicleCameraConfig")
)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")
local LocalPlayer = Players.LocalPlayer
local MapClamp = CameraUtils_m.mapClamp

local _ = function(arg1, arg2) --[[ pitchVelocity ]] -- line: 46
    local v8 = arg2.XVector:Dot(arg1)

    return (math.abs(v8))
end

local _ = function(arg3, arg4) --[[ yawVelocity ]] -- line: 51
    local v9 = arg4.YVector:Dot(arg3)

    return (math.abs(v9))
end

local v10 = 0.016666666666666666
local Spring = CameraUtils_m.Spring
local SanitizeAngle = CameraUtils_m.sanitizeAngle
local t_1 = setmetatable({}, VRBaseCamera_m)
t_1.__index = t_1

function t_1.new() -- line: 59
    -- upvalues:
    --  [1] VRBaseCamera_m (copy)
    --  [2] t_1 (copy)
    --  [3] RunService (copy)
    --  [4] v10 (ref)

    local t_2 = setmetatable(VRBaseCamera_m.new(), t_1)
    t_2:Reset()
    RunService.Stepped:Connect(function(_, arg6) -- line: 64
        -- upvalues:
        --  [1] v10 (ref)

        v10 = arg6
    end)

    return t_2
end

function t_1.Reset(arg7) -- line: 72
    -- upvalues:
    --  [1] VehicleCameraCore_m (copy)
    --  [2] v1 (ref)
    --  [3] Spring (copy)
    --  [4] VehicleCameraConfig_m (copy)
    --  [5] CameraUtils_m (copy)
    --  [6] t (copy)

    arg7.vehicleCameraCore = VehicleCameraCore_m.new(arg7:GetSubjectCFrame())

    if v1 then
        arg7.pitchSpring = Spring.new(0, 0)
    else
        arg7.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig_m.pitchBaseAngle))
    end

    arg7.yawSpring = Spring.new(0, 0)

    if v1 then
        arg7.lastPanTick = 0
        arg7.currentDriftAngle = 0
        arg7.needsReset = true
    end

    local CurrentCamera = workspace.CurrentCamera
    local v12 = CurrentCamera and CurrentCamera.CameraSubject
    assert(CurrentCamera, "VRVehicleCamera initialization error")
    assert(v12)
    assert(v12:IsA("VehicleSeat"))
    local v13, v14 = CameraUtils_m.getLooseBoundingSphere((v12:GetConnectedParts(true)))
    arg7.assemblyRadius = math.max(v14, 5)
    arg7.assemblyOffset = v12.CFrame:Inverse() * v13
    arg7.gamepadZoomLevels = {}

    for _, val in t do
        table.insert(arg7.gamepadZoomLevels, val * arg7.headScale * arg7.assemblyRadius / 10)
    end

    arg7.lastCameraFocus = nil
    arg7:SetCameraToSubjectDistance(arg7.gamepadZoomLevels[#arg7.gamepadZoomLevels])
end

function t_1._StepRotation(arg8, arg9, arg10) -- line: 112
    -- upvalues:
    --  [1] SanitizeAngle (copy)
    --  [2] CameraInput_m (copy)
    --  [3] VehicleCameraConfig_m (copy)
    --  [4] MapClamp (copy)

    local YawSpring = arg8.yawSpring
    local PitchSpring = arg8.pitchSpring
    YawSpring.pos = SanitizeAngle(YawSpring.pos + -arg8:getRotation(arg9))
    PitchSpring.pos = SanitizeAngle(
        (math.clamp(PitchSpring.pos, -1.3962634015954636, 1.3962634015954636))
    )

    if CameraInput_m.getRotationActivated() then
        arg8.lastPanTick = os.clock()
    end

    local v16 = math.rad(VehicleCameraConfig_m.pitchDeadzoneAngle)

    if os.clock() - arg8.lastPanTick > VehicleCameraConfig_m.autocorrectDelay then
        local v17 = MapClamp(
            arg10,
            VehicleCameraConfig_m.autocorrectMinCarSpeed,
            VehicleCameraConfig_m.autocorrectMaxCarSpeed,
            0,
            VehicleCameraConfig_m.autocorrectResponse
        )
        YawSpring.freq = v17
        PitchSpring.freq = v17

        if YawSpring.freq < 0.001 then
            YawSpring.vel = 0
        end

        if PitchSpring.freq < 0.001 then
            PitchSpring.vel = 0
        end

        if v16 >= math.abs((SanitizeAngle(0 - PitchSpring.pos))) then
            PitchSpring.goal = PitchSpring.pos
        else
            PitchSpring.goal = 0
        end
    else
        YawSpring.freq = 0
        YawSpring.vel = 0
        PitchSpring.freq = 0
        PitchSpring.vel = 0
        PitchSpring.goal = 0
    end

    return CFrame.fromEulerAnglesYXZ(PitchSpring:step(arg9), YawSpring:step(arg9), 0)
end

function t_1._GetThirdPersonLocalOffset(arg11) -- line: 176
    -- upvalues:
    --  [1] VehicleCameraConfig_m (copy)

    return arg11.assemblyOffset + Vector3.new(
        0,
        arg11.assemblyRadius * VehicleCameraConfig_m.verticalCenterOffset,
        0
    )
end

function t_1._GetFirstPersonLocalOffset(t1: table, u1: CFrame) -- line: 180
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local Character = LocalPlayer.Character

    if Character and Character.Parent then
        local Head = Character:FindFirstChild("Head")

        if Head and Head:IsA("BasePart") then
            return u1:Inverse() * Head.Position
        end
    end

    return t1:_GetThirdPersonLocalOffset()
end

function t_1.Update(arg12) -- line: 194
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v10 (ref)
    --  [3] LocalPlayer (copy)
    --  [4] VRService (copy)

    if v1 then
        local v21 = v10
        v10 = 0
        arg12:UpdateFadeFromBlack(v21)
        arg12:UpdateEdgeBlur(LocalPlayer, v21)

        if VRService.ThirdPersonFollowCamEnabled then
            local v22, v23 = arg12:UpdateStepRotation(v21)

            return v22, v23
        end

        local v24, v25 = arg12:UpdateComfortCamera(v21)

        return v24, v25
    else
        return arg12:UpdateComfortCamera()
    end
end

function t_1.addDrift(arg13, arg14, arg15) -- line: 217
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] VRService (copy)

    local _ = function(arg16) --[[ NormalizeAngle ]] -- line: 218
        arg16 = (arg16 + 12.566370614359172) % 6.283185307179586
        arg16 = if not (arg16 > 3.141592653589793) then arg16 else arg16 - 6.283185307179586

        return arg16
    end

    local CurrentCamera_1 = workspace.CurrentCamera
    local v26 = arg13:GetCameraToSubjectDistance()
    local v27 = arg13:GetSubjectVelocity()
    local v28 = arg13:GetSubjectCFrame()
    local _ = require(
        LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule")
    )

    if v27.Magnitude > 0.1 then
        local v30 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
        local v31 = CurrentCamera_1.CFrame * (v30.Rotation + v30.Position * CurrentCamera_1.HeadScale)
        local _, v33, _ = v31:ToEulerAnglesYXZ()
        local _, v36, _ = v28:ToEulerAnglesYXZ()
        local v38 = (v33 - arg13.currentDriftAngle + 12.566370614359172) % 6.283185307179586

        if v38 > 3.141592653589793 then
            v38 -= 6.283185307179586
        end

        local v39 = (v36 - arg13.currentDriftAngle + 12.566370614359172) % 6.283185307179586
        v39 = if not (v39 > 3.141592653589793) then v39 else v39 - 6.283185307179586
        local v40 = math.min(v39, v38)
        local v41 = math.max(v39, v38)
        v38 = 0

        if v40 > 0 then
            v38 = v40
        elseif v41 < 0 then
            v38 = v41
        end

        arg13.currentDriftAngle = v38 + arg13.currentDriftAngle
        local LookVector = CFrame.fromEulerAnglesYXZ(0, arg13.currentDriftAngle, 0).LookVector
        arg14 = arg14:Lerp(
            CFrame.new(
                CurrentCamera_1.CFrame.Position + (arg15.Position - Vector3.new(
                    LookVector.X,
                    0,
                    LookVector.Z
                ).Unit * v26) - v31.Position
            ) * CurrentCamera_1.CFrame.Rotation,
            0.01
        )
    end

    return arg14, arg15
end

function t_1.UpdateRotationCamera(arg17, arg18) -- line: 275
    -- upvalues:
    --  [1] MapClamp (copy)
    --  [2] LocalPlayer (copy)

    local CurrentCamera_2 = workspace.CurrentCamera
    local v42 = CurrentCamera_2 and CurrentCamera_2.CameraSubject
    local VehicleCameraCore = arg17.vehicleCameraCore
    assert(CurrentCamera_2)
    assert(v42)
    assert(v42:IsA("VehicleSeat"))
    v42 = arg17:GetSubjectCFrame()
    local v43 = arg17:GetSubjectVelocity()
    local v44 = arg17:GetSubjectRotVelocity()
    local v45 = v43:Dot(v42.ZVector)
    local v46 = math.abs(v45)
    local v47 = v42.YVector:Dot(v44)
    local v48 = math.abs(v47)
    local v49 = v42.XVector:Dot(v44)
    local v50 = math.abs(v49)
    local v51 = arg17:GetCameraToSubjectDistance()
    local v52 = MapClamp(
        v51,
        0.5,
        arg17.assemblyRadius,
        1,
        0
    )
    local v54 = arg17:_GetThirdPersonLocalOffset():Lerp(arg17:_GetFirstPersonLocalOffset(v42), v52)
    VehicleCameraCore:setTransform(v42)
    local v55 = VehicleCameraCore:step(arg18, v50, v48, v52)
    local v56 = v42 * v54
    local v57 = arg17:_StepRotation(arg18, v46)
    local v58 = arg17:GetVRFocus(v56, arg18) * v55 * v57
    local v59 = v58 * CFrame.new(0, 0, v51)

    if v43.Magnitude > 0.1 then
        arg17:StartVREdgeBlur(LocalPlayer)
    end

    return v59, v58
end

function t_1.UpdateStepRotation(arg19, arg20) -- line: 322
    -- upvalues:
    --  [1] MapClamp (copy)
    --  [2] UserGameSettings (copy)
    --  [3] VRService (copy)
    --  [4] LocalPlayer (copy)

    local CurrentCamera_3 = workspace.CurrentCamera
    local LastSubjectCFrame = arg19.lastSubjectCFrame
    local v60 = arg19:GetSubjectCFrame()
    local v61 = arg19:GetSubjectVelocity()
    local v62 = arg19:GetCameraToSubjectDistance()
    local v63 = MapClamp(
        v62,
        0.5,
        arg19.assemblyRadius,
        1,
        0
    )
    local v64 = arg19:_GetThirdPersonLocalOffset()
    local v65 = v64:Lerp(arg19:_GetFirstPersonLocalOffset(v60), v63)
    local v66 = arg19:GetVRFocus(v60 * v65, arg20)
    local v69, v70 = arg19:addDrift(
        v66:ToWorldSpace(
            arg19:GetVRFocus(LastSubjectCFrame * v65, arg20):ToObjectSpace(CurrentCamera_3.CFrame)
        ),
        v66
    )
    local v71 = arg19:getRotation(arg20)

    if math.abs(v71) > 0 then
        local v72 = v70:ToObjectSpace(v69)
        v64 = v70 * CFrame.Angles(0, -v71, 0) * v72

        if not UserGameSettings.VRSmoothRotationEnabled then
            local v73 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
            local v74 = v73.Rotation + v73.Position * CurrentCamera_3.HeadScale
            local v75 = v70 * v60.Rotation
            local v77 = v75:ToObjectSpace(v69 * v74)
            v77 = math.acos((Vector3.new(v77.X, 0, v77.Z).Unit:Dot(Vector3.new(0, 0, 1))))
            local v80 = v75:ToObjectSpace(v64 * v74)

            if v77 > math.acos((Vector3.new(v80.X, 0, v80.Z).Unit:Dot(Vector3.new(0, 0, 1)))) then
                if v71 < 0 then
                    v77 *= -1
                end

                v64 = v70 * CFrame.Angles(0, -v77, 0) * v72
            end
        end

        v69 = v64
    end

    if v61.Magnitude > 0.1 then
        arg19:StartVREdgeBlur(LocalPlayer)
    end

    if arg19.needsReset then
        arg19.needsReset = false
        VRService:RecenterUserHeadCFrame()
        arg19:StartFadeFromBlack()
        arg19:ResetZoom()
    end

    if arg19.recentered then
        v70 *= v60.Rotation
        v69 = v70 * CFrame.new(0, 0, v62)
        arg19.recentered = false
    end

    return v69, v69 * CFrame.new(0, 0, -v62)
end

function t_1.UpdateComfortCamera(arg21, arg22) -- line: 408
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v10 (ref)
    --  [3] MapClamp (copy)
    --  [4] LocalPlayer (copy)

    local CurrentCamera_4 = workspace.CurrentCamera
    local v82 = CurrentCamera_4 and CurrentCamera_4.CameraSubject
    local VehicleCameraCore_1 = arg21.vehicleCameraCore
    assert(CurrentCamera_4)
    assert(v82)
    assert(v82:IsA("VehicleSeat"))

    if not v1 then
        arg22 = v10
        v10 = 0
    end

    v82 = arg21:GetSubjectCFrame()
    local v83 = arg21:GetSubjectVelocity()
    local v84 = arg21:GetSubjectRotVelocity()
    local v85 = v83:Dot(v82.ZVector)
    local _ = math.abs(v85)
    local v87 = v82.YVector:Dot(v84)
    local v88 = math.abs(v87)
    local v89 = v82.XVector:Dot(v84)
    local v90 = math.abs(v89)
    local v91 = arg21:StepZoom()
    local v92 = MapClamp(
        v91,
        0.5,
        arg21.assemblyRadius,
        1,
        0
    )
    local v94 = arg21:_GetThirdPersonLocalOffset():Lerp(arg21:_GetFirstPersonLocalOffset(v82), v92)
    VehicleCameraCore_1:setTransform(v82)
    local v95 = VehicleCameraCore_1:step(arg22, v90, v88, v92)

    if not v1 then
        arg21:UpdateFadeFromBlack(arg22)
    end

    local v96, v97

    if not arg21:IsInFirstPerson() then
        v96 = CFrame.new(v82 * v94) * v95
        v97 = v96 * CFrame.new(0, 0, v91)

        if not arg21.lastCameraFocus then
            arg21.lastCameraFocus = v96
            arg21.needsReset = true
        end

        local v98 = v96.Position - CurrentCamera_4.CFrame.Position

        if v98.Unit:Dot(CurrentCamera_4.CFrame.LookVector) > 0.56 and (v98.magnitude < 200 and not arg21.needsReset) then
            v96 = arg21.lastCameraFocus
            local P = v96.p
            local v99 = arg21:GetCameraLookVector()
            v97 = CFrame.new(
                P - v91 * arg21:CalculateNewLookVectorFromArg(
                    Vector3.new(v99.X, 0, v99.Z).Unit,
                    Vector2.new(0, 0)
                ),
                P
            )
        else
            arg21.lastCameraFocus = arg21:GetVRFocus(v82.Position, arg22)
            arg21.needsReset = false
            arg21:StartFadeFromBlack()
            arg21:ResetZoom()
        end

        if not v1 then
            arg21:UpdateEdgeBlur(LocalPlayer, arg22)

            return v97, v96
        end
    else
        v96 = CFrame.new(v82 * v94) * CFrame.new(
            v95.Position,
            Vector3.new(v95.LookVector.X, 0, v95.LookVector.Z).Unit
        )
        v97 = v96 * CFrame.new(0, 0, v91)

        if v1 then
            if v83.Magnitude > 0.1 then
                arg21:StartVREdgeBlur(LocalPlayer)

                return v97, v96
            end
        else
            arg21:StartVREdgeBlur(LocalPlayer)
        end
    end

    return v97, v96
end

return t_1
