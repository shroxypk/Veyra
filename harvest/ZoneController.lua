-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone.ZoneController
-- Class: ModuleScript
-- bytes: 17869

local Janitor_m = require(script.Parent.Janitor)
local Enum_m = require(script.Parent.Enum)
local _ = require(script.Parent.Signal)
local Tracker_m = require(script.Tracker)
local CollectiveWorldModel_m = require(script.CollectiveWorldModel)
local Enums = Enum_m.enums
local Players = game:GetService("Players")
local t = {}
local v1 = 0
local t_1 = {}
local t_2 = {}
local t_3 = {}
local t_4 = {}
local t_5 = {}
local t_6 = {}
local v2 = 0
local RunService = game:GetService("RunService")
local t_7 = {}
local Heartbeat = RunService.Heartbeat
local v3 = RunService:IsClient()

if v3 then
    v3 = Players.LocalPlayer
end

local t_8 = {}
local t_9 = { player = Tracker_m.new("player"), item = Tracker_m.new("item") }
t_8.trackers = t_9

local _ = function(arg1) --[[ dictLength ]] -- line: 40
    local v4 = 0

    for _, _ in pairs(arg1) do
        v4 += 1
    end

    return v4
end

local _ = function(arg2, arg3, arg4) --[[ fillOccupants ]] -- line: 48
    local v5 = arg2[arg3]

    if not v5 then
        v5 = {}
        arg2[arg3] = v5
    end

    local v6 = arg4:IsA("Player")

    if v6 then
        v6 = arg4.Character
    end

    v5[arg4] = v6 or true
end

local t_10 = {}

function t_10.player(arg5) -- line: 59
    -- upvalues:
    --  [1] t_8 (copy)
    --  [2] t (copy)
    --  [3] v1 (ref)

    return t_8._getZonesAndItems(
        "player",
        t,
        v1,
        true,
        arg5
    )
end

function t_10.localPlayer(arg6) -- line: 62
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] t_8 (copy)
    --  [3] t_9 (copy)

    local t_11 = {}
    local v7 = v3.Character

    if not v7 then
        return t_11
    end

    for _, val_1 in pairs((t_8.getTouchingZones(v7, true, arg6, t_9.player))) do
        if val_1.activeTriggers.localPlayer then
            local v9 = v3
            v7 = t_11[val_1]

            if not v7 then
                v7 = {}
                t_11[val_1] = v7
            end

            local v10 = v9:IsA("Player")

            if v10 then
                v10 = v9.Character
            end

            v7[v9] = v10 or true
        end
    end

    return t_11
end

function t_10.item(arg7) -- line: 76
    -- upvalues:
    --  [1] t_8 (copy)
    --  [2] t (copy)
    --  [3] v1 (ref)

    return t_8._getZonesAndItems(
        "item",
        t,
        v1,
        true,
        arg7
    )
end

function t_8._registerZone(arg8) -- line: 84
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] Janitor_m (copy)
    --  [3] t_8 (copy)

    t_2[arg8] = true
    local v12 = arg8.janitor:add(Janitor_m.new(), "destroy")
    arg8._registeredJanitor = v12
    v12:add(arg8.updated:Connect(function() -- line: 88
        -- upvalues:
        --  [1] t_8 (ref)

        t_8._updateZoneDetails()
    end), "Disconnect")
    t_8._updateZoneDetails()
end

function t_8._deregisterZone(arg9) -- line: 94
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t_8 (copy)

    t_2[arg9] = nil
    arg9._registeredJanitor:destroy()
    arg9._registeredJanitor = nil
    t_8._updateZoneDetails()
end

function t_8._registerConnection(arg10, arg11) -- line: 101
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] t (copy)
    --  [3] t_8 (copy)
    --  [4] t_1 (copy)
    --  [5] t_10 (copy)

    local v14 = 0

    for _, _ in pairs(arg10.activeTriggers) do
        v14 += 1
    end

    v2 += 1

    if v14 == 0 then
        t[arg10] = true
        t_8._updateZoneDetails()
    end

    v14 = t_1[arg11]
    t_1[arg11] = v14 and v14 + 1 or 1
    arg10.activeTriggers[arg11] = true

    if arg10.touchedConnectionActions[arg11] then
        arg10:_formTouchedConnection(arg11)
    end

    if t_10[arg11] then
        t_8._formHeartbeat(arg11)
    end
end

