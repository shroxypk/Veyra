-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Halloween.PumpkinShade_Fx
-- Class: ModuleScript
-- bytes: 22731

local RunService = game:GetService("RunService")
local HalloweenFxUtil_m = require(script.Parent.HalloweenFxUtil)
local Assets = script.Assets
local Sounds = script.Sounds
local t = { Swipe1 = 0.05, Swipe2 = 0.15, LungeDoubleSwipe = 0.14, Throw = 0.25 }
local DarkLantern = script.DarkLantern
local Headless = script.Parent.Parent.Headless
local Assets_1 = Headless.Headless_PumpkinSummon_Fx.Assets
local Charge = Headless.Headless_PumpkinExplosion_Fx.Charge
local t_1 = { "Claw1", "Claw2", "Claw3" }
local t_2 = { 6, 0.3 }
local gradient_1 = ColorSequence.new(
    {
        ColorSequenceKeypoint.new(0, Color3.fromHex("261E48")),
        ColorSequenceKeypoint.new(0.4, Color3.fromHex("0F0E17")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("08070B"))
    }
)
local color = Color3.fromHex("0F0E17")
local color_1 = Color3.fromHex("08070B")
local color_2 = Color3.fromHex("0F0E17")
local color_3 = Color3.fromRGB(168, 130, 159)
local color_4 = Color3.fromRGB(8, 4, 6)
local color_5 = Color3.fromHex("261E48")
local color_6 = Color3.fromHex("261E48")
local color_7 = Color3.fromHex("0F0E17")
local color_8 = Color3.fromRGB(150, 0, 20)
local t_4 = {}
local t_5 = {}
local t_6 = {}

local function darken(u1: userdata, u2: Color3) -- line: 83
    local gradient = ColorSequence.new(u2)

    for _, descendant in u1:GetDescendants() do
        if not descendant:IsA("ParticleEmitter") then
            if not descendant:IsA("Trail") then
                if descendant:IsA("Beam") then
                    descendant.Color = gradient
                    descendant.LightEmission = 0
                    descendant.LightInfluence = 0

                    if descendant:IsA("ParticleEmitter") then
                        descendant.Brightness = 1
                    end
                elseif descendant:IsA("Light") then
                    descendant.Enabled = false
                end
            else
                descendant.Color = gradient
                descendant.LightEmission = 0
                descendant.LightInfluence = 0

                if descendant:IsA("ParticleEmitter") then
                    descendant.Brightness = 1

                    if descendant:IsA("Light") then
                        descendant.Enabled = false
                    end
                end
            end
        else
            descendant.Color = gradient
            descendant.LightEmission = 0
            descendant.LightInfluence = 0

            if descendant:IsA("ParticleEmitter") then
                descendant.Brightness = 1

                if descendant:IsA("Light") then
                    descendant.Enabled = false
                end
            end
        end
    end
end

local function fade(u3: userdata, n1: number) -- line: 100
    for _, descendant_1 in u3:GetDescendants() do
        if descendant_1:IsA("ParticleEmitter") then
            local t_7 = {}

            for _, val in descendant_1.Transparency.Keypoints do
                local v4 = 1 - (1 - val.Value) * n1
                table.insert(
                    t_7,
                    NumberSequenceKeypoint.new(val.Time, v4, (math.min(val.Envelope, v4, 1 - v4)))
                )
            end

            descendant_1.Transparency = NumberSequence.new(t_7)
        end
    end
end

local v6 = Assets.Explosion:Clone()
local Value
local v7, v8

