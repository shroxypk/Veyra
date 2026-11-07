-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.npcTypes.HalloweenReforge
-- Class: ModuleScript
-- bytes: 844

local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")

local function main(arg1) -- line: 9
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] Players (copy)

    ContextActionService:UnbindAction("ChatSkipKeys")
    arg1:HideChatBox()
    local Owner = arg1.Owner
    local OpenHalloweenForge = _G.OpenHalloweenForge

    if not OpenHalloweenForge then
        return
    end

    local v1 = OpenHalloweenForge
    local v2 = Owner and Owner.PrimaryPart

    repeat
        task.wait(0.1)
        local v3 = Players.LocalPlayer.Character
        v2 = v3 and v3.PrimaryPart
        v3 = Owner and Owner.PrimaryPart

        if not (v2 and (v3 and (v2.Position - v3.Position).Magnitude <= 22)) then
            break
        end
    until not v1(v2)()
end

return main
