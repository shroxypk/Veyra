-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dagon.Gravity_Field_Fx
-- Class: ModuleScript
-- bytes: 7227

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local _ = game:GetService("Debris")
local _ = game:GetService("TweenService")
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
local v3 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 15
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v3:Start()
local UpRocks_m = require(script.UpRocks)
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map }

local _ = function(u1: userdata, n1: number, n2: number) --[[ Distort ]] -- line: 28
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] TweenService (copy)
    --  [3] Services_m (copy)

    if not u1 or not u1.Parent then
        return
    end

    if n1 <= 0 then
        return
    end

    task.defer(function() -- line: 32
        -- upvalues:
        --  [1] n1 (copy)
        --  [2] u1 (copy)
        --  [3] ReplicatedStorage (ref)
        --  [4] TweenService (ref)
        --  [5] n2 (copy)
        --  [6] Services_m (ref)

        for _ = 1, n1 do
            if not u1.Parent then
                break
            end

            local _ = n1
            local v5 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
            v5.CFrame = u1.CFrame
            v5.Parent = workspace.Effects
            TweenService:Create(
                v5,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Size = v5.Size * n2, Transparency = 1 }
            ):Play()
            Services_m.Debris(v5, 0.5)
            task.wait()
        end
    end)
end

local function main(arg2, arg3) -- line: 59
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] UpRocks_m (copy)
    --  [4] Effects (copy)
    --  [5] Services_m (copy)
    --  [6] TweenService (copy)
    --  [7] v3 (copy)
    --  [8] RunService (copy)

    if not arg2 or (arg2.PrimaryPart.Position - CurrentCamera.CFrame.Position).Magnitude > 600 then
        return
    end

    local HumanoidRootPart = arg2:WaitForChild("HumanoidRootPart")
    local Magnitude = (CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude

    if arg3 == 0 then
        local v7 = ReplicatedStorage.Effects.MagicFX.Dagon.Gravity_Field:Clone()
        local EYE = v7.EYE
        task.spawn(
            UpRocks_m.Start,
            arg2,
            2,
            2,
            2,
            CFrame.new(0, 0, 0)
        )
        EYE.Parent = arg2.Head
        v7.Position = arg2.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0).Position
        v7.Parent = workspace.Effects
        Effects:CleanEmitParticle(v7, 1)
        Services_m.Debris(EYE, 4)
        local v13 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
        v13.Position = v7.Position
        v13.Parent = workspace.Effects
        TweenService:Create(
            v13,
            TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Size = Vector3.new(25, 25, 25), Transparency = 1 }
        ):Play()
        Services_m.Debris(v13, 1)

        return
    end

    if arg3 == 1 then
        local v17 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Jump:Clone()
        v17.Position = arg2.HumanoidRootPart.CFrame * CFrame.new(0, -4.5, 0).Position
        v17.Parent = workspace.Effects
        Effects:CleanEmitParticle(v17, 1)
        Services_m.Debris(v17, 4)

        return
    end

    if arg3 == 2 then
        task.wait(0.1)

        if Magnitude < 200 then
            v3:ShakeOnce(2, 7, 0, 0.5)
        end

        local v20 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Land:Clone()
        v20.Position = arg2.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0).Position
        v20.Parent = workspace.Effects
        Effects:CleanEmitParticle(v20, 1)
        Services_m.Debris(v20, 4)

        return
    end

    if arg3 == 3 then
        if Magnitude < 200 then
            v3:ShakeOnce(2, 6, 0, 0.4)
        end

        local v23 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Field_Impact_Hit:Clone()
        v23.Position = arg2.HumanoidRootPart.CFrame * CFrame.new(1.5, -5, -3).Position
        v23.Parent = workspace.Effects
        Effects:CleanEmitParticle(v23, 1)
        Services_m.Debris(v23, 4)
        local v25 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Quake:Clone()
        v25.Position = arg2.HumanoidRootPart.CFrame * CFrame.new(1.5, -4.5, -3).Position
        v25.Parent = workspace.Effects
        Effects:CleanEmitParticle(v25, 1)
        Services_m.Debris(v25, 4)
        local v31 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
        v31.CFrame = v23.CFrame
        v31.Parent = workspace.Effects
        v31.Size = Vector3.new(0, 0, 0)
        TweenService:Create(
            v31,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Size = Vector3.new(30, 30, 30), Transparency = 1 }
        ):Play()
        Services_m.Debris(v31, 0.5)
        local v37 = ReplicatedStorage.Effects.MagicFX.Dagon.Circle_Grow:Clone()
        v37.PrimaryPart = v37.Part
        v37:PivotTo(
            HumanoidRootPart.CFrame * CFrame.new(0, -5, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
        )
        v37:ScaleTo(0.1)
        v37.Parent = workspace.Effects
        local NumberValue = Instance.new("NumberValue")
        NumberValue.Value = 0.1
        local v44 = nil
        v44 = RunService.RenderStepped:Connect(function() -- line: 176
            -- upvalues:
            --  [1] v37 (copy)
            --  [2] v44 (ref)
            --  [3] NumberValue (copy)

            if not v37.Parent then
                v44:Disconnect()

                return
            end

            v37:ScaleTo(NumberValue.Value)
        end)
        TweenService:Create(
            NumberValue,
            TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Value = 20 }
        ):Play()
        task.delay(2.9, function() -- line: 186
            -- upvalues:
            --  [1] v44 (ref)
            --  [2] NumberValue (copy)
            --  [3] v37 (copy)
            --  [4] TweenService (ref)
            --  [5] Services_m (ref)

            v44:Disconnect()
            NumberValue:Destroy()

            for _, child in v37:GetChildren() do
                if child:IsA("BasePart") then
                    TweenService:Create(
                        child,
                        TweenInfo.new(1, Enum.EasingStyle.Linear),
                        { Position = child.Position - Vector3.new(0, 50, 0) }
                    ):Play()
                end
            end

            Services_m.Debris(v37, 3)
        end)
    end
end

return main
