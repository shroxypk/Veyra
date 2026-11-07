-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.Professions.ProfessionClient
-- Class: LocalScript
-- bytes: 62176

local Visible
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local Professions_m = require(Modules.Professions)
local CurrencyInfo_m = require(Modules.CurrencyInfo)
local v1 = require(Modules.scriptObjs).GetPlayerCharacter()
local Professions = v1:WaitForChild("Professions")
local Parent = script.Parent
local Templates = Parent.Templates
local ListView = Parent.ListView
local Scroll = ListView.Panel.Scroll
local Body = Scroll.TotalSection.Body
local Value = Body.Head.Value
local Progress = Body.Progress
local NextReward = Body.NextReward
local Track = Body.Track
local Claim = Body.Claim
local DetailView = Parent.DetailView
local HeaderBox = DetailView.HeaderBox
local Header = HeaderBox.Header
local v2 = Header.Back
local ProfName = Header.NameRow.ProfName
local RankLine = Header.InfoRow.RankLine
local Bar = Header.InfoRow.Bar

local function layoutHeaderBar() -- line: 47
    -- upvalues:
    --  [1] RankLine (copy)
    --  [2] Bar (copy)

    Bar.Size = UDim2.new(1, -(math.ceil(RankLine.TextBounds.X) + 12) - 2, 0, Bar.Size.Y.Offset)
end

RankLine:GetPropertyChangedSignal("TextBounds"):Connect(layoutHeaderBar)
local Tabs = HeaderBox.Tabs
local v4 = DetailView.Content
local MilestonesTab = v4.MilestonesTab
local Legend = MilestonesTab.Legend
local InfoTab = v4.InfoTab
local t = { Milestones = MilestonesTab, Info = InfoTab }
local New = Parent.Parent.Buttons.Professions:FindFirstChild("New")
CurrencyInfo_m.AttachHover(NextReward, "LockedEssence")
local MaxLevel = Professions_m.MaxLevel
local TotalLevelRewards = Professions_m.TotalLevelRewards
local FormatPercent = Professions_m.FormatPercent
local color = Color3.fromRGB(225, 225, 225)
local color_1 = Color3.fromRGB(175, 175, 175)
local color_2 = Color3.fromRGB(235, 235, 240)
local color_3 = Color3.fromRGB(150, 150, 160)
local color_4 = Color3.fromRGB(150, 230, 150)
local color_5 = Color3.fromRGB(170, 140, 230)
local color_6 = Color3.fromRGB(195, 165, 255)
local color_7 = Color3.fromRGB(215, 190, 255)
local color_8 = Color3.fromRGB(150, 128, 200)
local color_9 = Color3.fromRGB(150, 200, 255)
local color_10 = Color3.fromRGB(255, 120, 120)
local color_11 = Color3.fromRGB(20, 18, 24)
local color_12 = Color3.fromRGB(150, 215, 255)
local color_13 = Color3.fromRGB(200, 150, 255)
local t_2 = { color_12, color_13, Color3.fromRGB(240, 240, 245) }
local v5 = Professions_m:GetProfessions()
local t_3 = {}

for _, val in { "Mining", "Harvesting", "Combat", "Broom Flying", "Crafting", "Alchemy" } do
    if v5[val] then
        table.insert(t_3, val)
    end
end

local t_4 = {}

for key_1 in v5 do
    if not table.find(t_3, key_1) then
        table.insert(t_4, key_1)
    end
end

table.sort(t_4)

for _, val_1 in t_4 do
    table.insert(t_3, val_1)
end

local t_5 = {}
local t_6 = {}

for _, val_2 in t_3 do
    local v6 = Professions:WaitForChild(val_2, 30)
    local v8 = Professions:WaitForChild(val_2 .. "XP", 30)
    local v10 = Professions:WaitForChild(val_2 .. "MXP", 30)

    if v6 and (v8 and v10) then
        t_5[val_2] = { Level = v6, XP = v8, MXP = v10 }
        table.insert(t_6, val_2)
    else
        warn(`[ProfessionClient] missing saved values for {val_2}`)
    end
end

local v11 = t_6
local TotalClaimed = Professions:WaitForChild("TotalClaimed", 30)

local _ = function() --[[ getRemote ]] -- line: 135
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    return ReplicatedStorage.Remotes:WaitForChild("ProfessionRemote", 10)
end

local _ = function(arg1) --[[ getStats ]] -- line: 139
    -- upvalues:
    --  [1] t_5 (copy)

    local v12 = t_5[arg1]

    return v12.Level.Value, v12.XP.Value, v12.MXP.Value
end

local _ = function(arg2) --[[ formatNumber ]] -- line: 144
    return (tostring((math.floor(arg2))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))
end

