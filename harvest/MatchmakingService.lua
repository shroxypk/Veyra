-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService
-- Class: ModuleScript
-- bytes: 125043

local _, _, _, _, _, _, _, _, _, _
local v1 = false
local t = {}
local t_1 = {}
local t_2 = {}
local t_3 = {}
local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = Services_m.Players
local _ = Services_m.ReplicatedStorage
local ServerStorage = Services_m.ServerStorage
local _ = Services_m.ServerScriptService
local RunService = Services_m.RunService
local _ = Services_m.CollectionService
local MemoryStoreService = Services_m.MemoryStoreService
local DataStoreService = Services_m.DataStoreService
local MessagingService = Services_m.MessagingService
local TeleportService = Services_m.TeleportService
local TeleportModule_m = require(ServerStorage:WaitForChild("TeleportModule"))
local MATCHMAKINGSERVICESKILLS = DataStoreService:GetDataStore("MATCHMAKINGSERVICE_SKILLS")
local OpenSkill_m = require(script.OpenSkill)
local Signal_m = require(script.Signal)
local MATCHMAKINGSERVICE = MemoryStoreService:GetSortedMap("MATCHMAKINGSERVICE")
local MATCHMAKINGSERVICEJOINABLEGAMES = MemoryStoreService:GetSortedMap(
    "MATCHMAKINGSERVICE_JOINABLE_GAMES"
)
local MATCHMAKINGSERVICENONJOINABLEGAMES = MemoryStoreService:GetSortedMap(
    "MATCHMAKINGSERVICE_NONJOINABLE_GAMES"
)
local MATCHMAKINGSERVICEQUEUE = MemoryStoreService:GetSortedMap("MATCHMAKINGSERVICE_QUEUE")
local MATCHMAKINGSERVICETELEPORTDATA = MemoryStoreService:GetSortedMap(
    "MATCHMAKINGSERVICE_TELEPORT_DATA"
)
local v4 = nil
local v5 = nil
local t_4 = {
    Singleton = nil,
    Version = "3.0.0-beta.3",
    Versions = { v1 = 8470858629, v2 = 8898097654, v3 = 13533090734 }
}
t_4.__index = t_4

function first(arg1, arg2, arg3) -- line: 63
    if arg1 == nil then
        return nil
    end

    if arg3 == nil then
        arg3 = 1
    end

    local t_6 = {}

    for index = arg3, arg2 + (arg3 - 1) do
        if index > #arg1 then
            break
        end

        table.insert(t_6, arg1[index])
    end

    return t_6
end

function find(arg4, arg5) -- line: 74
    if arg4 == nil then
        return nil
    end

    for key, val in ipairs(arg4) do
        if arg5(val) then
            return key
        end
    end

    return nil
end

function dictlen(arg6) -- line: 84
    local v6 = 0

    for _, _ in pairs(arg6) do
        v6 += 1
    end

    return v6
end

function any(arg7, arg8) -- line: 92
    if arg7 == nil or arg8 == nil then
        return false
    end

    for _, val_2 in pairs(arg7) do
        if arg8(val_2) then
            return true
        end
    end

    return false
end

function all(arg9, arg10) -- line: 102
    if arg9 == nil or arg10 == nil then
        return false
    end

    local t_7 = {}

    for _, val_3 in ipairs(arg10) do
        t_7[val_3] = false
    end

    for _, val_4 in ipairs(arg9) do
        if table.find(arg10, val_4) ~= nil then
            t_7[val_4] = true
        end
    end

    return not any(t_7, function(arg11) -- line: 113
        return not arg11
    end)
end

function reduce(arg12, arg13, arg14) -- line: 116
    local v7 = arg14 or 0

    for key_5, val_5 in pairs(arg12) do
        v7 = arg13(v7, val_5, key_5, arg12)
    end

    return v7
end

function tableSelect(arg15, arg16) -- line: 124
    if arg15 == nil then
        return nil
    end

    local t_8 = {}

    for _, val_6 in ipairs(arg15) do
        table.insert(t_8, val_6[arg16])
    end

    return t_8
end

function append(arg17, arg18) -- line: 133
    if arg17 == nil or arg18 == nil then
        return nil
    end

    for _, val_7 in ipairs(arg18) do
        table.insert(arg17, val_7)
    end
end

function roundSkill(arg19) -- line: 147
    return math.round(arg19 / 10) * 10
end

function checkForParties(arg20) -- line: 151
    for key_8, val_8 in ipairs(arg20) do
        if val_8[3] ~= nil and key_8 + val_8[3] > #arg20 then
            for index_1 = #arg20, key_8, -1 do
                table.remove(arg20, index_1)
            end

            return false
        end
    end

    return true
end

function getFromMemory(arg21, arg22, arg23) -- line: 163
    if arg23 == nil then
        arg23 = 3
    end

    local Success = nil
    local v9 = nil
    local v10 = 0

    while not Success do
        if not (arg23 > v10) then
            break
        end

        Success, v9 = pcall(arg21.GetAsync, arg21, arg22)
        v10 += 1

        if Success then
            continue
        end

        if not (arg23 > v10) then
            continue
        end

        task.wait(v10 * 3 + math.random())
    end

    if not Success then
        warn(v9)

        return nil
    end

    return v9
end

function updateQueue(s1: string, arg24: any, arg25: any, arg26: any) -- line: 184
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEQUEUE (copy)

    local UnixTimestampMillis = DateTime.now().UnixTimestampMillis

    if arg26 == nil then
    end

    local Success_1, Result = pcall(function() -- line: 192
        -- upvalues:
        --  [1] MATCHMAKINGSERVICEQUEUE (ref)
        --  [2] s1 (copy)

        MATCHMAKINGSERVICEQUEUE:UpdateAsync("QueuedMaps", function(arg27) -- line: 193
            -- upvalues:
            --  [1] s1 (ref)

            if arg27 == nil then
                return { s1 }
            end

            if find(arg27, function(arg28) -- line: 197
                -- upvalues:
                --  [1] s1 (ref)

                return arg28 == s1
            end) then
                return arg27
            end

            table.insert(arg27, s1)

            return arg27
        end, 86400)
    end)

    if not Success_1 then
        print("Unable to update queued maps:")
        warn(Result)
    end

    local Success_2, Result_1 = pcall(function() -- line: 213
        -- upvalues:
        --  [1] MATCHMAKINGSERVICEQUEUE (ref)
        --  [2] s1 (copy)
        --  [3] arg24 (copy)
        --  [4] arg25 (copy)
        --  [5] UnixTimestampMillis (copy)

        MATCHMAKINGSERVICEQUEUE:UpdateAsync(s1 .. "__QueuedRatingTypes", function(arg29) -- line: 214
            -- upvalues:
            --  [1] arg24 (ref)
            --  [2] arg25 (ref)
            --  [3] UnixTimestampMillis (ref)

            if arg29 == nil then
                arg29 = { [arg24] = { { arg25, UnixTimestampMillis } } }

                return arg29
            end

            if arg29[arg24] == nil then
                arg29[arg24] = { { arg25, UnixTimestampMillis } }

                return arg29
            end

            if find(arg29[arg24], function(arg30) -- line: 221
                -- upvalues:
                --  [1] arg25 (ref)

                return arg30[1] == arg25
            end) then
                return arg29
            end

            table.insert(arg29[arg24], { arg25, UnixTimestampMillis })

            return arg29
        end, 86400)
    end)

    if not Success_2 then
        print("Unable to update queued rating types:")
        warn(Result_1)
    end
end

function t_4.GetSingleton(t1: table?) -- line: 318
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] Players (copy)
    --  [3] t_3 (copy)
    --  [4] MATCHMAKINGSERVICE (copy)
    --  [5] v1 (ref)
    --  [6] MessagingService (copy)
    --  [7] t (copy)
    --  [8] t_1 (copy)
    --  [9] t_2 (copy)

    if t1 and t1.MajorVersion ~= nil then
        local MajorVersion = t1.MajorVersion
        t1.MajorVersion = nil
        local v15 = t_4.Versions[MajorVersion]

        if v15 == nil then
            warn("Major version " .. tostring(t1.MajorVersion) .. " not found.")
        end

        t_4.Singleton = require(v15).GetSingleton(t1)

        return t_4.Singleton
    end

    print("Retrieving MatchmakingService (" .. t_4.Version .. ") Singleton.")

    if t_4.Singleton == nil then
        Players.PlayerRemoving:Connect(function(arg31) -- line: 331
            -- upvalues:
            --  [1] t_4 (ref)
            --  [2] t_3 (ref)

            if t_4.Singleton.IsGameServer then
                t_4.Singleton:RemovePlayerFromGameId(
                    arg31.UserId,
                    t_4.Singleton:GetCurrentGameCode(),
                    t_4.Singleton.UpdateJoinableOnLeave
                )
            end

            if t_3[arg31.UserId] then
                t_4.Singleton:RemovePlayerFromQueueId(arg31.UserId)
            end
        end)
        t_4.Singleton = t_4.new(t1)
        task.spawn(function() -- line: 341
            -- upvalues:
            --  [1] MATCHMAKINGSERVICE (ref)
            --  [2] v1 (ref)
            --  [3] t1 (copy)
            --  [4] MessagingService (ref)
            --  [5] Players (ref)
            --  [6] t_4 (ref)
            --  [7] t (ref)
            --  [8] t_1 (ref)
            --  [9] t_2 (ref)

            local v19 = getFromMemory(MATCHMAKINGSERVICE, "MainJobId", 3)
            local UnixTimestampMillis_1 = DateTime.now().UnixTimestampMillis

            if (if v19 ~= nil then if not (UnixTimestampMillis_1 >= v19[2] + 25000) then false else true else true) and not v1 then
                MATCHMAKINGSERVICE:UpdateAsync("MainJobId", function(arg32) -- line: 346
                    -- upvalues:
                    --  [1] v19 (copy)
                    --  [2] UnixTimestampMillis_1 (copy)

                    if arg32 == nil or arg32[1] == v19 then
                        return { game.JobId, UnixTimestampMillis_1 }
                    end

                    return nil
                end, 86400)
            end

            if t1 == nil or not t1.DisableGlobalEvents then
                MessagingService:SubscribeAsync("MatchmakingServicePlayersAddedToQueue", function(
                    arg33
                ) -- line: 355
                    -- upvalues:
                    --  [1] Players (ref)
                    --  [2] t_4 (ref)

                    for _, val_9 in ipairs(arg33.Data) do
                        if Players:GetPlayerByUserId(val_9[1]) == nil then
                            t_4.Singleton.PlayerAddedToQueue:Fire(
                                val_9[1],
                                val_9[2],
                                val_9[3],
                                val_9[4]
                            )
                        end
                    end
                end)
                MessagingService:SubscribeAsync("MatchmakingServicePlayersRemovedFromQueue", function(
                    arg34
                ) -- line: 362
                    -- upvalues:
                    --  [1] Players (ref)
                    --  [2] t_4 (ref)

                    for _, val_10 in ipairs(arg34.Data) do
                        if Players:GetPlayerByUserId(val_10[1]) == nil then
                            t_4.Singleton.PlayerRemovedFromQueue:Fire(
                                val_10[1],
                                val_10[2],
                                val_10[3],
                                val_10[4]
                            )
                        end
                    end
                end)

                while true do
                    if v1 then
                        break
                    end

                    task.wait(5)

                    if #t > 0 then
                        MessagingService:PublishAsync("MatchmakingServicePlayersAddedToQueue", t)
                        table.clear(t)
                    end

                    if #t_1 > 0 then
                        MessagingService:PublishAsync(
                            "MatchmakingServicePlayersRemovedFromQueue",
                            t_1
                        )
                        table.clear(t_1)
                    end

                    table.clear(t_2)
                end
            end
        end)
    end

    return t_4.Singleton
end

function t_4.SetMatchmakingInterval(t2: table, n1: number) -- line: 391
    t2.MatchmakingInterval = n1
end

function t_4.SetPlayerRange(t3: table, s2: string, u1: NumberRange) -- line: 398
    if u1.Max > 100 then
        warn("Maximum players has a cap of 100.")
    end

    local t_9 = {}
    local t_10 = { Min = u1.Min, Max = u1.Max }
    local PlayerRanges = t3.PlayerRanges
    t_9.MMS_NO_ROLE = t_10
    PlayerRanges[s2] = t_9
end

function t_4.SetMapRoles(t4: table, s3: string, t5: table) -- line: 420
    if t5.Max > 100 then
        warn("Maximum players has a cap of 100.")
    end

    t4.PlayerRanges[s3] = t5
