-- Decompiled with Veyra harvester
-- Instance: StarterGui.Permanent.Window.Shop.MarketClient
-- Class: LocalScript
-- bytes: 126702

do
    do
        local Services_m = require(game:GetService("ReplicatedFirst").Services)
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RunService = game:GetService("RunService")
        local MarketplaceService = game:GetService("MarketplaceService")
        local Modules = ReplicatedStorage.Modules
        local StatManager_m = require(Modules.StatManager)
        local Icon_m = require(Modules.Icon)
        local Products_m = require(Modules.Products)
        local ViewportHandle_m = require(Modules.ViewportHandle)
        local Items_m = require(Modules.Items)
        local Race_m = require(Modules.Race)
        local GrimoireRarity_m = require(Modules.GrimoireRarity)
        local BackpackUtils_m = require(Modules.BackpackUtils)
        local Formatter_m = require(Modules.Formatter)
        local DonationTitles_m = require(Modules.DonationTitles)
        local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
        local v4 = StatManager_m.require(v2)
        local Categories = BackpackUtils_m.Categories
        local MarketUtils = ReplicatedStorage.MarketUtils
        local Items = MarketUtils.Items
        local Timer = MarketUtils.Timer
        local _ = MarketUtils.Updating
        local v5 = Services_m.Maid.new()
        local Parent = script.Parent
        Parent.Visible = false
        local v6 = Parent.Pages
        local v7 = v6.Content
        local Items_1 = v7.Items
        local GiftingTo = v7.GiftingTo
        local Recipients = Parent.Recipients
        local Mail = Parent.Mail
        local Essence = Items_1.Essence
        local Featured = Items_1.Featured
        local Market = Items_1.Market
        local v8 = Market:FindFirstChild("Items") or Market
        local ConfirmFrame = Parent.ConfirmFrame
        local GiftRemotes = ReplicatedStorage:WaitForChild("GiftRemotes")
        local Request = GiftRemotes:WaitForChild("Request")
        local Updated = GiftRemotes:WaitForChild("Updated")
        local v9 = nil
        local v10 = nil
        local t = {}

        local _ = function(arg1) --[[ promptSelf ]] -- line: 72
            -- upvalues:
            --  [1] Request (copy)
            --  [2] MarketplaceService (copy)
            --  [3] v2 (copy)

            if not pcall(Request.InvokeServer, Request, "PromptSelf", arg1) then
                MarketplaceService:PromptProductPurchase(v2, arg1)
            end
        end

        local _ = function(arg2) --[[ giftProduct ]] -- line: 80
            -- upvalues:
            --  [1] v9 (ref)
            --  [2] Request (copy)

            if not v9 then
                return
            end

            local Success, Result = pcall(
                Request.InvokeServer,
                Request,
                "PromptGift",
                arg2,
                v9.UserId
            )

            if not Success then
                warn(`[MarketClient] gift prompt failed: {Result}`)
            end
        end

        local Text = ConfirmFrame.Display.Text
        local Text_1 = ConfirmFrame.Accept.Label.Text

        local _ = function(arg3) --[[ headshot ]] -- line: 94
            return `rbxthumb://type=AvatarHeadShot&id={arg3}&w=150&h=150`
        end

        local _ = function() --[[ applyConfirmMode ]] -- line: 98
            -- upvalues:
            --  [1] v9 (ref)
            --  [2] ConfirmFrame (copy)
            --  [3] Text (copy)
            --  [4] Text_1 (copy)

            if v9 then
                local Display = ConfirmFrame.Display
                local v11 = string.upper(v9.Name)
                Display.Text = `GIFT TO <font color='#7fd36f'>@{v11}</font>`
                ConfirmFrame.Accept.Label.Text = "Gift"

                return
            end

            ConfirmFrame.Display.Text = Text
            ConfirmFrame.Accept.Label.Text = Text_1
        end

        local function setGiftTarget(arg4) -- line: 108
            -- upvalues:
            --  [1] v9 (ref)
            --  [2] GiftingTo (copy)
            --  [3] ConfirmFrame (copy)
            --  [4] t (copy)

            v9 = arg4
            local v12 = GiftingTo
            v12.Visible = arg4 ~= nil

            if arg4 then
                GiftingTo.Recipient.User.Text = `@{arg4.Name}`
                GiftingTo.Recipient.Avatar.Image = `rbxthumb://type=AvatarHeadShot&id={arg4.UserId}&w=150&h=150`
            end

            ConfirmFrame.Visible = false

            for _, val in t do
                task.spawn(val)
            end
        end

        local Frame = Recipients.Frame
        local List = Frame.Recipients.List
        local RecipientTemplate = List.RecipientTemplate
        local SearchBox = Frame.SearchBar.Contents.SearchBox
        RecipientTemplate.Visible = false
        Recipients.Visible = false
        Mail.Visible = false
        GiftingTo.Visible = false
        local v14 = false

        local _ = function(arg5) --[[ cleanQuery ]] -- line: 134
            return (arg5:gsub("^@", ""):gsub("%s", ""))
        end

        local _ = function(arg6) --[[ isValidUsername ]] -- line: 140
            return if #arg6 >= 3 then if #arg6 <= 20 then not arg6:find("[^%w_]") else false else false
        end

        local function closeRecipients() -- line: 144
            -- upvalues:
            --  [1] Recipients (copy)
            --  [2] v10 (ref)

            Recipients.Visible = false
            v10 = nil
        end

        local _ = function(arg7) --[[ pickRecipient ]] -- line: 149
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] Recipients (copy)
            --  [3] setGiftTarget (copy)

            local v16 = v10
            v10 = nil
            Recipients.Visible = false
            setGiftTarget(arg7)

            if v16 then
                v16()
            end
        end

        local function addRecipientRow(arg8, arg9, arg10, arg11) -- line: 159
            -- upvalues:
            --  [1] RecipientTemplate (copy)
            --  [2] List (copy)

            local v17 = RecipientTemplate:Clone()
            v17.Name = "Row"
            v17:SetAttribute("Row", true)
            v17.Visible = true
            v17.LayoutOrder = arg10
            v17.User.Text = arg8

            if arg9 then
                v17.Avatar.Image = `rbxthumb://type=AvatarHeadShot&id={arg9}&w=150&h=150` or ""
            else
                v17.Avatar:Destroy()
            end

            if arg11 then
                v17.Activated:Connect(function() -- line: 174
                    -- upvalues:
                    --  [1] arg11 (copy)
                    --  [2] v17 (copy)

                    arg11(v17)
                end)
            else
                v17.AutoButtonColor = false
            end

            v17.Parent = List

            return v17
        end

        local function lookupUsername(arg12, arg13) -- line: 185
            -- upvalues:
            --  [1] v14 (ref)
            --  [2] Request (copy)
            --  [3] v10 (ref)
            --  [4] Recipients (copy)
            --  [5] setGiftTarget (copy)

            if v14 then
                return
            end

            v14 = true

            if arg13 then
                arg13.User.Text = "Searching..."
            end

            local Success_1, Result_1, v18 = pcall(Request.InvokeServer, Request, "Lookup", arg12)
            v14 = false

            if Success_1 then
                if type(Result_1) == "table" then
                    local v19 = v10
                    v10 = nil
                    Recipients.Visible = false
                    setGiftTarget(Result_1)

                    if v19 then
                        v19()

                        return
                    end
                elseif arg13 and arg13.Parent then
                    local v20 = Success_1 and v18 or "Search failed. Try again."
                    arg13.User.Text = v20
                end

                return
            end

            if arg13 and arg13.Parent then
                arg13.User.Text = Success_1 and v18 or "Search failed. Try again."
            end
        end

        local function populateRecipients() -- line: 204
            -- upvalues:
            --  [1] List (copy)
            --  [2] SearchBox (copy)
            --  [3] Players (copy)
            --  [4] v2 (copy)
            --  [5] addRecipientRow (copy)
            --  [6] v10 (ref)
            --  [7] Recipients (copy)
            --  [8] setGiftTarget (copy)
            --  [9] lookupUsername (copy)

            for _, child in List:GetChildren() do
                if child:GetAttribute("Row") then
                    child:Destroy()
                end
            end

            local v21 = SearchBox.Text:gsub("^@", ""):gsub("%s", "")
            local v22 = v21:lower()
            local v23 = false
            local v24 = 0
            local players = Players:GetPlayers()
            table.sort(players, function(arg14, arg15) -- line: 217
                return arg14.Name:lower() < arg15.Name:lower() and true
            end)
            local v27

            for key_2, val_1 in players do
                if val_1 ~= v2 then
                    if v22 ~= "" then
                        if not val_1.Name:lower():find(v22, 1, true) then
                            if val_1.DisplayName:lower():find(v22, 1, true) then
                                if val_1.Name:lower() == v22 then
                                    v23 = true
                                end

                                v24 += 1
                                v27 = if val_1.DisplayName ~= val_1.Name then `{val_1.DisplayName} (@{val_1.Name})` or `@{val_1.Name}` else `@{val_1.Name}`
                                addRecipientRow(v27, val_1.UserId, key_2 + 1, function() -- line: 234
                                    -- upvalues:
                                    --  [1] val_1 (copy)
                                    --  [2] v10 (ref)
                                    --  [3] Recipients (ref)
                                    --  [4] setGiftTarget (ref)

                                    local t_1 = {
                                        UserId = val_1.UserId,
                                        Name = val_1.Name,
                                        DisplayName = val_1.DisplayName
                                    }
                                    local v28 = v10
                                    v10 = nil
                                    Recipients.Visible = false
                                    setGiftTarget(t_1)

                                    if v28 then
                                        v28()
                                    end
                                end)
                            end
                        else
                            if val_1.Name:lower() == v22 then
                                v23 = true
                            end

                            v24 += 1
                            v27 = if val_1.DisplayName ~= val_1.Name then `{val_1.DisplayName} (@{val_1.Name})` or `@{val_1.Name}` else `@{val_1.Name}`
                            addRecipientRow(v27, val_1.UserId, key_2 + 1, function() -- line: 234
                                -- upvalues:
                                --  [1] val_1 (copy)
                                --  [2] v10 (ref)
                                --  [3] Recipients (ref)
                                --  [4] setGiftTarget (ref)

                                local t_2 = {
                                    UserId = val_1.UserId,
                                    Name = val_1.Name,
                                    DisplayName = val_1.DisplayName
                                }
                                local v29 = v10
                                v10 = nil
                                Recipients.Visible = false
                                setGiftTarget(t_2)

                                if v29 then
                                    v29()
                                end
                            end)
                        end
                    else
                        if val_1.Name:lower() == v22 then
                            v23 = true
                        end

                        v24 += 1
                        v27 = if val_1.DisplayName ~= val_1.Name then `{val_1.DisplayName} (@{val_1.Name})` or `@{val_1.Name}` else `@{val_1.Name}`
                        addRecipientRow(v27, val_1.UserId, key_2 + 1, function() -- line: 234
                            -- upvalues:
                            --  [1] val_1 (copy)
                            --  [2] v10 (ref)
                            --  [3] Recipients (ref)
                            --  [4] setGiftTarget (ref)

                            local t_3 = {
                                UserId = val_1.UserId,
                                Name = val_1.Name,
                                DisplayName = val_1.DisplayName
                            }
                            local v30 = v10
                            v10 = nil
                            Recipients.Visible = false
                            setGiftTarget(t_3)

                            if v30 then
                                v30()
                            end
                        end)
                    end
                end
            end

            if (if #v21 >= 3 then if #v21 <= 20 then not v21:find("[^%w_]") else false else false) and not v23 and v22 ~= v2.Name:lower() then
                addRecipientRow(`Find @{v21} (any server)`, nil, 0, function(arg16) -- line: 240
                    -- upvalues:
                    --  [1] lookupUsername (ref)
                    --  [2] v21 (copy)

                    lookupUsername(v21, arg16)
                end)

                return
            end

            if v24 == 0 then
            end
        end

        local _ = function(arg17) --[[ openRecipients ]] -- line: 248
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] Mail (copy)
            --  [3] SearchBox (copy)
            --  [4] populateRecipients (copy)
            --  [5] Recipients (copy)

            v10 = arg17
            Mail.Visible = false
            SearchBox.Text = ""
            populateRecipients()
            Recipients.Visible = true
        end

        local _ = function(arg18) --[[ requestGift ]] -- line: 257
            -- upvalues:
            --  [1] v9 (ref)
            --  [2] v10 (ref)
            --  [3] Mail (copy)
            --  [4] SearchBox (copy)
            --  [5] populateRecipients (copy)
            --  [6] Recipients (copy)

            if v9 then
                arg18()

                return
            end

            v10 = arg18
            Mail.Visible = false
            SearchBox.Text = ""
            populateRecipients()
            Recipients.Visible = true
        end

        SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- line: 265
            -- upvalues:
            --  [1] Recipients (copy)
            --  [2] populateRecipients (copy)

            if Recipients.Visible then
                populateRecipients()
            end
        end)
        SearchBox.FocusLost:Connect(function(arg19) -- line: 271
            -- upvalues:
            --  [1] Recipients (copy)
            --  [2] SearchBox (copy)
            --  [3] Players (copy)
            --  [4] v2 (copy)
            --  [5] v10 (ref)
            --  [6] setGiftTarget (copy)
            --  [7] List (copy)
            --  [8] lookupUsername (copy)

            if not arg19 or not Recipients.Visible then
                return
            end

            local v34 = SearchBox.Text:gsub("^@", ""):gsub("%s", "")

            if not (if #v34 >= 3 then if #v34 <= 20 then not v34:find("[^%w_]") else false else false) then
                return
            end

            for _, val_2 in Players:GetPlayers() do
                if val_2 ~= v2 then
                    if val_2.Name:lower() == v34:lower() then
                        local t_4 = {
                            UserId = val_2.UserId,
                            Name = val_2.Name,
                            DisplayName = val_2.DisplayName
                        }
                        local v37 = v10
                        v10 = nil
                        Recipients.Visible = false
                        setGiftTarget(t_4)

                        if v37 then
                            v37()
                        end

                        return
                    end
                end
            end

            local v35 = nil

            for _, child_1 in List:GetChildren() do
                if child_1:GetAttribute("Row") and child_1.LayoutOrder == 0 then
                    v35 = child_1
                end
            end

            lookupUsername(v34, v35)
        end)
        do
            local function refreshIfOpen() -- line: 294
                -- upvalues:
                --  [1] Recipients (copy)
                --  [2] populateRecipients (copy)

                if Recipients.Visible then
                    populateRecipients()
                end
            end

            Players.PlayerAdded:Connect(refreshIfOpen)
            Players.PlayerRemoving:Connect(function() -- line: 300
                -- upvalues:
                --  [1] refreshIfOpen (copy)

                task.defer(refreshIfOpen)
            end)
        end
        Frame.Close.Activated:Connect(closeRecipients)
        Recipients.DisableClick.Activated:Connect(closeRecipients)
        v6.Buttons.Gift.Activated:Connect(function() -- line: 307
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] Mail (copy)
            --  [3] SearchBox (copy)
            --  [4] populateRecipients (copy)
            --  [5] Recipients (copy)

            v10 = nil
            Mail.Visible = false
            SearchBox.Text = ""
            populateRecipients()
            Recipients.Visible = true
        end)
        GiftingTo.Recipient.Activated:Connect(function() -- line: 310
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] Mail (copy)
            --  [3] SearchBox (copy)
            --  [4] populateRecipients (copy)
            --  [5] Recipients (copy)

            v10 = nil
            Mail.Visible = false
            SearchBox.Text = ""
            populateRecipients()
            Recipients.Visible = true
        end)
        GiftingTo.Recipient.Close.Activated:Connect(function() -- line: 313
            -- upvalues:
            --  [1] v9 (ref)
            --  [2] GiftingTo (copy)
            --  [3] ConfirmFrame (copy)
            --  [4] t (copy)

            v9 = nil
            GiftingTo.Visible = false
            ConfirmFrame.Visible = false

            for _, val_3 in t do
                task.spawn(val_3)
            end
        end)
        Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 317
            -- upvalues:
            --  [1] Parent (copy)
            --  [2] Recipients (copy)
            --  [3] v10 (ref)
            --  [4] Mail (copy)

            if not Parent.Visible then
                Recipients.Visible = false
                v10 = nil
                Mail.Visible = false
            end
        end)
        local Frame_1 = Mail.Frame
        local Top = Frame_1.Top
        local Count = Frame_1.Count
        local Body = Frame_1.Body
        local List_1 = Body.List
        local GiftTemplate = script.GiftTemplate
        local Badge = v6.Buttons.Mail:FindFirstChild("Badge")
        local v38 = "Inbox"
        local v39 = nil
        local v40 = false
        local v41 = nil

        local function describeGift(arg20) -- line: 340
            -- upvalues:
            --  [1] Formatter_m (copy)

            if type(arg20) ~= "table" then
                return "a gift"
            end

            if arg20.Type == "SaveSlot" then
                local v42 = tonumber(arg20.Amount) or 1

                if v42 == 1 then
                    return "a Save Slot"
                end

                return `x{v42} Save Slots`
            else
                local v43

                if arg20.Type == "Essence" then
                    v43 = Formatter_m.addCommas(arg20.Amount or 0)

                    return `{v43} Essence`
                end

                if arg20.Type == "Bundle" or arg20.Type == "Unlock" then
                    v43 = arg20.Name or (arg20.Bundle or (arg20.Unlock or "gift"))

                    return `the {v43}`
                end

                return `x{arg20.Amount or 1} {arg20.Item or "?"}`
            end
        end

        local _ = function(arg21) --[[ timeAgo ]] -- line: 357
            arg21 = math.max(0, arg21 or 0)

            if arg21 < 60 then
                return "just now"
            end

            if arg21 < 3600 then
                local v44 = math.floor(arg21 / 60)

                return `{v44}m ago`
            end

            if arg21 < 86400 then
                local v45 = math.floor(arg21 / 3600)

                return `{v45}h ago`
            end

            local v46 = math.floor(arg21 / 86400)

            return `{v46}d ago`
        end

        local _ = function(arg22) --[[ setBadge ]] -- line: 369
            -- upvalues:
            --  [1] Badge (copy)

            if not Badge then
                return
            end

            Badge.Visible = arg22 > 0
            Badge.Text = if arg22 > 99 then "99+" else tostring(arg22)
        end

        do
            local v49 = nil

            local function claimGift(arg23, arg24) -- line: 379
                -- upvalues:
                --  [1] Request (copy)
                --  [2] v39 (ref)
                --  [3] v49 (ref)
                --  [4] List_1 (copy)

                local Claim = arg24.Claim

                if Claim:GetAttribute("Busy") then
                    return
                end

                Claim:SetAttribute("Busy", true)
                Claim.Text = "..."
                local Success_2, Result_2, v50, v51 = pcall(
                    Request.InvokeServer,
                    Request,
                    "Claim",
                    arg23.Id
                )

                if Success_2 and type(v51) == "table" then
                    v39 = v51
                    v49()

                    if not Result_2 and v50 then
                        local v52 = List_1:FindFirstChild(arg23.Id)

                        if v52 then
                            v52.When.Text = v50
                        end
                    end

                    return
                end

                if arg24.Parent then
                    Claim:SetAttribute("Busy", nil)
                    Claim.Text = if Success_2 and Result_2 then "Claimed" else "Claim"

                    if (not Success_2 or not Result_2) and v50 then
                        arg24.When.Text = v50
                    end
                end
            end

            function v49() --[[ renderMail ]] -- line: 411
                -- upvalues:
                --  [1] List_1 (copy)
                --  [2] v39 (ref)
                --  [3] Body (copy)
                --  [4] Top (copy)
                --  [5] v38 (ref)
                --  [6] v41 (ref)
                --  [7] Badge (copy)
                --  [8] Count (copy)
                --  [9] GiftTemplate (copy)
                --  [10] describeGift (copy)
                --  [11] claimGift (copy)

                for _, child_2 in List_1:GetChildren() do
                    if child_2:GetAttribute("Row") then
                        child_2:Destroy()
                    end
                end

                local v54 = v39
                local Loading = Body.Loading
                Loading.Visible = v54 == nil
                local History = Top.History
                History.Text = if v38 ~= "History" then "History" else "Inbox"

                if not v54 then
                    Body.Empty.Visible = false

                    return
                end

                local v56 = v54.Unclaimed or {}
                v41 = #v56
                local v57 = #v56

                if Badge then
                    local v58 = Badge
                    v58.Visible = v57 > 0
                    local v60 = Badge
                    v60.Text = if v57 > 99 then "99+" else tostring(v57)
                end

                v57 = v54.Now or os.time()

                if v38 == "Inbox" then
                    local v61 = Count
                    local v62 = #v56
                    local v63 = if #v56 ~= 1 then "s" else ""
                    v61.Text = ("You have %* unclaimed gift%*."):format(v62, v63)
                    Body.Empty.Visible = if #v56 ~= 0 then false else true

                    for index = #v56, 1, -1 do
                        local v64 = v56[index]
                        local v65 = GiftTemplate:Clone()
                        v65.Name = v64.Id
                        v65:SetAttribute("Row", true)
                        v65.LayoutOrder = #v56 - index
                        v65.Avatar.Image = `rbxthumb://type=AvatarHeadShot&id={v64.From}&w=150&h=150`
                        local From = v65.From
                        local v66 = if v64.Returned then `Returned by @{v64.FromName}` or `From @{v64.FromName}` else `From @{v64.FromName}`
                        From.Text = v66
                        v65.Contents.Text = describeGift(v64.Contents)
                        local When = v65.When
                        local v67 = math.max(0, v57 - (v64.Time or v57) or 0)

                        if v67 < 60 then
                            v66 = "just now"
                        elseif v67 < 3600 then
                            local v68 = math.floor(v67 / 60)
                            v66 = `{v68}m ago`
                        elseif v67 < 86400 then
                            local v69 = math.floor(v67 / 3600)
                            v66 = `{v69}h ago`
                        else
                            local v70 = math.floor(v67 / 86400)
                            v66 = `{v70}d ago`
                        end

                        When.Text = v66
                        v65.Status.Visible = false
                        v65.Claim.Visible = true
                        v65.Claim.Activated:Connect(function() -- line: 452
                            -- upvalues:
                            --  [1] claimGift (ref)
                            --  [2] v64 (copy)
                            --  [3] v65 (copy)

                            claimGift(v64, v65)
                        end)
                        v65.Parent = List_1
                    end
                else
                    local v71 = v54.History or {}
                    Count.Text = "Gift History"
                    Body.Empty.Text = "No gifts sent or received yet."
                    local Empty_1 = Body.Empty
                    Empty_1.Visible = #v71 == 0
                    local v76, v77, v78

                    for key_7, val_4 in v71 do
                        local v73 = val_4.Kind == "Sent"
                        local v74 = val_4.Kind == "Returned"
                        local v75 = GiftTemplate:Clone()
                        v75.Name = `{val_4.Kind}_{key_7}`
                        v75:SetAttribute("Row", true)
                        v75.LayoutOrder = key_7

                        if val_4.System then
                            v75.Avatar.Image = `rbxthumb://type=GameIcon&id={game.GameId}&w=150&h=150`
                            v75.From.Text = `From {val_4.OtherName or "the game"}`
                        else
                            v75.Avatar.Image = `rbxthumb://type=AvatarHeadShot&id={val_4.Other}&w=150&h=150`
                            local From_2 = v75.From

                            if v73 then
                                v76 = `Sent to @{val_4.OtherName}`

                                if not v76 then
                                    v76 = if v74 then `Returned to @{val_4.OtherName}` or `From @{val_4.OtherName}` else `From @{val_4.OtherName}`
                                end
                            else
                                v76 = if v74 then `Returned to @{val_4.OtherName}` or `From @{val_4.OtherName}` else `From @{val_4.OtherName}`
                            end

                            From_2.Text = v76
                        end

                        if val_4.System then
                            if type(val_4.Contents) == "table" and val_4.Contents.Name then
                                v75.Contents.Text = val_4.Contents.Name
                            else
                                local Contents_1 = v75.Contents
                                v77 = describeGift(val_4.Contents)
                                v78 = if val_4.Via ~= "Robux" then "" else " (Robux)"
                                Contents_1.Text = v77 .. v78
                            end
                        else
                            local Contents_2 = v75.Contents
                            v77 = describeGift(val_4.Contents)
                            v78 = if val_4.Via ~= "Robux" then "" else " (Robux)"
                            Contents_2.Text = v77 .. v78
                        end

                        local When_1 = v75.When
                        local v79 = math.max(0, v57 - (val_4.Time or v57) or 0)

                        if v79 < 60 then
                            v77 = "just now"
                        elseif v79 < 3600 then
                            local v80 = math.floor(v79 / 60)
                            v77 = `{v80}m ago`
                        elseif v79 < 86400 then
                            local v81 = math.floor(v79 / 3600)
                            v77 = `{v81}h ago`
                        else
                            local v82 = math.floor(v79 / 86400)
                            v77 = `{v82}d ago`
                        end

                        local v83 = not v73 and (val_4.Slot and ` \194\183 Slot {val_4.Slot}`) or ""
                        When_1.Text = v77 .. v83
                        v75.Claim.Visible = false
                        v75.Status.Visible = true
                        v75.Status.Text = if v73 then "Sent" else if not v74 then "Claimed" else "Returned"
                        v75.Status.TextColor3 = v73 and Color3.fromRGB(150, 190, 255) or (v74 and Color3.fromRGB(
                            230,
                            180,
                            120
                        ) or Color3.fromRGB(150, 220, 140))
                        v75.Parent = List_1
                    end
                end
            end

            local function loadMail() -- line: 493
                -- upvalues:
                --  [1] v40 (ref)
                --  [2] Request (copy)
                --  [3] v39 (ref)
                --  [4] v49 (ref)
                --  [5] Body (copy)

                if v40 then
                    return
                end

                v40 = true
                local Success_3, Result_3, v85 = pcall(Request.InvokeServer, Request, "GetMail")
                v40 = false

                if Success_3 and type(Result_3) == "table" then
                    v39 = Result_3
                    v49()

                    return
                end

                if not v39 then
                    Body.Loading.Visible = true
                    Body.Loading.Text = Success_3 and v85 or "Couldn't load your mail."
                end
            end

            local function openMail() -- line: 510
                -- upvalues:
                --  [1] Recipients (copy)
                --  [2] v10 (ref)
                --  [3] v38 (ref)
                --  [4] Body (copy)
                --  [5] v49 (ref)
                --  [6] Mail (copy)
                --  [7] loadMail (copy)

                Recipients.Visible = false
                v10 = nil
                v38 = "Inbox"
                Body.Loading.Text = "Loading..."
                v49()
                Mail.Visible = true
                task.spawn(loadMail)
            end

            v6.Buttons.Mail.Activated:Connect(openMail)
            Top.Close.Activated:Connect(function() -- line: 520
                -- upvalues:
                --  [1] Mail (copy)

                Mail.Visible = false
            end)
            Mail.DisableClick.Activated:Connect(function() -- line: 523
                -- upvalues:
                --  [1] Mail (copy)

                Mail.Visible = false
            end)
            Top.History.Activated:Connect(function() -- line: 526
                -- upvalues:
                --  [1] v38 (ref)
                --  [2] v49 (ref)

                v38 = if v38 ~= "Inbox" then "Inbox" else "History"
                v49()
            end)
            Updated.OnClientEvent:Connect(function(arguments) -- line: 532
                -- upvalues:
                --  [1] Badge (copy)
                --  [2] Mail (copy)
                --  [3] v41 (ref)
                --  [4] loadMail (copy)

                if type(arguments) ~= "number" then
                    return
                end

                if Badge then
                    Badge.Visible = arguments > 0
                    Badge.Text = if arguments > 99 then "99+" else tostring(arguments)
                end

                if Mail.Visible and arguments ~= v41 then
                    task.delay(0.5, loadMail)
                end
            end)
            task.delay(3, loadMail)
        end
        local _ = Color3.fromRGB(43, 197, 152)
        local _ = Color3.fromRGB(130, 130, 130)
        do
            local t_5 = { 1, 5, 10, 20 }
            local v90 = 1
            local v91 = t_5[v90]
            local v92 = 0
            local Slider_m = require(Modules.Slider)
            local Split = ConfirmFrame.Split
            local Holder = Split.Holder
            local v93 = 0
            local v94 = 0
            local v95 = nil
            local v96 = false
            local t_6 = {
                ["Race Reroll"] = true,
                ["Family Name Reroll"] = true,
                ["Magic Reroll"] = true
            }
            local color_2 = Color3.fromRGB(255, 255, 255)
            local v97 = false

            local _ = function() --[[ isRandomRestricted ]] -- line: 597
                -- upvalues:
                --  [1] v2 (copy)

                return if v2:GetAttribute("PaidRandomItemsRestricted") == false then false else true
            end

            local v99 = Split.Warning:Clone()
            v99.Name = "RegionWarning"

            for _, child_3 in v99:GetChildren() do
                child_3:Destroy()
            end

            v99.AnchorPoint = Vector2.zero
            v99.Position = UDim2.new(0, 14, 0, 82)
            v99.Size = UDim2.new(1, -28, 0, 44)
            v99.TextScaled = false
            v99.TextSize = 12
            v99.TextWrapped = true
            v99.TextXAlignment = Enum.TextXAlignment.Center
            v99.TextYAlignment = Enum.TextYAlignment.Top
            v99.TextColor3 = color_2
            v99.RichText = true
            v99.Visible = false
            v99.Parent = ConfirmFrame
            local v100 = v99:Clone()
            v100.Name = "GiftTopUpNote"
            v100.Visible = false
            v100.Parent = ConfirmFrame
            ConfirmFrame.Amount.TextWrapped = false

            local _ = function() --[[ getEssence ]] -- line: 631
                -- upvalues:
                --  [1] v4 (copy)

                return v4:GetStat("Essence") or 0
            end

            local _ = function() --[[ getLockedEssence ]] -- line: 635
                -- upvalues:
                --  [1] v4 (copy)

                return v4:GetStat("LockedEssence") or 0
            end

            local _ = function() --[[ getMinEssence ]] -- line: 640
                -- upvalues:
                --  [1] v93 (ref)
                --  [2] v4 (copy)

                return (math.max(0, v93 - (v4:GetStat("LockedEssence") or 0)))
            end

            local function showSplit(arg26) -- line: 644
                -- upvalues:
                --  [1] v94 (ref)
                --  [2] v93 (ref)
                --  [3] Holder (copy)
                --  [4] v4 (copy)
                --  [5] Split (copy)
                --  [6] Formatter_m (copy)
                --  [7] v96 (ref)

                v94 = v93 - arg26
                local v102 = v93 > 0 and arg26 / v93 or 1
                Holder.EssenceFill.Size = UDim2.fromScale(v102, 1)
                Holder.LockedFill.Size = UDim2.fromScale(1 - v102, 1)
                local Unavailable = Holder.Unavailable
                local FromScale = UDim2.fromScale
                local v104 = v93 > 0 and math.max(0, v93 - (v4:GetStat("LockedEssence") or 0)) / v93 or 0
                Unavailable.Size = FromScale(v104, 1)
                local EssenceLabel = Split.EssenceLabel
                local v105 = Formatter_m.addCommas(arg26)
                EssenceLabel.Text = `Essence {v105}`
                local LockedLabel = Split.LockedLabel
                local v106 = Formatter_m.addCommas(v94)
                LockedLabel.Text = `Locked {v106}`
                local v107 = false
                local Warning = Split.Warning

                if v94 > 0 then
                    v107 = not v96
                end

                Warning.Visible = v107
            end

            local function onSliderChanged(arg27) -- line: 658
                -- upvalues:
                --  [1] v93 (ref)
                --  [2] v4 (copy)
                --  [3] showSplit (copy)

                local v109 = math.max(0, v93 - (v4:GetStat("LockedEssence") or 0))
                showSplit((math.clamp(arg27, v109, v93)))
            end

            local _ = function() --[[ destroySlider ]] -- line: 663
                -- upvalues:
                --  [1] v95 (ref)

                if v95 then
                    v95:Destroy()
                    v95 = nil
                end
            end

            local function buildSlider(arg28) -- line: 670
                -- upvalues:
                --  [1] v93 (ref)
                --  [2] v94 (ref)
                --  [3] v95 (ref)
                --  [4] Slider_m (copy)
                --  [5] Holder (copy)
                --  [6] onSliderChanged (copy)
                --  [7] v4 (copy)
                --  [8] showSplit (copy)

                local v110 = v93 - v94

                if v95 then
                    v95:Destroy()
                    v95 = nil
                end

                local t_7 = { SliderData = nil, MoveInfo = nil }
                local t_8 = { Start = 0, End = v93, Increment = 25 }
                t_7.SliderData = t_8
                local New = Slider_m.new
                local v111 = Holder
                t_7.MoveInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad)
                v95 = New(v111, t_7)
                v95.Changed:Connect(onSliderChanged)
                v95.Released:Connect(function(arg29) -- line: 679
                    -- upvalues:
                    --  [1] v93 (ref)
                    --  [2] v4 (ref)
                    --  [3] v95 (ref)

                    if arg29 < math.max(0, v93 - (v4:GetStat("LockedEssence") or 0)) then
                        v95:OverrideValue((math.max(0, v93 - (v4:GetStat("LockedEssence") or 0))))
                    end
                end)
                v95:Track()
                local v116 = arg28 and v110 or math.min(v93, v4:GetStat("Essence") or 0)
                local v119 = math.max(0, v93 - (v4:GetStat("LockedEssence") or 0))
                v116 = math.clamp(v116, v119, v93)
                v95:OverrideValue(v116)
                showSplit(v116)
            end

            local function renderSplit(arg30) -- line: 695
                -- upvalues:
                --  [1] v99 (copy)
                --  [2] v97 (ref)
                --  [3] v9 (ref)
                --  [4] v93 (ref)
                --  [5] v4 (copy)
                --  [6] v100 (copy)
                --  [7] Formatter_m (copy)
                --  [8] Split (copy)
                --  [9] v95 (ref)
                --  [10] ConfirmFrame (copy)
                --  [11] v94 (ref)
                --  [12] buildSlider (copy)

                v99.Visible = v97
                local v121 = v9 ~= nil and (not v97 and math.max(
                    0,
                    v93 - (v4:GetStat("Essence") or 0)
                )) or 0
                v100.Visible = v121 > 0

                if v121 > 0 then
                    local v123 = v100
                    local v124 = Formatter_m.addCommas(v121)
                    v123.Text = `You need <b>{v124}</b> more Essence. Gift will first offer an Essence pack <b>for you</b> to pay with; press Gift again once it arrives.`
                end

                local v127

                if v97 then
                    Split.Visible = false

                    if v95 then
                        v95:Destroy()
                        v95 = nil
                    end

                    ConfirmFrame.Size = UDim2.new(
                        ConfirmFrame.Size.X.Scale,
                        ConfirmFrame.Size.X.Offset,
                        0,
                        175
                    )

                    if v9 then
                        v94 = 0
                        ConfirmFrame.Amount.Text = Formatter_m.addCommas(v93) .. " Essence"
                        v99.Text = "Your region restricts buying this with Essence, so it can't be gifted."

                        return
                    end

                    v94 = v93
                    ConfirmFrame.Amount.Text = Formatter_m.addCommas(v93) .. " Locked Essence"
                    v127 = v93 - (v4:GetStat("LockedEssence") or 0)
                    local v128 = v99
                    local v130

                    if v127 > 0 then
                        local v129 = Formatter_m.addCommas(v127)
                        v130 = `Your region restricts buying this with Essence. It can only be bought with Locked Essence, and it will be untradable.\n<font color="#ff7a6e">You need {v129} more Locked Essence.</font>` or "Your region restricts buying this with Essence. It can only be bought with Locked Essence, and it will be untradable."
                    else
                        v130 = "Your region restricts buying this with Essence. It can only be bought with Locked Essence, and it will be untradable."
                    end

                    v128.Text = v130

                    return
                else
                    v127 = if (v4:GetStat("LockedEssence") or 0) > 0 then if v9 ~= nil then false else true else false
                    Split.Visible = v127
                    local v131 = ConfirmFrame
                    local New_1 = UDim2.new
                    local Scale = ConfirmFrame.Size.X.Scale
                    local Offset = ConfirmFrame.Size.X.Offset
                    local v133 = if not (v121 > 0) then 0 else 50
                    v131.Size = New_1(Scale, Offset, 0, 125 + (if v127 then 58 else 0) + v133)

                    if not v127 or v93 <= 0 then
                        if v95 then
                            v95:Destroy()
                            v95 = nil
                        end

                        v94 = 0
                        ConfirmFrame.Amount.Text = Formatter_m.addCommas(v93) .. " Essence"

                        return
                    end

                    ConfirmFrame.Amount.Text = Formatter_m.addCommas(v93) .. " total"
                    buildSlider(arg30)

                    return
                end
            end

            local _ = function(arg31) --[[ setTotal ]] -- line: 741
                -- upvalues:
                --  [1] v93 (ref)
                --  [2] renderSplit (copy)

                v93 = arg31
                renderSplit(false)
            end

            local _ = function() --[[ getNormalCost ]] -- line: 747
                -- upvalues:
                --  [1] v93 (ref)
                --  [2] v94 (ref)

                return v93 - v94
            end

            v4:OnStatChanged("LockedEssence", function() -- line: 752
                -- upvalues:
                --  [1] ConfirmFrame (copy)
                --  [2] renderSplit (copy)

                if ConfirmFrame.Visible then
                    renderSplit(true)
                end
            end)
            v4:OnStatChanged("Essence", function() -- line: 757
                -- upvalues:
                --  [1] ConfirmFrame (copy)
                --  [2] renderSplit (copy)

                if ConfirmFrame.Visible then
                    renderSplit(true)
                end
            end)

            local _ = function() --[[ handlePointer ]] -- line: 763
                -- upvalues:
                --  [1] v91 (ref)
                --  [2] t_5 (copy)
                --  [3] v90 (ref)
                --  [4] v92 (ref)
                --  [5] v93 (ref)
                --  [6] renderSplit (copy)
                --  [7] ConfirmFrame (copy)

                v91 = t_5[v90]
                v93 = v91 * v92
                renderSplit(false)
                ConfirmFrame.Adjust.num.Text = v91 .. "x"
            end

            local _ = function() --[[ setPointer ]] -- line: 770
                -- upvalues:
                --  [1] v90 (ref)
                --  [2] t_5 (copy)
                --  [3] v91 (ref)
                --  [4] v92 (ref)
                --  [5] v93 (ref)
                --  [6] renderSplit (copy)
                --  [7] ConfirmFrame (copy)

                v90 += 1

                if v90 > #t_5 then
                    v90 = 1
                end

                v91 = t_5[v90]
                v93 = v91 * v92
                renderSplit(false)
                ConfirmFrame.Adjust.num.Text = v91 .. "x"
            end

            local _ = function() --[[ resetPointer ]] -- line: 780
                -- upvalues:
                --  [1] v90 (ref)
                --  [2] v91 (ref)
                --  [3] t_5 (copy)
                --  [4] v92 (ref)
                --  [5] v93 (ref)
                --  [6] renderSplit (copy)
                --  [7] ConfirmFrame (copy)

                v90 = 1
                v91 = t_5[v90]
                v93 = v91 * v92
                renderSplit(false)
                ConfirmFrame.Adjust.num.Text = v91 .. "x"
            end

            local _ = function() --[[ getPointer ]] -- line: 785
                -- upvalues:
                --  [1] Items (copy)
                --  [2] v90 (ref)

                return Items.Stocks[v90]
            end

            local v134 = Icon_m.new()
            v134:setImage(5239139676)
            v134:setOrder(8)
            v134:bindToggleItem(Parent)
            task.spawn(function() -- line: 797
                -- upvalues:
                --  [1] v2 (copy)
                --  [2] v134 (copy)
                --  [3] ReplicatedStorage (copy)

                local Settings = v2:WaitForChild("Settings", 60)
                local v135 = Settings

                if v135 then
                    v135 = Settings:WaitForChild("SeenBundle", 60)
                end

                if not v135 or v135.Value >= 1 then
                    return
                end

                v134:notify(v134.selected)

                local function exclaim() -- line: 805
                    -- upvalues:
                    --  [1] v134 (ref)

                    task.defer(function() -- line: 806
                        -- upvalues:
                        --  [1] v134 (ref)

                        local NoticeLabel = v134:getInstance("NoticeLabel")

                        if NoticeLabel then
                            NoticeLabel.Text = "!"
                        end
                    end)
                end

                v134.noticeChanged:Connect(exclaim)
                task.defer(function() -- line: 806
                    -- upvalues:
                    --  [1] v134 (ref)

                    local NoticeLabel_1 = v134:getInstance("NoticeLabel")

                    if NoticeLabel_1 then
                        NoticeLabel_1.Text = "!"
                    end
                end)
                v134.selected:Once(function() -- line: 815
                    -- upvalues:
                    --  [1] ReplicatedStorage (ref)
                    --  [2] v135 (copy)

                    ReplicatedStorage.Remotes.Player.UpdateSettings:FireServer(v135, 1)
                end)
            end)
            v134:modifyTheme(
                {
                    { "IconButton", "BackgroundColor3", Color3.fromRGB(25, 68, 33) },
                    { "Outline", "ImageColor3", Color3.fromRGB(19, 77, 29) }
                }
            )
            ConfirmFrame.Close.Activated:Connect(function() -- line: 825
                -- upvalues:
                --  [1] ConfirmFrame (copy)

                ConfirmFrame.Visible = false
            end)

            local function promptPurchase(arg32) -- line: 832
                -- upvalues:
                --  [1] v4 (copy)
                --  [2] Products_m (copy)
                --  [3] Request (copy)
                --  [4] MarketplaceService (copy)
                --  [5] v2 (copy)

                local v136 = (v4:GetStat("Essence") or 0) - arg32

                if v136 >= 0 then
                    return
                end

                local v137 = math.abs(v136)
                local v138 = if v137 <= 325 then 1 else if not (v137 <= 1075) then if not (v137 <= 2500) then 4 else 3 else 2

                if v138 then
                    local Product = Products_m.Essence[v138].Product

                    if not pcall(Request.InvokeServer, Request, "PromptSelf", Product) then
                        MarketplaceService:PromptProductPurchase(v2, Product)
                    end

                    return true
                end
            end

            local function AddItem(arg33) -- line: 858
                -- upvalues:
                --  [1] Featured (copy)
                --  [2] Categories (copy)
                --  [3] Items_m (copy)
                --  [4] Formatter_m (copy)
                --  [5] ViewportHandle_m (copy)
                --  [6] v5 (copy)
                --  [7] v9 (ref)
                --  [8] ConfirmFrame (copy)
                --  [9] Text (copy)
                --  [10] Text_1 (copy)
                --  [11] v96 (ref)
                --  [12] v97 (ref)
                --  [13] v93 (ref)
                --  [14] renderSplit (copy)
                --  [15] promptPurchase (copy)
                --  [16] v94 (ref)
                --  [17] ReplicatedStorage (copy)
                --  [18] BackpackUtils_m (copy)
                --  [19] v10 (ref)
                --  [20] Mail (copy)
                --  [21] SearchBox (copy)
                --  [22] populateRecipients (copy)
                --  [23] Recipients (copy)

                if Featured:FindFirstChild(arg33.Name) then
                    return
                end

                local Cost = arg33:GetAttribute("Cost")
                local v139 = Categories[arg33:GetAttribute("Type")] or Categories.Game
                local _ = v139.Order
                local Color = v139.Color
                local _ = Color3.new(0, 0, 0)
                local Name = arg33.Name
                local v140 = Items_m:LookupItem(Name)
                local v141 = script.Template:Clone()
                v141.Name = Name
                v141.Info.Item.Text = Name
                local Amount_4 = v141.Info.Amount
                local v142 = Formatter_m.addCommas(Cost)
                Amount_4.Text = `{v142} Essence`
                v141.BackgroundColor3 = Color
                arg33.AncestryChanged:Connect(function(_, arg35) -- line: 883
                    -- upvalues:
                    --  [1] v141 (copy)

                    if not arg35 then
                        v141:Destroy()
                    end
                end)
                local v143 = ViewportHandle_m.new(Name, v141.Display)

                if v143 then
                    v143.Size = UDim2.new(1, 0, 1.3, 0)
                    v143.Position = UDim2.new(0.5, 0, 0.5, 0)
                    v143.AnchorPoint = Vector2.new(0.5, 0.5)
                    v143.ClipsDescendants = false
                    v143.ZIndex = 3
                end

                local function openConfirm() -- line: 898
                    -- upvalues:
                    --  [1] v5 (ref)
                    --  [2] v9 (ref)
                    --  [3] ConfirmFrame (ref)
                    --  [4] Text (ref)
                    --  [5] Text_1 (ref)
                    --  [6] Name (copy)
                    --  [7] v96 (ref)
                    --  [8] v97 (ref)
                    --  [9] Cost (copy)
                    --  [10] v93 (ref)
                    --  [11] renderSplit (ref)
                    --  [12] promptPurchase (ref)
                    --  [13] v94 (ref)
                    --  [14] ReplicatedStorage (ref)
                    --  [15] BackpackUtils_m (ref)

                    v5:Destroy()

                    if v9 then
                        local Display_1 = ConfirmFrame.Display
                        local v144 = string.upper(v9.Name)
                        Display_1.Text = `GIFT TO <font color='#7fd36f'>@{v144}</font>`
                        ConfirmFrame.Accept.Label.Text = "Gift"
                    else
                        ConfirmFrame.Display.Text = Text
                        ConfirmFrame.Accept.Label.Text = Text_1
                    end

                    ConfirmFrame.Item.Text = string.upper(Name)
                    v96 = false
                    v97 = false
                    ConfirmFrame.Adjust.Visible = false
                    v93 = Cost
                    renderSplit(false)
                    v5:GiveTask(ConfirmFrame.Accept.Activated:Connect(function() -- line: 909
                        -- upvalues:
                        --  [1] promptPurchase (ref)
                        --  [2] v93 (ref)
                        --  [3] v94 (ref)
                        --  [4] v5 (ref)
                        --  [5] ConfirmFrame (ref)
                        --  [6] v9 (ref)
                        --  [7] ReplicatedStorage (ref)
                        --  [8] Name (ref)

                        if promptPurchase(v93 - v94) then
                            return
                        end

                        v5:Destroy()
                        ConfirmFrame.Visible = false

                        if v9 then
                            ReplicatedStorage.Remotes.MarketEvent:InvokeServer(
                                "Featured",
                                Name,
                                nil,
                                0,
                                v9.UserId
                            )

                            return
                        end

                        ReplicatedStorage.Remotes.MarketEvent:InvokeServer(
                            "Featured",
                            Name,
                            nil,
                            v94
                        )
                    end))
                    ConfirmFrame.Visible = true
                    BackpackUtils_m:HideHover()
                end

                v141.Activated:Connect(openConfirm)
                local Gift = v141:FindFirstChild("Gift")

                if Gift and Gift:IsA("GuiButton") then
                    Gift.Activated:Connect(function() -- line: 931
                        -- upvalues:
                        --  [1] openConfirm (copy)
                        --  [2] v9 (ref)
                        --  [3] v10 (ref)
                        --  [4] Mail (ref)
                        --  [5] SearchBox (ref)
                        --  [6] populateRecipients (ref)
                        --  [7] Recipients (ref)

                        local v146 = openConfirm

                        if v9 then
                            v146()

                            return
                        end

                        v10 = v146
                        Mail.Visible = false
                        SearchBox.Text = ""
                        populateRecipients()
                        Recipients.Visible = true
                    end)
                end

                v141.MouseEnter:Connect(function() -- line: 935
                    -- upvalues:
                    --  [1] ConfirmFrame (ref)
                    --  [2] BackpackUtils_m (ref)
                    --  [3] Name (copy)
                    --  [4] v140 (copy)

                    if ConfirmFrame.Visible then
                        return
                    end

                    BackpackUtils_m:ShowHover({ key = Name, text = v140.Desc })
                end)
                v141.MouseLeave:Connect(function() -- line: 945
                    -- upvalues:
                    --  [1] BackpackUtils_m (ref)

                    BackpackUtils_m:HideHover()
                end)
                v141.Parent = Featured
            end

            for key_9, val_5 in Products_m.Essence do
                local Product_3 = val_5.Product
                local v148 = Essence["Option" .. key_9]

                for _, child_4 in v148:GetChildren() do
                    if child_4:IsA("GuiButton") and child_4.Name ~= "Gift" then
                        child_4.Interactable = false
                        child_4.Active = false
                    end
                end

                local Amount_12 = v148.Action.Frame.Amount
                Amount_12.Text = "\238\128\130 ..."
                task.spawn(function() -- line: 967
                    -- upvalues:
                    --  [1] MarketplaceService (copy)
                    --  [2] Product_3 (copy)
                    --  [3] Amount_12 (copy)
                    --  [4] Formatter_m (copy)

                    local Success_4, Result_4 = pcall(
                        MarketplaceService.GetProductInfoAsync,
                        MarketplaceService,
                        Product_3,
                        Enum.InfoType.Product
                    )

                    if Success_4 and (type(Result_4) == "table" and Result_4.PriceInRobux) then
                        local v150 = Amount_12
                        local v151 = Formatter_m.addCommas(Result_4.PriceInRobux)
                        v150.Text = `\238\128\130 {v151}`

                        return
                    end

                    Amount_12.Text = "\238\128\130 ?"
                end)

                local function giftEssence() -- line: 977
                    -- upvalues:
                    --  [1] Product_3 (copy)
                    --  [2] v9 (ref)
                    --  [3] Request (copy)

                    if not v9 then
                        return
                    end

                    local Success_5, Result_5 = pcall(
                        Request.InvokeServer,
                        Request,
                        "PromptGift",
                        Product_3,
                        v9.UserId
                    )

                    if not Success_5 then
                        warn(`[MarketClient] gift prompt failed: {Result_5}`)
                    end
                end

                v148.Activated:Connect(function() -- line: 981
                    -- upvalues:
                    --  [1] v9 (ref)
                    --  [2] Product_3 (copy)
                    --  [3] Request (copy)
                    --  [4] MarketplaceService (copy)
                    --  [5] v2 (copy)

                    if v9 then
                        if not v9 then
                            return
                        end

                        local Success_6, Result_6 = pcall(
                            Request.InvokeServer,
                            Request,
                            "PromptGift",
                            Product_3,
                            v9.UserId
                        )

                        if not Success_6 then
                            warn(`[MarketClient] gift prompt failed: {Result_6}`)

                            return
                        end
                    else
                        local v152 = Product_3

                        if not pcall(Request.InvokeServer, Request, "PromptSelf", v152) then
                            MarketplaceService:PromptProductPurchase(v2, v152)
                        end
                    end
                end)
                local Gift_1 = v148:FindFirstChild("Gift")

                if Gift_1 and Gift_1:IsA("GuiButton") then
                    Gift_1.Activated:Connect(function() -- line: 991
                        -- upvalues:
                        --  [1] giftEssence (copy)
                        --  [2] v9 (ref)
                        --  [3] Product_3 (copy)
                        --  [4] Request (copy)
                        --  [5] v10 (ref)
                        --  [6] Mail (copy)
                        --  [7] SearchBox (copy)
                        --  [8] populateRecipients (copy)
                        --  [9] Recipients (copy)

                        if v9 then
                            if not v9 then
                                return
                            end

                            local _ = giftEssence
                            local Success_7, Result_7 = pcall(
                                Request.InvokeServer,
                                Request,
                                "PromptGift",
                                Product_3,
                                v9.UserId
                            )

                            if not Success_7 then
                                warn(`[MarketClient] gift prompt failed: {Result_7}`)

                                return
                            end
                        else
                            v10 = giftEssence
                            Mail.Visible = false
                            SearchBox.Text = ""
                            populateRecipients()
                            Recipients.Visible = true
                        end
                    end)
                end
            end

            Timer:GetPropertyChangedSignal("Value"):Connect(function() -- line: 997
                -- upvalues:
                --  [1] Items_1 (copy)
                --  [2] Timer (copy)

                Items_1.FeaturedTimer.Text = Timer.Value
            end)
            Items_1.FeaturedTimer.Text = Timer.Value
            Items.ChildAdded:Connect(AddItem)

            for _, child_5 in Items:GetChildren() do
                AddItem(child_5)
            end

            local v154 = utf8.char(57346)

            local function setupUnlockButton(arg36, arg37) -- line: 1014
                -- upvalues:
                --  [1] Products_m (copy)
                --  [2] v4 (copy)
                --  [3] v9 (ref)
                --  [4] MarketplaceService (copy)
                --  [5] v154 (copy)
                --  [6] Formatter_m (copy)
                --  [7] Request (copy)
                --  [8] v2 (copy)
                --  [9] v10 (ref)
                --  [10] Mail (copy)
                --  [11] SearchBox (copy)
                --  [12] populateRecipients (copy)
                --  [13] Recipients (copy)
                --  [14] t (copy)

                local v155 = Products_m.Products[arg37]
                local v156 = v155 and v155.Product
                local v157 = v155

                if v157 then
                    v157 = v155.Unlock
                end

                v155 = v157 ~= nil
                local Amount_5 = arg36.Info.Amount
                local v158 = "..."

                local _ = function() --[[ isOwned ]] -- line: 1023
                    -- upvalues:
                    --  [1] v157 (copy)
                    --  [2] v4 (ref)

                    return if v157 ~= nil then if v4:GetStat(v157) ~= true then false else true else false
                end

                local function render() -- line: 1027
                    -- upvalues:
                    --  [1] Amount_5 (copy)
                    --  [2] v157 (copy)
                    --  [3] v4 (ref)
                    --  [4] v9 (ref)
                    --  [5] v158 (ref)

                    local v160 = false
                    local v161 = Amount_5

                    if v157 ~= nil then
                        v160 = if v4:GetStat(v157) ~= true then false else true
                    end

                    v161.Text = if not v160 then v158 else if v9 then v158 else "Owned"
                end

                task.spawn(function() -- line: 1031
                    -- upvalues:
                    --  [1] MarketplaceService (ref)
                    --  [2] v156 (copy)
                    --  [3] v158 (ref)
                    --  [4] v154 (ref)
                    --  [5] Formatter_m (ref)
                    --  [6] Amount_5 (copy)
                    --  [7] v157 (copy)
                    --  [8] v4 (ref)
                    --  [9] v9 (ref)

                    local Success_8, Result_8 = pcall(
                        MarketplaceService.GetProductInfoAsync,
                        MarketplaceService,
                        v156,
                        Enum.InfoType.Product
                    )

                    if Success_8 then
                        if type(Result_8) == "table" and Result_8.PriceInRobux then
                            local v163 = v154
                            local v164 = Formatter_m.addCommas(Result_8.PriceInRobux)
                            v158 = `{v163} {v164}`
                        else
                            v158 = `{v154} ?`
                        end
                    else
                        v158 = `{v154} ?`
                    end

                    local v165 = false
                    local v166 = Amount_5

                    if v157 ~= nil then
                        v165 = if v4:GetStat(v157) ~= true then false else true
                    end

                    v166.Text = if not v165 then v158 else if v9 then v158 else "Owned"
                end)

                if v157 then
                    v4:OnStatChanged(v157, render)
                end

                arg36.Activated:Connect(function() -- line: 1045
                    -- upvalues:
                    --  [1] v156 (copy)
                    --  [2] v9 (ref)
                    --  [3] v155 (copy)
                    --  [4] Request (ref)
                    --  [5] v157 (copy)
                    --  [6] v4 (ref)
                    --  [7] MarketplaceService (ref)
                    --  [8] v2 (ref)

                    if not v156 then
                        return
                    end

                    if v9 then
                        if v155 then
                            if not v9 then
                                return
                            else
                                local Success_9, Result_9 = pcall(
                                    Request.InvokeServer,
                                    Request,
                                    "PromptGift",
                                    v156,
                                    v9.UserId
                                )

                                if not Success_9 then
                                    warn(`[MarketClient] gift prompt failed: {Result_9}`)
                                end
                            end
                        end

                        return
                    end

                    if if v157 ~= nil then if v4:GetStat(v157) ~= true then false else true else false then
                        return
                    end

                    if v155 then
                        local v169 = v156

                        if not pcall(Request.InvokeServer, Request, "PromptSelf", v169) then
                            MarketplaceService:PromptProductPurchase(v2, v169)

                            return
                        end
                    else
                        MarketplaceService:PromptProductPurchase(v2, v156)
                    end
                end)
                local Gift_2 = arg36:FindFirstChild("Gift")

                if Gift_2 then
                    if Gift_2:IsA("GuiButton") and not v155 then
                        Gift_2.Visible = false
                    elseif Gift_2 and Gift_2:IsA("GuiButton") then
                        Gift_2.Activated:Connect(function() -- line: 1070
                            -- upvalues:
                            --  [1] v156 (copy)
                            --  [2] v9 (ref)
                            --  [3] Request (ref)
                            --  [4] v10 (ref)
                            --  [5] Mail (ref)
                            --  [6] SearchBox (ref)
                            --  [7] populateRecipients (ref)
                            --  [8] Recipients (ref)

                            if v9 then
                                if not v9 then
                                    return
                                end

                                local Success_11, Result_11 = pcall(
                                    Request.InvokeServer,
                                    Request,
                                    "PromptGift",
                                    v156,
                                    v9.UserId
                                )

                                if not Success_11 then
                                    warn(`[MarketClient] gift prompt failed: {Result_11}`)

                                    return
                                end
                            else
                                function v10() -- line: 1071
                                    -- upvalues:
                                    --  [1] v156 (ref)
                                    --  [2] v9 (ref)
                                    --  [3] Request (ref)

                                    if not v9 then
                                        return
                                    end

                                    local Success_10, Result_10 = pcall(
                                        Request.InvokeServer,
                                        Request,
                                        "PromptGift",
                                        v156,
                                        v9.UserId
                                    )

                                    if not Success_10 then
                                        warn(`[MarketClient] gift prompt failed: {Result_10}`)
                                    end
                                end

                                Mail.Visible = false
                                SearchBox.Text = ""
                                populateRecipients()
                                Recipients.Visible = true
                            end
                        end)
                    end
                elseif Gift_2 and Gift_2:IsA("GuiButton") then
                    Gift_2.Activated:Connect(function() -- line: 1070
                        -- upvalues:
                        --  [1] v156 (copy)
                        --  [2] v9 (ref)
                        --  [3] Request (ref)
                        --  [4] v10 (ref)
                        --  [5] Mail (ref)
                        --  [6] SearchBox (ref)
                        --  [7] populateRecipients (ref)
                        --  [8] Recipients (ref)

                        if v9 then
                            if not v9 then
                                return
                            end

                            local Success_13, Result_13 = pcall(
                                Request.InvokeServer,
                                Request,
                                "PromptGift",
                                v156,
                                v9.UserId
                            )

                            if not Success_13 then
                                warn(`[MarketClient] gift prompt failed: {Result_13}`)

                                return
                            end
                        else
                            function v10() -- line: 1071
                                -- upvalues:
                                --  [1] v156 (ref)
                                --  [2] v9 (ref)
                                --  [3] Request (ref)

                                if not v9 then
                                    return
                                end

                                local Success_12, Result_12 = pcall(
                                    Request.InvokeServer,
                                    Request,
                                    "PromptGift",
                                    v156,
                                    v9.UserId
                                )

                                if not Success_12 then
                                    warn(`[MarketClient] gift prompt failed: {Result_12}`)
                                end
                            end

                            Mail.Visible = false
                            SearchBox.Text = ""
                            populateRecipients()
                            Recipients.Visible = true
                        end
                    end)
                end

                table.insert(t, render)
                local v170 = if v157 ~= nil then if v4:GetStat(v157) ~= true then false else true else false
                Amount_5.Text = if not v170 then v158 else if v9 then v158 else "Owned"
            end

            local openConfirm_1
            local v172

            for _, child_6 in v8:GetChildren() do
                if child_6:IsA("TextButton") then
                    v172 = child_6:GetAttribute("Unlock")

                    if v172 then
                        setupUnlockButton(child_6, v172)
                    else
                        local v172 = child_6.Name
                        local num = tonumber(
                            (child_6.Info.Amount.Text:match("[%d,]+"):gsub(",", ""))
                        )

                        function openConfirm_1() --[[ openConfirm ]] -- line: 1097
                            -- upvalues:
                            --  [1] v5 (copy)
                            --  [2] v9 (ref)
                            --  [3] ConfirmFrame (copy)
                            --  [4] Text (copy)
                            --  [5] Text_1 (copy)
                            --  [6] v172 (copy)
                            --  [7] v96 (ref)
                            --  [8] v97 (ref)
                            --  [9] t_6 (copy)
                            --  [10] v2 (copy)
                            --  [11] v92 (ref)
                            --  [12] num (copy)
                            --  [13] v90 (ref)
                            --  [14] v91 (ref)
                            --  [15] t_5 (copy)
                            --  [16] v93 (ref)
                            --  [17] renderSplit (copy)
                            --  [18] child_6 (copy)
                            --  [19] v4 (copy)
                            --  [20] ReplicatedStorage (copy)
                            --  [21] promptPurchase (copy)
                            --  [22] v94 (ref)

                            v5:Destroy()

                            if v9 then
                                local Display_2 = ConfirmFrame.Display
                                local v175 = string.upper(v9.Name)
                                Display_2.Text = `GIFT TO <font color='#7fd36f'>@{v175}</font>`
                                ConfirmFrame.Accept.Label.Text = "Gift"
                            else
                                ConfirmFrame.Display.Text = Text
                                ConfirmFrame.Accept.Label.Text = Text_1
                            end

                            ConfirmFrame.Item.Text = string.upper(v172)
                            v96 = v172 == "Save Slot"
                            v97 = if t_6[v172] == true then if v2:GetAttribute(
                                "PaidRandomItemsRestricted"
                            ) == false then false else true else false
                            v92 = num
                            v90 = 1
                            v91 = t_5[v90]
                            v93 = v91 * v92
                            renderSplit(false)
                            ConfirmFrame.Adjust.num.Text = v91 .. "x"
                            ConfirmFrame.Adjust.Visible = child_6:GetAttribute("Multiple")
                            v5:GiveTask(ConfirmFrame.Accept.Activated:Connect(function() -- line: 1110
                                -- upvalues:
                                --  [1] v97 (ref)
                                --  [2] v9 (ref)
                                --  [3] v4 (ref)
                                --  [4] v93 (ref)
                                --  [5] v5 (ref)
                                --  [6] ConfirmFrame (ref)
                                --  [7] ReplicatedStorage (ref)
                                --  [8] v172 (ref)
                                --  [9] v91 (ref)
                                --  [10] promptPurchase (ref)
                                --  [11] v94 (ref)

                                if v97 then
                                    if not v9 then
                                        if (v4:GetStat("LockedEssence") or 0) < v93 then
                                            return
                                        end

                                        v5:Destroy()
                                        ConfirmFrame.Visible = false
                                        ReplicatedStorage.Remotes.MarketEvent:InvokeServer(
                                            "Market",
                                            v172,
                                            v91,
                                            v93
                                        )

                                        return
                                    else
                                        return
                                    end
                                else
                                    if promptPurchase(v93 - v94) then
                                        return
                                    end

                                    v5:Destroy()
                                    ConfirmFrame.Visible = false

                                    if v9 then
                                        ReplicatedStorage.Remotes.MarketEvent:InvokeServer(
                                            "Market",
                                            v172,
                                            v91,
                                            0,
                                            v9.UserId
                                        )

                                        return
                                    end

                                    ReplicatedStorage.Remotes.MarketEvent:InvokeServer(
                                        "Market",
                                        v172,
                                        v91,
                                        v94
                                    )

                                    return
                                end
                            end))
                            ConfirmFrame.Visible = true
                        end

                        child_6.Activated:Connect(openConfirm_1)
                        local Gift_3 = child_6:FindFirstChild("Gift")

                        if Gift_3 and Gift_3:IsA("GuiButton") then
                            Gift_3.Activated:Connect(function() -- line: 1143
                                -- upvalues:
                                --  [1] openConfirm_1 (copy)
                                --  [2] v9 (ref)
                                --  [3] v10 (ref)
                                --  [4] Mail (copy)
                                --  [5] SearchBox (copy)
                                --  [6] populateRecipients (copy)
                                --  [7] Recipients (copy)

                                local v178 = openConfirm_1

                                if v9 then
                                    v178()

                                    return
                                end

                                v10 = v178
                                Mail.Visible = false
                                SearchBox.Text = ""
                                populateRecipients()
                                Recipients.Visible = true
                            end)
                        end
                    end
                end
            end

            local function applyRandomItemPolicy() -- line: 1150
                -- upvalues:
                --  [1] v2 (copy)
                --  [2] t_6 (copy)
                --  [3] v8 (copy)
                --  [4] color_2 (copy)
                --  [5] ConfirmFrame (copy)
                --  [6] renderSplit (copy)

                local v179 = if v2:GetAttribute("PaidRandomItemsRestricted") == false then false else true
                local _

                for key_13 in t_6 do
                    local v180 = v8:FindFirstChild(key_13)

                    if v180 and v180:IsA("GuiObject") then
                        v180.Visible = true
                        local v181 = v180:FindFirstChild("Info")

                        if v181 then
                            v181 = v180.Info:FindFirstChild("Amount")
                        end

                        if v181 then
                            if not v181:GetAttribute("DefaultText") then
                                v181:SetAttribute("DefaultText", v181.Text)
                                v181:SetAttribute("DefaultTextSize", v181.TextSize)
                            end

                            local DefaultText = v181:GetAttribute("DefaultText")
                            v181.Text = v179 and DefaultText:gsub("Essence", "Locked Essence") or DefaultText
                            v181.TextSize = if v179 then 12 else v181:GetAttribute(
                                "DefaultTextSize"
                            )
                        end

                        v181 = v180:FindFirstChild("RegionBadge")

                        if v179 and not v181 then
                            v181 = Instance.new("TextLabel")
                            v181.Name = "RegionBadge"
                            v181.AnchorPoint = Vector2.zero
                            v181.Position = UDim2.fromOffset(5, 5)
                            v181.Size = UDim2.fromOffset(17, 17)
                            v181.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                            v181.BackgroundTransparency = 0.15
                            v181.Font = Enum.Font.GothamBold
                            v181.Text = "!"
                            v181.TextSize = 14
                            v181.TextColor3 = color_2
                            v181.ZIndex = 4
                            local UICorner = Instance.new("UICorner")
                            UICorner.CornerRadius = UDim.new(1, 0)
                            UICorner.Parent = v181
                            local UIStroke = Instance.new("UIStroke")
                            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                            UIStroke.Color = color_2
                            UIStroke.Thickness = 1.5
                            UIStroke.Parent = v181
                            v181.Parent = v180
                        end

                        if v181 then
                            v181.Visible = v179
                        end

                        v181 = v180:FindFirstChild("Gift")

                        if v181 and v181:IsA("GuiObject") then
                            v181.Visible = not v179
                        end
                    end
                end

                if ConfirmFrame.Visible then
                    renderSplit(true)
                end
            end

            v2:GetAttributeChangedSignal("PaidRandomItemsRestricted"):Connect(applyRandomItemPolicy)
            applyRandomItemPolicy()
            local Bundles = Market:FindFirstChild("Bundles")
            local t_13 = {
                ["Race Reroll"] = "rbxassetid://99937731400293",
                ["Magic Reroll"] = "rbxassetid://140320519270233",
                ["Family Name Reroll"] = "rbxassetid://128817134352826"
            }
            local TitleStyle_m = require(Modules.Titles.TitleStyle)
            local font = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Bold)
            local color_4 = Color3.fromRGB(127, 211, 111)
            local color_5 = Color3.fromRGB(230, 180, 120)
            local t_14 = {}

            local _ = function(arg38) --[[ formatTimeLeft ]] -- line: 1242
                local v183 = math.floor(arg38)
                arg38 = math.max(0, v183)

                return string.format(
                    "%02dd %02dh %02dm",
                    arg38 // 86400,
                    arg38 % 86400 // 3600,
                    arg38 % 3600 // 60
                )
            end

            local _ = function(arg39) --[[ bundleTimeLeft ]] -- line: 1247
                if not arg39.EndsAt then
                    return nil
                end

                return arg39.EndsAt - workspace:GetServerTimeNow()
            end

            local function setupBundle(arg40, arg41) -- line: 1254
                -- upvalues:
                --  [1] font (copy)
                --  [2] TitleStyle_m (copy)
                --  [3] t_13 (copy)
                --  [4] ViewportHandle_m (copy)
                --  [5] Formatter_m (copy)
                --  [6] MarketplaceService (copy)
                --  [7] v4 (copy)
                --  [8] v9 (ref)
                --  [9] v2 (copy)
                --  [10] color_4 (copy)
                --  [11] color_5 (copy)
                --  [12] Request (copy)
                --  [13] t_14 (copy)

                local Product_1 = arg41.Product
                local Info = arg40.Info
                local LineTemplate = Info:FindFirstChild("LineTemplate")
                local Icons = arg40:FindFirstChild("Icons")
                local v184 = Icons

                if v184 then
                    v184 = Icons:FindFirstChild("IconTemplate")
                end

                local Status_1 = arg40:FindFirstChild("Status")
                local Timer_1 = arg40:FindFirstChild("Timer")
                local Robux = arg40.Robux

                if LineTemplate then
                    LineTemplate.Visible = false
                    local v185 = arg41.Lines or {}
                    local v186

                    for key_14, val_6 in v185 do
                        v186 = type(val_6)
                        v186 = val_6.Title

                        if v186 == "table" and v186 then
                            v186 = Instance.new("Frame")
                            v186.Name = "Line" .. key_14
                            v186.BackgroundTransparency = 1
                            v186.Size = UDim2.new(1, 0, 0, 0)
                            v186.AutomaticSize = Enum.AutomaticSize.Y
                            v186.LayoutOrder = 10 + key_14
                            v186.ZIndex = LineTemplate.ZIndex
                            local UIListLayout = Instance.new("UIListLayout")
                            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
                            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                            UIListLayout.Parent = v186

                            local _ = function(arg42, arg43) --[[ part ]] -- line: 1282
                                -- upvalues:
                                --  [1] LineTemplate (copy)
                                --  [2] v186 (copy)

                                local v187 = LineTemplate:Clone()
                                v187.Name = "Part" .. arg43
                                v187.Text = arg42
                                v187.Size = UDim2.fromOffset(0, 0)
                                v187.AutomaticSize = Enum.AutomaticSize.XY
                                v187.TextWrapped = false
                                v187.LayoutOrder = arg43
                                v187.Visible = true
                                v187.Parent = v186

                                return v187
                            end

                            local v188 = LineTemplate:Clone()
                            v188.Name = "Part" .. 1
                            v188.Text = "- "
                            v188.Size = UDim2.fromOffset(0, 0)
                            v188.AutomaticSize = Enum.AutomaticSize.XY
                            v188.TextWrapped = false
                            v188.LayoutOrder = 1
                            v188.Visible = true
                            v188.Parent = v186
                            local Title = val_6.Title
                            local v189 = LineTemplate:Clone()
                            v189.Name = "Part" .. 2
                            v189.Text = Title
                            v189.Size = UDim2.fromOffset(0, 0)
                            v189.AutomaticSize = Enum.AutomaticSize.XY
                            v189.TextWrapped = false
                            v189.LayoutOrder = 2
                            v189.Visible = true
                            v189.Parent = v186
                            v189.RichText = false
                            v189.FontFace = font
                            v189.TextSize = 15

                            for _, child_7 in v189:GetChildren() do
                                if child_7:IsA("UIStroke") then
                                    child_7:Destroy()
                                end
                            end

                            local UIStroke_1 = Instance.new("UIStroke")
                            UIStroke_1.Color = Color3.new(0, 0, 0)
                            UIStroke_1.Thickness = 2
                            UIStroke_1.Transparency = 0.4
                            UIStroke_1.Parent = v189
                            TitleStyle_m.Apply(v189, val_6.Title)
                            v189.Text = string.upper(val_6.Title)
                            local v192 = val_6.Suffix or "\194\160Title"
                            local v193 = LineTemplate:Clone()
                            v193.Name = "Part" .. 3
                            v193.Text = v192
                            v193.Size = UDim2.fromOffset(0, 0)
                            v193.AutomaticSize = Enum.AutomaticSize.XY
                            v193.TextWrapped = false
                            v193.LayoutOrder = 3
                            v193.Visible = true
                            v193.Parent = v186
                            v186.Parent = Info
                        else
                            v186 = LineTemplate:Clone()
                            v186.Name = "Line" .. key_14
                            v186.Text = "- " .. tostring(val_6)
                            v186.LayoutOrder = 10 + key_14
                            v186.Visible = true
                            v186.Parent = Info
                        end
                    end
                end

                if v184 then
                    local v194 = false
                    v184.Visible = v194
                    v194 = 0

                    local _ = function(arg44, arg45) --[[ addIcon ]] -- line: 1330
                        -- upvalues:
                        --  [1] v194 (ref)
                        --  [2] v184 (copy)
                        --  [3] Icons (copy)

                        v194 += 1
                        local v195 = v184:Clone()
                        v195.Name = "Icon" .. v194
                        v195.LayoutOrder = v194
                        v195.Image = arg44 or ""
                        v195.Count.Text = arg45
                        v195.Visible = true
                        v195.Parent = Icons

                        return v195
                    end

                    local v196 = arg41.Contents or {}
                    local v197 = nil
                    local v198 = 0
                    local v199 = v196.Items or {}

                    for _, val_7 in v199 do
                        local v200 = val_7[1]
                        local v201 = val_7[2] or 1

                        if t_13[v200] then
                            local v202 = t_13[v200]
                            local v203 = `x{v201}`
                            v194 += 1
                            local v204 = v184:Clone()
                            v204.Name = "Icon" .. v194
                            v204.LayoutOrder = v194
                            v204.Image = v202 or ""
                            v204.Count.Text = v203
                            v204.Visible = true
                            v204.Parent = Icons
                        else
                            v197 = v197 or v200
                            v198 += v201
                        end
                    end

                    if v197 then
                        local v205 = `x{v198}`
                        v194 += 1
                        local v206 = v184:Clone()
                        v206.Name = "Icon" .. v194
                        v206.LayoutOrder = v194
                        v206.Image = ""
                        v206.Count.Text = v205
                        v206.Visible = true
                        v206.Parent = Icons
                        local Success_14, Result_14 = pcall(ViewportHandle_m.new, v197, v206)

                        if Success_14 and Result_14 then
                            Result_14.Size = UDim2.fromScale(1.2, 1.2)
                            Result_14.Position = UDim2.fromScale(0.5, 0.5)
                            Result_14.AnchorPoint = Vector2.new(0.5, 0.5)
                            Result_14.ZIndex = v206.ZIndex
                        end
                    end

                    if v196.Essence then
                        local v207 = Formatter_m.addCommas(v196.Essence)
                        v194 += 1
                        v198 = v184:Clone()
                        v198.Name = "Icon" .. v194
                        v198.LayoutOrder = v194
                        v198.Image = "rbxassetid://119478476508480"
                        v198.Count.Text = v207
                        v198.Visible = true
                        v198.Parent = Icons
                    end
                end

                for _, val_8 in arg40:GetDescendants() do
                    if val_8:IsA("ViewportFrame") and val_8:GetAttribute("CameraCFrame") then
                        local Camera = Instance.new("Camera")
                        Camera.CFrame = val_8:GetAttribute("CameraCFrame")
                        Camera.FieldOfView = val_8:GetAttribute("CameraFieldOfView") or 40
                        Camera.Parent = val_8
                        val_8.CurrentCamera = Camera
                    end
                end

                if Icons then
                    for _, child_8 in Icons:GetChildren() do
                        local ViewportItem = child_8:GetAttribute("ViewportItem")

                        if type(ViewportItem) == "string" and child_8:IsA("GuiObject") then
                            local Success_15, Result_15 = pcall(
                                ViewportHandle_m.new,
                                ViewportItem,
                                child_8
                            )

                            if Success_15 and Result_15 then
                                Result_15.Size = UDim2.fromScale(1.2, 1.2)
                                Result_15.Position = UDim2.fromScale(0.5, 0.5)
                                Result_15.AnchorPoint = Vector2.new(0.5, 0.5)
                                Result_15.ZIndex = child_8.ZIndex
                                local Count_1 = child_8:FindFirstChild("Count")

                                if Count_1 then
                                    Count_1.ZIndex = math.max(Count_1.ZIndex, Result_15.ZIndex + 1)
                                end
                            end
                        end
                    end
                end

                local Amount_6 = Robux.Amount.Amount
                Amount_6.Text = "..."
                task.spawn(function() -- line: 1403
                    -- upvalues:
                    --  [1] MarketplaceService (ref)
                    --  [2] Product_1 (copy)
                    --  [3] Amount_6 (copy)
                    --  [4] Formatter_m (ref)

                    local Success_16, Result_16 = pcall(
                        MarketplaceService.GetProductInfoAsync,
                        MarketplaceService,
                        Product_1,
                        Enum.InfoType.Product
                    )

                    if Success_16 and (type(Result_16) == "table" and Result_16.PriceInRobux) then
                        Amount_6.Text = Formatter_m.addCommas(Result_16.PriceInRobux)

                        return
                    end

                    Amount_6.Text = "?"
                end)

                if arg41.Worth then
                    local Amount_7 = Robux.Worth.Amount
                    local v209 = Formatter_m.addCommas(arg41.Worth)
                    Amount_7.Text = `Worth {v209}`
                end

                local _ = function() --[[ isOwned ]] -- line: 1417
                    -- upvalues:
                    --  [1] v4 (ref)
                    --  [2] arg41 (copy)

                    return if v4:GetStat(arg41.Owned) ~= true then false else true
                end

                local function render_1() --[[ render ]] -- line: 1421
                    -- upvalues:
                    --  [1] v4 (ref)
                    --  [2] arg41 (copy)
                    --  [3] v9 (ref)
                    --  [4] v2 (ref)
                    --  [5] arg40 (copy)
                    --  [6] Product_1 (copy)
                    --  [7] Robux (copy)
                    --  [8] Status_1 (copy)
                    --  [9] color_4 (ref)
                    --  [10] color_5 (ref)
                    --  [11] Timer_1 (copy)

                    local v211 = if v4:GetStat(arg41.Owned) ~= true then false else true

                    if v211 then
                        v211 = not v9
                    end

                    local v212 = arg41
                    local v213 = if not v212.EndsAt then nil else v212.EndsAt - workspace:GetServerTimeNow()
                    v212 = if v213 == nil then false else v213 <= 0
                    local v214 = if v2:GetAttribute("PaidRandomItemsRestricted") == false then false else true
                    local v215 = not v212 and Product_1 ~= 0
                    arg40.Visible = v215
                    Robux.Visible = not v211
                    local v216 = nil

                    if v211 then
                        v216 = "<b>OWNED</b>"

                        if Status_1 then
                            Status_1.TextColor3 = color_4
                        end
                    elseif v214 then
                        v216 = "Unavailable in your region"

                        if Status_1 then
                            Status_1.TextColor3 = color_5
                        end
                    end

                    if Status_1 then
                        local v217 = v216 ~= nil
                        Status_1.Visible = v217
                        Status_1.Text = v216 or ""
                    end

                    if Timer_1 then
                        Timer_1.Visible = if v213 == nil then false else not v212 and v216 == nil

                        if v213 then
                            local v218 = Timer_1
                            local v220 = math.max(0, (math.floor(v213)))
                            v218.Text = `Leaves in <b>{string.format(
                                "%02dd %02dh %02dm",
                                v220 // 86400,
                                v220 % 86400 // 3600,
                                v220 % 3600 // 60
                            )}</b>`
                        end
                    end

                    arg40.Buy.AutoButtonColor = false
                    local v221 = v211 or (v214 or v212)
                    arg40.Buy.Active = not v221
                end

                arg40.Buy.Activated:Connect(function() -- line: 1457
                    -- upvalues:
                    --  [1] arg41 (copy)
                    --  [2] Product_1 (copy)
                    --  [3] v2 (ref)
                    --  [4] v9 (ref)
                    --  [5] Request (ref)
                    --  [6] v4 (ref)
                    --  [7] MarketplaceService (ref)

                    local v222 = arg41
                    local v223 = if not v222.EndsAt then nil else v222.EndsAt - workspace:GetServerTimeNow()
                    local Result_17, Success_17

                    if Product_1 ~= 0 then
                        if (if v2:GetAttribute("PaidRandomItemsRestricted") == false then false else true) or v223 and v223 <= 0 then
                            return
                        end

                        if v9 then
                            if not v9 then
                                return
                            end

                            Success_17, Result_17 = pcall(
                                Request.InvokeServer,
                                Request,
                                "PromptGift",
                                Product_1,
                                v9.UserId
                            )

                            if not Success_17 then
                                warn(`[MarketClient] gift prompt failed: {Result_17}`)
                            end

                            return
                        else
                            if if v4:GetStat(arg41.Owned) ~= true then false else true then
                                return
                            end

                            local v225 = Product_1

                            if not pcall(Request.InvokeServer, Request, "PromptSelf", v225) then
                                MarketplaceService:PromptProductPurchase(v2, v225)
                            end

                            return
                        end
                    else
                        return
                    end
                end)

                if arg41.Owned then
                    v4:OnStatChanged(arg41.Owned, render_1)
                end

                table.insert(t_14, { Card = arg40, Product = arg41, Render = render_1 })
                render_1()
            end

            local function renderBundles() -- line: 1481
                -- upvalues:
                --  [1] t_14 (copy)
                --  [2] Bundles (copy)

                local v226 = false

                for _, val_9 in t_14 do
                    val_9.Render()
                    v226 = v226 or val_9.Card.Visible
                end

                if Bundles then
                    Bundles.Visible = v226
                end
            end

            if Bundles then
                for key_20, val_10 in Products_m.Products, nil, nil do
                    local v229 = Bundles:FindFirstChild(key_20)

                    if val_10.Bundle and v229 then
                        if v229:FindFirstChild("Buy") then
                            setupBundle(v229, val_10)
                        end
                    end
                end

                v2:GetAttributeChangedSignal("PaidRandomItemsRestricted"):Connect(renderBundles)
                table.insert(t, renderBundles)
                local v234 = false

                for _, val_11 in t_14, nil, nil do
                    val_11.Render()
                    v234 = v234 or val_11.Card.Visible
                end

                if Bundles then
                    Bundles.Visible = v234
                end

                MarketplaceService.PromptProductPurchaseFinished:Connect(function(
                    userId,
                    productId,
                    isPurchased
                ) -- line: 1506
                    -- upvalues:
                    --  [1] v2 (copy)
                    --  [2] t_14 (copy)
                    --  [3] ConfirmFrame (copy)
                    --  [4] v134 (copy)
                    --  [5] Parent (copy)

                    if not isPurchased or userId ~= v2.UserId then
                        return
                    end

                    for _, val_12 in t_14 do
                        if val_12.Product.Product == productId then
                            ConfirmFrame.Visible = false
                            pcall(function() -- line: 1513
                                -- upvalues:
                                --  [1] v134 (ref)

                                v134:deselect()
                            end)
                            Parent.Visible = false

                            return
                        end
                    end
                end)
                local v240 = Bundles:FindFirstAncestorWhichIsA("ScrollingFrame")

                local function fullyInside(arg49) -- line: 1529
                    -- upvalues:
                    --  [1] v240 (copy)

                    if not v240 then
                        return true
                    end

                    local AbsolutePosition = arg49.AbsolutePosition
                    local AbsoluteSize = arg49.AbsoluteSize
                    local AbsolutePosition_1 = v240.AbsolutePosition
                    local AbsoluteWindowSize = v240.AbsoluteWindowSize

                    return AbsolutePosition.X >= AbsolutePosition_1.X - 1 and (AbsolutePosition.Y >= AbsolutePosition_1.Y - 1 and (AbsolutePosition.X + AbsoluteSize.X <= AbsolutePosition_1.X + AbsoluteWindowSize.X + 1 and AbsolutePosition.Y + AbsoluteSize.Y <= AbsolutePosition_1.Y + AbsoluteWindowSize.Y + 1))
                end

                local t_16 = {}
                local _

                for _, val_13 in t_14 do
                    local Backdrop = val_13.Card:FindFirstChild("Backdrop")
                    local v242 = Backdrop

                    if v242 then
                        v242 = Backdrop:FindFirstChild("RaysClip")
                    end

                    local v243 = Backdrop

                    if v243 then
                        v243 = Backdrop:FindFirstChild("Rays", true)
                    end

                    local v246 = Backdrop

                    if v246 then
                        v246 = Backdrop:FindFirstChild("Sparkles")
                    end

                    if v246 then
                        v246.Visible = false
                        v246 = nil
                    end

                    if v243 then
                        local t_17 = {
                            Card = val_13.Card,
                            Holder = v242 or v243,
                            Rays = v243,
                            Angle = #t_16 * 1.7 * 40,
                            RaySize = v243.Size,
                            RayBase = v243.ImageTransparency,
                            Sparkles = v246,
                            Stars = v246 and v246:GetChildren() or {},
                            Phase = #t_16 * 1.7
                        }
                        table.insert(t_16, t_17)
                    end
                end

                if #t_16 > 0 then
                    local v254 = nil

                    local function updateSpin() -- line: 1567
                        -- upvalues:
                        --  [1] Parent (copy)
                        --  [2] Bundles (copy)
                        --  [3] v254 (ref)
                        --  [4] RunService (copy)
                        --  [5] t_16 (copy)
                        --  [6] fullyInside (copy)

                        if Parent.Visible and (Bundles.Visible and not v254) then
                            v254 = RunService.RenderStepped:Connect(function(deltaTime) -- line: 1569
                                -- upvalues:
                                --  [1] t_16 (ref)
                                --  [2] fullyInside (ref)

                                local clock = os.clock()

                                for _, val_14 in t_16 do
                                    local v255 = math.sin(clock * 1.1 + val_14.Phase)
                                    local v256 = v255 * 0.05 + 1
                                    val_14.Rays.Size = UDim2.fromScale(
                                        val_14.RaySize.X.Scale * v256,
                                        val_14.RaySize.Y.Scale * v256
                                    )
                                    val_14.Rays.ImageTransparency = math.clamp(
                                        val_14.RayBase + v255 * 0.03,
                                        0,
                                        1
                                    )

                                    if fullyInside(val_14.Card) then
                                        val_14.Angle = (val_14.Angle + deltaTime * 6) % 360
                                    else
                                        val_14.Angle = 0
                                    end

                                    val_14.Rays.Rotation = val_14.Angle

                                    for key_25, val_15 in val_14.Stars do
                                        if val_15:IsA("ImageLabel") then
                                            val_15.ImageTransparency = (1 - math.max(
                                                math.sin(
                                                    clock * (1.3 + key_25 % 3 * 0.45) + val_14.Phase + key_25 * 2.1
                                                ),
                                                0
                                            )) * 0.75 + 0.25
                                            val_15.Rotation = (clock * 25 + key_25 * 40) % 360
                                        end
                                    end
                                end
                            end)

                            return
                        end

                        if (not Parent.Visible or not Bundles.Visible) and v254 then
                            v254:Disconnect()
                            v254 = nil
                        end
                    end

                    Parent:GetPropertyChangedSignal("Visible"):Connect(updateSpin)
                    Bundles:GetPropertyChangedSignal("Visible"):Connect(updateSpin)
                    updateSpin()
                end

                task.spawn(function() -- line: 1603
                    -- upvalues:
                    --  [1] t_14 (copy)
                    --  [2] Bundles (copy)

                    local v257 = false
                    local v258

                    for _, val_16 in t_14 do
                        local Product_2 = val_16.Product
                        v258 = if not Product_2.EndsAt then nil else Product_2.EndsAt - workspace:GetServerTimeNow()
                        v257 = if not v258 then v257 else if not (v258 > -2) then v257 else true
                    end

                    if v257 then
                        v257 = false

                        for _, val_17 in t_14 do
                            val_17.Render()
                            v258 = v257 or val_17.Card.Visible
                            v257 = v258
                        end

                        if Bundles then
                            Bundles.Visible = v257
                        end

                        task.wait(1)
                    end
                end)
            end

            ConfirmFrame.Adjust.Activated:Connect(function() -- line: 1621
                -- upvalues:
                --  [1] v90 (ref)
                --  [2] t_5 (copy)
                --  [3] v91 (ref)
                --  [4] v92 (ref)
                --  [5] v93 (ref)
                --  [6] renderSplit (copy)
                --  [7] ConfirmFrame (copy)

                v90 += 1

                if v90 > #t_5 then
                    v90 = 1
                end

                v91 = t_5[v90]
                v93 = v91 * v92
                renderSplit(false)
                ConfirmFrame.Adjust.num.Text = v91 .. "x"
            end)
            local t_18 = {}
            local t_19 = {}
            local Race = Parent.Race
            table.insert(t_19, Race)
            local Magic = Parent.Magic
            table.insert(t_19, Magic)

            for _, val_18 in t_19, nil, nil do
                local v261 = Parent:FindFirstChild("Available" .. val_18.Name)

                if v261 then
                    table.insert(t_18, v261)
                    val_18.Activated:Connect(function() -- line: 1636
                        -- upvalues:
                        --  [1] v261 (copy)
                        --  [2] t_18 (copy)

                        if v261.Visible then
                            v261.Visible = false

                            return
                        end

                        for _, val_19 in t_18 do
                            val_19.Visible = val_19 == v261
                        end
                    end)
                end
            end

            local AvailableRace = Parent.AvailableRace
            local AvailableMagic = Parent.AvailableMagic

            local _ = function(arg51) --[[ formatNumber ]] -- line: 1651
                if arg51 % 1 == 0 then
                    return string.format("%.2f", arg51)
                end

                return string.format("%.3f", arg51)
            end

            local v269

            for key_30, val_20 in Race_m.Races do
                if not val_20.Unobtainable then
                    local v263 = math.floor(val_20.Chance * 100)
                    local v264 = 100 - v263
                    local v265 = script.Label:Clone()
                    v265.Name = v264 .. key_30
                    v269 = if v263 % 1 == 0 then string.format("%.2f", v263) else string.format(
                        "%.3f",
                        v263
                    )
                    v265.Text = key_30 .. " - " .. v269 .. "%"
                    v265.Parent = AvailableRace
                end
            end

            for _, val_21 in ipairs(GrimoireRarity_m.Grimoires) do
                if not (val_21.Weight <= 0) then
                    local v273 = val_21.Weight * 100
                    local v274 = 100 - v273
                    local v275 = if not GrimoireRarity_m.Variants[val_21.Name] then "" else "<font color='rgb(170, 85, 255)'>*</font> "
                    local v276 = script.Label:Clone()
                    v276.Name = v274 .. val_21.Name
                    local Name_1 = val_21.Name
                    v269 = if v273 % 1 == 0 then string.format("%.2f", v273) else string.format(
                        "%.3f",
                        v273
                    )
                    v276.Text = v275 .. Name_1 .. " - " .. v269 .. "%"
                    v276.Parent = AvailableMagic
                end
            end

            local Donation = Parent.Donation
            local t_20 = { Donation = Donation, Items = v6 }
            local Buttons = Parent.Buttons
            local v282, v283

            for _, child_9 in Buttons:GetChildren() do
                if child_9:IsA("Frame") then
                    v6 = child_9:FindFirstChildWhichIsA("GuiButton")
                    v282 = v6.BackgroundColor3
                    v283 = t_20[child_9.Name]

                    local function UpdateSelected() -- line: 1713
                        -- upvalues:
                        --  [1] child_9 (copy)
                        --  [2] v6 (copy)
                        --  [3] v282 (copy)
                        --  [4] v283 (copy)

                        local Selected = child_9:GetAttribute("Selected")
                        local v284 = v6
                        v284.BackgroundColor3 = Selected and v282 or v282:Lerp(Color3.new(), 0.6)

                        for _, descendant in child_9:GetDescendants() do
                            if descendant:IsA("ImageLabel") then
                                descendant:SetAttribute(
                                    "OriginalColor",
                                    descendant:GetAttribute("OriginalColor") or descendant.ImageColor3
                                )
                                local OriginalColor = descendant:GetAttribute("OriginalColor")
                                descendant.ImageColor3 = Selected and OriginalColor or OriginalColor:Lerp(
                                    Color3.new(),
                                    0.6
                                )
                            elseif descendant:IsA("TextLabel") then
                                descendant.TextTransparency = if not Selected then 0.6 else 0
                            end
                        end

                        v283.Visible = Selected
                    end

                    v6.Activated:Connect(function() -- line: 1732
                        -- upvalues:
                        --  [1] child_9 (copy)
                        --  [2] Buttons (copy)

                        if child_9:GetAttribute("Selected") then
                            return
                        end

                        for _, child_10 in Buttons:GetChildren() do
                            if child_10:IsA("Frame") then
                                child_10:SetAttribute("Selected", false)
                            end
                        end

                        child_9:SetAttribute("Selected", true)
                    end)
                    child_9:GetAttributeChangedSignal("Selected"):Connect(UpdateSelected)
                    UpdateSelected()
                end
            end

            Donation.DonationDescription.Text = `Hello <font color='#e5bf61'>{v2.DisplayName}</font>! Donations help fund the game, and also support the developers of the game directly. Thank you for your support! \240\159\146\150`

            for key_35, val_22 in DonationTitles_m.Tiers do
                local v292 = Donation.Contents.Packages:FindFirstChild("TitleAwarded" .. key_35)

                if v292 then
                    v292.Title.Text = val_22.Title
                    v292.Title.TextColor3 = val_22.Color
                end
            end

            local Support = Donation.Contents.Contribution.Support
            local TopCount = DonationTitles_m.TopCount
            local v293 = Formatter_m.addCommas(DonationTitles_m.TopMinDonated)
            local v294 = DonationTitles_m.TopColor:ToHex()
            Support.Text = `All donations are appreciated! The top {TopCount} on the leaderboard ({v293}+ donated) also get the <font color="#{v294}">{DonationTitles_m.TopTitle}</font> title.`
            local t_21
            local v297

            for key_36, val_23 in Products_m.Donation do
                v294 = val_23.Product
                local v295 = Donation.Contents.Packages["Option" .. key_36]
                local Success_18, v296 = pcall(
                    MarketplaceService.GetProductInfoAsync,
                    MarketplaceService,
                    v294,
                    Enum.InfoType.Product
                )

                if Success_18 then
                    if type(v296) ~= "table" then
                        v297 = DonationTitles_m.Tiers[key_36]
                        t_21 = { PriceInRobux = v297 and v297.Required or 0 }
                        v296 = t_21
                    end
                else
                    v297 = DonationTitles_m.Tiers[key_36]
                    t_21 = { PriceInRobux = v297 and v297.Required or 0 }
                    v296 = t_21
                end

                local _ = v296.UserBasePriceInRobux
                local PriceInRobux = v296.PriceInRobux
                local Amount_8 = v295.Amount
                local v298 = Formatter_m.addCommas(PriceInRobux)
                Amount_8.Text = `{v298}\238\128\130`
                v295.Activated:Connect(function() -- line: 1778
                    -- upvalues:
                    --  [1] MarketplaceService (copy)
                    --  [2] v2 (copy)
                    --  [3] v294 (copy)

                    MarketplaceService:PromptProductPurchase(v2, v294)
                end)
            end

            local function UpdateContribution() -- line: 1783
                -- upvalues:
                --  [1] v4 (copy)
                --  [2] Donation (copy)
                --  [3] Formatter_m (copy)

                local Donated = v4:GetStat("Donated")
                local Amount_9 = Donation.Contents.Contribution.Amount
                local v300 = Formatter_m.addCommas(Donated)
                Amount_9.Text = `You donated: {v300}\238\128\130`
            end

            v4:OnStatChanged("Donated", UpdateContribution)
            local Donated_1 = v4:GetStat("Donated")
            Donation.Contents.Contribution.Amount.Text = `You donated: {Formatter_m.addCommas(
                Donated_1
            )}\238\128\130`
            local TopDonors_1 = ReplicatedStorage:WaitForChild("TopDonors")
            local t_22 = {}

            function getNameFromUserId(arg52) -- line: 1795
                -- upvalues:
                --  [1] t_22 (copy)
                --  [2] Players (copy)

                local v302 = t_22[arg52]

                if v302 then
                    return v302
                end

                local v303 = nil
                local Success_19, _ = pcall(function() -- line: 1802
                    -- upvalues:
                    --  [1] v303 (ref)
                    --  [2] Players (ref)
                    --  [3] arg52 (copy)

                    v303 = Players:GetNameFromUserIdAsync(arg52)
                end)

                if Success_19 then
                    t_22[arg52] = v303

                    return v303
                end

                return nil
            end

            local function CREATETEMPLATE(u1: userdata) -- line: 1812
                -- upvalues:
                --  [1] Formatter_m (copy)
                --  [2] Donation (copy)

                local Name_2 = u1.Name
                local v304 = u1:GetAttributes()
                local Place = v304.Place
                local Donated_2 = v304.Donated
                local Donor = v304.Donor
                local v305 = script.DonationTemplate:Clone()
                v305.LayoutOrder = Place
                v305.Name = Name_2
                local Place_1 = v305.Display.Place
                local _ = Color3.fromRGB(255, 255, 255)

                if Place ~= 1 and Place ~= 2 and Place == 3 then
                end

                local color_8 = Color3.fromRGB(25, 25, 25)
                local color_9 = Color3.fromRGB(80, 80, 80)

                if Place <= 5 then
                    color_9 = Color3.fromRGB(229, 204, 145)
                    local v307 = script.UIGradient:Clone()
                    v307.Parent = v305.Outline
                    v307.GradientControl.Enabled = true
                end

                Place_1.Text = `{Place}.`
                v305.BackgroundColor3 = color_8
                v305.Outline.ImageColor3 = color_9
                local Amount_11 = v305.Display.Amount
                local v308 = Formatter_m.addCommas(Donated_2)
                Amount_11.Text = `{v308}\238\128\130`
                v305.Display.Donor.Text = getNameFromUserId(Donor) or "Failed to load"
                v305.Parent = Donation.Contents.Donors.List
            end

            local function DELETETEMPLATE(u2: userdata) -- line: 1859
                -- upvalues:
                --  [1] Donation (copy)

                local v309 = Donation.Contents.Donors.List:FindFirstChild(u2.Name)

                if not v309 then
                    return
                end

                v309:Destroy()
            end

            TopDonors_1.ChildAdded:Connect(CREATETEMPLATE)
            TopDonors_1.ChildRemoved:Connect(DELETETEMPLATE)

            for _, child_11 in TopDonors_1:GetChildren() do
                task.spawn(CREATETEMPLATE, child_11)
            end
        end
    end
end
