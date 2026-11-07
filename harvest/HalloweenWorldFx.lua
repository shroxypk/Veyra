-- Decompiled with Veyra harvester
-- Instance: StarterGui.HalloweenUI.HalloweenWorldFx
-- Class: LocalScript
-- bytes: 23625

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HalloweenWorld = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("HalloweenWorld")
local color = Color3.fromRGB(255, 160, 60)
local font = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Bold)

local _ = function() --[[ candyIcon ]] -- line: 36
    -- upvalues:
    --  [1] PlayerGui (copy)

    local v1 = PlayerGui:FindFirstChild("CurrencyUI")
    local v2 = v1

    if v2 then
        v2 = v1:FindFirstChild("CandyCorn", true)
    end

    v1 = v2

    if v1 then
        v1 = v2:FindFirstChildWhichIsA("ImageLabel", true)
    end

    return if not v1 then nil else if v1.Image == "" then nil else v1.Image or nil
end

local function candyPopup(vec1: Vector3, n1: number) -- line: 43
    -- upvalues:
    --  [1] PlayerGui (copy)
    --  [2] font (copy)
    --  [3] color (copy)
    --  [4] TweenService (copy)
    --  [5] Debris (copy)
    --  [6] ReplicatedStorage (copy)

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera and (CurrentCamera.CFrame.Position - vec1).Magnitude > 250 then
        return
    end

    local CandyPopup_Part = Instance.new("Part")
    CandyPopup_Part.Name = "CandyPopup"
    CandyPopup_Part.Size = Vector3.new(0.2, 0.2, 0.2)
    CandyPopup_Part.Transparency = 1
    CandyPopup_Part.Anchored = true
    CandyPopup_Part.CanCollide = false
    CandyPopup_Part.CanQuery = false
    CandyPopup_Part.CanTouch = false
    CandyPopup_Part.CFrame = CFrame.new(vec1 + Vector3.new(0, 3, 0))
    CandyPopup_Part.Parent = workspace.CurrentCamera
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Size = UDim2.fromOffset(220, 40)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.LightInfluence = 0
    BillboardGui.Adornee = CandyPopup_Part
    BillboardGui.Parent = CandyPopup_Part
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.Parent = BillboardGui
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.Parent = Frame
    local t = {}
    local v4 = PlayerGui:FindFirstChild("CurrencyUI")
    local v5 = v4

    if v5 then
        v5 = v4:FindFirstChild("CandyCorn", true)
    end

    v4 = v5

    if v4 then
        v4 = v5:FindFirstChildWhichIsA("ImageLabel", true)
    end

    local v6 = if not v4 then nil else if v4.Image == "" then nil else v4.Image or nil

    if v6 then
        v4 = Instance.new("ImageLabel")
        v4.BackgroundTransparency = 1
        v4.Size = UDim2.fromOffset(26, 26)
        v4.Image = v6
        v4.Parent = Frame
        table.insert(t, { v4, { ImageTransparency = 1 } })
    end

    v6 = Instance.new("TextLabel")
    v6.BackgroundTransparency = 1
    v6.AutomaticSize = Enum.AutomaticSize.X
    v6.Size = UDim2.fromOffset(0, 30)
    v6.FontFace = font
    v6.TextSize = 24
    v6.TextColor3 = color
    v6.Text = `+{n1} Candy Corn`
    v6.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(40, 15, 0)
    UIStroke.Thickness = 2
    UIStroke.Parent = v6
    table.insert(t, { v6, { TextTransparency = 1 } })
    table.insert(t, { UIStroke, { Transparency = 1 } })
    Frame.Size = UDim2.fromScale(0.6, 0.6)
    Frame.Position = UDim2.fromScale(0.2, 0.2)
    TweenService:Create(
        Frame,
        TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0, 0) }
    ):Play()
    TweenService:Create(
        BillboardGui,
        TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { StudsOffset = Vector3.new(0, 3.5, 0) }
    ):Play()
    task.delay(0.77, function() -- line: 115
        -- upvalues:
        --  [1] t (copy)
        --  [2] TweenService (ref)

        local tweenInfo_2 = TweenInfo.new(0.63, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

        for _, val in t do
            TweenService:Create(val[1], tweenInfo_2, val[2]):Play()
        end
    end)
    Debris:AddItem(CandyPopup_Part, 1.5)
    local SFX = ReplicatedStorage:FindFirstChild("SFX")
    v6 = SFX

    if v6 then
        v6 = SFX:FindFirstChild("Misc")

        if v6 then
            v6 = SFX.Misc:FindFirstChild("Coins")
        end
    end

    if v6 then
        local v9 = v6:Clone()
        v9.Volume *= 0.6
        v9.Parent = CandyPopup_Part
        v9:Play()
    end
end

local t_2 = {}

local function newMarker() -- line: 141
    -- upvalues:
    --  [1] PlayerGui (copy)
    --  [2] color (copy)

    local v10 = PlayerGui:FindFirstChild("BirdClient")
    local v11 = v10

    if v11 then
        v11 = v10:FindFirstChild("BirdClient")
    end

    v10 = v11

    if v10 then
        v10 = v11:FindFirstChild("NPCIndicator")
    end

    if v10 then
        v11 = v10:Clone()
        v11.Enabled = true

        return v11
    end

    v10 = Instance.new("BillboardGui")
    v10.Size = UDim2.fromOffset(26, 26)
    v10.StudsOffset = Vector3.new(0, 5, 0)
    v10.AlwaysOnTop = true
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.Text = "\226\150\188"
    TextLabel.TextScaled = true
    TextLabel.TextColor3 = color
    TextLabel.Parent = v10

    return v10
end

local t_3 = {}

local function attach(u1: userdata, s1: string) -- line: 164
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t_2 (copy)
    --  [3] newMarker (copy)

    if t_3[s1] then
        return
    end

    local v12 = u1:FindFirstChild("HumanoidRootPart") or u1.PrimaryPart

    if not v12 then
        return
    end

    t_2[s1] = nil
    local v13 = newMarker()
    v13.Name = "HauntingMarker"
    v13.Parent = v12
    t_3[s1] = v13
    u1.AncestryChanged:Connect(function(_, arg2) -- line: 177
        -- upvalues:
        --  [1] t_3 (ref)
        --  [2] s1 (copy)

        if not arg2 then
            t_3[s1] = nil
        end
    end)
end

local function findEnemy(s2: string) -- line: 184
    local FightableNPCS = workspace:FindFirstChild("FightableNPCS")

    for _, val_1 in FightableNPCS and FightableNPCS:GetChildren() or {} do
        if val_1:GetAttribute("HauntingId") == s2 then
            return val_1
        end
    end

    return nil
end

local function watch(u2: userdata) -- line: 194
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] attach (copy)

    if not u2:IsA("Model") then
        return
    end

    local function check() -- line: 198
        -- upvalues:
        --  [1] u2 (copy)
        --  [2] t_2 (ref)
        --  [3] attach (ref)

        local HauntingId = u2:GetAttribute("HauntingId")

        if HauntingId and t_2[HauntingId] then
            attach(u2, HauntingId)
        end
    end

    local HauntingId_1 = u2:GetAttribute("HauntingId")

    if HauntingId_1 and t_2[HauntingId_1] then
        attach(u2, HauntingId_1)
    end

    u2:GetAttributeChangedSignal("HauntingId"):Once(check)
