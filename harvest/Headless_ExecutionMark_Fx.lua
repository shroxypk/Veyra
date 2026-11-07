-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Headless.Headless_ExecutionMark_Fx
-- Class: ModuleScript
-- bytes: 7172

local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local HeadlessFxUtil_m = require(script.Parent.HeadlessFxUtil)
local Assets = script.Assets
local t = setmetatable({}, { __mode = "k" })

local _ = function(u1: userdata) --[[ removeSigil ]] -- line: 21
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)

    local v1 = t[u1]
    t[u1] = nil

    if v1 then
        for _, val in v1 do
            HeadlessFxUtil_m.Stop(val)
        end
    end
end

local function addSigil(u2: userdata) -- line: 31
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] Assets (copy)

    local v2 = t[u2]
    t[u2] = nil

    if v2 then
        for _, val_1 in v2 do
            HeadlessFxUtil_m.Stop(val_1)
        end
    end

    v2 = u2

    if v2 then
        v2 = u2:FindFirstChild("HumanoidRootPart")
    end

    local cframe, t_1

    if v2 then
        if not HeadlessFxUtil_m.Near(v2.Position) then
            return
        end

        cframe = CFrame.new(0, 2, 0)
        local v4 = Assets.Sigil:GetAttribute("Offset")

        if not v4 then
            v4 = CFrame.new(0, 3.5, 0)
        end

        local v5 = cframe * v4
        local v6 = Assets.Sigil:Clone()
        t_1 = {}

        for _, child in v6:GetChildren() do
            if child:IsA("Attachment") then
                child.CFrame = v5 * child.CFrame
                HeadlessFxUtil_m.ScaleParticles(child, 2)

                for _, descendant in child:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.LockedToPart = true
                    end
                end

                child.Parent = v2
                HeadlessFxUtil_m.Enable(child, true)
                table.insert(t_1, child)
            end
        end

        v6:Destroy()
        t[u2] = t_1
        task.delay(8, function() -- line: 59
            -- upvalues:
            --  [1] t (ref)
            --  [2] u2 (copy)
            --  [3] t_1 (copy)
            --  [4] HeadlessFxUtil_m (ref)

            if t[u2] == t_1 then
                local v7 = u2
                local v8 = t[v7]
                t[v7] = nil

                if v8 then
                    for _, val_2 in v8 do
                        HeadlessFxUtil_m.Stop(val_2)
                    end
                end
            end
        end)

        return
    else
        return
    end
end

local function spawnHand(u3: userdata, vec1: Vector3, vec2: Vector3) -- line: 66
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] t (copy)
    --  [3] Assets (copy)
    --  [4] Debris (copy)
    --  [5] TweenService (copy)

    if not HeadlessFxUtil_m.Near(vec1) then
        local v11 = t[u3]
        t[u3] = nil

        if v11 then
            for _, val_4 in v11 do
                HeadlessFxUtil_m.Stop(val_4)
            end
        end

        return
    end

    local cframe_1 = CFrame.lookAt(vec1, vec1 + vec2)

    local _ = function(u4: CFrame) --[[ scaled ]] -- line: 73
        -- upvalues:
        --  [1] cframe_1 (copy)

        return cframe_1 * CFrame.new(u4.Position * 1.6) * u4.Rotation
    end

    HeadlessFxUtil_m.Sound("ExecutionMarkHand", vec1)
    local v14 = Assets.SpectralHand:Clone()
    v14.PrimaryPart = v14:FindFirstChildWhichIsA("MeshPart")
    v14:ScaleTo(1.6)
    local v15 = Assets.SpectralHand:GetAttribute("Offset") or CFrame.identity
    v14:PivotTo(cframe_1 * CFrame.new(v15.Position * 1.6) * v15.Rotation)
    v14.Parent = workspace.Effects
    HeadlessFxUtil_m.Enable(v14)
    Debris:AddItem(v14, 4)

    local function slam() -- line: 90
        -- upvalues:
        --  [1] u3 (copy)
        --  [2] t (ref)
        --  [3] HeadlessFxUtil_m (ref)
        --  [4] v14 (copy)
        --  [5] Assets (ref)
        --  [6] cframe_1 (copy)
        --  [7] vec1 (copy)

        local v17 = u3
        local v18 = t[v17]
        t[v17] = nil

        if v18 then
            for _, val_5 in v18 do
                HeadlessFxUtil_m.Stop(val_5)
            end
        end

        HeadlessFxUtil_m.Disable(v14)
        local HandImpact = Assets["Hand Impact"]
        local PlaceScaled = HeadlessFxUtil_m.PlaceScaled
        local v19 = HandImpact:GetAttribute("Offset") or CFrame.identity
        PlaceScaled(HandImpact, cframe_1 * CFrame.new(v19.Position * 1.6) * v19.Rotation, 1.6)
        HeadlessFxUtil_m.Shake(
            vec1,
            5,
            12,
            0.6,
            120
        )
    end

    local AnimationController = v14:FindFirstChildOfClass("AnimationController")
    local v23 = AnimationController

    if v23 then
        v23 = AnimationController:FindFirstChildOfClass("Animator")
    end

    local v24 = v23

    if not v24 then
        task.delay(1.0434782608695652, slam)

        return
    end

    local v26 = v24:LoadAnimation(script.SpectralHand)
    local v27 = false
    v26:GetMarkerReachedSignal("Slam"):Once(function() -- line: 107
        -- upvalues:
        --  [1] v27 (ref)
        --  [2] slam (copy)

        v27 = true
        slam()
    end)
    v26:GetMarkerReachedSignal("Sink"):Once(function() -- line: 111
        -- upvalues:
        --  [1] v14 (copy)
        --  [2] TweenService (ref)

        for _, descendant_2 in v14:GetDescendants() do
            if descendant_2:IsA("BasePart") then
                TweenService:Create(descendant_2, TweenInfo.new(0.4), { Transparency = 1 }):Play()
            end
        end
    end)
    v26:Play(0, 1, 1.15)
    task.delay(1.193478260869565, function() -- line: 120
        -- upvalues:
        --  [1] v27 (ref)
        --  [2] slam (copy)

        if not v27 then
            v27 = true
            slam()
        end
    end)
end

return function(u5: userdata, s1: string, ...) -- line: 128
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] addSigil (copy)
    --  [4] spawnHand (copy)
    --  [5] Assets (copy)

    if s1 == "Cancel" then
        for key_11 in t do
            local v29 = t[key_11]
            t[key_11] = nil

            if v29 then
                for _, val_6 in v29 do
                    HeadlessFxUtil_m.Stop(val_6)
                end
            end
        end

        return
    end

    if s1 == "Sigils" then
        for _, val_7 in (...) do
            addSigil(val_7)
        end

        return
    end

    if s1 == "Hand" then
        spawnHand(...)

        return
    end

    if s1 == "HandHit" then
        HeadlessFxUtil_m.Sound("ExecutionMarkHandHit", (...))

        return
    end

    local v30 = HeadlessFxUtil_m.Feet(u5)

    if not v30 then
        return
    end

    if s1 == "Cast" then
        local HumanoidRootPart = u5:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart then
            HeadlessFxUtil_m.Sound("ExecutionMarkCast", HumanoidRootPart)

            return
        end
    elseif s1 == "SwordImpact" then
        HeadlessFxUtil_m.Place(Assets.SwordImpact, v30)
        HeadlessFxUtil_m.Shake(
            v30.Position,
            4,
            10,
            0.5,
            150
        )
    end
end
