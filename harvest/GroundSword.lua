-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Skills.GroundSword
-- Class: ModuleScript
-- bytes: 3454

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local rng = Random.new()
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace:FindFirstChild("MapMisc") }
raycastParams.IgnoreWater = true

local _ = function(arg1, arg2) --[[ getXAndZPositions ]] -- line: 21
    return math.cos(arg1) * arg2, math.sin(arg1) * arg2
end

return function(arg3, arg4, _) -- line: 27
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Utility_m (copy)
    --  [3] raycastParams (copy)
    --  [4] rng (copy)

    if arg3 == "GroundEmit" then
        local v3 = ReplicatedStorage.Effects.MagicFX.SwordGround.SwordOuttaGround:Clone()
        _G.Debris(v3, 3)
        v3:PivotTo(CFrame.new(arg4.Position))
        v3.CFrame = v3.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
        v3.Parent = workspace.Effects
        Utility_m.EmitParticles(v3)
        local v5 = arg4 * CFrame.new(0, 5, 0)
        local t_1 = {}

        for index = 1, 10 do
            local v6 = index * 0.6283185307179586
            local P = (v5 * CFrame.new(math.cos(v6) * 4.5, 0, math.sin(v6) * 4.5)).p
            local Position = v5.Position
            local v8 = script.Part:Clone()
            v8.Name = "circleParts"
            v8.CFrame = CFrame.new(P, Position)
            table.insert(t_1, v8)
            local v9 = workspace:Raycast(v8.Position, Vector3.new(0, -10, 0), raycastParams)

            if v9 then
                if v9.Instance then
                    local Material = v9.Material
                    local v10 = v9.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                        Material
                    ) or v9.Instance.Color
                    local Transparency = v9.Instance.Transparency
                    local v11 = 1.5 * rng:NextInteger(50, 120) / 100
                    local vec3 = Vector3.new(3, v11, v11)
                    v8.Color = v10
                    v8.Transparency = Transparency
                    v8.Material = Material

                    if v9.Instance.MaterialVariant ~= "" then
                        v8.MaterialVariant = v9.Instance.MaterialVariant
                    end

                    v8.Parent = workspace.Effects
                    _G.Tween(
                        v8,
                        { 0.2, "EntranceExpressive", Enum.EasingDirection.Out },
                        { Size = vec3 }
                    )
                    v8.CFrame = CFrame.lookAt(v9.Position, v5.Position) * CFrame.new(
                        0,
                        -vec3.Y / 10,
                        0
                    ) * CFrame.fromEulerAnglesXYZ(0.7853981633974483, 0, 0)
                else
                    v8:Destroy()
                end
            else
                v8:Destroy()
            end
        end

        task.wait(0.8)

        for _, val in pairs(t_1) do
            _G.Tween(
                val,
                { 0.25, "Smooth", Enum.EasingDirection.Out },
                { Transparency = 1, Size = Vector3.new(0, 0, 0) },
                true
            )
        end

        table.clear(t_1)
    end
end
