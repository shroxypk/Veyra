-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Initialize.UI_EmitterModule
-- Class: ModuleScript
-- bytes: 6834

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local t = {}
local RunService = Services_m.RunService
local rng = Random.new()
local t_1 = {}
local t_2 = {}
local t_3 = {}
local now = tick()
local _ = nil
local v3 = Services_m.Maid.new()
v3:GiveTask(RunService.RenderStepped:Connect(function(deltaTime) -- line: 19
    -- upvalues:
    --  [1] _ (ref)
    --  [2] now (copy)
    --  [3] t_1 (copy)
    --  [4] t_2 (copy)
    --  [5] t_3 (copy)

    _ = tick() - now

    for _, val in pairs(t_1) do
        if val.Emitter.Enabled then
            if tick() - val.lastEmission >= val.Emitter.Rate ^ (-1) then
                val.lastEmission = tick()
                addParticle(val.Emitter, val.Emitter.Parent, val.Scale)
            end
        end
    end

    local t_4 = {}

    for _, val_1 in pairs(t_2) do
        local v4 = tick() - val_1.Start
        local v5 = v4 / val_1.Lifetime

        if v4 >= val_1.Lifetime then
            table.insert(t_4, val_1)
        else
            local v6, v7, v8 = getKeypointsFromTime(val_1.Transparency, v5)
            val_1.UI.ImageTransparency = lerpValue(v6.Value, v7.Value, v8)
            local v9, v10, v11 = getKeypointsFromTime(val_1.Size, v5)
            local v12 = lerpValue(v9.Value, v10.Value, v11) * 100 * val_1.Scale
            val_1.UI.Size = UDim2.new(0, v12, 0, v12)
            local v13, v14, v15 = getKeypointsFromTime(val_1.Emitter.Color, v5)
            val_1.UI.ImageColor3 = v13.Value:Lerp(v14.Value, v15)
            val_1.UI.Rotation += val_1.RotSpeed * deltaTime
            local _ = val_1.UI.Position
            local Speed = val_1.Speed
            local v17 = 1 - math.min(1, v4 ^ 4 * (val_1.Emitter.Drag / 10))
            local v18 = val_1.SpreadAngle
            val_1.SpeedDisplacement += Speed * deltaTime * v17

            if val_1.Emitter.EmissionDirection == Enum.NormalId.Bottom then
                v18 += 180
            else
                v18 = if val_1.Emitter.EmissionDirection ~= Enum.NormalId.Right then if val_1.Emitter.EmissionDirection ~= Enum.NormalId.Left then v18 else v18 + 270 else v18 + 90
            end

            local udim2 = UDim2.new(
                0,
                math.sin((math.rad(v18))) * val_1.SpeedDisplacement,
                0,
                -math.cos((math.rad(v18))) * val_1.SpeedDisplacement
            )
            val_1.Accel += val_1.Emitter.Acceleration * 100 * val_1.Scale * v4 ^ 2 * deltaTime * v17
            val_1.UI.Position = val_1.StartPos + udim2 + UDim2.new(
                0,
                val_1.Accel.X,
                0,
                -val_1.Accel.Y
            )
        end
    end

    for _, val_2 in pairs(t_4) do
        val_2.UI.ImageTransparency = 1
        local t_5 = { UI = val_2.UI, RemoveAt = nil }
        local v25 = t_3
        t_5.RemoveAt = tick() + 3 * val_2.Emitter.Rate ^ (-1)
        table.insert(v25, t_5)
        table.remove(t_2, table.find(t_2, val_2))
    end

    local t_6 = {}

    for _, val_3 in pairs(t_3) do
        if tick() >= val_3.RemoveAt then
            val_3.UI:Destroy()
            table.insert(t_6, val_3)
        end
    end

    for _, val_4 in pairs(t_6) do
        table.remove(t_3, table.find(t_3, val_4))
    end
end))

function lerpValue(arg2, arg3, arg4) -- line: 110
    return arg2 + (arg3 - arg2) * arg4
end

function r_num(arg5, arg6) -- line: 114
    -- upvalues:
    --  [1] rng (copy)

    return rng:NextNumber(arg6 and arg5 or 0, arg6 or arg5)
