-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.RiddleUI.RiddleClient
-- Class: LocalScript
-- bytes: 1632

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Value = script.Parent.Object.Value
local Data = Value:WaitForChild("Data")
local ChatBox = script.Parent.ChatBox
ChatBox.Chat.Text = Data.Question.Value
local t = { "A", "B", "C", "D", "E" }

for _, child in ipairs(Data.Answers:GetChildren()) do
    if child:IsA("StringValue") then
        local num = tonumber(child.Name)
        local v6 = script.Template:Clone()
        v6.Name = num
        v6.Choice.Text = t[num]
        v6.Button.Text = child.Value
        v6.Button.MouseButton1Up:Once(function() -- line: 29
            -- upvalues:
            --  [1] ReplicatedStorage (copy)
            --  [2] Value (copy)
            --  [3] num (copy)

            ReplicatedStorage.Remotes.Riddle:FireServer(Value, num)
            script.Parent:Destroy()
        end)
        v6.Button.MouseEnter:Connect(function() -- line: 34
            -- upvalues:
            --  [1] v6 (copy)

            v6.Button.TextColor3 = Color3.fromRGB(151, 187, 255)
            v6.Choice.TextColor3 = v6.Button.TextColor3
        end)
        v6.Button.MouseLeave:Connect(function() -- line: 39
            -- upvalues:
            --  [1] v6 (copy)

            v6.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            v6.Choice.TextColor3 = v6.Button.TextColor3
        end)
        v6.Parent = ChatBox.Options
    end
end

ChatBox.Visible = true
