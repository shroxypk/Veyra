-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.GamepadLayer.GamepadLayerHost
-- Class: Script
-- bytes: 170

local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules")
require(script.Parent)._attachHost()
require(Modules:WaitForChild("PadBinds"))._attachHost()
