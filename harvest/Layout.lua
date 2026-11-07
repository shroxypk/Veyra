-- Decompiled with Veyra harvester
-- Instance: StarterGui.AllianceUI.Clans.ClanFrame.Layout
-- Class: LocalScript
-- bytes: 6910

local Parent = script.Parent
local Contents = Parent.Contents
local Info = Contents.Info
local Profile = Info.Profile
local Identity = Profile.Identity
local GuildStats = Profile.GuildStats
local Tiles = GuildStats.Tiles
local Members = Contents.Members
local List = Members.List
local HeaderTemplate = script.HeaderTemplate
local t_1 = {
    { name = "Captain", color = Color3.fromRGB(214, 178, 72) },
    { name = "Vice-Captain", color = Color3.fromRGB(255, 255, 255) },
    { name = "Officer", color = Color3.fromRGB(255, 255, 255) },
    { name = "Member", color = Color3.fromRGB(255, 255, 255) }
}
local t_5 = {}

for _, val in t_1 do
    t_5[val.name] = val.color
end

local function commas(arg1) -- line: 36
    local v2 = tostring((math.floor(tonumber(arg1) or 0)))
    local v3

    repeat
        v2, v3 = string.gsub(v2, "^(-?%d+)(%d%d%d)", "%1,%2")
    until v3 == 0

    return v2
end

for _, descendant in Parent:GetDescendants() do
    if descendant:GetAttribute("Preview") then
        descendant:Destroy()
    end
end

local function renderProfile() -- line: 53
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] Tiles (copy)
    --  [3] commas (copy)
    --  [4] Identity (copy)
    --  [5] t_5 (copy)
    --  [6] Info (copy)
    --  [7] GuildStats (copy)

    local v4 = Parent:GetAttribute("MemberCount") or 0
    local v5 = Parent:GetAttribute("MemberCap") or 0
    local v6 = Parent:GetAttribute("OwnerName") or ""
    local v7 = Parent:GetAttribute("Rank") or ""
    local PrimaryColor = Parent:GetAttribute("PrimaryColor")
    local Value = Tiles.Members.Value
    Value.Text = v5 > 0 and `{v4}/{v5}` or tostring(v4)
    Tiles.Points.Value.Text = commas(Parent:GetAttribute("GuildPoints"))
    Tiles.PvP.Value.Text = commas(Parent:GetAttribute("PvPRating"))
    Tiles.PvE.Value.Text = commas(Parent:GetAttribute("PvERating"))
    local Owner = Identity.Owner
    Owner.Text = v6 ~= "" and `Owned by <b>{v6}</b>` or ""
    v6 = t_5[v7] or Color3.fromRGB(255, 255, 255)
    local Dot = Identity.RankPill:FindFirstChild("Dot")

    if Dot then
        Dot.BackgroundColor3 = v6
    end

    local Label = Identity.RankPill.Label
    local v13 = v6:ToHex()
    Label.Text = `Your rank: <font color="#{v13}">{v7}</font>`

    if typeof(PrimaryColor) == "Color3" then
        Info.BackgroundColor3 = PrimaryColor:Lerp(Color3.new(0, 0, 0), 0.75)
    end

    local v15 = v5 > 0 and math.clamp(v4 / v5, 0, 1) or 0
    GuildStats.Capacity.Fill.Size = UDim2.fromScale(v15, 1)
    GuildStats.Capacity.Fill.Visible = v15 > 0
    local CapacityLabel = GuildStats.CapacityLabel
    CapacityLabel.Text = if v5 > 0 then `{v4} of {v5} member slots filled` or `{v4} members` else `{v4} members`
end

Parent.AttributeChanged:Connect(renderProfile)
renderProfile()

local function hookRow(arg2) -- line: 88
    if arg2:GetAttribute("_Hooked") then
        return
    end

    arg2:SetAttribute("_Hooked", true)
    arg2.MouseEnter:Connect(function() -- line: 93
        -- upvalues:
        --  [1] arg2 (copy)

        arg2.BackgroundTransparency = 0.5
    end)
    arg2.MouseLeave:Connect(function() -- line: 96
        -- upvalues:
        --  [1] arg2 (copy)

        arg2.BackgroundTransparency = 1
    end)