end

function r_int(arg7, arg8) -- line: 118
    -- upvalues:
    --  [1] rng (copy)

    return rng:NextInteger(arg8 and arg7 or 0, arg8 or arg7)
end

function addParticle(arg9, arg10, arg11) -- line: 122
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t_2 (copy)

    local v30 = nil

    for _, val_5 in pairs(t_3) do
        if val_5.UI and val_5.UI.Parent then
            v30 = val_5.UI
            v30.Parent = arg10
            table.remove(t_3, table.find(t_3, val_5))
            break
        end
    end

    if not v30 then
        v30 = Instance.new("ImageLabel", arg10)
        v30.BackgroundTransparency = 1
        v30.AnchorPoint = Vector2.new(0.5, 0.5)
    end

    v30.Image = arg9.Texture
    v30.ZIndex = arg9.ZOffset
    local udim2_1 = UDim2.new(r_num(0, 1), 0, r_num(0, 1), 0)
    v30.Position = udim2_1
    v30.ImageColor3 = arg9.Color.Keypoints[1].Value
    local v34 = arg9.Size.Keypoints[1]
    local v35 = r_num(v34.Value - v34.Envelope, v34.Value + v34.Envelope) * 100 * arg11
    v30.Size = UDim2.new(0, v35, 0, v35)
    local v36 = arg9.Transparency.Keypoints[1]
    v30.ImageTransparency = r_num(v36.Value - v36.Envelope, v36.Value + v36.Envelope)
    v30.Rotation = r_num(arg9.Rotation.Min, arg9.Rotation.Max)
    local v37 = r_num(arg9.Speed.Min, arg9.Speed.Max) * 100 * arg11
    local v38 = r_num(arg9.RotSpeed.Min, arg9.RotSpeed.Max)
    local v39 = r_num(-arg9.SpreadAngle.X, arg9.SpreadAngle.Y)
    local v40 = getRandomNumberSequence(arg9.Transparency)
    local v41 = getRandomNumberSequence(arg9.Size)
    local t_7 = {
        Emitter = arg9,
        UI = v30,
        Start = tick(),
        Lifetime = r_num(arg9.Lifetime.Min, arg9.Lifetime.Max),
        Transparency = v40,
        Size = v41,
        Speed = v37,
        RotSpeed = v38,
        SpreadAngle = v39,
        StartPos = udim2_1,
        SpeedDisplacement = 0,
        Accel = Vector3.new(0, 0, 0),
        Scale = arg11
    }
    table.insert(t_2, t_7)
end

function getRandomNumberSequence(arg12) -- line: 175
    local t_8 = { Keypoints = {} }

    for _, val_6 in pairs(arg12.Keypoints) do
        local t_9 = {
            Time = val_6.Time,
            Value = r_num(val_6.Value - val_6.Envelope, val_6.Value + val_6.Envelope)
        }
        table.insert(t_8.Keypoints, t_9)
    end

    return t_8
end

function getKeypointsFromTime(arg13, arg14) -- line: 185
    for key_7, val_7 in pairs(arg13.Keypoints) do
        if arg14 < val_7.Time then
            local v43 = arg13.Keypoints[key_7 - 1]
            local v44 = arg13.Keypoints[key_7]

            return v43, v44, (arg14 - v43.Time) / (v44.Time - v43.Time)
        end
    end
end

function t.AddEmitter(_, arg16, arg17) -- line: 196
    -- upvalues:
    --  [1] t_1 (copy)

    local t_10 = { Emitter = arg16, lastEmission = tick(), Scale = arg17 or 1 }
    table.insert(t_1, t_10)
end

function t.RemoveEmitter(_, arg19) -- line: 200
    -- upvalues:
    --  [1] t_1 (copy)

    local t_11 = {}

    for _, val_8 in pairs(t_1) do
        if val_8.Emitter == arg19 then
            table.insert(t_11, val_8)
            break
        end
    end

    for _, val_9 in pairs(t_11) do
        table.remove(t_1, table.find(t_1, val_9))
    end
end

function t.Disconnect(_) -- line: 215
    -- upvalues:
    --  [1] v3 (copy)

    v3:Destroy()
end

return t
