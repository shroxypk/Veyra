-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.AugmentPrompt.AugmentClient.Hover.destroy
-- Class: LocalScript
-- bytes: 656

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.CollectionService
local Parent = script.Parent
local LocalPlayer = Services_m.Players.LocalPlayer
local v2 = LocalPlayer.Character
local ResetOnSpawn = Parent:FindFirstAncestorWhichIsA("ScreenGui").ResetOnSpawn

if not v2 then
    v2 = LocalPlayer.CharacterAdded:Wait()
end

if not ResetOnSpawn then
    v2.AncestryChanged:Connect(function(_, arg2) -- line: 16
        -- upvalues:
        --  [1] Parent (copy)

        if not arg2 then
            Parent:Destroy()
        end
    end)
end