end

task.spawn(function() -- line: 208
    -- upvalues:
    --  [1] watch (copy)

    workspace:WaitForChild("FightableNPCS").ChildAdded:Connect(watch)
end)
local color_1 = Color3.fromRGB(255, 150, 60)

local function markChest(u3: userdata) -- line: 219
    -- upvalues:
    --  [1] color_1 (copy)
    --  [2] font (copy)
    --  [3] TweenService (copy)

    local v15 = u3.PrimaryPart or u3:FindFirstChildWhichIsA("BasePart", true)
    local BillboardGui_1, Highlight, UIStroke_1

    if v15 then
        if u3:FindFirstChild("HauntingChestMarker") then
            return
        end

        Highlight = Instance.new("Highlight")
        Highlight.Name = "HauntingChestOutline"
        Highlight.FillTransparency = 1
        Highlight.OutlineColor = color_1
        Highlight.OutlineTransparency = 0
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.Adornee = u3
        Highlight.Parent = u3
        BillboardGui_1 = Instance.new("BillboardGui")
        BillboardGui_1.Name = "HauntingChestMarker"
        BillboardGui_1.Size = UDim2.fromOffset(160, 44)
        BillboardGui_1.StudsOffsetWorldSpace = Vector3.new(0, 4.5, 0)
        BillboardGui_1.AlwaysOnTop = true
        BillboardGui_1.LightInfluence = 0
        BillboardGui_1.Adornee = v15
        v15 = Instance.new("TextLabel")
        v15.BackgroundTransparency = 1
        v15.Size = UDim2.new(1, 0, 0, 20)
        v15.FontFace = font
        v15.TextSize = 18
        v15.TextColor3 = color_1
        v15.Text = "Your chest"
        v15.Parent = BillboardGui_1
        local v16 = v15:Clone()
        v16.Position = UDim2.fromOffset(0, 18)
        v16.TextSize = 20
        v16.Text = "\226\150\188"
        v16.Parent = BillboardGui_1

        for _, val_2 in { v15, v16 } do
            UIStroke_1 = Instance.new("UIStroke")
            UIStroke_1.Color = Color3.fromRGB(40, 15, 0)
            UIStroke_1.Thickness = 2
            UIStroke_1.Parent = val_2
        end

        BillboardGui_1.Parent = u3
        TweenService:Create(
            BillboardGui_1,
            TweenInfo.new(
                0.8,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut,
                -1,
                true
            ),
            { StudsOffsetWorldSpace = Vector3.new(0, 5.3, 0) }
        ):Play()

        return
    else
        return
    end
