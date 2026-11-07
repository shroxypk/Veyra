-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.LightningBolt
-- Class: ModuleScript
-- bytes: 10267

local os_clock = os.clock

function DiscretePulse(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5,
    arg6,
    arg7
) -- line: 9
    return (math.clamp(
        arg3 / (2 * arg4) - math.abs((arg1 - arg5 * arg2 + 0.5 * arg3) / arg4),
        arg6,
        arg7
    ))
end

function NoiseBetween(
    arg8,
    arg9,
    arg10,
    arg11,
    arg12
) -- line: 13
    return arg11 + (arg12 - arg11) * (math.noise(arg8, arg9, arg10) + 0.5)
end

function CubicBezier(
    arg13,
    arg14,
    arg15,
    arg16,
    arg17
) -- line: 17
    return arg13 * (1 - arg17) ^ 3 + arg14 * 3 * arg17 * (1 - arg17) ^ 2 + arg15 * 3 * (1 - arg17) * arg17 ^ 2 + arg16 * arg17 ^ 3
end

local BoltPart_Part = Instance.new("Part")
BoltPart_Part.TopSurface, BoltPart_Part.BottomSurface = 0, 0
BoltPart_Part.Anchored, BoltPart_Part.CanCollide = true, false
BoltPart_Part.Shape = "Cylinder"
BoltPart_Part.Name = "BoltPart"
BoltPart_Part.Material = Enum.Material.Neon
BoltPart_Part.Color = Color3.new(1, 1, 1)
BoltPart_Part.Transparency = 1
local _ = Random.new()
local v3 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse()
local t = {}
local t_1 = {}
t_1.__index = t_1

function t_1.new(arg18, arg19, arg20, arg21) -- line: 46
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] BoltPart_Part (copy)
    --  [3] v3 (copy)
    --  [4] os_clock (copy)
    --  [5] t (copy)

    local t_2 = setmetatable({}, t_1)
    t_2.Enabled = true
    t_2.Attachment0 = arg18
    t_2.Attachment1 = arg19
    t_2.CurveSize0, t_2.CurveSize1 = 0, 0
    t_2.MinRadius, t_2.MaxRadius = 0, 2.4
    t_2.Frequency = 1
    t_2.AnimationSpeed = 7
    t_2.Thickness = arg21 or 1
    t_2.MinThicknessMultiplier, t_2.MaxThicknessMultiplier = 0.2, 1
    t_2.MinTransparency, t_2.MaxTransparency = 0, 1
    t_2.PulseSpeed = 2
    t_2.PulseLength = 1000000
    t_2.FadeLength = 0.2
    t_2.ContractFrom = 0.5
    t_2.Color = Color3.new(1, 1, 1)
    t_2.ColorOffsetSpeed = 3
    t_2.Parts = {}
    local v4 = arg18
    local v5 = arg19
    local Effects = workspace.Effects
    local WorldPosition = v4.WorldPosition
    local v6 = v4.WorldPosition + v4.WorldAxis * t_2.CurveSize0
    local v7 = v5.WorldPosition - v5.WorldAxis * t_2.CurveSize1
    local WorldPosition_1 = v5.WorldPosition
    local v8 = WorldPosition
    local v9 = WorldPosition
    local v10 = arg20 or 30

    for index = 1, v10 do
        local v11 = CubicBezier(
            WorldPosition,
            v6,
            v7,
            WorldPosition_1,
            index / v10
        )
        local v12 = if index == v10 then v11 else CFrame.lookAt(v9, v11).Position or v11
        local v13 = BoltPart_Part:Clone()
        v13.Size = Vector3.new((v12 - v8).Magnitude, 0, 0)
        v13.CFrame = CFrame.lookAt(0.5 * (v8 + v12), v12) * v3
        v13.Parent = Effects
        v13.Locked, v13.CastShadow = true, false
        t_2.Parts[index], v8, v9 = v13, v12, v11
    end

    t_2.PartsHidden = false
    t_2.DisabledTransparency = 1
    t_2.StartT = os_clock()
    t_2.RanNum = math.random() * 100
    t_2.RefIndex = #t + 1
    t[t_2.RefIndex] = t_2

    return t_2
end

function t_1.Destroy(arg22) -- line: 111
    -- upvalues:
    --  [1] t (copy)

    t[arg22.RefIndex] = nil

    for index_1 = 1, #arg22.Parts do
        local _ = #arg22.Parts
        arg22.Parts[index_1]:Destroy()

        if index_1 % 100 == 0 then
            wait()
        end
    end
end

