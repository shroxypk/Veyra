-- Decompiled with Veyra harvester
-- Instance: StarterGui.BlacksmithUI.Main.CraftingClient
-- Class: LocalScript
-- bytes: 204614

do
    do
        local Services_m = require(game:GetService("ReplicatedFirst").Services)
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local v2 = ReplicatedStorage.Modules
        local BackpackUtils_m = require(v2.BackpackUtils)
        local Items_m = require(v2.Items)
        local ViewportHandle_m = require(v2.ViewportHandle)
        local Formatter_m = require(v2.Formatter)
        local Professions_m = require(v2.Professions)
        local SmeltData_m = require(v2.SmeltData)
        local StatManager_m = require(v2.StatManager)
        local v3, v4 = require(v2.scriptObjs).GetPlayerCharacter()
        local v5 = StatManager_m.require(v3)
        local CraftRemote = ReplicatedStorage.Remotes.Client.CraftRemote
        local Schematics = v3:WaitForChild("Schematics")
        local Inventory = v3:WaitForChild("Inventory")
        local Professions = v3:WaitForChild("Professions")
        local Parent = script.Parent
        local Window = Parent:WaitForChild("Window")
        local Templates = Window.Templates
        local Scale = Window.Scale
        local Title = Window.Title
        local Subtitle = Window.Subtitle
        local HeaderArt = Window.HeaderArt
        local Tabs = Window.Tabs
        local Close = Window.Close
        local CraftView = Window.CraftView
        local Items = CraftView.Items
        local Box = Items.Search.Box
        local Sort = Items.Sort
        local SortMenu = Items.SortMenu
        local Options = SortMenu.Options
        local Details = CraftView.Details
        local v6 = Details.Content
        local Scroll = v6.Scroll
        local Bottom = v6.Bottom
        local Quantity = Bottom.Quantity
        local Action = Bottom.Action
        local SmeltView = Window.SmeltView
        local Select = SmeltView.Select
        local Filters = Select.Filters
        local Grid = Select.Grid
        local Box_1 = Select.Search.Box
        local Count = Select.Count
        local Empty = Select.Empty
        local Details_1 = SmeltView.Details
        local v7 = Details_1.Content
        local Scroll_1 = v7.Scroll
        local Bottom_1 = v7.Bottom
        local Quantity_1 = Bottom_1.Quantity
        local Action_1 = Bottom_1.Action
        local t = {
            BUTTON = Color3.fromRGB(15, 15, 24),
            BUTTON_ON = Color3.fromRGB(36, 36, 58),
            BUTTON_OFF = Color3.fromRGB(22, 22, 30),
            CONFIRM = Color3.fromRGB(110, 32, 32),
            TOGGLE_HIGH = Color3.fromRGB(105, 76, 46),
            ACCENT = Color3.fromRGB(255, 190, 124),
            TEXT = Color3.fromRGB(225, 225, 225),
            TEXT_DIM = Color3.fromRGB(175, 175, 175),
            TEXT_OFF = Color3.fromRGB(120, 120, 130)
        }
        local TitleRule = Window.TitleRule
        local List = CraftView.Categories.List
        local List_1 = Items.List
        local Empty_1 = Items.Empty

        local _ = function(arg1, arg2) --[[ setSelected ]] -- line: 89
            -- upvalues:
            --  [1] t (copy)

            local SelectedOutline = arg1:FindFirstChild("SelectedOutline")

            if SelectedOutline then
                SelectedOutline.Visible = arg2
            end

            arg1.BackgroundColor3 = arg2 and t.BUTTON_ON or t.BUTTON
        end

        local t_1 = {
            Craft = {
                Title = "Crafting",
                Subtitle = "Create equipment, consumables and other items from the materials you've gathered."
            },
            Smelt = {
                Title = "Smelting",
                Subtitle = "Melt armor and weapons down into ore scrap and salvaged materials."
            }
        }

        local function qualityOrder(arg3) -- line: 119
            arg3 = math.clamp(math.floor(tonumber(arg3) or 0), 0, 3)
            local t_2 = { arg3 }

            for index = arg3 - 1, 0, -1 do
                table.insert(t_2, index)
            end

            for index_1 = arg3 + 1, 3 do
                table.insert(t_2, index_1)
            end

            return t_2
        end

        local _ = {
            Weapon = "rbxassetid://15454346332",
            Helmet = "rbxassetid://15454500834",
            Face = "rbxassetid://15464023729",
            Neck = "rbxassetid://123695900858427",
            Chest = "rbxassetid://15454568076",
            Legs = "rbxassetid://15453352188",
            Back = "rbxassetid://15454526777",
            Outfit = "rbxassetid://15462287157"
        }
        local Star = v2.BackpackUtils:FindFirstChild("Star")
        v2 = Star and Star.Image or "rbxassetid://11739217830"

        local function setStarImages(arg4, arg5) -- line: 134
            -- upvalues:
            --  [1] Star (copy)
            --  [2] v2 (copy)

            for _, child in arg4:GetChildren() do
                if child:IsA("ImageLabel") then
                    child:Destroy()
                end
            end

            for index_2 = 1, math.clamp(math.floor(arg5 or 0), 0, 3) do
                local _ = math.clamp(math.floor(arg5 or 0), 0, 3)
                local v10 = Star and Star:Clone() or Instance.new("ImageLabel")
                v10.Name = "Star" .. index_2
                v10.Image = v2
                v10.BackgroundTransparency = 1
                v10.SizeConstraint = Enum.SizeConstraint.RelativeYY
                v10.Size = UDim2.fromScale(1, 1)
                v10.ScaleType = Enum.ScaleType.Fit
                v10.LayoutOrder = index_2
                v10.ZIndex = arg4.ZIndex + 1
                v10.Parent = arg4
            end
        end

        local font = Font.new("rbxasset://fonts/families/AccanthisADFStd.json")

        local function segmentKey(arg6) -- line: 159
            -- upvalues:
            --  [1] segmentKey (copy)

            if type(arg6) == "string" then
                return arg6
            end

            if arg6.stars then
                return `*{arg6.stars}:{arg6.size or ""}`
            end

            local t_4 = {}

            for _, val in arg6.group or arg6 do
                table.insert(t_4, segmentKey(val))
            end

            return "[" .. table.concat(t_4, "|") .. "]"
        end

        local _ = function(arg7, arg8, arg9) --[[ horizontalList ]] -- line: 173
            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, arg8)
            UIListLayout.Wraps = arg9 == true
            UIListLayout.Parent = arg7

            return UIListLayout
        end

        local function addSegments(arg10, arg11, arg12, arg13) -- line: 184
            -- upvalues:
            --  [1] font (copy)
            --  [2] t (copy)
            --  [3] setStarImages (copy)
            --  [4] addSegments (copy)

            for key_2, val_1 in arg11 do
                if type(val_1) == "string" then
                    local TextLabel = Instance.new("TextLabel")
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.FontFace = font
                    TextLabel.TextSize = arg13
                    TextLabel.TextColor3 = t.TEXT
                    TextLabel.RichText = true
                    TextLabel.Text = val_1
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.AutomaticSize = Enum.AutomaticSize.X
                    TextLabel.Size = UDim2.fromOffset(0, arg12)
                    TextLabel.LayoutOrder = key_2
                    TextLabel.ZIndex = arg10.ZIndex + 1
                    local UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = Color3.fromRGB(20, 20, 20)
                    UIStroke.Thickness = 1.5
                    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
                    UIStroke.Parent = TextLabel
                    TextLabel.Parent = arg10
                elseif val_1.stars then
                    local v13 = math.clamp(math.floor(val_1.stars), 0, 3)

                    if v13 > 0 then
                        local v14 = val_1.size or math.floor(arg12 * 0.78)
                        local Stars_Frame = Instance.new("Frame")
                        Stars_Frame.Name = "Stars"
                        Stars_Frame.BackgroundTransparency = 1
                        Stars_Frame.Size = UDim2.fromOffset(v13 * v14 + (v13 - 1), v14)
                        Stars_Frame.LayoutOrder = key_2
                        Stars_Frame.ZIndex = arg10.ZIndex + 1
                        v14 = Instance.new("UIListLayout")
                        v14.FillDirection = Enum.FillDirection.Horizontal
                        v14.VerticalAlignment = Enum.VerticalAlignment.Center
                        v14.SortOrder = Enum.SortOrder.LayoutOrder
                        v14.Padding = UDim.new(0, 1)
                        v14.Wraps = false
                        v14.Parent = Stars_Frame
                        Stars_Frame.Parent = arg10
                        setStarImages(Stars_Frame, v13)
                    end
                elseif val_1.group then
                    local Frame_1 = Instance.new("Frame")
                    Frame_1.Name = "Group"
                    Frame_1.BackgroundTransparency = 1
                    Frame_1.AutomaticSize = Enum.AutomaticSize.X
                    Frame_1.Size = UDim2.fromOffset(0, arg12)
                    Frame_1.LayoutOrder = key_2
                    Frame_1.ZIndex = arg10.ZIndex + 1
                    local v15 = val_1.pad or 3
                    local UIListLayout_1 = Instance.new("UIListLayout")
                    UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
                    UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center
                    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
                    UIListLayout_1.Padding = UDim.new(0, v15)
                    UIListLayout_1.Wraps = false
                    UIListLayout_1.Parent = Frame_1
                    Frame_1.Parent = arg10
                    addSegments(Frame_1, val_1.group, arg12, val_1.textSize or arg13)
                end
            end
        end

        local function clearRendered(arg14) -- line: 234
            for _, child_1 in arg14:GetChildren() do
                if not child_1:IsA("UIListLayout") and not child_1:IsA("UIPadding") then
                    child_1:Destroy()
                end
            end
        end

        local function renderSegments(arg15, arg16, arg17, arg18) -- line: 242
            -- upvalues:
            --  [1] segmentKey (copy)
            --  [2] clearRendered (copy)
            --  [3] addSegments (copy)

            local v16 = segmentKey({ group = arg16 })

            if arg15:GetAttribute("RenderKey") == v16 then
                return
            end

            arg15:SetAttribute("RenderKey", v16)
            clearRendered(arg15)
            addSegments(arg15, arg16, arg17, arg18)
        end

        local function renderLines(arg19, arg20) -- line: 252
            -- upvalues:
            --  [1] segmentKey (copy)
            --  [2] clearRendered (copy)
            --  [3] addSegments (copy)

            local t_6 = {}

            for _, val_2 in arg20 do
                table.insert(t_6, (segmentKey({ group = val_2 })))
            end

            local v18 = table.concat(t_6, "\n")

            if arg19:GetAttribute("RenderKey") == v18 then
                return
            end

            arg19:SetAttribute("RenderKey", v18)
            clearRendered(arg19)

            for key_5, val_3 in arg20 do
                local Frame_2 = Instance.new("Frame")
                Frame_2.Name = "Line" .. key_5
                Frame_2.BackgroundTransparency = 1
                Frame_2.Size = UDim2.new(1, 0, 0, 0)
                Frame_2.AutomaticSize = Enum.AutomaticSize.Y
                Frame_2.LayoutOrder = key_5
                Frame_2.ZIndex = arg19.ZIndex
                local UIListLayout_2 = Instance.new("UIListLayout")
                UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
                UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
                UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_2.Padding = UDim.new(0, 5)
                UIListLayout_2.Wraps = true
                UIListLayout_2.Parent = Frame_2
                Frame_2.Parent = arg19
                addSegments(Frame_2, val_3, 20, 17)
            end
        end

        local v19 = "Craft"

        local _ = function(arg21) --[[ getItemInfo ]] -- line: 280
            -- upvalues:
            --  [1] Items_m (copy)

            local v20 = Items_m.AllItems[arg21]
            local v21 = v20

            if type(v20) ~= "table" or not v21 then
                v21 = nil
            end

            return v21
        end

        local _ = function() --[[ getCraftingLevel ]] -- line: 285
            -- upvalues:
            --  [1] Professions (copy)

            local Crafting = Professions:FindFirstChild("Crafting")

            return Crafting and Crafting.Value or 1
        end

        local _ = function() --[[ getBenefits ]] -- line: 290
            -- upvalues:
            --  [1] Professions_m (copy)
            --  [2] v3 (copy)

            return Professions_m:GetPlayerBenefits(v3, "Crafting")
        end

        local _ = function(arg22) --[[ getRequiredLevel ]] -- line: 294
            -- upvalues:
            --  [1] Professions_m (copy)

            local Crafting_1 = Professions_m:GetProfessions().Crafting
            local v23 = Crafting_1

            if v23 then
                v23 = Crafting_1.RecipeLevels
            end

            return v23 and v23[arg22] or arg22
        end

        local function getRequirement(arg23) -- line: 301
            -- upvalues:
            --  [1] Professions_m (copy)

            return Professions_m:GetCraftRequirement(arg23)
        end

        local _ = function(arg24) --[[ getProfessionLevel ]] -- line: 305
            -- upvalues:
            --  [1] Professions (copy)

            local v25 = Professions:FindFirstChild(arg24)

            return v25 and v25.Value or 1
        end

        local _ = function() --[[ getBulkMax ]] -- line: 310
            -- upvalues:
            --  [1] Professions_m (copy)
            --  [2] v3 (copy)

            local v27 = math.floor(Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0)

            return (math.max(1, v27))
        end

        local _ = function(arg25, arg26) --[[ clearChildren ]] -- line: 314
            for _, child_2 in arg25:GetChildren() do
                if arg26 then
                    if not child_2:IsA(arg26) then
                        child_2:Destroy()
                    end
                else
                    child_2:Destroy()
                end
            end
        end

        local function setIcon(arg27, arg28, arg29) -- line: 322
            -- upvalues:
            --  [1] ViewportHandle_m (copy)
            --  [2] Items_m (copy)
            --  [3] ReplicatedStorage (copy)

            local v28 = arg27:FindFirstChild("Holder") or arg27

            for _, child_3 in v28:GetChildren() do
                if not child_3:IsA("ViewportFrame") then
                    if not child_3:IsA("ImageLabel") then
                        if child_3:IsA("TextLabel") then
                            ViewportHandle_m:Destroy(child_3)
                            child_3:Destroy()
                        end
                    else
                        ViewportHandle_m:Destroy(child_3)
                        child_3:Destroy()
                    end
                else
                    ViewportHandle_m:Destroy(child_3)
                    child_3:Destroy()
                end
            end

            if not arg28 then
                return
            end

            local v29 = Items_m.AllItems[arg28]
            local v30 = v29

            if type(v29) ~= "table" or not v30 then
                v30 = nil
            end

            v29 = v30 and (v30.Icon or v30.Image)

            if typeof(v29) == "string" and v29 ~= "" and not ReplicatedStorage.Tools:FindFirstChild(
                arg28
            ) then
                v30 = Instance.new("ImageLabel")
                v30.BackgroundTransparency = 1
                v30.Image = v29
                v30.ScaleType = Enum.ScaleType.Fit
                v30.Size = UDim2.fromScale(1, 1)
                v30.ZIndex = v28.ZIndex + 1
                v30.Parent = v28

                return
            end

            local v31 = arg29 ~= false
            v29 = ViewportHandle_m.new(arg28, v28, v31)

            if v29 then
                v29.AnchorPoint = Vector2.new(0.5, 0.5)
                v29.Position = UDim2.fromScale(0.5, 0.5)
                v29.Size = UDim2.fromScale(1, 1)
                v29.BackgroundTransparency = 1
                v29.ZIndex = v28.ZIndex + 1
                v29.Ambient = Color3.fromRGB(215, 210, 200)
                v29.LightColor = Color3.fromRGB(255, 246, 228)
                v29.LightDirection = Vector3.new(-1, -1.5, -1)
            end
        end

        local function setImageIcon(arg30, arg31, arg32) -- line: 358
            -- upvalues:
            --  [1] t (copy)

            local v32 = arg30:FindFirstChild("Holder") or arg30

            for _, child_4 in v32:GetChildren() do
                child_4:Destroy()
            end

            if arg31 then
                local ImageLabel = Instance.new("ImageLabel")
                ImageLabel.BackgroundTransparency = 1
                ImageLabel.Image = arg31
                ImageLabel.ScaleType = Enum.ScaleType.Fit
                ImageLabel.Size = UDim2.fromScale(0.86, 0.86)
                ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
                ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageLabel.ZIndex = v32.ZIndex + 1
                ImageLabel.Parent = v32

                return
            end

            if arg32 then
                local TextLabel_1 = Instance.new("TextLabel")
                TextLabel_1.BackgroundTransparency = 1
                TextLabel_1.Text = arg32
                TextLabel_1.TextColor3 = t.ACCENT
                TextLabel_1.TextScaled = true
                TextLabel_1.FontFace = Font.new(
                    "rbxasset://fonts/families/Balthazar.json",
                    Enum.FontWeight.Bold
                )
                TextLabel_1.Size = UDim2.fromScale(1, 1)
                TextLabel_1.ZIndex = v32.ZIndex + 1
                TextLabel_1.Parent = v32
            end
        end

        local function styleGoldButton(arg33, arg34) -- line: 384
            -- upvalues:
            --  [1] t (copy)

            local SelectedOutline_1 = arg33:FindFirstChild("SelectedOutline")
            local Label = arg33:FindFirstChild("Label")

            if SelectedOutline_1 then
                SelectedOutline_1.Visible = arg34 ~= "disabled"
            end

            if arg34 == "confirm" then
                arg33.BackgroundColor3 = t.CONFIRM
            elseif arg34 == "disabled" then
                arg33.BackgroundColor3 = t.BUTTON_OFF
            else
                arg33.BackgroundColor3 = t.BUTTON_ON
            end

            if Label then
                Label.TextColor3 = if arg34 ~= "disabled" then t.TEXT else t.TEXT_OFF or t.TEXT
            end
        end

        local _ = function(arg35, arg36) --[[ setButtonText ]] -- line: 402
            local Label_1 = arg35:FindFirstChild("Label")

            if Label_1 then
                Label_1.Text = arg36
            end
        end

        local v35 = nil

        local _ = function(arg37, arg38) --[[ showTip ]] -- line: 410
            -- upvalues:
            --  [1] v35 (ref)
            --  [2] BackpackUtils_m (copy)

            v35 = arg37
            BackpackUtils_m:ShowHover(arg38)
        end

        local _ = function(arg39) --[[ hideTip ]] -- line: 414
            -- upvalues:
            --  [1] v35 (ref)
            --  [2] BackpackUtils_m (copy)

            if v35 ~= nil and (arg39 == nil or v35 == arg39) then
                v35 = nil
                BackpackUtils_m:HideHover()
            end
        end

        local function layoutRules() -- line: 421
            -- upvalues:
            --  [1] Scale (copy)
            --  [2] Window (copy)
            --  [3] Title (copy)
            --  [4] Tabs (copy)
            --  [5] TitleRule (copy)

            local Scale_1 = Scale.Scale

            if Scale_1 <= 0 then
                return
            end

            for _, descendant in Window:GetDescendants() do
                if descendant:IsA("TextLabel") and descendant:GetAttribute("LineGap") then
                    local Rule = descendant.Parent:FindFirstChild("Rule")
                    local v36 = descendant.TextBounds.X / Scale_1

                    if Rule and v36 > 0 then
                        Rule.Position = UDim2.new(0, v36 + 10, 0.5, 0)
                        Rule.Size = UDim2.new(1, -(v36 + 10), 0, 9)
                    end
                end
            end

            local v37 = Title.TextBounds.X / Scale_1

            if v37 > 0 then
                local v38 = Title.Position.X.Offset + v37 + 14
                local v39 = (Tabs.AbsolutePosition.X - Window.AbsolutePosition.X) / Scale_1
                TitleRule.Position = UDim2.fromOffset(v38, TitleRule.Position.Y.Offset)
                TitleRule.Size = UDim2.fromOffset(
                    math.max(v39 - 16 - v38, 0),
                    TitleRule.Size.Y.Offset
                )
            end
        end

        local function updateScale() -- line: 445
            -- upvalues:
            --  [1] Scale (copy)

            local CurrentCamera = workspace.CurrentCamera

            if not CurrentCamera then
                return
            end

            local ViewportSize = CurrentCamera.ViewportSize
            Scale.Scale = math.clamp(
                math.min(ViewportSize.X * 0.5 / 900, ViewportSize.Y * 0.6 / 580),
                0.45,
                0.85
            )
        end

        local function getStacks(arg40) -- line: 455
            -- upvalues:
            --  [1] Inventory (copy)
            --  [2] Formatter_m (copy)

            local t_8 = {}

            for _, child_5 in Inventory:GetChildren() do
                if Formatter_m.formatItem(child_5.Name) == arg40 then
                    table.insert(t_8, child_5)
                end
            end

            return t_8
        end

        local function getQualityCounts(arg41) -- line: 465
            local v44 = arg41:GetAttribute("Stock") or 0
            local v45 = arg41:GetAttribute("Q1") or 0
            local v46 = arg41:GetAttribute("Q2") or 0
            local v47 = arg41:GetAttribute("Q3") or 0

            return { [0] = math.max(v44 - v45 - v46 - v47, 0), [1] = v45, [2] = v46, [3] = v47 }
        end

        local function getMaterialTotals(arg42) -- line: 473
            -- upvalues:
            --  [1] getStacks (copy)
            --  [2] getQualityCounts (copy)

            local v48 = 0
            local t_10 = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }

            for _, val_4 in getStacks(arg42) do
                v48 += val_4:GetAttribute("Stock") or 0
                local v49 = getQualityCounts(val_4)
                t_10[0] += v49[0]
                t_10[1] = t_10[1] + v49[1]
                t_10[2] = t_10[2] + v49[2]
                t_10[3] = t_10[3] + v49[3]
            end

            return v48, t_10
        end

        local t_11 = {
            Material = "Materials",
            Weapon = "Weapons",
            Armor = "Armor",
            Outfit = "Outfits",
            Consumable = "Consumables",
            Tool = "Tools",
            Pickaxe = "Gathering",
            Sickle = "Gathering",
            Artifact = "Artifacts",
            Game = "Other",
            Schematic = "Schematics"
        }
        local t_12 = {
            All = 0,
            Schematics = 1,
            Materials = 2,
            Weapons = 3,
            Armor = 4,
            Outfits = 5,
            Consumables = 6,
            Tools = 7,
            Gathering = 8,
            Artifacts = 9,
            Other = 10
        }
        local t_13 = {
            Weapons = "rbxassetid://15454346332",
            Armor = "rbxassetid://15454568076",
            Outfits = "rbxassetid://15462287157"
        }
        local t_14 = {}
        local t_15 = {}
        local v51 = "All"
        local v52 = "Default"
        local v53 = false
        local v54 = nil
        local v55 = 1
        local t_16 = {}
        local t_17 = {}
        local v56 = false

        local _ = function(arg43) --[[ groupOf ]] -- line: 531
            -- upvalues:
            --  [1] t_11 (copy)

            return t_11[arg43.Type] or (arg43.Type or "Other")
        end

        local _ = function(arg44) --[[ getPreference ]] -- line: 535
            -- upvalues:
            --  [1] t_16 (copy)

            return t_16[arg44] or 0
        end

        local function buildPreferenceArg(arg45) -- line: 539
            -- upvalues:
            --  [1] t_16 (copy)

            local t_18 = {}
            local v58 = false

            for key_12 in arg45 do
                t_18[key_12] = t_16[key_12] or 0

                if t_18[key_12] > 0 then
                    v58 = true
                end
            end

            return v58 and t_18 or 0
        end

        local function affordableCount(arg46) -- line: 550
            -- upvalues:
            --  [1] getMaterialTotals (copy)
            --  [2] v5 (copy)

            local Craftsettings = arg46._craftsettings

            if not Craftsettings or not Craftsettings.Materials then
                return 0
            end

            local v60 = math.huge

            for key_13, val_5 in Craftsettings.Materials do
                if val_5 > 0 then
                    v60 = math.min(v60, (math.floor(getMaterialTotals(key_13) / val_5)))
                end
            end

            if (Craftsettings.Marks or 0) > 0 then
                v60 = math.min(v60, (math.floor((v5:GetStat("Marks") or 0) / Craftsettings.Marks)))
            end

            if v60 == math.huge then
                v60 = 0
            end

            return v60
        end

        local _ = function(arg47) --[[ levelOk ]] -- line: 570
            -- upvalues:
            --  [1] Professions_m (copy)
            --  [2] Professions (copy)

            local v63, v64 = Professions_m:GetCraftRequirement(arg47)
            local v65 = Professions:FindFirstChild(v63)
            local v66 = v64
            v64 = v65 and v65.Value or 1
            v63 = v66 <= v64

            return v63
        end

        local _ = function(arg48) --[[ canCraftNow ]] -- line: 575
            -- upvalues:
            --  [1] Professions_m (copy)
            --  [2] Professions (copy)
            --  [3] affordableCount (copy)

            local v67 = false

            if arg48.Kind == "Recipe" then
                local v68, v69 = Professions_m:GetCraftRequirement(arg48.Info)
                local v70 = Professions:FindFirstChild(v68)
                v68 = v70 and v70.Value or 1
                v67 = v69 <= v68 and true and affordableCount(arg48.Info) > 0
            end

            return v67
        end

        local function setCraftCount(arg49) -- line: 579
            -- upvalues:
            --  [1] Professions_m (copy)
            --  [2] v3 (copy)
            --  [3] v55 (ref)
            --  [4] Quantity (copy)

            local v71 = math.floor(Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0)
            local v72 = math.max(1, v71)
            local v73 = math.floor(tonumber(arg49) or 1)
            v55 = math.clamp(v73, 1, v72)
            Quantity.CountFrame.CountBox.Text = tostring(v55)
        end

        local function simulateAverageStars(arg50, arg51) -- line: 585
            -- upvalues:
            --  [1] getStacks (copy)
            --  [2] getQualityCounts (copy)
            --  [3] qualityOrder (copy)
            --  [4] t_16 (copy)

            local t_19 = {}

            for key_14 in arg50 do
                local t_20 = {}

                for _, val_6 in getStacks(key_14) do
                    table.insert(t_20, (getQualityCounts(val_6)))
                end

                t_19[key_14] = t_20
            end

            local t_21 = {}
            local v75, v77, v78, v79, v80, v81

            for index_3 = 1, arg51 do
                if index_3 > 1 then
                    v75 = true

                    for key_16, val_7 in arg50 do
                        local v76 = 0

                        for _, val_8 in t_19[key_16] do
                            v76 += val_8[0] + val_8[1] + val_8[2] + val_8[3]
                        end

                        if val_7 > v76 then
                            v75 = false
                            break
                        end
                    end

                    if not v75 then
                        break
                    end

                    v75 = 0
                    v77 = 0

                    for key_18, val_9 in arg50 do
                        v78 = qualityOrder(t_16[key_18] or 0)
                        v79 = val_9

                        for _, val_10 in t_19[key_18] do
                            for _, val_11 in v78 do
                                if v79 <= 0 then
                                    break
                                end

                                v80 = math.min(val_10[val_11], v79)
                                val_10[val_11] -= v80
                                v79 -= v80
                                v75 += val_11 * v80
                                v77 += v80
                            end

                            if v79 <= 0 then
                                break
                            end
                        end
                    end

                    v81 = v77 > 0 and v75 / v77 or 0
                else
                    v75 = 0
                    v77 = 0

                    for key_21, val_12 in arg50 do
                        v78 = qualityOrder(t_16[key_21] or 0)
                        v79 = val_12

                        for _, val_13 in t_19[key_21] do
                            for _, val_14 in v78 do
                                if v79 <= 0 then
                                    break
                                end

                                v80 = math.min(val_13[val_14], v79)
                                val_13[val_14] -= v80
                                v79 -= v80
                                v75 += val_14 * v80
                                v77 += v80
                            end

                            if v79 <= 0 then
                                break
                            end
                        end
                    end

                    v81 = v77 > 0 and v75 / v77 or 0
                end

                table.insert(t_21, v81)
            end

            return t_21
        end

        local function qualityLines(arg52) -- line: 640
            -- upvalues:
            --  [1] Professions_m (copy)
            --  [2] v3 (copy)
            --  [3] simulateAverageStars (copy)
            --  [4] v55 (ref)

            local Crafting_2 = Professions_m:GetPlayerBenefits(v3, "Crafting")
            local v82 = math.clamp(Crafting_2.star_capability or 0, 0, 3)
            local t_22 = {}

            if not Professions_m:CanCraftStars(arg52) then
                table.insert(
                    t_22,
                    {
                        "<b>Max quality:</b> <font color='rgb(175, 175, 175)'>this item can't have stars</font>"
                    }
                )

                return t_22
            end

            if v82 <= 0 then
                table.insert(
                    t_22,
                    {
                        "<b>Max quality:</b> no stars yet",
                        "<font color='rgb(175, 175, 175)'>(stars unlock at Crafting rank 5)</font>"
                    }
                )
            else
                table.insert(t_22, { "<b>Max quality:</b>", { stars = v82 } })
            end

            if v82 > 0 and (Crafting_2.star_preview or 0) >= 1 then
                local v83 = arg52._craftsettings.Materials or {}
                local v84 = (Crafting_2.perfectionist or 0) > 0
                local v85 = simulateAverageStars(v83, v55)
                v83 = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }
                local v86 = 0

                for _, val_15 in v85 do
                    local v87 = Professions_m:GetCraftStarOdds(
                        Professions_m:GetCraftQualityBoost(Crafting_2, val_15),
                        v82,
                        v84
                    )
                    v83[0] += v87[0] / #v85
                    v83[1] = v83[1] + v87[1] / #v85
                    v83[2] = v83[2] + v87[2] / #v85
                    v83[3] = v83[3] + v87[3] / #v85
                    v86 += val_15 / #v85
                end

                if v86 > 0 then
                    local t_24 = { group = { string.format("%.1f", v86), { stars = 1 }, "avg" } }
                    table.insert(t_22, { "<b>Material quality used:</b>", t_24 })
                else
                    table.insert(t_22, { "<b>Material quality used:</b> no stars" })
                end

                local t_27 = { (("<b>Odds%*:</b>"):format(if v55 > 1 then " per craft" else "")) }

                for index_4 = 0, v82 do
                    local v91 = Professions_m.FormatPercent(v83[index_4])
                    local t_28 = {
                        group = {
                            if index_4 <= 0 then "No stars" else { stars = index_4 },
                            `<font color='rgb(175, 175, 175)'>{v91}</font>`
                        },
                        pad = 4
                    }
                    table.insert(t_27, t_28)

                    if v82 > index_4 then
                        table.insert(t_27, "<font color='rgb(175, 175, 175)'>\226\128\162</font>")
                    end
                end

                table.insert(t_22, t_27)

                if v84 then
                    table.insert(
                        t_22,
                        {
                            "<font color='rgb(175, 175, 175)'><i>Perfectionist: best of two rolls.</i></font>"
                        }
                    )
                end
            end

            return t_22
        end

        local _ = function() --[[ clearMaterialRows ]] -- line: 696
            -- upvalues:
            --  [1] t_17 (copy)

            for _, val_16 in t_17 do
                val_16:Destroy()
            end

            table.clear(t_17)
        end

        local function styleToggle(arg53, arg54) -- line: 703
            -- upvalues:
            --  [1] t_16 (copy)
            --  [2] t (copy)

            local StarPicker = arg53.PickerSlot:FindFirstChild("StarPicker")

            if not StarPicker then
                return
            end

            local v93 = t_16[arg54] or 0
            local _

            for index_5 = 1, 3 do
                local v94 = StarPicker.Stars["Star" .. index_5]
                v94.ImageColor3 = v93 >= index_5 and Color3.new(1, 1, 1) or Color3.fromRGB(
                    70,
                    70,
                    80
                )
                v94.ImageTransparency = if not (v93 >= index_5) then 0.35 else 0
            end

            StarPicker.SelectedOutline.Visible = v93 > 0 and true
            StarPicker.BackgroundColor3 = v93 > 0 and t.BUTTON_ON or t.BUTTON
        end

        local function pickerTip(arg55) -- line: 718
            -- upvalues:
            --  [1] t_16 (copy)

            local v98 = t_16[arg55] or 0
            local v99

            if v98 <= 0 then
                v99 = `Uses your unstarred {arg55} first. Click to use 1-star first.`
            else
                local v100 = `Uses your {v98}-star {arg55} first, then lower stars.`
                local v102

                if v98 < 3 then
                    local v101 = v98 + 1
                    v102 = ` Click to use {v101}-star first.`
                else
                    v102 = " Click to reset."
                end

                v99 = v100 .. v102
            end

            return { key = arg55, text = v99 }
        end

        local function refreshMaterialRows(arg56) -- line: 730
            -- upvalues:
            --  [1] t_17 (copy)
            --  [2] v55 (ref)
            --  [3] getMaterialTotals (copy)
            --  [4] Formatter_m (copy)
            --  [5] renderSegments (ref)
            --  [6] v5 (copy)

            local v103 = arg56._craftsettings and arg56._craftsettings.Materials or {}
            local v106

            for key_26, val_17 in v103 do
                local v104 = t_17[key_26]

                if v104 then
                    local v105 = val_17 * v55
                    local v107
                    v106, v107 = getMaterialTotals(key_26)
                    local v108 = if v105 <= v106 then "rgb(212, 255, 155)" else "rgb(255, 94, 97)"
                    local v109 = Formatter_m.addCommas(v106)
                    local t_31 = { `<font color='{v108}'><b>{v109}</b></font> / {v105}` }

                    for index_6 = 3, 1, -1 do
                        if v107[index_6] > 0 then
                            local t_32 = { group = nil, pad = 2 }
                            local v110 = Formatter_m.addCommas(v107[index_6])
                            t_32.group = {
                                { stars = index_6, size = 13 },
                                `<font size='16' color='rgb(175, 175, 175)'>{v110}</font>`
                            }
                            table.insert(t_31, t_32)
                        end
                    end

                    renderSegments(v104.Amount, t_31, 20, 17)
                end
            end

            v103 = t_17._Marks

            if v103 then
                local v111 = (arg56._craftsettings.Marks or 0) * v55
                local v112 = v5:GetStat("Marks") or 0
                local v113 = renderSegments
                local Amount = v103.Amount
                v106 = if v111 <= v112 then "rgb(212, 255, 155)" else "rgb(255, 94, 97)"
                local v114 = Formatter_m.addCommas(v112)
                local v115 = Formatter_m.addCommas(v111)
                v113(Amount, { `<font color='{v106}'><b>{v114}</b></font> / {v115}` }, 20, 17)
            end
        end

        local function buildMaterialRows(arg57) -- line: 755
            -- upvalues:
            --  [1] t_17 (copy)
            --  [2] Scroll (copy)
            --  [3] Templates (copy)
            --  [4] setIcon (copy)
            --  [5] t_16 (copy)
            --  [6] styleToggle (copy)
            --  [7] pickerTip (copy)
            --  [8] v35 (ref)
            --  [9] BackpackUtils_m (copy)
            --  [10] t (copy)
            --  [11] refreshMaterialRows (copy)

            for _, val_18 in t_17 do
                val_18:Destroy()
            end

            table.clear(t_17)
            local Craftsettings_1 = arg57._craftsettings
            local v116 = Craftsettings_1.Materials or {}
            local Materials = Scroll.Materials
            local t_36 = {}

            for key_28 in v116 do
                table.insert(t_36, key_28)
            end

            table.sort(t_36)

            for key_29, val_19 in t_36 do
                v116 = Templates.MaterialRow:Clone()
                v116.Name = val_19
                v116.LayoutOrder = key_29
                v116.Label.Text = val_19
                setIcon(v116.Icon, val_19, true)
                local v118 = Templates.StarPicker:Clone()
                v118.Position = UDim2.fromScale(0, 0)
                v118.Size = UDim2.fromScale(1, 1)
                v118.Parent = v116.PickerSlot
                v118.MouseButton1Click:Connect(function() -- line: 777
                    -- upvalues:
                    --  [1] val_19 (copy)
                    --  [2] t_16 (ref)
                    --  [3] styleToggle (ref)
                    --  [4] v116 (copy)
                    --  [5] v118 (copy)
                    --  [6] pickerTip (ref)
                    --  [7] v35 (ref)
                    --  [8] BackpackUtils_m (ref)

                    local v119 = ((t_16[val_19] or 0) + 1) % 4
                    t_16[val_19] = v119 > 0 and v119 or nil
                    styleToggle(v116, val_19)
                    local v121 = v118
                    local v122 = pickerTip(val_19)
                    v35 = v121
                    BackpackUtils_m:ShowHover(v122)
                end)
                v118.MouseEnter:Connect(function() -- line: 783
                    -- upvalues:
                    --  [1] v118 (copy)
                    --  [2] pickerTip (ref)
                    --  [3] val_19 (copy)
                    --  [4] v35 (ref)
                    --  [5] BackpackUtils_m (ref)

                    local v123 = v118
                    local v124 = pickerTip(val_19)
                    v35 = v123
                    BackpackUtils_m:ShowHover(v124)
                end)
                v118.MouseLeave:Connect(function() -- line: 786
                    -- upvalues:
                    --  [1] v118 (copy)
                    --  [2] v35 (ref)
                    --  [3] BackpackUtils_m (ref)

                    local v125 = v118

                    if v35 ~= nil and (v125 == nil or v35 == v125) then
                        v35 = nil
                        BackpackUtils_m:HideHover()
                    end
                end)
                styleToggle(v116, val_19)
                v116.Parent = Materials
                t_17[val_19] = v116
            end

            if Craftsettings_1.Marks and Craftsettings_1.Marks > 0 then
                local v126 = Templates.MaterialRow:Clone()
                v126.Name = "_Marks"
                v126.LayoutOrder = #t_36 + 1
                v126.Label.Text = "Marks"
                local Icon = v126.Icon
                local v127 = Icon:FindFirstChild("Holder") or Icon

                for _, child_6 in v127:GetChildren() do
                    child_6:Destroy()
                end

                local TextLabel_2 = Instance.new("TextLabel")
                TextLabel_2.BackgroundTransparency = 1
                TextLabel_2.Text = "M"
                TextLabel_2.TextColor3 = t.ACCENT
                TextLabel_2.TextScaled = true
                TextLabel_2.FontFace = Font.new(
                    "rbxasset://fonts/families/Balthazar.json",
                    Enum.FontWeight.Bold
                )
                TextLabel_2.Size = UDim2.fromScale(1, 1)
                TextLabel_2.ZIndex = v127.ZIndex + 1
                TextLabel_2.Parent = v127
                v126.Parent = Materials
                t_17._Marks = v126
            end

            refreshMaterialRows(arg57)
        end

        local function requirementsText(arg58) -- line: 807
            -- upvalues:
            --  [1] Professions_m (copy)
            --  [2] Professions (copy)
            --  [3] BackpackUtils_m (copy)

            local v128, v129 = Professions_m:GetCraftRequirement(arg58)
            local v130 = Professions:FindFirstChild(v128)
            local v132 = if v129 <= (v130 and v130.Value or 1) then "rgb(212, 255, 155)" else "rgb(255, 94, 97)"
            local t_37 = {
                `Requirements to craft: <i><font color='{v132}'>{v128} Level {v129}</font></i>`
            }
            v132 = BackpackUtils_m.getRequirements(arg58.Required)

            if v132 ~= "" then
                table.insert(t_37, `Requirements to equip: <i>{v132}</i>`)
            end

            local t_38 = {}

            for key_31, val_20 in arg58 do
                local v134 = nil
                v134 = if key_31 ~= "_stats" then if key_31 ~= "_attributes" then v134 else val_20.Base else val_20

                if v134 then
                    for key_32, val_21 in v134 do
                        table.insert(t_38, BackpackUtils_m.getAttrib(key_32 .. " " .. val_21))
                    end
                end

                for key_33, val_22 in BackpackUtils_m.validAttributes do
                    if key_31 == key_33 then
                        if val_22:sub(-1) == " " then
                            table.insert(t_38, val_22 .. val_20)
                        elseif val_22:sub(1, 1) == " " then
                            table.insert(t_38, val_20 .. val_22)
                        else
                            table.insert(t_38, val_22 .. val_20)
                        end
                    end
                end
            end

            if #t_38 > 0 then
                local v135 = table.concat(t_38, ", ")
                table.insert(t_37, `Item stats: <i>{v135}</i>`)
            end

            return table.concat(t_37, "\n")
        end

        local _ = function(arg59) --[[ setCraftQuantityVisible ]] -- line: 849
            -- upvalues:
            --  [1] Quantity (copy)

            Quantity.Visible = arg59
        end

        local function getBulkUnlockLevel() -- line: 857
            -- upvalues:
            --  [1] Professions_m (copy)

            local Crafting_3 = Professions_m:GetProfessions().Crafting
            local v137 = nil

            for key_34, val_23 in Crafting_3 and Crafting_3.Skills or {} do
                v137 = if not val_23.Attributes then v137 else if not ((val_23.Attributes.bulk_craft or 0) > 0) then v137 else if not v137 then key_34 else if not (v137 > key_34) then v137 else key_34
            end

            return v137
        end

        local t_39 = {}
        do
            local function remember(arg60, arg61) -- line: 871
                -- upvalues:
                --  [1] t_39 (copy)

                local v139 = t_39[arg60]

                if not v139 then
                    v139 = {}
                    t_39[arg60] = v139
                end

                for _, val_24 in arg61 do
                    if v139[val_24] == nil then
                        v139[val_24] = arg60[val_24]
                    end
                end
            end

            local Label_2 = Quantity.Max.Label
            local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
            UITextSizeConstraint.MaxTextSize = 16

            local _ = function() --[[ isBulkLocked ]] -- line: 889
                -- upvalues:
                --  [1] Professions_m (copy)
                --  [2] v3 (copy)

                local v140 = math.floor(
                    Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0
                )

                return math.max(1, v140) <= 1 and true
            end

            local function applyBulkLock() -- line: 893
                -- upvalues:
                --  [1] Professions_m (copy)
                --  [2] v3 (copy)
                --  [3] Quantity (copy)
                --  [4] remember (copy)
                --  [5] t_39 (copy)
                --  [6] Label_2 (copy)
                --  [7] getBulkUnlockLevel (copy)
                --  [8] UITextSizeConstraint (copy)

                local v142 = math.floor(
                    Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0
                )
                local v143 = math.max(1, v142) <= 1 and true

                for _, val_25 in { Quantity.Minus, Quantity.Plus, Quantity.Max } do
                    remember(val_25, { "BackgroundTransparency", "AutoButtonColor" })
                    remember(val_25.Label, { "TextTransparency" })
                    val_25.Active = not v143
                    local v144 = not v143 and t_39[val_25].AutoButtonColor
                    val_25.AutoButtonColor = v144
                    v144 = if not v143 then t_39[val_25].BackgroundTransparency else 0.65
                    val_25.BackgroundTransparency = v144
                    val_25.Label.TextTransparency = if not v143 then t_39[val_25.Label].TextTransparency else 0.35
                end

                local CountFrame = Quantity.CountFrame
                remember(CountFrame, { "BackgroundTransparency" })
                remember(CountFrame.CountBox, { "TextTransparency" })
                CountFrame.BackgroundTransparency = if not v143 then t_39[CountFrame].BackgroundTransparency else 0.65
                CountFrame.CountBox.TextTransparency = if not v143 then t_39[CountFrame.CountBox].TextTransparency else 0.5
                CountFrame.CountBox.TextEditable = not v143
                remember(Label_2, { "Text", "TextScaled" })

                if v143 then
                    local v148 = getBulkUnlockLevel()
                    local v149 = Label_2
                    v149.Text = v148 and `Bulk crafting unlocks at Crafting Lv. {v148}` or "Bulk crafting locked"
                    Label_2.TextScaled = true
                    UITextSizeConstraint.Parent = Label_2

                    return
                end

                Label_2.Text = t_39[Label_2].Text
                Label_2.TextScaled = t_39[Label_2].TextScaled
                UITextSizeConstraint.Parent = nil
            end

            task.spawn(function() -- line: 926
                -- upvalues:
                --  [1] Professions (copy)
                --  [2] Quantity (copy)
                --  [3] applyBulkLock (copy)

                local Crafting_4 = Professions:WaitForChild("Crafting", 30)

                if Crafting_4 and Crafting_4:IsA("ValueBase") then
                    Crafting_4.Changed:Connect(function() -- line: 929
                        -- upvalues:
                        --  [1] Quantity (ref)
                        --  [2] applyBulkLock (ref)

                        if Quantity.Visible then
                            applyBulkLock()
                        end
                    end)
                end
            end)

            local function refreshCraftAction() -- line: 937
                -- upvalues:
                --  [1] v54 (ref)
                --  [2] Action (copy)
                --  [3] t (copy)
                --  [4] v55 (ref)
                --  [5] Professions_m (copy)
                --  [6] Professions (copy)
                --  [7] affordableCount (copy)
                --  [8] styleGoldButton (copy)

                local v151 = v54

                if not v151 then
                    return
                end

                if v151.Kind == "Schematic" then
                    local Label_3 = Action:FindFirstChild("Label")

                    if Label_3 then
                        Label_3.Text = "LEARN"
                    end

                    local v152 = Action
                    local SelectedOutline_3 = v152:FindFirstChild("SelectedOutline")
                    local Label_4 = v152:FindFirstChild("Label")

                    if SelectedOutline_3 then
                        SelectedOutline_3.Visible = true
                    end

                    v152.BackgroundColor3 = t.BUTTON_ON

                    if Label_4 then
                        Label_4.TextColor3 = t.TEXT
                    end

                    return
                end

                local v153 = Action
                local v154 = v55 > 1 and `CRAFT x{v55}` or "CRAFT"
                local Label_5 = v153:FindFirstChild("Label")

                if Label_5 then
                    Label_5.Text = v154
                end

                local v155 = nil
                local v156 = Professions:FindFirstChild(
                    Professions_m:GetCraftRequirement(v151.Info)
                )
                v155 = if not (v155 <= (v156 and v156.Value or 1) and true and affordableCount(
                    v151.Info
                ) >= v55) then "disabled" else nil
                styleGoldButton(Action, v155)
            end

            local _ = function() --[[ refreshCraftDetails ]] -- line: 952
                -- upvalues:
                --  [1] v54 (ref)
                --  [2] refreshMaterialRows (copy)
                --  [3] renderLines (ref)
                --  [4] Scroll (copy)
                --  [5] qualityLines (copy)
                --  [6] requirementsText (copy)
                --  [7] refreshCraftAction (copy)

                local v159 = v54

                if not v159 or v159.Kind ~= "Recipe" then
                    return
                end

                refreshMaterialRows(v159.Info)
                renderLines(Scroll.Quality, (qualityLines(v159.Info)))
                Scroll.Requirements.Text = requirementsText(v159.Info)
                refreshCraftAction()
            end

            local function showCraftDetails(arg62) -- line: 963
                -- upvalues:
                --  [1] Details (copy)
                --  [2] v6 (copy)
                --  [3] t_17 (copy)
                --  [4] setIcon (copy)
                --  [5] Scroll (copy)
                --  [6] Quantity (copy)
                --  [7] refreshCraftAction (copy)
                --  [8] Professions_m (copy)
                --  [9] t_11 (copy)
                --  [10] applyBulkLock (copy)
                --  [11] v55 (ref)
                --  [12] v3 (copy)
                --  [13] buildMaterialRows (copy)
                --  [14] v54 (ref)
                --  [15] refreshMaterialRows (copy)
                --  [16] renderLines (ref)
                --  [17] qualityLines (copy)
                --  [18] requirementsText (copy)

                local Empty_2 = Details.Empty
                Empty_2.Visible = arg62 == nil
                local v162 = v6
                v162.Visible = arg62 ~= nil

                for _, val_26 in t_17 do
                    val_26:Destroy()
                end

                table.clear(t_17)

                if not arg62 then
                    return
                end

                local Info = arg62.Info
                v6.ItemName.Text = arg62.Display
                setIcon(v6.IconBox, arg62.IconName, true)

                if arg62.Kind == "Schematic" then
                    v6.SubInfo.Text = "<font color='rgb(255, 190, 124)'>Unlearned schematic</font>"
                    Scroll.Description.Text = Info.Desc or ""
                    Scroll.Requirements.Text = `Learn this schematic to add <b>{arg62.Display}</b> to your recipes. The schematic is used up.`
                    Scroll.QualityHeader.Visible = false
                    Scroll.Quality.Visible = false
                    Quantity.Visible = false
                    refreshCraftAction()

                    return
                end

                local v163 = nil
                local v164 = t_11[Info.Type]
                local v165 = Professions_m:GetCraftRequirement(Info)
                local SubInfo = v6.SubInfo

                if not v164 then
                    v164 = Info.Type or "Other"
                end

                SubInfo.Text = `{v164}  \226\128\162  {v165} Level {v163}`
                Scroll.Description.Text = Info.Desc or ""
                Scroll.QualityHeader.Visible = true
                Scroll.Quality.Visible = true
                Quantity.Visible = true
                applyBulkLock()
                local v169 = math.min(
                    v55,
                    (math.max(
                        1,
                        (math.floor(Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0))
                    ))
                )
                local v171 = math.max(
                    1,
                    (math.floor(Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0))
                )
                v55 = math.clamp(math.floor(tonumber(v169) or 1), 1, v171)
                Quantity.CountFrame.CountBox.Text = tostring(v55)
                buildMaterialRows(Info)
                local v173 = v54

                if v173 then
                    if v173.Kind ~= "Recipe" then
                        return
                    end

                    refreshMaterialRows(v173.Info)
                    renderLines(Scroll.Quality, (qualityLines(v173.Info)))
                    Scroll.Requirements.Text = requirementsText(v173.Info)
                    refreshCraftAction()
                end
            end

            local function styleRow(arg63) -- line: 998
                -- upvalues:
                --  [1] v54 (ref)
                --  [2] t (copy)
                --  [3] Professions_m (copy)
                --  [4] Professions (copy)
                --  [5] affordableCount (copy)

                local Row = arg63.Row

                if not Row then
                    return
                end

                local v175 = arg63 == v54
                local SelectedOutline_4 = Row:FindFirstChild("SelectedOutline")

                if SelectedOutline_4 then
                    SelectedOutline_4.Visible = v175
                end

                Row.BackgroundColor3 = v175 and t.BUTTON_ON or t.BUTTON

                if arg63.Kind == "Schematic" then
                    Row.Sub.Text = "<font color='rgb(255, 190, 124)'>Unlearned schematic</font>"

                    return
                end

                local v177, v178 = Professions_m:GetCraftRequirement(arg63.Info)
                local v179, v180 = Professions_m:GetCraftRequirement(arg63.Info)
                local v181 = Professions:FindFirstChild(v179)
                v179 = v181 and v181.Value or 1

                if not (if not (v180 <= v179) then false else true) then
                    Row.Sub.Text = `<font color='rgb(255, 94, 97)'>Needs {v177} Level {v178}</font>`

                    return
                end

                if affordableCount(arg63.Info) > 0 then
                    Row.Sub.Text = "<font color='rgb(212, 255, 155)'>Ready to craft</font>"

                    return
                end

                Row.Sub.Text = `{v177} Level {v178}`
            end

            local function entryMatches(arg64) -- line: 1019
                -- upvalues:
                --  [1] v51 (ref)
                --  [2] Box (copy)
                --  [3] v53 (ref)
                --  [4] Professions_m (copy)
                --  [5] Professions (copy)
                --  [6] affordableCount (copy)

                if v51 ~= "All" and arg64.Group ~= v51 then
                    return false
                end

                local v182 = string.lower(Box.Text or "")

                if v182 ~= "" then
                    if not string.find(string.lower(arg64.Display), v182, 1, true) then
                        return false
                    end
                end

                if v53 and arg64.Kind ~= "Schematic" then
                    local v183 = false

                    if arg64.Kind == "Recipe" then
                        local v184, v185 = Professions_m:GetCraftRequirement(arg64.Info)
                        local v186 = Professions:FindFirstChild(v184)
                        v184 = v186 and v186.Value or 1
                        v183 = v185 <= v184 and true and affordableCount(arg64.Info) > 0
                    end

                    if not v183 then
                        return false
                    end
                else
                    return true
                end
            end

            local _ = function(arg65) --[[ sortEntries ]] -- line: 1033
                -- upvalues:
                --  [1] v52 (ref)
                --  [2] t_12 (copy)

                table.sort(arg65, function(arg66, arg67) -- line: 1034
                    -- upvalues:
                    --  [1] v52 (ref)
                    --  [2] t_12 (ref)

                    local v187 = arg66.Kind == "Schematic"

                    if v187 ~= (if arg67.Kind ~= "Schematic" then false else true) then
                        v187 = arg66.Kind == "Schematic"

                        return v187
                    end

                    if v52 == "Level" and arg66.Level ~= arg67.Level then
                        return arg66.Level < arg67.Level
                    end

                    local v190

                    if v52 == "Default" then
                        v190 = t_12[arg66.Group] or 50
                        local v191 = t_12[arg67.Group] or 50
                        local v192

                        if v190 ~= v191 then
                            v192 = v190 < v191

                            return v192
                        end

                        if arg66.Level ~= arg67.Level then
                            v192 = arg66.Level < arg67.Level

                            return v192
                        end
                    end

                    v190 = arg66.Display < arg67.Display

                    return v190
                end)
            end

            local _ = function(arg68, arg69) --[[ styleCategory ]] -- line: 1053
                -- upvalues:
                --  [1] t (copy)

                local SelectedOutline_5 = arg68:FindFirstChild("SelectedOutline")

                if SelectedOutline_5 then
                    SelectedOutline_5.Visible = arg69
                end

                arg68.BackgroundColor3 = arg69 and t.BUTTON_ON or t.BUTTON
                arg68.Label.TextColor3 = arg69 and t.TEXT or t.TEXT_DIM
                arg68.Count.TextColor3 = arg69 and t.ACCENT or t.TEXT_DIM
            end

            local function refreshCategoryCounts() -- line: 1059
                -- upvalues:
                --  [1] t_14 (copy)
                --  [2] t_15 (copy)
                --  [3] v51 (ref)
                --  [4] t (copy)

                local t_40 = { All = 0 }

                for _, val_27 in t_14 do
                    t_40.All += 1
                    t_40[val_27.Group] = (t_40[val_27.Group] or 0) + 1
                end

                local v194

                for key_39, val_28 in t_15 do
                    v194 = t_40[key_39] or 0
                    val_28.Count.Text = tostring(v194)
                    val_28.Visible = if key_39 ~= "All" then v194 > 0 else true
                end

                if v51 ~= "All" and (t_40[v51] or 0) == 0 then
                    v51 = "All"

                    for key_40, val_29 in t_15 do
                        v194 = key_40 == "All"
                        local SelectedOutline_6 = val_29:FindFirstChild("SelectedOutline")

                        if SelectedOutline_6 then
                            SelectedOutline_6.Visible = v194
                        end

                        val_29.BackgroundColor3 = v194 and t.BUTTON_ON or t.BUTTON
                        val_29.Label.TextColor3 = v194 and t.TEXT or t.TEXT_DIM
                        val_29.Count.TextColor3 = v194 and t.ACCENT or t.TEXT_DIM
                    end
                end
            end

            local v197 = nil

            local function ensureCategory(arg70, arg71) -- line: 1083
                -- upvalues:
                --  [1] t_15 (copy)
                --  [2] Templates (copy)
                --  [3] t_12 (copy)
                --  [4] setImageIcon (copy)
                --  [5] t_13 (copy)
                --  [6] setIcon (copy)
                --  [7] v51 (ref)
                --  [8] t (copy)
                --  [9] v197 (ref)
                --  [10] List (copy)

                local v198 = t_15[arg70]

                if v198 then
                    return v198
                end

                local v199 = Templates.CategoryButton:Clone()
                v199.Name = arg70
                v199.LayoutOrder = t_12[arg70] or 50
                v199.Label.Text = arg70

                if arg70 == "All" then
                    setImageIcon(v199.Icon, "rbxassetid://97114246738130")
                elseif t_13[arg70] then
                    setImageIcon(v199.Icon, t_13[arg70])
                elseif arg71 then
                    setIcon(v199.Icon, arg71, true)
                end

                v199.MouseButton1Click:Connect(function() -- line: 1099
                    -- upvalues:
                    --  [1] v51 (ref)
                    --  [2] arg70 (copy)
                    --  [3] t_15 (ref)
                    --  [4] t (ref)
                    --  [5] v197 (ref)

                    v51 = arg70

                    for key_41, val_30 in t_15 do
                        local v200 = key_41 == arg70
                        local SelectedOutline_7 = val_30:FindFirstChild("SelectedOutline")

                        if SelectedOutline_7 then
                            SelectedOutline_7.Visible = v200
                        end

                        val_30.BackgroundColor3 = v200 and t.BUTTON_ON or t.BUTTON
                        val_30.Label.TextColor3 = v200 and t.TEXT or t.TEXT_DIM
                        val_30.Count.TextColor3 = v200 and t.ACCENT or t.TEXT_DIM
                    end

                    v197()
                end)
                local v202 = if arg70 ~= v51 then false else true
                local SelectedOutline_8 = v199:FindFirstChild("SelectedOutline")

                if SelectedOutline_8 then
                    SelectedOutline_8.Visible = v202
                end

                v199.BackgroundColor3 = v202 and t.BUTTON_ON or t.BUTTON
                v199.Label.TextColor3 = v202 and t.TEXT or t.TEXT_DIM
                v199.Count.TextColor3 = v202 and t.ACCENT or t.TEXT_DIM
                v199.Parent = List
                t_15[arg70] = v199

                return v199
            end

            local function selectEntry(arg72) -- line: 1112
                -- upvalues:
                --  [1] v54 (ref)
                --  [2] styleRow (copy)
                --  [3] showCraftDetails (copy)

                local v204 = v54
                v54 = arg72

                if v204 then
                    styleRow(v204)
                end

                if arg72 then
                    styleRow(arg72)
                end

                showCraftDetails(arg72)
            end

            function v197() --[[ refreshList ]] -- line: 1124
                -- upvalues:
                --  [1] t_14 (copy)
                --  [2] entryMatches (copy)
                --  [3] v52 (ref)
                --  [4] t_12 (copy)
                --  [5] Empty_1 (copy)
                --  [6] v53 (ref)

                local t_41 = {}

                for _, val_31 in t_14 do
                    local v205 = entryMatches(val_31)
                    val_31.Row.Visible = v205

                    if v205 then
                        table.insert(t_41, val_31)
                    end
                end

                table.sort(t_41, function(arg73, arg74) -- line: 1034
                    -- upvalues:
                    --  [1] v52 (ref)
                    --  [2] t_12 (ref)

                    local v206 = arg73.Kind == "Schematic"

                    if v206 ~= (if arg74.Kind ~= "Schematic" then false else true) then
                        v206 = arg73.Kind == "Schematic"

                        return v206
                    end

                    if v52 == "Level" and arg73.Level ~= arg74.Level then
                        return arg73.Level < arg74.Level
                    end

                    local v209

                    if v52 == "Default" then
                        v209 = t_12[arg73.Group] or 50
                        local v210 = t_12[arg74.Group] or 50
                        local v211

                        if v209 ~= v210 then
                            v211 = v209 < v210

                            return v211
                        end

                        if arg73.Level ~= arg74.Level then
                            v211 = arg73.Level < arg74.Level

                            return v211
                        end
                    end

                    v209 = arg73.Display < arg74.Display

                    return v209
                end)

                for key_43, val_32 in t_41 do
                    val_32.Row.LayoutOrder = key_43
                end

                Empty_1.Visible = #t_41 == 0

                if next(t_14) == nil then
                    Empty_1.Text = "You don't know any recipes yet."

                    return
                end

                if v53 then
                    Empty_1.Text = "Nothing here you can craft right now."

                    return
                end

                Empty_1.Text = "No recipes match."
            end

            local v213 = false

            local _ = function() --[[ queueListRefresh ]] -- line: 1148
                -- upvalues:
                --  [1] v213 (ref)
                --  [2] refreshCategoryCounts (copy)
                --  [3] v197 (ref)

                if v213 then
                    return
                end

                v213 = true
                task.delay(0.05, function() -- line: 1153
                    -- upvalues:
                    --  [1] v213 (ref)
                    --  [2] refreshCategoryCounts (ref)
                    --  [3] v197 (ref)

                    v213 = false
                    refreshCategoryCounts()
                    v197()
                end)
            end

            local _ = function(arg75) --[[ removeEntry ]] -- line: 1160
                -- upvalues:
                --  [1] t_14 (copy)
                --  [2] v54 (ref)
                --  [3] styleRow (copy)
                --  [4] Details (copy)
                --  [5] v6 (copy)
                --  [6] t_17 (copy)
                --  [7] v213 (ref)
                --  [8] refreshCategoryCounts (copy)
                --  [9] v197 (ref)

                local v214 = t_14[arg75]

                if not v214 then
                    return
                end

                t_14[arg75] = nil
                local Row_1 = v214.Row
                v214.Row = nil

                if v54 == v214 then
                    local v215 = v54
                    v54 = nil

                    if v215 then
                        styleRow(v215)
                    end

                    Details.Empty.Visible = true
                    v6.Visible = false

                    for _, val_33 in t_17 do
                        val_33:Destroy()
                    end

                    table.clear(t_17)
                end

                if Row_1 then
                    Row_1:Destroy()
                end

                if v213 then
                    return
                end

                v213 = true
                task.delay(0.05, function() -- line: 1153
                    -- upvalues:
                    --  [1] v213 (ref)
                    --  [2] refreshCategoryCounts (ref)
                    --  [3] v197 (ref)

                    v213 = false
                    refreshCategoryCounts()
                    v197()
                end)
            end

            local function addEntry(arg76) -- line: 1179
                -- upvalues:
                --  [1] t_14 (copy)
                --  [2] Templates (copy)
                --  [3] setIcon (copy)
                --  [4] v54 (ref)
                --  [5] styleRow (copy)
                --  [6] Details (copy)
                --  [7] v6 (copy)
                --  [8] t_17 (copy)
                --  [9] showCraftDetails (copy)
                --  [10] ensureCategory (copy)
                --  [11] List_1 (copy)
                --  [12] v213 (ref)
                --  [13] refreshCategoryCounts (copy)
                --  [14] v197 (ref)

                if t_14[arg76.Key] then
                    return
                end

                local v216 = Templates.ItemRow:Clone()
                v216.Name = arg76.Key
                v216.Label.Text = arg76.Display
                setIcon(v216.Icon, arg76.IconName, true)
                v216.MouseButton1Click:Connect(function() -- line: 1187
                    -- upvalues:
                    --  [1] v54 (ref)
                    --  [2] arg76 (copy)
                    --  [3] styleRow (ref)
                    --  [4] Details (ref)
                    --  [5] v6 (ref)
                    --  [6] t_17 (ref)
                    --  [7] showCraftDetails (ref)

                    if v54 == arg76 then
                        local v217 = v54
                        v54 = nil

                        if v217 then
                            styleRow(v217)
                        end

                        Details.Empty.Visible = true
                        v6.Visible = false

                        for _, val_34 in t_17 do
                            val_34:Destroy()
                        end

                        table.clear(t_17)

                        return
                    end

                    local v218 = arg76
                    local v219 = v54
                    v54 = v218

                    if v219 then
                        styleRow(v219)
                    end

                    if v218 then
                        styleRow(v218)
                    end

                    showCraftDetails(v218)
                end)
                arg76.Row = v216
                t_14[arg76.Key] = arg76
                ensureCategory(arg76.Group, arg76.IconName)
                styleRow(arg76)
                v216.Parent = List_1

                if v213 then
                    return
                end

                v213 = true
                task.delay(0.05, function() -- line: 1153
                    -- upvalues:
                    --  [1] v213 (ref)
                    --  [2] refreshCategoryCounts (ref)
                    --  [3] v197 (ref)

                    v213 = false
                    refreshCategoryCounts()
                    v197()
                end)
            end

            local function onRecipeAdded(arg77) -- line: 1202
                -- upvalues:
                --  [1] Items_m (copy)
                --  [2] t_14 (copy)
                --  [3] v54 (ref)
                --  [4] styleRow (copy)
                --  [5] Details (copy)
                --  [6] v6 (copy)
                --  [7] t_17 (copy)
                --  [8] v213 (ref)
                --  [9] refreshCategoryCounts (copy)
                --  [10] v197 (ref)
                --  [11] addEntry (copy)
                --  [12] t_11 (copy)
                --  [13] getRequirement (copy)
                --  [14] v51 (ref)
                --  [15] t_15 (copy)
                --  [16] t (copy)
                --  [17] Box (copy)
                --  [18] showCraftDetails (copy)

                local Name = arg77.Name
                local v220 = Items_m.AllItems[Name]
                local v221 = v220

                if type(v220) ~= "table" or not v221 then
                    v221 = nil
                end

                if not v221 or not v221._craftsettings then
                    return
                end

                for key_46, val_35 in t_14 do
                    if val_35.Kind == "Schematic" and val_35.Info.BlueprintItem == Name then
                        local v222 = t_14[key_46]

                        if v222 then
                            t_14[key_46] = nil
                            local Row_2 = v222.Row
                            v222.Row = nil

                            if v54 == v222 then
                                local v223 = v54
                                v54 = nil

                                if v223 then
                                    styleRow(v223)
                                end

                                Details.Empty.Visible = true
                                v6.Visible = false

                                for _, val_36 in t_17 do
                                    val_36:Destroy()
                                end

                                table.clear(t_17)
                            end

                            if Row_2 then
                                Row_2:Destroy()
                            end

                            if not v213 then
                                v213 = true
                                task.delay(0.05, function() -- line: 1153
                                    -- upvalues:
                                    --  [1] v213 (ref)
                                    --  [2] refreshCategoryCounts (ref)
                                    --  [3] v197 (ref)

                                    v213 = false
                                    refreshCategoryCounts()
                                    v197()
                                end)
                            end
                        end
                    end
                end

                local v224 = addEntry
                local t_42 = {
                    Key = Name,
                    Kind = "Recipe",
                    Display = Name,
                    IconName = Name,
                    Info = v221,
                    Group = nil,
                    Level = nil
                }
                local v225 = t_11[v221.Type] or (v221.Type or "Other")
                t_42.Group = v225
                t_42.Level = select(2, getRequirement(v221))
                v224(t_42)

                if script:GetAttribute("PendingLearn") == Name and t_14[Name] then
                    script:SetAttribute("PendingLearn", nil)
                    v51 = "All"

                    for key_48, val_37 in t_15 do
                        local v226 = key_48 == "All"
                        v221 = val_37:FindFirstChild("SelectedOutline")

                        if v221 then
                            v221.Visible = v226
                        end

                        val_37.BackgroundColor3 = v226 and t.BUTTON_ON or t.BUTTON
                        val_37.Label.TextColor3 = v226 and t.TEXT or t.TEXT_DIM
                        val_37.Count.TextColor3 = v226 and t.ACCENT or t.TEXT_DIM
                    end

                    local v229 = string.lower(Box.Text or "")

                    if v229 ~= "" then
                        if not string.find(string.lower(Name), v229, 1, true) then
                            Box.Text = ""
                        end
                    end

                    local v230 = t_14[Name]
                    local v231 = v54
                    v54 = v230

                    if v231 then
                        styleRow(v231)
                    end

                    if v230 then
                        styleRow(v230)
                    end

                    showCraftDetails(v230)

                    if not v213 then
                        v213 = true
                        task.delay(0.05, function() -- line: 1153
                            -- upvalues:
                            --  [1] v213 (ref)
                            --  [2] refreshCategoryCounts (ref)
                            --  [3] v197 (ref)

                            v213 = false
                            refreshCategoryCounts()
                            v197()
                        end)
                    end
                end

                arg77.AncestryChanged:Connect(function(_, arg79) -- line: 1238
                    -- upvalues:
                    --  [1] Name (copy)
                    --  [2] t_14 (ref)
                    --  [3] v54 (ref)
                    --  [4] styleRow (ref)
                    --  [5] Details (ref)
                    --  [6] v6 (ref)
                    --  [7] t_17 (ref)
                    --  [8] v213 (ref)
                    --  [9] refreshCategoryCounts (ref)
                    --  [10] v197 (ref)

                    if not arg79 then
                        local v232 = Name
                        local v233 = t_14[v232]

                        if not v233 then
                            return
                        end

                        t_14[v232] = nil
                        local Row_3 = v233.Row
                        v233.Row = nil

                        if v54 == v233 then
                            local v234 = v54
                            v54 = nil

                            if v234 then
                                styleRow(v234)
                            end

                            Details.Empty.Visible = true
                            v6.Visible = false

                            for _, val_38 in t_17 do
                                val_38:Destroy()
                            end

                            table.clear(t_17)
                        end

                        if Row_3 then
                            Row_3:Destroy()
                        end

                        if v213 then
                            return
                        end

                        v213 = true
                        task.delay(0.05, function() -- line: 1153
                            -- upvalues:
                            --  [1] v213 (ref)
                            --  [2] refreshCategoryCounts (ref)
                            --  [3] v197 (ref)

                            v213 = false
                            refreshCategoryCounts()
                            v197()
                        end)
                    end
                end)
            end

            local function onInventorySchematic(arg80) -- line: 1245
                -- upvalues:
                --  [1] Items_m (copy)
                --  [2] Schematics (copy)
                --  [3] addEntry (copy)
                --  [4] t_14 (copy)
                --  [5] v54 (ref)
                --  [6] styleRow (copy)
                --  [7] Details (copy)
                --  [8] v6 (copy)
                --  [9] t_17 (copy)
                --  [10] v213 (ref)
                --  [11] refreshCategoryCounts (copy)
                --  [12] v197 (ref)

                local Name_1 = arg80.Name
                local v235 = Items_m.AllItems[Name_1]
                local v236 = v235

                if type(v235) ~= "table" or not v236 then
                    v236 = nil
                end

                if not v236 or v236.Type ~= "Schematic" or not v236.BlueprintItem then
                    return
                end

                if Schematics:FindFirstChild(v236.BlueprintItem) then
                    return
                end

                local v237 = "Schematic:" .. Name_1
                addEntry(
                    {
                        Key = v237,
                        Kind = "Schematic",
                        Display = v236.BlueprintItem,
                        IconName = Name_1,
                        Info = v236,
                        Group = "Schematics",
                        Level = 0,
                        ContainerName = Name_1
                    }
                )
                arg80.AncestryChanged:Connect(function(_, arg82) -- line: 1265
                    -- upvalues:
                    --  [1] v237 (copy)
                    --  [2] t_14 (ref)
                    --  [3] v54 (ref)
                    --  [4] styleRow (ref)
                    --  [5] Details (ref)
                    --  [6] v6 (ref)
                    --  [7] t_17 (ref)
                    --  [8] v213 (ref)
                    --  [9] refreshCategoryCounts (ref)
                    --  [10] v197 (ref)

                    if not arg82 then
                        local v238 = v237
                        local v239 = t_14[v238]

                        if not v239 then
                            return
                        end

                        t_14[v238] = nil
                        local Row_4 = v239.Row
                        v239.Row = nil

                        if v54 == v239 then
                            local v240 = v54
                            v54 = nil

                            if v240 then
                                styleRow(v240)
                            end

                            Details.Empty.Visible = true
                            v6.Visible = false

                            for _, val_39 in t_17 do
                                val_39:Destroy()
                            end

                            table.clear(t_17)
                        end

                        if Row_4 then
                            Row_4:Destroy()
                        end

                        if v213 then
                            return
                        end

                        v213 = true
                        task.delay(0.05, function() -- line: 1153
                            -- upvalues:
                            --  [1] v213 (ref)
                            --  [2] refreshCategoryCounts (ref)
                            --  [3] v197 (ref)

                            v213 = false
                            refreshCategoryCounts()
                            v197()
                        end)
                    end
                end)
            end

            local t_44 = { Default = "Default", Name = "Name", Level = "Level" }

            local function styleSortMenu() -- line: 1274
                -- upvalues:
                --  [1] Options (copy)
                --  [2] v52 (ref)
                --  [3] t (copy)
                --  [4] v53 (ref)
                --  [5] Sort (copy)
                --  [6] t_44 (copy)

                for _, child_7 in Options:GetChildren() do
                    if child_7:IsA("TextButton") and child_7.Name ~= "CraftableOnly" then
                        child_7.BackgroundTransparency = if child_7.Name ~= v52 then 1 else 0
                        child_7.Label.TextColor3 = if child_7.Name ~= v52 then t.TEXT else t.ACCENT or t.TEXT
                    end
                end

                local CraftableOnly = Options:FindFirstChild("CraftableOnly")
                local v243

                if CraftableOnly then
                    CraftableOnly.Box.Fill.Visible = v53
                    v243 = v53 and t.ACCENT or t.TEXT
                    CraftableOnly.Label.TextColor3 = v243
                end

                v243 = if not v53 then t_44[v52] or v52 else "Craftable"
                Sort.Label.Text = v243
                Sort.SelectedOutline.Visible = v53
            end

            local function setSort(arg83) -- line: 1290
                -- upvalues:
                --  [1] v52 (ref)
                --  [2] styleSortMenu (copy)
                --  [3] SortMenu (copy)
                --  [4] v197 (ref)

                v52 = arg83
                styleSortMenu()
                SortMenu.Visible = false
                v197()
            end

            local _ = function(arg84) --[[ setCraftableOnly ]] -- line: 1297
                -- upvalues:
                --  [1] v53 (ref)
                --  [2] styleSortMenu (copy)
                --  [3] v197 (ref)

                v53 = arg84
                styleSortMenu()
                v197()
            end

            Sort.MouseButton1Click:Connect(function() -- line: 1303
                -- upvalues:
                --  [1] SortMenu (copy)

                SortMenu.Visible = not SortMenu.Visible
            end)

            for _, child_8 in Options:GetChildren() do
                if child_8:IsA("TextButton") then
                    child_8.MouseButton1Click:Connect(function() -- line: 1308
                        -- upvalues:
                        --  [1] child_8 (copy)
                        --  [2] v53 (ref)
                        --  [3] styleSortMenu (copy)
                        --  [4] v197 (ref)
                        --  [5] v52 (ref)
                        --  [6] SortMenu (copy)

                        if child_8.Name == "CraftableOnly" then
                            v53 = not v53
                            styleSortMenu()
                            v197()

                            return
                        end

                        v52 = child_8.Name
                        styleSortMenu()
                        SortMenu.Visible = false
                        v197()
                    end)
                end
            end

            Box:GetPropertyChangedSignal("Text"):Connect(v197)
            Quantity.Minus.MouseButton1Click:Connect(function() -- line: 1320
                -- upvalues:
                --  [1] Professions_m (copy)
                --  [2] v3 (copy)
                --  [3] v55 (ref)
                --  [4] Quantity (copy)
                --  [5] v54 (ref)
                --  [6] refreshMaterialRows (copy)
                --  [7] renderLines (ref)
                --  [8] Scroll (copy)
                --  [9] qualityLines (copy)
                --  [10] requirementsText (copy)
                --  [11] refreshCraftAction (copy)

                local v244 = math.floor(
                    Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0
                )

                if if not (math.max(1, v244) <= 1) then false else true then
                    return
                end

                local v245 = v55 - 1
                local v247 = math.max(
                    1,
                    (math.floor(Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0))
                )
                v55 = math.clamp(math.floor(tonumber(v245) or 1), 1, v247)
                Quantity.CountFrame.CountBox.Text = tostring(v55)
                local v249 = v54

                if v249 then
                    if v249.Kind ~= "Recipe" then
                        return
                    end

                    refreshMaterialRows(v249.Info)
                    renderLines(Scroll.Quality, (qualityLines(v249.Info)))
                    Scroll.Requirements.Text = requirementsText(v249.Info)
                    refreshCraftAction()
                end
            end)
            Quantity.Plus.MouseButton1Click:Connect(function() -- line: 1327
                -- upvalues:
                --  [1] Professions_m (copy)
                --  [2] v3 (copy)
                --  [3] v55 (ref)
                --  [4] Quantity (copy)
                --  [5] v54 (ref)
                --  [6] refreshMaterialRows (copy)
                --  [7] renderLines (ref)
                --  [8] Scroll (copy)
                --  [9] qualityLines (copy)
                --  [10] requirementsText (copy)
                --  [11] refreshCraftAction (copy)

                local v251 = math.floor(
                    Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0
                )

                if if not (math.max(1, v251) <= 1) then false else true then
                    return
                end

                local v252 = v55 + 1
                local v254 = math.max(
                    1,
                    (math.floor(Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0))
                )
                v55 = math.clamp(math.floor(tonumber(v252) or 1), 1, v254)
                Quantity.CountFrame.CountBox.Text = tostring(v55)
                local v256 = v54

                if v256 then
                    if v256.Kind ~= "Recipe" then
                        return
                    end

                    refreshMaterialRows(v256.Info)
                    renderLines(Scroll.Quality, (qualityLines(v256.Info)))
                    Scroll.Requirements.Text = requirementsText(v256.Info)
                    refreshCraftAction()
                end
            end)
            Quantity.Max.MouseButton1Click:Connect(function() -- line: 1334
                -- upvalues:
                --  [1] Professions_m (copy)
                --  [2] v3 (copy)
                --  [3] v54 (ref)
                --  [4] affordableCount (copy)
                --  [5] v55 (ref)
                --  [6] Quantity (copy)
                --  [7] refreshMaterialRows (copy)
                --  [8] renderLines (ref)
                --  [9] Scroll (copy)
                --  [10] qualityLines (copy)
                --  [11] requirementsText (copy)
                --  [12] refreshCraftAction (copy)

                local v258 = math.floor(
                    Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0
                )

                if if not (math.max(1, v258) <= 1) then false else true then
                    return
                end

                local v259 = v54
                local v260 = if not v259 then 1 else if v259.Kind ~= "Recipe" then 1 else affordableCount(
                    v259.Info
                ) or 1
                local v264 = math.max(
                    1,
                    (math.min(
                        v260,
                        (math.max(
                            1,
                            (math.floor(
                                Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0
                            ))
                        ))
                    ))
                )
                local v266 = math.max(
                    1,
                    (math.floor(Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0))
                )
                v55 = math.clamp(math.floor(tonumber(v264) or 1), 1, v266)
                Quantity.CountFrame.CountBox.Text = tostring(v55)
                v260 = v54

                if v260 then
                    if v260.Kind ~= "Recipe" then
                        return
                    end

                    refreshMaterialRows(v260.Info)
                    renderLines(Scroll.Quality, (qualityLines(v260.Info)))
                    Scroll.Requirements.Text = requirementsText(v260.Info)
                    refreshCraftAction()
                end
            end)
            Quantity.CountFrame.CountBox.FocusLost:Connect(function() -- line: 1343
                -- upvalues:
                --  [1] Quantity (copy)
                --  [2] Professions_m (copy)
                --  [3] v3 (copy)
                --  [4] v55 (ref)
                --  [5] v54 (ref)
                --  [6] refreshMaterialRows (copy)
                --  [7] renderLines (ref)
                --  [8] Scroll (copy)
                --  [9] qualityLines (copy)
                --  [10] requirementsText (copy)
                --  [11] refreshCraftAction (copy)

                local Text = Quantity.CountFrame.CountBox.Text
                local v269 = math.floor(
                    Professions_m:GetPlayerBenefits(v3, "Crafting").bulk_craft or 0
                )
                local v270 = math.max(1, v269)
                local v271 = math.floor(tonumber(Text) or 1)
                v55 = math.clamp(v271, 1, v270)
                Quantity.CountFrame.CountBox.Text = tostring(v55)
                local v272 = v54

                if v272 then
                    if v272.Kind ~= "Recipe" then
                        return
                    end

                    refreshMaterialRows(v272.Info)
                    renderLines(Scroll.Quality, (qualityLines(v272.Info)))
                    Scroll.Requirements.Text = requirementsText(v272.Info)
                    refreshCraftAction()
                end
            end)
            Action.MouseButton1Click:Connect(function() -- line: 1348
                -- upvalues:
                --  [1] v54 (ref)
                --  [2] v56 (ref)
                --  [3] CraftRemote (copy)
                --  [4] v55 (ref)
                --  [5] buildPreferenceArg (copy)
                --  [6] refreshMaterialRows (copy)
                --  [7] renderLines (ref)
                --  [8] Scroll (copy)
                --  [9] qualityLines (copy)
                --  [10] requirementsText (copy)
                --  [11] refreshCraftAction (copy)

                local v274 = v54

                if not v274 or v56 then
                    return
                end

                v56 = true

                if v274.Kind == "Schematic" then
                    script:SetAttribute("PendingLearn", v274.Info.BlueprintItem)
                    local Success, Result = pcall(
                        CraftRemote.InvokeServer,
                        CraftRemote,
                        "Learn",
                        v274.ContainerName
                    )

                    if Success then
                        if not Result then
                            script:SetAttribute("PendingLearn", nil)
                        end
                    else
                        script:SetAttribute("PendingLearn", nil)
                    end
                else
                    local v275 = v274.Info._craftsettings.Materials or {}
                    pcall(
                        CraftRemote.InvokeServer,
                        CraftRemote,
                        "Craft",
                        v274.Key,
                        v55,
                        (buildPreferenceArg(v275))
                    )
                end

                v56 = false
                local v279 = v54

                if v279 then
                    if v279.Kind ~= "Recipe" then
                        return
                    end

                    refreshMaterialRows(v279.Info)
                    renderLines(Scroll.Quality, (qualityLines(v279.Info)))
                    Scroll.Requirements.Text = requirementsText(v279.Info)
                    refreshCraftAction()
                end
            end)

            local function styleFilter(arg85, arg86) -- line: 1383
                -- upvalues:
                --  [1] t (copy)

                local v281 = arg85:FindFirstChild("SelectedOutline")

                if v281 then
                    v281.Visible = arg86
                end

                arg85.BackgroundColor3 = arg86 and t.BUTTON_ON or t.BUTTON
                v281 = if arg85.Name ~= "All" then if arg85:GetAttribute("Count") ~= 0 then false else true else false
                arg85.Icon.ImageTransparency = if not v281 then if not arg86 then 0.3 else 0 else 0.75
            end

            local SelectTools = Select.SelectTools
            local Multi = SelectTools.Multi
            local SelectAll = SelectTools.SelectAll
            local Clear = SelectTools.Clear
            local Text_1 = Details_1.Empty.Text
            local v284 = "All"
            local t_45 = {}
            local t_46 = {}
            local t_47 = {}
            local v285 = nil
            local v286 = 0
            local v287 = false
            local v288 = false
            local v289 = false
            local v290 = 0
            local v291 = 1
            local v292 = nil
            local v293 = false
            local t_48 = {}

            local _ = function(arg87) --[[ slotOf ]] -- line: 1411
                if arg87.Type == "Weapon" then
                    return "Weapon"
                end

                return arg87.ArmorType or "Other"
            end

            local _ = function(arg88) --[[ isSmeltable ]] -- line: 1418
                -- upvalues:
                --  [1] SmeltData_m (copy)
                --  [2] Formatter_m (copy)

                return (SmeltData_m.CanSmelt(Formatter_m.formatItem(arg88.Name)))
            end

            local _ = function(arg89, arg90) --[[ isEquipped ]] -- line: 1422
                -- upvalues:
                --  [1] v5 (copy)

                local Name_2 = arg89.Name

                if arg90.ArmorType then
                    if v5:GetStat("Equipped" .. arg90.ArmorType) == Name_2 then
                        return true
                    end
                end

                if arg90.ArmorType then
                    if v5:GetStat(arg90.ArmorType .. "Vanity") == Name_2 then
                        return true
                    end
                end

                return if v5:GetStat("FightingStyle") ~= Name_2 then false else true
            end

            local _ = function(arg91) --[[ isHidden ]] -- line: 1433
                -- upvalues:
                --  [1] Formatter_m (copy)
                --  [2] Items_m (copy)
                --  [3] v5 (copy)

                local v297 = Formatter_m.formatItem(arg91.Name)
                local v298 = Items_m.AllItems[v297]
                local v299 = v298

                if type(v298) ~= "table" or not v299 then
                    v299 = nil
                end

                v297 = true
                local v302

                if v299 ~= nil then
                    local Name_3 = arg91.Name

                    if v299.ArmorType then
                        if v5:GetStat("Equipped" .. v299.ArmorType) == Name_3 then
                            return true
                        end
                    end

                    if v299.ArmorType then
                        if v5:GetStat(v299.ArmorType .. "Vanity") == Name_3 then
                            return true
                        end
                    end

                    v302 = if v5:GetStat("FightingStyle") ~= Name_3 then false else true
                end

                return v302
            end

            local function smeltBatch() -- line: 1438
                -- upvalues:
                --  [1] v285 (ref)
                --  [2] Formatter_m (copy)
                --  [3] Inventory (copy)
                --  [4] Items_m (copy)
                --  [5] v5 (copy)

                local v303 = v285

                if not v303 or not v303.Parent then
                    return {}
                end

                local v304 = Formatter_m.formatItem(v303.Name)
                local t_49 = { v303 }
                local t_50 = {}
                local v310

                for _, child_9 in Inventory:GetChildren() do
                    if child_9 ~= v303 and Formatter_m.formatItem(child_9.Name) == v304 and not child_9:GetAttribute(
                        "Locked"
                    ) then
                        local v306 = Items_m.AllItems[Formatter_m.formatItem(child_9.Name)]
                        local v307 = v306

                        if type(v306) ~= "table" or not v307 then
                            v307 = nil
                        end

                        local v308 = true

                        if v307 ~= nil then
                            local Name_4 = child_9.Name

                            if v307.ArmorType then
                                if v5:GetStat("Equipped" .. v307.ArmorType) == Name_4 then
                                    v308 = true
                                elseif v307.ArmorType then
                                    v310 = v307.ArmorType .. "Vanity"
                                    v308 = v5:GetStat(v310) == Name_4 or (if v5:GetStat(
                                        "FightingStyle"
                                    ) ~= Name_4 then false else true)
                                else
                                    v308 = if v5:GetStat("FightingStyle") ~= Name_4 then false else true
                                end
                            elseif v307.ArmorType then
                                v310 = v307.ArmorType .. "Vanity"
                                v308 = v5:GetStat(v310) == Name_4 or (if v5:GetStat("FightingStyle") ~= Name_4 then false else true)
                            else
                                v308 = if v5:GetStat("FightingStyle") ~= Name_4 then false else true
                            end
                        end

                        if not v308 then
                            table.insert(t_50, child_9)
                        end
                    end
                end

                table.sort(t_50, function(arg92, arg93) -- line: 1451
                    local v311 = arg92:GetAttribute("Quality") or 0
                    local v312 = arg93:GetAttribute("Quality") or 0
                    local v313

                    if v311 ~= v312 then
                        v313 = v311 < v312

                        return v313
                    end

                    v313 = arg92.Name < arg93.Name

                    return v313
                end)

                for _, val_40 in t_50 do
                    table.insert(t_49, val_40)
                end

                return t_49
            end

            local function pickedList() -- line: 1464
                -- upvalues:
                --  [1] t_48 (copy)
                --  [2] t_46 (copy)

                local t_51 = {}

                for key_55 in t_48 do
                    if key_55.Parent and t_46[key_55] then
                        table.insert(t_51, key_55)
                    end
                end

                table.sort(t_51, function(arg94, arg95) -- line: 1471
                    -- upvalues:
                    --  [1] t_46 (ref)

                    return t_46[arg94].LayoutOrder < t_46[arg95].LayoutOrder
                end)

                return t_51
            end

            local _ = function(arg96) --[[ setSmeltCount ]] -- line: 1477
                -- upvalues:
                --  [1] smeltBatch (copy)
                --  [2] v291 (ref)
                --  [3] Quantity_1 (copy)

                local v315 = math.max(1, #smeltBatch())
                local v316 = math.floor(tonumber(arg96) or 1)
                v291 = math.clamp(v316, 1, v315)
                Quantity_1.CountFrame.CountBox.Text = tostring(v291)
                local Note = Quantity_1.Note
                Note.Text = v315 > 1 and `of {v315}` or ""
            end

            local _ = function() --[[ resetConfirm ]] -- line: 1484
                -- upvalues:
                --  [1] v289 (ref)
                --  [2] v290 (ref)

                v289 = false
                v290 += 1
            end

            local function refreshSmeltAction() -- line: 1489
                -- upvalues:
                --  [1] v288 (ref)
                --  [2] Action_1 (copy)
                --  [3] v289 (ref)
                --  [4] t (copy)
                --  [5] v293 (ref)
                --  [6] pickedList (copy)
                --  [7] styleGoldButton (copy)
                --  [8] v291 (ref)
                --  [9] v287 (ref)

                if v288 then
                    local Label_6 = Action_1:FindFirstChild("Label")

                    if Label_6 then
                        Label_6.Text = "..."
                    end

                    return
                end

                if v289 then
                    local Label_7 = Action_1:FindFirstChild("Label")

                    if Label_7 then
                        Label_7.Text = "CONFIRM?"
                    end

                    local v318 = Action_1
                    local SelectedOutline_9 = v318:FindFirstChild("SelectedOutline")
                    local Label_8 = v318:FindFirstChild("Label")

                    if SelectedOutline_9 then
                        SelectedOutline_9.Visible = true
                    end

                    v318.BackgroundColor3 = t.CONFIRM

                    if Label_8 then
                        Label_8.TextColor3 = t.TEXT
                    end

                    return
                end

                if v293 then
                    local v319 = #pickedList()
                    local v320 = Action_1
                    local v322

                    if v319 > 0 then
                        local v321 = if v319 ~= 1 then "S" else ""
                        v322 = `SMELT {v319} ITEM{v321}` or "SMELT"
                    else
                        v322 = "SMELT"
                    end

                    local v323 = v320:FindFirstChild("Label")

                    if v323 then
                        v323.Text = v322
                    end

                    v323 = if not (v319 > 0) then "disabled" else nil
                    styleGoldButton(Action_1, v323)

                    return
                end

                local v324 = Action_1
                local v325 = v291 > 1 and `SMELT x{v291}` or "SMELT"
                local v326 = v324:FindFirstChild("Label")

                if v326 then
                    v326.Text = v325
                end

                v326 = if not v287 then "disabled" else nil
                styleGoldButton(Action_1, v326)
            end

            local function oddsLines(arg97) -- line: 1509
                -- upvalues:
                --  [1] Professions_m (copy)

                local t_52 = {}

                for key_56 in arg97 do
                    table.insert(t_52, key_56)
                end

                table.sort(t_52, function(arg98, arg99) -- line: 1514
                    -- upvalues:
                    --  [1] arg97 (copy)

                    return arg97[arg98] > arg97[arg99] or (if arg97[arg98] ~= arg97[arg99] then false else arg98 < arg99)
                end)
                local t_53 = {}

                for _, val_41 in t_52 do
                    local v328 = Professions_m.FormatPercent(arg97[val_41])
                    table.insert(
                        t_53,
                        `   - {val_41}  <font color='rgb(175, 175, 175)'>{v328}</font>`
                    )
                end

                return t_53
            end

            local function smeltPreviewText(arg100, arg101) -- line: 1524
                -- upvalues:
                --  [1] oddsLines (copy)
                --  [2] Professions_m (copy)

                local t_54 = {}
                local v330 = if not (arg101 > 1) then "" else " each"
                local v331 = `{arg100.Region} gear, tier {arg100.Tier}`

                if arg100.Rare then
                    v331 ..= " <font color='rgb(255, 207, 92)'><b>(rare)</b></font>"
                end

                local v332 = `<font color='rgb(225, 225, 225)'>{v331}</font>`
                table.insert(t_54, v332)

                if (arg100.ScrapCount or 0) > 0 then
                    table.insert(
                        t_54,
                        `<font color='rgb(212, 255, 155)'><b>{arg100.ScrapCount}x</b></font> <font color='rgb(225, 225, 225)'><b>Scrap</b></font>{v330} - each piece is one of:`
                    )
                    local v334 = oddsLines
                    local v335 = arg100.ScrapOdds or {}

                    for _, val_42 in v334(v335) do
                        table.insert(t_54, val_42)
                    end
                end

                if (arg100.SoftCount or 0) > 0 then
                    table.insert(
                        t_54,
                        `<font color='rgb(212, 255, 155)'><b>{arg100.SoftCount}x</b></font> <font color='rgb(225, 225, 225)'><b>Harvestables</b></font>{v330} - each one is:`
                    )
                    local v337 = oddsLines
                    local v338 = arg100.SoftOdds or {}

                    for _, val_43 in v337(v338) do
                        table.insert(t_54, val_43)
                    end
                end

                if arg100.Extras and #arg100.Extras > 0 then
                    table.insert(
                        t_54,
                        `<font color='rgb(225, 225, 225)'><b>Bonus chance</b></font>{v330}:`
                    )

                    for _, val_44 in arg100.Extras do
                        v331 = (val_44.Max or 1) > (val_44.Min or 1) and ` {val_44.Min}-{val_44.Max}x` or ""
                        local Item = val_44.Item
                        local v339 = Professions_m.FormatPercent(val_44.Chance)
                        table.insert(
                            t_54,
                            `   - {Item}{v331}  <font color='rgb(175, 175, 175)'>{v339}</font>`
                        )
                    end
                end

                if arg101 > 1 then
                    table.insert(
                        t_54,
                        `<font color='rgb(255, 190, 124)'>Smelting {arg101} copies - amounts shown are for this one; starred copies give a little more.</font>`
                    )
                end

                table.insert(
                    t_54,
                    "<font color='rgb(175, 175, 175)'><i>Amounts are fixed - only which material each piece becomes is rolled. Recast scrap into ore on the Craft tab. Smelting destroys the item.</i></font>"
                )

                return table.concat(t_54, "\n")
            end

            local function multiPreview(arg102) -- line: 1563
                -- upvalues:
                --  [1] Professions_m (copy)
                --  [2] v3 (copy)
                --  [3] Formatter_m (copy)
                --  [4] SmeltData_m (copy)

                local v342 = Professions_m:GetPlayerBenefits(v3, "Crafting").smelt_return or 0
                local t_55 = {}
                local t_56 = {}
                local t_57 = {}
                local t_58 = {}
                local v343 = 0
                local v344 = 0

                for _, val_45 in arg102 do
                    local v345 = Formatter_m.formatItem(val_45.Name)
                    t_55[v345] = (t_55[v345] or 0) + 1
                    local v346 = SmeltData_m.GetProfile(
                        v345,
                        val_45:GetAttribute("Quality") or 0,
                        v342
                    )

                    if v346 then
                        v343 += v346.ScrapCount
                        v344 += v346.SoftCount

                        for key_62, val_46 in v346.ScrapOdds do
                            t_56[key_62] = (t_56[key_62] or 0) + v346.ScrapCount * val_46
                        end

                        for key_63, val_47 in v346.SoftOdds do
                            t_57[key_63] = (t_57[key_63] or 0) + v346.SoftCount * val_47
                        end

                        for _, val_48 in v346.Extras do
                            t_58[val_48.Item] = (t_58[val_48.Item] or 0) + val_48.Chance * ((val_48.Min or 1) + (val_48.Max or 1)) / 2
                        end
                    end
                end

                local function expectedLines(arg103) -- line: 1586
                    local t_59 = {}

                    for key_65 in arg103 do
                        table.insert(t_59, key_65)
                    end

                    table.sort(t_59, function(arg104, arg105) -- line: 1591
                        -- upvalues:
                        --  [1] arg103 (copy)

                        return arg103[arg104] > arg103[arg105] or (if arg103[arg104] ~= arg103[arg105] then false else arg104 < arg105)
                    end)
                    local t_60 = {}

                    for _, val_49 in t_59 do
                        local v348 = string.format("%.1f", arg103[val_49])
                        table.insert(
                            t_60,
                            `   - {val_49}  <font color='rgb(175, 175, 175)'>~{v348}</font>`
                        )
                    end

                    return t_60
                end

                local t_61 = {}

                for key_67 in t_55 do
                    table.insert(t_61, key_67)
                end

                table.sort(t_61, function(arg106, arg107) -- line: 1605
                    -- upvalues:
                    --  [1] t_55 (copy)

                    return t_55[arg106] > t_55[arg107] or (if t_55[arg106] ~= t_55[arg107] then false else arg106 < arg107)
                end)
                local t_62 = {}

                for _, val_50 in t_61 do
                    table.insert(t_62, `{t_55[val_50]}x {val_50}`)
                end

                local t_63 = {}

                if v343 > 0 then
                    table.insert(
                        t_63,
                        `<font color='rgb(212, 255, 155)'><b>{v343}x</b></font> <font color='rgb(225, 225, 225)'><b>Scrap</b></font> in total - expected:`
                    )

                    for _, val_51 in expectedLines(t_56) do
                        table.insert(t_63, val_51)
                    end
                end

                if v344 > 0 then
                    table.insert(
                        t_63,
                        `<font color='rgb(212, 255, 155)'><b>{v344}x</b></font> <font color='rgb(225, 225, 225)'><b>Harvestables</b></font> in total - expected:`
                    )

                    for _, val_52 in expectedLines(t_57) do
                        table.insert(t_63, val_52)
                    end
                end

                if next(t_58) then
                    table.insert(
                        t_63,
                        "<font color='rgb(225, 225, 225)'><b>Bonus drops</b></font> - expected:"
                    )

                    for _, val_53 in expectedLines(t_58) do
                        table.insert(t_63, val_53)
                    end
                end

                table.insert(
                    t_63,
                    "<font color='rgb(175, 175, 175)'><i>Scrap totals are fixed; the ~ amounts are averages, since each piece is rolled when smelted. Smelting destroys every selected item.</i></font>"
                )

                return table.concat(t_62, ", "), table.concat(t_63, "\n")
            end

            local function styleTile(arg108) -- line: 1636
                -- upvalues:
                --  [1] t_46 (copy)
                --  [2] v293 (ref)
                --  [3] t_48 (copy)
                --  [4] v285 (ref)
                --  [5] t (copy)
                --  [6] setStarImages (copy)

                local v353 = t_46[arg108]

                if not v353 then
                    return
                end

                local v354 = v293 and t_48[arg108] == true
                local v355 = v354 or not v293 and arg108 == v285
                local SelectedOutline_10 = v353:FindFirstChild("SelectedOutline")

                if SelectedOutline_10 then
                    SelectedOutline_10.Visible = v355
                end

                v353.BackgroundColor3 = v355 and t.BUTTON_ON or t.BUTTON
                v353.Check.Visible = v354
                v354 = arg108:GetAttribute("Quality") or 0

                if v353:GetAttribute("ShownStars") ~= v354 then
                    v353:SetAttribute("ShownStars", v354)
                    setStarImages(v353.Stars, v354)
                end

                v354 = if arg108:GetAttribute("Locked") ~= true then false else true
                v353.Lock.Visible = v354

                for _, child_10 in v353.Holder:GetChildren() do
                    if child_10:IsA("ViewportFrame") then
                        child_10.ImageTransparency = if not v354 then 0 else 0.55
                    end
                end
            end

            local _ = function() --[[ restyleAllTiles ]] -- line: 1658
                -- upvalues:
                --  [1] t_46 (copy)
                --  [2] styleTile (copy)

                for key_73 in t_46 do
                    styleTile(key_73)
                end
            end

            local function gridMatches(arg109) -- line: 1664
                -- upvalues:
                --  [1] Formatter_m (copy)
                --  [2] Items_m (copy)
                --  [3] v5 (copy)
                --  [4] v284 (ref)
                --  [5] Box_1 (copy)

                local v358 = Formatter_m.formatItem(arg109.Name)
                local v359 = Items_m.AllItems[v358]
                local v360 = v359

                if type(v359) ~= "table" or not v360 then
                    v360 = nil
                end

                if v360 then
                    local Name_5 = arg109.Name
                    local v362

                    if v360.ArmorType then
                        if v5:GetStat("Equipped" .. v360.ArmorType) == Name_5 then
                            v359 = true
                        elseif v360.ArmorType then
                            v362 = v360.ArmorType .. "Vanity"
                            v359 = v5:GetStat(v362) == Name_5 or (if v5:GetStat("FightingStyle") ~= Name_5 then false else true)
                        else
                            v359 = if v5:GetStat("FightingStyle") ~= Name_5 then false else true
                        end
                    elseif v360.ArmorType then
                        v362 = v360.ArmorType .. "Vanity"
                        v359 = v5:GetStat(v362) == Name_5 or (if v5:GetStat("FightingStyle") ~= Name_5 then false else true)
                    else
                        v359 = if v5:GetStat("FightingStyle") ~= Name_5 then false else true
                    end

                    if v359 then
                        return false
                    end

                    if v284 ~= "All" then
                        if (if v360.Type == "Weapon" then "Weapon" else v360.ArmorType or "Other") ~= v284 then
                            return false
                        end
                    end

                    v360 = string.lower(Box_1.Text or "")

                    if v360 ~= "" then
                        if not string.find(string.lower(v358), v360, 1, true) then
                            return false
                        end
                    end

                    return true
                else
                    return false
                end
            end

            local _ = function() --[[ setSingleLayout ]] -- line: 1680
                -- upvalues:
                --  [1] Quantity_1 (copy)
                --  [2] Action_1 (copy)

                Quantity_1.Visible = true
                Action_1.Size = UDim2.new(1, -206, 0, 34)
            end

            local _ = function() --[[ setMultiLayout ]] -- line: 1685
                -- upvalues:
                --  [1] Quantity_1 (copy)
                --  [2] Action_1 (copy)

                Quantity_1.Visible = false
                Action_1.Size = UDim2.new(1, 0, 0, 34)
            end

            local _ = function(arg110) --[[ showSmeltRefusal ]] -- line: 1690
                -- upvalues:
                --  [1] Scroll_1 (copy)
                --  [2] v287 (ref)
                --  [3] refreshSmeltAction (copy)

                Scroll_1.Returns.Text = `<font color='rgb(255, 94, 97)'>{arg110 or "This item can't be smelted."}</font>`
                v287 = false
                refreshSmeltAction()
            end

            local function showMultiDetails() -- line: 1696
                -- upvalues:
                --  [1] pickedList (copy)
                --  [2] Details_1 (copy)
                --  [3] v7 (copy)
                --  [4] Quantity_1 (copy)
                --  [5] Action_1 (copy)
                --  [6] setIcon (copy)
                --  [7] Formatter_m (copy)
                --  [8] multiPreview (copy)
                --  [9] Scroll_1 (copy)
                --  [10] refreshSmeltAction (copy)

                local v366 = pickedList()
                Details_1.Empty.Text = "Multi-select is on: click items to add them, or use Select All for everything shown."
                Details_1.Empty.Visible = #v366 == 0
                v7.Visible = #v366 > 0 and true
                Quantity_1.Visible = false
                Action_1.Size = UDim2.new(1, 0, 0, 34)

                if #v366 > 0 then
                    local v370 = #v366
                    local v371 = if #v366 ~= 1 then "s" else ""
                    v7.ItemName.Text = `{v370} item{v371} selected`
                    setIcon(v7.IconBox, Formatter_m.formatItem(v366[1].Name), true)
                    v7.Quality.Visible = false
                    local v373, v374 = multiPreview(v366)
                    Scroll_1.Description.Text = v373
                    Scroll_1.Returns.Text = v374
                end

                refreshSmeltAction()
            end

            local _ = function(arg111) --[[ updateGridCount ]] -- line: 1713
                -- upvalues:
                --  [1] v293 (ref)
                --  [2] pickedList (copy)
                --  [3] Count (copy)

                local v375 = if arg111 ~= 1 then "s" else ""
                local v376 = `{arg111} item{v375}`

                if v293 then
                    local v377 = #pickedList()
                    v376 ..= `  -  {v377} selected`
                end

                Count.Text = v376
            end

            local function selectSmelt(arg112) -- line: 1721
                -- upvalues:
                --  [1] v285 (ref)
                --  [2] v287 (ref)
                --  [3] v289 (ref)
                --  [4] v290 (ref)
                --  [5] styleTile (copy)
                --  [6] Details_1 (copy)
                --  [7] Text_1 (copy)
                --  [8] v7 (copy)
                --  [9] v286 (ref)
                --  [10] v292 (ref)
                --  [11] Quantity_1 (copy)
                --  [12] Action_1 (copy)
                --  [13] refreshSmeltAction (copy)
                --  [14] Formatter_m (copy)
                --  [15] Items_m (copy)
                --  [16] setIcon (copy)
                --  [17] setStarImages (copy)
                --  [18] Scroll_1 (copy)
                --  [19] smeltBatch (copy)
                --  [20] v291 (ref)
                --  [21] CraftRemote (copy)
                --  [22] smeltPreviewText (copy)

                local v378 = v285
                v285 = arg112
                v287 = false
                v289 = false
                v290 += 1

                if v378 then
                    styleTile(v378)
                end

                Details_1.Empty.Text = Text_1
                Details_1.Empty.Visible = arg112 == nil
                v7.Visible = arg112 ~= nil
                v286 += 1
                v292 = nil
                Quantity_1.Visible = true
                Action_1.Size = UDim2.new(1, -206, 0, 34)

                if not arg112 then
                    refreshSmeltAction()

                    return
                end

                styleTile(arg112)
                local v381 = Formatter_m.formatItem(arg112.Name)
                local v382 = Items_m.AllItems[v381]
                local v383 = v382

                if type(v382) ~= "table" or not v383 then
                    v383 = nil
                end

                if not v383 then
                    v383 = {}
                end

                v7.ItemName.Text = v381
                setIcon(v7.IconBox, v381, true)
                local v384 = arg112:GetAttribute("Quality") or 0
                v7.Quality.Visible = v384 > 0 and true
                setStarImages(v7.Quality.Stars, v384)
                Scroll_1.Description.Text = v383.Desc or ""
                Scroll_1.Returns.Text = "<i>Checking...</i>"
                v383 = math.max(1, #smeltBatch())
                v291 = math.clamp(math.floor(tonumber(1) or 1), 1, v383)
                Quantity_1.CountFrame.CountBox.Text = tostring(v291)
                local Note_1 = Quantity_1.Note
                Note_1.Text = v383 > 1 and `of {v383}` or ""
                refreshSmeltAction()
                local v388 = v286
                task.spawn(function() -- line: 1755
                    -- upvalues:
                    --  [1] CraftRemote (ref)
                    --  [2] arg112 (copy)
                    --  [3] v388 (copy)
                    --  [4] v286 (ref)
                    --  [5] Scroll_1 (ref)
                    --  [6] v287 (ref)
                    --  [7] refreshSmeltAction (ref)
                    --  [8] v292 (ref)
                    --  [9] smeltPreviewText (ref)
                    --  [10] v291 (ref)

                    local Success_1, Result_1, v389 = pcall(
                        CraftRemote.InvokeServer,
                        CraftRemote,
                        "SmeltPreview",
                        arg112.Name
                    )

                    if v388 ~= v286 then
                        return
                    end

                    local v390

                    if Success_1 then
                        if type(Result_1) ~= "table" then
                            v390 = Success_1 and v389 or nil
                            Scroll_1.Returns.Text = `<font color='rgb(255, 94, 97)'>{v390 or "This item can't be smelted."}</font>`
                            v287 = false
                            refreshSmeltAction()

                            return
                        end

                        v292 = Result_1
                        v287 = true
                        Scroll_1.Returns.Text = smeltPreviewText(Result_1, v291)
                        refreshSmeltAction()

                        return
                    else
                        v390 = Success_1 and v389 or nil
                        Scroll_1.Returns.Text = `<font color='rgb(255, 94, 97)'>{v390 or "This item can't be smelted."}</font>`
                        v287 = false
                        refreshSmeltAction()

                        return
                    end
                end)
            end

            local t_64 = {
                Weapon = 1,
                Helmet = 2,
                Face = 3,
                Neck = 4,
                Chest = 5,
                Legs = 6,
                Back = 7
            }

            local function refreshGrid() -- line: 1771
                -- upvalues:
                --  [1] t_46 (copy)
                --  [2] Formatter_m (copy)
                --  [3] Items_m (copy)
                --  [4] v5 (copy)
                --  [5] gridMatches (copy)
                --  [6] t_48 (copy)
                --  [7] styleTile (copy)
                --  [8] t_64 (copy)
                --  [9] t_45 (copy)
                --  [10] v284 (ref)
                --  [11] t (copy)
                --  [12] v285 (ref)
                --  [13] v287 (ref)
                --  [14] v289 (ref)
                --  [15] v290 (ref)
                --  [16] Details_1 (copy)
                --  [17] Text_1 (copy)
                --  [18] v7 (copy)
                --  [19] v286 (ref)
                --  [20] v292 (ref)
                --  [21] Quantity_1 (copy)
                --  [22] Action_1 (copy)
                --  [23] refreshSmeltAction (copy)
                --  [24] v293 (ref)
                --  [25] showMultiDetails (copy)
                --  [26] Empty (copy)
                --  [27] pickedList (copy)
                --  [28] Count (copy)

                local t_65 = {}
                local t_66 = { All = 0 }
                local v391 = false
                local v396

                for key_74, val_54 in t_46 do
                    local v392 = Formatter_m.formatItem(key_74.Name)
                    local v393 = Items_m.AllItems[v392]
                    local v394 = v393

                    if type(v393) ~= "table" or not v394 then
                        v394 = nil
                    end

                    if v394 then
                        local Name_6 = key_74.Name

                        if v394.ArmorType then
                            if v5:GetStat("Equipped" .. v394.ArmorType) == Name_6 then
                                v392 = true
                            elseif v394.ArmorType then
                                v396 = v394.ArmorType .. "Vanity"
                                v392 = v5:GetStat(v396) == Name_6 or (if v5:GetStat("FightingStyle") ~= Name_6 then false else true)
                            else
                                v392 = if v5:GetStat("FightingStyle") ~= Name_6 then false else true
                            end
                        elseif v394.ArmorType then
                            v396 = v394.ArmorType .. "Vanity"
                            v392 = v5:GetStat(v396) == Name_6 or (if v5:GetStat("FightingStyle") ~= Name_6 then false else true)
                        else
                            v392 = if v5:GetStat("FightingStyle") ~= Name_6 then false else true
                        end

                        if not v392 then
                            t_66.All += 1
                            v392 = if v394.Type ~= "Weapon" then v394.ArmorType or "Other" else "Weapon"
                            t_66[v392] = (t_66[v392] or 0) + 1
                        end
                    end

                    v394 = gridMatches(key_74)
                    val_54.Visible = v394

                    if v394 then
                        table.insert(t_65, key_74)
                    elseif t_48[key_74] then
                        t_48[key_74] = nil
                        v391 = true
                        styleTile(key_74)
                    end
                end

                table.sort(t_65, function(arg113, arg114) -- line: 1793
                    -- upvalues:
                    --  [1] Formatter_m (ref)
                    --  [2] Items_m (ref)
                    --  [3] t_64 (ref)

                    local v397 = Formatter_m.formatItem(arg113.Name)
                    local v398 = Formatter_m.formatItem(arg114.Name)
                    local v399 = Items_m.AllItems[v397]
                    local v400 = v399

                    if type(v399) ~= "table" or not v400 then
                        v400 = nil
                    end

                    local v401 = Items_m.AllItems[v398]
                    local v402 = v401

                    if type(v401) ~= "table" or not v402 then
                        v402 = nil
                    end

                    local v403 = if v400.Type ~= "Weapon" then v400.ArmorType or "Other" else "Weapon"
                    local v404 = t_64[v403] or 9
                    v403 = if v402.Type ~= "Weapon" then v402.ArmorType or "Other" else "Weapon"
                    local v405 = t_64[v403] or 9
                    local v406

                    if v404 ~= v405 then
                        v406 = v404 < v405

                        return v406
                    end

                    if v397 ~= v398 then
                        v406 = v397 < v398

                        return v406
                    end

                    v406 = arg113:GetAttribute("Quality") or 0
                    local v407 = arg114:GetAttribute("Quality") or 0
                    local v408

                    if v406 ~= v407 then
                        v408 = v406 > v407

                        return v408
                    end

                    v408 = arg113.Name < arg114.Name

                    return v408
                end)

                for key_75, val_55 in t_65 do
                    t_46[val_55].LayoutOrder = key_75
                end

                for key_76, val_56 in t_45 do
                    val_56:SetAttribute("Count", t_66[key_76] or 0)
                    local v409 = if key_76 ~= v284 then false else true
                    local SelectedOutline_11 = val_56:FindFirstChild("SelectedOutline")

                    if SelectedOutline_11 then
                        SelectedOutline_11.Visible = v409
                    end

                    val_56.BackgroundColor3 = v409 and t.BUTTON_ON or t.BUTTON
                    local v410 = if val_56.Name ~= "All" then if val_56:GetAttribute("Count") ~= 0 then false else true else false
                    val_56.Icon.ImageTransparency = if not v410 then if not v409 then 0.3 else 0 else 0.75
                end

                if v285 and t_46[v285] then
                    local v412 = v285
                    local v414 = Items_m.AllItems[Formatter_m.formatItem(v412.Name)]
                    local v415 = v414

                    if type(v414) ~= "table" or not v415 then
                        v415 = nil
                    end

                    local v416 = true

                    if v415 ~= nil then
                        local Name_7 = v412.Name
                        local v418

                        if v415.ArmorType then
                            if v5:GetStat("Equipped" .. v415.ArmorType) == Name_7 then
                                v416 = true
                            elseif v415.ArmorType then
                                v418 = v415.ArmorType .. "Vanity"
                                v416 = v5:GetStat(v418) == Name_7 or (if v5:GetStat("FightingStyle") ~= Name_7 then false else true)
                            else
                                v416 = if v5:GetStat("FightingStyle") ~= Name_7 then false else true
                            end
                        elseif v415.ArmorType then
                            v418 = v415.ArmorType .. "Vanity"
                            v416 = v5:GetStat(v418) == Name_7 or (if v5:GetStat("FightingStyle") ~= Name_7 then false else true)
                        else
                            v416 = if v5:GetStat("FightingStyle") ~= Name_7 then false else true
                        end
                    end

                    if v416 then
                        v416 = v285
                        v285 = nil
                        v287 = false
                        v289 = false
                        v290 += 1

                        if v416 then
                            styleTile(v416)
                        end

                        Details_1.Empty.Text = Text_1
                        Details_1.Empty.Visible = true
                        v7.Visible = false
                        v286 += 1
                        v292 = nil
                        Quantity_1.Visible = true
                        Action_1.Size = UDim2.new(1, -206, 0, 34)
                        refreshSmeltAction()
                    end
                end

                if v293 and v391 then
                    showMultiDetails()
                end

                Empty.Visible = #t_65 == 0
                Empty.Text = if t_66.All ~= 0 then "Nothing here matches." else "You have no armor or weapons that can be smelted."
                local v421 = #t_65
                local v422 = if v421 ~= 1 then "s" else ""
                v391 = `{v421} item{v422}`

                if v293 then
                    v422 = #pickedList()
                    v391 ..= `  -  {v422} selected`
                end

                Count.Text = v391
            end

            local v423 = false

            local _ = function() --[[ queueGridRefresh ]] -- line: 1832
                -- upvalues:
                --  [1] v423 (ref)
                --  [2] refreshGrid (copy)

                if v423 then
                    return
                end

                v423 = true
                task.delay(0.05, function() -- line: 1837
                    -- upvalues:
                    --  [1] v423 (ref)
                    --  [2] refreshGrid (ref)

                    v423 = false
                    refreshGrid()
                end)
            end

            local function styleToolButtons() -- line: 1843
                -- upvalues:
                --  [1] Multi (copy)
                --  [2] v293 (ref)
                --  [3] t (copy)
                --  [4] SelectAll (copy)
                --  [5] Clear (copy)

                local v424 = Multi
                local v425 = v293
                local SelectedOutline_12 = v424:FindFirstChild("SelectedOutline")

                if SelectedOutline_12 then
                    SelectedOutline_12.Visible = v425
                end

                v424.BackgroundColor3 = v425 and t.BUTTON_ON or t.BUTTON
                Multi.Label.TextColor3 = v293 and t.TEXT or t.TEXT_DIM
                SelectAll.Label.TextColor3 = t.TEXT
                Clear.Label.TextColor3 = t.TEXT
            end

            local function setMultiMode(arg115) -- line: 1850
                -- upvalues:
                --  [1] v293 (ref)
                --  [2] t_48 (copy)
                --  [3] v289 (ref)
                --  [4] v290 (ref)
                --  [5] Multi (copy)
                --  [6] t (copy)
                --  [7] SelectAll (copy)
                --  [8] Clear (copy)
                --  [9] v285 (ref)
                --  [10] v287 (ref)
                --  [11] styleTile (copy)
                --  [12] Details_1 (copy)
                --  [13] Text_1 (copy)
                --  [14] v7 (copy)
                --  [15] v286 (ref)
                --  [16] v292 (ref)
                --  [17] Quantity_1 (copy)
                --  [18] Action_1 (copy)
                --  [19] refreshSmeltAction (copy)
                --  [20] showMultiDetails (copy)
                --  [21] t_46 (copy)
                --  [22] v423 (ref)
                --  [23] refreshGrid (copy)

                v293 = arg115
                table.clear(t_48)
                v289 = false
                v290 += 1
                local v428 = Multi
                local v429 = v293
                local SelectedOutline_13 = v428:FindFirstChild("SelectedOutline")

                if SelectedOutline_13 then
                    SelectedOutline_13.Visible = v429
                end

                v428.BackgroundColor3 = v429 and t.BUTTON_ON or t.BUTTON
                local Label_9 = Multi.Label
                Label_9.TextColor3 = v293 and t.TEXT or t.TEXT_DIM
                SelectAll.Label.TextColor3 = t.TEXT
                Clear.Label.TextColor3 = t.TEXT

                if arg115 then
                    local v432 = v285
                    v285 = nil
                    v287 = false
                    v289 = false
                    v290 += 1

                    if v432 then
                        styleTile(v432)
                    end

                    Details_1.Empty.Text = Text_1
                    Details_1.Empty.Visible = true
                    v7.Visible = false
                    v286 += 1
                    v292 = nil
                    Quantity_1.Visible = true
                    Action_1.Size = UDim2.new(1, -206, 0, 34)
                    refreshSmeltAction()
                    showMultiDetails()
                else
                    local v434 = v285
                    v285 = nil
                    v287 = false
                    v289 = false
                    v290 += 1

                    if v434 then
                        styleTile(v434)
                    end

                    Details_1.Empty.Text = Text_1
                    Details_1.Empty.Visible = true
                    v7.Visible = false
                    v286 += 1
                    v292 = nil
                    Quantity_1.Visible = true
                    Action_1.Size = UDim2.new(1, -206, 0, 34)
                    refreshSmeltAction()
                end

                for key_77 in t_46 do
                    styleTile(key_77)
                end

                if v423 then
                    return
                end

                v423 = true
                task.delay(0.05, function() -- line: 1837
                    -- upvalues:
                    --  [1] v423 (ref)
                    --  [2] refreshGrid (ref)

                    v423 = false
                    refreshGrid()
                end)
            end

            local _ = function(arg116) --[[ isPickable ]] -- line: 1865
                -- upvalues:
                --  [1] Formatter_m (copy)
                --  [2] Items_m (copy)
                --  [3] v5 (copy)

                local v436 = false

                if arg116.Parent ~= nil then
                    v436 = not arg116:GetAttribute("Locked")

                    if v436 then
                        local v438 = Items_m.AllItems[Formatter_m.formatItem(arg116.Name)]
                        local v439 = v438

                        if type(v438) ~= "table" or not v439 then
                            v439 = nil
                        end

                        local v440 = true

                        if v439 ~= nil then
                            local Name_8 = arg116.Name
                            local v442

                            if v439.ArmorType then
                                if v5:GetStat("Equipped" .. v439.ArmorType) == Name_8 then
                                    v440 = true
                                elseif v439.ArmorType then
                                    v442 = v439.ArmorType .. "Vanity"
                                    v440 = v5:GetStat(v442) == Name_8 or (if v5:GetStat(
                                        "FightingStyle"
                                    ) ~= Name_8 then false else true)
                                else
                                    v440 = if v5:GetStat("FightingStyle") ~= Name_8 then false else true
                                end
                            elseif v439.ArmorType then
                                v442 = v439.ArmorType .. "Vanity"
                                v440 = v5:GetStat(v442) == Name_8 or (if v5:GetStat("FightingStyle") ~= Name_8 then false else true)
                            else
                                v440 = if v5:GetStat("FightingStyle") ~= Name_8 then false else true
                            end
                        end

                        v436 = not v440
                    end
                end

                return v436
            end

            local function togglePick(arg117) -- line: 1869
                -- upvalues:
                --  [1] t_46 (copy)
                --  [2] Formatter_m (copy)
                --  [3] Items_m (copy)
                --  [4] v5 (copy)
                --  [5] v35 (ref)
                --  [6] BackpackUtils_m (copy)
                --  [7] t_48 (copy)
                --  [8] v289 (ref)
                --  [9] v290 (ref)
                --  [10] styleTile (copy)
                --  [11] showMultiDetails (copy)
                --  [12] v423 (ref)
                --  [13] refreshGrid (copy)

                local v443 = t_46[arg117]
                local v444 = false

                if arg117.Parent ~= nil then
                    v444 = not arg117:GetAttribute("Locked")

                    if v444 then
                        local v446 = Items_m.AllItems[Formatter_m.formatItem(arg117.Name)]
                        local v447 = v446

                        if type(v446) ~= "table" or not v447 then
                            v447 = nil
                        end

                        local v448 = true

                        if v447 ~= nil then
                            local Name_9 = arg117.Name
                            local v450

                            if v447.ArmorType then
                                if v5:GetStat("Equipped" .. v447.ArmorType) == Name_9 then
                                    v448 = true
                                elseif v447.ArmorType then
                                    v450 = v447.ArmorType .. "Vanity"
                                    v448 = v5:GetStat(v450) == Name_9 or (if v5:GetStat(
                                        "FightingStyle"
                                    ) ~= Name_9 then false else true)
                                else
                                    v448 = if v5:GetStat("FightingStyle") ~= Name_9 then false else true
                                end
                            elseif v447.ArmorType then
                                v450 = v447.ArmorType .. "Vanity"
                                v448 = v5:GetStat(v450) == Name_9 or (if v5:GetStat("FightingStyle") ~= Name_9 then false else true)
                            else
                                v448 = if v5:GetStat("FightingStyle") ~= Name_9 then false else true
                            end
                        end

                        v444 = not v448
                    end
                end

                if not v444 then
                    if v443 then
                        v444 = {
                            key = Formatter_m.formatItem(arg117.Name),
                            text = "Unlock this item before smelting it."
                        }
                        v35 = v443
                        BackpackUtils_m:ShowHover(v444)
                    end

                    return
                end

                t_48[arg117] = not t_48[arg117] or nil
                v289 = false
                v290 += 1
                styleTile(arg117)
                showMultiDetails()

                if v423 then
                    return
                end

                v423 = true
                task.delay(0.05, function() -- line: 1837
                    -- upvalues:
                    --  [1] v423 (ref)
                    --  [2] refreshGrid (ref)

                    v423 = false
                    refreshGrid()
                end)
            end

            Multi.MouseButton1Click:Connect(function() -- line: 1884
                -- upvalues:
                --  [1] setMultiMode (copy)
                --  [2] v293 (ref)

                setMultiMode(not v293)
            end)
            SelectAll.MouseButton1Click:Connect(function() -- line: 1888
                -- upvalues:
                --  [1] v293 (ref)
                --  [2] t_48 (copy)
                --  [3] v289 (ref)
                --  [4] v290 (ref)
                --  [5] Multi (copy)
                --  [6] t (copy)
                --  [7] SelectAll (copy)
                --  [8] Clear (copy)
                --  [9] v285 (ref)
                --  [10] v287 (ref)
                --  [11] styleTile (copy)
                --  [12] Details_1 (copy)
                --  [13] Text_1 (copy)
                --  [14] v7 (copy)
                --  [15] v286 (ref)
                --  [16] v292 (ref)
                --  [17] Quantity_1 (copy)
                --  [18] Action_1 (copy)
                --  [19] refreshSmeltAction (copy)
                --  [20] showMultiDetails (copy)
                --  [21] t_46 (copy)
                --  [22] v423 (ref)
                --  [23] refreshGrid (copy)
                --  [24] Formatter_m (copy)
                --  [25] Items_m (copy)
                --  [26] v5 (copy)

                if not v293 then
                    v293 = true
                    table.clear(t_48)
                    v289 = false
                    v290 += 1
                    local v451 = Multi
                    local v452 = v293
                    local SelectedOutline_14 = v451:FindFirstChild("SelectedOutline")

                    if SelectedOutline_14 then
                        SelectedOutline_14.Visible = v452
                    end

                    v451.BackgroundColor3 = v452 and t.BUTTON_ON or t.BUTTON
                    local Label_10 = Multi.Label
                    Label_10.TextColor3 = v293 and t.TEXT or t.TEXT_DIM
                    SelectAll.Label.TextColor3 = t.TEXT
                    Clear.Label.TextColor3 = t.TEXT
                    local v455 = v285
                    v285 = nil
                    v287 = false
                    v289 = false
                    v290 += 1

                    if v455 then
                        styleTile(v455)
                    end

                    Details_1.Empty.Text = Text_1
                    Details_1.Empty.Visible = true
                    v7.Visible = false
                    v286 += 1
                    v292 = nil
                    Quantity_1.Visible = true
                    Action_1.Size = UDim2.new(1, -206, 0, 34)
                    refreshSmeltAction()
                    showMultiDetails()

                    for key_78 in t_46 do
                        styleTile(key_78)
                    end

                    if not v423 then
                        v423 = true
                        task.delay(0.05, function() -- line: 1837
                            -- upvalues:
                            --  [1] v423 (ref)
                            --  [2] refreshGrid (ref)

                            v423 = false
                            refreshGrid()
                        end)
                    end
                end

                local v463

                for key_79, val_57 in t_46 do
                    if val_57.Visible then
                        local v457 = false

                        if key_79.Parent ~= nil then
                            v457 = not key_79:GetAttribute("Locked")

                            if v457 then
                                local v459 = Items_m.AllItems[Formatter_m.formatItem(key_79.Name)]
                                local v460 = v459

                                if type(v459) ~= "table" or not v460 then
                                    v460 = nil
                                end

                                local v461 = true

                                if v460 ~= nil then
                                    local Name_10 = key_79.Name

                                    if v460.ArmorType then
                                        if v5:GetStat("Equipped" .. v460.ArmorType) == Name_10 then
                                            v461 = true
                                        elseif v460.ArmorType then
                                            v463 = v460.ArmorType .. "Vanity"
                                            v461 = v5:GetStat(v463) == Name_10 or (if v5:GetStat(
                                                "FightingStyle"
                                            ) ~= Name_10 then false else true)
                                        else
                                            v461 = if v5:GetStat("FightingStyle") ~= Name_10 then false else true
                                        end
                                    elseif v460.ArmorType then
                                        v463 = v460.ArmorType .. "Vanity"
                                        v461 = v5:GetStat(v463) == Name_10 or (if v5:GetStat(
                                            "FightingStyle"
                                        ) ~= Name_10 then false else true)
                                    else
                                        v461 = if v5:GetStat("FightingStyle") ~= Name_10 then false else true
                                    end
                                end

                                v457 = not v461
                            end
                        end

                        if v457 then
                            t_48[key_79] = true
                        end
                    end
                end

                v289 = false
                v290 += 1

                for key_80 in t_46 do
                    styleTile(key_80)
                end

                showMultiDetails()

                if v423 then
                    return
                end

                v423 = true
                task.delay(0.05, function() -- line: 1837
                    -- upvalues:
                    --  [1] v423 (ref)
                    --  [2] refreshGrid (ref)

                    v423 = false
                    refreshGrid()
                end)
            end)
            Clear.MouseButton1Click:Connect(function() -- line: 1903
                -- upvalues:
                --  [1] v293 (ref)
                --  [2] t_48 (copy)
                --  [3] v289 (ref)
                --  [4] v290 (ref)
                --  [5] t_46 (copy)
                --  [6] styleTile (copy)
                --  [7] showMultiDetails (copy)
                --  [8] v423 (ref)
                --  [9] refreshGrid (copy)
                --  [10] v285 (ref)
                --  [11] v287 (ref)
                --  [12] Details_1 (copy)
                --  [13] Text_1 (copy)
                --  [14] v7 (copy)
                --  [15] v286 (ref)
                --  [16] v292 (ref)
                --  [17] Quantity_1 (copy)
                --  [18] Action_1 (copy)
                --  [19] refreshSmeltAction (copy)

                if v293 then
                    table.clear(t_48)
                    v289 = false
                    v290 += 1

                    for key_81 in t_46 do
                        styleTile(key_81)
                    end

                    showMultiDetails()

                    if v423 then
                        return
                    end

                    v423 = true
                    task.delay(0.05, function() -- line: 1837
                        -- upvalues:
                        --  [1] v423 (ref)
                        --  [2] refreshGrid (ref)

                        v423 = false
                        refreshGrid()
                    end)

                    return
                else
                    local v464 = v285
                    v285 = nil
                    v287 = false
                    v289 = false
                    v290 += 1

                    if v464 then
                        styleTile(v464)
                    end

                    Details_1.Empty.Text = Text_1
                    Details_1.Empty.Visible = true
                    v7.Visible = false
                    v286 += 1
                    v292 = nil
                    Quantity_1.Visible = true
                    Action_1.Size = UDim2.new(1, -206, 0, 34)
                    refreshSmeltAction()

                    return
                end
            end)

            local function removeTile(arg118) -- line: 1915
                -- upvalues:
                --  [1] t_46 (copy)
                --  [2] v35 (ref)
                --  [3] BackpackUtils_m (copy)
                --  [4] t_47 (copy)
                --  [5] t_48 (copy)
                --  [6] v285 (ref)
                --  [7] v287 (ref)
                --  [8] v289 (ref)
                --  [9] v290 (ref)
                --  [10] styleTile (copy)
                --  [11] Details_1 (copy)
                --  [12] Text_1 (copy)
                --  [13] v7 (copy)
                --  [14] v286 (ref)
                --  [15] v292 (ref)
                --  [16] Quantity_1 (copy)
                --  [17] Action_1 (copy)
                --  [18] refreshSmeltAction (copy)
                --  [19] v293 (ref)
                --  [20] showMultiDetails (copy)
                --  [21] v423 (ref)
                --  [22] refreshGrid (copy)

                local v466 = t_46[arg118]

                if v466 then
                    t_46[arg118] = nil

                    if v35 ~= nil and (v466 == nil or v35 == v466) then
                        v35 = nil
                        BackpackUtils_m:HideHover()
                    end

                    v466:Destroy()
                end

                local v467 = t_47[arg118] or {}

                for _, val_58 in v467 do
                    val_58:Disconnect()
                end

                t_47[arg118] = nil
                local v468 = t_48[arg118]
                t_48[arg118] = nil

                if arg118 == v285 then
                    local v469 = v285
                    v285 = nil
                    v287 = false
                    v289 = false
                    v290 += 1

                    if v469 then
                        styleTile(v469)
                    end

                    Details_1.Empty.Text = Text_1
                    Details_1.Empty.Visible = true
                    v7.Visible = false
                    v286 += 1
                    v292 = nil
                    Quantity_1.Visible = true
                    Action_1.Size = UDim2.new(1, -206, 0, 34)
                    refreshSmeltAction()
                end

                if v293 and v468 then
                    showMultiDetails()
                end

                if v423 then
                    return
                end

                v423 = true
                task.delay(0.05, function() -- line: 1837
                    -- upvalues:
                    --  [1] v423 (ref)
                    --  [2] refreshGrid (ref)

                    v423 = false
                    refreshGrid()
                end)
            end

            local function addTile(arg119) -- line: 1937
                -- upvalues:
                --  [1] t_46 (copy)
                --  [2] SmeltData_m (copy)
                --  [3] Formatter_m (copy)
                --  [4] Templates (copy)
                --  [5] setIcon (copy)
                --  [6] UserInputService (copy)
                --  [7] v293 (ref)
                --  [8] v285 (ref)
                --  [9] t_48 (copy)
                --  [10] v289 (ref)
                --  [11] v290 (ref)
                --  [12] Multi (copy)
                --  [13] t (copy)
                --  [14] SelectAll (copy)
                --  [15] Clear (copy)
                --  [16] v287 (ref)
                --  [17] styleTile (copy)
                --  [18] Details_1 (copy)
                --  [19] Text_1 (copy)
                --  [20] v7 (copy)
                --  [21] v286 (ref)
                --  [22] v292 (ref)
                --  [23] Quantity_1 (copy)
                --  [24] Action_1 (copy)
                --  [25] refreshSmeltAction (copy)
                --  [26] showMultiDetails (copy)
                --  [27] v423 (ref)
                --  [28] refreshGrid (copy)
                --  [29] Items_m (copy)
                --  [30] v5 (copy)
                --  [31] togglePick (copy)
                --  [32] selectSmelt (copy)
                --  [33] v35 (ref)
                --  [34] BackpackUtils_m (copy)
                --  [35] t_47 (copy)
                --  [36] Grid (copy)

                local changed

                if not t_46[arg119] then
                    if not SmeltData_m.CanSmelt(Formatter_m.formatItem(arg119.Name)) then
                        return
                    end

                    local v471 = Formatter_m.formatItem(arg119.Name)
                    local v472 = Templates.GridTile:Clone()
                    v472.Name = arg119.Name
                    setIcon(v472, v471, true)
                    v472.MouseButton1Click:Connect(function() -- line: 1946
                        -- upvalues:
                        --  [1] UserInputService (ref)
                        --  [2] v293 (ref)
                        --  [3] v285 (ref)
                        --  [4] t_48 (ref)
                        --  [5] v289 (ref)
                        --  [6] v290 (ref)
                        --  [7] Multi (ref)
                        --  [8] t (ref)
                        --  [9] SelectAll (ref)
                        --  [10] Clear (ref)
                        --  [11] v287 (ref)
                        --  [12] styleTile (ref)
                        --  [13] Details_1 (ref)
                        --  [14] Text_1 (ref)
                        --  [15] v7 (ref)
                        --  [16] v286 (ref)
                        --  [17] v292 (ref)
                        --  [18] Quantity_1 (ref)
                        --  [19] Action_1 (ref)
                        --  [20] refreshSmeltAction (ref)
                        --  [21] showMultiDetails (ref)
                        --  [22] t_46 (ref)
                        --  [23] v423 (ref)
                        --  [24] refreshGrid (ref)
                        --  [25] arg119 (copy)
                        --  [26] Formatter_m (ref)
                        --  [27] Items_m (ref)
                        --  [28] v5 (ref)
                        --  [29] togglePick (ref)
                        --  [30] selectSmelt (ref)

                        local v473 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or (UserInputService:IsKeyDown(
                            Enum.KeyCode.RightShift
                        ) or (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(
                            Enum.KeyCode.RightControl
                        )))

                        if not v293 and v473 then
                            local v474 = v285
                            v293 = true
                            table.clear(t_48)
                            v289 = false
                            v290 += 1
                            local v475 = Multi
                            local v476 = v293
                            local SelectedOutline_15 = v475:FindFirstChild("SelectedOutline")

                            if SelectedOutline_15 then
                                SelectedOutline_15.Visible = v476
                            end

                            v475.BackgroundColor3 = v476 and t.BUTTON_ON or t.BUTTON
                            local Label_11 = Multi.Label
                            Label_11.TextColor3 = v293 and t.TEXT or t.TEXT_DIM
                            SelectAll.Label.TextColor3 = t.TEXT
                            Clear.Label.TextColor3 = t.TEXT
                            local v479 = v285
                            v285 = nil
                            v287 = false
                            v289 = false
                            v290 += 1

                            if v479 then
                                styleTile(v479)
                            end

                            Details_1.Empty.Text = Text_1
                            Details_1.Empty.Visible = true
                            v7.Visible = false
                            v286 += 1
                            v292 = nil
                            Quantity_1.Visible = true
                            Action_1.Size = UDim2.new(1, -206, 0, 34)
                            refreshSmeltAction()
                            showMultiDetails()

                            for key_83 in t_46 do
                                styleTile(key_83)
                            end

                            if not v423 then
                                v423 = true
                                task.delay(0.05, function() -- line: 1837
                                    -- upvalues:
                                    --  [1] v423 (ref)
                                    --  [2] refreshGrid (ref)

                                    v423 = false
                                    refreshGrid()
                                end)
                            end

                            if v474 and v474 ~= arg119 then
                                local v481 = false

                                if v474.Parent ~= nil then
                                    v481 = not v474:GetAttribute("Locked")

                                    if v481 then
                                        local v483 = Items_m.AllItems[Formatter_m.formatItem(
                                            v474.Name
                                        )]
                                        local v484 = v483

                                        if type(v483) ~= "table" or not v484 then
                                            v484 = nil
                                        end

                                        local v485 = true

                                        if v484 ~= nil then
                                            local Name_11 = v474.Name
                                            local v487

                                            if v484.ArmorType then
                                                if v5:GetStat("Equipped" .. v484.ArmorType) == Name_11 then
                                                    v485 = true
                                                elseif v484.ArmorType then
                                                    v487 = v484.ArmorType .. "Vanity"
                                                    v485 = v5:GetStat(v487) == Name_11 or (if v5:GetStat(
                                                        "FightingStyle"
                                                    ) ~= Name_11 then false else true)
                                                else
                                                    v485 = if v5:GetStat("FightingStyle") ~= Name_11 then false else true
                                                end
                                            elseif v484.ArmorType then
                                                v487 = v484.ArmorType .. "Vanity"
                                                v485 = v5:GetStat(v487) == Name_11 or (if v5:GetStat(
                                                    "FightingStyle"
                                                ) ~= Name_11 then false else true)
                                            else
                                                v485 = if v5:GetStat("FightingStyle") ~= Name_11 then false else true
                                            end
                                        end

                                        v481 = not v485
                                    end
                                end

                                if v481 then
                                    t_48[v474] = true
                                    styleTile(v474)
                                end
                            end
                        end

                        if v293 then
                            togglePick(arg119)

                            return
                        end

                        if v285 == arg119 then
                            v473 = v285
                            v285 = nil
                            v287 = false
                            v289 = false
                            v290 += 1

                            if v473 then
                                styleTile(v473)
                            end

                            Details_1.Empty.Text = Text_1
                            Details_1.Empty.Visible = true
                            v7.Visible = false
                            v286 += 1
                            v292 = nil
                            Quantity_1.Visible = true
                            Action_1.Size = UDim2.new(1, -206, 0, 34)
                            refreshSmeltAction()

                            return
                        end

                        selectSmelt(arg119)
                    end)
                    v472.MouseEnter:Connect(function() -- line: 1965
                        -- upvalues:
                        --  [1] v472 (copy)
                        --  [2] arg119 (copy)
                        --  [3] v35 (ref)
                        --  [4] BackpackUtils_m (ref)

                        local t_68 = { key = arg119.Name }
                        v35 = v472
                        BackpackUtils_m:ShowHover(t_68)
                    end)
                    v472.MouseLeave:Connect(function() -- line: 1968
                        -- upvalues:
                        --  [1] v472 (copy)
                        --  [2] v35 (ref)
                        --  [3] BackpackUtils_m (ref)

                        local v489 = v472

                        if v35 ~= nil and (v489 == nil or v35 == v489) then
                            v35 = nil
                            BackpackUtils_m:HideHover()
                        end
                    end)

                    function changed() -- line: 1972
                        -- upvalues:
                        --  [1] styleTile (ref)
                        --  [2] arg119 (copy)
                        --  [3] v285 (ref)
                        --  [4] selectSmelt (ref)
                        --  [5] t_48 (ref)
                        --  [6] showMultiDetails (ref)
                        --  [7] v423 (ref)
                        --  [8] refreshGrid (ref)

                        styleTile(arg119)

                        if arg119 == v285 then
                            selectSmelt(arg119)
                        end

                        if arg119:GetAttribute("Locked") and t_48[arg119] then
                            t_48[arg119] = nil
                            styleTile(arg119)
                            showMultiDetails()
                        end

                        if v423 then
                            return
                        end

                        v423 = true
                        task.delay(0.05, function() -- line: 1837
                            -- upvalues:
                            --  [1] v423 (ref)
                            --  [2] refreshGrid (ref)

                            v423 = false
                            refreshGrid()
                        end)
                    end

                    local _ = {}
                    t_47[arg119] = {
                        arg119:GetAttributeChangedSignal("Locked"):Connect(changed),
                        arg119:GetAttributeChangedSignal("Quality"):Connect(changed)
                    }
                    t_46[arg119] = v472
                    styleTile(arg119)
                    v472.Parent = Grid

                    if v423 then
                        return
                    end

                    v423 = true
                    task.delay(0.05, function() -- line: 1837
                        -- upvalues:
                        --  [1] v423 (ref)
                        --  [2] refreshGrid (ref)

                        v423 = false
                        refreshGrid()
                    end)

                    return
                else
                    return
                end
            end

            for key_85, val_59 in {
                { Key = "All", Label = "All Gear", Icon = "rbxassetid://97114246738130" },
                { Key = "Weapon", Label = "Weapons", Icon = "rbxassetid://15454346332" },
                { Key = "Helmet", Label = "Head", Icon = "rbxassetid://15454500834" },
                { Key = "Face", Label = "Face", Icon = "rbxassetid://15464023729" },
                { Key = "Neck", Label = "Neck", Icon = "rbxassetid://123695900858427" },
                { Key = "Chest", Label = "Chest", Icon = "rbxassetid://15454568076" },
                { Key = "Legs", Label = "Legs", Icon = "rbxassetid://15453352188" },
                { Key = "Back", Label = "Back", Icon = "rbxassetid://15454526777" }
            } do
                local v511 = Templates.FilterButton:Clone()
                v511.Name = val_59.Key
                v511.LayoutOrder = key_85
                v511.Icon.Image = val_59.Icon or ""
                v511.MouseButton1Click:Connect(function() -- line: 2000
                    -- upvalues:
                    --  [1] v284 (ref)
                    --  [2] val_59 (copy)
                    --  [3] t_45 (copy)
                    --  [4] t (copy)
                    --  [5] refreshGrid (copy)

                    v284 = val_59.Key

                    for key_86, val_60 in t_45 do
                        local v512 = key_86 == val_59.Key
                        local v513 = val_60:FindFirstChild("SelectedOutline")

                        if v513 then
                            v513.Visible = v512
                        end

                        val_60.BackgroundColor3 = v512 and t.BUTTON_ON or t.BUTTON
                        v513 = if val_60.Name ~= "All" then if val_60:GetAttribute("Count") ~= 0 then false else true else false
                        val_60.Icon.ImageTransparency = if not v513 then if not v512 then 0.3 else 0 else 0.75
                    end

                    refreshGrid()
                end)
                v511.MouseEnter:Connect(function() -- line: 2007
                    -- upvalues:
                    --  [1] v511 (copy)
                    --  [2] val_59 (copy)
                    --  [3] v35 (ref)
                    --  [4] BackpackUtils_m (copy)

                    local v516 = v511:GetAttribute("Count") or 0
                    local t_72 = { key = val_59.Label, text = nil }
                    local v517 = v511
                    local v518 = if v516 == 1 then "" else "s"
                    t_72.text = `{v516} item{v518} you can smelt.`
                    v35 = v517
                    BackpackUtils_m:ShowHover(t_72)
                end)
                v511.MouseLeave:Connect(function() -- line: 2011
                    -- upvalues:
                    --  [1] v511 (copy)
                    --  [2] v35 (ref)
                    --  [3] BackpackUtils_m (copy)

                    local v519 = v511

                    if v35 ~= nil and (v519 == nil or v35 == v519) then
                        v35 = nil
                        BackpackUtils_m:HideHover()
                    end
                end)
                styleFilter(v511, if val_59.Key ~= v284 then false else true)
                v511.Parent = Filters
                t_45[val_59.Key] = v511
            end

            styleToolButtons()
            Box_1:GetPropertyChangedSignal("Text"):Connect(refreshGrid)

            local _ = function() --[[ redrawSmeltPreview ]] -- line: 2022
                -- upvalues:
                --  [1] v292 (ref)
                --  [2] v287 (ref)
                --  [3] Scroll_1 (copy)
                --  [4] smeltPreviewText (copy)
                --  [5] v291 (ref)
                --  [6] refreshSmeltAction (copy)

                if v292 and v287 then
                    Scroll_1.Returns.Text = smeltPreviewText(v292, v291)
                end

                refreshSmeltAction()
            end

            Quantity_1.Minus.MouseButton1Click:Connect(function() -- line: 2029
                -- upvalues:
                --  [1] v289 (ref)
                --  [2] v290 (ref)
                --  [3] v291 (ref)
                --  [4] smeltBatch (copy)
                --  [5] Quantity_1 (copy)
                --  [6] v292 (ref)
                --  [7] v287 (ref)
                --  [8] Scroll_1 (copy)
                --  [9] smeltPreviewText (copy)
                --  [10] refreshSmeltAction (copy)

                v289 = false
                v290 += 1
                local v523 = v291 - 1
                local v524 = math.max(1, #smeltBatch())
                local v525 = math.floor(tonumber(v523) or 1)
                v291 = math.clamp(v525, 1, v524)
                Quantity_1.CountFrame.CountBox.Text = tostring(v291)
                local Note_2 = Quantity_1.Note
                Note_2.Text = v524 > 1 and `of {v524}` or ""

                if v292 and v287 then
                    Scroll_1.Returns.Text = smeltPreviewText(v292, v291)
                end

                refreshSmeltAction()
            end)
            Quantity_1.Plus.MouseButton1Click:Connect(function() -- line: 2034
                -- upvalues:
                --  [1] v289 (ref)
                --  [2] v290 (ref)
                --  [3] v291 (ref)
                --  [4] smeltBatch (copy)
                --  [5] Quantity_1 (copy)
                --  [6] v292 (ref)
                --  [7] v287 (ref)
                --  [8] Scroll_1 (copy)
                --  [9] smeltPreviewText (copy)
                --  [10] refreshSmeltAction (copy)

                v289 = false
                v290 += 1
                local v527 = v291 + 1
                local v528 = math.max(1, #smeltBatch())
                local v529 = math.floor(tonumber(v527) or 1)
                v291 = math.clamp(v529, 1, v528)
                Quantity_1.CountFrame.CountBox.Text = tostring(v291)
                local Note_3 = Quantity_1.Note
                Note_3.Text = v528 > 1 and `of {v528}` or ""

                if v292 and v287 then
                    Scroll_1.Returns.Text = smeltPreviewText(v292, v291)
                end

                refreshSmeltAction()
            end)
            Quantity_1.CountFrame.CountBox.FocusLost:Connect(function() -- line: 2039
                -- upvalues:
                --  [1] v289 (ref)
                --  [2] v290 (ref)
                --  [3] Quantity_1 (copy)
                --  [4] smeltBatch (copy)
                --  [5] v291 (ref)
                --  [6] v292 (ref)
                --  [7] v287 (ref)
                --  [8] Scroll_1 (copy)
                --  [9] smeltPreviewText (copy)
                --  [10] refreshSmeltAction (copy)

                v289 = false
                v290 += 1
                local Text_2 = Quantity_1.CountFrame.CountBox.Text
                local v531 = math.max(1, #smeltBatch())
                local v532 = math.floor(tonumber(Text_2) or 1)
                v291 = math.clamp(v532, 1, v531)
                Quantity_1.CountFrame.CountBox.Text = tostring(v291)
                local Note_4 = Quantity_1.Note
                Note_4.Text = v531 > 1 and `of {v531}` or ""

                if v292 and v287 then
                    Scroll_1.Returns.Text = smeltPreviewText(v292, v291)
                end

                refreshSmeltAction()
            end)

            local _ = function() --[[ armConfirm ]] -- line: 2045
                -- upvalues:
                --  [1] v289 (ref)
                --  [2] v290 (ref)
                --  [3] refreshSmeltAction (copy)

                if v289 then
                    return false
                end

                v289 = true
                v290 += 1
                local v534 = v290
                refreshSmeltAction()
                task.delay(3, function() -- line: 2053
                    -- upvalues:
                    --  [1] v534 (copy)
                    --  [2] v290 (ref)
                    --  [3] v289 (ref)
                    --  [4] refreshSmeltAction (ref)

                    if v534 == v290 and v289 then
                        v289 = false
                        refreshSmeltAction()
                    end
                end)

                return true
            end

            Action_1.MouseButton1Click:Connect(function() -- line: 2062
                -- upvalues:
                --  [1] v288 (ref)
                --  [2] v293 (ref)
                --  [3] pickedList (copy)
                --  [4] v289 (ref)
                --  [5] v290 (ref)
                --  [6] refreshSmeltAction (copy)
                --  [7] CraftRemote (copy)
                --  [8] t_48 (copy)
                --  [9] t_46 (copy)
                --  [10] styleTile (copy)
                --  [11] showMultiDetails (copy)
                --  [12] Details_1 (copy)
                --  [13] v423 (ref)
                --  [14] refreshGrid (copy)
                --  [15] v285 (ref)
                --  [16] v287 (ref)
                --  [17] smeltBatch (copy)
                --  [18] v291 (ref)
                --  [19] Scroll_1 (copy)
                --  [20] selectSmelt (copy)

                if v288 then
                    return
                end

                if v293 then
                    local v535 = pickedList()
                    local Result_2, t_73

                    if #v535 ~= 0 then
                        local v536

                        if v289 then
                            v536 = false
                        else
                            v289 = true
                            v290 += 1
                            local v537 = v290
                            refreshSmeltAction()
                            task.delay(3, function() -- line: 2053
                                -- upvalues:
                                --  [1] v537 (copy)
                                --  [2] v290 (ref)
                                --  [3] v289 (ref)
                                --  [4] refreshSmeltAction (ref)

                                if v537 == v290 and v289 then
                                    v289 = false
                                    refreshSmeltAction()
                                end
                            end)
                            v536 = true
                        end

                        if v536 then
                            return
                        end

                        v289 = false
                        v290 += 1
                        v288 = true
                        refreshSmeltAction()
                        t_73 = {}

                        for _, val_61 in v535 do
                            table.insert(t_73, val_61.Name)
                        end

                        local Success_2
                        local v538
                        Success_2, Result_2, v538 = pcall(
                            CraftRemote.InvokeServer,
                            CraftRemote,
                            "SmeltMany",
                            t_73
                        )
                        v288 = false
                        table.clear(t_48)

                        for key_88 in t_46 do
                            styleTile(key_88)
                        end

                        showMultiDetails()
                        local v540

                        if Success_2 then
                            if type(Result_2) ~= "table" then
                                v540 = Success_2 and v538 or "Smelting failed."
                                Details_1.Empty.Text = ("<font color='rgb(255, 94, 97)'>%*</font>"):format(
                                    v540
                                )
                            end
                        else
                            v540 = Success_2 and v538 or "Smelting failed."
                            Details_1.Empty.Text = ("<font color='rgb(255, 94, 97)'>%*</font>"):format(
                                v540
                            )
                        end

                        if v423 then
                            return
                        end

                        v423 = true
                        task.delay(0.05, function() -- line: 1837
                            -- upvalues:
                            --  [1] v423 (ref)
                            --  [2] refreshGrid (ref)

                            v423 = false
                            refreshGrid()
                        end)

                        return
                    else
                        return
                    end
                elseif v285 then
                    if v287 then
                        local v541

                        if v289 then
                            v541 = false
                        else
                            v289 = true
                            v290 += 1
                            local v542 = v290
                            refreshSmeltAction()
                            task.delay(3, function() -- line: 2053
                                -- upvalues:
                                --  [1] v542 (copy)
                                --  [2] v290 (ref)
                                --  [3] v289 (ref)
                                --  [4] refreshSmeltAction (ref)

                                if v542 == v290 and v289 then
                                    v289 = false
                                    refreshSmeltAction()
                                end
                            end)
                            v541 = true
                        end

                        if v541 then
                            return
                        end

                        v289 = false
                        v290 += 1
                        v288 = true
                        refreshSmeltAction()
                        local v543 = smeltBatch()
                        local v544 = {}

                        for index_7 = 1, math.min(v291, #v543) do
                            local _ = math.min(v291, #v543)
                            table.insert(v544, v543[index_7].Name)
                        end

                        local v546, v547, v548

                        if #v544 == 1 then
                            v546, v547, v548 = pcall(
                                CraftRemote.InvokeServer,
                                CraftRemote,
                                "Smelt",
                                v544[1]
                            )
                        else
                            v546, v547, v548 = pcall(
                                CraftRemote.InvokeServer,
                                CraftRemote,
                                "SmeltMany",
                                v544
                            )
                        end

                        v288 = false

                        if v285 and v285.Parent then
                            local v549

                            if v546 then
                                if type(v547) ~= "table" then
                                    v549 = v546 and v548 or nil
                                    Scroll_1.Returns.Text = `<font color='rgb(255, 94, 97)'>{v549 or "This item can't be smelted."}</font>`
                                    v287 = false
                                    refreshSmeltAction()
                                else
                                    refreshSmeltAction()
                                end
                            else
                                v549 = v546 and v548 or nil
                                Scroll_1.Returns.Text = `<font color='rgb(255, 94, 97)'>{v549 or "This item can't be smelted."}</font>`
                                v287 = false
                                refreshSmeltAction()
                                refreshSmeltAction()
                            end
                        else
                            v544 = nil

                            for _, val_63 in v543 do
                                if val_63.Parent and t_46[val_63] then
                                    v544 = val_63
                                    break
                                end
                            end

                            selectSmelt(v544)
                        end

                        if v423 then
                            return
                        end

                        v423 = true
                        task.delay(0.05, function() -- line: 1837
                            -- upvalues:
                            --  [1] v423 (ref)
                            --  [2] refreshGrid (ref)

                            v423 = false
                            refreshGrid()
                        end)

                        return
                    else
                        return
                    end
                else
                    return
                end
            end)

            local _ = function(arg120, arg121) --[[ styleTab ]] -- line: 2131
                -- upvalues:
                --  [1] t (copy)

                local SelectedOutline_17 = arg120:FindFirstChild("SelectedOutline")

                if SelectedOutline_17 then
                    SelectedOutline_17.Visible = arg121
                end

                arg120.BackgroundColor3 = arg121 and t.BUTTON_ON or t.BUTTON
                arg120.Label.TextColor3 = arg121 and t.TEXT or t.TEXT_DIM
            end

            local function setMode(arg122) -- line: 2136
                -- upvalues:
                --  [1] v19 (ref)
                --  [2] t_1 (copy)
                --  [3] Title (copy)
                --  [4] Subtitle (copy)
                --  [5] HeaderArt (copy)
                --  [6] CraftView (copy)
                --  [7] SmeltView (copy)
                --  [8] SortMenu (copy)
                --  [9] v35 (ref)
                --  [10] BackpackUtils_m (copy)
                --  [11] v289 (ref)
                --  [12] v290 (ref)
                --  [13] Tabs (copy)
                --  [14] t (copy)
                --  [15] refreshGrid (copy)
                --  [16] refreshSmeltAction (copy)
                --  [17] refreshCategoryCounts (copy)
                --  [18] v197 (ref)
                --  [19] layoutRules (copy)

                v19 = arg122
                local v553 = t_1[arg122]
                Title.Text = v553.Title
                Subtitle.Text = v553.Subtitle
                local attribute = HeaderArt:GetAttribute(arg122 .. "Image")
                local v555 = HeaderArt
                local v554 = attribute

                if typeof(attribute) ~= "string" or not v554 then
                    v554 = ""
                end

                v555.Image = v554
                local v556 = CraftView
                v554 = arg122 == "Craft"
                v556.Visible = v554
                local v557 = SmeltView
                v554 = arg122 == "Smelt"
                v557.Visible = v554
                SortMenu.Visible = false

                if v35 ~= nil then
                    v35 = nil
                    BackpackUtils_m:HideHover()
                end

                v289 = false
                v290 += 1
                local _ = typeof(attribute)

                for _, child_11 in Tabs:GetChildren() do
                    if child_11:IsA("GuiButton") then
                        local v559 = child_11.Name == arg122
                        local SelectedOutline_18 = child_11:FindFirstChild("SelectedOutline")

                        if SelectedOutline_18 then
                            SelectedOutline_18.Visible = v559
                        end

                        child_11.BackgroundColor3 = v559 and t.BUTTON_ON or t.BUTTON
                        child_11.Label.TextColor3 = v559 and t.TEXT or t.TEXT_DIM
                    end
                end

                if arg122 == "Smelt" then
                    refreshGrid()
                    refreshSmeltAction()
                else
                    refreshCategoryCounts()
                    v197()
                end

                task.defer(layoutRules)
            end

            for _, child_12 in Tabs:GetChildren() do
                if child_12:IsA("GuiButton") then
                    child_12.MouseButton1Click:Connect(function() -- line: 2168
                        -- upvalues:
                        --  [1] setMode (copy)
                        --  [2] child_12 (copy)

                        setMode(child_12.Name)
                    end)
                end
            end

            Close.MouseButton1Click:Connect(function() -- line: 2174
                -- upvalues:
                --  [1] Parent (copy)

                Parent.Visible = false
            end)

            local function openModeChanged() -- line: 2178
                -- upvalues:
                --  [1] Parent (copy)
                --  [2] setMode (copy)

                local OpenMode = Parent:GetAttribute("OpenMode")

                if OpenMode == "Craft" or OpenMode == "Smelt" then
                    setMode(OpenMode)
                end
            end

            Parent:GetAttributeChangedSignal("OpenMode"):Connect(openModeChanged)
            Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 2186
                -- upvalues:
                --  [1] Parent (copy)
                --  [2] Scale (copy)
                --  [3] layoutRules (copy)
                --  [4] v19 (ref)
                --  [5] t_46 (copy)
                --  [6] styleTile (copy)
                --  [7] refreshGrid (copy)
                --  [8] t_14 (copy)
                --  [9] styleRow (copy)
                --  [10] v197 (ref)
                --  [11] v54 (ref)
                --  [12] refreshMaterialRows (copy)
                --  [13] renderLines (ref)
                --  [14] Scroll (copy)
                --  [15] qualityLines (copy)
                --  [16] requirementsText (copy)
                --  [17] refreshCraftAction (copy)
                --  [18] v35 (ref)
                --  [19] BackpackUtils_m (copy)
                --  [20] SortMenu (copy)
                --  [21] v289 (ref)
                --  [22] v290 (ref)

                if Parent.Visible then
                    local CurrentCamera_1 = workspace.CurrentCamera

                    if CurrentCamera_1 then
                        local ViewportSize_1 = CurrentCamera_1.ViewportSize
                        Scale.Scale = math.clamp(
                            math.min(ViewportSize_1.X * 0.5 / 900, ViewportSize_1.Y * 0.6 / 580),
                            0.45,
                            0.85
                        )
                    end

                    task.defer(layoutRules)

                    if v19 == "Smelt" then
                        for key_96 in t_46 do
                            styleTile(key_96)
                        end

                        refreshGrid()

                        return
                    end

                    for _, val_66 in t_14 do
                        styleRow(val_66)
                    end

                    v197()
                    local v563 = v54

                    if v563 then
                        if v563.Kind ~= "Recipe" then
                            return
                        end

                        refreshMaterialRows(v563.Info)
                        renderLines(Scroll.Quality, (qualityLines(v563.Info)))
                        Scroll.Requirements.Text = requirementsText(v563.Info)
                        refreshCraftAction()

                        return
                    end
                else
                    if v35 ~= nil then
                        v35 = nil
                        BackpackUtils_m:HideHover()
                    end

                    SortMenu.Visible = false
                    v289 = false
                    v290 += 1
                end
            end)

            function CraftRemote.OnClientInvoke(arg123, arg124, arg125) --[[ onClientInvoke ]] -- line: 2207
                -- upvalues:
                --  [1] Parent (copy)
                --  [2] Services_m (copy)
                --  [3] RunService (copy)
                --  [4] v4 (copy)

                if arg123 == "Interact" and not Parent.Visible then
                    _G.PROMPTS[arg125] = true
                    arg125.Enabled = false
                    Parent:SetAttribute("OpenMode", nil)
                    Parent:SetAttribute("OpenMode", "Craft")
                    Parent.Visible = true
                    local v565 = Services_m.Maid.new()
                    v565:GiveTask(RunService.Heartbeat:Connect(function() -- line: 2217
                        -- upvalues:
                        --  [1] Parent (ref)
                        --  [2] v4 (ref)
                        --  [3] arg124 (copy)
                        --  [4] v565 (copy)
                        --  [5] arg125 (copy)

                        if not Parent.Visible or v4 and (v4.PrimaryPart and (v4.PrimaryPart.Position - arg124.Position).Magnitude > 10) then
                            v565:Destroy()
                            Parent.Visible = false
                            arg125.Enabled = true
                        end
                    end))
                end
            end

            local v566 = 0
            local v567 = 0
            RunService.Heartbeat:Connect(function(deltaTime) -- line: 2230
                -- upvalues:
                --  [1] Parent (copy)
                --  [2] v566 (ref)
                --  [3] v567 (ref)
                --  [4] v19 (ref)
                --  [5] v54 (ref)
                --  [6] refreshMaterialRows (copy)
                --  [7] renderLines (ref)
                --  [8] Scroll (copy)
                --  [9] qualityLines (copy)
                --  [10] requirementsText (copy)
                --  [11] refreshCraftAction (copy)
                --  [12] t_14 (copy)
                --  [13] styleRow (copy)
                --  [14] v53 (ref)
                --  [15] v197 (ref)
                --  [16] t_46 (copy)
                --  [17] styleTile (copy)
                --  [18] v423 (ref)
                --  [19] refreshGrid (copy)

                if not Parent.Visible then
                    return
                end

                v566 += deltaTime
                v567 += deltaTime

                if v566 >= 0.2 then
                    v566 = 0

                    if v19 == "Craft" and v54 then
                        local v568 = v54

                        if v568 and v568.Kind == "Recipe" then
                            refreshMaterialRows(v568.Info)
                            renderLines(Scroll.Quality, (qualityLines(v568.Info)))
                            Scroll.Requirements.Text = requirementsText(v568.Info)
                            refreshCraftAction()
                        end
                    end
                end

                if v567 >= 1 then
                    v567 = 0

                    if v19 == "Craft" then
                        for _, val_67 in t_14 do
                            styleRow(val_67)
                        end

                        if v53 then
                            v197()

                            return
                        end
                    else
                        for key_99 in t_46 do
                            styleTile(key_99)
                        end

                        if v423 then
                            return
                        end

                        v423 = true
                        task.delay(0.05, function() -- line: 1837
                            -- upvalues:
                            --  [1] v423 (ref)
                            --  [2] refreshGrid (ref)

                            v423 = false
                            refreshGrid()
                        end)
                    end
                end
            end)
            ensureCategory("All")
            setSort("Default")
            setCraftCount(1)

            for _, child_13 in Schematics:GetChildren() do
                onRecipeAdded(child_13)
            end

            Schematics.ChildAdded:Connect(onRecipeAdded)

            for _, child_14 in Inventory:GetChildren() do
                onInventorySchematic(child_14)
                addTile(child_14)
            end

            Inventory.ChildAdded:Connect(function(child_15) -- line: 2271
                -- upvalues:
                --  [1] onInventorySchematic (copy)
                --  [2] addTile (copy)

                onInventorySchematic(child_15)
                addTile(child_15)
            end)
            Inventory.ChildRemoved:Connect(function(child_16) -- line: 2275
                -- upvalues:
                --  [1] t_46 (copy)
                --  [2] removeTile (copy)

                if t_46[child_16] then
                    removeTile(child_16)
                end
            end)
            local CurrentCamera_2 = workspace.CurrentCamera

            if CurrentCamera_2 then
                CurrentCamera_2:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
            end

            updateScale()
            selectEntry(nil)
            selectSmelt(nil)
            setMode("Craft")
            openModeChanged()
        end
    end
end
