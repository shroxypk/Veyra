-- Decompiled with Veyra harvester
-- Instance: StarterGui.RespawnUI.RespawnClient
-- Class: LocalScript
-- bytes: 17428

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local _ = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local GamepadService = game:GetService("GamepadService")
local Modules = ReplicatedStorage.Modules
local GetDamageTags_m = require(Modules.GetDamageTags)
local Basic_m = require(Modules.Basic)
local StatManager_m = require(Modules.StatManager)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local CurrentCamera = workspace.CurrentCamera
local v5 = Services_m.Maid.new()
local v6 = Services_m.Maid.new()
local Visual = script.Parent.Visual
local v7 = nil
Visual.Main.Buttons.Shrine.Button.MouseButton1Up:Connect(function() -- line: 31
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] v2 (copy)
    --  [3] ReplicatedStorage (copy)

    if not v7 then
        v7 = true
        ReplicatedStorage.LoadCharacter:InvokeServer(
            "Nearest",
            (v2:WaitForChild("PlayerGui"):FindFirstChild("LocationClient", true):GetAttribute(
                "CurrentLocation"
            ))
        )
        task.wait(0.5)
        v7 = false
    end
end)
Visual.Main.Buttons.Inn.Button.MouseButton1Up:Connect(function() -- line: 42
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] ReplicatedStorage (copy)

    if not v7 then
        v7 = true
        ReplicatedStorage.LoadCharacter:InvokeServer()
        task.wait(0.5)
        v7 = false
    end
end)
Visual.Main.Buttons.Mission.Button.MouseButton1Up:Connect(function() -- line: 50
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] ReplicatedStorage (copy)

    if not v7 then
        v7 = true
        ReplicatedStorage.LoadCharacter:InvokeServer("Mission")
        task.wait(0.5)
        v7 = false
    end
end)
v2:GetAttributeChangedSignal("InMissionInstance"):Connect(function() -- line: 59
    -- upvalues:
    --  [1] Visual (copy)
    --  [2] v2 (copy)

    Visual.Main.Buttons.Mission.Visible = v2:GetAttribute("InMissionInstance")
end)
local t = {}

for _, descendant in Visual:GetDescendants() do
    if not descendant:IsA("Frame") then
        if descendant:IsA("TextButton") then
            t[descendant] = { Original = descendant.BackgroundTransparency }
            descendant.BackgroundTransparency = 1
        elseif descendant:IsA("TextLabel") then
            t[descendant] = { Original = descendant.TextTransparency }
            descendant.TextTransparency = 1
        elseif descendant:IsA("ImageLabel") then
            t[descendant] = { Original = descendant.ImageTransparency }
            descendant.ImageTransparency = 1
        end
    else
        t[descendant] = { Original = descendant.BackgroundTransparency }
        descendant.BackgroundTransparency = 1

        if descendant:IsA("TextLabel") then
            t[descendant] = { Original = descendant.TextTransparency }
            descendant.TextTransparency = 1
        elseif descendant:IsA("ImageLabel") then
            t[descendant] = { Original = descendant.ImageTransparency }
            descendant.ImageTransparency = 1
        end
    end
end

local t_4 = {
    Default = script.KamoInn,
    Eldritch = script.EldritchInn,
    DOT = script.BeamsInn,
    Mushroom = script.MushroomInn
}

local _ = function(arg1, arg2) --[[ isRegionAllowed ]] -- line: 98
    local Region = arg1:GetAttribute("Region")

    if not Region or Region == "" then
        return true
    end

    return if table.find(string.split(Region, "_"), arg2) == nil then false else true
end

local function getDamaged(arg3) -- line: 107
    -- upvalues:
    --  [1] Visual (copy)
    --  [2] GetDamageTags_m (copy)

    for _, child in Visual.Main.Scrolling:GetChildren() do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local v9 = arg3:FindFirstChildWhichIsA("Humanoid").MaxHealth
    v9 = 0
    local v10 = GetDamageTags_m:SearchInstance(arg3)

    for key_2, _ in v10 do
        v9 += key_2:GetAttribute("DMGTotal")
    end

    local _

    for key_3, val_1 in v10 do
        local DMGTotal = key_3:GetAttribute("DMGTotal")
        local v11 = val_1 and val_1.Name or string.gsub(key_3.Name, " Respawnable", "")
        local v12 = string.format(": <b>%.2f", DMGTotal / v9 * 100) .. "%</b>"
        local v13 = script.Label:Clone()
        v13.Name = v11
        v13.Text = val_1 and v11 .. " (" .. val_1.UserId .. ")" .. v12 or v11 .. v12
        v13.Parent = Visual.Main.Scrolling
    end
