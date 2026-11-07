-- Decompiled with Veyra harvester
-- Instance: StarterGui.AllianceUI.Clans.ClanClient
-- Class: LocalScript
-- bytes: 40458

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("MarketplaceService")
local _ = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local StatManager_m = require(Modules.StatManager)
local Formatter_m = require(Modules.Formatter)
local GuildConfig_m = require(Modules.GuildConfig)
local LocalPlayer = Players.LocalPlayer
local v2 = StatManager_m.require(LocalPlayer)
local Parent = script.Parent
local Edit = Parent.Buttons.Edit
local Upgrades = Parent.Buttons.Upgrades
local _ = Parent.Buttons.Rankings
local _ = Parent.Buttons.Clan
local ClanFrame = Parent.ClanFrame
local MemberTemplate = ClanFrame:FindFirstChild("MemberTemplate", true)
local Contents = ClanFrame.Contents
local t = {
    ClanName = Contents.Info.Profile.Identity.ClanName,
    Logo = Contents.Info.Profile.Identity.Logo,
    Description = Contents.Chat.Message.Description,
    MemberFrame = Contents.Members,
    Leave = Contents.Info.Leave,
    Chat = Contents.Chat,
    Composer = Contents.Chat:FindFirstChild("Composer")
}
local MemberFrame = t.MemberFrame
local EditFrame = Parent.EditFrame
local Choices = EditFrame.Colors.Choices
local Palette = EditFrame.Palette
local Input = EditFrame.Input
local t_1 = {}

for _, val in {
    EditFrame.Description,
    EditFrame.Logo,
    EditFrame.Colors,
    EditFrame.ViewCloak,
    EditFrame.Options,
    Input.Buttons.Promote,
    Input.Buttons.Demote
} do
    t_1[val] = val.Visible
end

local CreateFrame = Parent.CreateFrame
local Choices_1 = CreateFrame.Colors.Choices
local Requirement = CreateFrame:FindFirstChild("Requirement")
local RankingsFrame = Parent.RankingsFrame
local BoardTabs = RankingsFrame.BoardTabs
local UpgradesFrame = Parent.UpgradesFrame
local MemberCap = UpgradesFrame.MemberCap
local color = Color3.fromRGB(167, 142, 40)
local Invite = Parent.Parent.Invite
local ConfirmFrame = Parent.ConfirmFrame
local v4 = false
local v5 = RunService:IsStudio() or LocalPlayer.UserId == 52866742
local v6 = ""
local t_2 = {
    Rankings = function() -- line: 88
        -- upvalues:
        --  [1] CreateFrame (copy)
        --  [2] ClanFrame (copy)
        --  [3] EditFrame (copy)
        --  [4] UpgradesFrame (copy)
        --  [5] RankingsFrame (copy)

        CreateFrame.Visible = false
        ClanFrame.Visible = false
        EditFrame.Visible = false
        UpgradesFrame.Visible = false
        RankingsFrame.Visible = true
    end,
    Clan = function() -- line: 95
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] UpgradesFrame (copy)
        --  [3] ClanFrame (copy)
        --  [4] CreateFrame (copy)
        --  [5] RankingsFrame (copy)
        --  [6] EditFrame (copy)

        local v7 = if v2:GetStat("Alliance") == "" then false else true
        UpgradesFrame.Visible = false

        if v7 then
            ClanFrame.Visible = true
            CreateFrame.Visible = false
            RankingsFrame.Visible = false
            EditFrame.Visible = false

            return
        end

        ClanFrame.Visible = false
        CreateFrame.Visible = true
        RankingsFrame.Visible = false
        EditFrame.Visible = false
    end,
    Edit = function() -- line: 110
        -- upvalues:
        --  [1] CreateFrame (copy)
        --  [2] RankingsFrame (copy)
        --  [3] ClanFrame (copy)
        --  [4] UpgradesFrame (copy)
        --  [5] EditFrame (copy)

        CreateFrame.Visible = false
        RankingsFrame.Visible = false
        ClanFrame.Visible = false
        UpgradesFrame.Visible = false
        EditFrame.Visible = true
    end,
    Upgrades = function() -- line: 117
        -- upvalues:
        --  [1] CreateFrame (copy)
        --  [2] RankingsFrame (copy)
        --  [3] ClanFrame (copy)
        --  [4] EditFrame (copy)
        --  [5] UpgradesFrame (copy)

        CreateFrame.Visible = false
        RankingsFrame.Visible = false
        ClanFrame.Visible = false
        EditFrame.Visible = false
        UpgradesFrame.Visible = true
    end
}

local _ = function(arg1) --[[ getDictCount ]] -- line: 126
    if typeof(arg1) ~= "table" then
        return 1
    end

    local v8 = 0

    for _, _ in pairs(arg1) do
        v8 += 1
    end

    return v8
end

