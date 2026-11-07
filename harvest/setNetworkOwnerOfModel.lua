-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.setNetworkOwnerOfModel
-- Class: ModuleScript
-- bytes: 301

local function setNetworkOwnerOfModel(arg1, arg2) -- line: 1
    for _, descendant in pairs(arg1:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant:CanSetNetworkOwnership() then
            descendant:SetNetworkOwner(arg2)
        end
    end
end

return setNetworkOwnerOfModel
