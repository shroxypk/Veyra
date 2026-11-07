-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.ScytheCrit
-- Class: ModuleScript
-- bytes: 1138

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)

local _ = function(arg1, arg2, arg3) --[[ Weld ]] -- line: 13
    local Weld = Instance.new("Weld")
    Weld.Name = arg1.Name .. "Weld"
    Weld.Part0 = arg1
    Weld.Part1 = arg2
    Weld.C0 = arg3
    Weld.Parent = arg2
end

return function(arg4, arg5) -- line: 22
    -- upvalues:
    --  [1] Utility_m (copy)

    if not arg5 or (arg5.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg4 == "Slash" then
        local v2 = script.Slash:Clone()
        _G.Debris(v2, 3)
        v2.CFrame = arg5.CFrame
        local cframe = CFrame.Angles(0, 3.839724354387525, 0)
        local Weld_2 = Instance.new("Weld")
        Weld_2.Name = arg5.Name .. "Weld"
        Weld_2.Part0 = arg5
        Weld_2.Part1 = v2
        Weld_2.C0 = cframe
        Weld_2.Parent = v2
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
    end
end
