-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone
-- Class: ModuleScript
-- bytes: 29819

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Heartbeat = RunService.Heartbeat
local v1 = RunService:IsClient()

if v1 then
    v1 = Players.LocalPlayer
end

local Enums = require(script.Enum).enums
local Janitor_m = require(script.Janitor)
local Signal_m = require(script.Signal)
local ZonePlusReference_m = require(script.ZonePlusReference)
local v2 = ZonePlusReference_m.getObject()
local v3 = script.ZoneController
local Tracker = v3.Tracker
local CollectiveWorldModel = v3.CollectiveWorldModel
local v4 = require(v3)
local HttpService = game:GetService("HttpService")
v3 = if game:GetService("RunService"):IsClient() then "Client" else "Server"
local v5 = v2

if v5 then
    v5 = v2:FindFirstChild(v3)
end

if v5 then
    return require(v2.Value)
end

v3 = {}
v3.__index = v3

if not v5 then
    ZonePlusReference_m.addToReplicatedStorage()
end

v3.enum = Enums

function v3.new(arg1) -- line: 34
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] Enums (copy)
    --  [3] Janitor_m (copy)
    --  [4] HttpService (copy)
    --  [5] v4 (copy)
    --  [6] Signal_m (copy)
    --  [7] v1 (copy)

    local t = {}
    setmetatable(t, v3)
    local v6 = typeof(arg1)

    if v6 ~= "table" and v6 ~= "Instance" then
        error("The zone container must be a model, folder, basepart or table!")
    end

    t.accuracy = Enums.Accuracy.High
    t.autoUpdate = true
    t.respectUpdateQueue = true
    local v7 = Janitor_m.new()
    t.janitor = v7
    t._updateConnections = v7:add(Janitor_m.new(), "destroy")
    t.container = arg1
    t.zoneParts = {}
    t.overlapParams = {}
    t.region = nil
    t.volume = nil
    t.boundMin = nil
    t.boundMax = nil
    t.recommendedMaxParts = nil
    t.zoneId = HttpService:GenerateGUID()
    t.activeTriggers = {}
    t.occupants = {}
    t.trackingTouchedTriggers = {}
    t.enterDetection = Enums.Detection.Centre
    t.exitDetection = Enums.Detection.Centre
    t._currentEnterDetection = nil
    t._currentExitDetection = nil
    t.totalPartVolume = 0
    t.allZonePartsAreBlocks = true
    t.trackedItems = {}
    t.settingsGroupName = nil
    t.worldModel = workspace
    t.onItemDetails = {}
    t.itemsToUntrack = {}
    v4.updateDetection(t)
    t.updated = v7:add(Signal_m.new(), "destroy")
    local t_1 = { "player", "part", "localPlayer", "item" }
    local t_2 = { "entered", "exited" }

    for _, val in pairs(t_1) do
        local v8 = 0
        local v9 = 0

        for _, val_1 in pairs(t_2) do
            local v11 = v7:add(Signal_m.new(true), "destroy")
            local v13 = val_1:sub(1, 1):upper() .. val_1:sub(2)
            t[val .. v13] = v11
            v11.connectionsChanged:Connect(function(arg2) -- line: 105
                -- upvalues:
                --  [1] val (copy)
                --  [2] v1 (ref)
                --  [3] v13 (copy)
                --  [4] v9 (ref)
                --  [5] v8 (ref)
                --  [6] v4 (ref)
                --  [7] t (copy)

                if val == "localPlayer" and not v1 and arg2 == 1 then
                    error(("Can only connect to 'localPlayer%s' on the client!"):format(v13))
                end

                v9 = v8
                v8 += arg2

                if v9 == 0 and v8 > 0 then
                    v4._registerConnection(t, val, v13)

                    return
                end

                if v9 > 0 and v8 == 0 then
                    v4._deregisterConnection(t, val)
                end
            end)
        end
    end

    v3.touchedConnectionActions = {}

    for _, val_2 in pairs(t_1) do
        local v14 = t[("_%sTouchedZone"):format(val_2)]

        if v14 then
            t.trackingTouchedTriggers[val_2] = {}

            v3.touchedConnectionActions[val_2] = function(arg3) -- line: 129
                -- upvalues:
                --  [1] v14 (copy)
                --  [2] t (copy)

                v14(t, arg3)
            end
        end
    end

    t:_update()
    v4._registerZone(t)
    v7:add(function() -- line: 140
        -- upvalues:
        --  [1] v4 (ref)
        --  [2] t (copy)

        v4._deregisterZone(t)
    end, true)

    return t
