-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.BroomClient
-- Class: LocalScript
-- bytes: 25172

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("Lighting")
local _ = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local StateManager_m = require(Modules.StateManager)
local DeadZones_m = require(Modules.DeadZones)
local Basic_m = require(Modules.Basic)
local CreateBindableAction_m = require(Modules.CreateBindableAction)
local GamepadLayer_m = require(Modules.GamepadLayer)
local Professions_m = require(Modules.Professions)
local StatManager_m = require(Modules.StatManager)
local Items_m = require(Modules.Items)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StateManager_m.require(v3)
local Professions = v2:WaitForChild("Professions")
local CurrentCamera = workspace.CurrentCamera
local Animator = v3:WaitForChild("Humanoid"):WaitForChild("Animator")
local PrimaryPart = v3.PrimaryPart
local v5 = require(v2:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { v3 }
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true
local rng = Random.new()
local WaterZones_m = require(ReplicatedStorage.Modules.WaterZones)

local _ = function(arg1) --[[ waterFloor ]] -- line: 54
    -- upvalues:
    --  [1] WaterZones_m (copy)

    local v6 = WaterZones_m:GetLakeLevel(arg1)

    return v6 and v6 + 4 or 5
end

local _ = function(arg2) --[[ inWater ]] -- line: 60
    -- upvalues:
    --  [1] WaterZones_m (copy)
    --  [2] DeadZones_m (copy)
    --  [3] v3 (copy)

    local v8 = WaterZones_m:GetLakeLevel(arg2)

    if v8 then
        return arg2.Y < v8 + 4
    end

    return if arg2.Y < 5 then not DeadZones_m:InDeadZone(v3) else false
end

local FLYINGTAG = Basic_m.FLYING_TAG
local t = {
    Stall = Enum.AnimationPriority.Action,
    Forward = Enum.AnimationPriority.Action2,
    Left = Enum.AnimationPriority.Action2,
    Right = Enum.AnimationPriority.Action2
}
local t_1 = {}
local t_2 = {}
local BroomRemote = ReplicatedStorage.Remotes.BroomRemote
local ElevationMeter = script.ElevationMeter
local FlySound = script.FlySound
ElevationMeter.Parent = PrimaryPart
local FlightPositionAttachment_Attachment = Instance.new("Attachment")
FlightPositionAttachment_Attachment.Name = "FlightPositionAttachment"
local AlignOrientation = Instance.new("AlignOrientation")
AlignOrientation.Attachment0 = FlightPositionAttachment_Attachment
AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
AlignOrientation.RigidityEnabled = false
AlignOrientation.ReactionTorqueEnabled = false
AlignOrientation.AlignType = Enum.AlignType.Parallel
AlignOrientation.MaxTorque = math.huge
AlignOrientation.Enabled = true
AlignOrientation.Parent = FlightPositionAttachment_Attachment
local LinearVelocity = Instance.new("LinearVelocity")
LinearVelocity.Attachment0 = FlightPositionAttachment_Attachment
LinearVelocity.ForceLimitsEnabled = false
LinearVelocity.Enabled = true
LinearVelocity.Parent = FlightPositionAttachment_Attachment
local v10 = 0
local v11 = 1
local v12 = 1
local v13 = false

local function professionBonus() -- line: 141
    -- upvalues:
    --  [1] Professions_m (copy)
    --  [2] v10 (ref)
    --  [3] v11 (ref)
    --  [4] v12 (ref)
    --  [5] v13 (ref)

    local v15 = Professions_m:GetPlayerBenefits(
        game:GetService("Players").LocalPlayer,
        "Broom Flying"
    )
    local v16 = v15.altitude or 0
    v10 = v15.speed or 0
    v11 = 1 + v16
    v12 = 1 + (v15.orb_strength or 0)
    v13 = (v15.slipstream or 0) > 0 and true
end

Professions:WaitForChild("Broom Flying"):GetPropertyChangedSignal("Value"):Connect(professionBonus)
local v18 = Professions_m:GetPlayerBenefits(game:GetService("Players").LocalPlayer, "Broom Flying")
v10 = v18.speed or 0
v11 = 1 + (v18.altitude or 0)
v12 = 1 + (v18.orb_strength or 0)
local v19 = StatManager_m.require(v2)
local Binds = v2:WaitForChild("Binds")
v13 = (v18.slipstream or 0) > 0 and true

local function canUseBroom() -- line: 158
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] v2 (copy)
    --  [3] PrimaryPart (copy)

    if _G.NOFLYZONE then
        _G.FLYZONEALERT()

        return
    end

    local v20 = v4:IsIncapacitated()
    local v21 = v4:IsClimbing()

    if not v2:GetAttribute("InCombat") and not v20 and not v21 and not v4:IsSwimming() and not v4:HasState(
        "Stunned"
    ) and not PrimaryPart:FindFirstChildWhichIsA("BodyMover") then
        return true
    end
