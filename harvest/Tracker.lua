-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone.ZoneController.Tracker
-- Class: ModuleScript
-- bytes: 9502

local Players = game:GetService("Players")
local _ = game:GetService("RunService").Heartbeat
local Signal_m = require(script.Parent.Parent.Signal)
local Janitor_m = require(script.Parent.Parent.Janitor)
local t = {}
t.__index = t
local t_1 = {}
t.trackers = t_1
t.itemAdded = Signal_m.new()
t.itemRemoved = Signal_m.new()
t.bodyPartsToIgnore = {
    UpperTorso = true,
    LowerTorso = true,
    Torso = true,
    LeftHand = true,
    RightHand = true,
    LeftFoot = true,
    RightFoot = true
}

function t.getCombinedTotalVolumes() -- line: 35
    -- upvalues:
    --  [1] t_1 (copy)

    local v1 = 0

    for key, _ in pairs(t_1) do
        v1 += key.totalVolume
    end

    return v1
end

function t.getCharacterSize(arg1) -- line: 43
    local v2 = arg1

    if v2 then
        v2 = arg1:FindFirstChild("Head")
    end

    local v3 = arg1

    if v3 then
        v3 = arg1:FindFirstChild("HumanoidRootPart")
    end

    if not v3 or not v2 then
        return nil
    end

    if not v2:IsA("BasePart") then
        v2 = v3
    end

    local Y = v2.Size.Y
    v2 = v3.Size

    return v2 * Vector3.new(2, 2, 1) + Vector3.new(0, Y, 0), v3.CFrame * CFrame.new(
        0,
        Y / 2 - v2.Y / 2,
        0
    )
end

function t.new(arg2) -- line: 60
    -- upvalues:
    --  [1] t (copy)
    --  [2] Janitor_m (copy)
    --  [3] Players (copy)
    --  [4] t_1 (copy)

    local t_2 = {}
    setmetatable(t_2, t)
    t_2.name = arg2
    t_2.totalVolume = 0
    t_2.parts = {}
    t_2.partToItem = {}
    t_2.items = {}
    t_2.whitelistParams = nil
    t_2.characters = {}
    t_2.baseParts = {}
    t_2.exitDetections = {}
    t_2.janitor = Janitor_m.new()

    if arg2 == "player" then
        local function updatePlayerCharacters() -- line: 76
            -- upvalues:
            --  [1] Players (ref)
            --  [2] t_2 (copy)

            local t_3 = {}

            for _, val_1 in pairs(Players:GetPlayers()) do
                local Character = val_1.Character

                if Character then
                    t_3[Character] = true
                end
            end

            t_2.characters = t_3
        end

        local function playerAdded(arg3) -- line: 87
            -- upvalues:
            --  [1] updatePlayerCharacters (copy)
            --  [2] t_2 (copy)

            local function charAdded(arg4) -- line: 88
                -- upvalues:
                --  [1] updatePlayerCharacters (ref)
                --  [2] t_2 (ref)

                local Humanoid = arg4:WaitForChild("Humanoid", 3)

                if Humanoid then
                    updatePlayerCharacters()
                    t_2:update()

                    for _, val_2 in pairs(Humanoid:GetChildren()) do
                        if val_2:IsA("NumberValue") then
                            val_2.Changed:Connect(function() -- line: 95
                                -- upvalues:
                                --  [1] t_2 (ref)

                                t_2:update()
                            end)
                        end
                    end
                end
            end

            if arg3.Character then
                charAdded(arg3.Character)
            end

            arg3.CharacterAdded:Connect(charAdded)
            arg3.CharacterRemoving:Connect(function(character) -- line: 106
                -- upvalues:
                --  [1] t_2 (ref)

                t_2.exitDetections[character] = nil
            end)
        end

        Players.PlayerAdded:Connect(playerAdded)

        for _, val_3 in pairs(Players:GetPlayers()) do
            playerAdded(val_3)
        end

        Players.PlayerRemoving:Connect(function(_) -- line: 116
            -- upvalues:
            --  [1] updatePlayerCharacters (copy)
            --  [2] t_2 (copy)

            updatePlayerCharacters()
            t_2:update()
        end)
    elseif arg2 == "item" then
        local _ = function(arg7, arg8) --[[ updateItem ]] -- line: 123
            -- upvalues:
            --  [1] t_2 (copy)

            if arg7.isCharacter then
                t_2.characters[arg7.item] = arg8
            elseif arg7.isBasePart then
                t_2.baseParts[arg7.item] = arg8
            end

            t_2:update()
        end

        t.itemAdded:Connect(function(arg9) -- line: 131
            -- upvalues:
            --  [1] t_2 (copy)

            if arg9.isCharacter then
                t_2.characters[arg9.item] = true
            elseif arg9.isBasePart then
                t_2.baseParts[arg9.item] = true
            end

            t_2:update()
        end)
        t.itemRemoved:Connect(function(arg10) -- line: 134
            -- upvalues:
            --  [1] t_2 (copy)

            t_2.exitDetections[arg10.item] = nil

            if arg10.isCharacter then
                t_2.characters[arg10.item] = nil
            elseif arg10.isBasePart then
                t_2.baseParts[arg10.item] = nil
            end

            t_2:update()
        end)
    end

    t_1[t_2] = true
    task.defer(t_2.update, t_2)

    return t_2
