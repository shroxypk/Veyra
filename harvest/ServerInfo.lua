-- Decompiled with Veyra harvester
-- Instance: StarterGui.List.List.Contents.Server.ServerInfo
-- Class: LocalScript
-- bytes: 3362

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Parent = script.Parent
local ServerID = Parent.ServerID
local ServerLocation = Parent.ServerLocation
local ServerClock = Parent.ServerClock
local LocalPlayer = Players.LocalPlayer
local Stats = Parent.Stats
local v2 = ReplicatedStorage:WaitForChild("GameVersion"):GetAttribute("Date") or "?"
local t = table.create(60)
local v3 = 0

local _ = function(arg1) --[[ convertSeconds ]] -- line: 19
    arg1 = arg1 or 0
    local v4 = math.floor(arg1 / 60) % 60
    local v5 = math.floor(arg1 / 3600) % 24

    return math.floor(arg1 / 86400) .. "d " .. v5 .. "h " .. v4 .. "m"
end

local function SetServerID() -- line: 27
    -- upvalues:
    --  [1] ServerID (copy)
    --  [2] ReplicatedStorage (copy)

    ServerID.Text = tostring(ReplicatedStorage.ServerID.Value)
end

local function SetServerLocation() -- line: 31
    -- upvalues:
    --  [1] ServerLocation (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] v2 (copy)

    ServerLocation.Text = ReplicatedStorage.ServerLocation.Value .. " | " .. string.lower(
        "crpg." .. v2
    )
end

local function SetClock() -- line: 35
    -- upvalues:
    --  [1] ServerClock (copy)
    --  [2] ReplicatedStorage (copy)

    local v8 = ServerClock
    local v9 = ReplicatedStorage:GetAttribute("ServerTime") or 0
    local v10 = math.floor(v9 / 60) % 60
    local v11 = math.floor(v9 / 3600) % 24
    v8.Text = math.floor(v9 / 86400) .. "d " .. v11 .. "h " .. v10 .. "m"
end

local _ = function() --[[ getTotalDT ]] -- line: 39
    -- upvalues:
    --  [1] t (copy)

    local v12 = 0

    for _, val in ipairs(t) do
        v12 += 1 / val
    end

    return v12 / math.max(#t, 1)
end

ReplicatedStorage:GetAttributeChangedSignal("ServerTime"):Connect(SetClock)
ReplicatedStorage:WaitForChild("ServerID"):GetPropertyChangedSignal("Value"):Connect(SetServerID)
ReplicatedStorage:WaitForChild("ServerLocation"):GetPropertyChangedSignal("Value"):Connect(
    SetServerLocation
)
Services_m.RunService.RenderStepped:Connect(function(deltaTime) -- line: 51
    -- upvalues:
    --  [1] t (copy)
    --  [2] v3 (ref)
    --  [3] Stats (copy)
    --  [4] LocalPlayer (copy)

    if #t == 60 then
        table.remove(t, 1)
    end

    table.insert(t, deltaTime)
    local v13 = _G
    local v14 = 0

    for _, val_1 in ipairs(t) do
        v14 += 1 / val_1
    end

    local v15 = math.floor(v14 / math.max(#t, 1))
    v13.FramesPS = math.min(v15, 500)
    local clock = os.clock()

    if clock - v3 < 0.5 then
        return
    end

    v3 = clock
    local color = Color3.fromRGB(255, 80, 80):Lerp(
        Color3.fromRGB(0, 230, 0),
        (math.clamp(_G.FramesPS / 50, 0, 1))
    )
    Stats.Text = string.format(
        "%d | <font color='#%s'>%d</font>",
        LocalPlayer.UserId,
        color:ToHex(),
        _G.FramesPS
    )
end)
ServerID.Text = tostring(ReplicatedStorage.ServerID.Value)
ServerLocation.Text = ReplicatedStorage.ServerLocation.Value .. " | " .. string.lower("crpg." .. v2)
local v19 = ReplicatedStorage:GetAttribute("ServerTime") or 0
local v20 = math.floor(v19 / 60) % 60
local v21 = math.floor(v19 / 3600) % 24
ServerClock.Text = math.floor(v19 / 86400) .. "d " .. v21 .. "h " .. v20 .. "m"
