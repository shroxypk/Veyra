-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.InnerRealmRestoreFX
-- Class: LocalScript
-- bytes: 6434

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local InnerRealm = ReplicatedStorage.Remotes:WaitForChild("InnerRealm")
local Effect = script:WaitForChild("effect")

local function fadeModel(arg1, arg2, arg3, arg4) -- line: 22
    -- upvalues:
    --  [1] TweenService (copy)

    local t = {}

    for _, val in arg1:QueryDescendants("BasePart, Decal") do
        table.insert(t, val)
        val.LocalTransparencyModifier = arg2
    end

    local NumberValue = Instance.new("NumberValue")
    NumberValue.Value = arg2
    NumberValue.Changed:Connect(function(arg5) -- line: 31
        -- upvalues:
        --  [1] t (copy)

        for _, val_1 in t do
            val_1.LocalTransparencyModifier = arg5
        end
    end)
    local v3 = TweenService:Create(
        NumberValue,
        TweenInfo.new(arg4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        { Value = arg3 }
    )
    v3.Completed:Once(function() -- line: 38
        -- upvalues:
        --  [1] NumberValue (copy)

        NumberValue:Destroy()
    end)
    v3:Play()
end

local function crossfade(arg6) -- line: 46
    -- upvalues:
    --  [1] fadeModel (copy)

    local Broken = arg6:FindFirstChild("Broken")

    if Broken then
        fadeModel(Broken, 0, 1, 1)
        task.delay(3, function() -- line: 52
            -- upvalues:
            --  [1] fadeModel (ref)
            --  [2] Broken (copy)

            fadeModel(Broken, 0, 0, 0)
        end)
    end

    local v4 = nil

    local function onRestored(arg7) -- line: 58
        -- upvalues:
        --  [1] v4 (ref)
        --  [2] fadeModel (ref)

        if arg7.Name ~= "Restored" then
            return
        end

        v4:Disconnect()
        fadeModel(arg7, 1, 1, 0)
        task.wait()
        fadeModel(arg7, 1, 0, 1)
    end

    v4 = arg6.ChildAdded:Connect(onRestored)
    task.delay(10, function() -- line: 69
        -- upvalues:
        --  [1] v4 (ref)

        if v4.Connected then
            v4:Disconnect()
        end
    end)
end

local function scaleNumberSequence(arg8, arg9) -- line: 76
    local t_2 = {}

    for _, val_2 in arg8.Keypoints do
        table.insert(
            t_2,
            NumberSequenceKeypoint.new(val_2.Time, val_2.Value * arg9, val_2.Envelope * arg9)
        )
    end

    return NumberSequence.new(t_2)
end

local _ = function(u1: CFrame, vec1: Vector3) --[[ playRestoreFX ]] -- line: 84
    -- upvalues:
    --  [1] Effect (copy)
    --  [2] scaleNumberSequence (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] TweenService (copy)
    --  [5] Services_m (copy)

    local _, v6 = u1:ToEulerAnglesYXZ()
    local X = vec1.X
    local Z = vec1.Z
    local v7 = math.max(X, Z)
    local v8 = math.clamp(math.sqrt(X * Z) / 15, 0.6, 3)
    local v9 = u1.Position - Vector3.new(0, vec1.Y / 2, 0)
    local v10 = Effect:Clone()
    v10.Size = Vector3.new(X, 1, Z)
    local cframe = CFrame.new(v9)
    v10.CFrame = cframe * CFrame.Angles(0, v6, 0)
    local _ = CFrame.Angles(0, v6, 0)

    for _, descendant in v10:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Size = scaleNumberSequence(descendant.Size, v8)
            descendant.Rate *= v8
            descendant.Speed = NumberRange.new(
                descendant.Speed.Min * 1.6,
                descendant.Speed.Max * 1.6
            )
            descendant.Lifetime = NumberRange.new(
                descendant.Lifetime.Min / 1.6,
                descendant.Lifetime.Max / 1.6
            )
            descendant.Acceleration *= 2.5600000000000005
            descendant.RotSpeed = NumberRange.new(
                descendant.RotSpeed.Min * 1.6,
                descendant.RotSpeed.Max * 1.6
            )
        elseif descendant:IsA("Attachment") and descendant.Name == "beam" then
            local v11 = math.sign(descendant.Position.Z)

            if X <= Z then
                descendant.Position = Vector3.new(0, 0, v11 * Z * 0.7333333333333333)
            else
                descendant.Position = Vector3.new(v11 * X * 0.7333333333333333, 0, 0)
            end
        end
    end

    v10.Parent = workspace:FindFirstChild("Effects") or workspace
    _G.ToggleParticles(v10, true)
    local v16 = math.clamp(v7, 15, 60)

    for _, val_3 in v10:GetDescendants() do
        if val_3:IsA("Light") then
            _G.Tween(
                val_3,
                { 1.5, "Quad", Enum.EasingDirection.Out },
                { Brightness = 1.5, Range = v16 }
            )
        end
    end

    local Upgrade = ReplicatedStorage.SFX.Misc:FindFirstChild("Upgrade")

    if Upgrade and _G.PlaySound then
        _G.PlaySound(Upgrade, v10)
    end

    local v18 = true
    local v19 = v10.CFrame
    task.spawn(function() -- line: 137
        -- upvalues:
        --  [1] v18 (ref)
        --  [2] v10 (copy)
        --  [3] TweenService (ref)
        --  [4] v19 (copy)

        local v20 = 0

        while true do
            if not v18 then
                break
            end

            if not v10.Parent then
                break
            end

            v20 += 1
            local v21 = TweenService
            local v22 = v10
            local tweenInfo_1 = TweenInfo.new(3, Enum.EasingStyle.Linear)
            local v24 = v21:Create(
                v22,
                tweenInfo_1,
                { CFrame = v19 * CFrame.Angles(0, math.rad(v20 * 120), 0) }
            )
            v24:Play()
            v24.Completed:Wait()
        end
    end)
    task.wait(4.2)

    for _, descendant_1 in v10:GetDescendants() do
        if descendant_1:IsA("Light") then
            _G.Tween(
                descendant_1,
                { 1.5, "Quad", Enum.EasingDirection.Out },
                { Brightness = 0, Range = 0 }
            )
        end
    end

    _G.ToggleParticles(v10)
    Services_m.Debris(v10, 8)
    task.delay(8, function() -- line: 159
        -- upvalues:
        --  [1] v18 (ref)

        v18 = false
    end)
end

InnerRealm.OnClientEvent:Connect(function(arg10, arg11, arg12, arg13) -- line: 164
    -- upvalues:
    --  [1] crossfade (copy)

    if arg10 == "RestoreFX" and typeof(arg11) == "CFrame" and typeof(arg12) == "Vector3" and typeof(
        arg13
    ) == "Instance" then
        crossfade(arg13)
    end
end)
