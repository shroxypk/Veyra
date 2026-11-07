-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Spatial.PhaseFlurry_FX
-- Class: ModuleScript
-- bytes: 12750

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local Services_m = require(game:GetService("ReplicatedFirst").Services)
local VFX_m = require(Modules.Shared.VFX)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local Skills_m = require(Modules.Skills)
local Spatial = ReplicatedStorage.Effects.VFX.Spatial
local Flurry = Skills_m:LookupSkill("Phase Flurry").Flurry
local CurrentCamera = workspace.CurrentCamera
local t = {
    Streak = Spatial["Spatial Volley"].Shoot,
    Emit = Spatial["Spatial Volley"].Emit,
    HitEffect = Spatial.Counter.HitEffect,
    Teleport = Spatial.Counter.Teleport,
    Portal = Spatial.Portal.Portal,
    KickDown = Spatial["Skyward Ascent"].LegKickDownwards,
    GroundFX = Spatial["Skyward Ascent"].GroundFX
}
local t_1 = {
    Color = nil,
    DefaultColor = Color3.fromRGB(65, 1, 255),
    AfterimageTransparency = 0.45,
    StreakRotation = CFrame.Angles(0, 3.141592653589793, 0),
    HitOffset = CFrame.identity,
    GroundFXHeight = 0.2,
    ImpactHeight = 2.8,
    HitShake = { { 1, 24, 0, 0.12, 0 } },
    HitShakeDistance = 80,
    SlamShake = { { 2.4, 28, 0, 0.18, 0 }, { 1.8, 30, 0, 0.18, 0.06 }, { 1.2, 26, 0, 0.22, 0.14 } },
    SlamShakeDistance = 140
}

local function shake(vec1: Vector3, n1: number, t1: table) -- line: 87
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
    KickDown = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(-0, -1, -0), Vector3.new(-0, -0, -1)):ToObjectSpace(
        t.KickDown.CFrame.Rotation
    ),
    GroundFX = t.GroundFX.CFrame.Rotation
}

local _ = function(u1: userdata) --[[ variantColors ]] -- line: 114
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] GrimoireRarity_m (copy)

    if t_1.Color then
        return { Primary = t_1.Color }
    end

    return (GrimoireRarity_m:GetSkillVariant(u1, "Spatial"))
end

local function prepareArt(arg1) -- line: 119
    -- upvalues:
    --  [1] t (copy)
    --  [2] GrimoireRarity_m (copy)

    if not arg1 then
        return t, function() -- line: 121
        end
    end

    local t_5 = {}

    for key_1, val_1 in t do
        local v8 = val_1:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v8, arg1)
        t_5[key_1] = v8
    end

    return t_5, function() -- line: 131
        -- upvalues:
        --  [1] t_5 (copy)

        for _, val_2 in t_5 do
            val_2:Destroy()
        end
    end
end

local t_6 = {}

local function artFor(arg2: any, u2: userdata) -- line: 141
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] prepareArt (copy)
    --  [3] t_1 (copy)
    --  [4] GrimoireRarity_m (copy)

    if typeof(arg2) == "string" and t_6[arg2] then
        return t_6[arg2]
    end

    local v11, v10 = prepareArt(
        if t_1.Color then { Primary = t_1.Color } else GrimoireRarity_m:GetSkillVariant(
            u2,
            "Spatial"
        )
    )

    if typeof(arg2) == "string" then
        t_6[arg2] = v11
    end

    task.delay(4, function() -- line: 152
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] t_6 (ref)
        --  [3] v10 (copy)

        if typeof(arg2) == "string" then
            t_6[arg2] = nil
        end

        v10()
    end)

    return v11
end

