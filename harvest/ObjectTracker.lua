-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ObjectTracker
-- Class: ModuleScript
-- bytes: 8381

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local t = {}
local t_1 = {}
local t_2 = {}

local _ = function() --[[ getRootPosition ]] -- line: 20
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local Character = LocalPlayer.Character
    local v1 = Character

    if v1 then
        v1 = Character:FindFirstChild("HumanoidRootPart")
    end

    return v1 and v1.Position
end

local function getAnchor(arg1) -- line: 27
    if arg1:IsA("BasePart") then
        return arg1
    end

    if arg1:IsA("Model") then
        return arg1.PrimaryPart
    end

    return nil
end

local function getPosition(arg2) -- line: 36
    local v3 = if arg2:IsA("BasePart") then arg2 else if arg2:IsA("Model") then arg2.PrimaryPart else nil

    return v3 and v3.Position
end

local function scanClosest(arg3, arg4) -- line: 41
    -- upvalues:
    --  [1] CollectionService (copy)

    local v5 = math.huge
    local v6 = nil
    local Magnitude

    for _, val in CollectionService:GetTagged(arg3.tag) do
        local v7 = if val:IsA("BasePart") then val else if val:IsA("Model") then val.PrimaryPart else nil
        local v8 = v7

        if v8 then
            v8 = v7.Position
        end

        if v8 then
            if arg3.filterFn then
                if arg3.filterFn(val) then
                    Magnitude = (arg4 - v8).Magnitude

                    if v5 > Magnitude then
                        v5 = Magnitude
                        v6 = val
                    end
                end
            else
                Magnitude = (arg4 - v8).Magnitude

                if v5 > Magnitude then
                    v5 = Magnitude
                    v6 = val
                end
            end
        end
    end

    return v6
end

local function setClosest(arg5, arg6, arg7) -- line: 66
    -- upvalues:
    --  [1] t_1 (copy)

    if arg6.closest == arg7 then
        return
    end

    arg6.closest = arg7
    local v9 = t_1[arg5]

    if not v9 then
        return
    end

    local v10 = arg7

    if v10 then
        local v11 = if arg7:IsA("BasePart") then arg7 else if arg7:IsA("Model") then arg7.PrimaryPart else nil
        v10 = v11 and v11.Position
    end

    local Success, Result = pcall(v9, arg5, arg7, v10)

    if not Success then
        warn(`ObjectTracker callback "{arg5}" errored: {Result}`)
    end
end

local _ = function(arg8) --[[ disconnect ]] -- line: 83
    if arg8.removedConn then
        arg8.removedConn:Disconnect()
        arg8.removedConn = nil
    end

    if arg8.addedConn then
        arg8.addedConn:Disconnect()
        arg8.addedConn = nil
    end
end

RunService.Heartbeat:Connect(function() -- line: 97
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] t (copy)
    --  [3] setClosest (copy)
    --  [4] scanClosest (copy)

    local Character_1 = LocalPlayer.Character
    local v12 = Character_1

    if v12 then
        v12 = Character_1:FindFirstChild("HumanoidRootPart")
    end

    local v13 = v12

    if v13 then
        v13 = v12.Position
    end

    if not v13 then
        return
    end

    local clock = os.clock()

    for key_1, val_1 in t do
        if val_1.active and not (clock - val_1.lastScan < val_1.interval) then
            val_1.lastScan = clock
            setClosest(key_1, val_1, (scanClosest(val_1, v13)))
        end
    end
end)
local t_3 = { GetAnchor = getAnchor, GetPosition = getPosition }

function t_3.Register(arg9, arg10, arg11, arg12) -- line: 121
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_2 (copy)
    --  [3] t_3 (copy)

    local v15 = t[arg9]

    if v15 then
        v15.active = false

        if v15.removedConn then
            v15.removedConn:Disconnect()
            v15.removedConn = nil
        end

        if v15.addedConn then
            v15.addedConn:Disconnect()
            v15.addedConn = nil
        end
    end

    t[arg9] = {
        tag = arg10,
        filterFn = arg11,
        interval = arg12 or 0.5,
        closest = nil,
        active = false,
        lastScan = 0,
        addedConn = nil,
        removedConn = nil
    }

    if t_2[arg9] then
        t_2[arg9] = nil
        t_3.StartTracking(arg9)
    end
