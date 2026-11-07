-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.OutpostClient
-- Class: ModuleScript
-- bytes: 8698

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.CollectionService
local LocalPlayer = Services_m.Players.LocalPlayer
local RunService = Services_m.RunService
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local OutpostRemote = ReplicatedStorage.Remotes:WaitForChild("OutpostRemote")
local Outpost = workspace.Map.Areas["@EldritchQuests"].Outpost
local Ghosts = Outpost.Ghosts
local OutpostNote = Outpost:WaitForChild("Outpost Note")

function Main() -- line: 18
    -- upvalues:
    --  [1] OutpostRemote (copy)
    --  [2] Ghosts (copy)
    --  [3] Services_m (copy)
    --  [4] Outpost (copy)

    local Invoke = OutpostRemote:WaitForChild("Invoke")
    local v2 = Invoke:InvokeServer("GetData")

    for _, child in Ghosts:GetChildren() do
        local Name = child.Name

        if child:IsA("Model") then
            if v2[Name] then
                child:Destroy()
            else
                local v3 = script.ghost:Clone()
                local Humanoid = v3:FindFirstChildWhichIsA("Humanoid")
                local PrimaryPart = v3.PrimaryPart
                v3:PivotTo(child.PrimaryPart.CFrame * CFrame.new(0, 2.94, 0))
                local v7 = script.ChatObjectPrompt:Clone()
                v7.Triggered:Connect(function(_) -- line: 35
                    -- upvalues:
                    --  [1] Invoke (copy)
                    --  [2] Name (copy)
                    --  [3] v7 (copy)
                    --  [4] PrimaryPart (copy)
                    --  [5] Services_m (ref)
                    --  [6] v3 (copy)

                    if Invoke:InvokeServer("Collect", Name) then
                        v7:Destroy()
                        local v8 = script.effect:Clone()
                        v8.CFrame = PrimaryPart.CFrame
                        v8.Parent = workspace.Effects
                        _G.ToggleParticles(v8, true)

                        for _, val in v8:QueryDescendants("Light") do
                            _G.Tween(
                                val,
                                { 1.5, "Quad", Enum.EasingDirection.Out },
                                { Brightness = 1.5, Range = 15 }
                            )
                        end

                        local TweenService = Services_m.TweenService
                        local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear)
                        local v10 = TweenService:Create(
                            v8,
                            tweenInfo,
                            { CFrame = v8.CFrame * CFrame.Angles(0, 2.0943951023931953, 0) }
                        )
                        local v12 = TweenService:Create(
                            v8,
                            tweenInfo,
                            { CFrame = v8.CFrame * CFrame.Angles(0, 4.1887902047863905, 0) }
                        )
                        local v14 = TweenService:Create(
                            v8,
                            tweenInfo,
                            { CFrame = v8.CFrame * CFrame.Angles(0, 6.283185307179586, 0) }
                        )
                        v10.Completed:Connect(function() -- line: 55
                            -- upvalues:
                            --  [1] v12 (copy)

                            v12:Play()
                        end)
                        v12.Completed:Connect(function() -- line: 56
                            -- upvalues:
                            --  [1] v14 (copy)

                            v14:Play()
                        end)
                        v14.Completed:Connect(function() -- line: 57
                            -- upvalues:
                            --  [1] v10 (copy)

                            v10:Play()
                        end)
                        v10:Play()

                        for _, descendant in v3:GetDescendants() do
                            if descendant:IsA("BasePart") then
                                _G.Tween(
                                    descendant,
                                    { 1.5, "Quad", Enum.EasingDirection.Out },
                                    { Transparency = 1 }
                                )
                            end
                        end

                        task.delay(1.5, function() -- line: 66
                            -- upvalues:
                            --  [1] v3 (ref)

                            v3:Destroy()
                        end)
                        task.wait(6)

                        for _, descendant_1 in v8:GetDescendants() do
                            if descendant_1:IsA("Light") then
                                _G.Tween(
                                    descendant_1,
                                    { 1.5, "Quad", Enum.EasingDirection.Out },
                                    { Brightness = 0, Range = 0 }
                                )
                            end
                        end

                        _G.ToggleParticles(v8)
                        Services_m.Debris(v8, 8)
                    end
                end)
                v7.Parent = PrimaryPart
                v3.Parent = Outpost
                Humanoid.Animator:LoadAnimation(script.Idle):Play()
                child:Destroy()
            end
        end
    end
end

local v15 = Services_m.Maid.new()
local v16 = script.ChatObjectPrompt:Clone()
v16.Triggered:Connect(function(playerWhoTriggered) -- line: 93
    -- upvalues:
    --  [1] v15 (copy)
    --  [2] v16 (copy)
    --  [3] OutpostRemote (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] PlayerGui (copy)
    --  [6] RunService (copy)
    --  [7] OutpostNote (copy)

    v15:Destroy()
    v16.Enabled = false
    OutpostRemote:FireServer("Note")
    local v17 = ReplicatedStorage.UI.NoteUI:Clone()
    v17.ChatBox.Label.Text = "The outpost is lost. A fog engulfed the outpost and descended on us, transforming those who lingered within it into ravenous creatures.  There was hope, or so we believed, as stories of a cure emerged deep inside the mining caves. Three days ago, we dispatched a team to search the caves. They have yet to return. We have no more options now. The last of us that can still stand will go into the caves ourselves. If there remains any hope of saving the outpost, it exists there."
    v17.Enabled = true
    v17.Parent = PlayerGui
    v15:GiveTask(v17)

    local _ = function() --[[ disconnect ]] -- line: 105
        -- upvalues:
        --  [1] v15 (ref)
        --  [2] v17 (copy)
        --  [3] v16 (ref)

        v15:Destroy()
        v17:Destroy()
        v16.Enabled = true
    end

    v15:GiveTask(RunService.Heartbeat:Connect(function() -- line: 111
        -- upvalues:
        --  [1] playerWhoTriggered (copy)
        --  [2] OutpostNote (ref)
        --  [3] v16 (ref)
        --  [4] v17 (copy)
        --  [5] PlayerGui (ref)
        --  [6] v15 (ref)

        local Character = playerWhoTriggered.Character

        if Character then
            if Character.PrimaryPart then
                if not ((Character.PrimaryPart.Position - OutpostNote.PrimaryPart.Position).Magnitude > v16.MaxActivationDistance + 4) then
                    if v17:IsDescendantOf(PlayerGui) then
                        if not Character:IsDescendantOf(workspace) then
                            v15:Destroy()
                            v17:Destroy()
                            v16.Enabled = true
                        end
                    else
                        v15:Destroy()
                        v17:Destroy()
                        v16.Enabled = true
                    end
                else
                    v15:Destroy()
                    v17:Destroy()
                    v16.Enabled = true
                end
            elseif v17:IsDescendantOf(PlayerGui) then
                if not Character:IsDescendantOf(workspace) then
                    v15:Destroy()
                    v17:Destroy()
                    v16.Enabled = true
                end
            else
                v15:Destroy()
                v17:Destroy()
                v16.Enabled = true
            end
        elseif v17:IsDescendantOf(PlayerGui) then
            if not Character:IsDescendantOf(workspace) then
                v15:Destroy()
                v17:Destroy()
                v16.Enabled = true
            end
        else
            v15:Destroy()
            v17:Destroy()
            v16.Enabled = true
        end
    end))
end)
v16.Parent = OutpostNote
_G.PROMPTS[v16] = true

return Main
