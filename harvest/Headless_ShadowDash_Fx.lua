-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Headless.Headless_ShadowDash_Fx
-- Class: ModuleScript
-- bytes: 12517

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local HeadlessFxUtil_m = require(script.Parent.HeadlessFxUtil)
local Assets = script.Assets
local color = Color3.fromRGB(70, 120, 255)
local t = setmetatable({}, { __mode = "k" })

local _ = function(u1: userdata) --[[ stateOf ]] -- line: 19
    -- upvalues:
    --  [1] t (copy)

    local v1 = t[u1]

    if not v1 then
        v1 = {}
        t[u1] = v1
    end

    return v1
end

local t_1 = { Template = Assets.DashEnable, Centre = "Enable" }
local t_2 = { Template = Assets.Orb }

local function carried(u2: userdata, s1: string?) -- line: 39
    local v2 = u2:Clone()
    local v3 = v2:IsA("BasePart") and { v2 } or {}

    for _, descendant in v2:GetDescendants() do
        if descendant:IsA("BasePart") then
            table.insert(v3, descendant)
        end
    end

    local v4 = v2:IsA("BasePart") and v2 or (v2:FindFirstChild(s1 or "", true) or v3[1])
    local Rotation = v4.CFrame.Rotation
    local t_3 = {}

    for _, val in v3 do
        val.Anchored = true
        val.CanCollide = false
        val.CanQuery = false
        val.CanTouch = false
        t_3[val] = v4.CFrame:ToObjectSpace(val.CFrame)
    end

    return v2, function(u3: CFrame) -- line: 59
        -- upvalues:
        --  [1] Rotation (copy)
        --  [2] t_3 (copy)

        local v5 = u3 * Rotation

        for key_2, val_1 in t_3 do
            key_2.CFrame = v5 * val_1
        end
    end
end

local t_4 = { t_1, t_2 }

local function follow(u4: userdata) -- line: 68
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] t_4 (copy)
    --  [3] carried (copy)
    --  [4] RunService (copy)

    local HumanoidRootPart = u4.HumanoidRootPart
    local v6 = HeadlessFxUtil_m.FindBone(u4, "Spinebone")
    local t_5 = {}
    local t_6 = {}

    for _, val_2 in t_4 do
        local v7, v8 = carried(val_2.Template, val_2.Centre)
        table.insert(t_5, v7)
        table.insert(t_6, v8)
    end

    local function place() -- line: 78
        -- upvalues:
        --  [1] v6 (copy)
        --  [2] HumanoidRootPart (copy)
        --  [3] t_6 (copy)

        local v11 = v6 and v6.TransformedWorldCFrame.Position or HumanoidRootPart.Position
        local v12 = CFrame.new(v11) * HumanoidRootPart.CFrame.Rotation

        for _, val_3 in t_6 do
            val_3(v12)
        end
    end

    place()

    for _, val_4 in t_5 do
        val_4.Parent = workspace.Effects
        HeadlessFxUtil_m.Enable(val_4)
    end

    local v13 = nil
    v13 = RunService.RenderStepped:Connect(function() -- line: 92
        -- upvalues:
        --  [1] t_5 (copy)
        --  [2] HumanoidRootPart (copy)
        --  [3] v13 (ref)
        --  [4] place (copy)

        if not t_5[1].Parent or not HumanoidRootPart.Parent then
            v13:Disconnect()

            return
        end

        place()
    end)

    return t_5
end

local function setShadow(u5: userdata, b1: boolean) -- line: 102
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] Assets (copy)

    local v14 = t[u5]

    if not v14 then
        v14 = {}
        t[u5] = v14
    end

    if b1 then
        if not v14.Highlight then
            v14.Highlight = HeadlessFxUtil_m.Highlight(u5, Assets.ShadowHighlight, 0.35, 0.5)
        end

        for _, descendant_1 in u5:GetDescendants() do
            if descendant_1:IsA("BasePart") and descendant_1.Name ~= "HumanoidRootPart" and descendant_1.Name ~= "Head" then
                descendant_1.LocalTransparencyModifier = 0.55
            end
        end

        return
    end

    HeadlessFxUtil_m.RemoveHighlight(v14.Highlight)
    v14.Highlight = nil

    for _, descendant_2 in u5:GetDescendants() do
        if descendant_2:IsA("BasePart") then
            descendant_2.LocalTransparencyModifier = 0
        end
    end
end

