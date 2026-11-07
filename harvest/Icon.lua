-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon
-- Class: ModuleScript
-- bytes: 40334

local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local _ = require(script.Types)
local v1 = script
local Reference_m = require(v1.Reference)
local v2 = Reference_m.getObject()
local v3 = v2

if v3 then
    v3 = v2.Value
end

if v3 and v3 ~= v1 then
    return (require(v3))
end

if not v2 then
    Reference_m.addToReplicatedStorage()
end

v3 = require(v1.Packages.GoodSignal)
local Janitor_m = require(v1.Packages.Janitor)
local Utility_m = require(v1.Utility)
local Themes_m = require(v1.Features.Themes)
local Gamepad_m = require(v1.Features.Gamepad)
local Overflow_m = require(v1.Features.Overflow)
local t = {}
t.__index = t
local t_1 = {}
local Themes = v1.Features.Themes
local LocalPlayer = Players.LocalPlayer
local v4 = v3.new()
local Elements = v1.Elements
local v5 = 0
local t_2 = {
    mobile = Enum.PreferredInput.Touch,
    desktop = Enum.PreferredInput.KeyboardAndMouse,
    console = Enum.PreferredInput.Gamepad
}
t.baseDisplayOrderChanged = v3.new()
t.baseDisplayOrder = 10
t.baseTheme = require(Themes.Default)
t.isOldTopbar = false
t.iconsDictionary = t_1
t.insetHeightChanged = v3.new()
t.container = require(Elements.Container)(t)
t.topbarEnabled = true
t.iconAdded = v3.new()
t.iconRemoved = v3.new()
t.iconChanged = v3.new()

function t.getIcons() -- line: 110
    -- upvalues:
    --  [1] t (copy)

    return t.iconsDictionary
end

function t.getIconByUID(arg1) -- line: 114
    -- upvalues:
    --  [1] t (copy)

    local v6 = t.iconsDictionary[arg1]

    if v6 then
        return v6
    end

    return nil
end

function t.getIcon(arg2) -- line: 122
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)

    local v7 = t.getIconByUID(arg2)

    if v7 then
        return v7
    end

    for _, val in pairs(t_1) do
        if val.name == arg2 then
            return val
        end
    end

    return nil
end

function t.setTopbarEnabled(arg3, arg4) -- line: 135
    -- upvalues:
    --  [1] t (copy)

    if typeof(arg3) ~= "boolean" then
        arg3 = t.topbarEnabled
    end

    if not arg4 then
        t.topbarEnabled = arg3
    end

    for _, val_1 in pairs(t.container) do
        val_1.Enabled = arg3
    end
end

function t.modifyBaseTheme(arg5) -- line: 147
    -- upvalues:
    --  [1] Themes_m (copy)
    --  [2] t (copy)
    --  [3] t_1 (copy)

    for _, val_2 in pairs((Themes_m.getModifications(arg5))) do
        for _, val_3 in pairs(t.baseTheme) do
            Themes_m.merge(val_3, val_2)
        end
    end

    for _, val_4 in pairs(t_1) do
        val_4:setTheme(t.baseTheme)
    end
end

function t.setDisplayOrder(arg6) -- line: 159
    -- upvalues:
    --  [1] t (copy)

    t.baseDisplayOrder = arg6
    t.baseDisplayOrderChanged:Fire(arg6)
end

task.defer(Gamepad_m.start, t)
task.defer(Overflow_m.start, t)
task.defer(function() -- line: 169
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] t (copy)
    --  [3] v1 (copy)

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    for _, val_5 in pairs(t.container) do
        val_5.Parent = PlayerGui
    end

    require(v1.Attribute)
end)

