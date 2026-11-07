-- Decompiled with Veyra harvester
-- Instance: StarterGui.Location.Window.Discovery.DiscoveryClient
-- Class: LocalScript
-- bytes: 4891

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local Formatter_m = require(ReplicatedStorage.Modules.Formatter)
local _, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Client = ReplicatedStorage.Remotes:WaitForChild("DiscoverMap"):WaitForChild("Client")
local Parent = script.Parent
local v4 = false
local t = {}
local t_1 = { 0.5, "Quad", Enum.EasingDirection.Out }

local function fadeInObject(u1: userdata, b1: boolean?) -- line: 25
    -- upvalues:
    --  [1] t_1 (copy)

    for _, val in u1:QueryDescendants(":not([$Ignore])") do
        local t_2 = nil

        if val:IsA("TextLabel") then
            t_2 = { TextTransparency = 0, TextStrokeTransparency = 0.7 }
        elseif val:IsA("ImageLabel") then
            t_2 = { ImageTransparency = 0.35 }
        elseif val:IsA("Frame") then
            t_2 = { BackgroundTransparency = 0.5 }
        elseif val:IsA("UIStroke") then
            t_2 = { Transparency = 0 }
        end

        if t_2 then
            if b1 then
                for key_1, val_1 in t_2 do
                    val[key_1] = val_1
                end
            else
                _G.Tween(val, t_1, t_2)
            end
        end
    end
end

local function fadeOutObject(arg1: any, b2: boolean?) -- line: 52
    -- upvalues:
    --  [1] t_1 (copy)

    for _, descendant in arg1:GetDescendants() do
        local t_3 = nil

        if descendant:IsA("TextLabel") then
            t_3 = { TextTransparency = 1, TextStrokeTransparency = 1 }
        elseif descendant:IsA("ImageLabel") then
            t_3 = { ImageTransparency = 1 }
        elseif descendant:IsA("Frame") then
            t_3 = { BackgroundTransparency = 1 }
        elseif descendant:IsA("UIStroke") then
            t_3 = { Transparency = 1 }
        end

        if t_3 then
            if b2 then
                for key_3, val_2 in t_3 do
                    descendant[key_3] = val_2
                end
            else
                _G.Tween(descendant, t_1, t_3)
            end
        end
    end
end

local Display = Parent.Display
Client.OnClientEvent:Connect(function(arg2, arg3) -- line: 78
    -- upvalues:
    --  [1] t (copy)

    table.insert(t, { name = arg2, percentage = arg3 })
end)
RunService.Heartbeat:Connect(function() -- line: 82
    -- upvalues:
    --  [1] t (copy)
    --  [2] v4 (ref)
    --  [3] fadeOutObject (copy)
    --  [4] Parent (copy)
    --  [5] Display (copy)
    --  [6] TweenService (copy)
    --  [7] Formatter_m (copy)
    --  [8] fadeInObject (copy)

    if next(t) and not v4 then
        v4 = true
        script.Alert:Play()
        local v7 = t[1]
        local v8 = v7.percentage * 100
        local Name = v7.name
        fadeOutObject(Parent, true)

        if not Parent.Visible then
            Parent.Visible = true
        end

        local UIGradient = Display.Header.UIGradient
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
        local v10 = TweenService:Create(UIGradient, tweenInfo, { Offset = Vector2.new(1, 0) })
        local vec2 = Vector2.new(-1, 0)
        UIGradient.Offset = vec2

        local function animate() -- line: 111
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] UIGradient (copy)
            --  [3] vec2 (copy)
            --  [4] animate (copy)

            if not v10 then
                return
            end

            v10:Play()
            v10.Completed:Once(function() -- line: 117
                -- upvalues:
                --  [1] UIGradient (ref)
                --  [2] vec2 (ref)
                --  [3] animate (ref)

                UIGradient.Offset = vec2
                task.wait(1)
                animate()
            end)
        end

        if v10 then
            v10:Play()
            v10.Completed:Once(function() -- line: 117
                -- upvalues:
                --  [1] UIGradient (copy)
                --  [2] vec2 (copy)
                --  [3] animate (copy)

                UIGradient.Offset = vec2
                task.wait(1)
                animate()
            end)
        end

        Display.Header.Text = `Discovered - {Name}`
        local Percent = Display.Percent
        local v11 = Formatter_m.formatNumber(v8)
        Percent.Text = `{v11}% of significant locations discovered...`
        fadeInObject(Parent)
        task.wait(5)

        if v10 then
            v10:Destroy()
            v10 = nil
        end

        table.remove(t, 1)
        fadeOutObject(Parent)
        task.wait(1)
        v4 = false
    end
end)
