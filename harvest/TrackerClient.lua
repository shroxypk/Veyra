-- Decompiled with Veyra harvester
-- Instance: StarterGui.ProfessionTrackerHUD.TrackerClient
-- Class: LocalScript
-- bytes: 40828

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Professions_m = require(ReplicatedStorage.Modules.Professions)
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
local Holder = Parent.Holder
local TrackerWidget = script.TrackerWidget
local t = {
    Profession = "Mining",
    Kind = "Ore",
    Attribute = "Tracker_Ore",
    Title = "Tracker",
    Section = "Ores",
    Noun = { "ore type", "ore types" },
    Color = Color3.fromRGB(131, 126, 190)
}
local RespawnTimer = script.RespawnTimer
local MapMarker = script.MapMarker
local t_1 = {
    t,
    {
        Profession = "Harvesting",
        Kind = "Harvest",
        Attribute = "Tracker_Harvest",
        Title = "Tracker",
        Section = "Plants",
        Noun = { "plant type", "plant types" },
        Color = Color3.fromRGB(142, 171, 99)
    }
}
local t_3 = {
    { Range = 500, Types = 1 },
    { Range = 1000, Types = 1, Count = true },
    { Range = 1000, Types = 2, Count = true, Outline = true },
    { Range = 2000, Types = 2, Count = true, Outline = true, Timers = true, MapMarkers = true }
}
local t_4 = { "I", "II", "III", "IV" }
local color = Color3.fromRGB(110, 110, 110)
local v1 = 0.2
local v2 = nil
local ProfessionTrackerFX_Folder = Instance.new("Folder")
ProfessionTrackerFX_Folder.Name = "ProfessionTrackerFX"
ProfessionTrackerFX_Folder.Parent = Workspace
local t_5 = { Ore = {}, Harvest = {} }

local _ = function(arg1) --[[ getItem ]] -- line: 106
    return arg1:GetAttribute("Item") or arg1.Name
end

local function indexRecord(arg2) -- line: 110
    -- upvalues:
    --  [1] t_5 (copy)

    if not arg2:IsA("Configuration") then
        return
    end

    local v5 = t_5[arg2:GetAttribute("Kind")]

    if not v5 then
        return
    end

    local v6 = arg2:GetAttribute("Item") or arg2.Name
    local v7 = v5[v6] or {}
    v5[v6] = v7
    table.insert(v5[v6], arg2)
end

local function unindexRecord(arg3) -- line: 125
    -- upvalues:
    --  [1] t_5 (copy)

    for _, val in t_5 do
        for key_1, val_1 in val do
            local v8 = table.find(val_1, arg3)

            if v8 then
                table.remove(val_1, v8)

                if #val_1 == 0 then
                    val[key_1] = nil
                end

                return
            end
        end
    end
end

local v9 = nil
task.spawn(function() -- line: 141
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] indexRecord (copy)
    --  [3] v9 (ref)
    --  [4] unindexRecord (copy)
    --  [5] v1 (ref)

    local ProfessionNodes = ReplicatedStorage:WaitForChild("ProfessionNodes")

    for _, child in ProfessionNodes:GetChildren() do
        indexRecord(child)
    end

    ProfessionNodes.ChildAdded:Connect(function(child_1) -- line: 146
        -- upvalues:
        --  [1] indexRecord (ref)
        --  [2] v9 (ref)

        indexRecord(child_1)

        if v9 then
            v9()
        end
    end)
    ProfessionNodes.ChildRemoved:Connect(function(child_2) -- line: 152
        -- upvalues:
        --  [1] unindexRecord (ref)
        --  [2] v9 (ref)

        unindexRecord(child_2)

        if v9 then
            v9()
        end
    end)
    v1 = 0.2

    if v9 then
        v9()
    end
end)
local t_6 = { Ore = {}, Harvest = {} }
local t_7 = setmetatable({}, { __mode = "k" })

local _ = function(arg6) --[[ getNodePart ]] -- line: 171
    return arg6.PrimaryPart or (arg6:FindFirstChild("Handle") or arg6:FindFirstChildWhichIsA(
        "BasePart"
    ))
end

local function watchModelFolder(arg7, arg8) -- line: 175
    -- upvalues:
    --  [1] t_6 (copy)

    local v11 = t_6[arg7]

    local function add(arg9) -- line: 178
        -- upvalues:
        --  [1] v11 (copy)

        if arg9:IsA("Model") then
            local v12 = v11[arg9.Name] or {}
            v11[arg9.Name] = v12
            v11[arg9.Name][arg9] = true
        end
    end

    local function remove(arg10) -- line: 185
        -- upvalues:
        --  [1] v11 (copy)

        local v13 = v11[arg10.Name]

        if v13 then
            v13[arg10] = nil
        end
    end

    for _, child_3 in arg8:GetChildren() do
        if child_3:IsA("Model") then
            local v14 = v11[child_3.Name] or {}
            v11[child_3.Name] = v14
            v11[child_3.Name][child_3] = true
        end
    end

    arg8.ChildAdded:Connect(add)
    arg8.ChildRemoved:Connect(remove)
end

task.spawn(function() -- line: 199
    -- upvalues:
    --  [1] Workspace (copy)
    --  [2] watchModelFolder (copy)

    local Harvestable = Workspace:WaitForChild("Map"):WaitForChild("Harvestable")
    task.spawn(function() -- line: 201
        -- upvalues:
        --  [1] watchModelFolder (ref)
        --  [2] Harvestable (copy)

        watchModelFolder("Ore", Harvestable:WaitForChild("Ores"))
    end)
    watchModelFolder("Harvest", Harvestable:WaitForChild("Crops"))
end)

