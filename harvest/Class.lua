-- Decompiled with Veyra harvester
-- Instance: Workspace.Map.@BroomRacing.RacingController.Class
-- Class: ModuleScript
-- bytes: 7854

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local t = {}
t.__index = t
t.VERSION = "_05"
local t_1 = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
}

function t.GetSeason(_) -- line: 23
    local v2 = DateTime.now():ToUniversalTime()

    return v2.Year, v2.Month
end

function t.GetStoreName(arg2, arg3) -- line: 29
    local v3, v4 = arg2:GetSeason()

    return string.format(
        "%s%s_%04d_%02d",
        arg3,
        arg2.VERSION,
        v3,
        v4
    )
end

function t.GetSeasonText(arg4) -- line: 35
    -- upvalues:
    --  [1] t_1 (copy)

    local v5, v6 = arg4:GetSeason()
    local v7 = v5
    local v8 = v6 + 1

    if v8 > 12 then
        v7 = v5 + 1
        v8 = 1
    end

    local UnixTimestamp = DateTime.fromUniversalTime(v7, v8, 1).UnixTimestamp
    v8 = math.max(0, UnixTimestamp - DateTime.now().UnixTimestamp)
    local v9 = math.floor(v8 / 86400)
    v7 = math.floor(v8 / 3600)
    local v10, v11

    if v9 >= 1 then
        v10 = if v9 ~= 1 then "s" else ""
        v11 = `resets in {v9} day{v10}`
    elseif v7 >= 1 then
        v10 = if v7 ~= 1 then "s" else ""
        v11 = `resets in {v7} hour{v10}`
    else
        v11 = "resets soon"
    end

    return `{t_1[v6]} {v5} \194\183 {v11}`
end

function t.UpdateRankings(arg5, arg6, arg7, arg8) -- line: 61
    -- upvalues:
    --  [1] DataStoreService (copy)

    local _, Result_1 = pcall(function() -- line: 62
        -- upvalues:
        --  [1] DataStoreService (ref)
        --  [2] arg5 (copy)
        --  [3] arg6 (copy)
        --  [4] arg7 (copy)
        --  [5] arg8 (copy)

        local v13 = DataStoreService:GetOrderedDataStore(arg5:GetStoreName(arg6))
        local v14 = arg7
        local v15 = nil
        local _, _ = pcall(function() -- line: 67
            -- upvalues:
            --  [1] v15 (ref)
            --  [2] v13 (copy)
            --  [3] v14 (copy)

            v15 = v13:GetAsync(v14)
        end)

        if v15 then
            if not (v15 < math.floor(arg8 * 1000)) then
                v13:UpdateAsync(v14, function(arg9) -- line: 73
                    -- upvalues:
                    --  [1] arg8 (ref)

                    local _ = arg9 or 0

                    return (math.floor(arg8 * 1000))
                end)
            end
        else
            v13:UpdateAsync(v14, function(arg10) -- line: 73
                -- upvalues:
                --  [1] arg8 (ref)

                local _ = arg10 or 0

                return (math.floor(arg8 * 1000))
            end)
        end
    end)

    if Result_1 then
        warn(Result_1)
    end
end

function t.GetLeaderboard(_, arg12) -- line: 85
    -- upvalues:
    --  [1] Players (copy)

    local t_2 = {}

    for key, val in pairs((arg12:GetSortedAsync(true, 50, 1, 1E+31):GetCurrentPage())) do
        local _, Result_3 = pcall(function() -- line: 99
            -- upvalues:
            --  [1] val (copy)
            --  [2] Players (ref)
            --  [3] t_2 (copy)
            --  [4] key (copy)

            local v19 = nil
            local Key = val.key
            local Value = val.value
            local Success_2, _ = pcall(function() -- line: 104
                -- upvalues:
                --  [1] Key (copy)
                --  [2] v19 (ref)
                --  [3] Players (ref)

                v19 = Players:GetNameFromUserIdAsync((tonumber(Key:split("_")[1])))
            end)

            if Success_2 and v19 then
                table.insert(t_2, { RequestPlayer = v19, Rating = Value, Order = key })
            end
        end)

        if Result_3 then
            print(Result_3, key)
        end
    end

    return t_2
