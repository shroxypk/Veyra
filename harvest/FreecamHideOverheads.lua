-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.FreecamHideOverheads
-- Class: LocalScript
-- bytes: 3752

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v1 = false
local t = {}
local t_1 = {}

local _ = function(arg1) --[[ hide ]] -- line: 33
    -- upvalues:
    --  [1] t (copy)

    if t[arg1] ~= nil then
        return
    end

    local MaxDistance = arg1.MaxDistance
    t[arg1] = if not (MaxDistance <= 0.01) then MaxDistance else math.huge
    arg1.MaxDistance = 0.01
end

local function hideAllIn(arg2) -- line: 49
    -- upvalues:
    --  [1] t (copy)

    for _, descendant in arg2:GetDescendants() do
        if descendant:IsA("BillboardGui") and t[descendant] == nil then
            local MaxDistance_1 = descendant.MaxDistance
            t[descendant] = if not (MaxDistance_1 <= 0.01) then MaxDistance_1 else math.huge
            descendant.MaxDistance = 0.01
        end
    end
end

local function setActive(arg3) -- line: 57
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] hideAllIn (copy)
    --  [3] PlayerGui (copy)
    --  [4] t_1 (copy)
    --  [5] t (copy)

    if arg3 == v1 then
        return
    end

    v1 = arg3

    if arg3 then
        hideAllIn(workspace)
        hideAllIn(PlayerGui)

        for _, val in { workspace, PlayerGui } do
            table.insert(t_1, val.DescendantAdded:Connect(function(descendant_1) -- line: 69
                -- upvalues:
                --  [1] t (ref)

                if descendant_1:IsA("BillboardGui") then
                    if t[descendant_1] ~= nil then
                        return
                    end

                    local MaxDistance_2 = descendant_1.MaxDistance
                    t[descendant_1] = if not (MaxDistance_2 <= 0.01) then MaxDistance_2 else math.huge
                    descendant_1.MaxDistance = 0.01
                end
            end))
        end

        return
    end

    for _, val_1 in t_1 do
        val_1:Disconnect()
    end

    table.clear(t_1)

    for key_3, val_2 in t do
        if key_3.Parent then
            key_3.MaxDistance = val_2
        end
    end

    table.clear(t)
end

local function watchFreecam(arg5) -- line: 90
    -- upvalues:
    --  [1] setActive (copy)
    --  [2] PlayerGui (copy)
    --  [3] v1 (ref)
    --  [4] t_1 (copy)
    --  [5] t (copy)

    local FreecamScript = arg5:WaitForChild("FreecamScript", 10)

    if not FreecamScript then
        return
    end

    local function refresh() -- line: 96
        -- upvalues:
        --  [1] setActive (ref)
        --  [2] FreecamScript (copy)

        setActive(if FreecamScript:GetAttribute("FreecamEnabled") ~= true then false else true)
    end

    setActive(if FreecamScript:GetAttribute("FreecamEnabled") ~= true then false else true)
    FreecamScript:GetAttributeChangedSignal("FreecamEnabled"):Connect(refresh)
    arg5.AncestryChanged:Connect(function() -- line: 104
        -- upvalues:
        --  [1] arg5 (copy)
        --  [2] PlayerGui (ref)
        --  [3] v1 (ref)
        --  [4] t_1 (ref)
        --  [5] t (ref)

        if not arg5:IsDescendantOf(PlayerGui) then
            if v1 == false then
                return
            end

            v1 = false

            for _, val_3 in t_1 do
                val_3:Disconnect()
            end

            table.clear(t_1)

            for key_5, val_4 in t do
                if key_5.Parent then
                    key_5.MaxDistance = val_4
                end
            end

            table.clear(t)
        end
    end)
end

PlayerGui.ChildAdded:Connect(function(child) -- line: 112
    -- upvalues:
    --  [1] watchFreecam (copy)

    if child.Name == "Freecam" then
        watchFreecam(child)
    end
end)
local Freecam = PlayerGui:FindFirstChild("Freecam")

if Freecam then
    task.spawn(watchFreecam, Freecam)
end