end

function v3.fromRegion(arg4, arg5) -- line: 147
    -- upvalues:
    --  [1] v3 (copy)

    local Model = Instance.new("Model")

    local function createCube(arg6, arg7) -- line: 150
        -- upvalues:
        --  [1] createCube (copy)
        --  [2] Model (copy)

        if arg7.X > 2024 or arg7.Y > 2024 or arg7.Z > 2024 then
            local v15 = arg7 * 0.25
            local v16 = arg7 * 0.5
            createCube(arg6 * CFrame.new(-v15.X, -v15.Y, -v15.Z), v16)
            createCube(arg6 * CFrame.new(-v15.X, -v15.Y, v15.Z), v16)
            createCube(arg6 * CFrame.new(-v15.X, v15.Y, -v15.Z), v16)
            createCube(arg6 * CFrame.new(-v15.X, v15.Y, v15.Z), v16)
            createCube(arg6 * CFrame.new(v15.X, -v15.Y, -v15.Z), v16)
            createCube(arg6 * CFrame.new(v15.X, -v15.Y, v15.Z), v16)
            createCube(arg6 * CFrame.new(v15.X, v15.Y, -v15.Z), v16)
            createCube(arg6 * CFrame.new(v15.X, v15.Y, v15.Z), v16)

            return
        end

        local Part = Instance.new("Part")
        Part.CFrame = arg6
        Part.Size = arg7
        Part.Anchored = true
        Part.Parent = Model
    end

    createCube(arg4, arg5)
    local v25 = v3.new(Model)
    v25:relocate()

    return v25
end

function v3._calculateRegion(_, arg9, arg10) -- line: 179
    local t_3 = { Min = {}, Max = {} }

    for key_3, val_3 in pairs(t_3) do
        val_3.Values = {}

        function val_3.parseCheck(arg11, arg12) -- line: 183
            -- upvalues:
            --  [1] key_3 (copy)

            local v26

            if key_3 == "Min" then
                v26 = arg11 <= arg12

                return v26
            end

            if key_3 == "Max" then
                v26 = arg11 >= arg12

                return v26
            end
        end

        function val_3.parse(arg13, arg14) -- line: 190
            for key_4, val_4 in pairs(arg14) do
                if arg13.parseCheck(val_4, arg13.Values[key_4] or val_4) then
                    arg13.Values[key_4] = val_4
                end
            end
        end
    end

    local v44, v45

    for _, val_5 in pairs(arg9) do
        local v27 = val_5.Size * 0.5

        for _, val_6 in pairs(
            {
                val_5.CFrame * CFrame.new(-v27.X, -v27.Y, -v27.Z),
                val_5.CFrame * CFrame.new(-v27.X, -v27.Y, v27.Z),
                val_5.CFrame * CFrame.new(-v27.X, v27.Y, -v27.Z),
                val_5.CFrame * CFrame.new(-v27.X, v27.Y, v27.Z),
                val_5.CFrame * CFrame.new(v27.X, -v27.Y, -v27.Z),
                val_5.CFrame * CFrame.new(v27.X, -v27.Y, v27.Z),
                val_5.CFrame * CFrame.new(v27.X, v27.Y, -v27.Z),
                val_5.CFrame * CFrame.new(v27.X, v27.Y, v27.Z)
            }
        ) do
            local v43
            v43, v44, v45 = val_6:GetComponents()
            local t_5 = { v43, v44, v45 }
            t_3.Min:parse(t_5)
            t_3.Max:parse(t_5)
        end
    end

    local t_6 = {}
    local t_7 = {}

    local _ = function(arg15) --[[ roundToFour ]] -- line: 222
        return math.floor((arg15 + 2) / 4) * 4
    end

    for key_7, val_7 in pairs(t_3) do
        for _, val_8 in pairs(val_7.Values) do
            v44 = if key_7 ~= "Min" then t_7 else t_6 or t_7
            v45 = val_8

            if not arg10 then
                local v46 = if key_7 ~= "Min" then 2 else -2
                v45 = math.floor((val_8 + v46 + 2) / 4) * 4
            end

            table.insert(v44, v45)
        end
    end

    local vec3 = Vector3.new(unpack(t_6))
    local vec3_1 = Vector3.new(unpack(t_7))

    return Region3.new(vec3, vec3_1), vec3, vec3_1
