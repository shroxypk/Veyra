-- Decompiled with Veyra harvester
-- Instance: StarterGui.Cinematic.CeremonyClient
-- Class: LocalScript
-- bytes: 9010

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("Lighting")
local _ = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local v2, v3 = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Bin = v2:WaitForChild("bin")
local Animator = v3:WaitForChild("Humanoid").Animator
local v4 = nil
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
local CurrentCamera = workspace.CurrentCamera
local Fade = script.Parent.Fade
local CinematicBottom = script.Parent.CinematicBottom
local Dialogue = script.Parent.Dialogue
local v5 = Animator:LoadAnimation(ReplicatedStorage.Animations.GrimoireReceive)
v5.Priority = Enum.AnimationPriority.Action4

function SET_DISPLAY(arg1) -- line: 30
    return "<i>" .. arg1 .. "</i>"
end

ReplicatedStorage.Remotes.CEREMONY.OnClientEvent:Connect(function(arg2, ...) -- line: 34
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] Dialogue (copy)
    --  [3] Bin (copy)
    --  [4] CinematicBottom (copy)
    --  [5] Fade (copy)
    --  [6] CurrentCamera (copy)
    --  [7] RunService (copy)
    --  [8] v5 (copy)
    --  [9] HumanoidRootPart (copy)
    --  [10] v3 (copy)

    local t = { ... }
    local v6 = t[1]

    if v4 then
        v4:Disconnect()
        v4 = nil
    end

    _G.Use = false
    Dialogue.Label.Text = ""

    if arg2 == "Start" then
        Bin.Event.Value = "137132025167605"
        CinematicBottom.Visible = true
        local Tween = _G.Tween
        Tween(
            Fade,
            { 1, "Quad", Enum.EasingDirection.Out },
            { BackgroundTransparency = 0 },
            false,
            true
        )
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        CurrentCamera.CFrame = v6.CFrame

        return
    end

    if arg2 == "PanAnnouncer" then
        local Tween_1 = _G.Tween
        Tween_1(Fade, { 0.5, "Quad", Enum.EasingDirection.Out }, { BackgroundTransparency = 1 })
        task.spawn(function() -- line: 60
            -- upvalues:
            --  [1] Dialogue (ref)

            Dialogue.Label.Text = SET_DISPLAY("AHEM...")
            task.wait(3)
            Dialogue.Label.Text = SET_DISPLAY("THE MAGIC CEREMONY WILL NOW BEGIN!")
        end)
        local Tween_2 = _G.Tween
        local v22 = CurrentCamera
        Tween_2(
            v22,
            { 5, "Quad", Enum.EasingDirection.Out },
            { CFrame = v6.CFrame },
            false,
            true
        )
        local Tween_3 = _G.Tween
        Tween_3(Fade, { 0.5, "Quad", Enum.EasingDirection.Out }, { BackgroundTransparency = 0 })

        return
    end

    if arg2 == "PanRoom" then
        local Tween_4 = _G.Tween
        Tween_4(Fade, { 1, "Quad", Enum.EasingDirection.Out }, { BackgroundTransparency = 1 })
        local v30 = 0
        local v31 = 9
        local New = CFrame.new(0, 30, 15)
        local Position = v6.Position
        local _ = tick()
        v4 = RunService.RenderStepped:Connect(function(deltaTime_2) -- line: 82
            -- upvalues:
            --  [1] v30 (ref)
            --  [2] v4 (ref)
            --  [3] Fade (ref)
            --  [4] v31 (ref)
            --  [5] New (ref)
            --  [6] CurrentCamera (ref)
            --  [7] Position (ref)
            --  [8] RunService (ref)

            if v30 >= 35 then
                v4:Disconnect()
                _G.Tween(
                    Fade,
                    { 0.5, "Quad", Enum.EasingDirection.Out },
                    { BackgroundTransparency = 0 },
                    false,
                    true
                )
                v31 = 9
                v30 = 150
                New = CFrame.new(0, 45, 18)
                CurrentCamera.CFrame = CFrame.lookAt(
                    (CFrame.new(Position) * CFrame.Angles(0, math.rad(v30), 0) * New).Position,
                    Position
                )
                task.wait(0.5)
                _G.Tween(
                    Fade,
                    { 1, "Quad", Enum.EasingDirection.Out },
                    { BackgroundTransparency = 1 }
                )
                v4 = RunService.RenderStepped:Connect(function(deltaTime_1) -- line: 98
                    -- upvalues:
                    --  [1] v30 (ref)
                    --  [2] v4 (ref)
                    --  [3] Fade (ref)
                    --  [4] v31 (ref)
                    --  [5] New (ref)
                    --  [6] Position (ref)
                    --  [7] CurrentCamera (ref)
                    --  [8] RunService (ref)

                    if v30 >= 190 then
                        v4:Disconnect()
                        _G.Tween(
                            Fade,
                            { 0.5, "Quad", Enum.EasingDirection.Out },
                            { BackgroundTransparency = 0 },
                            false,
                            true
                        )
                        v31 = 15
                        v30 = 195
                        New = CFrame.new(0, -15, 23)
                        Position += Vector3.new(0, 25, 0)
                        CurrentCamera.CFrame = CFrame.lookAt(
                            (CFrame.new(Position) * CFrame.Angles(0, math.rad(v30), 0) * New).Position,
                            Position
                        )
                        task.wait(0.5)
                        _G.Tween(
                            Fade,
                            { 1, "Quad", Enum.EasingDirection.Out },
                            { BackgroundTransparency = 1 }
                        )
                        v4 = RunService.RenderStepped:Connect(function(deltaTime) -- line: 115
                            -- upvalues:
                            --  [1] v30 (ref)
                            --  [2] v31 (ref)
                            --  [3] CurrentCamera (ref)
                            --  [4] Position (ref)
                            --  [5] New (ref)

                            v30 += v31 * deltaTime
                            CurrentCamera.CFrame = CFrame.lookAt(
                                (CFrame.new(Position) * CFrame.Angles(0, math.rad(v30), 0) * New).Position,
                                Position
                            )
                        end)

                        return
                    end

                    v30 += v31 * deltaTime_1
                    CurrentCamera.CFrame = CFrame.lookAt(
                        (CFrame.new(Position) * CFrame.Angles(0, math.rad(v30), 0) * New).Position,
                        Position
                    )
                end)

                return
            end

            v30 += v31 * deltaTime_2
            CurrentCamera.CFrame = CFrame.lookAt(
                (CFrame.new(Position) * CFrame.Angles(0, math.rad(v30), 0) * New).Position,
                Position
            )
        end)

        return
    end

    if arg2 == "ViewGrimoires" then
        local Tween_5 = _G.Tween
        Tween_5(
            Fade,
            { 0.5, "Quad", Enum.EasingDirection.Out },
            { BackgroundTransparency = 0 },
            false,
            true
        )
        CurrentCamera.CFrame = v6.CFrame
        task.wait(0.5)
        local Tween_6 = _G.Tween
        Tween_6(Fade, { 0.5, "Quad", Enum.EasingDirection.Out }, { BackgroundTransparency = 1 })

        return
    end

    if arg2 == "TrackGrimoire" then
        local v47 = t[2]
        v5:Play(0.15)
        local RenderStepped = RunService.RenderStepped

        local function v54() -- line: 147
            -- upvalues:
            --  [1] v47 (copy)
            --  [2] HumanoidRootPart (ref)
            --  [3] v4 (ref)
            --  [4] CurrentCamera (ref)
            --  [5] v6 (copy)

            if (v47.Position - HumanoidRootPart.Position).Magnitude < 20 then
                v4:Disconnect()
                CurrentCamera.CFrame = CFrame.lookAt(
                    (HumanoidRootPart.CFrame * CFrame.new(0, 3, -9)).Position,
                    HumanoidRootPart.Position
                )

                return
            end

            CurrentCamera.CFrame = CFrame.lookAt(v6.Position, v47.Position)
        end

        v4 = RenderStepped:Connect(v54)

        return
    end

    if arg2 == "Finish" then
        v5:Stop(0.1)
        local Tween_7 = _G.Tween
        Tween_7(
            Fade,
            { 0.25, "Quad", Enum.EasingDirection.Out },
            { BackgroundTransparency = 0 },
            false,
            true
        )
        CinematicBottom.Visible = false
        CurrentCamera.CameraType = "Custom"
        CurrentCamera.CameraSubject = v3.Humanoid
        task.wait(0.25)
        local Tween_8 = _G.Tween
        Tween_8(Fade, { 0.5, "Quad", Enum.EasingDirection.Out }, { BackgroundTransparency = 1 })
        Bin.Event.Value = ""
        _G.Use = true
    end
end)
