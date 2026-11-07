-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.OrbExplosion
-- Class: ModuleScript
-- bytes: 895

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local VFX = Services_m.VFX
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(arg1, ...) -- line: 15
    -- upvalues:
    --  [1] VFX (copy)
    --  [2] ReplicatedStorage (copy)

    if arg1 == "FX" then
        local Position = (...).Position
        local v2 = script["Balls Explode"]:Clone()
        v2.Position = Position + Vector3.new(0, 0.5, 0)
        v2.Parent = workspace.Effects
        VFX.Emit2(v2, true)
        _G.Debris(v2, 2)
        _G.PlaySound(
            ReplicatedStorage.SFX.Explosions.Explosion8,
            v2,
            nil,
            nil,
            nil,
            nil
        )
    end
end

return Attack