for _, descendant_2 in v6:GetDescendants() do
    if not descendant_2:IsA("ParticleEmitter") then
        if not descendant_2:IsA("Trail") then
            if descendant_2:IsA("Beam") then
                Value = descendant_2.Color.Keypoints[1].Value
                v7 = math.max(Value.R, Value.G, Value.B) >= 0.35 and true
                v8 = v7 and color_6 or color_7
                descendant_2.Color = ColorSequence.new(v8)
                descendant_2.LightEmission = 0
                descendant_2.LightInfluence = 0

                if descendant_2:IsA("ParticleEmitter") then
                    descendant_2.Brightness = 1
                end
            elseif descendant_2:IsA("Light") then
                descendant_2.Enabled = false
            end
        else
            Value = descendant_2.Color.Keypoints[1].Value
            v7 = math.max(Value.R, Value.G, Value.B) >= 0.35 and true
            v8 = v7 and color_6 or color_7
            descendant_2.Color = ColorSequence.new(v8)
            descendant_2.LightEmission = 0
            descendant_2.LightInfluence = 0

            if descendant_2:IsA("ParticleEmitter") then
                descendant_2.Brightness = 1

                if descendant_2:IsA("Light") then
                    descendant_2.Enabled = false
                end
            end
        end
    else
        Value = descendant_2.Color.Keypoints[1].Value
        v7 = math.max(Value.R, Value.G, Value.B) >= 0.35 and true
        v8 = v7 and color_6 or color_7
        descendant_2.Color = ColorSequence.new(v8)
        descendant_2.LightEmission = 0
        descendant_2.LightInfluence = 0

        if descendant_2:IsA("ParticleEmitter") then
            descendant_2.Brightness = 1

            if descendant_2:IsA("Light") then
                descendant_2.Enabled = false
            end
        end
    end
end

local function shadePumpkin(u4: userdata) -- line: 133
    -- upvalues:
    --  [1] color_3 (copy)
    --  [2] color_4 (copy)
    --  [3] color_5 (copy)

    for _, descendant_3 in u4:GetDescendants() do
        if descendant_3:IsA("SurfaceAppearance") then
            pcall(function() -- line: 136
                -- upvalues:
                --  [1] descendant_3 (copy)
                --  [2] color_3 (ref)

                descendant_3.Color = color_3
                descendant_3.EmissiveStrength = 0
            end)
        end
    end

    local PumpkinShade_Highlight = Instance.new("Highlight")
    PumpkinShade_Highlight.Name = "PumpkinShade"
    PumpkinShade_Highlight.FillColor = color_4
    PumpkinShade_Highlight.FillTransparency = 0.45
    PumpkinShade_Highlight.OutlineColor = color_5
    PumpkinShade_Highlight.OutlineTransparency = 0.45
    PumpkinShade_Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    PumpkinShade_Highlight.Adornee = u4
    PumpkinShade_Highlight.Parent = u4

    return PumpkinShade_Highlight
end

local _ = function(u5: userdata) --[[ prepare ]] -- line: 154
    local v9 = u5:FindFirstChildWhichIsA("BasePart") or u5
    v9.Anchored = true
    v9.CanCollide = false
    v9.CanQuery = false
    v9.CanTouch = false

    return v9
end

local _ = function(u6: userdata, u7: userdata, n2: number) --[[ scaleLantern ]] -- line: 163
    if u6:IsA("Model") then
        u6:ScaleTo(u6:GetScale() * n2)

        return
    end

    u7.Size *= n2
end

local _ = function(u8: userdata) --[[ clearLantern ]] -- line: 175
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] HalloweenFxUtil_m (copy)

    local v11 = t_4[u8]
    t_4[u8] = nil

    if not v11 then
        return
    end

    v11.Lantern:Destroy()
    HalloweenFxUtil_m.Stop(v11.Aura)
    v11.Carrier.Trail.Enabled = false
    task.delay(0.4, v11.Carrier.Destroy, v11.Carrier)
end

local function trailCarrier(vec1: Vector3) -- line: 189
    -- upvalues:
    --  [1] gradient_1 (copy)

    local LanternTrail_Part = Instance.new("Part")
    LanternTrail_Part.Name = "LanternTrail"
    LanternTrail_Part.Size = Vector3.new(0.2, 0.2, 0.2)
    LanternTrail_Part.Transparency = 1
    LanternTrail_Part.Anchored = true
    LanternTrail_Part.CanCollide = false
    LanternTrail_Part.CanQuery = false
    LanternTrail_Part.CanTouch = false
    LanternTrail_Part.CFrame = CFrame.new(vec1)
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(0, 0.6, 0)
    Attachment.Parent = LanternTrail_Part
    local Attachment_1 = Instance.new("Attachment")
    Attachment_1.Position = Vector3.new(0, -0.6, 0)
    Attachment_1.Parent = LanternTrail_Part
    local Trail = Instance.new("Trail")
    Trail.Attachment0 = Attachment
    Trail.Attachment1 = Attachment_1
    Trail.Color = gradient_1
    Trail.Transparency = NumberSequence.new(
        { NumberSequenceKeypoint.new(0, 0.05), NumberSequenceKeypoint.new(1, 1) }
    )
    Trail.Lifetime = 0.3
    Trail.LightEmission = 0
    Trail.LightInfluence = 0
    Trail.FaceCamera = true
    Trail.MinLength = 0.05
    Trail.Parent = LanternTrail_Part
    LanternTrail_Part.Parent = workspace.Effects

    return LanternTrail_Part
