-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.GetDamageTags
-- Class: ModuleScript
-- bytes: 1483

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local t = {
    SearchInstance = function(_: table, u1: userdata, n1: number?) --[[ SearchInstance ]] -- line: 10
        -- upvalues:
        --  [1] Players (copy)

        local v2 = n1 or 0
        local t_1 = {}

        for _, child in u1:GetChildren() do
            local DMGTotal = child:GetAttribute("DMGTotal")

            if child:IsA("Configuration") and DMGTotal then
                local v3 = if Players:FindFirstChild(child.Name) == nil then false else true

                if v2 <= DMGTotal then
                    t_1[child] = v3
                end
            end
        end

        return t_1
    end
}
local t_2 = { workspace.FightableNPCS, workspace.pCharacters }

function t.SearchTags(_: table, s1: string, n2: number?) -- line: 28
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] Players (copy)

    local v4 = n2 or 0
    local t_3 = {}

    for _, val in t_2 do
        for _, val_1 in val:QueryDescendants(`Configuration[$Owner = {s1}]`) do
            local DMGTotal_1 = val_1:GetAttribute("DMGTotal")

            if DMGTotal_1 then
                local v5 = if Players:FindFirstChild(val_1.Name) == nil then false else true

                if v4 <= DMGTotal_1 then
                    t_3[val_1] = v5
                end
            end
        end
    end

    return t_3
end

return t
