-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MapService
-- Class: ModuleScript
-- bytes: 116807

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local Quests = ReplicatedStorage.Modules.ClientNPCS.Quests
local Slider_m = require(Modules.Slider)
local ObjectTracker_m = require(Modules.ObjectTracker)
local QuestProgress_m = require(Modules.QuestProgress)
local RegionDefinitions_m = require(script.RegionDefinitions)
local LocalPlayer = Players.LocalPlayer
local Locations = ReplicatedStorage:WaitForChild("_Locations")
local DiscoverMap = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DiscoverMap")
local Client = DiscoverMap:WaitForChild("Client")
local PlayerMarker = script:FindFirstChild("PlayerMarker")
local QuestMarker = script:FindFirstChild("QuestMarker")
local LocationMarker = script:FindFirstChild("LocationMarker")
local ObjectiveMarker = script:FindFirstChild("ObjectiveMarker")
local WaypointMarker = script:FindFirstChild("WaypointMarker")
local WaypointDisplay = script:FindFirstChild("WaypointDisplay")
local DeathMarker = script:FindFirstChild("DeathMarker")
local DeathDisplay = script:FindFirstChild("DeathDisplay")
local PortalMarker = script:FindFirstChild("PortalMarker")
local PointMarker = script:FindFirstChild("PointMarker")
local InfoHover = script:FindFirstChild("InfoHover")
local MapPoints_m = require(script.MapPoints)
local t = { Base = 6, Min = 2.5, Max = 8, Step = 0.15 }
local t_1 = { Deadzone = 0.15, PanSpeed = 1.2, ZoomRate = 1.5 }
local t_2 = { Steps = 1000, Axis = "X" }
local t_3 = {
    Discovered = Color3.fromRGB(255, 255, 255),
    Undiscovered = Color3.fromRGB(9, 9, 9),
    DiscoveryDisabled = Color3.fromRGB(255, 255, 255),
    FadeInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
}
local t_4 = {
    Enabled = true,
    Image = "rbxassetid://91871766277469",
    Color = Color3.fromRGB(0, 0, 0),
    Transparency = 0,
    MinSize = 1500,
    MaxSize = 2600,
    FadeInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
}
local t_5 = {
    ZIndex = 2,
    LabelName = "Label",
    WatchedAttributes = { MapLocation = true, DisplayName = true }
}
local t_6 = {
    Tags = { "QuestNPC", "QuestObject" },
    GiverZIndex = 3,
    ObjectiveZIndex = 11,
    IconName = "Icon",
    Colors = {
        OneTime = Color3.fromRGB(255, 255, 0),
        Repeatable = Color3.fromRGB(11, 210, 255),
        InProgress = Color3.fromRGB(118, 118, 118),
        Objective = Color3.fromRGB(255, 179, 71),
        Return = Color3.fromRGB(155, 255, 140)
    }
}
local t_8 = {
    FolderName = "ActiveRaids",
    Color = Color3.fromRGB(255, 75, 75),
    Text = "An active raid is taking place here.",
    FallbackRadius = 400
}
local t_9 = {
    ZIndex = 4,
    Category = "Points",
    UnknownColor = Color3.fromRGB(150, 150, 150),
    RetryDelay = 5
}
local _ = { Offset = Vector2.new(16, 16), Margin = 8, TitleColor = Color3.fromRGB(225, 225, 225) }
local t_11 = {
    Default = {
        Points = true,
        Locations = true,
        QuestGivers = true,
        Objectives = true,
        DeathMarker = true,
        GuildMembers = true
    },
    EnabledAttribute = "FilterEnabled",
    IndicatorName = "Check",
    DisabledTransparency = 0.6
}
local t_12 = {
    ZIndex = 12,
    Color = Color3.fromRGB(255, 80, 80),
    ClickThreshold = 6,
    RemoveRadius = 18,
    ArriveRadius = 25,
    DistanceLabelName = "dist"
}
local t_13 = {
    RemoteName = "GuildMapPositions",
    Category = "GuildMembers",
    Color = Color3.fromRGB(90, 220, 120),
    Size = 9,
    ZIndex = 10,
    AlwaysVisible = true
}
local _ = {
    AttributePrefix = "DeathBag_",
    Category = "DeathMarker",
    ZIndex = 12,
    DistanceLabelName = "dist"
}
local t_15 = {
    onRegionDiscovered = nil,
    onLocationDiscovered = nil,
    onFilterChanged = nil,
    onWaypointChanged = nil
}
local v2 = nil
local t_16 = {}
local t_17 = {}
local t_18 = {}

local _ = function(vec1: Vector3, vec2: Vector3) --[[ getBounds ]] -- line: 271
    return Vector2.new(math.min(vec1.X, vec2.X), (math.min(vec1.Z, vec2.Z))), (Vector2.new(
        math.max(vec1.X, vec2.X),
        (math.max(vec1.Z, vec2.Z))
    ))
end

for _, val in RegionDefinitions_m.Regions do
    local Corner1 = val.Corner1
    local Corner2 = val.Corner2
    local _ = { Retries = 3, RetryDelay = 2 }
    local vec2_10 = Vector2.new(math.min(Corner1.X, Corner2.X), (math.min(Corner1.Z, Corner2.Z)))
    local vec2_11 = Vector2.new(math.max(Corner1.X, Corner2.X), (math.max(Corner1.Z, Corner2.Z)))
    local t_20 = {
        Name = val.Name,
        Index = val.Index,
        Image = val.Image,
        ImageRectOffset = val.ImageRectOffset,
        ImageRectSize = val.ImageRectSize,
        ImageMin = val.ImageMin,
        ImageMax = val.ImageMax,
        DisplayName = val.DisplayName,
        Description = val.Description,
        DiscoveryDisabled = nil,
        Min = nil,
        Max = nil,
        Size = nil,
        Height = nil,
        Top = nil,
        Bottom = nil
    }
    local DiscoveryDisabled = val.DiscoveryDisabled
    t_20.DiscoveryDisabled = if DiscoveryDisabled ~= true then false else true
    t_20.Min = vec2_10
    t_20.Max = vec2_11
    t_20.Size = vec2_11 - vec2_10
    t_20.Height = (Corner1.Y + Corner2.Y) / 2
    t_20.Top = math.max(Corner1.Y, Corner2.Y)
    t_20.Bottom = math.min(Corner1.Y, Corner2.Y)
    table.insert(t_16, t_20)
    t_17[t_20.Name] = t_20
end

local v15 = RegionDefinitions_m.Areas or {}

for _, val_1 in v15 do
    local Corner1_1 = val_1.Corner1
    local Corner2_1 = val_1.Corner2
    local New_4 = Vector2.new(
        math.min(Corner1_1.X, Corner2_1.X),
        (math.min(Corner1_1.Z, Corner2_1.Z))
    )
    local New_5 = Vector2.new(
        math.max(Corner1_1.X, Corner2_1.X),
        (math.max(Corner1_1.Z, Corner2_1.Z))
    )
    local t_21 = {
        Name = val_1.Name,
        Description = val_1.Description or "",
        Min = New_4,
        Max = New_5
    }
    table.insert(t_18, t_21)
end

local v18 = RegionDefinitions_m.World
local v19, v20, v22, v23, v26

if v18 then
    v19 = v18.Corner1
    v20 = v18.Corner2
    local vec2_12 = Vector2.new(math.min(v19.X, v20.X), (math.min(v19.Z, v20.Z)))
    local New_7 = Vector2.new(math.max(v19.X, v20.X), (math.max(v19.Z, v20.Z)))
    v22 = vec2_12
    v23 = New_7
    v15 = {
        Min = v22,
        Max = v23,
        Size = v23 - v22,
        Height = (v19.Y + v20.Y) / 2,
        Top = math.max(v19.Y, v20.Y),
        Bottom = math.min(v19.Y, v20.Y)
    }
else
    v19 = math.huge
    v20 = math.huge
    v22 = -math.huge
    v23 = -math.huge
    v26 = -math.huge
    local v25 = math.huge
    v18 = 0

    for _, val_2 in t_16, nil, nil do
        v19 = math.min(v19, val_2.Min.X)
        v20 = math.min(v20, val_2.Min.Y)
        v22 = math.max(v22, val_2.Max.X)
        v23 = math.max(v23, val_2.Max.Y)
        v26 = math.max(v26, val_2.Top)
        v25 = math.min(v25, val_2.Bottom)
        v18 += val_2.Height
    end

    local vec2_1 = Vector2.new(v19, v20)
    v20 = Vector2.new(v22, v23)
    v15 = {
        Min = vec2_1,
        Max = v20,
        Size = v20 - vec2_1,
        Height = v18 / #t_16,
        Top = v26,
        Bottom = v25
    }
end

v18 = {}
v19 = {}
local t_22 = {}
v22 = {}
v23 = {}
v26 = table.clone(t_11.Default)
local v30 = false
local v31 = nil
local v32 = false
local v33 = nil
local v34 = nil
local t_23 = {}
local v35 = nil
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.RespectCanCollide = true
raycastParams.IgnoreWater = false
raycastParams.FilterDescendantsInstances = { workspace.Map }
local v36 = nil
local v37 = nil
local v38 = nil
local t_24 = {}
local t_25 = {}
local t_26 = {}

local _ = function(t1: table, vec3: Vector3) --[[ isInRegion ]] -- line: 407
    return vec3.X >= t1.Min.X and (vec3.X <= t1.Max.X and (vec3.Z >= t1.Min.Y and vec3.Z <= t1.Max.Y))
end

local _ = function(t2: table) --[[ isRegionRevealed ]] -- line: 413
    -- upvalues:
    --  [1] v18 (copy)

    return if not t2.DiscoveryDisabled then v18[t2.Name] == true else true
end

local function getAreaAt(vec4: Vector3, t3: table?) -- line: 420
    -- upvalues:
    --  [1] t_18 (copy)

    if t3 then
        if vec4.X >= t3.Min.X and (vec4.X <= t3.Max.X and (vec4.Z >= t3.Min.Y and vec4.Z <= t3.Max.Y)) then
            return t3
        end
    end

    for _, val_3 in t_18 do
        if vec4.X >= val_3.Min.X and (vec4.X <= val_3.Max.X and (vec4.Z >= val_3.Min.Y and vec4.Z <= val_3.Max.Y)) then
            return val_3
        end
    end

    return nil
end

local _ = function(vec5: Vector3, _: table?) --[[ getRegionAt ]] -- line: 434
    -- upvalues:
    --  [1] RegionDefinitions_m (copy)
    --  [2] t_16 (copy)

    local v42 = RegionDefinitions_m.PieceIndexAt(vec5.X, vec5.Z)

    if v42 then
        return t_16[v42]
    end

    return nil
end

local _ = function(vec6: Vector3) --[[ isDiscoveredAt ]] -- line: 441
    -- upvalues:
    --  [1] RegionDefinitions_m (copy)
    --  [2] t_16 (copy)
    --  [3] v18 (copy)

    local v43 = RegionDefinitions_m.PieceIndexAt(vec6.X, vec6.Z)
    local v44 = if v43 then t_16[v43] else nil
    v43 = if v44 == nil then false else not v44.DiscoveryDisabled and v18[v44.Name] == true

    return v43
end

local _ = function(vec7: Vector3) --[[ worldToUV ]] -- line: 446
    -- upvalues:
    --  [1] v15 (copy)

    return Vector2.new((vec7.X - v15.Min.X) / v15.Size.X, (vec7.Z - v15.Min.Y) / v15.Size.Y)
end

local function uvToWorld(u1: Vector2) -- line: 453
    -- upvalues:
    --  [1] v15 (copy)
    --  [2] RegionDefinitions_m (copy)
    --  [3] t_16 (copy)

    local vec3_1 = Vector3.new(
        v15.Min.X + u1.X * v15.Size.X,
        v15.Height,
        v15.Min.Y + u1.Y * v15.Size.Y
    )
    local v45 = RegionDefinitions_m.PieceIndexAt(vec3_1.X, vec3_1.Z)
    local v46 = if v45 then t_16[v45] else nil

    if v46 then
        return (Vector3.new(vec3_1.X, v46.Height, vec3_1.Z))
    end

    return vec3_1
end

local _ = function(u2: Vector2) --[[ isUVOnMap ]] -- line: 466
    return u2.X >= 0 and (u2.X <= 1 and (u2.Y >= 0 and u2.Y <= 1))
end

local _ = function(u3: CFrame) --[[ mapRotation ]] -- line: 470
    local LookVector = u3.LookVector
    local v48 = math.atan2(LookVector.X, -LookVector.Z)

    return (math.deg(v48))
end

local function resolveTarget(arg1) -- line: 475
    if typeof(arg1) == "function" then
        arg1 = arg1()
    end

    local v49 = typeof(arg1)

    if v49 == "CFrame" then
        return arg1
    end

    if v49 == "Vector3" then
        return CFrame.new(arg1)
    end

    if v49 == "Instance" then
        if not arg1.Parent then
            return nil
        end

        if arg1:IsA("BasePart") then
            return arg1.CFrame
        end

        if arg1:IsA("PVInstance") then
            return arg1:GetPivot()
        end

        if arg1:IsA("Attachment") then
            return arg1.WorldCFrame
        end

        local v50 = arg1:GetAttribute("Position") or arg1:GetAttribute("CFrame")

        if typeof(v50) == "CFrame" then
            return v50
        end

        if typeof(v50) == "Vector3" then
            return CFrame.new(v50)
        end
    end

    return nil
end

local function getRootCFrame() -- line: 507
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local Character = LocalPlayer.Character
    local v51 = Character

    if v51 then
        v51 = Character:FindFirstChild("HumanoidRootPart")
    end

    return v51 and v51.CFrame
end

local _ = function() --[[ getRootPosition ]] -- line: 513
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local v53 = LocalPlayer.Character
    local v54 = v53

    if v54 then
        v54 = v53:FindFirstChild("HumanoidRootPart")
    end

    local v55 = v54 and v54.CFrame
    v53 = v55 and v55.Position

    return v53
end

local _ = function(u4: Vector2) --[[ applyDeadzone ]] -- line: 518
    local Magnitude = u4.Magnitude

    if Magnitude < 0.15 then
        return Vector2.zero
    end

    return u4.Unit * math.min((Magnitude - 0.15) / 0.85, 1)
end

local _ = function(n1: number) --[[ zoomToAlpha ]] -- line: 527
    return math.log(n1 / 2.5) / 1.1631508098056809
end

local _ = function(n2: number) --[[ alphaToZoom ]] -- line: 531
    return 2.5 * 3.2 ^ math.clamp(n2, 0, 1)
end

local _ = function(_: string) --[[ obscure ]] -- line: 535
    return "???"
end

local function readLocation(u5: userdata) -- line: 539
    local t_27, _

    if u5:IsA("Folder") then
        if u5:GetAttribute("MapLocation") ~= true then
            return nil
        end

        t_27 = {
            Name = u5.Name,
            DisplayName = u5:GetAttribute("DisplayName") or u5.Name,
            Target = u5
        }

        return t_27
    else
        return nil
    end
