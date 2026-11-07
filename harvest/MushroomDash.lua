-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Mushroom.MushroomDash
-- Class: ModuleScript
-- bytes: 561

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.TweenService
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)

return function(arg1, arg2, _) -- line: 14
    -- upvalues:
    --  [1] Utility_m (copy)

    if arg1 == "Dash" then
        local v2 = script.Dash:Clone()
        v2.CFrame = arg2
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        _G.Debris(v2, 4)
    end
end
