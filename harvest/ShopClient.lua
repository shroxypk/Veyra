-- Decompiled with Veyra harvester
-- Instance: StarterGui.SellUI.Shop.ShopClient
-- Class: LocalScript
-- bytes: 4186

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local Modules = ReplicatedStorage.Modules
local StatManager_m = require(Modules.StatManager)
local Basic_m = require(Modules.Basic)
local Slider_m = require(Modules:WaitForChild("Slider"))
local v3, v4 = require(Modules.scriptObjs).GetPlayerCharacter()
local v5 = StatManager_m.require(v3)
local Bin = v3:WaitForChild("bin")
local v6 = nil
local ShopEvent = ReplicatedStorage.Remotes.Player.ShopEvent
local HumanoidRootPart = v4:WaitForChild("HumanoidRootPart")
local v7 = Services_m.Maid.new()

local function disconnect() -- line: 27
    -- upvalues:
    --  [1] v7 (copy)
    --  [2] v6 (ref)

    v7:Destroy()
    v6 = nil
end

local function onClientEvent(arg1, arg2) -- line: 32
    -- upvalues:
    --  [1] v6 (ref)
    --  [2] Bin (copy)
    --  [3] v7 (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] Slider_m (copy)
    --  [6] Basic_m (copy)
    --  [7] v5 (copy)
    --  [8] ShopEvent (copy)
    --  [9] Services_m (copy)
    --  [10] disconnect (copy)

    if v6 or Bin.Chatting.Value then
        return
    end

    v7:Destroy()
    ReplicatedStorage.SFX.Misc.Ding:Play()
    v6 = arg1
    local v8 = script:WaitForChild("BuyTemplate"):Clone()
    v8.Name = tick()
    v8.Display.Text = "Purchasing " .. arg1.Name .. "(s)"

    if arg1:GetAttribute("Unique") then
        Slider_m.Visible = false
    end

    v8.Parent = script.Parent
    v7:GiveTask(v8)
    local MaxBuy = Basic_m.MaxBuy
    local Holder = v8.Slider.Holder
    local TextControl = Holder.TextControl
    local t = { SliderData = nil, MoveInfo = nil }
    local t_1 = { Start = 1, End = MaxBuy, Increment = 1 }
    local New = Slider_m.new
    t.SliderData = t_1
    t.MoveInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad)
    local v9 = New(Holder, t)
    v9:Track()

    local function onChanged(n1: number) -- line: 70
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] v8 (copy)
        --  [3] v5 (ref)
        --  [4] TextControl (copy)
        --  [5] v9 (copy)
        --  [6] MaxBuy (copy)

        local v10 = math.floor(arg2 * n1)
        v8.Amount.Text = _G.addCommas(v10) .. " Marks"
        local Amount_1 = v8.Amount
        Amount_1.TextColor3 = v10 > v5:GetStat("Marks") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(
            255,
            255,
            255
        )
        TextControl.Text = n1
        v9._config.SliderData.End = MaxBuy
    end

    local function onFocusLost(_) -- line: 79
        -- upvalues:
        --  [1] TextControl (copy)
        --  [2] v9 (copy)

        local Text = TextControl.Text
        v9:OverrideValue(typeof((tonumber(Text))) == "number" and tonumber(Text) or 1)
    end

    local function onPress() -- line: 85
        -- upvalues:
        --  [1] ShopEvent (ref)
        --  [2] arg1 (copy)
        --  [3] v9 (copy)
        --  [4] Services_m (ref)
        --  [5] ReplicatedStorage (ref)
        --  [6] v7 (ref)
        --  [7] v6 (ref)

        local v13, _ = ShopEvent:InvokeServer("Buy", arg1, v9._data._value)

        if v13 then
            Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Coins, script)
            v7:Destroy()
            v6 = nil

            return
        end

        _G.CreateAlert("Unable to purchase item.", ReplicatedStorage.SFX.Misc.Error)
        v7:Destroy()
        v6 = nil
    end

    v7:GiveTask(v8.Action.Activated:Connect(onPress))
    v7:GiveTask(v8.Close.Activated:Connect(disconnect))
    TextControl.FocusLost:Connect(onFocusLost)
    v9.Changed:Connect(onChanged)
    v9:OverrideValue(1)
end

local function onStep() -- line: 105
    -- upvalues:
    --  [1] v6 (ref)
    --  [2] HumanoidRootPart (copy)
    --  [3] v7 (copy)

    if not v6 then
        return
    end

    if (HumanoidRootPart.Position - v6.PrimaryPart.Position).magnitude > 10 then
        v7:Destroy()
        v6 = nil
    end
end

ShopEvent.Client.OnClientEvent:Connect(onClientEvent)
RunService.Stepped:Connect(onStep)