end

local function toss(u9: userdata, vec2: Vector3, vec3: Vector3, n3: number) -- line: 223
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] HalloweenFxUtil_m (copy)
    --  [3] DarkLantern (copy)
    --  [4] shadePumpkin (copy)
    --  [5] Assets (copy)
    --  [6] darken (copy)
    --  [7] color_1 (copy)
    --  [8] trailCarrier (copy)
    --  [9] t_2 (copy)
    --  [10] RunService (copy)

    local v12 = t_4[u9]
    t_4[u9] = nil

    if v12 then
        v12.Lantern:Destroy()
        HalloweenFxUtil_m.Stop(v12.Aura)
        v12.Carrier.Trail.Enabled = false
        task.delay(0.4, v12.Carrier.Destroy, v12.Carrier)
    end

    if not HalloweenFxUtil_m.Near(vec2) and not HalloweenFxUtil_m.Near(vec3) then
        return
    end

    local v13 = DarkLantern:Clone()
    local v14 = v13:FindFirstChildWhichIsA("BasePart") or v13
    v14.Anchored = true
    v14.CanCollide = false
    v14.CanQuery = false
    v14.CanTouch = false

    if v13:IsA("Model") then
        v13:ScaleTo(v13:GetScale() * 0.6)
    else
        v14.Size *= 0.6
    end

    v14.CFrame = CFrame.new(vec2)
    shadePumpkin(v13)
    v13.Parent = workspace.Effects
    local v16 = Assets.PumpkinAura:GetAttribute("Offset") or CFrame.identity
    local v17 = HalloweenFxUtil_m.Spawn(Assets.PumpkinAura, CFrame.new(vec2) * v16.Rotation)
    HalloweenFxUtil_m.ScaleParticles(v17, 0.6)
    darken(v17, color_1)
    HalloweenFxUtil_m.Enable(v17, true)
    local v18 = trailCarrier(vec2)
    local t_9 = { Lantern = v13, Aura = v17, Carrier = v18 }
    t_4[u9] = t_9
    local v19 = math.max(t_2[1], (vec3 - vec2).Magnitude * t_2[2])
    local clock = os.clock()
    local v20 = nil
    v20 = RunService.RenderStepped:Connect(function() -- line: 249
        -- upvalues:
        --  [1] t_4 (ref)
        --  [2] u9 (copy)
        --  [3] t_9 (copy)
        --  [4] v13 (copy)
        --  [5] v20 (ref)
        --  [6] clock (copy)
        --  [7] n3 (copy)
        --  [8] vec2 (copy)
        --  [9] vec3 (copy)
        --  [10] v19 (copy)
        --  [11] v14 (copy)
        --  [12] v17 (copy)
        --  [13] v16 (copy)
        --  [14] v18 (copy)

        if t_4[u9] ~= t_9 or not v13.Parent then
            v20:Disconnect()

            return
        end

        local v21 = os.clock() - clock
        local v22 = math.min(v21 / n3, 1)
        local v25 = vec2:Lerp(vec3 + Vector3.new(0, 1, 0), v22) + Vector3.new(
            0,
            v19 * 4 * v22 * (1 - v22),
            0
        )
        v14.CFrame = CFrame.new(v25) * CFrame.Angles(
            v21 * 9.42477796076938,
            v21 * 9.42477796076938 * 0.4,
            0
        )
        v17.CFrame = CFrame.new(v25) * v16.Rotation
        v18.CFrame = CFrame.new(v25)
    end)
end

