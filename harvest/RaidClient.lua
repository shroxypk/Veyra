-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Player._Raid.RaidClient
-- Class: LocalScript
-- bytes: 2985

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local _, v3 = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Display = script.Parent.Display
local Remaining = Display.Remaining
local Header = Display.Header
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
local now = tick()
local _ = 2
local t = {}

local function AddInstance(arg1) -- line: 25
    -- upvalues:
    --  [1] t (copy)

    if t[arg1] then
        return
    end

    t[arg1] = arg1:WaitForChild("Camp_Data")
end

local function onStep() -- line: 30
    -- upvalues:
    --  [1] now (ref)
    --  [2] t (copy)
    --  [3] HumanoidRootPart (copy)
    --  [4] Header (copy)
    --  [5] Remaining (copy)
    --  [6] Display (copy)

    if tick() - now >= 2 then
        now = tick()
        local v6 = nil
        local v7 = nil

        for key, val in t do
            local _, Result = pcall(function() -- line: 37
                -- upvalues:
                --  [1] key (copy)
                --  [2] HumanoidRootPart (ref)
                --  [3] v6 (ref)
                --  [4] v7 (ref)
                --  [5] val (copy)

                if key.PrimaryPart and HumanoidRootPart and (key.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude < 300 then
                    v6, v7 = key, val
                end
            end)

            if Result then
                print(Result)
            end

            local _ = print

            if v6 then
                break
            end
        end

        if v6 and v7 then
            local CurrentFigures = v7:GetAttribute("CurrentFigures")
            local TotalFigures = v7:GetAttribute("TotalFigures")
            local v8 = math.floor(CurrentFigures / TotalFigures * 100)
            Header.Text = "\226\152\137 " .. v6.Name
            Header.HeaderShadow.Text = Header.Text
            Remaining.Text = "<font color=\"rgb(255, 176, 119)\">" .. v8 .. "%</font> of Entities Remaining"

            if not (CurrentFigures < TotalFigures) then
                if v6:GetAttribute("AlwaysDisplay") then
                    Display.Visible = true
                end
            else
                Display.Visible = true
            end
        else
            Display.Visible = false
        end
    end
end

RunService.Stepped:Connect(onStep)
CollectionService:GetInstanceAddedSignal("Raid"):Connect(AddInstance)
CollectionService:GetInstanceRemovedSignal("Raid"):Connect(function(arg2) -- line: 75
    -- upvalues:
    --  [1] t (copy)

    if t[arg2] then
        t[arg2] = nil
    end
end)

for _, val_1 in CollectionService:GetTagged("Raid") do
    if not t[val_1] then
        t[val_1] = val_1:WaitForChild("Camp_Data")
    end
end
