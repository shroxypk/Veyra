-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.ManaVisionClient
-- Class: LocalScript
-- bytes: 11566

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local Modules = ReplicatedStorage.Modules
local v2 = Lighting:FindFirstChild("ManaVision")

if not v2 then
    v2 = Instance.new("ColorCorrectionEffect")
    v2.Name = "ManaVision"
    v2.Parent = Lighting
end

local v3, v4 = require(Modules.scriptObjs).GetPlayerCharacter()
local PrimaryPart = v4.PrimaryPart
local tweenInfo = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v5 = TweenService:Create(v2, tweenInfo, { Saturation = -0.75, Contrast = 0.1 })
local v6 = TweenService:Create(v2, tweenInfo, { Saturation = 0, Contrast = 0 })

local function hideObject(arg1) -- line: 38
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] Services_m (copy)

    if arg1:IsA("BasePart") then
        TweenService:Create(
            arg1,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Transparency = 1 }
        ):Play()
    end

    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") and descendant.Name == "particlaaasf" then
            descendant.Enabled = false
            Services_m.Debris(descendant, 2)
        elseif descendant:IsA("Decal") then
            descendant.Transparency = 1
        end
    end
end

local function showObject(arg2) -- line: 53
    -- upvalues:
    --  [1] TweenService (copy)

    if arg2:IsA("BasePart") then
        if arg2:HasTag("PartVisible") then
            TweenService:Create(
                arg2,
                TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Transparency = 0 }
            ):Play()
        end

        for _, child in script.Reveal:GetChildren() do
            local v9 = child:Clone()
            v9.Name = "particlaaasf"
            v9.Parent = arg2
        end

        return
    end

    if arg2:IsA("Decal") then
        TweenService:Create(
            arg2,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Transparency = arg2:GetAttribute("OriginalTransparency") or 0 }
        ):Play()
    end
end

local v11 = Services_m.Maid.new()
local color = Color3.fromRGB(170, 255, 255)
local range = NumberRange.new(1.4, 2.4)
local t_1 = {}

local _ = function(arg3) --[[ hintAnchor ]] -- line: 89
    if arg3:IsA("BasePart") then
        return arg3
    end

    return arg3:IsA("Model") and arg3.PrimaryPart or nil
end

local function hintWanted(arg4) -- line: 97
    -- upvalues:
    --  [1] v3 (copy)

    local HintQuest = arg4:GetAttribute("HintQuest")
    local HintTask = arg4:GetAttribute("HintTask")

    if not HintQuest or not HintTask then
        return false
    end

    local v13 = v3:FindFirstChild("Quests")
    local v14 = v13

    if v14 then
        v14 = v13:FindFirstChild(HintQuest)
    end

    if v14 then
        if v14:GetAttribute("Completed") then
            return false
        end

        v13 = v14:FindFirstChild("Tasks")

        if v13 then
            v13 = v14.Tasks:FindFirstChild(HintTask)
        end

        if v13 then
            if v13:GetAttribute("Hidden") then
                return false
            end

            if (v13:GetAttribute("TaskProgress") or 0) >= (v13:GetAttribute("TaskMax") or 1) then
                return false
            end

            v13 = v14:FindFirstChild("Objects")

            if v13 and v13:FindFirstChild(arg4.Name) then
                return false
            end

            return true
        else
            return false
        end
    else
        return false
    end
end

local function removeHint(arg5) -- line: 125
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Services_m (copy)

    local v19 = t_1[arg5]

    if not v19 then
        return
    end

    t_1[arg5] = nil

    if v19.Thread then
        pcall(task.cancel, v19.Thread)
    end

    for _, val in v19.Instances do
        if val:IsA("ParticleEmitter") then
            val.Enabled = false
            Services_m.Debris(val, 1)
        elseif val:IsA("Tween") then
            val:Cancel()
            val:Destroy()
        else
            val:Destroy()
        end
    end
end

