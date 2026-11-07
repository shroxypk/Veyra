-- Decompiled with Veyra harvester
-- Instance: StarterGui.Permanent.Window.ServerList.ServerListClient
-- Class: LocalScript
-- bytes: 12863

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Modules = ReplicatedStorage.Modules
local Permissions_m = require(Modules.Permissions)
local Icon_m = require(Modules.Icon)
local Parent = script.Parent
local Friends = Parent.Friends
local Servers = Parent.Servers
local Box = Parent.Top.SearchBar.Box
local Error = Servers.Error
local AvailableRegions = Parent.AvailableRegions
local PlaceholderText = Box.PlaceholderText
local v2 = Icon_m.new()
v2:setImage(9692125126)
v2:setOrder(5)
v2:bindToggleItem(Parent)
_G.CanTeleport = true

function Teleport(arg1, arg2, arg3) -- line: 45
    -- upvalues:
    --  [1] PlayerGui (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] v2 (copy)

    if PlayerGui:FindFirstChild("TeleprotScreen") then
        return
    end

    local v3, v4 = ReplicatedStorage.Remotes.Teleport:InvokeServer(arg1, arg2, arg3)

    if not v3 then
        return false, v4
    end

    PlayerGui:WaitForChild("Gameplay").Enabled = false
    v2:deselect()
    ReplicatedStorage.UI.TeleportScreen:Clone().Parent = PlayerGui

    return true
end

local t = {}
local v5 = false

local function LoadFriends() -- line: 75
    -- upvalues:
    --  [1] Players (copy)
    --  [2] LocalPlayer (copy)
    --  [3] t (copy)

    local Success, Result = pcall(Players.GetFriendsAsync, Players, LocalPlayer.UserId)

    if not Success then
        return
    end

    for _ = 1, 10 do
        for _, val in Result:GetCurrentPage() do
            t[val.Id] = true
        end

        if Result.IsFinished then
            break
        end

        if not pcall(Result.AdvanceToNextPageAsync, Result) then
            break
        end
    end
end

local _ = function(arg4) --[[ AddPlayer ]] -- line: 91
    -- upvalues:
    --  [1] Players (copy)
    --  [2] Friends (copy)

    local v6 = script.PlayerInstance:Clone()
    v6.PlayerName.Text = Players:GetNameFromUserIdAsync(arg4)
    v6.PlayerImage.Icon.Image = `https://www.roblox.com/headshot-thumbnail/image?userId={arg4}&width=420&height=420&format=png`
    v6.Parent = Friends.Players
end

local function ClearFrame() -- line: 98
    -- upvalues:
    --  [1] Friends (copy)

    for _, child in pairs(Friends.Players:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
end

local t_1 = {}
local t_2 = {}
local v8 = "All"
local v9 = ""
local t_3 = {}
local t_4 = { "NA", "EU", "ASIA" }
local t_5 = {}

local _ = function(arg5) --[[ SetRegionText ]] -- line: 124
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] t_2 (copy)

    local v10 = t_5[arg5]

    if v10 then
        v10.Display.Label.Text = `{arg5} ({t_2[arg5] or 0})`
    end
end

local v11 = nil

local function CreateContents(arg6) -- line: 131
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] v8 (ref)
    --  [3] v11 (ref)
    --  [4] t_2 (copy)
    --  [5] AvailableRegions (copy)

    if t_5[arg6] then
        return
    end

    local v12 = script.RegionTemplate:Clone()
    v12.Name = arg6
    t_5[arg6] = v12
    v12.Button.MouseButton1Up:Connect(function() -- line: 140
        -- upvalues:
        --  [1] v8 (ref)
        --  [2] arg6 (copy)
        --  [3] v11 (ref)

        v8 = arg6
        v11()
    end)
    local v13 = t_5[arg6]

    if v13 then
        v13.Display.Label.Text = `{arg6} ({t_2[arg6] or 0})`
    end

    v12.Parent = AvailableRegions
end

local t_6 = {}
CreateContents("All")

