-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Spatial.RiftBloom_FX
-- Class: ModuleScript
-- bytes: 8633

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local Skills_m = require(Modules.Skills)
local Spatial = ReplicatedStorage.Effects.VFX.Spatial
local Bloom = Skills_m:LookupSkill("Rift Bloom").Bloom
local CurrentCamera = workspace.CurrentCamera
local t = {
    Color = nil,
    SigilEmitters = { Flash = true, SP = true },
    SigilHeight = 0.1,
    PortalOpenDelay = 0.05,
    PortalStagger = 0.04,
    SwordStart = -1,
    SwordLinger = 0.2,
    ThrustShake = { { 1.3, 26, 0, 0.15, 0 }, { 0.9, 30, 0, 0.12, 0.05 } },
    ThrustShakeDistance = 60
}

local function shake(vec1: Vector3, n1: number, t1: table) -- line: 71
    -- upvalues:
    --  [1] CurrentCamera (copy)

    if not _G.CameraShake then
        return
    end

    if n1 < (vec1 - CurrentCamera.CFrame.Position).Magnitude then
        return
    end

    for _, val in t1 do
        local v1, v2, v3, v4, v5 = table.unpack(val)
        local t_1 = { v1, v2, v3, v4 }

        if v5 and v5 > 0 then
            task.delay(v5, _G.CameraShake, t_1)
        else
            _G.CameraShake(t_1)
        end
    end
end

local _ = function(vec2: Vector3) --[[ inRange ]] -- line: 89
    -- upvalues:
    --  [1] CurrentCamera (copy)

    return (vec2 - CurrentCamera.CFrame.Position).Magnitude <= 400
end

VFX_m.init()
VFX_m.preload(
    {
        Spatial.Portal.MiniPortal,
        Spatial["Rift Bloom"],
        Spatial.Mark.Lop.Floor,
        Spatial.Counter.HitEffect
    }
)

local function makeSigil() -- line: 98
    -- upvalues:
    --  [1] Spatial (copy)
    --  [2] t (copy)

    local v7 = Spatial.Mark.Lop.Floor:Clone()

    for _, child in v7:GetChildren() do
        if child:IsA("ParticleEmitter") and not t.SigilEmitters[child.Name] then
            child:Destroy()
        end
    end

    return v7
end

local t_2 = {
    Sigil = makeSigil(),
    Portal = Spatial.Portal.MiniPortal,
    Sword = Spatial["Rift Bloom"].MiniSword,
    HitEffect = Spatial.Counter.HitEffect
}
local v8 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(-0, -1, -0), Vector3.new(-0, -0, -1)):ToObjectSpace(
    t_2.Sword.CFrame.Rotation
)
local t_3 = {}

local function artFor(arg1: any, u1: userdata) -- line: 123
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t (copy)
    --  [3] GrimoireRarity_m (copy)
    --  [4] t_2 (copy)

    if typeof(arg1) == "string" and t_3[arg1] then
        return t_3[arg1]
    end

    local v9 = if t.Color then { Primary = t.Color } else GrimoireRarity_m:GetSkillVariant(
        u1,
        "Spatial"
    )

    if not v9 then
        return t_2
    end

    local t_4 = {}

    for key_2, val_1 in t_2 do
        local v11 = val_1:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v11, v9)
        t_4[key_2] = v11
    end

    if typeof(arg1) == "string" then
        t_3[arg1] = t_4
    end

    task.delay(4, function() -- line: 144
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] t_3 (ref)
        --  [3] t_4 (copy)

        if typeof(arg1) == "string" then
            t_3[arg1] = nil
        end

        for _, val_2 in t_4 do
            val_2:Destroy()
        end
    end)

    return t_4
end

local function ring(u2: CFrame) -- line: 158
    -- upvalues:
    --  [1] Bloom (copy)

    local v12 = u2.Position + Vector3.new(0, Bloom.PortalHeight, 0)
    local t_5 = table.create(Bloom.PortalCount)

    for index = 0, Bloom.PortalCount - 1 do
        local _ = Bloom.PortalCount - 1
        local LookVector = (u2 * CFrame.Angles(
            0,
            index * (6.283185307179586 / Bloom.PortalCount),
            0
        )).LookVector
        local v14 = v12 + LookVector * Bloom.PortalRadius
        table.insert(t_5, CFrame.lookAt(v14, v14 + LookVector))
    end

    return t_5