function t.new() -- line: 180
    -- upvalues:
    --  [1] t (copy)
    --  [2] Janitor_m (copy)
    --  [3] Utility_m (copy)
    --  [4] t_1 (copy)
    --  [5] v3 (copy)
    --  [6] v1 (copy)
    --  [7] Elements (copy)
    --  [8] v5 (ref)
    --  [9] UserInputService (copy)
    --  [10] t_2 (copy)
    --  [11] v4 (copy)
    --  [12] StarterGui (copy)

    local t_3 = {}
    setmetatable(t_3, t)
    local v8 = Janitor_m.new()
    t_3.janitor = v8
    t_3.themesJanitor = v8:add(Janitor_m.new())
    t_3.singleClickJanitor = v8:add(Janitor_m.new())
    t_3.captionJanitor = v8:add(Janitor_m.new())
    t_3.joinJanitor = v8:add(Janitor_m.new())
    t_3.menuJanitor = v8:add(Janitor_m.new())
    t_3.dropdownJanitor = v8:add(Janitor_m.new())
    local v9 = Utility_m.generateUID()
    t_1[v9] = t_3
    v8:add(function() -- line: 197
        -- upvalues:
        --  [1] t_1 (ref)
        --  [2] v9 (copy)

        t_1[v9] = nil
    end)
    t_3.selected = v8:add(v3.new())
    t_3.deselected = v8:add(v3.new())
    t_3.toggled = v8:add(v3.new())
    t_3.viewingStarted = v8:add(v3.new())
    t_3.viewingEnded = v8:add(v3.new())
    t_3.stateChanged = v8:add(v3.new())
    t_3.notified = v8:add(v3.new())
    t_3.noticeStarted = v8:add(v3.new())
    t_3.noticeChanged = v8:add(v3.new())
    t_3.endNotices = v8:add(v3.new())
    t_3.toggleKeyAdded = v8:add(v3.new())
    t_3.fakeToggleKeyChanged = v8:add(v3.new())
    t_3.alignmentChanged = v8:add(v3.new())
    t_3.updateSize = v8:add(v3.new())
    t_3.resizingComplete = v8:add(v3.new())
    t_3.joinedParent = v8:add(v3.new())
    t_3.menuSet = v8:add(v3.new())
    t_3.dropdownSet = v8:add(v3.new())
    t_3.updateMenu = v8:add(v3.new())
    t_3.startMenuUpdate = v8:add(v3.new())
    t_3.childThemeModified = v8:add(v3.new())
    t_3.indicatorSet = v8:add(v3.new())
    t_3.dropdownChildAdded = v8:add(v3.new())
    t_3.menuChildAdded = v8:add(v3.new())
    t_3.iconModule = v1
    t_3.UID = v9
    t_3.isEnabled = true
    t_3.enabled = t_3.isEnabled
    t_3.isSelected = false
    t_3.isViewing = false
    t_3.joinedFrame = false
    t_3.parentIconUID = false
    t_3.deselectWhenOtherIconSelected = true
    t_3.totalNotices = 0
    t_3.activeState = "Deselected"
    t_3.alignment = ""
    t_3.originalAlignment = ""
    t_3.appliedTheme = {}
    t_3.appearance = {}
    t_3.cachedInstances = {}
    t_3.cachedNamesToInstances = {}
    t_3.cachedCollectives = {}
    t_3.bindedToggleKeys = {}
    t_3.customBehaviours = {}
    t_3.toggleItems = {}
    t_3.bindedEvents = {}
    t_3.notices = {}
    t_3.menuIcons = {}
    t_3.dropdownIcons = {}
    t_3.childIconsDict = {}
    t_3.creationTime = os.clock()
    t_3.widget = v8:add(require(Elements.Widget)(t_3, t))
    t_3:setAlignment()
    v5 += 1
    local v10 = v5 * 0.01 + 1
    t_3:setOrder(v10, "deselected")
    t_3:setOrder(v10, "selected")
    t_3:setTheme(t.baseTheme)
    local ClickRegion = t_3:getInstance("ClickRegion")
    local v11 = false
    local v12 = 0

    local _ = function() --[[ handleToggle ]] -- line: 277
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] v12 (ref)

        if t_3.locked then
            return
        end

        local now = tick()

        if now - v12 < 0.1 then
            return
        end

        v12 = now

        if t_3.isSelected then
            t_3:deselect("User", t_3)

            return
        end

        t_3:select("User", t_3)
    end

    ClickRegion.MouseButton1Click:Connect(function() -- line: 296
        -- upvalues:
        --  [1] v11 (ref)
        --  [2] t_3 (copy)
        --  [3] v12 (ref)

        v11 = true

        if t_3.locked then
            return
        end

        local now_1 = tick()

        if now_1 - v12 < 0.1 then
            return
        end

        v12 = now_1

        if t_3.isSelected then
            t_3:deselect("User", t_3)

            return
        end

        t_3:select("User", t_3)
    end)
    ClickRegion.TouchTap:Connect(function() -- line: 301
        -- upvalues:
        --  [1] v11 (ref)
        --  [2] t_3 (copy)
        --  [3] v12 (ref)

        if not v11 then
            if t_3.locked then
                return
            end

            local now_2 = tick()

            if now_2 - v12 < 0.1 then
                return
            end

            v12 = now_2

            if t_3.isSelected then
                t_3:deselect("User", t_3)

                return
            end

            t_3:select("User", t_3)
        end
    end)
    v8:add(UserInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- line: 314
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] v12 (ref)

        if t_3.locked then
            return
        end

        if t_3.bindedToggleKeys[input.KeyCode] and not gameProcessedEvent then
            if t_3.locked then
                return
            end

            local now_3 = tick()

            if now_3 - v12 < 0.1 then
                return
            end

            v12 = now_3

            if t_3.isSelected then
                t_3:deselect("User", t_3)

                return
            end

            t_3:select("User", t_3)
        end
    end))

    local function viewingStarted(arg9) -- line: 326
        -- upvalues:
        --  [1] t_3 (copy)

        if t_3.locked then
            return
        end

        t_3.isViewing = true
        t_3.viewingStarted:Fire(true)

        if not arg9 then
            t_3:setState("Viewing", "User", t_3)
        end
    end

    local function viewingEnded() -- line: 336
        -- upvalues:
        --  [1] t_3 (copy)

        if t_3.locked then
            return
        end

        t_3.isViewing = false
        t_3.viewingEnded:Fire(true)
        t_3:setState(nil, "User", t_3)
    end

    t_3.joinedParent:Connect(function() -- line: 344
        -- upvalues:
        --  [1] t_3 (copy)

        if t_3.isViewing then
            if t_3.locked then
                return
            end

            t_3.isViewing = false
            t_3.viewingEnded:Fire(true)
            t_3:setState(nil, "User", t_3)
        end
    end)
    ClickRegion.MouseEnter:Connect(function() -- line: 349
        -- upvalues:
        --  [1] UserInputService (ref)
        --  [2] t_2 (ref)
        --  [3] t_3 (copy)

        local v13 = UserInputService.PreferredInput ~= t_2.desktop

        if t_3.locked then
            return
        end

        t_3.isViewing = true
        t_3.viewingStarted:Fire(true)

        if not v13 then
            t_3:setState("Viewing", "User", t_3)
        end
    end)
    local v14 = 0
    v8:add(UserInputService.TouchEnded:Connect(viewingEnded))
    ClickRegion.MouseLeave:Connect(viewingEnded)
    ClickRegion.SelectionGained:Connect(viewingStarted)
    ClickRegion.SelectionLost:Connect(viewingEnded)
    ClickRegion.MouseButton1Down:Connect(function() -- line: 358
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] UserInputService (ref)
        --  [3] t_2 (ref)
        --  [4] v14 (ref)

        if not t_3.locked and UserInputService.PreferredInput == t_2.mobile then
            v14 += 1
            local v15 = v14
            task.delay(0.2, function() -- line: 362
                -- upvalues:
                --  [1] v15 (copy)
                --  [2] v14 (ref)
                --  [3] t_3 (ref)

                if v15 == v14 then
                    if t_3.locked then
                        return
                    end

                    t_3.isViewing = true
                    t_3.viewingStarted:Fire(true)
                    t_3:setState("Viewing", "User", t_3)
                end
            end)
        end
    end)
    ClickRegion.MouseButton1Up:Connect(function() -- line: 369
        -- upvalues:
        --  [1] v14 (ref)

        v14 += 1
    end)
    local IconOverlay = t_3:getInstance("IconOverlay")
    t_3.viewingStarted:Connect(function() -- line: 375
        -- upvalues:
        --  [1] IconOverlay (copy)
        --  [2] t_3 (copy)

        IconOverlay.Visible = not t_3.overlayDisabled
    end)
    t_3.viewingEnded:Connect(function() -- line: 378
        -- upvalues:
        --  [1] IconOverlay (copy)

        IconOverlay.Visible = false
    end)
    v8:add(v4:Connect(function(arg10) -- line: 383
        -- upvalues:
        --  [1] t_3 (copy)

        if arg10 ~= t_3 and t_3.deselectWhenOtherIconSelected and arg10.deselectWhenOtherIconSelected then
            t_3:deselect("AutoDeselect", arg10)
        end
    end))
    local v16 = string.split(debug.info(2, "s"), ".")
    local v17 = game
    local v18 = nil

    for _, val_6 in pairs(v16) do
        v17 = v17:FindFirstChild(val_6)

        if not v17 then
            break
        end

        if v17:IsA("ScreenGui") then
            v18 = v17
        end
    end

    local _ = v17:IsA("ScreenGui")

    if v17 and v18 and v18.ResetOnSpawn == true then
        t_3.originsScreenGui = v18
        Utility_m.localPlayerRespawned(function() -- line: 409
            -- upvalues:
            --  [1] t_3 (copy)

            t_3:destroy()
        end)
    end

    t_3.toggled:Connect(function(arg11) -- line: 415
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] t (ref)

        t_3.noticeChanged:Fire(t_3.totalNotices)

        for key_7, _ in pairs(t_3.childIconsDict) do
            local v20 = t.getIconByUID(key_7)
            v20.noticeChanged:Fire(v20.totalNotices)

            if not arg11 and v20.isSelected then
                for _, _ in pairs(v20.childIconsDict) do
                    v20:deselect("HideParentFeature", t_3)
                end
            end
        end
    end)
    t_3.selected:Connect(function() -- line: 438
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] StarterGui (ref)

        if if not (#t_3.dropdownIcons > 0) then false else true then
            if StarterGui:GetCore("ChatActive") and t_3.alignment ~= "Right" then
                t_3.chatWasPreviouslyActive = true
                StarterGui:SetCore("ChatActive", false)
            end

            if StarterGui:GetCoreGuiEnabled("PlayerList") and t_3.alignment ~= "Left" then
                t_3.playerlistWasPreviouslyActive = true
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
            end
        end
    end)
    t_3.deselected:Connect(function() -- line: 451
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] StarterGui (ref)

        if t_3.chatWasPreviouslyActive then
            t_3.chatWasPreviouslyActive = nil
            StarterGui:SetCore("ChatActive", true)
        end

        if t_3.playerlistWasPreviouslyActive then
            t_3.playerlistWasPreviouslyActive = nil
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        end
    end)
    task.delay(0.1, function() -- line: 465
        -- upvalues:
        --  [1] t_3 (copy)

        if t_3.activeState == "Deselected" then
            t_3.stateChanged:Fire("Deselected")
            t_3:refresh()
        end
    end)
    t.iconAdded:Fire(t_3)

    return t_3