local function UpdateClanMembers() -- line: 138
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] MemberFrame (copy)
    --  [3] Players (copy)
    --  [4] MemberTemplate (copy)
    --  [5] Formatter_m (copy)

    local v9, v10, v11 = ReplicatedStorage.Remotes.Alliance:InvokeServer("GetClanMembers")
    local v12 = v11

    if typeof(v11) ~= "table" or not v12 then
        v12 = {}
    end

    local v13 = v12

    for _, child in MemberFrame.List:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end

    local t_3 = { Captain = 1, ["Vice-Captain"] = 2, Officer = 3, Member = 4 }
    local num

    for key_3, val_2 in pairs(v9) do
        num = tonumber(key_3)
        local v14 = if tonumber(v10) == num then "Captain" else t_3[val_2] and val_2 or "Member"
        local v15 = if not pcall(function() -- line: 156
            -- upvalues:
            --  [1] Players (ref)
            --  [2] num (ref)

            return Players:GetNameFromUserIdAsync(num)
        end) then `Failed to load: {num}` else nil
        local v16 = MemberTemplate:Clone()
        local Display = v16.Display
        v16:SetAttribute("RealName", v15)
        v16.Name = if v10 == num then "@" else v15
        Display.Icon.Image = `rbxthumb://type=AvatarHeadShot&id={num}&w=420&h=420`
        Display.identity.Text = `@{v15}`
        Display.rank.Text = v14
        v15 = Display:FindFirstChild("contribution")

        if v15 then
            local v18 = Formatter_m.addCommas((math.floor(tonumber(v13[tostring(num)]) or 0)))
            v15.Text = `Contribution: <b>{v18}</b>`
        end

        v16:SetAttribute("RankOrder", t_3[v14])
        v16.Parent = MemberFrame.List
    end

    local t_4 = {}

    for _, child_1 in MemberFrame.List:GetChildren() do
        if child_1:IsA("GuiObject") then
            table.insert(t_4, child_1)
        end
    end

    table.sort(t_4, function(arg2, arg3) -- line: 191
        local v19 = arg2:GetAttribute("RankOrder") or 99
        local v20 = arg3:GetAttribute("RankOrder") or 99
        local v21

        if v19 ~= v20 then
            v21 = v19 < v20

            return v21
        end

        local v23 = string.lower(arg2:GetAttribute("RealName") or arg2.Name)
        v21 = v23 < string.lower(arg3:GetAttribute("RealName") or arg3.Name)

        return v21
    end)

    for key_5, val_3 in t_4 do
        val_3.LayoutOrder = key_5
    end
end

local t_5 = {
    Clan = { ClanFrame, CreateFrame },
    Rankings = { RankingsFrame },
    Upgrades = { UpgradesFrame },
    Edit = { EditFrame }
}
local color_1 = Color3.fromRGB(167, 142, 40)

local function syncHighlights() -- line: 213
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] Parent (copy)
    --  [3] color_1 (copy)

    for key_6, val_4 in t_5 do
        local v25 = Parent.Buttons:FindFirstChild(key_6)

        if v25 then
            local v26 = false

            for _, val_5 in val_4 do
                if val_5.Visible then
                    v26 = true
                end
            end

            v25:SetAttribute("Highlighted", v26)
            local v27 = color_1
            local Label = v25.Label

            if not v26 or not v27 then
                v27 = Color3.new(1, 1, 1)
            end

            Label.TextColor3 = v27
        end
    end
end

local v28 = false

local function queueSync() -- line: 232
    -- upvalues:
    --  [1] v28 (ref)
    --  [2] syncHighlights (copy)

    if v28 then
        return
    end

    v28 = true
    task.defer(function() -- line: 237
        -- upvalues:
        --  [1] v28 (ref)
        --  [2] syncHighlights (ref)

        v28 = false
        syncHighlights()
    end)
end

for _, val_6 in t_5 do
    for _, val_7 in val_6 do
        val_7:GetPropertyChangedSignal("Visible"):Connect(queueSync)
    end
end

for key_10 in t_5 do
    queueSync = Parent.Buttons:FindFirstChild(key_10)

    if queueSync and queueSync:IsA("GuiButton") then
        queueSync.MouseButton1Up:Connect(function() -- line: 252
            -- upvalues:
            --  [1] queueSync (copy)
            --  [2] t_2 (copy)
            --  [3] key_10 (copy)

            local Locked = queueSync:FindFirstChild("Locked")

            if Locked and Locked.Visible then
                return
            end

            t_2[key_10]()
        end)
    end
end

syncHighlights()
local v29 = false
local v30 = nil
local v31 = false

local function updateUpgrades(arg4, arg5) -- line: 267
    -- upvalues:
    --  [1] v30 (ref)
    --  [2] v31 (ref)
    --  [3] MemberCap (copy)
    --  [4] UpgradesFrame (copy)
    --  [5] GuildConfig_m (copy)
    --  [6] Formatter_m (copy)
    --  [7] color (copy)

    v30 = arg4
    v31 = arg5
    local Purchase = MemberCap.Purchase

    if not arg4 then
        UpgradesFrame.Points.Text = "Guild Points: <b>?</b>"
        MemberCap.Current.Text = "Couldn't load upgrades"
        MemberCap.Level.Text = ""
        MemberCap.Next.Text = ""
        Purchase.Visible = false

        return
    end

    local v32 = arg4.MemberCapLevel or 0
    local v33 = GuildConfig_m.GetMaxMemberCapLevel()
    local v34 = GuildConfig_m.GetMemberCapCost(v32)
    local v35 = arg4.GuildPoints or 0
    UpgradesFrame.Points.Text = `Guild Points: <b>{Formatter_m.addCommas(v35)}</b>`
    MemberCap.Current.Text = `<b>{GuildConfig_m.GetMemberCap(v32)}</b> members`
    MemberCap.Level.Text = `Level {v32}/{v33}`
    local Pips = MemberCap.Pips

    for _, child_2 in Pips:GetChildren() do
        if child_2:IsA("GuiObject") then
            child_2:Destroy()
        end
    end

    for index = 1, v33 do
        local v36 = script.Pip:Clone()
        v36.LayoutOrder = index
        v36.Size = UDim2.fromScale(math.min(0.2, 0.9 / v33), 1)
        v36.BackgroundColor3 = v32 >= index and color or Color3.fromRGB(70, 70, 70)
        v36.Parent = Pips
    end

    if v34 then
        local v38 = GuildConfig_m.GetMemberCap(v32 + 1)
        MemberCap.Next.Text = `Next level: +{GuildConfig_m.MemberCapPerLevel} members ({v38} total)`
        local Label_1 = Purchase.Label
        local v39 = Formatter_m.addCommas(v34)
        Label_1.Text = `Upgrade - {v39} Points`
    else
        MemberCap.Next.Text = "Max level reached"
        Purchase.Label.Text = "Maxed"
    end

    v33 = arg5 and (if v34 == nil then false else v34 <= v35)
    Purchase.Visible = true
    Purchase.AutoButtonColor = v33
    Purchase.BackgroundTransparency = if not v33 then 0.6 else 0
    Purchase.Label.TextTransparency = if not v33 then 0.4 else 0
    UpgradesFrame.Note.Visible = not arg5
