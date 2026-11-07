-- Decompiled with Veyra harvester
-- Instance: StarterGui.LootUI.LootDisplay.LootClient
-- Class: LocalScript
-- bytes: 12729

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local v2 = Services_m.Maid.new()
local v3, v4 = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local HumanoidRootPart = v4:WaitForChild("HumanoidRootPart")
local PlayerGui = v3:WaitForChild("PlayerGui")
local _ = require(ReplicatedStorage.Modules.Basic)
local ViewportHandle_m = require(ReplicatedStorage.Modules.ViewportHandle)
local Items_m = require(ReplicatedStorage.Modules.Items)
local Weight_m = require(ReplicatedStorage.Modules.Weight)
local GamepadLayer_m = require(ReplicatedStorage.Modules.GamepadLayer)
local Parent = script.Parent
local _ = PlayerGui:WaitForChild(".objects")
local BackpackUtils_m = require(ReplicatedStorage.Modules.BackpackUtils)
local _ = BackpackUtils_m.StatOrder
local Categories = BackpackUtils_m.Categories

local function CREATESLOT(arg1, arg2, arg3, _) -- line: 33
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] Categories (copy)
    --  [3] v2 (copy)
    --  [4] ViewportHandle_m (copy)
    --  [5] BackpackUtils_m (copy)
    --  [6] Weight_m (copy)

    local v5 = arg2.Name:split("_")[1]
    local v6 = Items_m.AllItems[v5]

    if not v6 then
        return warn("Item not found: " .. v5)
    end

    local Desc = v6.Desc
    local _ = v6.Rarity
    local Type = v6.Type
    local MasteryType = v6.MasteryType
    local Stats = arg2:GetAttribute("Stats")
    local Enchantment = arg2:GetAttribute("Enchantment")
    local Quality = arg2:GetAttribute("Quality")
    local Stock = arg2:GetAttribute("Stock")
    local v7 = Categories[Type]
    local _ = v7.Order
    local Color = v7.Color
    local _ = Color3.new(0, 0, 0)
    local v8 = script.LootTemplate:Clone()
    v8.LayoutOrder = arg3 or 0
    v8.Name = arg2.Name
    v2:GiveTask(v8)
    local v9 = ViewportHandle_m.new(v5, v8)

    if v9 then
        v9.AnchorPoint = Vector2.new(0, 0.5)
        v9.Size = UDim2.new(0.2, 0, 0.88, 0)
        v9.Position = UDim2.new(0, 5, 0.5, 0)
        v9.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        v9.BackgroundTransparency = 0.5
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 2)
        UICorner.Parent = v9
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = Color3.fromRGB(100, 100, 100)
        UIStroke.Parent = v9
    end

    local Display = v8.Display
    local Stats_1 = Display.Stats
    Display.Label.Text = v5

    if Enchantment ~= "" then
        Display.Enchantment.Visible = true
        Display.Enchantment.Text = Enchantment
        v8.LayoutOrder = -10
    end

    local t = {}
    local v10 = Stats:split(",")

    if v10[1] ~= "" then
        for _, val in v10 do
            if val ~= "" then
                local v11 = val:match("%d+")
                local v12 = val:match("[%a%s]+")

                if v11 ~= "0" then
                    table.insert(
                        t,
                        {
                            text = BackpackUtils_m.getAttrib(val, MasteryType, v6, v5),
                            order = BackpackUtils_m.StatOrder[v12] or 1
                        }
                    )
                end
            end
        end
    end

    for key_1, val_1 in BackpackUtils_m.validAttributes do
        local v14 = v6[key_1]

        if v14 then
            table.insert(
                t,
                {
                    text = if val_1:sub(-1) == " " then val_1 .. v14 else if val_1:sub(1, 1) == " " then v14 .. val_1 else val_1 .. v14,
                    order = BackpackUtils_m.StatOrder[key_1] or 1
                }
            )
        end
    end

    local Stats_2 = v6._stats

    if Stats_2 then
        for key_2, val_2 in Stats_2 do
            table.insert(
                t,
                {
                    text = "" .. BackpackUtils_m.getAttrib(key_2 .. " " .. val_2),
                    order = BackpackUtils_m.StatOrder[key_2] or 1
                }
            )
        end
    end

    local v17 = Weight_m.GetItemWeight(v6, arg2) * math.max(Stock or 1, 1)

    if v17 > 0 then
        table.insert(t, { text = "Carry Weight: " .. Weight_m.FormatNumber(v17), order = 99 })
    end

    table.sort(t, function(arg5, arg6) -- line: 137
        return arg5.order < arg6.order
    end)
    v6 = ""

    for key_3, val_3 in ipairs(t) do
        local v19 = val_3.text:gsub("%s+$", "")
        local v20 = key_3 < #t and v19 .. "," or v19
        v6 ..= v20
    end

    if v6 == "" then
        v6 = Desc
    end

    Stats_1.Text = v6
    Stats_1.Visible = Stats_1.Text ~= ""
    v8.BackgroundColor3 = Color
    v8.Outline.ImageColor3 = Color3.fromRGB(70, 70, 70)

    local function mouseClick() -- line: 158
        -- upvalues:
        --  [1] arg2 (copy)

        local RemoteEvent = arg2:FindFirstChildWhichIsA("RemoteEvent")

        if RemoteEvent then
            RemoteEvent:FireServer()
        end
    end

    local function mouseEnter() -- line: 165
        -- upvalues:
        --  [1] v8 (copy)

        v8.BackgroundTransparency = 0.4
    end

    local function mouseLeave() -- line: 169
        -- upvalues:
        --  [1] v8 (copy)

        v8.BackgroundTransparency = 0
    end

    local t_5 = {}

    function t_5.Enchantment() -- line: 175
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] Display (copy)
        --  [3] Enchantment (copy)

        BackpackUtils_m:SetEnchantment(Display, Enchantment, true)
    end

    function t_5.Quality() -- line: 179
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] Display (copy)
        --  [3] Type (copy)
        --  [4] Quality (copy)

        BackpackUtils_m:SetQuality(Display, Type, Quality, true)
        Display.Quality.Visible = #Display.Quality:GetChildren() > 1 and true
    end

    for _, val_4 in pairs(t_5) do
        val_4()
    end

    v8.Button.Activated:Connect(mouseClick)
    v8.MouseEnter:Connect(mouseEnter)
    v8.MouseLeave:Connect(mouseLeave)

    if Stock > 1 then
        Display.Label.Text ..= " (" .. Stock .. ")"
    end

    v8.Parent = arg1
