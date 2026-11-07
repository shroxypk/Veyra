-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.InnerRealm.PortableBanker
-- Class: ModuleScript
-- bytes: 2165

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
        Products_m.Products.PortableBanker.Unlock
    ) ~= true then false else true
end

local function promptPass() -- line: 21
    -- upvalues:
    --  [1] Products_m (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] MarketplaceService (copy)
    --  [4] Players (copy)

    local Product = Products_m.Products.PortableBanker.Product
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
    DisplayName = "Portable Banker",
    __override = true,
    start = function() --[[ start ]] -- line: 35
        -- upvalues:
        --  [1] StatManager_m (copy)
        --  [2] Players (copy)
        --  [3] Products_m (copy)

        if if StatManager_m.require(Players.LocalPlayer):GetStat(
            Products_m.Products.PortableBanker.Unlock
        ) ~= true then false else true then
            return "greeting"
        end

        return "locked"
    end,
    nodes = nil
}
local t_1 = {
    greeting = {
        text = "Your vault is safe with me. What can I do for you?",
        choices = { { text = "I'd like to access my bank.", action = "Banker" } }
    },
    locked = nil
}
local t_3 = {
    text = "A banker could keep your vault right here in your realm, open whenever you need it.",
    choices = { { text = "Unlock the Portable Banker.", action = promptPass } }
}
t_1.locked = t_3
t.nodes = t_1

return t