end

local function timeAgo(arg6) -- line: 321
    local now = os.time()
    local v42 = tonumber(arg6) or os.time()
    local v43 = math.max(0, now - v42)

    if v43 < 60 then
        return "just now"
    end

    if v43 < 3600 then
        local v44 = math.floor(v43 / 60)

        return `{v44}m ago`
    end

    if v43 < 86400 then
        local v45 = math.floor(v43 / 3600)

        return `{v45}h ago`
    end

    local v46 = math.floor(v43 / 86400)

    return `{v46}d ago`
end

local v47 = 0

local function renderAnnouncement(arg7, arg8) -- line: 335
    -- upvalues:
    --  [1] t (copy)
    --  [2] v47 (ref)
    --  [3] timeAgo (copy)
    --  [4] Players (copy)

    local Composer = t.Composer

    if Composer then
        Composer.Input.Visible = arg8
        Composer.Post.Visible = arg8
        Composer.Locked.Visible = not arg8
    end

    if not t.Chat then
        return
    end

    local t_6 = {}

    for _, child_3 in t.Chat:GetChildren() do
        if child_3.Name == "Announcement" and child_3:FindFirstChild("Body") then
            table.insert(t_6, child_3)
        end
    end

    local function setHeader(arg9) -- line: 354
        -- upvalues:
        --  [1] t_6 (copy)

        for _, val_8 in t_6 do
            local Header = val_8:FindFirstChild("Header")

            if Header then
                Header.Text = arg9
                Header.Visible = arg9 ~= ""
            end
        end
    end

    v47 += 1
    local v49 = v47
    local v50 = if typeof(arg7) == "table" then if typeof(arg7.Text) == "string" then arg7.Text ~= "" else false else false

    for _, val_9 in t_6 do
        val_9.Body.Text = v50 and arg7.Text or (if not arg8 then "No announcement yet." else "No announcement yet. Pin one below for your guild to see.")
    end

    if not v50 then
        for _, val_10 in t_6 do
            local Header_1 = val_10:FindFirstChild("Header")

            if Header_1 then
                Header_1.Text = ""
                Header_1.Visible = false
            end
        end

        return
    end

    local v52 = timeAgo(arg7.Time)
    setHeader(v52)
    local num_1 = tonumber(arg7.AuthorId)

    if num_1 then
        task.spawn(function() -- line: 382
            -- upvalues:
            --  [1] Players (ref)
            --  [2] num_1 (copy)
            --  [3] v49 (copy)
            --  [4] v47 (ref)
            --  [5] setHeader (copy)
            --  [6] v52 (copy)

            local Success_1, Result = pcall(Players.GetNameFromUserIdAsync, Players, num_1)

            if Success_1 and Result and v49 == v47 then
                setHeader(`{Result}, {v52}`)
            end
        end)
    end
end

