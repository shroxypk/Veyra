-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS.InfoSell
-- Class: ModuleScript
-- bytes: 15216

local ReplicatedStorage = require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)
local t = { white = 250, green = 500, blue = 1000, purple = 2500, gold = 5000 }

local _ = function(arg1) --[[ canAfford ]] -- line: 16
    -- upvalues:
    --  [1] t (copy)
    --  [2] StatManager_m (copy)

    local v1 = t[arg1]

    return function(arg2) -- line: 18
        -- upvalues:
        --  [1] StatManager_m (ref)
        --  [2] v1 (copy)

        local v2 = StatManager_m.require(arg2)

        return (v2 and v2:GetStat("Marks") or 0) >= v1
    end
end

local _ = function(arg3) --[[ buyInfo ]] -- line: 25
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    local t_1 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }

    function t_1.args(_, arg5) -- line: 28
        -- upvalues:
        --  [1] arg3 (copy)

        return "BuyInfo", arg5, arg3
    end

    return t_1
end

local t_2 = {}
local t_3 = { start = "greeting", nodes = nil }
local t_4 = {
    greeting = {
        text = "Hm? Nobody finds this tavern by accident. Sit. You don't find me, I find you. The name is not important. The hood stays on. I sell knowledge. It is the only thing that never loses its value.",
        choices = {
            { text = "What kind of knowledge do you sell?", after = "tiers" },
            { text = "Who do you work for?", after = "whoareyou" },
            { text = "Maybe another time.", after = "farewell" }
        }
    },
    tiers = {
        text = "Everything I know comes in colors. White is cheap. Green costs more. Blue, more still. Purple is the kind of thing people get killed over. And Gold? Gold secrets make people disappear. So. What color are you buying?",
        choices = {
            { text = "White, 50 marks.", after = "white" },
            { text = "Green, 150 marks.", after = "green" },
            { text = "Blue, 400 marks.", after = "blue" },
            { text = "Purple, 1000 marks.", after = "purple" },
            { text = "Gold, 2500 marks.", after = "gold" },
            { text = "Nothing today.", after = "farewell" }
        }
    },
    whoareyou = {
        text = "That is not for sale. Not at any color. Ask me again and the price of everything else goes up.",
        choices = {
            { text = "Fair enough. Show me what is for sale.", after = "tiers" },
            { text = "Forget it.", after = "farewell" }
        }
    },
    white = nil,
    white1 = nil,
    white2 = nil,
    green = nil,
    green1 = nil,
    green2 = nil,
    green3 = nil,
    blue = nil,
    blue1 = nil,
    blue2 = nil,
    blue3 = nil,
    blue4 = nil,
    purple = nil,
    purple1 = nil,
    purple2 = nil,
    purple3 = nil,
    gold = nil,
    goldFarewell = nil
}
local t_8 = { text = "White it is. Pick one.", choices = nil }
local t_9 = {
    text = "Who is Pecieval's ex-disciple?",
    after = "white1",
    condition = nil,
    chatEvent = nil
}
local White = t.white

function t_9.condition(arg6) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] White (copy)

    local v5 = StatManager_m.require(arg6)

    return (v5 and v5:GetStat("Marks") or 0) >= White
end

local t_10 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v8 = "white"

function t_10.args(_, arg8) -- line: 28
    -- upvalues:
    --  [1] v8 (copy)

    return "BuyInfo", arg8, v8
end

t_9.chatEvent = t_10
local t_12 = {
    text = "What is Grey Fox's past?",
    after = "white2",
    condition = nil,
    chatEvent = nil
}
local White_1 = t.white

function t_12.condition(arg9) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] White_1 (copy)

    local v9 = StatManager_m.require(arg9)

    return (v9 and v9:GetStat("Marks") or 0) >= White_1
end

local t_13 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v12 = "white"

function t_13.args(_, arg11) -- line: 28
    -- upvalues:
    --  [1] v12 (copy)

    return "BuyInfo", arg11, v12
end

