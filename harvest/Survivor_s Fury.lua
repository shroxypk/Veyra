-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Survivor's Fury
-- Class: ModuleScript
-- bytes: 348

local _ = game:GetService("ReplicatedStorage")

return function(arg1, _, _) -- line: 3
    local v1 = 0
    local Humanoid = arg1:FindFirstChild("Humanoid")

    if arg1:FindFirstChild("Survivor's Fury") then
        v1 = if not Humanoid then v1 else if not (Humanoid.Health < Humanoid.MaxHealth * 0.25) then v1 else 0.1
    end

    return v1
end
