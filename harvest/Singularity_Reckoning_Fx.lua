-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dagon.Singularity_Reckoning_Fx
-- Class: ModuleScript
-- bytes: 5514

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local _ = workspace.CurrentCamera
local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage_1 = Services_m.ReplicatedStorage
local UpRocks_m = require(script.UpRocks)
local Bezier_m = require(script.Bezier)
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map }

local _ = function(u1: userdata, n1: number, n2: number) --[[ Distort ]] -- line: 22
    -- upvalues:
    --  [1] ReplicatedStorage_1 (copy)
    --  [2] TweenService (copy)
    --  [3] Services_m (copy)

    if not u1 or not u1.Parent then
        return
    end

    if n1 <= 0 then
        return
    end

    task.defer(function() -- line: 26
        -- upvalues:
        --  [1] n1 (copy)
        --  [2] u1 (copy)
        --  [3] ReplicatedStorage_1 (ref)
        --  [4] TweenService (ref)
        --  [5] n2 (copy)
        --  [6] Services_m (ref)

        for _ = 1, n1 do
            if not u1.Parent then
                break
            end

            local _ = n1
            local v4 = ReplicatedStorage_1.Effects.MagicFX.Dagon.Distortion:Clone()
            v4.CFrame = u1.CFrame
            v4.Parent = workspace.Effects
            TweenService:Create(
                v4,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Size = v4.Size * n2, Transparency = 1 }
            ):Play()
            Services_m.Debris(v4, 0.5)
            task.wait()
        end
    end)
end

local function main(arg1, arg2, arg3) -- line: 53
    -- upvalues:
    --  [1] Players (copy)
    --  [2] ReplicatedStorage_1 (copy)
    --  [3] Effects (copy)
    --  [4] UpRocks_m (copy)
    --  [5] Services_m (copy)
    --  [6] Bezier_m (copy)

    local LocalPlayer = Players.LocalPlayer

    if arg3 == 1 then
        local HumanoidRootPart = arg1:WaitForChild("HumanoidRootPart")
        local _ = arg1:WaitForChild("Humanoid")
        local v6 = ReplicatedStorage_1.Effects.MagicFX.Dagon.Singular_Start:Clone()
        v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.25, 0)
        v6.Parent = workspace.Effects
        v6.Name = "Dagon_Rising_Effect"
        Effects:CleanEmitParticle(v6.Ground_Explo, 1)
        Effects:CleanEmitParticle(v6.Floor, 5, true)
        Effects:CleanEmitParticle(v6.DebrisRing, 5, true)
        task.spawn(
            UpRocks_m.Start,
            arg1,
            5,
            3,
            3,
            CFrame.new(0, 0, 0)
        )

        for _, val in ipairs(arg2) do
            local Hitbox = val:WaitForChild("Hitbox")
            local v9 = ReplicatedStorage_1.Effects.MagicFX.Dagon.Trail_2:Clone()
            v9:PivotTo(arg1["Left Arm"].CFrame * CFrame.new(0, -1, 0))
            v9.Parent = workspace.Effects
            Services_m.Debris(v9, 6)
            Bezier_m.new(
                v9.Position,
                v9.CFrame * CFrame.new(
                    math.random(-25, 25),
                    math.random(0, 5),
                    math.random(-25, 25)
                ).Position,
                Hitbox.Position
            ):CreateCFrameTween(v9, { "CFrame" }, TweenInfo.new(1), true):Play()
            task.delay(1, function() -- line: 90
                -- upvalues:
                --  [1] ReplicatedStorage_1 (ref)
                --  [2] Hitbox (copy)
                --  [3] Effects (ref)
                --  [4] Services_m (ref)
                --  [5] LocalPlayer (copy)
                --  [6] val (copy)

                local v16 = ReplicatedStorage_1.Effects.MagicFX.Dagon.Reckon_Spawn:Clone()
                v16.CFrame = Hitbox.CFrame
                v16.Parent = workspace.Effects
                Effects:CleanEmitParticle(v16, 1)
                Services_m.Debris(v16, 5)
                task.wait(0.2)
                Hitbox.Health.Enabled = true
                Hitbox.Health.Adornee = Hitbox
                Hitbox.Health.Parent = LocalPlayer.PlayerGui
                Effects:CleanEmitParticle(val, 1, true)
            end)
        end

        return
    end

    if arg3 == 2 then
        local v17 = ReplicatedStorage_1.Effects.MagicFX.Dagon.Reckon_Spawn:Clone()
        v17.CFrame = CFrame.new(arg1)
        v17.Parent = workspace.Effects
        Effects:CleanEmitParticle(v17, 1)
        Services_m.Debris(v17, 5)

        return
    end

    if arg3 == 3 then
        local HumanoidRootPart_1 = arg1:WaitForChild("HumanoidRootPart")
        local _ = arg1:WaitForChild("Humanoid")
        local DagonRisingEffect = workspace.Effects:FindFirstChild("Dagon_Rising_Effect")
        Effects:CleanEmitParticle(DagonRisingEffect, 1, false)
        Services_m.Debris(DagonRisingEffect, 4)
        task.wait(1)

        if arg2 == true then
            local v18 = ReplicatedStorage_1.Effects.MagicFX.Dagon.Dagon_Heal:Clone()
            v18.CFrame = HumanoidRootPart_1.CFrame * CFrame.new(0, 0.2, 0)
            v18.Parent = workspace.Effects
            Effects:CleanEmitParticle(v18, 2)
            Services_m.Debris(v18, 2)

            return
        end
    else
        warn("No Args for Howling Move")
    end
end

return main
