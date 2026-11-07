-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Spatial.SkywardAscent_FX
-- Class: ModuleScript
-- bytes: 18993

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local Skills_m = require(Modules.Skills)
local SkywardAscent = ReplicatedStorage.Effects.VFX.Spatial["Skyward Ascent"]
local Ascent = Skills_m:LookupSkill("Skyward Ascent").Ascent
local CurrentCamera = workspace.CurrentCamera
local t = {
    LegKickUpwards = SkywardAscent.LegKickUpwards,
    Portal = SkywardAscent.Portal,
    Sword1 = SkywardAscent.Sword1,
    Shoot = SkywardAscent.Shoot,
    LegKickDownwards = SkywardAscent.LegKickDownwards,
    GroundFX = SkywardAscent.GroundFX
}
local t_1 = {
    Color = nil,
    KickOffset = CFrame.identity,
    ChargeOffset = CFrame.identity,
    GroundFXHeight = 0.2,
    KickDownOffset = CFrame.identity,
    PinOffset = -3,
    StuckEmitters = { Star9 = true },
    SeekTimeout = 0.3,
    SwordLinger = 0.4,
    SwordMaxLife = 2,
    KickShake = { { 1.4, 26, 0, 0.15, 0 }, { 1.1, 30, 0, 0.12, 0.06 } },
    KickShakeDistance = 100,
    ImpactShake = {
        { 2.6, 28, 0, 0.18, 0 },
        { 2.2, 32, 0, 0.16, 0.06 },
        { 1.8, 30, 0, 0.2, 0.13 },
        { 1.2, 26, 0, 0.25, 0.22 }
    },
    ImpactShakeDistance = 150
}

local function shake(vec1: Vector3, n1: number, t1: table) -- line: 114
    -- upvalues:
    --  [1] CurrentCamera (copy)

    if not _G.CameraShake then
        return
    end

    if n1 < (vec1 - CurrentCamera.CFrame.Position).Magnitude then
        return
    end

    for _, val in t1 do
        local v2, v3, v4, v5, v6 = table.unpack(val)
        local t_2 = { v2, v3, v4, v5 }

        if v6 and v6 > 0 then
            task.delay(v6, _G.CameraShake, t_2)
        else
            _G.CameraShake(t_2)
        end
    end
end

local t_3 = {
    Radius = 10,
    RingSpread = NumberRange.new(1, 4),
    RingCount = 17,
    SlabSize = Vector3.new(4.5, 3.5, 2),
    SlabGrowTime = 0.3,
    SlabLife = NumberRange.new(2, 3.5),
    ChunkCount = 6,
    ChunkPower = 40,
    Chunk = ReplicatedStorage.Effects.VFX.Light.Debris
}
local cframe = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(-0, -1, -0), Vector3.new(-0, -0, -1))
local v7 = CFrame.new(SkywardAscent.Portal.Position) * cframe
local t_4 = {
    Portal = v7:ToObjectSpace(SkywardAscent.Portal.CFrame).Rotation,
    Shoot = v7:ToObjectSpace(SkywardAscent.Shoot:GetPivot()),
    Sword = cframe:ToObjectSpace(SkywardAscent.Sword1.CFrame.Rotation),
    KickDown = cframe:ToObjectSpace(SkywardAscent.LegKickDownwards.CFrame.Rotation),
    GroundFX = SkywardAscent.GroundFX.CFrame.Rotation
}

local function prepareArt(arg1) -- line: 168
    -- upvalues:
    --  [1] t (copy)
    --  [2] GrimoireRarity_m (copy)

    if not arg1 then
        return t, function() -- line: 170
        end
    end

    local t_5 = {}

    for key_1, val_1 in t do
        local v9 = val_1:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v9, arg1)
        t_5[key_1] = v9
    end

    return t_5, function() -- line: 180
        -- upvalues:
        --  [1] t_5 (copy)

        for _, val_2 in t_5 do
            val_2:Destroy()
        end
    end
end

local t_6 = {}

local function artFor(arg2: any, u1: userdata) -- line: 190
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] t_1 (copy)
    --  [3] GrimoireRarity_m (copy)
    --  [4] prepareArt (copy)

    if typeof(arg2) == "string" and t_6[arg2] then
        return t_6[arg2]
    end

    local v11, v12 = prepareArt(
        if t_1.Color then { Primary = t_1.Color } else GrimoireRarity_m:GetSkillVariant(
            u1,
            "Spatial"
        )
    )

    if typeof(arg2) == "string" then
        t_6[arg2] = v11
    end

    task.delay(6, function() -- line: 202
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] t_6 (ref)
        --  [3] v12 (copy)

        if typeof(arg2) == "string" then
            t_6[arg2] = nil
        end

        v12()
    end)

    return v11