local _ = function(arg3) --[[ formatTime ]] -- line: 149
    arg3 = math.ceil(arg3)

    if arg3 >= 60 then
        return string.format("%dm %02ds", arg3 // 60, arg3 % 60)
    end

    return `{arg3}s`
end

local _ = function(arg4) --[[ escape ]] -- line: 157
    return (tostring(arg4):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local _ = function(arg5, arg6) --[[ colorTag ]] -- line: 161
    local v14 = arg5:ToHex()

    return `<font color="#{v14}">{arg6}</font>`
end

local _ = function(arg7, arg8) --[[ darken ]] -- line: 165
    return arg7:Lerp(Color3.new(0, 0, 0), arg8)
end

local _ = function(arg9, arg10) --[[ lighten ]] -- line: 169
    return arg9:Lerp(Color3.new(1, 1, 1), arg10)
end

local _ = function(arg11) --[[ getNextMilestone ]] -- line: 173
    -- upvalues:
    --  [1] MaxLevel (copy)

    return (math.min((arg11 // 5 + 1) * 5, MaxLevel))
end

local _ = function(arg12) --[[ raceExists ]] -- line: 177
    local Map = workspace:FindFirstChild("Map")
    local v15 = Map

    if v15 then
        v15 = Map:FindFirstChild("@BroomRacing")
    end

    return if v15 ~= nil then if v15:FindFirstChild(arg12) == nil then false else true else false
end

local function getNextChallenge(arg13) -- line: 185
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] MaxLevel (copy)
    --  [3] Professions_m (copy)

    local v17 = t_5[arg13]
    local Value_1 = v17.Level.Value

    if Value_1 >= MaxLevel then
        return nil, nil, false
    end

    local Value_2 = v17.XP.Value
    local Value_3 = v17.MXP.Value
    local v18 = math.min((Value_1 // 5 + 1) * 5, MaxLevel)
    local v19 = Professions_m:GetChallenge(arg13, v18)

    if v19 and v19.Type == "Race" then
        local Race = v19.Race
        local Map_1 = workspace:FindFirstChild("Map")
        local v20 = Map_1

        if v20 then
            v20 = Map_1:FindFirstChild("@BroomRacing")
        end

        if not (if v20 ~= nil then if v20:FindFirstChild(Race) == nil then false else true else false) then
            v19 = nil
        end
    end

    if not v19 then
        return nil, v18, false
    end

    return v19, v18, if Value_1 + 1 ~= v18 then false else Value_2 >= Value_3
end

local _ = function(arg14) --[[ isChallengeReady ]] -- line: 203
    -- upvalues:
    --  [1] getNextChallenge (copy)

    local _, _, v25 = getNextChallenge(arg14)

    return v25
end

local _ = function(arg15) --[[ getCooldown ]] -- line: 208
    -- upvalues:
    --  [1] v1 (copy)

    local v26 = v1:GetAttribute("ProfChallengeCD_" .. string.gsub(arg15, "%s", "")) or 0

    return (math.max(v26 - workspace:GetServerTimeNow(), 0))
end

local _ = function() --[[ getTotalLevel ]] -- line: 213
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] t_5 (copy)

    local v27 = 0

    for _, val_3 in v11 do
        v27 += t_5[val_3].Level.Value
    end

    return v27
end

local _ = function() --[[ getNextTotalReward ]] -- line: 221
    -- upvalues:
    --  [1] TotalClaimed (copy)
    --  [2] TotalLevelRewards (copy)

    local v28 = TotalClaimed and TotalClaimed.Value or 0

    return TotalLevelRewards[v28 + 1], v28
end

local _ = function() --[[ getAccountClaimed ]] -- line: 229
    -- upvalues:
    --  [1] v1 (copy)

    return tonumber(v1:GetAttribute("AccountTotalClaimed")) or 0
end

local _ = function(arg16) --[[ isEssencePaidElsewhere ]] -- line: 234
    -- upvalues:
    --  [1] TotalClaimed (copy)
    --  [2] v1 (copy)

    return if arg16 > (TotalClaimed and TotalClaimed.Value or 0) then arg16 <= (tonumber(
        v1:GetAttribute("AccountTotalClaimed")
    ) or 0) and true else false
end

local _ = function() --[[ isTotalClaimable ]] -- line: 239
    -- upvalues:
    --  [1] TotalClaimed (copy)
    --  [2] TotalLevelRewards (copy)
    --  [3] v11 (ref)
    --  [4] t_5 (copy)

    local v31 = TotalClaimed and TotalClaimed.Value or 0
    local v32 = TotalLevelRewards[v31 + 1]
    v31 = false

    if v32 ~= nil then
        local v33 = 0

        for _, val_4 in v11 do
            v33 += t_5[val_4].Level.Value
        end

        v31 = v33 >= v32.Level
    end

    return v31
end

local function setFill(arg17, arg18) -- line: 245
    -- upvalues:
    --  [1] v1 (copy)

    if arg17:IsDescendantOf(v1) then
        arg17:TweenSize(
            UDim2.fromScale(arg18, 1),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.4,
            true
        )

        return
    end

    arg17.Size = UDim2.fromScale(arg18, 1)
end

local function setButtonEnabled(arg19, arg20) -- line: 253
    arg19.Active = arg20
    arg19.AutoButtonColor = false
    local v34 = if not arg20 then 0.45 else 0
    arg19.TextTransparency = v34
    v34 = arg20 and Color3.fromRGB(34, 34, 40) or Color3.fromRGB(15, 15, 24)
    arg19.BackgroundColor3 = v34
    v34 = arg19:FindFirstChild("Selected")

    if v34 then
        v34.Visible = arg20
    end
end

local _ = function(arg21, arg22) --[[ setIcon ]] -- line: 265
    -- upvalues:
    --  [1] v5 (copy)

    local v35 = v5[arg22]
    local v36 = if typeof(v35.Icon) == "string" then if v35.Icon == "" then false else true else false
    arg21.Image = v36 and v35.Icon or ""
    arg21.ImageColor3 = v35.Color
    arg21.Letter.Visible = not v36

    if not v36 then
        arg21.Letter.Text = string.upper((string.sub(arg22, 1, 1)))
        arg21.Letter.TextColor3 = v35.Color:Lerp(Color3.new(1, 1, 1), 0.35)
    end
end

local t_8 = {}
local v38 = nil
local v39 = "Milestones"
local v40 = nil
local t_9 = {}
local v41 = false
local v42 = nil
local v43 = nil

local function setXPBar(arg23, arg24, arg25) -- line: 292
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] MaxLevel (copy)
    --  [3] getNextChallenge (copy)
    --  [4] v5 (copy)
    --  [5] setFill (copy)

    local v44 = t_5[arg24]
    local Value_4 = v44.XP.Value
    local Value_5 = v44.MXP.Value
    local v45, v46

    if v44.Level.Value >= MaxLevel then
        v45 = 1
        v46 = "MAX"
    else
        local _, _, v49 = getNextChallenge(arg24)

        if v49 then
            v45 = 1
            v46 = if not arg25 then "Rank challenge ready" else "Challenge ready"
        else
            v45 = math.clamp(Value_4 / math.max(Value_5, 1), 0, 1)
            local v52 = tostring((math.floor(Value_4))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub(
                "^,",
                ""
            )
            local v53 = math.floor(Value_5)
            v46 = `{v52} / {tostring(v53):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")} XP`
        end
    end

    arg23.Front.BackgroundColor3 = v5[arg24].Color:Lerp(Color3.new(0, 0, 0), 0.2)
    arg23.Outline.ImageColor3 = v5[arg24].Color:Lerp(Color3.new(0, 0, 0), 0.5)
    setFill(arg23.Front, v45)
    arg23.Label.Text = v46
    arg23.Label.TextColor3 = Color3.new(1, 1, 1)
end

local _ = function() --[[ updateBadges ]] -- line: 314
    -- upvalues:
    --  [1] t_8 (copy)
    --  [2] getNextChallenge (copy)
    --  [3] TotalClaimed (copy)
    --  [4] TotalLevelRewards (copy)
    --  [5] v11 (ref)
    --  [6] t_5 (copy)
    --  [7] New (copy)

    local v54 = false

    for key_6 in t_8 do
        local v55 = v54

        if not v55 then
            local _, _, v58 = getNextChallenge(key_6)
            v55 = v58
        end

        v54 = v55
    end

    local v59 = v54

    if not v59 then
        local v60 = TotalClaimed and TotalClaimed.Value or 0
        local v61 = TotalLevelRewards[v60 + 1]
        v59 = false

        if v61 ~= nil then
            v60 = 0

            for _, val_5 in v11 do
                v60 += t_5[val_5].Level.Value
            end

            v59 = v60 >= v61.Level and true
        end
    end

    if New then
        New.Visible = v59
    end
end

local function updateCard(arg26) -- line: 328
    -- upvalues:
    --  [1] t_8 (copy)
    --  [2] v5 (copy)
    --  [3] t_5 (copy)
    --  [4] Professions_m (copy)
    --  [5] MaxLevel (copy)
    --  [6] getNextChallenge (copy)
    --  [7] color_2 (copy)
    --  [8] setXPBar (copy)

    local v62 = t_8[arg26]

    if not v62 then
        return
    end

    local Items = v62.Items
    local v63 = t_5[arg26]
    local v64 = v63.Level.Value
    local _ = v63.XP.Value
    local _ = v63.MXP.Value
    local v65 = v5[arg26]
    local v66 = Professions_m:GetRank(v64)
    local Title = Items.Title
    local v67 = tostring(arg26):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    Title.Text = `{v67} <i><font size="14">Lv {v64}/{MaxLevel}</font></i>`
    v64 = tostring(v66.Name):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local _, _, v70 = getNextChallenge(arg26)

    if v70 then
        local v71 = color_2:ToHex()
        v64 ..= "  " .. `<font color="#{v71}">\194\183 Challenge ready</font>`
    end

    Items.Rank.Text = v64
    setXPBar(v62.Bar, arg26, true)
    v62.Bar.Label.TextColor3 = v65.Color
end

local t_10 = {}

for key_8, val_6 in TotalLevelRewards do
    local v72 = Templates.TotalRow:Clone()
    v72.Name = tostring(val_6.Level)
    v72.LayoutOrder = key_8
    v72.Level.Text = tostring(val_6.Level)
    v72.Visible = true
    v72.Parent = Track
    t_10[key_8] = v72
end

local function refreshTotal() -- line: 366
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] t_5 (copy)
    --  [3] Value (copy)
    --  [4] MaxLevel (copy)
    --  [5] TotalClaimed (copy)
    --  [6] TotalLevelRewards (copy)
    --  [7] v1 (copy)
    --  [8] setFill (copy)
    --  [9] Progress (copy)
    --  [10] color_8 (copy)
    --  [11] color_5 (copy)
    --  [12] color_9 (copy)
    --  [13] NextReward (copy)
    --  [14] t_10 (copy)
    --  [15] color_4 (copy)
    --  [16] color_2 (copy)
    --  [17] color_1 (copy)
    --  [18] Claim (copy)
    --  [19] v41 (ref)
    --  [20] setButtonEnabled (copy)

    local v73 = 0

    for _, val_7 in v11 do
        v73 += t_5[val_7].Level.Value
    end

    local v74 = #v11 * MaxLevel
    Value.Text = `{v73} / {v74}`
    local v76 = TotalClaimed and TotalClaimed.Value or 0
    local v77 = TotalLevelRewards[v76 + 1]
    local v78 = v76
    v76 = false

    if v77 ~= nil then
        local v79 = v78 + 1
        v76 = if v79 > (TotalClaimed and TotalClaimed.Value or 0) then v79 <= (tonumber(
            v1:GetAttribute("AccountTotalClaimed")
        ) or 0) and true else false
    end

    if v77 then
        setFill(Progress.Front, (math.clamp(v73 / v77.Level, 0, 1)))
        local Label_1 = Progress.Label
        local v82 = math.min(v73, v77.Level)
        Label_1.Text = `{v82} / {v77.Level}`
        local v87

        if v76 then
            local v83 = `Next at {v77.Level}: `
            local v84 = color_8
            local v85 = `<s>+{v77.LockedEssence} Locked Essence</s> (essence already claimed on another slot)`
            local v86 = v84:ToHex()
            v87 = v83 .. `<font color="#{v86}">{v85}</font>`
        else
            local v88 = `Next at {v77.Level}: `
            local v89 = color_5
            local v90 = `<b>+{v77.LockedEssence}</b> Locked Essence`
            local v91 = v89:ToHex()
            v87 = v88 .. `<font color="#{v91}">{v90}</font>`
        end

        if v77.Title then
            local v92 = color_9
            local v93 = `"{tostring(v77.Title):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
                ">",
                "&gt;"
            )}"`
            local v94 = v92:ToHex()
            v87 ..= ", title " .. `<font color="#{v94}">{v93}</font>`
        end

        NextReward.Label.Text = v87
        NextReward.EssenceImage.Visible = true
    else
        setFill(Progress.Front, 1)
        Progress.Label.Text = "Complete"
        NextReward.Label.Text = "All rewards claimed"
        NextReward.EssenceImage.Visible = false
    end

    local v104, v106, v107, v96, v97, v98

    for key_10, val_8 in t_10 do
        local v95 = TotalLevelRewards[key_10]

        if v78 >= key_10 then
            v96 = "Claimed"
            v97 = color_4
            v98 = 0.45
        elseif key_10 == v78 + 1 and v73 >= v95.Level then
            v96 = "Ready!"
            v97 = color_2
            v98 = 0
        else
            v96 = nil
            v97 = color_1
            v98 = 0.2
        end

        local v99 = TotalClaimed and TotalClaimed.Value or 0
        local v100 = if key_10 > v99 then key_10 <= (tonumber(
            v1:GetAttribute("AccountTotalClaimed")
        ) or 0) and true else false
        v99 = if not (v78 >= key_10) then v100 else true

        if v99 then
            local v101 = color_8
            local v102 = `<s>+{v95.LockedEssence}</s>`
            local v103 = v101:ToHex()
            v104 = `<font color="#{v103}">{v102}</font>`

            if not v104 then
                local v105 = color_5
                v106 = `+{v95.LockedEssence}`
                v107 = v105:ToHex()
                v104 = `<font color="#{v107}">{v106}</font>`
            end
        else
            local v108 = color_5
            v106 = `+{v95.LockedEssence}`
            v107 = v108:ToHex()
            v104 = `<font color="#{v107}">{v106}</font>`
        end

        if v95.Title then
            local v109 = color_9
            local v110 = `"{tostring(v95.Title):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
                ">",
                "&gt;"
            )}"`
            local v111 = v109:ToHex()
            v104 ..= "  " .. `<font color="#{v111}">{v110}</font>`
        end

        if v100 then
            local v112 = color_8:ToHex()
            v104 ..= "  " .. `<font color="#{v112}">\194\183 other slot</font>`
        end

        val_8.Reward.Text = v104
        val_8.EssenceImage.ImageTransparency = if not v99 then v98 else 0.6
        val_8.State.Visible = v96 ~= nil
        val_8.State.Text = v96 or ""
        val_8.State.TextColor3 = v97
        local v114 = if not v96 then -84 else -160
        val_8.Reward.Size = UDim2.new(1, v114, 1, 0)
        val_8:FindFirstChild("Selected").Visible = if v96 ~= "Ready!" then false else true
        val_8.Level.TextTransparency = v98
        val_8.Reward.TextTransparency = v98
    end

    v78 = if v77 == nil then false else v73 >= v77.Level

    if not v77 then
        Claim.Text = "ALL CLAIMED"
    elseif v41 then
        Claim.Text = "CLAIMING..."
    else
        local v120

        if v78 and v76 then
            local v116 = Claim

            if v77.Title then
                local v117 = color_9
                local v118 = `"{tostring(v77.Title):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
                    ">",
                    "&gt;"
                )}"`
                local v119 = v117:ToHex()
                v120 = `CLAIM {`<font color="#{v119}">{v118}</font>`} \194\183 NO ESSENCE` or "CLAIM (ESSENCE ON OTHER SLOT)"
            else
                v120 = "CLAIM (ESSENCE ON OTHER SLOT)"
            end

            v116.Text = v120
        elseif v78 then
            local v121 = Claim

            if v77.Title then
                local v122 = color_9
                local v123 = `"{tostring(v77.Title):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
                    ">",
                    "&gt;"
                )}"`
                local v124 = v122:ToHex()
                v120 = `CLAIM REWARD \194\183 {`<font color="#{v124}">{v123}</font>`}` or "CLAIM REWARD"
            else
                v120 = "CLAIM REWARD"
            end

            v121.Text = v120
        else
            Claim.Text = `REACH {v77.Level} TO CLAIM`
        end
    end

    setButtonEnabled(Claim, v78 and not v41)
end

Claim.Activated:Connect(function() -- line: 440
    -- upvalues:
    --  [1] v41 (ref)
    --  [2] TotalClaimed (copy)
    --  [3] TotalLevelRewards (copy)
    --  [4] v11 (ref)
    --  [5] t_5 (copy)
    --  [6] refreshTotal (copy)
    --  [7] ReplicatedStorage (copy)
    --  [8] t_8 (copy)
    --  [9] getNextChallenge (copy)
    --  [10] New (copy)

    if not v41 then
        local v127 = TotalClaimed and TotalClaimed.Value or 0
        local v128 = TotalLevelRewards[v127 + 1]
        local v129 = false

        if v128 ~= nil then
            v127 = 0

            for _, val_9 in v11 do
                v127 += t_5[val_9].Level.Value
            end

            v129 = v127 >= v128.Level and true
        end

        if not v129 then
            return
        end

        v41 = true
        refreshTotal()
        task.spawn(function() -- line: 448
            -- upvalues:
            --  [1] ReplicatedStorage (ref)
            --  [2] v41 (ref)
            --  [3] refreshTotal (ref)
            --  [4] t_8 (ref)
            --  [5] getNextChallenge (ref)
            --  [6] TotalClaimed (ref)
            --  [7] TotalLevelRewards (ref)
            --  [8] v11 (ref)
            --  [9] t_5 (ref)
            --  [10] New (ref)

            local v130 = ReplicatedStorage.Remotes:WaitForChild("ProfessionRemote", 10)

            if v130 then
                local Success, Result = pcall(v130.InvokeServer, v130, "ClaimTotal")

                if not Success then
                    warn("[ProfessionClient] ClaimTotal failed:", Result)
                elseif typeof(Result) == "table" and Result.Result == "Claimed" and Result.Paid == false and _G.CreateAlert then
                    _G.CreateAlert(
                        "Reward claimed. Its Locked Essence was already claimed on another slot."
                    )
                end
            end

            v41 = false
            refreshTotal()
            v130 = false

            for key_12 in t_8 do
                local v131 = v130

                if not v131 then
                    local _, _, v134 = getNextChallenge(key_12)
                    v131 = v134
                end

                v130 = v131
            end

            local v135 = v130

            if not v135 then
                local v136 = TotalClaimed and TotalClaimed.Value or 0
                local v137 = TotalLevelRewards[v136 + 1]
                v135 = false

                if v137 ~= nil then
                    v136 = 0

                    for _, val_10 in v11 do
                        v136 += t_5[val_10].Level.Value
                    end

                    v135 = v136 >= v137.Level and true
                end
            end

            if New then
                New.Visible = v135
            end
        end)

        return
    else
        return
    end
end)

local function describeChallenge(arg27) -- line: 467
    local v146

    if arg27.Type == "Race" then
        v146 = arg27.Region and ` in <b>{tostring(arg27.Region):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )}</b>` or ""

        return `Finish <b>{tostring(arg27.Race):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )}</b>{v146} in under <b>{arg27.TargetTime}s</b>.`
    end

    v146 = arg27.Hits or 6
    local v147 = arg27.Crits or 0
    local v148 = arg27.Misses or 3
    local v149 = if arg27.CritStreak and v147 > 0 then `Land <b>{v147} crits in a row</b>` else if v147 > 0 then `Land <b>{v146} hits</b> (<b>{v147}</b> crits)` else `Land <b>{v146} hits</b>`
    local v150 = if v148 <= 0 then "with no misses" else if v148 == 1 then "with <b>1</b> miss allowed" else `with <b>{v148}</b> misses allowed`
    v148 = if arg27.Type ~= "Mining" then "harvesting" else "mining"

    return `{v149} {v150} in a {v148} trial.`
end

local function getChallengeStatus(arg28) -- line: 500
    -- upvalues:
    --  [1] getNextChallenge (copy)
    --  [2] t_5 (copy)
    --  [3] v1 (copy)
    --  [4] color_1 (copy)
    --  [5] v40 (ref)
    --  [6] color_2 (copy)
    --  [7] t_9 (copy)

    local v151, v152, v153 = getNextChallenge(arg28)

    if not v151 then
        return nil
    end

    local v154 = t_5[arg28]
    local _ = v154.XP.Value
    local _ = v154.MXP.Value
    local Value_10 = v154.Level.Value
    v154 = if v151.Type ~= "Race" then false else true
    v151 = if v154 then 0 else math.max(
        (v1:GetAttribute("ProfChallengeCD_" .. string.gsub(arg28, "%s", "")) or 0) - workspace:GetServerTimeNow(),
        0
    )
    local v156 = color_1
    local v157 = false
    local v158

    if v40 == arg28 then
        v158 = "Challenge in progress..."
        v156 = color_2
    else
        local v159

        if not v153 then
            if v152 > Value_10 + 1 then
                v159 = v152 - 1
                v158 = `Unlocks once your XP bar is full at Lv {v159}.`
            else
                v158 = "Fill your XP bar to attempt this challenge."
            end
        elseif v151 > 0 then
            local v160 = math.ceil(v151)
            v159 = if v160 >= 60 then string.format("%dm %02ds", v160 // 60, v160 % 60) else `{v160}s`
            v158 = `Try again in {v159}.`
        else
            v157 = v40 == nil
            v156 = color_2
            v158 = if not v154 then "Ready! Pass the trial to rank up." else "Ready! Finish the race in time to rank up."
        end
    end

    local v162 = t_9[arg28]

    if v162 then
        if os.clock() < v162.Until and v40 ~= arg28 then
            local Text = v162.Text
            local v163 = v162.Color:ToHex()
            v158 ..= "\n" .. `<font color="#{v163}">{Text}</font>`
        end
    end

    return {
        Milestone = v152,
        Status = v158,
        Color = v156,
        Enabled = v157,
        Ready = v153,
        Button = if not v154 then "START CHALLENGE" else "VIEW RACE"
    }
end

local t_12 = {
    Failed = { "Challenge failed.", color_10 },
    NotReady = { "Not ready yet: fill your XP bar first.", color_1 },
    Busy = { "You're already in a challenge.", color_1 },
    Cancelled = { "Challenge cancelled.", color_1 },
    Idle = { "Challenge timed out.", color_1 },
    Left = { "Challenge ended.", color_1 }
}

local function handleChallengeResult(arg29, arg30) -- line: 551
    -- upvalues:
    --  [1] color_1 (copy)
    --  [2] t_5 (copy)
    --  [3] color_2 (copy)
    --  [4] t_12 (copy)
    --  [5] t_9 (copy)

    local v165, v166, v170

    if typeof(arg30) ~= "table" then
        v165 = "Couldn't start the challenge. Try again."
        v166 = color_1
    elseif arg30.Result == "Passed" then
        local v167 = arg30.Level or t_5[arg29].Level.Value
        v165 = `Passed! You reached Lv {v167}.`
        v166 = color_2
    elseif arg30.Result == "Race" then
        local v168 = arg30.Region and ` in {tostring(arg30.Region):gsub("&", "&amp;"):gsub(
            "<",
            "&lt;"
        ):gsub(">", "&gt;")}` or ""
        v165 = `Head to {tostring(arg30.Race):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")}{v168} and finish in under {arg30.TargetTime}s.`
        v166 = color_2

        if _G.CreateAlert then
            _G.CreateAlert(`Rank challenge: finish {arg30.Race}{v168} in under {arg30.TargetTime}s`)
        end
    else
        if arg30.Result == "Cooldown" then
            return
        end

        local v169 = t_12[arg30.Result]
        v170 = v169[1]

        if not v169 or not v170 then
            local str = tostring(arg30.Result)
            v170 = `Challenge ended ({str}).`
        end

        v165 = v170
        v170 = v169 and v169[2] or color_1
        v166 = v170
    end

    v170 = { Text = v165, Color = v166, Until = nil }
    v170.Until, t_9[arg29] = os.clock() + 8, v170
end

local function startChallenge(arg31) -- line: 576
    -- upvalues:
    --  [1] v40 (ref)
    --  [2] getChallengeStatus (copy)
    --  [3] getNextChallenge (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] t_9 (copy)
    --  [6] v42 (ref)
    --  [7] v1 (copy)
    --  [8] handleChallengeResult (copy)

    if v40 then
        return
    end

    local v172 = getChallengeStatus(arg31)

    if not v172 or not v172.Enabled then
        return
    end

    local v173 = getNextChallenge(arg31)
    local ProfessionRemote = ReplicatedStorage.Remotes:WaitForChild("ProfessionRemote", 10)

    if not ProfessionRemote then
        return
    end

    v40 = arg31
    t_9[arg31] = nil
    v42()

    if v173 and v173.Type ~= "Race" then
        v1:SetAttribute("InMenu", false)
    end

    task.spawn(function() -- line: 600
        -- upvalues:
        --  [1] ProfessionRemote (copy)
        --  [2] arg31 (copy)
        --  [3] v40 (ref)
        --  [4] handleChallengeResult (ref)
        --  [5] v42 (ref)

        local Success_2, Result_2 = pcall(
            ProfessionRemote.InvokeServer,
            ProfessionRemote,
            "Challenge",
            arg31
        )

        if not Success_2 then
            warn("[ProfessionClient] Challenge failed:", Result_2)
        end

        v40 = nil
        handleChallengeResult(arg31, Success_2 and Result_2 or nil)
        v42()
    end)
end

local t_13 = {}

local function buildTrack(arg32) -- line: 617
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] Professions_m (copy)
    --  [3] Templates (copy)
    --  [4] color_1 (copy)
    --  [5] CurrencyInfo_m (copy)
    --  [6] color (copy)
    --  [7] color_9 (copy)
    --  [8] describeChallenge (copy)
    --  [9] startChallenge (copy)
    --  [10] color_2 (copy)
    --  [11] MaxLevel (copy)
    --  [12] MilestonesTab (copy)
    --  [13] t_13 (copy)

    local v175 = v5[arg32]
    local Frame = Instance.new("Frame")
    Frame.Name = arg32
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.fromScale(1, 0)
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Frame
    local v176 = Professions_m:GetLevelEntries(arg32)
    local t_14 = {}

    for key_16, val_12 in v176 do
        local v177 = Templates.LevelRow:Clone()
        v177.Name = tostring(key_16)
        v177.LayoutOrder = key_16
        v177.Level.Text = tostring(key_16)
        local Body_1 = v177.Body
        local v178 = val_12.Skill
        local v179 = if v178 ~= nil then v178.Name ~= nil else false
        Body_1.Main.Visible = not v179
        Body_1.Main.Gem.BackgroundColor3 = v175.Color

        if v178 then
            Body_1.Main.Text.Text = tostring(v178.Desc):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
                ">",
                "&gt;"
            )
        elseif key_16 > 1 then
            Body_1.Main.Text.Text = "Level up"
            Body_1.Main.Text.TextColor3 = color_1
        else
            Body_1.Main.Text.Text = "Where every journey starts."
            Body_1.Main.Text.TextColor3 = color_1
        end

        local Essence = v177.Essence
        Essence.Visible = if val_12.Reward == nil then false else true

        if val_12.Reward then
            CurrencyInfo_m.AttachHover(Essence, "LockedEssence")
        end

        Body_1.Skill.Visible = v179

        if v179 then
            Body_1.Skill.Texts.SkillName.Text = string.upper(
                (tostring(v178.Name):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
            )
            Body_1.Skill.Texts.Desc.Text = tostring(v178.Desc):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
                ">",
                "&gt;"
            )
            Body_1.Skill.UIStroke.Color = v175.Color:Lerp(Color3.new(0, 0, 0), 0.6)
            local Ring = Body_1.Skill.Ring
            Ring.Image.Image = v175.Icon or ""
            Ring.Image.ImageColor3 = v175.Color
            Ring.BackgroundColor3 = v175.Color:Lerp(Color3.new(0, 0, 0), 0.7)
        end

        v179 = Body_1.Milestone
        v178 = val_12.Rank ~= nil or (val_12.Quality ~= nil or val_12.Challenge ~= nil)
        v179.Visible = val_12.Milestone and v178

        if val_12.Milestone then
            v178 = string.upper(val_12.Rank or "")

            if val_12.Title then
                local v181 = color:ToHex()
                local v182 = `<font color="#{v181}">Title: </font>`
                local v183 = color_9
                local v184 = tostring(val_12.Title):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
                    ">",
                    "&gt;"
                )
                local v185 = v183:ToHex()
                v178 ..= "  \194\183  " .. v182 .. `<font color="#{v185}">{v184}</font>`
            end

            v179.Rank.Text = v178
            v179.Quality.Visible = val_12.Quality ~= nil
            local Quality = v179.Quality
            Quality.Text = val_12.Quality and `Material quality: {val_12.Quality}` or ""
            v178 = val_12.Challenge
            local Challenge = v179.Challenge
            local v187 = v178 ~= nil
            Challenge.Visible = v187

            if v178 then
                v187 = "<b>Rank challenge:</b> " .. describeChallenge(v178)

                if v178.Type == "Race" then
                    local Race_1 = v178.Race
                    local Map_2 = workspace:FindFirstChild("Map")
                    local v188 = Map_2

                    if v188 then
                        v188 = Map_2:FindFirstChild("@BroomRacing")
                    end

                    if not (if v188 ~= nil then if v188:FindFirstChild(Race_1) == nil then false else true else false) then
                        local v190 = color_1:ToHex()
                        v187 ..= " " .. `<font color="#{v190}">(race not open yet: this rank is reached automatically)</font>`
                    end
                end

                Challenge.Desc.Text = v187
                Challenge.Start.Activated:Connect(function() -- line: 696
                    -- upvalues:
                    --  [1] startChallenge (ref)
                    --  [2] arg32 (copy)

                    startChallenge(arg32)
                end)
            end

            v177.Level.TextSize = 26
            v177.Level.TextColor3 = color_2
        end

        v177.Highlight.BackgroundColor3 = v175.Color
        v177.Separator.Visible = key_16 < MaxLevel
        v177.Visible = true
        v177.Parent = Frame
        t_14[key_16] = v177
    end

    Frame.Parent = MilestonesTab
    t_13[arg32] = { Frame = Frame, Rows = t_14, Entries = v176 }

    return t_13[arg32]
end

local function fadeTexts(arg33, arg34) -- line: 717
    for _, descendant in arg33:GetDescendants() do
        if descendant:IsA("TextLabel") then
            local v192 = descendant.Name == "Sub" and math.max(arg34, 0.2) or arg34
            descendant.TextTransparency = v192
            v192 = descendant:FindFirstChildOfClass("UIStroke")

            if v192 then
                v192.Transparency = arg34
            end
        end
    end
end

local _ = function(arg35) --[[ getAccountEssence ]] -- line: 730
    -- upvalues:
    --  [1] v1 (copy)

    return tonumber(v1:GetAttribute("AccountEssence_" .. string.gsub(arg35, "%s", ""))) or 1
end

local function updateEssence(
    arg36,
    arg37,
    arg38,
    arg39,
    arg40
) -- line: 737
    -- upvalues:
    --  [1] MaxLevel (copy)
    --  [2] color_7 (copy)
    --  [3] color_6 (copy)
    --  [4] color_5 (copy)
    --  [5] color_8 (copy)

    local Essence_1 = arg36.Essence

    if not arg37.Reward then
        return false
    end

    local LockedEssence = arg37.Reward.LockedEssence
    local v195 = arg38 >= MaxLevel
    local v196 = arg38 <= math.max(arg39, arg40) and true
    local v197 = v195 and color_7 or (arg37.Milestone and color_6 or color_5)
    Essence_1.Amount.TextSize = if v195 then 18 else if not arg37.Milestone then 16 else 18
    local Amount = Essence_1.Amount
    Amount.Text = v196 and `<s>{LockedEssence}</s>` or tostring(LockedEssence)
    Essence_1.Amount.TextColor3 = v196 and color_8 or v197
    Essence_1.Amount.TextTransparency = if not v196 then 0 else 0.25
    Essence_1.Amount:FindFirstChildOfClass("UIStroke").Transparency = 0
    Essence_1.EssenceImage.ImageTransparency = if v196 then 0.55 else 0
    Essence_1.Check.Visible = false
    Essence_1.Mark.Visible = false

    return v196
end

local function updateTrack(arg41) -- line: 760
    -- upvalues:
    --  [1] t_13 (copy)
    --  [2] v5 (copy)
    --  [3] t_5 (copy)
    --  [4] getChallengeStatus (copy)
    --  [5] v1 (copy)
    --  [6] Legend (copy)
    --  [7] Professions_m (copy)
    --  [8] color_2 (copy)
    --  [9] color_11 (copy)
    --  [10] color_3 (copy)
    --  [11] fadeTexts (copy)
    --  [12] updateEssence (copy)
    --  [13] color_4 (copy)
    --  [14] setButtonEnabled (copy)

    local v200 = t_13[arg41]

    if not v200 then
        return
    end

    local v201 = v5[arg41]
    local v202 = t_5[arg41]
    local Value_11 = v202.Level.Value
    local _ = v202.XP.Value
    local _ = v202.MXP.Value
    local v203 = getChallengeStatus(arg41)
    local v206 = tonumber(v1:GetAttribute("AccountEssence_" .. string.gsub(arg41, "%s", ""))) or 1
    local v207 = false
    local Core = Legend.Core
    Core.Visible = if v201.Core == nil then false else true
    local Core_1 = Legend.Core
    Core_1.Text = v201.Core and tostring((Professions_m:FormatCore(arg41))):gsub("&", "&amp;"):gsub(
        "<",
        "&lt;"
    ):gsub(">", "&gt;") .. " every level" or ""
    local Core_2 = Legend.Core
    local Color_5 = v201.Color
    local v210 = Color3.new(1, 1, 1)
    Core_2.TextColor3 = Color_5:Lerp(v210, 0.2)

    for key_18, val_13 in v200.Rows do
        v210 = Value_11 >= key_18
        local v211 = key_18 == Value_11 + 1
        local v212 = if not v210 then if not v211 then 0.5 else 0.15 else 0
        val_13.Highlight.Visible = v211
        val_13.NextTag.Visible = v211
        val_13.Marker.BackgroundColor3 = v210 and v201.Color or (v211 and color_2 or color_11)
        val_13.Marker.BackgroundTransparency = 0
        local v214 = if not v200.Entries[key_18].Milestone then 10 else 12
        local v215 = if not v200.Entries[key_18].Milestone then 10 else 12
        val_13.Marker.Size = UDim2.fromOffset(v214, v215)
        val_13.Timeline.BackgroundTransparency = if not v210 then 0.75 else 0.35
        local Timeline = val_13.Timeline
        Timeline.BackgroundColor3 = v210 and v201.Color:Lerp(Color3.new(1, 1, 1), 0.2) or color_3
        fadeTexts(val_13, v212)
        val_13.NextTag.TextTransparency = 0

        if updateEssence(
            val_13,
            v200.Entries[key_18],
            key_18,
            Value_11,
            v206
        ) then
            v207 = true
        end

        local v217 = if not v210 then 0.6 else 0
        val_13.Body.Main.Gem.BackgroundTransparency = v217
        v217 = if not v210 then 0.55 else 0
        val_13.Body.Skill.Ring.Image.ImageTransparency = v217
        v217 = if not v210 then 0.75 else 0.55
        val_13.Body.Skill.BackgroundTransparency = v217
        v217 = if not v210 then 0.7 else 0.35
        val_13.Body.Skill.UIStroke.Transparency = v217
        v212 = val_13.Body.Milestone.Challenge

        if v212.Visible then
            v211 = if v203 == nil then false else v203.Milestone == key_18
            v212.Status.Visible = v211 or v210
            v217 = v211 and v203.Ready
            v212.Start.Visible = v217

            if v210 then
                v212.Status.Text = "Passed"
                v212.Status.TextColor3 = color_4
            elseif v211 then
                v212.Status.Text = v203.Status
                v212.Status.TextColor3 = v203.Color
                v212.Start.Text = v203.Button
                setButtonEnabled(v212.Start, v203.Enabled)
                v212.Status.TextTransparency = 0
                v212.Desc.TextTransparency = 0
            end
        end
    end

    Legend.Note.Text = "* Struck-out essence has already been claimed on this account."
    Legend.Note.Visible = v207
end

local _ = function(arg42) --[[ scrollToNextLevel ]] -- line: 823
    -- upvalues:
    --  [1] t_13 (copy)
    --  [2] t_5 (copy)
    --  [3] MaxLevel (copy)
    --  [4] MilestonesTab (copy)

    local v218 = t_13[arg42]

    if not v218 then
        return
    end

    local v219 = t_5[arg42]
    local _ = v219.XP.Value
    local _ = v219.MXP.Value
    local v221 = v218.Rows[math.clamp(v219.Level.Value + 1, 1, MaxLevel)]
    task.defer(function() -- line: 830
        -- upvalues:
        --  [1] v221 (copy)
        --  [2] MilestonesTab (ref)

        if not v221 or not v221.Parent then
            return
        end

        MilestonesTab.CanvasPosition = Vector2.new(
            0,
            (math.max(
                v221.AbsolutePosition.Y - MilestonesTab.AbsolutePosition.Y + MilestonesTab.CanvasPosition.Y - 60,
                0
            ))
        )
    end)
end

local v223 = 0
local v224 = false

local function reflowContent() -- line: 845
    -- upvalues:
    --  [1] v4 (copy)

    local t_16 = {}

    for _, descendant_1 in v4:GetDescendants() do
        if descendant_1:IsA("TextLabel") and descendant_1.TextWrapped and descendant_1.AutomaticSize ~= Enum.AutomaticSize.None then
            local Size = descendant_1.Size
            table.insert(t_16, { descendant_1, Size })
            descendant_1.Size = UDim2.new(
                Size.X.Scale,
                Size.X.Offset - 1,
                Size.Y.Scale,
                Size.Y.Offset
            )
        end
    end

    task.wait()

    for _, val_14 in t_16 do
        val_14[1].Size = val_14[2]
    end
end

local _ = function() --[[ queueReflow ]] -- line: 860
    -- upvalues:
    --  [1] v224 (ref)
    --  [2] v4 (copy)
    --  [3] reflowContent (copy)

    if v224 then
        return
    end

    v224 = true
    task.delay(0.1, function() -- line: 865
        -- upvalues:
        --  [1] v224 (ref)
        --  [2] v4 (ref)
        --  [3] reflowContent (ref)

        v224 = false

        if v4.AbsoluteSize.X > 1 then
            reflowContent()
        end
    end)
end

v4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 873
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] v223 (ref)
    --  [3] v224 (ref)
    --  [4] reflowContent (copy)

    local X = v4.AbsoluteSize.X

    if X <= 1 then
        v223 = 0

        return
    end

    if X ~= v223 then
        v223 = X

        if v224 then
            return
        end

        v224 = true
        task.delay(0.1, function() -- line: 865
            -- upvalues:
            --  [1] v224 (ref)
            --  [2] v4 (ref)
            --  [3] reflowContent (ref)

            v224 = false

            if v4.AbsoluteSize.X > 1 then
                reflowContent()
            end
        end)
    end
end)

