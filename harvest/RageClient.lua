-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Player.Bars.BarsSide.RageMeter.Bar.RageClient
-- Class: LocalScript
-- bytes: 2704

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _ = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local CreateBindableAction_m = require(Modules.CreateBindableAction)
local GamepadLayer_m = require(Modules.GamepadLayer)
local StatManager_m = require(Modules.StatManager)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Parent = script.Parent

local function handleAction(_, arg2, _) -- line: 24
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if arg2 == Enum.UserInputState.Begin then
        ReplicatedStorage.Remotes.Beast:FireServer("Trigger")
    end
end

CreateBindableAction_m(
    "BeastRage",
    v2:WaitForChild("Binds"):WaitForChild("Summon Spirit"),
    handleAction
)
GamepadLayer_m.setHold(Enum.KeyCode.DPadLeft, function() -- line: 37
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if Enum.UserInputState.Begin == Enum.UserInputState.Begin then
        ReplicatedStorage.Remotes.Beast:FireServer("Trigger")
    end
end)
local v5 = nil
local Rotation = Parent.Rotation

local function onStep(_) -- line: 45
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] Rotation (copy)

    Parent.Rotation = Rotation + math.abs(math.sin(os.clock() * 30) * 0.65)
end

local function UpdateUI() -- line: 50
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] Parent (copy)
    --  [3] v4 (copy)
    --  [4] RunService (copy)
    --  [5] v5 (ref)
    --  [6] onStep (copy)
    --  [7] Rotation (copy)

    local v6 = v3:GetAttribute("rageStore") or 0
    local v7 = v3:GetAttribute("rageStoreMax") or 1
    local v8 = v6 >= v7 and true
    local v9 = false
    local Parent_1 = Parent.Parent

    if v4:GetStat("Magic") == "Beast" then
        v9 = if v4:GetStat("GrimoireEvolved") ~= true then RunService:IsStudio() else true
    end

    Parent_1.Visible = v9
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
v4:OnStatChanged("GrimoireEvolved", UpdateUI)
v3:GetAttributeChangedSignal("rageStore"):Connect(UpdateUI)
v3:GetAttributeChangedSignal("rageStoreMax"):Connect(UpdateUI)
UpdateUI()
