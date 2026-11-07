-- Decompiled with Veyra harvester
-- Instance: Workspace.Objects.Trainers.MediumWepTrainer.Info
-- Class: ModuleScript
-- bytes: 348

local _ = game:GetService("ReplicatedStorage")
local t = { DisplayName = "Fen", start = "greeting", nodes = nil }
local t_1 = {
    greeting = {
        text = "If you have come seeking to develop your weapon training, this is the right place.",
        choices = { { text = "I'm interested", action = "Trainer" } }
    }
}
t.nodes = t_1

return t
