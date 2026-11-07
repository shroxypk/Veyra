-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager
-- Class: ModuleScript
-- bytes: 9789

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local _ = game:GetService("UserInputService")
local CheckQuestCompletion_m = require(ReplicatedStorage.Modules.CheckQuestCompletion)
local LocalPlayer = Players.LocalPlayer
local v1 = nil
local t = {}
local Quests = LocalPlayer:WaitForChild("Quests")
local t_1 = {
    "Here. A gesture of my thanks.",
    "You truly came through for me this time! Here. Take this."
}
local t_2 = {
    "Could you get away from here. I can't be caught speaking to someone with a reputation such as yours.",
    "I shouldn't be speaking to someone with a reputation like yours.",
    "... That reputation of yours won't get you what you're looking for from me."
}
local t_3 = {
    "Make sure to come back to me when you've completed that task I told you about.",
    "I'll be here awaiting your return!"
}
local Actions = script.Actions
t.__index = t

local _ = function(arg1) --[[ resolveValue ]] -- line: 40
    -- upvalues:
    --  [1] LocalPlayer (copy)

    if type(arg1) == "function" then
        return arg1(LocalPlayer)
    end

    return arg1
end

local _ = function(arg2) --[[ checkCondition ]] -- line: 47
    -- upvalues:
    --  [1] LocalPlayer (copy)

    if not arg2 then
        return true
    end

    if type(arg2) == "function" then
        return arg2(LocalPlayer)
    end

    return arg2
end

function t.SetChatBox(_, arg4) -- line: 59
    -- upvalues:
    --  [1] v1 (ref)

    v1 = arg4
end

function t.HideChatBox(_) -- line: 63
    -- upvalues:
    --  [1] v1 (ref)

    if v1 then
        v1.Visible = false
    end
end

