-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.pkg.Shake
-- Class: ModuleScript
-- bytes: 4074

local RunService: any = game:GetService("RunService")
local rng: any = Random.new()
local v1: number = 0
local t: any = {}
t.__index = t

function t.new() -- line: 254
    -- upvalues:
    --  [1] t (copy)
    --  [2] RunService (copy)
    --  [3] rng (copy)

    local t_1: any = setmetatable({}, t)
    t_1.Amplitude = 1
    t_1.Frequency = 1
    t_1.FadeInTime = 1
    t_1.FadeOutTime = 1
    t_1.SustainTime = 0
    t_1.Sustain = false
    t_1.PositionInfluence = Vector3.new(1, 1, 1)
    t_1.RotationInfluence = Vector3.new(1, 1, 1)
    t_1.TimeFunction = if RunService:IsRunning() then time else os.clock
    t_1._timeOffset = rng:NextNumber(-1000000, 1000000)
    t_1._startTime = 0
    t_1._running = false
    t_1._signalConnections = {}
    t_1._renderBindings = {}

    return t_1
end

function t.InverseSquare(vec1: Vector3, n1: number) -- line: 305
    if n1 < 1 then
        n1 = 1
    end

    return vec1 * (1 / (n1 * n1))
end

function t.NextRenderName() -- line: 321
    -- upvalues:
    --  [1] v1 (ref)

    v1 += 1

    return ("__shake_%.4i__"):format(v1)
end

function t.Start(arg1) -- line: 334
    arg1._startTime = arg1.TimeFunction()
    arg1._running = true
end

function t.Stop(arg2) -- line: 346
    -- upvalues:
    --  [1] RunService (copy)

    arg2._running = false

    for _, val in arg2._renderBindings do
        RunService:UnbindFromRenderStep(val)
    end

    table.clear(arg2._renderBindings)

    for _, val_1 in arg2._signalConnections do
        val_1:Disconnect()
    end

    table.clear(arg2._signalConnections)
end

function t.IsShaking(arg3) -- line: 364
    return arg3._running
end

function t.StopSustain(arg4) -- line: 373
    local v3: any = arg4.TimeFunction()
    arg4.Sustain = false
    arg4.SustainTime = v3 - arg4._startTime - arg4.FadeInTime
end

function t.Update(arg5) -- line: 401
    local v4: boolean = false
    local v5: any = arg5.TimeFunction()
    local v6: any = v5 - arg5._startTime
    local v7: any = (v5 + arg5._timeOffset) / arg5.Frequency % 10000
    v5 = 1
    local v8: number = 1
    v5 = if not (v6 < arg5.FadeInTime) then v5 else v6 / arg5.FadeInTime

    if not arg5.Sustain and v6 > arg5.FadeInTime + arg5.SustainTime then
        if arg5.FadeOutTime == 0 then
            v4 = true
        else
            v8 = 1 - (v6 - arg5.FadeInTime - arg5.SustainTime) / arg5.FadeOutTime
            v4 = if arg5.Sustain then v4 else if not (v6 >= arg5.FadeInTime + arg5.SustainTime + arg5.FadeOutTime) then v4 else true
        end
    end

    local v9 = math.noise(v7, 0) / 2
    local v10 = math.noise(0, v7) / 2
    local v12: any = Vector3.new(v9, v10, math.noise(v7, v7) / 2) * arg5.Amplitude * math.min(
        v5,
        v8
    )

    if v4 then
        arg5:Stop()
    end

    return arg5.PositionInfluence * v12, arg5.RotationInfluence * v12, v4
end

function t.OnSignal(t1: table, arg6: any, f1: (...any) -> ...any) -- line: 459
    local v14: any = arg6:Connect(function() -- line: 460
        -- upvalues:
        --  [1] f1 (copy)
        --  [2] t1 (copy)

        f1(t1:Update())
    end)
    table.insert(t1._signalConnections, v14)

    return v14
end

function t.BindToRenderStep(t2: table, s1: string, n2: number, f2: (...any) -> ...any) -- line: 489
    -- upvalues:
    --  [1] RunService (copy)

    RunService:BindToRenderStep(s1, n2, function() -- line: 490
        -- upvalues:
        --  [1] f2 (copy)
        --  [2] t2 (copy)

        f2(t2:Update())
    end)
    table.insert(t2._renderBindings, s1)
end

function t.Clone(arg7) -- line: 526
    -- upvalues:
    --  [1] t (copy)

    local v16: any = t.new()

    for _, val_2 in {
        "Amplitude",
        "Frequency",
        "FadeInTime",
        "FadeOutTime",
        "SustainTime",
        "Sustain",
        "PositionInfluence",
        "RotationInfluence",
        "TimeFunction"
    } do
        v16[val_2] = arg7[val_2]
    end

    return v16
end

function t.Destroy(arg8) -- line: 548
    arg8:Stop()
end

return { new = t.new, InverseSquare = t.InverseSquare, NextRenderName = t.NextRenderName }