end

function t.setName(arg12, arg13) -- line: 481
    arg12.widget.Name = arg13
    arg12.name = arg13

    return arg12
end

function t.setState(arg14, arg15, arg16, arg17) -- line: 487
    -- upvalues:
    --  [1] Utility_m (copy)
    --  [2] v4 (copy)

    local v22

    if not arg15 then
        v22 = if not arg14.isSelected then "Deselected" else "Selected"
        arg15 = v22
    end

    v22 = Utility_m.formatStateName(arg15)

    if arg14.activeState == v22 then
        return
    end

    local IsSelected = arg14.isSelected
    arg14.activeState = v22

    if v22 == "Deselected" then
        arg14.isSelected = false

        if IsSelected then
            arg14.toggled:Fire(false, arg16, arg17)
            arg14.deselected:Fire(arg16, arg17)
        end

        arg14:_setToggleItemsVisible(false, arg16, arg17)
    elseif v22 == "Selected" then
        arg14.isSelected = true

        if not IsSelected then
            arg14.toggled:Fire(true, arg16, arg17)
            arg14.selected:Fire(arg16, arg17)
            v4:Fire(arg14, arg16, arg17)
        end

        arg14:_setToggleItemsVisible(true, arg16, arg17)
    end

    arg14.stateChanged:Fire(v22, arg16, arg17)
