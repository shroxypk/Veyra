-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Utility
-- Class: ModuleScript
-- bytes: 11422

local _ = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local _ = game:GetService("RunService")
local t = {
    EmitParticles = function(arg1, arg2, arg3, arg4) --[[ EmitParticles ]] -- line: 8
        -- upvalues:
        --  [1] TweenService (copy)

        arg2 = arg2 or 2
        arg4 = if not arg4 then false else true
        arg3 = arg3 or 0.25

        for _, val in next, arg1:GetDescendants() do
            if val:IsA("ParticleEmitter") then
                if val:GetAttribute("EmitDelay") then
                    task.delay(val:GetAttribute("EmitDelay"), function() -- line: 16
                        -- upvalues:
                        --  [1] val (copy)

                        val:Emit(val:GetAttribute("EmitCount"))
                    end)
                else
                    val:Emit(val:GetAttribute("EmitCount"))
                end
            elseif val:IsA("PointLight") and arg4 == false then
                TweenService:Create(
                    val,
                    TweenInfo.new(
                        arg3,
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        0,
                        true,
                        0
                    ),
                    { Brightness = arg2 }
                ):Play()
            end
        end
    end,
    Toggle = function(arg5, arg6) --[[ Toggle ]] -- line: 32
        for _, descendant in arg5:GetDescendants() do
            if not descendant:IsA("ParticleEmitter") then
                if not descendant:IsA("Trail") then
                    if descendant:IsA("Beam") then
                        descendant.Enabled = arg6
                    end
                else
                    descendant.Enabled = arg6
                end
            else
                descendant.Enabled = arg6
            end
        end
    end,
    Flipbook = function(u1: userdata, n1: number, arg7: any) --[[ Flipbook ]] -- line: 40
        local Decal = u1:FindFirstChildOfClass("Decal")

        if Decal and arg7 then
            Decal.Transparency = 1
            coroutine.wrap(function() -- line: 44
                -- upvalues:
                --  [1] arg7 (copy)
                --  [2] Decal (copy)
                --  [3] n1 (copy)

                for index = 1, #arg7 do
                    local v5 = Decal
                    local _ = #arg7
                    v5.Transparency -= #arg7 * 0.025
                    Decal.Texture = arg7[index]
                    task.wait(1 / n1)
                end

                Decal.Texture = ""
            end)()
        end
    end,
    throwRock = function(
        arg8,
        arg9,
        arg10,
        arg11,
        arg12
    ) --[[ throwRock ]] -- line: 56
        -- upvalues:
        --  [1] Debris (copy)
        --  [2] TweenService (copy)

        arg11 = arg11 or 180
        local v7 = script.Rocks["Rock" .. math.random(1, 3)]:Clone()
        v7.Size = v7.Size * Random.new():NextNumber(1.01, arg9 or 2)
        v7.CanCollide = false
        local v11 = arg8.CFrame * CFrame.new(
            math.random(-5, 5),
            math.random(0, 5),
            math.random(-5, 5)
        )
        local Angles = CFrame.Angles
        local v12 = math.random(-arg11, arg11)
        local v13 = math.rad(v12)
        local v14 = math.random(-arg11, arg11)
        v7.CFrame = v11 * Angles(v13, 0, (math.rad(v14)))
        v7.Parent = arg12
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(100000000, 100000000, 100000000)
        BodyVelocity.P = 1000
        BodyVelocity.Velocity = v7.CFrame.UpVector * math.random(15, arg10 or 75)
        BodyVelocity.Parent = v7
        Debris:AddItem(BodyVelocity, 0.2)
        task.delay(0.1, function() -- line: 72
            -- upvalues:
            --  [1] v7 (copy)

            v7.CanCollide = true
        end)
        task.delay(2, function() -- line: 75
            -- upvalues:
            --  [1] v7 (copy)
            --  [2] TweenService (ref)
            --  [3] Debris (ref)

            v7.Start.Trail.Enabled = false
            TweenService:Create(v7, TweenInfo.new(0.5), { Size = Vector3.new(0, 0, 0) }):Play()
            Debris:AddItem(v7, 0.5)
        end)
    end,
    ParticleHandler = function(arg13, arg14, arg15) --[[ ParticleHandler ]] -- line: 82
        -- upvalues:
        --  [1] TweenService (copy)

        for _, val_1 in next, arg13:GetDescendants() do
            if val_1:IsA("ParticleEmitter") then
                val_1.Enabled = arg14
            elseif val_1:IsA("PointLight") then
                TweenService:Create(
                    val_1,
                    TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
                    { Brightness = arg15 }
                ):Play()
            end
        end
    end,
    LeftRightRock = function(
        arg16,
        arg17,
        arg18,
        arg19,
        arg20,
        arg21,
        arg22
    ) --[[ LeftRightRock ]] -- line: 94
        -- upvalues:
        --  [1] Debris (copy)
        --  [2] TweenService (copy)

        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        local v19 = arg20 or { workspace.FX }
        raycastParams.FilterDescendantsInstances = v19
        v19 = workspace:Raycast(arg16.Position, Vector3.new(0, arg17 or -25, 0), raycastParams)

        if v19 then
            local Part = Instance.new("Part")
            Debris:AddItem(Part, 3)
            Part.Anchored = true
            Part.CanCollide = true
            Part.CFrame = CFrame.new(v19.Position, v19.Position + v19.Normal) * CFrame.Angles(
                -1.5707963267948966,
                0,
                0
            )
            Part.Position += arg19 * arg18
            local v21 = math.random(-360, 360)
            Part.Orientation = Vector3.new(v21, math.random(-360, 360), math.random(-360, 360))
            Part.Material = v19.Instance.Material
            Part.Color = v19.Instance.Color
            Part.Parent = arg22
            local v23 = Part:Clone()
            Debris:AddItem(v23, 3)
            v23.CFrame = CFrame.new(v19.Position, v19.Position + v19.Normal) * CFrame.Angles(
                -1.5707963267948966,
                0,
                0
            )
            v23.Position += arg19 * -arg18
            local v24 = math.random(-360, 360)
            v23.Orientation = Vector3.new(v24, math.random(-360, 360), math.random(-360, 360))
            v23.Parent = arg22
            TweenService:Create(Part, TweenInfo.new(0.2), { Size = Vector3.new(1, 1, 1) * arg21 }):Play()
            TweenService:Create(v23, TweenInfo.new(0.2), { Size = Vector3.new(1, 1, 1) * arg21 }):Play()
            task.delay(2.5, function() -- line: 125
                -- upvalues:
                --  [1] TweenService (ref)
                --  [2] Part (copy)
                --  [3] v23 (copy)

                TweenService:Create(Part, TweenInfo.new(0.5), { Size = Vector3.new(0, 0, 0) }):Play()
                TweenService:Create(v23, TweenInfo.new(0.5), { Size = Vector3.new(0, 0, 0) }):Play()
            end)
        end
    end,
    ImpactFrame = function(arg23, arg24) --[[ ImpactFrame ]] -- line: 132
        -- upvalues:
        --  [1] Debris (copy)

        arg24 = arg24 or 0.06

        for index_1 = 1, #arg23 do
            local Highlight = Instance.new("Highlight")
            Highlight.FillTransparency = 0
            Highlight.OutlineTransparency = 1
            Highlight.FillColor = Color3.new(1, 1, 1)
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            Highlight.Parent = arg23[index_1]
            task.delay(arg24 * 0.5, function() -- line: 142
                -- upvalues:
                --  [1] Highlight (copy)

                Highlight.FillColor = Color3.new(0, 0, 0)
            end)
            Debris:AddItem(Highlight, arg24)
        end

        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
        ColorCorrectionEffect.TintColor = Color3.new(0, 0, 0)
        ColorCorrectionEffect.Brightness = 3
        task.delay(arg24 * 0.5, function() -- line: 151
            -- upvalues:
            --  [1] ColorCorrectionEffect (copy)

            ColorCorrectionEffect.TintColor = Color3.new(1, 1, 1)
        end)
        ColorCorrectionEffect.Parent = game.Lighting
        Debris:AddItem(ColorCorrectionEffect, arg24)
    end,
    BloomBlur = function() --[[ BloomBlur ]] -- line: 158
        -- upvalues:
        --  [1] Debris (copy)
        --  [2] TweenService (copy)

        local New_1 = TweenInfo.new
        local Blur_BlurEffect = Instance.new("BlurEffect", game.Lighting)
        local Bloom_BloomEffect = Instance.new("BloomEffect", game.Lighting)
        Debris:AddItem(Blur_BlurEffect, 0.5)
        Debris:AddItem(Bloom_BloomEffect, 0.5)
        Blur_BlurEffect.Name = "Blur"
        Bloom_BloomEffect.Name = "Bloom"
        local v34 = TweenService
        v34:Create(
            Blur_BlurEffect,
            New_1(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { Size = math.random(8, 12) }
        ):Play()
        TweenService:Create(
            Bloom_BloomEffect,
            New_1(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { Intensity = 3, Size = 35, Threshold = 1 }
        ):Play()
        task.delay(0.1, function() -- line: 171
            -- upvalues:
            --  [1] TweenService (ref)
            --  [2] Blur_BlurEffect (copy)
            --  [3] New_1 (copy)
            --  [4] Bloom_BloomEffect (copy)

            TweenService:Create(
                Blur_BlurEffect,
                New_1(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                { Size = 0 }
            ):Play()
            TweenService:Create(
                Bloom_BloomEffect,
                New_1(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                { Intensity = 1, Size = 24, Threshold = 2 }
            ):Play()
        end)
    end,
    CreateWeld = function(arg25, arg26) --[[ CreateWeld ]] -- line: 177
        local Weld = Instance.new("Weld")
        Weld.Part0 = arg25
        Weld.Part1 = arg26
        Weld.Parent = arg26

        return Weld
    end,
    BreakJoints = function(_: table, u3: userdata) --[[ BreakJoints ]] -- line: 191
        if u3:IsA("BasePart") then
            for _, val_3 in u3:GetJoints() do
                val_3:Destroy()
            end

            return
        end

        for _, descendant_1 in u3:GetDescendants() do
            if descendant_1:IsA("BasePart") then
                for _, val_4 in descendant_1:GetJoints() do
                    val_4:Destroy()
                end
            end
        end
    end
}

local _ = function(u2: userdata) --[[ BreakJoints ]] -- line: 185
    for _, val_2 in u2:GetJoints() do
        val_2:Destroy()
    end
end

function t.DeepCopyTable(_, arg28) -- line: 203
    -- upvalues:
    --  [1] t (copy)

    local t_9 = {}

    for key_7, val_5 in pairs(arg28) do
        if type(val_5) == "table" then
            t_9[key_7] = t:DeepCopyTable(val_5)
        else
            t_9[key_7] = val_5
        end
    end

    return t_9
end

return t
