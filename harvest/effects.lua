-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Effects
-- Class: ModuleScript
-- bytes: 17660

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local TweenService = Services_m.TweenService
local ReplicatedStorage = Services_m.ReplicatedStorage
local rng = Random.new()
local _ = RaycastParams.new()
local _ = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local _ = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local _ = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
local LightningSparks_m = require(ReplicatedStorage.LightningBolt.LightningSparks)
local LightningBolt_m = require(ReplicatedStorage.LightningBolt)

local _ = function(arg1) --[[ removelight ]] -- line: 16
    pcall(function() -- line: 17
        -- upvalues:
        --  [1] arg1 (copy)

        task.wait(0.25)
        _G.Tween(
            arg1,
            { 0.5, "Smoother", Enum.EasingDirection.In },
            { Range = 0, Brightness = 0 },
            true,
            true
        )
    end)
end

local t = {
    GenerateLightning = function(arg2, arg3, arg4) --[[ GenerateLightning ]] -- line: 25
        -- upvalues:
        --  [1] ReplicatedStorage (copy)
        --  [2] Services_m (copy)
        --  [3] LightningBolt_m (copy)
        --  [4] LightningSparks_m (copy)

        local v2 = arg4.Radius or 1
        local v3 = arg4.Color or Color3.fromRGB()
        local v4 = arg4.Curve or 15
        local v5 = arg4.Speed or 2
        local v6 = arg4.Length or 0.5
        local v7 = arg4.Unit or 2
        local v8 = arg4.FadeLength or 0.25
        local v9 = arg4.Thickness or 1
        local v10 = ReplicatedStorage.Effects.Part1:Clone()
        local v11 = ReplicatedStorage.Effects.Part2:Clone()
        Services_m.Debris(v10, 2)
        Services_m.Debris(v11, 2)
        v10.CFrame = arg2
        v11.CFrame = arg3
        local v12 = ReplicatedStorage.Effects.Beam:Clone()
        Services_m.Debris(v12, 2)
        v12.CurveSize0 = v4
        v12.CurveSize1 = v4
        v12.Parent = workspace.Effects
        local Attachment1 = v10.Attachment1
        local Attachment2 = v11.Attachment2
        local cframe = CFrame.fromAxisAngle(
            (v11.Position - v10.Position).Unit,
            v7 * math.random() * 3.141592653589793
        )
        local t_1 = {}
        local t_2 = {}
        t_1.WorldPosition, t_1.WorldAxis = Attachment1.WorldPosition, cframe * Attachment1.WorldAxis
        t_2.WorldPosition, t_2.WorldAxis = Attachment2.WorldPosition, cframe * Attachment2.WorldAxis
        local v14 = LightningBolt_m.new(t_1, t_2, 12, v9)
        v14.CurveSize0, v14.CurveSize1 = v12.CurveSize0, v12.CurveSize1
        v14.PulseSpeed = v5
        v14.PulseLength = v6
        v14.FadeLength = v8
        v14.MinRadius = v2 / 2
        v14.MaxRadius = v2
        v14.Color = v3
        local _ = LightningSparks_m.new(v14)
    end,
    lightningNew = function(...) --[[ lightningNew ]] -- line: 61
        _G.GetModule("LightningGenerate1")(...)
    end,
    Lightning2 = function(_, ...) --[[ Lightning2 ]] -- line: 65
        _G.GetModule("LightningGenerate2")(...)
    end,
    Lightning3 = function(_, ...) --[[ Lightning3 ]] -- line: 69
        _G.GetModule("LightningGenerate3")(...)
    end,
    BeamEffect = function(arg7, arg8) --[[ BeamEffect ]] -- line: 73
        -- upvalues:
        --  [1] ReplicatedStorage (copy)
        --  [2] Services_m (copy)

        _G.FastSpawn(function() -- line: 74
            -- upvalues:
            --  [1] arg7 (copy)
            --  [2] ReplicatedStorage (ref)
            --  [3] Services_m (ref)
            --  [4] arg8 (copy)

            for index = 1, 6 do
                _G.FastSpawn(function() -- line: 76
                    -- upvalues:
                    --  [1] index (copy)
                    --  [2] arg7 (ref)
                    --  [3] ReplicatedStorage (ref)
                    --  [4] Services_m (ref)
                    --  [5] arg8 (ref)

                    local v16 = math.sin(index * 360)
                    local v17 = math.cos(index * 360)
                    local v18 = Vector3.new(v16, 0, v17) + arg7.Position or Vector3.new(0, -1000, 0)
                    local v19 = ReplicatedStorage.Effects.BP:Clone()
                    Services_m.Debris(v19, 2)
                    v19.Shape = "Block"
                    Instance.new("SpecialMesh", v19).MeshType = "Sphere"
                    v19.Size = Vector3.new(10, 10, 10)
                    v19.Material = Enum.Material.Neon
                    v19.Color = arg8 or Color3.fromRGB(255, 255, 255)
                    v19.Transparency = 0
                    local New = CFrame.new
                    local v21 = math.random(-1, 1)
                    local v22 = math.random(-1, 1)
                    v19.CFrame = New(v18 + Vector3.new(v21, v22, math.random(-1, 1)), v18)
                    v19.Parent = workspace.Effects
                    local t_3 = { Size = nil, CFrame = nil }
                    local Tween = _G.Tween
                    local t_4 = { 0.15, "EntranceExpressive", Enum.EasingDirection.Out }
                    t_3.Size = v19.Size + Vector3.new(0, 0, math.random(2, 4))
                    t_3.CFrame = v19.CFrame * CFrame.new(0, 0, 50)
                    Tween(
                        v19,
                        t_4,
                        t_3,
                        nil,
                        true
                    )
                    _G.Tween(
                        v19,
                        { 0.25, "Quad", Enum.EasingDirection.Out },
                        { Size = Vector3.new(0, 0, 50), Transparency = 1 },
                        true
                    )
                end)
            end
        end)
    end,
    Specks = function(
        arg9,
        arg10,
        arg11,
        arg12,
        arg13
    ) --[[ Specks ]] -- line: 100
        -- upvalues:
        --  [1] rng (copy)
        --  [2] ReplicatedStorage (copy)

        arg11 = arg11 or Vector3.new(0.8, 0.8, 1.5)
        local v24 = arg12 or CFrame.new(0, 0, rng:NextNumber(6, 7))
        arg12 = v24
        v24 = ReplicatedStorage.Effects.BP:Clone()
        game.Debris:AddItem(v24, 2)
        v24.Shape = "Block"
        v24.Size = arg11
        v24.Material = Enum.Material.Neon
        v24.Color = Color3.fromRGB(255, 255, 255)
        v24.Transparency = 0
        local cframe_1 = CFrame.lookAt(arg9, arg10.Position)
        local v25 = arg13 and arg12 or CFrame.new()
        v24.CFrame = cframe_1 * v25
        Instance.new("SpecialMesh", v24).MeshType = "Sphere"
        v24.Parent = workspace.Effects
        _G.FastSpawn(function() -- line: 116
            -- upvalues:
            --  [1] arg13 (copy)
            --  [2] v24 (copy)
            --  [3] arg11 (ref)
            --  [4] arg12 (ref)

            if arg13 then
                local t_5 = { Size = Vector3.new(0, 0, arg11.Z), CFrame = nil }
                local Tween_1 = _G.Tween
                local v26 = v24
                local t_6 = { 0.2, "Smoother", Enum.EasingDirection.Out }
                t_5.CFrame = v24.CFrame * CFrame.new(0, 0, 4)
                Tween_1(v26, t_6, t_5, true)

                return
            end

            _G.Tween(
                v24,
                { 0.9, "EntranceExpressive", Enum.EasingDirection.Out },
                { CFrame = v24.CFrame * arg12 }
            )
            _G.Tween(
                v24,
                { 0.3, "EntranceExpressive", Enum.EasingDirection.Out, false, 0.2 },
                { Size = Vector3.new(0, 0, 0), Transparency = 1 },
                true
            )
        end)
    end,
    CreateGroundCrack = function(_, arg15, arg16) --[[ CreateGroundCrack ]] -- line: 129
        -- upvalues:
        --  [1] Services_m (copy)

        _G.FastSpawn(function() -- line: 130
            -- upvalues:
            --  [1] arg16 (copy)
            --  [2] arg15 (copy)
            --  [3] Services_m (ref)

            local v28 = script.GroundCrack1:Clone()
            local DirtPatch = v28.DirtPatch
            DirtPatch.Size = arg16
            DirtPatch.CFrame = arg15
            local Crack1 = v28.Crack1
            Crack1.Size = DirtPatch.Size * 1.25
            Crack1.CFrame = arg15
            v28.Parent = workspace.Effects
            _G.Tween(
                DirtPatch.Decal,
                { 0.25, "Linear", Enum.EasingDirection.Out },
                { Transparency = 0.1 }
            )
            _G.Tween(
                Crack1.Decal,
                { 0.25, "Linear", Enum.EasingDirection.Out },
                { Transparency = 0.5 },
                false,
                true
            )
            task.delay(0.6, function() -- line: 147
                -- upvalues:
                --  [1] DirtPatch (copy)
                --  [2] Crack1 (copy)

                _G.Tween(
                    DirtPatch.Decal,
                    { 0.55, "Quad", Enum.EasingDirection.Out },
                    { Transparency = 1 }
                )
                _G.Tween(
                    Crack1.Decal,
                    { 1.25, "Quad", Enum.EasingDirection.Out },
                    { Transparency = 1 }
                )
            end)
            Services_m.Debris(v28, 3)
        end)
    end
}