end

function t.UpdateLeaderboard(arg13, arg14, arg15) -- line: 122
    -- upvalues:
    --  [1] DataStoreService (copy)

    local Season = arg15.Parent:FindFirstChild("Season")

    if Season then
        Season.Text = arg13:GetSeasonText()
    end

    local v21 = arg13:GetLeaderboard(
        (DataStoreService:GetOrderedDataStore(arg13:GetStoreName(arg14)))
    )

    for _, child in arg15:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    for _, val_1 in pairs(v21) do
        local _, Result_4 = pcall(function() -- line: 139
            -- upvalues:
            --  [1] val_1 (copy)
            --  [2] arg15 (copy)

            local v22 = val_1.RequestPlayer or "unable to identify user"
            local v23 = script.BoardTemplate:Clone()
            v23.Name = v22
            local Rank = v23.Rank
            local v24 = val_1.Rating / 1000
            local v25 = math.floor(v24 / 60)
            local v26 = math.floor(v24 % 60)
            local v27 = math.floor(v24 * 100 % 100)
            local v28 = string.format("%02d:%02d.%02d", v25, v26, v27)
            v23.Player.Text = v22
            v23.Time.Text = v28
            Rank.Text = val_1.Order

            if val_1.Order == 1 then
                Rank.TextColor3 = Color3.fromRGB(204, 172, 77)
            elseif val_1.Order == 2 then
                Rank.TextColor3 = Color3.new(0.9, 0.9, 0.9)
            elseif val_1.Order == 3 then
                Rank.TextColor3 = Color3.fromRGB(166, 112, 0)
            end

            v23.LayoutOrder = val_1.Order
            v23.Parent = arg15
        end)

        if Result_4 then
            print(Result_4)
        end
    end
end

function t.GetTime(arg16, arg17, arg18) -- line: 180
    -- upvalues:
    --  [1] DataStoreService (copy)

    local v30 = DataStoreService:GetOrderedDataStore(arg16:GetStoreName(arg17))
    arg18 = math.floor((arg18 or math.huge) * 1000)

    if arg18 <= 1 then
        return 1
    end

    local Success_5, Result_5 = pcall(function() -- line: 190
        -- upvalues:
        --  [1] v30 (copy)
        --  [2] arg18 (ref)

        return v30:GetSortedAsync(true, 100, 1, arg18 - 1)
    end)

    if not Success_5 or not Result_5 then
        warn("[Racing] GetSortedAsync failed:", Result_5)

        return nil
    end

    local v34 = 0

    for index = 1, 10 do
        v34 += #Result_5:GetCurrentPage()
        local _ = Result_5:GetCurrentPage()

        if Result_5.IsFinished then
            return v34 + 1
        end

        if index == 10 then
            break
        end

        if not pcall(function() -- line: 210
            -- upvalues:
            --  [1] Result_5 (copy)

            Result_5:AdvanceToNextPageAsync()
        end) then
            return nil
        end
    end

    return 9999
end

function t.CreateLeaderboard(_, arg20, arg21) -- line: 224
    for _, child_1 in arg21:GetChildren() do
        if child_1:IsA("SurfaceGui") then
            child_1:Destroy()
        end
    end

    local v36 = script.LeaderboardTemplate:Clone()
    v36.Name = "SurfaceGui"
    v36.Adornee = arg21
    local Main = v36.Leaderboard.Main
    Main.Title.Text = string.upper(arg20)
    v36.Parent = arg21

    return Main.List
end

function t.Init(arg22, arg23) -- line: 243
    local t_4 = {}

    for key_4, val_2 in pairs(arg23) do
        local Leaderboard = val_2:FindFirstChild("Leaderboard")

        if Leaderboard then
            t_4[key_4] = arg22:CreateLeaderboard(key_4, Leaderboard)
            Leaderboard.Size = Vector3.new(7, 7, 0.001)
        end
    end

    for key_5, val_3 in pairs(t_4) do
        local Success_6, Result_6 = pcall(arg22.UpdateLeaderboard, arg22, key_5, val_3)

        if not Success_6 then
            warn("[Racing] Couldn't update leaderboard for", key_5, Result_6)
        end
    end

    task.wait(90)
end

return t
