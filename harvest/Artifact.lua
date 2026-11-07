-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Items.Artifact
-- Class: ModuleScript
-- bytes: 1433

local t = {}

local function readCraftSettings(arg1) -- line: 3
    local t_1 = {}
    local Materials = arg1:FindFirstChild("Materials")

    if Materials then
        t_1.Materials = {}

        for _, child in Materials:GetChildren() do
            if child:IsA("ValueBase") then
                t_1.Materials[child.Name] = child.Value
            end
        end
    end

    for _, child_1 in arg1:GetChildren() do
        if child_1:IsA("ValueBase") then
            t_1[child_1.Name] = child_1.Value
        end
    end

    return t_1
end

local function readRequired(arg2) -- line: 26
    local t_2 = {}

    for _, child_2 in arg2:GetChildren() do
        if child_2:IsA("ValueBase") then
            t_2[child_2.Name] = child_2.Value
        end
    end

    return t_2
end

local function init() -- line: 38
    -- upvalues:
    --  [1] readCraftSettings (copy)
    --  [2] readRequired (copy)
    --  [3] t (copy)

    for _, child_3 in script:GetChildren() do
        local v1 = child_3:GetAttributes()
        local Craftsettings = child_3:FindFirstChild("_craftsettings")

        if Craftsettings then
            v1._craftsettings = readCraftSettings(Craftsettings)
        end

        local v2 = child_3.Parent:FindFirstChild("_required") or child_3:FindFirstChild("_required")

        if v2 then
            v1.Required = readRequired(v2)
        end

        t[child_3.Name] = v1
    end
end

init()

return t