function t_8.updateDetection(arg12) -- line: 121
    -- upvalues:
    --  [1] Tracker_m (copy)
    --  [2] Enums (copy)

    for key_3, val_3 in pairs(
        { enterDetection = "_currentEnterDetection", exitDetection = "_currentExitDetection" }
    ) do
        local v16 = arg12[key_3]
        local v17 = Tracker_m.getCombinedTotalVolumes()
        arg12[val_3] = if v16 ~= Enums.Detection.Automatic then v16 else if not (v17 > 729000) then Enums.Detection.WholeBody else Enums.Detection.Centre
    end
end

function t_8._formHeartbeat(arg13) -- line: 140
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] Heartbeat (copy)
    --  [3] t (copy)
    --  [4] t_8 (copy)
    --  [5] t_10 (copy)
    --  [6] Enums (copy)

    if t_7[arg13] then
        return
    end

    local v18 = 0
    t_7[arg13] = Heartbeat:Connect(function() -- line: 150
        -- upvalues:
        --  [1] v18 (ref)
        --  [2] t (ref)
        --  [3] arg13 (copy)
        --  [4] t_8 (ref)
        --  [5] t_10 (ref)
        --  [6] Enums (ref)

        local clock = os.clock()

        if clock >= v18 then
            local v19 = nil
            local v20 = nil

            for key_4, _ in pairs(t) do
                if key_4.activeTriggers[arg13] then
                    local Accuracy = key_4.accuracy
                    v19 = if v19 == nil then Accuracy else if not (v19 > Accuracy) then v19 else Accuracy
                    t_8.updateDetection(key_4)
                    local CurrentEnterDetection = key_4._currentEnterDetection
                    v20 = if v20 == nil then CurrentEnterDetection else if not (v20 > CurrentEnterDetection) then v20 else CurrentEnterDetection
                end
            end

            local v21 = v19
            v19 = t_10[arg13](v20)
            v20 = {}
            local t_13 = {}
            local v22, v23

            for key_5, val_5 in pairs(v19) do
                v22 = key_5.settingsGroupName

                if v22 then
                    v22 = t_8.getGroup(key_5.settingsGroupName)
                end

                if v22 and v22.onlyEnterOnceExitedAll == true then
                    for key_6, _ in pairs(val_5) do
                        v23 = v20[key_5.settingsGroupName]

                        if not v23 then
                            v23 = {}
                            v20[key_5.settingsGroupName] = v23
                        end

                        v23[key_6] = key_5
                    end

                    t_13[key_5] = val_5
                end
            end

            for key_7, val_7 in pairs(t_13) do
                v22 = v20[key_7.settingsGroupName]

                if v22 then
                    for key_8, _ in pairs(val_7) do
                        v23 = v22[key_8]

                        if v23 and v23 ~= key_7 then
                            val_7[key_8] = nil
                        end
                    end
                end
            end

            local t_14 = { {}, {} }

            for key_9, _ in pairs(t) do
                if key_9.activeTriggers[arg13] then
                    local Accuracy_1 = key_9.accuracy
                    local v24 = v19[key_9] or {}
                    local v25 = false

                    for _, _ in pairs(v24) do
                        v25 = true
                        break
                    end

                    v21 = if not v25 then v21 else if not (Accuracy_1 > v21) then v21 else Accuracy_1
                    v25 = key_9:_updateOccupants(arg13, v24)
                    t_14[1][key_9] = v25.exited
                    t_14[2][key_9] = v25.entered
                end
            end

            local t_15 = { "Exited", "Entered" }

            for key_11, val_11 in pairs(t_14) do
                local v26 = arg13 .. t_15[key_11]

                for key_12, val_12 in pairs(val_11) do
                    local v27 = key_12[v26]

                    if v27 then
                        for _, val_13 in pairs(val_12) do
                            v27:Fire(val_13)
                        end
                    end
                end
            end

            v18 = clock + Enums.Accuracy.getProperty(v21)
        end
    end)
end

function t_8._deregisterConnection(arg14, arg15) -- line: 249
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] t_1 (copy)
    --  [3] t_7 (copy)
    --  [4] t (copy)
    --  [5] t_8 (copy)

    v2 -= 1

    if t_1[arg15] == 1 then
        t_1[arg15] = nil
        local v28 = t_7[arg15]

        if v28 then
            t_7[arg15] = nil
            v28:Disconnect()
        end
    else
        local v29 = t_1
        v29[arg15] -= 1
    end

    arg14.activeTriggers[arg15] = nil
    local v30 = 0

    for _, _ in pairs(arg14.activeTriggers) do
        v30 += 1
    end

    if v30 == 0 then
        t[arg14] = nil
        t_8._updateZoneDetails()
    end

    if arg14.touchedConnectionActions[arg15] then
        arg14:_disconnectTouchedConnection(arg15)
    end