local _ = function(arg43, arg44, arg45, arg46) --[[ addLine ]] -- line: 888
    -- upvalues:
    --  [1] Templates (copy)
    --  [2] color (copy)

    local v225 = Templates.Line:Clone()
    v225.Name = "Line" .. arg44
    v225.LayoutOrder = arg44
    v225.Text = arg45
    v225.TextColor3 = arg46 or color
    v225.Visible = true
    v225.Parent = arg43

    return v225
end

local function fillLines(arg47, arg48) -- line: 899
    -- upvalues:
    --  [1] Templates (copy)
    --  [2] color (copy)

    for _, child in arg47:GetChildren() do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    for key_22, val_15 in arg48 do
        local v227 = val_15[1]
        local v228 = val_15[2]
        local v229 = Templates.Line:Clone()
        v229.Name = "Line" .. key_22
        v229.LayoutOrder = key_22
        v229.Text = v227
        v229.TextColor3 = v228 or color
        v229.Visible = true
        v229.Parent = arg47
    end
end

local function attributeKey(arg49) -- line: 911
    local t_17 = {}
    local v231 = arg49.Attributes or {}

    for key_23 in v231 do
        table.insert(t_17, key_23)
    end

    table.sort(t_17)

    return table.concat(t_17, "+")
end

local function refreshInfo() -- line: 920
    -- upvalues:
    --  [1] v38 (ref)
    --  [2] v5 (copy)
    --  [3] t_5 (copy)
    --  [4] InfoTab (copy)
    --  [5] Professions_m (copy)
    --  [6] color_1 (copy)
    --  [7] color (copy)
    --  [8] attributeKey (copy)
    --  [9] fillLines (copy)
    --  [10] v1 (copy)
    --  [11] FormatPercent (copy)
    --  [12] t_2 (copy)

    local v232 = v38

    if not v232 then
        return
    end

    local v233 = v5[v232]
    local v234 = t_5[v232]
    local Value_16 = v234.Level.Value
    local _ = v234.XP.Value
    local _ = v234.MXP.Value
    local v235 = v233.Color:Lerp(Color3.new(1, 1, 1), 0.35)
    InfoTab.Description.Text = tostring(v233.Desc or ""):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
        ">",
        "&gt;"
    )
    local t_18 = {}

    if v233.Core then
        local v237 = Professions_m:FormatCore(v232, v233.Core.PerLevel * (Value_16 - 1))
        local v238 = `<b>{tostring(v237):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")}</b>  `
        local v239 = color_1:ToHex()
        table.insert(t_18, { v238 .. `<font color="#{v239}">(from levels)</font>`, color })
    end

    local t_20 = {}
    local t_21 = {}
    local t_22 = {}
    local v240 = nil

    for index = 1, Value_16 do
        local v241 = v233.Skills[index]

        if v241 then
            if v241.Attributes and v241.Attributes.tracker ~= nil then
                v240 = v241
            elseif v241.Name then
                table.insert(t_22, v241)
            else
                local v243 = attributeKey(v241)

                if not t_20[v243] then
                    table.insert(t_21, v243)
                end

                t_20[v243] = v241
            end
        end
    end

    for _, val_16 in t_21 do
        table.insert(
            t_18,
            {
                tostring(t_20[val_16].Desc):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"),
                color
            }
        )
    end

    if #t_18 == 0 then
        table.insert(t_18, { "No bonuses yet.", color_1 })
    end

    local t_24 = {}

    if v240 then
        local _ = {}
        local v244 = "<b>" .. tostring(v240.Name or "Tracker"):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        ) .. "</b>"
        local v245 = v235:ToHex()
        local v246 = `<font color="#{v245}">{v244}</font>`
        table.insert(
            t_24,
            {
                `{v246}: {tostring(v240.Desc):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")}`,
                color
            }
        )
    end

    for _, val_17 in t_22 do
        local _ = {}
        local v247 = "<b>" .. tostring(val_17.Name):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        ) .. "</b>"
        local v248 = v235:ToHex()
        local v249 = `<font color="#{v248}">{v247}</font>`
        table.insert(
            t_24,
            {
                `{v249}: {tostring(val_17.Desc):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
                    ">",
                    "&gt;"
                )}`,
                color
            }
        )
    end

    if #t_24 == 0 then
        table.insert(t_24, { "None yet. Abilities unlocked by levelling show up here.", color_1 })
    end

    fillLines(InfoTab.Stats, t_18)
    fillLines(InfoTab.Unlocks, t_24)
    local QualityHeader = InfoTab.QualityHeader
    QualityHeader.Visible = v233.Gathers == true
    local Quality_1 = InfoTab.Quality
    Quality_1.Visible = v233.Gathers == true

    if v233.Gathers then
        v240 = Professions_m:GetQualityOdds(Value_16, Professions_m:GetPlayerBenefits(v1, v232))

        for index_1 = 1, 3 do
            local v252 = InfoTab.Quality["Star" .. index_1]
            local v253 = FormatPercent(v240[index_1])
            v252.Text = `{index_1}\226\152\133 {v253}`
            v252.TextColor3 = v240[index_1] > 0 and t_2[index_1] or color_1
            v252.TextTransparency = if not (v240[index_1] > 0) then 0.4 else 0
        end
    end
