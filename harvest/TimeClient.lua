-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Player.Bars.BarsSide.TimeFrame.Bar.TimeClient
-- Class: LocalScript
-- bytes: 1725

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local StatManager_m = require(Modules.StatManager)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Parent = script.Parent
local v5 = nil
local Rotation = Parent.Rotation

local function onStep(_) -- line: 22
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] Rotation (copy)

    Parent.Rotation = Rotation + math.abs(math.sin(os.clock() * 30) * 0.65)
end

function UpdateUI() -- line: 27
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] Parent (copy)
    --  [3] v4 (copy)
    --  [4] v5 (ref)
    --  [5] RunService (copy)
    --  [6] onStep (copy)
    --  [7] Rotation (copy)

    local v6 = v3:GetAttribute("timeStore") or 0
    local v7 = v3:GetAttribute("timeStoreMax") or 1
    local v8 = v6 >= v7 and true
    Parent.Parent.Visible = if v4:GetStat("Magic") ~= "Time" then false else true
    Parent.Front:TweenSize(
        UDim2.new(math.clamp(v6 / v7, 0, 1), 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.25,
        true
    )

    if v8 then
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

v4:OnStatChanged("Magic", UpdateUI)
v3:GetAttributeChangedSignal("timeStore"):Connect(UpdateUI)
v3:GetAttributeChangedSignal("timeStoreMax"):Connect(UpdateUI)
UpdateUI()