t_12.chatEvent = t_13
t_8.choices = { t_9, t_12, { text = "Back.", after = "tiers" } }
t_4.white = t_8
t_4.white1 = {
    text = "Pecieval's ex-disciple has been spotted in Mushroom Village. His name is Aldric. Nobody knows why they came back to this realm. But they left Pecieval for a reason.",
    choices = {
        { text = "Another one.", after = "white" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.white2 = {
    text = "Before Grey Fox founded the Den of Thieves, he was a stable boy. The most wanted thief in the realm started by cleaning up after horses.",
    choices = {
        { text = "Another one.", after = "white" },
        { text = "That is all I need.", after = "farewell" }
    }
}
local t_16 = { text = "Green it is. Pick one.", choices = nil }
local t_17 = {
    text = "What is the Assembly Tower's secret?",
    after = "green1",
    condition = nil,
    chatEvent = nil
}
local Green = t.green

function t_17.condition(arg12) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Green (copy)

    local v13 = StatManager_m.require(arg12)

    return (v13 and v13:GetStat("Marks") or 0) >= Green
end

local t_18 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v16 = "green"

function t_18.args(_, arg14) -- line: 28
    -- upvalues:
    --  [1] v16 (copy)

    return "BuyInfo", arg14, v16
end

t_17.chatEvent = t_18
local t_20 = {
    text = "What magic does Holda the Witch use?",
    after = "green2",
    condition = nil,
    chatEvent = nil
}
local Green_1 = t.green

function t_20.condition(arg15) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Green_1 (copy)

    local v17 = StatManager_m.require(arg15)

    return (v17 and v17:GetStat("Marks") or 0) >= Green_1
end

local t_21 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v20 = "green"

function t_21.args(_, arg17) -- line: 28
    -- upvalues:
    --  [1] v20 (copy)

    return "BuyInfo", arg17, v20
end

t_20.chatEvent = t_21
local t_22 = { text = "What is Holda's past?", after = "green3", condition = nil, chatEvent = nil }
local Green_2 = t.green

function t_22.condition(arg18) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Green_2 (copy)

    local v21 = StatManager_m.require(arg18)

    return (v21 and v21:GetStat("Marks") or 0) >= Green_2
end

local t_23 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v24 = "green"

function t_23.args(_, arg20) -- line: 28
    -- upvalues:
    --  [1] v24 (copy)

    return "BuyInfo", arg20, v24
end

t_22.chatEvent = t_23
t_16.choices = { t_17, t_20, t_22, { text = "Back.", after = "tiers" } }
t_4.green = t_16
t_4.green1 = {
    text = "There is a secret code hidden in the paintings that lets you access a secret basement within the Assembly Tower. I could tell you the code. But then it would not be worth as much to you, would it?",
    choices = {
        { text = "Another one.", after = "green" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.green2 = {
    text = "Holda the Witch is a fire grimoire user.",
    choices = {
        { text = "Another one.", after = "green" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.green3 = {
    text = "Holda the Witch used to be a researcher for the Assembly. She stole forbidden texts from the Citadel library before she left.",
    choices = {
        { text = "Another one.", after = "green" },
        { text = "That is all I need.", after = "farewell" }
    }
}
local t_27 = {
    text = "Blue tier. This is the kind of knowledge that gets people followed home. Pick carefully.",
    choices = nil
}
local t_28 = {
    text = "Where is Grey Fox's treasure?",
    after = "blue1",
    condition = nil,
    chatEvent = nil
}
local Blue = t.blue

function t_28.condition(arg21) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Blue (copy)

    local v25 = StatManager_m.require(arg21)

    return (v25 and v25:GetStat("Marks") or 0) >= Blue
end

local t_29 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v28 = "blue"

function t_29.args(_, arg23) -- line: 28
    -- upvalues:
    --  [1] v28 (copy)

    return "BuyInfo", arg23, v28
end

t_28.chatEvent = t_29
local t_31 = {
    text = "How do I summon the Lizard King?",
    after = "blue2",
    condition = nil,
    chatEvent = nil
}
local Blue_1 = t.blue

function t_31.condition(arg24) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Blue_1 (copy)

    local v29 = StatManager_m.require(arg24)

    return (v29 and v29:GetStat("Marks") or 0) >= Blue_1
end

local t_32 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v32 = "blue"

function t_32.args(_, arg26) -- line: 28
    -- upvalues:
    --  [1] v32 (copy)

    return "BuyInfo", arg26, v32
end

t_31.chatEvent = t_32
local t_33 = { text = "How do I summon Ba'al?", after = "blue3", condition = nil, chatEvent = nil }
local Blue_2 = t.blue

function t_33.condition(arg27) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Blue_2 (copy)

    local v33 = StatManager_m.require(arg27)

    return (v33 and v33:GetStat("Marks") or 0) >= Blue_2
end

local t_34 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v36 = "blue"

function t_34.args(_, arg29) -- line: 28
    -- upvalues:
    --  [1] v36 (copy)

    return "BuyInfo", arg29, v36
end

t_33.chatEvent = t_34
local t_35 = {
    text = "What is the swamp arena?",
    after = "blue4",
    condition = nil,
    chatEvent = nil
}
local Blue_3 = t.blue

function t_35.condition(arg30) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Blue_3 (copy)

    local v37 = StatManager_m.require(arg30)

    return (v37 and v37:GetStat("Marks") or 0) >= Blue_3
end

local t_36 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v40 = "blue"

function t_36.args(_, arg32) -- line: 28
    -- upvalues:
    --  [1] v40 (copy)

    return "BuyInfo", arg32, v40
end

t_35.chatEvent = t_36
t_27.choices = { t_28, t_31, t_33, t_35, { text = "Back.", after = "tiers" } }
t_4.blue = t_27
t_4.blue1 = {
    text = "Grey Fox's treasure is hidden somewhere within the Eldritch region. Even the Thieves Guild has not found it. Though, this is likely just a rumor.",
    choices = {
        { text = "Another one.", after = "blue" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.blue2 = {
    text = "You must possess a Horn of Calling to summon the one called the Lizard King. Without the horn, you are just shouting into a swamp.",
    choices = {
        { text = "Another one.", after = "blue" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.blue3 = {
    text = "You must possess a Cursed Bell to summon the one called Ba'al. The bell does not just summon him. It invites him. Know the difference before you ring it.",
    choices = {
        { text = "Another one.", after = "blue" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.blue4 = {
    text = "The Lizard King lives in an arena at the heart of the swamp. The lizard soldiers treat him as a sacred king. They guard him with their lives.",
    choices = {
        { text = "Another one.", after = "blue" },
        { text = "That is all I need.", after = "farewell" }
    }
}
local t_41 = {
    text = "Purple. You have coin and nerve, I will give you that. Everything past this line, somebody powerful wants buried. Choose.",
    choices = nil
}
local t_42 = { text = "Do archangels exist?", after = "purple1", condition = nil, chatEvent = nil }
local Purple = t.purple

function t_42.condition(arg33) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Purple (copy)

    local v41 = StatManager_m.require(arg33)

    return (v41 and v41:GetStat("Marks") or 0) >= Purple
end

local t_43 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v44 = "purple"

function t_43.args(_, arg35) -- line: 28
    -- upvalues:
    --  [1] v44 (copy)

    return "BuyInfo", arg35, v44
end

t_42.chatEvent = t_43
local t_45 = {
    text = "Are there any candidates for the Grand Magus seat for the Forgotten Realm?",
    after = "purple2",
    condition = nil,
    chatEvent = nil
}
local Purple_1 = t.purple

function t_45.condition(arg36) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Purple_1 (copy)

    local v45 = StatManager_m.require(arg36)

    return (v45 and v45:GetStat("Marks") or 0) >= Purple_1
end

local t_46 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v48 = "purple"

function t_46.args(_, arg38) -- line: 28
    -- upvalues:
    --  [1] v48 (copy)

    return "BuyInfo", arg38, v48
end

t_45.chatEvent = t_46
local t_47 = {
    text = "What is Dagon's grimoire.",
    after = "purple3",
    condition = nil,
    chatEvent = nil
}
local Purple_2 = t.purple

function t_47.condition(arg39) -- line: 18
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Purple_2 (copy)

    local v49 = StatManager_m.require(arg39)

    return (v49 and v49:GetStat("Marks") or 0) >= Purple_2
end

local t_48 = { remote = ReplicatedStorage.Remotes.NPC, args = nil }
local v52 = "purple"

function t_48.args(_, arg41) -- line: 28
    -- upvalues:
    --  [1] v52 (copy)

    return "BuyInfo", arg41, v52
end

t_47.chatEvent = t_48
t_41.choices = { t_42, t_45, t_47, { text = "Back.", after = "tiers" } }
t_4.purple = t_41
t_4.purple1 = {
    text = "There exists a race of people called archangels. Coming across one is extremely rare. They are said to be heaven's chosen. They are very beautiful people. Beautiful enough that most who meet one never stop looking for another.",
    choices = {
        { text = "Another one.", after = "purple" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.purple2 = {
    text = "There are a few but Dagon the 'Gravity Baron' is current the frontrunner for the Grand Magus seat for the Forgotten Realm.",
    choices = {
        { text = "Another one.", after = "purple" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.purple3 = {
    text = "Dagon is a Gravity grimoire user. Keep that in mind if you ever stand across from him. There is no dodging what pulls you down.",
    choices = {
        { text = "Another one.", after = "purple" },
        { text = "That is all I need.", after = "farewell" }
    }
}
t_4.gold = {
    text = "Ha! Hahahaha! Gold tier? You? Oh, that is wonderful. Look at you, barely any dust on your boots and you want the secrets people vanish over. You are too weak for this sort of information. It would crush you before you finished hearing it. Go on, shoo.",
    choices = {
        { text = "Could I try a different tier, then?", after = "tiers" },
        { text = "Surely my marks is good enough?", after = "goldFarewell" }
    }
}
t_4.goldFarewell = {
    text = "Run along now, little one. Try not to get lost on the way out.",
    choices = { { text = "Whatever.", exit = true } }
}
t_3.nodes = t_4
t_2["Hooded Man"] = t_3

return t_2
