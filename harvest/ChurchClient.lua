-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.ChurchClient
-- Class: ModuleScript
-- bytes: 2035

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Quests = LocalPlayer:WaitForChild("Quests")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ChurchRemote = ReplicatedStorage.Remotes:WaitForChild("ChurchRemote")
local Objects = workspace.Map.Areas["@EldritchQuests"].Church.Objects
local _ = Objects:WaitForChild("HymnBook")
local Collision = Objects:WaitForChild("Doors"):WaitForChild("Collision")

function Main() -- line: 17
end

ChurchRemote.OnClientEvent:Connect(function(arg1, _) -- line: 20
    -- upvalues:
    --  [1] Objects (copy)

    if arg1 == "Completed" then
        Objects.Completed.Value = true
    end
end)
ChurchRemote:FireServer("CheckCompleted")

local function Completed() -- line: 28
    -- upvalues:
    --  [1] Objects (copy)
    --  [2] Collision (copy)
    --  [3] PlayerGui (copy)
    --  [4] ReplicatedStorage (copy)

    local Value = Objects.Completed.Value
    Collision.CanCollide = not Value

    if Value then
        local HymnUI = PlayerGui:FindFirstChild("HymnUI")

        if HymnUI then
            HymnUI.Enabled = false
        end

        for _, val in pairs(Objects.Doors:GetDescendants()) do
            if val:IsA("BasePart") then
                _G.Tween(val, { 0.5, "Quad", Enum.EasingDirection.Out }, { Transparency = 1 })
            end
        end

        local v3 = ReplicatedStorage.SFX.Misc.GroundShake:Clone()
        v3.Parent = Objects.Doors.PrimaryPart
        v3.RollOffMaxDistance = 250
        v3:Play()
        task.wait(2)
        _G.FadeSound(v3)
    end
end

Objects.Completed:GetPropertyChangedSignal("Value"):Connect(Completed)
task.spawn(Completed)
Quests.ChildAdded:Connect(function(child) -- line: 54
    -- upvalues:
    --  [1] ChurchRemote (copy)

    if child.Name == "Aric" then
        task.wait(3)
        ChurchRemote:FireServer("CheckCompleted")
    end
end)

return Main
