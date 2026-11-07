-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Halloween.HalloweenFxUtil
-- Class: ModuleScript
-- bytes: 9878

local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local HeadlessFxUtil_m = require(script.Parent.Parent.Headless.HeadlessFxUtil)
local t = { __index = HeadlessFxUtil_m }
local Assets = script.Parent.Parent.Headless.Headless_Fx.Assets
local t_1 = setmetatable({}, t)

function t_1.Root(u1: userdata?) -- line: 17
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)

    local v1 = u1

    if v1 then
        v1 = u1:FindFirstChild("HumanoidRootPart")
    end

    local LookVector

    if v1 then
        if not HeadlessFxUtil_m.Near(v1.Position) then
            return nil
        end

        LookVector = v1.CFrame.LookVector

        return CFrame.lookAt(v1.Position, v1.Position + Vector3.new(LookVector.X, 0, LookVector.Z))
    else
        return nil
    end
end

function t_1.ScaleOffset(u2: CFrame, n1: number) -- line: 28
    if n1 == 1 then
        return u2
    end

    return CFrame.new(u2.Position * n1) * u2.Rotation
end

function t_1.Place(u3: userdata, u4: userdata) -- line: 37
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] HeadlessFxUtil_m (copy)

    local v2 = t_1.Root(u4)

    if not v2 then
        return nil
    end

    local v3 = u4:GetScale()

    if v3 ~= 1 then
        local v4 = u3:GetAttribute("Offset") or CFrame.identity

        return HeadlessFxUtil_m.PlaceScaled(u3, v2 * t_1.ScaleOffset(v4, v3), v3)
    end

    return HeadlessFxUtil_m.Place(u3, v2)
end

function t_1.PopNumber(u5: userdata, n2: number, u6: Color3, n3: number?) -- line: 51
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] TweenService (copy)
    --  [3] Debris (copy)

    local v5 = u5:FindFirstChild("Head") or u5:FindFirstChild("HumanoidRootPart")
    local BillboardGui, _

    if v5 then
        if not HeadlessFxUtil_m.Near(v5.Position) then
            return
        end

        BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "HalloweenNumber"
        BillboardGui.Adornee = v5
        BillboardGui.AlwaysOnTop = true
        BillboardGui.LightInfluence = 0
        BillboardGui.Size = UDim2.fromOffset(160, 50)
        BillboardGui.StudsOffsetWorldSpace = Vector3.new(
            (math.random() - 0.5) * 2,
            2.5 * u5:GetScale(),
            0
        )
        v5 = Instance.new("TextLabel")
        v5.BackgroundTransparency = 1
        v5.Size = UDim2.fromScale(1, 1)
        v5.Font = Enum.Font.GothamBlack
        v5.Text = tostring((math.floor(n2 + 0.5)))
        v5.TextColor3 = u6
        v5.TextScaled = false
        v5.TextSize = n3 or 30
        v5.TextStrokeTransparency = 0.2
        v5.TextStrokeColor3 = Color3.new(0, 0, 0)
        v5.Parent = BillboardGui
        BillboardGui.Parent = workspace:FindFirstChild("Effects") or workspace
        TweenService:Create(
            BillboardGui,
            TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { StudsOffsetWorldSpace = BillboardGui.StudsOffsetWorldSpace + Vector3.new(0, 2.5, 0) }
        ):Play()
        TweenService:Create(
            v5,
            TweenInfo.new(
                0.4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.In,
                0,
                false,
                0.5
            ),
            { TextTransparency = 1, TextStrokeTransparency = 1 }
        ):Play()
        Debris:AddItem(BillboardGui, 1)

        return
    else
        return
    end
end

function t_1.PlaceAtPoint(u7: userdata, vec1: Vector3, u8: CFrame?, n4: number?) -- line: 86
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)

    if not HeadlessFxUtil_m.Near(vec1) then
        return nil
    end

    local v11 = u7:GetAttribute("Offset") or CFrame.identity
    local v13 = CFrame.new(vec1) * (u8 and u8.Rotation or CFrame.identity) * v11.Rotation

    if n4 and n4 ~= 1 then
        return HeadlessFxUtil_m.PlaceScaled(u7, v13, n4)
    end

    return HeadlessFxUtil_m.PlaceAt(u7, v13)
end

function t_1.GroundRing(vec2: Vector3, n5: number, u9: Color3, n6: number) -- line: 99
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] TweenService (copy)
    --  [3] Debris (copy)

    if not HeadlessFxUtil_m.Near(vec2) then
        return nil
    end

    local HalloweenRing_Part = Instance.new("Part")
    HalloweenRing_Part.Name = "HalloweenRing"
    HalloweenRing_Part.Shape = Enum.PartType.Cylinder
    HalloweenRing_Part.Material = Enum.Material.Neon
    HalloweenRing_Part.Color = u9
    HalloweenRing_Part.Transparency = 0.9
    HalloweenRing_Part.Anchored = true
    HalloweenRing_Part.CanCollide = false
    HalloweenRing_Part.CanQuery = false
    HalloweenRing_Part.CanTouch = false
    HalloweenRing_Part.CastShadow = false
    HalloweenRing_Part.Size = Vector3.new(0.15, n5 * 0.4, n5 * 0.4)
    HalloweenRing_Part.CFrame = CFrame.new(vec2 + Vector3.new(0, 0.1, 0)) * CFrame.Angles(
        0,
        0,
        1.5707963267948966
    )
    HalloweenRing_Part.Parent = workspace.Effects
    TweenService:Create(
        HalloweenRing_Part,
        TweenInfo.new(n6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = Vector3.new(0.15, n5 * 2, n5 * 2), Transparency = 0.7 }
    ):Play()
    Debris:AddItem(HalloweenRing_Part, n6 + 2)

    return HalloweenRing_Part
