-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Headless.HeadlessFxUtil
-- Class: ModuleScript
-- bytes: 12915

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local CameraShaker_m = require(Modules:FindFirstChild("CameraShaker"))
VFX_m.init()
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 22
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v2:Start()
local t = {
    Near = function(vec1: Vector3, n1: number?) --[[ Near ]] -- line: 32
        -- upvalues:
        --  [1] CurrentCamera (copy)

        return (CurrentCamera.CFrame.Position - vec1).Magnitude <= (n1 or 600)
    end
}

function t.Feet(u1: userdata?) -- line: 39
    -- upvalues:
    --  [1] t (copy)

    local v4 = u1

    if v4 then
        v4 = u1:FindFirstChild("HumanoidRootPart")
    end

    local v5 = v4

    if v5 then
        v5 = v4:FindFirstChild("VFXRoot")
    end

    if v5 then
        if not t.Near(v5.WorldPosition) then
            return nil
        end

        v4 = v5.WorldCFrame
        v5 = v4.LookVector

        return CFrame.lookAt(v4.Position, v4.Position + Vector3.new(v5.X, 0, v5.Z))
    else
        return nil
    end
end

function t.Shake(
    vec2: Vector3,
    n2: number,
    n3: number,
    n4: number,
    n5: number?
) -- line: 50
    -- upvalues:
    --  [1] t (copy)
    --  [2] v2 (copy)

    if t.Near(vec2, n5 or 150) then
        v2:ShakeOnce(n2, n3, 0, n4)
    end
end

function t.FindBone(u2: userdata, s1: string) -- line: 56
    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("Bone") and descendant.Name == s1 then
            return descendant
        end
    end

    return nil
end

function t.Emit(u3: userdata, n6: number?) -- line: 66
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    local clock = os.clock()
    ForgeVFX_m.emit(u3).Finished:catch(function(arg2) -- line: 69
        -- upvalues:
        --  [1] u3 (copy)

        local g_warn = warn
        local v6 = u3:GetFullName()
        g_warn(`[Headless] emit failed for {v6}: {arg2}`)
    end):finally(function() -- line: 72
        -- upvalues:
        --  [1] n6 (copy)
        --  [2] clock (copy)
        --  [3] u3 (copy)

        local v9 = (n6 or 0) - (os.clock() - clock)

        if v9 > 0 then
            task.delay(v9, u3.Destroy, u3)

            return
        end

        u3:Destroy()
    end)
end

local function hasConstantEffect(u4: userdata) -- line: 82
    if u4:HasTag("ConstantVFX") then
        return true
    end

    for _, descendant_1 in u4:GetDescendants() do
        if descendant_1:HasTag("ConstantVFX") then
            return true
        end
    end

    return false
end

function t.Enable(u5: userdata, b1: boolean?) -- line: 97
    -- upvalues:
    --  [1] ForgeVFX_m (copy)
    --  [2] hasConstantEffect (copy)

    if b1 then
        ForgeVFX_m.emit(u5)
    end

    if hasConstantEffect(u5) then
        task.defer(function() -- line: 103
            -- upvalues:
            --  [1] u5 (copy)
            --  [2] ForgeVFX_m (ref)

            if u5.Parent then
                ForgeVFX_m.enable(u5)
            end
        end)

        return
    end

    ForgeVFX_m.enable(u5)
end

function t.Disable(u6: userdata) -- line: 114
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    ForgeVFX_m.disable(u6)
end

function t.Stop(u7: userdata?) -- line: 119
    -- upvalues:
    --  [1] ForgeVFX_m (copy)
    --  [2] Debris (copy)

    if not u7 or not u7.Parent then
        return
    end

    ForgeVFX_m.disable(u7)
    local v10 = 0

    for _, descendant_2 in u7:GetDescendants() do
        if descendant_2:IsA("ParticleEmitter") then
            v10 = math.max(v10, descendant_2.Lifetime.Max)
        end
    end

    Debris:AddItem(u7, v10 + 0.1)
end

function t.Remove(u8: userdata?) -- line: 134
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    if not u8 or not u8.Parent then
        return
    end

    ForgeVFX_m.disable(u8)

    for _, val in u8:IsA("ParticleEmitter") and { u8 } or u8:GetDescendants() do
        if val:IsA("ParticleEmitter") then
            val:Clear()
        end
    end

    u8:Destroy()
end

