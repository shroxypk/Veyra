-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS.Quest : DOT Legacy
-- Class: ModuleScript
-- bytes: 1608

local _ = require
local t = {}
local t_1 = { start = "greeting", nodes = nil }
local t_2 = {
    greeting = {
        text = "The Citadel Library holds three forbidden texts that were never meant to be read. Their knowledge is dangerous, yet vital for understanding the true nature of the Forgotten Realm.",
        choices = {
            { text = "What makes these books so forbidden?", after = "finish" },
            { text = "Why would anyone want these books now?", after = "choice2" },
            { text = "I could retrieve these books for you.", after = "choice3" }
        }
    },
    finish = {
        text = "They contain the unedited accounts of the Magic Assembly's first expeditions. The official histories omit... details about the Cataclysm. The truth could unravel centuries of lies.",
        choices = { { text = "That does sound dangerous." } }
    },
    choice2 = {
        text = "Because history repeats itself. The same forces that corrupted the first expeditions are stirring again. These texts might be our only warning against making the same catastrophic mistakes.",
        choices = { { text = "I see." } }
    },
    choice3 = {
        text = "This isn't a simple task. The library is guarded by enchanted traps and soldiers. Bring me all three forbidden volumes, 'Order Report', 'Regal Dispatch', and 'The Silent Accord'. Do this, and I'll share what we learn.",
        choices = {
            { text = "I'll recover these forbidden texts.", action = "AcceptQuest" },
            { text = "Too risky for me." }
        }
    }
}
t_1.nodes = t_2
t.Aemond = t_1

return t
