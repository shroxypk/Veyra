-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dagon.Rift_Cleaver_Fx
-- Class: ModuleScript
-- bytes: 7319

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local Debris = game:GetService("Debris")
local _ = game:GetService("TweenService")
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
local v3 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 15
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v3:Start()
local Effects = _G.GetModule("Effects")
local PartJoiner_m = require(script.PartJoiner)
local Bezier_m = require(script.Bezier)

local _ = function(u1: userdata, n1: number, n2: number) --[[ Distort ]] -- line: 24
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] TweenService (copy)
    --  [3] Debris (copy)

    if not u1 or not u1.Parent then
        return
    end

    if n1 <= 0 then
        return
    end

    task.defer(function() -- line: 28
        -- upvalues:
        --  [1] n1 (copy)
        --  [2] u1 (copy)
        --  [3] ReplicatedStorage (ref)
        --  [4] TweenService (ref)
        --  [5] n2 (copy)
        --  [6] Debris (ref)

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
            Debris:AddItem(v5, 0.5)
            task.wait()
        end
    end)
end

local function main(arg2, arg3) -- line: 55
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] v3 (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Services_m (copy)
    --  [5] Effects (copy)
    --  [6] Bezier_m (copy)
    --  [7] Debris (copy)
    --  [8] TweenService (copy)
    --  [9] PartJoiner_m (copy)

    if not arg2 or (arg2.PrimaryPart.Position - CurrentCamera.CFrame.Position).Magnitude > 600 then
        return
    end

    local HumanoidRootPart = arg2:WaitForChild("HumanoidRootPart")
    local Magnitude = (CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude

    if arg3 == 1 then
        if Magnitude < 100 then
            v3:ShakeOnce(2, 9, 0, 0.6)
        end

        local v7 = ReplicatedStorage.Effects.MagicFX.Dagon.Reave_Explo:Clone()
        v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -5, -15) * CFrame.Angles(
            0,
            1.5707963267948966,
            0
        )
        Services_m.Debris(v7, 2)
        Effects:CleanEmitParticle(v7, 1)
        local v10 = ReplicatedStorage.Effects.MagicFX.Dagon.SuckIn_Orb:Clone()
        v10.CFrame = v7.CFrame * CFrame.new(0, 0, 0)
        Effects:CleanEmitParticle(v10, 1, true)
        v7.Parent = workspace.Effects
        v10.Parent = workspace.Effects

        for _ = 1, 5 do
            local v12 = ReplicatedStorage.Effects.MagicFX.Dagon.Trail:Clone()
            v12.CFrame = v7.CFrame * CFrame.new(
                math.random(-15, 15),
                math.random(-5, 15),
                math.random(-15, 15)
            )
            v12.Parent = workspace.Effects
            Bezier_m.new(
                v12.Position,
                v12.CFrame * CFrame.new(
                    math.random(-25, 25),
                    math.random(0, 5),
                    math.random(-25, 25)
                ).Position,
                v7.Position
            ):CreateCFrameTween(v12, { "CFrame" }, TweenInfo.new(0.15), true):Play()
            Debris:AddItem(v12, 0.15)
            local v20 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
            v20.CFrame = v7.CFrame
            v20.Parent = workspace.Effects
            v20.Size = Vector3.new(35, 35, 35)
            TweenService:Create(
                v20,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Size = Vector3.new(0, 0, 0), Transparency = 1 }
            ):Play()
            Debris:AddItem(v20, 0.25)
            task.wait(0.1)
        end

        v10:Destroy()

        return
    end

    if arg3 == 2 then
        if Magnitude < 150 then
            v3:ShakeOnce(3, 10, 0, 0.7)
        end

        local v22 = ReplicatedStorage.Effects.MagicFX.Dagon.Reave_Final:Clone()
        v22.Position = HumanoidRootPart.CFrame * CFrame.new(0, -5, -15).Position
        v22.Parent = workspace.Effects
        Services_m.Debris(v22, 10)
        Effects:CleanEmitParticle(v22, 1)

        for _ = 1, 3 do
            local v24 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
            v24.CFrame = v22.CFrame
            v24.Parent = workspace.Effects
            TweenService:Create(
                v24,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Size = Vector3.new(35, 35, 35), Transparency = 1 }
            ):Play()
            Debris:AddItem(v24, 0.5)
            task.wait(0.1)
        end
    else
        if arg3 == 0 then
            warn("SWORD EFFECT")
            local Blade = arg2:FindFirstChild("Blade", true)
            local v26 = ReplicatedStorage.Effects.MagicFX.Dagon.Fake_Blade:Clone()
            v26.CFrame = Blade.CFrame
            v26.Transparency = 1
            PartJoiner_m.Weld(v26, Blade)
            v26.Parent = workspace.Effects
            TweenService:Create(v26, TweenInfo.new(0.4), { Transparency = 0 }):Play()
            task.delay(0.1, function() -- line: 166
                -- upvalues:
                --  [1] Effects (ref)
                --  [2] v26 (copy)

                Effects:CleanEmitParticle(v26.Start, 1)
                task.wait(0.2)
                Effects:CleanEmitParticle(v26.End, 1)
            end)
            task.delay(0.85, function() -- line: 172
                -- upvalues:
                --  [1] TweenService (ref)
                --  [2] v26 (copy)
                --  [3] ReplicatedStorage (ref)
                --  [4] HumanoidRootPart (copy)
                --  [5] Services_m (ref)
                --  [6] Effects (ref)

                TweenService:Create(
                    v26,
                    TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    { Transparency = 1 }
                ):Play()
                game.Debris:AddItem(v26, 1)
                local v30 = ReplicatedStorage.Effects.MagicFX.Dagon.Reave_Slash:Clone()
                v30.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(
                    0,
                    3.141592653589793,
                    0
                )
                v30.Parent = workspace.Effects
                Services_m.Debris(v30, 2)
                Effects:CleanEmitParticle(v30, 1)
            end)

            return
        end

        warn("No Args for Howling Move")
    end
end

return main
