-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS.SpecialChat
-- Class: ModuleScript
-- bytes: 17464

local _ = require
local t = {}
local t_1 = {
    start = "greeting",
    nodes = {
        greeting = {
            text = "Come at me when you're ready. I'll give you the grace of the first strike."
        }
    }
}
t.Percival = t_1
local t_3 = { start = "greeting", nodes = nil }
local t_4 = {
    greeting = {
        text = {
            "Everything all right?",
            "Trouble?",
            "The town is under my protection now. You watch yourself.",
            "If you're in need of supplies, head down towards the General Store. If it's potions you're after, the Alchemist Tower has a cauldron.",
            "You look quite tired. I hear the Tavern has warm beds.",
            "Best not to go roaming north of the village. I hear those damned Alkes have infested the place.",
            "Move along.",
            "I stand guard over this village, ready to defend against any foes who dare to attack. My comrades fight bravely in the war, but I must hold the line here.",
            "I may be tired and weary from constant vigilance, but I will not let my guard down. The safety of this village depends on me.",
            "The constant threat of war has made it difficult to tend to our crops and livestock. It's a constant struggle to keep food on the table for our families.",
            "I just wish there was a way for us to live in peace and harmony, without constantly having to worry about defending ourselves.",
            "Have you heard any news from the front lines?"
        }
    }
}
t_3.nodes = t_4
t["Kamo Guard Respawnable"] = t_3
local t_6 = { start = "greeting", nodes = nil }
local t_7 = {
    greeting = {
        text = {
            "Training is important, but there's nothing like the real thing. I can't wait to test my skill against the enemy and emerge victorious.",
            "I wonder what kind of magic the enemy will throw at us. I'm not worried, though. With my spear and my training, I can take on anything they throw my way.",
            "I can't believe we've been at this base for over a month now. At this rate, I don't believe the war will happen.",
            "I've heard rumors that there's a powerful sorceress on the opposing side. Hopefully, I don't run into her in the battlefield.",
            "The long nights at camp can be tedious, but they only serve to make us stronger. We must be ready for whatever the battlefield may bring.",
            "I've been practicing my magic spells in secret, trying to increase my power. I won't let my comrades down in the heat of battle.",
            "I've heard tales of other magic swordsmen who can control the elements and summon spirits to fight alongside them. I wonder if I'll ever be able to master those kinds of powers.",
            "I miss my family and home, but I know I have a duty to serve and protect our village. I will do whatever it takes to keep our people safe."
        }
    }
}
t_6.nodes = t_7
t["Kamo Army Guard Respawnable"] = t_6
local t_9 = { start = "greeting", nodes = nil }
local t_10 = {
    greeting = {
        text = {
            "Seen yer kind before... trouble always follows.",
            "Keep your mark purse close, outlander.",
            "We don't take kindly to outsiders snoopin' around.",
            "We don't take kindly to outsiders here.",
            "Another day, another shift. Another ache.",
            "Stay out of trouble, outlander.",
            "What is it, outlander?"
        }
    }
}
t_9.nodes = t_10
t["Eldritch Guard Respawnable"] = t_9
local t_12 = { start = "greeting", nodes = nil }
local t_13 = {
    greeting = {
        text = {
            "What?",
            "Hmph.",
            "Make it quick.",
            "Move along.",
            "What do you want?",
            "Tired? Head to Beam's Inn. They have beds there.",
            "I'm not saying that Dark Elves are stupid. They're just headstrong.",
            "People have said a Combat Arena is finally opening with in the Hearth Realm; I might have to travel there and participate.",
            "The Magic Assembly has begun roaming the roads, be wary now.",
            "I'm not sure what to make of the attack on Kamo Village. I heard that a young fella saved the place."
        }
    }
}
t_12.nodes = t_13
t["Sentinel Respawnable"] = t_12
local t_15 = { start = "greeting", nodes = nil }
local t_16 = {
    greeting = {
        text = {
            "I can't wait to pillage and plunder to our heart's content. All that gold and treasure, just waiting for us to take it.",
            "We've been gathering weapons and supplies for weeks. It's time to put all of our planning into action.",
            "We've got to be careful not to underestimate Kamo Village. They may not look like much, but they've got some tricks up their sleeves.",
            "I can't wait to see our commander in action. She's said to be one of the most skilled shadow magic users in the realm, and I can't wait to see her unleash her power on the battlefield.",
            "I've heard that our commander is a real mercenary. She's not afraid to get her hands dirty and do whatever it takes to win.",
            "I can't wait to get my hands on some of that Kamo gold. It's been too long since we've had a good haul.",
            "I've heard that the commander can control the shadows themselves. I can't wait to see her in action.",
            "I'm simply thankful to be on the same side as the commander. I wouldn't want to be the victim of that shadow magic."
        }
    }
}
t_15.nodes = t_16
t["Sentinel Army Guard"] = t_15
local t_18 = { start = "greeting", nodes = nil }
local t_19 = {
    greeting = {
        text = {
            "We used to have patrols beyond the fort. Now? We're lucky to hold the walls.",
            "If the gates fail, we fall back to the inner keep. Pray it doesn't come to that.",
            "Last week, a recruit asked if it gets easier. I laughed so hard I cried.",
            "Heard a rumor, some say the Castellan's got 'advisors' whispering in his ear. Never shows their faces, though.",
            "We're stretched thinner than a rusted blade. If the next swarm's bigger, we're done for.",
            "Heard the Castellan's men dragged off another dissenter last night. At this rate, the walls will hold better than our loyalty.",
            "Ever notice the Castellan never leaves the upper wing?"
        }
    }
}
t_18.nodes = t_19
t["Fort Guard Respawnable"] = t_18
local t_21 = { start = "greeting", nodes = nil }
local t_22 = {
    greeting = {
        text = {
            "Keep walking, soft-skin. The Fell don't take kindly to loiterers.",
            "Piss off. I'm counting my scars.",
            "The Fell don't take kindly to gawkers. Move.",
            "I'll count to three. Then I draw steel. One..."
        }
    }
}
t_21.nodes = t_22
t["Fell Hunter"] = t_21
local t_24 = { start = "greeting", nodes = nil }
local t_25 = { greeting = { text = { "You are not welcomed here.", "Leave immediately." } } }
t_24.nodes = t_25
t["Holda the Witch Respawnable"] = t_24
local t_27 = { start = "greeting", nodes = nil }
local t_28 = {
    greeting = {
        text = {
            "You may have captured my body, but you'll never capture my spirit.",
            "I may be locked up in this cell, but my comrades will come to rescue me.",
            "I've been in tight spots before and always managed to escape. You'll see.",
            "You may have captured me, but you can't hold me forever. My friends will come for me.",
            "You may have captured me, but my spirit remains unbroken. I will escape and bring down your entire operation, mark my words.",
            "I never expected to be captured like this. I'm a spearsman, not a prisoner.",
            "I've faced death countless times on the battlefield. A little imprisonment won't break me.",
            "I will not be a pawn in your games, let me go.",
            "I feel like an animal, locked up in a cage. Is this how they treat all their prisoners?",
            "I wish I had a little more room to move around. I feel like I'm suffocating in here.",
            "I can't believe I've been locked up in this tiny cell for so long. I feel like I'm going stir-crazy."
        }
    }
}
t_27.nodes = t_28
t.Prisoner = t_27
local t_30 = { start = "greeting", nodes = nil }
local t_31 = {
    greeting = {
        text = {
            "Have you heard any news from the front lines? I'm worried about our soldiers.",
            "I've been trying to keep busy by helping out with the war effort any way I can. Have you done anything to help?",
            "I'm starting to get really anxious about the war. Have you found any way to cope with the stress?",
            "I heard a rumor that the Den of Thieves has hired a group of mercenaries to fight for them. I hope it's not true.",
            "I'm so worried about my family and friends who are fighting in the war. I just want them to come home safe.",
            "I can't believe that the Den of Thieves would declare war on us after we were already attacked by that wizard and those beasts. It's not fair.",
            "I saw some of the injured soldiers returning to the village yesterday. It's a miracle that they made it back alive.",
            "I can't shake the feeling that we're being set up. First the wizard and his beasts attack us, and now the Den of Thieves declares war? It just doesn't make sense.",
            "I hope the other villages will come to our aid in this war. We can't fight the Den of Thieves alone."
        }
    }
}
t_30.nodes = t_31
t["Kamo Villager"] = t_30
local t_33 = { start = "greeting", nodes = { greeting = { text = "..." } } }
t["Kamo Spirit Respawnable"] = t_33
local t_35 = { start = "greeting", nodes = nil }
local t_36 = {
    greeting = {
        text = {
            "I believe that music is the purest form of magic, as it can make people feel things that they never thought possible.",
            "The strings of my guitar vibrate like the waves of magic, and the melodies I play can conjure up memories and emotions like nothing else.",
            "Every performance I give is a chance to create something new and magical, to touch the hearts of those who listen and bring them into my world.",
            "I've always believed that music and magic are two sides of the same mark."
        }
    }
}
t_35.nodes = t_36
t.Leorio = t_35
local t_38 = { start = "greeting", nodes = nil }
local t_39 = {
    greeting = {
        text = { "This ain't no public inn. State your business.", "Turn back, little bird." }
    }
}
t_38.nodes = t_39
t["Assembly Commissioner"] = t_38
local t_41 = { start = "greeting", nodes = nil }
local t_42 = {
    greeting = {
        text = {
            "Honestly, if it were up to me, I wouldn't be here. But orders are orders, so here I am",
            "Hmph. They say talent can come from anywhere... but down here? Guess we'll see about that.",
            "Luminos save me... One more day in this dump, and I'm going to lose my mind.",
            "My brother used to say he'd be right beside me in the Knights. Turns out, he took over the family farm instead.",
            "I've been away from home for so long now, sometimes I forget what it feels like. Can't wait to see them one day.",
            "Here for the exam?",
            "The path of a Knight isn't easy; the exam will show if you're truly prepared."
        }
    }
}
t_41.nodes = t_42
t.Knight = t_41
local t_44 = { start = "greeting", nodes = nil }
local t_45 = {
    greeting = {
        text = {
            "Ooooh! You're not a mushmite! ...Are you?",
            "Your feet are so... stemless. How do you stand?",
            "Have you met Glowy? He sells the sticky-heal things.",
            "The sky dropped water again. Mean sky.",
            "You're very pointy. Are you a bad mushroom?",
            "Welcome! welcome! Have you tried the spore juice? It's extra fizzy today!"
        }
    }
}
t_44.nodes = t_45
t["Mushmite Villager"] = t_44
local t_47 = { start = "greeting", nodes = nil }
local t_48 = {
    greeting = {
        text = {
            "If you miss the exam, I'm not reopening this thing for you.",
            "Summoning portals aren't meant to be lingered by. Go! You're burning daylight and magic!",
            "If I lose focus and you end up in the abyss, that's on you.",
            "Talk to me after you've survived this exam. If you survive, that is."
        }
    }
}
t_47.nodes = t_48
t["Summoning Wizard"] = t_47
local t_50 = { Reputation = -10, start = "greeting", nodes = nil }
local t_51 = {
    greeting = {
        text = {
            "I warmly welcome you to my domain.",
            "I am Grey Fox, the greatest thief.",
            "Oppurtunity makes a thief.",
            "I am commonly branded as selfish, but I prefer the term 'opportunist'.",
            "I've stolen from kings, queens, and even dragons. And let me tell you, dragons are not easy to rob. But I'm always up for a challenge. That's why I'm the best."
        },
        choices = {
            { text = "What exactly is the Den of Thieves?", after = "choice1" },
            { text = "What made you a successful thief?", after = "choice2" },
            { text = "Why did you wage war with Kamo Village?", after = "choice3" }
        }
    },
    choice1 = {
        text = "The Den of Thieves is my kingdom. And as the king, I get to make the rules. So if you want to do business with us, you better be prepared to follow them. Or else. You don't want to cross me, trust me.",
        choices = { { text = "I won't." } }
    },
    choice2 = {
        text = "You wanna know the secret to being a successful thief? It's all about the thrill of the heist. If you don't love the rush of stealing, then you're not really living.",
        choices = { { text = "Oh." } }
    },
    choice3 = {
        text = "Ah, now that's a question a thief never answers. A magician doesn't reveal his tricks, and I don't reveal what or how I plan on stealing.",
        choices = { { text = "Oh." } }
    }
}
t_50.nodes = t_51
t["Grey Fox"] = t_50
local t_56 = { Reputation = -10, start = "greeting", nodes = nil }
local t_57 = {
    greeting = {
        text = {
            "I've always been drawn to the shadows. They offer protection and the element of surprise.",
            "I may be encamped at a base now, but I'm always ready for a good fight. Are you up for a little sparring match to pass the time?",
            "I can't wait to see the loot we'll be able to plunder from Kamo Village. Grey Fox is paying me a fortune for this job.",
            "I love the thrill of battle, don't you? There's nothing like the rush of adrenaline when you're charging into the fray.",
            "I'm looking forward to getting my hands dirty in this battle. It's been too long since I've had a good fight.",
            "I've been paid a handsome sum to lead this army. But the real reward will be the look on the villagers' faces when we storm in and take control.",
            "I have a reputation for being ruthless and sadistic. But I like to think of it as just being good at my job.",
            "I'm a mercenary, so I'm in it for the money. But let's be real, the power and control that comes with leading an army is pretty intoxicating.",
            "I'm not afraid to get my hands dirty. In fact, I quite enjoy it. Kamo Village is going to be a feast for the senses.",
            "I've heard that the general of Kamo Village is a formidable opponent. I can't wait to see how well he fares against my shadow magic."
        },
        choices = {
            { text = "How did you become so powerful with shadow magic?", after = "choice1" },
            { text = "Who are you?", after = "choice2" }
        }
    },
    choice1 = {
        text = "Oh, it's a long story. But let's just say that a little birdy told me about a certain book that held the secrets to shadow magic. And let's just say that Grey Fox wasn't above doing a little bit of thievery to help me out on it.",
        choices = { { text = "Impressive." } }
    },
    choice2 = {
        text = "Oh darling, where to begin? My name is Raven Blackwood, and I am a mercenary. I've been hired by the leader of the Den of Thieves, Grey Fox, to lead his army in the conquest of Kamo Village.",
        choices = { { text = "Perhaps." } }
    }
}
t_56.nodes = t_57
t["Raven Blackwood"] = t_56
local t_61 = { start = "greeting", nodes = nil }
local t_62 = {
    greeting = {
        text = {
            "If you're heading out, brew a potion or two first. You'll thank me later.",
            "Nothing beats a hot meal after a long gig.",
            "I remember when this hall was just a few tables and a leaky roof.",
            "Don't mind me. Just resting before the next gig.",
            "Funny little folk, the Mushmites. They talk about themselves like they're someone else.",
            "Watch your step in here. The Mushmites don't like being stepped on. Can't blame them.",
            "Word is somebody from the Hearth Realm got sent down to a dock as punishment. Poor soul.",
            "Don't step on a Mushmite's cap. Trust me, you'll hear about it for a week.",
            "Your grimoire is your best friend out there.",
            "Quiet day. I'll take it.",
            "Stay sharp out there, newcomer."
        }
    }
}
t_61.nodes = t_62
t["Veteran Adventurer"] = t_61

return t
