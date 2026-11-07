-- Decompiled with Veyra harvester
-- Instance: StarterGui.List.List.PlayerListHandle
-- Class: LocalScript
-- bytes: 25873

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)
local LocalPlayer = Players.LocalPlayer
local PlayerList = LocalPlayer:WaitForChild("Settings"):WaitForChild("PlayerList")
local Parent = script.Parent
local Contents = Parent.Contents
local Header = Contents.Header
local Toggle = Header.Toggle
local PlayerCount = Header.PlayerCount
local Panel = Contents.Panel
local Scrolling = Panel.Scrolling
local UIListLayout = Scrolling.UIListLayout
local Server = Contents.Server
local Info = Parent.Info
local Actions = Parent.Actions
local Template = script.Template
local color = Color3.fromRGB(169, 255, 179)
local color_1 = Color3.fromRGB(188, 209, 255)
local color_2 = Color3.fromRGB(150, 150, 150)
local RankColors = script.RankColors
local t_3 = {}
local t_4 = {
    { MaxPlace = 10, Gradient = RankColors.Top10 },
    { MaxPlace = 50, Gradient = RankColors.Top50 },
    { MaxPlace = 100, Gradient = RankColors.Top100 }
}
RunService.Heartbeat:Connect(function() -- line: 53
    -- upvalues:
    --  [1] Panel (copy)
    --  [2] t_3 (copy)

    local vec2

    if Panel.Visible then
        if not next(t_3) then
            return
        end

        vec2 = Vector2.new(os.clock() / 2.5 % 1 * 2 - 1, 0)

        for key in t_3 do
            if key.Parent then
                key.Offset = vec2
            else
                t_3[key] = nil
            end
        end

        return
    else
        return
    end
end)

local _ = function(s1: string) --[[ escapeRichText ]] -- line: 67
    return (s1:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local t_5 = {
    Captain = "rbxassetid://17783123674",
    ["Vice-Captain"] = "rbxassetid://5560210162",
    Officer = "",
    Member = ""
}
local t_6 = {}

local _ = function(arg1) --[[ getDictCount ]] -- line: 80
    if typeof(arg1) ~= "table" then
        return 1
    end

    local v3 = 0

    for _, _ in pairs(arg1) do
        v3 += 1
    end

    return v3
end

local function resize() -- line: 93
    -- upvalues:
    --  [1] Server (copy)
    --  [2] UIListLayout (copy)
    --  [3] Scrolling (copy)

    local CurrentCamera = workspace.CurrentCamera
    local v4 = CurrentCamera and CurrentCamera.ViewportSize.Y or 720
    local v5 = UIListLayout.AbsoluteContentSize.Y + 8
    local v6 = math.max(v4 * 0.5 - Server.AbsoluteSize.Y, 60)
    local v7 = math.min(v5, v6)
    Scrolling.Size = UDim2.new(1, 0, 0, v7)
end

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resize)
Server:GetPropertyChangedSignal("AbsoluteSize"):Connect(resize)

local function hookCamera() -- line: 105
    -- upvalues:
    --  [1] resize (copy)
    --  [2] Server (copy)
    --  [3] UIListLayout (copy)
    --  [4] Scrolling (copy)

    local CurrentCamera_1 = workspace.CurrentCamera

    if CurrentCamera_1 then
        CurrentCamera_1:GetPropertyChangedSignal("ViewportSize"):Connect(resize)
    end

    local CurrentCamera_2 = workspace.CurrentCamera
    local v9 = CurrentCamera_2 and CurrentCamera_2.ViewportSize.Y or 720
    local v10 = UIListLayout.AbsoluteContentSize.Y + 8
    local v11 = math.max(v9 * 0.5 - Server.AbsoluteSize.Y, 60)
    local v12 = math.min(v10, v11)
    Scrolling.Size = UDim2.new(1, 0, 0, v12)
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(hookCamera)
local CurrentCamera_3 = workspace.CurrentCamera
local color_3 = Color3.fromRGB(144, 105, 37)

