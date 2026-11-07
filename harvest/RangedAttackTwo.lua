-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Mushroom.RangedAttackTwo
-- Class: ModuleScript
-- bytes: 607

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.TweenService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)

return function(arg1, arg2) -- line: 14
    -- upvalues:
    --  [1] Utility_m (copy)

    if arg1 == "Explosion" then
        local v2 = script.Expo:Clone()
        _G.Debris(v2, 4)
        v2:PivotTo(CFrame.new(arg2.Position))
        v2.Parent = workspace.Effects
        task.wait(0.1)
        Utility_m.EmitParticles(v2)
    end
end