function t.ScaleParticles(u9: userdata, n7: number) -- line: 148
    for _, descendant_3 in u9:GetDescendants() do
        if descendant_3:IsA("ParticleEmitter") then
            local t_1 = {}

            for _, val_1 in descendant_3.Size.Keypoints do
                table.insert(
                    t_1,
                    NumberSequenceKeypoint.new(val_1.Time, val_1.Value * n7, val_1.Envelope * n7)
                )
            end

            descendant_3.Size = NumberSequence.new(t_1)
        elseif descendant_3:IsA("Attachment") then
            descendant_3.Position *= n7
        end
    end
end

local function prepare(u10: userdata) -- line: 162
    local v13 = u10:IsA("BasePart") and { u10 } or {}

    for _, descendant_4 in u10:GetDescendants() do
        if descendant_4:IsA("BasePart") then
            table.insert(v13, descendant_4)
        end
    end

    for _, val_2 in v13 do
        val_2.Anchored = true
        val_2.CanCollide = false
        val_2.CanQuery = false
        val_2.CanTouch = false
    end
end

local function turnAccelerations(u11: userdata, u12: CFrame) -- line: 180
    for _, descendant_5 in u11:GetDescendants() do
        if descendant_5:IsA("ParticleEmitter") and descendant_5.Acceleration ~= Vector3.new(0, 0, 0) then
            descendant_5.Acceleration = u12:VectorToWorldSpace(descendant_5.Acceleration)
        end
    end
end

function t.Spawn(u13: userdata, u14: CFrame) -- line: 189
    -- upvalues:
    --  [1] prepare (copy)
    --  [2] turnAccelerations (copy)

    local v14 = u13:Clone()
    prepare(v14)

    if v14:IsA("Model") then
        turnAccelerations(v14, (u14 * v14:GetPivot():Inverse()).Rotation)
        v14:PivotTo(u14)
    elseif v14:IsA("BasePart") then
        v14.Transparency = 1
        local v16 = u14 * v14.CFrame:Inverse()

        for _, descendant_6 in v14:GetDescendants() do
            if descendant_6:IsA("BasePart") then
                descendant_6.CFrame = v16 * descendant_6.CFrame
            end
        end

        v14.CFrame = u14
        turnAccelerations(v14, v16.Rotation)
    end

    v14.Parent = workspace.Effects

    return v14
end

function t.Place(u15: userdata, u16: CFrame) -- line: 213
    -- upvalues:
    --  [1] t (copy)

    local v17 = u15:GetAttribute("Offset") or CFrame.identity

    return t.PlaceAt(u15, u16 * v17)
end

function t.PlaceAt(u17: userdata, u18: CFrame) -- line: 219
    -- upvalues:
    --  [1] t (copy)

    local v18 = t.Spawn(u17, u18)
    t.Emit(v18)

    return v18
end

function t.PlaceScaled(u19: userdata, u20: CFrame, n8: number) -- line: 226
    -- upvalues:
    --  [1] prepare (copy)
    --  [2] turnAccelerations (copy)
    --  [3] t (copy)

    local Model = Instance.new("Model")
    Model.Name = u19.Name
    local v19 = u19:Clone()
    prepare(v19)

    if v19:IsA("BasePart") then
        v19.Transparency = 1
    end

    v19.Parent = Model

    if v19:IsA("BasePart") then
        Model.PrimaryPart = v19
    end

    turnAccelerations(Model, (u20 * Model:GetPivot():Inverse()).Rotation)
    Model:PivotTo(u20)

    if n8 ~= 1 then
        Model:ScaleTo(n8)
    end

    Model.Parent = workspace.Effects
    t.Emit(Model)

    return Model
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
local v21 = false

local function groundParams() -- line: 252
    -- upvalues:
    --  [1] v21 (ref)
    --  [2] raycastParams (copy)

    if not v21 then
        local HalloweenIsland = workspace:FindFirstChild("HalloweenIsland")
        v21 = if HalloweenIsland == nil then false else true
        raycastParams.FilterDescendantsInstances = {
            workspace:FindFirstChild("Map"),
            workspace.Terrain,
            HalloweenIsland
        }
    end

    return raycastParams
end

function t.GroundY(vec3: Vector3, n9: number) -- line: 262
    -- upvalues:
    --  [1] groundParams (copy)

    local v27 = workspace:Raycast(
        vec3 + Vector3.new(0, 40, 0),
        Vector3.new(0, -200, 0),
        (groundParams())
    )

    return v27 and v27.Position.Y or n9
end