local function addDust(n4: number, vec4: Vector3, n5: number, n6: number) -- line: 264
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Assets_1 (copy)
    --  [3] darken (copy)
    --  [4] color_2 (copy)
    --  [5] fade (copy)
    --  [6] Sounds (copy)
    --  [7] t_6 (copy)

    if not HalloweenFxUtil_m.Near(vec4) then
        return
    end

    local v30 = HalloweenFxUtil_m.Spawn(Assets_1.Smoke, CFrame.new(vec4 + Vector3.new(0, 1, 0)))
    HalloweenFxUtil_m.ScaleParticles(v30, 0.6)
    darken(v30, color_2)
    fade(v30, 0.55)
    HalloweenFxUtil_m.Emit(v30)
    local PumpkinLinger = Assets_1.PumpkinLinger
    local v31 = PumpkinLinger:GetAttribute("Offset") or CFrame.identity
    local v32 = n5 * 2
    local math_max = math.max
    local Y = v31.Y
    local v33 = v32 / math_max(PumpkinLinger.Size.X, PumpkinLinger.Size.Z)
    local v34 = v33 ^ 0.5
    local v35 = HalloweenFxUtil_m.Spawn(PumpkinLinger, CFrame.new(vec4 + Vector3.new(0, Y, 0)))
    v35.Size = Vector3.new(
        PumpkinLinger.Size.X * v33,
        PumpkinLinger.Size.Y,
        PumpkinLinger.Size.Z * v33
    )
    HalloweenFxUtil_m.ScaleParticles(v35, v34)

    for _, descendant_4 in v35:GetDescendants() do
        if descendant_4:IsA("ParticleEmitter") then
            descendant_4.Rate *= v34 * 0.55
        end
    end

    darken(v35, color_2)
    fade(v35, 0.55)
    HalloweenFxUtil_m.Enable(v35)
    HalloweenFxUtil_m.LoopSound(Sounds:FindFirstChild("DustLoop"), v35)
    t_6[n4] = v35
    task.delay(n6 + 1, function() -- line: 291
        -- upvalues:
        --  [1] t_6 (ref)
        --  [2] n4 (copy)
        --  [3] v35 (copy)
        --  [4] HalloweenFxUtil_m (ref)

        if t_6[n4] == v35 then
            t_6[n4] = nil
            HalloweenFxUtil_m.StopSound(v35:FindFirstChild("DustLoop"), 0.6)
            HalloweenFxUtil_m.Stop(v35)
        end
    end)
end

local _ = function(n7: number) --[[ removeDust ]] -- line: 300
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] HalloweenFxUtil_m (copy)

    local v36 = t_6[n7]
    t_6[n7] = nil

    if v36 then
        HalloweenFxUtil_m.StopSound(v36:FindFirstChild("DustLoop"), 0.6)
        HalloweenFxUtil_m.Stop(v36)
    end
end

local _ = function(u10: userdata) --[[ clearDecoy ]] -- line: 313
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] HalloweenFxUtil_m (copy)

    local v37 = t_5[u10]
    t_5[u10] = nil

    if not v37 then
        return
    end

    v37.Lantern:Destroy()
    HalloweenFxUtil_m.Stop(v37.Aura)
    HalloweenFxUtil_m.Stop(v37.Charge)
end

local function buildDecoy(u11: CFrame?) -- line: 326
    -- upvalues:
    --  [1] DarkLantern (copy)
    --  [2] shadePumpkin (copy)
    --  [3] Assets (copy)
    --  [4] HalloweenFxUtil_m (copy)
    --  [5] darken (copy)
    --  [6] color_1 (copy)
    --  [7] Charge (copy)
    --  [8] color (copy)

    local v38 = DarkLantern:Clone()
    local v39 = v38:FindFirstChildWhichIsA("BasePart") or v38
    v39.Anchored = true
    v39.CanCollide = false
    v39.CanQuery = false
    v39.CanTouch = false

    if v38:IsA("Model") then
        v38:ScaleTo(v38:GetScale() * 1.5)
    else
        v39.Size *= 1.5
    end

    u11 = (u11 or CFrame.identity) * CFrame.new(0, v39.Size.Y / 2 + 0.2, 0)
    v39.CFrame = u11
    local v42 = shadePumpkin(v38)
    local v43 = Assets.PumpkinAura:GetAttribute("Offset") or CFrame.identity
    local v44 = HalloweenFxUtil_m.Spawn(Assets.PumpkinAura, u11 * v43.Rotation)
    darken(v44, color_1)
    v43 = Charge:Clone()
    HalloweenFxUtil_m.ScaleParticles(v43, math.max(v39.Size.X, v39.Size.Z) / 4.65 * 0.5)
    darken(v43, color)
    v43.Position = Vector3.new(0, 0, 0)
    v43.Parent = v39

    return v38, v39, u11, v42, v44, v43
end