local function UpdateClanInfo() -- line: 391
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] UpgradesFrame (copy)
    --  [3] EditFrame (copy)
    --  [4] RankingsFrame (copy)
    --  [5] Upgrades (copy)
    --  [6] Edit (copy)
    --  [7] t_1 (copy)
    --  [8] Palette (copy)
    --  [9] ClanFrame (copy)
    --  [10] CreateFrame (copy)
    --  [11] Players (copy)
    --  [12] ReplicatedStorage (copy)
    --  [13] updateUpgrades (copy)
    --  [14] t (copy)
    --  [15] renderAnnouncement (copy)
    --  [16] Input (copy)
    --  [17] Choices (copy)
    --  [18] UpdateClanMembers (copy)

    local AllianceRank = v2:GetStat("AllianceRank")
    local v54 = v2:GetStat("Alliance")
    local v55 = if AllianceRank ~= "Captain" then false else true
    local v56 = AllianceRank == "Vice-Captain" or v55
    local v57 = v54 ~= ""
    local v58 = UpgradesFrame.Visible and v57
    EditFrame.Visible = false
    RankingsFrame.Visible = false
    UpgradesFrame.Visible = v58
    local v59 = v57 and v55
    Upgrades.Locked.Visible = not v57
    Edit.Locked.Visible = not (v57 and v56)

    for key_16, val_11 in t_1 do
        key_16.Visible = v59 and val_11
    end

    if not v59 then
        Palette.Visible = false
    end

    if not v57 then
        ClanFrame.Visible = false
        CreateFrame.Visible = true

        return
    end

    CreateFrame.Visible = false
    ClanFrame.Visible = not v58
    local v60 = _G.GetAllianceInfo(v54)

    if not next(v60) then
        return
    end

    local v61 = v60.OwnerID

    if v61 then
        v61 = Players:GetNameFromUserIdAsync(v60.OwnerID)
    end

    local v62 = v60.ClanName
    v57 = v60.ClanLogo
    local Description = v60.Description
    local Members = v60.Members
    local SecondaryColor = v60.SecondaryColor
    local TertiaryColor = v60.TertiaryColor
    local v63 = v60.PrimaryColor:split(",")
    local v64 = SecondaryColor:split(",")
    local v65 = TertiaryColor:split(",")
    local v66, v67

    if typeof(Members) ~= "table" then
        v66 = 1
    else
        v67 = 0

        for _, _ in pairs(Members) do
            v67 += 1
        end

        v66 = v67
    end

    local v68 = ReplicatedStorage.Remotes.Alliance:InvokeServer("GetGuildProgress")
    v67 = v68

    if v67 then
        v67 = v68.MemberCap
    end

    updateUpgrades(v68, v55)
    t.ClanName.Text = v62
    t.ClanName.TextColor3 = Color3.new(v65[1], v65[2], v65[3])
    v62 = string.match(Description, "^%s*(.-)%s*$") or ""
    local v69 = utf8.offset(v62, 101)

    if v69 then
        v62 = (string.match(string.sub(v62, 1, v69 - 1), "^(.-)%s*$") or "") .. "..."
    end

    t.Description.Text = `"{v62}"`
    t.Logo.Image = v57
    local v70 = ReplicatedStorage.Remotes.Alliance:InvokeServer("GetClanPoints", v54)
    v62 = v70 and math.max(0, v70.ReputationPvE or 0) or 0
    v54 = v70 and math.max(0, v70.ReputationPvP or 0) or 0
    ClanFrame:SetAttribute("MemberCount", v66)
    ClanFrame:SetAttribute("MemberCap", v67 or 0)
    local v71 = v68.GuildPoints
    local v72 = ClanFrame

    if not v68 or not v71 then
        v71 = 0
    end

    v72:SetAttribute("GuildPoints", v71)
    ClanFrame:SetAttribute("PvPRating", v54)
    ClanFrame:SetAttribute("PvERating", v62)
    ClanFrame:SetAttribute("OwnerName", v61 or "")
    ClanFrame:SetAttribute("Rank", AllianceRank)
    ClanFrame:SetAttribute("PrimaryColor", Color3.new(v63[1], v63[2], v63[3]))
    renderAnnouncement(v60.Announcement, v55)

    if v56 or v55 then
        Input.Visible = true

        if v55 then
            t.Leave.Visible = false
            task.spawn(function() -- line: 490
                -- upvalues:
                --  [1] EditFrame (ref)
                --  [2] Description (copy)
                --  [3] v57 (copy)
                --  [4] Choices (ref)
                --  [5] v63 (copy)
                --  [6] v64 (copy)
                --  [7] v65 (copy)

                EditFrame.Description.Text = Description
                EditFrame.Logo.IMG.Image = v57
                EditFrame.Logo.Text = string.gsub(v57, "rbxassetid://", "")
                Choices.PrimaryColor.BackgroundColor3 = Color3.new(v63[1], v63[2], v63[3])
                Choices.SecondaryColor.BackgroundColor3 = Color3.new(v64[1], v64[2], v64[3])
                Choices.TertiaryColor.BackgroundColor3 = Color3.new(v65[1], v65[2], v65[3])
            end)
        else
            t.Leave.Visible = true
        end
    else
        Input.Visible = false
        t.Leave.Visible = true
    end

    UpdateClanMembers()
end

local function updateCloakPreview() -- line: 511
    -- upvalues:
    --  [1] Choices (copy)
    --  [2] EditFrame (copy)

    local BackgroundColor3 = Choices.PrimaryColor.BackgroundColor3
    local BackgroundColor3_1 = Choices.SecondaryColor.BackgroundColor3

    for _, val_13 in EditFrame.ViewCloak.Preview:QueryDescendants("BasePart") do
        val_13.Color = val_13:GetAttribute("PrimaryColor") and BackgroundColor3 or (val_13:GetAttribute(
            "Ignore"
        ) and val_13.Color or BackgroundColor3_1)
    end
end

Choices.PrimaryColor:GetPropertyChangedSignal("BackgroundColor3"):Connect(updateCloakPreview)
Choices.SecondaryColor:GetPropertyChangedSignal("BackgroundColor3"):Connect(updateCloakPreview)
v2:OnStatChanged("Alliance", UpdateClanInfo)
v2:OnStatChanged("AllianceRank", UpdateClanInfo)
task.spawn(UpdateClanInfo)

function Preview() -- line: 528
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] ReplicatedStorage (copy)
    --  [3] CreateFrame (copy)
    --  [4] v5 (copy)

    if v4 then
        return
    end

    v4 = true
    local v75, v76, v77 = ReplicatedStorage.Remotes.Alliance:InvokeServer(
        "Preview",
        CreateFrame.ClanName.Text,
        CreateFrame.Logo.Text,
        CreateFrame.Description.Text
    )
    CreateFrame.ClanName.Text = v75
    local IMG = CreateFrame.Logo.IMG
    IMG.Image = string.match(v76, "rbxassetid://") and v76 or "rbxassetid://" .. v76
    CreateFrame.Description.Text = v77

    if v5 then
        print(v75, v76, v77)
    end

    v4 = false
end

function PreviewEdit() -- line: 547
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] ReplicatedStorage (copy)
    --  [3] EditFrame (copy)
    --  [4] v5 (copy)

    if v4 then
        return
    end

    v4 = true
    local v79, v80, v81 = ReplicatedStorage.Remotes.Alliance:InvokeServer(
        "Preview",
        "",
        EditFrame.Logo.Text,
        EditFrame.Description.Text
    )
    local IMG_1 = EditFrame.Logo.IMG
    IMG_1.Image = string.match(v80, "rbxassetid://") and v80 or "rbxassetid://" .. v80
    EditFrame.Description.Text = v81

    if v5 then
        print(v79, v80, v81)
    end

    v4 = false
