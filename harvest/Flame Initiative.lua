-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Flame.Flame Initiative
-- Class: ModuleScript
-- bytes: 2138

local ReplicatedStorage = require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage
local Effects = _G.GetModule("Effects")
local _ = Color3.fromRGB(255, 85, 0)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(arg1, arg2) -- line: 15
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Effects (copy)
    --  [3] raycastParams (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    if arg1 == "Explosion" then
        _G.PlaySound(ReplicatedStorage.SFX.Explosions.Explosion4, arg2)
        local v1 = script.FireExplosion:Clone()
        _G.Debris(v1, 2)
        v1.CFrame = arg2
        v1.Parent = workspace.Effects
        Effects:EmitParticle(v1, 20)
        local v2 = ReplicatedStorage.Effects.Ball:Clone()
        v2.CFrame = arg2 * CFrame.new(0, -1, 0)
        v2.Color = Color3.fromRGB(255, 120, 66)
        v2.Material = Enum.Material.ForceField
        v2.Parent = workspace.Effects
        _G.Tween(
            v2,
            { 0.5, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(22, 22, 22), Transparency = 1 },
            true
        )
        local v3 = workspace:Raycast(arg2.Position, Vector3.new(0, -10, 0), raycastParams)

        if v3 and v3.Instance then
            local Material = v3.Material
            local _

            if v3.Instance:IsA("Terrain") then
                if not workspace.Terrain:GetMaterialColor(Material) then
                    _ = v3.Instance.Color
                end
            else
                _ = v3.Instance.Color
            end

            local Position = v3.Position
            local v4 = script.Wind:Clone()
            _G.Debris(v4, 1)
            v4.CFrame = CFrame.new(Position)
            v4.Parent = workspace.Effects
            Effects:EmitParticle(v4, 8)
            Effects:CreateGroundCrack(CFrame.new(Position), Vector3.new(18, 0, 18))
        end
    end
end

return Attack