local function decoy(u12: userdata, vec5: Vector3, n8: number) -- line: 348
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] HalloweenFxUtil_m (copy)
    --  [3] buildDecoy (copy)
    --  [4] RunService (copy)
    --  [5] color_8 (copy)
    --  [6] color_4 (copy)

    local v48, v49, v50
    local v45 = t_5[u12]
    t_5[u12] = nil

    if v45 then
        v45.Lantern:Destroy()
        HalloweenFxUtil_m.Stop(v45.Aura)
        HalloweenFxUtil_m.Stop(v45.Charge)
    end

    if not HalloweenFxUtil_m.Near(vec5) then
        return
    end

    local v47, v51, v52
    v47, v48, v49, v50, v51, v52 = buildDecoy(CFrame.new(vec5))
    v47.Parent = workspace.Effects
    HalloweenFxUtil_m.Enable(v51, true)
    HalloweenFxUtil_m.Enable(v52)
    local t_10 = { Lantern = v47, Aura = v51, Charge = v52 }
    t_5[u12] = t_10
    local clock_1 = os.clock()
    local v58 = 0
    local v59 = 0
    local v60 = nil
    v60 = RunService.RenderStepped:Connect(function() -- line: 366
        -- upvalues:
        --  [1] t_5 (ref)
        --  [2] u12 (copy)
        --  [3] t_10 (copy)
        --  [4] v47 (copy)
        --  [5] v60 (ref)
        --  [6] clock_1 (copy)
        --  [7] v48 (copy)
        --  [8] v49 (copy)
        --  [9] v58 (ref)
        --  [10] n8 (copy)
        --  [11] v59 (ref)
        --  [12] v50 (copy)
        --  [13] color_8 (ref)
        --  [14] color_4 (ref)

        if t_5[u12] ~= t_10 or not v47.Parent then
            v60:Disconnect()

            return
        end

        local v61 = os.clock() - clock_1
        v48.CFrame = v49 * CFrame.Angles(0, v61 * 1.5, math.sin(v61 * 9) * 0.12)

        if v61 >= v58 then
            local v65 = math.max(n8 - v61, 0.05)
            v59 = v61 + 0.06
            v58 = v61 + math.clamp(v65 * 0.35, 0.12, 0.4)
        end

        local v65 = v61 < v59 and true
        v50.FillColor = v65 and color_8 or color_4
        v50.FillTransparency = if not v65 then 0.45 else 0.2
    end)
    task.delay(n8 + 1, function() -- line: 383
        -- upvalues:
        --  [1] t_5 (ref)
        --  [2] u12 (copy)
        --  [3] t_10 (copy)
        --  [4] HalloweenFxUtil_m (ref)

        if t_5[u12] == t_10 then
            local v67 = u12
            local v68 = t_5[v67]
            t_5[v67] = nil

            if not v68 then
                return
            end

            v68.Lantern:Destroy()
            HalloweenFxUtil_m.Stop(v68.Aura)
            HalloweenFxUtil_m.Stop(v68.Charge)
        end
    end)
end

local _ = function(s1: string, arg1: any) --[[ sound ]] -- line: 390
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Sounds (copy)
    --  [3] t (copy)

    HalloweenFxUtil_m.Sound(Sounds:FindFirstChild(s1), arg1, t[s1])
end

