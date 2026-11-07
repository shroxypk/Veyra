-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Skills.Lunge
-- Class: ModuleScript
-- bytes: 902

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2) -- line: 17
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Utility_m (copy)

    if arg1 == "LungeEmit" then
        local v2 = ReplicatedStorage.Effects.MagicFX.Lunge.Dash:Clone()
        v2.CFrame = arg2
        v2.CFrame = v2.CFrame * CFrame.new(0, 0, -10) * CFrame.Angles(0, 0, 0)
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        _G.Debris(v2, 4)
    end
end