end

function v3._displayBounds(arg16) -- line: 245
    if not arg16.displayBoundParts then
        arg16.displayBoundParts = true

        for key_9, val_9 in pairs({ BoundMin = arg16.boundMin, BoundMax = arg16.boundMax }) do
            local Part_1 = Instance.new("Part")
            Part_1.Anchored = true
            Part_1.CanCollide = false
            Part_1.Transparency = 0.5
            Part_1.Size = Vector3.new(1, 1, 1)
            Part_1.Color = Color3.fromRGB(255, 0, 0)
            Part_1.CFrame = CFrame.new(val_9)
            Part_1.Name = key_9
            Part_1.Parent = workspace
            arg16.janitor:add(Part_1, "Destroy")
        end
    end
end

function v3._update(arg17) -- line: 264
    -- upvalues:
    --  [1] RunService (copy)

    local Container = arg17.container
    local t_9 = {}
    local v47 = 0
    arg17._updateConnections:clean()
    local v48 = typeof(Container)
    local t_10 = {}

    if v48 == "table" then
        for _, val_10 in pairs(Container) do
            if val_10:IsA("BasePart") then
                table.insert(t_9, val_10)
            end
        end
    elseif v48 == "Instance" then
        if Container:IsA("BasePart") then
            table.insert(t_9, Container)
        else
            table.insert(t_10, Container)

            for _, val_11 in pairs(Container:GetDescendants()) do
                if val_11:IsA("BasePart") then
                    table.insert(t_9, val_11)
                else
                    table.insert(t_10, val_11)
                end
            end
        end
    end

    arg17.zoneParts = t_9
    arg17.overlapParams = {}
    v48 = true

    for _, val_12 in pairs(t_9) do
        local _, Result = pcall(function() -- line: 298
            -- upvalues:
            --  [1] val_12 (copy)

            return val_12.Shape.Name
        end)

        if Result ~= "Block" then
            v48 = false
        end
    end

    arg17.allZonePartsAreBlocks = v48
    v48 = OverlapParams.new()
    v48.FilterType = Enum.RaycastFilterType.Include
    v48.MaxParts = #t_9
    v48.FilterDescendantsInstances = t_9
    arg17.overlapParams.zonePartsWhitelist = v48
    local overlapParams = OverlapParams.new()
    overlapParams.FilterType = Enum.RaycastFilterType.Exclude
    overlapParams.FilterDescendantsInstances = t_9
    arg17.overlapParams.zonePartsIgnorelist = overlapParams

    local function update() -- line: 318
        -- upvalues:
        --  [1] arg17 (copy)
        --  [2] v47 (ref)
        --  [3] RunService (ref)

        if arg17.autoUpdate then
            local v50 = os.clock()

            if arg17.respectUpdateQueue then
                local v52 = v47
                v52 += 1
                v47 = v52
                v50 += 0.1
            end

            local v53 = nil
            v53 = RunService.Heartbeat:Connect(function() -- line: 326
                -- upvalues:
                --  [1] v50 (ref)
                --  [2] v53 (ref)
                --  [3] arg17 (ref)
                --  [4] v47 (ref)

                if os.clock() >= v50 then
                    v53:Disconnect()

                    if arg17.respectUpdateQueue then
                        v47 -= 1
                    end

                    if v47 == 0 and arg17.zoneId then
                        arg17:_update()
                    end
                end
            end)
        end
    end

    local t_11 = { "Size", "Position" }

    local _ = function(arg18) --[[ verifyDefaultCollision ]] -- line: 340
        if arg18.CollisionGroupId ~= 0 then
            error(
                "Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts."
            )
        end
    end

    for _, val_13 in pairs(t_9) do
        for _, val_14 in pairs(t_11) do
            arg17._updateConnections:add(
                val_13:GetPropertyChangedSignal(val_14):Connect(update),
                "Disconnect"
            )
        end

        if val_13.CollisionGroupId ~= 0 then
            error(
                "Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts."
            )
        end

        arg17._updateConnections:add(val_13:GetPropertyChangedSignal("CollisionGroupId"):Connect(
            function() -- line: 350
                -- upvalues:
                --  [1] val_13 (copy)

                if val_13.CollisionGroupId ~= 0 then
                    error(
                        "Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts."
                    )
                end
            end
        ), "Disconnect")
    end

    local t_12 = { "ChildAdded", "ChildRemoved" }

    for _, _ in pairs(t_10) do
        for _, val_16 in pairs(t_12) do
            arg17._updateConnections:add(arg17.container[val_16]:Connect(function(arg19) -- line: 357
                -- upvalues:
                --  [1] arg17 (copy)
                --  [2] v47 (ref)
                --  [3] RunService (ref)

                if arg19:IsA("BasePart") then
                    local v58 = arg17.autoUpdate

                    if v58 then
                        v58 = os.clock()

                        if arg17.respectUpdateQueue then
                            local v60 = v47
                            v60 += 1
                            v47 = v60
                            v58 += 0.1
                        end

                        local v61 = nil
                        v61 = RunService.Heartbeat:Connect(function() -- line: 326
                            -- upvalues:
                            --  [1] v58 (ref)
                            --  [2] v61 (ref)
                            --  [3] arg17 (ref)
                            --  [4] v47 (ref)

                            if os.clock() >= v58 then
                                v61:Disconnect()

                                if arg17.respectUpdateQueue then
                                    v47 -= 1
                                end

                                if v47 == 0 and arg17.zoneId then
                                    arg17:_update()
                                end
                            end
                        end)
                    end
                end
            end), "Disconnect")
        end
    end

    local v63, v64, v65 = arg17:_calculateRegion(t_9)
    local v66, _, _ = arg17:_calculateRegion(t_9, true)
    arg17.region = v63
    arg17.exactRegion = v66
    arg17.boundMin = v64
    arg17.boundMax = v65
    local Size = v63.Size
    arg17.volume = Size.X * Size.Y * Size.Z
    arg17:_updateTouchedConnections()
    arg17.updated:Fire()
