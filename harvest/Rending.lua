-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Rending
-- Class: ModuleScript
-- bytes: 1805

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local _ = function(arg1, arg2, arg3) --[[ Weld ]] -- line: 17
    local Weld = Instance.new("Weld")
    Weld.Name = arg1.Name .. "Weld"
    Weld.Part0 = arg1
    Weld.Part1 = arg2
    Weld.C0 = arg3
    Weld.Parent = arg2
end

return function(arg4, arg5) -- line: 26
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Utility_m (copy)

    if not arg5 or (arg5.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg4 == "Slash" then
        local cframe = CFrame.Angles(0, -2.530727415391778, 0)
        local v2 = ReplicatedStorage.Effects.WeaponFX.Rending.Slash:Clone()
        _G.Debris(v2, 3)
        v2.CFrame = arg5.CFrame * cframe
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)

        return
    end

    if arg4 == "Windup" then
        _G.PlaySound(script.SFX, arg5)
        local cframe_1 = CFrame.Angles(0, 0, 0)
        local v3 = ReplicatedStorage.Effects.WeaponFX.Rending.Emit:Clone()
        _G.Debris(v3, 3)
        v3.CFrame = arg5.CFrame * cframe_1
        v3.Parent = workspace.Effects
        local Weld_2 = Instance.new("Weld")
        Weld_2.Name = arg5.Name .. "Weld"
        Weld_2.Part0 = arg5
        Weld_2.Part1 = v3
        Weld_2.C0 = cframe_1
        Weld_2.Parent = v3
        Utility_m.EmitParticles(v3)
    end
end