if CurrentCamera_3 then
    CurrentCamera_3:GetPropertyChangedSignal("ViewportSize"):Connect(resize)
end

local CurrentCamera_4 = workspace.CurrentCamera
local v14 = CurrentCamera_4 and CurrentCamera_4.ViewportSize.Y or 720
local v15 = UIListLayout.AbsoluteContentSize.Y + 8
local v16 = math.max(v14 * 0.5 - Server.AbsoluteSize.Y, 60)
local v17 = math.min(v15, v16)
Scrolling.Size = UDim2.new(1, 0, 0, v17)

local function sortRows() -- line: 117
    -- upvalues:
    --  [1] t_6 (copy)

    local t_7 = {}

    for _, val_1 in t_6 do
        table.insert(t_7, val_1)
    end

    table.sort(t_7, function(arg2, arg3) -- line: 122
        local v18 = arg2.Alliance ~= ""

        if v18 ~= (if arg3.Alliance == "" then false else true) then
            return v18
        end

        if arg2.Alliance ~= arg3.Alliance then
            return arg2.Alliance:lower() < arg3.Alliance:lower() and true
        end

        return arg2.Identity:lower() < arg3.Identity:lower() and true
    end)

    for key_4, val_2 in t_7 do
        val_2.Row.LayoutOrder = key_4
    end
end

local _ = function(arg4, arg5) --[[ placePopup ]] -- line: 139
    -- upvalues:
    --  [1] Contents (copy)

    local CurrentCamera_5 = workspace.CurrentCamera
    local v23 = CurrentCamera_5 and CurrentCamera_5.ViewportSize.Y or 720
    local Y = arg5.AbsolutePosition.Y
    local FromOffset = UDim2.fromOffset
    local v24 = Contents.AbsolutePosition.X - 8
    local v25 = math.max(v23 - arg4.AbsoluteSize.Y - 10, 10)
    arg4.Position = FromOffset(v24, (math.clamp(Y, 10, v25)))
end

function _G.GetAllianceInfo(arg6) -- line: 149
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if arg6 == "" then
        return {}
    end

    local v26 = ReplicatedStorage.Remotes.Alliance:InvokeServer("GetClanInfo", arg6) or {}
    local v27 = v26.ClanLogo

    if v27 then
        v27 = string.match(v26.ClanLogo, "rbxassetid://") and v26.ClanLogo or "rbxassetid://" .. v26.ClanLogo
    end

    v26.ClanLogo = v27

    return v26
end

local t_8 = {}

local function getOwner(arg7) -- line: 160
    -- upvalues:
    --  [1] t_8 (copy)
    --  [2] Players (copy)

    if t_8[arg7] then
        return t_8[arg7]
    end

    for _ = 1, 5 do
        local Success, Result = pcall(Players.GetNameFromUserIdAsync, Players, arg7)

        if Success then
            t_8[arg7] = Result

            return Result
        end

        task.wait(0.1)
    end
end