end

local _ = function() --[[ notifyLocationsChanged ]] -- line: 550
    -- upvalues:
    --  [1] v38 (ref)

    if v38 then
        v38.locationsChanged()
    end
end

local _ = function(u6: userdata) --[[ refreshLocation ]] -- line: 556
    -- upvalues:
    --  [1] readLocation (copy)
    --  [2] t_22 (copy)
    --  [3] v38 (ref)

    local v58 = readLocation(u6)

    if v58 == nil and t_22[u6] == nil then
        return
    end

    t_22[u6] = v58

    if v38 then
        v38.locationsChanged()
    end
end

local function watchLocation(u7: userdata) -- line: 566
    -- upvalues:
    --  [1] v22 (copy)
    --  [2] t_5 (copy)
    --  [3] readLocation (copy)
    --  [4] t_22 (copy)
    --  [5] v38 (ref)

    if not u7:IsA("Folder") or v22[u7] then
        return
    end

    v22[u7] = u7.AttributeChanged:Connect(function(attribute) -- line: 571
        -- upvalues:
        --  [1] t_5 (ref)
        --  [2] u7 (copy)
        --  [3] readLocation (ref)
        --  [4] t_22 (ref)
        --  [5] v38 (ref)

        if t_5.WatchedAttributes[attribute] then
            local v59 = u7
            local v60 = readLocation(v59)

            if v60 == nil and t_22[v59] == nil then
                return
            end

            t_22[v59] = v60

            if v38 then
                v38.locationsChanged()
            end
        end
    end)
    local v62 = readLocation(u7)

    if v62 == nil and t_22[u7] == nil then
        return
    end

    t_22[u7] = v62

    if v38 then
        v38.locationsChanged()
    end
end

local function unwatchLocation(u8: userdata) -- line: 580
    -- upvalues:
    --  [1] v22 (copy)
    --  [2] t_22 (copy)
    --  [3] v38 (ref)

    local v63 = v22[u8]

    if v63 then
        v63:Disconnect()
        v22[u8] = nil
    end

    if t_22[u8] then
        t_22[u8] = nil

        if v38 then
            v38.locationsChanged()
        end
    end
end

for _, descendant in Locations:GetDescendants() do
    watchLocation(descendant)
end

Locations.DescendantAdded:Connect(watchLocation)
Locations.DescendantRemoving:Connect(unwatchLocation)

local _ = function(s2: string) --[[ findMapLocation ]] -- line: 600
    -- upvalues:
    --  [1] t_22 (copy)

    for _, val_4 in t_22 do
        if val_4.Name == s2 then
            return val_4
        end
    end

    return nil
end

local _ = function() --[[ notifyQuestGiversChanged ]] -- line: 609
    -- upvalues:
    --  [1] v38 (ref)

    if v38 then
        v38.questGiversChanged()
    end
end

local _ = function(t5: table) --[[ resolveGiver ]] -- line: 617
    local v64 = t5.Instance or t5.LastInstance

    if v64 and v64:GetAttribute("MapHidden") then
        return nil
    end

    v64 = t5.Instance

    if v64 and v64.Parent then
        t5.CFrame = v64:GetPivot()
    end

    return t5.CFrame
end

local function onGiverTagged(u9: userdata) -- line: 629
    -- upvalues:
    --  [1] Quests (copy)
    --  [2] v23 (copy)
    --  [3] v38 (ref)

    if not u9:IsA("PVInstance") then
        return
    end

    local Name_3 = u9.Name
    local v65 = Quests:FindFirstChild(Name_3, true)

    if not v65 then
        return
    end

    local v66 = v23[Name_3]
    local v67 = if v66 ~= nil then false else true

    if v67 then
        v66 = { Name = Name_3, DisplayName = Name_3, Quest = v65 }
        v23[Name_3] = v66
    end

    v66.Instance = u9
    v66.LastInstance = u9
    v66.DisplayName = u9:GetAttribute("DisplayName") or Name_3
    v66.CFrame = u9:GetPivot()

    if v67 and v38 then
        v38.questGiversChanged()
    end
end

local function onGiverUntagged(u10: userdata) -- line: 661
    -- upvalues:
    --  [1] v23 (copy)
    --  [2] t_6 (copy)

    local v68 = v23[u10.Name]

    if not v68 or v68.Instance ~= u10 then
        return
    end

    if u10:IsDescendantOf(game) then
        for _, val_5 in t_6.Tags do
            if u10:HasTag(val_5) then
                return
            end
        end
    end

    local Success, Result = pcall(u10.GetPivot, u10)

    if Success then
        v68.CFrame = Result
    end

    v68.Instance = nil
end

for _, val_6 in t_6.Tags do
    CollectionService:GetInstanceAddedSignal(val_6):Connect(onGiverTagged)
    CollectionService:GetInstanceRemovedSignal(val_6):Connect(onGiverUntagged)

    for _, val_7 in CollectionService:GetTagged(val_6) do
        onGiverTagged(val_7)
    end
end

local function findGround(vec8: Vector3) -- line: 690
    -- upvalues:
    --  [1] RegionDefinitions_m (copy)
    --  [2] t_16 (copy)
    --  [3] v15 (copy)
    --  [4] raycastParams (copy)

    local v69 = RegionDefinitions_m.PieceIndexAt(vec8.X, vec8.Z)
    local v70 = if v69 then t_16[v69] else nil
    v69 = if not v70 then v15.Top else v70.Top
    local v71 = if not v70 then v15.Bottom else v70.Bottom
    local v73 = workspace:Raycast(
        Vector3.new(vec8.X, v69, vec8.Z),
        Vector3.new(0, v71 - v69, 0),
        raycastParams
    )
    local v74 = v73

    if v74 then
        v74 = v73.Position
    end

    return v74
end

local function refreshWaypointDisplay() -- line: 700
    -- upvalues:
    --  [1] v31 (ref)
    --  [2] v33 (ref)
    --  [3] v34 (ref)
    --  [4] WaypointDisplay (copy)
    --  [5] t_12 (copy)

    if not v31 then
        if v33 then
            v33:Destroy()
            v33 = nil
            v34 = nil
        end

        return
    end

    if not v33 or not v33.Parent then
        local Waypoint_Part = Instance.new("Part")
        Waypoint_Part.Name = "Waypoint"
        Waypoint_Part.Size = Vector3.new(1, 1, 1)
        Waypoint_Part.Transparency = 1
        Waypoint_Part.Anchored = true
        Waypoint_Part.CanCollide = false
        Waypoint_Part.CanQuery = false
        Waypoint_Part.CanTouch = false
        local v75 = WaypointDisplay:Clone()
        v75.Adornee = Waypoint_Part
        v75.Parent = Waypoint_Part
        local v76 = v75:FindFirstChild(t_12.DistanceLabelName, true)
        v34 = if v76 then if v76:IsA("TextLabel") then v76 else nil else nil
        Waypoint_Part.Parent = workspace
        v33 = Waypoint_Part
    end

    v33.Position = v31
end

local _ = function(vec9: Vector3) --[[ updateWaypointDistance ]] -- line: 734
    -- upvalues:
    --  [1] v31 (ref)
    --  [2] v34 (ref)

    if v31 and v34 then
        local v78 = v34
        local v79 = math.floor((v31 - vec9).Magnitude)
        v78.Text = `{v79}m`
    end
end

local function setWaypoint(vec10: Vector3?, b1: boolean?) -- line: 740
    -- upvalues:
    --  [1] findGround (copy)
    --  [2] v32 (ref)
    --  [3] LocalPlayer (copy)
    --  [4] v31 (ref)
    --  [5] refreshWaypointDisplay (copy)
    --  [6] v34 (ref)
    --  [7] t_15 (copy)

    local v81

    if vec10 and b1 ~= false then
        local v80 = findGround(vec10)
        v81 = if v80 == nil then false else true
        v32 = v81

        if v80 then
            vec10 = v80
        else
            local Character_1 = LocalPlayer.Character
            local v82 = Character_1

            if v82 then
                v82 = Character_1:FindFirstChild("HumanoidRootPart")
            end

            local v83 = v82 and v82.CFrame
            v81 = v83

            if v81 then
                v81 = v83.Position
            end

            v82 = if not v81 then vec10.Y else v81.Y
            vec10 = Vector3.new(vec10.X, v82, vec10.Z)
        end
    else
        v32 = vec10 ~= nil
    end

    if v31 == vec10 then
        return
    end

    v31 = vec10
    refreshWaypointDisplay()
    local Character_2 = LocalPlayer.Character
    local v84 = Character_2

    if v84 then
        v84 = Character_2:FindFirstChild("HumanoidRootPart")
    end

    v81 = v84 and v84.CFrame
    local v85 = v81

    if v85 then
        v85 = v81.Position
    end

    if v85 and v31 and v34 then
        local v86 = v34
        local v87 = math.floor((v31 - v85).Magnitude)
        v86.Text = `{v87}m`
    end

    if t_15.onWaypointChanged then
        task.spawn(t_15.onWaypointChanged, vec10)
    end
end

local function updateWaypoint(vec11: Vector3) -- line: 770
    -- upvalues:
    --  [1] v31 (ref)
    --  [2] v32 (ref)
    --  [3] findGround (copy)
    --  [4] refreshWaypointDisplay (copy)
    --  [5] t_12 (copy)
    --  [6] setWaypoint (copy)
    --  [7] v34 (ref)

    if not v31 then
        return
    end

    if not v32 then
        local v88 = findGround(v31)

        if v88 then
            v32 = true
            v31 = v88
            refreshWaypointDisplay()
        end
    end

    if t_12.ArriveRadius > 0 and Vector2.new(v31.X - vec11.X, v31.Z - vec11.Z).Magnitude <= t_12.ArriveRadius then
        setWaypoint(nil)

        return
    end

    if v31 and v34 then
        local v89 = v34
        local v90 = math.floor((v31 - vec11).Magnitude)
        v89.Text = `{v90}m`
    end
end

local function updateDeathDisplays(vec12: Vector3?) -- line: 796
    -- upvalues:
    --  [1] v26 (copy)
    --  [2] t_23 (copy)

    local v91 = v26.DeathMarker ~= false

    for _, val_8 in t_23 do
        if val_8.gui then
            val_8.gui.Enabled = v91
        end

        if vec12 and val_8.label then
            local Label = val_8.label
            local v92 = math.floor((val_8.position - vec12).Magnitude)
            Label.Text = `{v92}m`
        end
    end
end

local function syncDeathBag(s3: string) -- line: 811
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] t_23 (copy)
    --  [3] DeathDisplay (copy)
    --  [4] updateDeathDisplays (copy)
    --  [5] v35 (ref)

    if string.sub(s3, 1, 9) ~= "DeathBag_" then
        return
    end

    local attribute_1 = LocalPlayer:GetAttribute(s3)
    local v93 = t_23[s3]
    local v94, v95

    if typeof(attribute_1) ~= "Vector3" then
        if v93 then
            t_23[s3] = nil

            if v93.part then
                v93.part:Destroy()
            end
        end
    else
        if not v93 then
            v93 = { position = attribute_1 }
            t_23[s3] = v93
        end

        v93.position = attribute_1

        if DeathDisplay and (not v93.part or not v93.part.Parent) then
            local Part_1 = Instance.new("Part")
            Part_1.Name = "DeathMarker"
            Part_1.Size = Vector3.new(1, 1, 1)
            Part_1.Transparency = 1
            Part_1.Anchored = true
            Part_1.CanCollide = false
            Part_1.CanQuery = false
            Part_1.CanTouch = false
            v94 = DeathDisplay:Clone()
            v94.Adornee = Part_1
            v94.Parent = Part_1
            v95 = v94:FindFirstChild("dist", true)
            v93.part = Part_1
            v93.gui = v94
            v93.label = if v95 then if v95:IsA("TextLabel") then v95 else nil else nil
            Part_1.Parent = workspace
        end

        if v93.part then
            v93.part.Position = attribute_1
        end
    end

    local Character_3 = LocalPlayer.Character
    v95 = Character_3
    local v97 = updateDeathDisplays

    if v95 then
        v95 = Character_3:FindFirstChild("HumanoidRootPart")
    end

    v93 = v95 and v95.CFrame
    v94 = v93 and v93.Position
    v97(v94)

    if v35 then
        v35()
    end
end

LocalPlayer.AttributeChanged:Connect(syncDeathBag)

for key_10 in LocalPlayer:GetAttributes() do
    syncDeathBag(key_10)
end

local _ = function() --[[ notifyDiscoveryChanged ]] -- line: 873
    -- upvalues:
    --  [1] v38 (ref)

    if v38 then
        v38.discoveryChanged()
    end
end

local function readDiscoveryProfile(arg3) -- line: 880
    local t_30 = {}

    if typeof(arg3) ~= "table" then
        return t_30
    end

    for key_11, val_9 in arg3 do
        if typeof(key_11) == "string" and val_9 then
            table.insert(t_30, key_11)
        elseif typeof(val_9) == "string" then
            table.insert(t_30, val_9)
        end
    end

    return t_30
end

local _ = function(t6: table, arg4: any) --[[ mergeDiscovered ]] -- line: 898
    -- upvalues:
    --  [1] readDiscoveryProfile (copy)
    --  [2] v38 (ref)

    local v98 = false

    for _, val_10 in readDiscoveryProfile(arg4) do
        if not t6[val_10] then
            t6[val_10] = true
            v98 = true
        end
    end

    if v98 and v38 then
        v38.discoveryChanged()
    end
end

local function loadDiscovered(s4: string, t7: table) -- line: 913
    -- upvalues:
    --  [1] DiscoverMap (copy)
    --  [2] readDiscoveryProfile (copy)
    --  [3] v38 (ref)

    for index = 1, 3 do
        local Success_1, Result_1 = pcall(DiscoverMap.InvokeServer, DiscoverMap, s4)

        if Success_1 then
            local v99 = false

            for _, val_11 in readDiscoveryProfile(Result_1) do
                if not t7[val_11] then
                    t7[val_11] = true
                    v99 = true
                end
            end

            if v99 and v38 then
                v38.discoveryChanged()
            end

            return
        end

        warn(`Map: DiscoverMap("{s4}") failed:`, Result_1)

        if index < 3 then
            task.wait(2)
        end
    end
end

local function discoverRegion(t8: table) -- line: 929
    -- upvalues:
    --  [1] v18 (copy)
    --  [2] t_15 (copy)
    --  [3] v38 (ref)
    --  [4] DiscoverMap (copy)

    if t8.DiscoveryDisabled or v18[t8.Name] then
        return
    end

    v18[t8.Name] = true

    if t_15.onRegionDiscovered then
        task.spawn(t_15.onRegionDiscovered, t8)
    end

    if v38 then
        v38.discoveryChanged()
    end

    task.spawn(function() -- line: 941
        -- upvalues:
        --  [1] DiscoverMap (ref)
        --  [2] t8 (copy)

        local Success_2, Result_2 = pcall(
            DiscoverMap.InvokeServer,
            DiscoverMap,
            "AddRegion",
            t8.Name
        )

        if not Success_2 then
            warn(`Map: failed to save region "{t8.Name}":`, Result_2)
        end
    end)