end

function t._preventMultiFrameUpdates(arg11, arg12, ...) -- line: 148
    local v10 = arg11._preventMultiDetails or {}
    arg11._preventMultiDetails = v10
    v10 = arg11._preventMultiDetails[arg12]

    if not v10 then
        v10 = { calling = false, callsThisFrame = 0, updatedThisFrame = false }
        arg11._preventMultiDetails[arg12] = v10
    end

    v10.callsThisFrame += 1

    if v10.callsThisFrame == 1 then
        local t_4 = table.pack(...)
        task.defer(function() -- line: 165
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] arg11 (copy)
            --  [3] arg12 (copy)
            --  [4] t_4 (copy)

            local CallsThisFrame = v10.callsThisFrame
            v10.callsThisFrame = 0

            if CallsThisFrame > 1 then
                arg11[arg12](arg11, unpack(t_4))
            end
        end)

        return false
    end

    return true
end

function t.update(arg13) -- line: 177
    -- upvalues:
    --  [1] t (copy)
    --  [2] Janitor_m (copy)

    if arg13:_preventMultiFrameUpdates("update") then
        return
    end

    arg13.totalVolume = 0
    arg13.parts = {}
    arg13.partToItem = {}
    arg13.items = {}
    local Janitor

    for key_4, _ in pairs(arg13.characters) do
        local v13 = t.getCharacterSize(key_4)

        if v13 then
            local v14 = v13.X * v13.Y
            local TotalVolume = arg13.totalVolume
            TotalVolume += v14 * v13.Z
            arg13.totalVolume = TotalVolume
            Janitor = arg13.janitor:add(
                Janitor_m.new(),
                "destroy",
                "trackCharacterParts-" .. arg13.name
            )

            local _ = function(arg14) --[[ updateTrackerOnParentChanged ]] -- line: 198
                -- upvalues:
                --  [1] Janitor (ref)
                --  [2] arg13 (copy)

                Janitor:add(arg14.AncestryChanged:Connect(function() -- line: 199
                    -- upvalues:
                    --  [1] arg14 (copy)
                    --  [2] Janitor (ref)
                    --  [3] arg13 (ref)

                    if not arg14:IsDescendantOf(game) and arg14.Parent == nil and Janitor ~= nil then
                        Janitor:destroy()
                        Janitor = nil
                        arg13:update()
                    end
                end), "Disconnect")
            end

            for _, val_5 in pairs(key_4:GetChildren()) do
                if val_5:IsA("BasePart") and not t.bodyPartsToIgnore[val_5.Name] then
                    arg13.partToItem[val_5] = key_4
                    table.insert(arg13.parts, val_5)
                    Janitor:add(val_5.AncestryChanged:Connect(function() -- line: 199
                        -- upvalues:
                        --  [1] val_5 (copy)
                        --  [2] Janitor (ref)
                        --  [3] arg13 (copy)

                        if not val_5:IsDescendantOf(game) and val_5.Parent == nil and Janitor ~= nil then
                            Janitor:destroy()
                            Janitor = nil
                            arg13:update()
                        end
                    end), "Disconnect")
                end
            end

            Janitor:add(key_4.AncestryChanged:Connect(function() -- line: 199
                -- upvalues:
                --  [1] key_4 (copy)
                --  [2] Janitor (ref)
                --  [3] arg13 (copy)

                if not key_4:IsDescendantOf(game) and key_4.Parent == nil and Janitor ~= nil then
                    Janitor:destroy()
                    Janitor = nil
                    arg13:update()
                end
            end), "Disconnect")
            table.insert(arg13.items, key_4)
        end
    end

    for key_6, _ in pairs(arg13.baseParts) do
        local Size = key_6.Size
        local v22 = Size.X * Size.Y
        local TotalVolume_1 = arg13.totalVolume
        TotalVolume_1 += v22 * Size.Z
        arg13.totalVolume = TotalVolume_1
        arg13.partToItem[key_6] = key_6
        table.insert(arg13.parts, key_6)
        table.insert(arg13.items, key_6)
    end

    arg13.whitelistParams = OverlapParams.new()
    arg13.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
    arg13.whitelistParams.MaxParts = #arg13.parts
    arg13.whitelistParams.FilterDescendantsInstances = arg13.parts
end

return t
