-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.All.GrimoireEvolutionClient
-- Class: ModuleScript
-- bytes: 17115

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local _ = require(Modules.CheckQuestCompletion)
local Formatter_m = require(Modules.Formatter)
local UIEffects_m = require(Modules.UI.UIEffects)
local Transitions_m = require(Modules.Transitions)
local StateManager_m = require(Modules.StateManager)
local StatManager_m = require(Modules.StatManager)
local LocalPlayer = Players.LocalPlayer
local World = Basic_m.World
local CurrentCamera = workspace.CurrentCamera
local v2 = StatManager_m.require(LocalPlayer)
local Quests = LocalPlayer:WaitForChild("Quests")
local Bin = LocalPlayer:WaitForChild("bin")

local function main() -- line: 28
    -- upvalues:
    --  [1] World (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] LocalPlayer (copy)
    --  [4] StateManager_m (copy)
    --  [5] Bin (copy)
    --  [6] Transitions_m (copy)
    --  [7] CurrentCamera (copy)
    --  [8] TweenService (copy)
    --  [9] RunService (copy)
    --  [10] Services_m (copy)
    --  [11] UIEffects_m (copy)
    --  [12] Formatter_m (copy)
    --  [13] v2 (copy)
    --  [14] Basic_m (copy)
    --  [15] Quests (copy)

    local v3 = nil
    local v4 = 0
    local Statues = nil

    if World then
        Statues = script.Statues
        Statues.Parent = workspace.ChatObjects.GrimoireEvo
    end

    local function childAdded(u1: userdata) -- line: 42
        -- upvalues:
        --  [1] v3 (ref)
        --  [2] World (ref)
        --  [3] ReplicatedStorage (ref)
        --  [4] LocalPlayer (ref)
        --  [5] StateManager_m (ref)
        --  [6] Bin (ref)
        --  [7] Transitions_m (ref)
        --  [8] CurrentCamera (ref)
        --  [9] TweenService (ref)
        --  [10] RunService (ref)
        --  [11] Services_m (ref)
        --  [12] Statues (ref)
        --  [13] v4 (ref)
        --  [14] UIEffects_m (ref)
        --  [15] Formatter_m (ref)
        --  [16] v2 (ref)
        --  [17] Basic_m (ref)
        --  [18] Quests (ref)

        if u1.Name ~= "EvoQuest" then
            return
        end

        if v3 then
            v3:Disconnect()
            v3 = nil
        end

        if not u1:GetAttribute("Completed") then
            u1:GetAttributeChangedSignal("Completed"):Wait()
        end

        if World then
            local v10 = ReplicatedStorage.Remotes:WaitForChild("GrimoireEvolutionRemote")
            v10.OnClientEvent:Connect(function(arg1, arg2) -- line: 57
                -- upvalues:
                --  [1] LocalPlayer (ref)
                --  [2] StateManager_m (ref)
                --  [3] Bin (ref)
                --  [4] Transitions_m (ref)
                --  [5] CurrentCamera (ref)
                --  [6] TweenService (ref)
                --  [7] RunService (ref)
                --  [8] Services_m (ref)

                local Character = LocalPlayer.Character

                if Character:GetAttribute("InCutscene") then
                    return
                end

                local v11 = StateManager_m.require(Character)
                Character:SetAttribute("InCutscene", true)
                Bin.Event.Value = "97977767295461"
                local t = { "Occupied", "Frozen", "Cant Move" }

                for _, val in t do
                    v11:AddState(val)
                end

                local PrimaryPart = Character.PrimaryPart
                local v12 = Character.Humanoid.Animator:LoadAnimation(script.Meditate)
                PrimaryPart.Anchored = true

                if arg1 then
                    arg1.Enabled = false
                end

                local Candles = arg2.Candles
                local CamPart = arg2.CamPart
                local v13 = #Candles:GetChildren()
                local v14 = 1
                local v15 = CamPart.CFrame
                local Position = v15.Position
                local cframe = CFrame.lookAt((v15 * CFrame.new(0, 0, -4)).Position, Position)
                local v19 = 0
                local LookVector = v15.LookVector
                local v20 = math.atan2(LookVector.Z, LookVector.X)
                local v21 = math.cos(v20) * 25
                local v22 = Position + Vector3.new(v21, 0, math.sin(v20) * 25)
                Transitions_m.Play({ Type = nil, Action = "In", Yield = true })
                v12:Play()
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                CurrentCamera.CFrame = cframe
                task.wait(0.4)
                Transitions_m.Play({ Type = nil, Action = "Out", TweenTime = 1 })
                local v27 = TweenService
                local v28 = CurrentCamera
                local tweenInfo = TweenInfo.new(2)
                local v31 = v27:Create(v28, tweenInfo, { CFrame = CFrame.lookAt(v22, Position) })
                v31:Play()
                v31.Completed:Wait()
                CurrentCamera.CFrame = CFrame.lookAt(v22, Position)
                task.wait(0.25)
                local v33 = nil
                v33 = RunService.RenderStepped:Connect(function(deltaTime) -- line: 139
                    -- upvalues:
                    --  [1] v19 (ref)
                    --  [2] v13 (copy)
                    --  [3] v14 (ref)
                    --  [4] Candles (copy)
                    --  [5] TweenService (ref)
                    --  [6] Services_m (ref)
                    --  [7] v20 (copy)
                    --  [8] Position (copy)
                    --  [9] CurrentCamera (ref)
                    --  [10] v33 (ref)

                    v19 += deltaTime
                    local v34 = math.min(v19 / 9, 1)
                    local v35 = math.floor(v34 * v13) + 1

                    while true do
                        if not (v35 >= v14) then
                            break
                        end

                        if not (v14 <= v13) then
                            break
                        end

                        local v36 = Candles[v14]

                        for _, val_1 in v36:QueryDescendants("ParticleEmitter, PointLight") do
                            if val_1:IsA("PointLight") then
                                val_1.Brightness = 0
                                val_1.Range = 0
                                val_1.Enabled = true
                                TweenService:Create(
                                    val_1,
                                    TweenInfo.new(0.25),
                                    { Brightness = 4, Range = 8 }
                                ):Play()
                            else
                                val_1.Enabled = true
                            end
                        end

                        Services_m.PlaySound(script.Ignite, v36:FindFirstChildWhichIsA("BasePart"))
                        v14 += 1
                    end

                    local v38 = v20 - 6.283185307179586 * v34
                    local v39 = Position
                    local v40 = math.cos(v38) * 25
                    CurrentCamera.CFrame = CFrame.lookAt(
                        v39 + Vector3.new(v40, 0, math.sin(v38) * 25),
                        Position
                    )

                    if v34 >= 1 then
                        v33:Disconnect()
                    end
                end)

                while true do
                    if not v33.Connected then
                        break
                    end

                    task.wait()
                end

                task.wait(0.5)
                Transitions_m.Play({ Type = nil, Action = "In", Yield = true, TweenTime = 1 })
                v12:Stop(0.3)
                CurrentCamera.CameraType = "Custom"
                CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
                PrimaryPart.Anchored = false
                task.wait(1)
                _G.CreateSignificantAlert("MEDITATION COMPLETE", script.Complete)
                Transitions_m.Play({ Type = nil, Action = "Out", TweenTime = 1 })
                Character:SetAttribute("InCutscene", false)
                local v42
                Bin.Event.Value, v42 = "", t

                for _, val_2 in v42 do
                    v11:RemoveState(val_2)
                end
            end)

            for _, child in Statues:GetChildren() do
                if child:IsA("Model") then
                    v10 = script.Particles:Clone()
                    local v43 = script.Highlight:Clone()
                    local PrimaryPart_1 = child.PrimaryPart
                    child:GetAttributeChangedSignal("Activated"):Connect(function() -- line: 226
                        -- upvalues:
                        --  [1] child (copy)
                        --  [2] v10 (copy)
                        --  [3] PrimaryPart_1 (copy)
                        --  [4] v43 (copy)
                        --  [5] v4 (ref)

                        if child:GetAttribute("Activated") then
                            v10:PivotTo(PrimaryPart_1.CFrame)
                            v10.const.Part0 = PrimaryPart_1
                            v10.const.Part1 = v10
                            v10.Parent = child
                            v43.Parent = child
                            v4 += 1

                            if v4 >= 4 then
                            end
                        end
                    end)
                    local Handler_m = require(child.Handler)
                    local v47 = script.ChatObjectPrompt:Clone()
                    Handler_m.init(v47)
                    v47.Triggered:Connect(function(playerWhoTriggered) -- line: 247
                        -- upvalues:
                        --  [1] Handler_m (copy)
                        --  [2] PrimaryPart_1 (copy)
                        --  [3] Transitions_m (ref)
                        --  [4] CurrentCamera (ref)
                        --  [5] TweenService (ref)

                        if Handler_m.main() then
                            playerWhoTriggered.Character:SetAttribute("InCutscene", true)
                            local _ = PrimaryPart_1.Position - Vector3.new(0, 10, 0)
                            local v50 = PrimaryPart_1.CFrame * CFrame.new(0, 0, -50)
                            Transitions_m.Play({ Type = nil, Action = "In", Yield = true })
                            CurrentCamera.CameraType = Enum.CameraType.Scriptable
                            CurrentCamera.CFrame = CFrame.lookAt(
                                v50.Position,
                                PrimaryPart_1.Position
                            )
                            task.wait(0.5)
                            Transitions_m.Play({ Type = nil, Action = "Out" })
                            local v52 = TweenService
                            local v53 = CurrentCamera
                            local tweenInfo_2 = TweenInfo.new(3)
                            local v55 = v52:Create(
                                v53,
                                tweenInfo_2,
                                { CFrame = CurrentCamera.CFrame * CFrame.new(0, 10, 0) }
                            )
                            v55:Play()
                            v55.Completed:Wait()
                            Transitions_m.Play({ Type = nil, Action = "In", Yield = true })
                            CurrentCamera.CameraType = "Custom"
                            CurrentCamera.CameraSubject = playerWhoTriggered.Character.Humanoid
                            task.wait(0.25)
                            Transitions_m.Play({ Type = nil, Action = "Out" })
                            playerWhoTriggered.Character:SetAttribute("InCutscene", false)
                        end
                    end)
                    v47.Parent = child.DemonStatue.Root
                end
            end
        end

        local v57 = nil

        local function getQuestAdded(u2: userdata) -- line: 302
            -- upvalues:
            --  [1] v57 (ref)
            --  [2] UIEffects_m (ref)
            --  [3] Formatter_m (ref)
            --  [4] v2 (ref)
            --  [5] Basic_m (ref)
            --  [6] LocalPlayer (ref)

            if u2.Name ~= "EvoQuest2" then
                return
            end

            if v57 then
                v57:Disconnect()
                v57 = nil
            end

            if u2:GetAttribute("Completed") then
                return
            end

            local EvolutionGUI = script.EvolutionGUI
            local t_3 = {}
            local t_4 = {
                Arcane = {
                    Task = u2.Tasks["Arcane mastery"],
                    text = function(arg5) --[[ text ]] -- line: 320
                        return `{arg5}% of arcane mastery earned`
                    end,
                    Increment = 10
                },
                Bosses = {
                    Task = u2.Tasks["Defeat bosses"],
                    text = function(arg6) --[[ text ]] -- line: 327
                        return `{arg6}% of bosses felled`
                    end,
                    Increment = 1
                },
                Players = {
                    Task = u2.Tasks["Eliminate players"],
                    text = function(arg7) --[[ text ]] -- line: 334
                        return `{arg7}% of players defeated`
                    end,
                    Increment = 1
                },
                XP = {
                    text = function(arg8) --[[ text ]] -- line: 340
                        return `{arg8}% of evolution experience earned`
                    end,
                    Increment = 10
                }
            }

            local function toggleVisibility(arg9) -- line: 347
                -- upvalues:
                --  [1] UIEffects_m (ref)

                UIEffects_m.FadeOut(arg9, true, true)
                UIEffects_m.FadeIn(arg9, nil, true)
                arg9.Visible = true
                task.delay(3, function() -- line: 353
                    -- upvalues:
                    --  [1] UIEffects_m (ref)
                    --  [2] arg9 (copy)

                    UIEffects_m.FadeOut(arg9, nil, true)
                    task.wait(0.25)
                    arg9.Visible = false
                end)
            end

            for key_4, val_3 in t_4 do
                local Task = val_3.Task
                local Text = val_3.text
                local Increment = val_3.Increment
                local v58 = EvolutionGUI.Bars[key_4]
                local Front = v58.Front
                t_3[key_4] = -1

                local function hook(arg10, arg11) -- line: 373
                    -- upvalues:
                    --  [1] Formatter_m (ref)
                    --  [2] Increment (copy)
                    --  [3] t_3 (copy)
                    --  [4] key_4 (copy)
                    --  [5] toggleVisibility (copy)
                    --  [6] v58 (copy)
                    --  [7] Text (copy)
                    --  [8] Front (copy)

                    local v60 = Formatter_m.round(arg10 / arg11, 2)
                    local v61 = math.clamp(v60, 0, 1)
                    local v62 = math.floor(v61 * 100 / Increment)

                    if v62 > t_3[key_4] then
                        t_3[key_4] = v62
                        toggleVisibility(v58)
                    end

                    v58.Header.Text = Text((math.floor(v60 * 100)))
                    task.wait(0.2)
                    Front.Size = UDim2.fromScale(v61, 1)
                end

                if key_4 == "XP" then
                    v2:OnStatChanged("EvolutionXP", function() -- line: 393
                        -- upvalues:
                        --  [1] hook (copy)
                        --  [2] v2 (ref)
                        --  [3] Basic_m (ref)

                        hook(v2:GetStat("EvolutionXP"), Basic_m.EvolutionBreakthrough)
                    end)
                elseif Task then
                    Task:GetAttributeChangedSignal("TaskProgress"):Connect(function() -- line: 399
                        -- upvalues:
                        --  [1] hook (copy)
                        --  [2] Task (copy)

                        hook(Task:GetAttribute("TaskProgress"), Task:GetAttribute("TaskMax"))
                    end)
                end

                UIEffects_m.FadeOut(v58, true, true)
            end

            EvolutionGUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end

        v57 = Quests.ChildAdded:Connect(getQuestAdded)

        for _, child_1 in Quests:GetChildren() do
            getQuestAdded(child_1)
        end
    end

    v3 = Quests.ChildAdded:Connect(childAdded)

    for _, child_2 in Quests:GetChildren() do
        childAdded(child_2)
    end
end

return main
