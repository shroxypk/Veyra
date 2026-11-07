-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Admin.teleportServer
-- Class: ModuleScript
-- bytes: 506

local ZeroSecure_m = require(game:GetService("ServerStorage").GameModules.ZeroSecure)

return function(arg1, arg2) -- line: 7
    -- upvalues:
    --  [1] ZeroSecure_m (copy)

    local Character = arg1.Executor.Character

    if Character and Character.PrimaryPart then
        for _, val in arg2 do
            if val.Character and val.Character:FindFirstChild("HumanoidRootPart") then
                ZeroSecure_m:MoveCharacter(val, Character.PrimaryPart.CFrame)
            end
        end
    end
end
