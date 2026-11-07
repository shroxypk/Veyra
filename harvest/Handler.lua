-- Decompiled with Veyra harvester
-- Instance: Workspace.ChatObjects.GrimoireEvo.Statues.4.Handler
-- Class: ModuleScript
-- bytes: 2487

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Formatter_m = require(ReplicatedStorage.Modules.Formatter)
local Parent = script.Parent
local v2 = nil
local t = {}

function t.setPrompt(_, arg2) -- line: 21
    -- upvalues:
    --  [1] v2 (ref)

    if not v2 then
        v2 = arg2
    end
end

local Quests = Players.LocalPlayer:WaitForChild("Quests")
local Name = Parent.Name

function t.progress(_) -- line: 27
    -- upvalues:
    --  [1] Quests (copy)

    local EvoQuest2 = Quests:FindFirstChild("EvoQuest2")

    if not EvoQuest2 then
        return
    end

    local ArcaneMastery = EvoQuest2:WaitForChild("Tasks"):WaitForChild("Arcane mastery")
    local TaskProgress = ArcaneMastery:GetAttribute("TaskProgress")
    local TaskMax = ArcaneMastery:GetAttribute("TaskMax")

    return TaskProgress, TaskMax, TaskProgress >= TaskMax and true
end

function t.complete(_, _) -- line: 40
    -- upvalues:
    --  [1] t (copy)
    --  [2] v2 (ref)
    --  [3] Parent (copy)

    local v4, v5 = t:progress()

    if not v4 then
        return
    end

    if v4 >= v5 then
        if v2 then
            v2:SetAttribute("ServerDisabled", true)
            v2.Enabled = false
        end

        Parent:SetAttribute("Activated", true)

        return true
    end
end

function t.init(arg6) -- line: 58
    -- upvalues:
    --  [1] t (copy)

    t:setPrompt(arg6)
    t:complete(true)
end

function t.main() -- line: 63
    -- upvalues:
    --  [1] t (copy)
    --  [2] Formatter_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Name (copy)
    --  [5] v2 (ref)

    local v6, v7 = t:progress()

    if not v6 then
        return
    end

    local v10

    if v6 < v7 then
        local v8 = math.floor(v6)
        local v9 = Formatter_m.addCommas(v7)
        v10 = `[i]The statue is dormant... It craves destruction, the kind only magic can bring.[/i][br][b]Magic damage dealt: {v8}/{v9}[/b]`
    else
        v10 = "[i]The statue blazes. Your mastery of magic has proven itself.[/i]"
    end

    local t_1 = { DisplayName = "Statue of Sorcery", start = "initial", nodes = nil }
    local t_2 = { initial = { text = v10 } }
    t_1.nodes = t_2
    v10 = t:complete()
    ReplicatedStorage.Remotes.GrimoireEvolutionRemote:FireServer("Collect", Name)
    _G.ForceChat(t_1, v2)

    return v10
end

return t