end

function t_4.AddGamePlace(t6: table, s4: string, n2: number) -- line: 431
    t6.GamePlaceIds[s4] = n2

    if not t6.PlayerRanges[s4] then
        t6.PlayerRanges[s4] = NumberRange.new(6, 10)
    end
end

function t_4.SetIsGameServer(t7: table, b1: boolean, b2: boolean) -- line: 442
    t7.IsGameServer = b1
    t7.UpdateJoinableOnLeave = b2
end

function t_4.SetStartingMean(t8: table, n3: number) -- line: 450
    t8.StartingMean = n3
end

function t_4.SetStartingStandardDeviation(t9: table, n4: number) -- line: 457
    t9.StartingStandardDeviation = n4
end

function t_4.SetMaxPartySkillGap(t10: table, n5: number) -- line: 463
    t10.MaxPartySkillGap = n5
end

function t_4.SetSecondsBetweenExpansion(t11: table, n6: number) -- line: 471
    t11.SecondsPerExpansion = n6
end

function t_4.SetFoundGameDelay(t12: table, n7: number) -- line: 477
    t12.FoundGameDelay = n7
end

function t_4.SetRunningGamesJoinable(t13: table, b3: boolean) -- line: 483
    t13.RunningGamesJoinable = b3
end

function t_4.Clear(arg35) -- line: 488
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [3] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)
    --  [4] MATCHMAKINGSERVICE (copy)
    --  [5] MATCHMAKINGSERVICEQUEUE (copy)

    print("Clearing memory")
    local v21 = t_4:GetAllRunningGames()
    local v22 = 0 + #v21

    for _, val_11 in ipairs(v21) do
        if val_11.value.joinable then
            v22 += 1
            MATCHMAKINGSERVICEJOINABLEGAMES:RemoveAsync(val_11.key)
        else
            v22 += 1
            MATCHMAKINGSERVICENONJOINABLEGAMES:RemoveAsync(val_11.key)
        end
    end

    MATCHMAKINGSERVICE:RemoveAsync("QueuedSkillLevels")
    MATCHMAKINGSERVICE:RemoveAsync("MainJobId")
    v22 += 2
    local v23 = getFromMemory(MATCHMAKINGSERVICEQUEUE, "QueuedMaps", 3)
    v22 += 3

    if v23 == nil then
        return print("Total requests: " .. tostring(v22))
    end

    MATCHMAKINGSERVICEQUEUE:RemoveAsync("QueuedMaps")
    v22 += 1

    for _, val_12 in ipairs(v23) do
        local v24 = arg35:GetQueue(val_12)
        v22 += 1
        MATCHMAKINGSERVICEQUEUE:RemoveAsync(val_12 .. "__QueuedRatingTypes")

        if v24 ~= nil then
            for key_13, val_13 in pairs(v24) do
                for key_14, _ in pairs(val_13) do
                    v22 += 1
                    MATCHMAKINGSERVICEQUEUE:RemoveAsync(val_12 .. "__" .. key_13 .. "__" .. key_14)
                end
            end
        end
    end

    print("Total requests: " .. tostring(v22))
end

