-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Shared.ScreenFlash
-- Class: ModuleScript
-- bytes: 3113

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local t = { Color = Color3.new(1, 1, 1), StartTransparency = 0, HoldTime = 0.03, FadeTime = 0.35 }
local t_1 = {}
local v1 = nil
local v2 = nil

local function ensureFrame() -- line: 44
    -- upvalues:
    --  [1] Players (copy)
    --  [2] v2 (ref)
    --  [3] v1 (ref)
    --  [4] t (copy)

    local LocalPlayer = Players.LocalPlayer
    local v3 = LocalPlayer

    if v3 then
        v3 = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end

    if not v3 then
        return nil
    end

    if v2 and (v2.Parent and (v1 and v1.Parent == v3)) then
        return v2
    end

    local AbilityScreenFlash_ScreenGui = Instance.new("ScreenGui")
    AbilityScreenFlash_ScreenGui.Name = "AbilityScreenFlash"
    AbilityScreenFlash_ScreenGui.ResetOnSpawn = false
    AbilityScreenFlash_ScreenGui.IgnoreGuiInset = true
    AbilityScreenFlash_ScreenGui.DisplayOrder = 1000
    AbilityScreenFlash_ScreenGui.Enabled = false
    AbilityScreenFlash_ScreenGui.Parent = v3
    v3 = Instance.new("Frame")
    v3.Name = "Flash"
    v3.Size = UDim2.fromScale(1, 1)
    v3.Position = UDim2.fromScale(0, 0)
    v3.BorderSizePixel = 0
    v3.BackgroundColor3 = t.Color
    v3.BackgroundTransparency = 1
    v3.Active = false
    v3.Selectable = false
    v3.Parent = AbilityScreenFlash_ScreenGui
    v1 = AbilityScreenFlash_ScreenGui
    v2 = v3

    return v3
end

local v4 = nil
local v5 = 0

function t_1.Play(t1: table?) -- line: 81
    -- upvalues:
    --  [1] ensureFrame (copy)
    --  [2] v1 (ref)
    --  [3] t (copy)
    --  [4] v4 (ref)
    --  [5] v5 (ref)
    --  [6] v2 (ref)
    --  [7] TweenService (copy)

    local v6 = ensureFrame()

    if not v6 or not v1 then
        return
    end

    local v7 = t1 or {}
    local v8 = v7.Color or t.Color
    local v9 = v7.StartTransparency or t.StartTransparency
    local v10 = v7.HoldTime or t.HoldTime
    local v11 = v7.FadeTime or t.FadeTime

    if v4 then
        v4:Cancel()
        v4 = nil
    end

    v5 += 1
    local v12 = v5
    v6.BackgroundColor3 = v8
    v6.BackgroundTransparency = v9
    v1.Enabled = true

    function v9() --[[ fade ]] -- line: 107
        -- upvalues:
        --  [1] v12 (copy)
        --  [2] v5 (ref)
        --  [3] v2 (ref)
        --  [4] TweenService (ref)
        --  [5] v11 (copy)
        --  [6] v4 (ref)
        --  [7] v1 (ref)

        if v12 ~= v5 or not v2 or not v2.Parent then
            return
        end

        local v15 = TweenService:Create(
            v2,
            TweenInfo.new(v11, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { BackgroundTransparency = 1 }
        )
        v4 = v15
        v15.Completed:Once(function() -- line: 119
            -- upvalues:
            --  [1] v12 (ref)
            --  [2] v5 (ref)
            --  [3] v1 (ref)

            if v12 == v5 and v1 then
                v1.Enabled = false
            end
        end)
        v15:Play()
    end

    if v10 > 0 then
        task.delay(v10, v9)

        return
    end

    v9()
end

return t_1
