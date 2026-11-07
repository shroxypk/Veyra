-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Trials
-- Class: ModuleScript
-- bytes: 3624

local t = {}
t[1] = { Free = true, Requirements = {} }
local t_2 = {
    Requirements = {
        Insight = { Amount = 50, Type = "Insight" },
        Manaheart = { Amount = 2, Type = "Item" },
        Level = { Amount = 25, Type = "Level" }
    }
}
t[2] = t_2
local t_4 = {
    Requirements = {
        Insight = { Amount = 50, Type = "Insight" },
        Manaheart = { Amount = 2, Type = "Item" },
        Level = { Amount = 35, Type = "Level" }
    }
}
t[3] = t_4
local t_6 = {
    Requirements = {
        Insight = { Amount = 50, Type = "Insight" },
        Manaheart = { Amount = 2, Type = "Item" },
        Level = { Amount = 45, Type = "Level" }
    }
}
t[4] = t_6
local t_8 = {
    Requirements = {
        Insight = { Amount = 50, Type = "Insight" },
        Manaheart = { Amount = 5, Type = "Item" },
        Level = { Amount = 55, Type = "Level" }
    }
}
t[5] = t_8
local t_10 = {
    Requirements = {
        Insight = { Amount = 50, Type = "Insight" },
        Manaheart = { Amount = 5, Type = "Item" },
        Level = { Amount = 65, Type = "Level" }
    }
}
t[6] = t_10
local t_12 = {
    Requirements = {
        Insight = { Amount = 50, Type = "Insight" },
        Manaheart = { Amount = 1, Type = "Item" },
        Level = { Amount = 75, Type = "Level" }
    }
}
t.Default = t_12
t.GrimoireQuest = {
    Index = "GrimoireQuest",
    SeekTask = "Seek out the whispers of mana",
    CeremonyTask = "Participate in the Magic Ceremony",
    ReturnTask = "Return to Merlin",
    UnlockTask = "Meditate in your Inner Realm to unlock an ability"
}

function t.IsTaskComplete(u1: userdata, s1: string, s2: string) -- line: 120
    local v1 = u1:FindFirstChild("Quests")
    local v2 = v1

    if v2 then
        v2 = v1:FindFirstChild(s1)
    end

    if not v2 then
        return false
    end

    if v2:GetAttribute("Completed") then
        return true
    end

    v1 = v2:FindFirstChild("Tasks")

    if v1 then
        v1 = v2.Tasks:FindFirstChild(s2)
    end

    if not v1 then
        return false
    end

    return (v1:GetAttribute("TaskProgress") or 0) >= (v1:GetAttribute("TaskMax") or 1) and true
end

function t.GetMessage(_, arg2) -- line: 136
    -- upvalues:
    --  [1] t (copy)

    return t[arg2]
end

function t.GetTrial(n1: number) -- line: 141
    -- upvalues:
    --  [1] t (copy)

    return t[n1] or t.Default
end

function t.CountGameplaySkills(u2: userdata, t1: table) -- line: 146
    local v6 = 0
    local v7 = 0

    if not t1 then
        return v6, v7
    end

    for key, val in t1 do
        if val.ReqType == "Gameplay" then
            v7 += 1

            if u2 and u2:FindFirstChild(key) then
                v6 += 1
            end
        end
    end

    return v6, v7
end

function t.MeetsRequirements(arg3: any, arg4: any, u3: userdata?) -- line: 167
    if not arg3 then
        return false
    end

    if arg3.Free then
        return true
    end

    local v8 = 0
    local v9 = 0

    for key_1, val_1 in arg3.Requirements do
        v9 += 1

        if val_1.Type == "Item" then
            local v10 = u3

            if v10 then
                v10 = u3:FindFirstChild(key_1)
            end

            local v11 = v10 and v10:GetAttribute("Stock") or 0

            if v11 >= val_1.Amount then
                v8 += 1
            end
        else
            v8 = if val_1.Type ~= "Insight" then if val_1.Type ~= "Level" then v8 else if not ((arg4.Level or 0) >= val_1.Amount) then v8 else v8 + 1 else if not ((arg4.Insight or 0) >= val_1.Amount) then v8 else v8 + 1
        end
    end

    return if v9 == 0 then false else v8 >= v9
end

return t