local function BuildServer(arg7) -- line: 152
    -- upvalues:
    --  [1] Friends (copy)
    --  [2] ClearFrame (copy)
    --  [3] Players (copy)

    local Info = arg7.Info
    local v14 = script.ServerInstance:Clone()
    v14.Name = Info.ID
    local Info_1 = v14.Info
    Info_1.ID.Text = Info.ID
    Info_1.Location.Text = arg7.Region
    Info_1.UpTime.Text = Info.UpTime or "0d 0h 0m"
    local v15 = #Info.Players
    Info_1.Players.Text = `{v15}/{Info.MaxPlayers} Players`
    v14.MouseButton1Up:Connect(function() -- line: 164
        -- upvalues:
        --  [1] Info (copy)

        Teleport("ServerJoin", Info.ServerID, Info.PlaceID)
    end)
    v14.MouseEnter:Connect(function() -- line: 168
        -- upvalues:
        --  [1] Friends (ref)
        --  [2] ClearFrame (ref)
        --  [3] Info (copy)
        --  [4] arg7 (copy)
        --  [5] Players (ref)

        Friends.Visible = true
        ClearFrame()
        Friends.Header.Text = "Friends in " .. Info.ID .. "..."

        for _, val_1 in arg7.Friends do
            local v16 = script.PlayerInstance:Clone()
            v16.PlayerName.Text = Players:GetNameFromUserIdAsync(val_1)
            v16.PlayerImage.Icon.Image = `https://www.roblox.com/headshot-thumbnail/image?userId={val_1}&width=420&height=420&format=png`
            v16.Parent = Friends.Players
        end
    end)
    v14.MouseLeave:Connect(function() -- line: 178
        -- upvalues:
        --  [1] Friends (ref)

        Friends.Visible = false
    end)

    if next(arg7.Friends) then
        v14.Name = "/" .. v14.Name
        v14.Outline.ImageColor3 = Color3.fromRGB(153, 255, 98)
    end

    return v14
end

local function BuildSpecial(arg8, arg9) -- line: 190
    -- upvalues:
    --  [1] t_4 (copy)

    local v18 = script[`.{arg8}ServerInstance`]:Clone()

    if arg8 == "Tester" then
        v18.MouseButton1Up:Connect(function() -- line: 194
            Teleport("TesterJoin", nil, 8248288152)
        end)

        return v18
    end

    if arg8 == "CC" then
        local Name = v18.Name
        local v19 = table.find(t_4, arg9)
        v18.Name = Name .. `{v19}{arg9}`
        v18.Info.Location.Text = `Content Creator ({arg9})`
        v18.MouseButton1Up:Connect(function() -- line: 201
            -- upvalues:
            --  [1] arg9 (copy)

            Teleport("CCJoin", arg9, 8248288152)
        end)

        return v18
    end

    if arg8 == "Developer" then
        v18.MouseButton1Up:Connect(function() -- line: 205
            Teleport("DeveloperJoin", nil, 8248288152)
        end)
    end

    return v18
end

local _ = function(arg10) --[[ Matches ]] -- line: 213
    -- upvalues:
    --  [1] v8 (ref)
    --  [2] v9 (ref)

    return if v8 == "All" then v9 == "" or string.find(arg10.SearchKey, v9, 1, true) ~= nil else if arg10.Region ~= v8 then false else v9 == "" or string.find(
        arg10.SearchKey,
        v9,
        1,
        true
    ) ~= nil
end

local v21 = 0

function v11() --[[ RenderList ]] -- line: 220
    -- upvalues:
    --  [1] v21 (ref)
    --  [2] t_6 (copy)
    --  [3] t_1 (copy)
    --  [4] v8 (ref)
    --  [5] v9 (ref)
    --  [6] t_3 (copy)
    --  [7] Box (copy)
    --  [8] PlaceholderText (copy)
    --  [9] Error (copy)
    --  [10] BuildServer (copy)
    --  [11] Servers (copy)

    v21 += 1
    local v22 = v21

    for _, val_2 in t_6 do
        val_2:Destroy()
    end

    table.clear(t_6)
    local t_7 = {}
    local t_8 = {}
    local v23 = 0

    for _, val_3 in t_1 do
        if if v8 == "All" then v9 == "" or string.find(val_3.SearchKey, v9, 1, true) ~= nil else if val_3.Region ~= v8 then false else v9 == "" or string.find(
            val_3.SearchKey,
            v9,
            1,
            true
        ) ~= nil then
            v23 += 1

            if next(val_3.Friends) then
                table.insert(t_7, val_3)
            elseif #t_8 < 50 then
                table.insert(t_8, val_3)
            end
        end
    end

    local v25 = 0

    for _, val_4 in t_3 do
        local v26 = false

        if v8 == "All" then
            v26 = true

            if v9 ~= "" then
                v26 = if string.find(string.upper(val_4.Name), v9, 1, true) == nil then false else true
            end
        end

        val_4.Visible = v26

        if val_4.Visible then
            v25 += 1
        end
    end

    Box.PlaceholderText = if v23 > 50 then `{PlaceholderText} ({50} of {v23} shown)` else PlaceholderText
    local v29 = Error
    v29.Visible = if v23 ~= 0 then false else v25 == 0
    v25 = 0

    for _, val_5 in { t_7, t_8 } do
        for _, val_6 in val_5 do
            if v25 >= 50 then
                return
            end

            v23 = BuildServer(val_6)
            v23.Parent = Servers
            table.insert(t_6, v23)
            v25 += 1

            if v25 % 10 == 0 then
                task.wait()

                if v22 ~= v21 then
                    return
                end
            end
        end
    end