end

function t.getInstance(arg18, arg19) -- line: 520
    -- upvalues:
    --  [1] Themes_m (copy)

    local v23 = arg18.cachedNamesToInstances[arg19]

    if v23 then
        return v23
    end

    local function cacheInstance(arg20, arg21) -- line: 528
        -- upvalues:
        --  [1] arg18 (copy)

        if not arg18.cachedInstances[arg21] then
            local Collective = arg21:GetAttribute("Collective")
            local v24 = Collective

            if v24 then
                v24 = arg18.cachedCollectives[Collective]
            end

            if v24 then
                table.insert(v24, arg21)
            end

            arg18.cachedNamesToInstances[arg20] = arg21
            arg18.cachedInstances[arg21] = true
            arg21.Destroying:Once(function() -- line: 538
                -- upvalues:
                --  [1] arg18 (ref)
                --  [2] arg20 (copy)
                --  [3] arg21 (copy)

                arg18.cachedNamesToInstances[arg20] = nil
                arg18.cachedInstances[arg21] = nil
            end)
        end
    end

    local Widget = arg18.widget
    cacheInstance("Widget", Widget)

    if arg19 == "Widget" then
        return Widget
    end

    local v26 = nil

    local function scanChildren(arg22) -- line: 551
        -- upvalues:
        --  [1] arg18 (copy)
        --  [2] Themes_m (ref)
        --  [3] scanChildren (copy)
        --  [4] cacheInstance (copy)
        --  [5] arg19 (copy)
        --  [6] v26 (ref)

        local Name

        for _, child in pairs(arg22:GetChildren()) do
            local WidgetUID = child:GetAttribute("WidgetUID")

            if not WidgetUID or WidgetUID == arg18.UID then
                local v28 = Themes_m.getRealInstance(child)

                if v28 then
                    child = v28
                end

                scanChildren(child)

                if not child:IsA("GuiBase") then
                    if not child:IsA("UIBase") then
                        if child:IsA("ValueBase") then
                            Name = child.Name
                            cacheInstance(Name, child)

                            if Name == arg19 then
                                v26 = child
                            end
                        end
                    else
                        Name = child.Name
                        cacheInstance(Name, child)

                        if Name == arg19 then
                            v26 = child
                        end
                    end
                else
                    Name = child.Name
                    cacheInstance(Name, child)

                    if Name == arg19 then
                        v26 = child
                    end
                end
            end
        end
    end

    scanChildren(Widget)

    return v26
end

function t.getCollective(arg23, arg24) -- line: 580
    local v29 = arg23.cachedCollectives[arg24]

    if v29 then
        return v29
    end

    local t_4 = {}

    for key_10, _ in pairs(arg23.cachedInstances) do
        if key_10:GetAttribute("Collective") == arg24 then
            table.insert(t_4, key_10)
        end
    end

    arg23.cachedCollectives[arg24] = t_4

    return t_4
end

function t.getInstanceOrCollective(arg25, arg26) -- line: 601
    local v30 = {}
    local v31 = arg25:getInstance(arg26)

    if v31 then
        table.insert(v30, v31)
    end

    if #v30 == 0 then
        v30 = arg25:getCollective(arg26)
    end

    return v30
end

function t.getStateGroup(arg27, arg28) -- line: 615
    local v32 = arg28 or arg27.activeState
    local v33 = arg27.appearance[v32]

    if not v33 then
        v33 = {}
        arg27.appearance[v32] = v33
    end

    return v33
end

function t.refreshAppearance(arg29, arg30, arg31) -- line: 625
    -- upvalues:
    --  [1] Themes_m (copy)

    Themes_m.refresh(arg29, arg30, arg31)

    return arg29
end

function t.refresh(arg32) -- line: 630
    arg32:refreshAppearance(arg32.widget)
    arg32.updateSize:Fire()

    return arg32
end

function t.updateParent(arg33) -- line: 636
    -- upvalues:
    --  [1] t (copy)

    local v34 = t.getIconByUID(arg33.parentIconUID)

    if v34 then
        v34.updateSize:Fire()
    end
end

function t.setBehaviour(
    arg34,
    arg35,
    arg36,
    arg37,
    arg38
) -- line: 643
    arg34.customBehaviours[arg35 .. "-" .. arg36] = arg37

    if arg38 then
        for _, val_10 in pairs((arg34:getInstanceOrCollective(arg35))) do
            arg34:refreshAppearance(val_10, arg36)
        end
    end
end

function t.modifyTheme(arg39, arg40, arg41) -- line: 656
    -- upvalues:
    --  [1] Themes_m (copy)

    return arg39, (Themes_m.modify(arg39, arg40, arg41))
end

