-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.TunePuzzleClient
-- Class: ModuleScript
-- bytes: 6154

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TunePuzzleRemote = ReplicatedStorage.Remotes:WaitForChild("TunePuzzleRemote")
local Objects = workspace.Map.Areas["@EldritchQuests"].TunePuzzle.Objects
local Puzzle = Objects:WaitForChild("Puzzle")
local Highlight = script:FindFirstChildWhichIsA("Highlight")
local t = {}
local t_1 = {}
local color = Color3.fromRGB(0, 0, 0)
local color_1 = Color3.fromRGB(91, 55, 53)
local v2 = true

local function resetPuzzle() -- line: 21
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Puzzle (copy)
    --  [3] v2 (ref)

    table.clear(t_1)

    for _, child in Puzzle.Stones:GetChildren() do
        if child:IsA("BasePart") then
            child:SetAttribute("Activated", false)
        end
    end

    v2 = true
end

local function main() -- line: 33
    -- upvalues:
    --  [1] Puzzle (copy)
    --  [2] TweenService (copy)
    --  [3] color_1 (copy)
    --  [4] t_1 (copy)
    --  [5] t (ref)
    --  [6] Highlight (copy)
    --  [7] TunePuzzleRemote (copy)
    --  [8] v2 (ref)
    --  [9] resetPuzzle (copy)
    --  [10] color (copy)

    for _, child_1 in Puzzle.Stones:GetChildren() do
        if child_1:IsA("BasePart") then
            local Rune = child_1.RunePart.Rune
            local num = tonumber(child_1.Name)
            local ProximityPrompt = child_1:FindFirstChildWhichIsA("ProximityPrompt")
            child_1:GetAttributeChangedSignal("Activated"):Connect(function() -- line: 42
                -- upvalues:
                --  [1] child_1 (copy)
                --  [2] ProximityPrompt (copy)
                --  [3] TweenService (ref)
                --  [4] Rune (copy)
                --  [5] color_1 (ref)
                --  [6] t_1 (ref)
                --  [7] num (copy)
                --  [8] t (ref)
                --  [9] Highlight (ref)
                --  [10] TunePuzzleRemote (ref)
                --  [11] v2 (ref)
                --  [12] resetPuzzle (ref)
                --  [13] color (ref)

                if child_1:GetAttribute("Activated") then
                    ProximityPrompt.Enabled = false
                    TweenService:Create(Rune, TweenInfo.new(1), { Color3 = color_1 }):Play()
                    table.insert(t_1, num)
                    local v8 = if t[#t_1] ~= num then false else true
                    script["Pitch" .. child_1.Name]:Play()
                    task.wait(1)

                    if v8 then
                        local v9 = script.ActiveHighlight:Clone()
                        v9.FillTransparency = 1
                        v9.OutlineTransparency = 1
                        v9.Parent = child_1
                        _G.Tween(
                            v9,
                            { 0.3, "Linear", Enum.EasingDirection.Out },
                            {
                                FillTransparency = Highlight.FillTransparency,
                                OutlineTransparency = Highlight.OutlineTransparency
                            },
                            nil,
                            true
                        )
                        TunePuzzleRemote:FireServer("Check", t_1)
                        v2 = true

                        return
                    end

                    resetPuzzle()

                    return
                else
                    ProximityPrompt.Enabled = true
                    TweenService:Create(Rune, TweenInfo.new(1), { Color3 = color }):Play()
                    local ActiveHighlight = child_1:FindFirstChild("ActiveHighlight")

                    if ActiveHighlight then
                        _G.Tween(
                            ActiveHighlight,
                            { 0.3, "Linear", Enum.EasingDirection.Out },
                            { FillTransparency = 1, OutlineTransparency = 1 },
                            true,
                            true
                        )
                    end

                    return
                end
            end)
        end
    end
end

TunePuzzleRemote.OnClientEvent:Connect(function(arg1, ...) -- line: 90
    -- upvalues:
    --  [1] Objects (copy)
    --  [2] v2 (ref)
    --  [3] t (ref)

    if arg1 == "Completed" then
        Objects.Completed.Value = true

        return
    end

    if arg1 == "Activate" and v2 then
        v2 = false
        (...):SetAttribute("Activated", true)

        return
    end

    if arg1 == "GetCode" then
        t = ...
    end
end)

local function Completed() -- line: 105
    -- upvalues:
    --  [1] Objects (copy)
    --  [2] Puzzle (copy)
    --  [3] color_1 (copy)
    --  [4] Services_m (copy)

    local Value = Objects.Completed.Value

    for _, child_2 in pairs(Puzzle.Stones:GetChildren()) do
        if child_2:IsA("BasePart") then
            local ProximityPrompt_1 = child_2:FindFirstChildWhichIsA("ProximityPrompt")
            local _ = child_2:FindFirstChild("ActiveHighlight")

            if ProximityPrompt_1 then
                ProximityPrompt_1.Enabled = not Value
            end

            if Value then
                child_2.RunePart.Rune.Color3 = color_1
                local ActiveHighlight_2 = child_2:FindFirstChild("ActiveHighlight")

                if ActiveHighlight_2 then
                    _G.Tween(
                        ActiveHighlight_2,
                        { 0.3, "Linear", Enum.EasingDirection.Out },
                        { FillTransparency = 1, OutlineTransparency = 1 },
                        true
                    )
                end
            end
        end
    end

    local Cauldron = Objects.Cauldron
    Cauldron.Root.FireAttachment.PuzzleFire.Enabled = Value

    if Value then
        Services_m.PlaySound(script.Ignite, Cauldron.Root)
    end
end

TunePuzzleRemote:FireServer("CheckCompleted")
TunePuzzleRemote:FireServer("GetCode")
Objects.Completed:GetPropertyChangedSignal("Value"):Connect(Completed)
task.spawn(Completed)

return main
