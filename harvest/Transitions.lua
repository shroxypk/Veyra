-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Transitions
-- Class: ModuleScript
-- bytes: 3330

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("RunService")
local _ = ReplicatedStorage.Modules
local LocalPlayer = Players.LocalPlayer
local Transition = ReplicatedStorage.Remotes.Transition
local v2 = LocalPlayer:WaitForChild("PlayerGui")
local CurrentCamera = workspace.CurrentCamera
local v3 = v2:FindFirstChild("Transitions")

if not v3 then
    v3 = Instance.new("ScreenGui")
    v3.DisplayOrder = 2
    v3.ResetOnSpawn = false
    v3.IgnoreGuiInset = true
    v3.Parent = v2
end

v2 = v3:FindFirstChild("Fade") or script.Fade
v2.Parent = v3
local v4 = v2:Clone()
v4.Parent = v3
v3 = { Teleport = v4 }

local function PlayTransition(arg1) -- line: 38
    -- upvalues:
    --  [1] PlayTransition (copy)
    --  [2] CurrentCamera (copy)
    --  [3] TweenService (copy)
    --  [4] LocalPlayer (copy)
    --  [5] v3 (copy)
    --  [6] v2 (copy)

    local pointCamera

    if arg1.Type == "Camera" then
        local v5 = arg1.TweenTime or 1

        function pointCamera(vec1: Vector3, vec2: Vector3) -- line: 48
            -- upvalues:
            --  [1] PlayTransition (ref)
            --  [2] CurrentCamera (ref)
            --  [3] TweenService (ref)
            --  [4] v5 (copy)

            PlayTransition({ Type = nil, Action = "In", Yield = true })
            task.wait(0.1)
            PlayTransition({ Type = nil, Action = "Out", Yield = false })
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            local v8 = TweenService:Create(
                CurrentCamera,
                TweenInfo.new(v5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { CFrame = CFrame.lookAt(vec1, vec2) }
            )
            v8:Play()
            v8.Completed:Wait()
        end

        local function resetCamera() -- line: 74
            -- upvalues:
            --  [1] PlayTransition (ref)
            --  [2] CurrentCamera (ref)
            --  [3] LocalPlayer (ref)

            PlayTransition({ Type = nil, Action = "In", Yield = true })
            task.spawn(function() -- line: 81
                -- upvalues:
                --  [1] CurrentCamera (ref)
                --  [2] LocalPlayer (ref)

                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
            end)
            task.wait(0.1)
            PlayTransition({ Type = nil, Action = "Out", Yield = true })
        end

        pointCamera(arg1.Origin, arg1.Position)
        task.wait(0.5)
        resetCamera()

        return
    end

    local v9 = v3[arg1.Type] or v2
    local v10 = arg1.TweenTime or 0.25
    local Yield = arg1.Yield
    pointCamera = if arg1.Action ~= "In" then false else true
    local v11 = TweenService
    local tweenInfo_1 = TweenInfo.new(v10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v13 = v11:Create(
        v9,
        tweenInfo_1,
        { BackgroundTransparency = if not pointCamera then 1 else 0 }
    )
    v13:Play()

    if Yield then
        v13.Completed:Wait()
    end
end

Transition.OnClientEvent:Connect(PlayTransition)

return { Play = PlayTransition }
