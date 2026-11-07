-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Ultimates.TimeUltimate_FX
-- Class: ModuleScript
-- bytes: 30749

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local CameraShaker_m = require(Modules.CameraShaker)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local rng = Random.new()
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 21
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v2:Start()
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { workspace.Effects }

local _ = function(arg2) --[[ newRayParams ]] -- line: 32
    local raycastParams_1 = RaycastParams.new()
    raycastParams_1.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams_1.FilterDescendantsInstances = arg2

    return raycastParams_1
end

VFX_m.init()
local t = {}
local t_1 = {}

local function stopBeamShake(arg3, arg4) -- line: 53
    -- upvalues:
    --  [1] t_1 (copy)

    local v3 = t_1[arg3]

    if v3 then
        t_1[arg3] = nil
        v3:StartFadeOut(arg4 or 0.5)
    end
end

local _ = function(vec1: Vector3) --[[ sideAxes ]] -- line: 68
    local v4 = Vector3.new(vec1.X, 0, vec1.Z)

    if v4.Magnitude < 0.001 then
        v4 = Vector3.new(0, 0, -1)
    end

    v4 = v4.Unit

    return v4, v4:Cross(Vector3.new(0, 1, 0))
end

local _ = function(
    vec2: Vector3,
    n1: number,
    n2: number,
    u1: userdata,
    u2: userdata,
    vec3: Vector3
) --[[ debrisExplosion ]] -- line: 78
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] rng (copy)

    local v5 = Vector3.new(vec3.X, 0, vec3.Z)

    if v5.Magnitude < 0.001 then
        v5 = Vector3.new(0, 0, -1)
    end

    local Unit = v5.Unit
    local v6 = v5.Unit:Cross(Vector3.new(0, 1, 0))

    for index = 1, n2 do
        local v7 = if index % 2 ~= 0 then -1 else 1
        local v8 = u2:Clone()
        Services_m.Debris(v8, 6)
        v8.Color = u1.Color:Lerp(Color3.new(0, 0, 0), 0.35)
        v8.Material = u1.Material
        v8.MaterialVariant = u1.MaterialVariant
        local v9 = rng:NextNumber(1, 3)
        v8.Size = Vector3.new(v9, rng:NextNumber(1, 3), rng:NextNumber(1, 3)) * 1.5
        v8.Position = vec2
        local v15 = v6 * (v7 * rng:NextNumber(n1 * 0.4, n1)) + Vector3.new(
            0,
            rng:NextNumber(n1, n1 * 2),
            0
        )
        v8.AssemblyLinearVelocity = v15 + Unit * rng:NextNumber(-n1 * 0.2, n1 * 0.2)
        local v18 = rng:NextNumber(-10, 10)
        v8.AssemblyAngularVelocity = Vector3.new(
            v18,
            rng:NextNumber(-10, 10),
            rng:NextNumber(-10, 10)
        )
        v8.Parent = workspace.Effects
        task.delay(rng:NextNumber(2, 4.4), function() -- line: 102
            -- upvalues:
            --  [1] v8 (copy)

            _G.Tween(
                v8,
                { 1.5, "Linear", Enum.EasingDirection.Out },
                { Size = Vector3.new(0, 0, 0) }
            )
        end)
    end
end