local function findModel(arg11, arg12) -- line: 208
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] t_6 (copy)

    local v17 = t_7[arg12]

    if v17 and v17.Parent then
        return v17
    end

    t_7[arg12] = nil
    local v20 = t_6[arg11][arg12:GetAttribute("Item") or arg12.Name]
    local Position = arg12:GetAttribute("Position")

    if v20 then
        if typeof(Position) ~= "Vector3" then
            return nil
        end

        for key_4 in v20 do
            local v21 = key_4.PrimaryPart or (key_4:FindFirstChild("Handle") or key_4:FindFirstChildWhichIsA(
                "BasePart"
            ))

            if v21 and (v21.Position - Position).Magnitude <= 6 then
                t_7[arg12] = key_4

                return key_4
            end
        end

        return nil
    else
        return nil
    end
end

local v22 = nil
task.spawn(function() -- line: 237
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] v22 (ref)

    local Success, Result = pcall(require, ReplicatedStorage.Modules:WaitForChild("MapService"))

    if Success then
        v22 = Result

        return
    end

    warn(`[ProfessionTracker] Map markers unavailable: {Result}`)
end)
local Professions = nil

local _ = function(arg13) --[[ getTier ]] -- line: 251
    -- upvalues:
    --  [1] Professions (ref)
    --  [2] Professions_m (copy)
    --  [3] LocalPlayer (copy)
    --  [4] t_3 (copy)

    local v24 = Professions

    if v24 then
        v24 = Professions:FindFirstChild(arg13.Profession)
    end

    if not v24 then
        return 0
    end

    return (math.clamp(
        math.floor(
            tonumber(Professions_m:GetPlayerBenefits(LocalPlayer, arg13.Profession).tracker) or 0
        ),
        0,
        #t_3
    ))
end

local function getSelection(arg14, arg15) -- line: 263
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local t_8 = {}
    local attribute = LocalPlayer:GetAttribute(arg14.Attribute)

    if typeof(attribute) ~= "string" then
        return t_8
    end

    for _, val_2 in string.split(attribute, ",") do
        local v26 = string.match(val_2, "^%s*(.-)%s*$")

        if v26 ~= "" and not table.find(t_8, v26) then
            table.insert(t_8, v26)

            if arg15 <= #t_8 then
                break
            end
        end
    end

    return t_8
end