end

local function initAnimations() -- line: 173
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] t_1 (copy)

    for _, child in ReplicatedStorage.Animations.Broom:GetChildren() do
        local t_3 = {}

        for _, child_1 in child:GetChildren() do
            t_3[child_1.Name] = child_1
        end

        t_1[child.Name] = t_3
    end
end

initAnimations()
local t_4 = { Forward = false, Left = false, Right = false }
local t_5 = { Forward = false, Left = false, Right = false }
local v23 = nil

local function loadTracks() -- line: 201
    -- upvalues:
    --  [1] v19 (copy)
    --  [2] Items_m (copy)
    --  [3] t_1 (copy)
    --  [4] v23 (ref)
    --  [5] t_2 (copy)
    --  [6] t (copy)
    --  [7] Animator (copy)

    local Broom = v19:GetStat("Broom")
    local v24 = Items_m.AllItems[Broom]
    local v25 = v24.AnimationSet

    if type(v24) ~= "table" or not v25 then
        v25 = Broom
    end

    v24 = if t_1[v25] then v25 else "Default"

    if v23 == v24 then
        return
    end

    for _, val in t_2 do
        val:Stop(0)
        val:Destroy()
    end

    table.clear(t_2)
    v25 = t_1[v24]
    local Default = t_1.Default

    for key_3, val_1 in t do
        local v26 = v25 and v25[key_3] or Default and Default[key_3]

        if v26 then
            local v27 = Animator:LoadAnimation(v26)
            v27.Priority = val_1
            t_2[key_3] = v27
        else
            warn(`Broom animation "{key_3}" missing from "{v24}" and Default`)
        end
    end

    v23 = v24
end

local _ = function(arg3, arg4) --[[ playAnimation ]] -- line: 238
    -- upvalues:
    --  [1] t_2 (copy)

    local v28 = t_2[arg3]

    if v28 and not v28.IsPlaying then
        v28:Play(arg4 or 0.4)
    end
end

local _ = function(arg5, arg6) --[[ stopAnimation ]] -- line: 245
    -- upvalues:
    --  [1] t_2 (copy)

    local v29 = t_2[arg5]

    if v29 and v29.IsPlaying then
        v29:Stop(arg6 or 0.7)
    end
end

local _ = function() --[[ stopAllAnimations ]] -- line: 252
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t_4 (copy)
    --  [3] t_5 (copy)

    for key_4 in t_2 do
        local v30 = t_2[key_4]

        if v30 and v30.IsPlaying then
            v30:Stop(0.1)
        end
    end

    for key_5 in t_4 do
        t_4[key_5] = false
        t_5[key_5] = false
    end
end

