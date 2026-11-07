-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.CeiveImOverlay
-- Class: ModuleScript
-- bytes: 6909

local GuiService = game:GetService("GuiService")
local font = Font.new("rbxasset://fonts/families/PressStart2P.json")
local t = {}
t.__index = t

function t.new(n1: number?, n2: number?, b1: boolean?) -- line: 22
    -- upvalues:
    --  [1] GuiService (copy)
    --  [2] t (copy)

    local v1 = if b1 ~= nil then b1 else true
    b1 = v1
    v1 = UDim2.fromOffset(25, 5 + GuiService:GetGuiInset().Y)
    local udim2 = UDim2.new(1, -25, 1, -5)
    local udim2_1 = UDim2.fromOffset(0, 0)
    local udim2_2 = UDim2.fromScale(1, 1)
    local t_1 = setmetatable({}, t)
    t_1.DefaultY = n1 or 5
    t_1.TextSize = n2 or 11
    t_1.BackFrame = Instance.new("Frame")
    local v2 = v1
    local BackFrame = t_1.BackFrame

    if not b1 or not v2 then
        v2 = udim2_1
    end

    BackFrame.Position = v2
    v2 = b1 and udim2 or udim2_2
    t_1.BackFrame.Size = v2
    t_1.BackFrame.Name = "BackFrame"
    t_1.BackFrame.Transparency = 1
    t_1.ListLayout = Instance.new("UIListLayout")
    t_1.ListLayout.Padding = UDim.new(0, 2)
    t_1.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    t_1.ListLayout.Parent = t_1.BackFrame
    t_1.m_Indent = 0
    t_1.DidUpdate = false
    t_1.m_State = ""
    t_1.m_PreviousState = ""
    t_1.m_RenderGroup = {}
    t_1.m_ItemPool = {}

    return t_1
end

function t.Begin(t1: table, s1: string, u1: Color3?, u2: Color3?) -- line: 64
    if s1 then
        if type(s1) ~= "string" then
            warn("Expected text to ImOverlay::Begin", debug.traceback())

            return
        end

        if u1 and typeof(u1) ~= "Color3" then
            warn("BackgroundColor should be a Color3", debug.traceback())

            return
        end

        if u2 and typeof(u2) ~= "Color3" then
            warn("TextColor should be a Color3", debug.traceback())

            return
        end

        t1:Text(s1, u1, u2)
        t1.m_Indent += 1

        return
    else
        warn("Expected text to ImOverlay::Begin", debug.traceback())

        return
    end
end

function t.End(arg1) -- line: 84
    if arg1.m_Indent - 1 < 0 then
        error("Too many callbacks to ImOverlay::End")

        return
    end

    arg1.m_Indent -= 1
end

function t.Text(t2: table, s2: string, u3: Color3?, u4: Color3?) -- line: 93
    if s2 then
        if type(s2) ~= "string" then
            warn("Expected text to ImOverlay::Text", debug.traceback())

            return
        end

        if u3 and typeof(u3) ~= "Color3" then
            warn("BackgroundColor should be a Color3", debug.traceback())

            return
        end

        if u4 and typeof(u4) ~= "Color3" then
            warn("TextColor should be a Color3", debug.traceback())

            return
        end

        local v3 = u3 or Color3.new()
        u3 = v3
        v3 = u4 or Color3.new(1, 1, 1)
        u4 = v3
        table.insert(
            t2.m_RenderGroup,
            { Text = s2, TextColor = u4, BackgroundColor = u3, Indent = t2.m_Indent }
        )
        t2.m_State = t2.m_State .. `{s2}|{u4}|{u3}|{t2.m_Indent}`

        return
    else
        warn("Expected text to ImOverlay::Text", debug.traceback())

        return
    end
end

function t.m_Pool(arg2) -- line: 122
    debug.profilebegin("ImOverlay::m_Pool")

    for _, child in arg2.BackFrame:GetChildren() do
        if not child:IsA("UIListLayout") and child.Visible then
            child.Visible = false
            table.insert(arg2.m_ItemPool, child)
        end
    end

    debug.profileend()
