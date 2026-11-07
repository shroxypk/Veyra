-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.BoatTween.TweenFunctions
-- Class: ModuleScript
-- bytes: 10041

local Bezier_m = require(script.Bezier)

local function RevBack(arg1) -- line: 3
    arg1 = 1 - arg1

    return 1 - (math.sin(arg1 * 1.5707963267948966) + math.sin(arg1 * 3.141592653589793) * (math.cos(
        arg1 * 3.141592653589793
    ) + 1) / 2)
end

local function Linear(arg2) -- line: 10
    return arg2
end

local v3 = Bezier_m(0.4, 0, 0.6, 1)
local v4 = Bezier_m(0.4, 0, 0.2, 1)
local v5 = Bezier_m(0.4, 0, 1, 1)
local v6 = Bezier_m(0, 0, 0.2, 1)
local v7 = Bezier_m(0.8, 0, 0.2, 1)
local v8 = Bezier_m(0.9, 0.1, 1, 0.2)
local v9 = Bezier_m(0.1, 0.9, 0.2, 1)
local v10 = Bezier_m(0.7, 0, 1, 0.5)
local v11 = Bezier_m(0.2, 0, 0.38, 0.9)
local v12 = Bezier_m(0.4, 0.14, 0.3, 1)
local v13 = Bezier_m(0, 0, 0.38, 0.9)
local v14 = Bezier_m(0, 0, 0.3, 1)
local v15 = Bezier_m(0.2, 0, 1, 0.9)
local v16 = Bezier_m(0.4, 0.14, 1, 1)
local v17 = Bezier_m(0.07, 0.95, 0, 1)

local function Smooth(arg3) -- line: 44
    return arg3 * arg3 * (3 - 2 * arg3)
end

local function Smoother(arg4) -- line: 48
    return arg4 * arg4 * arg4 * (arg4 * (6 * arg4 - 15) + 10)
end

local function RidiculousWiggle(arg5) -- line: 52
    return (math.sin(math.sin(arg5 * 3.141592653589793) * 1.5707963267948966))
end

local function Spring(arg6) -- line: 56
    return -math.exp(-6.9 * arg6) * math.cos(-20.106192982974676 * arg6) + 1
end

local function SoftSpring(arg7) -- line: 60
    return -math.exp(-7.5 * arg7) * math.cos(-10.053096491487338 * arg7) + 1
end

local function OutBounce(arg8) -- line: 64
    return arg8 < 0.36363636363636365 and 7.5625 * arg8 * arg8 or (arg8 < 0.7272727272727273 and 3 + arg8 * (11 * arg8 - 12) * 0.6875 or (arg8 < 0.9090909090909091 and 6 + arg8 * (11 * arg8 - 18) * 0.6875 or 7.875 + arg8 * (11 * arg8 - 21) * 0.6875))
end

local function InBounce(arg9) -- line: 71
    if arg9 > 0.6363636363636364 then
        arg9 -= 1

        return 1 - arg9 * arg9 * 7.5625
    end

    if arg9 > 0.2727272727272727 then
        return (11 * arg9 - 7) * (11 * arg9 - 3) / -16
    end

    if arg9 > 0.09090909090909091 then
        return (11 * (4 - 11 * arg9) * arg9 - 3) / 16
    end

    return arg9 * (11 * arg9 - 1) * -0.6875
end

