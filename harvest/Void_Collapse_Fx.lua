-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dagon.Void_Collapse_Fx
-- Class: ModuleScript
-- bytes: 14210

local _ = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local Debris = game:GetService("Debris")
local _ = game:GetService("TweenService")
local _ = workspace.CurrentCamera
local _ = game.Debris
local ReplicatedStorage = require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage
local UpRocks_m = require(script.UpRocks)
local PartJoiner_m = require(script.PartJoiner)
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map }

local _ = function(u1: userdata, n1: number, n2: number) --[[ Distort ]] -- line: 22
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

    task.defer(function() -- line: 26
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

return function(arg1, arg2) -- line: 53
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Effects (copy)
    --  [3] TweenService (copy)
    --  [4] Debris (copy)
    --  [5] raycastParams (copy)
    --  [6] UpRocks_m (copy)
    --  [7] PartJoiner_m (copy)

    local _ = game.Players.LocalPlayer
    local HumanoidRootPart = arg1:WaitForChild("HumanoidRootPart")
    local _ = arg1:WaitForChild("Humanoid")

    if arg2 == 1 then
        local v4 = ReplicatedStorage.Effects.MagicFX.Dagon.Void_Slash:Clone()
        Effects:CleanEmitParticle(v4, 1)
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1, -3) * CFrame.Angles(
            0,
            3.141592653589793,
            0
        )
        v4.Parent = workspace
        TweenService:Create(
            v4.PointLight,
            TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
            { Range = 20 }
        ):Play()
        local v8 = ReplicatedStorage.Effects.MagicFX.Dagon.Void_Slashfront:Clone()
        v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -5, -10)
        v8.Parent = workspace.Effects
        Debris:AddItem(v8, 25)
        local v12 = workspace:Raycast(
            v8.Position,
            CFrame.new(v8.Position).UpVector * -10,
            raycastParams
        )

        if v12 then
            Effects:CleanEmitParticle(v8, 15)
            TweenService:Create(
                v8.Decal,
                TweenInfo.new(0.15, Enum.EasingStyle.Quad),
                { Transparency = 0, Color3 = Color3.fromRGB(1700, 250, 555) }
            ):Play()
            task.delay(0.7, function() -- line: 79
                -- upvalues:
                --  [1] TweenService (ref)
                --  [2] v8 (copy)

                TweenService:Create(
                    v8,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad),
                    { Size = Vector3.new(0, 0, 28.497) }
                ):Play()
            end)
            v8.Position = v12.Position
            v8.dust.Color = ColorSequence.new(v12.Instance.Color)
            Effects:CleanEmitParticle(v8.dust, 10)
            Effects:CleanEmitParticle(v8.rocks, 10)
        end

        coroutine.wrap(UpRocks_m.Start)(
            arg1,
            5,
            3,
            3,
            CFrame.new(0, 0, -10)
        )
        local Part = Instance.new("Part")
        Part.Parent = workspace.Effects
        Part.Transparency = 1
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.CFrame = arg1.HumanoidRootPart.CFrame
        Debris:AddItem(Part, 1.45)
        coroutine.wrap(function() -- line: 93
            -- upvalues:
            --  [1] Part (copy)
            --  [2] raycastParams (ref)
            --  [3] TweenService (ref)
            --  [4] v4 (copy)
            --  [5] Debris (ref)

            for index_1 = 1, 4 do
                task.wait()
                local v16 = math.random(1, 2) / 1
                local Part_1 = Instance.new("Part")
                Part_1.CanCollide = false
                Part_1.Anchored = true
                Part_1.Size = Vector3.new(0, 0, 0)
                Part_1.Parent = workspace.Effects
                Part_1.CFrame = Part.CFrame * CFrame.new(-2.5, -2, -1)
                Part_1.CFrame = Part_1.CFrame * CFrame.new(index_1 * 0.125, 0, index_1 * 3 * -1.25)
                local v22 = workspace:Raycast(
                    Part_1.Position,
                    CFrame.new(Part_1.Position).UpVector * -30,
                    raycastParams
                )

                if v22 then
                    Part_1.Color = v22.Instance.Color
                    Part_1.Material = v22.Material
                    Part_1.Position = v22.Position
                    local v23 = math.random(-180, 180)
                    Part_1.Orientation = Vector3.new(
                        v23,
                        math.random(-180, 180),
                        math.random(-180, 180)
                    )
                    local v26 = TweenService:Create(
                        Part_1,
                        TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                        { Size = Vector3.new(v16, v16, v16) }
                    )
                    v26:Play()
                    v26.Completed:Once(function() -- line: 112
                        -- upvalues:
                        --  [1] TweenService (ref)
                        --  [2] Part_1 (copy)

                        delay(1, function() -- line: 113
                            -- upvalues:
                            --  [1] TweenService (ref)
                            --  [2] Part_1 (ref)

                            local v29 = TweenService:Create(
                                Part_1,
                                TweenInfo.new(
                                    0.45,
                                    Enum.EasingStyle.Exponential,
                                    Enum.EasingDirection.Out
                                ),
                                { Size = Vector3.new(0, 0, 0) }
                            )
                            v29:Play()
                            v29.Completed:Once(function() -- line: 116
                                -- upvalues:
                                --  [1] Part_1 (ref)

                                Part_1:Destroy()
                            end)
                        end)
                    end)
                else
                    Part_1:Destroy()
                end
            end

            TweenService:Create(
                v4.PointLight,
                TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                { Brightness = 0 }
            ):Play()
            Debris:AddItem(v4, 1)
        end)()
        coroutine.wrap(function() -- line: 128
            -- upvalues:
            --  [1] Part (copy)
            --  [2] raycastParams (ref)
            --  [3] TweenService (ref)

            for index_2 = 1, 4 do
                task.wait()
                local v31 = math.random(1, 2) / 1
                local Part_2 = Instance.new("Part")
                Part_2.CanCollide = false
                Part_2.Anchored = true
                Part_2.Size = Vector3.new(0, 0, 0)
                Part_2.Parent = workspace.Effects
                Part_2.CFrame = Part.CFrame * CFrame.new(2.5, -2, -1)
                Part_2.CFrame = Part_2.CFrame * CFrame.new(index_2 * -0.125, 0, index_2 * 3 * -1.25)
                local v37 = workspace:Raycast(
                    Part_2.Position,
                    CFrame.new(Part_2.Position).UpVector * -30,
                    raycastParams
                )

                if v37 then
                    task.spawn(function() -- line: 141
                        -- upvalues:
                        --  [1] v37 (copy)
                        --  [2] Part_2 (copy)

                        for _, child in pairs(v37.Instance:GetChildren()) do
                            if child and child:IsA("Texture") then
                                child:Clone().Parent = Part_2
                            end
                        end
                    end)
                    Part_2.Color = v37.Instance.Color
                    Part_2.Material = v37.Material
                    Part_2.Position = v37.Position
                    local v39 = math.random(-180, 180)
                    Part_2.Orientation = Vector3.new(
                        v39,
                        math.random(-180, 180),
                        math.random(-180, 180)
                    )
                    local v42 = TweenService:Create(
                        Part_2,
                        TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                        { Size = Vector3.new(v31, v31, v31) }
                    )
                    v42:Play()
                    v42.Completed:Once(function() -- line: 156
                        -- upvalues:
                        --  [1] TweenService (ref)
                        --  [2] Part_2 (copy)

                        delay(1, function() -- line: 157
                            -- upvalues:
                            --  [1] TweenService (ref)
                            --  [2] Part_2 (ref)

                            local v45 = TweenService:Create(
                                Part_2,
                                TweenInfo.new(
                                    0.45,
                                    Enum.EasingStyle.Exponential,
                                    Enum.EasingDirection.Out
                                ),
                                { Size = Vector3.new(0, 0, 0) }
                            )
                            v45:Play()
                            v45.Completed:Once(function() -- line: 160
                                -- upvalues:
                                --  [1] Part_2 (ref)

                                Part_2:Destroy()
                            end)
                        end)
                    end)
                else
                    Part_2:Destroy()
                end
            end
        end)()
        local v46 = ReplicatedStorage.Effects.MagicFX.Dagon.Distortion:Clone()
        v46.CFrame = v8.CFrame
        v46.Parent = workspace.Effects
        v46.Size = Vector3.new(0, 0, 0)
        TweenService:Create(
            v46,
            TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out),
            { Size = Vector3.new(50, 50, 50), Transparency = 1 }
        ):Play()
        task.wait(3)
        TweenService:Create(
            v46,
            TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out),
            { Size = Vector3.new(0, 0, 0), Transparency = 1 }
        ):Play()
        Debris:AddItem(v46, 1)

        return
    end

    if arg2 == 2 then
        local v49 = ReplicatedStorage.Effects.MagicFX.Dagon.Float_Effect:Clone()
        v49.Weld.Part1 = arg1.PrimaryPart
        v49.Size = Vector3.new(0, 0, 0)
        v49.Parent = workspace.Effects
        Effects:CleanEmitParticle(v49, 1, true)
        TweenService:Create(
            v49,
            TweenInfo.new(1, Enum.EasingStyle.Back),
            { Size = Vector3.new(8, 8, 8) }
        ):Play()
        task.delay(3, function() -- line: 215
            -- upvalues:
            --  [1] TweenService (ref)
            --  [2] v49 (copy)
            --  [3] Effects (ref)

            TweenService:Create(
                v49,
                TweenInfo.new(1, Enum.EasingStyle.Back),
                { Size = Vector3.new(0, 0, 0), Transparency = 1 }
            ):Play()
            Effects:CleanEmitParticle(v49, 3, false)
            game.Debris:AddItem(v49, 1)
        end)

        return
    end

    if arg2 == 3 then
        local v53 = ReplicatedStorage.Effects.MagicFX.Dagon.Void_Explosion:Clone()
        v53.CFrame = arg1.HumanoidRootPart.CFrame
        v53.Parent = workspace.Effects
        Effects:CleanEmitParticle(v53, 1)
        game.Debris:AddItem(v53, 5)

        return
    end

    if arg2 == 0 then
        local Blade = arg1:FindFirstChild("Blade", true)
        local v54 = ReplicatedStorage.Effects.MagicFX.Dagon.Fake_Blade:Clone()
        v54.CFrame = Blade.CFrame
        v54.Transparency = 1
        PartJoiner_m.Weld(v54, Blade)
        v54.Parent = workspace.Effects
        TweenService:Create(v54, TweenInfo.new(0.4), { Transparency = 0 }):Play()
        task.delay(0.1, function() -- line: 239
            -- upvalues:
            --  [1] Effects (ref)
            --  [2] v54 (copy)

            Effects:CleanEmitParticle(v54.Start, 1)
            task.wait(0.2)
            Effects:CleanEmitParticle(v54.End, 1)
        end)
        task.delay(0.85, function() -- line: 245
            -- upvalues:
            --  [1] TweenService (ref)
            --  [2] v54 (copy)

            TweenService:Create(
                v54,
                TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Transparency = 1 }
            ):Play()
            game.Debris:AddItem(v54, 1)
        end)

        return
    end

    warn("No Args for Howling Move")
end
