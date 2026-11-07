-- Decompiled with Veyra harvester
-- Instance: StarterGui.KeypadUI.KeypadClient
-- Class: LocalScript
-- bytes: 3555

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.Basic)
local _, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local Main = script.Parent.Main
local Code = Main.Code
local KeyCode = ReplicatedStorage.Remotes.KeyCode
local v4 = 1
local t = { Code.Keys[1], Code.Keys[2], Code.Keys[3], Code.Keys[4], Code.Keys[5], Code.Keys[6] }
local v5 = nil

function Update(arg1) -- line: 28
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] t (copy)
    --  [3] v4 (ref)
    --  [4] KeyCode (copy)
    --  [5] Code (copy)

    if v5 then
        return
    end

    v5 = true
    t[v4].Text = arg1
    v4 += 1

    if v4 > 6 then
        v4 = 1
        local v6 = ""

        for _, val in pairs(t) do
            local Text = val.Text
            local v7 = tonumber(Text) and tonumber(Text) or "0"
            v6 ..= v7
        end

        if KeyCode:InvokeServer(v6) then
            Code.Keys.Visible = false
            Code.Error.Visible = false
            Code.Valid.Visible = true
            v5 = false

            return true
        end

        Code.Keys.Visible = false
        Code.Error.Visible = true
        task.wait(2)

        for _, val_1 in pairs(t) do
            val_1.Text = "_"
        end

        Code.Error.Visible = false
        Code.Keys.Visible = true
    end

    v5 = false
end

local v8 = script.Object.Value or workspace:WaitForChild("Map"):WaitForChild("Areas"):WaitForChild(
    "Assembly_Tower"
)
local Keypad = v8:WaitForChild("Objects"):WaitForChild("Keypad")

function v8() --[[ syncAttribute ]] -- line: 80
    -- upvalues:
    --  [1] Code (copy)
    --  [2] Keypad (copy)
    --  [3] v4 (ref)
    --  [4] t (copy)

    Code.Valid.Visible = false
    Code.Keys.Visible = false
    Code.Error.Visible = true

    if not Keypad:GetAttribute("Solved") then
        v4 = 1

        for _, val_2 in pairs(t) do
            val_2.Text = "_"
        end

        Code.Error.Visible = false
        Code.Keys.Visible = true

        return
    end
end

Keypad:GetAttributeChangedSignal("Solved"):Connect(v8)
v8()

function KeyCode.OnClientInvoke(arg2, arg3) -- line: 103
    -- upvalues:
    --  [1] Main (copy)
    --  [2] Services_m (copy)
    --  [3] RunService (copy)
    --  [4] v3 (copy)

    if Main.Visible then
        return
    end

    _G.PROMPTS[arg3] = true
    arg3.Enabled = false
    Main.Visible = true
    local v14 = Services_m.Maid.new()
    local v15 = nil

    for _, val_3 in ipairs(Main.Keys:GetChildren()) do
        if val_3:IsA("TextButton") then
            v14:GiveTask(val_3.MouseButton1Up:Connect(function() -- line: 117
                -- upvalues:
                --  [1] v15 (ref)
                --  [2] val_3 (copy)

                v15 = Update(val_3.Name)
            end))
        end
    end

    v14:GiveTask(RunService.Heartbeat:Connect(function() -- line: 123
        -- upvalues:
        --  [1] v3 (ref)
        --  [2] arg2 (copy)
        --  [3] v15 (ref)
        --  [4] v14 (copy)
        --  [5] Main (ref)
        --  [6] arg3 (copy)

        if if not v3 then v15 else if not v3.PrimaryPart then v15 else (v3.PrimaryPart.Position - arg2.PrimaryPart.Position).Magnitude > 8 or v15 then
            v14:Destroy()
            task.wait(0.5)
            Main.Visible = false
            arg3.Enabled = true
        end
    end))
end
