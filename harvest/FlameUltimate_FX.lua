-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Ultimates.FlameUltimate_FX
-- Class: ModuleScript
-- bytes: 12660

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local CameraShaker_m = require(Modules.CameraShaker)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local ScreenFlash_m = require(Modules.Shared.ScreenFlash)
local Flame = ReplicatedStorage.Effects.VFX.Flame
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 21
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
VFX_m.init()
local t = {
    Start = {
        Ball = Flame["1_Start"].Ball,
        StarStart = Flame["1_Start"].StarStart,
        Leap = Flame["1_Start"].Leap
    },
    Charge = { Burst = Flame["2_Charge"].Charge },
    Throw = { ExplosionBall = Flame["3_Throw"].ExplosionBall, Explode = Flame["3_Throw"].Explode }
}
local t_4 = { LimbName = "Right Arm", KeepAuthoredOffset = true, Offset = CFrame.new(0, -1, 0) }
local t_5 = { Offset = CFrame.new(0, 0, 0), MinLifetime = 2 }
local t_6 = {
    ExplodeDelay = 1,
    MeshName = "Explosion",
    MeshFadeTime = 0.08,
    Flash = {
        Enabled = true,
        Delay = 0,
        Color = Color3.new(1, 1, 1),
        StartTransparency = 0.15,
        HoldTime = 0.03,
        FadeTime = 0.4
    }
}

local _ = function(u1: userdata) --[[ getAnchorRoot ]] -- line: 90
    return (u1:FindFirstChild("HumanoidRootPart"))
end

local t_8 = {}

local function fireStart(u2: userdata, n1: number) -- line: 96
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] t (copy)
    --  [4] t_8 (copy)
    --  [5] ForgeVFX_m (copy)
    --  [6] VFX_m (copy)

    local v3 = u2:FindFirstChild(t_4.LimbName)

    if not v3 then
        return
    end

    local v4 = if t_4.KeepAuthoredOffset then nil else t_4.Offset
    local v5 = GrimoireRarity_m:GetPlayerVariant(u2)
    local t_9 = {}
    table.insert(t_9, t.Start.Ball:Clone())
    table.insert(t_9, t.Start.StarStart:Clone())
    GrimoireRarity_m:ApplyVariantEffect(t_9, v5)
    local v6 = t.Start.Ball:Clone()
    GrimoireRarity_m:ApplyVariantEffect(v6, v5)
    v6.Parent = v3

    if v4 then
        v6.CFrame = v4
    end

    t_8[n1 .. "_FireBall"] = v6
    ForgeVFX_m.enable(v6)
    VFX_m.burstOnto(t_9[2], v3, v4)

    for _, val in t_9 do
        val:Destroy()
    end
end

local function fireCharge(u3: userdata) -- line: 134
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] t (copy)
    --  [3] VFX_m (copy)
    --  [4] t_5 (copy)
    --  [5] ForgeVFX_m (copy)

    local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then
        return
    end

    local v7 = GrimoireRarity_m:GetPlayerVariant(u3)
    local t_10 = {}
    table.insert(t_10, t.Charge.Burst:Clone())
    table.insert(t_10, t.Start.Leap:Clone())
    GrimoireRarity_m:ApplyVariantEffect(t_10, v7)
    local v8 = t.Start.Leap:Clone()
    GrimoireRarity_m:ApplyVariantEffect(v8, v7)
    v8.Parent = workspace.Effects
    v8.CFrame = u3.PrimaryPart.CFrame * CFrame.new(0, -2.5, 0)
    VFX_m.burstAttached(t_10[1], HumanoidRootPart, t_5.Offset, t_5.MinLifetime)
    ForgeVFX_m.emit(v8)

    for _, val_1 in t_10 do
        val_1:Destroy()
    end
end