end

function v3._updateOccupants(arg20, arg21, arg22) -- line: 393
    local v69 = arg20.occupants[arg21]

    if not v69 then
        v69 = {}
        arg20.occupants[arg21] = v69
    end

    local t_13 = {}

    for key_17, val_17 in pairs(v69) do
        local v70 = arg22[key_17]

        if v70 == nil or v70 ~= val_17 then
            v69[key_17] = nil

            if not t_13.exited then
                t_13.exited = {}
            end

            table.insert(t_13.exited, key_17)
        end
    end

    for key_18, _ in pairs(arg22) do
        if v69[key_18] == nil then
            v69[key_18] = key_18:IsA("Player") and key_18.Character or true

            if not t_13.entered then
                t_13.entered = {}
            end

            table.insert(t_13.entered, key_18)
        end
    end

    return t_13
end

function v3._formTouchedConnection(arg23, arg24) -- line: 423
    -- upvalues:
    --  [1] Janitor_m (copy)

    local v72 = "_touchedJanitor" .. arg24
    local v73 = arg23[v72]

    if v73 then
        v73:clean()
    else
        arg23[v72] = arg23.janitor:add(Janitor_m.new(), "destroy")
    end

    arg23:_updateTouchedConnection(arg24)
end

function v3._updateTouchedConnection(arg25, arg26) -- line: 435
    local v75 = arg25["_touchedJanitor" .. arg26]

    if not v75 then
        return
    end

    for _, val_19 in pairs(arg25.zoneParts) do
        v75:add(val_19.Touched:Connect(arg25.touchedConnectionActions[arg26], arg25), "Disconnect")
    end