end

local function burstModel(u2: userdata, u3: CFrame) -- line: 214
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    local v13 = u2:Clone()
    v13:PivotTo(u3)
    v13.Parent = workspace
    local v14 = 0

    local function finished() -- line: 220
        -- upvalues:
        --  [1] v14 (ref)
        --  [2] v13 (copy)

        v14 -= 1

        if v14 <= 0 then
            v13:Destroy()
        end
    end

    for _, child in v13:GetChildren() do
        if not child:IsA("BasePart") then
            if not child:IsA("Model") then
                if child:IsA("Attachment") then
                    v14 += 1
                    ForgeVFX_m.emit(child).Finished:catch(function(arg3) -- line: 231
                        -- upvalues:
                        --  [1] u2 (copy)
                        --  [2] child (copy)

                        warn(`[SkywardAscent_FX] emit failed for {u2.Name}.{child.Name}: {arg3}`)
                    end):finally(finished)
                end
            else
                v14 += 1
                ForgeVFX_m.emit(child).Finished:catch(function(arg4) -- line: 231
                    -- upvalues:
                    --  [1] u2 (copy)
                    --  [2] child (copy)

                    warn(`[SkywardAscent_FX] emit failed for {u2.Name}.{child.Name}: {arg4}`)
                end):finally(finished)
            end
        else
            v14 += 1
            ForgeVFX_m.emit(child).Finished:catch(function(arg5) -- line: 231
                -- upvalues:
                --  [1] u2 (copy)
                --  [2] child (copy)

                warn(`[SkywardAscent_FX] emit failed for {u2.Name}.{child.Name}: {arg5}`)
            end):finally(finished)
        end
    end

    if v14 == 0 then
        v13:Destroy()
    end

    return v13
end

local function stripToTrails(u4: userdata, t2: table?) -- line: 248
    for _, descendant in u4:GetDescendants() do
        if not descendant:IsA("ParticleEmitter") or not t2 or not t2[descendant.Name] then
            if not descendant:IsA("ParticleEmitter") then
                if not descendant:IsA("Beam") then
                    if not descendant:IsA("Light") then
                        if descendant:IsA("Decal") then
                            descendant:Destroy()
                        end
                    else
                        descendant:Destroy()
                    end
                else
                    descendant:Destroy()
                end
            else
                descendant:Destroy()
            end
        end
    end
end

local t_7 = {}
local v15 = nil

local _ = function(t3: table, vec2: Vector3?) --[[ releaseSword ]] -- line: 274
    -- upvalues:
    --  [1] stripToTrails (copy)
    --  [2] t_1 (copy)

    if t3.Part.Parent then
        if vec2 then
            t3.Part.CFrame = CFrame.new(vec2) * t3.Rotation
        end

        stripToTrails(t3.Part)
    end

    local Part_1 = t3.Part
    task.delay(t_1.SwordLinger, function() -- line: 283
        -- upvalues:
        --  [1] Part_1 (copy)

        Part_1:Destroy()
    end)
end

local function stepSwords(n2: number) -- line: 288
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] t_1 (copy)
    --  [3] stripToTrails (copy)
    --  [4] Ascent (copy)
    --  [5] v15 (ref)

    local clock = os.clock()
    local v17

    for key_5, val_3 in t_7 do
        local v16 = if not val_3.StuckUntil then clock - val_3.Born > t_1.SwordMaxLife else clock >= val_3.StuckUntil

        if not val_3.Part.Parent or v16 then
            t_7[key_5] = nil

            if val_3.Part.Parent then
                stripToTrails(val_3.Part)
            end

            local v17 = val_3.Part
            task.delay(t_1.SwordLinger, function() -- line: 283
                -- upvalues:
                --  [1] v17 (copy)

                v17:Destroy()
            end)
        else
            v16 = key_5.Parent ~= nil

            if val_3.Stuck then
                for _, val_4 in val_3.Stuck do
                    val_4.Enabled = true
                end
            end

            if not val_3.Pinned then
                v17 = Ascent.SwordSpeed * n2
                local v19 = (if not v16 then val_3.Position + val_3.Direction * v17 else key_5.Position + val_3.Direction * t_1.PinOffset) - val_3.Position

                if v17 >= v19.Magnitude or clock - val_3.Born > t_1.SeekTimeout then
                    val_3.Pinned = true
                else
                    val_3.Position += v19.Unit * v17
                end
            end

            if val_3.Pinned and v16 then
                val_3.Position = key_5.Position + val_3.Direction * t_1.PinOffset
            end

            val_3.Part.CFrame = CFrame.new(val_3.Position) * val_3.Rotation
        end
    end

    if next(t_7) == nil and v15 then
        v15:Disconnect()
        v15 = nil
    end
