-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Halloween.ManaLeech_Fx
-- Class: ModuleScript
-- bytes: 19737

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HalloweenFxUtil_m = require(script.Parent.HalloweenFxUtil)
local Assets = script.Assets
local Sounds = script.Sounds
local t = { VolleyCast = 0.2, ClawSwipe = 0.15 }
local color = Color3.fromRGB(170, 10, 30)
local t_1 = { 0.5, 0.15 }
local t_2 = {}
local t_3 = {}

local _ = function(s1: string, arg1: any) --[[ sound ]] -- line: 43
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Sounds (copy)
    --  [3] t (copy)

    return HalloweenFxUtil_m.Sound(Sounds:FindFirstChild(s1), arg1, t[s1])
end

local _ = function(u1: userdata, n1: number?) --[[ stopWindup ]] -- line: 47
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] t_3 (copy)

    HalloweenFxUtil_m.StopSound(t_3[u1], n1)
    t_3[u1] = nil
end

local v2 = Assets.BatBlink:Clone()

for _, descendant in v2:GetDescendants() do
    if descendant:IsA("ParticleEmitter") then
        local EmitDuration = descendant:GetAttribute("EmitDuration")

        if typeof(EmitDuration) == "number" then
            descendant:SetAttribute("EmitDuration", EmitDuration * 0.3)
        end

        descendant.Lifetime = NumberRange.new(
            descendant.Lifetime.Min * 0.5,
            descendant.Lifetime.Max * 0.5
        )
    end
end

local t_4 = setmetatable({}, { __mode = "k" })

local function flyOrb(
    vec1: Vector3,
    vec2: Vector3,
    n2: number,
    n3: number,
    n4: number?,
    u2: userdata?
) -- line: 66
    -- upvalues:
    --  [1] Assets (copy)
    --  [2] HalloweenFxUtil_m (copy)
    --  [3] RunService (copy)

    local v4 = Assets.Orb:GetAttribute("Offset") or CFrame.identity
    local v5 = CFrame.lookAt(Vector3.new(0, 0, 0), vec2)
    local v6 = v5 * v4.Rotation
    v5 = u2

    if v5 then
        v5:SetAttribute("Hovering", nil)
        v5.CFrame = CFrame.new(vec1) * v6
    else
        v5 = HalloweenFxUtil_m.Spawn(Assets.Orb, CFrame.new(vec1) * v6)

        if n4 and n4 ~= 1 then
            HalloweenFxUtil_m.ScaleParticles(v5, n4)
        end

        HalloweenFxUtil_m.Enable(v5, true)
    end

    local v7 = nil
    local clock = os.clock()
    v7 = RunService.RenderStepped:Connect(function() -- line: 83
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] v7 (ref)
        --  [3] clock (copy)
        --  [4] n2 (copy)
        --  [5] n3 (copy)
        --  [6] vec1 (copy)
        --  [7] vec2 (copy)
        --  [8] v6 (copy)
        --  [9] HalloweenFxUtil_m (ref)

        if v5.Parent then
            if v5:GetAttribute("Stopped") then
                v7:Disconnect()

                return
            end

            local v9 = math.min((os.clock() - clock) * n2, n3)
            v5.CFrame = CFrame.new(vec1 + vec2 * v9) * v6

            if v9 >= n3 then
                v7:Disconnect()
                v5:SetAttribute("Stopped", true)
                HalloweenFxUtil_m.StopSound(v5:FindFirstChild("OrbFlight"))
                HalloweenFxUtil_m.Stop(v5)
            end

            return
        else
            v7:Disconnect()

            return
        end
    end)

    return v5
end

local function stopOrb(u3: userdata?, vec3: Vector3?) -- line: 100
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)

    if not u3 or not u3.Parent then
        return
    end

    u3:SetAttribute("Stopped", true)

    if vec3 then
        u3.CFrame = CFrame.new(vec3) * u3.CFrame.Rotation
    end

    HalloweenFxUtil_m.StopSound(u3:FindFirstChild("OrbFlight"), 0.1)
    HalloweenFxUtil_m.Stop(u3)
end

