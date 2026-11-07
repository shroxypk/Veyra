-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Items.Outfits
-- Class: ModuleScript
-- bytes: 2837

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

local _ = function(arg3) --[[ getShared ]] -- line: 38
    return arg3:FindFirstChild("_sharedstats"), arg3:FindFirstChild("_sharedinfo")
end

local function init() -- line: 42
    -- upvalues:
    --  [1] readCraftSettings (copy)
    --  [2] readRequired (copy)
    --  [3] t (copy)

    local v2

    for _, child_3 in script:GetChildren() do
        local Sharedstats_1 = child_3:FindFirstChild("_sharedstats")
        local Sharedinfo = child_3:FindFirstChild("_sharedinfo")
        local v1 = child_3:IsA("Configuration")

        if v1 then
            v1 = not (Sharedstats_1 or Sharedinfo)
        end

        v2 = child_3.Parent:FindFirstChild("_required") or child_3:FindFirstChild("_required")

        local function apply(arg4) -- line: 49
            -- upvalues:
            --  [1] Sharedinfo (copy)
            --  [2] Sharedstats_1 (copy)
            --  [3] readCraftSettings (ref)
            --  [4] v2 (copy)
            --  [5] readRequired (ref)
            --  [6] t (ref)

            if not arg4:IsA("Configuration") then
                return
            end

            local v3 = Sharedinfo and Sharedinfo:GetAttributes() or {}

            for key_4, val in arg4:GetAttributes() do
                v3[key_4] = val
            end

            local v4 = Sharedstats_1 or arg4:FindFirstChild("_stats")
            local v5 = arg4:FindFirstChild("_craftsettings") or Sharedinfo and Sharedinfo:FindFirstChild(
                "_craftsettings"
            )

            if v5 then
                v3._craftsettings = readCraftSettings(v5)
            end

            if v4 then
                v3._stats = v4:GetAttributes()
            end

            if v2 then
                v3.Required = readRequired(v2)
            end

            t[arg4.Name] = v3
        end

        if Sharedstats_1 or Sharedinfo then
            for _, descendant in child_3:GetDescendants() do
                apply(descendant)
            end
        elseif v1 then
            apply(child_3)
        end
    end
end

init()

return t