end

function t_8._updateZoneDetails() -- line: 271
    -- upvalues:
    --  [1] t_3 (ref)
    --  [2] t_4 (ref)
    --  [3] t_5 (ref)
    --  [4] t_6 (ref)
    --  [5] v1 (ref)
    --  [6] t_2 (copy)
    --  [7] t (copy)

    t_3 = {}
    t_4 = {}
    t_5 = {}
    t_6 = {}
    v1 = 0

    for key_15, _ in pairs(t_2) do
        local v31 = t[key_15]

        if v31 then
            v1 += key_15.volume
        end

        for _, val_16 in pairs(key_15.zoneParts) do
            if v31 then
                table.insert(t_3, val_16)
                t_4[val_16] = key_15
            end

            table.insert(t_5, val_16)
            t_6[val_16] = key_15
        end
    end
end

function t_8._getZonesAndItems(
    arg16,
    arg17,
    arg18,
    arg19,
    arg20
) -- line: 293
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] t_8 (copy)
    --  [3] Players (copy)
    --  [4] CollectiveWorldModel_m (copy)

    local v32 = arg18

    if not v32 then
        for key_17, _ in pairs(arg17) do
            v32 += key_17.volume
        end
    end

    local t_16 = {}
    local v33 = t_9[arg16]

    if v32 > v33.totalVolume then
        for _, val_18 in pairs(v33.items) do
            for _, val_19 in pairs((t_8.getTouchingZones(val_18, arg19, arg20, v33))) do
                if not arg19 or val_19.activeTriggers[arg16] then
                    local v35 = if arg16 == "player" then Players:GetPlayerFromCharacter(val_18) else val_18

                    if v35 then
                        local v36 = t_16[val_19]

                        if not v36 then
                            v36 = {}
                            t_16[val_19] = v36
                        end

                        local v37 = v35:IsA("Player")

                        if v37 then
                            v37 = v35.Character
                        end

                        v36[v35] = v37 or true
                    end
                end
            end
        end

        return t_16
    end

    local v40

    for key_20, _ in pairs(arg17) do
        if not arg19 or key_20.activeTriggers[arg16] then
            local t_17 = {}

            for _, val_21 in pairs(
                (CollectiveWorldModel_m:GetPartBoundsInBox(
                    key_20.region.CFrame,
                    key_20.region.Size,
                    v33.whitelistParams
                ))
            ) do
                local v39 = v33.partToItem[val_21]

                if not t_17[v39] then
                    t_17[v39] = true
                end
            end

            for key_22, _ in pairs(t_17) do
                if arg16 == "player" then
                    local playerFromCharacter = Players:GetPlayerFromCharacter(key_22)

                    if key_20:findPlayer(playerFromCharacter) then
                        v40 = t_16[key_20]

                        if not v40 then
                            v40 = {}
                            t_16[key_20] = v40
                        end

                        local v41 = playerFromCharacter:IsA("Player")

                        if v41 then
                            v41 = playerFromCharacter.Character
                        end

                        v40[playerFromCharacter] = v41 or true
                    end
                elseif key_20:findItem(key_22) then
                    v40 = t_16[key_20]

                    if not v40 then
                        v40 = {}
                        t_16[key_20] = v40
                    end

                    local v42 = key_22:IsA("Player")

                    if v42 then
                        v42 = key_22.Character
                    end

                    v40[key_22] = v42 or true
                end
            end
        end
    end

    return t_16
end

function t_8.getZones() -- line: 354
    -- upvalues:
    --  [1] t_2 (copy)

    local t_18 = {}

    for key_23, _ in pairs(t_2) do
        table.insert(t_18, key_23)
    end

    return t_18
end