end

HalloweenWorld.OnClientEvent:Connect(function(s3: string, ...) -- line: 266
    -- upvalues:
    --  [1] candyPopup (copy)
    --  [2] markChest (copy)
    --  [3] findEnemy (copy)
    --  [4] attach (copy)
    --  [5] t_2 (copy)

    if s3 == "Candy" then
        local v19, v20 = ...

        if typeof(v19) == "Vector3" and type(v20) == "number" then
            candyPopup(v19, v20)

            return
        end
    elseif s3 == "Chest" then
        local v21 = ...

        if typeof(v21) == "Instance" and v21:IsA("Model") then
            markChest(v21)

            return
        end
    elseif s3 == "Mark" then
        local v22 = ...

        if type(v22) ~= "string" then
            return
        end

        local v23 = findEnemy(v22)

        if v23 then
            attach(v23, v22)

            return
        end

        t_2[v22] = true
    end
end)
local Parent = script.Parent
local udim2 = UDim2.fromOffset(270, 58)
local color_2 = Color3.fromRGB(120, 55, 20)
local color_3 = Color3.fromRGB(255, 150, 70)
local color_4 = Color3.fromRGB(255, 225, 200)
local color_5 = Color3.fromRGB(215, 180, 160)
local tweenInfo_4 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local HauntingBanner_ScreenGui = Instance.new("ScreenGui")
HauntingBanner_ScreenGui.Name = "HauntingBanner"
HauntingBanner_ScreenGui.ResetOnSpawn = false
HauntingBanner_ScreenGui.IgnoreGuiInset = true
HauntingBanner_ScreenGui.DisplayOrder = 5
HauntingBanner_ScreenGui.Enabled = false
local v24 = Parent:WaitForChild("Pass"):WaitForChild("EndsTimer"):Clone()
v24.Name = "Plate"
v24.AnchorPoint = Vector2.new(0.5, 0)
v24.Position = UDim2.new(0.5, 0, 0, 68)
v24.Size = udim2
v24.ImageColor3 = color_2

for _, descendant in v24:GetDescendants() do
    if descendant:IsA("UIGradient") and descendant.Parent ~= v24 then
        descendant:Destroy()
    end
end

