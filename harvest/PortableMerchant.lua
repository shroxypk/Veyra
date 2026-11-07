-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.InnerRealm.PortableMerchant
-- Class: ModuleScript
-- bytes: 2168

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Products_m = require(ReplicatedStorage.Modules.Products)
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)

local _ = function() --[[ ownsPass ]] -- line: 14
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Players (copy)
    --  [3] Products_m (copy)

    return if StatManager_m.require(Players.LocalPlayer):GetStat(
        Products_m.Products.PortableMerchant.Unlock
    ) ~= true then false else true
end

local function promptPass() -- line: 21
    -- upvalues:
    --  [1] Products_m (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] MarketplaceService (copy)
    --  [4] Players (copy)

    local Product = Products_m.Products.PortableMerchant.Product
    local GiftRemotes = ReplicatedStorage:FindFirstChild("GiftRemotes")
    local v3 = GiftRemotes

    if v3 then
        v3 = GiftRemotes:FindFirstChild("Request")
    end

    if v3 and pcall(v3.InvokeServer, v3, "PromptSelf", Product) then
        return
    end

    MarketplaceService:PromptProductPurchase(Players.LocalPlayer, Product)
end

local t = {
    DisplayName = "Portable Merchant",
    __override = true,
    start = function() --[[ start ]] -- line: 35
        -- upvalues:
        --  [1] StatManager_m (copy)
        --  [2] Players (copy)
        --  [3] Products_m (copy)

        if if StatManager_m.require(Players.LocalPlayer):GetStat(
            Products_m.Products.PortableMerchant.Unlock
        ) ~= true then false else true then
            return "greeting"
        end

        return "locked"
    end,
    nodes = nil
}
local t_1 = {
    greeting = {
        text = "Back again? Let's see what you've brought me.",
        choices = { { text = "I'd like to sell items.", action = "Sell" } }
    },
    locked = nil
}
local t_3 = {
    text = "A merchant could set up shop right here in your realm, ready whenever you need to sell.",
    choices = { { text = "Unlock the Portable Merchant.", action = promptPass } }
}
t_1.locked = t_3
t.nodes = t_1

return t
