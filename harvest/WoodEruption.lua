-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.WoodEruption
-- Class: ModuleScript
-- bytes: 6787

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.VFX
local _ = Random.new()
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 11
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local DebrisCircle = _G.GetModule("DebrisCircle")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function WeldModel(arg2) -- line: 24
    local PrimaryPart = arg2.PrimaryPart

    for _, child in pairs(arg2:GetChildren()) do
        if child:IsA("BasePart") then
            local Weld = Instance.new("Weld")
            Weld.Name = arg2.Name .. "_" .. child.Name .. "Weld"
            Weld.Part0 = PrimaryPart
            Weld.Part1 = child
            local cframe = CFrame.new(PrimaryPart.Position)
            Weld.C0, Weld.C1 = PrimaryPart.CFrame:inverse() * cframe, child.CFrame:inverse() * cframe
            Weld.Parent = PrimaryPart
        end
    end

    for _, child_1 in pairs(arg2:GetChildren()) do
        if child_1:IsA("BasePart") then
            child_1.Anchored = false
            child_1.CanCollide = false
        end
    end
end

local function CreateTree(u1: CFrame, u2: CFrame, arg3: any) -- line: 48
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] WeldModel (copy)
    --  [3] DebrisCircle (copy)
    --  [4] Utility_m (copy)

    if (u1.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    local Material = arg3.Material
    local v8 = arg3:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or arg3.Color
    local v9 = u2 or CFrame.Angles(0, 0.3490658503988659, 0)
    local v10 = ReplicatedStorage.Effects.TreeEruption:Clone()
    v10.Name = tick()
    WeldModel(v10)
    local v13 = pairs

    for _, val in v13(v10:GetChildren()) do
        if val:IsA("BasePart") then
            val.Size = Vector3.new(val.Size.X * 2.5, val.Size.Y, val.Size.Z * 2.5)
            val:SetAttribute("NormalSize", val.Size)
            val.CanCollide = false
            val.CanTouch = false
            val.CanQuery = false
            val.Transparency = 1
            val.Size = Vector3.new(val.Size.X / 2, 0, val.Size.Z / 2)
            val.MaterialVariant = "Dead Tree Bark"
        end
    end

    v10.PrimaryPart.CFrame = u1
    v10.PrimaryPart.Anchored = true
    v10.Parent = workspace.Effects
    _G.CameraShake("Explosion")
    local PrimaryPart_3 = v10.PrimaryPart.CFrame
    local v18 = v10.PrimaryPart.CFrame * v9
    DebrisCircle.ConnectedCircle(
        nil,
        12,
        3,
        11,
        nil,
        u1 * CFrame.new(0, 1.5, 0)
    )
    _G.PlaySound(
        ReplicatedStorage.SFX.Explosions.TreeCrash,
        u1,
        nil,
        0.15,
        nil,
        nil
    )
    local v19 = script.GroundSmash:Clone()
    v19.CFrame = v10.PrimaryPart.CFrame * CFrame.new(0, 1, 0)
    v19.Parent = workspace.Effects
    _G.Debris(v19, 4)
    wait()

    for _, val_1 in pairs(v19:GetDescendants()) do
        if val_1:IsA("ParticleEmitter") then
            if not val_1.Name:match("Smoke") then
                if not val_1.Name:match("Rock") then
                    if val_1.Name:match("Shock") then
                        val_1.Color = ColorSequence.new(v8)
                    end
                else
                    val_1.Color = ColorSequence.new(v8)
                end
            else
                val_1.Color = ColorSequence.new(v8)
            end
        end
    end

    Utility_m.EmitParticles(v19)
    task.delay(0.0125, function() -- line: 115
        -- upvalues:
        --  [1] PrimaryPart_3 (copy)
        --  [2] v18 (copy)
        --  [3] v10 (copy)

        local CFrameValue = Instance.new("CFrameValue")
        CFrameValue.Value = PrimaryPart_3
        _G.Tween(CFrameValue, { 0.65, "Quad", Enum.EasingDirection.Out }, { Value = v18 }).Completed:Connect(
            function() -- line: 120
                -- upvalues:
                --  [1] CFrameValue (copy)

                CFrameValue:Destroy()
            end
        )
        CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() -- line: 123
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] CFrameValue (copy)

            v10.PrimaryPart.CFrame = CFrameValue.Value
        end)
    end)
    task.delay(0.025, function() -- line: 128
        -- upvalues:
        --  [1] v10 (copy)

        local v22 = #v10:GetChildren()
        local v23 = 0.075
        local v24 = 0.2 / v22

        for index = 1, v22 do
            local v25 = v10[index]
            local NormalSize = v25:GetAttribute("NormalSize")
            local _ = v25:GetAttribute("NormalCFrame")

            for _, val_2 in pairs(script.Particles:GetChildren()) do
                local v27 = val_2:Clone()
                v27.Parent = v25
                v27:Emit(v27:GetAttribute("EmitCount") or 3)
            end

            _G.Tween(
                v25,
                { v23, "Quad", Enum.EasingDirection.Out },
                { Transparency = 0, Size = NormalSize }
            )
            task.wait(v23 / 7)
            v23 += v24
        end
    end)
    task.delay(4, function() --[[ Destroy ]] -- line: 152
        -- upvalues:
        --  [1] v10 (copy)

        for _, descendant in pairs(v10:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CollisionGroup = "Debris"
                descendant.CanCollide = true
                _G.Tween(
                    descendant,
                    { 0.65, "Quad", Enum.EasingDirection.Out },
                    { Size = descendant.Size * 0.8 }
                ).Completed:Connect(function() -- line: 158
                    -- upvalues:
                    --  [1] descendant (copy)

                    task.wait(1)
                    _G.Tween(
                        descendant,
                        { 0.75, "Quad", Enum.EasingDirection.Out },
                        { Size = Vector3.new(0, 0, 0), Transparency = 1 },
                        true
                    )
                end)
            elseif descendant:IsA("Weld") then
                descendant:Destroy()
            end
        end

        _G.Debris(v10, 3)
    end)

    return v10
end

function Attack(...) -- line: 174
    -- upvalues:
    --  [1] CreateTree (copy)

    CreateTree(...)
end

return Attack
