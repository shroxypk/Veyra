-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.AirDashClient
-- Class: ModuleScript
-- bytes: 3985

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.CollectionService
local LocalPlayer = Services_m.Players.LocalPlayer
local RunService = Services_m.RunService
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local AirDashRemote = ReplicatedStorage.Remotes:WaitForChild("AirDashRemote")

function Main() -- line: 14
end

local function init() -- line: 17
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] AirDashRemote (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] PlayerGui (copy)
    --  [5] RunService (copy)

    local Note = workspace.Map.Areas["@QuestAreas"].AirDashQuest:WaitForChild("AirDashShrine").Note
    local v2 = Services_m.Maid.new()
    local v3 = script.ChatObjectPrompt:Clone()
    v3.Triggered:Connect(function(playerWhoTriggered) -- line: 24
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] v3 (copy)
        --  [3] AirDashRemote (ref)
        --  [4] ReplicatedStorage (ref)
        --  [5] PlayerGui (ref)
        --  [6] RunService (ref)
        --  [7] Note (copy)

        v2:Destroy()
        v3.Enabled = false
        AirDashRemote:FireServer("Note")
        local v4 = ReplicatedStorage.UI.NoteUI:Clone()
        v4.ChatBox.Label.Text = "The sky welcomes those who trust in the wind. To move beyond the earth, one must release fear and become one with the air itself. Step boldly, let the currents carry you, and you will find freedom beyond the clouds."
        v4.Enabled = true
        v4.Parent = PlayerGui
        v2:GiveTask(v4)

        local _ = function() --[[ disconnect ]] -- line: 36
            -- upvalues:
            --  [1] v2 (ref)
            --  [2] v4 (copy)
            --  [3] v3 (ref)

            v2:Destroy()
            v4:Destroy()
            v3.Enabled = true
        end

        v2:GiveTask(RunService.Heartbeat:Connect(function() -- line: 42
            -- upvalues:
            --  [1] playerWhoTriggered (copy)
            --  [2] Note (ref)
            --  [3] v3 (ref)
            --  [4] v4 (copy)
            --  [5] PlayerGui (ref)
            --  [6] v2 (ref)

            local Character = playerWhoTriggered.Character

            if Character then
                if Character.PrimaryPart then
                    if not ((Character.PrimaryPart.Position - Note.PrimaryPart.Position).Magnitude > v3.MaxActivationDistance + 4) then
                        if v4:IsDescendantOf(PlayerGui) then
                            if not Character:IsDescendantOf(workspace) then
                                v2:Destroy()
                                v4:Destroy()
                                v3.Enabled = true
                            end
                        else
                            v2:Destroy()
                            v4:Destroy()
                            v3.Enabled = true
                        end
                    else
                        v2:Destroy()
                        v4:Destroy()
                        v3.Enabled = true
                    end
                elseif v4:IsDescendantOf(PlayerGui) then
                    if not Character:IsDescendantOf(workspace) then
                        v2:Destroy()
                        v4:Destroy()
                        v3.Enabled = true
                    end
                else
                    v2:Destroy()
                    v4:Destroy()
                    v3.Enabled = true
                end
            elseif v4:IsDescendantOf(PlayerGui) then
                if not Character:IsDescendantOf(workspace) then
                    v2:Destroy()
                    v4:Destroy()
                    v3.Enabled = true
                end
            else
                v2:Destroy()
                v4:Destroy()
                v3.Enabled = true
            end
        end))
    end)
    v3.Parent = Note.PrimaryPart
    _G.PROMPTS[v3] = true
end

init()

return Main
