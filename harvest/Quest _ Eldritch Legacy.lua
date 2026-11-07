-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS.Quest : Eldritch Legacy
-- Class: ModuleScript
-- bytes: 26627

local Basic_m = require(
    require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage.Modules.Basic
)
local t = {}
local t_1 = { Reputation = nil, start = "greeting", nodes = nil }
local t_2 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_1.Reputation = t_2
local t_3 = {
    greeting = {
        text = "You... you there... Please... I can't make it back. The general's material... they're still needed...",
        choices = {
            { text = "What material are you talking about?", after = "choice1" },
            { text = "Who sent you on this mission?", after = "choice2" }
        }
    },
    choice1 = {
        text = "Plaguegord... grows on the tower stones. General needs it for... fortifications. Was supposed to deliver three clusters to Vallis... Can't stand...",
        choices = { { text = "Rest easy. I'll handle it.", action = "AcceptQuest" } }
    },
    choice2 = {
        text = "General Corvin himself... said the material has... protective properties. A monster's attack slides right off walls treated with it... Please... don't let my failure... endanger the fort...",
        choices = { { text = "Oh...", exit = true } }
    }
}
t_1.nodes = t_3
t["Guard Kael"] = t_1
local t_7 = { start = "greeting", nodes = nil }
local t_8 = {
    greeting = {
        text = "You've got the look of a true hunter about you. I've got a challenge that separates the skilled from the legendary. Interested in proving your mettle against every threat in this region?",
        choices = {
            { text = "What exactly would this challenge involve?", after = "choice1" },
            { text = "Why hunt one of each?", after = "choice2" }
        }
    },
    choice1 = {
        text = "A complete bestiary sweep. One kill of each major species - Blightseeker, Hollowseer, High Ogre, all the way up to the Lizard King. No tricks, just pure hunting skill.",
        choices = {
            { text = "I accept your challenge.", action = "AcceptQuest" },
            { text = "That's quite the shopping list of monsters. I'll pass.", exit = true }
        }
    },
    choice2 = {
        text = "Any fool can specialize. A true master hunter adapts to all prey. This tests your knowledge of weaknesses, terrain advantages, and combat flexibility.",
        choices = { { text = "Makes sense when you put it that way.", exit = true } }
    }
}
t_7.nodes = t_8
t["Master Hunter Goran"] = t_7
local t_12 = { Reputation = nil, start = "greeting", nodes = nil }
local t_13 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_12.Reputation = t_13
local t_14 = {
    greeting = {
        text = "I've been out here for three days. Everyone I came with is dead. I don't really know what I'm still doing sitting here if I'm being honest with you.",
        choices = { { text = "What happened to them?", after = "happened" } }
    },
    happened = {
        text = "There's a camp of lizard soldiers deeper in the marsh. We knew something was pushing out of the swamp and causing trouble but we weren't prepared for what we actually found. They were organised. Purposeful. They went through us before we could even fall back properly.",
        choices = { { text = "Is something commanding them?", after = "king" } }
    },
    king = {
        text = "The locals have a name for it. The King of the Swamp. There's an arena somewhere at the heart of all this and the carvings around it go back further than anything I've seen before. The soldiers don't just follow it. They treat it like something sacred. I couldn't get anywhere near it on my own while injured.",
        choices = { { text = "What are you going to do about it?", after = "plan" } }
    },
    plan = {
        text = "When I've recovered enough to move properly I'm going to go back in there and finish what we started. For them. I found the schematic for a ritual horn near the camp, it's used to call the King out to the arena. I just need the materials to build it and right now I can barely stand.",
        choices = { { text = "I can gather the materials for you.", after = "really" } }
    },
    really = {
        text = "You'd do that. You don't know what it's like in there. The soldiers are all through the swamp, not just in the camp. You'll cross paths with them whether you're looking for a fight or not.",
        choices = {
            { text = "What do you need me to find?", after = "materials" },
            { text = "I can handle myself. What do you need?", after = "materials" }
        }
    },
    materials = {
        text = "The materials needed are the following, spirit lumivine, witherclay, wood and a copper ingot. None of it is hard to come by on its own. It's just that everything in this swamp will try to kill you while you're looking for it.",
        choices = { { text = "I'll bring everything back to you.", after = "schematic" } }
    },
    schematic = {
        text = "I'll give you the schematic as a reward once you complete my request. I don't imagine you'll actually try to build it yourself but I need to reward you somehow. Just bring the materials back and I'll take it from there.",
        choices = {
            { text = "I'll be back with all of it.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_12.nodes = t_14
t["Wounded Fell Hunter"] = t_12
local t_22 = { Reputation = nil, start = "greeting", nodes = nil }
local t_23 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_22.Reputation = t_23
local t_24 = {
    greeting = {
        text = "You're not one of those fools seeking the Shifting Sphinx, are you? Every season, some whelp hears the tavern tales and thinks they'll be the one to master its trials. Most come back mad... if they come back at all.",
        choices = {
            { text = "What's this Sphinx you're talking about?", after = "choice1" },
            { text = "Where do I find this trial?", after = "choice2" }
        }
    },
    choice1 = {
        text = "Ancient thing in the witches' refuge, a sandstone monstrosity that changes form. They say it gifts survivors with strange powers. Last month a delirious mercenary kept shouting fire spells... with his  voice. Like some pre-Cataclysm relic.",
        choices = { { text = "Sounds like madness to me.", exit = true } }
    },
    choice2 = {
        text = "So you are mad. Head [direction] past the swamp, the refuge is buried in the edges of the region. But heed this, the Sphinx cares nothing for mortal concerns. Answer wrong and it might reshape your bones instead of its own.",
        choices = {
            { text = "I'll risk it. That reward is worth any trial.", action = "AcceptQuest" },
            { text = "Maybe I'll stick to hunting Blightseekers instead.", exit = true }
        }
    }
}
t_22.nodes = t_24
t["Fort Guard"] = t_22
local t_28 = { Reputation = nil, start = "greeting", nodes = nil }
local t_29 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_28.Reputation = t_29
local t_30 = {
    greeting = {
        text = "Will you help me? I haven't seen my brother since yesterday... I'm worried something's happened.",
        choices = { { text = "Do you have any idea where he might be?", after = "finish" } }
    },
    finish = {
        text = "He was last seen inside the Fort. If they took him, he's probably in the tower at the farthest side... That's where they keep prisoners.",
        choices = {
            { text = "I'll look for him.", action = "AcceptQuest" },
            { text = "Sorry, I'm busy.", exit = true }
        }
    }
}
t_28.nodes = t_30
t.Kiro = t_28
local t_33 = { Reputation = nil, start = "greeting", nodes = nil }
local t_34 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_33.Reputation = t_34
local t_35 = {
    greeting = {
        text = "Foreigner, there's a tale of a man who wandered the graveyard at night, slaying spirits until dawn. With each spirit he vanquished, wisdom filled his soul, until he emerged enlightened.",
        choices = { { text = "Enlightened?", after = "finish" } }
    },
    finish = {
        text = "It is said that the man gained the ability to protect himself from mana itself, though I believe this is all hearsay until I witness it firsthand.",
        choices = {
            { text = "I'll have to check this out myself.", action = "AcceptQuest" },
            { text = "I don't have time for fairy tales.", exit = true }
        }
    }
}
t_33.nodes = t_35
t.Ragnar = t_33
local t_38 = { Reputation = nil, start = "greeting", nodes = nil }
local t_39 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_38.Reputation = t_39
local t_40 = {
    greeting = {
        text = "The village is running low on supplies. Could you deliver this letter to my contact in Kamo? She can help us secure food. Her name is Eleanor.",
        choices = { { text = "Where can I find her?", after = "finish" } }
    },
    finish = {
        text = "You can find her at the Guild Hall located near Kamo Village.",
        choices = {
            { text = "I'll deliver the letter.", action = "AcceptQuest" },
            { text = "I'm busy right now, but maybe later.", exit = true }
        }
    }
}
t_38.nodes = t_40
t.Eko = t_38
local t_43 = { Reputation = nil, start = "greeting", nodes = nil }
local t_44 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_43.Reputation = t_44
local t_45 = {
    greeting = {
        text = "Huh, who are you? Nevermind, that's not important. I was once a great warrior, defending these lands, but that time has long passed. These days I've been feeling quite uneasy. If you could lend your capable, living hands, that would greatly appreciated.",
        choices = { { text = "What do you need?", after = "finish" } }
    },
    finish = {
        text = "My tombstone... It's my link to this world. Please, check on it for me.",
        choices = {
            { text = "Will do.", action = "AcceptQuest" },
            { text = "I'm not interested.", exit = true }
        }
    }
}
t_43.nodes = t_45
t.Errol = t_43
local t_48 = { Reputation = nil, start = "greeting", nodes = nil }
local t_49 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_48.Reputation = t_49
local t_50 = {
    greeting = {
        text = "Foreigner! I need your help. I lost my glasses somewhere around here. Can you find them for me?",
        choices = { { text = "Do you remember where you last had them?", after = "finish" } }
    },
    finish = {
        text = "Well, I was playing by the broken bridge near the edge of the village. Then I went to the General Store to pick up some supplies. The glasses could be anywhere along that path.",
        choices = {
            { text = "Alright.", action = "AcceptQuest" },
            { text = "I'm not interested anymore.", exit = true }
        }
    }
}
t_48.nodes = t_50
t.Sowon = t_48
local t_53 = { Reputation = nil, start = "greeting", nodes = nil }
local t_54 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_53.Reputation = t_54
local t_55 = {
    greeting = {
        text = "My family lies buried beyond those rusted gates. My parents always cherished this locket. Could you bury it with them?",
        choices = { { text = "Where can I find their grave?", after = "finish" } }
    },
    finish = {
        text = "You'll find it towards the rear of the graveyard, on the right side.",
        choices = {
            { text = "Got it.", action = "AcceptQuest" },
            { text = "Actually, I'm busy right now.", exit = true }
        }
    }
}
t_53.nodes = t_55
t.Samedi = t_53
local t_58 = { Reputation = nil, start = "greeting", nodes = nil }
local t_59 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_58.Reputation = t_59
local t_60 = {
    greeting = {
        text = "Lost traveler, I yearn for peace. I am tethered here, bound by memories. Can you help me find pieces of my past?",
        choices = { { text = "How can I help?", after = "finish" } }
    },
    finish = {
        text = "Within this region lie a song weaver, a forgotten promise, and a faded memory. Perhaps they will give me peace.",
        choices = {
            { text = "I will try.", action = "AcceptQuest" },
            { text = "I'm not interested in helping you.", exit = true }
        }
    }
}
t_58.nodes = t_60
t.Houken = t_58
local t_63 = { Reputation = nil, start = "greeting", nodes = nil }
local t_64 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_63.Reputation = t_64
local t_65 = {
    greeting = {
        text = "Lost soul, follow the whispering light.",
        choices = { { text = "Who are you?", after = "finish" } }
    },
    finish = {
        text = "I am but a shadow of the past, a guardian of secrets long forgotten. Follow along.",
        choices = {
            { text = "Lead the way.", action = "AcceptQuest" },
            { text = "Not interested.", exit = true }
        }
    }
}
t_63.nodes = t_65
t.Eunseom = t_63
local t_68 = { Reputation = nil, start = "greeting", nodes = nil }
local t_69 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_68.Reputation = t_69
local t_70 = {
    greeting = {
        text = "Foreigner... thank Luminos you're here. Beasts... they've ravaged this village. I was... investigating a hidden staircase when...",
        choices = { { text = "Beast? What happened?", after = "finish" } }
    },
    finish = {
        text = "It seems my investigation will have to wait. But listen... there, inside the church. A path leads to my family's research... Finish it...",
        choices = {
            { text = "I'll check it out.", action = "AcceptQuest" },
            { text = "Sounds dangerous. I'm not interested in any trouble.", exit = true }
        }
    }
}
t_68.nodes = t_70
t.Aric = t_68
local t_73 = { Reputation = nil, start = "greeting", nodes = nil }
local t_74 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_73.Reputation = t_74
local t_75 = {
    greeting = {
        text = "Traveler, blessed be your arrival. A darkness has fallen over our village. A miasmic fog has crept in, bringing sickness and suffering.",
        choices = { { text = "How can I help?", after = "finish" } }
    },
    finish = {
        text = "We believe the ancient texts teach us a cleansing technique. However, the ingredients are only a few and spread over the mist-shrouded land. We need someone who can take up the duty.",
        choices = {
            {
                text = "I'll be back as soon as I can with those ingredients.",
                action = "AcceptQuest"
            },
            { text = "Sorry, maybe next time.", exit = true }
        }
    }
}
t_73.nodes = t_75
t.Kafka = t_73
local t_78 = { Reputation = nil, start = nil, nodes = nil }
local t_79 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_78.Reputation = t_79

function t_78.start(arg1) -- line: 384
    local GuardKael = arg1:WaitForChild("Quests"):FindFirstChild("Guard Kael")

    if GuardKael and not GuardKael:GetAttribute("Completed") then
        for _, child in GuardKael.Tasks:GetChildren() do
            if child:GetAttribute("DeliveryTask") and child:GetAttribute("TaskProgress") == 0 then
                return "Guard Kael_Quest"
            end
        end
    end

    return "greeting"
end

local t_80 = {
    ["Guard Kael_Quest"] = {
        text = "Plaguegord? Wait... Kael was supposed to... oh no. He was a good scout. Thank you for honoring his final request. The general will want to know about this."
    }
}
t_80.greeting = {
    text = "Could you spare a moment? It's a delicate matter. My colleague Clovis, may Luminos curse his name, stole tax records from the archives. Fort Ash can't afford scrutiny, and I'd rather not involve the guards. Retrieve them, and I'll see you generously compensated. Will you help?",
    choices = {
        { text = "I'll find your thief. Where did he go?", after = "finish" },
        { text = "Tax records? Why would anyone steal those?", after = "greeting2" }
    }
}
t_80.greeting2 = {
    { text = "I see." },
    text = "Clovis was always prone to drama. He claimed there were inconsistencies, probably just clerical errors blown out of proportion. He fancied himself a reformer. But this isn't the proper way to raise concerns, is it?"
}
t_80.finish = {
    text = "He took the old road to the Forsaken Village and is most likely holed up in the ruins. But be wary: Clovis is an expert at concealing himself.",
    choices = { { text = "I'll track him down", action = "AcceptQuest" } }
}
t_78.nodes = t_80
t.Vallis = t_78
local t_83 = { Reputation = nil, start = "greeting", nodes = nil }
local t_84 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_83.Reputation = t_84
local t_85 = {
    greeting = {
        text = "Have you seen it yet? The big one that walks. Most people who come through here haven't and then they see it and they don't know what to do with themselves.",
        choices = { { text = "What are you talking about?", after = "whatisit" } }
    },
    whatisit = {
        text = "The Plainswalker. That's what everyone around here calls it. It's been walking the Eldritch region for as long as anyone can remember. My gran said her gran used to tell the story of it when she was little and it was already old then.",
        choices = { { text = "What does it do?", after = "whatitdoes" } }
    },
    whatitdoes = {
        text = "That's the thing about it. It doesn't really do anything on purpose. It just walks. It has always just walked. But it's so large that if you're standing where it's going and you don't move in time then that's sort of the end of you. And if someone tries to hurt it, it notices.",
        choices = { { text = "Has it hurt many people?", after = "hurt" } }
    },
    hurt = {
        text = "Some. Not because it meant to. My gran said the ones who got hurt were either unlucky with where they were standing or they thought they could take something that big on by themselves. The Plainswalker doesn't chase anyone. It just keeps walking.",
        choices = { { text = "Anything else?", after = "hero" } }
    },
    hero = {
        text = "In a old story a hero hunts it down and brings it down for good and after that the Eldritch region has peace properly for the first time. No more ground shaking. No more people getting caught in its path by accident. The story always said the hero would be someone passing through who didn't know the rules yet.",
        choices = { { text = "You think I'm the hero from the story.", after = "likeme" } }
    },
    likeme = {
        text = "You didn't know about it before I told you just now, did you. And you came from somewhere else. That's how the story goes. Gran used to say that the hero never knew they were the hero until someone smaller than them pointed it out.",
        choices = {
            { text = "Where does the Plainswalker walk?", after = "where" },
            { text = "I'll go find it.", after = "where" }
        }
    },
    where = {
        text = "Out across the Eldritch plains, same as always. You'll hear it before you see it. Just follow the feeling that the ground is unhappy about something and you'll find it eventually. That's what gran always said anyway.",
        choices = {
            { text = "I'll go and put an end to it.", after = "ending" },
            { text = "Not right now.", exit = true }
        }
    },
    ending = {
        text = "I always hoped the story was real. Everyone around here sort of stopped believing it after a while but I never did. Be careful though. It might not mean any harm but something that big doesn't have to mean it for it to happen anyway.",
        choices = {
            {
                text = "I'll be careful. Thank you for telling me the story.",
                action = "AcceptQuest"
            }
        }
    }
}
t_83.nodes = t_85
t.Duggan = t_83
local t_94 = { Reputation = nil, start = "greeting", nodes = nil }
local t_95 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_94.Reputation = t_95
local t_96 = {
    greeting = {
        text = "You have the look of someone who has been moving through this region for a while. Tell me, have you come across any of the temples yet? The old stone ones, half buried in the landscape like they have been there since before anyone thought to name the land around them.",
        choices = {
            { text = "I haven't found any yet.", after = "problem" },
            { text = "I've seen a few. What about them?", after = "problem" }
        }
    },
    problem = {
        text = "Anyways, something has been happening to them recently that I cannot explain and that I find deeply troubling. High Ogres have been gathering at them, as though something inside is drawing them there.",
        choices = { { text = "Why would ogres be drawn to a temple?", after = "unknown" } }
    },
    unknown = {
        text = "I have asked myself that question every day since I first saw it happening. High Ogres are not creatures of ritual or reverence, at least not as far as anyone has ever documented. Whatever is pulling them toward those sites I do not understand it and that troubles me as much as the damage itself.",
        choices = { { text = "What do you need me to do about it?", after = "yes" } }
    },
    yes = {
        text = "I want the desecration to stop and killing at least three of them is the most direct way I can think of to send a message to the rest. Find a temple, there are several within reasonable distance of here, and deal with the High Ogre you find there. I would go myself but I am a scholar, not a fighter, and I would very much like to continue being a scholar.",
        choices = {
            { text = "How will I find a temple?", after = "findit" },
            { text = "I will find one and handle it.", after = "accept" }
        }
    },
    findit = {
        text = "Move through the region and keep your eyes on the landscape rather than the road. The temples do not hide exactly but they do not announce themselves either. You will know one when you see it. And if there is a High Ogre present you will almost certainly know that too before long.",
        choices = { { text = "I will find one and deal with what is inside.", after = "accept" } }
    },
    accept = {
        text = "Thank you. Those temples are some of the only things left in this region that connect us to something older and more considered than what we have now. I would very much like them to still be standing and intact long after both of us are gone.",
        choices = {
            { text = "I will take care of it.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_94.nodes = t_96
t.Niall = t_94
local t_103 = { start = "greeting", nodes = nil }
local t_104 = {
    greeting = {
        text = "You can see me. Most people who come through here cannot. Or maybe nobody has come through here in long enough that it no longer matters either way.",
        choices = {
            { text = "What happened to this place?", after = "happened" },
            { text = "Who are you?", after = "whoareyou" }
        }
    },
    whoareyou = {
        text = "My name is Prakash. I lived here with the other miners for most of my adult life. This outpost was a good place once. Quiet, hardworking, the kind of place where everyone knew what they were there to do and got on with doing it.",
        choices = { { text = "What happened to everyone?", after = "happened" } }
    },
    happened = {
        text = "The miasmic fog came in one night without any warning. By morning the others were not themselves anymore. I do not know how else to describe what they became. I was one of the last to go and by then there was nothing left of the outpost worth saving. I never left this house after that.",
        choices = {
            { text = "I'm sorry. Is that why you're still here?", after = "stillhere" },
            { text = "What is keeping you here?", after = "stillhere" }
        }
    },
    stillhere = {
        text = "Partly. But there is something else. Something I should have done before all of this happened and did not. My father was a miner his whole life. When he was dying he asked me to mine a vein of Ashenstone he had spent years trying to find and have it smelted into an ingot. Something to carry on from him.",
        choices = { { text = "Maybe I can do it for you.", after = "accept" } }
    },
    accept = {
        text = "I have been standing in this house for a very long time thinking about all the days I told myself I would do it tomorrow. If you bring back that ingot it will not undo any of that but I think it might finally let me stop thinking about it. Thank you for listening to me.",
        choices = {
            { text = "I will finish what you started.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_103.nodes = t_104
t.Prakash = t_103
local t_110 = { Reputation = nil, start = "greeting", nodes = nil }
local t_111 = { Faction = "Eldritch", Value = Basic_m.ReputationBadMin / 2 }
t_110.Reputation = t_111
local t_112 = {
    greeting = {
        text = "Careful where you step. I took a bad fall in the mines and now I'm stuck here with a bad leg. My ore quota is still due and the foreman doesn't wait for anyone.",
        choices = {
            { text = "What happened in the mines?", after = "choice1" },
            { text = "What do you need me to do?", after = "choice2" }
        }
    },
    choice1 = {
        text = "A support beam gave way while I was digging in the deep tunnels. The rocks came down on me and my leg took the worst of it. I was able to crawl here. The doctors say I need to stay off it for weeks. But the quota doesn't care about broken legs.",
        choices = { { text = "So you need someone to fill the quota for you.", after = "choice2" } }
    },
    choice2 = {
        text = "I need ore from the deep veins. Three clusters of Viridium and five of Netherite should fill my quota and then some. The veins are rich but the tunnels are not safe, even for careful miners. Will you go down for me?",
        choices = {
            { text = "I'll bring back your ore.", action = "AcceptQuest" },
            { text = "Mining isn't my kind of work.", exit = true }
        }
    }
}
t_110.nodes = t_112
t.Fahad = t_110

return t
