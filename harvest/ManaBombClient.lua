-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.ManaBombClient
-- Class: ModuleScript
-- bytes: 13346

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.CollectionService
local LocalPlayer = Services_m.Players.LocalPlayer
local ReplicatedStorage = Services_m.ReplicatedStorage
local Quests = LocalPlayer:WaitForChild("Quests")
local _ = LocalPlayer:WaitForChild("PlayerGui")
local BombQuestEvent = ReplicatedStorage.Remotes:WaitForChild("BombQuestEvent")
local ManaBombQuest = workspace.Map.Areas["@QuestAreas"].ManaBombQuest
local Wall = ManaBombQuest.Wall
local Eggs = ManaBombQuest.Eggs

function Main() -- line: 18
end

local v2 = Services_m.Maid.new()
local v3 = nil

local function controlCollisions(arg1, arg2) -- line: 25
    if arg1:IsA("BasePart") then
        arg1.CanCollide = arg2

        return
    end

    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = arg2
        end
    end
end

local function showObject(arg3, arg4) -- line: 37
    if arg3:IsA("BasePart") then
        arg3.Transparency = if not arg4 then 1 else 0

        return
    end

    for _, descendant_1 in arg3:GetDescendants() do
        if descendant_1:IsA("BasePart") then
            descendant_1.Transparency = if not arg4 then 1 else 0
        end
    end
end

local Asami = Quests:FindFirstChild("Asami")
local onCharacterAdded, promptTriggered