end

function Confirm() -- line: 564
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] ConfirmFrame (copy)
    --  [3] v6 (ref)
    --  [4] CreateFrame (copy)
    --  [5] Choices_1 (copy)
    --  [6] ReplicatedStorage (copy)
    --  [7] EditFrame (copy)
    --  [8] Choices (copy)

    if v4 or not ConfirmFrame.Visible then
        return
    end

    v4 = true

    if v6 == "Create" then
        local _ = ReplicatedStorage.Remotes.Alliance:InvokeServer(
            "Create",
            CreateFrame.ClanName.Text,
            CreateFrame.Logo.Text,
            CreateFrame.Description.Text,
            Choices_1.PrimaryColor.BackgroundColor3,
            Choices_1.SecondaryColor.BackgroundColor3,
            Choices_1.TertiaryColor.BackgroundColor3
        )
    elseif v6 == "Disband" then
        local _ = ReplicatedStorage.Remotes.Alliance:InvokeServer("Disband")
    elseif v6 == "Leave" then
        local _ = ReplicatedStorage.Remotes.Alliance:InvokeServer("Leave")
    elseif v6 == "Edit" then
        local _ = ReplicatedStorage.Remotes.Alliance:InvokeServer(
            "Edit",
            "",
            EditFrame.Logo.Text,
            EditFrame.Description.Text,
            Choices.PrimaryColor.BackgroundColor3,
            Choices.SecondaryColor.BackgroundColor3,
            Choices.TertiaryColor.BackgroundColor3
        )
    end

    ConfirmFrame.Visible = false
    v4 = false
end

local function updateCreateRequirement() -- line: 596
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] Requirement (copy)
    --  [3] CreateFrame (copy)

    local v87 = if v2:GetStat("PassedExam") ~= true then false else true

    if Requirement then
        Requirement.Visible = not v87
    end

    local Purchase_1 = CreateFrame.Purchase
    Purchase_1.AutoButtonColor = v87
    Purchase_1.BackgroundTransparency = if not v87 then 0.6 else 0

    for _, descendant in Purchase_1:GetDescendants() do
        if descendant:IsA("TextLabel") then
            descendant.TextTransparency = if not v87 then 0.4 else 0
        end
    end
end

v2:OnStatChanged("PassedExam", updateCreateRequirement)
task.spawn(updateCreateRequirement)

local function createPressed() -- line: 616
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] Basic_m (copy)
    --  [3] ConfirmFrame (copy)
    --  [4] v6 (ref)

    if not v2:GetStat("PassedExam") then
        return
    end

    if v2:GetStat("Marks") < Basic_m.CreateClanFee then
        return
    end

    ConfirmFrame.Visible = not ConfirmFrame.Visible
    v6 = "Create"
end

local function savePressed() -- line: 629
    -- upvalues:
    --  [1] ConfirmFrame (copy)
    --  [2] v6 (ref)

    ConfirmFrame.Visible = not ConfirmFrame.Visible
    v6 = "Edit"
end

CreateFrame.Purchase.MouseButton1Up:Connect(createPressed)
CreateFrame.ClanName.FocusLost:Connect(Preview)
CreateFrame.Description.FocusLost:Connect(Preview)
CreateFrame.Logo.FocusLost:Connect(Preview)
EditFrame.Description.FocusLost:Connect(PreviewEdit)
EditFrame.Logo.FocusLost:Connect(PreviewEdit)
EditFrame.Options.Save.MouseButton1Up:Connect(savePressed)
EditFrame.Options.Disband.MouseButton1Up:Connect(function() -- line: 643
    -- upvalues:
    --  [1] ConfirmFrame (copy)
    --  [2] v6 (ref)

    ConfirmFrame.Visible = not ConfirmFrame.Visible
    v6 = "Disband"
end)
ConfirmFrame.Accept.MouseButton1Up:Connect(Confirm)
ConfirmFrame.Decline.MouseButton1Up:Connect(function() -- line: 649
    -- upvalues:
    --  [1] ConfirmFrame (copy)

    ConfirmFrame.Visible = false
end)
CreateFrame.Description:GetPropertyChangedSignal("Text"):Connect(function() -- line: 653
    -- upvalues:
    --  [1] CreateFrame (copy)
    --  [2] Basic_m (copy)

    if string.len(CreateFrame.Description.Text) > Basic_m.DescriptionLimit then
        CreateFrame.Description.TextColor3 = Color3.fromRGB(185, 0, 0)

        return
    end

    CreateFrame.Description.TextColor3 = Color3.fromRGB(255, 255, 255)
end)
CreateFrame.ClanName:GetPropertyChangedSignal("Text"):Connect(function() -- line: 661
    -- upvalues:
    --  [1] CreateFrame (copy)
    --  [2] Basic_m (copy)

    if not (string.len(CreateFrame.ClanName.Text) > Basic_m.NameMaximum) then
        if string.len(CreateFrame.ClanName.Text) < Basic_m.NameMinimum then
            CreateFrame.ClanName.TextColor3 = Color3.fromRGB(185, 0, 0)

            return
        end

        CreateFrame.ClanName.TextColor3 = Color3.fromRGB(255, 255, 255)

        return
    else
        CreateFrame.ClanName.TextColor3 = Color3.fromRGB(185, 0, 0)

        return
    end
end)
EditFrame.Description:GetPropertyChangedSignal("Text"):Connect(function() -- line: 669
    -- upvalues:
    --  [1] EditFrame (copy)
    --  [2] Basic_m (copy)

    if string.len(EditFrame.Description.Text) > Basic_m.DescriptionLimit then
        EditFrame.Description.TextColor3 = Color3.fromRGB(185, 0, 0)

        return
    end

    EditFrame.Description.TextColor3 = Color3.fromRGB(255, 255, 255)
end)
local v94 = nil

