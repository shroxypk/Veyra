-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.katana_client
-- Class: ModuleScript
-- bytes: 1358

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.ReplicatedStorage
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

    local v2 = ...

    if not v2 then
        return
    end

    if arg1 == "Slam" then
        local v4 = (v2.CFrame * CFrame.new(0, 0, -7)).Position
        local v5 = workspace:Raycast(v4, Vector3.new(0, -8, 0), raycastParams)
        local v6

        if v5 then
            if v5.Instance then
                v6 = v5.Instance.Color
                v4 = v5.Position
            else
                v6 = Color3.fromRGB(107, 107, 107)
                v4 -= Vector3.new(0, 3.5, 0)
            end
        else
            v6 = Color3.fromRGB(107, 107, 107)
            v4 -= Vector3.new(0, 3.5, 0)
        end

        local v7 = script.Part:Clone()
        v7.Position = v4
        v7.Parent = workspace.Effects
        Effects:SetParticleColor(v7, v6)
        VFX.Emit2(v7, true)
        _G.Debris(v7, 2)
    end
end

return Attack