end

function t.m_Cleanup(arg3) -- line: 137
    debug.profilebegin("ImOverlay::m_Cleanup")
    arg3.m_State = ""
    arg3.m_Indent = 0
    arg3.m_RenderGroup = {}
    debug.profileend()
end

function t.m_CreateLabel(
    t3: table,
    s3: string,
    u5: Color3,
    u6: Color3,
    n3: number
) -- line: 145
    -- upvalues:
    --  [1] font (copy)

    debug.profilebegin("ImOverlay::m_CreateLabel")
    local Background_Frame = Instance.new("Frame")
    Background_Frame.Name = "Background"
    Background_Frame.AutomaticSize = Enum.AutomaticSize.XY
    Background_Frame.BackgroundColor3 = u6
    Background_Frame.BackgroundTransparency = 0.4
    Background_Frame.BorderSizePixel = 0
    local TaskText_TextLabel = Instance.new("TextLabel")
    TaskText_TextLabel.Name = "TaskText"
    TaskText_TextLabel.FontFace = font
    TaskText_TextLabel.Text = s3
    TaskText_TextLabel.TextColor3 = u5
    TaskText_TextLabel.TextSize = t3.TextSize
    TaskText_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TaskText_TextLabel.AutomaticSize = Enum.AutomaticSize.XY
    TaskText_TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TaskText_TextLabel.BackgroundTransparency = 1
    TaskText_TextLabel.Position = UDim2.fromOffset(n3 * 50, 0)
    TaskText_TextLabel.Size = UDim2.fromOffset(0, t3.DefaultY)
    TaskText_TextLabel.Parent = Background_Frame
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Name = "UIPadding"
    UIPadding.PaddingBottom = UDim.new(0, 2)
    UIPadding.Parent = TaskText_TextLabel
    local UIPadding_1 = Instance.new("UIPadding")
    UIPadding_1.Name = "UIPadding"
    UIPadding_1.PaddingRight = UDim.new(0, 5)
    UIPadding_1.PaddingLeft = UDim.new(0, 5)
    UIPadding_1.Parent = Background_Frame
    debug.profileend()

    return Background_Frame
end

function t.Render(arg4) -- line: 182
    debug.profilebegin("ImOverlay::Render")

    if arg4.m_State == "" then
        arg4:m_Pool()
        arg4:m_Cleanup()
        arg4.DidUpdate = false
        debug.profileend()

        return
    end

    arg4.m_State = arg4.m_State .. `{arg4.DefaultY}|{arg4.TextSize}`

    if arg4.m_State == arg4.m_PreviousState then
        arg4:m_Cleanup()
        arg4.DidUpdate = false
        debug.profileend()

        return
    end

    arg4:m_Pool()
    arg4.m_PreviousState = arg4.m_State
    arg4.DidUpdate = true

    for key_1, val in arg4.m_RenderGroup do
        debug.profilebegin("Render Item")

        if #arg4.m_ItemPool == 0 then
            local v4 = arg4:m_CreateLabel(val.Text, val.TextColor, val.BackgroundColor, val.Indent)
            v4.LayoutOrder = key_1
            v4.Parent = arg4.BackFrame
            debug.profileend()
        else
            debug.profilebegin("Edit Label")
            local v5 = table.remove(arg4.m_ItemPool, #arg4.m_ItemPool)
            local TaskText = v5.TaskText
            v5.LayoutOrder = key_1
            v5.BackgroundColor3 = val.BackgroundColor
            TaskText.Text = val.Text
            TaskText.TextColor3 = val.TextColor
            TaskText.Position = UDim2.fromOffset(50 * val.Indent, 0)
            v5.Visible = true
            v5.Parent = arg4.BackFrame
            debug.profileend()
            debug.profileend()
        end
    end

    arg4:m_Cleanup()
    debug.profileend()
end

function t.Destroy(arg5) -- line: 239
    arg5.BackFrame:Destroy()
    setmetatable(arg5, nil)
end

return t