local function controlPalettes() -- line: 679
    -- upvalues:
    --  [1] v94 (ref)
    --  [2] EditFrame (copy)
    --  [3] CreateFrame (copy)
    --  [4] Choices (copy)
    --  [5] Choices_1 (copy)

    local _ = function(arg10) --[[ getPaletteChanged ]] -- line: 681
        -- upvalues:
        --  [1] v94 (ref)

        arg10:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() -- line: 682
            -- upvalues:
            --  [1] v94 (ref)
            --  [2] arg10 (copy)

            if v94 then
                v94.BackgroundColor3 = arg10.BackgroundColor3
            end
        end)
    end

    local _ = function(arg11, arg12) --[[ addClick ]] -- line: 689
        -- upvalues:
        --  [1] v94 (ref)

        arg11.MouseButton1Up:Connect(function() -- line: 690
            -- upvalues:
            --  [1] arg12 (copy)
            --  [2] v94 (ref)
            --  [3] arg11 (copy)

            arg12.Visible = true
            v94 = arg11
        end)
    end

    local Color = EditFrame.Palette.Slider.Color
    Color:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() -- line: 682
        -- upvalues:
        --  [1] v94 (ref)
        --  [2] Color (copy)

        if v94 then
            v94.BackgroundColor3 = Color.BackgroundColor3
        end
    end)
    local Color_1 = CreateFrame.Palette.Slider.Color
    Color_1:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() -- line: 682
        -- upvalues:
        --  [1] v94 (ref)
        --  [2] Color_1 (copy)

        if v94 then
            v94.BackgroundColor3 = Color_1.BackgroundColor3
        end
    end)
    local PrimaryColor_1 = Choices.PrimaryColor
    local Palette_1 = EditFrame.Palette
    PrimaryColor_1.MouseButton1Up:Connect(function() -- line: 690
        -- upvalues:
        --  [1] Palette_1 (copy)
        --  [2] v94 (ref)
        --  [3] PrimaryColor_1 (copy)

        Palette_1.Visible = true
        v94 = PrimaryColor_1
    end)
    local SecondaryColor_2 = Choices.SecondaryColor
    local Palette_2 = EditFrame.Palette
    SecondaryColor_2.MouseButton1Up:Connect(function() -- line: 690
        -- upvalues:
        --  [1] Palette_2 (copy)
        --  [2] v94 (ref)
        --  [3] SecondaryColor_2 (copy)

        Palette_2.Visible = true
        v94 = SecondaryColor_2
    end)
    local TertiaryColor_2 = Choices.TertiaryColor
    local Palette_3 = EditFrame.Palette
    TertiaryColor_2.MouseButton1Up:Connect(function() -- line: 690
        -- upvalues:
        --  [1] Palette_3 (copy)
        --  [2] v94 (ref)
        --  [3] TertiaryColor_2 (copy)

        Palette_3.Visible = true
        v94 = TertiaryColor_2
    end)
    local PrimaryColor_2 = Choices_1.PrimaryColor
    local Palette_4 = CreateFrame.Palette
    PrimaryColor_2.MouseButton1Up:Connect(function() -- line: 690
        -- upvalues:
        --  [1] Palette_4 (copy)
        --  [2] v94 (ref)
        --  [3] PrimaryColor_2 (copy)

        Palette_4.Visible = true
        v94 = PrimaryColor_2
    end)
    local PrimaryColor_3 = Choices_1.PrimaryColor
    local Palette_5 = CreateFrame.Palette
    PrimaryColor_3.MouseButton1Up:Connect(function() -- line: 690
        -- upvalues:
        --  [1] Palette_5 (copy)
        --  [2] v94 (ref)
        --  [3] PrimaryColor_3 (copy)

        Palette_5.Visible = true
        v94 = PrimaryColor_3
    end)
    local TertiaryColor_3 = Choices_1.TertiaryColor
    local Palette_6 = CreateFrame.Palette
    TertiaryColor_3.MouseButton1Up:Connect(function() -- line: 690
        -- upvalues:
        --  [1] Palette_6 (copy)
        --  [2] v94 (ref)
        --  [3] TertiaryColor_3 (copy)

        Palette_6.Visible = true
        v94 = TertiaryColor_3
    end)
end

controlPalettes()

