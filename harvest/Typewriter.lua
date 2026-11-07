-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.Typewriter
-- Class: ModuleScript
-- bytes: 8002

local _ = require(game:GetService("ReplicatedFirst").Services)
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local t = { ColorShortcuts = {} }
local t_1 = {
    TextYAlignment = "Top",
    TextSize = 18,
    Font = Enum.Font.BuilderSans.Name,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
    TextTransparency = 0,
    TextStrokeTransparency = 0.8,
    PaddingY = 8
}
t.ColorShortcuts.White = Color3.new(1, 1, 1)
t.ColorShortcuts.Black = Color3.new(0, 0, 0)
t.ColorShortcuts.Red = Color3.new(1, 0.4, 0.4)
t.ColorShortcuts.Green = Color3.new(0.4, 1, 0.4)
t.ColorShortcuts.Blue = Color3.new(0.4, 0.4, 1)
t.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1)
t.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2)
t.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2)
t.ColorShortcuts.Purple = Color3.new(0.560784, 0.117647, 0.576471)
local t_2 = {}
t_2[Enum.Font.BuilderSansBold] = { bold = true, b = true }
t.fontsToApply = t_2

function t.Clean(_: table, u1: userdata) -- line: 36
    for _, child in u1:GetChildren() do
        if child:IsA("GuiBase") then
            child:Destroy()
        end
    end
end