function t_4.new(t14: table?) -- line: 527
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] Signal_m (copy)
    --  [3] RunService (copy)
    --  [4] MATCHMAKINGSERVICE (copy)
    --  [5] v1 (ref)
    --  [6] MATCHMAKINGSERVICEQUEUE (copy)
    --  [7] MATCHMAKINGSERVICETELEPORTDATA (copy)
    --  [8] Players (copy)
    --  [9] TeleportService (copy)
    --  [10] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [11] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)
    --  [12] ServerStorage (copy)
    --  [13] TeleportModule_m (copy)

    local t_11 = {}
    setmetatable(t_11, t_4)
    t_11.Options = t14 or {}
    t_11.MatchmakingInterval = 3
    t_11.PlayerRanges = {}
    t_11.GamePlaceIds = {}
    t_11.IsGameServer = false
    t_11.UpdateJoinableOnLeave = false
    t_11.MaxPartySkillGap = 50
    t_11.PlayerAddedToQueue = Signal_m:Create()
    t_11.PlayerRemovedFromQueue = Signal_m:Create()
    t_11.FoundGame = Signal_m:Create()
    t_11.GameCreated = Signal_m:Create()
    t_11.FoundGameDelay = 0
    t_11.ApplyCustomTeleportData = nil
    t_11.ApplyGeneralTeleportData = nil
    t_11.SecondsPerExpansion = 10
    t_11.RunningGamesJoinable = true

    if RunService:IsStudio() then
        task.spawn(t_11.Clear, t_11)
    end

    task.spawn(function() -- line: 552
        -- upvalues:
        --  [1] MATCHMAKINGSERVICE (ref)
        --  [2] t_11 (copy)
        --  [3] v1 (ref)
        --  [4] MATCHMAKINGSERVICEQUEUE (ref)
        --  [5] MATCHMAKINGSERVICETELEPORTDATA (ref)
        --  [6] Players (ref)
        --  [7] RunService (ref)
        --  [8] TeleportService (ref)
        --  [9] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
        --  [10] MATCHMAKINGSERVICENONJOINABLEGAMES (ref)
        --  [11] ServerStorage (ref)
        --  [12] TeleportModule_m (ref)

        local v28 = 0
        local v29 = 20000 + math.random(0, 10000)
        local v31 = getFromMemory(MATCHMAKINGSERVICE, "MainJobId", 3)
        local v32 = t_11
        local v33 = false

        if v31 ~= nil then
            v33 = v31[1] == game.JobId
        end

        v32.IsMain = v33

        local function tryClaim(arg36) -- line: 564
            -- upvalues:
            --  [1] MATCHMAKINGSERVICE (ref)
            --  [2] v1 (ref)
            --  [3] v31 (ref)
            --  [4] t_11 (ref)

            local UnixTimestampMillis_2 = DateTime.now().UnixTimestampMillis
            local Success_3, Result_2 = pcall(function() -- line: 566
                -- upvalues:
                --  [1] MATCHMAKINGSERVICE (ref)
                --  [2] v1 (ref)
                --  [3] arg36 (copy)
                --  [4] UnixTimestampMillis_2 (copy)

                return MATCHMAKINGSERVICE:UpdateAsync("MainJobId", function(arg37) -- line: 567
                    -- upvalues:
                    --  [1] v1 (ref)
                    --  [2] arg36 (ref)
                    --  [3] UnixTimestampMillis_2 (ref)

                    if v1 then
                        return nil
                    end

                    if arg37 == nil or (arg37[1] == game.JobId or arg36 ~= nil and (arg37[1] == arg36[1] and arg37[2] == arg36[2])) then
                        return { game.JobId, UnixTimestampMillis_2 }
                    end

                    return nil
                end, 86400)
            end)

            if Success_3 and Result_2 ~= nil then
                v31 = Result_2
            else
                v31 = nil
            end

            t_11.IsMain = if v31 == nil then false else v31[1] == game.JobId
        end

        if v31 == nil then
            tryClaim(nil)
        end

        local Result_5, _, TeleportOptions, str_1, str_2, t_16, t_17, t_18, t_19, t_20, table_remove_1, teleportPlayers, _
        local v102, v103, v107, v115, v124, v128, v129, v145, v146, v39, v49, v54, v55, v58, v60, v82

        while true do
            if t_11.IsGameServer then
                break
            end

            if v1 then
                break
            end

            task.wait(t_11.MatchmakingInterval)
            local UnixTimestampMillis_3 = DateTime.now().UnixTimestampMillis

            if t_11.IsMain then
                if UnixTimestampMillis_3 >= v28 + 10000 then
                    v28 = UnixTimestampMillis_3
                    tryClaim(v31)
                end
            elseif UnixTimestampMillis_3 >= v28 + v29 then
                v28 = UnixTimestampMillis_3
                local v38 = getFromMemory(MATCHMAKINGSERVICE, "MainJobId", 1)

                if v38 ~= nil then
                    if UnixTimestampMillis_3 >= v38[2] + 30000 then
                        tryClaim(v38)
                    else
                        v31 = v38
                        v39 = t_11
                        v39.IsMain = v38[1] == game.JobId
                    end
                else
                    tryClaim(v38)
                    v31 = v38
                    v39 = t_11
                    v39.IsMain = v38[1] == game.JobId
                end
            end

            if t_11.IsMain then
                local v41 = getFromMemory(MATCHMAKINGSERVICE, "QueuedParties", 3)

                if t_11.RunningGamesJoinable then
                    for _, val_15 in ipairs((t_11:GetJoinableGames())) do
                        local Value = val_15.value

                        if Value.joinable then
                            local v44 = t_11:GetQueue(Value.map)

                            if v44 == nil then
                                MATCHMAKINGSERVICEQUEUE:UpdateAsync("QueuedMaps", function(arg38) -- line: 626
                                    -- upvalues:
                                    --  [1] Value (copy)

                                    if arg38 == nil then
                                        return nil
                                    end

                                    local v46 = table.find(arg38, Value.map)

                                    if v46 == nil then
                                        return nil
                                    end

                                    table.remove(arg38, v46)

                                    return arg38
                                end, 86400)
                            else
                                v49 = v44[Value.ratingType]

                                if v49 ~= nil then
                                    local t_12 = {}

                                    for key_16, val_16 in Value.full do
                                        if not val_16 then
                                            table.insert(t_12, key_16)
                                        end
                                    end

                                    for _, val_17 in ipairs(t_12) do
                                        local v52 = v49[tostring(Value.skillLevel)]

                                        if v52 ~= nil then
                                            v52 = v52[val_17]

                                            if v52 ~= nil then
                                                if #v52 ~= 0 then
                                                    if not t_11.Options.DisableExpansions then
                                                        v54 = UnixTimestampMillis_3 - Value.createTime
                                                        v55 = t_11.SecondsPerExpansion
                                                        v58 = math.floor(v54 / (v55 * 1000))
                                                    else
                                                        v58 = 0
                                                    end

                                                    if v52 ~= nil or v58 ~= 0 then
                                                        v54 = v52 or {}
                                                        v55 = t_11.PlayerRanges[Value.map][val_17].Max
                                                        v60 = Value.players
                                                        local v61 = #v60
                                                        local v59 = first(v54, v55 - v61)

                                                        if v59 then
                                                            if #v59 ~= 0 then
                                                                local v63 = #v59
                                                                v61 = t_11.PlayerRanges[Value.map]
                                                                v55 = v61[val_17].Max
                                                                v60 = Value.players
                                                                v61 = #v60

                                                                if v63 < v55 - v61 then
                                                                    v55 = 1

                                                                    for index_2 = v55, v58 do
                                                                        v61 = tostring(
                                                                            Value.skillLevel + index_2 * 10
                                                                        )
                                                                        v60 = tostring(
                                                                            Value.skillLevel - index_2 * 10
                                                                        )
                                                                        local v65 = v44[Value.ratingType]
                                                                        local v66 = v44[Value.ratingType]

                                                                        if v65 ~= nil then
                                                                            if v65[v61] ~= nil then
                                                                                v65 = v65[v61][val_17]
                                                                            end

                                                                            if v66[v60] ~= nil then
                                                                                v66 = v66[v60][val_17]
                                                                            end
                                                                        end

                                                                        append(v59, v65)
                                                                        append(v59, v66)

                                                                        if #v59 > t_11.PlayerRanges[Value.map][val_17].Max - #Value.players then
                                                                            for index_3 = #v59, t_11.PlayerRanges[Value.map][val_17].Max - #Value.players, -1 do
                                                                                table.remove(
                                                                                    v59,
                                                                                    index_3
                                                                                )
                                                                            end
                                                                        end
                                                                    end
                                                                end

                                                                if v59 ~= nil then
                                                                    for index_4 = #v59, 1, -1 do
                                                                        v61 = v59[index_4][2]
                                                                        v60 = UnixTimestampMillis_3 - t_11.MatchmakingInterval * 1000

                                                                        if v61 >= v60 then
                                                                            v61 = table.remove
                                                                            v60 = v59
                                                                            v61(v60, index_4)
                                                                        end
                                                                    end

                                                                    v58 = #v59

                                                                    while true do
                                                                        if checkForParties(v59) then
                                                                            break
                                                                        end

                                                                        v61 = t_11.PlayerRanges[Value.map][val_17]
                                                                        v55 = v61.Max - #Value.players
                                                                        local v78 = first(
                                                                            v52,
                                                                            v55,
                                                                            v58 + 1
                                                                        )

                                                                        if v78 == nil or #v78 == 0 then
                                                                            break
                                                                        end

                                                                        v58 += #v78
                                                                        append(v59, v78)
                                                                    end
                                                                end

                                                                if v59 ~= nil then
                                                                    if #v59 > 0 then
                                                                        print(
                                                                            "Adding to existing game"
                                                                        )
                                                                        local t_13 = {}
                                                                        v82 = MATCHMAKINGSERVICETELEPORTDATA:GetAsync(
                                                                            val_15.key
                                                                        ) or {}

                                                                        for _, val_18 in ipairs(v59) do
                                                                            table.insert(
                                                                                t_13,
                                                                                val_18[1]
                                                                            )
                                                                            local v83 = t_11
                                                                            local v84 = val_18[1]
                                                                            local Key = val_15.key
                                                                            local RatingType_1 = Value.ratingType
                                                                            local v72 = v41[val_18]

                                                                            if v41 == nil or not v72 then
                                                                                v72 = {}
                                                                            end

                                                                            v83:SetPlayerInfoId(
                                                                                v84,
                                                                                Key,
                                                                                RatingType_1,
                                                                                v72,
                                                                                Value.map,
                                                                                UnixTimestampMillis_3 + t_11.FoundGameDelay * 1000
                                                                            )
                                                                        end

                                                                        t_11:AddPlayersToGameId(
                                                                            t_13,
                                                                            val_15.key,
                                                                            val_17
                                                                        )
                                                                        local v87 = t_11
                                                                        v61 = tableSelect(v59, 1)
                                                                        v87:RemovePlayersFromQueueId(
                                                                            v61,
                                                                            false
                                                                        )

                                                                        if t_11.ApplyCustomTeleportData ~= nil then
                                                                            local v88 = t_11.GetRunningGame(
                                                                                val_15.key
                                                                            )

                                                                            for _, val_19 in ipairs(
                                                                                t_13
                                                                            ) do
                                                                                v82.customData[val_19] = t_11.ApplyCustomTeleportData(
                                                                                    Players:GetPlayerByUserId(
                                                                                        val_19
                                                                                    ),
                                                                                    v88
                                                                                )
                                                                            end
                                                                        end

                                                                        v61 = val_15.key
                                                                        v60 = v82
                                                                        MATCHMAKINGSERVICETELEPORTDATA:SetAsync(
                                                                            v61,
                                                                            v60,
                                                                            86400
                                                                        )
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                local v96 = getFromMemory(MATCHMAKINGSERVICEQUEUE, "QueuedMaps", 3)

                if v96 == nil then
                    continue
                end

                local t_14 = {}

                for _, val_20 in ipairs(v96) do
                    local v97 = t_11:GetQueue(val_20)

                    if v97 == nil then
                        MATCHMAKINGSERVICEQUEUE:UpdateAsync("QueuedMaps", function(arg39) -- line: 773
                            -- upvalues:
                            --  [1] val_20 (copy)

                            if arg39 == nil then
                                return nil
                            end

                            local v98 = table.find(arg39, val_20)

                            if v98 == nil then
                                return nil
                            end

                            table.remove(arg39, v98)

                            return arg39
                        end, 86400)
                    else
                        for key_21, val_21 in pairs(v97) do
                            for key_22, val_22 in pairs(val_21) do
                                v82 = {}

                                for key_23, val_23 in pairs(val_22) do
                                    local v99 = first(val_23, t_11.PlayerRanges[val_20][key_23].Max)

                                    if v99 and #v99 ~= 0 then
                                        local v100 = if not t_11.Options.DisableExpansions then math.floor(
                                            (UnixTimestampMillis_3 - v99[1][2]) / (t_11.SecondsPerExpansion * 1000)
                                        ) else 0

                                        if v99 ~= nil then
                                            if #v99 < t_11.PlayerRanges[val_20][key_23].Max then
                                                for index_5 = 1, v100 do
                                                    str_1 = tostring(
                                                        tonumber(key_22) + index_5 * 10
                                                    )
                                                    str_2 = tostring(
                                                        tonumber(key_22) - index_5 * 10
                                                    )
                                                    v102 = v97[key_21]
                                                    v103 = v97[key_21]

                                                    if v102 ~= nil then
                                                        if v102[str_1] ~= nil then
                                                            v102 = v102[str_1][key_23]
                                                        end

                                                        if v103[str_2] ~= nil then
                                                            v103 = v103[str_2][key_23]
                                                        end
                                                    end

                                                    if v99 == nil then
                                                        v99 = {}
                                                    end

                                                    append(v99, v102)
                                                    append(v99, v103)
                                                end

                                                if #v99 > t_11.PlayerRanges[val_20][key_23].Max then
                                                    v107 = t_11.PlayerRanges[val_20]

                                                    for index_6 = #v99, v107[key_23].Max, -1 do
                                                        table_remove_1 = table.remove
                                                        local _ = v107[key_23].Max
                                                        table_remove_1(v99, index_6)
                                                    end
                                                else
                                                    if v99 ~= nil then
                                                        for index_7 = #v99, 1, -1 do
                                                            if v99[index_7][2] >= UnixTimestampMillis_3 - t_11.MatchmakingInterval * 1000 then
                                                                table.remove(v99, index_7)
                                                            end
                                                        end

                                                        v100 = #v99

                                                        while true do
                                                            if checkForParties(v99) then
                                                                break
                                                            end

                                                            v115 = first(
                                                                val_23,
                                                                t_11.PlayerRanges[val_20][key_23].Max,
                                                                v100 + 1
                                                            )

                                                            if v115 == nil or #v115 == 0 then
                                                                break
                                                            end

                                                            v100 += #v115
                                                            append(v99, v115)
                                                        end

                                                        for index_8 = #v99, 1, -1 do
                                                            if table.find(t_14, v99[index_8][1]) then
                                                                table.remove(v99, index_8)
                                                            end
                                                        end
                                                    end

                                                    if v99 ~= nil then
                                                        if not (#v99 < t_11.PlayerRanges[val_20][key_23].Min) then
                                                            v124 = tableSelect(v99, 1)
                                                            append(t_14, v124)
                                                            v82[key_23] = v124
                                                        end
                                                    end
                                                end
                                            else
                                                if v99 ~= nil then
                                                    for index_9 = #v99, 1, -1 do
                                                        if v99[index_9][2] >= UnixTimestampMillis_3 - t_11.MatchmakingInterval * 1000 then
                                                            table.remove(v99, index_9)
                                                        end
                                                    end

                                                    v100 = #v99

                                                    while true do
                                                        if checkForParties(v99) then
                                                            break
                                                        end

                                                        v115 = first(
                                                            val_23,
                                                            t_11.PlayerRanges[val_20][key_23].Max,
                                                            v100 + 1
                                                        )

                                                        if v115 == nil or #v115 == 0 then
                                                            break
                                                        end

                                                        v100 += #v115
                                                        append(v99, v115)
                                                    end

                                                    for index_10 = #v99, 1, -1 do
                                                        if table.find(t_14, v99[index_10][1]) then
                                                            table.remove(v99, index_10)
                                                        end
                                                    end
                                                end

                                                if v99 ~= nil then
                                                    if not (#v99 < t_11.PlayerRanges[val_20][key_23].Min) then
                                                        v124 = tableSelect(v99, 1)
                                                        append(t_14, v124)
                                                        v82[key_23] = v124
                                                    end
                                                end
                                            end
                                        else
                                            for index_11 = 1, v100 do
                                                str_1 = tostring(tonumber(key_22) + index_11 * 10)
                                                str_2 = tostring(tonumber(key_22) - index_11 * 10)
                                                v102 = v97[key_21]
                                                v103 = v97[key_21]

                                                if v102 ~= nil then
                                                    if v102[str_1] ~= nil then
                                                        v102 = v102[str_1][key_23]
                                                    end

                                                    if v103[str_2] ~= nil then
                                                        v103 = v103[str_2][key_23]
                                                    end
                                                end

                                                if v99 == nil then
                                                    v99 = {}
                                                end

                                                append(v99, v102)
                                                append(v99, v103)
                                            end

                                            if #v99 > t_11.PlayerRanges[val_20][key_23].Max then
                                                v107 = t_11.PlayerRanges[val_20]

                                                for index_12 = #v99, v107[key_23].Max, -1 do
                                                    table_remove_1 = table.remove
                                                    local _ = v107[key_23].Max
                                                    table_remove_1(v99, index_12)
                                                end
                                            else
                                                if v99 ~= nil then
                                                    for index_13 = #v99, 1, -1 do
                                                        if v99[index_13][2] >= UnixTimestampMillis_3 - t_11.MatchmakingInterval * 1000 then
                                                            table.remove(v99, index_13)
                                                        end
                                                    end

                                                    v100 = #v99

                                                    while true do
                                                        if checkForParties(v99) then
                                                            break
                                                        end

                                                        v115 = first(
                                                            val_23,
                                                            t_11.PlayerRanges[val_20][key_23].Max,
                                                            v100 + 1
                                                        )

                                                        if v115 == nil or #v115 == 0 then
                                                            break
                                                        end

                                                        v100 += #v115
                                                        append(v99, v115)
                                                    end

                                                    for index_14 = #v99, 1, -1 do
                                                        if table.find(t_14, v99[index_14][1]) then
                                                            table.remove(v99, index_14)
                                                        end
                                                    end
                                                end

                                                if v99 ~= nil then
                                                    if not (#v99 < t_11.PlayerRanges[val_20][key_23].Min) then
                                                        v124 = tableSelect(v99, 1)
                                                        append(t_14, v124)
                                                        v82[key_23] = v124
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end

                                local v127 = true

                                for key_24, val_24 in pairs(t_11.PlayerRanges[val_20]) do
                                    if v82[key_24] == nil or #v82[key_24] < val_24.Min then
                                        v127 = false
                                        break
                                    end
                                end

                                if v127 then
                                    print("WE GOT ENOUGH TO MAKE GAME!!!")

                                    if RunService:IsStudio() then
                                        v128 = "TEST"
                                        v129 = "TEST"
                                    else
                                        v128, v129 = TeleportService:ReserveServer(
                                            t_11.GamePlaceIds[val_20]
                                        )
                                    end

                                    local v60 = {
                                        full = {},
                                        skillLevel = tonumber(key_22),
                                        players = v82,
                                        started = false,
                                        joinable = t_11.RunningGamesJoinable,
                                        ratingType = key_21,
                                        map = val_20,
                                        createTime = UnixTimestampMillis_3
                                    }
                                    print("GAME DATA CREATED")

                                    for key_25, val_25 in pairs(t_11.PlayerRanges[val_20]) do
                                        local Full = v60.full
                                        local v126 = v82[key_25]

                                        if v126 then
                                            v126 = #v82[key_25] >= val_25.Max
                                        end

                                        Full[key_25] = v126
                                    end

                                    if v60.joinable then
                                        local v131 = true

                                        for _, val_26 in pairs(v60.full) do
                                            if not val_26 then
                                                v131 = false
                                                break
                                            end
                                        end

                                        if v131 then
                                            v60.joinable = false
                                        end
                                    end

                                    local Success_4, Result_3 = pcall(function() -- line: 933
                                        -- upvalues:
                                        --  [1] v60 (copy)
                                        --  [2] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
                                        --  [3] v128 (ref)
                                        --  [4] MATCHMAKINGSERVICENONJOINABLEGAMES (ref)

                                        if v60.joinable then
                                            print("Adding to joinable")
                                            MATCHMAKINGSERVICEJOINABLEGAMES:UpdateAsync(v128, function() -- line: 936
                                                -- upvalues:
                                                --  [1] v60 (ref)

                                                return v60
                                            end, 86400)

                                            return
                                        end

                                        print("Adding to non-joinable")
                                        MATCHMAKINGSERVICENONJOINABLEGAMES:UpdateAsync(v128, function() -- line: 941
                                            -- upvalues:
                                            --  [1] v60 (ref)

                                            return v60
                                        end, 86400)
                                    end)
                                    print("GAME DATA ADDED")

                                    if not Success_4 then
                                        print("Error adding new game:")
                                        warn(Result_3)
                                    else
                                        local Success_5, Result_4 = pcall(function() -- line: 953
                                            -- upvalues:
                                            --  [1] MATCHMAKINGSERVICE (ref)
                                            --  [2] v129 (ref)
                                            --  [3] v128 (ref)

                                            MATCHMAKINGSERVICE:SetAsync(v129, v128, 86400)
                                        end)

                                        if not Success_5 then
                                            print("Error adding new game:")
                                            warn(Result_4)
                                        else
                                            print("Added game")
                                            t_11.GameCreated:Fire(v60, v129, v128)
                                            local t_15 = {}

                                            for _, val_27 in pairs(v82) do
                                                for _, val_28 in ipairs(val_27) do
                                                    table.insert(t_15, val_28)
                                                    local v133 = t_11
                                                    local v135 = v128
                                                    local v137 = v41 ~= nil and v41[tostring(val_28)] or {}
                                                    v133:SetPlayerInfoId(
                                                        val_28,
                                                        v135,
                                                        key_21,
                                                        v137,
                                                        val_20,
                                                        UnixTimestampMillis_3 + t_11.FoundGameDelay * 1000
                                                    )
                                                end
                                            end

                                            t_11:RemovePlayersFromQueueId(t_15, false)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                t_16 = {}
                t_17 = {}
                t_18 = {}
                t_19 = {}

                for _, val_29 in ipairs(Players:GetPlayers()) do
                    v49 = val_29:GetAttribute("MMS_QUEUED")

                    if v49 then
                        v49 = t_11:GetPlayerInfoId(val_29.UserId)

                        if v49 ~= nil then
                            if UnixTimestampMillis_3 >= v49.teleportAfter then
                                if not v49.teleported then
                                    v145 = v49.curGame

                                    if v145 ~= nil then
                                        v145 = t_19[v49.curGame]

                                        if not v145 then
                                            v145 = t_11:GetRunningGame(v49.curGame)
                                            t_19[v49.curGame] = v145
                                        end

                                        t_11.FoundGame:Fire(val_29.UserId, v49.curGame, v145)

                                        if t_16[v49.curGame] == nil then
                                            t_16[v49.curGame] = {}
                                        end

                                        table.insert(t_16[v49.curGame], val_29)
                                        t_17[val_29.UserId] = v49.ratingType
                                        t_18[val_29.UserId] = v49.map

                                        function v146(arg40) -- line: 1006
                                            if arg40 then
                                                arg40.teleported = true
                                            end

                                            return arg40
                                        end

                                        MATCHMAKINGSERVICE:UpdateAsync(val_29.UserId, v146, 7200)
                                    end
                                end
                            end
                        end
                    end
                end

                for key_30, val_30 in pairs(t_16) do
                    t_20 = {
                        gameCode = key_30,
                        ratingType = t_17[val_30[1].UserId],
                        customData = {}
                    }
                    v49 = t_19[key_30]

                    if t_11.ApplyCustomTeleportData ~= nil then
                        for _, val_31 in ipairs(val_30) do
                            t_20.customData[val_31.UserId] = t_11.ApplyCustomTeleportData(
                                val_31,
                                v49
                            )
                        end
                    end

                    if t_11.ApplyGeneralTeleportData ~= nil then
                        t_20.gameData = t_11.ApplyGeneralTeleportData(v49)
                    end

                    MATCHMAKINGSERVICETELEPORTDATA:SetAsync(key_30, t_20, 86400)
                    local v49 = t_11.GamePlaceIds[t_18[val_30[1].UserId]]

                    function teleportPlayers(arg41, arg42) -- line: 1035
                        -- upvalues:
                        --  [1] key_30 (copy)
                        --  [2] ServerStorage (ref)
                        --  [3] TeleportModule_m (ref)
                        --  [4] v49 (copy)

                        if key_30 == "TEST" then
                            return
                        end

                        print("Attempting to teleport:", unpack(arg41))
                        local _ = unpack(arg41)

                        for _, val_32 in pairs(arg41) do
                            pcall(function() -- line: 1040
                                -- upvalues:
                                --  [1] val_32 (copy)
                                --  [2] ServerStorage (ref)

                                val_32:AddTag("InLimbo")
                                _G.ClearCombatTag(val_32)

                                if val_32.Character then
                                    val_32.Character.Parent = ServerStorage
                                end
                            end)
                        end

                        TeleportModule_m.teleportWithRetry(v49, arg41, arg42)
                    end

                    TeleportOptions = Instance.new("TeleportOptions")
                    TeleportOptions.ReservedServerAccessCode = key_30
                    _, Result_5 = pcall(teleportPlayers, val_30, TeleportOptions)

                    if Result_5 then
                        warn(Result_5)
                    end
                end
            else
                t_16 = {}
                t_17 = {}
                t_18 = {}
                t_19 = {}

                for _, val_33 in ipairs(Players:GetPlayers()) do
                    v49 = val_33:GetAttribute("MMS_QUEUED")

                    if v49 then
                        v49 = t_11:GetPlayerInfoId(val_33.UserId)

                        if v49 ~= nil then
                            if UnixTimestampMillis_3 >= v49.teleportAfter then
                                if not v49.teleported then
                                    v145 = v49.curGame

                                    if v145 ~= nil then
                                        v145 = t_19[v49.curGame]

                                        if not v145 then
                                            v145 = t_11:GetRunningGame(v49.curGame)
                                            t_19[v49.curGame] = v145
                                        end

                                        t_11.FoundGame:Fire(val_33.UserId, v49.curGame, v145)

                                        if t_16[v49.curGame] == nil then
                                            t_16[v49.curGame] = {}
                                        end

                                        table.insert(t_16[v49.curGame], val_33)
                                        t_17[val_33.UserId] = v49.ratingType
                                        t_18[val_33.UserId] = v49.map

                                        function v146(arg43) -- line: 1006
                                            if arg43 then
                                                arg43.teleported = true
                                            end

                                            return arg43
                                        end

                                        MATCHMAKINGSERVICE:UpdateAsync(val_33.UserId, v146, 7200)
                                    end
                                end
                            end
                        end
                    end
                end

                for key_34, val_34 in pairs(t_16) do
                    t_20 = {
                        gameCode = key_34,
                        ratingType = t_17[val_34[1].UserId],
                        customData = {}
                    }
                    v49 = t_19[key_34]

                    if t_11.ApplyCustomTeleportData ~= nil then
                        for _, val_35 in ipairs(val_34) do
                            t_20.customData[val_35.UserId] = t_11.ApplyCustomTeleportData(
                                val_35,
                                v49
                            )
                        end
                    end

                    if t_11.ApplyGeneralTeleportData ~= nil then
                        t_20.gameData = t_11.ApplyGeneralTeleportData(v49)
                    end

                    MATCHMAKINGSERVICETELEPORTDATA:SetAsync(key_34, t_20, 86400)
                    local v49 = t_11.GamePlaceIds[t_18[val_34[1].UserId]]

                    function teleportPlayers(arg44, arg45) -- line: 1035
                        -- upvalues:
                        --  [1] key_30 (copy)
                        --  [2] ServerStorage (ref)
                        --  [3] TeleportModule_m (ref)
                        --  [4] v49 (copy)

                        if key_30 == "TEST" then
                            return
                        end

                        print("Attempting to teleport:", unpack(arg44))
                        local _ = unpack(arg44)

                        for _, val_36 in pairs(arg44) do
                            pcall(function() -- line: 1040
                                -- upvalues:
                                --  [1] val_36 (copy)
                                --  [2] ServerStorage (ref)

                                val_36:AddTag("InLimbo")
                                _G.ClearCombatTag(val_36)

                                if val_36.Character then
                                    val_36.Character.Parent = ServerStorage
                                end
                            end)
                        end

                        TeleportModule_m.teleportWithRetry(v49, arg44, arg45)
                    end

                    TeleportOptions = Instance.new("TeleportOptions")
                    TeleportOptions.ReservedServerAccessCode = key_34
                    _, Result_5 = pcall(teleportPlayers, val_34, TeleportOptions)

                    if Result_5 then
                        warn(Result_5)
                    end
                end
            end
        end
    end)

    return t_11
end

function t_4.GetCurrentGameCode(arg46) -- line: 1066
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] MATCHMAKINGSERVICE (copy)

    if not arg46.IsGameServer or not game.PrivateServerId then
        return nil
    end

    if not v5 then
        v5 = MATCHMAKINGSERVICE:GetAsync(game.PrivateServerId)
    end

    return v5
end

function t_4.GetGameData(t15: table, s5: string) -- line: 1081
    -- upvalues:
    --  [1] MATCHMAKINGSERVICETELEPORTDATA (copy)

    local t_21 = {}

    if not s5 then
        if not t15.IsGameServer then
            return nil
        end

        s5 = t15:GetCurrentGameCode()
    end

    local v151 = MATCHMAKINGSERVICETELEPORTDATA:GetAsync(s5)

    if not v151 then
        return nil
    end

    t_21.gameCode = v151.gameCode
    t_21.ratingType = v151.ratingType

    if v151.gameData then
        for key_37, val_37 in pairs(v151.gameData) do
            t_21[key_37] = val_37
        end
    end

    return t_21
end

function t_4.GetUserDataId(_: table, n8: number) -- line: 1107
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] MATCHMAKINGSERVICETELEPORTDATA (copy)

    local v152 = t_4:GetPlayerInfoId(n8)

    if not v152 or not v152.curGame then
        return nil
    end

    local v153 = MATCHMAKINGSERVICETELEPORTDATA:GetAsync(v152.curGame)

    if not v153 or not v153.customData then
        return nil
    end

    return v153.customData[tostring(n8)]
end

function t_4.GetUserData(_: table, u2: userdata) -- line: 1123
    -- upvalues:
    --  [1] t_4 (copy)

    return t_4:GetUserDataId(u2.UserId)
end

function t_4.ToRatingNumber(_, arg48) -- line: 1130
    -- upvalues:
    --  [1] OpenSkill_m (copy)

    return OpenSkill_m.Ordinal(arg48)
end

function t_4.GetPlayerRatingId(t18: table, n9: number, s6: string) -- line: 1140
    -- upvalues:
    --  [1] MATCHMAKINGSERVICESKILLS (copy)
    --  [2] OpenSkill_m (copy)

    if t18.Options.DisableRatingSystem then
        return nil
    end

    local v156 = MATCHMAKINGSERVICESKILLS:GetAsync(s6 .. "__" .. tostring(n9))

    if not v156 then
        local v157 = OpenSkill_m.Rating(t18.StartingMean, t18.StartingStandardDeviation)
        MATCHMAKINGSERVICESKILLS:SetAsync(s6 .. "__" .. tostring(n9), v157, { n9 })
        v156 = v157
    end

    return v156
end

function t_4.GetPlayerRating(t19: table, u3: userdata, s7: string) -- line: 1157
    return t19:GetPlayerRatingId(u3.UserId, s7)
end

function t_4.SetPlayerRatingId(t20: table, n10: number, s8: string, t21: table) -- line: 1167
    -- upvalues:
    --  [1] MATCHMAKINGSERVICESKILLS (copy)

    if t20.Options.DisableRatingSystem then
        return nil
    end

    MATCHMAKINGSERVICESKILLS:SetAsync(s8 .. "__" .. tostring(n10), t21, { n10 })
end

function t_4.SetPlayerRating(t22: table, u4: userdata, s9: string, t23: table) -- line: 1178
    t22:SetPlayerRatingId(u4.UserId, s9, t23)
end

function t_4.ClearPlayerInfoId(_: table, n11: number) -- line: 1184
    -- upvalues:
    --  [1] MATCHMAKINGSERVICE (copy)

    MATCHMAKINGSERVICE:RemoveAsync(n11)
end

function t_4.ClearPlayerInfo(t25: table, u5: userdata) -- line: 1190
    t25:ClearPlayerInfoId(u5.UserId)
end

function t_4.SetPlayerInfoId(
    t26: table,
    n12: number,
    s10: string,
    s11: string,
    t27: table,
    s12: string,
    n13: number
) -- line: 1210
    -- upvalues:
    --  [1] MATCHMAKINGSERVICE (copy)

    if t26.Options.DisableRatingSystem then
        s11 = "MMS_RatingDisabled"
    end

    MATCHMAKINGSERVICE:SetAsync(
        n12,
        {
            curGame = s10,
            teleported = false,
            ratingType = s11,
            party = t27,
            map = s12,
            teleportAfter = n13 or 0
        },
        7200
    )
end

function t_4.SetPlayerInfo(
    t28: table,
    u6: userdata,
    s13: string,
    s14: string,
    t29: table,
    s15: string,
    n14: number
) -- line: 1229
    t28:SetPlayerInfoId(
        u6.UserId,
        s13,
        s14,
        t29,
        s15,
        n14
    )
end

function t_4.GetPlayerInfoId(_: table, n15: number) -- line: 1236
    -- upvalues:
    --  [1] MATCHMAKINGSERVICE (copy)

    return getFromMemory(MATCHMAKINGSERVICE, n15, 3)
end

function t_4.IsQueuedHere(_: table, n16: number) -- line: 1241
    -- upvalues:
    --  [1] t_3 (copy)

    return t_3[n16] == true
end

function t_4.GetPlayerInfo(t32: table, u7: userdata) -- line: 1248
    return t32:GetPlayerInfoId(u7.UserId)
end

function t_4.GetQueueCounts(arg49) -- line: 1254
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEQUEUE (copy)

    local t_23 = {}
    local v163 = getFromMemory(MATCHMAKINGSERVICEQUEUE, "QueuedMaps", 3)

    if v163 == nil then
        return
    end

    local v164 = 0

    for _, val_38 in ipairs(v163) do
        t_23[val_38] = {}
        local v165 = arg49:GetQueue(val_38)

        if v165 ~= nil then
            for key_39, val_39 in pairs(v165) do
                t_23[val_38][key_39] = {}

                for _, val_40 in pairs(val_39) do
                    for key_41, val_41 in pairs(val_40) do
                        local v166 = #val_41
                        t_23[val_38][key_39][key_41] = v166
                        v164 += v166
                    end
                end
            end
        end
    end

    return t_23, v164
end

function t_4.GetJoinableGames(_) -- line: 1281
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)

    local Key_1 = nil
    local t_24 = {}

    repeat
        local v168 = MATCHMAKINGSERVICEJOINABLEGAMES:GetRangeAsync(
            Enum.SortDirection.Ascending,
            200,
            Key_1
        )

        if #v168 == 0 then
            break
        end

        Key_1 = v168[#v168].key

        for _, val_42 in ipairs(v168) do
            table.insert(t_24, val_42)
        end
    until #v168 < 200

    return t_24
end

function t_4.GetNonJoinableGames(_) -- line: 1305
    -- upvalues:
    --  [1] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)

    local Key_2 = nil
    local t_25 = {}

    repeat
        local v170 = MATCHMAKINGSERVICENONJOINABLEGAMES:GetRangeAsync(
            Enum.SortDirection.Ascending,
            200,
            Key_2
        )

        if #v170 == 0 then
            break
        end

        Key_2 = v170[#v170].key

        for _, val_43 in ipairs(v170) do
            table.insert(t_25, val_43)
        end
    until #v170 < 200

    return t_25
end

function t_4.GetAllRunningGames(_) -- line: 1330
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [2] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)

    local Key_3 = nil
    local t_26 = {}

    repeat
        local v172 = MATCHMAKINGSERVICEJOINABLEGAMES:GetRangeAsync(
            Enum.SortDirection.Ascending,
            200,
            Key_3
        )

        if #v172 == 0 then
            break
        end

        Key_3 = v172[#v172].key

        for _, val_44 in ipairs(v172) do
            table.insert(t_26, val_44)
        end
    until #v172 < 200

    repeat
        local v173 = MATCHMAKINGSERVICENONJOINABLEGAMES:GetRangeAsync(
            Enum.SortDirection.Ascending,
            200,
            Key_3
        )

        if #v173 == 0 then
            break
        end

        Key_3 = v173[#v173].key

        for _, val_45 in ipairs(v173) do
            table.insert(t_26, val_45)
        end
    until #v173 < 200

    return t_26
end

function t_4.GetJoinableGamesFiltered(_: table, n17: number, f1: (...any) -> ...any) -- line: 1372
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)

    local Key_4 = nil
    local v175 = false
    local t_27 = {}

    repeat
        local v176 = MATCHMAKINGSERVICEJOINABLEGAMES:GetRangeAsync(
            Enum.SortDirection.Ascending,
            if not (n17 > 200) then n17 else 200,
            Key_4
        )

        if #v176 == 0 then
            break
        end

        Key_4 = v176[#v176].key

        if if not (n17 <= 200) then n17 > 200 and #v176 < 200 else n17 >= #v176 or n17 > 200 and #v176 < 200 then
            v175 = true
        end

        if f1 then
            for index_15 = #v176, 1, -1 do
                if not f1(v176[index_15].value) then
                    table.remove(v176, index_15)
                end
            end
        end

        for _, val_46 in ipairs(v176) do
            table.insert(t_27, val_46)

            if #t_27 == n17 then
                v175 = true
                break
            end
        end
    until #t_27 == n17 or v175

    return t_27
end

function t_4.GetNonJoinableGamesFiltered(_: table, n18: number, f2: (...any) -> ...any) -- line: 1411
    -- upvalues:
    --  [1] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)

    local Key_5 = nil
    local v179 = false
    local t_28 = {}

    repeat
        local v180 = MATCHMAKINGSERVICENONJOINABLEGAMES:GetRangeAsync(
            Enum.SortDirection.Ascending,
            if not (n18 > 200) then n18 else 200,
            Key_5
        )

        if #v180 == 0 then
            break
        end

        Key_5 = v180[#v180].key

        if if not (n18 <= 200) then n18 > 200 and #v180 < 200 else n18 >= #v180 or n18 > 200 and #v180 < 200 then
            v179 = true
        end

        if f2 then
            for index_16 = #v180, 1, -1 do
                if not f2(v180[index_16].value) then
                    table.remove(v180, index_16)
                end
            end
        end

        for _, val_47 in ipairs(v180) do
            table.insert(t_28, val_47)

            if #t_28 == n18 then
                v179 = true
                break
            end
        end
    until #t_28 == n18 or v179

    return t_28
end

function t_4.GetRunningGame(t35: table, s16: string) -- line: 1449
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [2] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)

    if not s16 then
        if not t35.IsGameServer then
            return nil
        end

        s16 = t35:GetCurrentGameCode()
    end

    local v182 = getFromMemory(MATCHMAKINGSERVICEJOINABLEGAMES, s16, 2) or getFromMemory(
        MATCHMAKINGSERVICENONJOINABLEGAMES,
        s16,
        2
    )

    if typeof(v182) == "table" then
        return v182
    end

    return nil
end

function t_4.GetQueue(_: table, s17: string) -- line: 1461
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEQUEUE (copy)

    local v183 = getFromMemory(MATCHMAKINGSERVICEQUEUE, s17 .. "__QueuedRatingTypes", 3)

    if v183 == nil then
        return nil
    end

    local t_29 = {}

    for key_48, val_48 in pairs(v183) do
        t_29[key_48] = {}

        for _, val_49 in ipairs(val_48) do
            t_29[key_48][val_49[1]] = getFromMemory(
                MATCHMAKINGSERVICEQUEUE,
                s17 .. "__" .. key_48 .. "__" .. val_49[1],
                3
            )
        end
    end

    return t_29
end

function t_4.QueuePlayerId(
    t37: table,
    n19: number,
    s18: string,
    s19: string,
    s20: string
) -- line: 1479
    -- upvalues:
    --  [1] OpenSkill_m (copy)
    --  [2] MATCHMAKINGSERVICEQUEUE (copy)
    --  [3] t_3 (copy)
    --  [4] Players (copy)
    --  [5] t_2 (copy)
    --  [6] t (copy)
    --  [7] t_1 (copy)

    local v186 = 0
    local UnixTimestampMillis_4 = DateTime.now().UnixTimestampMillis

    if t37.Options.DisableRatingSystem then
        s18 = "MMS_RatingDisabled"
    else
        v186 = roundSkill(OpenSkill_m.Ordinal((t37:GetPlayerRatingId(n19, s18))))
    end

    local str_3 = tostring(v186)

    if s20 == nil then
        s20 = "MMS_NO_ROLE"
    end

    local v188 = nil
    local v190 = nil

    if not pcall(function() -- line: 1499
        -- upvalues:
        --  [1] v188 (ref)
        --  [2] MATCHMAKINGSERVICEQUEUE (ref)
        --  [3] s19 (copy)
        --  [4] s18 (ref)
        --  [5] str_3 (copy)
        --  [6] s20 (ref)
        --  [7] n19 (copy)
        --  [8] UnixTimestampMillis_4 (copy)

        v188 = MATCHMAKINGSERVICEQUEUE:UpdateAsync(s19 .. "__" .. s18 .. "__" .. str_3, function(
            arg53
        ) -- line: 1500
            -- upvalues:
            --  [1] s20 (ref)
            --  [2] n19 (ref)
            --  [3] UnixTimestampMillis_4 (ref)

            if arg53 == nil then
                return { [s20] = { { n19, UnixTimestampMillis_4 } } }
            end

            if arg53[s20] ~= nil then
                table.insert(arg53[s20], { n19, UnixTimestampMillis_4 })

                return arg53
            end

            arg53[s20] = { { n19, UnixTimestampMillis_4 } }

            return arg53
        end, 86400)
    end) then
        print("Unable to queue player:")
        warn(v190)
    end

    updateQueue(s19, s18, str_3, s20)
    v190 = false
    local _ = pcall(function() -- line: 1499
        -- upvalues:
        --  [1] v188 (ref)
        --  [2] MATCHMAKINGSERVICEQUEUE (ref)
        --  [3] s19 (copy)
        --  [4] s18 (ref)
        --  [5] str_3 (copy)
        --  [6] s20 (ref)
        --  [7] n19 (copy)
        --  [8] UnixTimestampMillis_4 (copy)

        v188 = MATCHMAKINGSERVICEQUEUE:UpdateAsync(s19 .. "__" .. s18 .. "__" .. str_3, function(
            arg53
        ) -- line: 1500
            -- upvalues:
            --  [1] s20 (ref)
            --  [2] n19 (ref)
            --  [3] UnixTimestampMillis_4 (ref)

            if arg53 == nil then
                return { [s20] = { { n19, UnixTimestampMillis_4 } } }
            end

            if arg53[s20] ~= nil then
                table.insert(arg53[s20], { n19, UnixTimestampMillis_4 })

                return arg53
            end

            arg53[s20] = { { n19, UnixTimestampMillis_4 } }

            return arg53
        end, 86400)
    end)

    if v188 ~= nil then
        v190 = if find(v188[s20], function(arg54) -- line: 1522
            -- upvalues:
            --  [1] n19 (copy)

            return arg54[1] == n19
        end) == nil then false else true
    end

    if v190 then
        t_3[n19] = true
    end

    if v190 and not t37.Options.DisableGlobalEvents then
        local v192 = if not t37.Options.DisableRatingSystem then v186 else nil
        t37.PlayerAddedToQueue:Fire(
            n19,
            s19,
            s18,
            v192,
            s20
        )
        local v193 = Players:GetPlayerByUserId(n19)

        if v193 then
            v193:SetAttribute("MMS_QUEUED", true)
        end

        if table.find(t_2, n19) == nil then
            if find(t, function(arg55) -- line: 1536
                -- upvalues:
                --  [1] n19 (copy)

                return arg55[1] == n19
            end) == nil then
                local v195 = if not t37.Options.DisableRatingSystem then v186 else nil
                table.insert(t, { n19, s19, s18, v195, s20 })
            end

            table.insert(t_2, n19)
        end

        local v197 = find(t_1, function(arg56) -- line: 1545
            -- upvalues:
            --  [1] n19 (copy)

            return arg56[1] == n19
        end)
        local _ = find(t, function(arg55) -- line: 1536
            -- upvalues:
            --  [1] n19 (copy)

            return arg55[1] == n19
        end)

        if v197 ~= nil then
            table.remove(t_1, v197)
        end
    end

    return v190
end

function t_4.QueuePlayer(
    t38: table,
    u8: userdata,
    s21: string,
    s22: string,
    s23: string
) -- line: 1561
    return t38:QueuePlayerId(u8.UserId, s21, s22, s23)
end

function t_4.QueuePartyId(
    t39: table,
    t40: table,
    s24: string,
    s25: string,
    s26: string
) -- line: 1570
    -- upvalues:
    --  [1] OpenSkill_m (copy)
    --  [2] MATCHMAKINGSERVICEQUEUE (copy)
    --  [3] MATCHMAKINGSERVICE (copy)
    --  [4] t_3 (copy)
    --  [5] Players (copy)
    --  [6] t_2 (copy)
    --  [7] t (copy)
    --  [8] t_1 (copy)

    local _
    local UnixTimestampMillis_5 = DateTime.now().UnixTimestampMillis
    local _ = nil
    local v200 = 0
    local v205

    if t39.Options.DisableRatingSystem then
        s24 = "MMS_RatingDisabled"
    else
        local t_31 = {}

        for _, val_50 in ipairs(t40) do
            t_31[val_50] = t39:GetPlayerRatingId(val_50, s24)

            if any(t_31, function(arg57) -- line: 1580
                -- upvalues:
                --  [1] OpenSkill_m (ref)
                --  [2] t_31 (ref)
                --  [3] val_50 (copy)
                --  [4] t39 (copy)

                local v202 = OpenSkill_m.Ordinal(t_31[val_50])

                return math.abs(v202 - OpenSkill_m.Ordinal(arg57)) > t39.MaxPartySkillGap and true
            end) then
                return false, val_50, "Rating disparity too high"
            end

            v205 = v200 + OpenSkill_m.Ordinal(t_31[val_50])
        end

        v205 /= dictlen(t_31)
    end

    local v206 = roundSkill(v205)
    v205 = tostring(v206)
    local v207

    if s26 == nil then
        v207 = "MMS_NO_ROLE"
    end

    local v208 = nil
    local t_32 = {}

    for key_51, val_51 in ipairs(t40) do
        table.insert(t_32, { val_51, UnixTimestampMillis_5, #t40 - key_51 })
    end

    local Result_6 = nil

    if not pcall(function() -- line: 1607
        -- upvalues:
        --  [1] v208 (ref)
        --  [2] MATCHMAKINGSERVICEQUEUE (ref)
        --  [3] s25 (copy)
        --  [4] s24 (ref)
        --  [5] v205 (copy)
        --  [6] v207 (ref)
        --  [7] t_32 (copy)

        v208 = MATCHMAKINGSERVICEQUEUE:UpdateAsync(s25 .. "__" .. s24 .. "__" .. v205, function(
            arg58
        ) -- line: 1608
            -- upvalues:
            --  [1] v207 (ref)
            --  [2] t_32 (ref)

            if arg58 == nil then
                arg58 = { [v207] = {} }
            elseif arg58[v207] == nil then
                arg58[v207] = {}
            end

            for _, val_52 in ipairs(t_32) do
                table.insert(arg58[v207], val_52)
            end

            return arg58
        end, 86400)
    end) then
        print("Unable to queue party:")
        warn(Result_6)
    end

    local t_35 = {}

    for _, val_53 in ipairs(t40) do
        t_35[val_53] = t40
    end

    local Success_8, Result_7 = pcall(function() -- line: 1634
        -- upvalues:
        --  [1] MATCHMAKINGSERVICE (ref)
        --  [2] t_35 (copy)

        MATCHMAKINGSERVICE:UpdateAsync("QueuedParties", function(arg59) -- line: 1635
            -- upvalues:
            --  [1] t_35 (ref)

            if arg59 == nil then
                arg59 = {}
            end

            for key_54, val_54 in pairs(t_35) do
                arg59[key_54] = val_54
            end

            return arg59
        end, 86400)
    end)

    if not Success_8 then
        print("Unable to update Queued Parties:")
        warn(Result_7)
    end

    updateQueue(s25, s24, v205)

    for _, val_55 in ipairs(t40) do
        if find(v208[v207], function(arg60) -- line: 1652
            -- upvalues:
            --  [1] val_55 (copy)

            return arg60[1] == val_55
        end) == nil then
            t39:RemovePlayersFromQueueId(t40)

            return false, val_55, "Player not added to queue"
        end
    end

    for _, val_56 in ipairs(t40) do
        t_3[val_56] = true
        local v216 = if not t39.Options.DisableRatingSystem then v206 else nil
        t39.PlayerAddedToQueue:Fire(val_56, s25, s24, v216)
        local v217 = Players:GetPlayerByUserId(val_56)
        local _ = t39.Options.DisableRatingSystem

        if v217 then
            v217:SetAttribute("MMS_QUEUED", true)
        end

        if not t39.Options.DisableGlobalEvents then
            if table.find(t_2, val_56) == nil then
                if find(t, function(arg61) -- line: 1669
                    -- upvalues:
                    --  [1] val_56 (copy)

                    return arg61[1] == val_56
                end) == nil then
                    local v219 = if not t39.Options.DisableRatingSystem then v206 else nil
                    table.insert(t, { val_56, s25, s24, v219 })
                end

                table.insert(t_2, val_56)
            end

            local v221 = find(t_1, function(arg62) -- line: 1678
                -- upvalues:
                --  [1] val_56 (copy)

                return arg62[1] == val_56
            end)
            local _ = find(t, function(arg61) -- line: 1669
                -- upvalues:
                --  [1] val_56 (copy)

                return arg61[1] == val_56
            end)

            if v221 ~= nil then
                table.remove(t_1, v221)
            end
        end
    end

    return true
end

function t_4.QueueParty(
    t41: table,
    t42: table,
    s27: string,
    s28: string,
    s29: string
) -- line: 1695
    return t41:QueuePartyId(tableSelect(t42, "UserId"), s27, s28, s29)
end

function t_4.GetPlayerPartyId(t43: table, n20: number) -- line: 1702
    -- upvalues:
    --  [1] MATCHMAKINGSERVICE (copy)

    local v224 = getFromMemory(MATCHMAKINGSERVICE, "QueuedParties", 3)

    if v224 == nil or v224[n20] == nil then
        local v225 = t43:GetPlayerInfo(n20)

        for key_57, val_57 in pairs(v225) do
            print(key_57, val_57)
        end

        if v225 then
            return v225.party
        end

        return nil
    end

    return v224[n20]
end

function t_4.GetPlayerParty(t44: table, u9: userdata) -- line: 1718
    return t44:GetPlayerPartyId(u9)
end

function t_4.RemovePlayerFromQueueId(t45: table, n21: number, b4: boolean) -- line: 1726
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] MATCHMAKINGSERVICEQUEUE (copy)
    --  [3] Players (copy)
    --  [4] t_2 (copy)
    --  [5] t_1 (copy)
    --  [6] t (copy)
    --  [7] MATCHMAKINGSERVICE (copy)

    local _, _, _
    local t_36 = {}
    local _ = false
    local _ = nil
    local _ = nil

    if b4 == nil then
        b4 = true
    end

    t_3[n21] = nil
    local v232 = getFromMemory(MATCHMAKINGSERVICEQUEUE, "QueuedMaps", 3)

    if v232 == nil then
        return
    end

    local v253

    for _, val_58 in ipairs(v232) do
        local v233 = t45:GetQueue(val_58)

        if v233 == nil then
            MATCHMAKINGSERVICEQUEUE:UpdateAsync("QueuedMaps", function(arg63) -- line: 1744
                -- upvalues:
                --  [1] val_58 (copy)

                if arg63 == nil then
                    return nil
                end

                local v235 = table.find(arg63, val_58)

                if v235 == nil then
                    return nil
                end

                table.remove(arg63, v235)

                return arg63
            end, 86400)
        else
            for key_59, val_59 in pairs(v233) do
                for key_60, val_60 in pairs(val_59) do
                    for key_61, val_61 in pairs(val_60) do
                        if find(val_61, function(arg64) -- line: 1756
                            -- upvalues:
                            --  [1] n21 (copy)

                            return arg64[1] == n21
                        end) then
                            local Result_8 = nil

                            if not pcall(function() -- line: 1757
                                -- upvalues:
                                --  [1] MATCHMAKINGSERVICEQUEUE (ref)
                                --  [2] val_58 (copy)
                                --  [3] key_59 (copy)
                                --  [4] key_60 (copy)
                                --  [5] key_61 (copy)
                                --  [6] n21 (copy)
                                --  [7] t_36 (copy)
                                --  [8] t45 (copy)
                                --  [9] b4 (ref)
                                --  [10] Players (ref)
                                --  [11] t_2 (ref)
                                --  [12] t_1 (ref)
                                --  [13] t (ref)

                                MATCHMAKINGSERVICEQUEUE:UpdateAsync(val_58 .. "__" .. key_59 .. "__" .. key_60, function(
                                    arg65
                                ) -- line: 1758
                                    -- upvalues:
                                    --  [1] key_61 (ref)
                                    --  [2] n21 (ref)
                                    --  [3] t_36 (ref)
                                    --  [4] val_58 (ref)
                                    --  [5] key_59 (ref)
                                    --  [6] key_60 (ref)
                                    --  [7] t45 (ref)
                                    --  [8] b4 (ref)
                                    --  [9] Players (ref)
                                    --  [10] t_2 (ref)
                                    --  [11] t_1 (ref)
                                    --  [12] t (ref)

                                    if arg65 == nil then
                                        return nil
                                    end

                                    local v241 = find(arg65[key_61], function(arg66) -- line: 1760
                                        -- upvalues:
                                        --  [1] n21 (ref)

                                        return arg66[1] == n21
                                    end)

                                    if v241 == nil then
                                        return nil
                                    end

                                    table.remove(arg65[key_61], v241)

                                    if #arg65[key_61] == 0 then
                                        arg65[key_61] = nil
                                    end

                                    if next(arg65) == nil then
                                        table.insert(
                                            t_36,
                                            val_58 .. "__" .. key_59 .. "__" .. key_60
                                        )
                                    end

                                    t45.PlayerRemovedFromQueue:Fire(
                                        n21,
                                        val_58,
                                        key_59,
                                        tonumber(key_60),
                                        key_61
                                    )

                                    if b4 then
                                        local v245 = Players:GetPlayerByUserId(n21)

                                        if v245 then
                                            v245:SetAttribute("MMS_QUEUED", false)
                                        end
                                    end

                                    if not t45.Options.DisableGlobalEvents then
                                        if table.find(t_2, n21) == nil then
                                            if find(t_1, function(arg67) -- line: 1781
                                                -- upvalues:
                                                --  [1] n21 (ref)

                                                return arg67[1] == n21
                                            end) == nil then
                                                table.insert(
                                                    t_1,
                                                    {
                                                        n21,
                                                        val_58,
                                                        key_59,
                                                        tonumber(key_60),
                                                        key_61
                                                    }
                                                )
                                            end

                                            table.insert(t_2, n21)
                                        end

                                        local v252 = find(t, function(arg68) -- line: 1790
                                            -- upvalues:
                                            --  [1] n21 (ref)

                                            return arg68[1] == n21
                                        end)

                                        if v252 ~= nil then
                                            table.remove(t, v252)
                                        end
                                    end

                                    return arg65
                                end, 86400)
                            end) then
                                v253 = true
                                print("Unable to remove player from queue:")
                                warn(Result_8)
                            end
                        end
                    end
                end
            end
        end
    end

    local Success_9, Result_9 = pcall(function() -- line: 1813
        -- upvalues:
        --  [1] MATCHMAKINGSERVICE (ref)
        --  [2] n21 (copy)

        MATCHMAKINGSERVICE:UpdateAsync("QueuedParties", function(arg69) -- line: 1814
            -- upvalues:
            --  [1] n21 (ref)

            if arg69 == nil then
                return nil
            end

            arg69[n21] = nil

            return arg69
        end, 86400)
    end)

    if not Success_9 then
        print("Unable to update Queued Parties:")
        warn(Result_9)
    end

    for index_17 = #t_36, 1, -1 do
        local v254 = t_36[index_17]
        MATCHMAKINGSERVICEQUEUE:RemoveAsync(v254)
        local v255, v256, v257 = table.unpack(string.split(v254, "__"))
        MATCHMAKINGSERVICEQUEUE:UpdateAsync(v255 .. "__QueuedRatingTypes", function(arg70) -- line: 1831
            -- upvalues:
            --  [1] v256 (copy)
            --  [2] v257 (copy)
            --  [3] t_36 (copy)
            --  [4] v255 (copy)

            if arg70 == nil then
                return nil
            end

            if arg70[v256] ~= nil then
                local v260 = find(arg70, function(arg71) -- line: 1835
                    -- upvalues:
                    --  [1] v257 (ref)

                    return arg71[1] == v257
                end)

                if v260 ~= nil then
                    table.remove(arg70[v256], v260)
                end

                if #arg70[v256] == 0 then
                    arg70[v256] = nil
                end

                if dictlen(arg70) == 0 then
                    table.insert(t_36, v255 .. "__QueuedRatingTypes")
                end
            end

            return arg70
        end, 86400)

        if not Success_9 then
            v253 = true
            print("Unable to update Queued Rating Types:")
            warn(Result_9)
        end

        table.remove(t_36, index_17)
    end

    for index_18 = #t_36, 1, -1 do
        local v261 = t_36[index_18]
        MATCHMAKINGSERVICEQUEUE:RemoveAsync(v261)
        local v262 = table.unpack(string.split(v261, "__"))
        MATCHMAKINGSERVICEQUEUE:UpdateAsync("QueuedMaps", function(arg72) -- line: 1862
            -- upvalues:
            --  [1] v262 (copy)

            if arg72 == nil then
                return nil
            end

            local v263 = table.find(arg72, v262)

            if v263 ~= nil then
                table.remove(arg72, v263)
            end

            return arg72
        end, 86400)

        if not Success_9 then
            v253 = true
            print("Unable to update Queued Maps:")
            warn(Result_9)
        end

        table.remove(t_36, index_18)
    end

    return not v253
end

function t_4.RemovePlayerFromQueue(t46: table, u10: userdata, b5: boolean) -- line: 1888
    return t46:RemovePlayerFromQueueId(u10.UserId, b5)
end

function t_4.RemovePlayersFromQueueId(t47: table, t48: table, b6: boolean) -- line: 1895
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] MATCHMAKINGSERVICEQUEUE (copy)
    --  [3] Players (copy)
    --  [4] t_2 (copy)
    --  [5] t_1 (copy)
    --  [6] t (copy)
    --  [7] MATCHMAKINGSERVICE (copy)

    local _, _, _, _, _, _
    local t_38 = {}
    local _ = false
    local _ = nil
    local _ = nil

    if b6 == nil then
        b6 = true
    end

    for _, val_62 in t48 do
        t_3[val_62] = nil
    end

    local v272 = getFromMemory(MATCHMAKINGSERVICEQUEUE, "QueuedMaps", 3)

    if v272 == nil then
        return
    end

    local t_39 = {}
    local t_40 = {}

    for key_63, val_63 in ipairs(v272) do
        local v273 = t47:GetQueue(val_63)

        if v273 == nil then
            table.insert(t_40, key_63 - #t_40)
        else
            for key_64, val_64 in pairs(v273) do
                for key_65, val_65 in pairs(val_64) do
                    for _, val_66 in pairs(val_65) do
                        for _, val_67 in ipairs(t48) do
                            if find(val_66, function(arg73) -- line: 1925
                                -- upvalues:
                                --  [1] val_67 (copy)

                                return arg73[1] == val_67
                            end) then
                                if not t_39[val_63 .. "__" .. key_64 .. "__" .. key_65] then
                                    t_39[val_63 .. "__" .. key_64 .. "__" .. key_65] = {}
                                end

                                table.insert(
                                    t_39[val_63 .. "__" .. key_64 .. "__" .. key_65],
                                    val_67
                                )
                            end
                        end
                    end
                end
            end
        end
    end

    if #t_40 > 0 then
        for index_19 = #t_40, 1, -1 do
            table.remove(v272, index_19)
        end

        MATCHMAKINGSERVICEQUEUE:SetAsync("QueuedMaps", v272)
    end

    local v298

    for key_68, val_68 in pairs(t_39) do
        local Result_10 = nil

        if not pcall(function() -- line: 1945
            -- upvalues:
            --  [1] MATCHMAKINGSERVICEQUEUE (ref)
            --  [2] key_68 (copy)
            --  [3] val_68 (copy)
            --  [4] t47 (copy)
            --  [5] b6 (ref)
            --  [6] Players (ref)
            --  [7] t_2 (ref)
            --  [8] t_1 (ref)
            --  [9] t (ref)
            --  [10] t_38 (copy)

            MATCHMAKINGSERVICEQUEUE:UpdateAsync(key_68, function(arg74) -- line: 1946
                -- upvalues:
                --  [1] key_68 (ref)
                --  [2] val_68 (ref)
                --  [3] t47 (ref)
                --  [4] b6 (ref)
                --  [5] Players (ref)
                --  [6] t_2 (ref)
                --  [7] t_1 (ref)
                --  [8] t (ref)
                --  [9] t_38 (ref)

                if arg74 == nil then
                    return nil
                end

                local v288, v289, v290 = table.unpack(string.split(key_68, "__"))

                for _, val_69 in ipairs(val_68) do
                    for key_70, val_70 in pairs(arg74) do
                        local v292 = find(val_70, function(arg75) -- line: 1951
                            -- upvalues:
                            --  [1] val_69 (copy)

                            return arg75[1] == val_69
                        end)

                        if v292 ~= nil then
                            table.remove(val_70, v292)

                            if #val_70 == 0 then
                                arg74[key_70] = nil
                            end

                            t47.PlayerRemovedFromQueue:Fire(
                                val_69,
                                v288,
                                v289,
                                tonumber(v290),
                                key_70
                            )

                            if b6 then
                                local v293 = Players:GetPlayerByUserId(val_69)

                                if v293 then
                                    v293:SetAttribute("MMS_QUEUED", false)
                                end
                            end

                            if t47.Options.DisableGlobalEvents then
                                break
                            end

                            if table.find(t_2, val_69) == nil then
                                if find(t_1, function(arg76) -- line: 1968
                                    -- upvalues:
                                    --  [1] val_69 (copy)

                                    return arg76[1] == val_69
                                end) == nil then
                                    table.insert(
                                        t_1,
                                        { val_69, v288, v289, tonumber(v290), key_70 }
                                    )
                                end

                                table.insert(t_2, val_69)
                            end

                            local v297 = find(t, function(arg77) -- line: 1977
                                -- upvalues:
                                --  [1] val_69 (copy)

                                return arg77[1] == val_69
                            end)

                            if v297 == nil then
                                break
                            end

                            table.remove(t, v297)
                            break
                        end
                    end
                end

                if next(arg74) == nil then
                    table.insert(t_38, key_68)
                end

                return arg74
            end, 86400)
        end) then
            v298 = true
            print("Unable to remove player from queue:")
            warn(Result_10)
        end
    end

    local Success_10, Result_11 = pcall(function() -- line: 2004
        -- upvalues:
        --  [1] MATCHMAKINGSERVICE (ref)
        --  [2] t48 (copy)

        MATCHMAKINGSERVICE:UpdateAsync("QueuedParties", function(arg78) -- line: 2005
            -- upvalues:
            --  [1] t48 (ref)

            if arg78 == nil then
                return nil
            end

            for _, val_71 in ipairs(t48) do
                arg78[val_71] = nil
            end

            return arg78
        end, 86400)
    end)
    local _ = warn

    if not Success_10 then
        print("Unable to update Queued Parties:")
        warn(Result_11)
    end

    for index_20 = #t_38, 1, -1 do
        local v299 = t_38[index_20]
        MATCHMAKINGSERVICEQUEUE:RemoveAsync(v299)
        local key_68, v300, v301 = table.unpack(string.split(v299, "__"))
        MATCHMAKINGSERVICEQUEUE:UpdateAsync(key_68 .. "__QueuedRatingTypes", function(arg79) -- line: 2024
            -- upvalues:
            --  [1] v300 (copy)
            --  [2] v301 (copy)
            --  [3] t_38 (copy)
            --  [4] key_68 (copy)

            if arg79 == nil then
                return nil
            end

            if arg79[v300] ~= nil then
                local v304 = find(arg79, function(arg80) -- line: 2028
                    -- upvalues:
                    --  [1] v301 (ref)

                    return arg80[1] == v301
                end)

                if v304 ~= nil then
                    table.remove(arg79[v300], v304)
                end

                if #arg79[v300] == 0 then
                    arg79[v300] = nil
                end

                if dictlen(arg79) == 0 then
                    table.insert(t_38, key_68 .. "__QueuedRatingTypes")
                end
            end

            return arg79
        end, 86400)

        if not Success_10 then
            v298 = true
            print("Unable to update Queued Rating Types:")
            warn(Result_11)
        end

        table.remove(t_38, index_20)
    end

    local v306

    for index_21 = #t_38, 1, -1 do
        local v305 = t_38[index_21]
        MATCHMAKINGSERVICEQUEUE:RemoveAsync(v305)
        v306 = table.unpack(string.split(v305, "__"))
        MATCHMAKINGSERVICEQUEUE:UpdateAsync("QueuedMaps", function(arg81) -- line: 2055
            -- upvalues:
            --  [1] v306 (copy)

            if arg81 == nil then
                return nil
            end

            local v307 = table.find(arg81, v306)

            if v307 ~= nil then
                table.remove(arg81, v307)
            end

            return arg81
        end, 86400)

        if not Success_10 then
            v298 = true
            print("Unable to update Queued Maps:")
            warn(Result_11)
        end

        table.remove(t_38, index_21)
    end

    return not v298
end

function t_4.RemovePlayersFromQueue(t49: table, t50: table, b7: boolean) -- line: 2081
    return t49:RemovePlayersFromQueueId(tableSelect(t50, "UserId"), b7)
end

function t_4.AddPlayerToGameId(
    t51: table,
    n22: number,
    s30: string,
    b8: boolean,
    s31: string
) -- line: 2090
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [2] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)

    if b8 == nil then
        b8 = true
    end

    if s31 == nil then
        s31 = "MMS_NO_ROLE"
    end

    local v309 = false
    local v310 = false
    local v311 = nil
    local Success_11, Result_12 = pcall(function() -- line: 2098
        -- upvalues:
        --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
        --  [2] s30 (copy)
        --  [3] s31 (ref)
        --  [4] n22 (copy)
        --  [5] t51 (copy)
        --  [6] b8 (ref)
        --  [7] v310 (ref)
        --  [8] v311 (ref)

        MATCHMAKINGSERVICEJOINABLEGAMES:UpdateAsync(s30, function(arg82) -- line: 2099
            -- upvalues:
            --  [1] s31 (ref)
            --  [2] n22 (ref)
            --  [3] t51 (ref)
            --  [4] b8 (ref)
            --  [5] v310 (ref)
            --  [6] v311 (ref)

            if arg82 ~= nil then
                if arg82.players[s31] == nil then
                    arg82.players[s31] = {}
                end

                table.insert(arg82.players[s31], n22)

                for key_72, val_72 in pairs(t51.PlayerRanges[arg82.map]) do
                    local Full_1 = arg82.full
                    local v312 = arg82.players[key_72] and #arg82.players[key_72] >= val_72.Max
                    Full_1[key_72] = v312
                end

                if b8 then
                    local v313 = true

                    for _, val_73 in pairs(arg82.full) do
                        if not val_73 then
                            v313 = false
                            break
                        end
                    end

                    if v313 then
                        arg82.joinable = false
                        v310 = true
                        v311 = arg82

                        return nil
                    end
                end

                return arg82
            end

            return nil
        end, 86400)
    end)

    if not Success_11 then
        v309 = true
        print("Unable to update Running Games (Add player to game):")
        warn(Result_12)
    end

    if v310 then
        local Success_12, Result_13 = pcall(function() -- line: 2138
            -- upvalues:
            --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
            --  [2] s30 (copy)
            --  [3] MATCHMAKINGSERVICENONJOINABLEGAMES (ref)
            --  [4] v311 (ref)

            MATCHMAKINGSERVICEJOINABLEGAMES:RemoveAsync(s30)
            MATCHMAKINGSERVICENONJOINABLEGAMES:SetAsync(s30, v311, 86400)
        end)

        if not Success_12 then
            v309 = true
            print("Unable to update Running Games (Add player to game update joinable):")
            warn(Result_13)
        end
    end

    return not v309
end

function t_4.AddPlayerToGame(
    t52: table,
    u11: userdata,
    s32: string,
    b9: boolean,
    s33: string
) -- line: 2157
    return t52:AddPlayerToGameId(u11.UserId, s32, b9, s33)
end

function t_4.AddPlayersToGameId(
    t53: table,
    t54: table,
    s34: string,
    b10: boolean,
    s35: string
) -- line: 2166
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [2] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)

    local v314 = false
    local v315 = false

    if s35 == nil then
        s35 = "MMS_NO_ROLE"
    end

    local v316 = nil
    local Success_13, Result_14 = pcall(function() -- line: 2173
        -- upvalues:
        --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
        --  [2] s34 (copy)
        --  [3] s35 (ref)
        --  [4] t54 (copy)
        --  [5] t53 (copy)
        --  [6] b10 (copy)
        --  [7] v315 (ref)
        --  [8] v316 (ref)

        MATCHMAKINGSERVICEJOINABLEGAMES:UpdateAsync(s34, function(arg83) -- line: 2174
            -- upvalues:
            --  [1] s35 (ref)
            --  [2] t54 (ref)
            --  [3] t53 (ref)
            --  [4] b10 (ref)
            --  [5] v315 (ref)
            --  [6] v316 (ref)

            if arg83 ~= nil then
                if arg83.players[s35] == nil then
                    arg83.players[s35] = {}
                end

                for _, val_74 in ipairs(t54) do
                    table.insert(arg83.players[s35], val_74)
                end

                for key_75, val_75 in pairs(t53.PlayerRanges[arg83.map]) do
                    local Full_2 = arg83.full
                    local v317 = arg83.players[key_75] and #arg83.players[key_75] >= val_75.Max
                    Full_2[key_75] = v317
                end

                if b10 then
                    local v318 = true

                    for _, val_76 in pairs(arg83.full) do
                        if not val_76 then
                            v318 = false
                            break
                        end
                    end

                    if v318 then
                        arg83.joinable = false
                        v315 = true
                        v316 = arg83

                        return nil
                    end
                end

                return arg83
            end

            return nil
        end, 86400)
    end)

    if not Success_13 then
        v314 = true
        print("Unable to update Running Games (Add players to game):")
        warn(Result_14)
    end

    if v315 then
        local Success_14, Result_15 = pcall(function() -- line: 2215
            -- upvalues:
            --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
            --  [2] s34 (copy)
            --  [3] MATCHMAKINGSERVICENONJOINABLEGAMES (ref)
            --  [4] v316 (ref)

            MATCHMAKINGSERVICEJOINABLEGAMES:RemoveAsync(s34)
            MATCHMAKINGSERVICENONJOINABLEGAMES:SetAsync(s34, v316, 86400)
        end)

        if not Success_14 then
            v314 = true
            print("Unable to update Running Games (Add player to game update joinable):")
            warn(Result_15)
        end
    end

    return not v314
