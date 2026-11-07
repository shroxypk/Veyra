-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Halloween.HeadlessThrall_Fx
-- Class: ModuleScript
-- bytes: 10814

local TweenService = game:GetService("TweenService")
local HalloweenFxUtil_m = require(script.Parent.HalloweenFxUtil)
local Assets = script.Assets
local Sounds = script:FindFirstChild("Sounds")
local t = { 0.25, 0.33 }
local t_1 = { "Sweep1", "Sweep2" }
local Assets_1 = script.Parent.Parent.Headless.Headless_ShadowDash_Fx.Assets
local Assets_2 = script.Parent.Parent.Headless.Headless_Cleave_Fx.Assets
local Assets_3 = script.Parent.Parent.Headless.Headless_ExecutionMark_Fx.Assets
local _ = { Delay = 0.3, Time = 1.5 }
local t_3 = {
    CFrame.Angles(0, 3.141592653589793, 0),
    CFrame.new(0, -0.6, 0) * CFrame.Angles(0, 0, -0.3490658503988659) * CFrame.Angles(
        0,
        3.141592653589793,
        3.141592653589793
    )
}
local _ = Color3.fromRGB(255, 235, 200)
local color_1 = Color3.fromRGB(255, 45, 35)
local color_2 = Color3.fromRGB(255, 120, 40)
local color_3 = Color3.fromRGB(255, 120, 40)
local color_4 = Color3.fromRGB(170, 215, 255)
local _ = { Size = 1.6, Rate = 2 }
local t_5 = setmetatable({}, { __mode = "k" })
local t_6 = setmetatable({}, { __mode = "k" })

local function scaleSequence(u1: userdata, n1: number) -- line: 54
    local t_7 = {}

    for _, val in u1.Keypoints do
        table.insert(t_7, NumberSequenceKeypoint.new(val.Time, val.Value * n1, val.Envelope * n1))
    end

    return NumberSequence.new(t_7)
end

local function chargeBlade(u2: userdata) -- line: 63
    -- upvalues:
    --  [1] Assets (copy)
    --  [2] HalloweenFxUtil_m (copy)

    local Blade = u2:FindFirstChild("Blade", true)
    local t_8

    if Blade then
        if not Blade:IsA("BasePart") then
            return {}
        end

        t_8 = {}
        local v2 = u2:GetScale()

        for _, child in Assets.FeintCharge:Clone():GetChildren() do
            if v2 ~= 1 then
                if child:IsA("Attachment") then
                    child.Position *= v2
                end

                HalloweenFxUtil_m.ScaleParticles(child, v2)
                local v3 = child:IsA("Beam") and { child } or child:GetDescendants()

                for _, val_1 in v3 do
                    if val_1:IsA("Beam") then
                        val_1.Width0 *= v2
                        val_1.Width1 *= v2
                    end
                end
            end

            child.Parent = Blade
            table.insert(t_8, child)
        end

        for _, val_2 in t_8 do
            HalloweenFxUtil_m.Enable(val_2)
        end

        return t_8
    else
        return {}
    end
end

local function chargedSlash(u3: CFrame, n2: number, n3: number) -- line: 94
    -- upvalues:
    --  [1] Assets (copy)
    --  [2] t_1 (copy)
    --  [3] HalloweenFxUtil_m (copy)
    --  [4] Assets_2 (copy)
    --  [5] t_3 (copy)
    --  [6] TweenService (copy)

    local v4 = Assets:FindFirstChild(t_1[n2] or "")

    if not v4 then
        return
    end

    HalloweenFxUtil_m.PlaceScaled(
        v4,
        u3 * HalloweenFxUtil_m.ScaleOffset(v4:GetAttribute("Offset"), n3),
        n3 * 1.55
    )

    for _, descendant in HalloweenFxUtil_m.PlaceScaled(
        Assets_2.Slash,
        u3 * HalloweenFxUtil_m.ScaleOffset(t_3[n2], n3),
        n3 * 0.3
    ):GetDescendants() do
        if descendant:IsA("Light") then
            descendant.Range *= n3 * 0.3
            TweenService:Create(
                descendant,
                TweenInfo.new(
                    1.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0.3
                ),
                { Brightness = 0 }
            ):Play()
        end
    end
end

local function endFeint(u4: userdata) -- line: 111
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] HalloweenFxUtil_m (copy)

    local v6 = t_6[u4]
    t_6[u4] = nil

    if not v6 then
        return
    end

    for _, val_5 in v6.Charge do
        HalloweenFxUtil_m.Remove(val_5)
    end

    for key_9, val_6 in v6.Neck do
        if key_9.Parent then
            key_9.Size = val_6.Size
            key_9.Rate = val_6.Rate
        end
    end
end

local _ = function(u5: userdata, n4: number?) --[[ playSwing ]] -- line: 129
    -- upvalues:
    --  [1] Sounds (copy)
    --  [2] HalloweenFxUtil_m (copy)
    --  [3] t (copy)

    local v7 = u5.PrimaryPart or u5:FindFirstChild("HumanoidRootPart")
    local v8 = Sounds

    if v8 then
        v8 = n4

        if v8 then
            v8 = Sounds:FindFirstChild(`Slash{n4}`)
        end
    end

    if v7 and v8 then
        HalloweenFxUtil_m.Sound(v8, v7, t[n4])
    end
end