end

function t_1.Unparryable(u10: userdata, n7: number?, u11: CFrame?) -- line: 126
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] Assets (copy)

    local HumanoidRootPart = u10:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart then
        if not HeadlessFxUtil_m.Near(HumanoidRootPart.Position) then
            return
        end

        local v16 = Assets.UnparryableWarning:Clone()
        v16.CFrame = u11 or CFrame.new(0, 1.5, -2)
        HeadlessFxUtil_m.ScaleParticles(v16, n7 or 1)
        v16.Parent = HumanoidRootPart
        HeadlessFxUtil_m.Emit(v16)

        return
    else
        return
    end
end

function t_1.Tint(u12: userdata, u13: Color3, n8: number, n9: number?) -- line: 139
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] t_1 (copy)

    local HalloweenTint_Highlight = Instance.new("Highlight")
    HalloweenTint_Highlight.Name = "HalloweenTint"
    HalloweenTint_Highlight.FillColor = u13
    HalloweenTint_Highlight.OutlineColor = u13
    HalloweenTint_Highlight.FillTransparency = 1
    HalloweenTint_Highlight.OutlineTransparency = 1
    HalloweenTint_Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    HalloweenTint_Highlight.Adornee = u12
    HalloweenTint_Highlight.Parent = u12
    TweenService:Create(
        HalloweenTint_Highlight,
        TweenInfo.new(0.15),
        { FillTransparency = n8, OutlineTransparency = 0.4 }
    ):Play()

    if n9 and n9 > 0 then
        task.delay(n9, t_1.RemoveTint, HalloweenTint_Highlight)
    end

    return HalloweenTint_Highlight
end

function t_1.RemoveTint(u14: userdata?) -- line: 156
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] Debris (copy)

    if not u14 or not u14.Parent then
        return
    end

    TweenService:Create(u14, TweenInfo.new(0.25), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
    Debris:AddItem(u14, 0.3)
end

function t_1.Sound(u15: userdata?, arg1: any, n10: number?) -- line: 167
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] Debris (copy)

    if not u15 then
        return nil
    end

    local HalloweenSound_Attachment = nil
    local v21

    if typeof(arg1) == "Instance" then
        if arg1.Parent then
            if not HeadlessFxUtil_m.Near(arg1.Position) then
                return nil
            end

            v21 = arg1
        else
            return nil
        end
    else
        if not HeadlessFxUtil_m.Near(arg1) then
            return nil
        end

        HalloweenSound_Attachment = Instance.new("Attachment")
        HalloweenSound_Attachment.Name = "HalloweenSound"
        HalloweenSound_Attachment.WorldPosition = arg1
        HalloweenSound_Attachment.Parent, v21 = workspace.Terrain, HalloweenSound_Attachment
    end

    local v22 = u15:Clone()
    v22.Looped = false
    v22.TimePosition = n10 or 0
    v22.Parent = v21
    v22:Play()
    local v23 = HalloweenSound_Attachment or v22
    v22.Ended:Once(function() -- line: 194
        -- upvalues:
        --  [1] v23 (copy)

        v23:Destroy()
    end)
    Debris:AddItem(v23, 15)

    return v22
end

function t_1.LoopSound(u16: userdata?, u17: userdata) -- line: 202
    if not u16 then
        return nil
    end

    local v24 = u16:Clone()
    v24.Looped = true
    v24.Parent = u17
    v24:Play()

    return v24
end

function t_1.StopSound(u18: userdata?, n11: number?) -- line: 214
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] Debris (copy)

    if not u18 or not u18.Parent then
        return
    end

    n11 = n11 or 0.2
    TweenService:Create(u18, TweenInfo.new(n11), { Volume = 0 }):Play()
    Debris:AddItem(u18, n11 + 0.05)
end

function t_1.Attach(u19: userdata, u20: userdata, n12: number?) -- line: 224
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)

    local HalloweenFx_Attachment = Instance.new("Attachment")
    HalloweenFx_Attachment.Name = "HalloweenFx"

    for _, descendant in u19:GetDescendants() do
        if not descendant:IsA("ParticleEmitter") then
            if descendant:IsA("Trail") then
                descendant:Clone().Parent = HalloweenFx_Attachment
            end
        else
            descendant:Clone().Parent = HalloweenFx_Attachment
        end
    end

    if n12 and n12 ~= 1 then
        HeadlessFxUtil_m.ScaleParticles(HalloweenFx_Attachment, n12)
    end

    HalloweenFx_Attachment.Parent = u20

    for _, child in HalloweenFx_Attachment:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child.Enabled = true
        end
    end

    return HalloweenFx_Attachment
end

return t_1
