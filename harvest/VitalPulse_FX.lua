-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Misc.VitalPulse_FX
-- Class: ModuleScript
-- bytes: 15289

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local _ = require(Modules.CameraShaker)
local _ = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local rng = Random.new()
local _ = require(ReplicatedStorage.Modules.Utility)
local _ = _G.GetModule("Effects")
local t = {}
VFX_m.init()

local _ = function(n1: number, n2: number, u1: userdata, u2: userdata) --[[ tweenScale ]] -- line: 25
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] RunService (copy)

    local v2 = 0
    local v3 = 0
    local v4 = nil

    local function onStep(n3: number) -- line: 30
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] u1 (copy)
        --  [3] Services_m (ref)
        --  [4] v3 (ref)
        --  [5] n1 (copy)
        --  [6] n2 (copy)
        --  [7] u2 (copy)
        --  [8] v4 (ref)

        v2 = math.min(v2 + n3, u1.Time)
        local v6 = Services_m.TweenService:GetValue(
            v2 / u1.Time,
            u1.EasingStyle,
            u1.EasingDirection
        )
        v3 = n1 + v6 * (n2 - n1)
        u2:ScaleTo(v3)

        if v2 == u1.Time then
            v4:Disconnect()
        end
    end

    v4 = RunService.Heartbeat:Connect(onStep)

    return v4
end