local function clearHints() -- line: 148
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] removeHint (copy)

    for key_3 in t_1 do
        removeHint(key_3)
    end
end

local function makeBeam(arg6, arg7, arg8, arg9) -- line: 154
    -- upvalues:
    --  [1] color (copy)

    local Beam = Instance.new("Beam")
    Beam.Attachment0 = arg6
    Beam.Attachment1 = arg7
    Beam.Color = ColorSequence.new(color)
    Beam.LightEmission = 1
    Beam.LightInfluence = 0
    Beam.FaceCamera = true
    Beam.Segments = 10
    Beam.Texture = "rbxassetid://15811402156"
    Beam.TextureMode = Enum.TextureMode.Stretch
    Beam.TextureLength = 1
    Beam.Width0 = arg8
    Beam.Width1 = arg8 * 0.35
    Beam.Transparency = NumberSequence.new(
        {
            NumberSequenceKeypoint.new(0, (math.max(arg9, 0.85))),
            NumberSequenceKeypoint.new(0.15, arg9),
            NumberSequenceKeypoint.new(0.6, (math.min(1, arg9 + 0.4))),
            NumberSequenceKeypoint.new(1, 1)
        }
    )
    Beam.Parent = arg6

    return Beam
end

local function addHint(arg10, arg11) -- line: 179
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] makeBeam (copy)
    --  [3] TweenService (copy)
    --  [4] range (copy)

    local t_3 = { Instances = {} }
    t_1[arg10] = t_3

    local _ = function(arg12) --[[ keep ]] -- line: 183
        -- upvalues:
        --  [1] t_3 (copy)

        table.insert(t_3.Instances, arg12)

        return arg12
    end

    local v22 = arg10:IsA("Model") and arg10:GetBoundingBox().Position or arg11.Position
    local ManaHintBase_Attachment = Instance.new("Attachment")
    table.insert(t_3.Instances, ManaHintBase_Attachment)
    ManaHintBase_Attachment.Name = "ManaHintBase"
    ManaHintBase_Attachment.Parent = arg11
    ManaHintBase_Attachment.WorldPosition = v22
    local Attachment_1 = Instance.new("Attachment")
    table.insert(t_3.Instances, Attachment_1)
    Attachment_1.Name = "ManaHintTop"
    Attachment_1.Parent = arg11
    Attachment_1.WorldPosition = v22 + Vector3.new(0, 45, 0)
    local v23 = makeBeam(ManaHintBase_Attachment, Attachment_1, 1.2, 0.15)
    makeBeam(ManaHintBase_Attachment, Attachment_1, 4, 0.8)
    local v25 = TweenService:Create(
        v23,
        TweenInfo.new(
            1.2,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut,
            -1,
            true
        ),
        { Width0 = 1.8 }
    )
    v25:Play()
    table.insert(t_3.Instances, v25)

    for _, child_1 in script.Reveal:GetChildren() do
        local v26 = child_1:Clone()
        v26.Name = "ManaHintSparkle"
        v26.Parent = arg11
        table.insert(t_3.Instances, v26)
    end

    local v27 = script.Glisten:Clone()
    table.insert(t_3.Instances, v27)
    v27.Parent = ManaHintBase_Attachment
    t_3.Thread = task.spawn(function() -- line: 221
        -- upvalues:
        --  [1] v27 (copy)
        --  [2] range (ref)

        local rng = Random.new()

        while true do
            if not v27.Parent then
                break
            end

            v27.PlaybackSpeed = rng:NextNumber(0.9, 1.15)
            v27:Play()
            task.wait(rng:NextNumber(range.Min, range.Max))
        end
    end)
end