end

local function setTab(arg50) -- line: 995
    -- upvalues:
    --  [1] v39 (ref)
    --  [2] t (copy)
    --  [3] Tabs (copy)
    --  [4] color_2 (copy)
    --  [5] color_1 (copy)
    --  [6] v43 (ref)
    --  [7] v38 (ref)
    --  [8] t_13 (copy)
    --  [9] t_5 (copy)
    --  [10] MaxLevel (copy)
    --  [11] MilestonesTab (copy)
    --  [12] v224 (ref)
    --  [13] v4 (copy)
    --  [14] reflowContent (copy)

    v39 = arg50
    local v255

    for key_26, val_18 in t do
        v255 = if key_26 ~= arg50 then false else true
        val_18.Visible = v255
        local v256 = Tabs[key_26]
        v256:FindFirstChild("Selected").Visible = v255
        v256.TextColor3 = v255 and color_2 or color_1
        v256.BackgroundColor3 = v255 and Color3.fromRGB(34, 34, 40) or Color3.fromRGB(15, 15, 24)
    end

    v43()

    if arg50 == "Milestones" and v38 then
        local v258 = v38
        local v259 = t_13[v258]

        if v259 then
            v255 = t_5[v258]
            local _ = v255.XP.Value
            local _ = v255.MXP.Value
            local v261 = v259.Rows[math.clamp(v255.Level.Value + 1, 1, MaxLevel)]
            task.defer(function() -- line: 830
                -- upvalues:
                --  [1] v261 (copy)
                --  [2] MilestonesTab (ref)

                if not v261 or not v261.Parent then
                    return
                end

                MilestonesTab.CanvasPosition = Vector2.new(
                    0,
                    (math.max(
                        v261.AbsolutePosition.Y - MilestonesTab.AbsolutePosition.Y + MilestonesTab.CanvasPosition.Y - 60,
                        0
                    ))
                )
            end)
        end
    end

    if v224 then
        return
    end

    v224 = true
    task.delay(0.1, function() -- line: 865
        -- upvalues:
        --  [1] v224 (ref)
        --  [2] v4 (ref)
        --  [3] reflowContent (ref)

        v224 = false

        if v4.AbsoluteSize.X > 1 then
            reflowContent()
        end
    end)
