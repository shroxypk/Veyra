-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.axe_client
-- Class: ModuleScript
-- bytes: 1660

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local VFX = Services_m.VFX
local g_require_1 = require
local CurrentCamera = workspace.CurrentCamera
g_require_1(ReplicatedStorage.Modules:FindFirstChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(
    arg1
) -- line: 9
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.FightableNPCS, workspace.pCharacters }
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

function Attack(arg2, ...) -- line: 22
    -- upvalues:
    --  [1] VFX (copy)
    --  [2] raycastParams (copy)
    --  [3] Effects (copy)

    local v2 = ...

    if not v2 then
        return
    end

    if arg2 == "Final" then
        local v3 = script.Rotate.Attachment:Clone()
        v3.Parent = v2
        VFX.Emit2(v3, true)
        _G.Debris(v3, 3)
        local v4 = workspace:Raycast(v2.Position, Vector3.new(0, -10, 0), raycastParams)

        if v4 and v4.Instance then
            local Material = v4.Material
            local v5 = v4.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v4.Instance.Color
            local Position = v4.Position
            local v6 = script.Dust:Clone()
            v6.Position = Position
            v6.Parent = workspace.Effects
            Effects:SetParticleColor(v6, v5, "Smoke")
            VFX.Emit2(v6, true)
            _G.Debris(v6, 3)
        end
    end
end

return Attack
