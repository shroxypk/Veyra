-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.ResidualShockDamage
-- Class: ModuleScript
-- bytes: 1937

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StateManager_m = require(ReplicatedStorage.Modules.StateManager)
local DamageTag_m = require(script.Parent.DamageTag)

return function(arg1, arg2, arg3, arg4) -- line: 8
    -- upvalues:
    --  [1] StateManager_m (copy)
    --  [2] Players (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] DamageTag_m (copy)

    arg4 = arg4 or 5
    arg3 = arg3 or Color3.fromRGB(170, 85, 255)
    task.spawn(function() -- line: 12
        -- upvalues:
        --  [1] StateManager_m (ref)
        --  [2] arg2 (copy)
        --  [3] Players (ref)
        --  [4] ReplicatedStorage (ref)
        --  [5] arg3 (ref)
        --  [6] arg4 (ref)
        --  [7] arg1 (copy)
        --  [8] DamageTag_m (ref)

        local v2 = StateManager_m.require(arg2)
        local Humanoid = arg2.Humanoid
        local PrimaryPart = arg2.PrimaryPart
        local playerFromCharacter = Players:GetPlayerFromCharacter(arg2)
        local v3 = ReplicatedStorage.Effects.Statuses.StatusLightning:Clone()
        v3.Color = ColorSequence.new(arg3)
        v3.Parent = PrimaryPart

        for _ = 1, arg4 do
            local _ = arg4

            if v2:HasState("Downed") then
                break
            end

            local v5 = math.random(1, 3)

            if arg1 and arg1.Parent and not arg2:FindFirstChildWhichIsA("ForceField") then
                DamageTag_m(
                    arg2,
                    arg1,
                    v5,
                    nil,
                    true
                )
            end

            if if v5 >= Humanoid.Health + 5 then playerFromCharacter else v5 >= Humanoid.Health and playerFromCharacter then
                Humanoid.Health = 5
            else
                Humanoid:TakeDamage(v5)
            end

            task.wait(0.75)
        end

        v3:Destroy()
    end)
end
