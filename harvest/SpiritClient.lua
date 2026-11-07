-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Player.Bars.BarsSide.SpiritFrame.Bar.SpiritClient
-- Class: LocalScript
-- bytes: 2223

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local StatManager_m = require(Modules.StatManager)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local GetKeybind_m = require(Modules.GetKeybind)
local Parent = script.Parent

local function inputBegan(_, arg2) -- line: 20
    -- upvalues:
    --  [1] GetKeybind_m (copy)
    --  [2] ReplicatedStorage (copy)

    if arg2 then
        return
    end

    if GetKeybind_m("Summon Spirit") then
        ReplicatedStorage.Remotes.Spirit:FireServer("Trigger")
    end
end

local v5 = nil
local Rotation = Parent.Rotation

local function onStep(_) -- line: 32
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] Rotation (copy)

    Parent.Rotation = Rotation + math.abs(math.sin(os.clock() * 30) * 0.65)
end

local Basic_m = require(Modules.Basic)

local function UpdateUI() -- line: 37
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] Basic_m (copy)
    --  [3] Parent (copy)
    --  [4] v5 (ref)
    --  [5] RunService (copy)
    --  [6] onStep (copy)
    --  [7] Rotation (copy)

    local v6 = v4:GetStat("SpiritMeter") >= Basic_m.SpiritMeterMax and true
    Parent.Parent.Visible = if v4:GetStat("Deity") == "" then false else true
    local Front = Parent.Front
    local FromScale = UDim2.fromScale
    local SpiritMeter_1 = v4:GetStat("SpiritMeter")
    Front:TweenSize(
        FromScale(math.clamp(SpiritMeter_1 / Basic_m.SpiritMeterMax, 0, 1), 1),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.25,
        true
    )

    if v6 then
        if not v5 then
            v5 = RunService.Heartbeat:Connect(onStep)

            return
        end
    else
        if typeof(v5) == "RBXScriptConnection" then
            v5:Disconnect()
            v5 = nil
        end

        Parent.Rotation = Rotation
    end
end

UpdateUI()
UserInputService.InputBegan:Connect(inputBegan)
v4:OnStatChanged("Deity", UpdateUI)
v4:OnStatChanged("SpiritMeter", UpdateUI)