end

local function launchSword(arg6: any, u5: userdata, u6: CFrame) -- line: 335
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] stripToTrails (copy)
    --  [3] t_1 (copy)
    --  [4] t_4 (copy)
    --  [5] Ascent (copy)
    --  [6] VFX_m (copy)
    --  [7] v15 (ref)
    --  [8] RunService (copy)
    --  [9] stepSwords (copy)

    local v20 = t_7[u5]

    if v20 then
        t_7[u5] = nil

        if v20.Part.Parent then
            stripToTrails(v20.Part)
        end

        local Part_3 = v20.Part
        task.delay(t_1.SwordLinger, function() -- line: 283
            -- upvalues:
            --  [1] Part_3 (copy)

            Part_3:Destroy()
        end)
    end

    local v21 = u6.Rotation * t_4.Sword
    local v23 = math.max(t_1.SwordMaxLife, Ascent.KnockdownTime + 1) + t_1.SwordLinger
    local v24 = VFX_m.burst(arg6.Sword1, CFrame.new(u6.Position) * v21, nil, v23)
    v24.Anchored = true

    for _, val_5 in v24:QueryDescendants("Trail") do
        val_5.Enabled = true
    end

    t_7[u5] = {
        Part = v24,
        Rotation = v21,
        Direction = u6.LookVector,
        Position = u6.Position,
        Born = os.clock(),
        Pinned = false
    }

    if not v15 then
        v15 = RunService.Heartbeat:Connect(stepSwords)
    end
end

local rng = Random.new()
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {
    workspace.Effects,
    workspace.pCharacters,
    workspace.FightableNPCS
}
raycastParams.IgnoreWater = true

local function debrisRing(vec3: Vector3, u7: userdata) -- line: 374
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] rng (copy)
    --  [3] Services_m (copy)

    local v26 = vec3 + Vector3.new(0, -8, 0)
    local v27 = 6.283185307179586 / t_3.RingCount
    local v28

    for index = 1, t_3.RingCount do
        v28 = v27 * index
        local v29 = -v27 * 0.3
        local v30 = v27 * 0.3
        local _ = t_3.RingCount
        local v31 = v28 + rng:NextNumber(v29, v30)
        v28 = t_3.Radius + rng:NextNumber(t_3.RingSpread.Min, t_3.RingSpread.Max)
        local v32 = vec3.X + math.cos(v31) * v28
        local vec3_1 = Vector3.new(v32, vec3.Y - 0.65, vec3.Z + math.sin(v31) * v28)
        local v28 = Instance.new("Part")
        v28.Name = "Circle_Debris"
        v28.Size = Vector3.new(0, 0, 0)
        v28.CFrame = CFrame.lookAt(vec3_1, v26)
        v28.Anchored = true
        v28.CanCollide = false
        v28.CanQuery = false
        v28.CanTouch = false
        v28.CastShadow = false
        v28.Color = u7.Color
        v28.Material = u7.Material
        v28.Parent = workspace.Effects
        Services_m.Debris(v28, t_3.SlabLife.Max + 2)
        _G.Tween(
            v28,
            { t_3.SlabGrowTime, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = t_3.SlabSize }
        )
        task.delay(rng:NextNumber(t_3.SlabLife.Min, t_3.SlabLife.Max), function() -- line: 403
            -- upvalues:
            --  [1] v28 (copy)

            _G.Tween(
                v28,
                { 1.5, "Linear", Enum.EasingDirection.Out },
                { Position = v28.Position + Vector3.new(0, -3, 0) }
            )
        end)
    end
end

local function debrisChunks(vec4: Vector3, u8: userdata) -- line: 410
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] rng (copy)
    --  [3] Services_m (copy)

    local ChunkPower = t_3.ChunkPower

    for _ = 1, t_3.ChunkCount do
        local _ = t_3.ChunkCount
        local v35 = t_3.Chunk:Clone()
        v35.Color = u8.Color
        v35.Material = u8.Material
        v35.MaterialVariant = u8.MaterialVariant
        local v36 = rng:NextNumber(0.5, 2)
        v35.Size = Vector3.new(v36, rng:NextNumber(0.5, 2), rng:NextNumber(0.5, 2))
        v35.Position = vec4
        local v39 = rng:NextNumber(-ChunkPower, ChunkPower)
        local v41 = rng:NextNumber(ChunkPower, ChunkPower * 2)
        v35.AssemblyLinearVelocity = Vector3.new(v39, v41, rng:NextNumber(-ChunkPower, ChunkPower))
        local v43 = rng:NextNumber(-10, 10)
        v35.AssemblyAngularVelocity = Vector3.new(
            v43,
            rng:NextNumber(-10, 10),
            rng:NextNumber(-10, 10)
        )
        v35.Parent = workspace.Effects
        Services_m.Debris(v35, 6)
        task.delay(rng:NextNumber(2, 4.4), function() -- line: 433
            -- upvalues:
            --  [1] v35 (copy)

            _G.Tween(
                v35,
                { 1.5, "Linear", Enum.EasingDirection.Out },
                { Size = Vector3.new(0, 0, 0) }
            )
        end)
    end