end

function v3._updateTouchedConnections(arg27) -- line: 444
    for key_20, _ in pairs(arg27.touchedConnectionActions) do
        local v77 = arg27["_touchedJanitor" .. key_20]

        if v77 then
            v77:cleanup()
            arg27:_updateTouchedConnection(key_20)
        end
    end
end

function v3._disconnectTouchedConnection(arg28, arg29) -- line: 455
    local v78 = "_touchedJanitor" .. arg29
    local v79 = arg28[v78]

    if v79 then
        v79:cleanup()
        arg28[v78] = nil
    end
end

function v5(arg30, arg31) --[[ round ]] -- line: 464
    return math.round(arg30 * 10 ^ arg31) * 10 ^ (-arg31)
end

function v3._partTouchedZone(arg32, arg33) -- line: 467
    -- upvalues:
    --  [1] Janitor_m (copy)
    --  [2] Heartbeat (copy)
    --  [3] Enums (copy)

    local Part_2 = arg32.trackingTouchedTriggers.part

    if Part_2[arg33] then
        return
    end

    local v81 = 0
    local v82 = false
    local Position = arg33.Position
    local os_clock = os.clock()
    local v84 = arg32.janitor:add(Janitor_m.new(), "destroy")
    Part_2[arg33] = v84
    local _ = { Seat = true, VehicleSeat = true }

    if not ({ Seat = true, VehicleSeat = true })[arg33.ClassName] and ({ HumanoidRootPart = true })[arg33.Name] then
        arg33.CanTouch = false
    end

    local v85 = math.round(arg33.Size.X * arg33.Size.Y * arg33.Size.Z * 100000) * 1E-05
    arg32.totalPartVolume += v85
    v84:add(Heartbeat:Connect(function() -- line: 485
        -- upvalues:
        --  [1] v81 (ref)
        --  [2] Enums (ref)
        --  [3] arg32 (copy)
        --  [4] arg33 (copy)
        --  [5] v82 (ref)
        --  [6] Position (ref)
        --  [7] os_clock (ref)
        --  [8] v84 (copy)

        local clock = os.clock()

        if clock >= v81 then
            local v86 = Enums.Accuracy.getProperty(arg32.accuracy)
            v81 = clock + v86
            local v87 = arg32:findPoint(arg33.CFrame) or arg32:findPart(arg33)

            if not v82 then
                if v87 then
                    v82 = true
                    arg32.partEntered:Fire(arg33)

                    return
                end

                if (arg33.Position - Position).Magnitude > 1.5 and v86 <= clock - os_clock then
                    v84:cleanup()

                    return
                end
            elseif not v87 then
                v82 = false
                Position = arg33.Position
                os_clock = os.clock()
                arg32.partExited:Fire(arg33)
            end
        end
    end), "Disconnect")
    v84:add(function() -- line: 516
        -- upvalues:
        --  [1] Part_2 (copy)
        --  [2] arg33 (copy)
        --  [3] arg32 (copy)
        --  [4] v85 (copy)

        Part_2[arg33] = nil
        arg33.CanTouch = true
        arg32.totalPartVolume = math.round((arg32.totalPartVolume - v85) * 100000) * 1E-05
    end, true)
end

