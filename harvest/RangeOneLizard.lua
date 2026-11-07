-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Lizard.RangeOneLizard
-- Class: ModuleScript
-- bytes: 720

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2) -- line: 17
    -- upvalues:
    --  [1] Utility_m (copy)

    if arg1 == "Explosion" then
        local v2 = script.Hit:Clone()
        v2:PivotTo(CFrame.new(arg2))
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        _G.Debris(v2, 5)
    end
end
