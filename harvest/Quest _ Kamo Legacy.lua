-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS.Quest : Kamo Legacy
-- Class: ModuleScript
-- bytes: 36309

local Basic_m = require(
    require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage.Modules.Basic
)
local t = {}
local t_1 = { start = "greeting", nodes = nil }
local t_2 = {
    greeting = {
        text = "There is beauty here that is incomparable in all of [Color=#55aaff]Elysium[/Color]. However, I lack the guts to confess my love for her.",
        choices = { { text = "I could help you with that.", after = "finish" } }
    },
    finish = {
        text = "Really? You'll be able to find her in the Tavern. You can't miss her!",
        choices = {
            { text = "Got it.", action = "AcceptQuest" },
            { text = "On second thought, nevermind.", exit = true }
        }
    }
}
t_1.nodes = t_2
t.Hollo = t_1
local t_5 = { start = "greeting", nodes = nil }
local t_6 = {
    greeting = {
        text = "Did you hear about [Color=#94be81]Forb Kravitz[/Color]? He claims that huge critters roam the [Color=#55aaff]Valemerian Mountains[/Color].",
        choices = { { text = "Really?", after = "finish" } }
    },
    finish = {
        text = "Let's wager. If his words hold true, I'll gift you one of my cherished heirlooms.",
        choices = { { text = "Don't go back on your word.", action = "AcceptQuest" } }
    }
}
t_5.nodes = t_6
t.Galleo = t_5
local t_9 = { start = "greeting", nodes = nil }
local t_10 = {
    greeting = {
        text = "[Color=#ff5959]Those wretched troublemakers have done it again![/Color]",
        choices = { { text = "What's the matter?", after = "finish" } }
    },
    finish = {
        text = "Those blasted children stole my wagon's spare wheels! Can you help me find them? I'll show my gratitude.",
        choices = {
            { text = "Of course.", action = "AcceptQuest" },
            { text = "I'll pass for now.", exit = true }
        }
    }
}
t_9.nodes = t_10
t["Old Man Adelfus"] = t_9
local t_13 = { start = "greeting", nodes = nil }
local t_14 = {
    greeting = {
        text = "You must be the adventurer sent by the chief to investigate the disappearances!",
        choices = {
            {
                text = "Do you have any idea what might be causing these disappearances?",
                after = "finish"
            }
        }
    },
    finish = {
        text = "I theorize that shadowy creatures in the Highland Forest could be responsible for taking the children.",
        choices = { { text = "I'll go investigate.", action = "AcceptQuest" } }
    }
}
t_13.nodes = t_14
t.Javier = t_13
local t_17 = { start = "greeting", nodes = nil }
local t_18 = {
    greeting = { text = "Darn it!", choices = { { text = "Huh?", after = "finish" } } },
    finish = {
        text = "Without my teacher's guidance, I attempted a potion of clarity, but alas, I failed, depleting my key ingredients... would you kindly gather them for me?",
        choices = {
            { text = "I'll see what I can do.", action = "AcceptQuest" },
            { text = "Another time.", exit = true }
        }
    }
}
t_17.nodes = t_18
t.Abra = t_17
local t_21 = { Reputation = nil, start = "greeting", nodes = nil }
local t_22 = { Faction = "Kamo", Value = Basic_m.ReputationBadMin / 2 }
t_21.Reputation = t_22
local t_23 = {
    greeting = {
        text = "Quiet! Keep your voice down. I've been tracking Holda the Witch for three weeks now, and I believe she's right inside this house.",
        choices = {
            { text = "Who is Holda the Witch?", after = "finish" },
            { text = "Why haven't you gone in yourself?", after = "choice2" },
            { text = "What do you need me to do?", after = "choice3" }
        }
    },
    finish = {
        text = "A former Assembly researcher who stole forbidden texts from the Citadel library. She's been conducting illegal experiments on civilians, using fire magic to... alter them. The burns on her victims are unmistakable.",
        choices = { { text = "That's quite the feat.", exit = true } }
    },
    choice2 = {
        text = "I'm a tracker, not a fighter. My job ends when I find the target. Besides, her magic could turn me inside out before I crossed the threshold. I need someone with actual combat experience.",
        choices = { { text = "Smart to know your limits.", exit = true } }
    },
    choice3 = {
        text = "Go inside and apprehend Holda. But be careful, she's cunning and her house is likely trapped. I'll be waiting out here to confirm the capture.",
        choices = {
            { text = "I'll bring her out, one way or another.", action = "AcceptQuest" },
            { text = "I'm not tangling with a witch today.", exit = true }
        }
    }
}
t_21.nodes = t_23
t["Assembly Tracker Zohran"] = t_21
local t_28 = { Reputation = nil, start = "greeting", nodes = nil }
local t_29 = { Faction = "Kamo", Value = Basic_m.ReputationBadMin / 2 }
t_28.Reputation = t_29
local t_30 = {
    greeting = {
        text = "You there. Those arms look like they could handle some boar wrestling. I need Ember Blooms, the kind that grow in the Coves, but those Blackfyre Boars won't let anyone near them.",
        choices = {
            { text = "Why do you need these blooms so badly?", after = "finish" },
            { text = "What makes these boars so dangerous?", after = "choice2" }
        }
    },
    finish = {
        text = "Ember Blooms make the best burn salve this side of the region. The boars are territorial about them, always have been. Something in the soil there makes both the blooms and the boars meaner than usual.",
        choices = { { text = "Interesting. Good luck with that.", exit = true } }
    },
    choice2 = {
        text = "Blackfyre Boars aren't your average boar. Their tusks can pierce steel, and they charge faster than you can blink. Worst part is, they use a sort of flame magic. Bring me ten of those flowers, and I'll make it worth your while.",
        choices = {
            { text = "I'll get your blooms.", action = "AcceptQuest" },
            { text = "Not worth getting gored over some flowers.", exit = true }
        }
    }
}
t_28.nodes = t_30
t.Wilder = t_28
local t_34 = { start = "greeting", nodes = nil }
local t_35 = {
    greeting = {
        text = "Ah, a visitor! Tell me... do you believe in turning monsters into masterworks?",
        choices = {
            { text = "Who are you really?", after = "finish" },
            { text = "What's this about monster masterworks?", after = "choice2" }
        }
    },
    finish = {
        text = "A humble scholar of... unconventional materials. Let's just say I've learned more from dissecting corpses than any library. Though some call that heresy. I call it progress.",
        choices = { { text = "Fascinating and slightly disturbing.", exit = true } }
    },
    choice2 = {
        text = "Imagine armor made from Arachne. I've cracked the alchemy to stabilize its venomous properties. Bring me a fresh carcass with its core intact, and I'll share the schematic. For a fellow visionary, of course.",
        choices = {
            { text = "You're mad... but I'll get your spider parts.", action = "AcceptQuest" },
            { text = "I prefer my armor non-venomous, thanks.", exit = true }
        }
    }
}
t_34.nodes = t_35
t["Forb Kravitz"] = t_34
local t_39 = { start = "greeting", nodes = nil }
local t_40 = {
    greeting = {
        text = "You! Yes, YOU! Come here! I need materials. Specific materials. For something that has never been built before and probably should not be built but absolutely will be.",
        choices = {
            { text = "What are you building?", after = "explain" },
            { text = "Why me?", after = "whyme" }
        }
    },
    whyme = {
        text = "Because you're standing there and you look like someone who doesn't ask too many questions. I was wrong, apparently. But you're still here so let's move on.",
        choices = { { text = "Fine. What are you building?", after = "explain" } }
    },
    explain = {
        text = "A gauntlet. Not just any gauntlet. A gauntlet that channels the raw animating force of a Golem through a wearable frame. I am calling it the Gauntus Animatus and it will be either my greatest achievement or a very loud mistake.",
        choices = {
            { text = "What do you need from me?", after = "materials" },
            { text = "How is that even possible?", after = "possible" }
        }
    },
    possible = {
        text = "Lumivine for the binding structure, Arcane Tears for the channeling medium, Stone for the frame, and Manahearts to power the whole thing. On paper it works perfectly. In practice it will also work perfectly. I am choosing to believe that.",
        choices = { { text = "And you want me to gather all of that.", after = "materials" } }
    },
    materials = {
        text = "Lumivine, Arcane Tears, Stone, and Manahearts. Bring all of it back here and I'll have the schematic ready for you once construction is complete. You'll want to hold onto that schematic. Trust me.",
        choices = { { text = "I'll gather what you need.", after = "accept" } }
    },
    blowup = {
        text = "The probability of that is very low. Statistically. Based on my own calculations which I have not had independently verified. You'll be fine. Probably go gather the materials.",
        choices = { { text = "Incredibly reassuring. I'll get the materials.", after = "accept" } }
    },
    accept = {
        text = "Lumivine, Arcane Tears, Stone, Manahearts. Do not substitute anything. Do not get creative. Bring exactly what I asked for and we will both walk away from this very happy. One of us more than the other, but still.",
        choices = {
            { text = "I'll be back with everything.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_39.nodes = t_40
t["Hephaestus the Mad"] = t_39
local t_48 = { Reputation = nil, start = "greeting", nodes = nil }
local t_49 = { Faction = "Kamo", Value = Basic_m.ReputationBadMin / 2 }
t_48.Reputation = t_49
local t_50 = {
    greeting = {
        text = "Mister! Mister! You gotta help!",
        choices = {
            {
                text = "Easy there, little one. Take a breath and tell me what's wrong.",
                after = "finish"
            }
        }
    },
    finish = {
        text = "Elicia! The Kamo Blitz is starting today! But she doesn't know! I wrote her a letter, see? She should be by the well!",
        choices = {
            { text = "I'll help you pal.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_48.nodes = t_50
t.Ryze = t_48
local t_53 = { Reputation = nil, start = "greeting", nodes = nil }
local t_54 = { Faction = "Kamo", Value = Basic_m.ReputationBadMin / 2 }
t_53.Reputation = t_54
local t_55 = {
    greeting = {
        text = "Hello there, traveler. Have you come to help us with our current problem?",
        choices = { { text = "What problem?", after = "finish" } }
    },
    finish = {
        text = "Mercenaries took our supplies. We can't sustain battles without those supplies. Up for the challenge?",
        choices = {
            { text = "Yes, I am.", action = "AcceptQuest" },
            { text = "Another time.", exit = true }
        }
    }
}
t_53.nodes = t_55
t["Guard Layla"] = t_53
local t_58 = { Reputation = nil, start = "greeting", nodes = nil }
local t_59 = { Faction = "Kamo", Value = Basic_m.ReputationBadMin / 2 }
t_58.Reputation = t_59
local t_60 = {
    greeting = {
        text = "Adventurer, I need your help. Deliver this letter to Vulcan, the blacksmith in Kamo Village. He's vital for forging spears for our war effort.",
        choices = { { text = "Yes, I'll do it.", after = "finish" } }
    },
    finish = {
        text = "Excellent. Time is of the essence, so make haste. Bring back word from Vulcan.",
        choices = {
            { text = "I'll make sure to deliver the letter.", action = "AcceptQuest" },
            { text = "Actually, nevermind.", exit = true }
        }
    }
}
t_58.nodes = t_60
t["Guard Shiro"] = t_58
local t_63 = { Reputation = nil, start = "greeting", nodes = nil }
local t_64 = { Faction = "Kamo", Value = Basic_m.ReputationBadMin / 2 }
t_63.Reputation = t_64
local t_65 = {
    greeting = {
        text = "Hello adventurer, I heard you've been slacking off in training lately. That's not gonna cut it when the war starts.",
        choices = { { text = "Sorry, I've just been busy with other stuff.", after = "finish" } }
    },
    finish = {
        text = "The war's intense. Stay sharp or risk death, and worse, endanger others due to negligence.",
        choices = {
            { text = "I'll make sure to get in some extra practice.", action = "AcceptQuest" },
            { text = "Another time.", exit = true }
        }
    }
}
t_63.nodes = t_65
t["Captain Hayes"] = t_63
local t_68 = { Reputation = nil, start = "greeting", nodes = nil }
local t_69 = { Faction = "Kamo", Value = Basic_m.ReputationBadMin / 2 }
t_68.Reputation = t_69
local t_70 = {
    greeting = {
        text = "Hey, you. Yes, you. Do you see how low that stockpile of wood is? We're down to scraps. The Kamo army's got us building forts around every strategic position in the region, and at this rate we won't have enough timber to finish, let alone keep up repairs.",
        choices = {
            { text = "I can help. What do you need?", after = "explain" },
            { text = "What happened to the supply?", after = "why" }
        }
    },
    why = {
        text = "Between the fort construction and the repairs after the attacks, we burned through it faster than anyone expected. I'd go restock myself, but the army needs me here overseeing the builds. Can't exactly leave my post.",
        choices = { { text = "I'll get more for you.", after = "explain" } }
    },
    explain = {
        text = "Head over to the timber vendor and buy up whatever wood he's got in stock. We need those logs back here as soon as possible.",
        choices = {
            { text = "How much do you need?", after = "amount" },
            { text = "On it. I'll be back with wood.", action = "AcceptQuest" }
        }
    },
    amount = {
        text = "Five. Just be sure you've got enough marks on you, the vendor doesn't haggle much these days.",
        choices = {
            { text = "Understood. I'll get it done.", action = "AcceptQuest" },
            { text = "Not right now. I'll come back later.", exit = true }
        }
    }
}
t_68.nodes = t_70
t.Daniel = t_68
local t_75 = { start = "greeting", nodes = nil }
local t_76 = {
    greeting = {
        text = "Thank Luminos you're here. I dropped the whole shipment. Every last crate and sack, just... gone. Scattered everywhere when those wolves came out of nowhere.",
        choices = {
            { text = "Are you hurt?", after = "hurt" },
            { text = "What was in the shipment?", after = "contents" }
        }
    },
    hurt = {
        text = "No, no. I ran fast enough. Can't say the same for the cargo though. I looked back and saw the crates tumbling everywhere. I couldn't go back in there alone with those wolves still circling.",
        choices = {
            { text = "What was in the shipment?", after = "contents" },
            { text = "I'll go recover it for you.", after = "accept" }
        }
    },
    contents = {
        text = "Supplies for the village. Food, medicine, tools. Nothing that can afford to sit out there and rot, especially not right now with everything going on. Someone has to go back in and collect it all.",
        choices = {
            { text = "I'll go get it.", after = "accept" },
            { text = "Are the wolves still out there?", after = "wolves" }
        }
    },
    wolves = {
        text = "Almost certainly. They didn't follow me far but they weren't leaving either. Whatever drew them out, they're comfortable in that clearing now. Watch yourself in there.",
        choices = {
            { text = "I can handle them. I'll recover the supplies.", after = "accept" },
            { text = "I'll avoid them if I can and fight if I have to.", after = "accept" }
        }
    },
    accept = {
        text = "The crates and sacks are spread all over the place, I couldn't tell you exactly where each one landed. Just sweep the area and bring everything back here. And please, be careful. The shipment is important but it's not worth your life.",
        choices = {
            { text = "I'll get everything back. Count on it.", action = "AcceptQuest" },
            { text = "Not right now. I'll come back to this.", exit = true }
        }
    }
}
t_75.nodes = t_76
t.Lisa = t_75
local t_82 = { start = "greeting", nodes = nil }
local t_83 = {
    greeting = {
        text = "Oh good, someone with a strong back. I've been staring at those crates all morning trying to will them into moving. Hasn't worked so far.",
        choices = {
            { text = "What needs doing?", after = "explain" },
            { text = "I can help. What are you moving?", after = "explain" }
        }
    },
    explain = {
        text = "Seven crates sitting in the storehouse that need to go to the silo. Should have been done last week but one thing led to another and here we are.",
        choices = {
            { text = "Why the silo?", after = "why" },
            { text = "Seven crates. I can handle that.", after = "accept" }
        }
    },
    why = {
        text = "Storehouse is getting repurposed. Everything in there needs to be out before work starts. The silo's got the space, so that's where it's going.",
        choices = { { text = "Makes sense. I'll get them moved.", after = "accept" } }
    },
    accept = {
        text = "All seven, mind you. Don't leave any behind or I'll hear about it. The crates are right inside the storehouse, you can't miss them.",
        choices = {
            { text = "I'll have them all moved shortly.", action = "AcceptQuest" },
            { text = "Can't right now. Maybe later.", exit = true }
        }
    }
}
t_82.nodes = t_83
t["Farmer Carver"] = t_82
local t_88 = { start = "greeting", nodes = nil }
local t_89 = {
    greeting = {
        text = "Oi! You there! Yes, you. Name's Daeron the Daring. Maybe you've heard of me. Most people have.",
        choices = {
            { text = "Can't say I have.", after = "nope" },
            { text = "What do you want?", after = "want" }
        }
    },
    nope = {
        text = "You will. I've flown every race circuit in this region and I haven't met anyone worth competing against in months. It's getting embarrassing. For everyone else, I mean.",
        choices = {
            { text = "Is that a challenge?", after = "challenge" },
            { text = "Why are you telling me this?", after = "want" }
        }
    },
    want = {
        text = "Because you've got that look. Like you think you're faster than you are. I love that look. It means I get to prove someone wrong. Question is whether you're willing to find out.",
        choices = {
            { text = "Absolutely.", after = "challenge" },
            { text = "Depends what you have in mind.", after = "races" },
            { text = "Maybe another time.", exit = true }
        }
    },
    challenge = {
        text = "Good answer. I'm not interested in a single race. Anyone can get lucky once. I want to see if you can keep up across three different circuits. That's where you find out who actually belongs in the sky.",
        choices = {
            { text = "Which three?", after = "races" },
            { text = "Three races. I'll do all of them.", after = "accept" }
        }
    },
    races = {
        text = "The Broomshroom Zoom, the Elden Derby, and the Kamo Broom Blitz. Three different tracks, three different tests. Each one will make you fly differently. If you can handle all three you might actually be worth talking to.",
        choices = {
            { text = "I'll compete in all three.", after = "accept" },
            { text = "Maybe another time.", exit = true }
        }
    },
    accept = {
        text = "Ha. I like the confidence. Misplaced, probably, but I respect the commitment. Broomshroom Zoom, Elden Derby, Kamo Broom Blitz. Complete all three and come find me. Clock's already ticking.",
        choices = {
            { text = "Don't blink. You might miss it.", action = "AcceptQuest" },
            { text = "I'll see you on the other side.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_88.nodes = t_89
t["Daeron the Daring"] = t_88
local t_96 = { start = "greeting", nodes = nil }
local t_97 = {
    greeting = {
        text = "I'd say I have time to chat but I really don't. Blackfyre Boars have been multiplying faster than I can keep up with and my list is three days behind already.",
        choices = {
            { text = "I can help. What do you need?", after = "explain" },
            { text = "What's a Blackfyre Boar?", after = "what" }
        }
    },
    what = {
        text = "Big, dark-bristled, mean when cornered. They're not the worst thing in these wilds but there's too many of them right now and thinning the numbers is my job. Has been for years. Usually I can manage it alone.",
        choices = { { text = "But not right now.", after = "notnow" } }
    },
    notnow = {
        text = "Not right now. Between everything else going on I've barely slept. If you're offering help, I'm not too proud to take it.",
        choices = { { text = "Point me in the right direction.", after = "accept" } }
    },
    explain = {
        text = "Blackfyre Boars. Numbers are up and I'm stretched too thin to handle it all myself. I just need someone to go out there and cut the herd down. Straightforward work.",
        choices = {
            { text = "How many are we talking?", after = "howmany" },
            { text = "I'll handle it. How hard can they be?", after = "warning" }
        }
    },
    howmany = {
        text = "Enough to keep you busy. Don't underestimate them either. They're not clever but they're heavy and they hit hard when they charge. Keep your footing and don't let them get a run at you.",
        choices = { { text = "Noted. I'll head out now.", after = "accept" } }
    },
    warning = {
        text = "Famous last words. They're not clever but a charging Blackfyre will ruin your whole day if you're not paying attention. Stay on your feet and you'll be fine.",
        choices = { { text = "Good to know. I'll be careful.", after = "accept" } }
    },
    accept = {
        text = "Thank you. Genuinely. Come back when it's done and I'll make it worth your time. Right now I just need one less thing on my plate.",
        choices = {
            { text = "Consider it handled.", action = "AcceptQuest" },
            { text = "Not right now. Maybe later.", exit = true }
        }
    }
}
t_96.nodes = t_97
t.Qingyi = t_96
local t_105 = { start = "greeting", nodes = nil }
local t_106 = {
    greeting = {
        text = "You've got that look. The one where someone thinks they're a hunter because they've killed a few things and walked away. I've seen it a thousand times.",
        choices = {
            { text = "I'm better than I look.", after = "better" },
            { text = "What would it take to prove otherwise?", after = "prove" }
        }
    },
    better = {
        text = "Everyone is, according to them. I don't deal in opinions. I deal in results. You want to call yourself a hunter, then show me what you've actually put down.",
        choices = { { text = "What do you want me to hunt?", after = "list" } }
    },
    prove = {
        text = "Good question. First sensible thing you've said. I've been hunting these lands longer than most people have been walking them. I know every creature out there by name, by track, by the way they kill. You want my respect, you earn it the same way I did.",
        choices = { { text = "Tell me what needs to be hunted.", after = "list" } }
    },
    list = {
        text = "Every major species in this region. Blackfyre Boar, Dire Wolf, Wolf, Alke, Mushknight, Mushmite, and Golem. At least one of each. Not easy kills either, some of those will test you.",
        choices = {
            { text = "That's a long list.", after = "longlist" },
            { text = "I'll get it done.", after = "accept" }
        }
    },
    longlist = {
        text = "It is. That's the point. Any fool can kill one thing on a good day. I want to know you can handle all of it. Every terrain, every temperament, every kind of fight this region throws at you.",
        choices = {
            { text = "And if I do?", after = "reward" },
            { text = "I'll get it done.", after = "accept" }
        }
    },
    reward = {
        text = "Then you've earned something you won't regret. I'll leave it at that. Come back when the list is done. Every last one.",
        choices = { { text = "I'll be back when it's finished.", after = "accept" } }
    },
    accept = {
        text = "No shortcuts. No half measures. I'll know if you cut corners. Come back when every species on that list is accounted for and not a moment before.",
        choices = {
            { text = "Understood. I'll see it through.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_105.nodes = t_106
t.Skadi = t_105
local t_114 = { start = "greeting", nodes = nil }
local t_115 = {
    greeting = {
        text = "Oh! Oh thank goodness, a capable looking person. You look very capable. Extremely capable. Please tell me you're as capable as you look.",
        choices = {
            { text = "That depends. What do you need?", after = "explain" },
            { text = "...are you alright?", after = "alright" }
        }
    },
    alright = {
        text = "Absolutely. Perfectly fine. Totally composed. I am an Assembly Hunter, I am always composed. I just... have a small situation that I could use some assistance with. A very small one.",
        choices = { { text = "What kind of situation?", after = "explain" } }
    },
    explain = {
        text = "The Magic Assembly has assigned me to hunt the Dire Wolf here. Which is a completely reasonable assignment that I am completely prepared for. I simply thought that perhaps, hypothetically, someone else might want to do it instead. For a reward.",
        choices = { { text = "What kind of reward?", after = "reward" } }
    },
    reward = {
        text = "Complete the hunt and bring me proof and I will make it worth your while. You have my word as an Assembly Hunter. Which is very official and binding.",
        choices = {
            { text = "Is there anything I should know about the Dire Wolf?", after = "warning" },
            { text = "Consider it done.", after = "accept" }
        }
    },
    warning = {
        text = "About the Dire Wolf? No. Nothing worth mentioning. It is just a wolf. A big wolf. Nothing to... you know what, it's fine. You seem like you can handle yourself. Probably. Yes. You'll be fine.",
        choices = {
            { text = "That wasn't convincing at all.", after = "notconvincing" },
            { text = "Right. I'll head out.", after = "accept" }
        }
    },
    notconvincing = {
        text = "I am fully convinced on your behalf! Now please go before I think about it too hard. It should be residing in the skull under us. Good luck. Not that you'll need it. I hope.",
        choices = { { text = "I'll be back.", after = "accept" } }
    },
    accept = {
        text = "Wonderful. I'll be right here, perfectly calm, not thinking about it at all. Come back when it's done and I will have your reward ready. You have my sincerest gratitude.",
        choices = {
            { text = "Try not to worry too much.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_114.nodes = t_115
t["Assembly Hunter Legolas"] = t_114
local t_123 = { start = "greeting", nodes = nil }
local t_124 = {
    greeting = {
        text = "Back away! It's... it's an Assembly Golem. I was just trying to understand how it works, make some improvements... and then it just snapped.",
        choices = {
            { text = "You were tinkering with an Assembly Golem?", after = "tinker" },
            { text = "Where is it now?", after = "where" }
        }
    },
    tinker = {
        text = "I had it under control. I was close to figuring out its core, how it actually thinks, how it moves. And then one wrong adjustment and... yes. This happened. I know. I know.",
        choices = {
            { text = "Where did it go?", after = "where" },
            { text = "What exactly did you do to it?", after = "what" }
        }
    },
    what = {
        text = "I may have... destabilised the arcane tear at its centre. It's the source of a Golem's animation. I thought if I could access it I could learn something extraordinary. Instead I made it extraordinarily angry.",
        choices = { { text = "Where is it now?", after = "where" } }
    },
    where = {
        text = "It broke loose before I could contain it. It's up ahead and it is not calm. I can't stop it myself, I'm a researcher, not a fighter. But someone needs to put it down before it hurts someone.",
        choices = {
            { text = "I'll handle it.", after = "core" },
            { text = "This is entirely your fault.", after = "fault" }
        }
    },
    fault = {
        text = "I am aware of that, thank you. I feel terrible enough already. Please, just... stop it before the situation gets any worse.",
        choices = { { text = "Fine. I'll deal with it.", after = "core" } }
    },
    core = {
        text = "When you kill it, the arcane tear will be left behind. Please bring it back to me. It's dangerous loose and... honestly I'd still like to study it. From a much safer distance this time.",
        choices = {
            { text = "Hunt down the Golem and retrieve the arcane tear. Got it.", after = "accept" }
        }
    },
    accept = {
        text = "Thank you. Truly. And when you get back... maybe we don't mention the tinkering part to anyone. It doesn't need to be a whole thing.",
        choices = {
            { text = "No promises. I'll be back with the tear.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_123.nodes = t_124
t.Sindria = t_123
local t_132 = { start = "greeting", nodes = nil }
local t_133 = {
    greeting = {
        text = "Ugh, of all the days to lose my paddle! I'm stuck here with a boat that won't move.",
        choices = {
            { text = "What happened to it?", after = "what" },
            { text = "Can I help?", after = "help" }
        }
    },
    what = {
        text = "I stayed at the inn here and I think I left it there. I was so tired that I just walked off without it. It's somewhere in that inn, I just know it.",
        choices = { { text = "Sounds like a rough morning." } }
    },
    help = {
        text = "Would you? I can't leave the boat, and I'd hate to miss the fish. Check the inn in Kamo Village and bring my paddle back. I'll make it worth your time.",
        choices = {
            { text = "I'll find your paddle.", action = "AcceptQuest" },
            { text = "Maybe later." }
        }
    }
}
t_132.nodes = t_133
t["Boatman Pip"] = t_132
local t_137 = { start = "greeting", nodes = nil }
local t_138 = {
    greeting = {
        text = "Hey, you look like someone with a kind heart. Can I ask you for a big favor?",
        choices = {
            { text = "What kind of favor?", after = "favor" },
            { text = "Sorry, I'm busy." }
        }
    },
    favor = {
        text = "I want to start a small business making weapons for adventurers. I know how to make them. I just don't have the materials, and I can't afford any. Could you bring me 5 wood and 5 stone?",
        choices = {
            { text = "Why are you doing this?", after = "sister" },
            { text = "What do I get out of it?", after = "payback" },
            { text = "That sounds risky." }
        }
    },
    sister = {
        text = "My little sister dreams of going to the Hearth Realm. She talks about it every day. I want to save enough to send her there. This business is how I plan to do it.",
        choices = {
            { text = "That's a good reason.", after = "payback" },
            { text = "I'll think about it." }
        }
    },
    payback = {
        text = "Once I make the weapons and sell them, I'll pay you back a portion of the profit. I promise. I know it's a lot to trust, but I won't forget what you did for me.",
        choices = {
            { text = "Alright, I'll gather the materials.", action = "AcceptQuest" },
            { text = "I need to think about it." }
        }
    }
}
t_137.nodes = t_138
t.Rysia = t_137
local t_143 = { start = "greeting", nodes = nil }
local t_144 = {
    greeting = {
        text = "Ahhh... This hot spring is perfect. Best day I've had in months. There's just one thing missing.",
        choices = { { text = "What's missing?", after = "missing" } }
    },
    enjoy = {
        text = "Oh, you have no idea. My back hasn't felt this good in years. I could stay in here all week if my legs would let me get out.",
        choices = { { text = "So what's missing?", after = "missing" }, { text = "Sounds nice." } }
    },
    missing = {
        text = "Bamboo. I like to chew on a piece while I relax. It's a family tradition. My dad did it, and his dad did it too. Without it, a good soak just doesn't feel right.",
        choices = {
            { text = "Why bamboo?", after = "tradition" },
            { text = "Can I get some for you?", after = "help" }
        }
    },
    tradition = {
        text = "My grandfather said it keeps your mind calm and your teeth strong. I don't know if that's true, but I'm not going to be the one who breaks the tradition.",
        choices = {
            { text = "I'll see what I can do.", after = "help" },
            { text = "Sounds like a good tradition." }
        }
    },
    help = {
        text = "Would you? I'd go myself, but I'm not leaving this water. Bring me 5 bamboo and I'll make it worth your while.",
        choices = {
            { text = "I'll find some bamboo.", action = "AcceptQuest" },
            { text = "Maybe later." }
        }
    }
}
t_143.nodes = t_144
t.Ginn = t_143
local t_150 = { start = "greeting", nodes = nil }
local t_151 = {
    greeting = {
        text = "Hmph. Just my luck. The rope snapped and my bucket fell down the well. Can you help me?",
        choices = { { text = "What do you need?", after = "help" }, { text = "Sorry, I'm busy." } }
    },
    help = {
        text = "Go down the well and bring back my bucket. I'd go myself, but I don't like the dark. Yes, I know what I am. Don't say anything.",
        choices = {
            { text = "I'll get your bucket.", action = "AcceptQuest" },
            { text = "Maybe later." }
        }
    }
}
t_150.nodes = t_151
t.Jack = t_150
local t_154 = { start = "greeting", nodes = nil }
local t_155 = {
    greeting = {
        text = "Ugh. Don't just stand there. If you're not here to help, you're in the way.",
        choices = {
            { text = "What's wrong?", after = "back" },
            { text = "Can I help?", after = "favor" },
            { text = "Sorry, I'm busy." }
        }
    },
    back = {
        text = "My back, that's what. Forty years of bending over crops, and now I can't bend at all. The wheat is ripe, and I can't pick it. Blasted thing.",
        choices = {
            { text = "I can pick it for you.", after = "favor" },
            { text = "Sounds painful." }
        }
    },
    favor = {
        text = "Hmph. Fine. Harvest 5 wheat from my garden and bring it to me. And don't trample the crops. I've seen how you adventurers walk.",
        choices = {
            { text = "I'll harvest 5 wheat.", action = "AcceptQuest" },
            { text = "Maybe later." }
        }
    }
}
t_154.nodes = t_155
t["Farmer Carver"] = t_154

return t