local Label = v24.Label
Label.TextSize = 14
Label.TextColor3 = color_3
Label.Size = UDim2.new(1, 0, 0, 16)
Label.Position = UDim2.fromOffset(0, 4)
local Time = v24.Time
Time.FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Bold)
Time.TextSize = 15
Time.TextColor3 = color_4
Time.Size = UDim2.new(1, 0, 0, 18)
Time.Position = UDim2.fromOffset(0, 20)
local v25 = Time:Clone()
v25.Name = "Info"
v25.TextSize = 13
v25.TextColor3 = color_5
v25.Size = UDim2.new(1, 0, 0, 15)
v25.Position = UDim2.fromOffset(0, 38)
v25.Parent = v24
v24.Parent = HauntingBanner_ScreenGui
local t_4 = { [v24] = { ImageTransparency = 0.2, BackgroundTransparency = 1 } }

for _, descendant_1 in v24:GetDescendants() do
    if descendant_1:IsA("TextLabel") then
        t_4[descendant_1] = { TextTransparency = 0 }
    elseif descendant_1:IsA("ImageLabel") then
        t_4[descendant_1] = { ImageTransparency = math.max(descendant_1.ImageTransparency, 0.2) }
    end
end

for key_6, val_4 in t_4 do
    for key_7 in val_4 do
        key_6[key_7] = 1
    end
end

HauntingBanner_ScreenGui.Parent = PlayerGui

local function fadeBanner(b1: boolean) -- line: 364
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] TweenService (copy)
    --  [3] tweenInfo_4 (copy)

    for key_8, val_5 in t_4 do
        local t_6 = {}

        for key_9, val_6 in val_5 do
            t_6[key_9] = b1 and val_6 or 1
        end

        TweenService:Create(key_8, tweenInfo_4, t_6):Play()
    end
end

local _ = function(s4: string) --[[ attr ]] -- line: 374
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    return ReplicatedStorage:GetAttribute(s4)
end

local function statusText() -- line: 378
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    local HauntingPhase = ReplicatedStorage:GetAttribute("HauntingPhase")
    local v27 = ReplicatedStorage:GetAttribute("HauntingWave") or 0
    local v28 = ReplicatedStorage:GetAttribute("HauntingWaves") or 0

    if HauntingPhase == "Warning" then
        local v31 = math.max(
            math.ceil(
                (ReplicatedStorage:GetAttribute("HauntingRiseAt") or 0) - workspace:GetServerTimeNow()
            ),
            0
        )
        local v32 = v31 // 60
        local v33 = string.format("%02d", v31 % 60)

        return `The dead rise in {v32}:{v33}`
    end

    if HauntingPhase == "Wave" then
        return `Wave {v27} of {v28}  \194\183  {ReplicatedStorage:GetAttribute("HauntingLeft") or 0} undead left`
    end

    if HauntingPhase == "Lull" then
        return `Wave {v27} of {v28} cleared. More are coming...`
    end

    return if HauntingPhase ~= "Saved" then if HauntingPhase ~= "Lost" then "" else "The dead sank back into the earth..." else "The village is safe!"
end

local _ = function(n2: number) --[[ clock ]] -- line: 396
    local v34 = math.ceil(n2)
    n2 = math.max(v34, 0)
    local v35 = n2 // 60
    local v36 = string.format("%02d", n2 % 60)

    return `{v35}:{v36}`
end

local function infoText() -- line: 401
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    local HauntingPhase_1 = ReplicatedStorage:GetAttribute("HauntingPhase")
    local HauntingEndsAt = ReplicatedStorage:GetAttribute("HauntingEndsAt")
    local v37 = `{ReplicatedStorage:GetAttribute("HauntingParticipants") or 0} taking part`

    if HauntingPhase_1 == "Warning" then
        return "Head there and fight to take part"
    end

    if (HauntingPhase_1 == "Wave" or HauntingPhase_1 == "Lull") and HauntingEndsAt then
        local v39 = math.max(math.ceil(HauntingEndsAt - workspace:GetServerTimeNow()), 0)
        local v40 = v39 // 60
        local v41 = string.format("%02d", v39 % 60)

        return `{v37}  \194\183  ends in {`{v40}:{v41}`}`
    end

    return v37
end

