-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.BoatTween
-- Class: ModuleScript
-- bytes: 12313

local t = {}
local RunService = game:GetService("RunService")
local t_1 = { Heartbeat = true, Stepped = true, RenderStepped = true }

if not RunService:IsClient() then
    t_1.RenderStepped = nil
end

local TweenFunctions_m = require(script.TweenFunctions)
local t_2 = {
    Linear = {
        In = TweenFunctions_m.Linear,
        Out = TweenFunctions_m.Linear,
        InOut = TweenFunctions_m.Linear
    },
    Quad = {
        In = TweenFunctions_m.InQuad,
        Out = TweenFunctions_m.OutQuad,
        InOut = TweenFunctions_m.InOutQuad
    },
    Cubic = {
        In = TweenFunctions_m.InCubic,
        Out = TweenFunctions_m.OutCubic,
        InOut = TweenFunctions_m.InOutCubic
    },
    Quart = {
        In = TweenFunctions_m.InQuart,
        Out = TweenFunctions_m.OutQuart,
        InOut = TweenFunctions_m.InOutQuart
    },
    Quint = {
        In = TweenFunctions_m.InQuint,
        Out = TweenFunctions_m.OutQuint,
        InOut = TweenFunctions_m.InOutQuint
    },
    Sine = {
        In = TweenFunctions_m.InSine,
        Out = TweenFunctions_m.OutSine,
        InOut = TweenFunctions_m.InOutSine
    },
    Expo = {
        In = TweenFunctions_m.InExpo,
        Out = TweenFunctions_m.OutExpo,
        InOut = TweenFunctions_m.InOutExpo
    },
    Circ = {
        In = TweenFunctions_m.InCirc,
        Out = TweenFunctions_m.OutCirc,
        InOut = TweenFunctions_m.InOutCirc
    },
    Elastic = {
        In = TweenFunctions_m.InElastic,
        Out = TweenFunctions_m.OutElastic,
        InOut = TweenFunctions_m.InOutElastic
    },
    Back = {
        In = TweenFunctions_m.InBack,
        Out = TweenFunctions_m.OutBack,
        InOut = TweenFunctions_m.InOutBack
    },
    Bounce = {
        In = TweenFunctions_m.InBounce,
        Out = TweenFunctions_m.OutBounce,
        InOut = TweenFunctions_m.InOutBounce
    },
    Smooth = {
        In = TweenFunctions_m.InSmooth,
        Out = TweenFunctions_m.OutSmooth,
        InOut = TweenFunctions_m.InOutSmooth
    },
    Smoother = {
        In = TweenFunctions_m.InSmoother,
        Out = TweenFunctions_m.OutSmoother,
        InOut = TweenFunctions_m.InOutSmoother
    },
    RidiculousWiggle = {
        In = TweenFunctions_m.InRidiculousWiggle,
        Out = TweenFunctions_m.OutRidiculousWiggle,
        InOut = TweenFunctions_m.InOutRidiculousWiggle
    },
    RevBack = {
        In = TweenFunctions_m.InRevBack,
        Out = TweenFunctions_m.OutRevBack,
        InOut = TweenFunctions_m.InOutRevBack
    },
    Spring = {
        In = TweenFunctions_m.InSpring,
        Out = TweenFunctions_m.OutSpring,
        InOut = TweenFunctions_m.InOutSpring
    },
    SoftSpring = {
        In = TweenFunctions_m.InSoftSpring,
        Out = TweenFunctions_m.OutSoftSpring,
        InOut = TweenFunctions_m.InOutSoftSpring
    },
    Sharp = {
        In = TweenFunctions_m.InSharp,
        Out = TweenFunctions_m.OutSharp,
        InOut = TweenFunctions_m.InOutSharp
    },
    Acceleration = {
        In = TweenFunctions_m.InAcceleration,
        Out = TweenFunctions_m.OutAcceleration,
        InOut = TweenFunctions_m.InOutAcceleration
    },
    Standard = {
        In = TweenFunctions_m.InStandard,
        Out = TweenFunctions_m.OutStandard,
        InOut = TweenFunctions_m.InOutStandard
    },
    Deceleration = {
        In = TweenFunctions_m.InDeceleration,
        Out = TweenFunctions_m.OutDeceleration,
        InOut = TweenFunctions_m.InOutDeceleration
    },
    FabricStandard = {
        In = TweenFunctions_m.InFabricStandard,
        Out = TweenFunctions_m.OutFabricStandard,
        InOut = TweenFunctions_m.InOutFabricStandard
    },
    FabricAccelerate = {
        In = TweenFunctions_m.InFabricAccelerate,
        Out = TweenFunctions_m.OutFabricAccelerate,
        InOut = TweenFunctions_m.InOutFabricAccelerate
    },
    FabricDecelerate = {
        In = TweenFunctions_m.InFabricDecelerate,
        Out = TweenFunctions_m.OutFabricDecelerate,
        InOut = TweenFunctions_m.InOutFabricDecelerate
    },
    UWPAccelerate = {
        In = TweenFunctions_m.InUWPAccelerate,
        Out = TweenFunctions_m.OutUWPAccelerate,
        InOut = TweenFunctions_m.InOutUWPAccelerate
    },
    StandardProductive = {
        In = TweenFunctions_m.InStandardProductive,
        Out = TweenFunctions_m.OutStandardProductive,
        InOut = TweenFunctions_m.InOutStandardProductive
    },
    EntranceProductive = {
        In = TweenFunctions_m.InEntranceProductive,
        Out = TweenFunctions_m.OutEntranceProductive,
        InOut = TweenFunctions_m.InOutEntranceProductive
    },
    ExitProductive = {
        In = TweenFunctions_m.InExitProductive,
        Out = TweenFunctions_m.OutExitProductive,
        InOut = TweenFunctions_m.InOutExitProductive
    },
    StandardExpressive = {
        In = TweenFunctions_m.InStandardExpressive,
        Out = TweenFunctions_m.OutStandardExpressive,
        InOut = TweenFunctions_m.InOutStandardExpressive
    },
    EntranceExpressive = {
        In = TweenFunctions_m.InEntranceExpressive,
        Out = TweenFunctions_m.OutEntranceExpressive,
        InOut = TweenFunctions_m.InOutEntranceExpressive
    },
    ExitExpressive = {
        In = TweenFunctions_m.InExitExpressive,
        Out = TweenFunctions_m.OutExitExpressive,
        InOut = TweenFunctions_m.InOutExitExpressive
    },
    MozillaCurve = {
        In = TweenFunctions_m.InMozillaCurve,
        Out = TweenFunctions_m.OutMozillaCurve,
        InOut = TweenFunctions_m.InOutMozillaCurve
    }
}
local Lerps_m = require(script.Lerps)