local function setRing(u6: userdata, b2: boolean, u7: CFrame?) -- line: 124
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] follow (copy)

    local v15 = t[u6]

    if not v15 then
        v15 = {}
        t[u6] = v15
    end

    if v15.Ring then
        for _, val_5 in v15.Ring do
            HeadlessFxUtil_m.Stop(val_5)
        end

        v15.Ring = nil
    end

    HeadlessFxUtil_m.StopSound(v15.RunSound)
    v15.RunSound = nil

    if b2 and u7 then
        v15.Ring = follow(u6)
        local HumanoidRootPart_1 = u6:FindFirstChild("HumanoidRootPart")
        local v16 = HumanoidRootPart_1

        if v16 then
            v16 = HeadlessFxUtil_m.LoopSound("ShadowDashRun", HumanoidRootPart_1)
        end

        v15.RunSound = v16
    end
end

local cframe = CFrame.Angles(0, 0, 1.5707963267948966)

local function groundBeam(u8: userdata, n1: number, n2: number, n3: number) -- line: 147
    -- upvalues:
    --  [1] cframe (copy)
    --  [2] color (copy)

    local Attachment = Instance.new("Attachment")
    Attachment.CFrame = cframe
    Attachment.Parent = u8
    local Attachment_1 = Instance.new("Attachment")
    Attachment_1.CFrame = CFrame.new(0, 0, -n1) * cframe
    Attachment_1.Parent = u8
    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment_1
    Beam.Texture = "rbxassetid://16892386886"
    Beam.TextureMode = Enum.TextureMode.Stretch
    Beam.TextureSpeed = 1.5
    Beam.Width0 = n2
    Beam.Width1 = n2
    Beam.FaceCamera = false
    Beam.LightEmission = 1
    Beam.LightInfluence = 0
    Beam.Color = ColorSequence.new(color)
    Beam.Transparency = NumberSequence.new(n3)
    Beam.Segments = 1
    Beam.Parent = u8

    return Beam, Attachment_1
end

local function warningBeam(vec1: Vector3, vec2: Vector3, n4: number, n5: number) -- line: 172
    -- upvalues:
    --  [1] groundBeam (copy)
    --  [2] cframe (copy)
    --  [3] TweenService (copy)
    --  [4] Debris (copy)

    local Magnitude: Vector3 = (vec2 - vec1).Magnitude
    local HeadlessCutWarning_Part = Instance.new("Part")
    HeadlessCutWarning_Part.Name = "HeadlessCutWarning"
    HeadlessCutWarning_Part.Size = Vector3.new(1, 1, 1)
    HeadlessCutWarning_Part.Transparency = 1
    HeadlessCutWarning_Part.Anchored = true
    HeadlessCutWarning_Part.CanCollide = false
    HeadlessCutWarning_Part.CanQuery = false
    HeadlessCutWarning_Part.CanTouch = false
    HeadlessCutWarning_Part.CFrame = CFrame.lookAt(
        vec1 + Vector3.new(0, 0.25, 0),
        vec2 + Vector3.new(0, 0.25, 0)
    )
    HeadlessCutWarning_Part.Parent = workspace.Effects
    groundBeam(HeadlessCutWarning_Part, Magnitude, n4, 0.7)
    local _, v18 = groundBeam(HeadlessCutWarning_Part, 0.05, n4 * 0.8, 0.1)
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Changed:Connect(function(arg1) -- line: 188
        -- upvalues:
        --  [1] v18 (copy)
        --  [2] Magnitude (copy)
        --  [3] cframe (ref)

        v18.CFrame = CFrame.new(0, 0, -math.max(Magnitude * arg1, 0.05)) * cframe
    end)
    TweenService:Create(NumberValue, TweenInfo.new(n5, Enum.EasingStyle.Linear), { Value = 1 }):Play()
    Debris:AddItem(NumberValue, n5 + 0.1)
    Debris:AddItem(HeadlessCutWarning_Part, n5 + 0.05)
end

local color_1 = Color3.fromRGB(20, 10, 45)
local color_2 = Color3.fromRGB(150, 185, 255)

local function cutCore() -- line: 203
    -- upvalues:
    --  [1] color_1 (copy)
    --  [2] color_2 (copy)

    local Part_1 = Instance.new("Part")
    Part_1.Name = "HeadlessCutCore"
    Part_1.Shape = Enum.PartType.Ball
    Part_1.Size = Vector3.new(4, 4, 4)
    Part_1.Material = Enum.Material.Neon
    Part_1.Color = color_1
    Part_1.CastShadow = false
    Part_1.Anchored = true
    Part_1.CanCollide = false
    Part_1.CanQuery = false
    Part_1.CanTouch = false
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = color_1
    Highlight.FillTransparency = 0.2
    Highlight.OutlineColor = color_2
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Adornee = Part_1
    Highlight.Parent = Part_1

    return Part_1
end