local function nearHaunted(n3: number) -- line: 415
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] LocalPlayer (copy)

    local HauntingArea = ReplicatedStorage:GetAttribute("HauntingArea")
    local HauntingSize = ReplicatedStorage:GetAttribute("HauntingSize")
    local v42 = LocalPlayer.Character

    if v42 then
        v42 = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end

    if typeof(HauntingArea) == "CFrame" then
        if typeof(HauntingSize) ~= "Vector3" or not v42 then
            return false
        end

        local v43 = HauntingArea:PointToObjectSpace(v42.Position)
        v42 = HauntingSize / 2 + Vector3.new(1, 1, 1) * n3
        local v44 = false

        if math.abs(v43.X) <= v42.X then
            v44 = false

            if math.abs(v43.Y) <= v42.Y then
                local v47 = math.abs(v43.Z)
                v44 = v47 <= v42.Z and true
            end
        end

        return v44
    end

    return false
end

local v48 = false

local function updateBanner() -- line: 427
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] nearHaunted (copy)
    --  [3] Label (copy)
    --  [4] Time (copy)
    --  [5] statusText (copy)
    --  [6] v25 (copy)
    --  [7] infoText (copy)
    --  [8] v24 (copy)
    --  [9] v48 (ref)
    --  [10] HauntingBanner_ScreenGui (copy)
    --  [11] fadeBanner (copy)
    --  [12] tweenInfo_4 (copy)

    local Haunting = ReplicatedStorage:GetAttribute("Haunting")
    local v49 = if Haunting ~= nil then if ReplicatedStorage:GetAttribute("HauntingPhase") ~= "Warning" then nearHaunted(
        250
    ) else true else false

    if v49 then
        Label.Text = `{Haunting} is haunted`
        Time.Text = statusText()
        v25.Text = infoText()
        v24.Position = UDim2.new(
            0.5,
            0,
            0,
            if ReplicatedStorage:GetAttribute("BloodMoon") == true then 86 else 68
        )
    end

    if v49 == v48 then
        return
    end

    v48 = v49

    if v49 then
        HauntingBanner_ScreenGui.Enabled = true
    end

    fadeBanner(v49)

    if not v49 then
        task.delay(tweenInfo_4.Time, function() -- line: 445
            -- upvalues:
            --  [1] v48 (ref)
            --  [2] HauntingBanner_ScreenGui (ref)

            if not v48 then
                HauntingBanner_ScreenGui.Enabled = false
            end
        end)
    end
end

local tweenInfo_5 = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local t_7 = {
    Brightness = -0.03,
    Contrast = 0.05,
    Saturation = -0.08,
    TintColor = Color3.fromRGB(242, 228, 220)
}
local t_8 = { Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1) }
local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
local v55
ColorCorrectionEffect.Name, v55 = "HauntingDarken", t_8

for key_10, val_7 in v55 do
    ColorCorrectionEffect[key_10] = val_7
end

ColorCorrectionEffect.Parent = Lighting

local function insideHaunted() -- line: 475
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] LocalPlayer (copy)

    local HauntingArea_1 = ReplicatedStorage:GetAttribute("HauntingArea")
    local HauntingSize_1 = ReplicatedStorage:GetAttribute("HauntingSize")
    local HauntingPhase_2 = ReplicatedStorage:GetAttribute("HauntingPhase")
    local v56 = LocalPlayer.Character

    if v56 then
        v56 = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end

    if typeof(HauntingArea_1) == "CFrame" then
        if typeof(HauntingSize_1) ~= "Vector3" or not v56 or HauntingPhase_2 == "Saved" or HauntingPhase_2 == "Lost" then
            return false
        end

        local v57 = HauntingArea_1:PointToObjectSpace(v56.Position)
        v56 = HauntingSize_1 / 2
        local v58 = false

        if math.abs(v57.X) <= v56.X then
            v58 = false

            if math.abs(v57.Y) <= v56.Y then
                local v61 = math.abs(v57.Z)
                v58 = v61 <= v56.Z and true
            end
        end

        return v58
    end

    return false
end