end

function t_4.AddPlayersToGame(
    t55: table,
    t56: table,
    s36: string,
    b11: boolean,
    s37: string
) -- line: 2234
    return t55:AddPlayersToGameId(tableSelect(t56, "UserId"), s36, b11, s37)
end

function t_4.RemovePlayerFromGameId(t57: table, n23: number, s38: string, b12: boolean) -- line: 2243
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)

    local v320 = false
    local Success_15, Result_16 = pcall(function() -- line: 2245
        -- upvalues:
        --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
        --  [2] s38 (copy)
        --  [3] n23 (copy)
        --  [4] t57 (copy)
        --  [5] b12 (copy)

        MATCHMAKINGSERVICEJOINABLEGAMES:UpdateAsync(s38, function(arg84) -- line: 2246
            -- upvalues:
            --  [1] n23 (ref)
            --  [2] t57 (ref)
            --  [3] b12 (ref)

            if arg84 ~= nil then
                local v321 = table.find(arg84.players, n23)

                if v321 ~= nil then
                    table.remove(arg84.players, v321)
                else
                    return nil
                end

                arg84.full = #arg84.players == t57.PlayerRanges[arg84.map].Max
                arg84.joinable = if not b12 then arg84.joinable else #arg84.players ~= t57.PlayerRanges[arg84.map].Max

                return arg84
            end

            return nil
        end, 86400)
    end)

    if not Success_15 then
        v320 = true
        print("Unable to update Running Games (Remove player from game):")
        warn(Result_16)
    end

    return not v320