local t_15 = {
    Ball = function(arg34) -- line: 524
        return "GetPartBoundsInRadius", { arg34.Position, arg34.Size.X }
    end,
    Block = function(arg35) -- line: 527
        return "GetPartBoundsInBox", { arg35.CFrame, arg35.Size }
    end,
    Other = function(arg36) -- line: 530
        return "GetPartsInPart", { arg36 }
    end
}

function v3._getRegionConstructor(arg37, arg38, arg39) -- line: 534
    -- upvalues:
    --  [1] t_15 (copy)

    local Success_1, Result_1 = pcall(function() -- line: 535
        -- upvalues:
        --  [1] arg38 (copy)

        return arg38.Shape.Name
    end)
    local v90 = nil
    local t_16 = nil

    if Success_1 and arg37.allZonePartsAreBlocks then
        local v92 = t_15[Result_1]

        if v92 then
            v90, t_16 = v92(arg38)
        end
    end

    if not v90 then
        v90 = "GetPartsInPart"
        t_16 = { arg38 }
    end

    if arg39 then
        table.insert(t_16, arg39)
    end

    return v90, t_16
end

function v3.findLocalPlayer(arg40) -- line: 555
    -- upvalues:
    --  [1] v1 (copy)

    if not v1 then
        error("Can only call 'findLocalPlayer' on the client!")
    end

    return arg40:findPlayer(v1)
end

function v3._find(arg41, arg42, arg43) -- line: 562
    -- upvalues:
    --  [1] v4 (copy)

    v4.updateDetection(arg41)

    for _, val_21 in pairs(
        (v4.getTouchingZones(arg43, false, arg41._currentEnterDetection, v4.trackers[arg42]))
    ) do
        if val_21 == arg41 then
            return true
        end
    end

    return false
end

function v3.findPlayer(arg44, arg45) -- line: 574
    local Character = arg45.Character
    local v94 = Character

    if v94 then
        v94 = Character:FindFirstChildOfClass("Humanoid")
    end

    if not v94 then
        return false
    end

    return arg44:_find("player", arg45.Character)
end

function v3.findItem(arg46, arg47) -- line: 583
    return arg46:_find("item", arg47)
end

function v3.findPart(arg48, arg49) -- line: 587
    local v95, v96 = arg48:_getRegionConstructor(arg49, arg48.overlapParams.zonePartsWhitelist)
    local v98 = arg48.worldModel[v95](arg48.worldModel, unpack(v96))

    if #v98 > 0 then
        return true, v98
    end

    return false
end

function v3.getCheckerPart(arg50) -- line: 597
    -- upvalues:
    --  [1] v4 (copy)

    local v99 = arg50.checkerPart

    if not v99 then
        v99 = arg50.janitor:add(Instance.new("Part"), "Destroy")
        v99.Size = Vector3.new(0.1, 0.1, 0.1)
        v99.Name = "ZonePlusCheckerPart"
        v99.Anchored = true
        v99.Transparency = 1
        v99.CanCollide = false
        arg50.checkerPart = v99
    end

    local v100 = arg50.worldModel

    if v100 == workspace then
        v100 = v4.getWorkspaceContainer()
    end

    if v99.Parent ~= v100 then
        v99.Parent = v100
    end

    return v99
end

function v3.findPoint(arg51, arg52) -- line: 618
    local v101 = if typeof(arg52) == "Vector3" then CFrame.new(arg52) else arg52
    local v102 = arg51:getCheckerPart()
    v102.CFrame = v101
    local v103, v104 = arg51:_getRegionConstructor(v102, arg51.overlapParams.zonePartsWhitelist)
    local v106 = arg51.worldModel[v103](arg51.worldModel, unpack(v104))

    if #v106 > 0 then
        return true, v106
    end

    return false
end

