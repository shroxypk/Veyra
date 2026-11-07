-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.WaypointClient
-- Class: ModuleScript
-- bytes: 8621

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Invoke = ReplicatedStorage.Remotes:WaitForChild("WaypointRemote"):WaitForChild("Invoke")
local Waypoint = CollectionService:GetTagged("Waypoint")
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function enablePortal(u1: userdata, b1: boolean?) -- line: 21
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] tweenInfo (copy)

    for _, val in u1:QueryDescendants("ParticleEmitter") do
        val.Enabled = true
    end

    for _, child in u1.Runes:GetChildren() do
        if b1 then
            TweenService:Create(child, tweenInfo, { Color = Color3.fromRGB(139, 155, 199) }):Play()
        else
            child.Color = Color3.fromRGB(139, 155, 199)
        end
    end

    local v4 = script.WaypointHum:Clone()
    v4.Parent = u1.PrimaryPart
    v4:Play()
end

local function disablePortal(arg1) -- line: 39
    for _, child_1 in arg1.Runes:GetChildren() do
        child_1.Color = Color3.fromRGB(0, 0, 0)
    end
end

local function Main() -- line: 45
    -- upvalues:
    --  [1] Invoke (copy)
    --  [2] Waypoint (copy)
    --  [3] Services_m (copy)
    --  [4] enablePortal (copy)
    --  [5] disablePortal (copy)
    --  [6] ReplicatedStorage (copy)
    --  [7] PlayerGui (copy)
    --  [8] RunService (copy)

    local t_1 = {
        DisplayName = "",
        start = "initial",
        nodes = { initial = { text = "You are not yet able to use waypoint travel." } }
    }
    local v5 = Invoke:InvokeServer("GetData")

    for _, val_1 in Waypoint do
        if val_1:IsA("Model") then
            local Name = val_1.Name
            local PrimaryPart = val_1.PrimaryPart
            local v8 = script.ChatObjectPrompt:Clone()
            _G.PROMPTS[v8] = true
            local v9 = Services_m.Maid.new()

            if v5[Name] then
                enablePortal(val_1)
            else
                disablePortal(val_1)
            end

            v8.Triggered:Connect(function(playerWhoTriggered) -- line: 79
                -- upvalues:
                --  [1] v9 (copy)
                --  [2] Invoke (ref)
                --  [3] Name (copy)
                --  [4] enablePortal (ref)
                --  [5] val_1 (copy)
                --  [6] v8 (copy)
                --  [7] t_1 (copy)
                --  [8] ReplicatedStorage (ref)
                --  [9] PlayerGui (ref)
                --  [10] PrimaryPart (copy)
                --  [11] RunService (ref)

                if playerWhoTriggered:HasTag("WaypointDebounce") then
                    return
                end

                v9:Destroy()

                if not Invoke:InvokeServer("GetData")[Name] then
                    if Invoke:InvokeServer("Collect", Name) then
                        enablePortal(val_1, true)

                        return
                    end

                    _G.ClientChatObject(val_1, v8, t_1)

                    return
                else
                    v8.Enabled = false
                    local v10 = ReplicatedStorage.UI.WaypointUI:Clone()
                    v10:SetAttribute("currentWaypoint", Name)
                    v10.Enabled = true
                    v10.Parent = PlayerGui

                    local _ = function() --[[ disconnect ]] -- line: 106
                        -- upvalues:
                        --  [1] v9 (ref)
                        --  [2] v10 (copy)
                        --  [3] v8 (ref)

                        v9:Destroy()
                        v10:Destroy()
                        task.delay(1, function() -- line: 109
                            -- upvalues:
                            --  [1] v8 (ref)

                            v8.Enabled = true
                        end)
                    end

                    local function onStep() -- line: 114
                        -- upvalues:
                        --  [1] playerWhoTriggered (copy)
                        --  [2] PrimaryPart (ref)
                        --  [3] v8 (ref)
                        --  [4] v10 (copy)
                        --  [5] PlayerGui (ref)
                        --  [6] v9 (ref)

                        local Character = playerWhoTriggered.Character

                        if Character then
                            if Character.PrimaryPart then
                                if not ((Character.PrimaryPart.Position - PrimaryPart.Position).Magnitude > v8.MaxActivationDistance + 4) then
                                    if v10:IsDescendantOf(PlayerGui) then
                                        if not Character:IsDescendantOf(workspace) then
                                            v9:Destroy()
                                            v10:Destroy()
                                            task.delay(1, function() -- line: 109
                                                -- upvalues:
                                                --  [1] v8 (ref)

                                                v8.Enabled = true
                                            end)
                                        end
                                    else
                                        v9:Destroy()
                                        v10:Destroy()
                                        task.delay(1, function() -- line: 109
                                            -- upvalues:
                                            --  [1] v8 (ref)

                                            v8.Enabled = true
                                        end)
                                    end
                                else
                                    v9:Destroy()
                                    v10:Destroy()
                                    task.delay(1, function() -- line: 109
                                        -- upvalues:
                                        --  [1] v8 (ref)

                                        v8.Enabled = true
                                    end)
                                end
                            elseif v10:IsDescendantOf(PlayerGui) then
                                if not Character:IsDescendantOf(workspace) then
                                    v9:Destroy()
                                    v10:Destroy()
                                    task.delay(1, function() -- line: 109
                                        -- upvalues:
                                        --  [1] v8 (ref)

                                        v8.Enabled = true
                                    end)
                                end
                            else
                                v9:Destroy()
                                v10:Destroy()
                                task.delay(1, function() -- line: 109
                                    -- upvalues:
                                    --  [1] v8 (ref)

                                    v8.Enabled = true
                                end)
                            end
                        elseif v10:IsDescendantOf(PlayerGui) then
                            if not Character:IsDescendantOf(workspace) then
                                v9:Destroy()
                                v10:Destroy()
                                task.delay(1, function() -- line: 109
                                    -- upvalues:
                                    --  [1] v8 (ref)

                                    v8.Enabled = true
                                end)
                            end
                        else
                            v9:Destroy()
                            v10:Destroy()
                            task.delay(1, function() -- line: 109
                                -- upvalues:
                                --  [1] v8 (ref)

                                v8.Enabled = true
                            end)
                        end
                    end

                    v9:GiveTask(v10)
                    v9:GiveTask(RunService.Heartbeat:Connect(onStep))

                    return
                end
            end)
            v8.Parent = PrimaryPart
        end
    end
end

return Main
