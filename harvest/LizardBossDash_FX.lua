-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.LizardBoss.LizardBossDash_FX
-- Class: ModuleScript
-- bytes: 2586

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
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

return function(arg4, arg5, arg6) -- line: 26
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] Utility_m (copy)

    if arg5 and (arg5.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg4 == "ChargeTrail" and arg6 then
        local v2 = script.SlashProjectileStart:Clone()
        Services_m.Debris(v2, 4)
        v2.CFrame = arg5 * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, -6, 5)
        v2.Position += v2.CFrame.LookVector * -5
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)

        return
    end

    if arg4 == "LungeEmit" and arg6 then
        local v4 = script.Dash:Clone()
        v4.CFrame = arg5
        v4.CFrame = v4.CFrame * CFrame.new(0, -5, -10) * CFrame.Angles(0, 0, 0)
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
        local v7 = script.RunningSmoke:Clone()
        local cframe = CFrame.new(0, -6, 0)
        local Weld_2 = Instance.new("Weld")
        Weld_2.Name = arg6.Name .. "Weld"
        Weld_2.Part0 = arg6
        Weld_2.Part1 = v7
        Weld_2.C0 = cframe
        Weld_2.Parent = v7
        v7.Parent = workspace.Effects
        Utility_m.Toggle(v7, true)
        task.delay(0.4, function() -- line: 48
            -- upvalues:
            --  [1] Utility_m (ref)
            --  [2] v4 (copy)
            --  [3] v7 (copy)
            --  [4] Services_m (ref)

            Utility_m.Toggle(v4, false)
            Utility_m.Toggle(v7, false)
            Services_m.Debris(v4, 3)
            Services_m.Debris(v7, 3)
        end)
        Services_m.Debris(v4, 4)

        return
    end

    if arg4 == "Slash" and arg6 then
        local v8 = script.Slash:Clone()
        v8.CFrame = arg5 * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 1.4, 0)
        v8.Parent = workspace.Effects
        Utility_m.EmitParticles(v8)
        Services_m.Debris(v8, 4)
    end
end