end

function t_4.RemovePlayerFromGame(t58: table, u12: userdata, s39: string, b13: boolean) -- line: 2275
    return t58:RemovePlayerFromGameId(u12.UserId, s39, b13)
end

function t_4.RemovePlayersFromGameId(t59: table, t60: table, s40: string, b14: boolean) -- line: 2284
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)

    local v323 = false
    local Success_16, Result_17 = pcall(function() -- line: 2286
        -- upvalues:
        --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
        --  [2] s40 (copy)
        --  [3] t60 (copy)
        --  [4] t59 (copy)
        --  [5] b14 (copy)

        MATCHMAKINGSERVICEJOINABLEGAMES:UpdateAsync(s40, function(arg85) -- line: 2287
            -- upvalues:
            --  [1] t60 (ref)
            --  [2] t59 (ref)
            --  [3] b14 (ref)

            if arg85 ~= nil then
                for _, val_77 in ipairs(t60) do
                    local v324 = table.find(arg85.players, val_77)

                    if v324 ~= nil then
                        table.remove(arg85.players, v324)
                    end
                end

                arg85.full = #arg85.players == t59.PlayerRanges[arg85.map].Max
                arg85.joinable = if not b14 then arg85.joinable else #arg85.players ~= t59.PlayerRanges[arg85.map].Max

                return arg85
            end

            return nil
        end, 86400)
    end)

    if not Success_16 then
        v323 = true
        print("Unable to update Running Games (Remove players from game):")
        warn(Result_17)
    end

    return not v323
