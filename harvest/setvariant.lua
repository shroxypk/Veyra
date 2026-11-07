-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.setvariant
-- Class: ModuleScript
-- bytes: 494

return {
    Name = "setvariant",
    Aliases = { "variant" },
    Description = "Developers only. Sets your magic's variant (its colours). Leave it empty to list your magic's variants.",
    Group = "GameCommands",
    Args = {
        {
            Type = "string",
            Name = "Variant",
            Description = "Variant name, e.g. Void or Holy. Not case-sensitive, the start of a name works (ocean = Ocean Breeze). Empty lists them.",
            Optional = true
        }
    }
}