function t.new(arg6, arg7, arg8) -- line: 69
    -- upvalues:
    --  [1] t (copy)
    --  [2] Quests (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] t_2 (copy)
    --  [5] t_1 (copy)
    --  [6] t_3 (copy)
    --  [7] CheckQuestCompletion_m (copy)
    --  [8] LocalPlayer (copy)

    local t_4 = setmetatable({}, t)
    t_4.data = arg7
    t_4.DisplayName = arg7.DisplayName or arg8
    t_4.Owner = arg6
    t_4.currentNodeId = nil
    t_4.ended = false
    t_4.visitedNodes = {}
    local v2 = Quests:FindFirstChild(arg8)
    local v3 = ReplicatedStorage.Remotes.QuestCooldown:InvokeServer(arg8)
    local Reputation = arg7.Reputation
    local t_5 = {
        text = function() --[[ text ]] -- line: 86
            -- upvalues:
            --  [1] t_2 (ref)

            return t_2[Random.new():NextInteger(1, #t_2)]
        end
    }
    local Override = arg7.__override
    t_4.data.nodes.__reputation = t_5

    if not Override then
        local Data = t_4.data.nodes
        local t_6 = { text = nil, action = "CompleteQuest" }

        function t_6.text() -- line: 93
            -- upvalues:
            --  [1] v2 (copy)
            --  [2] t_1 (ref)

            local CompletionText = v2:GetAttribute("CompletionText")

            if not CompletionText or CompletionText == "" then
                return t_1[Random.new():NextInteger(1, #t_1)]
            end

            return CompletionText
        end

        Data.__complete = t_6
        local Data_1 = t_4.data.nodes
        local t_7 = { text = nil }

        function t_7.text() -- line: 104
            -- upvalues:
            --  [1] v2 (copy)
            --  [2] t_3 (ref)

            local IncompleteText = v2:GetAttribute("IncompleteText")

            if not IncompleteText or IncompleteText == "" then
                return t_3[Random.new():NextInteger(1, #t_3)]
            end

            return IncompleteText
        end

        Data_1.__incomplete = t_7
        local Data_2 = t_4.data.nodes
        local t_8 = { text = nil }

        function t_8.text() -- line: 114
            -- upvalues:
            --  [1] v3 (copy)

            if v3 then
                if v3 == "OneTime" then
                    return "I appreciate your help."
                end

                return `I don't need help right now! Talk to you some other time. [Color=#ff0000]You can do this quest in {v3} [/Color]`
            else
                return
            end
        end

        Data_2.__cooldown = t_8

        if v3 then
            t_4:EnterNode("__cooldown")

            return t_4
        end

        if v2 then
            local v10 = nil

            local _ = function() --[[ main ]] -- line: 134
                -- upvalues:
                --  [1] CheckQuestCompletion_m (ref)
                --  [2] LocalPlayer (ref)
                --  [3] arg8 (copy)
                --  [4] v10 (ref)

                if CheckQuestCompletion_m(LocalPlayer, arg8) == "TasksCompleted" then
                    v10 = "Complete"

                    return
                end

                v10 = "Incomplete"
            end

            v10 = if CheckQuestCompletion_m(LocalPlayer, arg8) == "TasksCompleted" then "Complete" else "Incomplete"

            if v10 == "Complete" then
                t_4:EnterNode("__complete")
            else
                t_4:EnterNode("__incomplete")
            end

            return t_4
        end
    end

    if Reputation then
        if typeof(Reputation) == "table" then
            local Faction = Reputation.Faction
            local v11 = Reputation.Value or 0
            local v12 = LocalPlayer.Factions:FindFirstChild(Faction or "")

            if v12 and v11 > v12.Value then
                t_4:EnterNode("__reputation")

                return t_4
            end
        end
    end

    local v13 = t_4.data.start

    if type(v13) == "function" then
        v13 = v13(LocalPlayer, arg6)
    end

    t_4:EnterNode(v13)

    return t_4
end

function t.EnterNode(arg9, arg10) -- line: 178
    -- upvalues:
    --  [1] LocalPlayer (copy)

    if not arg10 then
        arg9.ended = true

        return
    end

    arg9.currentNodeId = arg10
    local v15 = arg9:GetCurrentNode()

    if not v15 then
        arg9.ended = true

        return
    end

    arg9.visitedNodes[arg10] = arg9.visitedNodes[arg10] or 0
    local VisitedNodes = arg9.visitedNodes
    VisitedNodes[arg10] += 1

    if v15.action then
        if type(v15.action) == "function" then
            v15.action(LocalPlayer)

            return
        end

        arg9:HandleAction(v15.action)
    end
end

function t.GetCurrentNode(arg11) -- line: 204
    if not arg11.currentNodeId then
        return
    end

    return arg11.data.nodes[arg11.currentNodeId]
end

function t.GetAvailableChoices(arg12) -- line: 212
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local t_9 = {}
    local v16 = arg12:GetCurrentNode()

    if v16 and v16.choices then
        for key, val in ipairs(v16.choices) do
            local Condition = val.condition

            if if not Condition then true else if type(Condition) == "function" then Condition(
                LocalPlayer
            ) else Condition then
                table.insert(t_9, { index = key, data = val })
            end
        end
    end

    if v16 and v16.after then
        local t_13 = { index = #t_9 + 1, data = nil }
        local t_11 = { text = "Continue", after = v16.after }
        t_13.data = t_11
        table.insert(t_9, t_13)

        return t_9
    end

    table.insert(t_9, { index = #t_9 + 1, data = { text = "End Dialogue", exit = true } })

    return t_9
end

function t.Choose(arg13, arg14) -- line: 244
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local v19 = arg13:GetCurrentNode()

    if not v19 then
        return
    end

    local v20 = arg13:GetAvailableChoices()
    local v21 = v20

    if v21 then
        v21 = v20[arg14]
    end

    if not v21 then
        return
    end

    local Data_3 = v21.data

    if Data_3.exit then
        arg13:End()

        return
    end

    if Data_3.chatEvent then
        arg13:FireChatEvent(Data_3.chatEvent)
    end

    if Data_3.action then
        if type(Data_3.action) == "function" then
            Data_3.action()
        else
            arg13:HandleAction(Data_3.action)
        end
    end

    local After = Data_3.after
    v21 = if type(After) == "function" then After(LocalPlayer) else After

    if v21 then
        arg13:EnterNode(v21)

        return
    end

    if not Data_3.chatEvent and v19.chatEvent then
        arg13:FireChatEvent(v19.chatEvent)
    end

    arg13:End()
end

function t.FireChatEvent(arg15, arg16) -- line: 291
    -- upvalues:
    --  [1] LocalPlayer (copy)

    if type(arg16) ~= "table" or not arg16.remote then
        return
    end

    local v22 = {}

    if type(arg16.args) == "function" then
        v22 = table.pack(arg16.args(LocalPlayer, arg15.Owner))
    elseif type(arg16.args) == "table" then
        v22 = arg16.args
    end

    local v23 = v22.n or #v22
    arg16.remote:FireServer(table.unpack(v22, 1, v23))
end

function t.FireNodeEvent(arg17, arg18) -- line: 308
    if arg18 then
        arg17:FireChatEvent(arg18.chatEvent)
    end
end

function t.HandleAction(t1: table, s1: string) -- line: 314
    -- upvalues:
    --  [1] Actions (copy)

    local v24 = Actions:FindFirstChild(s1, true)

    if v24 then
        require(v24)(t1)
    end
end

function t.Advance(arg19) -- line: 321
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local v25 = arg19:GetCurrentNode()

    if not v25 then
        return
    end

    if v25.after then
        local After_1 = v25.after
        arg19:EnterNode(if type(After_1) == "function" then After_1(LocalPlayer) else After_1)

        return
    end

    arg19:End()
end

function t.End(arg20) -- line: 333
    arg20.ended = true
    arg20.currentNodeId = nil
end

function t.IsFinished(arg21) -- line: 338
    return arg21.ended or arg21.currentNodeId == nil
end

return t
