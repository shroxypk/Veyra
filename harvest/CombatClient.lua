-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.CombatClient
-- Class: LocalScript
-- bytes: 21590

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.ByteNetMax)
local Packets_m = require(Modules.Packets)
local Basic_m = require(Modules.Basic)
local StateManager_m = require(Modules.StateManager)
local CreateBindableAction_m = require(Modules.CreateBindableAction)
local GamepadLayer_m = require(Modules.GamepadLayer)
local GetKeybind_m = require(Modules.GetKeybind)
local StatManager_m = require(Modules.StatManager)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StateManager_m.require(v3)
local Humanoid = v3:WaitForChild("Humanoid")
local _ = v3:WaitForChild("HumanoidRootPart")
local _ = v3:WaitForChild("States")
local v5 = StatManager_m.require(v2)
local Binds = v2:WaitForChild("Binds")
local Settings = v2:WaitForChild("Settings")
local Block = Binds:WaitForChild("Block")
local Critical = Binds:WaitForChild("Critical")
local GrimoireUltimate = Binds:WaitForChild("Grimoire Ultimate")
local KeyCode_ButtonR1 = Enum.KeyCode.ButtonR1
local KeyCode_ButtonX = Enum.KeyCode.ButtonX

local _ = function() --[[ upperCut ]] -- line: 42
    -- upvalues:
    --  [1] Packets_m (copy)

    Packets_m.Combat.packets.AttackInput.send({ Action = "Uppercut", SprintAttack = false })
end

local function lightAttack() -- line: 49
    -- upvalues:
    --  [1] Humanoid (copy)
    --  [2] v4 (copy)
    --  [3] GetKeybind_m (copy)
    --  [4] Packets_m (copy)
    --  [5] Settings (copy)
    --  [6] v3 (copy)

    local v6 = "LightAttack"
    local AutoRun
    local v7, v8

    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        if not v4:IsSwimming() then
            if not v4:HasState("Airborne") then
                v6 = "AirAttack"
            elseif GetKeybind_m("Crouch") then
                Packets_m.Combat.packets.AttackInput.send(
                    { Action = "Uppercut", SprintAttack = false }
                )

                return
            end

            AutoRun = Settings:FindFirstChild("AutoRun")
            v7 = v4:IsSprinting()

            if v7 then
                v8 = AutoRun and AutoRun.Value
                v7 = not v8 or (if v3:GetAttribute("SprintKeyUsed") ~= true then false else true)
            end

            Packets_m.Combat.packets.AttackInput.send({ Action = v6, SprintAttack = v7 })

            return
        end

        if GetKeybind_m("Crouch") then
            Packets_m.Combat.packets.AttackInput.send({ Action = "Uppercut", SprintAttack = false })

            return
        end

        AutoRun = Settings:FindFirstChild("AutoRun")
        v7 = v4:IsSprinting()

        if v7 then
            v8 = AutoRun and AutoRun.Value
            v7 = not v8 or (if v3:GetAttribute("SprintKeyUsed") ~= true then false else true)
        end

        Packets_m.Combat.packets.AttackInput.send({ Action = v6, SprintAttack = v7 })

        return
    else
        if GetKeybind_m("Crouch") then
            Packets_m.Combat.packets.AttackInput.send({ Action = "Uppercut", SprintAttack = false })

            return
        end

        AutoRun = Settings:FindFirstChild("AutoRun")
        v7 = v4:IsSprinting()

        if v7 then
            v8 = AutoRun and AutoRun.Value
            v7 = not v8 or (if v3:GetAttribute("SprintKeyUsed") ~= true then false else true)
        end

        Packets_m.Combat.packets.AttackInput.send({ Action = v6, SprintAttack = v7 })

        return
    end
end

local _ = function(arg1) --[[ misdirect ]] -- line: 72
    -- upvalues:
    --  [1] Packets_m (copy)

    Packets_m.Combat.packets.MisdirectInput.send({ Action = arg1 })
end

local _ = function() --[[ slamAttack ]] -- line: 78
    -- upvalues:
    --  [1] Packets_m (copy)

    Packets_m.Combat.packets.AttackInput.send({ Action = "Slam", SprintAttack = false })
end

local function criticalAction(_, arg3, _) -- line: 85
    -- upvalues:
    --  [1] Packets_m (copy)

    if arg3 == Enum.UserInputState.Begin then
        Packets_m.Combat.packets.AttackInput.send({ Action = "HeavyAttack", SprintAttack = false })
    end
end

local v9 = false