function t.modifyChildTheme(arg42, arg43, arg44) -- line: 661
    -- upvalues:
    --  [1] t (copy)

    arg42.childModifications = arg43
    arg42.childModificationsUID = arg44

    for key_12, _ in pairs(arg42.childIconsDict) do
        t.getIconByUID(key_12):modifyTheme(arg43, arg44)
    end

    arg42.childThemeModified:Fire()

    return arg42
end

function t.removeModification(arg45, arg46) -- line: 674
    -- upvalues:
    --  [1] Themes_m (copy)

    Themes_m.remove(arg45, arg46)

    return arg45
end

function t.removeModificationWith(arg47, arg48, arg49, arg50) -- line: 679
    -- upvalues:
    --  [1] Themes_m (copy)

    Themes_m.removeWith(arg47, arg48, arg49, arg50)

    return arg47
end

function t.setTheme(arg51, arg52) -- line: 684
    -- upvalues:
    --  [1] Themes_m (copy)

    Themes_m.set(arg51, arg52)

    return arg51
end

function t.setEnabled(arg53, arg54) -- line: 689
    arg53.isEnabled = arg54
    arg53.enabled = arg53.isEnabled
    arg53.widget.Visible = arg54
    arg53:updateParent()

    return arg53
end

function t.select(arg55, arg56, arg57) -- line: 697
    arg55:setState("Selected", arg56, arg57)

    return arg55
end

function t.deselect(arg58, arg59, arg60) -- line: 702
    arg58:setState("Deselected", arg59, arg60)

    return arg58
end

function t.notify(arg61, arg62, arg63) -- line: 707
    -- upvalues:
    --  [1] Elements (copy)
    --  [2] t (copy)

    if not arg61.notice then
        arg61.notice = require(Elements.Notice)(arg61, t)
    end

    arg61.noticeStarted:Fire(arg62, arg63)

    return arg61
end

function t.clearNotices(arg64) -- line: 721
    arg64.endNotices:Fire()

    return arg64
end

function t.disableOverlay(arg65, arg66) -- line: 726
    arg65.overlayDisabled = arg66

    return arg65
end

t.disableStateOverlay = t.disableOverlay

function t.setImage(arg67, arg68, arg69) -- line: 732
    -- upvalues:
    --  [1] ContentProvider (copy)

    arg67:modifyTheme({ "IconImage", "Image", arg68, arg69 })
    task.spawn(function() -- line: 736
        -- upvalues:
        --  [1] arg68 (copy)
        --  [2] ContentProvider (ref)

        local v36 = if tonumber(arg68) then `rbxassetid://{arg68}` else arg68

        if ContentProvider:GetAssetFetchStatus(v36) ~= Enum.AssetFetchStatus.Success then
            pcall(ContentProvider.PreloadAsync, ContentProvider, { v36 })
        end
    end)

    return arg67
end

function t.setLabel(arg70, arg71, arg72) -- line: 748
    arg70:modifyTheme({ "IconLabel", "Text", arg71, arg72 })

    return arg70
end

function t.setOrder(arg73, arg74, arg75) -- line: 753
    local v38 = arg74 * 100
    arg73:modifyTheme({ "IconSpot", "LayoutOrder", v38, arg75 })
    arg73:modifyTheme({ "Widget", "LayoutOrder", v38, arg75 })

    return arg73
end

function t.setCornerRadius(arg76, arg77, arg78) -- line: 762
    arg76:modifyTheme({ "IconCorners", "CornerRadius", arg77, arg78 })

    return arg76
end

function t.align(arg79, arg80, arg81) -- line: 767
    -- upvalues:
    --  [1] t (copy)

    local v39 = tostring(arg80):lower()

    if v39 == "mid" or v39 == "centre" then
        v39 = "center"
    end

    v39 = if v39 == "left" then v39 else if v39 == "center" then v39 else if v39 == "right" then v39 else "left"
    local v40 = if v39 ~= "center" then t.container.TopbarStandard else t.container.TopbarCentered or t.container.TopbarStandard
    local Holders = v40.Holders
    local v42 = string.upper((string.sub(v39, 1, 1))) .. string.sub(v39, 2)

    if not arg81 then
        arg79.originalAlignment = v42
    end

    local v43 = Holders[v42]
    local JoinedFrame = arg79.joinedFrame
    arg79.screenGui = v40
    arg79.alignmentHolder = v43

    if not arg79.isDestroyed then
        arg79.widget.Parent = JoinedFrame or v43
    end

    arg79.alignment = v42
    arg79.alignmentChanged:Fire(v42)
    t.iconChanged:Fire(arg79)

    return arg79
end

t.setAlignment = t.align

function t.setLeft(arg82) -- line: 796
    arg82:setAlignment("Left")

    return arg82
end

function t.setMid(arg83) -- line: 801
    arg83:setAlignment("Center")

    return arg83
end

function t.setRight(arg84) -- line: 806
    arg84:setAlignment("Right")

    return arg84
end

function t.setWidth(arg85, arg86, arg87) -- line: 811
    arg85:modifyTheme({ "Widget", "DesiredWidth", arg86, arg87 })

    return arg85
end

function t.setImageScale(arg88, arg89, arg90) -- line: 819
    arg88:modifyTheme({ "IconImageScale", "Value", arg89, arg90 })

    return arg88
end

function t.setImageRatio(arg91, arg92, arg93) -- line: 824
    arg91:modifyTheme({ "IconImageRatio", "AspectRatio", arg92, arg93 })

    return arg91
end

