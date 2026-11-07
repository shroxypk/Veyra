-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.RagdollChar
-- Class: ModuleScript
-- bytes: 947

local _ = game:GetService("Players")
local StateManager_m = require(game:GetService("ReplicatedStorage").Modules.StateManager)

local function ragdollCharacter(arg1, arg2) -- line: 11
    -- upvalues:
    --  [1] StateManager_m (copy)

    if arg1:HasTag("NonHumanoid") then
        return
    end

    local v1 = StateManager_m.require(arg1)

    if v1:HasState("Unyielding Bastion Cooldown") then
        return
    end

    arg2 = arg2 or 1.25

    if arg1:FindFirstChild("Iron Rebound") then
        arg2 *= 0.85
    end

    v1:AddState("Ragdoll", arg2)

    if arg1:FindFirstChild("Unyielding Bastion") then
        task.delay(arg2, function() -- line: 28
            -- upvalues:
            --  [1] arg1 (copy)
            --  [2] v1 (copy)

            if not arg1 or not arg1.Parent then
                return
            end

            v1:AddState("Unyielding Bastion Cooldown", 40)
        end)
    end
end

return ragdollCharacter