function t.FadeOut(u21: userdata?, n10: number?) -- line: 268
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] Debris (copy)

    if not u21 or not u21.Parent then
        return
    end

    local tweenInfo = TweenInfo.new(n10 or 0.2)
    TweenService:Create(u21, tweenInfo, { Transparency = 1 }):Play()

    for _, descendant_7 in u21:GetDescendants() do
        if descendant_7:IsA("BasePart") then
            TweenService:Create(descendant_7, tweenInfo, { Transparency = 1 }):Play()
        end
    end

    Debris:AddItem(u21, (n10 or 0.2) + 0.05)
end

function t.Highlight(u22: userdata, u23: userdata, n11: number, n12: number) -- line: 283
    -- upvalues:
    --  [1] TweenService (copy)

    local v30 = u23:Clone()
    v30.Adornee = u22
    v30.FillTransparency = 1
    v30.OutlineTransparency = 1
    v30.Parent = u22
    TweenService:Create(
        v30,
        TweenInfo.new(0.3),
        { FillTransparency = n11, OutlineTransparency = n12 }
    ):Play()

    return v30
end

function t.RemoveHighlight(u24: userdata?) -- line: 293
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] Debris (copy)

    if not u24 or not u24.Parent then
        return
    end

    TweenService:Create(u24, TweenInfo.new(0.3), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
    Debris:AddItem(u24, 0.35)
end

local Sounds = script.Parent:WaitForChild("Sounds")
local rng = Random.new()

local function pick(s2: string) -- line: 309
    -- upvalues:
    --  [1] Sounds (copy)
    --  [2] rng (copy)

    local v33 = Sounds:FindFirstChild(s2)
    local v34

    if v33 and v33:IsA("Folder") then
        v34 = v33:GetChildren()
        local v35 = v34[1]

        if v35 then
            v35 = v34[rng:NextInteger(1, #v34)]
        end

        v33 = v35
    end

    v34 = v33 and (v33:IsA("Sound") and v33) or nil

    return v34
end

function t.Sound(s3: string, arg3: any, n13: number?) -- line: 320
    -- upvalues:
    --  [1] pick (copy)
    --  [2] t (copy)
    --  [3] Debris (copy)

    local v37 = pick(s3)

    if not v37 then
        return nil
    end

    local v38 = if typeof(arg3) == "Instance" then arg3.Position else arg3
    local v39, v40

    if typeof(arg3) == "Instance" then
        if arg3.Parent then
            if not t.Near(v38) then
                return nil
            end

            v38 = arg3
            v39 = nil

            if typeof(arg3) ~= "Instance" then
                v39 = Instance.new("Attachment")
                v39.Name = "HeadlessSound"
                v39.WorldPosition = arg3
                v39.Parent, v38 = workspace.Terrain, v39
            end

            v40 = v37:Clone()
            v40.Looped = false
            v40.TimePosition = n13 or 0
            v40.Parent = v38
            v40:Play()
            local v41 = v39 or v40
            v40.Ended:Once(function() -- line: 344
                -- upvalues:
                --  [1] v41 (copy)

                v41:Destroy()
            end)
            Debris:AddItem(v41, 30)

            return v40
        else
            return nil
        end
    else
        if not t.Near(v38) then
            return nil
        end

        local v42 = arg3
        v39 = nil

        if typeof(arg3) ~= "Instance" then
            v39 = Instance.new("Attachment")
            v39.Name = "HeadlessSound"
            v39.WorldPosition = arg3
            v39.Parent, v42 = workspace.Terrain, v39
        end

        v40 = v37:Clone()
        v40.Looped = false
        v40.TimePosition = n13 or 0
        v40.Parent = v42
        v40:Play()
        local v43 = v39 or v40
        v40.Ended:Once(function() -- line: 344
            -- upvalues:
            --  [1] v43 (copy)

            v43:Destroy()
        end)
        Debris:AddItem(v43, 30)

        return v40
    end
end

function t.LoopSound(s4: string, u25: userdata) -- line: 353
    -- upvalues:
    --  [1] pick (copy)

    local v44 = pick(s4)

    if not v44 or not u25.Parent then
        return nil
    end

    local v45 = v44:Clone()
    v45.Looped = true
    v45.Parent = u25
    v45:Play()

    return v45
end

function t.StopSound(u26: userdata?, n14: number?) -- line: 366
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] Debris (copy)

    if not u26 or not u26.Parent then
        return
    end

    n14 = n14 or 0.25
    TweenService:Create(u26, TweenInfo.new(n14), { Volume = 0 }):Play()
    Debris:AddItem(u26, n14 + 0.05)
end

return t
