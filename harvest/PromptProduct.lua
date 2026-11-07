-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.PromptProduct
-- Class: ModuleScript
-- bytes: 392

local Players = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local function main(arg1) -- line: 5
    -- upvalues:
    --  [1] MarketplaceService (copy)
    --  [2] Players (copy)

    MarketplaceService:PromptProductPurchase(Players.LocalPlayer, arg1:GetCurrentNode().productId)
end

return main
