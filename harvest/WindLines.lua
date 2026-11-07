-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.WindShakeController.WindLines
-- Class: ModuleScript
-- bytes: 8300

local RunService = game:GetService("RunService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local t = { UpdateConnection = nil, UpdateQueue = table.create(10), Enabled = true }
local t_1 = {}
t.Style = {
    Textures = { { Texture = "rbxassetid://12251461261", Weight = 1 } },
    WidthMin = 0.8,
    WidthMax = 1.1,
    RandomFlip = true,
    SpawnDistanceMin = 35,
    SpawnDistanceMax = 90,
    TrailLength = 20,
    LifetimeVariation = 0.5,
    EndFadeTime = 0.4,
    Transparency = 0.6,
    FadeEnds = true,
    FadeEndsAmount = 0.25,
    LightEmission = 0.2,
    Color = Color3.fromRGB(255, 255, 255)
}

local function pickTexture() -- line: 39
    -- upvalues:
    --  [1] t (copy)

    local Textures = t.Style.Textures

    if not Textures or #Textures == 0 then
        return ""
    end

    local v1 = 0

    for _, val in Textures do
        v1 += val.Weight or 1
    end

    local v2 = math.random() * v1

    for _, val_1 in Textures do
        v2 -= val_1.Weight or 1

        if v2 <= 0 then
            return val_1.Texture
        end
    end

    return Textures[1].Texture
end

local _ = function(arg1) --[[ destroyLine ]] -- line: 58
    arg1.Attachment0:Destroy()
    arg1.Attachment1:Destroy()
    arg1.Trail:Destroy()
end

local function setLineTransparency(arg2, arg3) -- line: 64
    -- upvalues:
    --  [1] t (copy)

    local BaseTransparency = arg2.BaseTransparency
    local v3 = BaseTransparency + (1 - BaseTransparency) * arg3

    if t.Style.FadeEnds then
        local v4 = math.clamp(t.Style.FadeEndsAmount or 0.25, 0.01, 0.49)
        arg2.Trail.Transparency = NumberSequence.new(
            {
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(v4, v3),
                NumberSequenceKeypoint.new(1 - v4, v3),
                NumberSequenceKeypoint.new(1, 1)
            }
        )

        return
    end

    arg2.Trail.Transparency = NumberSequence.new(v3)
end

function t.Init(_, arg5) -- line: 81
    -- upvalues:
    --  [1] t (copy)
    --  [2] RunService (copy)
    --  [3] setLineTransparency (copy)

    t.Lifetime = arg5.Lifetime or 3
    t.Direction = arg5.Direction or Vector3.new(1, 0, 0)
    t.Speed = arg5.Speed or 6

    if t.UpdateConnection then
        t.UpdateConnection:Disconnect()
        t.UpdateConnection = nil
    end

    for _, val_2 in t.UpdateQueue do
        val_2.Attachment0:Destroy()
        val_2.Attachment1:Destroy()
        val_2.Trail:Destroy()
    end

    table.clear(t.UpdateQueue)
    t.LastSpawned = os.clock()
    local v6 = 1 / (arg5.SpawnRate or 25)
    t.UpdateConnection = RunService.Heartbeat:Connect(function() -- line: 102
        -- upvalues:
        --  [1] t (ref)
        --  [2] v6 (copy)
        --  [3] setLineTransparency (ref)

        local clock = os.clock()

        if t.Enabled and clock - t.LastSpawned > v6 then
            t:Create()
            t.LastSpawned = clock
        end

        debug.profilebegin("Wind Lines")
        local UpdateQueue = t.UpdateQueue

        for index = #UpdateQueue, 1, -1 do
            local v7 = UpdateQueue[index]
            local v8 = clock - v7.StartClock
            local v9 = 0

            if not v7.FadeStart and v8 >= v7.Lifetime - v7.EndFadeTime then
                v7.FadeStart = v7.StartClock + v7.Lifetime - v7.EndFadeTime
                v7.FadeDuration = v7.EndFadeTime
            end

            if v7.FadeStart then
                v9 = math.clamp((clock - v7.FadeStart) / v7.FadeDuration, 0, 1)
            end

            if v8 >= v7.Lifetime or v9 >= 1 then
                v7.Attachment0:Destroy()
                v7.Attachment1:Destroy()
                v7.Trail:Destroy()
                local v10 = #UpdateQueue
                UpdateQueue[index] = UpdateQueue[v10]
                UpdateQueue[v10] = nil
            else
                if v7.FadeStart then
                    setLineTransparency(v7, v9)
                end

                v9 = (clock + v7.Seed) * (v7.Speed * 0.2)
                local Position = v7.Position
                local Attachment0 = v7.Attachment0
                local Position_1 = (CFrame.new(Position, Position + v7.Direction) * CFrame.new(
                    0,
                    0,
                    v7.Speed * -v8
                )).Position
                local v11 = math.sin(v9) * 0.5
                Attachment0.WorldPosition = Position_1 + Vector3.new(
                    v11,
                    math.sin(v9) * 0.8,
                    math.sin(v9) * 0.5
                )
                v7.Attachment1.WorldPosition = v7.Attachment0.WorldPosition + v7.Offset
            end
        end

        debug.profileend()
    end)
end

function t.Cleanup(_) -- line: 161
    -- upvalues:
    --  [1] t (copy)

    if t.UpdateConnection then
        t.UpdateConnection:Disconnect()
        t.UpdateConnection = nil
    end

    for _, val_3 in t.UpdateQueue do
        val_3.Attachment0:Destroy()
        val_3.Attachment1:Destroy()
        val_3.Trail:Destroy()
    end

    table.clear(t.UpdateQueue)
end

function t.ClearLines(_) -- line: 174
    -- upvalues:
    --  [1] t (copy)

    for _, val_4 in t.UpdateQueue do
        val_4.Attachment0:Destroy()
        val_4.Attachment1:Destroy()
        val_4.Trail:Destroy()
    end

    table.clear(t.UpdateQueue)
end

function t.FadeOutLines(_, arg9) -- line: 182
    -- upvalues:
    --  [1] t (copy)

    arg9 = arg9 or 0.5
    local clock_1 = os.clock()

    for _, val_5 in t.UpdateQueue do
        if not val_5.FadeStart then
            val_5.FadeStart = clock_1
            val_5.FadeDuration = arg9
        end
    end
end

function t.Create(_, arg11) -- line: 193
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t (copy)
    --  [3] pickTexture (copy)
    --  [4] setLineTransparency (copy)
    --  [5] Terrain (copy)

    debug.profilebegin("Add Wind Line")
    local v14 = arg11 or t_1
    arg11 = v14
    v14 = t.Style
    local v15 = arg11.Lifetime or t.Lifetime
    local v16 = arg11.Position or workspace.CurrentCamera.CFrame * CFrame.Angles(
        math.rad((math.random(-30, 70))),
        math.rad((math.random(-80, 80))),
        0
    ) * CFrame.new(
        0,
        0,
        -(v14.SpawnDistanceMin + math.random() * (v14.SpawnDistanceMax - v14.SpawnDistanceMin))
    ).Position
    local v21 = arg11.Direction or t.Direction
    local v23 = arg11.Speed or t.Speed

    if v23 <= 0 then
        debug.profileend()

        return
    end

    local v25 = v14.WidthMin + math.random() * (v14.WidthMax - v14.WidthMin)
    local v26 = if not v14.RandomFlip then 1 else if not (math.random() < 0.5) then 1 else -1
    local v27 = Vector3.new(0, 1, 0) * v25 * v26
    v26 = Instance.new("Attachment")
    local Attachment = Instance.new("Attachment")
    local Trail_2 = Instance.new("Trail")
    Trail_2.Attachment0 = v26
    Trail_2.Attachment1 = Attachment
    Trail_2.WidthScale = NumberSequence.new(
        {
            NumberSequenceKeypoint.new(0, 0.3),
            NumberSequenceKeypoint.new(0.2, 1),
            NumberSequenceKeypoint.new(0.8, 1),
            NumberSequenceKeypoint.new(1, 0.3)
        }
    )
    Trail_2.Texture = pickTexture()
    Trail_2.TextureMode = Enum.TextureMode.Stretch
    Trail_2.TextureLength = 1
    Trail_2.LightEmission = v14.LightEmission
    Trail_2.Color = ColorSequence.new(v14.Color)
    Trail_2.FaceCamera = true
    Trail_2.MaxLength = 0
    Trail_2.Lifetime = v14.TrailLength / math.max(v23, 1)
    Trail_2.Parent = v26
    v26.WorldPosition = v16
    Attachment.WorldPosition = v16 + v27
    local t_5 = {
        Attachment0 = v26,
        Attachment1 = Attachment,
        Trail = Trail_2,
        Offset = v27,
        EndFadeTime = v14.EndFadeTime,
        BaseTransparency = v14.Transparency,
        Lifetime = math.max(
            v15 + (math.random() * 2 - 1) * v14.LifetimeVariation,
            v14.EndFadeTime + 0.5
        ),
        Position = v16,
        Direction = v21,
        Speed = v23 + math.random(-10, 10) * 0.1,
        StartClock = os.clock(),
        Seed = math.random(1, 1000) * 0.1
    }
    setLineTransparency(t_5, 0)
    t.UpdateQueue[#t.UpdateQueue + 1] = t_5
    v26.Parent = Terrain
    Attachment.Parent = Terrain
    debug.profileend()
end

return t