end

function v43() --[[ refreshDetail ]] -- line: 1012
    -- upvalues:
    --  [1] v38 (ref)
    --  [2] v5 (copy)
    --  [3] t_5 (copy)
    --  [4] Professions_m (copy)
    --  [5] HeaderBox (copy)
    --  [6] ProfName (copy)
    --  [7] RankLine (copy)
    --  [8] MaxLevel (copy)
    --  [9] Bar (copy)
    --  [10] setXPBar (copy)
    --  [11] v39 (ref)
    --  [12] t_13 (copy)
    --  [13] buildTrack (copy)
    --  [14] updateTrack (copy)
    --  [15] refreshInfo (copy)

    local v263 = v38

    if not v263 then
        return
    end

    local v264 = v5[v263]
    local v265 = t_5[v263]
    local Value_21 = v265.Level.Value
    local _ = v265.XP.Value
    local _ = v265.MXP.Value
    local v266 = Professions_m:GetRank(Value_21)
    local v267 = v264.Color
    HeaderBox.BackgroundColor3 = v267:Lerp(Color3.new(0, 0, 0), 0.8)
    HeaderBox.Outline.ImageColor3 = v267:Lerp(Color3.new(0, 0, 0), 0.5)
    local v269 = HeaderBox:FindFirstChild("IconHolder")

    if v269 then
        v269 = HeaderBox.IconHolder:FindFirstChild("Icon")
    end

    if v269 then
        local v270 = if typeof(v264.Icon) == "string" then if v264.Icon == "" then false else true else false
        v269.Visible = v270
        v269.Image = v270 and v264.Icon or ""
        v269.ImageColor3 = v267
    end

    ProfName.Text = v263
    ProfName.TextColor3 = v267
    RankLine.Text = `{v266.Name} \194\183 Lv {Value_21}/{MaxLevel}`
    RankLine.TextColor3 = v267
    Bar.Size = UDim2.new(1, -(math.ceil(RankLine.TextBounds.X) + 12) - 2, 0, Bar.Size.Y.Offset)
    setXPBar(Bar, v263, false)
    Bar.Label.TextColor3 = v267

    if v39 == "Milestones" then
        v267 = t_13[v263] or buildTrack(v263)

        for key_27, val_19 in t_13 do
            val_19.Frame.Visible = key_27 == v263
        end

        v267.Frame.Visible = true
        updateTrack(v263)

        return
    end

    if v39 == "Info" then
        refreshInfo()
    end
