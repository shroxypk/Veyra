-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Environment.TreeDestruction
-- Class: ModuleScript
-- bytes: 14201

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ScaleModel_m = require(ReplicatedStorage.Modules.ScaleModel)
local v2 = Instance.new("Folder")
v2.Name = "client_debris"
v2.Parent = workspace.Map
v2 = if RunService:IsStudio() then 5 else 20
local TreeDestroy = ReplicatedStorage.Remotes.TreeDestroy
local PropDestroy = ReplicatedStorage.Remotes.PropDestroy
local rng = Random.new()
local t = {}
t.__index = t
local BindableEvent = Instance.new("BindableEvent")
t.Broken = BindableEvent.Event

function t.Destroy(_: table, u1: userdata, u2: CFrame, vec1: Vector3) -- line: 38
    -- upvalues:
    --  [1] BindableEvent (copy)
    --  [2] v2 (copy)

    local overlapParams = OverlapParams.new()
    overlapParams.FilterDescendantsInstances = { u1 }
    overlapParams.FilterType = Enum.RaycastFilterType.Exclude
    local v3 = workspace:GetPartBoundsInBox(u2, vec1, overlapParams)
    local Magnitude = vec1.Magnitude
    local t_1 = {}
    local v5

    for _, val in v3 do
        local v4 = val:FindFirstAncestorOfClass("Model")

        if v4 and not t_1[v4] then
            if v4:HasTag("Tree") then
                v5 = "T_Destroyed"
            elseif v4:HasTag("Prop") then
                v5 = "P_Destroyed"
            else
            end

            if not v4:HasTag(v5) then
                local Reset = v4:GetAttribute("Reset")

                if not (Reset ~= true and Reset ~= nil) and not (Magnitude < v4:GetExtentsSize().Magnitude / 3) then
                    t_1[v4] = true
                    v4:SetAttribute("Reset", false)
                    v4:AddTag(v5)
                    BindableEvent:Fire(v4, u1)
                    task.delay(v2, function() -- line: 88
                        -- upvalues:
                        --  [1] v4 (copy)
                        --  [2] v5 (ref)

                        if v4.Parent and v4:HasTag(v5) then
                            v4:RemoveTag(v5)
                        end
                    end)
                end
            end
        end
    end
end