local function afterimage(u3: userdata, u4: CFrame) -- line: 165
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] Flurry (copy)
    --  [4] TweenService (copy)
    --  [5] Services_m (copy)

    local Archivable = u3.Archivable
    u3.Archivable = true
    local v12, Result = pcall(function() -- line: 168
        -- upvalues:
        --  [1] u3 (copy)

        return u3:Clone()
    end)
    u3.Archivable = Archivable

    if not v12 or not Result then
        return
    end

    v12 = if t_1.Color then { Primary = t_1.Color } else GrimoireRarity_m:GetSkillVariant(
        u3,
        "Spatial"
    )
    local v13 = v12 and v12.Primary or t_1.DefaultColor
    v12 = {}
    local t_7 = {}

    for _, descendant in Result:GetDescendants() do
        if descendant:IsA("BasePart") then
            local Parent = descendant.Parent

            if Parent ~= Result then
                if Parent then
                    if Parent:IsA("Accessory") then
                        table.insert(v12, descendant)
                    else
                        table.insert(t_7, descendant)
                    end
                else
                    table.insert(t_7, descendant)
                end
            else
                table.insert(v12, descendant)
                table.insert(t_7, descendant)
            end
        elseif not descendant:IsA("Accessory") and not descendant:IsA("JointInstance") and not descendant:IsA(
            "Attachment"
        ) and not descendant:IsA("DataModelMesh") then
            table.insert(t_7, descendant)
        end
    end

    for _, val_3 in t_7 do
        if val_3.Parent then
            val_3:Destroy()
        end
    end

    local t_8 = { Transparency = 1 }
    local tweenInfo = TweenInfo.new(
        Flurry.AfterimageTime,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.In
    )

    for _, val_4 in v12 do
        if val_4.Parent then
            local v14 = val_4.Transparency >= 1 or val_4.Name == "HumanoidRootPart"
            val_4.Anchored = true
            val_4.CanCollide = false
            val_4.CanQuery = false
            val_4.CanTouch = false
            val_4.CastShadow = false
            val_4.Material = Enum.Material.Neon
            val_4.Color = v13
            val_4.Transparency = if v14 then 1 else t_1.AfterimageTransparency

            if val_4:IsA("MeshPart") then
                val_4.TextureID = ""
            end

            local SpecialMesh = val_4:FindFirstChildWhichIsA("SpecialMesh")

            if SpecialMesh then
                SpecialMesh.TextureId = ""
            end

            if not v14 then
                TweenService:Create(val_4, tweenInfo, t_8):Play()
            end
        end
    end

    Result.Name = "FlurryAfterimage"
    Result:PivotTo(u4)
    Result.Parent = workspace.Effects
    Services_m.Debris(Result, Flurry.AfterimageTime + 0.1)
end

local t_9 = {}

local function setHidden(u5: userdata, b1: boolean) -- line: 239
    local v16 = if not b1 then 0 else 1

    for _, descendant_1 in u5:GetDescendants() do
        if not descendant_1:IsA("BasePart") then
            if descendant_1:IsA("Decal") then
                descendant_1.LocalTransparencyModifier = v16
            end
        else
            descendant_1.LocalTransparencyModifier = v16
        end
    end
end

local _ = function(u6: userdata, n2: number, f1: (...any) -> ...any) --[[ vanish ]] -- line: 248
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] setHidden (copy)

    local v17 = (t_9[u6] or 0) + 1
    t_9[u6] = v17
    setHidden(u6, true)
    task.delay(n2, function() -- line: 253
        -- upvalues:
        --  [1] t_9 (ref)
        --  [2] u6 (copy)
        --  [3] v17 (copy)
        --  [4] setHidden (ref)
        --  [5] f1 (copy)

        if t_9[u6] ~= v17 then
            return
        end

        t_9[u6] = nil

        if u6.Parent then
            setHidden(u6, false)
        end

        f1()
    end)
end

VFX_m.init()
VFX_m.preload(
    { Spatial["Spatial Volley"], Spatial.Counter, Spatial.Portal, Spatial["Skyward Ascent"] }
)

local _ = function(vec2: Vector3) --[[ inRange ]] -- line: 268
    -- upvalues:
    --  [1] CurrentCamera (copy)

    return (vec2 - CurrentCamera.CFrame.Position).Magnitude <= 400
