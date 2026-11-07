-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ProfessionCombatClient
-- Class: LocalScript
-- bytes: 2576

local Players = game:GetService("Players")
local Professions_m = require(game:GetService("ReplicatedStorage").Modules.Professions)
local LocalPlayer = Players.LocalPlayer
local Combat = LocalPlayer:WaitForChild("Professions"):WaitForChild("Combat")
local v1 = {}

local function refresh() -- line: 21
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] Professions_m (copy)
    --  [3] LocalPlayer (copy)

    v1 = Professions_m:GetPlayerBenefits(LocalPlayer, "Combat")
end

local color = Color3.fromRGB(255, 90, 90)
Combat:GetPropertyChangedSignal("Value"):Connect(refresh)
v1 = Professions_m:GetPlayerBenefits(LocalPlayer, "Combat")
local v2 = nil

local function mark(arg1) -- line: 34
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v2 (ref)
    --  [3] color (copy)

    if (v1.hunters_mark or 0) <= 0 then
        return
    end

    if v2 and v2.model ~= arg1 then
        v2.highlight:Destroy()
        v2 = nil
    end

    if not v2 then
        local HuntersMark_Highlight = Instance.new("Highlight")
        HuntersMark_Highlight.Name = "HuntersMark"
        HuntersMark_Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        HuntersMark_Highlight.FillTransparency = 1
        HuntersMark_Highlight.OutlineColor = color
        HuntersMark_Highlight.OutlineTransparency = 0.6
        HuntersMark_Highlight.Adornee = arg1
        HuntersMark_Highlight.Parent = arg1
        v2 = { model = arg1, highlight = HuntersMark_Highlight }
    end

    local t_1 = {}
    v2.token = t_1
    task.delay(10, function() -- line: 58
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] t_1 (copy)

        if v2 and v2.token == t_1 then
            v2.highlight:Destroy()
            v2 = nil
        end
    end)
end

local function watchTag(arg2) -- line: 66
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] mark (copy)

    if not arg2:IsA("Configuration") then
        return
    end

    local Character = LocalPlayer.Character

    if not Character or arg2.Name ~= Character.Name then
        return
    end

    local Parent = arg2.Parent

    if Parent then
        if not Parent:IsA("Model") then
            return
        end

        mark(Parent)
        arg2:GetAttributeChangedSignal("DMG"):Connect(function() -- line: 79
            -- upvalues:
            --  [1] arg2 (copy)
            --  [2] mark (ref)

            if arg2.Parent then
                mark(arg2.Parent)
            end
        end)

        return
    else
        return
    end
end

workspace:WaitForChild("FightableNPCS").DescendantAdded:Connect(watchTag)