local function updateHints() -- line: 232
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] CollectionService (copy)
    --  [3] hintWanted (copy)
    --  [4] t_1 (copy)
    --  [5] removeHint (copy)
    --  [6] addHint (copy)

    local PrimaryPart_1 = v4.PrimaryPart

    if not PrimaryPart_1 then
        return
    end

    local t_4 = {}

    for _, val_1 in CollectionService:GetTagged("ManaHint") do
        local v29 = if val_1:IsA("BasePart") then val_1 else val_1:IsA("Model") and val_1.PrimaryPart or nil

        if v29 and val_1:IsDescendantOf(workspace) and (v29.Position - PrimaryPart_1.Position).Magnitude <= 150 and hintWanted(
            val_1
        ) then
            t_4[val_1] = v29
        end
    end

    for key_6 in t_1 do
        if not t_4[key_6] then
            removeHint(key_6)
        end
    end

    for key_7, val_2 in t_4 do
        if not t_1[key_7] then
            addHint(key_7, val_2)
        end
    end
end

local function tagAdded() -- line: 262
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] v11 (copy)
    --  [3] CollectionService (copy)
    --  [4] hideObject (copy)
    --  [5] v5 (copy)
    --  [6] v6 (copy)
    --  [7] ReplicatedStorage (copy)
    --  [8] PrimaryPart (copy)
    --  [9] showObject (copy)
    --  [10] clearHints (copy)
    --  [11] updateHints (copy)

    if not v4:GetAttribute("ManaVision") then
        v11:Destroy()

        for _, val_3 in CollectionService:GetTagged("Reveal") do
            val_3:RemoveTag("Reveal")
            hideObject(val_3)
        end

        v5:Cancel()
        v6:Play()

        return
    end

    v11:Destroy()
    script.Cast:Play()
    task.delay(0.1, function() -- line: 282
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] PrimaryPart (ref)

        for _ = 1, 3 do
            local v30 = ReplicatedStorage.Effects.Ball:Clone()
            v30.CFrame = PrimaryPart.CFrame
            v30.Color = Color3.fromRGB(0, 0, 0)
            v30.Material = Enum.Material.ForceField
            v30.Anchored = false
            local Weld = Instance.new("Weld")
            Weld.Part0 = v30
            Weld.Part1 = PrimaryPart
            Weld.C0 = CFrame.new(0, 0, 0)
            Weld.Parent = Weld.Part0
            v30.Parent = workspace.Effects
            _G.Tween(
                v30,
                { 2.5, "Quad", Enum.EasingDirection.Out },
                { Size = Vector3.new(110, 110, 110), Transparency = 1 },
                true
            )
            task.wait(0.125)
        end
    end)
    v6:Cancel()
    v5:Play()
    local Attachment_2 = Instance.new("Attachment")

    for _, child_2 in script.Head:GetChildren() do
        child_2:Clone().Parent = Attachment_2
    end

    Attachment_2.Parent = v4:FindFirstChild("Head")
    v11:GiveTask(Attachment_2)
    v11:GiveTask(CollectionService:GetInstanceAddedSignal("Concealed"):Connect(function(arg13) -- line: 315
        arg13:AddTag("Reveal")
    end))
    v11:GiveTask(CollectionService:GetInstanceAddedSignal("Reveal"):Connect(showObject))
    v11:GiveTask(CollectionService:GetInstanceRemovedSignal("Reveal"):Connect(hideObject))

    for _, val_4 in CollectionService:GetTagged("Concealed") do
        val_4:AddTag("Reveal")
    end

    v11:GiveTask(clearHints)
    v11:GiveTask(task.spawn(function() -- line: 328
        -- upvalues:
        --  [1] updateHints (ref)

        while true do
            local Success, Result = pcall(updateHints)

            if not Success then
                warn("[ManaVision] Hint update failed:", Result)
            end

            task.wait(0.3)
        end
    end))
end

v4:GetAttributeChangedSignal("ManaVision"):Connect(tagAdded)
tagAdded()
v4.Destroying:Connect(clearHints)
local Humanoid = v4:FindFirstChildOfClass("Humanoid")

if Humanoid then
    Humanoid.Died:Connect(clearHints)
end