local _ = function(
    vec4: Vector3,
    n3: number,
    u3: RaycastResult,
    vec5: Vector3,
    n4: number?,
    n5: number?
) --[[ debrisLine ]] -- line: 108
    -- upvalues:
    --  [1] rng (copy)
    --  [2] Services_m (copy)

    local v21 = Vector3.new(vec5.X, 0, vec5.Z)

    if v21.Magnitude < 0.001 then
        v21 = Vector3.new(0, 0, -1)
    end

    v21 = v21.Unit
    local v22 = v21
    local v23 = v21:Cross(Vector3.new(0, 1, 0))
    local v24 = n5 or 8
    local v25 = (n4 or 0) / math.max(v24 - 1, 1)
    local v31

    for index_1 = 1, v24 do
        local v26 = if index_1 % 2 ~= 0 then -1 else 1
        v31 = vec4 + v22 * (v25 * (index_1 - 1) + rng:NextNumber(-v25 * 0.3, v25 * 0.3))
        local v32 = v31 + v23 * (v26 * (n3 + rng:NextNumber(4, 9.5) * 1.5))
        local v33 = Vector3.new(v32.X, vec4.Y - 3.5999999999999996, v32.Z) + Vector3.new(0, 1.125, 0)
        local v34 = v31 + Vector3.new(0, -9, 0)
        local v31 = Instance.new("Part")
        Services_m.Debris(v31, 9)
        v31.Size = Vector3.new(0, 0, 0)
        v31.CFrame = CFrame.lookAt(v33, v34)
        v31.Anchored = true
        v31.CanCollide = false
        v31.CanQuery = false
        v31.CanTouch = false
        v31.CastShadow = false
        v31.Name = "Circle_Debris"
        v31.Color = u3.Instance.Color
        v31.Material = u3.Instance.Material
        v31.Parent = workspace.Effects
        _G.Tween(
            v31,
            { 0.3, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(11.432925, 8.166375, 4.899825) }
        )
        task.delay(rng:NextNumber(4, 8), function() -- line: 145
            -- upvalues:
            --  [1] v31 (copy)

            _G.Tween(
                v31,
                { 1.5, "Linear", Enum.EasingDirection.Out },
                { Position = v31.Position + Vector3.new(0, -3, 0) }
            )
        end)
    end
end

local function enableNow(arg5) -- line: 153
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    ForgeVFX_m.enable(arg5)

    local _ = function(arg6) --[[ prime ]] -- line: 156
        if arg6:IsA("ParticleEmitter") and arg6.Rate < 10 then
            arg6:Emit(1)
        end
    end

    if arg5:IsA("ParticleEmitter") and arg5.Rate < 10 then
        arg5:Emit(1)
    end

    for _, descendant in arg5:GetDescendants() do
        if descendant:IsA("ParticleEmitter") and descendant.Rate < 10 then
            descendant:Emit(1)
        end
    end
end

local _ = function(arg7) --[[ stopBeamSound ]] -- line: 172
    -- upvalues:
    --  [1] t (copy)
    --  [2] Services_m (copy)

    local v36 = arg7 .. "BeamSound"
    local v37 = t[v36]
    t[v36] = nil

    if v37 then
        v37.follow:Disconnect()

        if v37.sound.Parent then
            Services_m.FadeSound(v37.sound)
        end

        Services_m.Debris(v37.holder, 0.6)
    end
end

local UltimateBeam = ReplicatedStorage.SFX.Magic.Time.UltimateBeam

