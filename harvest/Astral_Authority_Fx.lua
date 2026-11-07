-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dagon.Astral_Authority_Fx
-- Class: ModuleScript
-- bytes: 8445

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local Debris = game:GetService("Debris")
local _ = game:GetService("TweenService")
local RunService_1 = game:GetService("RunService")
local _ = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Effects = _G.GetModule("Effects")
local FlyingRocks_m = require(script.FlyingRocks)
local _ = workspace.CurrentCamera
local _ = game.Debris
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map }

return function(arg1, arg2, arg3) -- line: 24
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Debris (copy)
    --  [4] Effects (copy)
    --  [5] RunService_1 (copy)
    --  [6] FlyingRocks_m (copy)

    local _ = arg1:WaitForChild("HumanoidRootPart")
    local _ = arg1:WaitForChild("Humanoid")
    local v2 = nil

    if arg2 == 0 then
        for _, val in ipairs(arg3) do
            val:WaitForChild("Distortion")
            val:WaitForChild("Base")
            val.PrimaryPart = val:WaitForChild("Distortion")

            local function RotateFunction() -- line: 41
                -- upvalues:
                --  [1] val (copy)
                --  [2] v2 (ref)
                --  [3] TweenService (ref)
                --  [4] RotateFunction (copy)

                if not val.Base then
                    return
                end

                local v4 = math.rad((math.random(-360, 360)))
                local v6 = math.rad((math.random(-360, 360)))
                local v8 = math.rad((math.random(-360, 360)))
                local v9 = TweenService
                local RotateWeld = val.Base.Rotate_Weld
                local tweenInfo = TweenInfo.new(
                    2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.InOut
                )
                local t = { C0 = val.Base.Rotate_Weld.C0 * CFrame.Angles(v4, v6, v8) }
                v2 = v9:Create(RotateWeld, tweenInfo, t)
                v2:Play()
                v2.Completed:Once(function() -- line: 55
                    -- upvalues:
                    --  [1] val (ref)
                    --  [2] RotateFunction (ref)

                    if not val.Base then
                        return
                    end

                    RotateFunction()
                end)
            end

            RotateFunction()
            local raycastParams_1 = RaycastParams.new()
            raycastParams_1.FilterDescendantsInstances = { arg1, val }
            raycastParams_1.FilterType = Enum.RaycastFilterType.Exclude
            local Position = val.PrimaryPart.Position
            local v10 = -val.PrimaryPart.CFrame.UpVector * 1
            local v11 = workspace:Raycast(Position, v10, raycastParams_1)

            if v11 then
                local _ = v11.Position
            end

            local v12 = Position + v10
            local Magnitude = (v12 - Position).Magnitude
            local v13 = ReplicatedStorage.Effects.MagicFX.Dagon.Astral_Spawn.Impact:Clone()
            v13.Position = CFrame.new(Position, v12) * CFrame.new(0, 0, -Magnitude / 2).Position
            v13.Parent = workspace.Terrain
            Debris:AddItem(v13, 5)
            Effects:CleanEmitParticle(v13, 1)
            task.delay(math.random(1, 2) / 10, function() -- line: 105
                -- upvalues:
                --  [1] TweenService (ref)
                --  [2] RunService_1 (ref)
                --  [3] val (copy)

                local NumberValue = Instance.new("NumberValue")
                NumberValue.Value = 0.1
                local v19 = TweenService
                v19:Create(
                    NumberValue,
                    TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    { Value = math.random(2, 3) }
                ):Play()
                local v20 = nil
                v20 = RunService_1.Heartbeat:Connect(function() -- line: 112
                    -- upvalues:
                    --  [1] val (ref)
                    --  [2] v20 (ref)
                    --  [3] NumberValue (copy)

                    if not val.Parent then
                        v20:Disconnect()

                        return
                    end

                    val:ScaleTo(NumberValue.Value)
                end)
            end)
        end
    elseif arg2 == 1 then
        for _, val_1 in ipairs(arg3) do
            Effects:CleanEmitParticle(val_1.Base, 1)
            task.spawn(function() -- line: 130
                -- upvalues:
                --  [1] val_1 (copy)
                --  [2] FlyingRocks_m (ref)
                --  [3] Effects (ref)
                --  [4] ReplicatedStorage (ref)
                --  [5] Debris (ref)
                --  [6] TweenService (ref)

                val_1.Distortion.ChildRemoved:Once(function(arg4) -- line: 131
                    -- upvalues:
                    --  [1] FlyingRocks_m (ref)
                    --  [2] val_1 (ref)
                    --  [3] Effects (ref)
                    --  [4] ReplicatedStorage (ref)
                    --  [5] Debris (ref)
                    --  [6] TweenService (ref)

                    if arg4.Name == "Charge" then
                        FlyingRocks_m.Start(
                            val_1.Base,
                            val_1.Base.Position,
                            math.random(2, 10),
                            7,
                            3,
                            false,
                            false
                        )
                        Effects:CleanEmitParticle(val_1.Distortion, 1, false)
                        val_1.Distortion.Transparency = 15
                        local v22 = ReplicatedStorage.Effects.MagicFX.Dagon.Astral_Hit.Impact:Clone()
                        v22.Position = val_1.Distortion.Position
                        v22.Parent = workspace.Terrain
                        Debris:AddItem(v22, 5)
                        Effects:CleanEmitParticle(v22, 1)
                        TweenService:Create(
                            val_1.Base,
                            TweenInfo.new(
                                3,
                                Enum.EasingStyle.Linear,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                1
                            ),
                            { Position = val_1.Base.Position + Vector3.new(0, -25, 0) }
                        ):Play()
                        TweenService:Create(
                            val_1.Base,
                            TweenInfo.new(0.2),
                            { Size = Vector3.new(0, 0, 0) }
                        ):Play()
                        task.spawn(function() -- line: 148
                            -- upvalues:
                            --  [1] TweenService (ref)
                            --  [2] val_1 (ref)

                            TweenService:Create(
                                val_1.Distortion,
                                TweenInfo.new(
                                    1,
                                    Enum.EasingStyle.Circular,
                                    Enum.EasingDirection.Out
                                ),
                                { Size = Vector3.new(30, 30, 30), Transparency = 1 }
                            ):Play()
                            task.wait(0.5)
                            TweenService:Create(
                                val_1.Distortion,
                                TweenInfo.new(
                                    0.25,
                                    Enum.EasingStyle.Circular,
                                    Enum.EasingDirection.Out
                                ),
                                { Size = Vector3.new(0, 0, 0), Transparency = 1 }
                            ):Play()
                        end)
                    end
                end)
            end)
        end
    else
        warn("No Args Move")
    end
end