local function locationDensity() -- line: 488
    -- upvalues:
    --  [1] Lighting (copy)
    --  [2] PlayerGui (copy)

    if Lighting:GetAttribute("BloodMoonLit") then
        return nil
    end

    local LocationClient = PlayerGui:FindFirstChild("LocationClient", true)
    local v62 = LocationClient

    if v62 then
        v62 = LocationClient:FindFirstChild("Atmosphere")
    end

    local Atmosphere = Lighting:FindFirstChildWhichIsA("Atmosphere")

    if not v62 or not Atmosphere then
        return nil
    end

    local v63, v64

    if LocationClient:GetAttribute("Weather") == true then
        v63 = v62:FindFirstChild("Rain")
    else
        v64 = v62:FindFirstChild(Atmosphere:GetAttribute("Active") or "Normal") or v62:FindFirstChild(
            "Normal"
        )
        v63 = v64
        v64 = Lighting.ClockTime
        local v65 = v63

        if v65 then
            v65 = v63:FindFirstChild("Night")
        end

        v63 = if not v65 then v63 else if v64 >= 18 then v65 else if not (v64 < 6) then v63 else v65
    end

    v64 = v63 and (v63:IsA("Atmosphere") and v63.Density) or nil

    return v64
end

local v66 = nil

local function setFog(u4: userdata, n4: number) -- line: 514
    -- upvalues:
    --  [1] v66 (ref)
    --  [2] TweenService (copy)
    --  [3] tweenInfo_5 (copy)

    if v66 then
        v66:Cancel()
    end

    v66 = TweenService:Create(u4, tweenInfo_5, { Density = n4 })
    v66.Completed:Once(function() -- line: 519
        -- upvalues:
        --  [1] v66 (ref)

        v66 = nil
    end)
    v66:Play()
end

local v67 = false
local v68 = 0

local function updateDarkness() -- line: 526
    -- upvalues:
    --  [1] insideHaunted (copy)
    --  [2] Lighting (copy)
    --  [3] locationDensity (copy)
    --  [4] v67 (ref)
    --  [5] TweenService (copy)
    --  [6] ColorCorrectionEffect (copy)
    --  [7] tweenInfo_5 (copy)
    --  [8] t_7 (copy)
    --  [9] t_8 (copy)
    --  [10] ReplicatedStorage (copy)
    --  [11] v68 (ref)
    --  [12] setFog (copy)
    --  [13] v66 (ref)

    local v69 = insideHaunted()
    local Atmosphere_1 = Lighting:FindFirstChildWhichIsA("Atmosphere")
    local v70 = locationDensity()

    if v69 ~= v67 then
        v67 = v69
        TweenService:Create(ColorCorrectionEffect, tweenInfo_5, if not v69 then t_8 else t_7):Play()
    end

    local v74 = (if not v69 then 0 else 0.05) + (if ReplicatedStorage:GetAttribute("HeadlessUp") then if Atmosphere_1 then if Atmosphere_1:GetAttribute(
        "Active"
    ) == "GravelightIsle" then 0.12 else 0 else 0 else 0)

    if not Atmosphere_1 or not v70 then
        v68 = 0

        return
    end

    if v74 ~= v68 then
        v68 = v74
        setFog(Atmosphere_1, v70 + v74)

        return
    end

    if v74 > 0 and not v66 and math.abs(Atmosphere_1.Density - (v70 + v74)) > 0.01 then
        setFog(Atmosphere_1, v70 + v74)
    end
end

LocalPlayer:SetAttribute("MusicOverrideFade", 5)

local function updateEventMusic() -- line: 561
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] nearHaunted (copy)
    --  [3] LocalPlayer (copy)

    local v75 = ReplicatedStorage:GetAttribute("HauntingPhase")
    local v76 = if ReplicatedStorage:GetAttribute("Haunting") ~= nil then if v75 == "Saved" then false else if v75 == "Lost" then false else nearHaunted(
        150
    ) else false
    v75 = if ReplicatedStorage:GetAttribute("BloodMoon") == true or v76 then 83882655085689 else nil

    if LocalPlayer:GetAttribute("MusicOverride") ~= v75 then
        LocalPlayer:SetAttribute("MusicOverride", v75)
    end
end

local v77 = 0
RunService.Heartbeat:Connect(function(deltaTime) -- line: 571
    -- upvalues:
    --  [1] v77 (ref)
    --  [2] updateBanner (copy)
    --  [3] updateDarkness (copy)
    --  [4] updateEventMusic (copy)

    v77 += deltaTime

    if v77 < 0.5 then
        return
    end

    v77 = 0
    updateBanner()
    updateDarkness()
    updateEventMusic()
end)
updateBanner()
