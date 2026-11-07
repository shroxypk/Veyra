-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Permissions
-- Class: ModuleScript
-- bytes: 3730

local Players = game:GetService("Players")
local t = { 52866742, 36558434, 23595482, 149489769 }
local t_1 = { [8109972250] = true, [116279325] = true, [537069675] = true }

local _ = function(arg1) --[[ getUserId ]] -- line: 15
    if typeof(arg1) == "Instance" then
        return arg1.UserId
    end

    return arg1
end

local _ = function(arg2) --[[ getPlayer ]] -- line: 22
    -- upvalues:
    --  [1] Players (copy)

    if typeof(arg2) == "Instance" then
        return arg2
    end

    return Players:GetPlayerByUserId(arg2)
end

local t_2 = {
    TesterAccess = function(_, arg4) --[[ TesterAccess ]] -- line: 31
        local v1 = nil
        pcall(function() -- line: 33
            -- upvalues:
            --  [1] v1 (ref)
            --  [2] arg4 (copy)

            v1 = arg4:GetRankInGroup(7523287)
        end)

        return if v1 ~= nil then v1 >= 4 else false
    end,
    IsContentCreator = function(_, arg6) --[[ IsContentCreator ]] -- line: 40
        -- upvalues:
        --  [1] Players (copy)

        local v3 = if typeof(arg6) == "Instance" then arg6 else Players:GetPlayerByUserId(arg6)

        if not v3 then
            return false
        end

        local Success, Result = pcall(v3.GetRoleInGroup, v3, 7523287)
        local v4 = Success

        if v4 then
            v4 = Result == "Content Creator"
        end

        return v4
    end
}
local t_3 = { [30] = true, [241] = true, [254] = true, [255] = true }

local function getGroupRank(arg7) -- line: 53
    local v5 = nil

    if typeof(arg7) == "Instance" then
        pcall(function() -- line: 56
            -- upvalues:
            --  [1] v5 (ref)
            --  [2] arg7 (copy)

            v5 = arg7:GetRankInGroup(7523287)
        end)
    else
        pcall(function() -- line: 60
            -- upvalues:
            --  [1] arg7 (copy)
            --  [2] v5 (ref)

            for _, val in game:GetService("GroupService"):GetGroupsAsync(arg7) do
                if val.Id == 7523287 then
                    v5 = val.Rank

                    return
                end
            end
        end)
    end

    return v5
end

local t_4 = { 198110693, 93692470, 17497127, 187115959, 23595482, 175901392, -1, -2 }

function t_2.TestUniverseAccess(_, arg9) -- line: 73
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t_3 (copy)
    --  [3] getGroupRank (copy)

    if t_2:IsAdmin(arg9) ~= nil then
        return true
    end

    return t_3[getGroupRank(arg9)] == true
end

function t_2.CanAccessCC(_, arg11) -- line: 81
    -- upvalues:
    --  [1] t_2 (copy)

    return if t_2:IsAdmin(arg11) == nil then t_2:IsContentCreator(arg11) else true
end

function t_2.AccessAll(_, arg13) -- line: 85
    -- upvalues:
    --  [1] t (copy)

    local v8 = if typeof(arg13) == "Instance" then arg13.UserId else arg13

    return table.find(t, v8)
end

function t_2.IsAdmin(_, arg15) -- line: 90
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] t (copy)

    local v9 = if typeof(arg15) == "Instance" then arg15.UserId else arg15

    return table.find(t_4, v9) or table.find(t, v9)
end

function t_2.IsDeveloper(_, arg17) -- line: 95
    -- upvalues:
    --  [1] t (copy)

    local v11 = if typeof(arg17) == "Instance" then arg17.UserId else arg17

    return table.find(t, v11)
end

function t_2.CanHostTournament(_, arg19) -- line: 101
    -- upvalues:
    --  [1] t_2 (copy)

    return if t_2:IsAdmin(arg19) == nil then false else true
end

function t_2.HasAccess(_, arg21) -- line: 105
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t_1 (copy)

    local v13 = if typeof(arg21) == "Instance" then arg21.UserId else arg21

    return if t_2:IsAdmin(v13) == nil then t_1[v13] == true else true
end

return t_2
