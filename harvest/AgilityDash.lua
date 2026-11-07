-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Physical.AgilityDash
-- Class: ModuleScript
-- bytes: 1791

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.TweenService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { workspace.FightableNPCS, workspace.pCharacters }
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local _ = _G.GetModule("Effects")

return function(arg1, arg2) -- line: 16
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Utility_m (copy)
    --  [4] Services_m (copy)

    if not arg2 or (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg1 == "Ground" then
        local v2 = workspace:Raycast(arg2.Position, Vector3.new(0, -10, 0), raycastParams)

        if v2 and v2.Instance then
            local v3 = ReplicatedStorage.Effects.SlideDust:Clone()
            _G.Debris(v3, 2)
            v3.Dust.Color = ColorSequence.new(v2.Instance.Color)
            v3.Position = v2.Position
            v3.Parent = workspace.Effects
            Utility_m.EmitParticles(v3)

            return
        end
    else
        local v4 = script.vfx:Clone()
        Services_m.Debris(v4, 2)
        v4.CFrame = arg2.CFrame * CFrame.new(0, 0, -2)
        local WeldConstraint = Instance.new("WeldConstraint")
        WeldConstraint.Part0 = arg2
        WeldConstraint.Part1 = v4
        WeldConstraint.Parent = v4
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
        task.wait(0.15)
        WeldConstraint:Destroy()
        v4.Anchored = true
    end
end
