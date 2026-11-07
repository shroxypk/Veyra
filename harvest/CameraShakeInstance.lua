-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.CameraShaker.CameraShaker.CameraShakeInstance
-- Class: ModuleScript
-- bytes: 3774

local t = {}
t.__index = t
local New = Vector3.new
local math_noise = math.noise
t.CameraShakeState = { FadingIn = 0, FadingOut = 1, Sustained = 2, Inactive = 3 }

function t.new(arg1, arg2, arg3, arg4) -- line: 28
    -- upvalues:
    --  [1] New (copy)
    --  [2] t (copy)

    if arg3 == nil then
        arg3 = 0
    end

    if arg4 == nil then
        arg4 = 0
    end

    assert(if type(arg1) ~= "number" then false else true, "Magnitude must be a number")
    assert(if type(arg2) ~= "number" then false else true, "Roughness must be a number")
    assert(if type(arg3) ~= "number" then false else true, "FadeInTime must be a number")
    assert(if type(arg4) ~= "number" then false else true, "FadeOutTime must be a number")

    return (setmetatable(
        {
            Magnitude = arg1,
            Roughness = arg2,
            PositionInfluence = New(),
            RotationInfluence = New(),
            DeleteOnInactive = true,
            roughMod = 1,
            magnMod = 1,
            fadeOutDuration = arg4,
            fadeInDuration = arg3,
            sustain = arg3 > 0 and true,
            currentFadeTime = if not (arg3 > 0) then 1 else 0,
            tick = Random.new():NextNumber(-100, 100),
            _camShakeInstance = true
        },
        t
    ))
end

function t.UpdateShake(arg5, arg6) -- line: 59
    -- upvalues:
    --  [1] math_noise (copy)
    --  [2] New (copy)

    local Tick = arg5.tick
    local v3 = arg5.currentFadeTime
    local v6 = New(
        math_noise(Tick, 0) * 0.5,
        math_noise(0, Tick) * 0.5,
        math_noise(Tick, Tick) * 0.5
    )

    if arg5.fadeInDuration > 0 and arg5.sustain then
        if v3 < 1 then
            v3 += arg6 / arg5.fadeInDuration
        elseif arg5.fadeOutDuration > 0 then
            arg5.sustain = false
        end
    end

    if not arg5.sustain then
        v3 -= arg6 / arg5.fadeOutDuration
    end

    if arg5.sustain then
        arg5.tick = Tick + arg6 * arg5.Roughness * arg5.roughMod
    else
        arg5.tick = Tick + arg6 * arg5.Roughness * arg5.roughMod * v3
    end

    arg5.currentFadeTime = v3

    return v6 * arg5.Magnitude * arg5.magnMod * v3
end

function t.StartFadeOut(arg7, arg8) -- line: 95
    if arg8 == 0 then
        arg7.currentFadeTime = 0
    end

    arg7.fadeOutDuration = arg8
    arg7.fadeInDuration = 0
    arg7.sustain = false
end

function t.StartFadeIn(arg9, arg10) -- line: 105
    if arg10 == 0 then
        arg9.currentFadeTime = 1
    end

    local v7 = arg10 or arg9.fadeInDuration
    arg9.fadeInDuration = v7
    arg9.fadeOutDuration = 0
    arg9.sustain = true
end

function t.GetScaleRoughness(arg11) -- line: 115
    return arg11.roughMod
end

function t.SetScaleRoughness(arg12, arg13) -- line: 120
    arg12.roughMod = arg13
end

function t.GetScaleMagnitude(arg14) -- line: 125
    return arg14.magnMod
end

function t.SetScaleMagnitude(arg15, arg16) -- line: 130
    arg15.magnMod = arg16
end

function t.GetNormalizedFadeTime(arg17) -- line: 135
    return arg17.currentFadeTime
end

function t.IsShaking(arg18) -- line: 140
    return arg18.currentFadeTime > 0 or arg18.sustain
end

function t.IsFadingOut(arg19) -- line: 145
    return not arg19.sustain and arg19.currentFadeTime > 0
end

function t.IsFadingIn(arg20) -- line: 150
    return arg20.currentFadeTime < 1 and (arg20.sustain and arg20.fadeInDuration > 0)
end

function t.GetState(arg21) -- line: 155
    -- upvalues:
    --  [1] t (copy)

    if arg21:IsFadingIn() then
        return t.CameraShakeState.FadingIn
    end

    if arg21:IsFadingOut() then
        return t.CameraShakeState.FadingOut
    end

    if arg21:IsShaking() then
        return t.CameraShakeState.Sustained
    end

    return t.CameraShakeState.Inactive
end

return t
