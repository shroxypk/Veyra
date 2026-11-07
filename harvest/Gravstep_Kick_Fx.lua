-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dagon.Gravstep_Kick_Fx
-- Class: ModuleScript
-- bytes: 6932

local _ = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local Debris = game:GetService("Debris")
local _ = game:GetService("TweenService")
local _ = workspace.CurrentCamera
local Debris_1 = game.Debris
local ReplicatedStorage = require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage

local _ = function(u1: userdata, n1: number, n2: number) --[[ Distort ]] -- line: 21
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

    task.defer(function() -- line: 25
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
            local v2 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
            v2.CFrame = u1.CFrame
            v2.Parent = workspace.Effects
            TweenService:Create(
                v2,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Size = v2.Size * n2, Transparency = 1 }
            ):Play()
            Debris:AddItem(v2, 0.5)
            task.wait()
        end
    end)
end

local Effects = _G.GetModule("Effects")

return function(arg1, arg2) -- line: 52
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Debris_1 (copy)
    --  [3] Effects (copy)
    --  [4] TweenService (copy)
    --  [5] Debris (copy)

    local _ = game.Players.LocalPlayer
    local HumanoidRootPart = arg1:WaitForChild("HumanoidRootPart")
    local _ = arg1:WaitForChild("Humanoid")

    if arg2 == 1 then
        local v4 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Step_Dis:Clone()
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0)
        v4.Parent = workspace.Effects
        Debris_1:AddItem(v4, 2)
        Effects:CleanEmitParticle(v4, 1)

        return
    end

    if arg2 == 2 then
        if HumanoidRootPart and HumanoidRootPart.Parent then
            local v6 = 2
            local v7 = 25
            task.defer(function() -- line: 25
                -- upvalues:
                --  [1] v6 (copy)
                --  [2] HumanoidRootPart (copy)
                --  [3] ReplicatedStorage (ref)
                --  [4] TweenService (ref)
                --  [5] v7 (copy)
                --  [6] Debris (ref)

                for _ = 1, v6 do
                    if not HumanoidRootPart.Parent then
                        break
                    end

                    local _ = v6
                    local v9 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
                    v9.CFrame = HumanoidRootPart.CFrame
                    v9.Parent = workspace.Effects
                    TweenService:Create(
                        v9,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        { Size = v9.Size * v7, Transparency = 1 }
                    ):Play()
                    Debris:AddItem(v9, 0.5)
                    task.wait()
                end
            end)
        end

        local v11 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Step_Appear:Clone()
        v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, 0)
        v11.Parent = workspace.Effects
        Debris_1:AddItem(v11, 2)
        Effects:CleanEmitParticle(v11, 1)

        return
    end

    if arg2 == 3 then
        local v13 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Explo:Clone()
        v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2, -6)
        v13.Parent = workspace.Effects
        Debris_1:AddItem(v13, 5)
        Effects:CleanEmitParticle(v13, 3)
        local v15 = TweenService
        local tweenInfo_2 = TweenInfo.new(0.74, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        v15:Create(
            v13,
            tweenInfo_2,
            { CFrame = v13.CFrame * CFrame.Angles(0, 0, 3.141592653589793) }
        ):Play()
        Effects:BeamSlash(
            v13,
            0.2,
            0.1,
            -2,
            0,
            0,
            -1,
            7.5,
            true
        )
        local v17 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Explo_Floor:Clone()
        v17.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -5, -15)
        v17.Parent = workspace.Effects
        Debris_1:AddItem(v17, 2)
        Effects:CleanEmitParticle(v17, 1)

        return
    end

    if arg2 == 0 then
        if HumanoidRootPart and HumanoidRootPart.Parent then
            local v19 = 5
            local v20 = 25
            task.defer(function() -- line: 25
                -- upvalues:
                --  [1] v19 (copy)
                --  [2] HumanoidRootPart (copy)
                --  [3] ReplicatedStorage (ref)
                --  [4] TweenService (ref)
                --  [5] v20 (copy)
                --  [6] Debris (ref)

                for _ = 1, v19 do
                    if not HumanoidRootPart.Parent then
                        break
                    end

                    local _ = v19
                    local v22 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
                    v22.CFrame = HumanoidRootPart.CFrame
                    v22.Parent = workspace.Effects
                    TweenService:Create(
                        v22,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        { Size = v22.Size * v20, Transparency = 1 }
                    ):Play()
                    Debris:AddItem(v22, 0.5)
                    task.wait()
                end
            end)
        end

        local v24 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Ini:Clone()
        v24.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, 0)
        v24.Parent = workspace.Effects
        Debris_1:AddItem(v24, 2)
        Effects:CleanEmitParticle(v24, 1)
        local v26 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Left:Clone()
        v26.PrimaryPart = v26["Left Arm"]
        v26:SetPrimaryPartCFrame(arg1["Left Arm"].CFrame)
        v26.PrimaryPart.WeldConstraint.Part1 = arg1["Left Arm"]
        v26.Parent = workspace.Effects
        Debris_1:AddItem(v26, 0.5)
        local v27 = ReplicatedStorage.Effects.MagicFX.Dagon.Grav_Right:Clone()
        v27.PrimaryPart = v27["Right Arm"]
        v27:SetPrimaryPartCFrame(arg1["Right Arm"].CFrame)
        v27.PrimaryPart.WeldConstraint.Part1 = arg1["Right Arm"]
        v27.Parent = workspace.Effects
        Debris_1:AddItem(v27, 0.5)
    end
end
