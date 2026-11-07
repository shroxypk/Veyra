-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.LizardBoss.LizardLeap_FX
-- Class: ModuleScript
-- bytes: 3455

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local ReplicatedStorage = Services_m.ReplicatedStorage
local rng = Random.new()
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function debrisCircle(
    vec1: Vector3,
    n1: number,
    u1: Ray,
    n2: number,
    vec2: Vector3
) -- line: 19
    -- upvalues:
    --  [1] rng (copy)
    --  [2] Services_m (copy)

    local v2 = vec1 + Vector3.new(0, -8, 0)
    local v3 = 6.283185307179586 / n2
    local v9

    for index = 1, n2 do
        local v7 = v3 * index + rng:NextNumber(-v3 * 0.3, v3 * 0.3)
        local v8 = n1 + rng:NextInteger(3, 12)
        v9 = vec1.X + math.cos(v7) * v8
        local v10 = Vector3.new(v9, vec1.Y - 2.4, vec1.Z + math.sin(v7) * v8) + Vector3.new(0, 0.75, 0)
        local v11 = CFrame.lookAt(v10, vec1).LookVector * 10
        local v9 = Instance.new("Part")
        Services_m.Debris(v9, 6)
        v9.Size = Vector3.new(0, 0, 0)
        v9.CFrame = CFrame.lookAt(v10 + v11, v2)
        v9.Anchored = true
        v9.CanCollide = false
        v9.CanQuery = false
        v9.CanTouch = false
        v9.CastShadow = false
        v9.Name = "Circle_Debris"
        local v12 = u1 and u1.Instance.Color or Color3.fromRGB(86, 80, 76)
        v9.Color = v12
        v12 = u1 and u1.Instance.Material or Enum.Material.Slate
        v9.Material = v12
        v12 = u1 and u1.Instance.MaterialVariant
        v9.MaterialVariant = v12
        v9.Parent = workspace.Effects
        _G.Tween(
            v9,
            { 0.3, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = vec2, Position = v10 }
        )
        task.delay(rng:NextNumber(2, 4), function() -- line: 56
            -- upvalues:
            --  [1] v9 (copy)

            _G.Tween(
                v9,
                { 1.5, "Linear", Enum.EasingDirection.Out },
                { Position = v9.Position + Vector3.new(0, -3, 0) }
            )
        end)
    end
end

return function(arg1, arg2, _) -- line: 62
    -- upvalues:
    --  [1] Utility_m (copy)
    --  [2] Services_m (copy)
    --  [3] raycastParams (copy)
    --  [4] debrisCircle (copy)

    if arg2 and (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg1 == "Leap" then
        local v14 = script.Leap:Clone()
        v14.CFrame = arg2 * CFrame.new(0, 4, 0)
        v14.Parent = workspace.Effects
        Utility_m.EmitParticles(v14, true)
        Services_m.Debris(v14, 2)

        return
    end

    if arg1 == "Slam" then
        local v16 = workspace:Raycast(
            arg2.Position + Vector3.new(0, 5, 0),
            Vector3.new(0, -7, 0),
            raycastParams
        )

        if v16 and v16.Instance then
            arg2 = CFrame.new(v16.Position)
            debrisCircle(
                v16.Position,
                16,
                v16,
                22,
                Vector3.new(9, 6, 3.5)
            )
        end

        local v17 = script.Slam:Clone()
        v17.CFrame = arg2
        v17.Parent = workspace.Effects
        Utility_m.EmitParticles(v17)
        Services_m.Debris(v17, 4)
    end
end
