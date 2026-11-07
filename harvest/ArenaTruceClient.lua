-- Decompiled with Veyra harvester
-- Instance: StarterGui.ArenaTruce.ArenaTruceClient
-- Class: LocalScript
-- bytes: 1511

local LocalPlayer = game:GetService("Players").LocalPlayer
local Parent = script.Parent
local color = Color3.fromRGB(255, 160, 60)
local Safezone = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Safezone", 30)
local v1 = Safezone

if v1 then
    v1 = Safezone:WaitForChild("Frame", 10)
end

if not v1 then
    return
end

local v3 = v1:Clone()
v3.Tip.Text = "Arena Truce: you're in Headless's arena. From the countdown until a minute after he falls, players can't hurt each other here."
v3.Tip.Visible = false
v1 = v3:FindFirstChild("Shield")

if v1 then
    v1.ImageColor3 = color
end

v3.Parent = Parent
v3.MouseEnter:Connect(function() -- line: 29
    -- upvalues:
    --  [1] v3 (copy)

    v3.Tip.Visible = true
end)
v3.MouseLeave:Connect(function() -- line: 32
    -- upvalues:
    --  [1] v3 (copy)

    v3.Tip.Visible = false
end)
local v4 = nil

local function watch(u1: userdata) -- line: 37
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] Parent (copy)

    if v4 then
        v4:Disconnect()
    end

    local function update() -- line: 41
        -- upvalues:
        --  [1] Parent (ref)
        --  [2] u1 (copy)

        Parent.Enabled = if u1:GetAttribute("InHeadlessZone") ~= true then false else true
    end

    v4 = u1:GetAttributeChangedSignal("InHeadlessZone"):Connect(update)
    Parent.Enabled = if u1:GetAttribute("InHeadlessZone") ~= true then false else true
end

if LocalPlayer.Character then
    watch(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(watch)