function v3._getAll(arg53, arg54) -- line: 635
    -- upvalues:
    --  [1] v4 (copy)

    v4.updateDetection(arg53)
    local t_17 = {}
    local v107 = v4._getZonesAndItems(
        arg54,
        { self = true },
        arg53.volume,
        false,
        arg53._currentEnterDetection
    )[arg53]

    if v107 then
        for key_22, _ in pairs(v107) do
            table.insert(t_17, key_22)
        end
    end

    return t_17
end

function v3.getPlayers(arg55) -- line: 648
    return arg55:_getAll("player")
end

function v3.getItems(arg56) -- line: 652
    return arg56:_getAll("item")
end

function v3.getParts(arg57) -- line: 656
    local t_18 = {}

    if arg57.activeTriggers.part then
        for key_23, _ in pairs(arg57.trackingTouchedTriggers.part) do
            table.insert(t_18, key_23)
        end

        return t_18
    end

    for _, val_24 in pairs(
        (arg57.worldModel:GetPartBoundsInBox(
            arg57.region.CFrame,
            arg57.region.Size,
            arg57.overlapParams.zonePartsIgnorelist
        ))
    ) do
        if arg57:findPart(val_24) then
            table.insert(t_18, val_24)
        end
    end

    return t_18
end

function v3.getRandomPoint(arg58) -- line: 677
    local ExactRegion = arg58.exactRegion
    local Size_1 = ExactRegion.Size
    local v109 = ExactRegion.CFrame
    local rng = Random.new()
    local v110 = nil
    local v121

    repeat
        local v120
        v120, v121 = arg58:findPoint(
            v109 * CFrame.new(
                rng:NextNumber(-Size_1.X / 2, Size_1.X / 2),
                rng:NextNumber(-Size_1.Y / 2, Size_1.Y / 2),
                rng:NextNumber(-Size_1.Z / 2, Size_1.Z / 2)
            )
        )

        if v120 then
            v110 = true
        end
    until v110

    local v119

    return v119.Position, v121
end

function v3.setAccuracy(arg59, arg60) -- line: 696
    -- upvalues:
    --  [1] Enums (copy)

    local v122 = tonumber(arg60)

    if not v122 then
        v122 = Enums.Accuracy[arg60]

        if not v122 then
            error(("'%s' is an invalid enumName!"):format(arg60))
        end
    elseif not Enums.Accuracy.getName(v122) then
        error(("%s is an invalid enumId!"):format(v122))
    end

    arg59.accuracy = v122
end

function v3.setDetection(arg61, arg62) -- line: 712
    -- upvalues:
    --  [1] Enums (copy)

    local v123 = tonumber(arg62)

    if not v123 then
        v123 = Enums.Detection[arg62]

        if not v123 then
            error(("'%s' is an invalid enumName!"):format(arg62))
        end
    elseif not Enums.Detection.getName(v123) then
        error(("%s is an invalid enumId!"):format(v123))
    end

    arg61.enterDetection = v123
    arg61.exitDetection = v123
end

function v3.trackItem(arg63, arg64) -- line: 729
    -- upvalues:
    --  [1] Janitor_m (copy)
    --  [2] Tracker (copy)

    local v124 = arg64:IsA("BasePart")
    local v125 = false

    if not v124 then
        local v126 = arg64:FindFirstChildOfClass("Humanoid")

        if v126 then
            v126 = arg64:FindFirstChild("HumanoidRootPart")
        end

        v125 = v126
    end

    assert(v124 or v125, "Only BaseParts or Characters/NPCs can be tracked!")

    if arg63.trackedItems[arg64] then
        return
    end

    if arg63.itemsToUntrack[arg64] then
        arg63.itemsToUntrack[arg64] = nil
    end

    local v128 = arg63.janitor:add(Janitor_m.new(), "destroy")
    local t_19 = { janitor = v128, item = arg64, isBasePart = v124, isCharacter = v125 }
    arg63.trackedItems[arg64] = t_19
    v128:add(arg64.AncestryChanged:Connect(function() -- line: 754
        -- upvalues:
        --  [1] arg64 (copy)
        --  [2] arg63 (copy)

        if not arg64:IsDescendantOf(game) then
            arg63:untrackItem(arg64)
        end
    end), "Disconnect")
    require(Tracker).itemAdded:Fire(t_19)