end

function t_3.OnClosestChanged(arg13, arg14) -- line: 147
    -- upvalues:
    --  [1] t_1 (copy)

    t_1[arg13] = arg14
end

function t_3.StartTracking(arg15) -- line: 151
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_2 (copy)
    --  [3] CollectionService (copy)
    --  [4] LocalPlayer (copy)
    --  [5] setClosest (copy)
    --  [6] scanClosest (copy)

    local v16 = t[arg15]

    if not v16 then
        t_2[arg15] = true

        return
    end

    if v16.active then
        return
    end

    v16.active = true
    v16.lastScan = 0
    v16.removedConn = CollectionService:GetInstanceRemovedSignal(v16.tag):Connect(function(arg16) -- line: 166
        -- upvalues:
        --  [1] v16 (copy)
        --  [2] LocalPlayer (ref)
        --  [3] setClosest (ref)
        --  [4] arg15 (copy)
        --  [5] scanClosest (ref)

        if v16.closest ~= arg16 then
            return
        end

        local Character_2 = LocalPlayer.Character
        local v18 = Character_2

        if v18 then
            v18 = Character_2:FindFirstChild("HumanoidRootPart")
        end

        local v19 = v18

        if v19 then
            v19 = v18.Position
        end

        setClosest(arg15, v16, v19 and scanClosest(v16, v19) or nil)
    end)
    v16.addedConn = CollectionService:GetInstanceAddedSignal(v16.tag):Connect(function(arg17) -- line: 174
        -- upvalues:
        --  [1] LocalPlayer (ref)
        --  [2] v16 (copy)
        --  [3] setClosest (ref)
        --  [4] arg15 (copy)

        local Character_3 = LocalPlayer.Character
        local v22 = Character_3

        if v22 then
            v22 = Character_3:FindFirstChild("HumanoidRootPart")
        end

        local v23 = v22

        if v23 then
            v23 = v22.Position
        end

        if not v23 then
            return
        end

        if v16.filterFn and not v16.filterFn(arg17) then
            return
        end

        v22 = if arg17:IsA("BasePart") then arg17 else if arg17:IsA("Model") then arg17.PrimaryPart else nil
        local v24 = v22

        if v24 then
            v24 = v22.Position
        end

        if not v24 then
            return
        end

        v22 = v16.closest
        local v25 = v22

        if v25 then
            local v26 = if v22:IsA("BasePart") then v22 else if v22:IsA("Model") then v22.PrimaryPart else nil
            v25 = v26

            if v25 then
                v25 = v26.Position
            end
        end

        if v25 and (v23 - v25).Magnitude <= (v23 - v24).Magnitude then
            return
        end

        setClosest(arg15, v16, arg17)
    end)
end

function t_3.StopTracking(arg18) -- line: 198
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t (copy)
    --  [3] t_1 (copy)

    t_2[arg18] = nil
    local v27 = t[arg18]

    if not v27 then
        return
    end

    v27.active = false

    if v27.removedConn then
        v27.removedConn:Disconnect()
        v27.removedConn = nil
    end

    if v27.addedConn then
        v27.addedConn:Disconnect()
        v27.addedConn = nil
    end

    if v27.closest == nil then
        return
    end

    v27.closest = nil
    local v28 = t_1[arg18]

    if not v28 then
        return
    end

    local Success_1, Result_1 = pcall(v28, arg18, nil, nil)

    if not Success_1 then
        warn(`ObjectTracker callback "{arg18}" errored: {Result_1}`)
    end
end

function t_3.Unregister(arg19) -- line: 211
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t (copy)
    --  [3] t_1 (copy)
    --  [4] t_2 (copy)

    t_3.StopTracking(arg19)
    t[arg19] = nil
    t_1[arg19] = nil
    t_2[arg19] = nil
end

function t_3.GetClosest(arg20) -- line: 218
    -- upvalues:
    --  [1] t (copy)

    local v29 = t[arg20]

    return v29 and v29.closest or nil
end

function t_3.IsRegistered(arg21) -- line: 223
    -- upvalues:
    --  [1] t (copy)

    return t[arg21] ~= nil
end

function t_3.IsTracking(arg22) -- line: 227
    -- upvalues:
    --  [1] t (copy)

    local v32 = t[arg22]

    return if v32 == nil then false else v32.active
end

return t_3