end

local _ = function(arg51) --[[ openProfession ]] -- line: 1053
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] v38 (ref)
    --  [3] ListView (copy)
    --  [4] DetailView (copy)
    --  [5] InfoTab (copy)
    --  [6] setTab (copy)

    if not t_5[arg51] then
        return
    end

    v38 = arg51
    ListView.Visible = false
    DetailView.Visible = true
    InfoTab.CanvasPosition = Vector2.zero
    setTab("Milestones")
end

local function closeProfession() -- line: 1064
    -- upvalues:
    --  [1] v38 (ref)
    --  [2] DetailView (copy)
    --  [3] ListView (copy)
    --  [4] v42 (ref)

    v38 = nil
    DetailView.Visible = false
    ListView.Visible = true
    v42()
end

v2.Activated:Connect(closeProfession)

for key_28 in t do
    Tabs[key_28].Activated:Connect(function() -- line: 1074
        -- upvalues:
        --  [1] v39 (ref)
        --  [2] key_28 (copy)
        --  [3] setTab (copy)

        if v39 ~= key_28 then
            setTab(key_28)
        end
    end)
end

function v42() --[[ refreshAll ]] -- line: 1081
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] updateCard (copy)
    --  [3] refreshTotal (copy)
    --  [4] v43 (ref)
    --  [5] t_8 (copy)
    --  [6] getNextChallenge (copy)
    --  [7] TotalClaimed (copy)
    --  [8] TotalLevelRewards (copy)
    --  [9] t_5 (copy)
    --  [10] New (copy)

    for _, val_20 in v11 do
        updateCard(val_20)
    end

    refreshTotal()
    v43()
    local v275 = false

    for key_30 in t_8 do
        local v276 = v275

        if not v276 then
            local _, _, v279 = getNextChallenge(key_30)
            v276 = v279
        end

        v275 = v276
    end

    local v280 = v275

    if not v280 then
        local v281 = TotalClaimed and TotalClaimed.Value or 0
        local v282 = TotalLevelRewards[v281 + 1]
        v280 = false

        if v282 ~= nil then
            v281 = 0

            for _, val_21 in v11 do
                v281 += t_5[val_21].Level.Value
            end

            v280 = v281 >= v282.Level and true
        end
    end

    if New then
        New.Visible = v280
    end
