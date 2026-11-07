-- Decompiled with Veyra harvester
-- Instance: StarterGui.HalloweenUI.BloodMoonAtmosphere
-- Class: LocalScript
-- bytes: 7673

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local _ = function(arg1, arg2) --[[ box ]] -- line: 22
    local Part = Instance.new("Part")
    Part.Name = arg1
    Part.Size = arg2
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false

    return Part
end

local function sequence(arg3) -- line: 35
    local t = {}

    for _, val in arg3 do
        table.insert(t, NumberSequenceKeypoint.new(val[1], val[2]))
    end

    return NumberSequence.new(t)
end

local Fog_ParticleEmitter = Instance.new("ParticleEmitter")
Fog_ParticleEmitter.Name = "Fog"
Fog_ParticleEmitter.Texture = "rbxassetid://12865656309"
Fog_ParticleEmitter.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
Fog_ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(130, 61, 62))
Fog_ParticleEmitter.Brightness = 0.5
Fog_ParticleEmitter.Transparency = sequence({ { 0, 1 }, { 0.21, 0.86 }, { 0.79, 0.86 }, { 1, 1 } })
Fog_ParticleEmitter.Size = NumberSequence.new(14)
Fog_ParticleEmitter.Lifetime = NumberRange.new(8.5)
Fog_ParticleEmitter.Rate = 2.5
Fog_ParticleEmitter.Speed = NumberRange.new(2)
Fog_ParticleEmitter.EmissionDirection = Enum.NormalId.Left
Fog_ParticleEmitter.Rotation = NumberRange.new(-360, 360)
Fog_ParticleEmitter.RotSpeed = NumberRange.new(-45, -20)
Fog_ParticleEmitter.LightEmission = 0
Fog_ParticleEmitter.LightInfluence = 0
Fog_ParticleEmitter.Shape = Enum.ParticleEmitterShape.Box
Fog_ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
Fog_ParticleEmitter.LockedToPart = false
Fog_ParticleEmitter.Enabled = false
local BloodMoonFog_Folder = Instance.new("Folder")
BloodMoonFog_Folder.Name = "BloodMoonFog"
local t_1 = {}

for index = 1, 4 do
    for index_1 = 1, 4 do
        local v1 = `Tile{index}_{index_1}`
        local Part_1 = Instance.new("Part")
        Part_1.Name = v1
        Part_1.Size = Vector3.new(50, 2, 50)
        Part_1.Transparency = 1
        Part_1.Anchored = true
        Part_1.CanCollide = false
        Part_1.CanQuery = false
        Part_1.CanTouch = false
        Part_1.CastShadow = false
        local v2 = Fog_ParticleEmitter:Clone()
        v2.Parent = Part_1
        Part_1.Parent = BloodMoonFog_Folder
        table.insert(
            t_1,
            {
                box = Part_1,
                emitter = v2,
                offset = Vector3.new((index - 2.5) * 50, 0, (index_1 - 2.5) * 50)
            }
        )
    end
end

Fog_ParticleEmitter:Destroy()
local Part_2 = Instance.new("Part")
Part_2.Name = "BloodMoonSpecks"
Part_2.Size = Vector3.new(120, 40, 120)
Part_2.Transparency = 1
Part_2.Anchored = true
Part_2.CanCollide = false
Part_2.CanQuery = false
Part_2.CanTouch = false
Part_2.CastShadow = false
local ParticleEmitter_1 = Instance.new("ParticleEmitter")
ParticleEmitter_1.Name = "Specks"
ParticleEmitter_1.Texture = "rbxassetid://16803198291"
ParticleEmitter_1.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
ParticleEmitter_1.FlipbookMode = Enum.ParticleFlipbookMode.Loop
ParticleEmitter_1.FlipbookFramerate = NumberRange.new(3)
local New_1 = ColorSequence.new
local color = Color3.fromRGB(255, 45, 40)
ParticleEmitter_1.Color = New_1(color, Color3.fromRGB(170, 20, 25))
ParticleEmitter_1.Size = sequence({ { 0, 0 }, { 0.15, 0.4 }, { 0.85, 0.32 }, { 1, 0 } })
ParticleEmitter_1.Transparency = NumberSequence.new(0.15)
ParticleEmitter_1.Lifetime = NumberRange.new(6, 9)
ParticleEmitter_1.Rate = 60
ParticleEmitter_1.Speed = NumberRange.new(0.3, 0.8)
ParticleEmitter_1.SpreadAngle = Vector2.new(180, 180)
ParticleEmitter_1.Acceleration = Vector3.new(0, 0.15, 0)
ParticleEmitter_1.Drag = 0.5
ParticleEmitter_1.Rotation = NumberRange.new(0, 360)
ParticleEmitter_1.RotSpeed = NumberRange.new(-60, 60)
ParticleEmitter_1.LightEmission = 1
ParticleEmitter_1.LightInfluence = 0.25
ParticleEmitter_1.Brightness = 10
ParticleEmitter_1.Shape = Enum.ParticleEmitterShape.Box
ParticleEmitter_1.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
ParticleEmitter_1.LockedToPart = false
ParticleEmitter_1.Enabled = false
ParticleEmitter_1.Parent = Part_2
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local v3 = false