end

local function stripToTrails(u3: userdata) -- line: 173
    for _, descendant in u3:GetDescendants() do
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

local function thrust(arg2: any, u4: CFrame) -- line: 182
    -- upvalues:
    --  [1] v8 (copy)
    --  [2] t (copy)
    --  [3] Bloom (copy)
    --  [4] VFX_m (copy)
    --  [5] TweenService (copy)
    --  [6] stripToTrails (copy)

    local v15 = u4.Rotation * v8
    local LookVector_1 = u4.LookVector
    local v16 = CFrame.new(u4.Position + LookVector_1 * t.SwordStart) * v15
    local v17 = CFrame.new(u4.Position + LookVector_1 * Bloom.ThrustReach) * v15
    local v18 = Bloom.ThrustTime + Bloom.HoldTime + Bloom.RetractTime
    local v19 = VFX_m.burst(arg2.Sword, v16, workspace.Effects, v18 + t.SwordLinger)
    v19.Anchored = true

    for _, val_3 in v19:QueryDescendants("Trail") do
        val_3.Enabled = true
    end

    TweenService:Create(
        v19,
        TweenInfo.new(Bloom.ThrustTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { CFrame = v17 }
    ):Play()
    task.delay(Bloom.ThrustTime + Bloom.HoldTime, function() -- line: 201
        -- upvalues:
        --  [1] v19 (copy)
        --  [2] TweenService (ref)
        --  [3] Bloom (ref)
        --  [4] v16 (copy)

        if not v19.Parent then
            return
        end

        TweenService:Create(
            v19,
            TweenInfo.new(Bloom.RetractTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            { CFrame = v16 }
        ):Play()
    end)
    task.delay(v18, function() -- line: 212
        -- upvalues:
        --  [1] v19 (copy)
        --  [2] stripToTrails (ref)
        --  [3] t (ref)

        if v19.Parent then
            stripToTrails(v19)
        end

        task.delay(t.SwordLinger, function() -- line: 216
            -- upvalues:
            --  [1] v19 (ref)

            v19:Destroy()
        end)
    end)
end

local function main(arg3) -- line: 222
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] VFX_m (copy)
    --  [3] artFor (copy)
    --  [4] t (copy)
    --  [5] ring (copy)
    --  [6] thrust (copy)
    --  [7] shake (copy)

    local Character = arg3.Character
    local Action = arg3.Action
    local CastId = arg3.CastId
    local Position_1 = arg3.Position

    if not Character then
        return
    end

    if Action == "Hit" then
        local Root = arg3.Root

        if typeof(Root) == "Instance" and Root:IsA("BasePart") then
            if if not ((Root.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
                VFX_m.burst(artFor(CastId, Character).HitEffect, Root.CFrame)
            end
        end

        return
    end

    local EndPosition

    if typeof(Position_1) == "CFrame" then
        if not (if not ((Position_1.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true) then
            return
        end

        local v25 = artFor(CastId, Character)

        if Action == "Bloom" then
            EndPosition = arg3.EndPosition

            if typeof(EndPosition) == "Vector3" then
                VFX_m.burst(
                    v25.Sigil,
                    CFrame.new(EndPosition + Vector3.new(0, t.SigilHeight, 0)) * Position_1.Rotation
                )
            end

            for key_6, val_4 in ring(Position_1) do
                task.delay(t.PortalOpenDelay + t.PortalStagger * (key_6 - 1), function() -- line: 253
                    -- upvalues:
                    --  [1] VFX_m (ref)
                    --  [2] v25 (copy)
                    --  [3] val_4 (copy)

                    VFX_m.burstChild(v25.Portal, val_4, "Open")
                end)
            end

            return
        end

        if Action == "Thrust" then
            for _, val_5 in ring(Position_1) do
                thrust(v25, val_5)
            end

            shake(Position_1.Position, t.ThrustShakeDistance, t.ThrustShake)

            return
        end

        if Action == "Close" or Action == "Cancel" then
            for _, val_6 in ring(Position_1) do
                VFX_m.burstChild(v25.Portal, val_6, "Close")
            end
        end

        return
    else
        return
    end
end

return main
