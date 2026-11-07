-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.CheckQuestCompletion
-- Class: ModuleScript
-- bytes: 1222

local function checkQuestCompletion(arg1, arg2) -- line: 2
    if not arg2 then
        return
    end

    local Inventory = arg1.Inventory
    local v1 = arg1.Quests:FindFirstChild(arg2)

    if not v1 then
        return
    end

    local v2 = 0
    local v3 = 0
    local v6

    for _, child in v1.Tasks:GetChildren() do
        local TaskProgress = child:GetAttribute("TaskProgress")
        local TaskMax = child:GetAttribute("TaskMax")
        local TaskType = child:GetAttribute("TaskType")
        local Object = child:GetAttribute("Object")

        if TaskType == "Collect" then
            local v4 = Inventory:FindFirstChild(Object)
            local v5 = v4 and v4:GetAttribute("Stock") or 0
            v6 = v5
        else
            v6 = TaskProgress
        end

        if TaskMax <= v6 then
            v2 += 1
        end

        v3 += 1
    end

    local v7 = v2 > 0 and v2 >= v3

    if v7 and not v1:GetAttribute("Completed") then
        return "TasksCompleted"
    end

    if not v7 then
        if v1:GetAttribute("Completed") then
            return "FullyFinished"
        end

        return "Incomplete"
    else
        return "FullyFinished"
    end
end

return checkQuestCompletion