local function follow() -- line: 113
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] raycastParams (copy)
    --  [3] t_1 (copy)
    --  [4] v3 (ref)
    --  [5] Part_2 (copy)

    local Character = LocalPlayer.Character
    local v4 = Character

    if v4 then
        v4 = Character:FindFirstChild("HumanoidRootPart")
    end

    if not v4 then
        return
    end

    local Position = v4.Position
    raycastParams.FilterDescendantsInstances = { Character, workspace.CurrentCamera }

    for _, val_1 in t_1 do
        v4 = Position + val_1.offset
        local v6 = workspace:Raycast(
            v4 + Vector3.new(0, 8, 0),
            Vector3.new(0, -88, 0),
            raycastParams
        )

        if v6 then
            val_1.box.CFrame = CFrame.new(v4.X, v6.Position.Y - 1.5, v4.Z)
        end

        local v7 = v3 and v6 ~= nil
        val_1.emitter.Enabled = v7
    end

    Part_2.CFrame = CFrame.new(Position)
end

local v9 = 0

local _ = function() --[[ onIsland ]] -- line: 138
    -- upvalues:
    --  [1] Lighting (copy)

    local Atmosphere = Lighting:FindFirstChildWhichIsA("Atmosphere")

    return if Atmosphere ~= nil then if Atmosphere:GetAttribute("Active") ~= "GravelightIsle" then false else true else false
end

local function update() -- line: 143
    -- upvalues:
    --  [1] Lighting (copy)
    --  [2] v3 (ref)
    --  [3] v9 (ref)
    --  [4] ParticleEmitter_1 (copy)
    --  [5] t_1 (copy)
    --  [6] follow (copy)
    --  [7] BloodMoonFog_Folder (copy)
    --  [8] Part_2 (copy)

    local v11 = true

    if Lighting:GetAttribute("BloodMoonLit") ~= true then
        local Atmosphere_1 = Lighting:FindFirstChildWhichIsA("Atmosphere")
        v11 = if Atmosphere_1 ~= nil then if Atmosphere_1:GetAttribute("Active") ~= "GravelightIsle" then false else true else false
    end

    if v11 == v3 then
        return
    end

    v3 = v11
    v9 += 1
    local v12 = v9
    ParticleEmitter_1.Enabled = v11

    for _, val_2 in t_1 do
        val_2.emitter.Enabled = false
    end

    follow()

    if v11 then
        BloodMoonFog_Folder.Parent = workspace.CurrentCamera
        Part_2.Parent = workspace.CurrentCamera
    end

    task.spawn(function() -- line: 163
        -- upvalues:
        --  [1] v11 (copy)
        --  [2] v9 (ref)
        --  [3] v12 (copy)
        --  [4] follow (ref)
        --  [5] BloodMoonFog_Folder (ref)
        --  [6] Part_2 (ref)

        local v13 = not v11 and os.clock() + 9

        while true do
            if v9 ~= v12 then
                break
            end

            if not v11 and not (v13 > os.clock()) then
                break
            end

            follow()
            task.wait(0.25)
        end

        if v9 == v12 and not v11 then
            BloodMoonFog_Folder.Parent = nil
            Part_2.Parent = nil
        end
    end)
end

Lighting:GetAttributeChangedSignal("BloodMoonLit"):Connect(update)

local function watchAtmosphere(arg4) -- line: 177
    -- upvalues:
    --  [1] update (copy)

    if arg4:IsA("Atmosphere") then
        arg4:GetAttributeChangedSignal("Active"):Connect(update)
    end
end

for _, child in Lighting:GetChildren() do
    if child:IsA("Atmosphere") then
        child:GetAttributeChangedSignal("Active"):Connect(update)
    end
end

Lighting.ChildAdded:Connect(watchAtmosphere)
update()