return function(u13: userdata, arg2: any, ...) -- line: 394
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Sounds (copy)
    --  [3] t (copy)
    --  [4] toss (copy)
    --  [5] t_4 (copy)
    --  [6] v6 (copy)
    --  [7] addDust (copy)
    --  [8] t_6 (copy)
    --  [9] decoy (copy)
    --  [10] t_5 (copy)
    --  [11] Assets (copy)
    --  [12] t_1 (copy)

    if arg2 == "Toss" then
        local v70 = u13:FindFirstChild("HumanoidRootPart") or ...
        HalloweenFxUtil_m.Sound(Sounds:FindFirstChild("Throw"), v70, t.Throw)
        toss(u13, ...)

        return
    end

    if arg2 == "Explode" then
        local v71 = ...
        local v72 = t_4[u13]
        t_4[u13] = nil

        if v72 then
            v72.Lantern:Destroy()
            HalloweenFxUtil_m.Stop(v72.Aura)
            v72.Carrier.Trail.Enabled = false
            task.delay(0.4, v72.Carrier.Destroy, v72.Carrier)
        end

        HalloweenFxUtil_m.Sound(Sounds:FindFirstChild("Explosion"), v71, t.Explosion)
        HalloweenFxUtil_m.PlaceAtPoint(v6, v71 + Vector3.new(0, 1, 0))
        HalloweenFxUtil_m.Shake(
            v71,
            4,
            10,
            0.5,
            120
        )

        return
    end

    if arg2 == "Dust" then
        addDust(...)

        return
    end

    if arg2 == "DustEnd" then
        local v73 = ...
        local v74 = t_6[v73]
        t_6[v73] = nil

        if v74 then
            HalloweenFxUtil_m.StopSound(v74:FindFirstChild("DustLoop"), 0.6)
            HalloweenFxUtil_m.Stop(v74)
        end

        return
    end

    if arg2 == "Decoy" then
        decoy(u13, ...)

        return
    end

    if arg2 == "DecoyBurst" then
        local v75 = ...
        local v76 = t_5[u13]
        t_5[u13] = nil

        if v76 then
            v76.Lantern:Destroy()
            HalloweenFxUtil_m.Stop(v76.Aura)
            HalloweenFxUtil_m.Stop(v76.Charge)
        end

        HalloweenFxUtil_m.Sound(Sounds:FindFirstChild("Explosion"), v75, t.Explosion)
        HalloweenFxUtil_m.PlaceAtPoint(v6, v75 + Vector3.new(0, 1.5, 0), nil, 1.4)
        HalloweenFxUtil_m.Shake(
            v75,
            5,
            12,
            0.5,
            130
        )

        return
    end

    local v77 = HalloweenFxUtil_m.Root(u13)

    if not v77 then
        return
    end

    local HumanoidRootPart = u13.HumanoidRootPart

    if arg2 == "Claw" then
        local v78 = ...
        local v79 = Assets:FindFirstChild(t_1[v78] or "")

        if v79 then
            HalloweenFxUtil_m.Place(v79, u13)
        end

        local v80 = "Swipe" .. v78
        HalloweenFxUtil_m.Sound(Sounds:FindFirstChild(v80), HumanoidRootPart, t[v80])

        if v78 == 3 then
            HalloweenFxUtil_m.Shake(
                v77.Position,
                1.2,
                8,
                0.25,
                50
            )

            return
        end
    else
        if arg2 == "LungeStart" then
            HalloweenFxUtil_m.Sound(
                Sounds:FindFirstChild("LungeDoubleSwipe"),
                HumanoidRootPart,
                t.LungeDoubleSwipe
            )

            return
        end

        if arg2 == "Lunge" then
            HalloweenFxUtil_m.Place(Assets.LungeClaw1, u13)
            HalloweenFxUtil_m.Place(Assets.LungeClaw2, u13)
            HalloweenFxUtil_m.Shake(
                v77.Position,
                1.5,
                8,
                0.3,
                60
            )

            return
        end

        if arg2 == "DashStart" or (arg2 == "DashAppear" or (arg2 == "Spawn" or (arg2 == "Despawn" or arg2 == "Death"))) then
            HalloweenFxUtil_m.Place(Assets.DashStart, u13)

            if arg2 == "DashStart" or (arg2 == "Despawn" or arg2 == "Death") then
                local Position = HumanoidRootPart.Position
                HalloweenFxUtil_m.Sound(Sounds:FindFirstChild("Vanish"), Position, t.Vanish)
            elseif arg2 == "DashAppear" or arg2 == "Spawn" then
                HalloweenFxUtil_m.Sound(
                    Sounds:FindFirstChild("Reappear"),
                    HumanoidRootPart,
                    t.Reappear
                )
            end

            local v82

            if arg2 ~= "Death" then
                if arg2 == "Despawn" then
                    v82 = t_5[u13]
                    t_5[u13] = nil

                    if not v82 then
                        return
                    end

                    v82.Lantern:Destroy()
                    HalloweenFxUtil_m.Stop(v82.Aura)
                    HalloweenFxUtil_m.Stop(v82.Charge)

                    return
                end
            else
                v82 = t_5[u13]
                t_5[u13] = nil

                if not v82 then
                    return
                end

                v82.Lantern:Destroy()
                HalloweenFxUtil_m.Stop(v82.Aura)
                HalloweenFxUtil_m.Stop(v82.Charge)

                return
            end
        elseif arg2 == "Unparryable" then
            HalloweenFxUtil_m.Unparryable(u13)
        end
    end
end
