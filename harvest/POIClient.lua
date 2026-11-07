-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.POIClient
-- Class: LocalScript
-- bytes: 2520

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local t = {}

local _ = function(arg1, arg2, arg3) --[[ smoothstep ]] -- line: 8
    local v1 = math.clamp((arg3 - arg1) / (arg2 - arg1), 0, 1)

    return v1 * v1 * (3 - v1 * 2)
end

local function register(arg4) -- line: 13
    -- upvalues:
    --  [1] t (copy)

    local BillboardGui = arg4:FindFirstChildWhichIsA("BillboardGui")

    if not BillboardGui then
        return
    end

    local Main = BillboardGui:WaitForChild("Main")
    local Icon = Main:WaitForChild("icon")
    t[arg4] = { Billboard = BillboardGui, Icon = Icon, Text = Main:WaitForChild("header") }
end

local function unregister(arg5) -- line: 30
    -- upvalues:
    --  [1] t (copy)

    t[arg5] = nil
end

for _, val in CollectionService:GetTagged("POI") do
    register(val)
end

CollectionService:GetInstanceAddedSignal("POI"):Connect(register)
CollectionService:GetInstanceRemovedSignal("POI"):Connect(unregister)
RunService.RenderStepped:Connect(function() -- line: 41
    -- upvalues:
    --  [1] CurrentCamera (ref)
    --  [2] t (copy)

    CurrentCamera = workspace.CurrentCamera
    local Position = CurrentCamera.CFrame.Position
    local LookVector = CurrentCamera.CFrame.LookVector

    for key_1, val_1 in t do
        if key_1.Parent then
            local Magnitude = (Position - key_1.Position).Magnitude
            local v2 = key_1:GetAttribute("MaxDistance") or 550
            local v3 = key_1:GetAttribute("LookFadeStart") or 0.9

            if Magnitude >= v2 then
                val_1.Billboard.Enabled = false
            else
                local v4 = key_1:GetAttribute("FadeDistance") or 400
                local v5 = key_1:GetAttribute("LookFadeEnd") or 0.98
                val_1.Billboard.Enabled = true
                local v6 = v2 - v4
                local v7 = math.clamp((Magnitude - v6) / (v2 - v6), 0, 1)
                local v8 = 1 - v7 * v7 * (3 - v7 * 2)
                local v9 = math.clamp(
                    (LookVector:Dot((key_1.Position - Position).Unit) - v3) / (v5 - v3),
                    0,
                    1
                )
                val_1.Icon.ImageTransparency = 1 - v8
                local v10 = 1 - v8 * (v9 * v9 * (3 - v9 * 2))
                val_1.Text.TextTransparency = v10
                val_1.Text.TextStrokeTransparency = math.clamp(v10 + 0.25, 0.25, 1)
            end
        end
    end
end)
