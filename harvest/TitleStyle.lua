-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Titles.TitleStyle
-- Class: ModuleScript
-- bytes: 4402

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Parent = script.Parent
local v1 = require(Parent)
local t = { ANIMATED_TAG = "AnimatedTitleGradient" }
local TitleGradients = Parent:WaitForChild("TitleGradients", 10)

if not TitleGradients then
    warn("[TitleStyle] Modules.Titles.TitleGradients is missing - title gradients are disabled")
end

if RunService:IsClient() then
    require(script.Animator)
end

local function toFontFace(arg1) -- line: 50
    local v2 = typeof(arg1)

    if v2 == "Font" then
        return arg1
    end

    if v2 == "EnumItem" and arg1.EnumType == Enum.Font then
        return Font.fromEnum(arg1)
    end

    if v2 == "string" then
        if arg1:find("^rbxasset") then
            return Font.new(arg1)
        end

        return Font.fromName(arg1)
    else
        return nil
    end
end

local t_1 = setmetatable({}, { __mode = "k" })

local function getOriginal(u1: userdata) -- line: 65
    -- upvalues:
    --  [1] t_1 (copy)

    local v3 = t_1[u1]

    if not v3 then
        v3 = {
            FontFace = u1.FontFace,
            TextColor3 = u1.TextColor3,
            Size = u1.Size,
            AutomaticSize = u1.AutomaticSize,
            TextWrapped = u1.TextWrapped,
            DisabledGradients = {}
        }
        t_1[u1] = v3
    end

    return v3
end

local function reset(u2: userdata, arg2: any) -- line: 81
    local TitleStyleGradient = u2:FindFirstChild("TitleStyleGradient")

    if TitleStyleGradient then
        TitleStyleGradient:Destroy()
    end

    for key in arg2.DisabledGradients do
        if key.Parent == u2 then
            key.Enabled = true
        end
    end

    table.clear(arg2.DisabledGradients)
    u2.FontFace = arg2.FontFace
    u2.TextColor3 = arg2.TextColor3
    u2.Size = arg2.Size
    u2.AutomaticSize = arg2.AutomaticSize
    u2.TextWrapped = arg2.TextWrapped
end

function t.GetGradient(s1: string?) -- line: 101
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] TitleGradients (copy)

    local v4 = s1

    if v4 then
        v4 = v1[s1]
    end

    if not v4 or not v4.Gradient then
        return nil
    end

    local v5 = TitleGradients

    if v5 then
        v5 = TitleGradients:FindFirstChild(v4.Gradient)
    end

    if v5 then
        if not v5:IsA("UIGradient") then
            warn(
                `[TitleStyle] title '{s1}' wants gradient '{v4.Gradient}' but Modules.Titles.TitleGradients has no UIGradient by that name`
            )

            return nil
        end

        return v5
    else
        warn(
            `[TitleStyle] title '{s1}' wants gradient '{v4.Gradient}' but Modules.Titles.TitleGradients has no UIGradient by that name`
        )

        return nil
    end
end

function t.GetFont(s2: string?) -- line: 115
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] toFontFace (copy)

    local v6 = s2

    if v6 then
        v6 = v1[s2]
    end

    return v6 and (v6.Font and toFontFace(v6.Font)) or nil
end

function t.Apply(u3: userdata, s3: string?, t1: table?) -- line: 124
    -- upvalues:
    --  [1] getOriginal (copy)
    --  [2] reset (copy)
    --  [3] v1 (copy)
    --  [4] t (copy)
    --  [5] CollectionService (copy)

    local v8 = getOriginal(u3)
    reset(u3, v8)
    local v9 = s3 and (if s3 == "" then false else v1[s3])

    if not v9 then
        return
    end

    local v10 = t.GetFont(s3)

    if v10 then
        u3.FontFace = v10
    end

    if v9.Color and (not t1 or not t1.KeepColor) then
        u3.TextColor3 = v9.Color
    end

    local v11 = t.GetGradient(s3)

    if not v11 then
        return
    end

    for _, child in u3:GetChildren() do
        if child:IsA("UIGradient") and child.Enabled then
            child.Enabled = false
            v8.DisabledGradients[child] = true
        end
    end

    u3.TextColor3 = Color3.new(1, 1, 1)
    u3.TextWrapped = false
    u3.Size = UDim2.new(0, 0, v8.Size.Y.Scale, v8.Size.Y.Offset)
    u3.AutomaticSize = if v8.AutomaticSize == Enum.AutomaticSize.Y then Enum.AutomaticSize.XY else if v8.AutomaticSize ~= Enum.AutomaticSize.XY then Enum.AutomaticSize.X else Enum.AutomaticSize.XY
    v9 = v11:Clone()
    v9.Name = "TitleStyleGradient"
    v9.Enabled = true

    if v9:GetAttribute("Animation") then
        CollectionService:AddTag(v9, t.ANIMATED_TAG)
    end

    v9.Parent = u3
end

return t