end

local function groundDebris(vec5: Vector3) -- line: 439
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] debrisRing (copy)
    --  [3] debrisChunks (copy)

    local v47 = workspace:Raycast(vec5 + Vector3.new(0, 2, 0), Vector3.new(0, -5, 0), raycastParams)

    if v47 then
        if not v47.Instance:IsA("BasePart") then
            return
        end

        debrisRing(v47.Position, v47.Instance)
        debrisChunks(v47.Position, v47.Instance)

        return
    else
        return
    end
end

VFX_m.init()
VFX_m.preload({ SkywardAscent })

local _ = function(vec6: Vector3) --[[ inRange ]] -- line: 452
    -- upvalues:
    --  [1] CurrentCamera (copy)

    return (vec6 - CurrentCamera.CFrame.Position).Magnitude <= 400
end

local function main(arg7) -- line: 456
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] VFX_m (copy)
    --  [3] artFor (copy)
    --  [4] t_1 (copy)
    --  [5] shake (copy)
    --  [6] t_4 (copy)
    --  [7] burstModel (copy)
    --  [8] launchSword (copy)
    --  [9] t_7 (copy)
    --  [10] Ascent (copy)
    --  [11] stripToTrails (copy)
    --  [12] groundDebris (copy)

    local Character = arg7.Character
    local Action = arg7.Action
    local CastId = arg7.CastId
    local Root = arg7.Root
    local Position = arg7.Position

    if Character then
        if typeof(Position) ~= "CFrame" then
            return
        end

        if Action == "Warp" then
            if if not ((Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
                VFX_m.burstChild(
                    artFor(CastId, Character).LegKickUpwards,
                    Position * t_1.ChargeOffset,
                    "Charge"
                )
            end

            return
        end

        if Action == "Kick" then
            if if not ((Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
                VFX_m.burstChild(
                    artFor(CastId, Character).LegKickUpwards,
                    Position * t_1.KickOffset,
                    "Kick"
                )
            end

            shake(Position.Position, t_1.KickShakeDistance, t_1.KickShake)

            return
        end

        if typeof(Root) == "Instance" then
            if not Root:IsA("BasePart") then
                return
            end

            if Action == "Portal" then
                if if not ((Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
                    VFX_m.burst(artFor(CastId, Character).Portal, Position * t_4.Portal)

                    return
                end
            else
                if Action == "Sword" then
                    local v51 = artFor(CastId, Character)
                    local v52 = (Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400 and true

                    if v52 then
                        v52 = Position * t_4.Shoot
                        burstModel(v51.Shoot, v52)
                        VFX_m.burst(
                            v51.LegKickDownwards,
                            CFrame.new(v52.Position) * Position.Rotation * t_1.KickDownOffset * t_4.KickDown
                        )
                    end

                    launchSword(v51, Root, Position)

                    return
                end

                if Action == "Impact" then
                    local v53 = t_7[Root]

                    if v53 and v53.Part.Parent then
                        v53.Pinned = true
                        v53.StuckUntil = os.clock() + Ascent.KnockdownTime
                        stripToTrails(v53.Part, t_1.StuckEmitters)
                        local t_11 = {}

                        for _, val_6 in v53.Part:QueryDescendants("ParticleEmitter") do
                            table.insert(t_11, val_6)
                        end

                        v53.Stuck = t_11
                    end

                    if if not ((Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
                        VFX_m.burst(
                            artFor(CastId, Character).GroundFX,
                            Position * CFrame.new(0, t_1.GroundFXHeight, 0) * t_4.GroundFX
                        )
                        groundDebris(Position.Position)
                    end

                    shake(Position.Position, t_1.ImpactShakeDistance, t_1.ImpactShake)

                    return
                end

                if Action == "Release" then
                    local v55 = t_7[Root]

                    if v55 then
                        t_7[Root] = nil

                        if v55.Part.Parent then
                            stripToTrails(v55.Part)
                        end

                        local Part_4 = v55.Part
                        task.delay(t_1.SwordLinger, function() -- line: 283
                            -- upvalues:
                            --  [1] Part_4 (copy)

                            Part_4:Destroy()
                        end)
                    end
                end
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
