-- Decompiled with Veyra harvester
-- Instance: StarterPack.ToolClass
-- Class: LocalScript
-- bytes: 5578

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.ByteNetMax)
local Packets_m = require(Modules.Packets)
local _ = require(Modules.Basic)
local _ = require(Modules.StateManager)
local _ = require(Modules.CreateBindableAction)
local _ = require(Modules.GetKeybind)
local GamepadLayer_m = require(Modules.GamepadLayer)
local Items_m = require(Modules.Items)
local StatManager_m = require(Modules.StatManager)
local SkillScrollPrompt_m = require(script:WaitForChild("SkillScrollPrompt"))
local v3, v4 = require(Modules.scriptObjs).GetPlayerCharacter()
local v5 = StatManager_m.require(v3)
local Inventory = v3:WaitForChild("Inventory")
local Humanoid = v4:WaitForChild("Humanoid")
local Animator = Humanoid:FindFirstChildWhichIsA("Animator")
local v6 = false
local v7 = nil
local t = { "Book", "Material", "Game", "Artifact" }
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- line: 36
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] v6 (ref)
    --  [3] GamepadLayer_m (copy)
    --  [4] Items_m (copy)
    --  [5] t (copy)
    --  [6] SkillScrollPrompt_m (copy)
    --  [7] Humanoid (copy)
    --  [8] ReplicatedStorage (copy)
    --  [9] v5 (copy)
    --  [10] Packets_m (copy)
    --  [11] Inventory (copy)

    if gameProcessedEvent or not v7 or not v6 then
        return
    end

    local v8 = if input.KeyCode ~= Enum.KeyCode.ButtonR1 then false else not GamepadLayer_m.isChorded(
        Enum.KeyCode.ButtonR1
    )

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch or v8 then
        local v9 = Items_m:LookupItem(v7.Name)

        if v9 and not table.find(t, v9.Type) then
            if v9.SkillScroll then
                SkillScrollPrompt_m.Open(v7.Name, function() -- line: 52
                    -- upvalues:
                    --  [1] Humanoid (ref)

                    Humanoid:UnequipTools()
                end)

                return
            end

            if v9.Type == "Consumable" then
                if ReplicatedStorage.Remotes.Player.Consumables:InvokeServer(v7) == true then
                    Humanoid:UnequipTools()

                    return
                end
            else
                if v9.Type == "Augment" then
                    ReplicatedStorage.Remotes.Grimoire:FireServer(
                        "EquipAugment",
                        v5:GetStat("Augment1"),
                        v7
                    )

                    return
                end

                local t_1 = { Item = Inventory:FindFirstChild(v7.Name) }
                Packets_m.Inventory.packets.Equip.send(t_1)
            end
        end
    end
end)
v4.ChildAdded:Connect(function(child) -- line: 71
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] v5 (copy)
    --  [3] v7 (ref)
    --  [4] Inventory (copy)
    --  [5] v6 (ref)
    --  [6] Packets_m (copy)
    --  [7] Animator (copy)
    --  [8] ReplicatedStorage (copy)

    local Name = child.Name
    local v10 = Items_m:LookupItem(Name)

    if child:IsA("Tool") and v10 then
        if v10.Type == "Weapon" then
            if v5:GetStat("FightingStyle") ~= Name then
                v7 = Inventory:FindFirstChild(child.Name)
                v6 = true

                if v10.ToolGrip then
                    Packets_m.Inventory.packets.Tool.listenOnce(function(_, _) -- line: 80
                        -- upvalues:
                        --  [1] Animator (ref)
                        --  [2] ReplicatedStorage (ref)

                        if not Idle then
                            Idle = Animator:LoadAnimation(
                                ReplicatedStorage.Animations.Items.ToolHold
                            )
                            Idle.Priority = Enum.AnimationPriority.Action
                        end

                        Idle:Play(0.2, nil, 0)
                    end)
                    Packets_m.Inventory.packets.Tool.send({ Action = "ToolHold", Item = v7 })
                end
            end
        else
            v7 = Inventory:FindFirstChild(child.Name)
            v6 = true

            if v10.ToolGrip then
                Packets_m.Inventory.packets.Tool.listenOnce(function(_, _) -- line: 80
                    -- upvalues:
                    --  [1] Animator (ref)
                    --  [2] ReplicatedStorage (ref)

                    if not Idle then
                        Idle = Animator:LoadAnimation(ReplicatedStorage.Animations.Items.ToolHold)
                        Idle.Priority = Enum.AnimationPriority.Action
                    end

                    Idle:Play(0.2, nil, 0)
                end)
                Packets_m.Inventory.packets.Tool.send({ Action = "ToolHold", Item = v7 })
            end
        end
    end
end)
v4.ChildRemoved:Connect(function(child_1) -- line: 97
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] v6 (ref)
    --  [3] Packets_m (copy)
    --  [4] Inventory (copy)

    local Name_1 = child_1.Name

    if child_1:IsA("Tool") and Items_m:LookupItem(Name_1) then
        if Idle then
            Idle:Stop()
        end

        v6 = false
        local t_3 = { Action = "ToolHide", Item = Inventory:FindFirstChild(Name_1) }
        Packets_m.Inventory.packets.Tool.send(t_3)
    end
end)