local function UpdateUI(u1: userdata) -- line: 176
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] Template (copy)
    --  [3] StatManager_m (copy)
    --  [4] t_4 (copy)
    --  [5] t_3 (copy)
    --  [6] color_2 (copy)
    --  [7] TweenService (copy)
    --  [8] sortRows (copy)
    --  [9] t_5 (copy)
    --  [10] color_1 (copy)
    --  [11] color (copy)
    --  [12] ReplicatedStorage (copy)
    --  [13] Actions (copy)
    --  [14] getOwner (copy)
    --  [15] Info (copy)
    --  [16] color_3 (copy)
    --  [17] Contents (copy)
    --  [18] LocalPlayer (copy)
    --  [19] Scrolling (copy)

    if t_6[u1] then
        return
    end

    local v28 = Template:Clone()
    v28:SetAttribute("RealName", u1.Name)
    v28.Name = u1.Name
    v28.Size = UDim2.new(1, 0, 0, 26)
    local t_9 = { Row = v28, Alliance = "", Identity = u1.Name }
    t_6[u1] = t_9
    local v30 = StatManager_m.require(u1)
    local CharacterName = u1:WaitForChild("CustomizeFolder"):WaitForChild("CharacterName")
    local Value = CharacterName.Value
    t_9.Identity = Value
    local Display = v28.Display
    local Alliance = Display.Alliance
    local Label = Alliance.Label
    local Icon = Alliance.Icon
    local SquadIcon = v28.SquadIcon
    local PlayerName = Display.PlayerName
    local v32 = false
    local v33 = nil

    local _ = function() --[[ showName ]] -- line: 206
        -- upvalues:
        --  [1] v32 (ref)
        --  [2] u1 (copy)
        --  [3] Value (ref)
        --  [4] v33 (ref)
        --  [5] PlayerName (copy)

        local v35 = (v32 and u1.Name or Value):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )

        if v33 then
            v35 ..= ` <font size="{13}" transparency="0.35">(#{v33})</font>`
        end

        PlayerName.Text = v35
    end

    PlayerName.RichText = true
    local v40 = (v32 and u1.Name or Value):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")

    if v33 then
        local v41 = v33
        v40 = v40 .. ` <font size="{13}" transparency="0.35">(#{v41})</font>`
    end

    PlayerName.Text = v40

    local function setHasAlliance(arg8) -- line: 217
        -- upvalues:
        --  [1] Alliance (copy)
        --  [2] SquadIcon (copy)
        --  [3] Display (copy)
        --  [4] v28 (copy)

        Alliance.Visible = arg8
        local v42 = arg8 and SquadIcon.Image ~= ""
        SquadIcon.Visible = v42
        local Visible = SquadIcon.Visible
        local v43 = if not Visible then 0 else 31
        Display.Position = UDim2.new(0, v43, 0, 0)
        local v45 = if not Visible then 0 else 31
        Display.Size = UDim2.new(1, -v45, 1, 0)
        local v47 = if not arg8 then 26 else 40
        v28.Size = UDim2.new(1, 0, 0, v47)
    end

    local v49 = nil

    local function showRank(arg9) -- line: 227
        -- upvalues:
        --  [1] v49 (ref)
        --  [2] v33 (ref)
        --  [3] v32 (ref)
        --  [4] u1 (copy)
        --  [5] Value (ref)
        --  [6] PlayerName (copy)
        --  [7] t_4 (ref)
        --  [8] t_3 (ref)

        if v49 then
            v49:Destroy()
            v49 = nil
        end

        v33 = arg9
        local v51 = (v32 and u1.Name or Value):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )

        if v33 then
            v51 ..= ` <font size="{13}" transparency="0.35">(#{v33})</font>`
        end

        PlayerName.Text = v51

        if not arg9 then
            return
        end

        for _, val_3 in t_4 do
            if arg9 <= val_3.MaxPlace then
                v49 = val_3.Gradient:Clone()
                v49.Parent = PlayerName

                if not (arg9 <= 10) then
                    break
                end

                t_3[v49] = true

                return
            end
        end
    end

    local _ = function() --[[ getNameColor ]] -- line: 249
        -- upvalues:
        --  [1] t_6 (ref)
        --  [2] u1 (copy)
        --  [3] t_9 (copy)
        --  [4] showRank (copy)
        --  [5] PlayerName (copy)

        local function update() -- line: 251
            -- upvalues:
            --  [1] t_6 (ref)
            --  [2] u1 (ref)
            --  [3] t_9 (ref)
            --  [4] showRank (ref)

            if t_6[u1] == t_9 then
                local Rank = u1:GetAttribute("Rank")
                showRank(if typeof(Rank) == "number" then Rank else nil)
            end
        end

        u1:GetAttributeChangedSignal("Rank"):Connect(update)

        if t_6[u1] == t_9 then
            local Rank_1 = u1:GetAttribute("Rank")
            showRank(if typeof(Rank_1) == "number" then Rank_1 else nil)
        end

        return PlayerName.TextColor3
    end

    local function update_1() --[[ update ]] -- line: 251
        -- upvalues:
        --  [1] t_6 (ref)
        --  [2] u1 (copy)
        --  [3] t_9 (copy)
        --  [4] showRank (copy)

        if t_6[u1] == t_9 then
            local Rank_2 = u1:GetAttribute("Rank")
            showRank(if typeof(Rank_2) == "number" then Rank_2 else nil)
        end
    end

    u1:GetAttributeChangedSignal("Rank"):Connect(update_1)

    if t_6[u1] == t_9 then
        local Rank_3 = u1:GetAttribute("Rank")
        showRank(if typeof(Rank_3) == "number" then Rank_3 else nil)
    end

    local TextColor3 = PlayerName.TextColor3
    v28.MouseEnter:Connect(function() -- line: 264
        -- upvalues:
        --  [1] v32 (ref)
        --  [2] u1 (copy)
        --  [3] Value (ref)
        --  [4] v33 (ref)
        --  [5] PlayerName (copy)
        --  [6] color_2 (ref)
        --  [7] TweenService (ref)
        --  [8] v28 (copy)

        v32 = true
        local v60 = (v32 and u1.Name or Value):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )

        if v33 then
            v60 ..= ` <font size="{13}" transparency="0.35">(#{v33})</font>`
        end

        PlayerName.Text = v60
        PlayerName.TextColor3 = color_2
        TweenService:Create(v28, TweenInfo.new(0.12), { BackgroundTransparency = 0.93 }):Play()
    end)
    v28.MouseLeave:Connect(function() -- line: 271
        -- upvalues:
        --  [1] v32 (ref)
        --  [2] u1 (copy)
        --  [3] Value (ref)
        --  [4] v33 (ref)
        --  [5] PlayerName (copy)
        --  [6] TextColor3 (copy)
        --  [7] TweenService (ref)
        --  [8] v28 (copy)

        v32 = false
        local v64 = (v32 and u1.Name or Value):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )

        if v33 then
            v64 ..= ` <font size="{13}" transparency="0.35">(#{v33})</font>`
        end

        PlayerName.Text = v64
        PlayerName.TextColor3 = TextColor3
        TweenService:Create(v28, TweenInfo.new(0.12), { BackgroundTransparency = 1 }):Play()
    end)
    CharacterName:GetPropertyChangedSignal("Value"):Connect(function() -- line: 278
        -- upvalues:
        --  [1] Value (ref)
        --  [2] CharacterName (copy)
        --  [3] t_9 (copy)
        --  [4] v32 (ref)
        --  [5] u1 (copy)
        --  [6] v33 (ref)
        --  [7] PlayerName (copy)
        --  [8] sortRows (ref)

        Value = CharacterName.Value
        t_9.Identity = Value
        local v68 = (v32 and u1.Name or Value):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )

        if v33 then
            v68 ..= ` <font size="{13}" transparency="0.35">(#{v33})</font>`
        end

        PlayerName.Text = v68
        sortRows()
    end)

    local function UpdateRank() -- line: 285
        -- upvalues:
        --  [1] v30 (copy)
        --  [2] Icon (copy)
        --  [3] t_5 (ref)
        --  [4] Label (copy)

        Icon.Image = t_5[v30:GetStat("AllianceRank")] or ""
        Icon.ImageColor3 = Label.TextColor3
        Icon.Visible = if Icon.Image == "" then false else true
    end

    local t_10 = {}

    local function UpdateAlliance() -- line: 294
        -- upvalues:
        --  [1] v30 (copy)
        --  [2] t_9 (copy)
        --  [3] t_10 (ref)
        --  [4] Label (copy)
        --  [5] SquadIcon (copy)
        --  [6] Icon (copy)
        --  [7] color_1 (ref)
        --  [8] setHasAlliance (copy)
        --  [9] sortRows (ref)
        --  [10] color (ref)
        --  [11] UpdateRank (copy)
        --  [12] ReplicatedStorage (ref)

        local v71 = v30:GetStat("Alliance") or ""
        t_9.Alliance = v71
        t_10 = _G.GetAllianceInfo(v71)

        if not next(t_10) or t_10.ClanName == "" then
            t_9.Alliance = ""
            Label.Text = ""
            SquadIcon.Image = ""
            Icon.Image = ""
            Icon.Visible = false
            Label.TextColor3 = color_1
            setHasAlliance(false)
            sortRows()

            return
        end

        local ClanName = t_10.ClanName
        local _ = t_10.ClanName
        Label.Text = ClanName
        SquadIcon.Image = t_10.ClanLogo or ""
        Label.TextColor3 = t_10.Verified and color or color_1
        setHasAlliance(true)
        sortRows()
        task.spawn(UpdateRank)
        local v73 = ReplicatedStorage:WaitForChild("TopGuilds"):FindFirstChild(ClanName)

        if not v73 then
            return
        end

        Label.Text = `{ClanName} <font transparency="0.35">#{v73.Place.Value}</font>`
    end

    Label.RichText = true
    local BindableEvent = Instance.new("BindableEvent")
    BindableEvent.Parent = v28
    BindableEvent.Event:Connect(UpdateAlliance)
    v30:OnStatChanged("Alliance", UpdateAlliance)
    v30:OnStatChanged("AllianceRank", UpdateRank)
    setHasAlliance(false)
    SquadIcon.MouseEnter:Connect(function() -- line: 340
        -- upvalues:
        --  [1] v30 (copy)
        --  [2] Actions (ref)
        --  [3] t_10 (ref)
        --  [4] getOwner (ref)
        --  [5] Info (ref)
        --  [6] color (ref)
        --  [7] color_3 (ref)
        --  [8] v28 (copy)
        --  [9] Contents (ref)

        local Alliance_1 = v30:GetStat("Alliance")
        local AllianceRank = v30:GetStat("AllianceRank")
        local CurrentCamera_6, Description, MemberCount, Members

        if not Actions.Visible then
            if Alliance_1 ~= "" then
                if not next(t_10) then
                    return
                end

                local v75 = t_10
                local v76 = v75.OwnerID and getOwner(v75.OwnerID)
                local v77 = v75.Description or ""
                Info.ClanName.Text = v75.ClanName
                Description = Info.Description
                Description.Text = v77:len() > 100 and v77:sub(1, 100) .. " ..." or v77
                MemberCount = Info.Info.MemberCount
                Members = v75.Members
                local v79

                if typeof(Members) ~= "table" then
                    v79 = 1
                else
                    v77 = 0

                    for _, _ in pairs(Members) do
                        v77 += 1
                    end

                    v79 = v77
                end

                MemberCount.Text = v79 .. " Member(s)"
                local Owner = Info.Info.Owner
                Owner.Text = v76 and "Owned by " .. v76 or "Couldn't determine owner."
                Info.Info.Rank.Text = "Rank: " .. tostring(AllianceRank)
                Info.Logo.Image = v75.ClanLogo or ""

                if v75.Verified then
                    Info.ClanName.Reputation.Text = "\194\187 Official Organization \194\171"
                    Info.ClanName.Reputation.TextColor3 = color
                else
                    Info.ClanName.Reputation.Text = "\194\187 Amateur Organization \194\171"
                    Info.ClanName.Reputation.TextColor3 = color_3
                end

                local v80 = Info
                CurrentCamera_6 = workspace.CurrentCamera
                local v81 = CurrentCamera_6 and CurrentCamera_6.ViewportSize.Y or 720
                v80.Position = UDim2.fromOffset(
                    Contents.AbsolutePosition.X - 8,
                    (math.clamp(
                        v28.AbsolutePosition.Y,
                        10,
                        (math.max(v81 - v80.AbsoluteSize.Y - 10, 10))
                    ))
                )
                Info.Visible = true

                return
            else
                return
            end
        else
            return
        end
    end)
    SquadIcon.MouseLeave:Connect(function() -- line: 370
        -- upvalues:
        --  [1] Info (ref)

        Info.Visible = false
    end)
    v28.Activated:Connect(function() -- line: 374
        -- upvalues:
        --  [1] Info (ref)
        --  [2] Actions (ref)
        --  [3] u1 (copy)
        --  [4] StatManager_m (ref)
        --  [5] LocalPlayer (ref)
        --  [6] v28 (copy)
        --  [7] Contents (ref)

        Info.Visible = false
        Actions.Viewing.Text = "Viewing " .. u1.Name
        local AllianceRank_1 = StatManager_m.require(LocalPlayer):GetStat("AllianceRank")
        local v86 = false
        local Locked = Actions.Options.Invite.Locked

        if AllianceRank_1 ~= "Captain" then
            v86 = AllianceRank_1 ~= "Vice-Captain"
        end

        Locked.Visible = v86
        Actions.Options.Kick.Locked.Visible = if AllianceRank_1 == "Captain" then false else AllianceRank_1 ~= "Vice-Captain"
        local v87 = Actions
        local CurrentCamera_7 = workspace.CurrentCamera
        local v88 = CurrentCamera_7 and CurrentCamera_7.ViewportSize.Y or 720
        local Y_4 = v28.AbsolutePosition.Y
        local FromOffset_4 = UDim2.fromOffset
        local v89 = Contents.AbsolutePosition.X - 8
        local v90 = math.max(v88 - v87.AbsoluteSize.Y - 10, 10)
        v87.Position = FromOffset_4(v89, (math.clamp(Y_4, 10, v90)))
        Actions.Visible = true
    end)
    v28.Visible = true
    v28.Parent = Scrolling
    sortRows()
    task.spawn(UpdateAlliance)