local function blockAction(_, arg6, _) -- line: 96
    -- upvalues:
    --  [1] v9 (ref)
    --  [2] Packets_m (copy)

    if arg6 == Enum.UserInputState.Begin then
        v9 = true

        while true do
            if not v9 then
                break
            end

            Packets_m.Combat.packets.BlockInput.send({ Action = "Block Input" })
            task.wait()
        end

        Packets_m.Combat.packets.BlockInput.send({ Action = "End Block" })

        return
    end

    if arg6 == Enum.UserInputState.End then
        v9 = false
    end
end

local function ultimateAction(_, arg9, _) -- line: 116
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Packets_m (copy)

    if arg9 == Enum.UserInputState.Begin then
        if v5:GetStat("Magic") == "Beast" then
            ReplicatedStorage.Remotes.Beast:FireServer("Trigger")

            return
        end

        Packets_m.Magic.packets.Ultimate.send({})
    end
end

local function getBlockAnimation(arg11) -- line: 129
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Humanoid (copy)

    local Tool = arg11:FindFirstChildWhichIsA("Tool")

    if not Tool then
        return
    end

    local v10 = Tool:GetAttribute("Combat") or Tool:GetAttribute("Sword")

    if not v10 then
        return
    end

    local v12 = ReplicatedStorage.Animations.Blocks:FindFirstChild(`{v10}_Block`)

    if not v12 then
        return
    end

    return Humanoid.Animator:LoadAnimation(v12)
end

local t_2 = {}

for key, val in Basic_m.WeaponTypes do
    for _, val_1 in val do
        t_2[val_1] = key
    end
end

local v13 = nil

local function setupCombatCache(arg12, arg13) -- line: 158
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] ReplicatedStorage (copy)

    local t_3 = { Tool = arg13, IsCombatTool = arg13:GetAttribute("Combat") }
    t_3.WeaponType = t_3.IsCombatTool or arg13:GetAttribute("Sword")

    if t_3.WeaponType then
        local v15 = t_2[t_3.WeaponType]

        if v15 then
            local v16 = ReplicatedStorage.Animations.Parrys[v15 .. "_Parry"]
            t_3.ParryAnimSpeed = v16:GetAttribute("Speed")
            t_3.ParryAnimation = arg12:FindFirstChildOfClass("Humanoid").Animator:LoadAnimation(v16)
            t_3.ParryAnimation.Priority = Enum.AnimationPriority.Action
        end
    end

    return t_3
end

local _ = function() --[[ onParryInput ]] -- line: 181
    -- upvalues:
    --  [1] v13 (ref)

    if not v13 or not v13.ParryAnimation then
        return
    end

    v13.ParryAnimation:Play()
    v13.ParryAnimation:AdjustSpeed(v13.ParryAnimSpeed)
end

local _ = function() --[[ startBlocking ]] -- line: 191
    -- upvalues:
    --  [1] getBlockAnimation (copy)
    --  [2] v3 (copy)

    if BlockTrack then
        BlockTrack:Stop(0.1)
        BlockTrack = nil
    end

    BlockTrack = getBlockAnimation(v3)

    if BlockTrack then
        BlockTrack.Priority = Enum.AnimationPriority.Action
        BlockTrack:Play()
    end
end

local _ = function() --[[ stopBlocking ]] -- line: 205
    if BlockTrack then
        BlockTrack:Stop(0.1)
        BlockTrack = nil
    end
end