end

local function main(arg3) -- line: 272
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] artFor (copy)
    --  [3] t_1 (copy)
    --  [4] VFX_m (copy)
    --  [5] shake (copy)
    --  [6] afterimage (copy)
    --  [7] Flurry (copy)
    --  [8] t_9 (copy)
    --  [9] setHidden (copy)
    --  [10] t_3 (copy)

    local Character = arg3.Character
    local Action = arg3.Action
    local CastId = arg3.CastId
    local _ = arg3.Root
    local Position = arg3.Position
    local EndPosition = arg3.EndPosition
    local Position_1, Position_2, Position_4

    if Character then
        if typeof(Position) ~= "CFrame" then
            return
        end

        if Action == "Dash" then
            Position_1 = Position.Position
            local v20 = (Position_1 - CurrentCamera.CFrame.Position).Magnitude <= 400 and true

            if v20 then
                v20 = artFor(CastId, Character)
                local v22 = Position * t_1.StreakRotation
                VFX_m.burstChild(v20.Streak, v22, "Dash")
                VFX_m.burstChild(v20.Streak, v22, "Slim")

                return
            end
        else
            if Action == "Hit" then
                Position_2 = Position.Position

                if if not ((Position_2 - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
                    VFX_m.burst(artFor(CastId, Character).HitEffect, Position * t_1.HitOffset)
                end

                shake(Position.Position, t_1.HitShakeDistance, t_1.HitShake)

                return
            end

            local v25

            if Action == "Blink" then
                if typeof(EndPosition) ~= "CFrame" then
                    return
                end

                local v26 = artFor(CastId, Character)
                v25 = (Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400 and true or (EndPosition.Position - CurrentCamera.CFrame.Position).Magnitude <= 400

                if v25 then
                    VFX_m.burst(v26.Teleport, CFrame.new(Position.Position))
                    afterimage(Character, Position)
                end

                local function v27() -- line: 311
                    -- upvalues:
                    --  [1] v25 (copy)
                    --  [2] VFX_m (ref)
                    --  [3] v26 (copy)
                    --  [4] EndPosition (copy)

                    if v25 then
                        VFX_m.burstChild(v26.Portal, EndPosition, "Close")
                    end
                end

                local v28 = (t_9[Character] or 0) + 1
                local VanishTime = Flurry.VanishTime
                t_9[Character] = v28
                setHidden(Character, true)
                task.delay(VanishTime, function() -- line: 253
                    -- upvalues:
                    --  [1] t_9 (ref)
                    --  [2] Character (copy)
                    --  [3] v28 (copy)
                    --  [4] setHidden (ref)
                    --  [5] v27 (copy)

                    if t_9[Character] ~= v28 then
                        return
                    end

                    t_9[Character] = nil

                    if Character.Parent then
                        setHidden(Character, false)
                    end

                    v27()
                end)

                return
            elseif Action == "Slam" then
                v25 = Position.Position
                local v26 = (v25 - CurrentCamera.CFrame.Position).Magnitude <= 400 and true

                if v26 then
                    v26 = artFor(CastId, Character)

                    if typeof(EndPosition) == "CFrame" then
                        Position_4 = EndPosition.Position
                        VFX_m.burst(
                            v26.KickDown,
                            CFrame.lookAt(
                                Position_4,
                                Position_4 - Vector3.new(0, 1, 0),
                                EndPosition.LookVector
                            ) * t_3.KickDown
                        )
                    end

                    VFX_m.burst(
                        v26.GroundFX,
                        Position * CFrame.new(0, t_1.GroundFXHeight, 0) * t_3.GroundFX
                    )
                    VFX_m.burstChild(
                        v26.Emit,
                        CFrame.new(Position.Position + Vector3.new(0, t_1.ImpactHeight, 0)),
                        "IMpactCore"
                    )
                end

                shake(Position.Position, t_1.SlamShakeDistance, t_1.SlamShake)
            end
        end

        return
    else
        return
    end
end

return main