end

local function releaseGamepadInput() -- line: 138
    -- upvalues:
    --  [1] GamepadService (copy)
    --  [2] GuiService (copy)

    pcall(function() -- line: 139
        -- upvalues:
        --  [1] GamepadService (ref)

        if GamepadService.GamepadCursorEnabled then
            warn("[RespawnClient] gamepad cursor still enabled after respawn; disabling")
            GamepadService:DisableGamepadCursor()
        end
    end)
    pcall(function() -- line: 145
        -- upvalues:
        --  [1] GuiService (ref)

        local SelectedObject = GuiService.SelectedObject

        if SelectedObject and SelectedObject:IsDescendantOf(script.Parent) then
            GuiService.SelectedObject = nil
        end
    end)
end

local v15 = false
local v16 = false

local function ToggleTopbar(arg4) -- line: 164
    -- upvalues:
    --  [1] StarterGui (copy)

    pcall(function() -- line: 165
        -- upvalues:
        --  [1] StarterGui (ref)
        --  [2] arg4 (copy)

        local function coreCall(arg5, ...) -- line: 168
            -- upvalues:
            --  [1] StarterGui (ref)

            local t_6 = {}

            for _ = 1, 12 do
                if ({ pcall(StarterGui[arg5], StarterGui, ...) })[1] then
                    break
                end

                task.wait()
            end

            return unpack(t_6)
        end

        coreCall("SetCore", "TopbarEnabled", arg4)
    end)
end

local function deathTween(arg6, arg7, arg8) -- line: 186
    -- upvalues:
    --  [1] v6 (copy)

    local v18 = _G.Tween(arg6, arg7, arg8)

    if v18 then
        v6:GiveTask(v18)
    end

    return v18
end

local t_7 = { 0.5, "Linear", Enum.EasingDirection.Out }

local function fadeElements(arg9) -- line: 194
    -- upvalues:
    --  [1] deathTween (copy)
    --  [2] t (copy)
    --  [3] t_7 (copy)

    local v19 = arg9 and deathTween or _G.Tween
    local t_10, t_8, t_9
    local v20

    for key_4, val_2 in t do
        if not key_4:IsA("Frame") then
            if key_4:IsA("TextButton") then
                t_8 = { BackgroundTransparency = nil }
                v20 = arg9 and val_2.Original or 1
                local v21 = t_7
                t_8.BackgroundTransparency = v20
                v19(key_4, v21, t_8)
            elseif key_4:IsA("TextLabel") then
                t_9 = { TextTransparency = nil, TextStrokeTransparency = nil }
                v20 = arg9 and val_2.Original or 1
                local v22 = t_7
                t_9.TextTransparency = v20
                t_9.TextStrokeTransparency = if not arg9 then 1 else 0.8
                v19(key_4, v22, t_9)
            elseif key_4:IsA("ImageLabel") then
                t_10 = { ImageTransparency = nil }
                v20 = arg9 and val_2.Original or 1
                local v23 = t_7
                t_10.ImageTransparency = v20
                v19(key_4, v23, t_10)
            end
        else
            t_8 = { BackgroundTransparency = nil }
            v20 = arg9 and val_2.Original or 1
            local v24 = t_7
            t_8.BackgroundTransparency = v20
            v19(key_4, v24, t_8)

            if key_4:IsA("TextLabel") then
                t_9 = { TextTransparency = nil, TextStrokeTransparency = nil }
                v20 = arg9 and val_2.Original or 1
                local v25 = t_7
                t_9.TextTransparency = v20
                t_9.TextStrokeTransparency = if not arg9 then 1 else 0.8
                v19(key_4, v25, t_9)
            elseif key_4:IsA("ImageLabel") then
                t_10 = { ImageTransparency = nil }
                v20 = arg9 and val_2.Original or 1
                local v26 = t_7
                t_10.ImageTransparency = v20
                v19(key_4, v26, t_10)
            end
        end
    end
end

local function HideDeathScreen() -- line: 209
    -- upvalues:
    --  [1] v6 (copy)
    --  [2] v15 (ref)
    --  [3] v7 (ref)
    --  [4] fadeElements (copy)
    --  [5] Visual (copy)
    --  [6] v16 (ref)
    --  [7] CurrentCamera (copy)
    --  [8] v2 (copy)
    --  [9] releaseGamepadInput (copy)
    --  [10] ToggleTopbar (copy)

    v6:DoCleaning()
    v15 = false
    v7 = false
    fadeElements(false)
    Visual.Main.Visible = false
    Visual.Vignette.Visible = false
    Visual.Skull.Message.Visible = false
    _G.CameraHover = false

    if v16 then
        v16 = false

        if CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end

    v2.ReplicationFocus = nil
    releaseGamepadInput()
    task.spawn(ToggleTopbar, true)
