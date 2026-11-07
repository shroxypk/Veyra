-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Misc.Bomb
-- Class: ModuleScript
-- bytes: 848

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.TweenService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(ReplicatedStorage.Modules.Utility)

return function(arg1, arg2) -- line: 14
    -- upvalues:
    --  [1] Utility_m (copy)
    --  [2] ReplicatedStorage (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg1 == "Explosion" then
        local v2 = script.Expo:Clone()
        _G.Debris(v2, 5)
        v2:PivotTo(CFrame.new(arg2.Position))
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        _G.PlaySound(ReplicatedStorage.SFX.Explosions.BombExplosion, v2)
    end
end
