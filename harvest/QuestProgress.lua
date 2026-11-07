-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.QuestProgress
-- Class: ModuleScript
-- bytes: 4135

local LocalPlayer = game:GetService("Players").LocalPlayer
local t = {
    getMax = function(u1: userdata) --[[ getMax ]] -- line: 16
        return u1:GetAttribute("TaskMax") or 1
    end
}
local Inventory = nil

local _ = function() --[[ getInventory ]] -- line: 9
    -- upvalues:
    --  [1] Inventory (ref)
    --  [2] LocalPlayer (copy)

    if not Inventory or not Inventory.Parent then
        Inventory = LocalPlayer:WaitForChild("Inventory")
    end

    return Inventory
end

function t.get(u2: userdata) -- line: 20
    -- upvalues:
    --  [1] Inventory (ref)
    --  [2] LocalPlayer (copy)

    if u2:GetAttribute("TaskType") == "Collect" then
        if not Inventory or not Inventory.Parent then
            Inventory = LocalPlayer:WaitForChild("Inventory")
        end

        local v3 = Inventory:FindFirstChild(u2:GetAttribute("Object"))

        return v3 and v3:GetAttribute("Stock") or 0
    end

    return u2:GetAttribute("TaskProgress") or 0
end

function t.isDone(u3: userdata) -- line: 28
    -- upvalues:
    --  [1] t (copy)

    return t.get(u3) >= t.getMax(u3) and true
end

function t.watch(u4: userdata, f1: (...any) -> ...any) -- line: 32
    -- upvalues:
    --  [1] Inventory (ref)
    --  [2] LocalPlayer (copy)

    local t_1 = {}
    local v7 = nil
    local v8 = 0

    local _ = function(arg1) --[[ emit ]] -- line: 37
        -- upvalues:
        --  [1] v8 (ref)
        --  [2] f1 (copy)

        v8 = arg1 or 0
        f1(v8)
    end

    local _ = function() --[[ dropStock ]] -- line: 42
        -- upvalues:
        --  [1] v7 (ref)

        if v7 then
            v7:Disconnect()
            v7 = nil
        end
    end

    if u4:GetAttribute("TaskType") == "Collect" then
        if not Inventory or not Inventory.Parent then
            Inventory = LocalPlayer:WaitForChild("Inventory")
        end

        local v9 = Inventory
        local Object = u4:GetAttribute("Object")

        local function bindItem() -- line: 53
            -- upvalues:
            --  [1] v7 (ref)
            --  [2] v9 (copy)
            --  [3] Object (copy)
            --  [4] v8 (ref)
            --  [5] f1 (copy)

            if v7 then
                v7:Disconnect()
                v7 = nil
            end

            local v10 = v9:FindFirstChild(Object)

            if not v10 then
                v8 = 0
                f1(v8)

                return
            end

            v7 = v10:GetAttributeChangedSignal("Stock"):Connect(function() -- line: 60
                -- upvalues:
                --  [1] v10 (copy)
                --  [2] v8 (ref)
                --  [3] f1 (ref)

                v8 = v10:GetAttribute("Stock") or 0
                f1(v8)
            end)
            v8 = v10:GetAttribute("Stock") or 0
            f1(v8)
        end

        local function onInventoryChanged(arg2) -- line: 66
            -- upvalues:
            --  [1] Object (copy)
            --  [2] bindItem (copy)

            if arg2.Name == Object then
                bindItem()
            end
        end

        table.insert(t_1, v9.ChildAdded:Connect(onInventoryChanged))
        table.insert(t_1, v9.ChildRemoved:Connect(onInventoryChanged))
        bindItem()
    else
        table.insert(t_1, u4:GetAttributeChangedSignal("TaskProgress"):Connect(function() -- line: 76
            -- upvalues:
            --  [1] u4 (copy)
            --  [2] v8 (ref)
            --  [3] f1 (copy)

            v8 = u4:GetAttribute("TaskProgress") or 0
            f1(v8)
        end))
        v8 = u4:GetAttribute("TaskProgress") or 0
        f1(v8)
    end

    local TaskMax = u4:GetAttributeChangedSignal("TaskMax")
    table.insert(t_1, TaskMax:Connect(function() -- line: 82
        -- upvalues:
        --  [1] f1 (copy)
        --  [2] v8 (ref)

        f1(v8)
    end))

    return function() -- line: 86
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] t_1 (copy)

        if v7 then
            v7:Disconnect()
            v7 = nil
        end

        for _, val in t_1 do
            val:Disconnect()
        end

        table.clear(t_1)
    end
end

return t
