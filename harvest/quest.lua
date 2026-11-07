-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Items.Quest
-- Class: ModuleScript
-- bytes: 606

local t = {}

local function init() -- line: 3
    -- upvalues:
    --  [1] t (copy)

    for _, child in script:GetChildren() do
        local v1 = child:GetAttributes()
        local v2 = child.Parent:FindFirstChild("_required") or child:FindFirstChild("_required")

        if v2 then
            local t_1 = {}

            for _, child_1 in v2:GetChildren() do
                if child_1:IsA("ValueBase") then
                    t_1[child_1.Name] = child_1.Value
                end
            end

            v1.Required = t_1
        end

        t[child.Name] = v1
    end
end

init()

return t