game:GetService("RunService").Heartbeat:Connect(function() -- line: 125
    -- upvalues:
    --  [1] t (copy)
    --  [2] os_clock (copy)
    --  [3] v3 (copy)

    for _, val in pairs(t) do
        if val.Enabled == true then
            val.PartsHidden = false
            local v15 = 1 - val.MaxTransparency
            local v16 = 1 - val.MinTransparency
            local MinRadius = val.MinRadius
            local MaxRadius = val.MaxRadius
            local Thickness = val.Thickness
            local Parts = val.Parts
            local v18 = #Parts
            local RanNum = val.RanNum
            local AnimationSpeed = val.AnimationSpeed
            local Frequency = val.Frequency
            local MinThicknessMultiplier = val.MinThicknessMultiplier
            local MaxThicknessMultiplier = val.MaxThicknessMultiplier
            local Attachment0 = val.Attachment0
            local Attachment1 = val.Attachment1
            local WorldPosition_2 = Attachment0.WorldPosition
            local v19 = Attachment0.WorldPosition + Attachment0.WorldAxis * val.CurveSize0
            local v20 = Attachment1.WorldPosition - Attachment1.WorldAxis * val.CurveSize1
            local WorldPosition_3 = Attachment1.WorldPosition
            local v21 = os_clock() - val.StartT
            local PulseLength = val.PulseLength
            local PulseSpeed = val.PulseSpeed
            local FadeLength = val.FadeLength
            local Color = val.Color
            local ColorOffsetSpeed = val.ColorOffsetSpeed
            local v22 = 1 - val.ContractFrom
            local v23 = WorldPosition_2
            local v24 = WorldPosition_2

            if v21 < (PulseLength + 1) / PulseSpeed then
                for index_2 = 1, v18 do
                    local v25 = Parts[index_2]
                    local v26 = index_2 / v18
                    local v27 = DiscretePulse(
                        v26,
                        PulseSpeed,
                        PulseLength,
                        FadeLength,
                        v21,
                        v15,
                        v16
                    )
                    local v28 = CubicBezier(
                        WorldPosition_2,
                        v19,
                        v20,
                        WorldPosition_3,
                        v26
                    )
                    local v29 = -v21
                    local v30 = AnimationSpeed * v29 + Frequency * 10 * v26 - 0.2 + RanNum * 4
                    local v31 = 5 * (AnimationSpeed * 0.01 * v29 / 10 + Frequency * v26) + RanNum * 4
                    local v33 = NoiseBetween(
                        5 * v30,
                        1.5,
                        1 * v31,
                        0,
                        0.6283185307179586
                    ) + NoiseBetween(
                        0.5 * v30,
                        1.5,
                        0.1 * v31,
                        0,
                        5.654866776461628
                    )
                    local v35 = NoiseBetween(
                        3.4,
                        v31,
                        v30,
                        MinRadius,
                        MaxRadius
                    ) * math.exp((v26 - 0.5) ^ 10 * -5000)
                    local v36 = NoiseBetween(
                        2.3,
                        v31,
                        v30,
                        MinThicknessMultiplier,
                        MaxThicknessMultiplier
                    )
                    local v41 = index_2 ~= v18 and (CFrame.new(v24, v28) * CFrame.Angles(0, 0, v33) * CFrame.Angles(
                        math.acos(
                            (math.clamp(
                                NoiseBetween(
                                    v31,
                                    v30,
                                    2.7,
                                    6.123233995736766E-17,
                                    1
                                ),
                                -1,
                                1
                            ))
                        ),
                        0,
                        0
                    ) * CFrame.new(0, 0, -v35)).Position or v28

                    if v22 < v27 then
                        v25.Size = Vector3.new(
                            (v41 - v23).Magnitude,
                            Thickness * v36 * v27,
                            Thickness * v36 * v27
                        )
                        v25.CFrame = CFrame.lookAt(0.5 * (v23 + v41), v41) * v3
                        v25.Transparency = 1 - v27
                    elseif v27 > v22 - 1 / (v18 * FadeLength) then
                        local v44 = (1 - (v27 - (v22 - 1 / (v18 * FadeLength))) * v18 * FadeLength) * (if not (v26 < v21 * PulseSpeed - 0.5 * PulseLength) then -1 else 1)
                        v25.Size = Vector3.new(
                            (1 - math.abs(v44)) * (v41 - v23).Magnitude,
                            Thickness * v36 * v27,
                            Thickness * v36 * v27
                        )
                        v25.CFrame = CFrame.lookAt(
                            v23 + (v41 - v23) * (math.max(0, v44) + (1 - math.abs(v44)) * 0.5),
                            v41
                        ) * v3
                        v25.Transparency = 1 - v27
                    else
                        v25.Transparency = 1
                    end

                    if typeof(Color) == "Color3" then
                        v25.Color = Color
                    else
                        local v47 = (RanNum + v26 - v21 * ColorOffsetSpeed) % 1
                        local Keypoints = Color.Keypoints

                        for index_3 = 1, #Keypoints - 1 do
                            if v47 > Keypoints[index_3].Time and v47 < Keypoints[index_3 + 1].Time then
                                v25.Color = Keypoints[index_3].Value:lerp(
                                    Keypoints[index_3 + 1].Value,
                                    (v47 - Keypoints[index_3].Time) / (Keypoints[index_3 + 1].Time - Keypoints[index_3].Time)
                                )
                                break
                            end
                        end
                    end

                    v23 = v41
                    v24 = v28
                end
            else
                val:Destroy()
            end
        elseif val.PartsHidden == false then
            val.PartsHidden = true
            local DisabledTransparency = val.DisabledTransparency

            for index_4 = 1, #val.Parts do
                local _ = #val.Parts
                val.Parts[index_4].Transparency = DisabledTransparency
            end
        end
    end
end)

return t_1
