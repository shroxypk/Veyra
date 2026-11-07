-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Spatial.SpatialVolley_FX
-- Class: ModuleScript
-- bytes: 9380

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local SpatialVolley_m = require(Modules.Shared.SpatialVolley)
local SpatialVolley = ReplicatedStorage.Effects.VFX.Spatial["Spatial Volley"]
local CurrentCamera = workspace.CurrentCamera
local t = {
    Portal = SpatialVolley.Portal,
    Shoot = SpatialVolley.Shoot,
    Projectile = SpatialVolley.Projectile,
    Emit = SpatialVolley.Emit
}
local t_1 = {
    Color = Color3.fromRGB(65, 1, 255),
    PortalRotation = CFrame.identity,
    ShootRotation = CFrame.Angles(0, 3.141592653589793, 0),
    ProjectileRotation = CFrame.identity,
    ShootOffset = CFrame.new(0, 0, -7),
    EmitHeight = 2.8,
    ProjectileLinger = 0.4,
    LandShake = { 1.2, 10, 0, 0.2 },
    LandShakeDistance = 120
}

local _ = function(vec1: Vector3, n1: number, t1: table) --[[ shake ]] -- line: 78
    -- upvalues:
    --  [1] CurrentCamera (copy)

    if not _G.CameraShake then
        return
    end

    if n1 < (vec1 - CurrentCamera.CFrame.Position).Magnitude then
        return
    end

    _G.CameraShake(t1)
end

local function prepareArt(arg1) -- line: 92
    -- upvalues:
    --  [1] t (copy)
    --  [2] GrimoireRarity_m (copy)

    if not arg1 then
        return t, function() -- line: 94
        end
    end

    local t_2 = {}

    for key, val in t do
        local v2 = val:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v2, arg1)
        t_2[key] = v2
    end

    return t_2, function() -- line: 104
        -- upvalues:
        --  [1] t_2 (copy)

        for _, val_1 in t_2 do
            val_1:Destroy()
        end
    end
end

local function burstModel(u1: userdata, u2: CFrame) -- line: 113
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    local v3 = u1:Clone()
    v3:PivotTo(u2)
    v3.Parent = workspace
    local v4 = 0

    local function finished() -- line: 119
        -- upvalues:
        --  [1] v4 (ref)
        --  [2] v3 (copy)

        v4 -= 1

        if v4 <= 0 then
            v3:Destroy()
        end
    end

    for _, child in v3:GetChildren() do
        if not child:IsA("BasePart") then
            if not child:IsA("Model") then
                if child:IsA("Attachment") then
                    v4 += 1
                    ForgeVFX_m.emit(child).Finished:catch(function(arg2) -- line: 130
                        -- upvalues:
                        --  [1] u1 (copy)
                        --  [2] child (copy)

                        warn(`[SpatialVolley_FX] emit failed for {u1.Name}.{child.Name}: {arg2}`)
                    end):finally(finished)
                end
            else
                v4 += 1
                ForgeVFX_m.emit(child).Finished:catch(function(arg3) -- line: 130
                    -- upvalues:
                    --  [1] u1 (copy)
                    --  [2] child (copy)

                    warn(`[SpatialVolley_FX] emit failed for {u1.Name}.{child.Name}: {arg3}`)
                end):finally(finished)
            end
        else
            v4 += 1
            ForgeVFX_m.emit(child).Finished:catch(function(arg4) -- line: 130
                -- upvalues:
                --  [1] u1 (copy)
                --  [2] child (copy)

                warn(`[SpatialVolley_FX] emit failed for {u1.Name}.{child.Name}: {arg4}`)
            end):finally(finished)
        end
    end

    if v4 == 0 then
        v3:Destroy()
    end

    return v3
end

local function stripToTrails(u3: userdata) -- line: 148
    u3.Transparency = 1

    for _, descendant in u3:GetDescendants() do
        if not descendant:IsA("ParticleEmitter") then
            if not descendant:IsA("Beam") then
                if not descendant:IsA("Light") then
                    if descendant:IsA("Decal") then
                        descendant:Destroy()
                    elseif descendant:IsA("BasePart") then
                        descendant.Transparency = 1
                    end
                else
                    descendant:Destroy()

                    if descendant:IsA("BasePart") then
                        descendant.Transparency = 1
                    end
                end
            else
                descendant:Destroy()

                if descendant:IsA("BasePart") then
                    descendant.Transparency = 1
                end
            end
        else
            descendant:Destroy()

            if descendant:IsA("BasePart") then
                descendant.Transparency = 1
            end
        end
    end
end