return function(u6: userdata, s1: string, ...) -- line: 137
    -- upvalues:
    --  [1] endFeint (copy)
    --  [2] HalloweenFxUtil_m (copy)
    --  [3] scaleSequence (copy)
    --  [4] t_6 (copy)
    --  [5] chargeBlade (copy)
    --  [6] color_4 (copy)
    --  [7] chargedSlash (copy)
    --  [8] Sounds (copy)
    --  [9] t (copy)
    --  [10] Assets (copy)
    --  [11] t_1 (copy)
    --  [12] color_1 (copy)
    --  [13] Assets_3 (copy)
    --  [14] t_5 (copy)
    --  [15] color_2 (copy)
    --  [16] Assets_1 (copy)
    --  [17] color_3 (copy)

    if s1 == "Feint" and ... == "End" then
        endFeint(u6)

        return
    end

    local v11 = HalloweenFxUtil_m.Root(u6)

    if not v11 then
        endFeint(u6)

        return
    end

    if s1 == "Feint" then
        local v12, v13 = ...

        if v12 == "Flare" then
            endFeint(u6)
            local t_9 = {}
            local NeckFire = u6:FindFirstChild("NeckFire", true)

            for _, val_7 in NeckFire and NeckFire:GetDescendants() or {} do
                if val_7:IsA("ParticleEmitter") then
                    local t_10 = { Size = val_7.Size, Rate = val_7.Rate }
                    t_9[val_7] = t_10
                    val_7.Size = scaleSequence(val_7.Size, 1.6)
                    val_7.Rate *= 2
                end
            end

            t_6[u6] = { Charge = chargeBlade(u6), Neck = t_9 }

            return
        end

        if v12 == "Flash" then
            HalloweenFxUtil_m.Tint(u6, color_4, 0.25, 0.25)
            local v16 = t_6[u6]

            for _, val_8 in v16 and v16.Charge or {} do
                local v18 = val_8:IsA("ParticleEmitter") and { val_8 } or val_8:GetDescendants()

                for _, val_9 in v18 do
                    if val_9:IsA("ParticleEmitter") then
                        val_9:Emit(4)
                    end
                end
            end

            HalloweenFxUtil_m.Shake(
                v11.Position,
                1.5,
                12,
                0.25,
                50
            )

            return
        end

        if v12 == "Slash" then
            chargedSlash(v11, v13, u6:GetScale())
            local v20 = u6.PrimaryPart or u6:FindFirstChild("HumanoidRootPart")
            local v21 = Sounds

            if v21 then
                v21 = v13

                if v21 then
                    v21 = Sounds:FindFirstChild(`Slash{v13}`)
                end
            end

            if v20 and v21 then
                HalloweenFxUtil_m.Sound(v21, v20, t[v13])
            end

            HalloweenFxUtil_m.Shake(
                v11.Position,
                2.5,
                12,
                0.35,
                60
            )

            return
        end
    else
        local v25

        if s1 == "Sweep" then
            local v24 = ...
            v25 = Assets:FindFirstChild(t_1[v24] or "")

            if v25 then
                HalloweenFxUtil_m.Place(v25, u6)
            end

            v25 = u6.PrimaryPart or u6:FindFirstChild("HumanoidRootPart")
            local v26 = Sounds

            if v26 then
                v26 = v24

                if v26 then
                    v26 = Sounds:FindFirstChild(`Slash{v24}`)
                end
            end

            if v25 and v26 then
                HalloweenFxUtil_m.Sound(v26, v25, t[v24])
            end

            HalloweenFxUtil_m.Shake(
                v11.Position,
                1.2,
                8,
                0.25,
                50
            )

            return
        end

        if s1 == "HeavySlash" then
            HalloweenFxUtil_m.Place(Assets.HeavySlash, u6)
            local v29 = u6.PrimaryPart or u6:FindFirstChild("HumanoidRootPart")

            if v29 and Sounds then
                HalloweenFxUtil_m.Sound(Sounds:FindFirstChild("Slash3"), v29)

                return
            end
        else
            if s1 == "Slam" then
                HalloweenFxUtil_m.Place(Assets.HeavySlashSlam, u6)
                HalloweenFxUtil_m.Shake(
                    v11.Position,
                    4,
                    10,
                    0.5,
                    100
                )

                return
            end

            local v30

            if s1 == "Parried" then
                HalloweenFxUtil_m.Tint(u6, color_1, 0.25, 0.3)
                v30 = u6:FindFirstChild("Torso") or u6:FindFirstChild("HumanoidRootPart")

                if v30 then
                    HalloweenFxUtil_m.PlaceScaled(
                        Assets_3.SwordImpact,
                        v30.CFrame,
                        0.5 * u6:GetScale()
                    )
                end

                HalloweenFxUtil_m.Shake(
                    v11.Position,
                    2,
                    10,
                    0.25,
                    40
                )

                return
            end

            if s1 == "BlockBreak" then
                v30, v25 = ...
                HalloweenFxUtil_m.RemoveTint(t_5[u6])
                t_5[u6] = nil

                if v30 then
                    if v25 then
                        HalloweenFxUtil_m.PopNumber(u6, v25, color_2, 40)
                    end

                    HalloweenFxUtil_m.PlaceScaled(Assets_1.Vanish, v11, 0.35 * u6:GetScale())
                    t_5[u6] = HalloweenFxUtil_m.Tint(u6, color_3, 0.6)
                    HalloweenFxUtil_m.Shake(
                        v11.Position,
                        3,
                        10,
                        0.5,
                        80
                    )

                    return
                end
            else
                if s1 == "Spawn" or s1 == "Despawn" or s1 == "Death" then
                    endFeint(u6)
                    HalloweenFxUtil_m.RemoveTint(t_5[u6])
                    t_5[u6] = nil
                    HalloweenFxUtil_m.PlaceScaled(Assets_1.Vanish, v11, 0.35 * u6:GetScale())

                    return
                end

                if s1 == "Unparryable" then
                    HalloweenFxUtil_m.Unparryable(u6)
                end
            end
        end
    end
end
