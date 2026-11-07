-- Decompiled with Veyra harvester
-- Instance: StarterGui.HeadlessEvent.HeadlessEventClient
-- Class: LocalScript
-- bytes: 3744

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
local HeadlessEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("HeadlessEvent", 60)

if not HeadlessEvent then
    return
end

local v1 = nil

local function close() -- line: 22
    -- upvalues:
    --  [1] v1 (ref)

    if v1 then
        v1.Frame:Destroy()
        v1 = nil
    end
end

local _ = function() --[[ template ]] -- line: 29
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local ServerEventData = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild(
        "ServerEventData",
        30
    )
    local v2 = ServerEventData

    if v2 then
        v2 = ServerEventData:WaitForChild("Frame", 10)
    end

    return v2
end

local _ = function(n1: number) --[[ format ]] -- line: 34
    local v3 = math.ceil(n1)
    n1 = math.max(v3, 0)

    return string.format("%d:%02d", n1 // 60, n1 % 60)
end

local function show(n2: number, n3: number) -- line: 39
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] LocalPlayer (copy)
    --  [3] Parent (copy)
    --  [4] HeadlessEvent (copy)
    --  [5] close (copy)

    if v1 then
        v1.Frame:Destroy()
        v1 = nil
    end

    local ServerEventData_1 = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild(
        "ServerEventData",
        30
    )
    local v4 = ServerEventData_1

    if v4 then
        v4 = ServerEventData_1:WaitForChild("Frame", 10)
    end

    if not v4 then
        return
    end

    local v5 = v4:Clone()
    v5.Name = "HeadlessPrompt"
    v5.Visible = true
    local Info = v5.Info
    Info.Header.Text = "THE HEADLESS HORSEMAN"
    Info.Header.Shade.Text = "THE HEADLESS HORSEMAN"
    Info.Description.Text = "Headless is about to rise in his arena on the Halloween island. Teleport there to fight him?"
    Info.Participants.Visible = false
    Info.Options.Join.Text = "Teleport"
    Info.Options.Decline.Text = "Decline"
    v5.Parent = Parent
    local t = { Frame = v5 }
    v1 = t
    Info.Options.Join.Activated:Connect(function() -- line: 60
        -- upvalues:
        --  [1] HeadlessEvent (ref)
        --  [2] v1 (ref)

        HeadlessEvent:FireServer("Teleport")

        if v1 then
            v1.Frame:Destroy()
            v1 = nil
        end
    end)
    Info.Options.Decline.Activated:Connect(close)
    local Notice = v4.Parent:FindFirstChild("Notice", true)

    if Notice and Notice:IsA("Sound") then
        Notice:Play()
    end

    local clock = os.clock()
    task.spawn(function() -- line: 73
        -- upvalues:
        --  [1] v1 (ref)
        --  [2] t (copy)
        --  [3] clock (copy)
        --  [4] n3 (copy)
        --  [5] Info (copy)
        --  [6] n2 (copy)

        while true do
            if v1 ~= t then
                break
            end

            local v6 = os.clock() - clock

            if v6 >= n3 then
                if not v1 then
                    break
                end

                v1.Frame:Destroy()
                v1 = nil

                return
            end

            local Timer = Info.Timer
            local v8 = math.max(math.ceil(n2 - v6), 0)
            Timer.Text = `Headless rises in {string.format("%d:%02d", v8 // 60, v8 % 60)}`
            task.wait(0.2)
        end
    end)
end

HeadlessEvent.OnClientEvent:Connect(function(s1: string, n4: number?, n5: number?) -- line: 86
    -- upvalues:
    --  [1] show (copy)
    --  [2] v1 (ref)

    if s1 == "Prompt" and typeof(n4) == "number" and typeof(n5) == "number" then
        show(n4, n5)

        return
    end

    if s1 == "Close" and v1 then
        v1.Frame:Destroy()
        v1 = nil
    end
end)