return (setmetatable({
    Linear = Linear,
    OutSmooth = Smooth,
    InSmooth = Smooth,
    InOutSmooth = Smooth,
    OutSmoother = Smoother,
    InSmoother = Smoother,
    InOutSmoother = Smoother,
    OutRidiculousWiggle = RidiculousWiggle,
    InRidiculousWiggle = RidiculousWiggle,
    InOutRidiculousWiggle = RidiculousWiggle,
    OutRevBack = RevBack,
    InRevBack = RevBack,
    InOutRevBack = RevBack,
    OutSpring = Spring,
    InSpring = Spring,
    InOutSpring = Spring,
    OutSoftSpring = SoftSpring,
    InSoftSpring = SoftSpring,
    InOutSoftSpring = SoftSpring,
    InSharp = v3,
    InOutSharp = v3,
    OutSharp = v3,
    InAcceleration = v5,
    InOutAcceleration = v5,
    OutAcceleration = v5,
    InStandard = v4,
    InOutStandard = v4,
    OutStandard = v4,
    InDeceleration = v6,
    InOutDeceleration = v6,
    OutDeceleration = v6,
    InFabricStandard = v7,
    InOutFabricStandard = v7,
    OutFabricStandard = v7,
    InFabricAccelerate = v8,
    InOutFabricAccelerate = v8,
    OutFabricAccelerate = v8,
    InFabricDecelerate = v9,
    InOutFabricDecelerate = v9,
    OutFabricDecelerate = v9,
    InUWPAccelerate = v10,
    InOutUWPAccelerate = v10,
    OutUWPAccelerate = v10,
    InStandardProductive = v11,
    OutStandardProductive = v11,
    InOutStandardProductive = v11,
    InStandardExpressive = v12,
    OutStandardExpressive = v12,
    InOutStandardExpressive = v12,
    InEntranceProductive = v13,
    OutEntranceProductive = v13,
    InOutEntranceProductive = v13,
    InEntranceExpressive = v14,
    OutEntranceExpressive = v14,
    InOutEntranceExpressive = v14,
    InExitProductive = v15,
    OutExitProductive = v15,
    InOutExitProductive = v15,
    InExitExpressive = v16,
    OutExitExpressive = v16,
    InOutExitExpressive = v16,
    OutMozillaCurve = v17,
    InMozillaCurve = v17,
    InOutMozillaCurve = v17,
    InQuad = function(arg10) --[[ InQuad ]] -- line: 171
        return arg10 * arg10
    end,
    OutQuad = function(arg11) --[[ OutQuad ]] -- line: 175
        return arg11 * (2 - arg11)
    end,
    InOutQuad = function(arg12) --[[ InOutQuad ]] -- line: 179
        return arg12 < 0.5 and 2 * arg12 * arg12 or 2 * (2 - arg12) * arg12 - 1
    end,
    InCubic = function(arg13) --[[ InCubic ]] -- line: 183
        return arg13 * arg13 * arg13
    end,
    OutCubic = function(arg14) --[[ OutCubic ]] -- line: 187
        return 1 - (1 - arg14) * (1 - arg14) * (1 - arg14)
    end,
    InOutCubic = function(arg15) --[[ InOutCubic ]] -- line: 191
        return arg15 < 0.5 and 4 * arg15 * arg15 * arg15 or 1 + 4 * (arg15 - 1) * (arg15 - 1) * (arg15 - 1)
    end,
    InQuart = function(arg16) --[[ InQuart ]] -- line: 195
        return arg16 * arg16 * arg16 * arg16
    end,
    OutQuart = function(arg17) --[[ OutQuart ]] -- line: 199
        arg17 -= 1

        return 1 - arg17 * arg17 * arg17 * arg17
    end,
    InOutQuart = function(arg18) --[[ InOutQuart ]] -- line: 204
        if arg18 < 0.5 then
            arg18 *= arg18

            return 8 * arg18 * arg18
        end

        arg18 -= 1

        return 1 - 8 * arg18 * arg18 * arg18 * arg18
    end,
    InQuint = function(arg19) --[[ InQuint ]] -- line: 214
        return arg19 * arg19 * arg19 * arg19 * arg19
    end,
    OutQuint = function(arg20) --[[ OutQuint ]] -- line: 218
        arg20 -= 1

        return arg20 * arg20 * arg20 * arg20 * arg20 + 1
    end,
    InOutQuint = function(arg21) --[[ InOutQuint ]] -- line: 223
        if arg21 < 0.5 then
            return 16 * arg21 * arg21 * arg21 * arg21 * arg21
        end

        arg21 -= 1

        return 16 * arg21 * arg21 * arg21 * arg21 * arg21 + 1
    end,
    InBack = function(arg22) --[[ InBack ]] -- line: 232
        return arg22 * arg22 * (3 * arg22 - 2)
    end,
    OutBack = function(arg23) --[[ OutBack ]] -- line: 236
        return (arg23 - 1) * (arg23 - 1) * (arg23 * 2 + arg23 - 1) + 1
    end,
    InOutBack = function(arg24) --[[ InOutBack ]] -- line: 240
        return arg24 < 0.5 and 2 * arg24 * arg24 * (6 * arg24 - 2) or 1 + 2 * (arg24 - 1) * (arg24 - 1) * (6 * arg24 - 2 - 2)
    end,
    InSine = function(arg25) --[[ InSine ]] -- line: 244
        return 1 - math.cos(arg25 * 1.5707963267948966)
    end,
    OutSine = function(arg26) --[[ OutSine ]] -- line: 248
        return (math.sin(arg26 * 1.5707963267948966))
    end,
    InOutSine = function(arg27) --[[ InOutSine ]] -- line: 252
        return (1 - math.cos(3.141592653589793 * arg27)) / 2
    end,
    OutBounce = OutBounce,
    InBounce = InBounce,
    InOutBounce = function(arg28) --[[ InOutBounce ]] -- line: 259
        local v24, v26, v27

        if arg28 < 0.5 then
            v24 = 2 * arg28
            v26 = (if not (v24 > 0.6363636363636364) then if not (v24 > 0.2727272727272727) then if not (v24 > 0.09090909090909091) then v24 * (11 * v24 - 1) * -0.6875 else (11 * (4 - 11 * v24) * v24 - 3) / 16 else (11 * v24 - 7) * (11 * v24 - 3) / -16 else 1 - (v24 - 1) * (v24 - 1) * 7.5625) / 2

            if not v26 then
                v27 = 2 * arg28 - 1
                v24 = v27 < 0.36363636363636365 and 7.5625 * v27 * v27 or (v27 < 0.7272727272727273 and 3 + v27 * (11 * v27 - 12) * 0.6875 or (v27 < 0.9090909090909091 and 6 + v27 * (11 * v27 - 18) * 0.6875 or 7.875 + v27 * (11 * v27 - 21) * 0.6875))
                v26 = v24 / 2 + 0.5
            end
        else
            v27 = 2 * arg28 - 1
            v24 = v27 < 0.36363636363636365 and 7.5625 * v27 * v27 or (v27 < 0.7272727272727273 and 3 + v27 * (11 * v27 - 12) * 0.6875 or (v27 < 0.9090909090909091 and 6 + v27 * (11 * v27 - 18) * 0.6875 or 7.875 + v27 * (11 * v27 - 21) * 0.6875))
            v26 = v24 / 2 + 0.5
        end

        return v26
    end,
    InElastic = function(arg29) --[[ InElastic ]] -- line: 263
        return math.exp((arg29 * 0.9638073641881153 - 1) * 8) * arg29 * 0.9638073641881153 * math.sin(
            4 * arg29 * 0.9638073641881153
        ) * 1.8752275007428716
    end,
    OutElastic = function(arg30) --[[ OutElastic ]] -- line: 269
        return 1 + math.exp(8 * (0.9638073641881153 - 0.9638073641881153 * arg30 - 1)) * 0.9638073641881153 * (arg30 - 1) * math.sin(
            3.855229456752461 * (1 - arg30)
        ) * 1.8752275007428716
    end,
    InOutElastic = function(arg31) --[[ InOutElastic ]] -- line: 276
        return arg31 < 0.5 and math.exp(8 * (1.9276147283762306 * arg31 - 1)) * 0.9638073641881153 * arg31 * math.sin(
            7.710458913504922 * arg31
        ) * 1.8752275007428716 or 1 + math.exp(8 * (0.9638073641881153 * (2 - 2 * arg31) - 1)) * 0.9638073641881153 * (arg31 - 1) * math.sin(
            3.855229456752461 * (2 - 2 * arg31)
        ) * 1.8752275007428716
    end,
    InExpo = function(arg32) --[[ InExpo ]] -- line: 281
        return arg32 * arg32 * math.exp(4 * (arg32 - 1))
    end,
    OutExpo = function(arg33) --[[ OutExpo ]] -- line: 285
        return 1 - (1 - arg33) * (1 - arg33) / math.exp(4 * arg33)
    end,
    InOutExpo = function(arg34) --[[ InOutExpo ]] -- line: 289
        return arg34 < 0.5 and 2 * arg34 * arg34 * math.exp(4 * (2 * arg34 - 1)) or 1 - 2 * (arg34 - 1) * (arg34 - 1) * math.exp(
            4 * (1 - 2 * arg34)
        )
    end,
    InCirc = function(arg35) --[[ InCirc ]] -- line: 293
        return -(math.sqrt(1 - arg35 * arg35) - 1)
    end,
    OutCirc = function(arg36) --[[ OutCirc ]] -- line: 297
        arg36 -= 1

        return (math.sqrt(1 - arg36 * arg36))
    end,
    InOutCirc = function(arg37) --[[ InOutCirc ]] -- line: 302
        arg37 *= 2

        if arg37 < 1 then
            return -(math.sqrt(1 - arg37 * arg37) - 1) / 2
        end

        arg37 -= 2

        return (math.sqrt(1 - arg37 * arg37) - 1) / 2
    end
}, {
    __index = function(_, arg39) --[[ __index ]] -- line: 312
        error(tostring(arg39) .. " is not a valid easing style.", 2)
    end
}))
