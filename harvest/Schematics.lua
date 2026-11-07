-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Items.Schematics
-- Class: ModuleScript
-- bytes: 1657

local t = {}

for key, _ in (require(script.Parent.Outfits)) do
    local v1 = key .. " Schematic"

    if not script:FindFirstChild(v1) then
        local v2 = script.Template:Clone()
        v2.Name = v1
        v2:SetAttribute("BlueprintItem", key)
        v2.Parent = script
    end
end

local function init() -- line: 14
    -- upvalues:
    --  [1] t (copy)

    for _, child in script:GetChildren() do
        local v3 = child:GetAttributes()
        local Craftsettings = child:FindFirstChild("_craftsettings")

        if Craftsettings then
            v3._craftsettings = {}
            local Materials = Craftsettings:FindFirstChild("Materials")

            if Materials then
                v3._craftsettings.Materials = {}

                for _, child_1 in Materials:GetChildren() do
                    if child_1:IsA("ValueBase") then
                        v3._craftsettings.Materials[child_1.Name] = child_1.Value
                    end
                end
            end

            for _, child_2 in Craftsettings:GetChildren() do
                if child_2:IsA("ValueBase") then
                    v3._craftsettings[child_2.Name] = child_2.Value
                end
            end
        end

        local v4 = child.Parent:FindFirstChild("_required") or child:FindFirstChild("_required")

        if v4 then
            local t_1 = {}

            for _, child_3 in v4:GetChildren() do
                if child_3:IsA("ValueBase") then
                    t_1[child_3.Name] = child_3.Value
                end
            end

            v3.Required = t_1
        end

        t[child.Name] = v3
    end
end

init()

return t