local function shadowCut(vec3: Vector3, vec4: Vector3, n6: number) -- line: 226
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] Assets (copy)
    --  [3] cutCore (copy)
    --  [4] RunService (copy)
    --  [5] TweenService (copy)

    local Rotation_1 = CFrame.lookAt(
        Vector3.new(0, 0, 0),
        (Vector3.new(vec4.X - vec3.X, 0, vec4.Z - vec3.Z))
    ).Rotation

    local _ = function(n7: number) --[[ at ]] -- line: 228
        -- upvalues:
        --  [1] vec3 (copy)
        --  [2] vec4 (copy)
        --  [3] Rotation_1 (copy)

        return CFrame.new(vec3:Lerp(vec4, n7) + Vector3.new(0, 6, 0)) * Rotation_1
    end

    local v23 = HeadlessFxUtil_m.Spawn(
        Assets.Small_Orb,
        CFrame.new(vec3:Lerp(vec4, 0) + Vector3.new(0, 6, 0)) * Rotation_1
    )
    HeadlessFxUtil_m.Enable(v23)
    local v24 = cutCore()
    v24.CFrame = v23.CFrame
    v24.Parent = workspace.Effects
    local clock = os.clock()
    local v25 = nil
    v25 = RunService.RenderStepped:Connect(function() -- line: 240
        -- upvalues:
        --  [1] clock (copy)
        --  [2] n6 (copy)
        --  [3] v23 (copy)
        --  [4] vec3 (copy)
        --  [5] vec4 (copy)
        --  [6] Rotation_1 (copy)
        --  [7] v24 (copy)
        --  [8] v25 (ref)
        --  [9] HeadlessFxUtil_m (ref)
        --  [10] TweenService (ref)

        local v26 = math.min((os.clock() - clock) / n6, 1)

        if v23.Parent then
            v23.CFrame = CFrame.new(vec3:Lerp(vec4, v26) + Vector3.new(0, 6, 0)) * Rotation_1
            v24.CFrame = v23.CFrame
        end

        if not v23.Parent or v26 >= 1 then
            v25:Disconnect()
            HeadlessFxUtil_m.Stop(v23)
            TweenService:Create(
                v24.Highlight,
                TweenInfo.new(0.15),
                { FillTransparency = 1, OutlineTransparency = 1 }
            ):Play()
            HeadlessFxUtil_m.FadeOut(v24, 0.15)
        end
    end)
end

return function(u9: userdata, s2: string, ...) -- line: 256
    -- upvalues:
    --  [1] setShadow (copy)
    --  [2] t (copy)
    --  [3] HeadlessFxUtil_m (copy)
    --  [4] warningBeam (copy)
    --  [5] shadowCut (copy)
    --  [6] Assets (copy)
    --  [7] setRing (copy)

    if s2 == "Shadow" then
        local v28 = ...

        if u9.Parent then
            setShadow(u9, v28)
        end

        return
    end

    local v29

    if s2 == "Ring" and not ... then
        v29 = t[u9]

        if not v29 then
            v29 = {}
            t[u9] = v29
        end

        if v29.Ring then
            for _, val_6 in v29.Ring do
                HeadlessFxUtil_m.Stop(val_6)
            end

            v29.Ring = nil
        end

        HeadlessFxUtil_m.StopSound(v29.RunSound)
        v29.RunSound = nil

        return
    end

    local v30, v31

    if s2 == "CutWarn" then
        local v32
        v29, v30, v31, v32 = ...

        if HeadlessFxUtil_m.Near(v29) then
            warningBeam(v29, v30, v32, v31)
        end

        return
    end

    if s2 == "Cut" then
        v29, v30, v31 = ...

        if HeadlessFxUtil_m.Near(v29) then
            shadowCut(v29, v30, v31)
            HeadlessFxUtil_m.Shake(
                (v29 + v30) / 2,
                2,
                10,
                0.35,
                120
            )
            HeadlessFxUtil_m.Sound("ShadowDashCut", v29)
        end

        return
    end

    local v33 = HeadlessFxUtil_m.Feet(u9)

    if not v33 then
        return
    end

    local HumanoidRootPart_2

    if s2 == "AuraStart" then
        HeadlessFxUtil_m.Place(Assets.AuraSTartUp, v33)
        HumanoidRootPart_2 = u9:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart_2 then
            HeadlessFxUtil_m.Sound("ShadowDashWindup", HumanoidRootPart_2)

            return
        end
    elseif s2 == "Vanish" or s2 == "Materialize" then
        HumanoidRootPart_2, v31 = ...
        local v34 = HumanoidRootPart_2 or v33
        HeadlessFxUtil_m.Place(Assets.Vanish, v34)
        HeadlessFxUtil_m.Shake(
            v34.Position,
            3,
            10,
            0.5,
            120
        )

        if s2 == "Materialize" and v31 then
            HeadlessFxUtil_m.Sound("ShadowDashReappear", v34.Position)

            return
        end
    elseif s2 == "Ring" then
        setRing(u9, true, v33)
    end
end
