-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.time
-- Class: ModuleScript
-- bytes: 358

return {
    Name = "time",
    Aliases = { "clocktime" },
    Description = "Changes the value of Lighting.ClockTime.",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "number",
            Name = "Hours",
            Description = "A numerical representation (in hours) of the current time of day used by Lighting."
        }
    }
}
