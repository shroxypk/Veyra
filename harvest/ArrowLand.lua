-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.ArrowLand
-- Class: ModuleScript
-- bytes: 1714

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local VFX = Services_m.VFX
local Effects = _G.GetModule("Effects")
local _ = _G.GetModule("DebrisCircle")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(arg1, ...) -- line: 15
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] Effects (copy)
    --  [3] VFX (copy)
    --  [4] ReplicatedStorage (copy)

    local v2 = ...

    if arg1 == "Land" then
        local v3 = v2.Position
        local v4 = workspace:Raycast(v3, Vector3.new(0, -10, 0), raycastParams)
        local v5

        if v4 then
            if v4.Instance then
                v5 = v4.Instance.Color
                v3 = v4.Position
            else
                v5 = Color3.fromRGB(107, 107, 107)
                v3 -= Vector3.new(0, 1, 0)
            end
        else
            v5 = Color3.fromRGB(107, 107, 107)
            v3 -= Vector3.new(0, 1, 0)
        end

        local v6 = script.Part:Clone()
        v6.Position = v3
        v6.Parent = workspace.Effects
        Effects:SetParticleColor(v6, v5)
        VFX.Emit2(v6, true)
        _G.Debris(v6, 2)
        v5 = ReplicatedStorage.Effects.ArrowEruption:Clone()
        v5.Position = v2.Position + Vector3.new(0, 0.5, 0)
        v5.Parent = workspace.Effects
        VFX.Emit2(v5, true)
        _G.Debris(v5, 2)
        _G.PlaySound(
            ReplicatedStorage.SFX.Explosions.ArrowHit,
            v6,
            150,
            nil,
            nil,
            nil
        )
    end
end

return Attack