local function fireThrow(u4: userdata, u5: userdata, n2: number) -- line: 164
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] ScreenFlash_m (copy)
    --  [3] GrimoireRarity_m (copy)
    --  [4] t (copy)
    --  [5] t_8 (copy)
    --  [6] Services_m (copy)
    --  [7] RunService (copy)
    --  [8] VFX_m (copy)
    --  [9] TweenService (copy)

    if not u4:FindFirstChild("HumanoidRootPart") then
        return
    end

    local Flash = t_6.Flash

    if Flash.Enabled then
        local function play() -- line: 172
            -- upvalues:
            --  [1] ScreenFlash_m (ref)
            --  [2] Flash (copy)

            ScreenFlash_m.Play(
                {
                    Color = Flash.Color,
                    StartTransparency = Flash.StartTransparency,
                    HoldTime = Flash.HoldTime,
                    FadeTime = Flash.FadeTime
                }
            )
        end

        if Flash.Delay > 0 then
            task.delay(Flash.Delay, play)
        else
            ScreenFlash_m.Play(
                {
                    Color = Flash.Color,
                    StartTransparency = Flash.StartTransparency,
                    HoldTime = Flash.HoldTime,
                    FadeTime = Flash.FadeTime
                }
            )
        end
    end

    local v13 = GrimoireRarity_m:GetPlayerVariant(u4)
    local t_13 = {}
    table.insert(t_13, t.Throw.ExplosionBall:Clone())
    table.insert(t_13, t.Throw.Explode:Clone())
    GrimoireRarity_m:ApplyVariantEffect(t_13, v13)
    local v20 = t_8[n2 .. "_FireBall"]
    local os_clock = os.clock()
    local v21 = Services_m.Maid.new()
    local New = OverlapParams.new()
    New.FilterType = Enum.RaycastFilterType.Exclude
    New.FilterDescendantsInstances = { u4, workspace.Effects }

    for _, val_2 in v20:QueryDescendants("Trail") do
        val_2.Enabled = true
    end

    local Part = Instance.new("Part")
    Part.Size = Vector3.new(4, 4, 4)
    local LookAt = CFrame.lookAt(v20.WorldPosition, u5)
    Part.CFrame = LookAt
    local FromRGB = Color3.fromRGB(0, 13, 255)
    Part.Color = FromRGB
    Part.Transparency = 1
    Part.CanCollide = false
    Part.Anchored = true
    Part.Parent = workspace.Effects
    v20.Parent = Part
    v20.CFrame = CFrame.new(0, 0, 0)
    local v34 = true
    local v35 = Part.CFrame
    v21:GiveTask(RunService.Heartbeat:Connect(function(deltaTime) -- line: 230
        -- upvalues:
        --  [1] v35 (ref)
        --  [2] Part (copy)
        --  [3] New (copy)
        --  [4] v34 (ref)
        --  [5] os_clock (copy)
        --  [6] VFX_m (ref)
        --  [7] t_13 (copy)
        --  [8] t_6 (ref)
        --  [9] TweenService (ref)

        v35 = CFrame.new(v35.Position + v35.LookVector * 250 * deltaTime) * (v35 - v35.Position)
        Part.CFrame = v35
        local v37, v38

        if #workspace:GetPartBoundsInBox(Part.CFrame, Vector3.new(4, 4, 4), New) > 0 then
            if not v34 then
                if os.clock() - os_clock > 0.8 and v34 then
                    v34 = false
                    local Position = Part.Position
                    v37 = t_13[1]
                    v38 = VFX_m.burst(v37, CFrame.new(Position), nil, t_6.ExplodeDelay)
                    v37 = v38

                    if v37 then
                        v37 = v38:FindFirstChild(t_6.MeshName, true)
                    end

                    if v37 and v37:IsA("BasePart") then
                        task.delay(math.max(t_6.ExplodeDelay - t_6.MeshFadeTime, 0), function() -- line: 248
                            -- upvalues:
                            --  [1] v37 (copy)
                            --  [2] t_6 (ref)
                            --  [3] TweenService (ref)

                            if not v37.Parent then
                                return
                            end

                            TweenService:Create(
                                v37,
                                TweenInfo.new(t_6.MeshFadeTime, Enum.EasingStyle.Linear),
                                { Transparency = 1 }
                            ):Play()
                        end)
                    end

                    task.delay(t_6.ExplodeDelay, function() -- line: 258
                        -- upvalues:
                        --  [1] VFX_m (ref)
                        --  [2] t_13 (ref)
                        --  [3] Position (copy)

                        VFX_m.burst(t_13[2], CFrame.new(Position))

                        for _, val_3 in t_13 do
                            val_3:Destroy()
                        end
                    end)
                end
            else
                v34 = false
                local Position_1 = Part.Position
                v37 = t_13[1]
                v38 = VFX_m.burst(v37, CFrame.new(Position_1), nil, t_6.ExplodeDelay)
                v37 = v38

                if v37 then
                    v37 = v38:FindFirstChild(t_6.MeshName, true)
                end

                if v37 and v37:IsA("BasePart") then
                    task.delay(math.max(t_6.ExplodeDelay - t_6.MeshFadeTime, 0), function() -- line: 248
                        -- upvalues:
                        --  [1] v37 (copy)
                        --  [2] t_6 (ref)
                        --  [3] TweenService (ref)

                        if not v37.Parent then
                            return
                        end

                        TweenService:Create(
                            v37,
                            TweenInfo.new(t_6.MeshFadeTime, Enum.EasingStyle.Linear),
                            { Transparency = 1 }
                        ):Play()
                    end)
                end

                task.delay(t_6.ExplodeDelay, function() -- line: 258
                    -- upvalues:
                    --  [1] VFX_m (ref)
                    --  [2] t_13 (ref)
                    --  [3] Position_1 (copy)

                    VFX_m.burst(t_13[2], CFrame.new(Position_1))

                    for _, val_4 in t_13 do
                        val_4:Destroy()
                    end
                end)
            end
        elseif os.clock() - os_clock > 0.8 and v34 then
            v34 = false
            local Position_2 = Part.Position
            v37 = t_13[1]
            v38 = VFX_m.burst(v37, CFrame.new(Position_2), nil, t_6.ExplodeDelay)
            v37 = v38

            if v37 then
                v37 = v38:FindFirstChild(t_6.MeshName, true)
            end

            if v37 and v37:IsA("BasePart") then
                task.delay(math.max(t_6.ExplodeDelay - t_6.MeshFadeTime, 0), function() -- line: 248
                    -- upvalues:
                    --  [1] v37 (copy)
                    --  [2] t_6 (ref)
                    --  [3] TweenService (ref)

                    if not v37.Parent then
                        return
                    end

                    TweenService:Create(
                        v37,
                        TweenInfo.new(t_6.MeshFadeTime, Enum.EasingStyle.Linear),
                        { Transparency = 1 }
                    ):Play()
                end)
            end

            task.delay(t_6.ExplodeDelay, function() -- line: 258
                -- upvalues:
                --  [1] VFX_m (ref)
                --  [2] t_13 (ref)
                --  [3] Position_2 (copy)

                VFX_m.burst(t_13[2], CFrame.new(Position_2))

                for _, val_5 in t_13 do
                    val_5:Destroy()
                end
            end)
        end
    end))
