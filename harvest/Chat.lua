-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS.Chat
-- Class: ModuleScript
-- bytes: 17087

local _ = require
local t = {}
local t_1 = {
    start = function(arg1) --[[ start ]] -- line: 10
        local Ryze = arg1:WaitForChild("Quests"):FindFirstChild("Ryze")

        if Ryze and not Ryze:GetAttribute("Completed") then
            for _, child in Ryze.Tasks:GetChildren() do
                if child:GetAttribute("DeliveryTask") and child:GetAttribute("TaskProgress") == 0 then
                    return "Ryze_Quest"
                end
            end
        end

        return "greeting"
    end,
    nodes = nil
}
local t_2 = {
    Ryze_Quest = {
        text = "Ryze and the Kamo Blitz? Count me in! Thank you for delivering this news to me.",
        action = "DeliveryQuest",
        quest = "Ryze"
    },
    greeting = {
        text = "Do you know what's happening? My mom says that the [b]Den of Thieves[/b] is trying to take over our village.",
        choices = {
            { text = "Yes, I've heard about it. Don't worry about it too much.", after = "finish" }
        }
    },
    finish = {
        text = "But how? They have so many more people and weapons. We don't stand a chance.",
        choices = {
            {
                text = "We may not have as many soldiers, but we have something even more powerful, unity and determination.",
                exit = true
            }
        }
    }
}
t_1.nodes = t_2
t.Elicia = t_1
local t_5 = {
    start = function(arg2) --[[ start ]] -- line: 49
        local Hollo = arg2:WaitForChild("Quests"):FindFirstChild("Hollo")

        if Hollo and not Hollo:GetAttribute("Completed") then
            return "Hollo_Quest"
        end

        return "greeting"
    end,
    nodes = nil
}
local t_6 = {
    Hollo_Quest = {
        text = "[i]Hollo[/i]? I don't know him very well... I'll have to decline.",
        action = "DeliveryQuest",
        quest = "Hollo"
    },
    greeting = {
        text = "*Singing*",
        choices = {
            { text = "Do you spend your entire day here?", after = "choice1" },
            { text = "Where did you learn to sing?", after = "choice2" }
        }
    },
    choice1 = {
        text = "Yeah, I usually spend my days entertaining folks.",
        choices = { { text = "Oh." } }
    },
    choice2 = {
        text = "When I was little, my mother taught me to sing. She said I had a good voice, so I use it to entertain others.",
        choices = { { text = "Thats very sweet." } }
    }
}
t_5.nodes = t_6
t.Recca = t_5
local t_10 = { start = "greeting", nodes = nil }
local t_11 = {
    greeting = {
        text = "Ah, traveler... You ever hear the tale of the Lady in the Mushroom Lake? My wet nurse used to whisper it to me when I was just knee-high.",
        choices = {
            { text = "A lady in the lake? Sounds like a children's story.", after = "choice1" },
            { text = "What exactly did your wet nurse say?", after = "choice2" }
        }
    },
    choice1 = {
        text = "Aye, but stories have roots deeper than ancient oaks. They say she's pale as moonlight, with eyes like still water. If you leave an offering and speak true, she might grant a wish... or so the old tales claim.",
        choices = { { text = "Maybe I'll visit." } }
    },
    choice2 = {
        text = "Oh, she swore on her life! Said the Lady appears at dusk to those with pure intentions. Bring her offerings, shiny things, rare herbs, and she might trade you... remarkable items. Some say she'll even turn marks into wisdom.",
        choices = { { text = "Sounds like a good way to lose my marks." } }
    }
}
t_10.nodes = t_11
t.Stumpy = t_10
local t_15 = { start = "greeting", nodes = nil }
local t_16 = {
    greeting = {
        text = "You're new around here, aren't you? Things aren't right in Fort Ash anymore... not since they forced out the merchant quarter. Something foul's brewing behind these walls.",
        choices = {
            { text = "Forced them out? What happened?", after = "choice1" },
            { text = "You mentioned something foul brewing?", after = "choice2" }
        }
    },
    choice1 = {
        text = "Aye, under orders from the Castellan. Said it was for 'security' when the monster waves got worse. But why kick out the very people keeping this fort supplied? The blacksmiths, the brewers... now we're left with military rations and whatever scraps trickle in.",
        choices = { { text = "That does seem suspicious..." } }
    },
    choice2 = {
        text = "People disappearing, that's what. Three this week alone, all last seen near the restricted upper wards. And the noises... You'll think me mad, but I swear I've heard Blightseeker screeches coming from inside the walls at night.",
        choices = { { text = "I'll keep my eyes open." } }
    }
}
t_15.nodes = t_16
t.Sae = t_15
local t_20 = { start = "greeting", nodes = nil }
local t_21 = {
    greeting = {
        text = "Can you believe it? The Magic Exam is finally here! I heard they've got some new challenges lined up this year, just to shake things up!",
        choices = { { text = "Anything we should be prepared for?", after = "choice1" } }
    },
    choice1 = {
        text = "People are saying the first round is brutal if you're not quick. If you slip up, it's game over. Guess they don't want any amateurs!",
        choices = { { text = "Interesting." } }
    }
}
t_20.nodes = t_21
t.Malforia = t_20
local t_24 = { start = "greeting", nodes = nil }
local t_25 = {
    greeting = {
        text = "I don't have time for your nonsense. Leave before I lose my patience.",
        choices = { { text = "My apologies, I'll be on my way now.", after = "choice1" } }
    },
    choice1 = { text = "Go on then.", choices = { { text = "Ok." } } }
}
t_24.nodes = t_25
t["Commissioner Azreal"] = t_24
local t_28 = { start = "greeting", nodes = nil }
local t_29 = {
    greeting = {
        text = "So, little bird, tell me. Do you fly with a flock, or fly solo?",
        choices = {
            { text = "I'm in a guild.", after = "choice1" },
            { text = "I'm alone.", after = "choice2" }
        }
    },
    choice1 = {
        text = "Ah, a wise bird! Strength in numbers, they say. Listen well, little bird. A guild's infamy is built on wings that carry out daring deeds. Whispers follow from dungeons plundered and requests fulfilled. Heed them, and your guild's name will be on everyone's tongue.",
        choices = { { text = "Interesting." } }
    },
    choice2 = {
        text = "A lone feather flutters easily, but a flock can weather any gale. Choose your nest wisely.",
        choices = { { text = "Hmm..." } }
    }
}
t_28.nodes = t_29
t.Willart = t_28
local t_33 = { start = "greeting", nodes = nil }
local t_34 = {
    greeting = {
        text = "Greetings, patron.",
        choices = {
            { text = "Who are you?", after = "choice1" },
            { text = "What exactly do you do here?", after = "choice2" },
            { text = "Excuse me, I'm looking for information on Grey Fox.", after = "choice3" }
        }
    },
    choice1 = {
        text = "We are the Thieves Guild. We're everywhere and nowhere at the same moment. We know all the mysteries that reside in this realm.",
        choices = { { text = "Hm..." } }
    },
    choice2 = {
        text = "We sell information. We have ears throughout Elysium.",
        choices = { { text = "Oh." } }
    },
    choice3 = {
        text = "It's said that Grey Fox wants to control the Kamo Spirit, which is a powerful entity that currently protects Kamo Village. If he can control the Kamo Spirit, he will be unstoppable.",
        choices = { { text = "Ah, I see..." } }
    }
}
t_33.nodes = t_34
t.Mammon = t_33
local t_39 = { start = "greeting", nodes = nil }
local t_40 = {
    greeting = {
        text = "Hoyo! Haven't seen your face around here before. You must be new. Welcome to... well, what's left of it.",
        choices = {
            { text = "Why is the village so deserted?", after = "choice1" },
            {
                text = "I ran into a strange fog before I arrived here. What is it?",
                after = "choice2"
            }
        }
    },
    choice1 = {
        text = "That's one way to put it. The Eldritch region has long been a plague in this realm. We've dealt with Plainswalkers, miasmic fog, and a variety of other problems. As a result, we are not in the greatest of conditions, but we survive.",
        choices = { { text = "Oh." } }
    },
    choice2 = {
        text = "That would be the miasmic fog. Nasty thing. If you linger there too long, you'll lose your mind and become one of the unfortunate ones.",
        choices = { { text = "Interesting." } }
    }
}
t_39.nodes = t_40
t.Mai = t_39
local t_44 = { start = "greeting", nodes = nil }
local t_45 = {
    greeting = {
        text = "Attention all aspiring defenders of the realm! The Magic examinations are now accepting participants. Note the examination schedule carefully.",
        choices = {
            { text = "What are the Knights?", after = "choice1" },
            { text = "When do the exams take place?", after = "choice2" }
        }
    },
    choice1 = {
        text = "An elite order that combines martial prowess with magic mastery. Only the most spectacular individuals may join.",
        choices = { { text = "Oh, okay." } }
    },
    choice2 = {
        text = "Examinations occur every 50 minutes starting at XX:00. There is a fifty minute downtime between each exam session. For example, if you miss the 3:10 exam, the next opportunity will be at 4:00.",
        choices = { { text = "I understand the schedule." } }
    }
}
t_44.nodes = t_45
t["Captain Holmes"] = t_44
local t_49 = { start = "greeting", nodes = nil }
local t_50 = {
    greeting = {
        text = "Huh? What do you want.",
        choices = { { text = "What are the symbols on your arms?", after = "choice1" } }
    },
    choice1 = {
        text = "They are magic enchantments engraved within my arm. When I traveled to the Hearth Realm, I was able to find someone able to do the procedure.",
        choices = { { text = "Interesting." } }
    }
}
t_49.nodes = t_50
t.Laenor = t_49
local t_53 = { start = "greeting", nodes = nil }
local t_54 = {
    greeting = {
        text = "Huh? What do you want.",
        choices = { { text = "What are the symbols on your arms?", after = "choice1" } }
    },
    choice1 = {
        text = "They are magic enchantments engraved within my arm. When I traveled to the Hearth Realm, I was able to find someone able to do the procedure.",
        choices = { { text = "Interesting." } }
    }
}
t_53.nodes = t_54
t.Laenor = t_53
local t_57 = { start = "greeting", nodes = nil }
local t_58 = {
    greeting = {
        text = "If my colleague told you their formula is superior, they are technically guessing.",
        choices = { { text = "Noted." } }
    }
}
t_57.nodes = t_58
t["Apprentice Conrad"] = t_57
local t_60 = { start = "greeting", nodes = nil }
local t_61 = {
    greeting = {
        text = "Big person! Big person! Pofty is hiding in the mushtrees. The bitey things comed from there. And there. And ALSO there. Pofty don't know where they don't come from.",
        choices = {
            { text = "How long have these 'bitey things' been attacking?", after = "howlong" }
        }
    },
    howlong = {
        text = "Since the moon got fat and skinny and fat again... Pofty counted on her capstalks but she runned out of capstalks to count on. Pofty thinks it's been a long long long long time.",
        choices = { { text = "That does sound like a long time." } }
    }
}
t_60.nodes = t_61
t.Pofty = t_60
local t_64 = { start = "greeting", nodes = nil }
local t_65 = {
    greeting = {
        text = "What do you want? I'm trying to enjoy this fire.",
        choices = {
            { text = "Why are so many people camped out here?", after = "crowd" },
            { text = "What's the deal with Mushroom Forest?", after = "forest" }
        }
    },
    crowd = {
        text = "Everyone leaves Kamo Village eventually and wants somewhere to rest before the next big job. This place is that respite. It's not much, but it beats sleeping in the dirt.",
        choices = { { text = "Fair enough." } }
    },
    forest = {
        text = "Every adventurer outgrows Kamo Village sooner or later. When you want to get stronger, you head for Mushroom Forest. That's where the big game is. My great nan used to say, 'Stay in the shallows and the only thing you'll catch is a cold.'.",
        choices = { { text = "That makes sense." } }
    }
}
t_64.nodes = t_65
t.Hadrian = t_64
local t_69 = { start = "greeting", nodes = nil }
local t_70 = {
    greeting = {
        text = "Oh, a new face! Hi, hi! Come sit by the fire! Don't mind Hadrian, he's like this with everyone.",
        choices = {
            { text = "What brings you two out here?", after = "why" },
            { text = "Is Hadrian always this grumpy?", after = "hadrian" }
        }
    },
    why = {
        text = "We're resting up! We took a bunch of gigs and needed a break. This spot is perfect. It's quiet, it's safe, and the fire is great!",
        choices = { { text = "Sounds nice." } }
    },
    hadrian = {
        text = "Yep! Ten years now. He's actually a big softie. He just won't admit it. Please don't tell him I said that!",
        choices = { { text = "Your secret is safe." } }
    }
}
t_69.nodes = t_70
t.Reginald = t_69
local t_74 = { start = "greeting", nodes = nil }
local t_75 = {
    greeting = {
        text = "Oh! A tall one! Cinnamon sees many tall ones around here. Welcome to the guild hall!",
        choices = {
            { text = "Tall ones?", after = "tall" },
            { text = "What's the guild hall like?", after = "hall" }
        }
    },
    tall = {
        text = "Yes, yes! Many people who look like the adventurer stay here to help around the Forest. Cinnamon thinks they look so odd! No cap, no spots, and so very tall. How do they even stand up straight?",
        choices = {
            { text = "We think you look odd too.", after = "odd" },
            { text = "Good to know." }
        }
    },
    odd = {
        text = "Hehe! Cinnamon supposes that is fair. Everyone looks odd to someone. Cinnamon is mush-happy to meet an odd friend!",
        choices = { { text = "Same here.", exit = true } }
    },
    hall = {
        text = "It is mush-cozy inside! Cinnamon would go in, but somebody has to guard the door. It is a very important job. Cinnamon decided that herself.",
        choices = { { text = "Sounds important.", exit = true } }
    }
}
t_74.nodes = t_75
t.Cinnamon = t_74
local t_80 = { start = "greeting", nodes = nil }
local t_81 = {
    greeting = {
        text = "Oh! Oh! An adventurer! Can Boop tell the adventurer a secret?",
        choices = {
            { text = "Sure, what is it?", after = "dream" },
            { text = "Maybe later.", exit = true }
        }
    },
    dream = {
        text = "Boop wants to join the guild and become an adventurer! A real one, with a real sword and a real badge! Boop would train so hard!",
        choices = {
            { text = "Why do you want to be one?", after = "knight" },
            { text = "That's a big dream.", after = "knight" }
        }
    },
    knight = {
        text = "Because Boop wants to become a Knight! Boop has heard the stories. The Knights are brave and strong, and they travel to the Hearth Realm! Boop wants to see it so mush-much!",
        choices = {
            { text = "That sounds amazing.", after = "lament" },
            { text = "What's stopping you?", after = "lament" }
        }
    },
    lament = {
        text = "Well... there is a problem. Mushmites cannot get a grimoire so Mushmites cannot use magic. Without one, it is very hard to even become an adventurer. Boop is a mush-sad Mushmite. But Boop will keep dreaming anyway.",
        choices = {
            { text = "I'm sorry, Boop.", exit = true },
            { text = "Don't give up.", exit = true }
        }
    }
}
t_80.nodes = t_81
t.Boop = t_80
local t_86 = { start = "greeting", nodes = nil }
local t_87 = {
    greeting = {
        text = "You've got that look. Like you're already thinking about the next stop.",
        choices = { { text = "Where should I go next?", after = "next" } }
    },
    next = {
        text = "The Eldritch region. The gigs pay more, and the monsters hit harder. It's a whole new world there.",
        choices = { { text = "Sounds interesting.", exit = true } }
    }
}
t_86.nodes = t_87
t.Lucy = t_86
local t_90 = { start = "greeting", nodes = nil }
local t_91 = {
    greeting = {
        text = "Hey there. I'm just waiting on my pal Nikita, she should be here any minute.",
        choices = { { text = "What are you two up to?", after = "plans" } }
    },
    plans = {
        text = "Oh, we've got big plans. Can't say more than that, but you'll hear about it soon enough.",
        choices = { { text = "Good luck with that.", exit = true } }
    }
}
t_90.nodes = t_91
t.Jonah = t_90

return t