local function UpdateInput() -- line: 264
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] v5 (copy)
    --  [3] t_5 (copy)
    --  [4] t_4 (copy)
    --  [5] t_2 (copy)

    if not v4:IsFlying() then
        return
    end

    local v31 = v5:GetMoveVector()
    t_5.Forward = v31.Z < -0.1 and true
    local v34 = t_5
    v34.Left = v31.X < -0.1
    local v35 = t_5
    v35.Right = v31.X > 0.1

    for key_6, val_2 in t_5 do
        if t_4[key_6] ~= val_2 then
            t_4[key_6] = val_2

            if val_2 then
                local v36 = t_2[key_6]

                if v36 and not v36.IsPlaying then
                    v36:Play(0.4)
                end
            else
                local v37 = t_2[key_6]

                if v37 and v37.IsPlaying then
                    v37:Stop(0.7)
                end
            end
        end
    end
end

local v38 = nil
local v39 = nil

local function setSoundSpeed(arg7, arg8) -- line: 297
    -- upvalues:
    --  [1] v38 (ref)
    --  [2] v39 (ref)
    --  [3] TweenService (copy)
    --  [4] FlySound (copy)

    if v38 == arg7 then
        return
    end

    v38 = arg7

    if v39 then
        v39:Cancel()
    end

    v39 = TweenService:Create(
        FlySound,
        TweenInfo.new(arg8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { PlaybackSpeed = arg7 }
    )
    v39:Play()
end

local v42 = false

local _ = function(arg9) --[[ TweenFOV ]] -- line: 317
    -- upvalues:
    --  [1] v42 (ref)
    --  [2] CurrentCamera (copy)

    if v42 or CurrentCamera.FieldOfView == arg9 then
        return
    end

    v42 = true
    task.spawn(function() -- line: 324
        -- upvalues:
        --  [1] CurrentCamera (ref)
        --  [2] arg9 (copy)
        --  [3] v42 (ref)

        _G.Tween(
            CurrentCamera,
            { 0.2, "Quad", Enum.EasingDirection.Out },
            { FieldOfView = arg9 },
            false,
            true
        )
        v42 = false
    end)
end

local v43 = 0
local v44 = 0

local function updateSlipstream(arg10) -- line: 337
    -- upvalues:
    --  [1] v44 (ref)
    --  [2] PrimaryPart (copy)
    --  [3] v2 (copy)
    --  [4] Players (copy)
    --  [5] FLYINGTAG (copy)
    --  [6] v13 (ref)
    --  [7] v43 (ref)

    if arg10 - v44 < 0.25 then
        return
    end

    v44 = arg10
    local v45 = 0
    local LookVector = PrimaryPart.CFrame.LookVector
    local v46 = v2.Character
    local v47 = v46 and v46:GetAttribute("SlipstreamAllies") or ""

    for _, val_3 in Players:GetPlayers() do
        v46 = if val_3 == v2 then false else val_3.Character
        local v48 = v46

        if v48 then
            v48 = v46.PrimaryPart
        end

        if v48 and v46:GetAttribute(FLYINGTAG) and string.find(
            v47,
            "," .. val_3.UserId .. ",",
            1,
            true
        ) then
            local v49 = v48.Position - PrimaryPart.Position

            if v49.Magnitude < 30 and v49.Magnitude > 0 and v49.Unit:Dot(LookVector) > 0.7 then
                if v46:GetAttribute("Slipstream") then
                    v45 = math.max(v45, 0.1)
                end

                if v13 then
                    v45 = math.max(v45, 0.05)
                end
            end
        end
    end

    v43 = v45
end

local _ = function(arg11) --[[ updateMaxFlySpeed ]] -- line: 366
    -- upvalues:
    --  [1] updateSlipstream (copy)
    --  [2] v4 (copy)
    --  [3] v12 (ref)
    --  [4] v10 (ref)
    --  [5] v43 (ref)
    --  [6] v3 (copy)

    updateSlipstream(os.clock())
    local v52 = 1 + (v4:HasState("SpeedOrb") and v12 * 0.5 or 0) + v10 + v43

    if v3:FindFirstChild("Tailwind") then
        v52 += 0.15
    end

    return arg11 * v52
end

local _ = function(arg12, arg13) --[[ smoothAlpha ]] -- line: 376
    return 1 - math.exp(-arg12 * arg13)
end

local v53 = false

local _ = function() --[[ requestDismount ]] -- line: 381
    -- upvalues:
    --  [1] v53 (ref)
    --  [2] BroomRemote (copy)

    if v53 then
        return
    end

    v53 = true
    task.spawn(function() -- line: 388
        -- upvalues:
        --  [1] BroomRemote (ref)
        --  [2] v53 (ref)

        BroomRemote:InvokeServer()
        v53 = false
    end)
end

local v54 = 0
local v55 = Vector3.new(0, 0, -1)
local Identity = CFrame.identity
local v56 = 0
local v57 = 0
local v58 = nil

local function spawnSpeedLine(arg14) -- line: 406
    -- upvalues:
    --  [1] rng (copy)
    --  [2] PrimaryPart (copy)

    local Impactlines_Part = Instance.new("Part")
    Impactlines_Part.Anchored = true
    Impactlines_Part.CanCollide = false
    Impactlines_Part.CanQuery = false
    Impactlines_Part.CanTouch = false
    Impactlines_Part.Name = "impactlines"
    Impactlines_Part.Color = Color3.fromRGB(240, 240, 240)
    Impactlines_Part.Transparency = rng:NextNumber(0.7, 0.8)
    Impactlines_Part.Size = Vector3.new(0.1, 0.1, rng:NextNumber(4, 6.5))
    local SpecialMesh = Instance.new("SpecialMesh")
    SpecialMesh.MeshType = Enum.MeshType.Sphere
    SpecialMesh.Parent = Impactlines_Part
    local v59 = PrimaryPart.Position + Vector3.new(0, 1, 0)
    local v60 = rng:NextNumber(-12, 12)
    local v61 = rng:NextNumber(-12, 12)
    Impactlines_Part.CFrame = CFrame.lookAt(
        v59 + Vector3.new(v60, v61, rng:NextNumber(-12, 12)),
        PrimaryPart.Position + arg14 * 100
    )
    Impactlines_Part.Parent = workspace.Effects
    local v62 = rng:NextNumber(5, 10)
    _G.Tween(
        Impactlines_Part,
        { 0.3, "Quad", Enum.EasingDirection.Out },
        {
            Position = Impactlines_Part.Position + Impactlines_Part.CFrame.LookVector * -v62,
            Transparency = 1,
            Size = Impactlines_Part.Size / 2
        },
        true
    )
end

local v63 = 0
local v64 = 0

local function flyStep(arg15) -- line: 439
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] UpdateInput (copy)
    --  [3] v5 (copy)
    --  [4] PrimaryPart (copy)
    --  [5] v3 (copy)
    --  [6] raycastParams (copy)
    --  [7] WaterZones_m (copy)
    --  [8] v11 (ref)
    --  [9] v63 (ref)
    --  [10] ElevationMeter (copy)
    --  [11] v42 (ref)
    --  [12] CurrentCamera (copy)
    --  [13] setSoundSpeed (copy)
    --  [14] v54 (ref)
    --  [15] v58 (ref)
    --  [16] DeadZones_m (copy)
    --  [17] v53 (ref)
    --  [18] BroomRemote (copy)
    --  [19] LinearVelocity (copy)
    --  [20] t_5 (copy)
    --  [21] updateSlipstream (copy)
    --  [22] v12 (ref)
    --  [23] v10 (ref)
    --  [24] v43 (ref)
    --  [25] v55 (ref)
    --  [26] Identity (ref)
    --  [27] v56 (ref)
    --  [28] v57 (ref)
    --  [29] AlignOrientation (copy)
    --  [30] v64 (ref)
    --  [31] spawnSpeedLine (copy)

    if not v4:IsFlying() then
        return
    end

    UpdateInput()
    local v65 = v5:GetMoveVector()
    local clock = os.clock()
    local Position = PrimaryPart.Position
    local v66 = 20
    local v67 = 20
    local v68 = if v3:GetAttribute("InRace") then 300 else 125
    local v69 = workspace:Raycast(Position, Vector3.new(0, -1000, 0), raycastParams)

    if v69 then
        local v70 = v69.Position.Y + 5
        local v71 = WaterZones_m:GetLakeLevel(Position)
        local v72 = v71 and v71 + 4 or 5
        v66 = math.max(v70, v72)
        v67 = Position.Y - v69.Position.Y
    end

    local v73 = (v68 + v66) * v11
    local v74 = string.format("%.1fm", v73 - v73 / v11)
    local v75 = math.clamp((Position.Y - v66) / (v73 - v66), 0, 1)
    local v76 = v75 - v63
    local math_exp = math.exp
    local v77 = math.clamp(v67 / v73, 0, 1)
    v63 = v63 + v76 * (1 - math_exp(-10 * arg15))
    ElevationMeter.Bar.Front.Size = UDim2.new(1, 0, v63, 0)
    local Height = ElevationMeter.Bar.Tip.Height
    local v81 = math.ceil(v73)
    local v82 = v74
    Height.Text = `{v81}m (+{v82})`
    local v83 = v75 * 100
    local Percent = ElevationMeter.Bar.Tip.Percent
    local v84 = math.ceil(v83)
    Percent.Text = `{v84}%`
    ElevationMeter.Bar.Tip.Percent.TextColor3 = Color3.new(0.788235, 1, 0.67451):Lerp(
        Color3.new(1, 0, 0),
        v77
    )

    if _G.NOFLYZONE then
        if not v42 and CurrentCamera.FieldOfView ~= 70 then
            v42 = true
            local v88 = 70
            task.spawn(function() -- line: 324
                -- upvalues:
                --  [1] CurrentCamera (ref)
                --  [2] v88 (copy)
                --  [3] v42 (ref)

                _G.Tween(
                    CurrentCamera,
                    { 0.2, "Quad", Enum.EasingDirection.Out },
                    { FieldOfView = v88 },
                    false,
                    true
                )
                v42 = false
            end)
        end

        setSoundSpeed(0, 0.5)
        v54 = 0
        v58 = nil
        local v89 = workspace:Raycast(Position, Vector3.new(0, -10, 0), raycastParams)
        local v90 = WaterZones_m:GetLakeLevel(Position)

        if (if v90 then if not (Position.Y < v90 + 4) then false else true else if Position.Y < 5 then not DeadZones_m:InDeadZone(
            v3
        ) else false) or v89 then
            if v53 then
                return
            else
                v53 = true
                task.spawn(function() -- line: 388
                    -- upvalues:
                    --  [1] BroomRemote (ref)
                    --  [2] v53 (ref)

                    BroomRemote:InvokeServer()
                    v53 = false
                end)

                return
            end
        end

        LinearVelocity.VectorVelocity = LinearVelocity.VectorVelocity:Lerp(
            Vector3.new(0, -25, 0),
            1 - math.exp(-6 * arg15)
        )

        return
    end

    local v94 = workspace.CurrentCamera.CFrame
    v67 = v65.Magnitude > 0.01
    v66 = t_5.Forward
    local v95 = t_5.Left or t_5.Right
    updateSlipstream(os.clock())
    local v97 = v4:HasState("SpeedOrb") and v12 * 0.5 or 0
    local v99 = 1 + v97 + v10 + v43

    if v3:FindFirstChild("Tailwind") then
        v99 += 0.15
    end

    local v102 = 80 * v99
    v97 = 0

    if v67 then
        v97 = if not v66 then 35 else v102
        v99 = v94:VectorToWorldSpace(v65.Unit)

        if v55:Dot(v99) < 0.5 then
            v55 = v99
            v54 = math.min(v54, v97)
        else
            v55 = v55:Lerp(v99, 1 - math.exp(-6 * arg15)).Unit
        end

        Identity = v94.Rotation
    end

    if v67 then
        if v97 > v54 then
            v94 = if v54 < v97 * 0.5 then 120 else math.max(8, v102 * 0.5)
            v54 = math.min(v54 + v94 * arg15, v97)
        else
            v54 = math.max(v54 - 60 * arg15, v97)
        end
    else
        v54 = v54 * math.exp(-4 * arg15)

        if v54 < 0.05 then
            v54 = 0
        end
    end

    v97 = v55 * v54

    if v97.Y > 0 then
        local v115 = math.clamp((v73 - Position.Y) / 15, 0, 1)
        v97 = Vector3.new(v97.X, v97.Y * v115, v97.Z)
    end

    if v73 < Position.Y then
        local v116 = math.min(5 + (Position.Y - v73) * 4, 20)
        v97 -= Vector3.new(0, v116, 0)
    end

    LinearVelocity.VectorVelocity = v97

    if v66 and v54 >= v102 - 0.5 then
        v58 = v58 or clock
    else
        v58 = nil
    end

    v73 = if v58 == nil then false else clock - v58 > 1.25
    local v119 = if not v66 then 0 else 5 * (v54 / v102)
    v102 = if v95 then math.sign(v65.X) else 0
    local v121 = -v102 * 8 * math.clamp(v54 / 35, 0, 1)
    v102 = 1 - math.exp(-6 * arg15)
    local v122 = v56
    v122 += (v119 - v56) * v102
    v56 = v122
    local v123 = v57
    v123 += (v121 - v57) * v102
    v57 = v123
    AlignOrientation.CFrame = Identity * CFrame.Angles(-math.rad(v56), 0, (math.rad(v57)))

    if v67 and v66 then
        local v127 = setSoundSpeed
        v127(if not v73 then 1 else 2, 0.25)
        v127 = if not v73 then 75 else 80

        if not v42 and CurrentCamera.FieldOfView ~= v127 then
            v42 = true
            task.spawn(function() -- line: 324
                -- upvalues:
                --  [1] CurrentCamera (ref)
                --  [2] v127 (copy)
                --  [3] v42 (ref)

                _G.Tween(
                    CurrentCamera,
                    { 0.2, "Quad", Enum.EasingDirection.Out },
                    { FieldOfView = v127 },
                    false,
                    true
                )
                v42 = false
            end)
        end
    elseif v67 and v95 then
        setSoundSpeed(0.5, 0.5)

        if not v42 then
            if CurrentCamera.FieldOfView ~= 70 then
                v42 = true
                local v132 = 70
                task.spawn(function() -- line: 324
                    -- upvalues:
                    --  [1] CurrentCamera (ref)
                    --  [2] v132 (copy)
                    --  [3] v42 (ref)

                    _G.Tween(
                        CurrentCamera,
                        { 0.2, "Quad", Enum.EasingDirection.Out },
                        { FieldOfView = v132 },
                        false,
                        true
                    )
                    v42 = false
                end)
            end
        end
    else
        setSoundSpeed(0, 0.5)

        if not v42 then
            if CurrentCamera.FieldOfView ~= 70 then
                v42 = true
                local v137 = 70
                task.spawn(function() -- line: 324
                    -- upvalues:
                    --  [1] CurrentCamera (ref)
                    --  [2] v137 (copy)
                    --  [3] v42 (ref)

                    _G.Tween(
                        CurrentCamera,
                        { 0.2, "Quad", Enum.EasingDirection.Out },
                        { FieldOfView = v137 },
                        false,
                        true
                    )
                    v42 = false
                end)
            end
        end
    end

    if v66 and v73 then
        if clock - v64 >= 0.01 then
            v64 = clock
            spawnSpeedLine(v97)
        end
    end

    v119 = WaterZones_m:GetLakeLevel(Position)

    if if v119 then if not (Position.Y < v119 + 4) then false else true else if Position.Y < 5 then not DeadZones_m:InDeadZone(
        v3
    ) else false then
        if v53 then
            return
        end

        v53 = true
        task.spawn(function() -- line: 388
            -- upvalues:
            --  [1] BroomRemote (ref)
            --  [2] v53 (ref)

            BroomRemote:InvokeServer()
            v53 = false
        end)
    end
