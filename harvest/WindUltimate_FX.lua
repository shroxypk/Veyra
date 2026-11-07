-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Ultimates.WindUltimate_FX
-- Class: ModuleScript
-- bytes: 12484

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local CameraShaker_m = require(Modules.CameraShaker)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local Arrow = ReplicatedStorage.Effects.VFX.Arrow
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 20
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
local rng = Random.new()
local t = {
    Charge = {
        GroundAura = Arrow["1_Charge"].GroundAura,
        GroundRunes = Arrow["1_Charge"].GroundRunes,
        HandArrow = Arrow["1_Charge"].HandArrow,
        FieldBurst = Arrow["1_Charge"].FieldBurst,
        FieldStreak = Arrow["1_Charge"].FieldStreak
    },
    Release = {
        Burst = Arrow["2_Release"].Burst,
        BurstMeshes = Arrow["2_Release"].BurstMeshes,
        ClawStrand = Arrow["2_Release"].ClawStrand
    },
    Impact = {
        ConvergeBurst = Arrow["3_Impact"].ConvergeBurst,
        SkyCircle = Arrow["3_Impact"].SkyCircle,
        RainPlane = Arrow["3_Impact"].RainPlane,
        GroundBurst = Arrow["3_Impact"].GroundBurst,
        GroundRunes = Arrow["3_Impact"].GroundRunes
    }
}
local t_4 = { HandLimbName = "Right Arm", HandOffset = CFrame.new(0, -0.8, 0) }
local t_5 = {
    FootOffset = -3,
    GroundAuraLinger = 2,
    GroundRunesLinger = 1.5,
    HandArrowLinger = 1.5,
    Field = {
        Interval = 0.1,
        PerTick = 1,
        Limit = 0,
        Volume = Vector3.new(20, 12, 20),
        Offset = Vector3.new(0, 15, 0),
        MinDistance = 10,
        RandomYaw = true,
        StopAfter = 0
    },
    StreaksEnabled = true,
    StreakSpeed = 1
}
local t_6 = {
    BurstOffset = CFrame.new(0, 0, 0),
    BurstEmitPart = "Emit",
    MeshesOffset = CFrame.new(0, 0, 0),
    Origin = Vector3.new(0, 0, 0),
    Convergence = Vector3.new(0, 35, 0),
    Claw = {
        Count = 5,
        RingRadius = 14,
        RingDistance = 0.4,
        RingPhase = 0,
        Tilt = -30,
        StrandsPerProng = 1,
        Stagger = 0.02,
        Speed = 0.6
    }
}

local _ = function(u1: userdata) --[[ getAnchorRoot ]] -- line: 144
    return (u1:FindFirstChild("HumanoidRootPart"))
end

local function randomPointInField(u2: CFrame) -- line: 148
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] rng (copy)

    local Field = t_5.Field
    local v3 = Field.Volume / 2

    for _ = 1, 8 do
        local v5 = rng:NextNumber(-v3.X, v3.X)
        local v7 = rng:NextNumber(-v3.Y, v3.Y)
        local vec3 = Vector3.new(v5, v7, rng:NextNumber(-v3.Z, v3.Z))

        if Vector3.new(vec3.X, 0, vec3.Z).Magnitude >= Field.MinDistance then
            return (u2 * CFrame.new(vec3)).Position
        end
    end

    local v9 = rng:NextNumber() * 3.141592653589793 * 2
    local v11 = math.cos(v9) * Field.MinDistance
    local v13 = rng:NextNumber(-v3.Y, v3.Y)
    local v14 = math.sin(v9)
    local vec3_1 = Vector3.new(v11, v13, v14 * Field.MinDistance)

    return (u2 * CFrame.new(vec3_1)).Position
end

local function applyVariantColors(u3: userdata, arg2: any) -- line: 177
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if not arg2 then
        return
    end

    if arg2.Primary == Color3.fromRGB(169, 209, 162) then
        GrimoireRarity_m:ApplyVariantEffect(u3, { Primary = Color3.fromRGB(104, 109, 106) })

        return
    end

    GrimoireRarity_m:ApplyVariantEffect(u3, arg2)
end

local _ = function(t1: table, arg3: any) --[[ processColors ]] -- line: 189
    -- upvalues:
    --  [1] applyVariantColors (copy)

    for _, val in t1 do
        applyVariantColors(val, arg3)
    end

    table.clear(t1)
end