function t.Write(
    t2: table,
    u2: userdata,
    s1: string,
    b1: boolean,
    u3: userdata
) -- line: 44
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t (copy)
    --  [3] TextService (copy)
    --  [4] TweenService (copy)

    t2:Clean(u2)
    local v2 = u3 or {}

    for key_1, val in t_1 do
        if not v2[key_1] then
            v2[key_1] = val
        end
    end

    local t_4 = {}
    local v3 = {}
    local v4 = string.len(s1)
    local v5 = 1
    local v6, v7

    while v4 >= v5 do
        v6 = nil
        v7 = v2.Font
        local v8 = string.sub(s1, v5)
        local v9 = string.sub(s1, v5, v5)
        local t_5 = { message = v9 }

        if v9 == "[" then
            local v10 = v8:match("%[(%S-)%]")

            if v10 then
                v6 = true
                v5 += string.len(v10) + 1

                if v10 == "br" then
                    local t_6 = {
                        message = "\n",
                        properties = {},
                        Font = v2.Font,
                        size = Vector2.new(0, v2.TextSize)
                    }
                    table.insert(t_4, t_6)
                elseif v10:sub(1, 1) == "/" then
                    v3[v10:match("^/(%w+)")] = nil
                else
                    local v13, v14 = v10:match("^(%w+)=?(.*)")
                    local v15 = v14

                    if v14 == "" or not v15 then
                        v15 = true
                    end

                    v3[v13] = v15
                end
            end
        end

        if not v6 then
            local t_7 = {}

            for key_2, val_1 in v3 do
                if key_2 == "Color" then
                    t_7.Color = val_1
                else
                    t_7[key_2] = true
                end
            end

            for key_3, val_2 in t.fontsToApply do
                for key_4, _ in val_2 do
                    if v3[key_4] then
                        v7 = key_3
                        break
                    end
                end
            end

            if not v3.italic and v3.i then
            end

            t_5.message = v9
            t_5.properties = t_7
            t_5.Font = v7
            t_5.size = TextService:GetTextSize(v9, v2.TextSize, v7, Vector2.new(100, 100))
            table.insert(t_4, t_5)
        end

        v5 += 1
    end

    v5 = u2.AbsoluteSize.X
    v6 = 0
    v7 = 0
    v4 = 0
    v3 = ""

    local function createLabel(
        arg1,
        arg2,
        arg3,
        arg4,
        arg5,
        arg6
    ) -- line: 126
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] v6 (ref)
        --  [3] v7 (ref)
        --  [4] u2 (copy)
        --  [5] TweenService (ref)

        local v18 = arg2.properties.italic or arg2.properties.i

        if not arg2.properties.bold then
            local _ = arg2.properties.b
        end

        local TextLabel = Instance.new("TextLabel")
        TextLabel.RichText = true
        TextLabel.Text = arg1
        TextLabel.Font = arg2.Font
        TextLabel.TextSize = v2.TextSize
        TextLabel.TextColor3 = arg3
        TextLabel.TextStrokeColor3 = v2.TextStrokeColor3
        TextLabel.TextStrokeTransparency = v2.TextStrokeTransparency
        TextLabel.TextTransparency = 0.5
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextYAlignment = Enum.TextYAlignment[v2.TextYAlignment]
        TextLabel.Size = UDim2.new(0, arg4.X, 0, arg4.Y + v2.PaddingY)
        TextLabel.Position = UDim2.new(0, v6, 0, v7)
        TextLabel.ZIndex = 5
        TextLabel.BackgroundTransparency = 1
        TextLabel.Visible = false
        TextLabel.Parent = u2

        if v18 then
            TextLabel.Text = "<i>" .. TextLabel.Text .. "</i>"
        end

        task.delay(arg5, function() -- line: 154
            -- upvalues:
            --  [1] TextLabel (copy)
            --  [2] v2 (ref)
            --  [3] TweenService (ref)
            --  [4] arg6 (copy)

            if not TextLabel.Parent then
                return
            end

            TextLabel.Visible = true
            TextLabel.TextSize = v2.TextSize + 6
            TweenService:Create(
                TextLabel,
                TweenInfo.new(0.15),
                { TextSize = v2.TextSize, TextTransparency = 0 }
            ):Play()

            if arg6 == 1 or arg6 % 7 == 0 then
                local v21 = script.sounds:GetChildren()[math.random(1, #script.sounds:GetChildren())]:Clone()
                v21.PlayOnRemove = true
                v21.Parent = script
                v21:Destroy()
            end
        end)
    end

    local function getColorFromString(arg7) -- line: 174
        -- upvalues:
        --  [1] t (ref)

        if t.ColorShortcuts[arg7] then
            return t.ColorShortcuts[arg7]
        end

        if arg7:sub(1, 1) == "#" then
            return Color3.fromHex(arg7)
        end

        local v22, v23, v24 = arg7:match("(%d+),(%d+),(%d+)")

        return Color3.fromRGB(v22, v23, v24)
    end

    for key_5, val_4 in ipairs(t_4) do
        local Message = val_4.message
        local Properties = val_4.properties
        local Size = val_4.size
        local v25 = v4
        local v26 = 0

        if Message == "\n" then
            v6 = 0
            v7 += val_4.size.Y + v2.PaddingY
            v3 = Message
        else
            if not string.match(Message, "%s") and string.match(v3, "%s") then
                for index = key_5, #t_4 do
                    local _ = t_4[index].message

                    if string.match(t_4[index].message, "%s") then
                        break
                    end

                    v26 += t_4[index].size.X
                end
            end

            if v5 - 16 < v6 + v26 then
                v4 += 0.1
                v25 = v4
                v6 = 0
                v7 += Size.Y
            end

            v26 = v2.TextColor3
            v26 = if not Properties.Color then v26 else getColorFromString(Properties.Color)

            if not string.match(Message, "%s") then
                createLabel(
                    Message,
                    val_4,
                    v26,
                    Size,
                    v25,
                    key_5
                )
            end

            v6 += Size.X
            v26 = {
                ["?"] = 0.1,
                ["!"] = 0.1,
                [","] = 0.2,
                ["."] = 0.2,
                default = 0.02,
                match = 0.01
            }
            v25 = if not string.match(Message, "%s") then v26[Message] or 0.02 else 0.01
            v4 += v25
            v3 = Message
        end
    end

    if b1 then
        task.wait(v4)
    end
end

return t
