-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.PrimAxeSlam
-- Class: ModuleScript
-- bytes: 924

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)

return function(arg1, arg2, _) -- line: 9
    -- upvalues:
    --  [1] Utility_m (copy)

    if not arg2 or (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    if arg1 == "Slam" then
        _G.PlaySound(script.Slam, arg2)
        local v2 = script.GroundImpact:Clone()
        _G.Debris(v2, 4)
        v2.CFrame = arg2
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)

        return
    end

    if arg1 == "Pull" then
        _G.PlaySound(script.Pull, arg2)
        local v3 = script.GroundPull:Clone()
        _G.Debris(v3, 4)
        v3.CFrame = arg2
        v3.Parent = workspace.Effects
        Utility_m.EmitParticles(v3)
    end
end