end

local v141 = nil
local KeyCode_DPadRight = Enum.KeyCode.DPadRight
local Broom_1 = Binds:WaitForChild("Broom")

local function broomAction(_, arg17, _) -- line: 610
    -- upvalues:
    --  [1] v141 (ref)
    --  [2] canUseBroom (copy)
    --  [3] v4 (copy)
    --  [4] BroomRemote (copy)

    if arg17 == Enum.UserInputState.Begin and not v141 and canUseBroom() then
        v141 = true
        task.delay(1, function() -- line: 613
            -- upvalues:
            --  [1] v141 (ref)

            v141 = false
        end)

        if v4:IsFlying() then
            BroomRemote:InvokeServer()

            return
        end

        BroomRemote:InvokeServer("Active")
    end
end

CreateBindableAction_m("Broom", Broom_1, broomAction)
GamepadLayer_m.setTap(KeyCode_DPadRight, function() -- line: 632
    -- upvalues:
    --  [1] broomAction (copy)

    broomAction("Broom", Enum.UserInputState.Begin)
end)
UserInputService.JumpRequest:Connect(function() -- line: 638
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] v141 (ref)
    --  [3] BroomRemote (copy)

    if v3:GetAttribute("BroomPassenger") ~= nil and not v141 then
        v141 = true
        task.delay(1, function() -- line: 641
            -- upvalues:
            --  [1] v141 (ref)

            v141 = false
        end)
        BroomRemote:InvokeServer("LeaveSeat")
    end