function t.CreateSmokeCloud(
    _,
    arg18,
    arg19,
    arg20,
    arg21,
    arg22
) -- line: 158
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)
    --  [3] t (copy)

    local v29 = arg19 or Color3.fromRGB(65, 65, 65)
    arg19 = v29
    v29 = ReplicatedStorage.Effects.SmokeCloud:Clone()
    v29.Name = "Ignore"
    v29.Color = arg19
    v29.CFrame = arg18
    v29.Size = arg20
    v29.Parent = workspace.Effects
    Services_m.Debris(v29, 5)
    t:SetParticleColor(v29, arg19)
    local v30 = arg21
    local v31 = t

    if not v30 then
        v30 = NumberSequence.new(5)
    end

    v31:SetParticleSize(v29, v30)
    t:EmitParticle(v29, arg22 or 30)
end

function t.createSmokeRing(
    _,
    arg24,
    arg25,
    arg26,
    arg27,
    arg28
) -- line: 172
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)
    --  [3] t (copy)

    local v32 = arg25 or Color3.fromRGB(65, 65, 65)
    arg25 = v32
    v32 = ReplicatedStorage.Effects.DustRing:Clone()
    v32.Name = "Ignore"
    v32.Color = arg25
    v32.CFrame = arg24
    v32.Parent = workspace.Effects
    Services_m.Debris(v32, 5)
    t:SetParticleColor(v32, arg25)
    local v33 = arg26
    local v34 = t

    if not v33 then
        v33 = NumberSequence.new(5)
    end

    v34:SetParticleSize(v32, v33)
    v33 = arg27
    local v35 = t

    if not v33 then
        v33 = NumberRange.new(10)
    end

    v35:SetParticleSpeed(v32, v33)
    t:EmitParticle(v32, arg28 or 30)
