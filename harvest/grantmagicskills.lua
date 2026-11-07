-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.grantmagicskills
-- Class: ModuleScript
-- bytes: 511

return {
    Name = "grantmagicskills",
    Aliases = { "givemagicskills", "allmagicskills" },
    Description = "Developers only. Grants you every skill of your current magic (your equipped grimoire) and puts them in your empty toolbar slots.",
    Group = "GameCommands",
    Args = {
        {
            Type = "boolean",
            Name = "Include passives",
            Description = "Also grant the magic's passives (e.g. Flame Passive). Default: false.",
            Optional = true
        }
    }
}
