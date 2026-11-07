-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ClientNPCS
-- Class: ModuleScript
-- bytes: 1049

local _ = game:GetService("ReplicatedStorage")
local _ = Color3.fromRGB(193, 162, 255)
local t = {}
t.__index = t
t.NPCS = {}

local function init() -- line: 10
    -- upvalues:
    --  [1] t (copy)

    for _, child in script:GetChildren() do
        if child:IsA("ModuleScript") then
            for key_1, val in pairs((require(child))) do
                t.NPCS[key_1] = val
            end
        end
    end
end

init()

function t.GetQuest(_, arg2) -- line: 23
    local v2 = script.Quests:FindFirstChild(arg2, true)

    if v2 then
        return v2
    end
end

function t.GetNPCFromQuest(_, arg4) -- line: 30
    for _, val_1 in script.Quests:QueryDescendants("Folder") do
        if val_1:GetAttribute("Quest") == arg4 then
            return val_1.Parent.Name
        end
    end
end

function t.GetLegacyCount(_, arg6) -- line: 38
    local v3 = 0

    for _, val_2 in script.Quests:QueryDescendants("Folder") do
        if val_2:GetAttribute("Legacy") == arg6 then
            v3 += 1
        end
    end

    return v3
end

return t
