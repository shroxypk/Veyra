-- Decompiled with Veyra harvester
-- Instance: Workspace.NPCS.Matriarch Hemlock.witchPromptHandler.Dialogue
-- Class: ModuleScript
-- bytes: 1312

local _ = require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage
local t = {
    DisplayName = "Matriarch Hemlock",
    LevelReq = 1,
    Hidden = true,
    ObjectType = "Chat",
    Contents = nil
}
local t_1 = {
    Text = "You've brought us something [Color=#ff0000]dangerous[/Color]... That [b]crystal fragment[/b] is a byproduct of a much older curse... one we've worked to keep sealed.",
    NextChoices = nil
}
local t_2 = { Choices = { { Type = "Continue", Text = "Can you tell me more?" } } }
t_1.NextChoices = t_2
local t_5 = {
    Text = "A long time ago, we forged three talismans to hold the curse in place. As long as they stood, the curse remained buried.",
    NextChoices = nil
}
local t_6 = { Choices = { { Type = "Continue", Text = "What changed?" } } }
t_5.NextChoices = t_6
local t_8 = {
    Text = "Something is interfering. The talismans are weakening and that crystal is proof.",
    NextChoices = nil
}
local t_9 = { Choices = { { Type = "Continue", Text = "How do I stop it?" } } }
t_8.NextChoices = t_9
local t_11 = {
    Text = "You need to find the talismans and stop whatever is feeding on them.",
    NextChoices = nil
}
local t_12 = { Choices = { { Type = "Dismiss", Text = "Understood." } } }
t_11.NextChoices = t_12
t.Contents = { t_1, t_5, t_8, t_11 }

return t
