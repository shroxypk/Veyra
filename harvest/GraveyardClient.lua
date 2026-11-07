-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.GraveyardClient
-- Class: ModuleScript
-- bytes: 4360

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local GraveyardRemote = ReplicatedStorage.Remotes:WaitForChild("GraveyardRemote")
local Objects = workspace.Map.Areas["@EldritchQuests"].Graveyard.Objects
local PuzzleContraption = Objects.PuzzleContraption
local Mechanisms = PuzzleContraption.Mechanisms
local Collision = PuzzleContraption.Collision
local GraveDoor = Objects.GraveDoor
local Errol = workspace.NPCS:WaitForChild("Errol")
Errol.Parent = nil
local t = { BlockA = 0, BlockB = 0, BlockC = 0, BlockD = 0 }

function Main() -- line: 28
    -- upvalues:
    --  [1] Mechanisms (copy)
    --  [2] t (copy)
    --  [3] GraveyardRemote (copy)

    for _, child in Mechanisms:GetChildren() do
        if child:IsA("BasePart") then
            local RotValue = child.RotValue
            RotValue:GetPropertyChangedSignal("Value"):Connect(function() -- line: 32
                -- upvalues:
                --  [1] child (copy)
                --  [2] RotValue (copy)
                --  [3] t (ref)
                --  [4] GraveyardRemote (ref)

                _G.PlaySound(
                    script.Turn,
                    child,
                    nil,
                    nil,
                    nil,
                    nil
                )
                local t_1 = { Orientation = Vector3.new(0, 0, RotValue.Value * 90) }
                _G.Tween(
                    child,
                    { 0.75, "Quad", Enum.EasingDirection.Out },
                    t_1,
                    false,
                    true
                )
                t[child.Name] = RotValue.Value
                GraveyardRemote:FireServer("Check", t)
            end)
        end
    end
end

GraveyardRemote.OnClientEvent:Connect(function(arg1, arg2) -- line: 47
    -- upvalues:
    --  [1] PuzzleContraption (copy)

    if arg1 == "Completed" then
        PuzzleContraption.Completed.Value = true

        return
    end

    if arg1 == "Rotated" then
        if arg2.Value >= 3 then
            arg2.Value = 0

            return
        end

        arg2.Value += 1
    end
end)
GraveyardRemote:FireServer("CheckCompleted")

local function tweenModel(arg3, arg4) -- line: 61
    local CFrameValue = Instance.new("CFrameValue")
    CFrameValue.Value = arg3:GetPrimaryPartCFrame()
    CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() -- line: 65
        -- upvalues:
        --  [1] arg3 (copy)
        --  [2] CFrameValue (copy)

        arg3:SetPrimaryPartCFrame(CFrameValue.Value)
    end)
    _G.Tween(
        CFrameValue,
        { 3, "Linear", Enum.EasingDirection.Out },
        { Value = arg4 },
        false,
        true
    )
    CFrameValue:Destroy()
end

local function Completed() -- line: 73
    -- upvalues:
    --  [1] PuzzleContraption (copy)
    --  [2] Mechanisms (copy)
    --  [3] Collision (copy)
    --  [4] Errol (copy)
    --  [5] GraveDoor (copy)
    --  [6] ReplicatedStorage (copy)
    --  [7] tweenModel (copy)

    local Value_2 = PuzzleContraption.Completed.Value

    for _, child_1 in pairs(Mechanisms:GetChildren()) do
        if child_1:IsA("BasePart") then
            local ProximityPrompt = child_1:FindFirstChildWhichIsA("ProximityPrompt")

            if ProximityPrompt then
                ProximityPrompt.Enabled = not Value_2
            end
        end
    end

    Collision.CanCollide = not Value_2

    if Value_2 then
        Errol.Parent = workspace.NPCS
    end

    if Value_2 and not GraveDoor.Open.Value then
        GraveDoor.Open.Value = true
        local v5 = ReplicatedStorage.SFX.Misc.GroundShake:Clone()
        v5.Parent = GraveDoor.Top.PrimaryPart
        v5.RollOffMaxDistance = 250
        v5:Play()
        _G.FastSpawn(function() -- line: 97
            -- upvalues:
            --  [1] tweenModel (ref)
            --  [2] GraveDoor (ref)

            tweenModel(GraveDoor.Top, GraveDoor.Top.PrimaryPart.CFrame * CFrame.new(0, 12, 0))
        end)
        tweenModel(GraveDoor.Bottom, GraveDoor.Bottom.PrimaryPart.CFrame * CFrame.new(0, -14, 0))
        _G.FadeSound(v5)
    end
end

PuzzleContraption.Completed:GetPropertyChangedSignal("Value"):Connect(Completed)
task.spawn(Completed)

return Main