end

function t_4.RemovePlayersFromGame(t61: table, t62: table, s41: string, b15: boolean) -- line: 2316
    return t61:RemovePlayersFromGameId(tableSelect(t62, "UserId"), s41, b15)
end

function t_4.UpdateRatingsId(t63: table, s42: string, t64: table, t65: table) -- line: 2325
    -- upvalues:
    --  [1] OpenSkill_m (copy)

    if t63.Options.DisableRatingSystem then
        return nil
    end

    local v327 = false
    local Success_17, Result_18 = pcall(function() -- line: 2328
        -- upvalues:
        --  [1] t65 (copy)
        --  [2] t63 (copy)
        --  [3] s42 (copy)
        --  [4] OpenSkill_m (ref)
        --  [5] t64 (copy)

        local t_42 = {}

        for _, val_78 in ipairs(t65) do
            local t_43 = {}

            for _, val_79 in ipairs(val_78) do
                table.insert(t_43, t63:GetPlayerRatingId(val_79, s42))
            end

            table.insert(t_42, t_43)
        end

        OpenSkill_m.Rate(t_42, { rank = t64 })

        for key_80, val_80 in ipairs(t_42) do
            for key_81, val_81 in ipairs(val_80) do
                t63:SetPlayerRatingId(t65[key_80][key_81], s42, val_81)
            end
        end
    end)

    if not Success_17 then
        v327 = true
        print("Unable to update Ratings:")
        warn(Result_18)
    end

    return not v327
