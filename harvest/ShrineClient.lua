-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.ShrineClient
-- Class: ModuleScript
-- bytes: 8708

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local _ = ReplicatedStorage.Modules
local LocalPlayer = Players.LocalPlayer
local Quests = LocalPlayer:WaitForChild("Quests")
local _ = LocalPlayer:WaitForChild("PlayerGui")
local ShrineEvent = ReplicatedStorage.Remotes:WaitForChild("ShrineEvent")
local Orbs = script.Orbs
local v2 = workspace.Map.Areas["@QuestAreas"].RuinedShrineQuest:WaitForChild("Shrine"):GetPivot()
local v3 = Services_m.Maid.new()

local _ = function(arg1, arg2) --[[ toggleParticles ]] -- line: 28
    for _, val in arg1:QueryDescendants("ParticleEmitter, Trail") do
        val.Enabled = arg2
    end
end

local TravelingPriest = Quests:FindFirstChild("Traveling Priest")
local t
local v4, v5, v7

if TravelingPriest then
    if not TravelingPriest:GetAttribute("Completed") then
        v4 = 0
        v5 = 0

        for _, child in Orbs:GetChildren() do
            if child:IsA("Part") then
                v5 += 1

                for _, child_1 in script.Effects:GetChildren() do
                    child_1:Clone().Parent = child
                end

                child.Trail.Attachment0 = child.Attachment0
                child.Trail.Attachment1 = child.Attachment1
                v7 = Random.new():NextNumber(3, 4)
                local v8 = Random.new():NextNumber(0.25, 0.5)
                t = { CFrame = nil }
                local tweenInfo = TweenInfo.new(
                    v7,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    math.huge,
                    true,
                    v8
                )
                t.CFrame = child.CFrame * CFrame.new(0, 1, 0)
                local v10 = TweenService:Create(child, tweenInfo, t)
                v10:Play()
                local v11 = script.ChatObjectPrompt:Clone()
                v11.Triggered:Connect(function(_) -- line: 65
                    -- upvalues:
                    --  [1] Quests (copy)
                    --  [2] v11 (copy)
                    --  [3] v4 (ref)
                    --  [4] v10 (copy)
                    --  [5] v2 (copy)
                    --  [6] child (copy)
                    --  [7] TweenService (copy)
                    --  [8] v5 (ref)
                    --  [9] ShrineEvent (copy)

                    if not Quests:FindFirstChild("Traveling Priest") then
                        return
                    end

                    v11:Destroy()
                    script.Collect:Play()
                    task.wait(0.25)
                    v4 += 1
                    v10:Cancel()
                    local v12 = math.max((v2.Position - child.Position).Magnitude / 25, 5)
                    local v15 = TweenService:Create(child, TweenInfo.new(v12), { CFrame = v2 })
                    v15:Play()
                    v15.Completed:Wait()
                    child:Destroy()

                    if v4 >= v5 then
                        ShrineEvent:FireServer()
                    end
                end)
                v11.Parent = child
            end
        end

        addedConnection = LocalPlayer.CharacterAdded:Connect(function(character) --[[ onCharacterAdded ]] -- line: 100
            -- upvalues:
            --  [1] v3 (copy)
            --  [2] Orbs (copy)

            v3:Destroy()

            local function attribChanged() -- line: 103
                -- upvalues:
                --  [1] character (copy)
                --  [2] Orbs (ref)

                local ManaVision = character:GetAttribute("ManaVision")
                local v16 = workspace.Effects
                local v17 = Orbs

                if not ManaVision or not v16 then
                    v16 = script
                end

                v17.Parent = v16

                for _, val_1 in Orbs:QueryDescendants("ParticleEmitter, Trail") do
                    val_1.Enabled = ManaVision
                end
            end

            v3.attribTag = character:GetAttributeChangedSignal("ManaVision"):Connect(attribChanged)
        end)
        local Character = LocalPlayer.Character
        v3:Destroy()
        v3.attribTag = Character:GetAttributeChangedSignal("ManaVision"):Connect(function() --[[ attribChanged ]] -- line: 103
            -- upvalues:
            --  [1] Character (copy)
            --  [2] Orbs (copy)

            local ManaVision_1 = Character:GetAttribute("ManaVision")
            local v19 = workspace.Effects
            local v20 = Orbs

            if not ManaVision_1 or not v19 then
                v19 = script
            end

            v20.Parent = v19

            for _, val_2 in Orbs:QueryDescendants("ParticleEmitter, Trail") do
                val_2.Enabled = ManaVision_1
            end
        end)
    end
