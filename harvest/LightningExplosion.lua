-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.LightningBolt.LightningExplosion
-- Class: ModuleScript
-- bytes: 4330

local Parent_m = require(script.Parent)
local LightningSparks_m = require(script.Parent.LightningSparks)
local rng = Random.new()
local os_clock = os.clock

function RandomVectorOffsetBetween(arg1, arg2, arg3) -- line: 9
    -- upvalues:
    --  [1] rng (copy)

    local v2 = CFrame.lookAt(Vector3.new(), arg1) * CFrame.Angles(
        0,
        0,
        rng:NextNumber(0, 6.283185307179586)
    )
    local Angles_1 = CFrame.Angles
    local v6 = rng:NextNumber(math.cos(arg3), (math.cos(arg2)))

    return (v2 * Angles_1(math.acos(v6), 0, 0)).LookVector
end

local t = {}
local t_1 = {}
t_1.__index = t_1

function t_1.new(
    arg4,
    arg5,
    arg6,
    arg7,
    arg8,
    arg9
) -- line: 20
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] rng (copy)
    --  [3] Parent_m (copy)
    --  [4] LightningSparks_m (copy)
    --  [5] os_clock (copy)
    --  [6] t (copy)

    local t_2 = setmetatable({}, t_1)
    t_2.Size = arg5 or 1
    t_2.NumBolts = arg6 or 12
    t_2.Color = arg7 or ColorSequence.new(Color3.new(1, 0, 0), Color3.new(0, 0, 1))
    t_2.BoltColor = arg8 or Color3.new(0.3, 0.3, 1)
    t_2.UpVector = arg9 or Vector3.new(0, 1, 0)
    local Effects = workspace.Effects
    local LightningExplosion_Part = Instance.new("Part")
    LightningExplosion_Part.Name = "LightningExplosion"
    LightningExplosion_Part.Anchored = true
    LightningExplosion_Part.CanCollide = false
    LightningExplosion_Part.Locked = true
    LightningExplosion_Part.CastShadow = false
    LightningExplosion_Part.Massless = true
    LightningExplosion_Part.Transparency = 1
    LightningExplosion_Part.Size = Vector3.new(0.05, 0.05, 0.05)
    LightningExplosion_Part.CFrame = CFrame.lookAt(
        arg4 + Vector3.new(0, 0.5, 0),
        arg4 + Vector3.new(0, 0.5, 0) + t_2.UpVector
    ) * CFrame.lookAt(Vector3.new(), Vector3.new(0, 1, 0)):inverse()
    LightningExplosion_Part.Parent = Effects
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = LightningExplosion_Part
    Attachment.CFrame = CFrame.new()
    local v8 = math.clamp(t_2.Size, 0, 3)
    local t_3 = {}

    for _ = 1, t_2.NumBolts do
        local t_4 = {}
        local t_5 = {}
        local _ = t_2.NumBolts
        local WorldPosition = Attachment.WorldPosition
        local v9 = RandomVectorOffsetBetween(t_2.UpVector, 1.1344640137963142, 1.3962634015954636)
        t_4.WorldPosition = WorldPosition
        t_4.WorldAxis = v9
        local v10 = Attachment.WorldPosition + t_4.WorldAxis * rng:NextNumber(20, 40) * 1.4 * v8
        local v11 = RandomVectorOffsetBetween(-t_2.UpVector, 1.2217304763960306, 1.9198621771937625)
        t_5.WorldPosition = v10
        t_5.WorldAxis = v11
        local v12 = Parent_m.new(t_4, t_5, 8)
        v12.AnimationSpeed = 0
        v12.Thickness = v8 * 1
        v12.Color = t_2.BoltColor
        v12.PulseLength = 0.8
        v12.ColorOffsetSpeed = 20
        v12.Frequency = 2
        v12.MinRadius, v12.MaxRadius = 0, v8 * 4
        v12.FadeLength = 0.4
        v12.PulseSpeed = 5
        v12.MinThicknessMultiplier, v12.MaxThicknessMultiplier = 0.7, 1
        local v13 = LightningSparks_m.new(v12, 5)
        v13.MinDistance, v13.MaxDistance = 7.5, 10
        v12.Velocity = (t_5.WorldPosition - t_4.WorldPosition).Unit * 0.1 * v8
        t_3[#t_3 + 1] = v12
    end

    t_2.Bolts = t_3
    t_2.Attachment = Attachment
    t_2.Part = LightningExplosion_Part
    t_2.StartT = os_clock()
    t_2.RefIndex = #t + 1
    t[t_2.RefIndex] = t_2

    return t_2
end

function t_1.Destroy(arg10) -- line: 127
    -- upvalues:
    --  [1] t (copy)

    t[arg10.RefIndex] = nil
    arg10.Part:Destroy()

    for index_1 = 1, #arg10.Bolts do
        local _ = #arg10.Bolts
        arg10.Bolts[index_1] = nil
    end
end

game:GetService("RunService").Heartbeat:Connect(function() -- line: 138
    -- upvalues:
    --  [1] t (copy)
    --  [2] os_clock (copy)

    for _, val in pairs(t) do
        local v16 = os_clock() - val.StartT
        local _ = val.Attachment

        if v16 < 0.7 and not (v16 > 0.2) then
            for index_2 = 1, #val.Bolts do
                local v17 = val.Bolts[index_2]
                local _ = #val.Bolts
                v17.Attachment1.WorldPosition += v17.Velocity
            end
        else
            val:Destroy()
        end
    end
end)

return t_1