local function startBeamSound(arg8, arg9) -- line: 185
    -- upvalues:
    --  [1] t (copy)
    --  [2] UltimateBeam (copy)
    --  [3] RunService (copy)
    --  [4] Services_m (copy)

    local EndingVFX = arg9:FindFirstChild("EndingVFX")
    local _

    if EndingVFX then
        if t[arg8 .. "BeamSound"] then
            return
        end

        local TimeBeamSound_Attachment = Instance.new("Attachment")
        TimeBeamSound_Attachment.Name = "TimeBeamSound"
        TimeBeamSound_Attachment.Parent = workspace.Terrain

        _ = function() --[[ place ]] -- line: 195
            -- upvalues:
            --  [1] TimeBeamSound_Attachment (copy)
            --  [2] arg9 (copy)
            --  [3] EndingVFX (copy)

            TimeBeamSound_Attachment.WorldPosition = (arg9:GetPivot().Position + EndingVFX.WorldPosition) / 2
        end

        TimeBeamSound_Attachment.WorldPosition = (arg9:GetPivot().Position + EndingVFX.WorldPosition) / 2
        local v39 = UltimateBeam:Clone()
        v39.Parent = TimeBeamSound_Attachment
        v39:Play()
        t[arg8 .. "BeamSound"] = {
            holder = TimeBeamSound_Attachment,
            sound = v39,
            follow = RunService.Heartbeat:Connect(function() -- line: 204
                -- upvalues:
                --  [1] arg9 (copy)
                --  [2] arg8 (copy)
                --  [3] t (ref)
                --  [4] Services_m (ref)
                --  [5] TimeBeamSound_Attachment (copy)
                --  [6] EndingVFX (copy)

                if not arg9.Parent then
                    local v40 = arg8 .. "BeamSound"
                    local v41 = t[v40]
                    t[v40] = nil

                    if v41 then
                        v41.follow:Disconnect()

                        if v41.sound.Parent then
                            Services_m.FadeSound(v41.sound)
                        end

                        Services_m.Debris(v41.holder, 0.6)
                    end

                    return
                end

                TimeBeamSound_Attachment.WorldPosition = (arg9:GetPivot().Position + EndingVFX.WorldPosition) / 2
            end)
        }
        v39.Ended:Once(function() -- line: 213
            -- upvalues:
            --  [1] arg8 (copy)
            --  [2] t (ref)
            --  [3] Services_m (ref)

            local v44 = arg8 .. "BeamSound"
            local v45 = t[v44]
            t[v44] = nil

            if v45 then
                v45.follow:Disconnect()

                if v45.sound.Parent then
                    Services_m.FadeSound(v45.sound)
                end

                Services_m.Debris(v45.holder, 0.6)
            end
        end)

        return
    else
        return
    end
end

local t_4 = {
    ReplicatedStorage.SFX.Magic.Time.BurnTick1,
    ReplicatedStorage.SFX.Magic.Time.BurnTick2
}
local range = NumberRange.new(0.25, 0.6)

