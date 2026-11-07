-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Player.Cooldowns.CooldownClient
-- Class: LocalScript
-- bytes: 2114

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local StateManager_m = require(Modules.StateManager)
local _, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StateManager_m.require(v3)
local t = {}

local function removeLabel(arg1) -- line: 16
    -- upvalues:
    --  [1] t (copy)

    local v5 = t[arg1]

    if not v5 then
        return
    end

    t[arg1] = nil
    v5:Destroy()
end

local function addLabel(arg2) -- line: 26
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] Services_m (copy)
    --  [3] t (copy)
    --  [4] RunService (copy)

    if not v4.Display[arg2] then
        return
    end

    local v6 = Services_m.Maid.new()

    local _ = function() --[[ disconnect ]] -- line: 34
        -- upvalues:
        --  [1] v6 (ref)

        if v6 then
            v6:Destroy()
            v6 = nil
        end
    end

    t[arg2] = v6
    local v7 = script.Label:Clone()
    v6:GiveTask(v7)

    local function handleLabel() -- line: 46
        -- upvalues:
        --  [1] v4 (ref)
        --  [2] arg2 (copy)
        --  [3] v6 (ref)
        --  [4] t (ref)
        --  [5] v7 (copy)

        local v8 = v4.Display[arg2]

        if not v8 then
            if v6 then
                v6:Destroy()
                v6 = nil
            end

            t[arg2] = nil

            return
        end

        local v9 = math.max(v8.EndTime - workspace:GetServerTimeNow(), 0)
        local v10 = math.clamp(v9 / v8.InitialTime, 0, 1)
        v7.Text = v8.Text .. " (" .. string.format("%.1f", v9) .. ")"
        v7.color.BackgroundColor3 = v8.Color
        v7.Size = UDim2.new(0, (v7.TextBounds.X + 2) * v10, 0, v7.Size.Y.Offset)
    end

    v6:GiveTask(v7:GetPropertyChangedSignal("TextBounds"):Connect(handleLabel))
    v6:GiveTask(RunService.RenderStepped:Connect(handleLabel))
    handleLabel()
    v7.Parent = script.Parent
end

v4:ObserveStateAdded(addLabel)
v4:ObserveStateRemoved(removeLabel)