function t.Create(_, arg2, arg3) -- line: 270
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] RunService (copy)
    --  [3] t_2 (copy)
    --  [4] Lerps_m (copy)

    local DelayTime_1, Goal, Time, g_type, t_35

    if arg2 then
        if typeof(arg2) ~= "Instance" then
            warn("Invalid object to tween:", arg2)

            return
        end

        local v1 = arg3

        if type(arg3) ~= "table" or not v1 then
            v1 = {}
        end

        local v2 = v1
        v1 = t_1[v2.StepType] and RunService[v2.StepType] or RunService.Stepped
        local v4 = t_2[v2.EasingStyle or "Quad"][v2.EasingDirection or "In"]
        Time = v2.Time
        g_type = type(Time)
        local v5 = v2.Time

        if g_type ~= "number" or not v5 then
            v5 = 1
        end

        local v8 = math.clamp(v5, 0, 9999999999)
        Goal = v2.Goal
        local v9 = type(Goal)
        v5 = v2.Goal

        if v9 ~= "table" or not v5 then
            v5 = {}
        end

        v9 = false

        if type(v2.DelayTime) == "number" then
            DelayTime_1 = v2.DelayTime
            local v10 = 0.027
            v9 = DelayTime_1 > v10 and v2.DelayTime
        end

        local v12

        if type(v2.RepeatCount) == "number" then
            v12 = math.clamp(v2.RepeatCount, -1, 999999999) or 0
        else
            v12 = 0
        end

        local v13 = v12 + 1
        v12 = {}

        for key, val in pairs(v5) do
            local v15 = Lerps_m[typeof(val)](arg2[key], val)
            v12[key] = v15
        end

        local BindableEvent_2 = Instance.new("BindableEvent")
        local BindableEvent = Instance.new("BindableEvent")
        local BindableEvent_3 = Instance.new("BindableEvent")
        local v21 = nil
        local v22 = tick()
        local v23 = 0
        t_35 = { Instance = arg2 }
        t_35.PlaybackState = Enum.PlaybackState.Begin
        t_35.Completed = BindableEvent_2.Event
        t_35.Resumed = BindableEvent_3.Event
        t_35.Stopped = BindableEvent.Event

        function t_35.Destroy(_) -- line: 311
            -- upvalues:
            --  [1] v21 (ref)
            --  [2] BindableEvent_2 (copy)
            --  [3] BindableEvent (copy)
            --  [4] BindableEvent_3 (copy)
            --  [5] t_35 (ref)

            if v21 then
                v21:Disconnect()
                v21 = nil
            end

            BindableEvent_2:Destroy()
            BindableEvent:Destroy()
            BindableEvent_3:Destroy()
            t_35 = nil
        end

        local v24 = false
        local v25 = 0

        local function Play(arg5, arg6) -- line: 327
            -- upvalues:
            --  [1] v21 (ref)
            --  [2] v13 (copy)
            --  [3] t_35 (ref)
            --  [4] BindableEvent_2 (copy)
            --  [5] v24 (ref)
            --  [6] v25 (ref)
            --  [7] v9 (copy)
            --  [8] v22 (ref)
            --  [9] v23 (ref)
            --  [10] v1 (copy)
            --  [11] v8 (copy)
            --  [12] v12 (copy)
            --  [13] arg2 (copy)
            --  [14] Play (copy)
            --  [15] v2 (ref)
            --  [16] v4 (copy)

            if v21 then
                v21:Disconnect()
                v21 = nil
            end

            arg5 = arg5 or 1

            if v13 ~= 0 and arg5 > v13 then
                t_35.PlaybackState = Enum.PlaybackState.Completed
                BindableEvent_2:Fire()
                v24 = false
                v25 = 1

                return
            end

            v25 = arg5

            if arg6 then
                v24 = true
            end

            if v9 then
                t_35.PlaybackState = Enum.PlaybackState.Delayed
                wait(v9)
            end

            v22 = tick() - v23
            v21 = v1:Connect(function() -- line: 354
                -- upvalues:
                --  [1] v23 (ref)
                --  [2] v22 (ref)
                --  [3] v8 (ref)
                --  [4] arg6 (copy)
                --  [5] v12 (ref)
                --  [6] arg2 (ref)
                --  [7] v21 (ref)
                --  [8] Play (ref)
                --  [9] arg5 (ref)
                --  [10] v2 (ref)
                --  [11] v4 (ref)

                v23 = tick() - v22

                if v23 >= v8 then
                    if arg6 then
                        for key_1, val_1 in pairs(v12) do
                            arg2[key_1] = val_1(0)
                        end
                    else
                        for key_2, val_2 in pairs(v12) do
                            arg2[key_2] = val_2(1)
                        end
                    end

                    v21:Disconnect()
                    v21 = nil

                    if arg6 then
                        v23 = 0
                        Play(arg5 + 1, false)

                        return
                    end

                    if v2.Reverses then
                        v23 = 0
                        Play(arg5, true)

                        return
                    end

                    v23 = 0
                    Play(arg5 + 1, false)

                    return
                else
                    if arg6 then
                        for key_3, val_3 in pairs(v12) do
                            arg2[key_3] = val_3((math.clamp(v4(1 - v23 / v8), 0, 1)))
                        end

                        return
                    end

                    for key_4, val_4 in pairs(v12) do
                        arg2[key_4] = val_4((math.clamp(v4(v23 / v8), 0, 1)))
                    end

                    return
                end
            end)
            t_35.PlaybackState = Enum.PlaybackState.Playing
        end

        function t_35.Play(_) -- line: 396
            -- upvalues:
            --  [1] v23 (ref)
            --  [2] Play (copy)

            v23 = 0
            Play(1, false)
        end

        function t_35.Stop(_) -- line: 401
            -- upvalues:
            --  [1] v21 (ref)
            --  [2] t_35 (ref)
            --  [3] BindableEvent (copy)

            if v21 then
                v21:Disconnect()
                v21 = nil
                t_35.PlaybackState = Enum.PlaybackState.Cancelled
                BindableEvent:Fire()
            end
        end

        function t_35.Resume(_) -- line: 410
            -- upvalues:
            --  [1] Play (copy)
            --  [2] v25 (ref)
            --  [3] v24 (ref)
            --  [4] BindableEvent_3 (copy)

            Play(v25, v24)
            BindableEvent_3:Fire()
        end

        return t_35
    else
        warn("Invalid object to tween:", arg2)

        return
    end
end

return t