local function spawnShot(arg5: any, vec2: Vector3, vec3: Vector3, n2: number) -- line: 170
    -- upvalues:
    --  [1] SpatialVolley_m (copy)
    --  [2] VFX_m (copy)
    --  [3] t_1 (copy)
    --  [4] burstModel (copy)

    local cframe = CFrame.lookAt(vec2, vec3)
    local v5 = SpatialVolley_m.travelTime(vec2, vec3)
    VFX_m.burst(arg5.Portal, cframe * t_1.PortalRotation)
    burstModel(arg5.Shoot, cframe * t_1.ShootOffset * t_1.ShootRotation)
    local v6 = cframe * t_1.ProjectileRotation
    local v7 = VFX_m.burst(arg5.Projectile, v6, nil, v5 + t_1.ProjectileLinger)
    v7.Anchored = true

    for _, val_2 in v7:QueryDescendants("Trail") do
        val_2.Enabled = true
    end

    return {
        Part = v7,
        From = v6,
        Travel = vec3 - vec2,
        SpawnAt = n2,
        LandAt = n2 + v5,
        Goal = vec3
    }
end

local function landShot(t2: table, arg6: any) -- line: 194
    -- upvalues:
    --  [1] stripToTrails (copy)
    --  [2] VFX_m (copy)
    --  [3] t_1 (copy)
    --  [4] CurrentCamera (copy)

    if t2.Part.Parent then
        t2.Part.CFrame = t2.From + t2.Travel
        stripToTrails(t2.Part)
    end

    VFX_m.burst(arg6.Emit, CFrame.new(t2.Goal + Vector3.new(0, t_1.EmitHeight, 0)))

    if not _G.CameraShake then
        return
    end

    if t_1.LandShakeDistance < (t2.Goal - CurrentCamera.CFrame.Position).Magnitude then
        return
    end

    _G.CameraShake(t_1.LandShake)
end

local function playVolley(u4: userdata, vec4: Vector3, buf1: buffer) -- line: 203
    -- upvalues:
    --  [1] SpatialVolley_m (copy)
    --  [2] t_1 (copy)
    --  [3] GrimoireRarity_m (copy)
    --  [4] prepareArt (copy)
    --  [5] RunService (copy)
    --  [6] spawnShot (copy)
    --  [7] landShot (copy)

    local v8, v9 = SpatialVolley_m.decode(vec4, buf1)
    local v10 = #v8

    if v10 == 0 then
        return
    end

    local v12, v13 = prepareArt(
        if t_1.Color then { Primary = t_1.Color } else GrimoireRarity_m:GetSkillVariant(
            u4,
            "Spatial"
        )
    )
    local t_6 = {}
    local t_4 = {}
    local t_5 = {}
    local clock = os.clock()
    local v15 = 1
    local v16 = nil
    v16 = RunService.Heartbeat:Connect(function() -- line: 221
        -- upvalues:
        --  [1] clock (copy)
        --  [2] v15 (ref)
        --  [3] v10 (copy)
        --  [4] SpatialVolley_m (ref)
        --  [5] t_6 (copy)
        --  [6] spawnShot (ref)
        --  [7] v12 (copy)
        --  [8] v8 (copy)
        --  [9] v9 (copy)
        --  [10] t_4 (copy)
        --  [11] t_5 (copy)
        --  [12] landShot (ref)
        --  [13] v16 (ref)
        --  [14] v13 (copy)

        local v17 = os.clock() - clock

        while true do
            if not (v15 <= v10) then
                break
            end

            local v18 = SpatialVolley_m.spawnTime(v15)

            if v17 < v18 then
                break
            end

            table.insert(t_6, (spawnShot(v12, v8[v15], v9[v15], v18)))
            v15 += 1
        end

        table.clear(t_4)
        table.clear(t_5)
        local v21 = 1

        while true do
            if not (v21 <= #t_6) then
                break
            end

            local v22 = t_6[v21]

            if v17 >= v22.LandAt or not v22.Part.Parent then
                landShot(v22, v12)
                t_6[v21] = t_6[#t_6]
                t_6[#t_6] = nil
                continue
            end

            local v23 = (v17 - v22.SpawnAt) / (v22.LandAt - v22.SpawnAt)
            table.insert(t_4, v22.Part)
            table.insert(t_5, v22.From + v22.Travel * v23)
            v21 += 1
        end

        if #t_4 > 0 then
            workspace:BulkMoveTo(t_4, t_5, Enum.BulkMoveMode.FireCFrameChanged)
        end

        if v15 > v10 and #t_6 == 0 then
            v16:Disconnect()
            v13()
        end
    end)
end

VFX_m.init()
VFX_m.preload({ SpatialVolley })

local function main(arg7) -- line: 271
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] playVolley (copy)

    local Character = arg7.Character
    local Position = arg7.Position
    local Shots = arg7.Shots

    if not Character then
        return
    end

    if arg7.Action == "Cast" then
        if typeof(Position) == "Vector3" then
            if typeof(Shots) ~= "buffer" then
                return
            end

            if (Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
                return
            end

            playVolley(Character, Position, Shots)

            return
        else
            return
        end
    else
        return
    end
end

return main