end

local Shrines = workspace.Map.Structures.Shrines
local Fade = Visual.Fade

local function ShowDeathScreen() -- line: 239
    -- upvalues:
    --  [1] v15 (ref)
    --  [2] StarterGui (copy)
    --  [3] getDamaged (copy)
    --  [4] v2 (copy)
    --  [5] fadeElements (copy)
    --  [6] v4 (copy)
    --  [7] Shrines (copy)
    --  [8] Basic_m (copy)
    --  [9] CurrentCamera (copy)
    --  [10] Visual (copy)
    --  [11] Fade (copy)
    --  [12] v6 (copy)
    --  [13] v16 (ref)
    --  [14] t_4 (copy)
    --  [15] ReplicatedStorage (copy)

    v15 = true
    local v27 = false
    pcall(function() -- line: 165
        -- upvalues:
        --  [1] StarterGui (ref)
        --  [2] v27 (copy)

        (function(arg10, ...) --[[ coreCall ]] -- line: 168
            -- upvalues:
            --  [1] StarterGui (ref)

            local t_12 = {}

            for _ = 1, 12 do
                if ({ pcall(StarterGui[arg10], StarterGui, ...) })[1] then
                    break
                end

                task.wait()
            end

            return unpack(t_12)
        end)("SetCore", "TopbarEnabled", v27)
    end)
    pcall(getDamaged, v2.Character)
    fadeElements(true)
    task.wait(0.2)
    local TrueSpawn = v4:GetStat("TrueSpawn")
    local v29 = workspace.Effects.Spawns:FindFirstChild(TrueSpawn)
    local CurrentLocation_1 = v2:WaitForChild("PlayerGui"):FindFirstChild("LocationClient", true):GetAttribute(
        "CurrentLocation"
    )
    local v30 = nil
    local v31 = math.huge
    local Magnitude, Region_1
    local v32, v33

    for _, child_1 in Shrines:GetChildren() do
        if child_1:IsA("Model") and child_1.PrimaryPart then
            local Uid = child_1:GetAttribute("uid")

            if Uid then
                if v2:GetAttribute(Uid) then
                    v32 = child_1:GetAttribute("Range") or Basic_m.ShrineProximity
                    Magnitude = (child_1.PrimaryPart.CFrame.Position - CurrentCamera.CFrame.Position).Magnitude

                    if v32 > Magnitude and v31 > Magnitude then
                        Region_1 = child_1:GetAttribute("Region")

                        if not Region_1 or Region_1 == "" then
                            v33 = true
                        else
                            v33 = if table.find(string.split(Region_1, "_"), CurrentLocation_1) == nil then false else true
                        end

                        if v33 then
                            v30 = child_1
                            v31 = Magnitude
                        end
                    end
                end
            else
                v32 = child_1:GetAttribute("Range") or Basic_m.ShrineProximity
                Magnitude = (child_1.PrimaryPart.CFrame.Position - CurrentCamera.CFrame.Position).Magnitude

                if v32 > Magnitude and v31 > Magnitude then
                    Region_1 = child_1:GetAttribute("Region")

                    if not Region_1 or Region_1 == "" then
                        v33 = true
                    else
                        v33 = if table.find(string.split(Region_1, "_"), CurrentLocation_1) == nil then false else true
                    end

                    if v33 then
                        v30 = child_1
                        v31 = Magnitude
                    end
                end
            end
        end
    end

    v31 = v30 ~= nil
    Visual.Skull.Position = UDim2.new(0.5, 0, -0.5, 0)
    local v34 = _G.Tween(
        Fade,
        { 1.5, "Quad", Enum.EasingDirection.Out },
        { BackgroundTransparency = 0 }
    )

    if v34 then
        v6:GiveTask(v34)
    end

    task.wait(1.5)
    Visual.Vignette.Visible = true
    v16 = true
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    local v36

    if v31 then
        Visual.Main.Buttons.Shrine.Visible = true
        local v35 = v30.PrimaryPart.CFrame
        v36 = CFrame.lookAt(
            (v35 * CFrame.new(0, 8, -17)).Position,
            v35.Position + Vector3.new(0, 6, 0)
        )
    else
        Visual.Main.Buttons.Shrine.Visible = false
        local v37 = t_4[TrueSpawn] or t_4.Default
        local v38 = v2
        v38.ReplicationFocus = v29 and v29:FindFirstChildWhichIsA("BasePart") or nil
        v36 = v37.CFrame
    end

    pcall(
        ReplicatedStorage.Remotes.RequestStreamAround.InvokeServer,
        ReplicatedStorage.Remotes.RequestStreamAround,
        v36.Position
    )
    CurrentCamera.CFrame = v36
    _G.CameraHover = true
    v36 = _G.Tween(Fade, { 1, "Quad", Enum.EasingDirection.Out }, { BackgroundTransparency = 1 })

    if v36 then
        v6:GiveTask(v36)
    end

    task.wait(1)
    v31 = _G.Tween(
        Visual.Skull,
        { 0.5, "Quad", Enum.EasingDirection.Out },
        { ImageTransparency = 0 }
    )

    if v31 then
        v6:GiveTask(v31)
    end

    task.wait(0.5)
    Visual.Skull.Message.Visible = true
    task.wait(0.1)
    local t_19 = { Position = UDim2.new(0.5, 0, 0.15, 0) }
    v30 = _G.Tween(Visual.Skull, { 0.5, "Quad", Enum.EasingDirection.Out }, t_19)

    if v30 then
        v6:GiveTask(v30)
    end

    task.wait(0.5)
    Visual.Main.Visible = true