end

script:GetAttributeChangedSignal("Viewing"):Connect(function() -- line: 199
    -- upvalues:
    --  [1] Parent (copy)

    Parent.Visible = script:GetAttribute("Viewing")
end)
local t_6 = {}
local List = Parent.List
List.Selectable = false

local function selectFirstSlot() -- line: 211
    -- upvalues:
    --  [1] GamepadLayer_m (copy)
    --  [2] List (copy)
    --  [3] GuiService (copy)
    --  [4] Parent (copy)

    if GamepadLayer_m.isGamepadActive() then
        if not script:GetAttribute("Viewing") then
            return
        end

        local v24 = nil

        for _, child in List:GetChildren() do
            if child:IsA("Frame") and (child:FindFirstChild("Button") and (not v24 or (child.LayoutOrder < v24.LayoutOrder or child.LayoutOrder == v24.LayoutOrder and child.AbsolutePosition.Y < v24.AbsolutePosition.Y))) then
                v24 = child
            end
        end

        GuiService.SelectedObject = v24 and v24.Button or Parent.LootAll

        return
    else
        return
    end
end

local _ = function() --[[ releaseSelection ]] -- line: 229
    -- upvalues:
    --  [1] GuiService (copy)
    --  [2] Parent (copy)

    local SelectedObject = GuiService.SelectedObject

    if SelectedObject and SelectedObject:IsDescendantOf(Parent) then
        GuiService.SelectedObject = nil
    end
end

function Close() -- line: 236
    -- upvalues:
    --  [1] GuiService (copy)
    --  [2] Parent (copy)
    --  [3] v2 (copy)
    --  [4] t_6 (copy)

    local SelectedObject_1 = GuiService.SelectedObject

    if SelectedObject_1 and SelectedObject_1:IsDescendantOf(Parent) then
        GuiService.SelectedObject = nil
    end

    v2:Destroy()
    script:SetAttribute("Viewing", false)
    Parent.LootAll.Timer.Size = UDim2.new(0, 0, 0, 0)

    for _, val_5 in ipairs(t_6) do
        val_5.Enabled = true
    end

    table.clear(t_6)
end

