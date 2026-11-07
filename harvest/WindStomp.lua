-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Wind.WindStomp
-- Class: ModuleScript
-- bytes: 1829

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local _ = Services_m.TweenService
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local Utility_m = require(ReplicatedStorage.Modules.Utility)

local _ = function(arg1, arg2, arg3) --[[ Weld ]] -- line: 14
    local Weld = Instance.new("Weld")
    Weld.Name = arg1.Name .. "Weld"
    Weld.Part0 = arg1
    Weld.Part1 = arg2
    Weld.C0 = arg3
    Weld.Parent = arg2
end

return function(arg4, arg5, arg6) -- line: 23
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Utility_m (copy)

    if not arg5 or not arg6 or (arg5.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg6)

    if arg4 == "Leg" then
        _G.PlaySound(script.Stomp, arg6.PrimaryPart)
        local v3 = script.Leg:Clone()
        _G.Debris(v3, 3)
        GrimoireRarity_m:ApplyVariantEffect(v3, v2)
        v3.CFrame = arg5
        local PrimaryPart = arg6.PrimaryPart
        local cframe = CFrame.new(0, 0, 0)
        local Weld_2 = Instance.new("Weld")
        Weld_2.Name = PrimaryPart.Name .. "Weld"
        Weld_2.Part0 = PrimaryPart
        Weld_2.Part1 = v3
        Weld_2.C0 = cframe
        Weld_2.Parent = v3
        v3.Parent = workspace.Effects
        Utility_m.EmitParticles(v3)

        return
    end

    if arg4 == "Stomp" then
        local v4 = script.Slam:Clone()
        _G.Debris(v4, 3)
        GrimoireRarity_m:ApplyVariantEffect(v4, v2)
        v4.CFrame = arg5 * CFrame.new(0, -2.5, -2)
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
    end
end