end

local function fireCleanup(n3: number) -- line: 272
    -- upvalues:
    --  [1] t_8 (copy)

    for key_6 in t_8 do
        if string.split(key_6, "_")[1] == tostring(n3) then
            local v43 = t_8[key_6]
            t_8[key_6] = nil
            task.delay(2, function() -- line: 278
                -- upvalues:
                --  [1] v43 (copy)

                if v43 then
                    v43:Destroy()
                end
            end)
        end
    end
end

v2:Start()
VFX_m.init()
VFX_m.preload({ Flame })

local function main(arg3) -- line: 292
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] fireStart (copy)
    --  [3] fireCharge (copy)
    --  [4] fireThrow (copy)
    --  [5] fireCleanup (copy)

    local Character = arg3.Character
    local Action = arg3.Action

    if not Character or not Character.PrimaryPart then
        return
    end

    if (CurrentCamera.CFrame.Position - Character.PrimaryPart.Position).Magnitude > 500 then
        return
    end

    if Action == "Start" then
        local _ = arg3.EndPosition
        fireStart(Character, arg3.CastId)

        return
    end

    if Action == "Charge" then
        local _ = arg3.EndPosition
        fireCharge(Character)

        return
    end

    if Action == "Throw" then
        fireThrow(Character, arg3.EndPosition, arg3.CastId)

        return
    end

    if Action == "Cleanup" then
        fireCleanup(arg3.CastId)

        return
    end
end

return main
