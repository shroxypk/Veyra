-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Headless.Headless_PumpkinExplosion_Fx
-- Class: ModuleScript
-- bytes: 15886

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local HeadlessFxUtil_m = require(script.Parent.HeadlessFxUtil)
local t = {}

local _ = function(u1: userdata) --[[ clear ]] -- line: 42
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)

    local v1 = t[u1]
    t[u1] = nil

    if v1 then
        v1.Pumpkin:Destroy()
        HeadlessFxUtil_m.Stop(v1.Charge)
    end
end

local function fade(u2: userdata, n1: number) -- line: 51
    -- upvalues:
    --  [1] TweenService (copy)

    TweenService:Create(
        u2,
        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Transparency = n1 }
    ):Play()
end

local _ = function(u3: userdata) --[[ glowOf ]] -- line: 60
    local SurfaceAppearance = u3:FindFirstChildOfClass("SurfaceAppearance")
    local Success, Result = pcall(function() -- line: 62
        -- upvalues:
        --  [1] SurfaceAppearance (copy)

        return SurfaceAppearance and SurfaceAppearance.EmissiveStrength
    end)

    return Success and Result or nil
end

local _ = function(u4: userdata, n2: number) --[[ setGlow ]] -- line: 68
    local SurfaceAppearance_1 = u4:FindFirstChildOfClass("SurfaceAppearance")

    if SurfaceAppearance_1 then
        pcall(function() -- line: 71
            -- upvalues:
            --  [1] SurfaceAppearance_1 (copy)
            --  [2] n2 (copy)

            SurfaceAppearance_1.EmissiveStrength = n2
        end)
    end
end

local function showFlail(u5: userdata, b1: boolean) -- line: 79
    -- upvalues:
    --  [1] fade (copy)

    local Cube001 = u5:FindFirstChild("Cube.001")
    local Success_1

    if Cube001 then
        if not Cube001:IsA("BasePart") then
            return
        end

        if b1 then
            local HeadlessFxFlailTransparency = Cube001:GetAttribute("HeadlessFxFlailTransparency")

            if HeadlessFxFlailTransparency ~= nil then
                Cube001:SetAttribute("HeadlessFxFlailTransparency", nil)
                fade(Cube001, HeadlessFxFlailTransparency)
                task.delay(0.15, function() -- line: 89
                    -- upvalues:
                    --  [1] Cube001 (copy)

                    local HeadlessFxFlailGlow = Cube001:GetAttribute("HeadlessFxFlailGlow")

                    if HeadlessFxFlailGlow ~= nil and Cube001:GetAttribute(
                        "HeadlessFxFlailTransparency"
                    ) == nil then
                        Cube001:SetAttribute("HeadlessFxFlailGlow", nil)
                        local SurfaceAppearance_2 = Cube001:FindFirstChildOfClass(
                            "SurfaceAppearance"
                        )

                        if SurfaceAppearance_2 then
                            pcall(function() -- line: 71
                                -- upvalues:
                                --  [1] SurfaceAppearance_2 (copy)
                                --  [2] HeadlessFxFlailGlow (copy)

                                SurfaceAppearance_2.EmissiveStrength = HeadlessFxFlailGlow
                            end)
                        end
                    end
                end)

                return
            end
        else
            if Cube001:GetAttribute("HeadlessFxFlailTransparency") == nil then
                Cube001:SetAttribute("HeadlessFxFlailTransparency", Cube001.Transparency)
            end

            if Cube001:GetAttribute("HeadlessFxFlailGlow") == nil then
                local SurfaceAppearance_3 = Cube001:FindFirstChildOfClass("SurfaceAppearance")
                local Result_1
                Success_1, Result_1 = pcall(function() -- line: 62
                    -- upvalues:
                    --  [1] SurfaceAppearance_3 (copy)

                    return SurfaceAppearance_3 and SurfaceAppearance_3.EmissiveStrength
                end)
                local v6 = Success_1 and Result_1 or nil

                if v6 then
                    Cube001:SetAttribute("HeadlessFxFlailGlow", v6)
                end
            end

            local SurfaceAppearance_6 = Cube001:FindFirstChildOfClass("SurfaceAppearance")

            if SurfaceAppearance_6 then
                local v8 = 0
                pcall(function() -- line: 71
                    -- upvalues:
                    --  [1] SurfaceAppearance_6 (copy)
                    --  [2] v8 (copy)

                    SurfaceAppearance_6.EmissiveStrength = v8
                end)
            end

            fade(Cube001, 1)
        end

        return
    else
        return
    end
end

local Charge = script.Charge