if Asami then
    if Asami:GetAttribute("Completed") then
        Eggs:Destroy()
        Wall:Destroy()
    else
        controlCollisions(Wall, true)
        showObject(Wall, true)
        local v6 = script.ChatObjectPrompt:Clone()
        v6.Enabled = false
        v6.Parent = Wall.PrimaryPart

        local function explodeWall() -- line: 61
            -- upvalues:
            --  [1] Wall (copy)
            --  [2] controlCollisions (copy)
            --  [3] ManaBombQuest (copy)

            local rng = Random.new()

            for _, val in {
                Wall.PrimaryPart.CFrame * CFrame.new(-3, -2, 0),
                Wall.PrimaryPart.CFrame * CFrame.new(3, -2, 0)
            } do
                _G.GetModule("Bomb")("Explosion", val)
                task.wait(0)
            end

            controlCollisions(Wall, false)
            Wall.PrimaryPart:Destroy()

            for _, descendant_2 in Wall:GetDescendants() do
                if descendant_2:IsA("BasePart") then
                    local v10 = descendant_2:Clone()
                    descendant_2.Transparency = 1
                    descendant_2.CanCollide = false
                    v10.Size *= 0.75
                    v10.Anchored = false
                    v10.CanCollide = true
                    v10.Parent = ManaBombQuest
                    local v11 = descendant_2.Velocity * rng:NextInteger(10, 15)
                    local v12 = rng:NextInteger(-30, 30)
                    v10.Velocity = v11 + Vector3.new(
                        v12,
                        rng:NextInteger(-30, 30),
                        rng:NextInteger(-30, 30)
                    )
                    task.delay(1, function() -- line: 90
                        -- upvalues:
                        --  [1] v10 (copy)

                        _G.Tween(
                            v10,
                            { 0.75, "Quad", Enum.EasingDirection.Out },
                            { Size = Vector3.new(0, 0, 0), Transparency = 1 },
                            true
                        )
                    end)
                end
            end
        end

        local function explodeEggs() -- line: 97
            -- upvalues:
            --  [1] Eggs (copy)

            for _, child in Eggs:GetChildren() do
                if child:IsA("Model") then
                    _G.GetModule("Bomb")("Explosion", child.PrimaryPart.CFrame)
                end
            end
        end

        function promptTriggered(_) -- line: 105
            -- upvalues:
            --  [1] Quests (copy)
            --  [2] Wall (copy)
            --  [3] v6 (copy)
            --  [4] v2 (copy)
            --  [5] v3 (ref)
            --  [6] BombQuestEvent (copy)
            --  [7] explodeWall (copy)
            --  [8] Eggs (copy)
            --  [9] explodeEggs (copy)
            --  [10] showObject (copy)
            --  [11] controlCollisions (copy)

            if Quests:FindFirstChild("Asami") then
                local t_6 = { DisplayName = "Your mind", start = "default", nodes = nil }
                local t_1 = {
                    default = { text = "I should use the bomb prototypes that Asami gave me..." }
                }
                t_6.nodes = t_1
                _G.ClientChatObject(Wall, v6, t_6)
                v2:Destroy()

                if v3 then
                    v3:Disconnect()
                    v3 = nil
                end

                BombQuestEvent:FireServer("ActivateEvent")
                task.wait(1)
                explodeWall()
                Wall:Destroy()
                v6:Destroy()
                local v26 = 0
                local v27 = 0

                for _, child_1 in Eggs:GetChildren() do
                    if child_1:IsA("Model") then
                        v27 += 1
                        local v28 = script.ChatObjectPrompt:Clone()
                        v28.Triggered:Connect(function() -- line: 145
                            -- upvalues:
                            --  [1] v28 (copy)
                            --  [2] v26 (ref)
                            --  [3] explodeEggs (ref)
                            --  [4] showObject (ref)
                            --  [5] child_1 (copy)
                            --  [6] controlCollisions (ref)
                            --  [7] v27 (ref)
                            --  [8] BombQuestEvent (ref)

                            v28:Destroy()
                            v26 += 1
                            task.wait(0.1)
                            explodeEggs()
                            showObject(child_1, false)
                            controlCollisions(child_1, true)

                            if v26 >= v27 then
                                BombQuestEvent:FireServer("BlowUpEggs")
                            end
                        end)
                        v28.Parent = child_1.PrimaryPart
                    end
                end

                return
            end

            local t_3 = { DisplayName = "Your mind", start = "default", nodes = nil }
            local t_4 = { default = { text = "A wall..." } }
            t_3.nodes = t_4
            _G.ClientChatObject(Wall, v6, t_3)
        end

        function onCharacterAdded(arg6) -- line: 181
            -- upvalues:
            --  [1] v2 (copy)
            --  [2] v6 (copy)

            v2:Destroy()

            local function attribChanged() -- line: 184
                -- upvalues:
                --  [1] v6 (ref)
                --  [2] arg6 (copy)

                v6.Enabled = arg6:GetAttribute("ManaVision")
            end

            v2.attribTag = arg6:GetAttributeChangedSignal("ManaVision"):Connect(attribChanged)
        end

        v6.Triggered:Connect(promptTriggered)
        v3 = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
        local Character = LocalPlayer.Character
        v2:Destroy()
        v2.attribTag = Character:GetAttributeChangedSignal("ManaVision"):Connect(function() --[[ attribChanged ]] -- line: 184
            -- upvalues:
            --  [1] v6 (copy)
            --  [2] Character (copy)

            v6.Enabled = Character:GetAttribute("ManaVision")
        end)
    end
