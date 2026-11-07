-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.LizardBoss.LizardStomp_FX
-- Class: ModuleScript
-- bytes: 3898

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local _ = require(Modules.CameraShaker)
local _ = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include
VFX_m.init()
local rng = Random.new()

local function debrisCircle(
    vec1: Vector3,
    n1: number,
    u1: userdata,
    n2: number,
    vec2: Vector3
) -- line: 24
    -- upvalues:
    --  [1] rng (copy)
    --  [2] Services_m (copy)

    local v2 = vec1 + Vector3.new(0, -8, 0)
    local v3 = 6.283185307179586 / (n2 or 15)
    local v4

    for index = 1, n2 or 15 do
        v4 = v3 * index
        local v7 = v4 + rng:NextNumber(-v3 * 0.3, v3 * 0.3)
        v4 = n1 + rng:NextInteger(3, 12)
        local v8 = vec1.X + math.cos(v7) * v4
        local v9 = Vector3.new(v8, vec1.Y - 2.4, vec1.Z + math.sin(v7) * v4) + Vector3.new(0, 0.75, 0)
        local v10 = CFrame.lookAt(v9, vec1).LookVector * 8
        local v4 = Instance.new("Part")
        Services_m.Debris(v4, 6)
        v4.Size = Vector3.new(0, 0, 0)
        v4.CFrame = CFrame.lookAt(v9 + v10, v2)
        v4.Anchored = true
        v4.CanCollide = false
        v4.CanQuery = false
        v4.CanTouch = false
        v4.CastShadow = false
        v4.Name = "Circle_Debris"
        local v11 = u1 and u1.Color or Color3.fromRGB(86, 80, 76)
        v4.Color = v11
        v11 = u1 and u1.Material or Enum.Material.Slate
        v4.Material = v11
        v11 = u1 and u1.MaterialVariant
        v4.MaterialVariant = v11
        v4.Parent = workspace.Effects
        _G.Tween(
            v4,
            { 0.3, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = vec2 or Vector3.new(7, 5, 3), Position = v9 }
        )
        task.delay(rng:NextNumber(2, 4), function() -- line: 61
            -- upvalues:
            --  [1] v4 (copy)

            _G.Tween(
                v4,
                { 1.5, "Linear", Enum.EasingDirection.Out },
                { Position = v4.Position + Vector3.new(0, -3, 0) }
            )
        end)
    end
end

return function(arg1, arg2, arg3, arg4) -- line: 67
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] debrisCircle (copy)
    --  [3] VFX_m (copy)
    --  [4] ForgeVFX_m (copy)

    if arg2 and (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg1 == "Stomp" then
        local v13 = Color3.fromRGB(147, 147, 147)
        local _ = Enum.Material.Slate
        local v14 = nil

        for _, val in arg3.Parent:QueryDescendants("Bone") do
            if val.Name == "toes_01.l" then
                v14 = val.WorldPosition
            end
        end

        arg4 = v14
        v14 = workspace:Raycast(arg4 + Vector3.new(0, 5, 0), Vector3.new(0, -30, 0), raycastParams)

        if v14 and v14.Instance then
            arg4 = v14.Position
            local Material = v14.Instance.Material
            v13 = v14.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v14.Instance.Color
            debrisCircle(v14.Position, 6, v14.Instance, 15)
        end

        local v17 = script.Stomp:Clone()
        _G.Debris(VFX_m, 4)
        v17.CFrame = CFrame.new(arg4)
        v17.Parent = workspace.Effects
        task.wait()

        for _, val_1 in v17:QueryDescendants("ParticleEmitter, #Smoke, #Rock") do
            val_1.Color = ColorSequence.new(v13)
        end

        ForgeVFX_m.emit(v17)
    end
end
