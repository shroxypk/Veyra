-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.Reset
-- Class: LocalScript
-- bytes: 961

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = Players.LocalPlayer
local Reset = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Reset")
local BindableEvent = Instance.new("BindableEvent")
BindableEvent.Event:connect(function() -- line: 8
    -- upvalues:
    --  [1] Reset (copy)

    Reset:FireServer()
end)
local v1 = 0

local function changeCallback() -- line: 16
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] BindableEvent (copy)
    --  [3] changeCallback (copy)

    if v1 < 20 then
        local Success, _ = pcall(function() -- line: 18
            -- upvalues:
            --  [1] BindableEvent (ref)

            return game:GetService("StarterGui"):SetCore("ResetButtonCallback", BindableEvent)
        end)

        if not Success then
            wait(1)
            v1 += 1
            changeCallback()

            return
        end
    end
end

changeCallback()