return function(s1: string, u3: userdata, n4: number, ...) -- line: 48
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] t (copy)
    --  [4] ForgeVFX_m (copy)
    --  [5] rng (copy)
    --  [6] RunService (copy)

    if (u3.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    if s1 == "Summon" then
        local v7 = Services_m.Maid.new
        local PrimaryPart = u3.PrimaryPart
        v7 = v7()
        local v8 = ReplicatedStorage.Effects.Skills.VitalPulse_FX.HealPool:Clone()
        Services_m.Debris(v8, 133)
        local BaseAttach = v8.Base.Trail.BaseAttach
        local v13 = v8:QueryDescendants("#OriginAttachment")[1]
        local v16 = v8:QueryDescendants("#RotatePart")[1]
        local v19 = v8:QueryDescendants("#SpecPartTwo")[1]
        t[n4 .. "HealFX"] = v8
        t[n4 .. "Maid"] = v7
        v8:PivotTo(CFrame.new(PrimaryPart.Position) * CFrame.new(0, -2.5, 0))
        v8:ScaleTo(0.1)

        for _, val in v8:QueryDescendants(".SummonFX"), nil, nil do
            if val:IsA("ParticleEmitter") then
                ForgeVFX_m.enable(val)
                local Transparency = val.Transparency
                val.Transparency = NumberSequence.new(1)
                _G.Tween(
                    val,
                    { 0.175, "Linear", Enum.EasingDirection.Out },
                    { Transparency = Transparency }
                )
            elseif val:IsA("PointLight") then
                local Brightness = val.Brightness
                val.Brightness = 0
                _G.Tween(
                    val,
                    { 0.175, "Linear", Enum.EasingDirection.Out },
                    { Brightness = Brightness }
                )
            elseif val:IsA("Beam") then
                local Transparency_1 = val.Transparency
                val.Transparency = NumberSequence.new(1)
                _G.Tween(
                    val,
                    { 0.175, "Linear", Enum.EasingDirection.Out },
                    { Transparency = Transparency_1 }
                )
            else
                local Transparency_2 = val.Transparency
                val.Transparency = 1
                _G.Tween(
                    val,
                    { 0.175, "Linear", Enum.EasingDirection.Out },
                    { Transparency = Transparency_2 }
                )
            end
        end

        t[n4 .. "Trail"] = {}
        local v37 = rng:NextInteger(4, 7)

        for index = 1, v37, 1 do
            local v39 = BaseAttach:Clone()
            Services_m.Debris(v39, 5)
            local TrailAttach1 = v39:FindFirstChild("TrailAttach_1")
            local TrailAttach2 = v39:FindFirstChild("TrailAttach_2")
            local v40 = rng:NextNumber(3, 6) / 10
            v39.Parent = v13
            v39.CFrame = v39.CFrame * (CFrame.new(0, rng:NextNumber(0.5, 3.5) / 10, 0) * CFrame.Angles(
                0,
                math.rad((rng:NextNumber(-180, 180))),
                0
            ))
            TrailAttach1.CFrame = TrailAttach1.CFrame * CFrame.new(v40, 0, 0)
            TrailAttach2.CFrame = TrailAttach2.CFrame * CFrame.new(v40, 0, 0)
            t[n4 .. "Trail"][index] = v39
        end

        v8.Parent = workspace.Effects
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Skills.VitalPulse["1"],
            v8:FindFirstChild("Base")
        )
        ForgeVFX_m.enable(v8.Base.Mesh)
        local New_2 = TweenInfo.new(0.175, Enum.EasingStyle.Linear)
        local v51 = 0
        local v52 = 0
        local v53 = nil
        local v54 = 0.1
        local v55 = 1
        v53 = RunService.Heartbeat:Connect(function(deltaTime: number) --[[ onStep ]] -- line: 30
            -- upvalues:
            --  [1] v51 (ref)
            --  [2] New_2 (copy)
            --  [3] Services_m (ref)
            --  [4] v52 (ref)
            --  [5] v54 (copy)
            --  [6] v55 (copy)
            --  [7] v8 (copy)
            --  [8] v53 (ref)

            v51 = math.min(v51 + deltaTime, New_2.Time)
            local v57 = Services_m.TweenService:GetValue(
                v51 / New_2.Time,
                New_2.EasingStyle,
                New_2.EasingDirection
            )
            v52 = v54 + v57 * (v55 - v54)
            v8:ScaleTo(v52)

            if v51 == New_2.Time then
                v53:Disconnect()
            end
        end)
        v7:GiveTask(v53)
        v7:GiveTask(RunService.Heartbeat:Connect(function(_) -- line: 120
            -- upvalues:
            --  [1] v16 (copy)
            --  [2] v13 (copy)
            --  [3] v19 (copy)

            local v60 = v16
            v60.CFrame = v60.CFrame * CFrame.Angles(0, 0.03490658503988659, 0)
            local v62 = v13
            v62.CFrame = v62.CFrame * CFrame.Angles(0, 0.05235987755982989, 0)
            local v64 = v19
            v64.CFrame = v64.CFrame * CFrame.Angles(0, 0.03490658503988659, 0)
        end))

        return
    end

    if s1 == "Enlarge" then
        local _ = u3.PrimaryPart
        local v69 = t[n4 .. "HealFX"]
        local v72 = v69:QueryDescendants("#OriginAttachment")[1]
        local Base_1 = v69.Base.Trail.BaseAttach
        local v73 = Services_m.Maid.new()
        task.delay(1, function() -- line: 134
            -- upvalues:
            --  [1] t (ref)
            --  [2] n4 (copy)

            t[n4 .. "Maid"]:Destroy()
            t[n4 .. "Maid"] = nil
        end)
        local v76 = ".BeamEdit, .WindEdit"

        for _, val_1 in v69:QueryDescendants(v76), nil, nil do
            if val_1:IsA("Attachment") then
                local Tween_2 = _G.Tween
                local t_5 = { CFrame = val_1:GetAttribute("Enlarge") }
                Tween_2(val_1, { 0.25, "Linear", Enum.EasingDirection.Out }, t_5)
            elseif val_1:IsA("Beam") then
                local Tween_3 = _G.Tween
                local t_7 = {
                    CurveSize0 = val_1:GetAttribute("Curve0"),
                    CurveSize1 = val_1:GetAttribute("Curve1"),
                    Width0 = val_1:GetAttribute("Width0"),
                    Width1 = val_1:GetAttribute("Width1")
                }
                Tween_3(val_1, { 0.25, "Linear", Enum.EasingDirection.Out }, t_7)
            end
        end

        v76 = "Decal, #RotatePart, PointLight"

        for _, val_2 in v69:QueryDescendants(v76), nil, nil do
            if val_2:IsA("Decal") then
                _G.Tween(val_2, { 0.25, "Linear", Enum.EasingDirection.Out }, { Transparency = 1 })
            elseif val_2.Name == "RotatePart" then
                _G.Tween(
                    val_2,
                    { 0.25, "Linear", Enum.EasingDirection.Out },
                    { Size = val_2.Size * 2 }
                )
            elseif val_2:IsA("PointLight") then
                _G.Tween(
                    val_2,
                    { 0.25, "Linear", Enum.EasingDirection.Out },
                    { Range = 17, Brightness = 2 }
                )
            end
        end

        v76 = 1

        for index_1 = v76, 5, 1 do
            local v95 = Base_1:Clone()
            Services_m.Debris(trail, 3)
            local TrailAttach1_1 = v95:FindFirstChild("TrailAttach_1")
            local TrailAttach2_1 = v95:FindFirstChild("TrailAttach_2")
            v95.Parent = v72
            local v101 = v95.CFrame
            v101 *= CFrame.new(0, rng:NextNumber(0.5, 3.5), 0) * CFrame.Angles(
                0,
                math.rad(index_1 * 72),
                0
            )
            v95.CFrame = v101
            local v103 = TrailAttach1_1.CFrame
            v103 *= CFrame.new(3, 0, 0)
            TrailAttach1_1.CFrame = v103
            local v104 = TrailAttach2_1.CFrame
            v104 *= CFrame.new(3, 0, 0)
            TrailAttach2_1.CFrame = v104

            for _, val_3 in v95:QueryDescendants("Trail, Attachment"), nil, nil do
                if val_3:IsA("Beam") then
                    local t_10 = { Transparency = NumberSequence.new(1) }
                    _G.Tween(val_3, { 0.25, "Linear", "Out" }, t_10)
                elseif val_3:IsA("Attachment") then
                    _G.Tween(val_3, { 0.25, "Linear", "Out" }, { Position = Vector3.new(14, 0, 0) })
                end
            end
        end

        for _, val_4 in t[n4 .. "Trail"], nil, nil do
            for _, val_5 in val_4:QueryDescendants("Trail"), nil, nil do
                local t_12 = { Transparency = NumberSequence.new(1) }
                _G.Tween(val_5, { 0.25, "Linear", "Out" }, t_12)
            end
        end

        v76 = "ParticleEmitter, Model"

        for _, val_6 in v69:QueryDescendants(v76), nil, nil do
            ForgeVFX_m.disable(val_6)
        end

        local v117 = ReplicatedStorage.Effects.Skills.VitalPulse_FX.LargeHealPool:Clone()
        Services_m.Debris(v117, 133)
        v117:PivotTo(v69:GetPivot())
        v117:ScaleTo(0.51)
        t[n4 .. "LargeHealFX"] = v117
        v117.Parent = workspace.Effects
        local New_4 = TweenInfo.new(0.25, Enum.EasingStyle.Linear)
        local v127 = 0
        local v128 = 0
        local v129 = nil
        local v130 = 0.51
        local v131 = 1

        local function onStep_2(n6: number) --[[ onStep ]] -- line: 30
            -- upvalues:
            --  [1] v127 (ref)
            --  [2] New_4 (copy)
            --  [3] Services_m (ref)
            --  [4] v128 (ref)
            --  [5] v130 (copy)
            --  [6] v131 (copy)
            --  [7] v117 (copy)
            --  [8] v129 (ref)

            v127 = math.min(v127 + n6, New_4.Time)
            local v133 = Services_m.TweenService:GetValue(
                v127 / New_4.Time,
                New_4.EasingStyle,
                New_4.EasingDirection
            )
            v128 = v130 + v133 * (v131 - v130)
            v117:ScaleTo(v128)

            if v127 == New_4.Time then
                v129:Disconnect()
            end
        end

        v129 = RunService.Heartbeat:Connect(onStep_2)
        v73:GiveTask(v129)

        return
    end

    if s1 == "Pulse" then
        local v141 = t[n4 .. "LargeHealFX"]
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Skills.VitalPulse["2"],
            v141:FindFirstChild("Base")
        )

        for _, val_7 in v141:QueryDescendants(".PulseFX"), nil, nil do
            ForgeVFX_m.emit(val_7)
        end

        return
    end

    if s1 == "CleanUp" then
        local v149 = ... or 3

        if t[n4 .. "HealFX"] then
            local v157 = t[n4 .. "HealFX"]
            local t_14, t_15, t_16, t_18
            local v164, v169, v172

            for _, val_8 in v157:QueryDescendants("Beam, ParticleEmitter, PointLight, Decal"), nil, nil do
                if not val_8:IsA("ParticleEmitter") then
                    if val_8:IsA("Beam") then
                        v164 = _G.Tween
                        t_14 = { 0.25, "Linear", Enum.EasingDirection.Out }
                        t_15 = { Transparency = NumberSequence.new(1) }
                        v164(val_8, t_14, t_15)
                    elseif val_8:IsA("Decal") then
                        v169 = _G.Tween
                        t_16 = { 0.25, "Linear", Enum.EasingDirection.Out }
                        v169(val_8, t_16, { Transparency = 1 })
                    else
                        v172 = _G.Tween
                        t_18 = { 0.25, "Linear", Enum.EasingDirection.Out }
                        v172(val_8, t_18, { Range = 0 })
                    end
                else
                    v164 = _G.Tween
                    t_14 = { 0.25, "Linear", Enum.EasingDirection.Out }
                    t_15 = { Transparency = NumberSequence.new(1) }
                    v164(val_8, t_14, t_15)

                    if val_8:IsA("Decal") then
                        v169 = _G.Tween
                        t_16 = { 0.25, "Linear", Enum.EasingDirection.Out }
                        v169(val_8, t_16, { Transparency = 1 })
                    else
                        v172 = _G.Tween
                        t_18 = { 0.25, "Linear", Enum.EasingDirection.Out }
                        v172(val_8, t_18, { Range = 0 })
                    end
                end
            end

            task.delay(v149, function() -- line: 235
                -- upvalues:
                --  [1] v157 (copy)
                --  [2] t (ref)
                --  [3] n4 (copy)

                if v157 and v157.Parent then
                    v157:Destroy()
                end

                t[n4 .. "HealFX"] = nil
            end)
        end

        if t[n4 .. "LargeHealFX"] then
            local v182 = t[n4 .. "LargeHealFX"]

            for _, val_9 in v182:QueryDescendants("ParticleEmitter"), nil, nil do
                local Tween_4 = _G.Tween
                Tween_4(
                    val_9,
                    { 0.25, "Linear", Enum.EasingDirection.Out },
                    { Transparency = NumberSequence.new(1) }
                )
            end

            task.delay(v149, function() -- line: 250
                -- upvalues:
                --  [1] v182 (copy)
                --  [2] t (ref)
                --  [3] n4 (copy)

                if v182 and v182.Parent then
                    v182:Destroy()
                end

                t[n4 .. "LargeHealFX"] = nil
            end)
        end

        task.delay(v149, function() -- line: 258
            -- upvalues:
            --  [1] t (ref)
            --  [2] n4 (copy)

            if t[n4 .. "Maid"] then
                t[n4 .. "Maid"]:Destroy()
                t[n4 .. "Maid"] = nil
            end
        end)
    end
end