function t.setTextSize(arg94, arg95, arg96) -- line: 829
    arg94:modifyTheme({ "IconLabel", "TextSize", arg95, arg96 })

    return arg94
end

function t.setTextFont(
    arg97,
    arg98,
    arg99,
    arg100,
    arg101
) -- line: 834
    local v44 = arg99 or Enum.FontWeight.Regular
    arg99 = v44
    v44 = arg100 or Enum.FontStyle.Normal
    arg100 = v44
    v44 = nil
    local v45 = typeof(arg98)

    if v45 == "number" then
        v44 = Font.fromId(arg98, arg99, arg100)
    elseif v45 == "EnumItem" then
        v44 = Font.fromEnum(arg98)
    elseif v45 == "string" and not arg98:match("rbxasset") then
        v44 = Font.fromName(arg98, arg99, arg100)
    end

    if not v44 then
        v44 = Font.new(arg98, arg99, arg100)
    end

    arg97:modifyTheme({ "IconLabel", "FontFace", v44, arg101 })

    return arg97
end

function t.setTextColor(arg102, arg103, arg104) -- line: 855
    if arg103 ~= nil then
        if arg103 ~= "" then
            if type(arg103) == "userdata" then
                if typeof(arg103) ~= "Color3" then
                    if arg103 ~= nil and arg103 ~= "" then
                        warn(
                            "setTextColor item must be a Color3 value! Changed the color to white."
                        )
                    end

                    arg103 = Color3.fromRGB(255, 255, 255)
                end
            else
                if arg103 ~= nil and arg103 ~= "" then
                    warn("setTextColor item must be a Color3 value! Changed the color to white.")
                end

                arg103 = Color3.fromRGB(255, 255, 255)
            end
        else
            if arg103 ~= nil and arg103 ~= "" then
                warn("setTextColor item must be a Color3 value! Changed the color to white.")
            end

            arg103 = Color3.fromRGB(255, 255, 255)
        end
    else
        if arg103 ~= nil and arg103 ~= "" then
            warn("setTextColor item must be a Color3 value! Changed the color to white.")
        end

        arg103 = Color3.fromRGB(255, 255, 255)
    end

    arg102:modifyTheme({ "IconLabel", "TextColor3", arg103, arg104 })

    return arg102
end

function t.bindToggleItem(arg105, arg106) -- line: 867
    if not arg106:IsA("GuiObject") and not arg106:IsA("LayerCollector") then
        error("Toggle item must be a GuiObject or LayerCollector!")
    end

    arg105.toggleItems[arg106] = true
    arg105:_updateSelectionInstances()

    return arg105
end

function t.unbindToggleItem(arg107, arg108) -- line: 876
    arg107.toggleItems[arg108] = nil
    arg107:_updateSelectionInstances()

    return arg107
end

function t._updateSelectionInstances(arg109) -- line: 882
    for key_13, _ in pairs(arg109.toggleItems) do
        local t_5 = {}

        for _, val_13 in pairs(key_13:GetDescendants()) do
            if not val_13:IsA("TextButton") then
                if val_13:IsA("ImageButton") and val_13.Active then
                    table.insert(t_5, val_13)
                end
            elseif val_13.Active then
                table.insert(t_5, val_13)
            end
        end

        arg109.toggleItems[key_13] = t_5
    end
end

function t._setToggleItemsVisible(arg110, arg111, _, arg113) -- line: 896
    for key_15, _ in pairs(arg110.toggleItems) do
        if not arg113 or arg113 == arg110 or arg113.toggleItems[key_15] == nil then
            key_15[if key_15:IsA("LayerCollector") then "Enabled" else "Visible"] = arg111
        end
    end
end

function t.bindEvent(arg114, arg115, arg116) -- line: 908
    local v48 = arg114[arg115]
    local v49 = v48

    if v49 then
        v49 = if typeof(v48) == "table" then v48.Connect else false
    end

    assert(v49, "argument[1] must be a valid topbarplus icon event name!")
    assert(if typeof(arg116) ~= "function" then false else true, "argument[2] must be a function!")
    arg114.bindedEvents[arg115] = v48:Connect(function(...) -- line: 912
        -- upvalues:
        --  [1] arg116 (copy)
        --  [2] arg114 (copy)

        arg116(arg114, ...)
    end)

    return arg114
end

function t.unbindEvent(arg117, arg118) -- line: 918
    local v50 = arg117.bindedEvents[arg118]

    if v50 then
        v50:Disconnect()
        arg117.bindedEvents[arg118] = nil
    end

    return arg117
end

function t.bindToggleKey(arg119, arg120) -- line: 927
    assert(
        if typeof(arg120) ~= "EnumItem" then false else true,
        "argument[1] must be a KeyCode EnumItem!"
    )
    arg119.bindedToggleKeys[arg120] = true
    arg119.toggleKeyAdded:Fire(arg120)
    arg119:setCaption("_hotkey_")

    return arg119
end

function t.unbindToggleKey(arg121, arg122) -- line: 935
    assert(
        if typeof(arg122) ~= "EnumItem" then false else true,
        "argument[1] must be a KeyCode EnumItem!"
    )
    arg121.bindedToggleKeys[arg122] = nil

    return arg121
end

function t.call(arg123, arg124, ...) -- line: 941
    local t_6 = table.pack(...)
    task.spawn(function() -- line: 943
        -- upvalues:
        --  [1] arg124 (copy)
        --  [2] arg123 (copy)
        --  [3] t_6 (copy)

        arg124(arg123, table.unpack(t_6))
    end)

    return arg123
