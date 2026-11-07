-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VehicleCamera.VehicleCameraCore
-- Class: ModuleScript
-- bytes: 5860

local CameraUtils_m = require(script.Parent.Parent.CameraUtils)
local VehicleCameraConfig_m = require(script.Parent.VehicleCameraConfig)
local SanitizeAngle = CameraUtils_m.sanitizeAngle

local _ = function(arg1) --[[ getYaw ]] -- line: 10
    -- upvalues:
    --  [1] SanitizeAngle (copy)

    local _, v2 = arg1:toEulerAnglesYXZ()

    return SanitizeAngle(v2)
end

local _ = function(arg2) --[[ getPitch ]] -- line: 16
    -- upvalues:
    --  [1] SanitizeAngle (copy)

    return SanitizeAngle((arg2:toEulerAnglesYXZ()))
end

local _ = function(
    arg3,
    arg4,
    arg5,
    arg6,
    arg7
) --[[ stepSpringAxis ]] -- line: 22
    -- upvalues:
    --  [1] SanitizeAngle (copy)

    local v3 = SanitizeAngle(arg6 - arg5)
    local v4 = math.exp(-arg4 * arg3)

    return SanitizeAngle((v3 * (1 + arg4 * arg3) + arg7 * arg3) * v4 + arg5), (arg7 * (1 - arg4 * arg3) - v3 * (arg4 * arg4 * arg3)) * v4
end

local t = {}
local Map = CameraUtils_m.map
local MapClamp = CameraUtils_m.mapClamp
t.__index = t

function t.new(arg8, arg9, arg10) -- line: 36
    -- upvalues:
    --  [1] t (copy)

    return (setmetatable(
        { fRising = arg8, fFalling = arg9, g = arg10, p = arg10, v = arg10 * 0 },
        t
    ))
end

function t.step(arg11, arg12) -- line: 46
    local G = arg11.g
    local V = arg11.v
    local v7 = 6.283185307179586 * (V > 0 and arg11.fRising or arg11.fFalling)
    local v8 = arg11.p - G
    local v9 = math.exp(-v7 * arg12)
    local v10 = (v8 * (1 + v7 * arg12) + V * arg12) * v9 + G
    arg11.p, arg11.v = v10, (V * (1 - v7 * arg12) - v8 * (v7 * v7 * arg12)) * v9

    return v10
end

local t_2 = {}
t_2.__index = t_2

function t_2.new(arg13) -- line: 72
    -- upvalues:
    --  [1] SanitizeAngle (copy)
    --  [2] t (copy)
    --  [3] VehicleCameraConfig_m (copy)
    --  [4] t_2 (copy)

    assert(if typeof(arg13) ~= "CFrame" then false else true)
    local t_3 = {
        yawG = nil,
        yawP = nil,
        yawV = 0,
        pitchG = nil,
        pitchP = nil,
        pitchV = 0,
        fSpringYaw = nil,
        fSpringPitch = nil
    }
    local _, v13 = arg13:toEulerAnglesYXZ()
    t_3.yawG = SanitizeAngle(v13)
    local _, v15 = arg13:toEulerAnglesYXZ()
    t_3.yawP = SanitizeAngle(v15)
    t_3.pitchG = SanitizeAngle((arg13:toEulerAnglesYXZ()))
    t_3.pitchP = SanitizeAngle((arg13:toEulerAnglesYXZ()))
    t_3.fSpringYaw = t.new(
        VehicleCameraConfig_m.yawReponseDampingRising,
        VehicleCameraConfig_m.yawResponseDampingFalling,
        0
    )
    t_3.fSpringPitch = t.new(
        VehicleCameraConfig_m.pitchReponseDampingRising,
        VehicleCameraConfig_m.pitchResponseDampingFalling,
        0
    )

    return (setmetatable(t_3, t_2))
end

