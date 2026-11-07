-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.Carry/Grip
-- Class: LocalScript
-- bytes: 1120

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("ContextActionService")
local CreateBindableAction_m = require(ReplicatedStorage.Modules.CreateBindableAction)
local v2, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Binds = v2:WaitForChild("Binds")
local Carry = Binds:WaitForChild("Carry")
local Grip = Binds:WaitForChild("Grip")

local function carryAction(_, arg2, _) -- line: 17
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if arg2 == Enum.UserInputState.Begin then
        ReplicatedStorage.Remotes.Player.DownedEvents:FireServer("Carry")
    end
end

local function gripAction(_, arg5, _) -- line: 23
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if arg5 == Enum.UserInputState.Begin then
        ReplicatedStorage.Remotes.Player.DownedEvents:FireServer("Grip")
    end
end

CreateBindableAction_m("Carry", Carry, carryAction)
CreateBindableAction_m("Grip", Grip, gripAction)
