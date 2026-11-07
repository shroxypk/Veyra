-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone.ZonePlusReference
-- Class: ModuleScript
-- bytes: 1029

local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
    addToReplicatedStorage = function() --[[ addToReplicatedStorage ]] -- line: 9
        -- upvalues:
        --  [1] ReplicatedStorage (copy)

        if ReplicatedStorage:FindFirstChild(script.Name) then
            return false
        end

        local ObjectValue = Instance.new("ObjectValue")
        ObjectValue.Name = script.Name
        ObjectValue.Value = script.Parent
        ObjectValue.Parent = ReplicatedStorage
        local BoolValue = Instance.new("BoolValue")
        BoolValue.Name = if game:GetService("RunService"):IsClient() then "Client" else "Server"
        BoolValue.Value = true
        BoolValue.Parent = ObjectValue

        return ObjectValue
    end,
    getObject = function() --[[ getObject ]] -- line: 25
        -- upvalues:
        --  [1] ReplicatedStorage (copy)

        local v2 = ReplicatedStorage:FindFirstChild(script.Name)

        if v2 then
            return v2
        end

        return false
    end
}
