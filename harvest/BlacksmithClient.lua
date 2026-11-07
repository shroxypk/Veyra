-- Decompiled with Veyra harvester
-- Instance: StarterGui.BlacksmithUI.BlacksmithClient
-- Class: LocalScript
-- bytes: 552

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Main = script.Parent.Main
ReplicatedStorage.Remotes.Blacksmith.Bindable.Event:Connect(function(arg1, arg2) -- line: 9
    -- upvalues:
    --  [1] Main (copy)

    if arg1 and (arg2 == "Craft" or arg2 == "Smelt") then
        Main:SetAttribute("OpenMode", nil)
        Main:SetAttribute("OpenMode", arg2)
    end

    Main.Visible = arg1
end)