ReplicatedStorage.Remotes.LOOT.OnClientEvent:Connect(function(
    arg7,
    arg8,
    arg9,
    arg10,
    arg11
) -- line: 247
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] Parent (copy)
    --  [3] CREATESLOT (copy)
    --  [4] List (copy)
    --  [5] v2 (copy)
    --  [6] GuiService (copy)
    --  [7] selectFirstSlot (copy)
    --  [8] RunService (copy)
    --  [9] HumanoidRootPart (copy)
    --  [10] v3 (copy)

    if script:GetAttribute("Viewing") then
        return
    end

    table.insert(t_6, arg7)
    arg7.Enabled = false
    Parent.List.CanvasPosition = Vector2.new(0, 0)

    for _, val_6 in pairs(Parent.List:GetChildren()) do
        if val_6:IsA("TextButton") then
            val_6:Destroy()
        end
    end

    script:SetAttribute("Viewing", true)
    Parent.TopBar.Header.Text = if arg8 == "" then "Loot" else arg8 .. "'s Loot"

    for key_9, val_7 in pairs(arg9:GetChildren()) do
        CREATESLOT(List, val_7, key_9)
    end

    v2:GiveTask(arg9.AncestryChanged:Connect(function(_, arg13) -- line: 271
        if not arg13 then
            Close()
        end
    end))
    v2:GiveTask(arg9.ChildRemoved:Connect(function(child_2) -- line: 277
        -- upvalues:
        --  [1] List (ref)
        --  [2] GuiService (ref)
        --  [3] selectFirstSlot (ref)
        --  [4] arg9 (copy)

        local v30 = List:FindFirstChild(child_2.Name)

        if v30 then
            local SelectedObject_2 = GuiService.SelectedObject
            local v31 = if SelectedObject_2 ~= nil then SelectedObject_2:IsDescendantOf(v30) else false
            v30:Destroy()

            if v31 then
                selectFirstSlot()
            end
        end

        if not arg9:FindFirstChildWhichIsA("Folder") then
            Close()
        end
    end))
    v2:GiveTask(RunService.Stepped:Connect(function() -- line: 294
        -- upvalues:
        --  [1] HumanoidRootPart (ref)
        --  [2] arg10 (copy)

        if (HumanoidRootPart.Position - arg10).Magnitude > 11 then
            Close()
        end
    end))
    v2:GiveTask(Parent.LootAll.Activated:Connect(function() -- line: 300
        -- upvalues:
        --  [1] arg11 (copy)

        arg11:FireServer()
    end))

    local function determineCD() -- line: 304
        -- upvalues:
        --  [1] Parent (ref)
        --  [2] arg11 (copy)
        --  [3] v3 (ref)
        --  [4] v2 (ref)
        --  [5] RunService (ref)

        Parent.LootAll.Label.Text = "Collect All"
        local v35 = arg11:FindFirstChild(v3.UserId)

        if v35 then
            v2.collectcd = nil
            local CooldownTime = v35:GetAttribute("cooldownTime")
            local _ = tick()
            v2.collectcd = RunService.Heartbeat:Connect(function() -- line: 318
                -- upvalues:
                --  [1] v35 (copy)
                --  [2] CooldownTime (copy)
                --  [3] Parent (ref)
                --  [4] v2 (ref)

                local v36 = v35:GetAttribute("timer") or CooldownTime
                Parent.LootAll.Label.Text = "Collect All (" .. string.format("%.1f", v36) .. ")"
                Parent.LootAll.Timer:TweenSize(
                    UDim2.new(math.clamp(v36 / CooldownTime, 0, 1), 0, 1, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quad,
                    0.25,
                    true
                )

                if not v36 or v36 <= 0 then
                    v2.collectcd = nil
                    Parent.LootAll.Label.Text = "Collect All"
                end
            end)
        end
    end

    v2:GiveTask(arg11.ChildAdded:Connect(determineCD))
    determineCD()
    task.defer(selectFirstSlot)
end)
GamepadLayer_m.InputModeChanged:Connect(function(arg15) -- line: 340
    -- upvalues:
    --  [1] selectFirstSlot (copy)
    --  [2] GuiService (copy)
    --  [3] Parent (copy)

    if arg15 then
        selectFirstSlot()

        return
    end

    local SelectedObject_3 = GuiService.SelectedObject

    if SelectedObject_3 and SelectedObject_3:IsDescendantOf(Parent) then
        GuiService.SelectedObject = nil
    end
end)
Parent.BottomBar.Close.Activated:Connect(Close)
CollectionService:GetInstanceAddedSignal("LootDebounce"):Connect(function(arg16) -- line: 350
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] Services_m (copy)
    --  [3] ReplicatedStorage (copy)

    if arg16 == v3 then
        Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Loot, arg16)
    end
end)
