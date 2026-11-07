-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Hollowseer.MinionExplode
-- Class: ModuleScript
-- bytes: 686

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local _ = Services_m.TweenService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)

return function(arg1, arg2) -- line: 14
    -- upvalues:
    --  [1] Utility_m (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg1 == "Explode" then
        local v2 = script.Expo:Clone()
        v2.CFrame = arg2
        v2.Parent = workspace.Effects
        wait()
        Utility_m.EmitParticles(v2)
        _G.Debris(v2, 2)
    end
end