end

function t.SetParticleColor(
    _,
    arg30,
    arg31,
    arg32,
    ...
) -- line: 186
    local v36 = if ... then if typeof(...) == "table" then ... or { ... } else { ... } else { ... }

    if typeof(arg31) ~= "Color3" then
        arg31 = Color3.fromRGB(126, 126, 126)
    end

    for _, descendant in pairs(arg30:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            if arg32 then
                if descendant.Name == arg32 then
                    descendant.Color = ColorSequence.new(arg31)
                end
            elseif not table.find(v36, descendant.Name) then
                descendant.Color = ColorSequence.new(arg31)
            end
        end
    end
end

function t.SetParticleSize(
    _,
    arg34,
    arg35,
    arg36,
    ...
) -- line: 204
    local v38 = if ... then if typeof(...) == "table" then ... or { ... } else { ... } else { ... }

    for _, descendant_1 in pairs(arg34:GetDescendants()) do
        if descendant_1:IsA("ParticleEmitter") then
            if arg36 then
                if descendant_1.Name == arg36 then
                    descendant_1.Size = arg35
                end
            elseif not table.find(v38, descendant_1.Name) then
                descendant_1.Size = arg35
            end
        end
    end
end

function t.SetParticleSpeed(
    _,
    arg38,
    arg39,
    arg40,
    ...
) -- line: 222
    local v40 = if ... then if typeof(...) == "table" then ... or { ... } else { ... } else { ... }

    for _, descendant_2 in pairs(arg38:GetDescendants()) do
        if descendant_2:IsA("ParticleEmitter") then
            if arg40 then
                if descendant_2.Name == arg40 then
                    descendant_2.Speed = arg39
                end
            elseif not table.find(v40, descendant_2.Name) then
                descendant_2.Speed = arg39
            end
        end
    end
end

function t.EmitParticle(
    _,
    arg42,
    arg43,
    arg44,
    ...
) -- line: 240
    if _G.MediumPerformance or _G.LowPerformance then
        arg43 = math.min(arg43, 15)
    end

    local v42 = if ... then if typeof(...) == "table" then ... or { ... } else { ... } else { ... }

    for _, descendant_3 in pairs(arg42:GetDescendants()) do
        if descendant_3:IsA("ParticleEmitter") then
            if arg44 then
                if descendant_3.Name == arg44 then
                    descendant_3:Emit(arg43 or 10)
                end
            elseif not table.find(v42, descendant_3.Name) then
                descendant_3:Emit(arg43 or 10)
            end
        end
    end
end

function t.CleanEmitParticle(_, arg46, arg47, arg48) -- line: 260
    if arg47 == 0 then
        for _, val in ipairs(arg46:GetDescendants()) do
            if val:IsA("ParticleEmitter") and arg48 ~= nil then
                val.Enabled = arg48
            end
        end

        return
    end

    if _G.MediumPerformance or _G.LowPerformance then
        arg47 = math.clamp(arg47, 1, 10)
    end

    for _, val_1 in ipairs(arg46:GetDescendants()) do
        if val_1:IsA("ParticleEmitter") then
            local EmitDelay = val_1:GetAttribute("EmitDelay")
            local v46 = val_1:GetAttribute("EmitCount") or arg47

            local function emit() -- line: 282
                -- upvalues:
                --  [1] val_1 (copy)
                --  [2] v46 (copy)
                --  [3] arg48 (copy)

                val_1:Emit(v46)

                if arg48 ~= nil then
                    val_1.Enabled = arg48
                end
            end

            if EmitDelay then
                task.delay(EmitDelay, emit)
            else
                val_1:Emit(v46)

                if arg48 ~= nil then
                    val_1.Enabled = arg48
                end
            end
        end
    end
end

function t.BeamSlash(
    _,
    arg50,
    arg51,
    arg52,
    arg53,
    arg54,
    arg55,
    arg56,
    arg57,
    arg58
) -- line: 298
    -- upvalues:
    --  [1] TweenService (copy)

    for _, descendant_4 in pairs(arg50:GetDescendants()) do
        if descendant_4:IsA("Beam") then
            descendant_4.Enabled = true

            if arg58 then
                TweenService:Create(
                    descendant_4,
                    TweenInfo.new(
                        arg51,
                        Enum.EasingStyle.Back,
                        Enum.EasingDirection.InOut,
                        0,
                        false,
                        arg52
                    ),
                    { Width0 = arg54, Width1 = arg55, CurveSize0 = arg56, CurveSize1 = arg57 }
                ):Play()
            else
                TweenService:Create(
                    descendant_4,
                    TweenInfo.new(
                        arg51,
                        Enum.EasingStyle.Back,
                        Enum.EasingDirection.InOut,
                        0,
                        false,
                        arg52
                    ),
                    { Width0 = arg54, Width1 = arg55 }
                ):Play()
            end

            descendant_4.TextureSpeed = arg53
        end
    end
end

function t.AddLight(arg59, arg60, arg61, arg62) -- line: 312
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)

    _G.FastSpawn(function() -- line: 313
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] Services_m (ref)
        --  [3] arg60 (copy)
        --  [4] arg59 (copy)
        --  [5] arg61 (copy)
        --  [6] arg62 (copy)

        local v50 = ReplicatedStorage.Effects.LightningLight:Clone()
        Services_m.Debris(v50, 2)
        v50.Light.Color = arg60
        v50.Color = v50.Light.Color
        v50.CFrame = arg59
        v50.Parent = workspace.Effects
        _G.Tween(
            v50.Light,
            { 0.2, "Smoother", Enum.EasingDirection.Out },
            { Range = arg61 or 15, Brightness = arg62 or 4 },
            nil,
            true
        )

        if v50 and v50:FindFirstChild("Light") then
            local Light = v50.Light
            pcall(function() -- line: 17
                -- upvalues:
                --  [1] Light (copy)

                task.wait(0.25)
                _G.Tween(
                    Light,
                    { 0.5, "Smoother", Enum.EasingDirection.In },
                    { Range = 0, Brightness = 0 },
                    true,
                    true
                )
            end)
            v50:Destroy()
        end
    end)
end

function t.FadeSound(_, arg64) -- line: 328
    -- upvalues:
    --  [1] TweenService (copy)

    local v51 = TweenService:Create(
        arg64,
        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Volume = 0 }
    )
    v51:Play()
    v51.Completed:Wait()
    arg64:Destroy()
end

return t