end

function t_4.UpdateRatings(t66: table, s43: string, t67: table, t68: table) -- line: 2361
    local t_44 = {}

    for _, val_82 in ipairs(t68) do
        table.insert(t_44, tableSelect(val_82, "UserId"))
    end

    return t66:UpdateRatingsId(s43, t67, t_44)
end

function t_4.SetJoinable(t69: table, s44: string, b16: boolean) -- line: 2373
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [3] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)
    --  [4] v5 (ref)

    if not t69.IsGameServer then
        return
    end

    local v328 = false

    if not b16 then
        local v329 = s44 or t69:GetCurrentGameCode()
        local v330 = v329
        v329 = getFromMemory(MATCHMAKINGSERVICEJOINABLEGAMES, v330, 3) or v4
        v4 = v329
        v4.joinable = false
        local Success_18, Result_19 = pcall(function() -- line: 2382
            -- upvalues:
            --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
            --  [2] v330 (ref)

            MATCHMAKINGSERVICEJOINABLEGAMES:RemoveAsync(v330)
        end)

        if not Success_18 then
            v328 = true
            print("Unable to update Running Games (Update joinable false):")
            warn(Result_19)
        end

        local Result_20 = nil

        if not pcall(function() -- line: 2392
            -- upvalues:
            --  [1] MATCHMAKINGSERVICENONJOINABLEGAMES (ref)
            --  [2] v330 (ref)
            --  [3] v4 (ref)

            MATCHMAKINGSERVICENONJOINABLEGAMES:SetAsync(v330, v4, 86400)
        end) then
            v328 = true
            print("Unable to update Running Games (Update joinable false 2):")
            warn(Result_20)
        end
    else
        v4.joinable = true
        local Success_19, Result_21 = pcall(function() -- line: 2404
            -- upvalues:
            --  [1] MATCHMAKINGSERVICENONJOINABLEGAMES (ref)
            --  [2] s44 (ref)

            MATCHMAKINGSERVICENONJOINABLEGAMES:RemoveAsync(s44)
        end)

        if not Success_19 then
            v328 = true
            print("Unable to update Running Games (Update joinable true):")
            warn(Result_21)
        end

        local Result_22 = nil

        if not pcall(function() -- line: 2414
            -- upvalues:
            --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
            --  [2] v5 (ref)
            --  [3] v4 (ref)

            MATCHMAKINGSERVICEJOINABLEGAMES:SetAsync(v5, v4, 86400)
        end) then
            v328 = true
            print("Unable to update Running Games (Update joinable true 2):")
            warn(Result_22)
        end
    end

    return not v328