function t_8.getTouchingZones(arg21, arg22, arg23, arg24) -- line: 374
    -- upvalues:
    --  [1] Enums (copy)
    --  [2] Tracker_m (copy)
    --  [3] t_3 (ref)
    --  [4] t_5 (ref)
    --  [5] t_4 (ref)
    --  [6] t_6 (ref)
    --  [7] CollectiveWorldModel_m (copy)

    local v43 = nil

    if arg24 then
        v43 = arg24.exitDetections[arg21]
        arg24.exitDetections[arg21] = nil
    end

    local v44 = v43 or arg23
    local v45 = nil
    local v46 = nil
    v43 = arg21:IsA("BasePart")
    local v47 = not v43
    local v48 = {}

    if v43 then
        v45 = arg21.Size
        v46 = arg21.CFrame
        table.insert(v48, arg21)
    elseif v44 == Enums.Detection.WholeBody then
        v45, v46 = Tracker_m.getCharacterSize(arg21)
        v48 = arg21:GetChildren()
    else
        local HumanoidRootPart = arg21:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart then
            v45 = HumanoidRootPart.Size
            v46 = HumanoidRootPart.CFrame
            table.insert(v48, HumanoidRootPart)
        end
    end

    if not v45 or not v46 then
        return {}
    end

    v44 = arg22 and t_3 or t_5
    v43 = arg22 and t_4 or t_6
    local overlapParams = OverlapParams.new()
    overlapParams.FilterType = Enum.RaycastFilterType.Whitelist
    overlapParams.MaxParts = #v44
    overlapParams.FilterDescendantsInstances = v44
    v44 = {}
    local t_19 = {}
    local t_20 = {}

    for _, val_24 in pairs((CollectiveWorldModel_m:GetPartBoundsInBox(v46, v45, overlapParams))) do
        v46 = v43[val_24]

        if v46 and v46.allZonePartsAreBlocks then
            t_19[v46] = true
            v44[val_24] = v46
        else
            table.insert(t_20, val_24)
        end
    end

    local v50 = #t_20
    v45 = 0
    local v51

    if v50 > 0 then
        v51 = OverlapParams.new()
        v51.FilterType = Enum.RaycastFilterType.Whitelist
        v51.MaxParts = v50
        v51.FilterDescendantsInstances = t_20
        local v54

        for _, val_25 in pairs(v48) do
            local v52 = false

            if val_25:IsA("BasePart") then
                if v47 then
                    if not Tracker_m.bodyPartsToIgnore[val_25.Name] then
                        for _, val_26 in pairs((CollectiveWorldModel_m:GetPartsInPart(val_25, v51))) do
                            if not v44[val_26] then
                                v54 = v43[val_26]

                                if v54 then
                                    t_19[v54] = true
                                    v44[val_26] = v54
                                    v45 += 1
                                end

                                if v45 == v50 then
                                    v52 = true
                                    break
                                end
                            end
                        end

                        if v52 then
                            break
                        end
                    end
                else
                    for _, val_27 in pairs((CollectiveWorldModel_m:GetPartsInPart(val_25, v51))) do
                        if not v44[val_27] then
                            v54 = v43[val_27]

                            if v54 then
                                t_19[v54] = true
                                v44[val_27] = v54
                                v45 += 1
                            end

                            if v45 == v50 then
                                v52 = true
                                break
                            end
                        end
                    end

                    if v52 then
                        break
                    end
                end
            end
        end
    end

    local t_21 = {}
    v51 = nil

    for key_28, _ in pairs(t_19) do
        v51 = if v51 == nil then key_28._currentExitDetection else if not (v51 > key_28._currentExitDetection) then v51 else key_28._currentExitDetection
        table.insert(t_21, key_28)
    end

    if v51 and arg24 then
        arg24.exitDetections[arg21] = v51
    end

    return t_21, v44
end

local t_22 = {}

function t_8.setGroup(arg25, arg26) -- line: 491
    -- upvalues:
    --  [1] t_22 (copy)

    local v55 = t_22[arg25]

    if not v55 then
        v55 = {}
        t_22[arg25] = v55
    end

    v55.onlyEnterOnceExitedAll = true
    v55._name = arg25
    v55._memberZones = {}

    if typeof(arg26) == "table" then
        for key_29, val_29 in pairs(arg26) do
            v55[key_29] = val_29
        end
    end

    return v55
end

function t_8.getGroup(arg27) -- line: 515
    -- upvalues:
    --  [1] t_22 (copy)

    return t_22[arg27]
end

local v57 = string.format(
    "ZonePlus%sContainer",
    if RunService:IsClient() then "Client" else "Server"
)
local v58 = nil

function t_8.getWorkspaceContainer() -- line: 521
    -- upvalues:
    --  [1] v58 (ref)
    --  [2] v57 (copy)

    local v59 = v58 or workspace:FindFirstChild(v57)

    if not v59 then
        v59 = Instance.new("Folder")
        v59.Name = v57
        v59.Parent = workspace
        v58 = v59
    end

    return v59
end

return t_8
