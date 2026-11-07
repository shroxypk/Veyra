-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.dagger_client
-- Class: ModuleScript
-- bytes: 1027

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)

return function(arg1, arg2, ...) -- line: 10
    -- upvalues:
    --  [1] Utility_m (copy)

    if not arg1 or (arg1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local PrimaryPart = arg1.PrimaryPart

    if arg2 == "Strike" then
        local v2 = script.FX:Clone()
        v2.Anchored = false
        v2.CFrame = PrimaryPart.CFrame
        v2.Parent = workspace.Effects
        _G.Debris(v2, 3)
        Utility_m.CreateWeld(v2, PrimaryPart).C0 = CFrame.new(0, 0, 6)
        Utility_m.ParticleHandler(v2, true)
        task.delay(0.2, function() -- line: 29
            -- upvalues:
            --  [1] Utility_m (ref)
            --  [2] v2 (copy)

            Utility_m.ParticleHandler(v2, false)
        end)
    end
end