end

local function onLocationConfirmed(s5: string, n3: number?) -- line: 950
    -- upvalues:
    --  [1] v19 (copy)
    --  [2] t_22 (copy)
    --  [3] t_15 (copy)
    --  [4] v38 (ref)

    if typeof(s5) ~= "string" or v19[s5] then
        return
    end

    v19[s5] = true
    local v100

    for _, val_12 in t_22 do
        if val_12.Name == s5 then
            v100 = val_12
        end
    end

    v100 = nil

    if v100 and t_15.onLocationDiscovered then
        task.spawn(t_15.onLocationDiscovered, v100, n3)
    end

    if v38 then
        v38.discoveryChanged()
    end
end

Client.OnClientEvent:Connect(onLocationConfirmed)
task.spawn(function() -- line: 966
    -- upvalues:
    --  [1] loadDiscovered (copy)
    --  [2] v18 (copy)
    --  [3] v30 (ref)
    --  [4] v36 (ref)
    --  [5] discoverRegion (copy)

    loadDiscovered("Region", v18)
    v30 = true

    if v36 then
        discoverRegion(v36)
    end
end)
task.spawn(loadDiscovered, "Locations", v19)

local _ = function(s6: string, arg5: any) --[[ setPointState ]] -- line: 977
    -- upvalues:
    --  [1] MapPoints_m (copy)
    --  [2] t_24 (copy)
    --  [3] v38 (ref)

    if typeof(arg5) ~= "number" or not MapPoints_m.Points[s6] or arg5 <= (t_24[s6] or 0) then
        return
    end

    t_24[s6] = arg5

    if v38 then
        v38.pointsChanged()
    end
end

local function loadPoints() -- line: 987
    -- upvalues:
    --  [1] DiscoverMap (copy)
    --  [2] MapPoints_m (copy)
    --  [3] t_24 (copy)
    --  [4] v38 (ref)

    local Success_3, Result_3 = pcall(DiscoverMap.InvokeServer, DiscoverMap, "Points")

    if Success_3 then
        if typeof(Result_3) ~= "table" then
            return
        end

        for key_15, val_13 in Result_3 do
            if typeof(key_15) == "string" and typeof(val_13) == "number" and MapPoints_m.Points[key_15] and not (val_13 <= (t_24[key_15] or 0)) then
                t_24[key_15] = val_13

                if v38 then
                    v38.pointsChanged()
                end
            end
        end

        return
    else
        return
    end
end

task.spawn(loadPoints)

local function updatePoints(vec13: Vector3) -- line: 1002
    -- upvalues:
    --  [1] MapPoints_m (copy)
    --  [2] t_24 (copy)
    --  [3] t_25 (copy)
    --  [4] DiscoverMap (copy)
    --  [5] v38 (ref)
    --  [6] t_9 (copy)

    for key_17, val_15 in MapPoints_m.Points do
        if not t_24[key_17] and not t_25[key_17] and not ((vec13 - val_15.Position).Magnitude > (val_15.Radius or 90)) then
            t_25[key_17] = true
            task.spawn(function() -- line: 1012
                -- upvalues:
                --  [1] DiscoverMap (ref)
                --  [2] key_17 (copy)
                --  [3] MapPoints_m (ref)
                --  [4] t_24 (ref)
                --  [5] v38 (ref)
                --  [6] t_9 (ref)
                --  [7] t_25 (ref)

                local Success_4, Result_4 = pcall(
                    DiscoverMap.InvokeServer,
                    DiscoverMap,
                    "AddPoint",
                    key_17
                )

                if Success_4 then
                    if typeof(Result_4) == "number" then
                        local v101 = key_17

                        if typeof(Result_4) == "number" and MapPoints_m.Points[v101] and not (Result_4 <= (t_24[v101] or 0)) then
                            t_24[v101] = Result_4

                            if v38 then
                                v38.pointsChanged()
                            end
                        end
                    else
                        task.wait(t_9.RetryDelay)
                    end
                else
                    task.wait(t_9.RetryDelay)
                end

                t_25[key_17] = nil
            end)
        end
    end
end

local _ = function() --[[ notifyRaidsChanged ]] -- line: 1024
    -- upvalues:
    --  [1] v38 (ref)

    if v38 then
        v38.raidsChanged()
    end
end

task.spawn(function() -- line: 1030
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] t_8 (copy)
    --  [3] t_26 (copy)
    --  [4] v38 (ref)

    local v102 = ReplicatedStorage:WaitForChild(t_8.FolderName, 60)

    if not v102 then
        return
    end

    v102.ChildAdded:Connect(function(child_1: userdata) --[[ onRaidAdded ]] -- line: 1036
        -- upvalues:
        --  [1] t_26 (ref)
        --  [2] v38 (ref)

        local Position = child_1:GetAttribute("Position")

        if typeof(Position) == "Vector3" then
            t_26[child_1] = Position

            if v38 then
                v38.raidsChanged()
            end
        end
    end)
    v102.ChildRemoved:Connect(function(child_2) -- line: 1045
        -- upvalues:
        --  [1] t_26 (ref)
        --  [2] v38 (ref)

        if t_26[child_2] then
            t_26[child_2] = nil

            if v38 then
                v38.raidsChanged()
            end
        end
    end)

    for _, child in v102:GetChildren() do
        local Position_1 = child:GetAttribute("Position")

        if typeof(Position_1) == "Vector3" then
            t_26[child] = Position_1

            if v38 then
                v38.raidsChanged()
            end
        end
    end
end)

local function locationContains(u12: userdata, vec14: Vector3) -- line: 1057
    local Position_2 = u12:GetAttribute("Position")
    local Size = u12:GetAttribute("Size")
    local Orientation

    if typeof(Position_2) == "Vector3" then
        if typeof(Size) ~= "Vector3" then
            return nil
        end

        Orientation = u12:GetAttribute("Orientation")
        local v104 = (CFrame.new(Position_2) * (if typeof(Orientation) == "CFrame" then Orientation.Rotation else CFrame.identity)):PointToObjectSpace(
            vec14
        )
        local v105 = Size / 2

        if math.abs(v104.X) <= v105.X then
            if math.abs(v104.Y) <= v105.Y then
                if math.abs(v104.Z) <= v105.Z then
                    return Size.X * Size.Y * Size.Z
                end
            end
        end

        return nil
    else
        return nil
    end
end

local function getRaidLocations() -- line: 1074
    -- upvalues:
    --  [1] t_26 (copy)
    --  [2] t_22 (copy)
    --  [3] locationContains (copy)
    --  [4] t_8 (copy)

    local t_31 = {}

    for _, val_16 in t_26 do
        local v109 = nil
        local v110 = math.huge

        for key_20 in t_22 do
            local v111 = locationContains(key_20, val_16)

            if v111 and v110 > v111 then
                v109 = key_20
                v110 = v111
            end
        end

        if not v109 then
            v110 = t_8.FallbackRadius

            for key_21 in t_22 do
                local Position_3 = key_21:GetAttribute("Position")

                if typeof(Position_3) == "Vector3" and v110 > (Position_3 - val_16).Magnitude then
                    v109 = key_21
                    v110 = (Position_3 - val_16).Magnitude
                end
            end
        end

        if v109 then
            t_31[v109] = true
        end
    end

    return t_31
end

local function updateTracking() -- line: 1102
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] v36 (ref)
    --  [3] RegionDefinitions_m (copy)
    --  [4] t_16 (copy)
    --  [5] getAreaAt (copy)
    --  [6] v37 (ref)
    --  [7] v30 (ref)
    --  [8] discoverRegion (copy)
    --  [9] v38 (ref)
    --  [10] updateWaypoint (copy)
    --  [11] updateDeathDisplays (copy)
    --  [12] updatePoints (copy)

    local Character_4 = LocalPlayer.Character
    local v112 = Character_4

    if v112 then
        v112 = Character_4:FindFirstChild("HumanoidRootPart")
    end

    local v113 = v112 and v112.CFrame
    local v114 = v113

    if v114 then
        v114 = v113.Position
    end

    if not v114 then
        return
    end

    local _ = v36
    v112 = RegionDefinitions_m.PieceIndexAt(v114.X, v114.Z)
    v113 = if v112 then t_16[v112] else nil
    local v116 = getAreaAt(v114, v37)

    if v113 ~= v36 or v116 ~= v37 then
        local v117 = if v113 == v36 then false else true
        v36 = v113
        v37 = v116

        if v117 and v113 and v30 then
            discoverRegion(v113)
        end

        if v38 then
            v38.regionChanged(v113)
        end
    end

    updateWaypoint(v114)
    updateDeathDisplays(v114)
    updatePoints(v114)
end

local v118 = 0
RunService.Heartbeat:Connect(function(deltaTime_1) -- line: 1132
    -- upvalues:
    --  [1] v118 (ref)
    --  [2] updateTracking (copy)

    v118 += deltaTime_1

    if v118 < 0.25 then
        return
    end

    v118 = 0
    updateTracking()
end)

local _ = function(s7: string?) --[[ isCategoryEnabled ]] -- line: 1142
    -- upvalues:
    --  [1] v26 (copy)

    return s7 == nil or v26[s7] ~= false
end

function t_15.getFilter(s8: string) -- line: 1146
    -- upvalues:
    --  [1] v26 (copy)

    return v26[s8] ~= false
end

function t_15.setFilter(s9: string, b2: boolean) -- line: 1150
    -- upvalues:
    --  [1] v26 (copy)
    --  [2] t_15 (copy)
    --  [3] v38 (ref)

    b2 = b2 == true

    if (if v26[s9] == false then false else true) == b2 then
        return
    end

    v26[s9] = b2

    if t_15.onFilterChanged then
        task.spawn(t_15.onFilterChanged, s9, b2)
    end

    if v38 then
        v38.filtersChanged()
    end
end

function t_15.toggleFilter(s10: string) -- line: 1165
    -- upvalues:
    --  [1] t_15 (copy)

    local v122 = not t_15.getFilter(s10)
    t_15.setFilter(s10, v122)

    return v122
end

function t_15.getFilters() -- line: 1171
    -- upvalues:
    --  [1] v26 (copy)

    return table.clone(v26)
end

function t_15.setFilters(t9: table) -- line: 1175
    -- upvalues:
    --  [1] t_15 (copy)

    for key_22, val_17 in t9 do
        t_15.setFilter(key_22, val_17)
    end
end

function t_15.resetFilters() -- line: 1181
    -- upvalues:
    --  [1] t_15 (copy)
    --  [2] t_11 (copy)

    t_15.setFilters(t_11.Default)
end

function t_15.getWaypoint() -- line: 1185
    -- upvalues:
    --  [1] v31 (ref)

    return v31
end

function t_15.setWaypoint(vec15: Vector3, b3: boolean?) -- line: 1189
    -- upvalues:
    --  [1] setWaypoint (copy)

    setWaypoint(vec15, b3)
end

function t_15.clearWaypoint() -- line: 1193
    -- upvalues:
    --  [1] setWaypoint (copy)

    setWaypoint(nil)
end

function t_15.getRegionAt(vec16: Vector3) -- line: 1197
    -- upvalues:
    --  [1] RegionDefinitions_m (copy)
    --  [2] t_16 (copy)

    local v123 = RegionDefinitions_m.PieceIndexAt(vec16.X, vec16.Z)

    if v123 then
        return t_16[v123]
    end

    return nil
end

function t_15.getCurrentRegion() -- line: 1201
    -- upvalues:
    --  [1] v36 (ref)

    return v36
end

function t_15.getRegion(s11: string) -- line: 1205
    -- upvalues:
    --  [1] t_17 (copy)

    return t_17[s11]
end

function t_15.getRegions() -- line: 1209
    -- upvalues:
    --  [1] t_16 (copy)

    return table.clone(t_16)
end

function t_15.getAreaAt(vec17: Vector3) -- line: 1213
    -- upvalues:
    --  [1] t_18 (copy)

    for _, val_18 in t_18 do
        if vec17.X >= val_18.Min.X and (vec17.X <= val_18.Max.X and (vec17.Z >= val_18.Min.Y and vec17.Z <= val_18.Max.Y)) then
            return val_18
        end
    end

    return nil
end

function t_15.getCurrentArea() -- line: 1217
    -- upvalues:
    --  [1] v37 (ref)

    return v37
end

function t_15.getRegionCounts() -- line: 1222
    -- upvalues:
    --  [1] t_16 (copy)
    --  [2] v18 (copy)

    local v125 = 0
    local v126 = 0

    for _, val_19 in t_16 do
        if not val_19.DiscoveryDisabled then
            v126 += 1

            if v18[val_19.Name] then
                v125 += 1
            end
        end
    end

    return v125, v126
end

function t_15.isDiscovered(s12: string) -- line: 1235
    -- upvalues:
    --  [1] v18 (copy)

    return v18[s12] == true
end

function t_15.setDiscovered(s13: string, b4: boolean) -- line: 1239
    -- upvalues:
    --  [1] v18 (copy)
    --  [2] v38 (ref)

    local v128 = if b4 then true else nil

    if v18[s13] == v128 then
        return
    end

    v18[s13] = v128

    if v38 then
        v38.discoveryChanged()
    end
end

function t_15.setDiscoveredRegions(t10: table) -- line: 1248
    -- upvalues:
    --  [1] v18 (copy)
    --  [2] v38 (ref)

    table.clear(v18)

    for _, val_20 in t10 do
        v18[val_20] = true
    end

    if v38 then
        v38.discoveryChanged()
    end
end

function t_15.getDiscoveredRegions() -- line: 1256
    -- upvalues:
    --  [1] v18 (copy)

    local t_32 = {}

    for key_26 in v18 do
        table.insert(t_32, key_26)
    end

    return t_32
end

function t_15.isLocationDiscovered(s14: string) -- line: 1264
    -- upvalues:
    --  [1] v19 (copy)

    return v19[s14] == true
end

function t_15.setLocationDiscovered(s15: string, b5: boolean) -- line: 1268
    -- upvalues:
    --  [1] v19 (copy)
    --  [2] v38 (ref)

    local v130 = if b5 then true else nil

    if v19[s15] == v130 then
        return
    end

    v19[s15] = v130

    if v38 then
        v38.discoveryChanged()
    end
end

function t_15.setDiscoveredLocations(t11: table) -- line: 1277
    -- upvalues:
    --  [1] v19 (copy)
    --  [2] v38 (ref)

    table.clear(v19)

    for _, val_21 in t11 do
        v19[val_21] = true
    end

    if v38 then
        v38.discoveryChanged()
    end
end

function t_15.getDiscoveredLocations() -- line: 1285
    -- upvalues:
    --  [1] v19 (copy)

    local t_33 = {}

    for key_28 in v19 do
        table.insert(t_33, key_28)
    end

    return t_33
end

function t_15.refreshPoints() -- line: 1294
    -- upvalues:
    --  [1] loadPoints (copy)

    task.spawn(loadPoints)