v4:ObserveReplicatedStateAdded(function(arg14) -- line: 212
    -- upvalues:
    --  [1] getBlockAnimation (copy)
    --  [2] v3 (copy)
    --  [3] v13 (ref)

    if arg14 == "SwordBlocking" or arg14 == "Blocking" then
        if BlockTrack then
            BlockTrack:Stop(0.1)
            BlockTrack = nil
        end

        BlockTrack = getBlockAnimation(v3)

        if BlockTrack then
            BlockTrack.Priority = Enum.AnimationPriority.Action
            BlockTrack:Play()

            return
        end
    elseif arg14 == "Parrying" and v13 then
        if not v13.ParryAnimation then
            return
        end

        v13.ParryAnimation:Play()
        v13.ParryAnimation:AdjustSpeed(v13.ParryAnimSpeed)
    end
end)
v4:ObserveReplicatedStateRemoved(function(arg15) -- line: 220
    if arg15 ~= "SwordBlocking" and arg15 ~= "Blocking" then
        return
    end

    if BlockTrack then
        BlockTrack:Stop(0.1)
        BlockTrack = nil
    end
end)
CreateBindableAction_m("Ultimate", GrimoireUltimate, ultimateAction)
CreateBindableAction_m("Critical", Critical, criticalAction)
CreateBindableAction_m("Block", Block, blockAction)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- line: 246
    -- upvalues:
    --  [1] GamepadLayer_m (copy)
    --  [2] v3 (copy)
    --  [3] v5 (copy)
    --  [4] KeyCode_ButtonR1 (copy)
    --  [5] KeyCode_ButtonX (copy)
    --  [6] Humanoid (copy)
    --  [7] UserInputService (copy)
    --  [8] v4 (copy)
    --  [9] Packets_m (copy)
    --  [10] lightAttack (copy)
    --  [11] Settings (copy)
    --  [12] GetKeybind_m (copy)

    if gameProcessedEvent then
        return
    end

    if input.UserInputType == Enum.UserInputType.Gamepad1 and GamepadLayer_m.isChorded(
        input.KeyCode
    ) then
        return
    end

    local v17 = v3:FindFirstChildWhichIsA("Tool")

    if v17 then
        local v18

        if not v17:GetAttribute("Combat") then
            if v17:GetAttribute("Sword") then
                if v5:GetStat("FightingStyle") ~= v17.Name then
                    return
                end

                v17 = input.UserInputType == Enum.UserInputType.MouseButton1 or (input.KeyCode == KeyCode_ButtonR1 or input.UserInputType == Enum.UserInputType.Touch)
                v18 = input.UserInputType == Enum.UserInputType.MouseButton2 or input.KeyCode == KeyCode_ButtonX

                if v18 then
                    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                        if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
                            if not v4:IsSwimming() then
                                Packets_m.Combat.packets.AttackInput.send(
                                    { Action = "Slam", SprintAttack = false }
                                )
                            elseif v17 then
                                lightAttack()

                                if Settings.HoldM1.Value then
                                    task.spawn(function() -- line: 271
                                        -- upvalues:
                                        --  [1] lightAttack (ref)
                                        --  [2] UserInputService (ref)
                                        --  [3] KeyCode_ButtonR1 (ref)

                                        repeat
                                            task.wait(0)
                                            lightAttack()
                                        until UserInputService:IsMouseButtonPressed(
                                            Enum.UserInputType.MouseButton1
                                        ) == false and not UserInputService:IsGamepadButtonDown(
                                            Enum.UserInputType.Gamepad1,
                                            KeyCode_ButtonR1
                                        )
                                    end)
                                end
                            end
                        elseif v17 then
                            lightAttack()

                            if Settings.HoldM1.Value then
                                task.spawn(function() -- line: 271
                                    -- upvalues:
                                    --  [1] lightAttack (ref)
                                    --  [2] UserInputService (ref)
                                    --  [3] KeyCode_ButtonR1 (ref)

                                    repeat
                                        task.wait(0)
                                        lightAttack()
                                    until UserInputService:IsMouseButtonPressed(
                                        Enum.UserInputType.MouseButton1
                                    ) == false and not UserInputService:IsGamepadButtonDown(
                                        Enum.UserInputType.Gamepad1,
                                        KeyCode_ButtonR1
                                    )
                                end)
                            end
                        end
                    elseif v17 then
                        lightAttack()

                        if Settings.HoldM1.Value then
                            task.spawn(function() -- line: 271
                                -- upvalues:
                                --  [1] lightAttack (ref)
                                --  [2] UserInputService (ref)
                                --  [3] KeyCode_ButtonR1 (ref)

                                repeat
                                    task.wait(0)
                                    lightAttack()
                                until UserInputService:IsMouseButtonPressed(
                                    Enum.UserInputType.MouseButton1
                                ) == false and not UserInputService:IsGamepadButtonDown(
                                    Enum.UserInputType.Gamepad1,
                                    KeyCode_ButtonR1
                                )
                            end)
                        end
                    end
                elseif v17 then
                    lightAttack()

                    if Settings.HoldM1.Value then
                        task.spawn(function() -- line: 271
                            -- upvalues:
                            --  [1] lightAttack (ref)
                            --  [2] UserInputService (ref)
                            --  [3] KeyCode_ButtonR1 (ref)

                            repeat
                                task.wait(0)
                                lightAttack()
                            until UserInputService:IsMouseButtonPressed(
                                Enum.UserInputType.MouseButton1
                            ) == false and not UserInputService:IsGamepadButtonDown(
                                Enum.UserInputType.Gamepad1,
                                KeyCode_ButtonR1
                            )
                        end)
                    end
                end

                if v18 then
                    Packets_m.Combat.packets.MisdirectInput.send({ Action = true })

                    if GetKeybind_m("Crouch") then
                        Packets_m.Combat.packets.AttackInput.send(
                            { Action = "Uppercut", SprintAttack = false }
                        )
                    end
                end

                return
            else
                return
            end
        else
            if v5:GetStat("FightingStyle") ~= v17.Name then
                return
            end

            v17 = input.UserInputType == Enum.UserInputType.MouseButton1 or (input.KeyCode == KeyCode_ButtonR1 or input.UserInputType == Enum.UserInputType.Touch)
            v18 = input.UserInputType == Enum.UserInputType.MouseButton2 or input.KeyCode == KeyCode_ButtonX

            if v18 then
                if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                    if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
                        if not v4:IsSwimming() then
                            Packets_m.Combat.packets.AttackInput.send(
                                { Action = "Slam", SprintAttack = false }
                            )
                        elseif v17 then
                            lightAttack()

                            if Settings.HoldM1.Value then
                                task.spawn(function() -- line: 271
                                    -- upvalues:
                                    --  [1] lightAttack (ref)
                                    --  [2] UserInputService (ref)
                                    --  [3] KeyCode_ButtonR1 (ref)

                                    repeat
                                        task.wait(0)
                                        lightAttack()
                                    until UserInputService:IsMouseButtonPressed(
                                        Enum.UserInputType.MouseButton1
                                    ) == false and not UserInputService:IsGamepadButtonDown(
                                        Enum.UserInputType.Gamepad1,
                                        KeyCode_ButtonR1
                                    )
                                end)
                            end
                        end
                    elseif v17 then
                        lightAttack()

                        if Settings.HoldM1.Value then
                            task.spawn(function() -- line: 271
                                -- upvalues:
                                --  [1] lightAttack (ref)
                                --  [2] UserInputService (ref)
                                --  [3] KeyCode_ButtonR1 (ref)

                                repeat
                                    task.wait(0)
                                    lightAttack()
                                until UserInputService:IsMouseButtonPressed(
                                    Enum.UserInputType.MouseButton1
                                ) == false and not UserInputService:IsGamepadButtonDown(
                                    Enum.UserInputType.Gamepad1,
                                    KeyCode_ButtonR1
                                )
                            end)
                        end
                    end
                elseif v17 then
                    lightAttack()

                    if Settings.HoldM1.Value then
                        task.spawn(function() -- line: 271
                            -- upvalues:
                            --  [1] lightAttack (ref)
                            --  [2] UserInputService (ref)
                            --  [3] KeyCode_ButtonR1 (ref)

                            repeat
                                task.wait(0)
                                lightAttack()
                            until UserInputService:IsMouseButtonPressed(
                                Enum.UserInputType.MouseButton1
                            ) == false and not UserInputService:IsGamepadButtonDown(
                                Enum.UserInputType.Gamepad1,
                                KeyCode_ButtonR1
                            )
                        end)
                    end
                end
            elseif v17 then
                lightAttack()

                if Settings.HoldM1.Value then
                    task.spawn(function() -- line: 271
                        -- upvalues:
                        --  [1] lightAttack (ref)
                        --  [2] UserInputService (ref)
                        --  [3] KeyCode_ButtonR1 (ref)

                        repeat
                            task.wait(0)
                            lightAttack()
                        until UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false and not UserInputService:IsGamepadButtonDown(
                            Enum.UserInputType.Gamepad1,
                            KeyCode_ButtonR1
                        )
                    end)
                end
            end

            if v18 then
                Packets_m.Combat.packets.MisdirectInput.send({ Action = true })

                if GetKeybind_m("Crouch") then
                    Packets_m.Combat.packets.AttackInput.send(
                        { Action = "Uppercut", SprintAttack = false }
                    )
                end
            end

            return
        end
    else
        return
    end
