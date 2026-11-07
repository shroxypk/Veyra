-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Items.Armor
-- Class: ModuleScript
-- bytes: 3279

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

local function readConfigs(arg3) -- line: 39
    local t_3 = {}

    for _, child_3 in arg3:GetChildren() do
        t_3[child_3.Name] = {
            CF = child_3:GetAttribute("CF"),
            WeldOn = child_3:GetAttribute("WeldOn")
        }
    end

    return t_3
end

local _ = function(arg4, arg5) --[[ readInfo ]] -- line: 53
    local v1 = arg5 and arg5:GetAttributes() or {}

    for key_4, val in arg4:GetAttributes() do
        v1[key_4] = val
    end

    return v1
end

local function init() -- line: 63
    -- upvalues:
    --  [1] readCraftSettings (copy)
    --  [2] readConfigs (copy)
    --  [3] readRequired (copy)
    --  [4] t (copy)

    for _, child_4 in script:GetChildren() do
        for _, descendant in child_4:GetDescendants() do
            local Sharedconfigs = descendant.Parent:FindFirstChild("_sharedconfigs")
            local Sharedattributes = descendant.Parent:FindFirstChild("_sharedattributes")
            local Sharedinfo = descendant.Parent:FindFirstChild("_sharedinfo")
            local v2 = if descendant.Parent == child_4 then descendant:FindFirstChild("_attributes") else false
            local v3 = descendant.Parent:FindFirstChild("_required") or descendant:FindFirstChild(
                "_required"
            )

            if v2 or Sharedconfigs and Sharedattributes then
                local v4 = Sharedconfigs or descendant._configs
                local v5 = Sharedattributes or descendant._attributes
                local v6 = Sharedinfo and Sharedinfo:GetAttributes() or {}

                for key_7, val_1 in descendant:GetAttributes() do
                    v6[key_7] = val_1
                end

                local v7 = descendant:FindFirstChild("_craftsettings") or Sharedinfo and Sharedinfo:FindFirstChild(
                    "_craftsettings"
                )

                if v7 then
                    v6._craftsettings = readCraftSettings(v7)
                end

                if v5 then
                    v6._attributes = {}

                    for _, child_5 in v5:GetChildren() do
                        v6._attributes[child_5.Name] = child_5:GetAttributes()
                    end
                end

                if v4 then
                    v6._configs = readConfigs(v4)
                end

                if v3 then
                    v6.Required = readRequired(v3)
                end

                t[descendant.Name] = v6
            end
        end
    end
end

init()

return t
