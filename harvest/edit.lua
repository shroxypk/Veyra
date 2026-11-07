-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.edit
-- Class: ModuleScript
-- bytes: 2428

local Players = game:GetService("Players")
local t = {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(17, 17, 17),
    BackgroundTransparency = 0.05,
    BorderColor3 = Color3.fromRGB(17, 17, 17),
    BorderSizePixel = 20,
    ClearTextOnFocus = false,
    MultiLine = true,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0.5, 0, 0.4, 0),
    Font = Enum.Font.Code,
    TextColor3 = Color3.fromRGB(241, 241, 241),
    TextWrapped = true,
    TextSize = 18,
    TextXAlignment = "Left",
    TextYAlignment = "Top",
    AutoLocalize = false,
    PlaceholderText = "Right click to exit"
}
local v1 = nil
local t_1 = {
    Name = "edit",
    Aliases = {},
    Description = "Edit text in a TextBox",
    Group = "DefaultUtil",
    Args = {
        {
            Type = "string",
            Name = "Input text",
            Description = "The text you wish to edit",
            Default = ""
        },
        {
            Type = "string",
            Name = "Delimiter",
            Description = "The character that separates each line",
            Default = ","
        }
    },
    ClientRun = nil
}

function t_1.ClientRun(arg1, arg2, arg3) -- line: 45
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] t (copy)
    --  [3] Players (copy)

    local v2 = v1 or arg1.Cmdr.Util.Mutex()
    v1 = v2
    v2 = v1()
    arg1:Reply("Right-click on the text area to exit.", Color3.fromRGB(158, 158, 158))
    local CmdrEditBox_ScreenGui = Instance.new("ScreenGui")
    CmdrEditBox_ScreenGui.Name = "CmdrEditBox"
    CmdrEditBox_ScreenGui.ResetOnSpawn = false
    local TextBox = Instance.new("TextBox")

    for key, val in pairs(t) do
        TextBox[key] = val
    end

    TextBox.Text = arg2:gsub(arg3, "\n")
    TextBox.Parent = CmdrEditBox_ScreenGui
    CmdrEditBox_ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    local thread = coroutine.running()
    TextBox.InputBegan:Connect(function(input) -- line: 69
        -- upvalues:
        --  [1] thread (copy)
        --  [2] TextBox (copy)
        --  [3] arg3 (copy)
        --  [4] CmdrEditBox_ScreenGui (copy)
        --  [5] v2 (copy)

        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            coroutine.resume(thread, TextBox.Text:gsub("\n", arg3))
            CmdrEditBox_ScreenGui:Destroy()
            v2()
        end
    end)

    return coroutine.yield()
end

return t_1