end

function t.addToJanitor(arg125, arg126, arg127, arg128) -- line: 949
    arg125.janitor:add(arg126, arg127, arg128)

    return arg125
end

function t.lock(arg129) -- line: 954
    arg129:getInstance("ClickRegion").Visible = false
    arg129.locked = true

    return arg129
end

function t.unlock(arg130) -- line: 962
    arg130:getInstance("ClickRegion").Visible = true
    arg130.locked = false

    return arg130
end

function t.debounce(arg131, arg132) -- line: 969
    arg131:lock()
    task.wait(arg132)
    arg131:unlock()

    return arg131
end

function t.autoDeselect(arg133, arg134) -- line: 976
    if arg134 == nil then
        arg134 = true
    end

    arg133.deselectWhenOtherIconSelected = arg134

    return arg133
end

function t.oneClick(arg135, arg136) -- line: 986
    local SingleClickJanitor = arg135.singleClickJanitor
    SingleClickJanitor:clean()

    if arg136 or arg136 == nil then
        SingleClickJanitor:add(arg135.selected:Connect(function() -- line: 992
            -- upvalues:
            --  [1] arg135 (copy)

            arg135:deselect("OneClick", arg135)
        end))
    end

    arg135.oneClickEnabled = true

    return arg135
end

function t.setCaption(arg137, arg138) -- line: 1000
    -- upvalues:
    --  [1] Elements (copy)

    if arg138 == "_hotkey_" and arg137.captionText then
        return arg137
    end

    local CaptionJanitor = arg137.captionJanitor
    arg137.captionJanitor:clean()

    if not arg138 or arg138 == "" then
        arg137.caption = nil
        arg137.captionText = nil

        return arg137
    end

    local v55 = CaptionJanitor:add(require(Elements.Caption)(arg137))
    v55:SetAttribute("CaptionText", arg138)
    arg137.caption = v55
    arg137.captionText = arg138

    return arg137
end

function t.setCaptionHint(arg139, arg140) -- line: 1018
    assert(
        if typeof(arg140) ~= "EnumItem" then false else true,
        "argument[1] must be a KeyCode EnumItem!"
    )
    arg139.fakeToggleKey = arg140
    arg139.fakeToggleKeyChanged:Fire(arg140)
    arg139:setCaption("_hotkey_")

    return arg139
end

function t.leave(arg141) -- line: 1026
    arg141.joinJanitor:clean()

    return arg141
end

function t.joinMenu(arg142, arg143) -- line: 1032
    -- upvalues:
    --  [1] Utility_m (copy)

    Utility_m.joinFeature(arg142, arg143, arg143.menuIcons, arg143:getInstance("Menu"))
    arg143.menuChildAdded:Fire(arg142)

    return arg142
end

function t.setMenu(arg144, arg145) -- line: 1038
    arg144.menuSet:Fire(arg145)

    return arg144
end

function t.setFixedMenu(arg146, arg147) -- line: 1043
    arg146:freezeMenu(arg147)
    arg146:setMenu(arg147)
end

t.setFrozenMenu = t.setFixedMenu

function t.freezeMenu(arg148) -- line: 1049
    arg148:select("FrozenMenu", arg148)
    arg148:bindEvent("deselected", function(arg149) -- line: 1053
        -- upvalues:
        --  [1] arg148 (copy)

        arg149:select("FrozenMenu", arg148)
    end)
    arg148:modifyTheme({ "IconSpot", "Visible", false })
end

function t.joinDropdown(arg150, arg151) -- line: 1059
    -- upvalues:
    --  [1] Utility_m (copy)

    arg151:getDropdown()
    Utility_m.joinFeature(
        arg150,
        arg151,
        arg151.dropdownIcons,
        arg151:getInstance("DropdownScroller")
    )
    arg151.dropdownChildAdded:Fire(arg150)

    return arg150
end

function t.getDropdown(arg152) -- line: 1066
    -- upvalues:
    --  [1] Elements (copy)

    local v57 = arg152.dropdown

    if not v57 then
        v57 = require(Elements.Dropdown)(arg152)
        arg152.dropdown = v57
        arg152:clipOutside(v57)
    end

    return v57
end

function t.setDropdown(arg153, arg154) -- line: 1076
    arg153:getDropdown()
    arg153.dropdownSet:Fire(arg154)

    return arg153
end

function t.clipOutside(arg155, arg156) -- line: 1082
    -- upvalues:
    --  [1] Utility_m (copy)

    local v58 = Utility_m.clipOutside(arg155, arg156)
    arg155:refreshAppearance(arg156)

    return arg155, v58
end

function t.setIndicator(arg157, arg158) -- line: 1093
    -- upvalues:
    --  [1] Elements (copy)
    --  [2] t (copy)

    if not arg157.indicator then
        arg157.indicator = arg157.janitor:add(require(Elements.Indicator)(arg157, t))
    end

    arg157.indicatorSet:Fire(arg158)
end