local function hoverOrb(u4: userdata, vec4: Vector3) -- line: 113
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Assets (copy)
    --  [3] RunService (copy)

    local HumanoidRootPart = u4:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart then
        if not HalloweenFxUtil_m.Near(HumanoidRootPart.Position) then
            return nil
        end

        local v14 = HalloweenFxUtil_m.Spawn(Assets.Orb, HumanoidRootPart.CFrame * CFrame.new(vec4))
        HalloweenFxUtil_m.ScaleParticles(v14, 0.85)
        HalloweenFxUtil_m.Enable(v14, true)
        v14:SetAttribute("Hovering", true)
        local v17 = nil
        v17 = RunService.RenderStepped:Connect(function() -- line: 123
            -- upvalues:
            --  [1] v14 (copy)
            --  [2] HumanoidRootPart (copy)
            --  [3] v17 (ref)
            --  [4] vec4 (copy)

            if v14.Parent then
                if v14:GetAttribute("Hovering") then
                    if v14:GetAttribute("Stopped") or not HumanoidRootPart.Parent then
                        v17:Disconnect()

                        return
                    end

                    v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(vec4)

                    return
                end

                v17:Disconnect()

                return
            else
                v17:Disconnect()

                return
            end
        end)

        return v14
    else
        return nil
    end
end

local _ = function(u5: userdata) --[[ heartOrb ]] -- line: 135
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Assets (copy)
    --  [3] Sounds (copy)

    if not u5:FindFirstChild("HalloweenFx") and HalloweenFxUtil_m.Near(u5.Position) then
        HalloweenFxUtil_m.Attach(Assets.Orb, u5, 4)
        HalloweenFxUtil_m.LoopSound(Sounds.HeartLoop, u5)
    end
end

local function heartFx(u6: userdata, s2: string) -- line: 142
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Assets (copy)
    --  [3] Sounds (copy)
    --  [4] color (copy)
    --  [5] t (copy)

    local HumanoidRootPart_1 = u6:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart_1 then
        return
    end

    if s2 ~= "Death" and s2 ~= "Despawn" and not HumanoidRootPart_1:FindFirstChild("HalloweenFx") and HalloweenFxUtil_m.Near(
        HumanoidRootPart_1.Position
    ) then
        HalloweenFxUtil_m.Attach(Assets.Orb, HumanoidRootPart_1, 4)
        HalloweenFxUtil_m.LoopSound(Sounds.HeartLoop, HumanoidRootPart_1)
    end

    if s2 == "Spawn" then
        if not HalloweenFxUtil_m.Near(HumanoidRootPart_1.Position) then
            return
        end

        HalloweenFxUtil_m.PlaceAtPoint(Assets.Burst, HumanoidRootPart_1.Position, nil, 0.6)
        HalloweenFxUtil_m.Shake(
            HumanoidRootPart_1.Position,
            2,
            10,
            0.3,
            60
        )

        return
    else
        if s2 == "HeartHit" then
            HalloweenFxUtil_m.PlaceAtPoint(Assets.Burst, HumanoidRootPart_1.Position, nil, 0.3)
            HalloweenFxUtil_m.Tint(u6, Color3.new(1, 1, 1), 0.6, 0.12)

            return
        end

        if s2 == "HeartShoot" then
            HalloweenFxUtil_m.Tint(u6, color, 0.5, 0.2)
            local _ = HalloweenFxUtil_m.Sound(
                Sounds:FindFirstChild("VolleyCast"),
                HumanoidRootPart_1,
                t.VolleyCast
            )

            return
        end

        if s2 == "Death" or s2 == "Despawn" then
            HalloweenFxUtil_m.StopSound(HumanoidRootPart_1:FindFirstChild("HeartLoop"), 0.1)
            local Position_1 = HumanoidRootPart_1.Position
            local _ = HalloweenFxUtil_m.Sound(
                Sounds:FindFirstChild("HeartBreak"),
                Position_1,
                t.HeartBreak
            )
            HalloweenFxUtil_m.Stop(HumanoidRootPart_1:FindFirstChild("HalloweenFx"))
            HalloweenFxUtil_m.PlaceAtPoint(
                Assets.Burst,
                HumanoidRootPart_1.Position,
                nil,
                if s2 == "Death" then 1 else 0.5
            )

            if s2 == "Death" then
                HalloweenFxUtil_m.Shake(
                    HumanoidRootPart_1.Position,
                    4,
                    12,
                    0.4,
                    60
                )
            end
        end

        return
    end
