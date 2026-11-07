-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.OgreRush
-- Class: ModuleScript
-- bytes: 1690

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local VFX = Services_m.VFX
local g_require_1 = require
local CurrentCamera = workspace.CurrentCamera
local v2 = g_require_1(ReplicatedStorage.Modules:FindFirstChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(
    arg1
) -- line: 11
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v2:Start()
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(...) -- line: 24
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] raycastParams (copy)
    --  [3] VFX (copy)

    local v3, _, _ = ...

    if (v3.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    v2:ShakeOnce(7, 7, 0, 0.25)
    _G.PlaySound(
        script.Dash,
        v3,
        nil,
        nil,
        nil,
        nil
    )
    local v6 = script.FX:Clone()
    _G.Debris(v6, 4)
    v6:PivotTo(v3)
    v6.Parent = workspace.Effects
    wait()
    local v7 = workspace:Raycast(v3.Position, Vector3.new(0, -20, 0), raycastParams)

    if v7 and v7.Instance then
        local Material = v7.Material
        local v8 = v7.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v7.Instance.Color

        for _, val in pairs(v6:GetDescendants()) do
            if val:IsA("ParticleEmitter") and val.Name:match("Wind") then
                val.Color = ColorSequence.new(v8)
            end
        end
    end

    VFX.Emit2(v6, true)
end

return Attack