local function syncHighlights(arg16, arg17) -- line: 287
    -- upvalues:
    --  [1] findModel (copy)
    --  [2] ProfessionTrackerFX_Folder (copy)

    local t_9 = {}

    for index = 1, math.min(#arg17, 12) do
        local v27 = arg17[index]
        local v28 = findModel(arg16.Kind, v27)
        local _ = math.min(#arg17, 12)

        if v28 then
            t_9[v27] = true
            local v30 = arg16.Highlights[v27]

            if not v30 or v30.Adornee ~= v28 or not v30.Parent then
                if v30 then
                    v30:Destroy()
                end

                local Highlight = Instance.new("Highlight")
                local Kind = arg16.Kind
                local v31 = v27:GetAttribute("Item") or v27.Name
                Highlight.Name = `{Kind}_{v31}`
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                Highlight.FillColor = arg16.Color
                Highlight.FillTransparency = 0.8
                Highlight.OutlineColor = arg16.Color
                Highlight.OutlineTransparency = 0
                Highlight.Adornee = v28
                Highlight.Parent = ProfessionTrackerFX_Folder
                arg16.Highlights[v27] = Highlight
            end
        end
    end

    for key_7, val_3 in arg16.Highlights do
        if not t_9[key_7] then
            val_3:Destroy()
            arg16.Highlights[key_7] = nil
        end
    end
end

local _ = function(arg18) --[[ formatTime ]] -- line: 326
    local v32 = math.ceil(arg18)
    arg18 = math.max(0, v32)

    return string.format("%d:%02d", arg18 // 60, arg18 % 60)
end

local function syncTimers(arg19, arg20, arg21) -- line: 331
    -- upvalues:
    --  [1] Workspace (copy)
    --  [2] RespawnTimer (copy)
    --  [3] t_3 (copy)
    --  [4] ProfessionTrackerFX_Folder (copy)

    local t_10 = {}
    local v42

    for index_1 = 1, math.min(#arg20, 20) do
        local v33 = arg20[index_1]
        t_10[v33] = true
        local v34 = arg19.Timers[v33]
        local _ = math.min(#arg20, 20)

        if not v34 then
            local ProfessionTrackerTimer_Attachment = Instance.new("Attachment")
            ProfessionTrackerTimer_Attachment.Name = "ProfessionTrackerTimer"
            ProfessionTrackerTimer_Attachment.Parent = Workspace.Terrain
            ProfessionTrackerTimer_Attachment.WorldPosition = v33:GetAttribute("Position") + Vector3.new(0, 4, 0)
            local v36 = RespawnTimer:Clone()
            local Kind_1 = arg19.Kind
            local v37 = v33:GetAttribute("Item") or v33.Name
            v36.Name = `{Kind_1}_{v37}`
            v36.Adornee = ProfessionTrackerTimer_Attachment
            local ItemName = v36.Panel.ItemName
            ItemName.Text = v33:GetAttribute("Item") or v33.Name
            v36.Panel.Time.TextColor3 = arg19.Color
            v36.Enabled = true
            v36.MaxDistance = t_3[4].Range
            v36.Parent = ProfessionTrackerFX_Folder
            v34 = { Gui = v36, Attachment = ProfessionTrackerTimer_Attachment }
            arg19.Timers[v33] = v34
        end

        local v39 = (v33:GetAttribute("RespawnAt") or 0) - arg21
        local Time = v34.Gui.Panel.Time

        if v39 > 0 then
            local v41 = math.max(0, (math.ceil(v39)))
            v42 = string.format("%d:%02d", v41 // 60, v41 % 60)
        else
            v42 = "Soon"
        end

        Time.Text = v42
    end

    for key_8, val_4 in arg19.Timers do
        if not t_10[key_8] then
            val_4.Gui:Destroy()
            val_4.Attachment:Destroy()
            arg19.Timers[key_8] = nil
        end
    end
end

local function syncMarkers(arg22, arg23) -- line: 371
    -- upvalues:
    --  [1] v22 (ref)
    --  [2] MapMarker (copy)
    --  [3] color (copy)

    local v43 = v22

    if v43 then
        v43 = v22.addMarker
    end

    if arg22.MarkerSource ~= v43 then
        for key_9, val_5 in arg22.Markers do
            pcall(val_5.Remove)
            arg22.Markers[key_9] = nil
        end

        arg22.MarkerSource = v43
    end

    if v43 then
        for key_10, val_6 in arg23 do
            local v44 = arg22.Markers[key_10]

            if not v44 then
                local Position_1 = key_10:GetAttribute("Position")
                local t_12 = { ZIndex = 4, Hover = nil, AlwaysVisible = true }
                local v45 = MapMarker
                t_12.Hover = key_10:GetAttribute("Item") or key_10.Name
                local Success_1
                local v47
                Success_1, v47, Position_1 = pcall(v43, Position_1, v45, t_12)

                if Success_1 and Position_1 then
                    v44 = { Remove = v47, Gui = Position_1 }
                    arg22.Markers[key_10] = v44
                    v47 = if not val_6 then color else arg22.Color
                    v44.Gui.BackgroundColor3 = v47
                end
            else
                v44.Gui.BackgroundColor3 = if not val_6 then color else arg22.Color
            end
        end
    end

    for key_11, val_7 in arg22.Markers do
        if arg23[key_11] == nil then
            pcall(val_7.Remove)
            arg22.Markers[key_11] = nil
        end
    end
end

local function clearEffects(arg24) -- line: 412
    -- upvalues:
    --  [1] syncHighlights (copy)
    --  [2] syncTimers (copy)
    --  [3] syncMarkers (copy)

    syncHighlights(arg24, {})
    syncTimers(arg24, {}, 0)
    syncMarkers(arg24, {})
end

for key_12, val_8 in t_1 do
    local v48 = TrackerWidget:Clone()
    v48.Name = val_8.Profession
    v48.LayoutOrder = key_12
    v48.Visible = false
    v48.Dial.UIStroke.Color = val_8.Color

    for _, child_4 in v48.Dial.Arrow:GetChildren() do
        if child_4:IsA("Frame") then
            child_4.BackgroundColor3 = val_8.Color
        end
    end

    local Stop = v48.Stop
    local UIStroke = Stop:FindFirstChildOfClass("UIStroke")
    Stop.MouseEnter:Connect(function() -- line: 437
        -- upvalues:
        --  [1] Stop (copy)
        --  [2] UIStroke (copy)

        Stop.TextColor3 = Color3.fromRGB(255, 190, 124)
        Stop.BackgroundColor3 = Color3.fromRGB(48, 36, 26)

        if UIStroke then
            UIStroke.Color = Color3.fromRGB(255, 190, 124)
        end
    end)
    Stop.MouseLeave:Connect(function() -- line: 444
        -- upvalues:
        --  [1] Stop (copy)
        --  [2] UIStroke (copy)

        Stop.TextColor3 = Color3.fromRGB(175, 175, 175)
        Stop.BackgroundColor3 = Color3.fromRGB(15, 15, 24)

        if UIStroke then
            UIStroke.Color = Color3.fromRGB(111, 111, 124)
        end
    end)
    Stop.Activated:Connect(function() -- line: 451
        -- upvalues:
        --  [1] LocalPlayer (copy)
        --  [2] val_8 (copy)

        LocalPlayer:SetAttribute(val_8.Attribute, "")
    end)
    v48.Parent = Holder
    val_8.Widget = v48
    val_8.Arrow = v48.Dial.Arrow
    val_8.Active = false
    val_8.Tier = 0
    val_8.Names = {}
    val_8.Target = nil
    val_8.Angle = 0
    val_8.StatusText = ""
    val_8.Highlights = {}
    val_8.Timers = {}
    val_8.Markers = {}
    val_8.MarkerSource = nil
end

local _ = function(arg25, arg26) --[[ setStatus ]] -- line: 471
    if arg25.StatusText ~= arg26 then
        arg25.StatusText = arg26
        arg25.Widget.Status.Text = arg26
    end
end

local function refreshConfig(arg27) -- line: 479
    -- upvalues:
    --  [1] Professions (ref)
    --  [2] Professions_m (copy)
    --  [3] LocalPlayer (copy)
    --  [4] t_3 (copy)
    --  [5] getSelection (copy)
    --  [6] v2 (ref)
    --  [7] clearEffects (copy)
    --  [8] t_4 (copy)
    --  [9] v1 (ref)

    local v57 = Professions

    if v57 then
        v57 = Professions:FindFirstChild(arg27.Profession)
    end

    local v58 = if not v57 then 0 else math.clamp(
        math.floor(
            tonumber(Professions_m:GetPlayerBenefits(LocalPlayer, arg27.Profession).tracker) or 0
        ),
        0,
        #t_3
    )
    local v60 = t_3[v58]
    local v61 = if not v60 then {} else getSelection(arg27, v60.Types)
    arg27.Tier = v58
    arg27.Names = v61
    arg27.Active = if v60 == nil then false else #v61 > 0
    arg27.Widget.Visible = arg27.Active

    if v2 then
        v2()
    end

    if not arg27.Active then
        arg27.Target = nil
        clearEffects(arg27)

        return
    end

    local Widget = arg27.Widget
    local Title = Widget.Title
    local Title_1 = arg27.Title
    local v63 = arg27.Color:ToHex()
    Title.Text = `{Title_1} <font color="#{v63}">{t_4[v58]}</font>`
    Widget.Types.Text = table.concat(v61, ", ")
    v1 = 0.2
end

local function refreshAll() -- line: 506
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] refreshConfig (copy)

    for _, val_9 in t_1 do
        refreshConfig(val_9)
    end
end

local Panel = Parent.Panel
local Body = Panel.Body
local Header = Body.Header
local Info = Body.Info
local BackArrow = Body:FindFirstChild("BackArrow", true)
local Home = Body.Home
local Picker = Body.Picker
local Grid = Picker.Grid
local TypeCard = script.TypeCard
local v65 = Parent.OpenTracker
local Close = Panel.Close
local color_1 = Color3.fromRGB(48, 36, 26)
local color_2 = Color3.fromRGB(225, 225, 225)
local color_3 = Color3.fromRGB(175, 175, 175)
local color_4 = Color3.fromRGB(15, 15, 24)
local color_5 = Color3.fromRGB(90, 90, 90)
local color_6 = Color3.fromRGB(160, 160, 160)
local t_14 = {
    Ore = { Title = "Ore Tracker", Verb = "an ore type" },
    Harvest = { Title = "Plant Tracker", Verb = "a plant type" }
}
local color_7 = Color3.fromRGB(111, 111, 124)
local color_8 = Color3.fromRGB(200, 200, 210)

local function darken(arg28, arg29) -- line: 548
    return arg28:Lerp(Color3.new(0, 0, 0), arg29)
end

local v66 = nil
local t_15 = {}
local v67 = nil

local function getMaterials(arg30) -- line: 557
    -- upvalues:
    --  [1] t_5 (copy)

    local t_16 = {}
    local t_17 = {}

    for key_15, val_10 in t_5[arg30] do
        local v68 = math.huge

        for _, val_11 in val_10 do
            v68 = math.min(v68, val_11:GetAttribute("Power") or 0)
            t_17[key_15] = t_17[key_15] or val_11:GetAttribute("Drop")
        end

        t_16[key_15] = v68
    end

    local t_18 = {}

    for key_17 in t_16 do
        table.insert(t_18, key_17)
    end

    table.sort(t_18, function(arg31, arg32) -- line: 572
        -- upvalues:
        --  [1] t_16 (copy)

        return if t_16[arg31] == t_16[arg32] then arg31 < arg32 else t_16[arg31] < t_16[arg32]
    end)

    return t_18, t_17
end

local Discovered = nil

local function getDiscovered() -- line: 583
    -- upvalues:
    --  [1] Discovered (ref)

    local t_19 = {}

    if Discovered then
        for _, val_12 in string.split(Discovered.Value, ",") do
            val_12 = string.match(val_12, "^%s*(.-)%s*$")

            if val_12 ~= "" then
                t_19[val_12] = true
            end
        end
    end

    return t_19
end

local function getUnlockLevel(arg33) -- line: 597
    -- upvalues:
    --  [1] Professions_m (copy)

    local v71 = Professions_m:GetProfessions()[arg33]
    local v72 = nil

    for key_19, val_13 in v71 and v71.Skills or {} do
        v72 = if not val_13.Attributes then v72 else if not val_13.Attributes.tracker then v72 else if not v72 then key_19 else if not (v72 > key_19) then v72 else key_19
    end

    return v72
end

local function pickType(arg34, arg35) -- line: 609
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Professions (ref)
    --  [3] Professions_m (copy)
    --  [4] LocalPlayer (copy)
    --  [5] getSelection (copy)

    local v74 = t_3
    local v75 = Professions

    if v75 then
        v75 = Professions:FindFirstChild(arg34.Profession)
    end

    local v78 = v74[if not v75 then 0 else math.clamp(
        math.floor(
            tonumber(Professions_m:GetPlayerBenefits(LocalPlayer, arg34.Profession).tracker) or 0
        ),
        0,
        #t_3
    )]

    if not v78 then
        return
    end

    local v79 = getSelection(arg34, v78.Types)
    local v80 = table.find(v79, arg35)

    if v80 then
        table.remove(v79, v80)
    else
        table.insert(v79, arg35)

        while true do
            if not (#v79 > v78.Types) then
                break
            end

            table.remove(v79, 1)
        end
    end

    LocalPlayer:SetAttribute(arg34.Attribute, table.concat(v79, ","))
end

local function getShowcaseModel(arg36, arg37, arg38) -- line: 632
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Workspace (copy)

    local Tools = ReplicatedStorage:FindFirstChild("Tools")
    local v82 = arg38

    if v82 then
        v82 = Tools

        if v82 then
            v82 = Tools:FindFirstChild(arg38)
        end
    end

    if not v82 then
        local v83 = Workspace:FindFirstChild("Map")
        local v84 = v83

        if v84 then
            v84 = v83:FindFirstChild("Harvestable")
        end

        v83 = v84

        if v83 then
            v83 = v84:FindFirstChild(if arg36 ~= "Ore" then "Crops" else "Ores")
        end

        local v86 = v83

        if v86 then
            v86 = v83:FindFirstChild(arg37)
        end

        v82 = v86
    end

    if not v82 then
        return nil
    end

    local v87 = v82:Clone()

    for _, descendant in v87:GetDescendants() do
        if not descendant:IsA("LuaSourceContainer") then
            if not descendant:IsA("ProximityPrompt") then
                if not descendant:IsA("Sound") then
                    if descendant:IsA("BillboardGui") then
                        descendant:Destroy()
                    end
                else
                    descendant:Destroy()
                end
            else
                descendant:Destroy()
            end
        else
            descendant:Destroy()
        end
    end

    if not v87:IsA("Model") then
        v82 = Instance.new("Model")
        v87.Parent = v82
        v87 = v82
    end

    return v87
end

local function fitModel(arg39, arg40) -- line: 660
    arg40.Parent = arg39
    local Success_2, Result_1, v88 = pcall(arg40.GetBoundingBox, arg40)

    if not Success_2 then
        return false
    end

    local Camera = Instance.new("Camera")
    Camera.FieldOfView = 30
    Camera.Parent = arg39
    arg39.CurrentCamera = Camera
    local v89 = math.max(v88.Magnitude / 2, 0.1)
    Camera.CFrame = CFrame.lookAt(
        Result_1.Position + Vector3.new(0.5318108, 0.37460658, 0.75950456) * (v89 / math.tan(
            (math.rad(Camera.FieldOfView / 2))
        )),
        Result_1.Position
    )

    return true
end

local v91 = nil
task.spawn(function() -- line: 681
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] v91 (ref)

    local Success_3, Result_2 = pcall(require, ReplicatedStorage.Modules:WaitForChild("Items", 10))

    if Success_3 and typeof(Result_2) == "table" then
        v91 = Result_2.AllItems or Result_2
    end
end)

local function setCardVisual(arg41, arg42, arg43, arg44) -- line: 688
    -- upvalues:
    --  [1] getShowcaseModel (copy)
    --  [2] fitModel (copy)
    --  [3] v91 (ref)

    local v92 = getShowcaseModel(arg42, arg43, arg44)

    if v92 and fitModel(arg41.Viewport, v92) then
        arg41.Icon.Visible = false

        return
    end

    v92 = v91 and (arg44 and v91[arg44])
    local v93 = v92.Image

    if typeof(v92) ~= "table" or not v93 then
        v93 = nil
    end

    arg41.Icon.Image = v93 or ""
    arg41.Icon.Visible = v93 ~= nil
end

local _ = function() --[[ clearCards ]] -- line: 701
    -- upvalues:
    --  [1] t_15 (copy)
    --  [2] v67 (ref)

    for _, val_14 in t_15 do
        val_14:Destroy()
    end

    table.clear(t_15)
    v67 = nil
end

local function refreshHome() -- line: 712
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Home (copy)
    --  [3] Professions (ref)
    --  [4] Professions_m (copy)
    --  [5] LocalPlayer (copy)
    --  [6] t_3 (copy)
    --  [7] color_5 (copy)
    --  [8] darken (copy)
    --  [9] color_3 (copy)
    --  [10] t_4 (copy)
    --  [11] getUnlockLevel (copy)

    local v97

    for _, val_15 in t_1 do
        local v95 = Home[val_15.Section]
        local v96 = Professions

        if v96 then
            v96 = Professions:FindFirstChild(val_15.Profession)
        end

        if not v96 then
            v97 = 0
        else
            local _ = Home
            v97 = math.clamp(
                math.floor(
                    tonumber(
                        Professions_m:GetPlayerBenefits(LocalPlayer, val_15.Profession).tracker
                    ) or 0
                ),
                0,
                #t_3
            )
        end

        v96 = if t_3[v97] == nil then false else true
        local v100 = v96 and val_15.Color or color_5
        v95.BackgroundColor3 = v100:Lerp(Color3.new(0, 0, 0), 0.8)
        v95.Outline.ImageColor3 = v100:Lerp(Color3.new(0, 0, 0), 0.5)
        v95:SetAttribute("OutlineColor", darken(v100, 0.5))
        v95:SetAttribute("HoverColor", v100)
        v95.IconHolder.Icon.ImageColor3 = v100
        v95.IconHolder.Icon.ImageTransparency = if v96 then 0.85 else 0.93
        v95.Title.TextColor3 = v96 and v100 or color_3
        v95.Title.TextTransparency = if not v96 then 0.35 else 0
        v95.Arrow.Visible = v96
        v95.Arrow.TextColor3 = v100

        if v96 then
            v95.Tier.Text = `Tier {t_4[v97]}`
            v95.Tier.TextColor3 = v100:Lerp(Color3.new(1, 1, 1), 0.35)
        else
            local v102 = getUnlockLevel(val_15.Profession)
            local Tier_2 = v95.Tier
            Tier_2.Text = v102 and `Reach {val_15.Profession} Lv {v102}` or "Locked"
            v95.Tier.TextColor3 = color_3
        end
    end
end

local function refreshPicker(arg45) -- line: 741
    -- upvalues:
    --  [1] Professions (ref)
    --  [2] Professions_m (copy)
    --  [3] LocalPlayer (copy)
    --  [4] t_3 (copy)
    --  [5] v66 (ref)
    --  [6] t_14 (copy)
    --  [7] getMaterials (copy)
    --  [8] Picker (copy)
    --  [9] t_4 (copy)
    --  [10] v67 (ref)
    --  [11] t_15 (copy)
    --  [12] TypeCard (copy)
    --  [13] setCardVisual (copy)
    --  [14] getDiscovered (copy)
    --  [15] pickType (copy)
    --  [16] color_8 (copy)
    --  [17] color_7 (copy)
    --  [18] Grid (copy)
    --  [19] getSelection (copy)
    --  [20] color_6 (copy)
    --  [21] color_2 (copy)
    --  [22] color_3 (copy)
    --  [23] color_1 (copy)
    --  [24] color_4 (copy)

    local v104 = Professions

    if v104 then
        v104 = Professions:FindFirstChild(arg45.Profession)
    end

    local v105 = if not v104 then 0 else math.clamp(
        math.floor(
            tonumber(Professions_m:GetPlayerBenefits(LocalPlayer, arg45.Profession).tracker) or 0
        ),
        0,
        #t_3
    )
    local v107 = t_3[v105]

    if not v107 then
        v66 = nil

        return false
    end

    local _ = t_14[arg45.Kind]
    local v109, v110 = getMaterials(arg45.Kind)
    local Noun = arg45.Noun
    local v111 = if v107.Types ~= 1 then 2 else 1
    Picker.Hint.Text = `Pick up to {v107.Types} {Noun[v111]} to track \194\183 Tier {t_4[v105]} \194\183 {v107.Range}m`
    Picker.Empty.Visible = if #v109 ~= 0 then false else true
    local v112 = arg45.Kind .. ":" .. table.concat(v109, ",")

    if v112 ~= v67 then
        for _, val_16 in t_15 do
            val_16:Destroy()
        end

        table.clear(t_15)
        v67 = nil
        v67 = v112

        for key_24, val_17 in v109 do
            v105 = TypeCard:Clone()
            v105.Name = val_17
            v105.LayoutOrder = key_24
            setCardVisual(v105, arg45.Kind, val_17, v110[val_17])
            v105.Activated:Connect(function() -- line: 765
                -- upvalues:
                --  [1] getDiscovered (ref)
                --  [2] val_17 (copy)
                --  [3] pickType (ref)
                --  [4] arg45 (copy)

                if getDiscovered()[val_17] then
                    pickType(arg45, val_17)
                end
            end)
            v105.MouseEnter:Connect(function() -- line: 770
                -- upvalues:
                --  [1] v105 (copy)
                --  [2] color_8 (ref)

                if v105.Active then
                    v105.Outline.ImageColor3 = color_8
                end
            end)
            v105.MouseLeave:Connect(function() -- line: 775
                -- upvalues:
                --  [1] v105 (copy)
                --  [2] color_7 (ref)

                v105.Outline.ImageColor3 = color_7
            end)
            v105.Parent = Grid
            t_15[val_17] = v105
        end
    end

    local v113 = getDiscovered()
    local v114 = getSelection(arg45, v107.Types)

    for key_25, val_18 in t_15 do
        v112 = v113[key_25] == true
        v107 = v112 and table.find(v114, key_25) ~= nil
        local Viewport = val_18.Viewport
        Viewport.ImageColor3 = v112 and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
        Viewport.Ambient = v112 and color_6 or Color3.new(0, 0, 0)
        Viewport.LightColor = v112 and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
        val_18.Icon.ImageColor3 = v112 and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
        val_18.TypeName.Text = v112 and key_25 or "???"
        val_18.TypeName.TextColor3 = v107 and color_2 or color_3
        val_18.AutoButtonColor = false
        val_18.Active = v112
        val_18:FindFirstChild("Selected").Visible = v107
        val_18.BackgroundColor3 = v107 and color_1 or color_4
    end

    return true
end

function v2() --[[ refreshPanel ]] -- line: 806
    -- upvalues:
    --  [1] Panel (copy)
    --  [2] v66 (ref)
    --  [3] refreshPicker (copy)
    --  [4] Home (copy)
    --  [5] Info (copy)
    --  [6] Picker (copy)
    --  [7] BackArrow (copy)
    --  [8] Header (copy)
    --  [9] t_14 (copy)
    --  [10] t_15 (copy)
    --  [11] v67 (ref)
    --  [12] refreshHome (copy)

    if not Panel.Visible then
        return
    end

    if v66 and not refreshPicker(v66) then
        v66 = nil
    end

    local v118 = v66 ~= nil
    Home.Visible = not v118
    Info.Visible = not v118
    Picker.Visible = v118

    if BackArrow then
        BackArrow.Visible = v118
    end

    local v119 = Header
    v119.Text = v118 and t_14[v66.Kind].Title or "Tracker"

    if not v118 then
        for _, val_19 in t_15 do
            val_19:Destroy()
        end

        table.clear(t_15)
        v67 = nil
        refreshHome()
    end
end

local v121 = false

function v9() --[[ queuePanelRefresh ]] -- line: 831
    -- upvalues:
    --  [1] v121 (ref)
    --  [2] v2 (ref)

    if v121 then
        return
    end

    v121 = true
    task.delay(0.5, function() -- line: 836
        -- upvalues:
        --  [1] v121 (ref)
        --  [2] v2 (ref)

        v121 = false
        v2()
    end)
end

local _ = function(arg46) --[[ setPanelOpen ]] -- line: 842
    -- upvalues:
    --  [1] Panel (copy)
    --  [2] v66 (ref)
    --  [3] t_15 (copy)
    --  [4] v67 (ref)
    --  [5] v2 (ref)

    Panel.Visible = arg46
    v66 = nil

    for _, val_20 in t_15 do
        val_20:Destroy()
    end

    table.clear(t_15)
    v67 = nil
    v2()
end

v65.Event:Connect(function(arguments) -- line: 849
    -- upvalues:
    --  [1] Panel (copy)
    --  [2] v66 (ref)
    --  [3] t_15 (copy)
    --  [4] v67 (ref)
    --  [5] v2 (ref)

    if arguments == nil then
        arguments = not Panel.Visible
    end

    Panel.Visible = arguments == true
    v66 = nil

    for _, val_21 in t_15 do
        val_21:Destroy()
    end

    table.clear(t_15)
    v67 = nil
    v2()
end)

for _, val_22 in t_1 do
    v65 = Home[val_22.Section]
    v65.MouseEnter:Connect(function() -- line: 859
        -- upvalues:
        --  [1] v65 (copy)
        --  [2] color_8 (copy)

        local Outline_1 = v65.Outline
        Outline_1.ImageColor3 = v65:GetAttribute("HoverColor") or color_8
    end)
    v65.MouseLeave:Connect(function() -- line: 862
        -- upvalues:
        --  [1] v65 (copy)
        --  [2] color_7 (copy)

        local Outline_2 = v65.Outline
        Outline_2.ImageColor3 = v65:GetAttribute("OutlineColor") or color_7
    end)
    Home[val_22.Section].Activated:Connect(function() -- line: 866
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] val_22 (copy)
        --  [3] Professions (ref)
        --  [4] Professions_m (copy)
        --  [5] LocalPlayer (copy)
        --  [6] v66 (ref)
        --  [7] Grid (copy)
        --  [8] v2 (ref)

        local v125 = val_22
        local v126 = Professions
        local v127 = t_3

        if v126 then
            v126 = Professions:FindFirstChild(v125.Profession)
        end

        if v127[if not v126 then 0 else math.clamp(
            math.floor(
                tonumber(Professions_m:GetPlayerBenefits(LocalPlayer, v125.Profession).tracker) or 0
            ),
            0,
            #t_3
        )] then
            v66 = val_22
            Grid.CanvasPosition = Vector2.zero
            v2()
        end
    end)
end

if BackArrow then
    BackArrow.Activated:Connect(function() -- line: 876
        -- upvalues:
        --  [1] v66 (ref)
        --  [2] v2 (ref)

        v66 = nil
        v2()
    end)
end

Close.Activated:Connect(function() -- line: 882
    -- upvalues:
    --  [1] Panel (copy)
    --  [2] v66 (ref)
    --  [3] t_15 (copy)
    --  [4] v67 (ref)
    --  [5] v2 (ref)

    Panel.Visible = false
    v66 = nil

    for _, val_23 in t_15 do
        val_23:Destroy()
    end

    table.clear(t_15)
    v67 = nil
    v2()
end)
task.spawn(function() -- line: 887
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] Discovered (ref)
    --  [3] v2 (ref)

    Discovered = LocalPlayer:WaitForChild("Professions"):WaitForChild("Discovered")
    Discovered:GetPropertyChangedSignal("Value"):Connect(v2)
    v2()
end)
task.spawn(function() -- line: 895
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] t_15 (copy)
    --  [3] v67 (ref)
    --  [4] v2 (ref)

    ReplicatedStorage:WaitForChild("Tools")

    for _, val_24 in t_15 do
        val_24:Destroy()
    end

    table.clear(t_15)
    v67 = nil
    v2()
end)

local _ = function() --[[ getRootPosition ]] -- line: 904
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local Character = LocalPlayer.Character
    local v130 = Character

    if v130 then
        v130 = Character:FindFirstChild("HumanoidRootPart")
    end

    return v130 and v130.Position
end

local function byDistance(arg48, arg49) -- line: 910
    return arg48.Distance < arg49.Distance
end

local _ = function(arg50) --[[ sortedRecords ]] -- line: 915
    -- upvalues:
    --  [1] byDistance (copy)

    table.sort(arg50, byDistance)
    local t_20 = table.create(#arg50)

    for key_32, val_25 in arg50 do
        t_20[key_32] = val_25.Record
    end

    return t_20
end

local function search(arg51, arg52, arg53) -- line: 924
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t_5 (copy)
    --  [3] syncHighlights (copy)
    --  [4] byDistance (copy)
    --  [5] syncTimers (copy)
    --  [6] syncMarkers (copy)

    local v133 = t_3[arg51.Tier]
    local v134 = t_5[arg51.Kind]
    local v135 = nil
    local v136 = math.huge
    local v137 = 0
    local t_21 = {}
    local t_22 = {}
    local t_23 = {}

    for _, val_26 in arg51.Names do
        local v138 = v134[val_26]

        if v138 then
            for _, val_27 in v138 do
                local Position_2 = val_27:GetAttribute("Position")

                if typeof(Position_2) == "Vector3" then
                    local Magnitude = (Position_2 - arg52).Magnitude

                    if not (Magnitude > v133.Range) then
                        local v139 = if val_27:GetAttribute("Available") == false then false else true

                        if v139 then
                            v137 += 1
                            table.insert(t_21, { Record = val_27, Distance = Magnitude })

                            if v136 > Magnitude then
                                v135 = Position_2
                                v136 = Magnitude
                            end
                        else
                            table.insert(t_22, { Record = val_27, Distance = Magnitude })
                        end

                        if v133.MapMarkers then
                            t_23[val_27] = v139
                        end
                    end
                end
            end
        end
    end

    arg51.Target = v135
    local Arrow = arg51.Arrow
    Arrow.Visible = v135 ~= nil
    local Idle = arg51.Widget.Dial.Idle
    Idle.Visible = v135 == nil

    if v135 then
        local v141 = math.floor(v136 + 0.5)
        v134 = `<b>{v141}</b>m`

        if v133.Count then
            v134 ..= `  <font color="#AFAFAF">\194\183  {v137} in range</font>`
        end

        if arg51.StatusText ~= v134 then
            arg51.StatusText = v134
            arg51.Widget.Status.Text = v134
        end
    elseif arg51.StatusText ~= "<font color=\"#AFAFAF\">None in range</font>" then
        arg51.StatusText = "<font color=\"#AFAFAF\">None in range</font>"
        arg51.Widget.Status.Text = "<font color=\"#AFAFAF\">None in range</font>"
    end

    local v142 = syncHighlights
    local t_26

    if v133.Outline then
        table.sort(t_21, byDistance)
        t_26 = table.create(#t_21)

        for key_35, val_28 in t_21 do
            t_26[key_35] = val_28.Record
        end
    else
        t_26 = {}
    end

    v142(arg51, t_26)
    local v145 = syncTimers

    if v133.Timers then
        table.sort(t_22, byDistance)
        t_26 = table.create(#t_22)

        for key_36, val_29 in t_22 do
            t_26[key_36] = val_29.Record
        end
    else
        t_26 = {}
    end

    v145(arg51, t_26, arg53)
    syncMarkers(arg51, t_23)
end

RunService.Heartbeat:Connect(function(deltaTime) -- line: 986
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] LocalPlayer (copy)
    --  [3] Workspace (copy)
    --  [4] t_1 (copy)
    --  [5] search (copy)

    v1 += deltaTime

    if v1 < 0.2 then
        return
    end

    v1 = 0
    local Character_1 = LocalPlayer.Character
    local v147 = Character_1

    if v147 then
        v147 = Character_1:FindFirstChild("HumanoidRootPart")
    end

    local v148 = v147

    if v148 then
        v148 = v147.Position
    end

    if not v148 then
        return
    end

    local v149 = Workspace:GetServerTimeNow()

    for _, val_30 in t_1 do
        if val_30.Active then
            search(val_30, v148, v149)
        end
    end
end)
RunService.RenderStepped:Connect(function(deltaTime_1) -- line: 1009
    -- upvalues:
    --  [1] Workspace (copy)
    --  [2] LocalPlayer (copy)
    --  [3] t_1 (copy)

    local v150 = Workspace.CurrentCamera
    local Character_2 = LocalPlayer.Character
    local v151 = Character_2

    if v151 then
        v151 = Character_2:FindFirstChild("HumanoidRootPart")
    end

    local v152 = v151 and v151.Position

    if not v150 or not v152 then
        return
    end

    local v153 = v150.CFrame
    v150 = v153.LookVector * Vector3.new(1, 0, 1)
    v150 = if not (v150.Magnitude < 0.001) then v150 else v153.UpVector * Vector3.new(1, 0, 1)

    if v150.Magnitude < 0.001 then
        return
    end

    v150 = v150.Unit
    local vec3 = Vector3.new(-v150.Z, 0, v150.X)
    local v154 = 1 - math.exp(-14 * deltaTime_1)

    for _, val_31 in t_1 do
        local v155 = val_31.Active

        if v155 then
            v155 = val_31.Target
        end

        if v155 then
            local v156 = (v155 - v152) * Vector3.new(1, 0, 1)

            if not (v156.Magnitude < 0.5) then
                local v157 = v156:Dot(vec3)
                val_31.Angle = (val_31.Angle + ((math.deg((math.atan2(v157, (v156:Dot(v150))))) - val_31.Angle + 180) % 360 - 180) * v154) % 360
                val_31.Arrow.Rotation = val_31.Angle
            end
        end
    end
end)

for _, val_32 in t_1 do
    LocalPlayer:GetAttributeChangedSignal(val_32.Attribute):Connect(function() -- line: 1052
        -- upvalues:
        --  [1] refreshConfig (copy)
        --  [2] val_32 (copy)

        refreshConfig(val_32)
    end)
end

task.spawn(function() -- line: 1058
    -- upvalues:
    --  [1] Professions (ref)
    --  [2] LocalPlayer (copy)
    --  [3] refreshAll (copy)
    --  [4] t_1 (copy)
    --  [5] refreshConfig (copy)

    Professions = LocalPlayer:WaitForChild("Professions")

    local _ = function(arg56) --[[ watchLevel ]] -- line: 1061
        -- upvalues:
        --  [1] refreshAll (ref)

        if arg56:IsA("ValueBase") then
            arg56.Changed:Connect(refreshAll)
        end
    end

    for _, child_5 in Professions:GetChildren() do
        if child_5:IsA("ValueBase") then
            child_5.Changed:Connect(refreshAll)
        end
    end

    Professions.ChildAdded:Connect(function(child_6) -- line: 1070
        -- upvalues:
        --  [1] refreshAll (ref)
        --  [2] t_1 (ref)
        --  [3] refreshConfig (ref)

        if child_6:IsA("ValueBase") then
            child_6.Changed:Connect(refreshAll)
        end

        for _, val_33 in t_1 do
            refreshConfig(val_33)
        end
    end)

    for _, val_34 in t_1 do
        refreshConfig(val_34)
    end
end)
LocalPlayer.CharacterAdded:Connect(function() -- line: 1079
    -- upvalues:
    --  [1] v1 (ref)

    v1 = 0.2
end)

for _, val_35 in t_1 do
    refreshConfig(val_35)
end