else
    controlCollisions(Wall, true)
    showObject(Wall, true)
    local v34 = script.ChatObjectPrompt:Clone()
    v34.Enabled = false
    v34.Parent = Wall.PrimaryPart

    local function explodeWall_1() --[[ explodeWall ]] -- line: 61
        -- upvalues:
        --  [1] Wall (copy)
        --  [2] controlCollisions (copy)
        --  [3] ManaBombQuest (copy)

        local rng_1 = Random.new()

        for _, val_1 in {
            Wall.PrimaryPart.CFrame * CFrame.new(-3, -2, 0),
            Wall.PrimaryPart.CFrame * CFrame.new(3, -2, 0)
        } do
            _G.GetModule("Bomb")("Explosion", val_1)
            task.wait(0)
        end

        controlCollisions(Wall, false)
        Wall.PrimaryPart:Destroy()

        for _, descendant_3 in Wall:GetDescendants() do
            if descendant_3:IsA("BasePart") then
                local v38 = descendant_3:Clone()
                descendant_3.Transparency = 1
                descendant_3.CanCollide = false
                v38.Size *= 0.75
                v38.Anchored = false
                v38.CanCollide = true
                v38.Parent = ManaBombQuest
                local v39 = descendant_3.Velocity * rng_1:NextInteger(10, 15)
                local v40 = rng_1:NextInteger(-30, 30)
                v38.Velocity = v39 + Vector3.new(
                    v40,
                    rng_1:NextInteger(-30, 30),
                    rng_1:NextInteger(-30, 30)
                )
                task.delay(1, function() -- line: 90
                    -- upvalues:
                    --  [1] v38 (copy)

                    _G.Tween(
                        v38,
                        { 0.75, "Quad", Enum.EasingDirection.Out },
                        { Size = Vector3.new(0, 0, 0), Transparency = 1 },
                        true
                    )
                end)
            end
        end
    end

    local function explodeEggs_1() --[[ explodeEggs ]] -- line: 97
        -- upvalues:
        --  [1] Eggs (copy)

        for _, child_2 in Eggs:GetChildren() do
            if child_2:IsA("Model") then
                _G.GetModule("Bomb")("Explosion", child_2.PrimaryPart.CFrame)
            end
        end
    end

    function promptTriggered(_) -- line: 105
        -- upvalues:
        --  [1] Quests (copy)
        --  [2] Wall (copy)
        --  [3] v34 (copy)
        --  [4] v2 (copy)
        --  [5] v3 (ref)
        --  [6] BombQuestEvent (copy)
        --  [7] explodeWall_1 (copy)
        --  [8] Eggs (copy)
        --  [9] explodeEggs_1 (copy)
        --  [10] showObject (copy)
        --  [11] controlCollisions (copy)

        if Quests:FindFirstChild("Asami") then
            local t_13 = { DisplayName = "Your mind", start = "default", nodes = nil }
            local t_8 = {
                default = { text = "I should use the bomb prototypes that Asami gave me..." }
            }
            t_13.nodes = t_8
            _G.ClientChatObject(Wall, v34, t_13)
            v2:Destroy()

            if v3 then
                v3:Disconnect()
                v3 = nil
            end

            BombQuestEvent:FireServer("ActivateEvent")
            task.wait(1)
            explodeWall_1()
            Wall:Destroy()
            v34:Destroy()
            local v54 = 0
            local v55 = 0

            for _, child_3 in Eggs:GetChildren() do
                if child_3:IsA("Model") then
                    v55 += 1
                    local v56 = script.ChatObjectPrompt:Clone()
                    v56.Triggered:Connect(function() -- line: 145
                        -- upvalues:
                        --  [1] v56 (copy)
                        --  [2] v54 (ref)
                        --  [3] explodeEggs_1 (ref)
                        --  [4] showObject (ref)
                        --  [5] child_3 (copy)
                        --  [6] controlCollisions (ref)
                        --  [7] v55 (ref)
                        --  [8] BombQuestEvent (ref)

                        v56:Destroy()
                        v54 += 1
                        task.wait(0.1)
                        explodeEggs_1()
                        showObject(child_3, false)
                        controlCollisions(child_3, true)

                        if v54 >= v55 then
                            BombQuestEvent:FireServer("BlowUpEggs")
                        end
                    end)
                    v56.Parent = child_3.PrimaryPart
                end
            end

            return
        end

        local t_10 = { DisplayName = "Your mind", start = "default", nodes = nil }
        local t_11 = { default = { text = "A wall..." } }
        t_10.nodes = t_11
        _G.ClientChatObject(Wall, v34, t_10)
    end

    function onCharacterAdded(arg8) -- line: 181
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] v34 (copy)

        v2:Destroy()

        local function attribChanged_2() --[[ attribChanged ]] -- line: 184
            -- upvalues:
            --  [1] v34 (ref)
            --  [2] arg8 (copy)

            v34.Enabled = arg8:GetAttribute("ManaVision")
        end

        v2.attribTag = arg8:GetAttributeChangedSignal("ManaVision"):Connect(attribChanged_2)
    end

    v34.Triggered:Connect(promptTriggered)
    v3 = LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
    local Character_1 = LocalPlayer.Character
    v2:Destroy()
    v2.attribTag = Character_1:GetAttributeChangedSignal("ManaVision"):Connect(function() --[[ attribChanged ]] -- line: 184
        -- upvalues:
        --  [1] v34 (copy)
        --  [2] Character_1 (copy)

        v34.Enabled = Character_1:GetAttribute("ManaVision")
    end)
end

return Main