function t.convertLabelToNumberSpinner(arg159, arg160, arg161) -- line: 1105
    task.defer(function() -- line: 1106
        -- upvalues:
        --  [1] arg159 (copy)
        --  [2] arg160 (copy)
        --  [3] arg161 (copy)

        local IconLabel = arg159:getInstance("IconLabel")
        IconLabel.Transparency = 1
        arg160.Parent = IconLabel.Parent
        arg160.Size = UDim2.fromScale(1, 1)
        arg160.AnchorPoint = Vector2.new(0.5, 0.5)
        arg160.Position = UDim2.new(0.5, 0, 0.5, 0)
        arg160.TextXAlignment = Enum.TextXAlignment.Center
        arg160.ClipsDescendants = false

        for _, val_15 in ipairs(
            {
                "FontFace",
                "BorderSizePixel",
                "BorderColor3",
                "Rotation",
                "TextStrokeTransparency",
                "TextStrokeColor3",
                "TextStrokeTransparency",
                "TextColor3"
            }
        ) do
            arg160[val_15] = IconLabel[val_15]
            arg159:addToJanitor(IconLabel:GetPropertyChangedSignal(val_15):Connect(function() -- line: 1129
                -- upvalues:
                --  [1] arg160 (ref)
                --  [2] val_15 (copy)
                --  [3] IconLabel (copy)

                arg160[val_15] = IconLabel[val_15]
            end))
        end

        local function getSpinnerSizeAndDigitCount() -- line: 1136
            -- upvalues:
            --  [1] arg160 (ref)

            local v63 = 0
            local v64 = 0

            for _, child_1 in arg160.Frame:GetChildren() do
                local v65 = string.lower(child_1.Name)

                if v65 == "digit" then
                    v63 += child_1.AbsoluteSize.X
                    v64 += 1
                elseif (v65 == "prefix" or v65 == "suffix" or v65 == "comma") and child_1.Text ~= "" then
                    v63 += child_1.AbsoluteSize.X
                    v64 += 1
                end
            end

            return v63, v64
        end

        local _ = function() --[[ getLabelParentContainerXSize ]] -- line: 1154
            -- upvalues:
            --  [1] IconLabel (copy)
            --  [2] arg160 (ref)

            local Parent = IconLabel.Parent
            local v66 = Parent

            if v66 then
                v66 = Parent.Parent
            end

            return if v66 ~= nil then if v66.IconImage.Visible ~= true then v66.AbsoluteSize.X else arg160.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X else 0
        end

        local _ = function() --[[ getNumberSpinnerXSize ]] -- line: 1166
            -- upvalues:
            --  [1] arg160 (ref)

            return arg160.Frame.AbsoluteSize.X
        end

        local function adjustSize() -- line: 1170
            -- upvalues:
            --  [1] getSpinnerSizeAndDigitCount (copy)
            --  [2] arg159 (ref)
            --  [3] arg160 (ref)
            --  [4] IconLabel (copy)

            local v67, v68 = getSpinnerSizeAndDigitCount()

            if v68 < 18 then
                arg159:setLabel(arg160.Value)
            end

            local v69 = arg160.Frame.AbsoluteSize.X

            while v67 < v69 do
                if arg159.isDestroyed == true then
                    break
                end

                task.wait(0.05)

                if v68 > 0 and v68 < 8 then
                    arg160.TextSize = IconLabel.TextSize
                    break
                end

                local v70 = arg160
                v70.TextSize += 1
                v69 = arg160.Frame.AbsoluteSize.X
                v67, v68 = getSpinnerSizeAndDigitCount()
            end

            local Parent_1 = IconLabel.Parent
            local v71 = Parent_1

            if v71 then
                v71 = Parent_1.Parent
            end

            v69 = if v71 ~= nil then if v71.IconImage.Visible ~= true then v71.AbsoluteSize.X else arg160.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X else 0

            while v67 > v69 do
                if arg159.isDestroyed == true then
                    break
                end

                task.wait(0.05)

                if v68 < 8 and v68 > 0 then
                    arg160.TextSize = IconLabel.TextSize

                    return
                end

                local v72 = arg160
                v72.TextSize -= 1
                local Parent_2 = IconLabel.Parent
                local v73 = Parent_2

                if v73 then
                    v73 = Parent_2.Parent
                end

                v69 = if v73 == nil then 0 else if v73.IconImage.Visible == true then arg160.Frame.AbsoluteSize.X + IconLabel.Parent.Parent.IconImage.AbsoluteSize.X else v73.AbsoluteSize.X
                v67, v68 = getSpinnerSizeAndDigitCount()
            end
        end

        arg159:addToJanitor(arg160.Frame.ChildAdded:Connect(adjustSize))
        arg159:addToJanitor(arg160.Frame.ChildRemoved:Connect(adjustSize))
        arg159:addToJanitor(arg159.iconAdded:Connect(function() -- line: 1208
            -- upvalues:
            --  [1] adjustSize (copy)

            task.wait(1)
            adjustSize()
        end))
        arg159:updateParent()
        arg160.Name = "LabelSpinner"
        arg160.Prefix = "$"
        arg160.Commas = true
        arg160.Decimals = 0
        arg160.Duration = 0.25
        arg160.Value = 10
        task.wait(0.2)

        if typeof(arg161) == "function" then
            arg161()
        end
    end)

    return arg159
end

function t.destroy(arg162) -- line: 1235
    -- upvalues:
    --  [1] t (copy)

    if arg162.isDestroyed then
        return
    end

    arg162:clearNotices()

    if arg162.parentIconUID then
        arg162:leave()
    end

    arg162.isDestroyed = true
    arg162.janitor:clean()
    t.iconRemoved:Fire(arg162)
end

t.Destroy = t.destroy

return t