local function beginCharge(u4: userdata) -- line: 197
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] VFX_m (copy)
    --  [3] t (copy)
    --  [4] t_4 (copy)
    --  [5] GrimoireRarity_m (copy)
    --  [6] applyVariantColors (copy)
    --  [7] randomPointInField (copy)
    --  [8] rng (copy)

    local HumanoidRootPart = u4:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then
        return function() -- line: 200
        end
    end

    local New = CFrame.new(0, t_5.FootOffset, 0)
    local v20 = HumanoidRootPart.CFrame * New
    local v21 = VFX_m.sustainAttached(t.Charge.GroundAura, HumanoidRootPart, New)
    local v24 = VFX_m.sustainAttached(t.Charge.GroundRunes, HumanoidRootPart, New)
    local v29 = u4:FindFirstChild(t_4.HandLimbName)
    local v30 = VFX_m.sustainAttached(t.Charge.HandArrow, v29, t_4.HandOffset)
    local v32 = GrimoireRarity_m:GetPlayerVariant(u4)
    local t_8 = {}
    table.insert(t_8, v21.Instance)
    table.insert(t_8, v24.Instance)
    table.insert(t_8, v30.Instance)

    for _, val_1 in t_8 do
        applyVariantColors(val_1, v32)
    end

    table.clear(t_8)
    local v34 = v20 * CFrame.new(t_5.Field.Offset)
    local v35 = false
    local _ = applyVariantColors

    if t_5.Field.StopAfter > 0 then
        task.delay(t_5.Field.StopAfter, function() -- line: 232
            -- upvalues:
            --  [1] v35 (ref)

            v35 = false
        end)
    end

    task.spawn(function() -- line: 237
        -- upvalues:
        --  [1] v35 (ref)
        --  [2] t_5 (ref)
        --  [3] randomPointInField (ref)
        --  [4] v34 (copy)
        --  [5] rng (ref)
        --  [6] VFX_m (ref)
        --  [7] t (ref)
        --  [8] applyVariantColors (ref)
        --  [9] v32 (copy)
        --  [10] v30 (copy)
        --  [11] HumanoidRootPart (copy)

        local v37 = 0

        while true do
            if not v35 then
                break
            end

            for _ = 1, t_5.Field.PerTick do
                if t_5.Field.Limit > 0 and v37 >= t_5.Field.Limit then
                    return
                end

                v37 += 1
                local _ = t_5.Field.PerTick
                local v38 = randomPointInField(v34)
                local v39 = if t_5.Field.RandomYaw then rng:NextNumber() * 3.141592653589793 * 2 else 0
                applyVariantColors(
                    VFX_m.burst(t.Charge.FieldBurst, CFrame.new(v38) * CFrame.Angles(0, v39, 0)),
                    v32
                )

                if t_5.StreaksEnabled then
                    local v40 = if not v30 then HumanoidRootPart.Position else v30.Instance.Position

                    if (v38 - v40).Magnitude > 0.001 then
                        applyVariantColors(
                            VFX_m.burstBezier(t.Charge.FieldStreak, CFrame.lookAt(v38, v40), v40),
                            v32
                        )
                    end
                end
            end

            task.wait(t_5.Field.Interval)
        end
    end)

    return function() -- line: 271
        -- upvalues:
        --  [1] v35 (ref)
        --  [2] v21 (copy)
        --  [3] t_5 (ref)
        --  [4] v24 (copy)
        --  [5] v30 (copy)

        v35 = false
        v21.Stop(t_5.GroundAuraLinger)
        v24.Stop(t_5.GroundRunesLinger)

        if v30 then
            v30.Stop(t_5.HandArrowLinger)
        end
    end
end

local function fireImpact(
    vec1: Vector3,
    u5: CFrame,
    arg4: any,
    _: userdata,
    vec2: Vector3
) -- line: 283
    -- upvalues:
    --  [1] VFX_m (copy)
    --  [2] t (copy)
    --  [3] applyVariantColors (copy)

    local t_9 = {}
    print("Client Impact Wind")
    table.insert(t_9, VFX_m.burst(t.Impact.ConvergeBurst, u5))
    table.insert(t_9, VFX_m.burst(t.Impact.SkyCircle, CFrame.new(vec1)))
    table.insert(t_9, VFX_m.burst(t.Impact.RainPlane, CFrame.new(vec1 + Vector3.new(0, 0, 0))))

    for _, val_2 in t_9 do
        applyVariantColors(val_2, arg4)
    end

    table.clear(t_9)
    table.insert(
        t_9,
        VFX_m.burst(t.Impact.GroundBurst, CFrame.new(vec2 + Vector3.new(0, 1.529, 0)))
    )
    table.insert(
        t_9,
        VFX_m.burst(t.Impact.GroundRunes, CFrame.new(vec2 + Vector3.new(0, -0.031, 0)))
    )

    for _, val_3 in t_9 do
        applyVariantColors(val_3, arg4)
    end

    table.clear(t_9)
end