end

local v17 = false

local function regroup() -- line: 102
    -- upvalues:
    --  [1] v17 (ref)
    --  [2] List (copy)
    --  [3] t_1 (copy)
    --  [4] HeaderTemplate (copy)
    --  [5] hookRow (copy)
    --  [6] Members (copy)

    v17 = false
    local t_6 = {}
    local t_7 = {}

    for _, child in List:GetChildren() do
        if child:IsA("GuiObject") then
            if child:GetAttribute("IsHeader") then
                t_7[child.Name] = child
            else
                table.insert(t_6, child)
            end
        end
    end

    table.sort(t_6, function(arg3, arg4) -- line: 116
        local v18 = arg3:GetAttribute("RankOrder") or 99
        local v19 = arg4:GetAttribute("RankOrder") or 99
        local v20

        if v18 ~= v19 then
            v20 = v18 < v19

            return v20
        end

        local v22 = string.lower(arg3:GetAttribute("RealName") or arg3.Name)
        v20 = v22 < string.lower(arg4:GetAttribute("RealName") or arg4.Name)

        return v20
    end)
    local t_8 = {}

    for _, val_1 in t_6 do
        local v24 = val_1:GetAttribute("RankOrder") or 4
        t_8[v24] = (t_8[v24] or 0) + 1
    end

    local t_9 = {}
    local v25 = nil
    local v26 = 0

    for _, val_2 in t_6 do
        local v27 = val_2:GetAttribute("RankOrder") or 4
        local v28 = t_1[v27] or t_1[4]

        if v27 ~= v25 then
            v25 = v27
            local v29 = "_Header_" .. v28.name
            local v30 = t_7[v29]

            if not v30 then
                v30 = HeaderTemplate:Clone()
                v30.Name = v29
            end

            t_9[v29] = true
            local v31 = string.upper(v28.name)
            local v32 = `{v31} ({t_8[v27]})`

            if v30.Text ~= v32 then
                v30.Text = v32
            end

            v26 += 1

            if v30.LayoutOrder ~= v26 then
                v30.LayoutOrder = v26
            end

            if v30.Parent ~= List then
                v30.Parent = List
            end
        end

        v26 += 1

        if val_2.LayoutOrder ~= v26 then
            val_2.LayoutOrder = v26
        end

        local Display = val_2:FindFirstChild("Display")
        local v33 = Display

        if v33 then
            v33 = Display:FindFirstChild("identity")
        end

        if v33 then
            local v34 = string.gsub(v33.Text, "^@", "")

            if v33.Text ~= v34 then
                v33.Text = v34
            end

            v33.TextColor3 = v28.color
        end

        hookRow(val_2)
    end

    for key_5, val_3 in t_7 do
        if not t_9[key_5] then
            val_3:Destroy()
        end
    end

    local v35 = #t_6
    Members.MembersTitle.Text = `Members ({v35})`
end

local function queue() -- line: 185
    -- upvalues:
    --  [1] v17 (ref)
    --  [2] regroup (copy)

    if v17 then
        return
    end

    v17 = true
    task.defer(regroup)
end

List.ChildAdded:Connect(function(child_1) -- line: 193
    -- upvalues:
    --  [1] v17 (ref)
    --  [2] regroup (copy)
    --  [3] queue (copy)

    if child_1:GetAttribute("IsHeader") then
        return
    end

    if not v17 then
        v17 = true
        task.defer(regroup)
    end

    if child_1:IsA("GuiObject") then
        child_1:GetPropertyChangedSignal("LayoutOrder"):Connect(queue)
    end
end)
List.ChildRemoved:Connect(function(child_2) -- line: 203
    -- upvalues:
    --  [1] v17 (ref)
    --  [2] regroup (copy)

    if not child_2:GetAttribute("IsHeader") then
        if v17 then
            return
        end

        v17 = true
        task.defer(regroup)
    end
end)

if not v17 then
    v17 = true
    task.defer(regroup)
end