end

local function Remove(arg10) -- line: 394
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] Scrolling (copy)
    --  [3] sortRows (copy)

    local v91 = t_6[arg10]

    if v91 then
        v91.Row:Destroy()
        t_6[arg10] = nil
    end

    for _, child in Scrolling:GetChildren() do
        if child:GetAttribute("RealName") == arg10.Name then
            child:Destroy()
        end
    end

    sortRows()
end

local tweenInfo_2 = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfo_3 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo_4 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v92 = Toggle:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
v92.Parent = Toggle
local v93 = nil
local t_11 = {}

local function setArrow(arg11) -- line: 424
    -- upvalues:
    --  [1] v93 (ref)
    --  [2] t_11 (ref)
    --  [3] Toggle (copy)
    --  [4] v92 (copy)
    --  [5] TweenService (copy)
    --  [6] tweenInfo_2 (copy)
    --  [7] tweenInfo_3 (copy)
    --  [8] tweenInfo_4 (copy)

    if v93 == arg11 then
        return
    end

    local v94 = v93 == nil
    v93 = arg11

    for _, val_7 in t_11 do
        val_7:Cancel()
    end

    table.clear(t_11)
    local v95 = if not arg11 then 90 else -90

    if v94 then
        Toggle.Rotation = v95
        v92.Scale = 1

        return
    end

    v94 = TweenService:Create(Toggle, tweenInfo_2, { Rotation = v95 })
    v95 = TweenService:Create(v92, tweenInfo_3, { Scale = 0.7 })
    local v96 = TweenService:Create(v92, tweenInfo_4, { Scale = 1 })
    t_11 = { v94, v95, v96 }
    v95.Completed:Once(function(arg12) -- line: 449
        -- upvalues:
        --  [1] v96 (copy)

        if arg12 == Enum.PlaybackState.Completed then
            v96:Play()
        end
    end)
    v94:Play()
    v95:Play()