end

local v284, v287

for key_32, val_22 in v11 do
    local v283 = v5[val_22]
    v2 = v283.Color
    local v285 = v2:Lerp(Color3.new(0, 0, 0), 0.2)
    local v286 = v2:Lerp(Color3.new(0, 0, 0), 0.8)
    v284 = v2:Lerp(Color3.new(0, 0, 0), 0.5)
    local v288 = Templates.Job:Clone()
    v287 = v288.Items
    v288.Name = val_22
    v288.LayoutOrder = key_32
    v288.Bar.Front.BackgroundColor3 = v285
    v288.Bar.Outline.ImageColor3 = v284
    v288.Bar.Label.TextColor3 = v2
    v288.BackgroundColor3 = v286
    v288.Outline.ImageColor3 = v284
    v287.Title.TextColor3 = v2
    v287.Title.RichText = true
    v287.Rank.TextColor3 = v2
    v287.Rank.RichText = true
    v287 = v288.IconHolder.Icon
    v284 = if typeof(v283.Icon) == "string" then if v283.Icon == "" then false else true else false
    v287.Visible = v284

    if v284 then
        v287.Image = v283.Icon
        v287.ImageColor3 = v2
    end

    v288.Activated:Connect(function() -- line: 1125
        -- upvalues:
        --  [1] val_22 (copy)
        --  [2] t_5 (copy)
        --  [3] v38 (ref)
        --  [4] ListView (copy)
        --  [5] DetailView (copy)
        --  [6] InfoTab (copy)
        --  [7] setTab (copy)

        local v289 = val_22

        if not t_5[v289] then
            return
        end

        v38 = v289
        ListView.Visible = false
        DetailView.Visible = true
        InfoTab.CanvasPosition = Vector2.zero
        setTab("Milestones")
    end)
    local v287 = v288.Outline
    local v284 = v287.ImageColor3
    v288.MouseEnter:Connect(function() -- line: 1133
        -- upvalues:
        --  [1] v287 (copy)
        --  [2] v2 (copy)

        v287.ImageColor3 = v2
    end)
    v288.MouseLeave:Connect(function() -- line: 1136
        -- upvalues:
        --  [1] v287 (copy)
        --  [2] v284 (copy)

        v287.ImageColor3 = v284
    end)
    t_8[val_22] = v288
    updateCard(val_22)
    v288.Visible = true
    v288.Parent = Scroll
