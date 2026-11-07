-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Skills.LeapProjec
-- Class: ModuleScript
-- bytes: 1777

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {
    workspace.Map,
    workspace.Terrain,
    workspace:FindFirstChild("MapMisc")
}
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2) -- line: 17
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Utility_m (copy)
    --  [3] raycastParams (copy)

    if arg1 == "LeapFX" then
        local v2 = ReplicatedStorage.Effects.MagicFX.LeapProjec.Leap:Clone()
        v2:PivotTo(CFrame.new(arg2.Position + Vector3.new(0, -2.5, 0)))
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        _G.Debris(v2, 4)

        return
    end

    if arg1 == "Explosion" then
        local v3 = ReplicatedStorage.Effects.MagicFX.LeapProjec.Expolosion:Clone()
        _G.Debris(v3, 5)
        v3:PivotTo(CFrame.new(arg2.Position))
        v3.Parent = workspace.Effects
        Utility_m.EmitParticles(v3)
        local v5 = workspace:Raycast(
            arg2.Position + Vector3.new(0, 1, 0),
            Vector3.new(0, -15, 0),
            raycastParams
        )

        if v5 and v5.Instance then
            local v6 = v5.Instance
            local Position = v5.Position
            _G.GetModule("RockParts")(
                CFrame.new(Position) * CFrame.new(0, 0.5, 0),
                math.random(2, 3),
                NumberRange.new(1, 4),
                { XZ = 16, Y = 65, Y2 = 75 },
                v6
            )
        end
    end
end