end

local function updateToggle() -- line: 458
    -- upvalues:
    --  [1] PlayerList (copy)
    --  [2] Players (copy)
    --  [3] setArrow (copy)
    --  [4] PlayerCount (copy)
    --  [5] Panel (copy)
    --  [6] Server (copy)
    --  [7] Info (copy)
    --  [8] Actions (copy)

    local Value_2 = PlayerList.Value
    local v97 = #Players:GetPlayers()
    setArrow(Value_2)
    PlayerCount.Text = v97 .. " player(s)"
    Panel.Visible = Value_2
    Server.Visible = Value_2

    if not Value_2 then
        Info.Visible = false
        Actions.Visible = false
    end
end

Toggle.Activated:Connect(function() -- line: 471
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] PlayerList (copy)

    ReplicatedStorage.Remotes.Player.UpdateSettings:FireServer(PlayerList)
end)
PlayerList:GetPropertyChangedSignal("Value"):Connect(updateToggle)
local Value_3 = PlayerList.Value
local v98 = #Players:GetPlayers()
setArrow(Value_3)
PlayerCount.Text = v98 .. " player(s)"
Panel.Visible = Value_3
Server.Visible = Value_3

if not Value_3 then
    Info.Visible = false
    Actions.Visible = false
end

local function handlePlayerAdded(arg13) -- line: 481
    -- upvalues:
    --  [1] PlayerList (copy)
    --  [2] Players (copy)
    --  [3] setArrow (copy)
    --  [4] PlayerCount (copy)
    --  [5] Panel (copy)
    --  [6] Server (copy)
    --  [7] Info (copy)
    --  [8] Actions (copy)
    --  [9] LocalPlayer (copy)
    --  [10] UpdateUI (copy)

    local Value_4 = PlayerList.Value
    local v99 = #Players:GetPlayers()
    setArrow(Value_4)
    PlayerCount.Text = v99 .. " player(s)"
    Panel.Visible = Value_4
    Server.Visible = Value_4

    if not Value_4 then
        Info.Visible = false
        Actions.Visible = false
    end

    if arg13 ~= LocalPlayer then
        arg13:WaitForChild("PlayerFolder")
    end

    arg13:WaitForChild("CustomizeFolder")
    UpdateUI(arg13)