function autoSuggest(arg13) -- line: 711
    -- upvalues:
    --  [1] Players (copy)

    for _, val_14 in Players:GetPlayers() do
        if val_14.Name:sub(1, #arg13) == arg13 then
            return val_14.Name
        end
    end

    return nil
end

Input:GetPropertyChangedSignal("Text"):Connect(function() -- line: 720
    -- upvalues:
    --  [1] Input (copy)

    local v96 = autoSuggest(Input.Text)

    if not v96 then
        Input.Fill.Text = ""

        return
    end

    Input.Fill.Text = Input.Text .. string.sub(v96, #Input.Text + 1)
end)
Input.Buttons.Invite.MouseButton1Up:Connect(function() -- line: 729
    -- upvalues:
    --  [1] Input (copy)
    --  [2] ReplicatedStorage (copy)

    if Input.Text == "" then
        return
    end

    ReplicatedStorage.Remotes.Alliance:InvokeServer("Invite", Input.Text)
end)
Input.Buttons.Kick.MouseButton1Up:Connect(function() -- line: 735
    -- upvalues:
    --  [1] Input (copy)
    --  [2] ReplicatedStorage (copy)

    if Input.Text == "" then
        return
    end

    ReplicatedStorage.Remotes.Alliance:InvokeServer("Kick", Input.Text)
end)
Input.Buttons.Promote.MouseButton1Up:Connect(function() -- line: 741
    -- upvalues:
    --  [1] Input (copy)
    --  [2] ReplicatedStorage (copy)

    if Input.Text == "" then
        return
    end

    ReplicatedStorage.Remotes.Alliance:InvokeServer("Promote", Input.Text)
end)
Input.Buttons.Demote.MouseButton1Up:Connect(function() -- line: 747
    -- upvalues:
    --  [1] Input (copy)
    --  [2] ReplicatedStorage (copy)

    if Input.Text == "" then
        return
    end

    ReplicatedStorage.Remotes.Alliance:InvokeServer("Demote", Input.Text)
end)
t.Leave.MouseButton1Up:Connect(function() -- line: 753
    -- upvalues:
    --  [1] ConfirmFrame (copy)
    --  [2] v6 (ref)

    ConfirmFrame.Visible = not ConfirmFrame.Visible
    v6 = "Leave"
end)

if t.Composer then
    local Input_1 = t.Composer.Input
    local v97 = false

    local function postAnnouncement() -- line: 763
        -- upvalues:
        --  [1] Input_1 (copy)
        --  [2] v97 (ref)
        --  [3] ReplicatedStorage (copy)

        local Text_3 = Input_1.Text
        local Result_1, Success_2

        if not v97 then
            if string.match(Text_3, "^%s*$") then
                return
            end

            v97 = true
            Success_2, Result_1 = pcall(function() -- line: 769
                -- upvalues:
                --  [1] ReplicatedStorage (ref)
                --  [2] Text_3 (copy)

                return ReplicatedStorage.Remotes.Alliance:InvokeServer("Announce", Text_3)
            end)

            if Success_2 and Result_1 then
                Input_1.Text = ""
            end

            v97 = false

            return
        else
            return
        end
    end

    t.Composer.Post.MouseButton1Up:Connect(postAnnouncement)
    Input_1.FocusLost:Connect(function(arg14) -- line: 779
        -- upvalues:
        --  [1] postAnnouncement (copy)

        if arg14 then
            postAnnouncement()
        end
    end)
end

Input.FocusLost:Connect(function(arg15) -- line: 786
    -- upvalues:
    --  [1] Input (copy)

    if arg15 and Input.Fill.Text ~= "" then
        local v98 = autoSuggest(Input.Text)

        if v98 then
            Input.Text = v98
        end
    end
end)
local Remotes = ReplicatedStorage.Remotes

function Remotes.Alliance.OnClientInvoke(arg16, arg17) -- line: 795
    -- upvalues:
    --  [1] Invite (copy)
    --  [2] Services_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] UpdateClanInfo (copy)

    if arg16 == "Invite" then
        Invite.Info.Text = arg17
        Invite.Visible = true
        local v99 = Services_m.Maid.new()
        v99:GiveTask(Invite.Accept.MouseButton1Up:Once(function() -- line: 801
            -- upvalues:
            --  [1] v99 (copy)
            --  [2] ReplicatedStorage (ref)
            --  [3] Invite (ref)

            v99:Destroy()
            ReplicatedStorage.Remotes.Alliance:InvokeServer("Join")
            Invite.Visible = false
        end))
        v99:GiveTask(Invite.Decline.MouseButton1Up:Once(function() -- line: 806
            -- upvalues:
            --  [1] v99 (copy)
            --  [2] ReplicatedStorage (ref)
            --  [3] Invite (ref)

            v99:Destroy()
            ReplicatedStorage.Remotes.Alliance:InvokeServer("Decline")
            Invite.Visible = false
        end))

        return
    end

    UpdateClanInfo()
end

local t_7 = {
    PvP = { Folder = ReplicatedStorage:WaitForChild("TopGuildsPvP"), Label = "PvP Rating" },
    PvE = { Folder = ReplicatedStorage:WaitForChild("TopGuildsPvE"), Label = "PvE Rating" }
}
local v100 = "PvP"

local function CREATETEMPLATE(arg18, arg19) -- line: 825
    -- upvalues:
    --  [1] v100 (ref)
    --  [2] Players (copy)
    --  [3] Formatter_m (copy)
    --  [4] t_7 (copy)
    --  [5] RankingsFrame (copy)

    if arg19 ~= v100 then
        return
    end

    local Name = arg18.Name
    local Value = arg18:WaitForChild("MemberCount").Value
    local Value_1 = arg18:WaitForChild("Place").Value
    local Info = arg18:WaitForChild("info")
    local Value_2 = Info:WaitForChild("OwnerID").Value
    local Value_3 = Info:WaitForChild("Rating").Value
    local Value_4 = Info:WaitForChild("Logo").Value
    local Value_5 = Info:WaitForChild("Description").Value
    local Value_6 = Info:WaitForChild("Disbanded").Value
    local Value_7 = Info:WaitForChild("PrimaryColor").Value
    local Value_8 = Info:WaitForChild("SecondaryColor").Value
    local t_10 = {}
    t_10.P1 = { Color = Value_7, m = 1.1 }
    t_10.P2 = { Color = Value_7, m = 1.25 }
    t_10.S1 = { Color = Value_8, m = 1.25 }
    t_10.S2 = { Color = Value_8, m = 1.25, strokeOnly = true }
    t_10.S3 = { Color = Value_8, m = 3 }
    local v101 = Players:GetNameFromUserIdAsync(Value_2)
    local v102 = script.RankingTemplate:Clone()
    v102.LayoutOrder = Value_1
    v102.Name = Name
    local Logo_1 = v102.Logo
    Logo_1.Image = string.match(Value_4, "rbxassetid://") and Value_4 or "rbxassetid://" .. Value_4
    v102.Description.Text = Value_5
    v102.Header.Text = Name
    v102.Rank.Text = `#{Value_1}`
    local Rating = v102.Rating
    local v104 = Formatter_m.addCommas(Value_3)
    Rating.Text = `{v104} {t_7[arg19].Label}`
    v102:SetAttribute("Board", arg19)
    v102.BackgroundColor3 = Value_7

    for _, descendant_1 in v102:GetDescendants() do
        for key_22, _ in (descendant_1:GetAttributes()) do
            local v105 = t_10[key_22]

            if v105 then
                local Color_2 = v105.Color
                local M = v105.m
                local StrokeOnly = v105.strokeOnly
                local v106 = Color3.fromRGB(Color_2):Lerp(Color_2, M)

                if descendant_1:IsA("Frame") then
                    descendant_1.BackgroundColor3 = v106
                    break
                end

                if descendant_1:IsA("TextLabel") then
                    if StrokeOnly then
                        descendant_1.TextStrokeColor3 = Color3.fromRGB(Color_2):Lerp(Color_2, M)
                        break
                    end

                    descendant_1.TextColor3 = v106
                    descendant_1.TextStrokeColor3 = Color3.fromRGB(Color_2):Lerp(Color_2, M * 2.5)
                    break
                else
                    if not descendant_1:IsA("ImageLabel") then
                        break
                    end

                    descendant_1.ImageColor3 = v106
                    break
                end
            end
        end
    end

    if Value_1 == 1 then
        v102.Rank.TextColor3 = Color3.new(1, 1, 0)
    elseif Value_1 == 2 then
        v102.Rank.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    elseif Value_1 == 3 then
        v102.Rank.TextColor3 = Color3.fromRGB(166, 112, 0)
    end

    v102.Owned.Text = "Owned by " .. v101 .. ", " .. Value .. " Member(s)"
    v102.Disbanded.Visible = Value_6

    if arg19 ~= v100 or arg18.Parent ~= t_7[arg19].Folder then
        v102:Destroy()

        return
    end

    local v108 = RankingsFrame:FindFirstChild(Name)

    if v108 and v108:GetAttribute("Board") then
        v108:Destroy()
    end

    v102.Parent = RankingsFrame
end

local _ = function(arg20, arg21) --[[ DELETETEMPLATE ]] -- line: 933
    -- upvalues:
    --  [1] v100 (ref)
    --  [2] RankingsFrame (copy)

    if arg21 ~= v100 then
        return
    end

    local v109 = RankingsFrame:FindFirstChild(arg20.Name)

    if v109 then
        if not v109:GetAttribute("Board") then
            return
        end

        v109:Destroy()

        return
    else
        return
    end
end

local function showBoard(arg22) -- line: 945
    -- upvalues:
    --  [1] v100 (ref)
    --  [2] BoardTabs (copy)
    --  [3] color (copy)
    --  [4] RankingsFrame (copy)
    --  [5] t_7 (copy)
    --  [6] CREATETEMPLATE (copy)

    v100 = arg22

    for _, child_4 in BoardTabs:GetChildren() do
        if child_4:IsA("GuiButton") then
            child_4.Label.TextColor3 = if child_4.Name ~= arg22 then Color3.new(1, 1, 1) else color or Color3.new(
                1,
                1,
                1
            )
        end
    end

    for _, child_5 in RankingsFrame:GetChildren() do
        if child_5:GetAttribute("Board") then
            child_5:Destroy()
        end
    end

    for _, child_6 in t_7[arg22].Folder:GetChildren() do
        task.spawn(CREATETEMPLATE, child_6, arg22)
    end
end

for key_26, val_16 in t_7 do
    val_16.Folder.ChildAdded:Connect(function(child_7) -- line: 966
        -- upvalues:
        --  [1] CREATETEMPLATE (copy)
        --  [2] key_26 (copy)

        CREATETEMPLATE(child_7, key_26)
    end)
    val_16.Folder.ChildRemoved:Connect(function(child_8) -- line: 969
        -- upvalues:
        --  [1] key_26 (copy)
        --  [2] v100 (ref)
        --  [3] RankingsFrame (copy)

        if key_26 ~= v100 then
            return
        end

        local v111 = RankingsFrame:FindFirstChild(child_8.Name)

        if v111 then
            if not v111:GetAttribute("Board") then
                return
            end

            v111:Destroy()
        end
    end)
    local v112 = BoardTabs:FindFirstChild(key_26)

    if v112 then
        v112.MouseButton1Up:Connect(function() -- line: 975
            -- upvalues:
            --  [1] v100 (ref)
            --  [2] key_26 (copy)
            --  [3] showBoard (copy)

            if v100 ~= key_26 then
                showBoard(key_26)
            end
        end)
    end
end

showBoard(v100)
MemberCap.Purchase.MouseButton1Up:Connect(function() -- line: 987
    -- upvalues:
    --  [1] v29 (ref)
    --  [2] v30 (ref)
    --  [3] v31 (ref)
    --  [4] GuildConfig_m (copy)
    --  [5] ReplicatedStorage (copy)

    if v29 or not v30 or not v31 then
        return
    end

    local v113 = GuildConfig_m.GetMemberCapCost(v30.MemberCapLevel)

    if not v113 or v113 > (v30.GuildPoints or 0) then
        return
    end

    v29 = true
    ReplicatedStorage.Remotes.Alliance:InvokeServer("PurchaseUpgrade", "MemberCap")
    v29 = false
end)
ReplicatedStorage.Remotes.Guild.Event:Connect(function(arguments) -- line: 1001
    -- upvalues:
    --  [1] Parent (copy)

    Parent.Visible = arguments
end)