local function makeCharge() -- line: 113
    -- upvalues:
    --  [1] Charge (copy)

    local v13 = Charge:Clone()
    local t_2 = {}

    for _, descendant in v13:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            local t_3 = { Size = descendant.Size, Speed = descendant.Speed }
            t_2[descendant] = t_3
        end
    end

    local function resize(n3: number) -- line: 121
        -- upvalues:
        --  [1] t_2 (copy)

        local v14 = n3 / 4.65 * 0.55

        for key_1, val in t_2 do
            local t_4 = {}

            for _, val_1 in val.Size.Keypoints do
                table.insert(
                    t_4,
                    NumberSequenceKeypoint.new(val_1.Time, val_1.Value * v14, val_1.Envelope * v14)
                )
            end

            key_1.Size = NumberSequence.new(t_4)
            key_1.Speed = NumberRange.new(val.Speed.Min * v14, val.Speed.Max * v14)
        end
    end

    v13.Parent = workspace.Terrain

    return v13, resize
end

local Assets = script.Assets

return function(u6: userdata, s1: string, vec1: Vector3) -- line: 136
    -- upvalues:
    --  [1] fade (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] t (copy)
    --  [4] Assets (copy)
    --  [5] makeCharge (copy)
    --  [6] showFlail (copy)
    --  [7] TweenService (copy)
    --  [8] RunService (copy)
    --  [9] Debris (copy)

    local v51

    if s1 == "Catch" then
        local Cube001_1 = u6:FindFirstChild("Cube.001")

        if Cube001_1 then
            if not Cube001_1:IsA("BasePart") then
                return
            else
                local HeadlessFxFlailTransparency_2 = Cube001_1:GetAttribute(
                    "HeadlessFxFlailTransparency"
                )

                if HeadlessFxFlailTransparency_2 ~= nil then
                    Cube001_1:SetAttribute("HeadlessFxFlailTransparency", nil)
                    fade(Cube001_1, HeadlessFxFlailTransparency_2)
                    task.delay(0.15, function() -- line: 89
                        -- upvalues:
                        --  [1] Cube001_1 (copy)

                        local HeadlessFxFlailGlow_2 = Cube001_1:GetAttribute("HeadlessFxFlailGlow")

                        if HeadlessFxFlailGlow_2 ~= nil and Cube001_1:GetAttribute(
                            "HeadlessFxFlailTransparency"
                        ) == nil then
                            Cube001_1:SetAttribute("HeadlessFxFlailGlow", nil)
                            local SurfaceAppearance_7 = Cube001_1:FindFirstChildOfClass(
                                "SurfaceAppearance"
                            )

                            if SurfaceAppearance_7 then
                                pcall(function() -- line: 71
                                    -- upvalues:
                                    --  [1] SurfaceAppearance_7 (copy)
                                    --  [2] HeadlessFxFlailGlow_2 (copy)

                                    SurfaceAppearance_7.EmissiveStrength = HeadlessFxFlailGlow_2
                                end)
                            end
                        end
                    end)
                end
            end
        end

        return
    end

    if not HeadlessFxUtil_m.Near(vec1) then
        return
    end

    if s1 == "Cast" then
        local HumanoidRootPart = u6:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart then
            HeadlessFxUtil_m.Sound("PumpkinExplosionThrow", HumanoidRootPart)

            return
        end
    else
        if s1 == "Land" then
            local v25 = t[u6]
            t[u6] = nil

            if v25 then
                v25.Pumpkin:Destroy()
                HeadlessFxUtil_m.Stop(v25.Charge)
            end

            local v27 = Assets.PumpkinModel:Clone()
            local BasePart = v27:FindFirstChildWhichIsA("BasePart")
            v27.PrimaryPart = BasePart
            BasePart.PivotOffset = CFrame.identity
            BasePart.Anchored = true
            BasePart.CanCollide = false
            BasePart.CanQuery = false
            BasePart.CanTouch = false
            local v32 = HeadlessFxUtil_m.Feet(u6)
            local v33 = v32
            local v36, v37

            if v33 then
                local v34 = vec1.X - v32.X
                v36 = vec1.Z
                v37 = v32.Z
                v33 = Vector3.new(v34, 0, v36 - v37)
            end

            local v39 = v33 and (v33.Magnitude > 0.1 and CFrame.lookAt(Vector3.new(0, 0, 0), v33).Rotation) or CFrame.identity
            local v40 = v27:GetScale()
            local Size = BasePart.Size.X
            v36 = "Cube.001"
            local v41 = u6:FindFirstChild(v36)
            v37 = "Pumpkin"
            local v43 = u6:FindFirstChild(v37, true)
            v36 = 1.5
            v37 = nil

            if v41 then
                if v41:IsA("BasePart") and v43 then
                    if v43:IsA("Bone") then
                        v37 = (v43.TransformedWorldCFrame * CFrame.new(0, v41.Size.Y * 0.1135, 0)).Position
                        v36 = math.max(v41.Size.X, v41.Size.Z) / Size
                    end
                end
            end

            local NumberValue = Instance.new("NumberValue")
            NumberValue.Value = v36
            local v50 = makeCharge
            v50, v51 = v50()

            local function place() -- line: 183
                -- upvalues:
                --  [1] v27 (copy)
                --  [2] v40 (copy)
                --  [3] NumberValue (copy)
                --  [4] vec1 (copy)
                --  [5] BasePart (copy)
                --  [6] v37 (ref)
                --  [7] v36 (ref)
                --  [8] v39 (copy)
                --  [9] v50 (copy)
                --  [10] v51 (copy)

                v27:ScaleTo(v40 * NumberValue.Value)
                local v54 = vec1 + Vector3.new(0, BasePart.Size.Y / 2, 0)
                local v55 = if v37 then v37:Lerp(
                    v54,
                    (math.clamp((NumberValue.Value - v36) / (5 - v36), 0, 1))
                ) else v54
                v27:PivotTo(CFrame.new(v55) * v39)
                v50.WorldCFrame = BasePart.CFrame
                v51((math.max(BasePart.Size.X, BasePart.Size.Z)))
            end

            place()
            local t_5 = {}

            for _, val_2 in v27:GetDescendants(), nil, nil do
                if val_2:IsA("BasePart") then
                    local Transparency = val_2.Transparency
                    local SurfaceAppearance_8 = val_2:FindFirstChildOfClass("SurfaceAppearance")
                    local Success_2, Result_3 = pcall(function() -- line: 62
                        -- upvalues:
                        --  [1] SurfaceAppearance_8 (copy)

                        return SurfaceAppearance_8 and SurfaceAppearance_8.EmissiveStrength
                    end)
                    local v62 = Success_2 and Result_3 or nil
                    table.insert(t_5, { val_2, Transparency, v62 })
                    val_2.Transparency = 1
                    local SurfaceAppearance_9 = val_2:FindFirstChildOfClass("SurfaceAppearance")

                    if SurfaceAppearance_9 then
                        local v64 = 0
                        pcall(function() -- line: 71
                            -- upvalues:
                            --  [1] SurfaceAppearance_9 (copy)
                            --  [2] v64 (copy)

                            SurfaceAppearance_9.EmissiveStrength = v64
                        end)
                    end
                end
            end

            local v65
            v27.Parent, v65 = workspace.Effects, t_5

            for _, val_3 in v65 do
                fade(val_3[1], val_3[2])
            end

            showFlail(u6, false)
            task.delay(0.15, function() -- line: 213
                -- upvalues:
                --  [1] t_5 (copy)
                --  [2] TweenService (ref)

                local v69

                for _, val_4 in t_5 do
                    local v67 = val_4[1]
                    local v68 = val_4[3]
                    v69 = v68

                    if v69 then
                        v69 = v67.Parent

                        if v69 then
                            v69 = v67:FindFirstChildOfClass("SurfaceAppearance")
                        end
                    end

                    if v69 then
                        pcall(function() -- line: 218
                            -- upvalues:
                            --  [1] TweenService (ref)
                            --  [2] v69 (copy)
                            --  [3] v68 (copy)

                            TweenService:Create(
                                v69,
                                TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                                { EmissiveStrength = v68 * 3 }
                            ):Play()
                        end)
                    end
                end
            end)
            HeadlessFxUtil_m.Enable(v50)
            local v73 = nil
            v73 = RunService.RenderStepped:Connect(function() -- line: 229
                -- upvalues:
                --  [1] v27 (copy)
                --  [2] v73 (ref)
                --  [3] t (ref)
                --  [4] u6 (copy)
                --  [5] v50 (copy)
                --  [6] HeadlessFxUtil_m (ref)
                --  [7] place (copy)

                if not v27.Parent then
                    v73:Disconnect()

                    if t[u6] and t[u6].Pumpkin == v27 then
                        t[u6] = nil
                    end

                    if v50.Parent then
                        HeadlessFxUtil_m.Stop(v50)
                    end

                    return
                end

                place()
            end)
            TweenService:Create(
                NumberValue,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                { Value = 5 }
            ):Play()
            Debris:AddItem(NumberValue, 2.3)
            Debris:AddItem(v27, 2.3)
            t[u6] = { Pumpkin = v27, Charge = v50 }
            HeadlessFxUtil_m.Shake(
                vec1,
                2,
                8,
                0.3,
                120
            )
            HeadlessFxUtil_m.Sound("PumpkinExplosionInflate", BasePart)

            return
        end

        if s1 == "Explode" then
            local v75 = t[u6]
            t[u6] = nil

            if v75 then
                v75.Pumpkin:Destroy()
                HeadlessFxUtil_m.Stop(v75.Charge)
            end

            HeadlessFxUtil_m.PlaceScaled(
                Assets.Explosion,
                CFrame.new(vec1 + Vector3.new(0, 2, 0)),
                3
            )
            HeadlessFxUtil_m.PlaceScaled(Assets.Smoke, CFrame.new(vec1 + Vector3.new(0, 2, 0)), 3)
            HeadlessFxUtil_m.Shake(
                vec1,
                7,
                12,
                1,
                220
            )
            HeadlessFxUtil_m.Sound("PumpkinExplosionExplode", vec1)
        end
    end
end