end

function t_4.RemoveGame(arg86) -- line: 2430
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [3] MATCHMAKINGSERVICE (copy)

    if not arg86.IsGameServer then
        return
    end

    local v331 = false
    local v332 = arg86:GetCurrentGameCode()
    local v333 = v4 or getFromMemory(MATCHMAKINGSERVICEJOINABLEGAMES, v332, 3)
    local Success_20, Result_23 = pcall(function() -- line: 2435
        -- upvalues:
        --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
        --  [2] v332 (copy)

        MATCHMAKINGSERVICEJOINABLEGAMES:RemoveAsync(v332)
    end)

    if not Success_20 then
        v331 = true
        print("Unable to update Running Games (Remove game):")
        warn(Result_23)
    end

    local Success_21, Result_24 = pcall(function() -- line: 2445
        -- upvalues:
        --  [1] MATCHMAKINGSERVICE (ref)

        MATCHMAKINGSERVICE:RemoveAsync(game.PrivateServerId)
    end)

    if not Success_21 then
        v331 = true
        print("Unable to update Running Games (Remove game):")
        warn(Result_24)
    end

    if v333 then
        for key_83, _ in ipairs(v333.players) do
            arg86:ClearPlayerInfoId(key_83)
        end
    end

    return not v331
end

function t_4.StartGame(t70: table, s45: string, b17: boolean) -- line: 2468
    -- upvalues:
    --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (copy)
    --  [2] v4 (ref)
    --  [3] MATCHMAKINGSERVICENONJOINABLEGAMES (copy)

    if b17 == nil then
        b17 = false
    end

    if s45 == nil then
        s45 = t70:GetCurrentGameCode()
    end

    local v334 = false
    local Success_23, Result_27 = pcall(function() -- line: 2472
        -- upvalues:
        --  [1] b17 (ref)
        --  [2] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
        --  [3] s45 (ref)
        --  [4] v4 (ref)
        --  [5] v334 (ref)
        --  [6] MATCHMAKINGSERVICENONJOINABLEGAMES (ref)

        if b17 then
            MATCHMAKINGSERVICEJOINABLEGAMES:UpdateAsync(s45, function(arg87) -- line: 2474
                -- upvalues:
                --  [1] b17 (ref)

                if arg87 ~= nil then
                    arg87.started = true
                    arg87.joinable = b17

                    return arg87
                end

                if arg87 == nil then
                    warn("Unable to update Running Games (Start game): Invalid gameId.")
                else
                    warn(
                        "Unable to update Running Games (Start game): No running games found in memory"
                    )
                end

                return nil
            end, 86400)

            return
        end

        v4 = getFromMemory(MATCHMAKINGSERVICEJOINABLEGAMES, s45, 3) or v4
        v4.joinable = false
        local Success_22, Result_25 = pcall(function() -- line: 2492
            -- upvalues:
            --  [1] MATCHMAKINGSERVICEJOINABLEGAMES (ref)
            --  [2] s45 (ref)

            MATCHMAKINGSERVICEJOINABLEGAMES:RemoveAsync(s45)
        end)

        if not Success_22 then
            v334 = true
            print("Unable to update Running Games (Start game joinable false):")
            warn(Result_25)
        end

        local Result_26 = nil

        if not pcall(function() -- line: 2502
            -- upvalues:
            --  [1] MATCHMAKINGSERVICENONJOINABLEGAMES (ref)
            --  [2] s45 (ref)
            --  [3] v4 (ref)

            MATCHMAKINGSERVICENONJOINABLEGAMES:SetAsync(s45, v4, 86400)
        end) then
            v334 = true
            print("Unable to update Running Games (Start game joinable false 2):")
            warn(Result_26)
        end
    end)

    if not Success_23 then
        v334 = true
        print("Unable to update Running Games (Start game):")
        warn(Result_27)
    end

    return not v334
end

if not RunService:IsStudio() then
    game:BindToClose(function() -- line: 2523
        -- upvalues:
        --  [1] v1 (ref)
        --  [2] MATCHMAKINGSERVICE (copy)
        --  [3] t_4 (copy)

        v1 = true
        local _, _ = pcall(function() -- line: 2525
            -- upvalues:
            --  [1] MATCHMAKINGSERVICE (ref)

            if getFromMemory(MATCHMAKINGSERVICE, "MainJobId", 3)[1] == game.JobId then
                MATCHMAKINGSERVICE:RemoveAsync("MainJobId")
            end
        end)
        local v336 = t_4.GetSingleton()

        if v336.IsGameServer then
            v336:RemoveGame()
        end
    end)
end

return t_4