function t.DestroyPart(_: table, u3: userdata, u4: CFrame, arg1: any) -- line: 97
    -- upvalues:
    --  [1] rng (copy)
    --  [2] TweenService (copy)
    --  [3] Services_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] ScaleModel_m (copy)

    local v6 = arg1 and Vector3.new(arg1, arg1, arg1) or Vector3.new(7, 7, 7)
    local overlapParams_1 = OverlapParams.new()
    overlapParams_1.FilterDescendantsInstances = { u3 }
    overlapParams_1.FilterType = Enum.RaycastFilterType.Exclude
    local v7 = workspace:GetPartBoundsInBox(u4, v6, overlapParams_1)
    local tweenInfo = TweenInfo.new(
        0.2,
        Enum.EasingStyle.Bounce,
        Enum.EasingDirection.Out,
        0,
        true
    )
    v6 = {}

    local _ = function() --[[ getBreakVelocity ]] -- line: 116
        -- upvalues:
        --  [1] u3 (copy)
        --  [2] u4 (copy)

        local PrimaryPart = u3.PrimaryPart

        if not PrimaryPart then
            return Vector3.new(0, 0, 0)
        end

        return (u4.Position - PrimaryPart.Position).Unit * 25
    end

    local function playBreakingSound(arg2) -- line: 124
        -- upvalues:
        --  [1] rng (ref)

        local v8 = arg2:FindFirstChild("Breaking", true)

        if not v8 then
            v8 = script.Breaking
        end

        v8 = v8:Clone()
        v8.PlayOnRemove = true
        v8.PlaybackSpeed = v8.PlaybackSpeed + rng:NextNumber(-0.05, 0.05)
        v8.Parent = arg2
        task.delay(0.01, function() -- line: 132
            -- upvalues:
            --  [1] v8 (ref)

            if v8.Parent then
                v8:Destroy()
            end
        end)
    end

    local function breakPart(arg3) -- line: 139
        -- upvalues:
        --  [1] TweenService (ref)
        --  [2] u3 (copy)
        --  [3] u4 (copy)
        --  [4] Services_m (ref)
        --  [5] ReplicatedStorage (ref)

        arg3:SetAttribute("Destroyable", nil)
        local v9 = arg3:GetAttribute("OriginalSize")

        if not v9 then
            v9 = arg3.Size
            arg3:SetAttribute("OriginalSize", v9)
        end

        TweenService:Create(arg3, TweenInfo.new(0.2), { Size = v9 * 0.95 }):Play()

        if arg3.Parent and arg3.Parent.Name == "Reckon_Objective" then
            arg3.CanCollide = false
        else
            arg3.CanCollide = true
            arg3.Anchored = false
        end

        v9 = Instance.new("BodyVelocity")
        v9.MaxForce = Vector3.new(100000, 100000, 100000)
        local PrimaryPart_1 = u3.PrimaryPart
        local v11 = if PrimaryPart_1 then (u4.Position - PrimaryPart_1.Position).Unit * 25 else Vector3.new(0, 0, 0)
        v9.Velocity = v11 + Vector3.new(0, 2, 0)
        v9.Parent = arg3
        Services_m.Debris(v9, 0.1)
        local v12 = arg3:FindFirstChild("BreakSFX") or ReplicatedStorage.SFX.Explosions.RockImpact
        Services_m.PlaySound(v12, arg3)

        if arg3.Parent and arg3.Parent.Name == "Reckon_Objective" then
            arg3.Parent:Destroy()

            return
        end

        task.delay(0.4, function() -- line: 177
            -- upvalues:
            --  [1] arg3 (copy)

            if arg3.Parent then
                _G.ServerTween(
                    arg3,
                    { 0.4, "Quad", Enum.EasingDirection.Out },
                    { Transparency = 1 },
                    true
                )
            end
        end)
    end

    local function breakModel(arg4, arg5) -- line: 189
        -- upvalues:
        --  [1] u3 (copy)
        --  [2] u4 (copy)
        --  [3] Services_m (ref)
        --  [4] ReplicatedStorage (ref)
        --  [5] TweenService (ref)

        arg4:SetAttribute("Destroyable", nil)
        local v13 = arg4.PrimaryPart or arg5
        local PrimaryPart_2 = u3.PrimaryPart
        local v14 = if not PrimaryPart_2 then Vector3.new(0, 0, 0) else (u4.Position - PrimaryPart_2.Position).Unit * 25

        for _, val_1 in arg4:QueryDescendants("BasePart") do
            val_1.Anchored = false

            if val_1 ~= v13 then
                local WeldConstraint = Instance.new("WeldConstraint")
                WeldConstraint.Part0 = v13
                WeldConstraint.Part1 = val_1
                WeldConstraint.Parent = v13
            end
        end

        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(200001, 200001, 200001)
        BodyVelocity.Velocity = v14
        BodyVelocity.Parent = v13
        Services_m.Debris(BodyVelocity, 0.1)
        v13:ApplyImpulseAtPosition(
            u3.PrimaryPart.CFrame.LookVector * v13.AssemblyMass * 10,
            v13.Position + Vector3.new(0, 6, 0)
        )
        local v16 = arg4:FindFirstChild("BreakSFX", true) or ReplicatedStorage.SFX.Explosions.RockImpact
        Services_m.PlaySound(v16, v13)
        task.delay(2, function() -- line: 224
            -- upvalues:
            --  [1] arg4 (copy)
            --  [2] TweenService (ref)
            --  [3] Services_m (ref)

            for _, val_2 in arg4:QueryDescendants("ParticleEmitter, Light") do
                val_2.Enabled = false
            end

            for _, val_3 in arg4:QueryDescendants("BasePart") do
                val_3.Anchored = true
                val_3.CanCollide = false
                TweenService:Create(val_3, TweenInfo.new(0.25), { Transparency = 1 }):Play()
            end

            Services_m.Debris(arg4, 1)
        end)
    end

    local function showDamaged(u5: userdata) -- line: 243
        -- upvalues:
        --  [1] TweenService (ref)

        local v18 = script.Highlight:Clone()
        v18.Parent = u5
        local v20 = TweenService:Create(v18, TweenInfo.new(0.2), { FillTransparency = 1 })
        v20.Completed:Once(function() -- line: 255
            -- upvalues:
            --  [1] v18 (copy)

            v18:Destroy()
        end)
        v20:Play()
    end

    local Destroyable_1
    local v24

    for _, val_4 in v7 do
        local v21 = val_4:FindFirstAncestorOfClass("Model")

        if v21 then
            local Destroyable = v21:GetAttribute("Destroyable")

            if Destroyable then
                if not v6[v21] then
                    v6[v21] = true
                    showDamaged(v21)

                    if Destroyable <= 1 then
                        task.spawn(breakModel, v21, val_4)
                    else
                        v21:SetAttribute("Destroyable", Destroyable - 1)
                        playBreakingSound(v21.PrimaryPart or val_4)
                        local tweenInfo_4 = TweenInfo.new(
                            0.05,
                            Enum.EasingStyle.Bounce,
                            Enum.EasingDirection.Out,
                            0,
                            true,
                            0
                        )
                        ScaleModel_m(v21, v21:GetScale() - rng:NextNumber(0.02, 0.03), tweenInfo_4)
                    end
                end
            else
                Destroyable_1 = val_4:GetAttribute("Destroyable")

                if Destroyable_1 then
                    showDamaged(val_4)

                    if Destroyable_1 <= 1 then
                        breakPart(val_4)
                    else
                        v24 = val_4:GetAttribute("OriginalSize")

                        if not v24 then
                            v24 = val_4.Size
                            val_4:SetAttribute("OriginalSize", v24)
                        end

                        TweenService:Create(val_4, tweenInfo, { Size = v24 * 0.99 }):Play()
                        val_4:SetAttribute("Destroyable", Destroyable_1 - 1)
                        playBreakingSound(val_4)
                    end
                end
            end
        else
            Destroyable_1 = val_4:GetAttribute("Destroyable")

            if Destroyable_1 then
                showDamaged(val_4)

                if Destroyable_1 <= 1 then
                    breakPart(val_4)
                else
                    v24 = val_4:GetAttribute("OriginalSize")

                    if not v24 then
                        v24 = val_4.Size
                        val_4:SetAttribute("OriginalSize", v24)
                    end

                    TweenService:Create(val_4, tweenInfo, { Size = v24 * 0.99 }):Play()
                    val_4:SetAttribute("Destroyable", Destroyable_1 - 1)
                    playBreakingSound(val_4)
                end
            end
        end
    end
