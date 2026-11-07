-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS.Tailor
-- Class: ModuleScript
-- bytes: 1905

local _ = require
local t = {}
local t_1 = { start = "greeting", nodes = nil }
local t_2 = {
    greeting = {
        text = { "Aye.", "Let's hear it.", "I'm listening.", "I'm all ears.", "Look around." }
    }
}
t_1.nodes = t_2
t.Ace = t_1
local t_4 = { start = "greeting", nodes = nil }
local t_5 = {
    greeting = {
        text = {
            "Life's too short for boring garments!",
            "Darling, tell me all about this disaster you call clothing!",
            "Don't just wear clothes, my dear, let them wear YOU!"
        }
    }
}
t_4.nodes = t_5
t.Cyrus = t_4
local t_7 = {
    start = function(arg1) --[[ start ]] -- line: 36
        local Johan = arg1:WaitForChild("Quests"):FindFirstChild("Johan")

        if Johan and not Johan:GetAttribute("Completed") then
            for _, child in Johan.Tasks:GetChildren() do
                if child:GetAttribute("DeliveryTask") and child:GetAttribute("TaskProgress") == 0 then
                    return "Johan_Quest"
                end
            end
        end

        return "greeting"
    end,
    nodes = nil
}
local t_8 = {
    Johan_Quest = {
        text = "Let me see... Ah, just a slight adjustment here... There! It's finished. You can go ahead and take this prototype back to Johan.",
        action = "DeliveryQuest",
        quest = "Johan"
    },
    greeting = {
        text = "Greetings customer! How may I be of service to you today?",
        choices = {
            {
                text = "I'm in need of some new clothes. Do you have anything for sale?",
                after = "finish"
            }
        }
    },
    finish = {
        text = "Of course! I have a wide selection of clothing available, including tunics, cloaks, and dresses. What type of clothing are you interested in?",
        choices = { { text = "Let's take a look.", exit = true } }
    }
}
t_7.nodes = t_8
t.Saevel = t_7

return t
