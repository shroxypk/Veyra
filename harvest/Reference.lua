-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Reference
-- Class: ModuleScript
-- bytes: 771

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = { objectName = "TopbarPlusReference" }

function t.addToReplicatedStorage() -- line: 10
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] t (copy)

    if ReplicatedStorage:FindFirstChild(t.objectName) then
        return false
    end

    local ObjectValue = Instance.new("ObjectValue")
    ObjectValue.Name = t.objectName
    ObjectValue.Value = script.Parent
    ObjectValue.Parent = ReplicatedStorage

    return ObjectValue
end

function t.getObject() -- line: 22
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] t (copy)

    local v1 = ReplicatedStorage:FindFirstChild(t.objectName)

    if v1 then
        return v1
    end

    return false
end

return t