end

local _ = function(u7: userdata) --[[ torso ]] -- line: 174
    return u7:FindFirstChild("HumanoidRootPart") or u7.PrimaryPart
end

local function setMark(u8: userdata, b1: boolean) -- line: 178
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] HalloweenFxUtil_m (copy)
    --  [3] Assets (copy)
    --  [4] color (copy)
    --  [5] Sounds (copy)

    local v36 = t_4[u8]

    if v36 then
        t_4[u8] = nil
        HalloweenFxUtil_m.StopSound(v36.Sound, 0.5)
        HalloweenFxUtil_m.Stop(v36.Attachment)
        HalloweenFxUtil_m.RemoveTint(v36.Highlight)
    end

    if not b1 then
        return
    end

    local Head = u8:FindFirstChild("Head")

    if Head then
        if not HalloweenFxUtil_m.Near(Head.Position) then
            return
        end

        local v37 = HalloweenFxUtil_m.Attach(Assets.Orb, Head, 0.45)
        v37.Position = Vector3.new(0, 2, 0)
        t_4[u8] = {
            Attachment = v37,
            Highlight = HalloweenFxUtil_m.Tint(u8, color, 0.75),
            Sound = HalloweenFxUtil_m.LoopSound(Sounds.MarkLoop, Head)
        }

        return
    else
        return
    end
end

