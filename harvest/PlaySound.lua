-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.PlaySound
-- Class: ModuleScript
-- bytes: 1229

local function playSound(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5,
    arg6,
    _
) -- line: 2
    local Volume = arg1.Volume
    local RollOffMaxDistance = arg1.RollOffMaxDistance
    local PlaybackSpeed = arg1.PlaybackSpeed
    local v1 = typeof(arg2)
    local Part = nil
    local v3

    if v1 == "CFrame" or v1 == "Vector3" then
        v3 = if v1 ~= "CFrame" then CFrame.new(arg2) else arg2 or CFrame.new(arg2)
        Part = Instance.new("Part")
        Part.Transparency = 1
        Part.CanCollide = false
        Part.Anchored = true
        Part.CanQuery = false
        Part.CFrame = v3
        Part.Parent = workspace.Effects
    end

    local v4 = arg1:Clone()
    v4.Volume = arg4 or Volume
    v4.RollOffMaxDistance = arg3 or RollOffMaxDistance
    v4.PlaybackSpeed, v3 = arg5 or PlaybackSpeed, arg6
    local TimePosition

    if not v3 then
        TimePosition = v4.TimePosition
    end

    v4.TimePosition = TimePosition
    v4.Ended:Connect(function() -- line: 27
        -- upvalues:
        --  [1] v4 (copy)
        --  [2] Part (ref)

        v4:Destroy()

        if Part then
            Part:Destroy()
        end
    end)
    v4.Parent = Part or arg2
    v4:Play()
end

return playSound
