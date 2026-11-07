-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS.Quest : Mushroom Forest
-- Class: ModuleScript
-- bytes: 20011

local _ = require
local t = {}
local t_1 = { start = "greeting", nodes = nil }
local t_2 = {
    greeting = {
        text = "Pardon me. Something's wrong with the cave on the mountainside. I was preparing for my next experiment when I heard a screech... the kind that makes your spine crawl.",
        choices = {
            { text = "You want me to investigate?", after = "finish" },
            { text = "What did you hear exactly?", after = "choice2" }
        }
    },
    finish = {
        text = "Discreetly, yes. Take these prototype mana bombs as insurance. I've been working on them for a while and they should work as intended. And if you see egg sacs... well, that's what the bombs are for.",
        choices = {
            { text = "I'll investigate.", action = "AcceptQuest" },
            { text = "On second thought nevermind.", exit = true }
        }
    },
    choice2 = {
        text = "A screech similar to one Alkes make when they're agitated. The problem is, they shouldn't be nesting this faraway from the mountains. Not unless something drove them here.",
        choices = { { text = "That does sound serious.", exit = true } }
    }
}
t_1.nodes = t_2
t.Asami = t_1
local t_6 = { start = "greeting", nodes = nil }
local t_7 = {
    greeting = {
        text = "Ahhh, traveler! You've come at a dire time. The forest... it weeps. Our kin near the lake, their caps glow too bright, their spores too thick. Something has twisted them. They no longer sing with the mycelium's chorus. Will you help us restore balance?",
        choices = { { text = "Twisted? What happened to them?", after = "finish" } }
    },
    finish = {
        text = "Something crept into their roots. Now they spread without wisdom, choking herbs and livestock alike. We've tried singing to them, but... they must be returned to the earth. Bring me seven of their fallen caps, not as trophies, but as proof of your deeds.",
        choices = {
            { text = "Seven mushrooms. Got it.", action = "AcceptQuest" },
            { text = "Sounds like the town's problem, not mine.", exit = true }
        }
    }
}
t_6.nodes = t_7
t.Shroombert = t_6
local t_10 = { start = "greeting", nodes = nil }
local t_11 = {
    greeting = {
        text = "The Assembly sent me to patch up this waypoint gate, but... I think I came underprepared. Tools are fine but I'm missing a few key materials.",
        choices = { { text = "You think I could get you what you're missing?", after = "finish" } }
    },
    finish = {
        text = "Really? That would save me a trip back. I'll need a few [b]Hearthstones[/b] and [b]Manahearts[/b] to get this running again. If you can bring them, I'll handle the rest.",
        choices = {
            { text = "Got it.", action = "AcceptQuest" },
            { text = "Nevermind. I don't have time.", exit = true }
        }
    }
}
t_10.nodes = t_11
t["Brother Grimm"] = t_10
local t_14 = { start = "greeting", nodes = nil }
local t_15 = {
    greeting = {
        text = "...oh. Someone comed. Ploppy is sorry she cannot get up. Ploppy's sporey-bits are all achey and her cap feels too heavy...",
        choices = {
            { text = "Are you okay? What do you need?", after = "explain" },
            { text = "How long have you been like this?", after = "howlong" }
        }
    },
    howlong = {
        text = "Mmm... many sleeps. Ploppy tried to stand on the second sleep but the room went all spinny and Ploppy decided the bed was better. The bed is very good.",
        choices = { { text = "What can I do to help?", after = "explain" } }
    },
    explain = {
        text = "Ploppy heard that... a potion of clarity makes the achey go away. Nobody sells potions anymore, so Ploppy was going to brew one herself. She even gathered the ingredients. Then the room went spinny.",
        choices = {
            { text = "I'll brew it for you. Don't worry.", after = "recipe" },
            { text = "Can't you brew it yourself?", after = "cantgo" }
        }
    },
    cantgo = {
        text = "Ploppy tried. Ploppy's legs said no. Very rude of them.",
        choices = { { text = "Alright. I'll brew it for you.", after = "recipe" } }
    },
    recipe = {
        text = "It is easy, Ploppy promises. One [b]Mana Bloom[/b] and two [b]Cloth[/b] in a cauldron makes a [b]Minor Potion of Clarity[/b]. Ploppy will give you enough for two tries, in case the first one goes sludgy. The nearest cauldron is in [b]Dewfall Refuge[/b].",
        choices = { { text = "One Mana Bloom, two Cloth. Got it.", after = "accept" } }
    },
    accept = {
        text = "Oh... you would do that for Ploppy? You are very nice. Ploppy thinks you are maybe the nicest non-mushroom she has ever met. Ploppy will wait here. She is good at waiting.",
        choices = { { text = "Rest up. I'll be back soon.", action = "AcceptQuest" } }
    }
}
t_14.nodes = t_15
t.Ploppy = t_14
local t_22 = { start = "greeting", nodes = nil }
local t_23 = {
    greeting = {
        text = "Hmph. You. Finally someone walks by who looks like they can do something useful. Do you see this? Do you SEE this?",
        choices = {
            { text = "The glowshrooms?", after = "yes" },
            { text = "What's the problem?", after = "yes" }
        }
    },
    yes = {
        text = "YES. The glowshrooms. Snappy's glowshrooms. Well, not Snappy's glowshrooms, Snappy does not WANT these glowshrooms. They are too many and too glowy and they are blocking the whole path. Nobody can get through.",
        choices = {
            { text = "Can't you move them yourself?", after = "myself" },
            { text = "I can clear them out for you.", after = "accept" }
        }
    },
    myself = {
        text = "Snappy is a mushmite, not a lumberjack. And besides, it is very awkward to remove one's own cousins. Even if they are very rude and overgrown and in the way.",
        choices = { { text = "Fair enough. I'll take care of it.", after = "accept" } }
    },
    accept = {
        text = "Good. Pull them out, stomp them, Snappy does not care how you do it. Just clear the path. All of it. Snappy is tired of squeezing through like some kind of spore in a crack.",
        choices = {
            { text = "How many are there?", after = "howmany" },
            { text = "I'll get it done.", action = "AcceptQuest" }
        }
    },
    howmany = {
        text = "Too many. That is how many. They doubled overnight and Snappy does not appreciate it one bit. Just go and clear them before they double again. Hmph.",
        choices = {
            { text = "Alright. I'll handle it.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_22.nodes = t_23
t.Snappy = t_22
local t_29 = { start = "greeting", nodes = nil }
local t_30 = {
    greeting = {
        text = "Hm. Fresh boots, clean hands, and that look on your face like you have never taken a corner at full speed in your life. Gargamel has seen your type before.",
        choices = {
            { text = "What type is that?", after = "type" },
            { text = "I know how to race.", after = "challenge" }
        }
    },
    type = {
        text = "The type that watches the race from the sidelines and thinks they could do better. Then they get on the track and find out very quickly that they could not.",
        choices = {
            { text = "You don't know what I'm capable of.", after = "challenge" },
            { text = "Maybe I'll surprise you.", after = "challenge" }
        }
    },
    challenge = {
        text = "Ha. They all say that. You want Gargamel's respect? It is not given. It is earned. The race course runs straight through Mushroom Village. Finish it. Then we talk.",
        choices = {
            { text = "Fine. I'll run the course.", after = "accept" },
            { text = "What's the course like?", after = "explain" }
        }
    },
    explain = {
        text = "Tight corners, uneven ground, and mushrooms everywhere that do not move just because you ask nicely. It is a proper track. Not something you stumble through. Something you learn.",
        choices = { { text = "I'll figure it out. I'm in.", after = "accept" } }
    },
    accept = {
        text = "Good. Gargamel will be watching the board. If your name appears, maybe, maybe, you are worth talking to. Now go. Stop wasting time standing here.",
        choices = {
            { text = "I'll see you at the top of that board.", action = "AcceptQuest" },
            { text = "I need a moment first.", exit = true }
        }
    }
}
t_29.nodes = t_30
t.Gargamel = t_29
local t_36 = { start = "greeting", nodes = nil }
local t_37 = {
    greeting = {
        text = "Oh my sporey stars... just look at it. Hogatha was ill for only a little while and the whole garden went and forgot itself completely.",
        choices = {
            { text = "What happened to it?", after = "explain" },
            { text = "It looks pretty rough. Do you need help?", after = "explain" }
        }
    },
    explain = {
        text = "The weeds came first, sneaky little things. Then the poor dears that did not get watered just... drooped away. Hogatha tried to go out yesterday but her old legs said absolutely not.",
        choices = {
            { text = "I can clean it up for you.", after = "really" },
            { text = "What needs doing exactly?", after = "tasks" }
        }
    },
    really = {
        text = "You would do that for a old mushmite you just met? Oh, you are a kind one. Hogatha can see it in your cap. The good ones always have a certain look about them.",
        choices = { { text = "Of course. Tell me what needs doing.", after = "tasks" } }
    },
    tasks = {
        text = "Pull up the withered plants first, no saving those poor things. Then the weeds along the flower beds, they have gotten terribly bold. And the healthy ones just need a good drink. The watering can is sitting right there on the porch, Hogatha made sure of that.",
        choices = {
            { text = "I'll take care of all of it.", after = "accept" },
            { text = "That sounds manageable. I'll get started.", after = "accept" }
        }
    },
    accept = {
        text = "Oh bless you, dear. Hogatha will sit right here and try not to fuss too much. She is very good at fussing so no promises. Just be gentle with the flowers that are still standing. They have been through enough.",
        choices = {
            { text = "I'll be careful. Leave it to me.", action = "AcceptQuest" },
            { text = "Not right now, I'm afraid.", exit = true }
        }
    }
}
t_36.nodes = t_37
t.Hogatha = t_36
local t_43 = { start = "greeting", nodes = nil }
local t_44 = {
    greeting = {
        text = "I've tended to this shrine whenever my travels bring me this way. There was always a certain warmth to it. Now, that warmth is barely there.",
        choices = { { text = "Can you tell what's wrong?", after = "accept" } }
    },
    accept = {
        text = "Spirits have long gathered around this place. I fear something has driven them away. If they're still nearby, perhaps they can be coaxed back.",
        choices = { { text = "I'll take a look.", action = "AcceptQuest" } }
    }
}
t_43.nodes = t_44
t["Traveling Priest"] = t_43
local t_47 = { start = "greeting", nodes = nil }
local t_48 = {
    greeting = {
        text = "Ah, good. Someone who looks like they can follow instructions. I don't suppose you have any background in applied alchemy? No matter. I have a proposition.",
        choices = {
            { text = "I'm listening.", after = "explain" },
            { text = "What kind of proposition?", after = "explain" }
        }
    },
    explain = {
        text = "My colleague and I are both close to something historic. A health potion. A true one. Nothing like it exists in this world yet and whoever formulates it correctly will change medicine, warfare, everything. We simply cannot agree on whose formula is correct.",
        choices = {
            { text = "So you need someone to test both.", after = "neutral" },
            { text = "Why not test them yourselves?", after = "why" }
        }
    },
    why = {
        text = "My colleague would sabotage the results. Not intentionally, perhaps, but bias has a way of corrupting methodology. We need a neutral party with no stake in the outcome.",
        choices = { { text = "And that's where I come in.", after = "neutral" } }
    },
    neutral = {
        text = "Precisely. I'll give you both schematics. Craft both, test both, and report back exactly what happens.",
        choices = {
            { text = "What should I expect when I test them?", after = "expect" },
            { text = "And if one of them works?", after = "works" }
        }
    },
    expect = {
        text = "If my formula is correct, you should feel an immediate restorative effect. Wounds closing and the like. That is the intended outcome. My colleague's formula is... less refined. I make no predictions for that one.",
        choices = {
            { text = "What if neither works?", after = "neither" },
            { text = "Understood. I'll test both.", after = "accept" }
        }
    },
    works = {
        text = "Then whoever's formula succeeded will have made history. The first health potion ever recorded. A rather significant achievement, I think you'll agree.",
        choices = {
            { text = "What if neither works?", after = "neither" },
            { text = "I'll get to work on both.", after = "accept" }
        }
    },
    neither = {
        text = "Then we both have more work to do and I will be deeply unsatisfied. But I would still want to know. An honest result is more useful than a comfortable lie.",
        choices = { { text = "Fair enough. I'll report exactly what happens.", after = "accept" } }
    },
    accept = {
        text = "Here are the schematics you will need. Gather everything, craft both, test both, and come back with a clear account.",
        choices = {
            { text = "I'll get it done.", action = "AcceptQuest" },
            { text = "Not right now.", exit = true }
        }
    }
}
t_47.nodes = t_48
t["Apprentice Roland"] = t_47
local t_57 = { start = "greeting", nodes = nil }
local t_58 = {
    greeting = {
        text = "Ohh... hello, treader. I was torn up rather badly, in the last wave of beasties. The wound wants a healing draught, but the merchant carts, they do not come anymore. Not since the beasties turned so fierce.",
        choices = {
            { text = "I can make you something for it.", after = "quest" },
            { text = "What happened to you?", after = "happened" }
        }
    },
    happened = {
        text = "A great clawed thing broke through the fence-line. I tried to run, root-swift as I am, but I caught upon my own tangled feet, and then... and then this happened to me. A wound left untended turns sour, my grove-mother always warned. It goes green and it forgets how to heal.",
        choices = { { text = "I'll make you something for it.", after = "quest" } }
    },
    quest = {
        text = "Truly? Oh, you would do this? Thank you, thank you, a hundred thanks upon you. My grove-mother's remedy is simple: three [b]Red Mushrooms[/b] in a cauldron makes a [b]Minor Potion of Vitality[/b]. Take these, I gathered them before the beasties came. There is enough for two brews, should the first one spoil. The nearest cauldron is in [b]Dewfall Refuge[/b], and red mushrooms grow all around it.",
        choices = {
            { text = "One potion of vitality, got it.", action = "AcceptQuest" },
            { text = "Uh... Nevermind.", exit = true }
        }
    }
}
t_57.nodes = t_58
t.Dabbin = t_57
local t_62 = { start = "greeting", nodes = nil }
local t_63 = {
    greeting = {
        text = "Well, look at that. Another adventurer who thinks they're tough. Think you can keep up with me?",
        choices = { { text = "Keep up with what?", after = "money" } }
    },
    money = {
        text = "These marks? Missions, plain and simple. I've made more here in a few weeks than most people make in a year. But you? You look like you'd cry if a Mushknight looked at you funny.",
        choices = {
            { text = "I'm tougher than I look.", after = "challenge" },
            { text = "Lucky you.", exit = true }
        }
    },
    challenge = {
        text = "Go out into the forest and take down 5 Mushknights. I did it before breakfast. Unless you're too scared, of course.",
        choices = {
            { text = "Five Mushknights? Easy.", action = "AcceptQuest" },
            { text = "Why should I?", after = "taunt" }
        }
    },
    taunt = {
        text = "Because I said you can't. Prove me wrong. Or walk away and let everyone know you ran from a challenge. Your choice.",
        choices = {
            { text = "Fine. I'll show you.", action = "AcceptQuest" },
            { text = "Not worth my time.", exit = true }
        }
    }
}
t_62.nodes = t_63
t.Hodan = t_62
local t_68 = { start = "greeting", nodes = nil }
local t_69 = {
    greeting = {
        text = "Oh! A tall one! Cupcake has a mush-big favor to ask. Will the adventurer help?",
        choices = { { text = "What do you need?", after = "favor" }, { text = "Sorry, I'm busy." } }
    },
    favor = {
        text = "Cupcake's friend Ploppy said Cupcake could read her book. But Cupcake's legs are very short, and the walk is very long! Can the adventurer go to Nutmeg's house and bring the book back?",
        choices = {
            { text = "I'll get the book.", action = "AcceptQuest" },
            { text = "Maybe later." }
        }
    }
}
t_68.nodes = t_69
t.Cupcake = t_68
local t_72 = { start = "greeting", nodes = nil }
local t_73 = {
    greeting = {
        text = "Oh dear, oh dear! Coffee is in a mush-big pickle. Coffee lost his three lanterns!",
        choices = {
            { text = "What happened?", after = "lost" },
            { text = "Where could they be?", after = "where" },
            { text = "Sorry, I'm busy." }
        }
    },
    lost = {
        text = "A big gust of wind came through, and whoosh! Coffee's lanterns flew away. Coffee's old legs are too slow to chase them. Will the adventurer help?",
        choices = {
            { text = "I'll help find them.", action = "AcceptQuest" },
            { text = "Where could they be?", after = "where" },
            { text = "Maybe later." }
        }
    },
    where = {
        text = "Coffee believes the lanterns landed in three places. One is inside the village. One is by the Lady Uxie lake. And one is by the fungite cave. Coffee is mush-sure of it! Mostly.",
        choices = {
            { text = "I'll find all three.", action = "AcceptQuest" },
            { text = "Maybe later." }
        }
    }
}
t_72.nodes = t_73
t.Coffee = t_72
local t_77 = { start = "greeting", nodes = nil }
local t_78 = {
    greeting = {
        text = "Oh! A tall one! Sprout has a mush-big garden, and it is full of mana wheat! But Sprout's arms are too short to harvest it all.",
        choices = {
            { text = "What do you need?", after = "favor" },
            { text = "Tell me about the garden.", after = "garden" },
            { text = "Sorry, I'm busy." }
        }
    },
    garden = {
        text = "Sprout grows mana wheat every day! It sparkles in the sun and smells mush-sweet. But if it is not picked soon, it will go to waste. Sprout would be so sad.",
        choices = { { text = "I can help.", after = "favor" }, { text = "Maybe later." } }
    },
    favor = {
        text = "Will the adventurer harvest Sprout's garden? Sprout needs 10 mana wheat. Pick them gently, please. The wheat is shy.",
        choices = {
            { text = "I'll harvest 10 mana wheat.", action = "AcceptQuest" },
            { text = "Maybe later." }
        }
    }
}
t_77.nodes = t_78
t.Sprout = t_77

return t