end

function v3.untrackItem(arg65, arg66) -- line: 764
    -- upvalues:
    --  [1] Tracker (copy)

    local v130 = arg65.trackedItems[arg66]

    if v130 then
        v130.janitor:destroy()
    end

    arg65.trackedItems[arg66] = nil
    require(Tracker).itemRemoved:Fire(v130)
end

function v3.bindToGroup(arg67, arg68) -- line: 775
    -- upvalues:
    --  [1] v4 (copy)

    arg67:unbindFromGroup()
    local v131 = v4.getGroup(arg68) or v4.setGroup(arg68)
    v131._memberZones[arg67.zoneId] = arg67
    arg67.settingsGroupName = arg68
end

function v3.unbindFromGroup(arg69) -- line: 782
    -- upvalues:
    --  [1] v4 (copy)

    if arg69.settingsGroupName then
        local v132 = v4.getGroup(arg69.settingsGroupName)

        if v132 then
            v132._memberZones[arg69.zoneId] = nil
        end

        arg69.settingsGroupName = nil
    end
end

function v3.relocate(arg70) -- line: 792
    -- upvalues:
    --  [1] CollectiveWorldModel (copy)

    if arg70.hasRelocated then
        return
    end

    local v133 = require(CollectiveWorldModel).setupWorldModel(arg70)
    arg70.worldModel = v133
    arg70.hasRelocated = true
    local v134 = arg70.container

    if typeof(v134) == "table" then
        v134 = Instance.new("Folder")

        for _, val_25 in pairs(arg70.zoneParts) do
            val_25.Parent = v134
        end
    end

    arg70.relocationContainer = arg70.janitor:add(v134, "Destroy", "RelocationContainer")
    v134.Parent = v133
end

function v3._onItemCallback(
    arg71,
    arg72,
    arg73,
    arg74,
    arg75
) -- line: 813
    local v135 = arg71.onItemDetails[arg74]

    if not v135 then
        v135 = {}
        arg71.onItemDetails[arg74] = v135
    end

    if #v135 == 0 then
        arg71.itemsToUntrack[arg74] = true
    end

    table.insert(v135, arg74)
    arg71:trackItem(arg74)

    function v135() --[[ triggerCallback ]] -- line: 825
        -- upvalues:
        --  [1] arg75 (copy)
        --  [2] arg71 (copy)
        --  [3] arg74 (copy)

        arg75()

        if arg71.itemsToUntrack[arg74] then
            arg71.itemsToUntrack[arg74] = nil
            arg71:untrackItem(arg74)
        end
    end

    if arg71:findItem(arg74) == arg73 then
        arg75()

        if arg71.itemsToUntrack[arg74] then
            local v138
            arg71.itemsToUntrack[arg74], v138 = nil, arg74
            arg71:untrackItem(v138)

            return
        end
    else
        local v139 = nil
        v139 = arg71[arg72]:Connect(function(arg76) -- line: 838
            -- upvalues:
            --  [1] v139 (ref)
            --  [2] arg74 (copy)
            --  [3] arg75 (copy)
            --  [4] arg71 (copy)

            if v139 and arg76 == arg74 then
                v139:Disconnect()
                v139 = nil
                arg75()

                if arg71.itemsToUntrack[arg74] then
                    arg71.itemsToUntrack[arg74] = nil
                    arg71:untrackItem(arg74)
                end
            end
        end)
    end
end

function v3.onItemEnter(arg77, ...) -- line: 860
    arg77:_onItemCallback("itemEntered", true, ...)
end

function v3.onItemExit(arg78, ...) -- line: 864
    arg78:_onItemCallback("itemExited", false, ...)
end

function v3.destroy(arg79) -- line: 868
    arg79:unbindFromGroup()
    arg79.janitor:destroy()
end

v3.Destroy = v3.destroy

return v3
