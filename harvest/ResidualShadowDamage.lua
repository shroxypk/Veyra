-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.ResidualShadowDamage
-- Class: ModuleScript
-- bytes: 988

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local _ = require(ReplicatedStorage.Modules.StateManager)
local Shadow = ServerStorage.Assets.Particles.Shadow.Shadow

return function(_, arg2, _, _) -- line: 11
    -- upvalues:
    --  [1] Players (copy)
    --  [2] Shadow (copy)

    task.spawn(function() -- line: 14
        -- upvalues:
        --  [1] Players (ref)
        --  [2] arg2 (copy)
        --  [3] Shadow (ref)

        local _ = Players:GetPlayerFromCharacter(arg2)
        local _ = arg2.Humanoid
        local PrimaryPart = arg2.PrimaryPart

        for _, child in Shadow:GetChildren() do
            if child:IsA("ParticleEmitter") then
                local v1 = child:Clone()
                _G.Debris(v1, 2)
                v1.Parent = PrimaryPart
                v1:Emit(child:GetAttribute("EmitCount") or 5)
            end
        end
    end)
end