end)
v3.DescendantAdded:Connect(function(descendant) -- line: 648
    if descendant:IsA("ProximityPrompt") and descendant.Name == "BroomSeatPrompt" then
        descendant.Enabled = false
    end
end)
local v142 = nil

local function syncFlyAttribute() -- line: 656
    -- upvalues:
    --  [1] v142 (ref)
    --  [2] v3 (copy)
    --  [3] FLYINGTAG (copy)
    --  [4] loadTracks (copy)
    --  [5] t_2 (copy)
    --  [6] v54 (ref)
    --  [7] v56 (ref)
    --  [8] v57 (ref)
    --  [9] v58 (ref)
    --  [10] v55 (ref)
    --  [11] Identity (ref)
    --  [12] FlightPositionAttachment_Attachment (copy)
    --  [13] PrimaryPart (copy)
    --  [14] ElevationMeter (copy)
    --  [15] AlignOrientation (copy)
    --  [16] RunService (copy)
    --  [17] flyStep (copy)
    --  [18] CurrentCamera (copy)
    --  [19] t_4 (copy)
    --  [20] t_5 (copy)
    --  [21] setSoundSpeed (copy)
    --  [22] LinearVelocity (copy)

    if v142 then
        v142:Disconnect()
        v142 = nil
    end

    if v3:GetAttribute(FLYINGTAG) then
        loadTracks()
        local Stall = t_2.Stall

        if Stall and not Stall.IsPlaying then
            Stall:Play(0.1)
        end

        local v143 = workspace.CurrentCamera.CFrame
        v54 = 0
        v56 = 0
        v57 = 0
        v58 = nil
        v55 = v143.LookVector
        Identity = v143.Rotation
        FlightPositionAttachment_Attachment.Parent = PrimaryPart
        ElevationMeter.Enabled = true
        AlignOrientation.CFrame = Identity
        v142 = RunService.PreSimulation:Connect(flyStep)

        return
    end

    CurrentCamera.FieldOfView = 70

    for key_8 in t_2 do
        local v144 = t_2[key_8]

        if v144 and v144.IsPlaying then
            v144:Stop(0.1)
        end
    end

    for key_9 in t_4 do
        t_4[key_9] = false
        t_5[key_9] = false
    end

    setSoundSpeed(0, 0.5)
    FlightPositionAttachment_Attachment.Parent = nil
    ElevationMeter.Enabled = false
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
end

v3:GetAttributeChangedSignal(FLYINGTAG):Connect(syncFlyAttribute)
syncFlyAttribute()
