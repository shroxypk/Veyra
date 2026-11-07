-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Lizard.Cleave
-- Class: ModuleScript
-- bytes: 884

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2, _) -- line: 17
    -- upvalues:
    --  [1] Utility_m (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg1 == "Slash" then
        local v2 = script.Slash:Clone()
        _G.Debris(v2, 4)
        v2.CFrame = arg2 * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 1.4, 0)
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
    end
end