end

Players.PlayerRemoving:Connect(function(arg14) -- line: 490
    -- upvalues:
    --  [1] Remove (copy)
    --  [2] updateToggle (copy)

    Remove(arg14)
    task.defer(updateToggle)
end)

for _, val_8 in Players:GetPlayers() do
    task.spawn(handlePlayerAdded, val_8)
end

Players.PlayerAdded:Connect(handlePlayerAdded)

local _ = function() --[[ viewingName ]] -- line: 503
    -- upvalues:
    --  [1] Actions (copy)

    return (string.gsub(Actions.Viewing.Text, "Viewing ", ""))
end

local function tradePressed() -- line: 507
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Actions (copy)

    ReplicatedStorage.Remotes.Trading:InvokeServer(
        "Invite",
        (string.gsub(Actions.Viewing.Text, "Viewing ", ""))
    )
end

local function invitePressed() -- line: 511
    -- upvalues:
    --  [1] Actions (copy)
    --  [2] ReplicatedStorage (copy)

    if Actions.Options.Invite.Locked.Visible then
        return
    end

    ReplicatedStorage.Remotes.Alliance:InvokeServer(
        "Invite",
        (string.gsub(Actions.Viewing.Text, "Viewing ", ""))
    )
end

local function kickPressed() -- line: 516
    -- upvalues:
    --  [1] Actions (copy)
    --  [2] ReplicatedStorage (copy)

    if Actions.Options.Kick.Locked.Visible then
        return
    end

    ReplicatedStorage.Remotes.Alliance:InvokeServer(
        "Kick",
        (string.gsub(Actions.Viewing.Text, "Viewing ", ""))
    )
end

Actions.Options.Trade.Activated:Connect(tradePressed)
Actions.Options.Invite.Activated:Connect(invitePressed)
Actions.Options.Kick.Activated:Connect(kickPressed)
Actions.MouseLeave:Connect(function() -- line: 525
    -- upvalues:
    --  [1] Actions (copy)

    Actions.Visible = false
end)

local function RefreshFunction() -- line: 529
    -- upvalues:
    --  [1] Scrolling (copy)

    for _, val_9 in Scrolling:QueryDescendants("BindableEvent") do
        val_9:Fire()
    end
end

ReplicatedStorage:WaitForChild("TopGuilds"):GetAttributeChangedSignal("Refresh"):Connect(
    RefreshFunction
)
