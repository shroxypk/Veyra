-- Decompiled with Veyra harvester
-- Instance: StarterGui.ServerEventData.ServerEventClient
-- Class: LocalScript
-- bytes: 8088

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("Lighting")
local _ = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local _, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()

while true do
    if ReplicatedStorage:FindFirstChild("ServerEventData") then
        break
    end

    task.wait()
end

local Frame = script.Parent.Frame
local Info = Frame.Info
local ServerEventData = ReplicatedStorage:WaitForChild("ServerEventData")

local function updateEvent() -- line: 24
    -- upvalues:
    --  [1] ServerEventData (copy)
    --  [2] Frame (copy)
    --  [3] Info (copy)

    local v4 = string.upper(ServerEventData.Event.Value)

    if v4 == "" or not ServerEventData.Active.Value then
        Frame.Visible = false

        return
    end

    local v5 = #ServerEventData.Participants:GetChildren()
    local Value = ServerEventData.Timer.Value
    local v6 = if Value == 1 then " second remaining" else " seconds remaining"
    Info.Header.Text = v4
    Info.Header.Shade.Text = Info.Header.Text
    Info.Description.Text = ServerEventData.Description.Value
    Info.Participants.Text = v5 .. (if v5 == 1 then " participant" else " participants") .. " <b>[min. 2 required]</b>"
    Info.Timer.Text = Value .. v6

    if ServerEventData.Queue.Value then
    end

    Frame.Visible = true
end

ServerEventData.Active:GetPropertyChangedSignal("Value"):Connect(function() -- line: 47
    -- upvalues:
    --  [1] ServerEventData (copy)

    if ServerEventData.Active.Value then
        script.Notice:Play()
    end
end)
ServerEventData.Participants.ChildAdded:Connect(updateEvent)
ServerEventData.Participants.ChildRemoved:Connect(updateEvent)

for _, child in ServerEventData:GetChildren() do
    if child:IsA("ValueBase") then
        child:GetPropertyChangedSignal("Value"):Connect(updateEvent)
    end
end

updateEvent()
Info.Options.Join.Activated:Connect(function() -- line: 64
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.ServerEventQueue:InvokeServer("Join")
end)
Info.Options.Decline.Activated:Connect(function() -- line: 67
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] ServerEventData (copy)

    if ReplicatedStorage.Remotes.ServerEventQueue:InvokeServer("Leave") then
        ServerEventData.Active.Value = false
    end
end)

local function CreateCD(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 73
    -- upvalues:
    --  [1] TweenService (copy)

    local v8 = script.Label:Clone()
    v8.Text = arg1
    v8.TextColor3 = arg2 or v8.TextColor3
    v8.Position = arg5 or v8.Position
    v8.Parent = script.Parent
    local v10 = arg4 or 1
    v8:TweenSize(
        UDim2.new(0.2, 0, 0.05, 0),
        "Out",
        "Quad",
        v10,
        true
    )
    task.delay(v10 * 0.8, function() -- line: 82
        -- upvalues:
        --  [1] TweenService (ref)
        --  [2] v8 (copy)
        --  [3] v10 (copy)

        TweenService:Create(
            v8,
            TweenInfo.new(v10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { TextTransparency = 1, TextStrokeTransparency = 1 }
        ):Play()
    end)

    if arg3 then
        arg3:Play()
    end

    _G.Debris(v8, 2)
end

local t = {}
local ServerEventClient = ReplicatedStorage.Remotes:WaitForChild("ServerEventQueue"):WaitForChild(
    "ServerEventClient"
)

local function onClientEvent(arg6, ...) -- line: 97
    -- upvalues:
    --  [1] t (copy)
    --  [2] Services_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] TweenService (copy)
    --  [5] CreateCD (copy)

    if arg6 == "Gladiator" then
        if ... then
            if t[arg6] then
                t[arg6]:Destroy()
                t[arg6] = nil
            end

            local v13 = Services_m.Maid.new()
            t[arg6] = v13
            local GladiatorData = ReplicatedStorage:WaitForChild("GladiatorData")
            local v14 = script.Gladiator:Clone()
            local Info_1 = v14.Info
            v13:GiveTask(v14)
            TweenService:Create(
                Info_1.Sudden,
                TweenInfo.new(
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    math.huge,
                    true,
                    0.05
                ),
                { TextTransparency = 1, TextStrokeTransparency = 0.9 }
            ):Play()

            local function updateData() -- line: 120
                -- upvalues:
                --  [1] GladiatorData (copy)
                --  [2] Info_1 (copy)

                local Value_1 = GladiatorData.TimeRemaining.Value
                local v15 = math.floor(Value_1 / 60)
                local v16 = math.floor(Value_1 % 60)
                local v17 = string.format("%01d:%02d", v15, v16)
                v16 = if GladiatorData.Versus.Value == "" then "WAITING ON MATCHUP" else GladiatorData.Versus.Value
                Info_1.Sudden.Visible = GladiatorData.Sudden.Value
                Info_1.Timer.Text = v17
                Info_1.Versus.Text = v16
                Info_1.Versus.Shade.Text = Info_1.Versus.Text
            end

            for _, child_1 in GladiatorData:GetChildren() do
                if child_1:IsA("ValueBase") then
                    v13:GiveTask(child_1:GetPropertyChangedSignal("Value"):Connect(updateData))
                end
            end

            updateData()
            v14.Parent = script.Parent

            return
        end

        if t[arg6] then
            t[arg6]:Destroy()
            t[arg6] = nil

            return
        end
    else
        if arg6 == "AnnounceWinner" then
            local v18 = ... .. " HAS WON THE GLADIATOR'S CALL!"
            local v19 = script.Winner:Clone()
            local Info_2 = v19.Info
            local UIGradient = Info_2.Versus.UIGradient
            Info_2.Versus.Text = v18
            Info_2.Versus.Shade.Text = Info_2.Versus.Text
            v19.Parent = script.Parent
            local t_1 = { Offset = Vector2.new(1, 0) }
            local v20 = TweenService:Create(
                UIGradient,
                TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out),
                t_1
            )
            local vec2 = Vector2.new(-1, 0)
            UIGradient.Offset = vec2

            local function animate() -- line: 173
                -- upvalues:
                --  [1] v20 (copy)
                --  [2] UIGradient (copy)
                --  [3] vec2 (copy)
                --  [4] animate (copy)

                v20:Play()
                v20.Completed:Once(function() -- line: 175
                    -- upvalues:
                    --  [1] UIGradient (ref)
                    --  [2] vec2 (ref)
                    --  [3] animate (ref)

                    UIGradient.Offset = vec2
                    task.wait(1.25)
                    animate()
                end)
            end

            v20:Play()
            v20.Completed:Once(function() -- line: 175
                -- upvalues:
                --  [1] UIGradient (copy)
                --  [2] vec2 (copy)
                --  [3] animate (copy)

                UIGradient.Offset = vec2
                task.wait(1.25)
                animate()
            end)
            task.wait(6)

            for _, val in Info_2:QueryDescendants("TextLabel") do
                _G.Tween(
                    val,
                    { 0.5, "Quad", Enum.EasingDirection.Out },
                    { TextTransparency = 1, TextStrokeTransparency = 1 }
                )
            end

            _G.Debris(v19, 2)

            return
        end

        if arg6 == "Text" then
            CreateCD(...)
        end
    end
end

ServerEventClient.OnClientEvent:Connect(onClientEvent)