local function main(arg10) -- line: 223
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] CurrentCamera (copy)
    --  [3] GrimoireRarity_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] Services_m (copy)
    --  [6] t (copy)
    --  [7] ForgeVFX_m (copy)
    --  [8] enableNow (copy)
    --  [9] startBeamSound (copy)
    --  [10] v2 (copy)
    --  [11] stopBeamShake (copy)
    --  [12] rng (copy)
    --  [13] t_4 (copy)
    --  [14] range (copy)

    local Character = arg10.Character
    local Action = arg10.Action
    local CastId = arg10.CastId

    if Action == "Cleanup" then
        local v52 = t_1[CastId]

        if v52 then
            t_1[CastId] = nil
            v52:StartFadeOut(0.5)
        end

        return
    end

    local FlatVFX_1, LookVector, New_1, New_4, New_6, NumberValue_2, PrimaryPart, TimeBall, WorldPosition, _, finishBeam, math_max_1, _, t_10, t_12, _, t_8, t_9, _

    if Character then
        if Character.PrimaryPart then
            if (Character:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
                return
            end

            PrimaryPart = Character.PrimaryPart
            local v56 = GrimoireRarity_m:GetSkillVariant(Character, "Time")
            local v102

            if Action == "BeamSummon" then
                local v57 = ReplicatedStorage.Effects.MagicFX.Time.TimeBeam:Clone()
                Services_m.Debris(v57, 4)

                if v56 then
                    GrimoireRarity_m:ApplyVariantEffect(v57, v56)
                end

                t[CastId .. "BeamFX"] = v57
                v57:PivotTo(PrimaryPart.CFrame * CFrame.new(0, 80, -22.5))
                TimeBall = v57.TimeBall
                local v71 = TimeBall:GetScale()
                TimeBall:ScaleTo(v71 * 0.1)
                local v73 = "MeshPart"

                for _, val in TimeBall:QueryDescendants(v73), nil, nil do
                    val.Transparency = 1
                    ForgeVFX_m.disable(val)
                end

                v57.Parent = workspace.Effects
                task.spawn(function() -- line: 260
                    -- upvalues:
                    --  [1] v57 (copy)
                    --  [2] enableNow (ref)

                    for index_2 = 1, 3 do
                        for _, val_1 in v57:QueryDescendants("." .. index_2 .. "_VFX") do
                            if val_1 then
                                enableNow(val_1)
                            end

                            task.wait(0.05)
                        end
                    end
                end)
                v73 = "MeshPart"

                for _, val_2 in TimeBall:QueryDescendants(v73), nil, nil do
                    val_2.Transparency = 0
                    ForgeVFX_m.enable(val_2)
                end

                New_1 = Instance.new("NumberValue")
                New_1.Value = 0.1
                New_1.Changed:Connect(function(arg11) -- line: 278
                    -- upvalues:
                    --  [1] TimeBall (copy)
                    --  [2] v71 (copy)

                    if TimeBall.Parent then
                        TimeBall:ScaleTo(v71 * arg11)
                    end
                end)
                _G.Tween(
                    New_1,
                    { 0.1, "Linear", "Out" },
                    { Value = 1 },
                    true,
                    true
                )

                if not v57.Parent then
                    return
                end

                for _, val_3 in v57:QueryDescendants(".Starting_VFX") do
                    ForgeVFX_m.enable(val_3)
                end

                _ = {}
                t_8 = { v57.EndingVFX, v57.FlatVFX }
                t_9 = { Character, workspace.Effects }
                local v94 = RaycastParams.new()
                v94.FilterType = Enum.RaycastFilterType.Exclude
                v94.FilterDescendantsInstances = t_9
                local v95 = workspace:Raycast(v57:GetPivot().Position, Vector3.new(0, -88, 0), v94)
                v94 = v95 and v95.Distance or 82
                local v100 = nil

                for _, val_4 in t_8, v100, nil do
                    v102 = _G.Tween
                    t_10 = { CFrame = CFrame.new(0, -v94, 0) }
                    v102(val_4, { 0.1, "Linear", "Out" }, t_10)
                end

                task.wait(0.1)

                if not v57.Parent then
                    return
                end

                local v101 = ".Landing_VFX"

                for _, val_5 in v57:QueryDescendants(v101), nil, nil do
                    v102 = ForgeVFX_m.enable
                    v102(val_5)
                end

                v101 = ".Spin_FX"

                for _, val_6 in v57:QueryDescendants(v101), nil, nil do
                    v102 = ForgeVFX_m.emit
                    v102(val_6)
                end

                startBeamSound(CastId, v57)

                if not t_1[CastId] then
                    if (PrimaryPart.Position - CurrentCamera.CFrame.Position).Magnitude < 100 then
                        local v116 = t_1
                        local v117 = v2
                        v102 = 0.15
                        v116[CastId] = v117:StartShake(0.6, 8, v102)
                        task.delay(4, stopBeamShake, CastId)
                    end
                end
            end

            if Action == "BeamFire" then
                local v125 = t[CastId .. "BeamFX"]

                if not v125 then
                    return
                end

                local TimeBall_1 = v125:FindFirstChild("TimeBall")
                local v129 = v125:FindFirstChild("EndingVFX")
                FlatVFX_1 = v125:FindFirstChild("FlatVFX")

                if not TimeBall_1 or not v129 or not FlatVFX_1 then
                    return
                end

                local v130 = v125:GetPivot()
                LookVector = v130.LookVector
                _ = ReplicatedStorage.Effects.VFX.Light.Debris
                WorldPosition = v129.WorldPosition
                local v132 = WorldPosition.X - v130.Position.X
                v102 = v130.Position.Z
                local v134 = WorldPosition.Z - v102
                New_4 = Vector3.new(v132, 0, v134)
                t_12 = { Character, workspace.Effects }
                local v136 = RaycastParams.new()
                v136.FilterType = Enum.RaycastFilterType.Exclude
                v136.FilterDescendantsInstances = t_12
                local v137 = WorldPosition
                v102 = 0
                New_6 = Vector3.new(LookVector.X, v102, LookVector.Z).Unit
                v102 = -7.5

                for index_3 = 15, 0, v102 do
                    if workspace:Raycast(
                        WorldPosition - New_6 * index_3 + Vector3.new(0, 10, 0),
                        Vector3.new(0, -30, 0),
                        v136
                    ) then
                    end
                end

                local v140 = v125:QueryDescendants(".TrailVFX")
                v102 = nil

                if #v140 > 0 then
                    v102 = Instance.new("Attachment")
                    v102.Name = "TimeTrailFront"
                    v102.Parent = workspace.Terrain
                    local FromMatrix = CFrame.fromMatrix
                    local v141 = New_6:Cross(Vector3.new(0, 1, 0))
                    v102.WorldCFrame = FromMatrix(WorldPosition, v141, Vector3.new(0, 1, 0))

                    for _, val_7 in v125:QueryDescendants(".TrailAttachment") do
                        val_7.Parent = v102
                    end

                    local v144 = 0
                    local v143 = nil

                    for _, val_8 in v140, v143, nil do
                        val_8:Clear()
                        val_8.Enabled = true
                        v144 = math.max(v144, val_8.Lifetime)
                    end

                    Services_m.Debris(v102, v144 + 0.5 + 1)
                end

                local v148 = ReplicatedStorage.Effects.MagicFX.Time.AfterFX:Clone()

                if v56 then
                    GrimoireRarity_m:ApplyVariantEffect(v148, v56)
                end

                local v151 = WorldPosition - New_6 * 15
                local Size = v148.Size
                local v152 = 0
                local v153 = false

                _ = function(arg12) --[[ placeAfterFX ]] -- line: 396
                    -- upvalues:
                    --  [1] v152 (ref)
                    --  [2] v151 (copy)
                    --  [3] New_6 (copy)
                    --  [4] Size (copy)
                    --  [5] v148 (copy)

                    v152 = math.max(arg12, v152)
                    local v155 = v151 + New_6 * (v152 / 2) + Vector3.new(0, Size.Y / 2, 0)
                    local v156 = v148
                    local v157 = math.max(v152, 0.05)
                    v156.Size = Vector3.new(v157, Size.Y, Size.Z)
                    v148.CFrame = CFrame.fromMatrix(v155, New_6, Vector3.new(0, 1, 0))
                end

                v152 = math.max(15, v152)
                local v162 = v151 + New_6 * (v152 / 2) + Vector3.new(0, Size.Y / 2, 0)
                math_max_1 = math.max(v152, 0.05)
                v148.Size = Vector3.new(math_max_1, Size.Y, Size.Z)
                v148.CFrame = CFrame.fromMatrix(v162, New_6, Vector3.new(0, 1, 0))
                v148.Parent = workspace.Effects
                ForgeVFX_m.enable(v148)
                local v166 = true

                local function v177() -- line: 409
                    -- upvalues:
                    --  [1] v166 (ref)
                    --  [2] v148 (copy)
                    --  [3] rng (ref)
                    --  [4] v152 (ref)
                    --  [5] v151 (copy)
                    --  [6] New_6 (copy)
                    --  [7] t_4 (ref)
                    --  [8] Services_m (ref)
                    --  [9] range (ref)

                    while true do
                        if not v166 then
                            break
                        end

                        if not v148.Parent then
                            break
                        end

                        local v169 = rng:NextNumber(0, (math.max(v152, 0)))
                        local v171 = rng:NextNumber(-0.5, 0.5) * v148.Size.Z
                        local v173 = v151 + New_6 * v169 + New_6:Cross(Vector3.new(0, 1, 0)) * v171
                        local v176 = t_4[rng:NextInteger(1, #t_4)]
                        Services_m.PlaySound(v176, v173, nil, v176.Volume * 0.18)
                        task.wait(rng:NextNumber(range.Min, range.Max))
                    end
                end

                task.spawn(v177)

                _ = function() --[[ finishAfterFX ]] -- line: 420
                    -- upvalues:
                    --  [1] v153 (ref)
                    --  [2] v166 (ref)
                    --  [3] v148 (copy)
                    --  [4] ForgeVFX_m (ref)
                    --  [5] Services_m (ref)

                    if v153 then
                        return
                    end

                    v153 = true
                    task.delay(7, function() -- line: 424
                        -- upvalues:
                        --  [1] v166 (ref)
                        --  [2] v148 (ref)
                        --  [3] ForgeVFX_m (ref)
                        --  [4] Services_m (ref)

                        v166 = false

                        if not v148.Parent then
                            return
                        end

                        ForgeVFX_m.disable(v148)
                        local v178 = 0

                        for _, descendant_1 in v148:GetDescendants() do
                            if descendant_1:IsA("ParticleEmitter") then
                                descendant_1.Enabled = false
                                v178 = math.max(v178, descendant_1.Lifetime.Max)
                            elseif descendant_1:IsA("Light") then
                                _G.Tween(descendant_1, { 0.5, "Linear", "Out" }, { Brightness = 0 })
                            end
                        end

                        Services_m.Debris(v148, (math.max(v178, 0.5)))
                    end)
                end

                local v180 = false

                function finishBeam() -- line: 446
                    -- upvalues:
                    --  [1] v180 (ref)
                    --  [2] v153 (ref)
                    --  [3] v166 (ref)
                    --  [4] v148 (copy)
                    --  [5] ForgeVFX_m (ref)
                    --  [6] Services_m (ref)
                    --  [7] CastId (copy)
                    --  [8] t_1 (ref)
                    --  [9] v125 (copy)
                    --  [10] v129 (copy)
                    --  [11] TimeBall_1 (copy)
                    --  [12] t (ref)

                    if v180 then
                        return
                    end

                    v180 = true

                    if not v153 then
                        v153 = true
                        task.delay(7, function() -- line: 424
                            -- upvalues:
                            --  [1] v166 (ref)
                            --  [2] v148 (ref)
                            --  [3] ForgeVFX_m (ref)
                            --  [4] Services_m (ref)

                            v166 = false

                            if not v148.Parent then
                                return
                            end

                            ForgeVFX_m.disable(v148)
                            local v184 = 0

                            for _, descendant_2 in v148:GetDescendants() do
                                if descendant_2:IsA("ParticleEmitter") then
                                    descendant_2.Enabled = false
                                    v184 = math.max(v184, descendant_2.Lifetime.Max)
                                elseif descendant_2:IsA("Light") then
                                    _G.Tween(
                                        descendant_2,
                                        { 0.5, "Linear", "Out" },
                                        { Brightness = 0 }
                                    )
                                end
                            end

                            Services_m.Debris(v148, (math.max(v184, 0.5)))
                        end)
                    end

                    local v186 = CastId
                    local v187 = t_1[v186]

                    if v187 then
                        t_1[v186] = nil
                        v187:StartFadeOut(0.5)
                    end

                    local t_13 = {}

                    for _, val_9 in v125:QueryDescendants("Trail") do
                        t_13[val_9] = val_9.Transparency.Keypoints
                    end

                    local NumberValue = Instance.new("NumberValue")
                    NumberValue.Value = 0
                    NumberValue.Changed:Connect(function(arg13) -- line: 460
                        -- upvalues:
                        --  [1] t_13 (copy)

                        for key_13, val_10 in t_13 do
                            if key_13.Parent then
                                local t_14 = table.create(#val_10)

                                for key_14, val_11 in val_10 do
                                    t_14[key_14] = NumberSequenceKeypoint.new(
                                        val_11.Time,
                                        val_11.Value + (1 - val_11.Value) * arg13
                                    )
                                end

                                key_13.Transparency = NumberSequence.new(t_14)
                            end
                        end
                    end)
                    _G.Tween(NumberValue, { 0.25, "Linear", "Out" }, { Value = 1 }, true)

                    for _, val_12 in v129:QueryDescendants("ParticleEmitter") do
                        ForgeVFX_m.disable(val_12)
                    end

                    for _, val_13 in v125:QueryDescendants(".Landing_VFX") do
                        ForgeVFX_m.disable(val_13)
                    end

                    for _, val_14 in TimeBall_1:QueryDescendants("Beam") do
                        _G.Tween(val_14, { 0.25, "Linear", "Out" }, { Width0 = 0, Width1 = 0 })
                    end

                    local v188 = TimeBall_1:GetScale()
                    task.delay(1, function() -- line: 485
                        -- upvalues:
                        --  [1] CastId (ref)
                        --  [2] t (ref)
                        --  [3] Services_m (ref)
                        --  [4] TimeBall_1 (ref)
                        --  [5] v188 (copy)
                        --  [6] v125 (ref)
                        --  [7] ForgeVFX_m (ref)

                        local v189 = CastId .. "BeamSound"
                        local v190 = t[v189]
                        t[v189] = nil

                        if v190 then
                            v190.follow:Disconnect()

                            if v190.sound.Parent then
                                Services_m.FadeSound(v190.sound)
                            end

                            Services_m.Debris(v190.holder, 0.6)
                        end

                        local NumberValue_1 = Instance.new("NumberValue")
                        NumberValue_1.Value = 1
                        NumberValue_1.Changed:Connect(function(arg14) -- line: 490
                            -- upvalues:
                            --  [1] TimeBall_1 (ref)
                            --  [2] v188 (ref)

                            if TimeBall_1.Parent then
                                TimeBall_1:ScaleTo(v188 * math.max(arg14, 0.01))
                            end
                        end)
                        _G.Tween(NumberValue_1, { 0.5, "Linear", "Out" }, { Value = 0 }, true)

                        for index_4 = 1, 3 do
                            for _, val_15 in v125:QueryDescendants("." .. index_4 .. "_VFX") do
                                ForgeVFX_m.disable(val_15)

                                if val_15:IsA("ParticleEmitter") then
                                    local t_15 = { Transparency = NumberSequence.new(1) }
                                    _G.Tween(val_15, { 0.5, "Linear", "Out" }, t_15)
                                end
                            end
                        end
                    end)
                end

                NumberValue_2 = Instance.new("NumberValue")
                NumberValue_2.Value = 0
                NumberValue_2.Changed:Connect(function(arg15) -- line: 510
                    -- upvalues:
                    --  [1] v125 (copy)
                    --  [2] v130 (copy)
                    --  [3] New_6 (copy)
                    --  [4] New_4 (copy)
                    --  [5] v136 (copy)
                    --  [6] WorldPosition (copy)
                    --  [7] v129 (copy)
                    --  [8] FlatVFX_1 (copy)
                    --  [9] v102 (ref)
                    --  [10] v148 (copy)
                    --  [11] v151 (copy)
                    --  [12] v152 (ref)
                    --  [13] Size (copy)
                    --  [14] v137 (ref)

                    if not v125.Parent then
                        return
                    end

                    local v194 = v130 + New_6 * arg15
                    v125:PivotTo(v194)
                    local v195 = v194.Position + New_4
                    local v196 = workspace:Raycast(v195, Vector3.new(0, -300, 0), v136)
                    local v197 = v196 and v196.Position or Vector3.new(
                        v195.X,
                        WorldPosition.Y,
                        v195.Z
                    )
                    v129.WorldPosition = v197
                    FlatVFX_1.WorldPosition = v197

                    if v102 then
                        v102.WorldPosition = v197
                    end

                    if v148.Parent then
                        v152 = math.max((v197 - v151):Dot(New_6), v152)
                        local v200 = v151 + New_6 * (v152 / 2) + Vector3.new(0, Size.Y / 2, 0)
                        v148.Size = Vector3.new(math.max(v152, 0.05), Size.Y, Size.Z)
                        v148.CFrame = CFrame.fromMatrix(v200, New_6, Vector3.new(0, 1, 0))
                    end

                    if v196 then
                        local v204 = v197 - v137
                        local v205 = v204.Magnitude

                        while true do
                            if not (v205 >= 7.5) then
                                break
                            end

                            v137 += v204.Unit * 7.5
                            v205 -= 7.5
                        end
                    end
                end)
                _G.Tween(
                    NumberValue_2,
                    { 0.5, "Linear", Enum.EasingDirection.Out },
                    { Value = 112.5 },
                    true
                )
                task.delay(0.5, finishBeam)
            end

            return
        else
            return
        end
    else
        return
    end
end

return main
