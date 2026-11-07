-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Elements.Notice
-- Class: ModuleScript
-- bytes: 4435

return function(arg1, arg2) -- line: 1
    local Notice_Frame = Instance.new("Frame")
    Notice_Frame.Name = "Notice"
    Notice_Frame.ZIndex = 25
    Notice_Frame.AutomaticSize = Enum.AutomaticSize.X
    Notice_Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Notice_Frame.BorderSizePixel = 0
    Notice_Frame.BackgroundTransparency = 0.1
    Notice_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Notice_Frame.Visible = false
    Notice_Frame.Parent = arg1.widget
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Notice_Frame
    Instance.new("UIStroke").Parent = Notice_Frame
    local NoticeLabel_TextLabel = Instance.new("TextLabel")
    NoticeLabel_TextLabel.Name = "NoticeLabel"
    NoticeLabel_TextLabel.ZIndex = 26
    NoticeLabel_TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    NoticeLabel_TextLabel.AutomaticSize = Enum.AutomaticSize.X
    NoticeLabel_TextLabel.Size = UDim2.new(1, 0, 1, 0)
    NoticeLabel_TextLabel.BackgroundTransparency = 1
    NoticeLabel_TextLabel.Position = UDim2.new(0.5, 0, 0.515, 0)
    NoticeLabel_TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NoticeLabel_TextLabel.FontSize = Enum.FontSize.Size14
    NoticeLabel_TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    NoticeLabel_TextLabel.Text = "1"
    NoticeLabel_TextLabel.TextWrapped = true
    NoticeLabel_TextLabel.TextWrap = true
    NoticeLabel_TextLabel.Font = Enum.Font.Arial
    NoticeLabel_TextLabel.Parent = Notice_Frame
    local Parent = script.Parent.Parent
    local Packages = Parent.Packages
    local Janitor_m = require(Packages.Janitor)
    local GoodSignal_m = require(Packages.GoodSignal)
    local Utility_m = require(Parent.Utility)
    arg1.noticeChanged:Connect(function(arg3) -- line: 43
        -- upvalues:
        --  [1] NoticeLabel_TextLabel (copy)
        --  [2] arg2 (copy)
        --  [3] arg1 (copy)
        --  [4] Utility_m (copy)
        --  [5] Notice_Frame (copy)

        if not arg3 then
            return
        end

        local v1 = arg3 > 99 and true
        local v2 = if not v1 then arg3 else "99+"
        NoticeLabel_TextLabel.Text = v2

        if v1 then
            NoticeLabel_TextLabel.TextSize = 11
        end

        v2 = if arg3 < 1 then false else true
        v1 = arg2.getIconByUID(arg1.parentIconUID)
        local v3 = #arg1.dropdownIcons > 0 or #arg1.menuIcons > 0
        v2 = if not arg1.isSelected then if not v1 then v2 else if v1.isSelected then v2 else false else if not v3 then if not v1 then v2 else if v1.isSelected then v2 else false else false
        Utility_m.setVisible(Notice_Frame, v2, "NoticeHandler")
    end)
    arg1.noticeStarted:Connect(function(arg4, arg5) -- line: 71
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)
        --  [3] Janitor_m (copy)
        --  [4] GoodSignal_m (copy)
        --  [5] Utility_m (copy)

        if not arg4 then
            arg4 = arg1.deselected
        end

        local v4 = arg2.getIconByUID(arg1.parentIconUID)

        if v4 then
            v4:notify(arg4)
        end

        local v5 = arg1.janitor:add(Janitor_m.new())
        local v6 = v5:add(GoodSignal_m.new())
        v5:add(arg1.endNotices:Connect(function() -- line: 83
            -- upvalues:
            --  [1] v6 (copy)

            v6:Fire()
        end))
        v5:add(arg4:Connect(function() -- line: 86
            -- upvalues:
            --  [1] v6 (copy)

            v6:Fire()
        end))
        arg5 = arg5 or Utility_m.generateUID()
        arg1.notices[arg5] = { completeSignal = v6, clearNoticeEvent = arg4 }

        local _ = function() --[[ updateNotice ]] -- line: 94
            -- upvalues:
            --  [1] arg1 (ref)

            arg1.noticeChanged:Fire(arg1.totalNotices)
        end

        arg1.notified:Fire(arg5)
        local v8 = arg1
        v8.totalNotices += 1
        arg1.noticeChanged:Fire(arg1.totalNotices)
        v6:Once(function() -- line: 100
            -- upvalues:
            --  [1] v5 (copy)
            --  [2] arg1 (ref)
            --  [3] arg5 (ref)

            v5:destroy()
            local v9 = arg1
            v9.totalNotices -= 1
            arg1.notices[arg5] = nil
            arg1.noticeChanged:Fire(arg1.totalNotices)
        end)
    end)
    Notice_Frame:SetAttribute("ClipToJoinedParent", true)
    arg1:clipOutside(Notice_Frame)

    return Notice_Frame
end
