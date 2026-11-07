-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.staff_client
-- Class: ModuleScript
-- bytes: 2793

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local VFX = Services_m.VFX
local Effects = _G.GetModule("Effects")
local _ = _G.GetModule("DebrisCircle")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(arg1, ...) -- line: 15
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] Effects (copy)
    --  [3] VFX (copy)
    --  [4] ReplicatedStorage (copy)

    local v2 = ...

    if not v2 then
        return
    end

    if arg1 == "StaffSweep" then
        local v3 = workspace:Raycast(v2.Position, Vector3.new(0, -10, 0), raycastParams)

        if v3 and v3.Instance then
            local Material = v3.Material
            local v4 = v3.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v3.Instance.Color
            local Position = v3.Position
            local v5 = script.StaffCritFX:Clone()
            v5.Position = Position
            v5.Parent = workspace.Effects
            Effects:SetParticleColor(v5, v4, "Smoke")
            VFX.Emit2(v5, true)
            _G.Debris(v5, 2)

            return
        end
    else
        if arg1 == "StaffWind" then
            local v6 = script.StaffCritWind.Attachment:Clone()
            v6.Parent = v2
            VFX.Emit2(v6, true)
            _G.Debris(v6, 2)

            return
        end

        if arg1 == "StaffSlam" then
            local v8 = (v2.CFrame * CFrame.new(0, 0, -5)).Position
            local v9 = workspace:Raycast(v8, Vector3.new(0, -8, 0), raycastParams)
            local v11

            if v9 then
                if v9.Instance then
                    local Material_1 = v9.Material
                    v11 = v9.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                        Material_1
                    ) or v9.Instance.Color
                    v8 = v9.Position
                else
                    v11 = Color3.fromRGB(107, 107, 107)
                    v8 -= Vector3.new(0, 3.5, 0)
                end
            else
                v11 = Color3.fromRGB(107, 107, 107)
                v8 -= Vector3.new(0, 3.5, 0)
            end

            local v12 = script.Part:Clone()
            v12.Position = v8
            v12.Parent = workspace.Effects
            Effects:SetParticleColor(v12, v11)
            VFX.Emit2(v12, true)
            _G.Debris(v12, 2)
            _G.PlaySound(
                ReplicatedStorage.SFX.Explosions.RockDebris1,
                v2,
                150,
                0.75,
                2.1,
                nil
            )
        end
    end
end

return Attack
