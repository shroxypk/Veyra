-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Physical.KunLinKick
-- Class: ModuleScript
-- bytes: 1570

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2, arg3) -- line: 17
    -- upvalues:
    --  [1] Utility_m (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 or not arg3 then
        return
    end

    if arg1 == "LungeEmit" then
        local v2 = script.Dash:Clone()
        v2.CFrame = arg2
        v2.CFrame = v2.CFrame * CFrame.new(0, 0, -10) * CFrame.Angles(0, 0, 0)
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        task.delay(0.4, function() -- line: 27
            -- upvalues:
            --  [1] v2 (copy)

            _G.Debris(v2, 3)
        end)
        _G.Debris(v2, 4)

        return
    end

    if arg1 == "Slash" then
        local v5 = script.Spin:Clone()
        v5.CFrame = arg2 * CFrame.Angles(1.5707963267948966, 0, 0)
        v5.Parent = workspace.Effects
        local Weld = Instance.new("Weld")
        Weld.Part0 = arg3
        Weld.Part1 = v5
        Weld.C0 = CFrame.new(0, 0.5, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
        Weld.Parent = arg3
        Utility_m.EmitParticles(v5)
        task.wait(1.5)
        _G.Debris(v5, 3)
        _G.Debris(Weld, 3)
    end
end