end

for _, val_23 in v11 do
    local v290 = t_5[val_23]

    local function onChanged() -- line: 1152
        -- upvalues:
        --  [1] updateCard (copy)
        --  [2] val_23 (copy)
        --  [3] refreshTotal (copy)
        --  [4] t_8 (copy)
        --  [5] getNextChallenge (copy)
        --  [6] TotalClaimed (copy)
        --  [7] TotalLevelRewards (copy)
        --  [8] v11 (ref)
        --  [9] t_5 (copy)
        --  [10] New (copy)
        --  [11] v38 (ref)
        --  [12] v43 (ref)

        updateCard(val_23)
        refreshTotal()
        local v291 = false

        for key_34 in t_8 do
            local v292 = v291

            if not v292 then
                local _, _, v295 = getNextChallenge(key_34)
                v292 = v295
            end

            v291 = v292
        end

        local v296 = v291

        if not v296 then
            local v297 = TotalClaimed and TotalClaimed.Value or 0
            local v298 = TotalLevelRewards[v297 + 1]
            v296 = false

            if v298 ~= nil then
                v297 = 0

                for _, val_24 in v11 do
                    v297 += t_5[val_24].Level.Value
                end

                v296 = v297 >= v298.Level and true
            end
        end

        if New then
            New.Visible = v296
        end

        if v38 == val_23 then
            v43()
        end
    end

    v290.XP:GetPropertyChangedSignal("Value"):Connect(onChanged)
    v290.MXP:GetPropertyChangedSignal("Value"):Connect(onChanged)
    v290.Level:GetPropertyChangedSignal("Value"):Connect(onChanged)
    v1:GetAttributeChangedSignal("AccountEssence_" .. string.gsub(val_23, "%s", "")):Connect(function() -- line: 1166
        -- upvalues:
        --  [1] v38 (ref)
        --  [2] val_23 (copy)
        --  [3] v39 (ref)
        --  [4] updateTrack (copy)

        if v38 == val_23 and v39 == "Milestones" then
            updateTrack(val_23)
        end
    end)
    v1:GetAttributeChangedSignal("ProfChallengeCD_" .. string.gsub(val_23, "%s", "")):Connect(function() -- line: 1172
        -- upvalues:
        --  [1] v38 (ref)
        --  [2] val_23 (copy)
        --  [3] v39 (ref)
        --  [4] updateTrack (copy)

        if v38 == val_23 and v39 == "Milestones" then
            updateTrack(val_23)
        end
    end)
end

if TotalClaimed then
    TotalClaimed:GetPropertyChangedSignal("Value"):Connect(function() -- line: 1180
        -- upvalues:
        --  [1] refreshTotal (copy)
        --  [2] t_8 (copy)
        --  [3] getNextChallenge (copy)
        --  [4] TotalClaimed (copy)
        --  [5] TotalLevelRewards (copy)
        --  [6] v11 (ref)
        --  [7] t_5 (copy)
        --  [8] New (copy)

        refreshTotal()
        local v303 = false

        for key_36 in t_8 do
            local v304 = v303

            if not v304 then
                local _, _, v307 = getNextChallenge(key_36)
                v304 = v307
            end

            v303 = v304
        end

        local v308 = v303

        if not v308 then
            local v309 = TotalClaimed and TotalClaimed.Value or 0
            local v310 = TotalLevelRewards[v309 + 1]
            v308 = false

            if v310 ~= nil then
                v309 = 0

                for _, val_25 in v11 do
                    v309 += t_5[val_25].Level.Value
                end

                v308 = v309 >= v310.Level and true
            end
        end

        if New then
            New.Visible = v308
        end
    end)
end

v1:GetAttributeChangedSignal("AccountTotalClaimed"):Connect(refreshTotal)
Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 1189
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] v42 (ref)
    --  [3] v224 (ref)
    --  [4] v4 (copy)
    --  [5] reflowContent (copy)

    if Parent.Visible then
        v42()

        if v224 then
            return
        end

        v224 = true
        task.delay(0.1, function() -- line: 865
            -- upvalues:
            --  [1] v224 (ref)
            --  [2] v4 (ref)
            --  [3] reflowContent (ref)

            v224 = false

            if v4.AbsoluteSize.X > 1 then
                reflowContent()
            end
        end)
    end
end)
task.spawn(function() -- line: 1197
    -- upvalues:
    --  [1] t_8 (copy)
    --  [2] getNextChallenge (copy)
    --  [3] TotalClaimed (copy)
    --  [4] TotalLevelRewards (copy)
    --  [5] v11 (ref)
    --  [6] t_5 (copy)
    --  [7] New (copy)
    --  [8] Parent (copy)
    --  [9] v38 (ref)
    --  [10] v39 (ref)
    --  [11] updateTrack (copy)

    while true do
        if not script.Parent then
            break
        end

        task.wait(1)
        local v311 = false

        for key_38 in t_8 do
            local v312 = v311

            if not v312 then
                local _, _, v315 = getNextChallenge(key_38)
                v312 = v315
            end

            v311 = v312
        end

        local v316 = v311

        if not v316 then
            local v317 = TotalClaimed and TotalClaimed.Value or 0
            local v318 = TotalLevelRewards[v317 + 1]
            v316 = false

            if v318 ~= nil then
                v317 = 0

                for _, val_26 in v11 do
                    v317 += t_5[val_26].Level.Value
                end

                v316 = v317 >= v318.Level and true
            end
        end

        if New then
            New.Visible = v316
        end

        if not Parent.Visible then
            continue
        end

        if not v38 then
            continue
        end

        if v39 ~= "Milestones" then
            continue
        end

        updateTrack(v38)
    end
end)
ListView.Visible = true
DetailView.Visible, Visible = false, v42
Visible()
local Parent_1 = script.Parent
local Outline_2 = Parent_1.Parent:FindFirstChild("Outline")
local DetailView_1 = Parent_1:FindFirstChild("DetailView")
local _ = Parent_1:FindFirstChild("DetailView")

if Outline_2 and DetailView_1 then
    local function syncOutline() -- line: 1223
        -- upvalues:
        --  [1] Outline_2 (copy)
        --  [2] Parent_1 (copy)
        --  [3] DetailView_1 (copy)

        local v319 = Parent_1.Visible and DetailView_1.Visible
        Outline_2.Visible = not v319
    end

    Parent_1:GetPropertyChangedSignal("Visible"):Connect(syncOutline)
    DetailView_1:GetPropertyChangedSignal("Visible"):Connect(syncOutline)
    local Visible_1 = Parent_1.Visible

    if Visible_1 then
        Visible_1 = DetailView_1.Visible
    end

    Outline_2.Visible = not Visible_1
end
