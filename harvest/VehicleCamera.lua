-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VehicleCamera
-- Class: ModuleScript
-- bytes: 6244

local t = { 0, 15, 30 }
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local BaseCamera_m = require(script.Parent:WaitForChild("BaseCamera"))
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils_m = require(script.Parent:WaitForChild("CameraUtils"))
local _ = require(script.Parent:WaitForChild("ZoomController"))
local VehicleCameraCore_m = require(script:WaitForChild("VehicleCameraCore"))
local VehicleCameraConfig_m = require(script:WaitForChild("VehicleCameraConfig"))
local _ = CameraUtils_m.map
local MapClamp = CameraUtils_m.mapClamp

local _ = function(arg1, arg2) --[[ pitchVelocity ]] -- line: 31
    local v7 = arg2.XVector:Dot(arg1)

    return (math.abs(v7))
end

local _ = function(arg3, arg4) --[[ yawVelocity ]] -- line: 36
    local v8 = arg4.YVector:Dot(arg3)

    return (math.abs(v8))
end

local v9 = 0.016666666666666666
local Spring = CameraUtils_m.Spring
local LocalPlayer = Players.LocalPlayer
local SanitizeAngle = CameraUtils_m.sanitizeAngle
RunService.Stepped:Connect(function(_, arg6) -- line: 42
    -- upvalues:
    --  [1] v9 (ref)

    v9 = arg6
end)
local t_1 = setmetatable({}, BaseCamera_m)
t_1.__index = t_1

function t_1.new() -- line: 49
    -- upvalues:
    --  [1] BaseCamera_m (copy)
    --  [2] t_1 (copy)

    local t_2 = setmetatable(BaseCamera_m.new(), t_1)
    t_2:Reset()

    return t_2
end

function t_1.Reset(arg7) -- line: 55
    -- upvalues:
    --  [1] VehicleCameraCore_m (copy)
    --  [2] Spring (copy)
    --  [3] VehicleCameraConfig_m (copy)
    --  [4] CameraUtils_m (copy)
    --  [5] t (copy)

    arg7.vehicleCameraCore = VehicleCameraCore_m.new(arg7:GetSubjectCFrame())
    arg7.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig_m.pitchBaseAngle))
    arg7.yawSpring = Spring.new(0, 0)
    arg7.lastPanTick = 0
    local CurrentCamera = workspace.CurrentCamera
    local v11 = CurrentCamera

    if v11 then
        v11 = CurrentCamera.CameraSubject
    end

    assert(CurrentCamera)
    assert(v11)
    assert(v11:IsA("VehicleSeat"))
    local v12, v13 = CameraUtils_m.getLooseBoundingSphere((v11:GetConnectedParts(true)))
    arg7.assemblyRadius = math.max(v13, 5)
    arg7.assemblyOffset = v11.CFrame:Inverse() * v12
    arg7.gamepadZoomLevels = {}

    for _, val in t do
        table.insert(arg7.gamepadZoomLevels, val * arg7.assemblyRadius / 10)
    end

    arg7:SetCameraToSubjectDistance(arg7.gamepadZoomLevels[#arg7.gamepadZoomLevels])
end

function t_1._StepRotation(arg8, arg9, arg10) -- line: 85
    -- upvalues:
    --  [1] CameraInput_m (copy)
    --  [2] SanitizeAngle (copy)
    --  [3] VehicleCameraConfig_m (copy)
    --  [4] MapClamp (copy)

    local YawSpring = arg8.yawSpring
    local PitchSpring = arg8.pitchSpring
    local v14 = CameraInput_m.getRotation(arg9, true)
    local v15 = -v14.Y
    YawSpring.pos = SanitizeAngle(YawSpring.pos + -v14.X)
    PitchSpring.pos = SanitizeAngle(
        (math.clamp(PitchSpring.pos + v15, -1.3962634015954636, 1.3962634015954636))
    )

    if CameraInput_m.getRotationActivated() then
        arg8.lastPanTick = os.clock()
    end

    local v17 = -math.rad(VehicleCameraConfig_m.pitchBaseAngle)

    if os.clock() - arg8.lastPanTick > VehicleCameraConfig_m.autocorrectDelay then
        local v18 = MapClamp(
            arg10,
            VehicleCameraConfig_m.autocorrectMinCarSpeed,
            VehicleCameraConfig_m.autocorrectMaxCarSpeed,
            0,
            VehicleCameraConfig_m.autocorrectResponse
        )
        YawSpring.freq = v18
        PitchSpring.freq = v18
        local v19 = math.rad(VehicleCameraConfig_m.pitchDeadzoneAngle)

        if YawSpring.freq < 0.001 then
            YawSpring.vel = 0
        end

        if PitchSpring.freq < 0.001 then
            PitchSpring.vel = 0
        end

        if v19 >= math.abs((SanitizeAngle(v17 - PitchSpring.pos))) then
            PitchSpring.goal = PitchSpring.pos
        else
            PitchSpring.goal = v17
        end
    else
        YawSpring.freq = 0
        YawSpring.vel = 0
        PitchSpring.freq = 0
        PitchSpring.vel = 0
        PitchSpring.goal = v17
    end

    return CFrame.fromEulerAnglesYXZ(PitchSpring:step(arg9), YawSpring:step(arg9), 0)
end

function t_1._GetThirdPersonLocalOffset(arg11) -- line: 148
    -- upvalues:
    --  [1] VehicleCameraConfig_m (copy)

    return arg11.assemblyOffset + Vector3.new(
        0,
        arg11.assemblyRadius * VehicleCameraConfig_m.verticalCenterOffset,
        0
    )
end

function t_1._GetFirstPersonLocalOffset(t1: table, u1: CFrame) -- line: 152
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

function t_1.Update(arg12) -- line: 166
    -- upvalues:
    --  [1] v9 (ref)
    --  [2] MapClamp (copy)

    local CurrentCamera_1 = workspace.CurrentCamera
    local v23 = CurrentCamera_1 and CurrentCamera_1.CameraSubject
    local VehicleCameraCore = arg12.vehicleCameraCore
    assert(CurrentCamera_1)
    assert(v23)
    assert(v23:IsA("VehicleSeat"))
    v23 = v9
    v9 = 0
    local v24 = arg12:GetSubjectCFrame()
    local v25 = arg12:GetSubjectVelocity()
    local v26 = arg12:GetSubjectRotVelocity()
    local v27 = v25:Dot(v24.ZVector)
    local v28 = math.abs(v27)
    local v29 = v24.YVector:Dot(v26)
    local v30 = math.abs(v29)
    local v31 = v24.XVector:Dot(v26)
    local v32 = math.abs(v31)
    local v33 = arg12:StepZoom()
    local v34 = arg12:_StepRotation(v23, v28)
    local v35 = MapClamp(
        v33,
        0.5,
        arg12.assemblyRadius,
        1,
        0
    )
    local v37 = arg12:_GetThirdPersonLocalOffset():Lerp(arg12:_GetFirstPersonLocalOffset(v24), v35)
    VehicleCameraCore:setTransform(v24)
    local v38 = VehicleCameraCore:step(v23, v32, v30, v35)
    local v39 = CFrame.new(v24 * v37) * v38 * v34

    return v39 * CFrame.new(0, 0, v33), v39
end

function t_1.ApplyVRTransform(_) -- line: 211
end

return t_1
