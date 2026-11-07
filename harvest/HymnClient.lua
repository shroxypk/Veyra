-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.HymnUI.HymnClient
-- Class: LocalScript
-- bytes: 6163

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local v2, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local _ = v2:WaitForChild("Inventory")
local mouse = v2:GetMouse()
local Objects = v2:WaitForChild("PlayerGui"):WaitForChild(".objects")
local ChurchRemote = ReplicatedStorage.Remotes:WaitForChild("ChurchRemote")
local Code = script.Parent.ChatBox.Code

local function InBounds(arg1) -- line: 25
    -- upvalues:
    --  [1] Code (copy)

    local t = {}

    for _, child in pairs(Code:GetChildren()) do
        if child:IsA("Frame") then
            t[child] = (child.AbsolutePosition - arg1.AbsolutePosition).Magnitude
        end
    end

    local v5 = math.huge
    local v6 = nil

    for key_1, val in pairs(t) do
        if v5 > val then
            v6 = key_1
            v5 = val
        end
    end

    return v6
end

local function checkCode() -- line: 44
    -- upvalues:
    --  [1] Code (copy)
    --  [2] ChurchRemote (copy)

    local t_1 = {}

    for index = 1, 6 do
        table.insert(t_1, Code[index]:FindFirstChildWhichIsA("ImageButton").Name)
    end

    ChurchRemote:FireServer("Check", t_1)
end

for _, val_1 in Code:QueryDescendants("ImageButton") do
    local v7 = nil
    local v8 = nil
    local Position_1 = nil
    local AbsolutePosition = nil
    val_1.InputBegan:Connect(function(input) -- line: 58
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] Position_1 (ref)
        --  [3] AbsolutePosition (ref)
        --  [4] val_1 (copy)
        --  [5] Objects (copy)
        --  [6] InBounds (copy)
        --  [7] checkCode (copy)

        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            v7 = true
            Position_1 = input.Position
            AbsolutePosition = val_1.AbsolutePosition
            local _ = nil
            local Parent = val_1.Parent
            val_1.AnchorPoint = Vector2.new(0, 0)
            val_1.Position = UDim2.new(0, AbsolutePosition.X, 0, AbsolutePosition.Y)
            val_1.Parent = Objects
            local v18 = nil
            local v19 = nil
            v18 = input.Changed:Connect(function() -- line: 74
                -- upvalues:
                --  [1] input (copy)
                --  [2] v18 (ref)
                --  [3] v7 (ref)
                --  [4] _ (ref)
                --  [5] val_1 (ref)
                --  [6] InBounds (ref)
                --  [7] Parent (copy)
                --  [8] v19 (ref)
                --  [9] checkCode (ref)

                if input.UserInputState == Enum.UserInputState.End then
                    v18:Disconnect()
                    v18 = nil
                    v7 = false
                    _ = val_1.AbsolutePosition
                    local v20 = InBounds(val_1)

                    if v20 then
                        if (val_1.AbsolutePosition - v20.AbsolutePosition).Magnitude < 20 then
                            if if Parent ~= v20 then false else true then
                                val_1.Parent = Parent
                            else
                                local ImageButton = v20:FindFirstChildWhichIsA("ImageButton")

                                if ImageButton then
                                    ImageButton.Parent = Parent
                                end

                                val_1.Parent = v20
                            end
                        else
                            val_1.Parent = Parent
                        end
                    else
                        val_1.Parent = Parent
                    end

                    if v19 == nil then
                        v19 = false
                    end

                    checkCode()
                end
            end)
        end
    end)
    local v22 = Services_m.TweenService:Create(
        val_1,
        TweenInfo.new(
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            math.huge,
            true
        ),
        { Rotation = 10 }
    )
    val_1.MouseEnter:Connect(function() -- line: 120
        -- upvalues:
        --  [1] v22 (copy)

        v22:Play()
    end)
    val_1.MouseLeave:Connect(function() -- line: 123
        -- upvalues:
        --  [1] v22 (copy)
        --  [2] val_1 (copy)

        v22:Cancel()
        val_1.Rotation = 0
    end)
    val_1.InputChanged:Connect(function(input_1) -- line: 128
        -- upvalues:
        --  [1] v8 (ref)

        if input_1.UserInputType == Enum.UserInputType.MouseMovement or input_1.UserInputType == Enum.UserInputType.Touch then
            v8 = input_1
        end
    end)
    UserInputService.InputChanged:Connect(function(input_2) -- line: 134
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] val_1 (copy)
        --  [3] mouse (copy)
        --  [4] v8 (ref)
        --  [5] Position_1 (ref)
        --  [6] AbsolutePosition (ref)

        if v7 then
            if input_2.KeyCode == Enum.KeyCode.Thumbstick1 then
                val_1.Position = UDim2.new(0, mouse.X, 0, mouse.Y)

                return
            end

            if input_2 == v8 then
                local v24 = input_2.Position - Position_1
                val_1.Position = UDim2.new(
                    0,
                    AbsolutePosition.X + v24.X,
                    0,
                    AbsolutePosition.Y + v24.Y
                )
            end
        end
    end)
    val_1:GetPropertyChangedSignal("Parent"):Connect(function() -- line: 147
        -- upvalues:
        --  [1] val_1 (copy)
        --  [2] Code (copy)

        if val_1:IsDescendantOf(Code) then
            val_1.AnchorPoint = Vector2.new(0.5, 0.5)
            val_1.Position = UDim2.new(0.5, 0, 0.5, 0)

            return
        end

        val_1.AnchorPoint = Vector2.new(0, 0)
    end)
end