else
    v4 = 0
    v5 = 0

    for _, child_2 in Orbs:GetChildren() do
        if child_2:IsA("Part") then
            v5 += 1

            for _, child_3 in script.Effects:GetChildren() do
                child_3:Clone().Parent = child_2
            end

            child_2.Trail.Attachment0 = child_2.Attachment0
            child_2.Trail.Attachment1 = child_2.Attachment1
            v7 = Random.new():NextNumber(3, 4)
            local v22 = Random.new():NextNumber(0.25, 0.5)
            t = { CFrame = nil }
            local tweenInfo_2 = TweenInfo.new(
                v7,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                math.huge,
                true,
                v22
            )
            t.CFrame = child_2.CFrame * CFrame.new(0, 1, 0)
            local v24 = TweenService:Create(child_2, tweenInfo_2, t)
            v24:Play()
            local v25 = script.ChatObjectPrompt:Clone()
            v25.Triggered:Connect(function(_) -- line: 65
                -- upvalues:
                --  [1] Quests (copy)
                --  [2] v25 (copy)
                --  [3] v4 (ref)
                --  [4] v24 (copy)
                --  [5] v2 (copy)
                --  [6] child (copy)
                --  [7] TweenService (copy)
                --  [8] v5 (ref)
                --  [9] ShrineEvent (copy)

                if not Quests:FindFirstChild("Traveling Priest") then
                    return
                end

                v25:Destroy()
                script.Collect:Play()
                task.wait(0.25)
                v4 += 1
                v24:Cancel()
                local v26 = math.max((v2.Position - child.Position).Magnitude / 25, 5)
                local v29 = TweenService:Create(child, TweenInfo.new(v26), { CFrame = v2 })
                v29:Play()
                v29.Completed:Wait()
                child:Destroy()

                if v4 >= v5 then
                    ShrineEvent:FireServer()
                end
            end)
            v25.Parent = child_2
        end
    end

    addedConnection = LocalPlayer.CharacterAdded:Connect(function(character_1) --[[ onCharacterAdded ]] -- line: 100
        -- upvalues:
        --  [1] v3 (copy)
        --  [2] Orbs (copy)

        v3:Destroy()

        local function attribChanged_2() --[[ attribChanged ]] -- line: 103
            -- upvalues:
            --  [1] character_1 (copy)
            --  [2] Orbs (ref)

            local ManaVision_2 = character_1:GetAttribute("ManaVision")
            local v30 = workspace.Effects
            local v31 = Orbs

            if not ManaVision_2 or not v30 then
                v30 = script
            end

            v31.Parent = v30

            for _, val_3 in Orbs:QueryDescendants("ParticleEmitter, Trail") do
                val_3.Enabled = ManaVision_2
            end
        end

        v3.attribTag = character_1:GetAttributeChangedSignal("ManaVision"):Connect(attribChanged_2)
    end)
    local Character_1 = LocalPlayer.Character
    v3:Destroy()
    v3.attribTag = Character_1:GetAttributeChangedSignal("ManaVision"):Connect(function() --[[ attribChanged ]] -- line: 103
        -- upvalues:
        --  [1] Character_1 (copy)
        --  [2] Orbs (copy)

        local ManaVision_3 = Character_1:GetAttribute("ManaVision")
        local v33 = workspace.Effects
        local v34 = Orbs

        if not ManaVision_3 or not v33 then
            v33 = script
        end

        v34.Parent = v33

        for _, val_4 in Orbs:QueryDescendants("ParticleEmitter, Trail") do
            val_4.Enabled = ManaVision_3
        end
    end)
end

local function main() -- line: 116
end

return main
