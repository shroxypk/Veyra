-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.SpawnController
-- Class: LocalScript
-- bytes: 589

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local Packets_m = require(Modules.Packets)
local _, _ = require(Modules.scriptObjs).GetPlayerCharacter()

local function main() -- line: 14
    -- upvalues:
    --  [1] Packets_m (copy)
    --  [2] main (copy)

    Packets_m.Spawn.packets.Update.send({})
    task.delay(4, main)
end

Packets_m.Spawn.packets.Update.send({})
task.delay(4, main)