end

local _ = function() --[[ isDead ]] -- line: 324
    -- upvalues:
    --  [1] v2 (copy)

    local Character = v2.Character
    local v40 = Character

    if v40 then
        v40 = Character:FindFirstChildWhichIsA("Humanoid")
    end

    local v41 = not v40

    if not v41 then
        v41 = true

        if not (v40.Health <= 0) then
            v41 = if v40:GetState() ~= Enum.HumanoidStateType.Dead then false else true
        end
    end

    return v41
end

local function PlayerDied() -- line: 331
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] v6 (copy)
    --  [3] v2 (copy)
    --  [4] ShowDeathScreen (copy)

    v5:DoCleaning()
    v6:DoCleaning()
    v6:GiveTask(task.delay(3, function() -- line: 334
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] ShowDeathScreen (ref)

        while true do
            if not v2:GetAttribute("InvasionRespawnLocked") then
                break
            end

            v2:GetAttributeChangedSignal("InvasionRespawnLocked"):Wait()
        end

        local Character_1 = v2.Character
        local v42 = Character_1

        if v42 then
            v42 = Character_1:FindFirstChildWhichIsA("Humanoid")
        end

        local v43 = not v42

        if not v43 then
            v43 = true

            if not (v42.Health <= 0) then
                v43 = if v42:GetState() ~= Enum.HumanoidStateType.Dead then false else true
            end
        end

        if not v43 then
            return
        end

        ShowDeathScreen()
    end))
end

v2:GetAttributeChangedSignal("InvasionRespawnLocked"):Connect(function() -- line: 345
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] v15 (ref)
    --  [3] HideDeathScreen (copy)
    --  [4] PlayerDied (copy)

    if v2:GetAttribute("InvasionRespawnLocked") and v15 then
        local Character_2 = v2.Character
        local v45 = Character_2

        if v45 then
            v45 = Character_2:FindFirstChildWhichIsA("Humanoid")
        end

        local v46 = not v45

        if not v46 then
            v46 = true

            if not (v45.Health <= 0) then
                v46 = if v45:GetState() ~= Enum.HumanoidStateType.Dead then false else true
            end
        end

        if v46 then
            HideDeathScreen()
            PlayerDied()
        end
    end
end)

local function CharacterSpawned(arg11) -- line: 354
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] HideDeathScreen (copy)
    --  [3] v2 (copy)
    --  [4] PlayerDied (copy)

    v5:DoCleaning()
    HideDeathScreen()
    local Humanoid = arg11:WaitForChild("Humanoid")

    if Humanoid and v2.Character == arg11 then
        v5:GiveTask(Humanoid.Died:Connect(PlayerDied))

        if Humanoid.Health <= 0 then
            PlayerDied()
        end
    end
end

v2.CharacterAdded:Connect(CharacterSpawned)

if v2.Character and v2.Character ~= v3 then
    task.spawn(CharacterSpawned, v2.Character)
else
    v5:GiveTask(v3:WaitForChild("Humanoid").Died:Connect(PlayerDied))
end
