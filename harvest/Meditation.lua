-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.InnerRealm.Meditation
-- Class: ModuleScript
-- bytes: 445

local t = { DisplayName = "Meditation", __override = true, start = "initial", nodes = nil }
local t_1 = {
    initial = {
        text = "You settle into stillness and turn your focus inward. What is it you seek?",
        choices = {
            { text = "I seek to uncover new traits.", action = "TraitObtaining" },
            { text = "I seek to uncover new abilities.", action = "MagicObtaining" }
        }
    }
}
t.nodes = t_1

return t
