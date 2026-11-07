-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.Elderthorne
-- Class: ModuleScript
-- bytes: 1372

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {
    workspace.Map,
    workspace:FindFirstChild("MapMisc"),
    workspace.Terrain
}
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function main(arg1, arg2, _) -- line: 16
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] Effects (copy)
    --  [3] Utility_m (copy)

    if arg1 == "SlideEmit" then
        local v2 = script.Dash:Clone()
        local v3 = workspace:Raycast(arg2.Position, Vector3.new(0, -3, 0), raycastParams)

        if v3 and v3.Instance then
            Effects:SetParticleColor(v2, v3.Instance.Color)
        end

        v2.CFrame = arg2 * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        _G.Debris(v2, 4)

        return
    end

    if arg1 == "Lunge" then
        local v5 = script.LungeHit:Clone()
        v5.CFrame = arg2
        v5.CFrame = v5.CFrame * CFrame.new(0, 0, -2)
        v5.Parent = workspace.Effects
        Utility_m.EmitParticles(v5)
    end
end

return main
