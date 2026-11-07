-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Racing.RacingClient
-- Class: LocalScript
-- bytes: 9044

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local v2, v3 = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Main = script.Parent.Main
local Results = script.Parent.Results
local PlayerGui = v2:WaitForChild("PlayerGui")
v2 = PlayerGui:FindFirstChild("Indicators") or Instance.new("ScreenGui")
v2.Name = "Indicators"
v2.Parent = PlayerGui
local v4 = _G
local v5 = _G.CREATED_PARTS or {}
v4.CREATED_PARTS = v5

for key, _ in pairs(_G.CREATED_PARTS) do
    key:Destroy()
    _G.CREATED_PARTS[key] = nil
end

local function CreateCD(arg1, arg2, arg3, arg4) -- line: 27
    -- upvalues:
    --  [1] Main (copy)
    --  [2] TweenService (copy)
    --  [3] Services_m (copy)

    local v6 = script.Label:Clone()
    v6.Text = arg1
    v6.TextColor3 = arg2 or v6.TextColor3
    v6.Parent = Main
    local v8 = arg4 or 0.5
    v6:TweenSize(
        UDim2.new(0.2, 0, 0.05, 0),
        "Out",
        "Quad",
        v8,
        true
    )
    task.delay(v8 * 0.8, function() -- line: 35
        -- upvalues:
        --  [1] TweenService (ref)
        --  [2] v6 (copy)
        --  [3] v8 (copy)

        TweenService:Create(
            v6,
            TweenInfo.new(v8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { TextTransparency = 1, TextStrokeTransparency = 1 }
        ):Play()
    end)

    if arg3 then
        arg3:Play()
    end

    Services_m.Debris(v6, 2)
end

local _ = function(arg5) --[[ placementText ]] -- line: 46
    if arg5 == nil then
        return "Couldn't load your placement right now."
    end

    return arg5 < 1000 and "This time is good enough to place you #" .. arg5 or "This time is good enough to place you < #1,000"
end

local v12 = 0
local v13 = Services_m.Maid.new()
ReplicatedStorage.Remotes.RacingRemote.Client.OnClientEvent:Connect(function(arg6, ...) -- line: 57
    -- upvalues:
    --  [1] Main (copy)
    --  [2] v2 (copy)
    --  [3] v12 (ref)
    --  [4] Results (copy)
    --  [5] v13 (copy)
    --  [6] RunService (copy)
    --  [7] ReplicatedStorage (copy)
    --  [8] CreateCD (copy)

    local v24

    local _ = function() --[[ finish ]] -- line: 59
        -- upvalues:
        --  [1] Main (ref)

        Main.Header.Text = ""
        Main.Time.Text = ""
        Main.Start.Visible = false
        Main.Visible = false
    end

    if arg6 == "Create" then
        local v14, v15 = ...

        for _, val_1 in pairs(v14) do
            if typeof(val_1) == "table" then
                for key_2, val_2 in pairs(val_1) do
                    if key_2 == "Gate" then
                        local v16 = script.Gate:Clone()
                        v16:SetPrimaryPartCFrame(val_2)
                        v16.Parent = workspace.Effects.Debris
                        local v17 = script.BillboardGui:Clone()
                        v17.Parent = v2
                        v17.Adornee = v16.PrimaryPart
                        v17.Adornee.Destroying:Connect(function() -- line: 80
                            -- upvalues:
                            --  [1] v17 (copy)

                            v17:Destroy()
                        end)
                        v17.Enabled = true
                        _G.CREATED_PARTS[v16] = v15
                    elseif key_2 == "FinishGate" then
                        local v18 = script.Gate:Clone()
                        v18:SetPrimaryPartCFrame(val_2)
                        v18.Parent = workspace.Effects.Debris
                        local v19 = script.FinishGui:Clone()
                        v19.Parent = v2
                        v19.Adornee = v18.PrimaryPart
                        v19.Adornee.Destroying:Connect(function() -- line: 94
                            -- upvalues:
                            --  [1] v19 (copy)

                            v19:Destroy()
                        end)
                        v19.Enabled = true
                        _G.CREATED_PARTS[v18] = v15
                    elseif key_2 == "Orb" then
                        local v20 = script.SpeedOrb:Clone()
                        v20.CFrame = val_2
                        v20.Parent = workspace.Effects.Debris
                        _G.CREATED_PARTS[v20] = v15
                    elseif key_2 == "START" then
                        local v21 = script.Start:Clone()
                        v21.CFrame = val_2
                        v21.Parent = workspace.Effects.Debris
                        local v22 = script.MarkerPoint:Clone()
                        v22.Parent = v2
                        v22.Adornee = v21
                        v22.Adornee.Destroying:Connect(function() -- line: 114
                            -- upvalues:
                            --  [1] v22 (copy)

                            v22:Destroy()
                        end)
                        v22.Enabled = true
                        _G.CREATED_PARTS[v21] = v15
                    end
                end
            end
        end

        return
    end

    if arg6 == "Destroy" then
        local _ = ...

        for key_3, val_3 in pairs(_G.CREATED_PARTS) do
            if val_3 == ... then
                key_3:Destroy()
                _G.CREATED_PARTS[key_3] = nil
            end
        end

        return
    end

    if arg6 == "Display" then
        v12 += 1
        Results.Visible = false
        Main.Visible = true
        Main.Header.Text = ...
        Main.Time.Text = "00:00.00"
        Main.Time.TextColor3 = Color3.fromRGB(255, 255, 255)
        Main.Start.Visible = true

        return
    end

    if arg6 == "Start" then
        v12 += 1
        Results.Visible = false
        Main.Visible = true
        local v24 = ...
        v13:Destroy()
        v13.Heartbeat = RunService.Heartbeat:Connect(function() -- line: 154
            -- upvalues:
            --  [1] v24 (copy)
            --  [2] Main (ref)

            local v25 = math.max(workspace:GetServerTimeNow() - v24, 0)
            local v26 = math.floor(v25 / 60)
            local v27 = math.floor(v25 % 60)
            local v28 = math.floor(v25 * 100 % 100)
            Main.Time.Text = string.format("%02d:%02d.%02d", v26, v27, v28)
        end)

        return
    end

    if arg6 == "End" then
        Main.Visible = false
        local v30
        v24, v30 = ...
        v13:Destroy()
        local v31 = math.floor(v24 / 60)
        local v32 = math.floor(v24 % 60)
        Results.Time.Text = string.format("%02d:%02d.%02d", v31, v32, (math.floor(v24 * 100 % 100)))
        local Info = Results.Info
        local v34

        if v30 ~= nil then
            v34 = if v30 == nil then "Couldn't load your placement right now." else v30 < 1000 and "This time is good enough to place you #" .. v30 or "This time is good enough to place you < #1,000"

            if not v34 then
                v34 = "Calculating your placement..."
            end
        else
            v34 = "Calculating your placement..."
        end

        Info.Text = v34
        Results.Visible = true
        _G.PlaySound(ReplicatedStorage.SFX.Misc.RaceCompletion, script)

        return
    end

    if arg6 == "Placement" then
        local v35 = ...
        local Info_1 = Results.Info
        Info_1.Text = if v35 == nil then "Couldn't load your placement right now." else v35 < 1000 and "This time is good enough to place you #" .. v35 or "This time is good enough to place you < #1,000"

        return
    end

    if arg6 == "Failed" then
        Results.Visible = false
        v13:Destroy()
        CreateCD("Race Failed", Color3.fromRGB(255, 0, 0), nil, 1)
        Main.Time.TextColor3 = Color3.fromRGB(255, 58, 58)
        local v37 = v12
        task.wait(0.25)

        if v12 == v37 then
            Main.Header.Text = ""
            Main.Time.Text = ""
            Main.Start.Visible = false
            Main.Visible = false

            return
        end
    else
        if arg6 == "Countdown" then
            CreateCD(...)

            return
        end

        if arg6 == "EndCountdown" then
            Main.Start.Visible = false
        end
    end
end)
Results.Hide.Activated:Connect(function() -- line: 208
    -- upvalues:
    --  [1] Results (copy)

    Results.Visible = false
end)
Main.Abandon.Activated:Connect(function() -- line: 212
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.RacingRemote:FireServer("Quit")
end)

local function syncAttribute() -- line: 216
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] Main (copy)

    if v3:GetAttribute("InRace") then
        Main.Abandon.Visible = false

        return
    end

    Main.Abandon.Visible = true
end

v3:GetAttributeChangedSignal("InRace"):Connect(syncAttribute)

if v3:GetAttribute("InRace") then
    Main.Abandon.Visible = false
else
    Main.Abandon.Visible = true
end