function t_2.setGoal(arg14, arg15) -- line: 99
    -- upvalues:
    --  [1] SanitizeAngle (copy)

    local _, v17
    assert(if typeof(arg15) ~= "CFrame" then false else true)
    _, v17 = arg15:toEulerAnglesYXZ()
    arg14.yawG = SanitizeAngle(v17)
    arg14.pitchG = SanitizeAngle((arg15:toEulerAnglesYXZ()))
end

function t_2.getCFrame(arg16) -- line: 106
    return CFrame.fromEulerAnglesYXZ(arg16.pitchP, arg16.yawP, 0)
end

function t_2.step(
    arg17,
    arg18,
    arg19,
    arg20,
    arg21
) -- line: 110
    -- upvalues:
    --  [1] MapClamp (copy)
    --  [2] Map (copy)
    --  [3] VehicleCameraConfig_m (copy)
    --  [4] SanitizeAngle (copy)

    assert(if typeof(arg18) ~= "number" then false else true)
    assert(if typeof(arg20) ~= "number" then false else true)
    assert(if typeof(arg19) ~= "number" then false else true)
    assert(if typeof(arg21) ~= "number" then false else true)
    local FSpringYaw = arg17.fSpringYaw
    local FSpringPitch = arg17.fSpringPitch
    FSpringYaw.g = MapClamp(
        Map(
            arg21,
            0,
            1,
            arg20,
            0
        ),
        math.rad(VehicleCameraConfig_m.cutoffMinAngularVelYaw),
        math.rad(VehicleCameraConfig_m.cutoffMaxAngularVelYaw),
        1,
        0
    )
    FSpringPitch.g = MapClamp(
        Map(
            arg21,
            0,
            1,
            arg19,
            0
        ),
        math.rad(VehicleCameraConfig_m.cutoffMinAngularVelPitch),
        math.rad(VehicleCameraConfig_m.cutoffMaxAngularVelPitch),
        1,
        0
    )
    local v26 = 6.283185307179586 * VehicleCameraConfig_m.yawStiffness * FSpringYaw:step(arg18)
    local v28 = 6.283185307179586 * VehicleCameraConfig_m.pitchStiffness * FSpringPitch:step(arg18)
    v28 *= Map(
        arg21,
        0,
        1,
        1,
        VehicleCameraConfig_m.firstPersonResponseMul
    )
    v26 *= Map(
        arg21,
        0,
        1,
        1,
        VehicleCameraConfig_m.firstPersonResponseMul
    )
    local YawG = arg17.yawG
    local YawV = arg17.yawV
    local v29 = SanitizeAngle(arg17.yawP - YawG)
    local v30 = math.exp(-v26 * arg18)
    arg17.yawP, arg17.yawV = SanitizeAngle((v29 * (1 + v26 * arg18) + YawV * arg18) * v30 + YawG), (YawV * (1 - v26 * arg18) - v29 * (v26 * v26 * arg18)) * v30
    local PitchG = arg17.pitchG
    local PitchV = arg17.pitchV
    local v32 = SanitizeAngle(arg17.pitchP - PitchG)
    local v33 = math.exp(-v28 * arg18)
    arg17.pitchP, arg17.pitchV = SanitizeAngle(
        (v32 * (1 + v28 * arg18) + PitchV * arg18) * v33 + PitchG
    ), (PitchV * (1 - v28 * arg18) - v32 * (v28 * v28 * arg18)) * v33

    return arg17:getCFrame()
end

local t_4 = {}
t_4.__index = t_4

function t_4.new(arg22) -- line: 167
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t_4 (copy)

    return (setmetatable({ vrs = t_2.new(arg22) }, t_4))
end

function t_4.step(
    arg23,
    arg24,
    arg25,
    arg26,
    arg27
) -- line: 173
    return arg23.vrs:step(arg24, arg25, arg26, arg27)
end

function t_4.setTransform(arg28, arg29) -- line: 177
    arg28.vrs:setGoal(arg29)
end

return t_4
