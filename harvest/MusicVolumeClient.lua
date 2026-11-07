-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.MusicVolumeClient
-- Class: LocalScript
-- bytes: 632

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local BackgroundMusic = SoundService:WaitForChild("BackgroundMusic")
local MusicVolume = LocalPlayer:WaitForChild("Settings"):WaitForChild("MusicVolume")

local function controlVolume() -- line: 10
    -- upvalues:
    --  [1] BackgroundMusic (copy)
    --  [2] MusicVolume (copy)

    BackgroundMusic.Volume = (tonumber(MusicVolume.Value) or 100) / 100
end

MusicVolume:GetPropertyChangedSignal("Value"):Connect(controlVolume)
BackgroundMusic.Volume = (tonumber(MusicVolume.Value) or 100) / 100
