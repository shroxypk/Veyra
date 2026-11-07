-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Items.Chests
-- Class: ModuleScript
-- bytes: 1378

local t = {}

local function init() -- line: 3
    -- upvalues:
    --  [1] t (copy)

    for _, child in script:GetChildren() do
        local v1 = child:GetAttributes()
        local Craftsettings = child:FindFirstChild("_craftsettings")

        if Craftsettings then
            v1._craftsettings = {}
            local Materials = Craftsettings:FindFirstChild("Materials")

            if Materials then
                v1._craftsettings.Materials = {}

                for _, child_1 in Materials:GetChildren() do
                    if child_1:IsA("ValueBase") then
                        v1._craftsettings.Materials[child_1.Name] = child_1.Value
                    end
                end
            end

            for _, child_2 in Craftsettings:GetChildren() do
                if child_2:IsA("ValueBase") then
                    v1._craftsettings[child_2.Name] = child_2.Value
                end
            end
        end

        local v2 = child.Parent:FindFirstChild("_required") or child:FindFirstChild("_required")

        if v2 then
            local t_1 = {}

            for _, child_3 in v2:GetChildren() do
                if child_3:IsA("ValueBase") then
                    t_1[child_3.Name] = child_3.Value
                end
            end

            v1.Required = t_1
        end

        t[child.Name] = v1
    end
end

init()

return t