end

local _ = function(_, _) --[[ HandleDestroyed ]] -- line: 323
end

local _ = function(_, _) --[[ HandleRestored ]] -- line: 327
end

CollectionService:GetInstanceAddedSignal("P_Destroyed"):Connect(function(arg10) -- line: 331
    -- upvalues:
    --  [1] PropDestroy (copy)

    local Position = arg10:GetPivot().Position
    local v26 = nil

    for _, descendant in arg10:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CastShadow = false
            descendant.CanTouch = false
            descendant.CanQuery = false
            descendant.CanCollide = false
            descendant.Transparency = 1

            if descendant:HasTag(_G.BURNING_TAG) then
                descendant:RemoveTag(_G.BURNING_TAG)
                v26 = "Burning"
            end
        elseif descendant:IsA("Decal") then
            descendant.Transparency = 1
        end
    end

    PropDestroy:FireAllClients(
        "Destroy",
        arg10,
        arg10:GetAttribute("ID"),
        Position,
        v26
    )
end)
CollectionService:GetInstanceRemovedSignal("P_Destroyed"):Connect(function(arg11) -- line: 358
    for _, descendant_1 in arg11:GetDescendants() do
        if descendant_1:IsA("BasePart") then
            descendant_1.CastShadow = true
            descendant_1.CanQuery = true
            descendant_1.CanTouch = descendant_1:GetAttribute("OriginalTouch")
            descendant_1.CanCollide = descendant_1:GetAttribute("OriginalCollide")
            local t_4 = { Transparency = descendant_1:GetAttribute("OriginalTransparency") }
            _G.ServerTween(descendant_1, { 0.5, "Quad", Enum.EasingDirection.Out }, t_4)
        elseif descendant_1:IsA("Decal") then
            local t_6 = { Transparency = descendant_1:GetAttribute("OriginalTransparency") }
            _G.ServerTween(descendant_1, { 0.5, "Quad", Enum.EasingDirection.Out }, t_6)
        end
    end

    task.wait(1)
    arg11:SetAttribute("Reset", true)
end)
CollectionService:GetInstanceAddedSignal("T_Destroyed"):Connect(function(arg12) -- line: 376
    -- upvalues:
    --  [1] TreeDestroy (copy)

    local Position_1 = arg12:GetPivot().Position
    local v27 = nil

    for _, val_5 in arg12:QueryDescendants("BasePart") do
        val_5.CastShadow = false
        val_5.CanTouch = false
        val_5.CanQuery = false
        val_5.CanCollide = false
        val_5.Transparency = 1

        if val_5:HasTag(_G.BURNING_TAG) then
            v27 = "Burning"
            val_5:RemoveTag(_G.BURNING_TAG)
        end
    end

    TreeDestroy:FireAllClients(
        "Destroy",
        arg12,
        arg12:GetAttribute("ID"),
        Position_1,
        v27
    )
end)
CollectionService:GetInstanceRemovedSignal("T_Destroyed"):Connect(function(arg13) -- line: 397
    -- upvalues:
    --  [1] TreeDestroy (copy)

    TreeDestroy:FireAllClients("Restore", arg13, (arg13:GetAttribute("ID")))

    for _, val_6 in arg13:QueryDescendants("BasePart") do
        val_6.CastShadow = true
        val_6.CanQuery = true
        val_6.CanTouch = val_6:GetAttribute("OriginalTouch")
        val_6.CanCollide = val_6:GetAttribute("OriginalCollide")
        local t_8 = { Transparency = val_6:GetAttribute("OriginalTransparency") }
        _G.ServerTween(val_6, { 0.5, "Quad", Enum.EasingDirection.Out }, t_8)
    end

    task.wait(1)
    arg13:SetAttribute("Reset", true)
end)

return t
