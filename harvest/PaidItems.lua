-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.PaidItems
-- Class: ModuleScript
-- bytes: 2656

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local t = { "Save Slot Token" }
local t_1 = { ATTRIBUTE = "PaidItemTradingAllowed" }
local t_2 = {}
local t_3 = {}

if RunService:IsServer() then
    local MarketServer = game:GetService("ServerScriptService"):WaitForChild("Init"):WaitForChild(
        "MarketServer"
    )

    for _, val in require(MarketServer:WaitForChild("Items")) do
        if val.index then
            t_2[val.index] = true
        end
    end

    for _, val_1 in require(MarketServer:WaitForChild("MarketItems")) do
        if val_1.Item then
            t_2[val_1.Item] = true

            if val_1.PaidRandom then
                t_3[val_1.Item] = true
            end
        end
    end

    for _, val_2 in t do
        t_2[val_2] = true
    end

    local t_4 = {}

    for key_3 in t_2 do
        table.insert(t_4, key_3)
    end

    local t_5 = {}

    for key_4 in t_3 do
        table.insert(t_5, key_4)
    end

    script:SetAttribute("RandomNames", HttpService:JSONEncode(t_5))
    script:SetAttribute("Names", HttpService:JSONEncode(t_4))
else
    local Names = script:GetAttribute("Names")

    if not Names then
        repeat
            task.wait(0.1)
            Names = script:GetAttribute("Names")

            if Names then
                break
            end
        until os.clock() + 10 < os.clock()
    end

    local Success, Result = pcall(HttpService.JSONDecode, HttpService, Names or "[]")

    for _, val_3 in Success and Result or {} do
        t_2[val_3] = true
    end

    local Success_1, Result_1 = pcall(
        HttpService.JSONDecode,
        HttpService,
        script:GetAttribute("RandomNames") or "[]"
    )

    for _, val_4 in Success_1 and Result_1 or {} do
        t_3[val_4] = true
    end
end

function t_1.IsPaidRandom(arg1) -- line: 83
    -- upvalues:
    --  [1] t_3 (copy)

    if typeof(arg1) ~= "string" then
        return false
    end

    return if t_3[arg1:split("_")[1]] ~= true then false else true
end

function t_1.IsPaid(arg2) -- line: 90
    -- upvalues:
    --  [1] t_2 (copy)

    if typeof(arg2) ~= "string" then
        return false
    end

    return if t_2[arg2:split("_")[1]] ~= true then false else true
end

function t_1.CanTradePaid(arg3) -- line: 97
    return if typeof(arg3) == "Instance" then if arg3:GetAttribute("PaidItemTradingAllowed") ~= true then false else true else false
end

function t_1.CanTrade(arg4, arg5, arg6) -- line: 102
    -- upvalues:
    --  [1] t_1 (copy)

    return if t_1.IsPaid(arg4) then t_1.CanTradePaid(arg5) and t_1.CanTradePaid(arg6) else true
end

return t_1