local function fireRelease(u7: userdata, u8: CFrame, n1: number, n2: number) -- line: 309
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] VFX_m (copy)
    --  [3] t (copy)
    --  [4] t_6 (copy)
    --  [5] applyVariantColors (copy)
    --  [6] Players (copy)
    --  [7] fireImpact (copy)

    local HumanoidRootPart_1 = u7:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart_1 then
        return
    end

    local v41 = GrimoireRarity_m:GetPlayerVariant(u7)
    local t_10 = {}
    local v42 = HumanoidRootPart_1.CFrame
    table.insert(t_10, VFX_m.burstChild(t.Release.Burst, v42 * t_6.BurstOffset, t_6.BurstEmitPart))
    table.insert(t_10, VFX_m.burst(t.Release.BurstMeshes, v42 * t_6.MeshesOffset))

    for _, val_4 in t_10 do
        applyVariantColors(val_4, v41)
    end

    table.clear(t_10)
    local v43 = v42:PointToWorldSpace(t_6.Origin)
    local v44 = u8:PointToWorldSpace(t_6.Convergence)
    local v45 = v44 - v43
    local v46 = if v45.Magnitude > 0.0001 then v45.Unit else v42.LookVector
    local v47 = v42.UpVector - v46 * v42.UpVector:Dot(v46)

    if v47.Magnitude > 0.0001 then
        v47 = v47.Unit
    else
        v47 = v42.LookVector
    end

    local Unit = v46:Cross(v47).Unit
    local Claw = t_6.Claw
    local v49 = v43 + v45 * Claw.RingDistance

    for index_2 = 1, Claw.Count do
        local _ = Claw.Count
        v45 = math.rad(Claw.RingPhase) + (index_2 - 1) / Claw.Count * 3.141592653589793 * 2
        local v52 = v47 * math.cos(v45) + Unit * math.sin(v45)
        local v53 = v49 + v52 * Claw.RingRadius
        local v54 = CFrame.lookAt(v43, v44, v52) * CFrame.Angles(0, 0, (math.rad(Claw.Tilt)))

        local function release() -- line: 357
            -- upvalues:
            --  [1] t (ref)
            --  [2] applyVariantColors (ref)
            --  [3] v41 (copy)
            --  [4] Claw (copy)
            --  [5] t_10 (copy)
            --  [6] VFX_m (ref)
            --  [7] v54 (copy)
            --  [8] v44 (copy)
            --  [9] v53 (copy)

            local v55 = t.Release.ClawStrand:Clone()
            applyVariantColors(v55, v41)

            for _ = 1, Claw.StrandsPerProng do
                local _ = Claw.StrandsPerProng
                table.insert(t_10, VFX_m.burstBezier(v55, v54, v44, v53))
            end

            v55:Destroy()
        end

        if Claw.Stagger > 0 and index_2 > 1 then
            task.delay((index_2 - 1) * Claw.Stagger, release)
        else
            release()
        end
    end

    v47 = Players.LocalPlayer.Character

    if v47 and v47 ~= u7 then
        table.insert({ u7 }, v47)
    end

    local cframe_2 = CFrame.lookAt(v44, v43)
    task.delay(n1, function() -- line: 383
        -- upvalues:
        --  [1] n1 (copy)
        --  [2] fireImpact (ref)
        --  [3] v44 (copy)
        --  [4] cframe_2 (copy)
        --  [5] v41 (copy)
        --  [6] u7 (copy)
        --  [7] n2 (copy)

        print(n1, " Client")
        fireImpact(
            v44,
            cframe_2,
            v41,
            u7,
            n2
        )
    end)
end

local _ = {
    Delay = 0,
    RainPlaneOffset = Vector3.new(0, 0, 0),
    GroundProbeDistance = 300,
    GroundBurstHeight = 1.529,
    GroundRunesHeight = -0.031
}
v2:Start()
VFX_m.init()
VFX_m.retime(t.Release.ClawStrand, t_6.Claw.Speed)
VFX_m.retime(t.Charge.FieldStreak, t_5.StreakSpeed)
VFX_m.preload({ Arrow })
local t_13 = {}

local function main(
    s1: string,
    u9: userdata,
    vec4: Vector3,
    n3: number,
    n4: number
) -- line: 399
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] t_13 (copy)
    --  [3] beginCharge (copy)
    --  [4] fireRelease (copy)

    if not u9 or not u9.PrimaryPart then
        return
    end

    if (CurrentCamera.CFrame.Position - u9.PrimaryPart.Position).Magnitude > 500 then
        return
    end

    if s1 == "Start" then
        t_13[u9] = beginCharge(u9)

        return
    end

    if s1 == "Shoot" then
        fireRelease(u9, CFrame.new(vec4), n3, n4)

        return
    end

    if s1 == "Cleanup" then
        t_13[u9]()

        return
    end
end

return main