end

function t_15.getMapLocations() -- line: 1298
    -- upvalues:
    --  [1] t_22 (copy)

    local t_34 = {}

    for _, val_22 in t_22 do
        table.insert(t_34, val_22)
    end

    return t_34
end

function t_15.getLocationCounts() -- line: 1306
    -- upvalues:
    --  [1] t_22 (copy)
    --  [2] v19 (copy)

    local v131 = 0
    local v132 = 0

    for _, val_23 in t_22 do
        v132 += 1

        if v19[val_23.Name] then
            v131 += 1
        end
    end

    return v131, v132
end

function t_15.init(u13: userdata, u14: userdata?) -- line: 1317
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] Services_m (copy)
    --  [3] t_15 (copy)
    --  [4] t_3 (copy)
    --  [5] InfoHover (copy)
    --  [6] ReplicatedStorage (copy)
    --  [7] LocalPlayer (copy)
    --  [8] v15 (copy)
    --  [9] t_16 (copy)
    --  [10] t_4 (copy)
    --  [11] RegionDefinitions_m (copy)
    --  [12] v18 (copy)
    --  [13] TweenService (copy)
    --  [14] t (copy)
    --  [15] t_2 (copy)
    --  [16] v26 (copy)
    --  [17] resolveTarget (copy)
    --  [18] v37 (ref)
    --  [19] UserInputService (copy)
    --  [20] GuiService (copy)
    --  [21] uvToWorld (copy)
    --  [22] v19 (copy)
    --  [23] t_8 (copy)
    --  [24] getRaidLocations (copy)
    --  [25] t_22 (copy)
    --  [26] LocationMarker (copy)
    --  [27] t_5 (copy)
    --  [28] MapPoints_m (copy)
    --  [29] t_24 (copy)
    --  [30] t_9 (copy)
    --  [31] PointMarker (copy)
    --  [32] t_6 (copy)
    --  [33] v23 (copy)
    --  [34] QuestMarker (copy)
    --  [35] QuestProgress_m (copy)
    --  [36] ObjectiveMarker (copy)
    --  [37] ObjectTracker_m (copy)
    --  [38] t_11 (copy)
    --  [39] updateTracking (copy)
    --  [40] v36 (ref)
    --  [41] getRootCFrame (copy)
    --  [42] PlayerMarker (copy)
    --  [43] t_13 (copy)
    --  [44] Players (copy)
    --  [45] v31 (ref)
    --  [46] WaypointMarker (copy)
    --  [47] t_12 (copy)
    --  [48] t_23 (copy)
    --  [49] DeathMarker (copy)
    --  [50] v35 (ref)
    --  [51] PortalMarker (copy)
    --  [52] CollectionService (copy)
    --  [53] setWaypoint (copy)
    --  [54] v38 (ref)
    --  [55] Slider_m (copy)
    --  [56] ContextActionService (copy)
    --  [57] RunService (copy)
    --  [58] t_1 (copy)

    if v2 then
        v2:Destroy()
        v2 = nil
    end

    v2 = Services_m.Maid.new()
    local v133 = v2
    v2:GiveTask(u13.Destroying:Connect(function() -- line: 1326
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] v133 (copy)
        --  [3] t_15 (ref)

        if v2 == v133 then
            t_15.cleanup()
        end
    end))
    local MapImage = u13:WaitForChild("MapImage")
    u13.ClipsDescendants = true
    MapImage.AnchorPoint = Vector2.zero
    MapImage.Image = ""
    MapImage.ImageColor3 = t_3.Undiscovered
    MapImage.ScaleType = Enum.ScaleType.Stretch
    local v135 = script.Hover:Clone()
    v135.Parent = script
    v2:GiveTask(v135)
    local v136 = u13:FindFirstAncestorWhichIsA("ScreenGui")
    local v137 = InfoHover

    if v137 then
        v137 = InfoHover:Clone()
    end

    local v138 = nil

    if v137 then
        v137.Visible = false
        v137.Parent = v136 or u13
        v2:GiveTask(v137)
    end

    local BackpackUtils_m = require(ReplicatedStorage.Modules.BackpackUtils)

    local _ = function(u15: userdata?) --[[ hideInfo ]] -- line: 1357
        -- upvalues:
        --  [1] v138 (ref)
        --  [2] BackpackUtils_m (copy)

        if v138 and (u15 == nil or u15 == v138) then
            v138 = nil
            BackpackUtils_m:HideHover()
        end
    end

    local _ = function() --[[ placeInfo ]] -- line: 1364
    end

    local function showInfo(u16: userdata, f1: (...any) -> ...any) -- line: 1391
        -- upvalues:
        --  [1] v138 (ref)
        --  [2] BackpackUtils_m (copy)

        local v139, v140, v141 = f1()

        if not v139 then
            if v138 and (u16 == nil or u16 == v138) then
                v138 = nil
                BackpackUtils_m:HideHover()
            end

            return false
        end

        v138 = u16
        local t_35 = { key = v139, text = nil, color = nil }
        t_35.text, t_35.color = v140 or "", v141
        BackpackUtils_m:ShowHover(t_35)

        return true
    end

    local Quests_1 = LocalPlayer:WaitForChild("Quests")
    local t_36 = {
        zoom = 6,
        pos = Vector2.zero,
        baseSize = Vector2.one,
        laidOut = false,
        following = true
    }
    local t_37 = { input = nil, start = nil, last = nil, moved = false }
    local t_38 = { stick = Vector2.zero, zoomIn = 0, zoomOut = 0 }
    local t_39 = {}
    local v142 = 0
    local t_40 = {}
    local t_41 = {}
    local t_42 = {}

    local function placeImage(u17: userdata, u18: Vector2, u19: Vector2) -- line: 1452
        -- upvalues:
        --  [1] v15 (ref)

        local v143 = u19 - u18
        u17.Position = UDim2.fromScale(
            (u18.X - v15.Min.X) / v15.Size.X,
            (u18.Y - v15.Min.Y) / v15.Size.Y
        )
        u17.Size = UDim2.new(v143.X / v15.Size.X, 0, v143.Y / v15.Size.Y, 0)
    end

    local v144 = nil
    local v145 = nil
    local v146 = false
    local Fog_Folder = Instance.new("Folder")
    Fog_Folder.Name = "Fog"
    Fog_Folder.Parent = MapImage
    v2:GiveTask(Fog_Folder)
    local v148

    for index_1 = #t_16, 1, -1 do
        local v147 = t_16[index_1]
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = v147.Name
        ImageLabel.Image = v147.Image

        if v147.ImageRectSize then
            v148 = v147.ImageRectOffset or Vector2.zero
            ImageLabel.ImageRectOffset = v148
            ImageLabel.ImageRectSize = v147.ImageRectSize
        end

        ImageLabel.BackgroundTransparency = 1
        ImageLabel.ScaleType = Enum.ScaleType.Stretch
        ImageLabel.ResampleMode = Enum.ResamplerMode.Pixelated
        ImageLabel.AnchorPoint, v148 = Vector2.zero, placeImage
        v148(ImageLabel, v147.ImageMin or v147.Min, v147.ImageMax or v147.Max)
        ImageLabel.ZIndex = MapImage.ZIndex
        ImageLabel.Active = false
        ImageLabel.Parent = MapImage
        v2:GiveTask(ImageLabel)
        t_42[v147] = ImageLabel
    end

    local t_43 = {}
    local v154

    if t_4.Enabled and RegionDefinitions_m.Fog then
        for _, val_24 in RegionDefinitions_m.Fog do
            local v152 = t_16[val_24.Region]

            if v152 then
                local v153 = t_4.MinSize + (t_4.MaxSize - t_4.MinSize) * val_24.Bucket / 7
                local ImageLabel_1 = Instance.new("ImageLabel")
                ImageLabel_1.Name = v152.Name
                ImageLabel_1.Image = t_4.Image
                ImageLabel_1.ImageColor3 = t_4.Color
                ImageLabel_1.ImageTransparency = 1
                ImageLabel_1.BackgroundTransparency = 1
                ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageLabel_1.Position = UDim2.fromScale(
                    (val_24.Position.X - v15.Min.X) / v15.Size.X,
                    (val_24.Position.Y - v15.Min.Y) / v15.Size.Y
                )
                ImageLabel_1.Size = UDim2.fromScale(v153 / v15.Size.X, v153 / v15.Size.Y)
                ImageLabel_1.Rotation = val_24.Rotation
                ImageLabel_1.ZIndex = MapImage.ZIndex + 1
                ImageLabel_1.Active = false
                ImageLabel_1.Parent = Fog_Folder
                local t_44 = { label = ImageLabel_1, region = v152, other = nil }
                v154 = val_24.Other and t_16[val_24.Other]
                t_44.other = v154
                table.insert(t_43, t_44)
            end
        end
    end

    local function refreshFog(b6: boolean?) -- line: 1529
        -- upvalues:
        --  [1] t_43 (copy)
        --  [2] v18 (ref)
        --  [3] t_4 (ref)
        --  [4] TweenService (ref)

        local v155, v156

        for _, val_25 in t_43 do
            local Region = val_25.region
            v155 = if not Region.DiscoveryDisabled then v18[Region.Name] == true else true
            v156 = not v155 and (val_25.other == nil or (if not val_25.other.DiscoveryDisabled then v18[val_25.other.Name] == true else true))

            if val_25.visible ~= v156 or b6 then
                val_25.visible = v156

                if val_25.tween then
                    val_25.tween:Cancel()
                    val_25.tween = nil
                end

                local v155 = val_25.label
                local v157 = if not v156 then 1 else t_4.Transparency

                if b6 then
                    v155.ImageTransparency = v157
                    v155.Visible = v156
                else
                    v155.Visible = true
                    local v158 = TweenService:Create(
                        v155,
                        t_4.FadeInfo,
                        { ImageTransparency = v157 }
                    )
                    val_25.tween = v158
                    v158.Completed:Connect(function(playbackState) -- line: 1551
                        -- upvalues:
                        --  [1] val_25 (copy)
                        --  [2] v158 (copy)
                        --  [3] v155 (copy)
                        --  [4] v156 (copy)

                        if playbackState == Enum.PlaybackState.Completed and val_25.tween == v158 then
                            val_25.tween = nil
                            v155.Visible = v156
                        end
                    end)
                    v158:Play()
                end
            end
        end
    end

    local function refreshTiles(b7: boolean?) -- line: 1562
        -- upvalues:
        --  [1] t_42 (copy)
        --  [2] v18 (ref)
        --  [3] t_3 (ref)
        --  [4] MapImage (copy)
        --  [5] TweenService (ref)
        --  [6] refreshFog (copy)

        for key_33, val_26 in t_42 do
            local v159 = if not key_33.DiscoveryDisabled then v18[key_33.Name] == true else true
            local v160 = if v159 then if not key_33.DiscoveryDisabled then t_3.Discovered else t_3.DiscoveryDisabled else t_3.Undiscovered
            local v161 = if not v159 then 1 else 0
            val_26.ZIndex = MapImage.ZIndex + v161

            if b7 then
                val_26.ImageColor3 = v160
            else
                TweenService:Create(val_26, t_3.FadeInfo, { ImageColor3 = v160 }):Play()
            end
        end

        refreshFog(b7)
    end

    local _ = function() --[[ syncSlider ]] -- line: 1583
        -- upvalues:
        --  [1] v144 (ref)
        --  [2] v146 (ref)
        --  [3] t_36 (copy)
        --  [4] t (ref)
        --  [5] v145 (ref)

        if not v144 or v144.IsHeld then
            return
        end

        v146 = true
        v144:OverrideValue(math.log(t_36.zoom / t.Min) / math.log(t.Max / t.Min) * 1000)
        v146 = false
        v145 = v144:GetValue()
    end

    local _ = function() --[[ hasValidSize ]] -- line: 1593
        -- upvalues:
        --  [1] u13 (copy)

        local AbsoluteSize = u13.AbsoluteSize

        return AbsoluteSize.X > 0 and AbsoluteSize.Y > 0
    end

    local function recomputeBaseSize() -- line: 1598
        -- upvalues:
        --  [1] u13 (copy)
        --  [2] v15 (ref)
        --  [3] t_36 (copy)

        local AbsoluteSize_1 = u13.AbsoluteSize

        if not (AbsoluteSize_1.X > 0 and AbsoluteSize_1.Y > 0) then
            return false
        end

        local AbsoluteSize_2 = u13.AbsoluteSize
        local v167 = v15.Size.X / v15.Size.Y

        if v167 < AbsoluteSize_2.X / AbsoluteSize_2.Y then
            t_36.baseSize = Vector2.new(AbsoluteSize_2.X, AbsoluteSize_2.X / v167)
        else
            t_36.baseSize = Vector2.new(AbsoluteSize_2.Y * v167, AbsoluteSize_2.Y)
        end

        t_36.laidOut = true

        return true
    end

    local _ = function() --[[ getCanvasSize ]] -- line: 1615
        -- upvalues:
        --  [1] t_36 (copy)

        return t_36.baseSize * t_36.zoom
    end

    local function clampPos(u20: Vector2) -- line: 1619
        -- upvalues:
        --  [1] u13 (copy)
        --  [2] t_36 (copy)

        local AbsoluteSize_3 = u13.AbsoluteSize
        local v170 = t_36.baseSize * t_36.zoom
        local v171 = AbsoluteSize_3 * 0.25
        local New_8 = Vector2.new
        local X_5 = u20.X
        local v172 = math.min(AbsoluteSize_3.X - v170.X - v171.X, v171.X)
        local v173 = math.clamp(X_5, v172, v171.X)
        local Y_7 = u20.Y
        local v174 = math.min(AbsoluteSize_3.Y - v170.Y - v171.Y, v171.Y)

        return New_8(v173, (math.clamp(Y_7, v174, v171.Y)))
    end

    local _ = function() --[[ applyLayout ]] -- line: 1629
        -- upvalues:
        --  [1] t_36 (copy)
        --  [2] clampPos (copy)
        --  [3] MapImage (copy)

        t_36.pos = clampPos(t_36.pos)
        local v176 = t_36.baseSize * t_36.zoom
        MapImage.Size = UDim2.fromOffset(v176.X, v176.Y)
        MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
    end

    local _ = function(u21: Vector2) --[[ centerOnUV ]] -- line: 1636
        -- upvalues:
        --  [1] t_36 (copy)
        --  [2] u13 (copy)
        --  [3] clampPos (copy)
        --  [4] MapImage (copy)

        t_36.pos = u13.AbsoluteSize / 2 - u21 * (t_36.baseSize * t_36.zoom)
        t_36.pos = clampPos(t_36.pos)
        local v180 = t_36.baseSize * t_36.zoom
        MapImage.Size = UDim2.fromOffset(v180.X, v180.Y)
        MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
    end

    local _ = function() --[[ getCenterUV ]] -- line: 1641
        -- upvalues:
        --  [1] u13 (copy)
        --  [2] t_36 (copy)

        return (u13.AbsoluteSize / 2 - t_36.pos) / (t_36.baseSize * t_36.zoom)
    end

    local function followPlayer() -- line: 1645
        -- upvalues:
        --  [1] LocalPlayer (ref)
        --  [2] recomputeBaseSize (copy)
        --  [3] v15 (ref)
        --  [4] t_36 (copy)
        --  [5] u13 (copy)
        --  [6] clampPos (copy)
        --  [7] MapImage (copy)

        local Character_5 = LocalPlayer.Character
        local v183 = Character_5

        if v183 then
            v183 = Character_5:FindFirstChild("HumanoidRootPart")
        end

        local v184 = v183 and v183.CFrame
        local v185 = v184

        if v185 then
            v185 = v184.Position
        end

        local vec2_2

        if v185 then
            if not recomputeBaseSize() then
                return false
            end

            vec2_2 = Vector2.new(
                (v185.X - v15.Min.X) / v15.Size.X,
                (v185.Z - v15.Min.Y) / v15.Size.Y
            )
            local v186 = vec2_2.X >= 0 and (vec2_2.X <= 1 and (vec2_2.Y >= 0 and vec2_2.Y <= 1))
            local v187 = if not v186 then Vector2.new(0.5, 0.5) else vec2_2
            t_36.pos = u13.AbsoluteSize / 2 - v187 * (t_36.baseSize * t_36.zoom)
            t_36.pos = clampPos(t_36.pos)
            v185 = t_36.baseSize * t_36.zoom
            MapImage.Size = UDim2.fromOffset(v185.X, v185.Y)
            MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)

            return true
        else
            return false
        end
    end

    local _ = function() --[[ centerOnPlayer ]] -- line: 1656
        -- upvalues:
        --  [1] t_36 (copy)
        --  [2] followPlayer (copy)
        --  [3] LocalPlayer (ref)
        --  [4] u13 (copy)

        t_36.following = true
        local v194 = followPlayer()
        local Character_6 = LocalPlayer.Character
        local v195 = Character_6

        if v195 then
            v195 = Character_6:FindFirstChild("HumanoidRootPart")
        end

        local v196 = v195 and v195.CFrame
        local v197 = v196 and v196.Position

        if v194 and v197 then
            u13:SetAttribute("FocusPoint", v197)
        end

        return v194
    end

    function v154() --[[ stopFollowing ]] -- line: 1667
        -- upvalues:
        --  [1] t_36 (copy)

        t_36.following = false
    end

    local _ = function(n4: number, u22: Vector2, b8: boolean?) --[[ zoomAt ]] -- line: 1671
        -- upvalues:
        --  [1] t_36 (copy)
        --  [2] clampPos (copy)
        --  [3] MapImage (copy)
        --  [4] v144 (ref)
        --  [5] v146 (ref)
        --  [6] t (ref)
        --  [7] t_2 (ref)
        --  [8] v145 (ref)

        n4 = math.clamp(n4, 2.5, 8)

        if n4 == t_36.zoom then
            return
        end

        local v198 = (u22 - t_36.pos) / (t_36.baseSize * t_36.zoom)
        t_36.zoom = n4
        t_36.pos = u22 - v198 * (t_36.baseSize * t_36.zoom)
        t_36.pos = clampPos(t_36.pos)
        local v200 = t_36.baseSize * t_36.zoom
        MapImage.Size = UDim2.fromOffset(v200.X, v200.Y)
        MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)

        if not b8 and v144 then
            if v144.IsHeld then
                return
            end

            v146 = true
            v144:OverrideValue(math.log(t_36.zoom / t.Min) / math.log(t.Max / t.Min) * t_2.Steps)
            v146 = false
            v145 = v144:GetValue()
        end
    end

    local _ = function(u23: userdata) --[[ releaseHover ]] -- line: 1685
        -- upvalues:
        --  [1] v135 (copy)
        --  [2] v138 (ref)
        --  [3] BackpackUtils_m (copy)

        if v135.Parent == u23 then
            v135.Parent = script
        end

        if v138 and (u23 == nil or u23 == v138) then
            v138 = nil
            BackpackUtils_m:HideHover()
        end
    end

    local _ = function(arg9) --[[ hideMarker ]] -- line: 1692
        -- upvalues:
        --  [1] v135 (copy)
        --  [2] v138 (ref)
        --  [3] BackpackUtils_m (copy)

        if arg9.gui.Visible then
            arg9.gui.Visible = false
            local Gui = arg9.gui

            if v135.Parent == Gui then
                v135.Parent = script
            end

            if v138 and (Gui == nil or Gui == v138) then
                v138 = nil
                BackpackUtils_m:HideHover()
            end
        end
    end

    local function updateMarker(arg10) -- line: 1699
        -- upvalues:
        --  [1] v26 (ref)
        --  [2] v135 (copy)
        --  [3] v138 (ref)
        --  [4] BackpackUtils_m (copy)
        --  [5] resolveTarget (ref)
        --  [6] RegionDefinitions_m (ref)
        --  [7] t_16 (ref)
        --  [8] v18 (ref)
        --  [9] v15 (ref)

        local Category = arg10.category

        if not (Category == nil or v26[Category] ~= false) then
            if arg10.gui.Visible then
                arg10.gui.Visible = false
                local Gui_1 = arg10.gui

                if v135.Parent == Gui_1 then
                    v135.Parent = script
                end

                if v138 and (Gui_1 == nil or Gui_1 == v138) then
                    v138 = nil
                    BackpackUtils_m:HideHover()
                end
            end

            return
        end

        local v207 = resolveTarget(arg10.target)

        if not v207 then
            if arg10.gui.Visible then
                arg10.gui.Visible = false
                local Gui_2 = arg10.gui

                if v135.Parent == Gui_2 then
                    v135.Parent = script
                end

                if v138 and (Gui_2 == nil or Gui_2 == v138) then
                    v138 = nil
                    BackpackUtils_m:HideHover()
                end
            end

            return
        end

        if not arg10.alwaysVisible then
            local Position_4 = v207.Position
            local v208 = RegionDefinitions_m.PieceIndexAt(Position_4.X, Position_4.Z)
            local v209 = if v208 then t_16[v208] else nil

            if not (if v209 == nil then false else not v209.DiscoveryDisabled and v18[v209.Name] == true) then
                if arg10.gui.Visible then
                    arg10.gui.Visible = false
                    local Gui_3 = arg10.gui

                    if v135.Parent == Gui_3 then
                        v135.Parent = script
                    end

                    if v138 and (Gui_3 == nil or Gui_3 == v138) then
                        v138 = nil
                        BackpackUtils_m:HideHover()
                    end
                end

                return
            end
        end

        local v211 = v207.Position
        local vec2_3 = Vector2.new(
            (v211.X - v15.Min.X) / v15.Size.X,
            (v211.Z - v15.Min.Y) / v15.Size.Y
        )
        v211 = vec2_3.X >= 0 and (vec2_3.X <= 1 and (vec2_3.Y >= 0 and vec2_3.Y <= 1))

        if not v211 then
            if arg10.gui.Visible then
                arg10.gui.Visible = false
                local Gui_4 = arg10.gui

                if v135.Parent == Gui_4 then
                    v135.Parent = script
                end

                if v138 and (Gui_4 == nil or Gui_4 == v138) then
                    v138 = nil
                    BackpackUtils_m:HideHover()
                end
            end

            return
        end

        arg10.gui.Visible = true
        arg10.gui.Position = UDim2.fromScale(vec2_3.X, vec2_3.Y)

        if arg10.rotate then
            local LookVector_1 = v207.LookVector
            arg10.gui.Rotation = math.deg((math.atan2(LookVector_1.X, -LookVector_1.Z)))
        end
    end

    local _ = function() --[[ updateAllMarkers ]] -- line: 1729
        -- upvalues:
        --  [1] t_39 (copy)
        --  [2] updateMarker (copy)

        for _, val_27 in t_39 do
            updateMarker(val_27)
        end
    end

    local function setHeader(t12: table?) -- line: 1735
        -- upvalues:
        --  [1] v136 (copy)
        --  [2] v37 (ref)

        local v213 = v136

        if v213 then
            v213 = v136:FindFirstChild("Main")
        end

        local v214 = v213

        if v214 then
            v214 = v213:FindFirstChild("Header")
        end

        if not v214 then
            return
        end

        v213 = v214:FindFirstChild("Description")
        local v215 = nil
        local Description_1 = nil

        if t12 and t12.DisplayName then
            v215 = t12.DisplayName
            Description_1 = t12.Description
        elseif v37 then
            v215 = v37.Name
            Description_1 = v37.Description
        end

        if v215 then
            v214.Text = string.upper(v215)

            if v213 then
                v213.Text = Description_1 or ""

                return
            end
        else
            v214.Text = "UNCHARTED TERRITORY"

            if v213 then
                v213.Text = "???"
            end
        end
    end

    local _ = function() --[[ getCursorInGuiSpace ]] -- line: 1764
        -- upvalues:
        --  [1] UserInputService (ref)
        --  [2] v136 (copy)
        --  [3] GuiService (ref)

        local v217 = UserInputService:GetMouseLocation()

        if v136 and not v136.IgnoreGuiInset then
            v217 -= GuiService:GetGuiInset()
        end

        return v217
    end

    local _ = function(u24: userdata) --[[ inputToGuiSpace ]] -- line: 1773
        -- upvalues:
        --  [1] v136 (copy)
        --  [2] GuiService (ref)

        local vec2_4 = Vector2.new(u24.Position.X, u24.Position.Y)

        if v136 and v136.IgnoreGuiInset then
            vec2_4 += GuiService:GetGuiInset()
        end

        return vec2_4
    end

    local _ = function(u25: Vector2) --[[ guiPointToUV ]] -- line: 1781
        -- upvalues:
        --  [1] u13 (copy)
        --  [2] t_36 (copy)

        return (u25 - u13.AbsolutePosition - t_36.pos) / (t_36.baseSize * t_36.zoom)
    end

    function t_15.worldToMap(vec18: Vector3) -- line: 1785
        -- upvalues:
        --  [1] v15 (ref)

        local vec2_5 = Vector2.new(
            (vec18.X - v15.Min.X) / v15.Size.X,
            (vec18.Z - v15.Min.Y) / v15.Size.Y
        )

        if vec2_5.X >= 0 and (vec2_5.X <= 1 and (vec2_5.Y >= 0 and vec2_5.Y <= 1)) then
            return vec2_5
        end

        return nil
    end

    function t_15.mapToWorld(u26: Vector2) -- line: 1790
        -- upvalues:
        --  [1] uvToWorld (ref)

        return (uvToWorld(u26))
    end

    function t_15.worldToGui(vec19: Vector3) -- line: 1794
        -- upvalues:
        --  [1] t_15 (ref)
        --  [2] u13 (copy)
        --  [3] t_36 (copy)

        local v219 = t_15.worldToMap(vec19)

        if not v219 then
            return nil
        end

        return u13.AbsolutePosition + t_36.pos + v219 * (t_36.baseSize * t_36.zoom)
    end

    function t_15.guiToWorld(u27: Vector2) -- line: 1802
        -- upvalues:
        --  [1] u13 (copy)
        --  [2] t_36 (copy)
        --  [3] uvToWorld (ref)

        local v220 = (u27 - u13.AbsolutePosition - t_36.pos) / (t_36.baseSize * t_36.zoom)

        if not (v220.X >= 0 and (v220.X <= 1 and (v220.Y >= 0 and v220.Y <= 1))) then
            return nil
        end

        return (uvToWorld(v220))
    end

    function t_15.getWorldAtCursor() -- line: 1810
        -- upvalues:
        --  [1] t_15 (ref)
        --  [2] UserInputService (ref)
        --  [3] v136 (copy)
        --  [4] GuiService (ref)

        local GuiToWorld = t_15.guiToWorld
        local v222 = UserInputService:GetMouseLocation()

        if v136 and not v136.IgnoreGuiInset then
            v222 -= GuiService:GetGuiInset()
        end

        return GuiToWorld(v222)
    end

    function t_15.centerOn(vec20: Vector3) -- line: 1814
        -- upvalues:
        --  [1] t_15 (ref)
        --  [2] t_36 (copy)
        --  [3] u13 (copy)
        --  [4] clampPos (copy)
        --  [5] MapImage (copy)

        local v223 = t_15.worldToMap(vec20)

        if v223 then
            t_36.following = false
            t_36.pos = u13.AbsoluteSize / 2 - v223 * (t_36.baseSize * t_36.zoom)
            t_36.pos = clampPos(t_36.pos)
            local v225 = t_36.baseSize * t_36.zoom
            MapImage.Size = UDim2.fromOffset(v225.X, v225.Y)
            MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
        end
    end

    function t_15.centerOnPlayer() -- line: 1822
        -- upvalues:
        --  [1] t_36 (copy)
        --  [2] followPlayer (copy)
        --  [3] LocalPlayer (ref)
        --  [4] u13 (copy)

        t_36.following = true
        local v228 = followPlayer()
        local Character_7 = LocalPlayer.Character
        local v229 = Character_7

        if v229 then
            v229 = Character_7:FindFirstChild("HumanoidRootPart")
        end

        local v230 = v229 and v229.CFrame
        local v231 = v230 and v230.Position

        if v228 and v231 then
            u13:SetAttribute("FocusPoint", v231)
        end

        return v228
    end

    function t_15.addMarker(arg11: any, u28: userdata, t13: table?) -- line: 1826
        -- upvalues:
        --  [1] MapImage (copy)
        --  [2] v142 (ref)
        --  [3] showInfo (copy)
        --  [4] v135 (copy)
        --  [5] v138 (ref)
        --  [6] BackpackUtils_m (copy)
        --  [7] t_39 (copy)
        --  [8] updateMarker (copy)

        local v232 = t13 or {}
        local v233 = u28:Clone()
        v233.AnchorPoint = Vector2.new(0.5, 0.5)
        v233.ZIndex = MapImage.ZIndex + 1 + (v232.ZIndex or 1)
        v233.Parent = MapImage

        for _, val_28 in v233:QueryDescendants("TextLabel, ImageLabel") do
            val_28.ZIndex = v233.ZIndex - 1
        end

        v142 += 1
        local v234 = v142

        if v232.Hover or v232.Info then
            local v235 = 0

            local function onEnter() -- line: 1845
                -- upvalues:
                --  [1] v235 (ref)
                --  [2] v232 (copy)
                --  [3] showInfo (ref)
                --  [4] v233 (copy)
                --  [5] v135 (ref)

                v235 += 1

                if v235 > 1 then
                    return
                end

                if v232.Info and showInfo(v233, v232.Info) then
                    return
                end

                if v232.Hover then
                    v135.Text = v232.Hover
                    v135.Parent = v233
                end
            end

            local function onLeave() -- line: 1859
                -- upvalues:
                --  [1] v235 (ref)
                --  [2] v233 (copy)
                --  [3] v135 (ref)
                --  [4] v138 (ref)
                --  [5] BackpackUtils_m (ref)

                v235 = math.max(v235 - 1, 0)

                if v235 == 0 then
                    local v236 = v233

                    if v135.Parent == v236 then
                        v135.Parent = script
                    end

                    if v138 and (v236 == nil or v236 == v138) then
                        v138 = nil
                        BackpackUtils_m:HideHover()
                    end
                end
            end

            v233.MouseEnter:Connect(onEnter)
            v233.MouseLeave:Connect(onLeave)

            if v232.Info then
                for _, val_29 in v233:QueryDescendants("TextLabel") do
                    val_29.MouseEnter:Connect(onEnter)
                    val_29.MouseLeave:Connect(onLeave)
                end

                v233:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 1873
                    -- upvalues:
                    --  [1] v233 (copy)
                    --  [2] v235 (ref)

                    if not v233.Visible then
                        v235 = 0
                    end
                end)
            end
        end

        local t_47 = {
            gui = v233,
            target = arg11,
            rotate = v232.Rotate == true,
            alwaysVisible = v232.AlwaysVisible == true,
            category = v232.Category
        }
        t_39[v234] = t_47
        updateMarker(t_47)

        local function remove() -- line: 1891
            -- upvalues:
            --  [1] t_39 (ref)
            --  [2] v234 (copy)
            --  [3] v233 (copy)
            --  [4] v135 (ref)
            --  [5] v138 (ref)
            --  [6] BackpackUtils_m (ref)

            if t_39[v234] then
                t_39[v234] = nil
                local v239 = v233

                if v135.Parent == v239 then
                    v135.Parent = script
                end

                if v138 and (v239 == nil or v239 == v138) then
                    v138 = nil
                    BackpackUtils_m:HideHover()
                end

                v233:Destroy()
            end
        end

        return remove, v233
    end

    local t_48 = {}

    local function refreshLocationLabels() -- line: 1904
        -- upvalues:
        --  [1] t_40 (copy)
        --  [2] v19 (ref)
        --  [3] t_48 (ref)
        --  [4] t_8 (ref)

        for key_37, val_30 in t_40 do
            if val_30.label then
                local Location = val_30.location
                val_30.label.Text = if not v19[Location.Name] then "???" else Location.DisplayName
                val_30.label.TextColor3 = if not t_48[key_37] then val_30.baseColor else t_8.Color
            end
        end
    end

    local function refreshRaids() -- line: 1916
        -- upvalues:
        --  [1] t_48 (ref)
        --  [2] getRaidLocations (ref)
        --  [3] refreshLocationLabels (copy)
        --  [4] v138 (ref)
        --  [5] t_40 (copy)
        --  [6] BackpackUtils_m (copy)

        t_48 = getRaidLocations()
        refreshLocationLabels()

        if v138 then
            for key_38, val_31 in t_40 do
                if val_31.gui == v138 and not t_48[key_38] then
                    local v241 = v138

                    if v138 and (v241 == nil or v241 == v138) then
                        v138 = nil
                        BackpackUtils_m:HideHover()
                    end
                end
            end
        end
    end

    local function syncLocationMarkers() -- line: 1930
        -- upvalues:
        --  [1] t_40 (copy)
        --  [2] t_22 (ref)
        --  [3] t_15 (ref)
        --  [4] LocationMarker (ref)
        --  [5] t_5 (ref)
        --  [6] t_48 (ref)
        --  [7] v19 (ref)
        --  [8] t_8 (ref)
        --  [9] getRaidLocations (ref)
        --  [10] refreshLocationLabels (copy)

        for key_39, val_32 in t_40 do
            if t_22[key_39] ~= val_32.location then
                val_32.remove()
                t_40[key_39] = nil
            end
        end

        for key_40, val_33 in t_22 do
            if not t_40[key_40] then
                local t_49 = { ZIndex = t_5.ZIndex, Category = "Locations", Info = nil }

                function t_49.Info() -- line: 1943
                    -- upvalues:
                    --  [1] t_48 (ref)
                    --  [2] key_40 (copy)
                    --  [3] v19 (ref)
                    --  [4] val_33 (copy)
                    --  [5] t_8 (ref)

                    if not t_48[key_40] then
                        return nil
                    end

                    return if not v19[val_33.Name] then "???" else val_33.DisplayName, t_8.Text, t_8.Color
                end

                local v243, v244 = t_15.addMarker(val_33.Target, LocationMarker, t_49)
                local v245 = v244:FindFirstChild(t_5.LabelName, true)

                if not v245 and v244:IsA("TextLabel") then
                    v245 = v244
                end

                local t_50 = {
                    remove = v243,
                    gui = v244,
                    label = v245,
                    baseColor = nil,
                    location = nil
                }
                local v246 = if not v245 then Color3.new(1, 1, 1) else v245.TextColor3
                local v247 = t_40
                t_50.baseColor = v246
                t_50.location = val_33
                v247[key_40] = t_50
            end
        end

        t_48 = getRaidLocations()
        refreshLocationLabels()
    end

    local t_51 = {}

    local function stylePoint(s16: string) -- line: 1976
        -- upvalues:
        --  [1] t_51 (copy)
        --  [2] MapPoints_m (ref)
        --  [3] t_24 (ref)
        --  [4] t_9 (ref)

        local v248 = t_51[s16]
        local v249 = MapPoints_m.Points[s16]

        if not v248 or not v249 then
            return
        end

        local v250 = MapPoints_m.Kinds[v249.Kind] or {}
        v249 = if t_24[s16] ~= 2 then false else true
        v248.gui.BackgroundColor3 = if not v249 then t_9.UnknownColor else v250.Color or Color3.new(
            1,
            1,
            1
        )
        v250 = v248.gui:FindFirstChild("Glyph")

        if v250 and v250:IsA("GuiObject") then
            v250.Visible = not v249
        end
    end

    local function syncPointMarkers() -- line: 1992
        -- upvalues:
        --  [1] PointMarker (ref)
        --  [2] t_24 (ref)
        --  [3] MapPoints_m (ref)
        --  [4] t_51 (copy)
        --  [5] t_15 (ref)
        --  [6] t_9 (ref)
        --  [7] stylePoint (copy)

        if not PointMarker then
            return
        end

        local v252

        for key_41, val_34 in t_24 do
            v252 = MapPoints_m.Points
            local v253 = v252[key_41]

            if v253 then
                v252 = 1

                if not (val_34 < v252) then
                    v252 = t_51[key_41]

                    if not v252 then
                        v252 = MapPoints_m.Kinds[v253.Kind] or {}
                        local t_52 = { ZIndex = t_9.ZIndex, Category = t_9.Category, Info = nil }

                        function t_52.Info() -- line: 2008
                            -- upvalues:
                            --  [1] t_24 (ref)
                            --  [2] key_41 (copy)
                            --  [3] v253 (copy)
                            --  [4] v252 (copy)

                            if t_24[key_41] == 2 then
                                return v253.Name, v252.SolvedText, v252.Color
                            end

                            return v252.UnknownName or "???", v252.UnknownText, nil
                        end

                        local v254, v255 = t_15.addMarker(v253.Position, PointMarker, t_52)
                        local Glyph = v255:FindFirstChild("Glyph")

                        if Glyph and Glyph:IsA("GuiObject") then
                            Glyph.ZIndex = v255.ZIndex + 1
                        end

                        t_51[key_41] = { remove = v254, gui = v255 }
                    end

                    stylePoint(key_41)
                end
            end
        end
    end

    local function tintMarker(u29: userdata, u30: Color3) -- line: 2029
        -- upvalues:
        --  [1] t_6 (ref)

        local v256 = u29:FindFirstChild(t_6.IconName, true)
        local v257

        if v256 then
            if not v256:IsA("ImageLabel") then
                v257 = if v256:IsA("ImageButton") then v256 else u29
            else
                v257 = v256
                v257 = u29
            end
        else
            v257 = u29
        end

        if not v257:IsA("ImageLabel") then
            if v257:IsA("ImageButton") then
                v257.ImageColor3 = u30
            end
        else
            v257.ImageColor3 = u30
        end
    end

    local function refreshGiverTint(s17: string) -- line: 2037
        -- upvalues:
        --  [1] t_41 (copy)
        --  [2] v23 (ref)
        --  [3] Quests_1 (copy)
        --  [4] t_6 (ref)
        --  [5] tintMarker (copy)

        local v258 = t_41[s17]
        local v259 = v23[s17]

        if not v258 or not v259 then
            return
        end

        local v260 = if Quests_1:FindFirstChild(s17) then t_6.Colors.InProgress else if v259.Quest:GetAttribute(
            "CooldownType"
        ) == "OneTime" then t_6.Colors.OneTime else t_6.Colors.Repeatable
        tintMarker(v258.gui, v260)
    end

    local function syncGiverMarkers() -- line: 2055
        -- upvalues:
        --  [1] v23 (ref)
        --  [2] t_41 (copy)
        --  [3] t_15 (ref)
        --  [4] QuestMarker (ref)
        --  [5] t_6 (ref)
        --  [6] refreshGiverTint (copy)

        for key_42, val_35 in v23 do
            if not t_41[key_42] then
                local t_54 = {
                    ZIndex = t_6.GiverZIndex,
                    Hover = `{val_35.DisplayName}\nQuest: {val_35.Quest:GetAttribute("Quest") or ""}`,
                    Category = "QuestGivers"
                }
                local v264, v265 = t_15.addMarker(function() -- line: 2062
                    -- upvalues:
                    --  [1] val_35 (copy)

                    local v261 = val_35
                    local v262 = v261.Instance or v261.LastInstance

                    if v262 and v262:GetAttribute("MapHidden") then
                        return nil
                    end

                    v262 = v261.Instance

                    if v262 and v262.Parent then
                        v261.CFrame = v262:GetPivot()
                    end

                    return v261.CFrame
                end, QuestMarker, t_54)
                t_41[key_42] = { remove = v264, gui = v265 }
                refreshGiverTint(key_42)
            end
        end
    end

    local v266 = Services_m.Maid.new()
    v2:GiveTask(v266)

    local function rebuildObjectives() -- line: 2078
        -- upvalues:
        --  [1] v266 (copy)
        --  [2] Quests_1 (copy)
        --  [3] rebuildObjectives (copy)
        --  [4] QuestProgress_m (ref)
        --  [5] t_15 (ref)
        --  [6] ObjectiveMarker (ref)
        --  [7] t_6 (ref)
        --  [8] tintMarker (copy)
        --  [9] ObjectTracker_m (ref)

        v266:Destroy()
        local Tracking = Quests_1:GetAttribute("Tracking")
        local v267 = Tracking

        if v267 then
            v267 = Quests_1:FindFirstChild(Tracking)
        end

        if not v267 then
            return
        end

        local Tasks = v267:FindFirstChild("Tasks")

        if not Tasks then
            v266:GiveTask(v267.ChildAdded:Connect(function(child_4) -- line: 2089
                -- upvalues:
                --  [1] rebuildObjectives (ref)

                if child_4.Name == "Tasks" then
                    rebuildObjectives()
                end
            end))

            return
        end

        v266:GiveTask(Tasks.ChildAdded:Connect(rebuildObjectives))
        v266:GiveTask(Tasks.ChildRemoved:Connect(rebuildObjectives))

        local _ = function(u31: userdata) --[[ isActive ]] -- line: 2100
            -- upvalues:
            --  [1] v267 (copy)
            --  [2] QuestProgress_m (ref)

            local v271 = not v267:GetAttribute("Completed")

            if v271 then
                v271 = not u31:GetAttribute("Hidden")

                if v271 then
                    v271 = not QuestProgress_m.isDone(u31)
                end
            end

            return v271
        end

        for _, child_3 in Tasks:GetChildren() do
            local Name_4 = child_3.Name
            local v274, v275 = t_15.addMarker(
                function() -- line: 2109
                    -- upvalues:
                    --  [1] child_3 (copy)
                    --  [2] v267 (copy)
                    --  [3] QuestProgress_m (ref)

                    local v272 = child_3
                    local v273 = not v267:GetAttribute("Completed")

                    if v273 then
                        v273 = not v272:GetAttribute("Hidden")

                        if v273 then
                            v273 = not QuestProgress_m.isDone(v272)
                        end
                    end

                    if not v273 then
                        return nil
                    end

                    local TrackPosition = child_3:GetAttribute("TrackPosition")

                    if typeof(TrackPosition) ~= "Vector3" or TrackPosition == Vector3.new(0, 0, 0) then
                        return nil
                    end

                    return TrackPosition
                end,
                ObjectiveMarker,
                {
                    ZIndex = t_6.ObjectiveZIndex,
                    Hover = Name_4,
                    AlwaysVisible = true,
                    Category = "Objectives"
                }
            )
            tintMarker(v275, t_6.Colors.Objective)
            v266:GiveTask(v274)

            if child_3:HasTag("TrackClosest") then
                local v276 = Tracking .. "/" .. Name_4
                local v282, v283 = t_15.addMarker(
                    function() -- line: 2129
                        -- upvalues:
                        --  [1] child_3 (copy)
                        --  [2] v267 (copy)
                        --  [3] QuestProgress_m (ref)
                        --  [4] ObjectTracker_m (ref)
                        --  [5] v276 (copy)

                        local v277 = child_3
                        local v278 = not v267:GetAttribute("Completed")

                        if v278 then
                            v278 = not v277:GetAttribute("Hidden")

                            if v278 then
                                v278 = not QuestProgress_m.isDone(v277)
                            end
                        end

                        if not v278 then
                            return nil
                        end

                        local v279 = ObjectTracker_m.GetClosest(v276)
                        local v280 = v279 and ObjectTracker_m.GetAnchor(v279)

                        return v280 and v280.CFrame
                    end,
                    ObjectiveMarker,
                    {
                        ZIndex = t_6.ObjectiveZIndex,
                        Hover = Name_4,
                        AlwaysVisible = true,
                        Category = "Objectives"
                    }
                )
                tintMarker(v283, t_6.Colors.Objective)
                v266:GiveTask(v282)
            end
        end

        local t_58 = {
            ZIndex = t_6.ObjectiveZIndex,
            Hover = `Return to {v267:GetAttribute("ReturnNPC") or Tracking}`,
            AlwaysVisible = true,
            Category = "Objectives"
        }
        local v285, v286 = t_15.addMarker(function() -- line: 2148
            -- upvalues:
            --  [1] v267 (copy)
            --  [2] Tasks (copy)
            --  [3] QuestProgress_m (ref)

            if v267:GetAttribute("Completed") then
                return nil
            end

            local children = Tasks:GetChildren()

            if #children == 0 then
                return nil
            end

            for _, val_36 in children do
                if not QuestProgress_m.isDone(val_36) then
                    return nil
                end
            end

            return v267:GetAttribute("ReturnPosition")
        end, ObjectiveMarker, t_58)
        tintMarker(v286, t_6.Colors.Return)
        v266:GiveTask(v285)
    end

    local t_59 = {}

    local function paintFilterButton(u32: userdata, s18: string) -- line: 2174
        -- upvalues:
        --  [1] t_15 (ref)
        --  [2] t_11 (ref)

        local v287 = t_15.getFilter(s18)
        u32:SetAttribute(t_11.EnabledAttribute, v287)
        local v288 = u32:FindFirstChild(t_11.IndicatorName, true)

        if v288 and v288:IsA("GuiObject") then
            v288.Visible = v287

            return
        end

        v288 = if not v287 then t_11.DisabledTransparency else 0

        if u32:IsA("ImageButton") then
            u32.ImageTransparency = v288

            return
        end

        if u32:IsA("TextButton") then
            u32.TextTransparency = v288
        end
    end

    local _ = function() --[[ refreshFilterButtons ]] -- line: 2192
        -- upvalues:
        --  [1] t_59 (copy)
        --  [2] paintFilterButton (copy)

        for key_45, val_37 in t_59 do
            paintFilterButton(key_45, val_37)
        end
    end

    function t_15.bindFilterButton(u33: userdata, s19: string) -- line: 2198
        -- upvalues:
        --  [1] t_59 (copy)
        --  [2] v2 (ref)
        --  [3] paintFilterButton (copy)

        t_59[u33] = s19
        local v289 = u33.Activated:Connect(function() -- line: 2201
        end)

        local function unbind() -- line: 2205
            -- upvalues:
            --  [1] v289 (copy)
            --  [2] t_59 (ref)
            --  [3] u33 (copy)

            v289:Disconnect()
            t_59[u33] = nil
        end

        v2:GiveTask(unbind)
        paintFilterButton(u33, s19)

        return unbind
    end

    local function onQuestDataChanged(u34: userdata) -- line: 2215
        -- upvalues:
        --  [1] refreshGiverTint (copy)
        --  [2] Quests_1 (copy)
        --  [3] rebuildObjectives (copy)

        refreshGiverTint(u34.Name)

        if u34.Name == Quests_1:GetAttribute("Tracking") then
            rebuildObjectives()
        end
    end

    v2:GiveTask(Quests_1.ChildAdded:Connect(onQuestDataChanged))
    v2:GiveTask(Quests_1.ChildRemoved:Connect(onQuestDataChanged))
    v2:GiveTask(Quests_1:GetAttributeChangedSignal("Tracking"):Connect(rebuildObjectives))
    v2:GiveTask(function() -- line: 2226
        -- upvalues:
        --  [1] t_39 (copy)
        --  [2] v135 (copy)
        --  [3] v138 (ref)
        --  [4] BackpackUtils_m (copy)
        --  [5] t_40 (copy)
        --  [6] t_41 (copy)
        --  [7] t_51 (copy)

        for _, val_38 in t_39 do
            local Gui_7 = val_38.gui

            if v135.Parent == Gui_7 then
                v135.Parent = script
            end

            if v138 and (Gui_7 == nil or Gui_7 == v138) then
                v138 = nil
                BackpackUtils_m:HideHover()
            end

            val_38.gui:Destroy()
        end

        table.clear(t_39)
        table.clear(t_40)
        table.clear(t_41)
        table.clear(t_51)
    end)
    updateTracking()

    if recomputeBaseSize() then
        t_36.pos = u13.AbsoluteSize / 2 - Vector2.new(0.5, 0.5) * (t_36.baseSize * t_36.zoom)
        t_36.pos = clampPos(t_36.pos)
        local v293 = t_36.baseSize * t_36.zoom
        MapImage.Size = UDim2.fromOffset(v293.X, v293.Y)
        MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
    end

    local vec2_6
    t_36.following, vec2_6 = true, followPlayer
    local v294 = vec2_6()
    local Character_8 = LocalPlayer.Character
    local v295 = Character_8

    if v295 then
        v295 = Character_8:FindFirstChild("HumanoidRootPart")
    end

    local v296 = v295 and v295.CFrame
    local v297 = v296 and v296.Position

    if v294 and v297 then
        u13:SetAttribute("FocusPoint", v297)
    end

    v2:GiveTask(LocalPlayer.CharacterAdded:Connect(function() -- line: 2244
        -- upvalues:
        --  [1] t_36 (copy)

        t_36.following = true
    end))
    setHeader(v36)
    refreshTiles(true)
    t_15.addMarker(
        getRootCFrame,
        PlayerMarker,
        { Rotate = true, ZIndex = 11, Hover = "You", AlwaysVisible = true }
    )
    local v299 = ReplicatedStorage.Remotes:FindFirstChild(t_13.RemoteName)

    if v299 and PlayerMarker then
        local v300 = PlayerMarker:Clone()
        local Vision = v300:FindFirstChild("Vision")

        if Vision then
            Vision:Destroy()
        end

        v300.BackgroundColor3 = t_13.Color
        v300.Size = UDim2.fromOffset(t_13.Size, t_13.Size)
        v2:GiveTask(v300)
        local t_60 = {}

        local _ = function(u35: userdata) --[[ memberName ]] -- line: 2272
            local CustomizeFolder = u35:FindFirstChild("CustomizeFolder")
            local v301 = CustomizeFolder

            if v301 then
                v301 = CustomizeFolder:FindFirstChild("CharacterName")
            end

            if v301 and (v301:IsA("StringValue") and v301.Value ~= "") then
                return v301.Value
            end

            return u35.DisplayName
        end

        local _ = function(n5: number) --[[ removeGuildMarker ]] -- line: 2281
            -- upvalues:
            --  [1] t_60 (copy)

            local v302 = t_60[n5]

            if v302 then
                v302.remove()
                t_60[n5] = nil
            end
        end

        v2:GiveTask(v299.OnClientEvent:Connect(function(arguments) -- line: 2289
            -- upvalues:
            --  [1] Players (ref)
            --  [2] LocalPlayer (ref)
            --  [3] t_60 (copy)
            --  [4] t_15 (ref)
            --  [5] v300 (copy)
            --  [6] t_13 (ref)

            if typeof(arguments) ~= "table" then
                return
            end

            local t_61 = {}
            local v307

            for _, val_39 in arguments do
                local v303 = val_39[1]
                local v304 = val_39[2]
                local v305 = val_39[3]
                local v306 = val_39[4]
                v307 = false

                if typeof(v303) == "number" then
                    v307 = Players:GetPlayerByUserId(v303)
                end

                if v307 and v307 ~= LocalPlayer and typeof(v304) == "number" then
                    t_61[v303] = true
                    local v308 = t_60[v303]

                    if v308 then
                        v308.position = CFrame.new(v304, v305, v306)
                    else
                        local t_63 = { position = CFrame.new(v304, v305, v306) }
                        local t_62 = {
                            ZIndex = t_13.ZIndex,
                            Hover = nil,
                            AlwaysVisible = nil,
                            Category = nil
                        }
                        local AddMarker_2 = t_15.addMarker
                        local v311 = v300
                        local CustomizeFolder_1 = v307:FindFirstChild("CustomizeFolder")
                        local v312 = CustomizeFolder_1

                        if v312 then
                            v312 = CustomizeFolder_1:FindFirstChild("CharacterName")
                        end

                        t_62.Hover = if v312 then if v312:IsA("StringValue") and v312.Value ~= "" then v312.Value else v307.DisplayName else v307.DisplayName
                        t_62.AlwaysVisible = t_13.AlwaysVisible
                        t_62.Category = t_13.Category
                        t_63.remove = AddMarker_2(function() -- line: 2308
                            -- upvalues:
                            --  [1] v307 (copy)
                            --  [2] t_63 (copy)

                            local Character_9 = v307.Character
                            local v310 = Character_9

                            if v310 then
                                v310 = Character_9:FindFirstChild("HumanoidRootPart")
                            end

                            if v310 then
                                return v310.CFrame
                            end

                            return t_63.position
                        end, v311, t_62)
                        t_60[v303] = t_63
                    end
                end
            end

            for key_48 in t_60 do
                if not t_61[key_48] then
                    local v314 = t_60[key_48]

                    if v314 then
                        v314.remove()
                        t_60[key_48] = nil
                    end
                end
            end
        end))
        v2:GiveTask(Players.PlayerRemoving:Connect(function(arg14) -- line: 2329
            -- upvalues:
            --  [1] t_60 (copy)

            local UserId = arg14.UserId
            local v316 = t_60[UserId]

            if v316 then
                v316.remove()
                t_60[UserId] = nil
            end
        end))
        v2:GiveTask(function() -- line: 2333
            -- upvalues:
            --  [1] t_60 (copy)

            for key_49 in t_60 do
                local v318 = t_60[key_49]

                if v318 then
                    v318.remove()
                    t_60[key_49] = nil
                end
            end
        end)
    end

    local _, v320 = t_15.addMarker(
        function() -- line: 2340
            -- upvalues:
            --  [1] v31 (ref)

            return v31
        end,
        WaypointMarker,
        { ZIndex = t_12.ZIndex, Hover = "Waypoint", AlwaysVisible = true }
    )
    tintMarker(v320, t_12.Color)
    local t_64 = {}

    local function syncDeathMarkers() -- line: 2352
        -- upvalues:
        --  [1] t_64 (copy)
        --  [2] t_23 (ref)
        --  [3] DeathMarker (ref)
        --  [4] t_15 (ref)

        for key_50, val_40 in t_64 do
            local v321 = t_23[key_50]

            if not v321 or v321.position ~= val_40.position then
                val_40.remove()
                t_64[key_50] = nil
            end
        end

        if not DeathMarker then
            return
        end

        for key_51, val_41 in t_23 do
            if not t_64[key_51] then
                local t_65 = {
                    remove = t_15.addMarker(
                        val_41.position,
                        DeathMarker,
                        {
                            ZIndex = 12,
                            Hover = "Your loot bag",
                            AlwaysVisible = true,
                            Category = "DeathMarker"
                        }
                    ),
                    position = val_41.position
                }
                t_64[key_51] = t_65
            end
        end
    end

    v35 = syncDeathMarkers
    v2:GiveTask(function() -- line: 2379
        -- upvalues:
        --  [1] v35 (ref)
        --  [2] syncDeathMarkers (copy)

        if v35 == syncDeathMarkers then
            v35 = nil
        end
    end)
    syncDeathMarkers()

    local function onWaypointAdded(u36: userdata) -- line: 2388
        -- upvalues:
        --  [1] t_15 (ref)
        --  [2] PortalMarker (ref)

        t_15.addMarker(
            u36:GetPivot(),
            PortalMarker,
            { ZIndex = 1, Hover = "Waypoint Gate", Category = "WaypointGates" }
        )
    end

    CollectionService:GetInstanceAddedSignal("Waypoint"):Connect(onWaypointAdded)

    for _, val_42 in CollectionService:GetTagged("Waypoint") do
        t_15.addMarker(
            val_42:GetPivot(),
            PortalMarker,
            { ZIndex = 1, Hover = "Waypoint Gate", Category = "WaypointGates" }
        )
    end

    local _ = function(u37: Vector2) --[[ isOnWaypoint ]] -- line: 2401
        -- upvalues:
        --  [1] v31 (ref)
        --  [2] v320 (copy)
        --  [3] t_12 (ref)

        if not v31 or not v320.Visible then
            return false
        end

        local v322 = v320.AbsolutePosition + v320.AbsoluteSize / 2

        return math.max(t_12.RemoveRadius, v320.AbsoluteSize.X / 2, v320.AbsoluteSize.Y / 2) >= (u37 - v322).Magnitude and true
    end

    local _ = function(u38: Vector2) --[[ onMapClicked ]] -- line: 2410
        -- upvalues:
        --  [1] v31 (ref)
        --  [2] v320 (copy)
        --  [3] t_12 (ref)
        --  [4] setWaypoint (ref)
        --  [5] t_15 (ref)

        local v325

        if not v31 or not v320.Visible then
            v325 = false
        else
            local v326 = v320.AbsolutePosition + v320.AbsoluteSize / 2
            v325 = math.max(t_12.RemoveRadius, v320.AbsoluteSize.X / 2, v320.AbsoluteSize.Y / 2) >= (u38 - v326).Magnitude and true
        end

        if v325 then
            setWaypoint(nil)

            return
        end

        local v328 = t_15.guiToWorld(u38)

        if v328 then
            setWaypoint(v328)
        end
    end

    syncLocationMarkers()
    syncGiverMarkers()
    syncPointMarkers()
    rebuildObjectives()
    local t_66 = {
        regionChanged = nil,
        discoveryChanged = nil,
        locationsChanged = nil,
        questGiversChanged = nil,
        filtersChanged = nil,
        pointsChanged = nil,
        raidsChanged = nil
    }

    function t_66.regionChanged(t14: table?) -- line: 2428
        -- upvalues:
        --  [1] setHeader (copy)

        setHeader(t14)
    end

    function t_66.discoveryChanged() -- line: 2431
        -- upvalues:
        --  [1] refreshTiles (copy)
        --  [2] refreshLocationLabels (copy)
        --  [3] t_39 (copy)
        --  [4] updateMarker (copy)

        refreshTiles(false)
        refreshLocationLabels()

        for _, val_43 in t_39 do
            updateMarker(val_43)
        end
    end

    function t_66.locationsChanged() -- line: 2436
        -- upvalues:
        --  [1] syncLocationMarkers (copy)

        syncLocationMarkers()
    end

    function t_66.questGiversChanged() -- line: 2439
        -- upvalues:
        --  [1] syncGiverMarkers (copy)

        syncGiverMarkers()
    end

    function t_66.filtersChanged() -- line: 2442
        -- upvalues:
        --  [1] t_39 (copy)
        --  [2] updateMarker (copy)
        --  [3] t_59 (copy)
        --  [4] paintFilterButton (copy)

        for _, val_44 in t_39 do
            updateMarker(val_44)
        end

        for key_55, val_45 in t_59 do
            paintFilterButton(key_55, val_45)
        end
    end

    function t_66.pointsChanged() -- line: 2446
        -- upvalues:
        --  [1] syncPointMarkers (copy)

        syncPointMarkers()
    end

    function t_66.raidsChanged() -- line: 2449
        -- upvalues:
        --  [1] refreshRaids (copy)

        refreshRaids()
    end

    v38 = t_66
    v2:GiveTask(function() -- line: 2455
        -- upvalues:
        --  [1] v38 (ref)
        --  [2] t_66 (copy)

        if v38 == t_66 then
            v38 = nil
        end
    end)

    if u14 then
        local t_67 = { SliderData = nil, Axis = "X" }
        local t_68 = { Start = 0, End = 1000, Increment = 1, DefaultValue = nil }
        local New_9 = Slider_m.new
        t_68.DefaultValue = math.log(t_36.zoom / t.Min) / math.log(t.Max / t.Min) * 1000
        t_67.SliderData = t_68
        v144 = New_9(u14, t_67)
        v2:GiveTask(v144)
        v145 = v144:GetValue()
        v144.Changed:Connect(function(n6: number) -- line: 2476
            -- upvalues:
            --  [1] v146 (ref)
            --  [2] v145 (ref)
            --  [3] t (ref)
            --  [4] u13 (copy)
            --  [5] t_36 (copy)
            --  [6] clampPos (copy)
            --  [7] MapImage (copy)

            if v146 or n6 == v145 then
                return
            end

            v145 = n6
            local v330 = t.Max / t.Min
            local Min = t.Min
            local v331 = u13.AbsoluteSize / 2
            local v332 = math.clamp(Min * v330 ^ math.clamp(n6 / 1000, 0, 1), t.Min, t.Max)

            if v332 == t_36.zoom then
                return
            end

            local v333 = (v331 - t_36.pos) / (t_36.baseSize * t_36.zoom)
            t_36.zoom = v332
            t_36.pos = v331 - v333 * (t_36.baseSize * t_36.zoom)
            t_36.pos = clampPos(t_36.pos)
            local v335 = t_36.baseSize * t_36.zoom
            MapImage.Size = UDim2.fromOffset(v335.X, v335.Y)
            MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
        end)
        v144:Track()
    end

    local function endDrag() -- line: 2487
        -- upvalues:
        --  [1] t_37 (copy)

        t_37.input = nil
        t_37.start = nil
        t_37.last = nil
        t_37.moved = false
    end

    v2:GiveTask(MapImage.InputBegan:Connect(function(input: userdata) -- line: 2494
        -- upvalues:
        --  [1] t_37 (copy)

        if t_37.input then
            return
        end

        local UserInputType = input.UserInputType

        if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch then
            local vec2_7 = Vector2.new(input.Position.X, input.Position.Y)
            t_37.input = input
            t_37.start = vec2_7
            t_37.last = vec2_7
            t_37.moved = false
        end
    end))
    v2:GiveTask(UserInputService.InputChanged:Connect(function(input_1: userdata) -- line: 2508
        -- upvalues:
        --  [1] t_37 (copy)
        --  [2] t_12 (ref)
        --  [3] t_36 (copy)
        --  [4] clampPos (copy)
        --  [5] MapImage (copy)

        if not t_37.input then
            return
        end

        local v339 = if t_37.input.UserInputType ~= Enum.UserInputType.MouseButton1 then false else input_1.UserInputType == Enum.UserInputType.MouseMovement
        local v340 = if t_37.input.UserInputType ~= Enum.UserInputType.Touch then false else input_1 == t_37.input

        if not v339 and not v340 then
            return
        end

        v340 = Vector2.new(input_1.Position.X, input_1.Position.Y)

        if not t_37.moved then
            if (v340 - t_37.start).Magnitude < t_12.ClickThreshold then
                return
            end

            t_37.moved = true
        end

        v339 = v340 - t_37.last
        t_37.last = v340

        if v339 == Vector2.zero then
            return
        end

        t_36.following = false
        local v341 = t_36
        v341.pos += v339
        t_36.pos = clampPos(t_36.pos)
        local v343 = t_36.baseSize * t_36.zoom
        MapImage.Size = UDim2.fromOffset(v343.X, v343.Y)
        MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
    end))
    v2:GiveTask(UserInputService.InputEnded:Connect(function(input_2: userdata) -- line: 2543
        -- upvalues:
        --  [1] t_37 (copy)
        --  [2] v136 (copy)
        --  [3] GuiService (ref)
        --  [4] v31 (ref)
        --  [5] v320 (copy)
        --  [6] t_12 (ref)
        --  [7] setWaypoint (ref)
        --  [8] t_15 (ref)

        if not t_37.input then
            return
        end

        if not (if input_2.UserInputType ~= Enum.UserInputType.MouseButton1 then false else t_37.input.UserInputType == Enum.UserInputType.MouseButton1) and input_2 ~= t_37.input then
            return
        end

        local v348 = not t_37.moved
        t_37.input = nil
        t_37.start = nil
        t_37.last = nil
        t_37.moved = false

        if v348 then
            local vec2_8 = Vector2.new(input_2.Position.X, input_2.Position.Y)

            if v136 and v136.IgnoreGuiInset then
                vec2_8 += GuiService:GetGuiInset()
            end

            local v349

            if not v31 or not v320.Visible then
                v349 = false
            else
                local v350 = v320.AbsolutePosition + v320.AbsoluteSize / 2
                v349 = math.max(t_12.RemoveRadius, v320.AbsoluteSize.X / 2, v320.AbsoluteSize.Y / 2) >= (vec2_8 - v350).Magnitude and true
            end

            if v349 then
                setWaypoint(nil)

                return
            end

            local v352 = t_15.guiToWorld(vec2_8)

            if v352 then
                setWaypoint(v352)
            end
        end
    end))
    v2:GiveTask(UserInputService.WindowFocusReleased:Connect(endDrag))
    v2:GiveTask(endDrag)
    v2:GiveTask(u13.InputChanged:Connect(function(input_3: userdata) -- line: 2565
        -- upvalues:
        --  [1] t_36 (copy)
        --  [2] UserInputService (ref)
        --  [3] v136 (copy)
        --  [4] GuiService (ref)
        --  [5] u13 (copy)
        --  [6] t (ref)
        --  [7] clampPos (copy)
        --  [8] MapImage (copy)
        --  [9] v144 (ref)
        --  [10] v146 (ref)
        --  [11] t_2 (ref)
        --  [12] v145 (ref)

        if input_3.UserInputType ~= Enum.UserInputType.MouseWheel then
            return
        end

        t_36.following = false
        local v355 = UserInputService:GetMouseLocation()

        if v136 and not v136.IgnoreGuiInset then
            v355 -= GuiService:GetGuiInset()
        end

        local v356 = v355 - u13.AbsolutePosition
        local v357 = math.clamp(t_36.zoom * 1.15 ^ input_3.Position.Z, t.Min, t.Max)

        if v357 == t_36.zoom then
            return
        end

        local v358 = (v356 - t_36.pos) / (t_36.baseSize * t_36.zoom)
        t_36.zoom = v357
        t_36.pos = v356 - v358 * (t_36.baseSize * t_36.zoom)
        t_36.pos = clampPos(t_36.pos)
        local v360 = t_36.baseSize * t_36.zoom
        MapImage.Size = UDim2.fromOffset(v360.X, v360.Y)
        MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)

        if v144 then
            if v144.IsHeld then
                return
            end

            v146 = true
            v144:OverrideValue(math.log(t_36.zoom / t.Min) / math.log(t.Max / t.Min) * t_2.Steps)
            v146 = false
            v145 = v144:GetValue()
        end
    end))
    GuiService.SelectedObject = nil

    local function isMapShowing() -- line: 2579
        -- upvalues:
        --  [1] u13 (copy)

        local v367 = u13

        while v367 do
            if v367:IsA("GuiObject") and not v367.Visible then
                return false
            end

            if v367:IsA("LayerCollector") and not v367.Enabled then
                return false
            end

            v367 = v367.Parent
        end

        return true
    end

    ContextActionService:BindActionAtPriority(
        "MapPan",
        function(_, arg16, arg17) -- line: 2593
            -- upvalues:
            --  [1] isMapShowing (copy)
            --  [2] t_38 (copy)

            if not isMapShowing() then
                t_38.stick = Vector2.zero

                return Enum.ContextActionResult.Pass
            end

            if arg16 == Enum.UserInputState.End or arg16 == Enum.UserInputState.Cancel then
                t_38.stick = Vector2.zero
            else
                t_38.stick = Vector2.new(arg17.Position.X, arg17.Position.Y)
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        Enum.ContextActionPriority.High.Value,
        Enum.KeyCode.Thumbstick1
    )
    ContextActionService:BindActionAtPriority(
        "MapZoomIn",
        function(_, arg19, arg20) -- line: 2607
            -- upvalues:
            --  [1] isMapShowing (copy)
            --  [2] t_38 (copy)

            if not isMapShowing() then
                t_38.zoomIn = 0

                return Enum.ContextActionResult.Pass
            end

            if arg19 == Enum.UserInputState.End or arg19 == Enum.UserInputState.Cancel then
                t_38.zoomIn = 0
            else
                t_38.zoomIn = arg20.Position.Z
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        Enum.ContextActionPriority.High.Value,
        Enum.KeyCode.ButtonR2
    )
    ContextActionService:BindActionAtPriority(
        "MapZoomOut",
        function(_, arg22, arg23) -- line: 2621
            -- upvalues:
            --  [1] isMapShowing (copy)
            --  [2] t_38 (copy)

            if not isMapShowing() then
                t_38.zoomOut = 0

                return Enum.ContextActionResult.Pass
            end

            if arg22 == Enum.UserInputState.End or arg22 == Enum.UserInputState.Cancel then
                t_38.zoomOut = 0
            else
                t_38.zoomOut = arg23.Position.Z
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        Enum.ContextActionPriority.High.Value,
        Enum.KeyCode.ButtonL2
    )
    v2:GiveTask(function() -- line: 2635
        -- upvalues:
        --  [1] ContextActionService (ref)

        ContextActionService:UnbindAction("MapPan")
        ContextActionService:UnbindAction("MapZoomIn")
        ContextActionService:UnbindAction("MapZoomOut")
    end)
    v2:GiveTask(RunService.RenderStepped:Connect(function(deltaTime) -- line: 2641
        -- upvalues:
        --  [1] t_38 (copy)
        --  [2] t_1 (ref)
        --  [3] t_36 (copy)
        --  [4] u13 (copy)
        --  [5] t (ref)
        --  [6] clampPos (copy)
        --  [7] MapImage (copy)
        --  [8] v144 (ref)
        --  [9] v146 (ref)
        --  [10] t_2 (ref)
        --  [11] v145 (ref)
        --  [12] followPlayer (copy)
        --  [13] t_39 (copy)
        --  [14] updateMarker (copy)
        --  [15] v138 (ref)
        --  [16] isMapShowing (copy)
        --  [17] BackpackUtils_m (copy)

        local v369 = false
        local Stick = t_38.stick
        local Magnitude_1 = Stick.Magnitude
        local v370 = if Magnitude_1 < t_1.Deadzone then Vector2.zero else Stick.Unit * math.min(
            (Magnitude_1 - t_1.Deadzone) / (1 - t_1.Deadzone),
            1
        )

        if v370 ~= Vector2.zero then
            t_36.following = false
            local v372 = u13.AbsoluteSize.Y * 1.2
            local v373 = t_36
            v373.pos = v373.pos + Vector2.new(-v370.X, v370.Y) * v372 * deltaTime
            v369 = true
        end

        v370 = t_38.zoomIn - t_38.zoomOut

        if math.abs(v370) > 0.05 then
            local Zoom = t_36.zoom
            local v374 = u13.AbsoluteSize / 2
            local v375 = math.clamp(Zoom * math.exp(v370 * 1.5 * deltaTime), t.Min, t.Max)

            if v375 ~= t_36.zoom then
                local v376 = (v374 - t_36.pos) / (t_36.baseSize * t_36.zoom)
                t_36.zoom = v375
                t_36.pos = v374 - v376 * (t_36.baseSize * t_36.zoom)
                t_36.pos = clampPos(t_36.pos)
                local v378 = t_36.baseSize * t_36.zoom
                MapImage.Size = UDim2.fromOffset(v378.X, v378.Y)
                MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)

                if v144 and not v144.IsHeld then
                    v146 = true
                    v144:OverrideValue(
                        math.log(t_36.zoom / t.Min) / math.log(t.Max / t.Min) * t_2.Steps
                    )
                    v146 = false
                    v145 = v144:GetValue()
                end
            end
        end

        if t_36.following then
            followPlayer()
        elseif v369 then
            t_36.pos = clampPos(t_36.pos)
            local v385 = t_36.baseSize * t_36.zoom
            MapImage.Size = UDim2.fromOffset(v385.X, v385.Y)
            MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
        end

        for _, val_46 in t_39 do
            updateMarker(val_46)
        end

        if v138 then
            if v138.Visible then
                if v138.Parent then
                    if not isMapShowing() and v138 then
                        v138 = nil
                        BackpackUtils_m:HideHover()

                        return
                    end
                elseif v138 then
                    v138 = nil
                    BackpackUtils_m:HideHover()

                    return
                end
            elseif v138 then
                v138 = nil
                BackpackUtils_m:HideHover()

                return
            end
        end
    end))
    v2:GiveTask(u13:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 2674
        -- upvalues:
        --  [1] u13 (copy)
        --  [2] t_36 (copy)
        --  [3] followPlayer (copy)
        --  [4] recomputeBaseSize (copy)
        --  [5] clampPos (copy)
        --  [6] MapImage (copy)

        local AbsoluteSize_5 = u13.AbsoluteSize

        if not (AbsoluteSize_5.X > 0 and AbsoluteSize_5.Y > 0) then
            return
        end

        if t_36.following and followPlayer() then
            return
        end

        if not t_36.laidOut then
            if recomputeBaseSize() then
                t_36.pos = u13.AbsoluteSize / 2 - Vector2.new(0.5, 0.5) * (t_36.baseSize * t_36.zoom)
                t_36.pos = clampPos(t_36.pos)
                local v392 = t_36.baseSize * t_36.zoom
                MapImage.Size = UDim2.fromOffset(v392.X, v392.Y)
                MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
            end

            return
        end

        local v395 = (u13.AbsoluteSize / 2 - t_36.pos) / (t_36.baseSize * t_36.zoom)
        recomputeBaseSize()
        t_36.pos = u13.AbsoluteSize / 2 - v395 * (t_36.baseSize * t_36.zoom)
        t_36.pos = clampPos(t_36.pos)
        local v397 = t_36.baseSize * t_36.zoom
        MapImage.Size = UDim2.fromOffset(v397.X, v397.Y)
        MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)
    end))

    function t_15.setZoom(n7: number) -- line: 2695
        -- upvalues:
        --  [1] u13 (copy)
        --  [2] t (ref)
        --  [3] t_36 (copy)
        --  [4] clampPos (copy)
        --  [5] MapImage (copy)
        --  [6] v144 (ref)
        --  [7] v146 (ref)
        --  [8] t_2 (ref)
        --  [9] v145 (ref)

        local v400 = u13.AbsoluteSize / 2
        local v401 = math.clamp(n7, t.Min, t.Max)

        if v401 == t_36.zoom then
            return
        end

        local v402 = (v400 - t_36.pos) / (t_36.baseSize * t_36.zoom)
        t_36.zoom = v401
        t_36.pos = v400 - v402 * (t_36.baseSize * t_36.zoom)
        t_36.pos = clampPos(t_36.pos)
        local v404 = t_36.baseSize * t_36.zoom
        MapImage.Size = UDim2.fromOffset(v404.X, v404.Y)
        MapImage.Position = UDim2.fromOffset(t_36.pos.X, t_36.pos.Y)

        if v144 then
            if v144.IsHeld then
                return
            end

            v146 = true
            v144:OverrideValue(math.log(t_36.zoom / t.Min) / math.log(t.Max / t.Min) * t_2.Steps)
            v146 = false
            v145 = v144:GetValue()
        end
    end

    function t_15.getZoom() -- line: 2698
        -- upvalues:
        --  [1] t_36 (copy)

        return t_36.zoom
    end
end

function t_15.cleanup() -- line: 2703
    -- upvalues:
    --  [1] v2 (ref)

    if v2 then
        v2:Destroy()
        v2 = nil
    end
end

return t_15
