-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.RemoveMovers
-- Class: ModuleScript
-- bytes: 598

local ServerStorage = game:GetService("ServerStorage")
local t = {
    "TurnGyro",
    "SwimPosition",
    "FLIGHTVELOCITY",
    "FLIGHTGYRO",
    "AerialM1Velocity",
    "Climb Gyro",
    "Airborne"
}

return function(arg1, arg2) -- line: 5
    -- upvalues:
    --  [1] ServerStorage (copy)
    --  [2] t (copy)

    if arg2 then
        require(ServerStorage.GameModules.TagPlayers).CreateTag("RemoveMover", arg2, 0.05)
    end

    for _, child in arg1:GetChildren() do
        if child:IsA("BodyMover") and not table.find(t, child.Name) then
            child:Destroy()
        end
    end
end