return function(u9: userdata, s3: string, ...) -- line: 202
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] HalloweenFxUtil_m (copy)
    --  [3] hoverOrb (copy)
    --  [4] Sounds (copy)
    --  [5] t (copy)
    --  [6] flyOrb (copy)
    --  [7] stopOrb (copy)
    --  [8] Assets (copy)
    --  [9] setMark (copy)
    --  [10] color (copy)
    --  [11] Players (copy)
    --  [12] heartFx (copy)
    --  [13] t_3 (copy)
    --  [14] t_1 (copy)
    --  [15] v2 (copy)

    local HumanoidRootPart_2, OrbSpawn
    local v40, v44

    if s3 == "OrbSummon" then
        local v41
        v40, v41 = ...

        for key_1, val in v40 do
            local v42 = t_2[val]

            if v42 and v42.Parent then
                v42:SetAttribute("Stopped", true)
                HalloweenFxUtil_m.StopSound(v42:FindFirstChild("OrbFlight"), 0.1)
                HalloweenFxUtil_m.Stop(v42)
            end

            t_2[val] = hoverOrb(u9, v41[key_1])
        end

        HumanoidRootPart_2 = u9:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart_2 then
            local Sound_3 = HalloweenFxUtil_m.Sound
            OrbSpawn = Sounds:FindFirstChild("OrbSpawn")
            v44 = Sound_3(OrbSpawn, HumanoidRootPart_2, t.OrbSpawn)
        end

        return
    end

    if s3 == "Orb" then
        local v45
        v40, HumanoidRootPart_2, v44, OrbSpawn, v45 = ...
        local v46 = t_2[v40]
        local v47, v48

        if v46 then
            if v46.Parent then
                if v46:GetAttribute("Hovering") then
                    v47 = flyOrb(
                        HumanoidRootPart_2,
                        v44,
                        OrbSpawn,
                        v45,
                        nil,
                        v46
                    )
                else
                    if v46 and v46.Parent then
                        v46:SetAttribute("Stopped", true)
                        HalloweenFxUtil_m.StopSound(v46:FindFirstChild("OrbFlight"), 0.1)
                        HalloweenFxUtil_m.Stop(v46)
                    end

                    v48 = HalloweenFxUtil_m.Near(HumanoidRootPart_2) and flyOrb(
                        HumanoidRootPart_2,
                        v44,
                        OrbSpawn,
                        v45
                    ) or nil
                    v47 = v48
                end
            else
                if v46 and v46.Parent then
                    v46:SetAttribute("Stopped", true)
                    HalloweenFxUtil_m.StopSound(v46:FindFirstChild("OrbFlight"), 0.1)
                    HalloweenFxUtil_m.Stop(v46)
                end

                v48 = HalloweenFxUtil_m.Near(HumanoidRootPart_2) and flyOrb(
                    HumanoidRootPart_2,
                    v44,
                    OrbSpawn,
                    v45
                ) or nil
                v47 = v48
            end
        else
            if v46 and v46.Parent then
                v46:SetAttribute("Stopped", true)
                HalloweenFxUtil_m.StopSound(v46:FindFirstChild("OrbFlight"), 0.1)
                HalloweenFxUtil_m.Stop(v46)
            end

            v48 = HalloweenFxUtil_m.Near(HumanoidRootPart_2) and flyOrb(
                HumanoidRootPart_2,
                v44,
                OrbSpawn,
                v45
            ) or nil
            v47 = v48
        end

        t_2[v40] = v47

        if v47 then
            HalloweenFxUtil_m.LoopSound(Sounds.OrbFlight, v47)
        end

        return
    end

    if s3 == "OrbHit" then
        v40, HumanoidRootPart_2 = ...
        stopOrb(t_2[v40], HumanoidRootPart_2)
        t_2[v40] = nil
        HalloweenFxUtil_m.PlaceAtPoint(Assets.Burst, HumanoidRootPart_2, nil, 0.35)
        local _ = HalloweenFxUtil_m.Sound(
            Sounds:FindFirstChild("OrbImpact"),
            HumanoidRootPart_2,
            t.OrbImpact
        )

        return
    end

    if s3 == "Mark" then
        v40, HumanoidRootPart_2 = ...
        setMark(v40, HumanoidRootPart_2)

        return
    end

    local v50, v51

    if s3 == "MarkWarn" then
        v50 = ...
        v51 = v50:FindFirstChild("HumanoidRootPart") or v50.PrimaryPart

        if v51 then
            if not HalloweenFxUtil_m.Near(v51.Position) then
                return
            end

            HalloweenFxUtil_m.Tint(v50, color, 0.2, 1.2)

            if v50 == Players.LocalPlayer.Character then
                HalloweenFxUtil_m.Shake(v51.Position, 1.5, 12, 0.6)
            end

            return
        else
            return
        end
    elseif s3 == "Internal" then
        v50, v51 = ...
        local v52 = v50:FindFirstChild("HumanoidRootPart") or v50.PrimaryPart

        if not v52 then
            return
        end

        local v53 = if not v51 then 0.25 else 0.6
        HalloweenFxUtil_m.PlaceAtPoint(Assets.Burst, v52.Position, nil, v53)

        if v51 then
            HalloweenFxUtil_m.Tint(v50, color, 0.1, 0.4)

            if v50 == Players.LocalPlayer.Character then
                HalloweenFxUtil_m.Shake(v52.Position, 4, 12, 0.5)
            end
        end

        return
    else
        if u9:GetAttribute("HalloweenEnemy") == "BloodHeart" then
            heartFx(u9, s3)

            return
        end

        if s3 == "Death" or s3 == "Despawn" then
            HalloweenFxUtil_m.StopSound(t_3[u9], 0.1)
            t_3[u9] = nil
        end

        local v54 = HalloweenFxUtil_m.Root(u9)

        if not v54 then
            return
        end

        local HumanoidRootPart_3 = u9.HumanoidRootPart

        if s3 == "VolleyCast" then
            local _ = HalloweenFxUtil_m.Sound(
                Sounds:FindFirstChild("VolleyCast"),
                HumanoidRootPart_3,
                t.VolleyCast
            )

            return
        end

        if s3 == "ClawLunge" then
            local _ = HalloweenFxUtil_m.Sound(
                Sounds:FindFirstChild("ClawLunge"),
                HumanoidRootPart_3,
                t.ClawLunge
            )

            return
        end

        if s3 == "Claw" then
            HalloweenFxUtil_m.Place(Assets.Slash, u9)
            local _ = HalloweenFxUtil_m.Sound(
                Sounds:FindFirstChild("ClawSwipe"),
                HumanoidRootPart_3,
                t.ClawSwipe
            )

            return
        end

        if s3 == "Drain" then
            local v58 = ...
            local v59 = v58:FindFirstChild("HumanoidRootPart") or v58.PrimaryPart

            if not v59 then
                return
            end

            local v60 = v54.Position - v59.Position

            if v60.Magnitude > 0.5 then
                local v61 = flyOrb(
                    v59.Position,
                    v60.Unit,
                    v60.Magnitude / 0.35,
                    v60.Magnitude,
                    0.6
                )
                local v62 = u9:FindFirstChild("Torso") or (u9:FindFirstChild("UpperTorso") or u9:FindFirstChild(
                    "HumanoidRootPart"
                ))

                if v62 and v61:IsA("BasePart") then
                    local DrainBeam_Attachment = Instance.new("Attachment")
                    DrainBeam_Attachment.Name = "DrainBeam"
                    DrainBeam_Attachment.Parent = v62
                    local Attachment_1 = Instance.new("Attachment")
                    Attachment_1.Name = "DrainBeam"
                    Attachment_1.Parent = v61
                    local Beam = Instance.new("Beam")
                    Beam.Attachment0 = DrainBeam_Attachment
                    Beam.Attachment1 = Attachment_1
                    Beam.Color = ColorSequence.new(color)
                    Beam.LightEmission = 1
                    Beam.LightInfluence = 0
                    Beam.FaceCamera = true
                    Beam.Segments = 1
                    Beam.Width0 = t_1[1]
                    Beam.Width1 = t_1[2]
                    Beam.Transparency = NumberSequence.new(0.15)
                    Beam.Parent = DrainBeam_Attachment
                    task.delay(0.35, function() -- line: 321
                        -- upvalues:
                        --  [1] Beam (copy)
                        --  [2] DrainBeam_Attachment (copy)
                        --  [3] Attachment_1 (copy)

                        for index = 1, 5 do
                            Beam.Transparency = NumberSequence.new(index * 0.85 / 5 + 0.15)
                            task.wait(0.05)
                        end

                        DrainBeam_Attachment:Destroy()
                        Attachment_1:Destroy()
                    end)
                end
            end

            HalloweenFxUtil_m.Tint(v58, Color3.fromRGB(80, 140, 255), 0.4, 0.4)

            return
        else
            if s3 == "Blink" or s3 == "BlinkAppear" or s3 == "Spawn" or s3 == "Despawn" or s3 == "Death" then
                HalloweenFxUtil_m.Place(v2, u9)

                if s3 == "BlinkAppear" or s3 == "Spawn" then
                    local _ = HalloweenFxUtil_m.Sound(
                        Sounds:FindFirstChild("Reappear"),
                        HumanoidRootPart_3,
                        t.Reappear
                    )

                    return
                end

                local Position_3 = HumanoidRootPart_3.Position
                local _ = HalloweenFxUtil_m.Sound(
                    Sounds:FindFirstChild("Vanish"),
                    Position_3,
                    t.Vanish
                )

                return
            end

            if s3 == "Burst" then
                HalloweenFxUtil_m.Place(Assets.Burst, u9)
                HalloweenFxUtil_m.Shake(
                    v54.Position,
                    3,
                    10,
                    0.4,
                    80
                )
                HalloweenFxUtil_m.StopSound(t_3[u9], 0.1)
                t_3[u9] = nil
                local _ = HalloweenFxUtil_m.Sound(
                    Sounds:FindFirstChild("BurstExplosion"),
                    HumanoidRootPart_3,
                    t.BurstExplosion
                )

                return
            end

            if s3 == "Unparryable" then
                HalloweenFxUtil_m.Unparryable(u9)
                HalloweenFxUtil_m.StopSound(t_3[u9], nil)
                t_3[u9] = nil
                t_3[u9] = HalloweenFxUtil_m.Sound(
                    Sounds:FindFirstChild("BurstWindup"),
                    HumanoidRootPart_3,
                    t.BurstWindup
                )
            end

            return
        end
    end
end