end)

local _ = function(arg18) --[[ onToolEquipped ]] -- line: 291
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] v13 (ref)
    --  [3] setupCombatCache (copy)

    local Character = v2.Character

    if not Character then
        return
    end

    v13 = setupCombatCache(Character, arg18)
end

local function onToolUnequipped() -- line: 298
    -- upvalues:
    --  [1] v13 (ref)

    if v13 and v13.ParryAnimation then
        v13.ParryAnimation:Stop(0)
        v13.ParryAnimation:Destroy()
    end

    v13 = nil
end

local t_4 = {}

local function hookTool(arg19) -- line: 312
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] v2 (copy)
    --  [3] v13 (ref)
    --  [4] setupCombatCache (copy)
    --  [5] onToolUnequipped (copy)

    if not arg19:IsA("Tool") or t_4[arg19] then
        return
    end

    t_4[arg19] = true
    arg19.Equipped:Connect(function() -- line: 316
        -- upvalues:
        --  [1] arg19 (copy)
        --  [2] v2 (ref)
        --  [3] v13 (ref)
        --  [4] setupCombatCache (ref)

        local Character_1 = v2.Character

        if not Character_1 then
            return
        end

        v13 = setupCombatCache(Character_1, arg19)
    end)
    arg19.Unequipped:Connect(onToolUnequipped)
end

for _, child in v2.Backpack:GetChildren() do
    hookTool(child)
end

v2.Backpack.ChildAdded:Connect(hookTool)