end

local function ServerUI(arg11) -- line: 279
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t_2 (copy)
    --  [3] t (copy)
    --  [4] CreateContents (copy)
    --  [5] t_5 (copy)
    --  [6] v8 (ref)
    --  [7] v11 (ref)

    table.clear(t_1)
    table.clear(t_2)

    for _, val_7 in arg11 do
        if typeof(val_7) == "table" then
            local v30 = val_7.Location or "Server Location Unknown"
            local t_9 = {}

            for _, val_8 in val_7.Players do
                if t[val_8] then
                    table.insert(t_9, val_8)
                end
            end

            local t_10 = { Info = val_7, Region = v30, SearchKey = nil, Friends = nil }
            local v32 = t_1
            t_10.SearchKey = string.upper((tostring(val_7.ID)))
            t_10.Friends = t_9
            table.insert(v32, t_10)
            t_2[v30] = (t_2[v30] or 0) + 1
            CreateContents(v30)
        end
    end

    t_2.All = #t_1

    for key_10 in t_5 do
        local v33 = t_5[key_10]

        if v33 then
            v33.Display.Label.Text = `{key_10} ({t_2[key_10] or 0})`
        end
    end

    if v8 ~= "All" and not t_2[v8] then
        v8 = "All"
    end

    v11()
end

local function AddSpecials() -- line: 320
    -- upvalues:
    --  [1] Permissions_m (copy)
    --  [2] LocalPlayer (copy)
    --  [3] t_4 (copy)
    --  [4] BuildSpecial (copy)
    --  [5] Servers (copy)
    --  [6] t_3 (copy)

    for _, val_9 in {
        { "Tester", Permissions_m:TesterAccess(LocalPlayer) },
        { "CC", Permissions_m:CanAccessCC(LocalPlayer) },
        { "Developer", Permissions_m:AccessAll(LocalPlayer) }
    } do
        if val_9[2] then
            for _, val_10 in if val_9[1] ~= "CC" then { false } else t_4 do
                local v35 = BuildSpecial(val_9[1], val_10)
                v35.Parent = Servers
                table.insert(t_3, v35)
            end
        end
    end
end

task.spawn(function() -- line: 336
    -- upvalues:
    --  [1] AddSpecials (copy)
    --  [2] LoadFriends (copy)
    --  [3] v5 (ref)
    --  [4] ServerUI (copy)
    --  [5] ReplicatedStorage (copy)

    AddSpecials()
    LoadFriends()
    v5 = true
    ServerUI(ReplicatedStorage:WaitForChild("Servers"):InvokeServer("Request"))
end)
local QuickActions = Parent.QuickActions
QuickActions.QuickJoin.Button.MouseButton1Up:Connect(function() -- line: 345
    Teleport("RandomJoin", nil, 8248288152)
end)
local Label_3 = QuickActions.Colosseum.Display.Label
local v37 = 0
local Text = Label_3.Text
QuickActions.Colosseum.Button.MouseButton1Up:Connect(function() -- line: 353
    -- upvalues:
    --  [1] v37 (ref)
    --  [2] Label_3 (copy)
    --  [3] Text (copy)

    local v38, v39 = Teleport("Colosseum")

    if not v38 and v39 then
        v37 += 1
        local v40 = v37
        Label_3.Text = v39
        task.delay(2, function() -- line: 362
            -- upvalues:
            --  [1] v40 (copy)
            --  [2] v37 (ref)
            --  [3] Label_3 (ref)
            --  [4] Text (ref)

            if v40 == v37 then
                Label_3.Text = Text
            end
        end)
    end
end)
QuickActions.Instances.Visible = Permissions_m:AccessAll(LocalPlayer)
QuickActions.Instances.Button.MouseButton1Up:Connect(function() -- line: 372
    Teleport("CloverInstances")
end)

local function refreshPressed() -- line: 376
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] ReplicatedStorage (copy)
    --  [3] ServerUI (copy)

    if not v5 then
        return
    end

    local v41 = ReplicatedStorage.Servers:InvokeServer("Refresh")

    if v41 then
        ServerUI(v41)
    end
end

Parent.Top.Refresh.MouseButton1Up:Connect(refreshPressed)
Box:GetPropertyChangedSignal("Text"):Connect(function() -- line: 390
    -- upvalues:
    --  [1] v9 (ref)
    --  [2] Box (copy)
    --  [3] v11 (ref)

    v9 = string.upper(Box.Text)
    v11()
end)
TeleportService.TeleportInitFailed:Connect(function(_, _, _) -- line: 395
    -- upvalues:
    --  [1] PlayerGui (copy)

    if PlayerGui:FindFirstChild("Gameplay") then
        PlayerGui:FindFirstChild("Gameplay").Enabled = true
    end
end)
