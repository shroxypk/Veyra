-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MapService.MapPoints
-- Class: ModuleScript
-- bytes: 1737

local t = { Kinds = nil, Points = nil }
local t_1 = {
    Puzzle = {
        Color = Color3.fromRGB(196, 150, 255),
        UnknownName = "Unsolved Puzzle",
        UnknownText = "Something here hasn't been figured out yet.",
        SolvedText = "Solved."
    },
    Poneglyph = {
        Color = Color3.fromRGB(110, 215, 200),
        UnknownName = "Ancient Stone",
        UnknownText = "A stone covered in strange writing.",
        SolvedText = "Inscribed."
    }
}
t.Kinds = t_1
t.Points = {
    TunePuzzle = {
        Kind = "Puzzle",
        Name = "Tune Puzzle",
        Position = Vector3.new(10162, 378, 5367),
        Radius = 90,
        Puzzle = "TunePuzzle"
    },
    TunePuzzle2 = {
        Kind = "Puzzle",
        Name = "Tune Puzzle",
        Position = Vector3.new(7191, 160, 4649),
        Radius = 90,
        Puzzle = "TunePuzzle2"
    },
    GraveyardPuzzle = {
        Kind = "Puzzle",
        Name = "Crypt Contraption",
        Position = Vector3.new(7191, 181, 1709),
        Radius = 90,
        Puzzle = "{a83ec724-8028-4c16-a0c5-e3cb94d92662}"
    },
    Poneglyph1 = {
        Kind = "Poneglyph",
        Name = "Poneglyph",
        Position = Vector3.new(3152, 203, 1148),
        Radius = 90,
        Quest = "AugmentQuest",
        Object = "Poneglyph1"
    },
    Poneglyph2 = {
        Kind = "Poneglyph",
        Name = "Poneglyph",
        Position = Vector3.new(11562, 306, 673),
        Radius = 90,
        Quest = "AugmentQuest",
        Object = "Poneglyph2"
    },
    Poneglyph3 = {
        Kind = "Poneglyph",
        Name = "Poneglyph",
        Position = Vector3.new(-180, 292, -3532),
        Radius = 90,
        Quest = "AugmentQuest",
        Object = "Poneglyph3"
    }
}

return t
