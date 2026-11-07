-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.InventoryListener
-- Class: ModuleScript
-- bytes: 2553

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.UI.BaseNotification)
local _ = require(Modules.UI.UIEffects)
local ItemNotification_m = require(Modules.UI.ItemNotification)
local LocalPlayer = Players.LocalPlayer
local _ = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Notification")
local t = {}
t.__index = t

function t.new() -- line: 21
    -- upvalues:
    --  [1] t (copy)
    --  [2] Services_m (copy)

    local t_1 = setmetatable({}, t)
    t_1.Maid = Services_m.Maid.new()
    t_1.ItemMaids = {}
    t_1:Init()

    return t_1
end

function t.TrackItem(arg1, arg2, arg3) -- line: 32
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] ItemNotification_m (copy)
    --  [3] ReplicatedStorage (copy)

    local v2 = Services_m.Maid.new()
    arg1.ItemMaids[arg2] = v2
    local v3 = arg2:GetAttribute("Stock") or 0

    if not arg3 then
        ItemNotification_m.new(arg2.Name, v3, ReplicatedStorage.SFX.Misc.Alert)
    end

    v2:GiveTask(arg2:GetAttributeChangedSignal("Stock"):Connect(function() -- line: 48
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] v3 (ref)
        --  [3] ItemNotification_m (ref)
        --  [4] ReplicatedStorage (ref)

        local v4 = arg2:GetAttribute("Stock") or 0

        if v4 > v3 then
            ItemNotification_m.new(arg2.Name, v4 - v3, ReplicatedStorage.SFX.Misc.Alert)
        end

        v3 = v4
    end))
    v2:GiveTask(arg2.Destroying:Connect(function() -- line: 64
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] arg1 (copy)
        --  [3] arg2 (copy)

        v2:Destroy()
        arg1.ItemMaids[arg2] = nil
    end))
end

function t.Init(arg4) -- line: 71
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] RunService (copy)

    local Inventory = LocalPlayer:WaitForChild("Inventory")
    arg4.Maid:GiveTask(Inventory.ChildAdded:Connect(function(child_2) -- line: 75
        -- upvalues:
        --  [1] arg4 (copy)

        arg4:TrackItem(child_2, false)
    end))
    local _ = Inventory.ChildAdded:Connect(function(child_2) -- line: 75
        -- upvalues:
        --  [1] arg4 (copy)

        arg4:TrackItem(child_2, false)
    end)

    for _, child in Inventory:GetChildren() do
        arg4:TrackItem(child, true)
    end

    if RunService:IsStudio() then
    end
end

return t
