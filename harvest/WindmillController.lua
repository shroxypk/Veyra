-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.WindmillController
-- Class: LocalScript
-- bytes: 858

local _ = require(game:GetService("ReplicatedFirst").Services)
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local v2 = 0

repeat
    task.wait(0.1)
until _G.CanRender

RunService.Heartbeat:Connect(function(deltaTime) -- line: 15
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] CollectionService (copy)

    v2 += deltaTime

    if v2 < 0.05 then
        return
    end

    v2 = 0

    for _, val in (CollectionService:GetTagged("Windmill")) do
        if _G.CanRender(val) and val:FindFirstChild("Blade") and val.Blade.PrimaryPart then
            val.Blade:PivotTo(
                val.Blade.PrimaryPart.CFrame * CFrame.Angles(
                    0,
                    0,
                    Random.new():NextNumber(0.04, 0.06)
                )
            )
        end
    end
end)
