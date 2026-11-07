-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.Stats.F1.StatPoints.Reset.ResetPoints
-- Class: LocalScript
-- bytes: 728

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Modules = ReplicatedStorage.Modules
local Products_m = require(Modules.Products)
local StatManager_m = require(Modules.StatManager)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local _ = StatManager_m.require(v2)
script.Parent.MouseButton1Up:Connect(function() -- line: 17
    -- upvalues:
    --  [1] MarketplaceService (copy)
    --  [2] v2 (copy)
    --  [3] Products_m (copy)

    MarketplaceService:PromptProductPurchase(v2, Products_m.Products.ResetPoints.Product)
end)
