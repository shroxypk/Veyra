-- Decompiled with Veyra harvester
-- Instance: StarterGui.Location.Window.Location.LocationClient
-- Class: LocalScript
-- bytes: 36032

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Modules = ReplicatedStorage.Modules
local Locations = ReplicatedStorage._Locations
local Locations_m = require(ReplicatedStorage.Locations)
local DictionaryRandom_m = require(Modules.DictionaryRandom)
local WeatherZones_m = require(Modules.WeatherZones)
local ControlWeather_m = require(Modules.ControlWeather)
local RegionManager_m = require(Modules.RegionManager)
local EnvironmentMaterials_m = require(Modules.EnvironmentMaterials)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local Bin = v2:WaitForChild("bin")
local Humanoid = v3:WaitForChild("Humanoid")
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")

if not v2:GetAttribute("Loaded") then
    v2:GetAttributeChangedSignal("Loaded"):Wait()
end

local t = {
    Mines = true,
    EldLair = true,
    BoarDen = true,
    WolfDen = true,
    UndergroundChamber = true,
    OutpostCave = true,
    AlkeBoss = true,
    LizardBossAtmosphere = true,
    TempleLibrary = true,
    Dojo = true,
    AncientTemple = true,
    AshenTemple = true,
    Mortem = true,
    Glad = true
}
local t_1 = { ["97977767295461"] = 1.5 }
local v4 = if RunService:IsStudio() then 1 else 5
local t_2 = { ["Past Adventures"] = 93925854840684 }
local LocationAlert = ReplicatedStorage.SFX.Misc.LocationAlert
local Parent = script.Parent
local Place = Parent.Place
local Desc = Parent.Desc
local GameMusic = script.Music.GameMusic
local Action = script.Music.Action
local EventMusic = script.Music.EventMusic
local BackgroundMusic = game:GetService("SoundService"):WaitForChild("BackgroundMusic")

for _, val in { GameMusic, Action, EventMusic } do
    val.SoundGroup = BackgroundMusic
end

local Atmosphere = script.Atmosphere
local Environment = script.Environment
local Ambience = Environment.Ambience
local Weather = script:WaitForChild("Weather")
local Sky = Lighting:FindFirstChildWhichIsA("Sky")
local Clouds = workspace.Terrain:FindFirstChildWhichIsA("Clouds")
local ColorCorrection = Lighting:FindFirstChild("ColorCorrection")
local Atmosphere_1 = Lighting:FindFirstChildWhichIsA("Atmosphere")

if not Atmosphere_1 then
    Atmosphere_1 = Instance.new("Atmosphere")
    Atmosphere_1.Parent = Lighting
end

Atmosphere_1:SetAttribute("Active", nil)
_G.NOFLYZONE = false
_G.WISP_DENSITY = false
local v7 = true
local t_3 = {}
local v8 = false

local _ = function(arg1) --[[ track ]] -- line: 133
    -- upvalues:
    --  [1] t_3 (copy)

    table.insert(t_3, arg1)

    return arg1
end

local _ = function() --[[ inCombat ]] -- line: 138
    -- upvalues:
    --  [1] v2 (copy)

    if v2:GetAttribute("InCombat") then
        return true
    end

    return false
end

local _ = function() --[[ isRaining ]] -- line: 143
    return if script:GetAttribute("Weather") ~= true then false else true
end

local _ = function(arg2) --[[ getEnvironmentSettings ]] -- line: 147
    -- upvalues:
    --  [1] Atmosphere (copy)

    return arg2 and Atmosphere:FindFirstChild(arg2) or Atmosphere.Normal
end

local _ = function() --[[ isNight ]] -- line: 151
    -- upvalues:
    --  [1] Lighting (copy)

    local ClockTime = Lighting.ClockTime

    return ClockTime >= 18 or ClockTime < 6
end

local _ = function(arg3) --[[ forTimeOfDay ]] -- line: 157
    -- upvalues:
    --  [1] Lighting (copy)

    local ClockTime_1 = Lighting.ClockTime

    return (ClockTime_1 >= 18 or ClockTime_1 < 6) and arg3:FindFirstChild("Night") or arg3
end

local _ = function(arg4) --[[ bloodMoonApplies ]] -- line: 161
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Atmosphere (copy)
    --  [3] t (copy)

    if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then
        return false
    end

    arg4 = arg4 or "Normal"
    local v14 = Atmosphere:FindFirstChild(arg4)
    local v15 = not t[arg4]

    if v15 then
        local v16 = v14

        if v16 then
            v16 = v14:FindFirstChild("setTime")
        end

        v15 = not v16
    end

    return v15
end

local _ = function() --[[ getRoamingEnvironment ]] -- line: 170
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Atmosphere (copy)

    local Season = ReplicatedStorage:GetAttribute("Season")

    if Season and Atmosphere:FindFirstChild(Season) then
        return Season
    end

    return "Normal"
end

local _ = function() --[[ getAppliedSettings ]] -- line: 179
    -- upvalues:
    --  [1] Atmosphere_1 (ref)
    --  [2] ReplicatedStorage (copy)
    --  [3] Atmosphere (copy)
    --  [4] t (copy)
    --  [5] Lighting (copy)

    local Active = Atmosphere_1:GetAttribute("Active")
    local v17

    if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then
        v17 = false
    else
        Active = Active or "Normal"
        local v18 = Atmosphere:FindFirstChild(Active)
        v17 = not t[Active]

        if v17 then
            local v19 = v18

            if v19 then
                v19 = v18:FindFirstChild("setTime")
            end

            v17 = not v19
        end
    end

    if v17 then
        return script.BloodMoon
    end

    v17 = if script:GetAttribute("Weather") ~= true then false else true

    if v17 then
        return Atmosphere.Rain
    end

    local v20 = Atmosphere_1:GetAttribute("Active")
    local v21 = v20 and Atmosphere:FindFirstChild(v20) or Atmosphere.Normal
    local ClockTime_2 = Lighting.ClockTime
    v20 = ClockTime_2 >= 18 or ClockTime_2 < 6
    v17 = v20 and v21:FindFirstChild("Night") or v21

    return v17
end

local _ = function(arg5) --[[ getTargetDensity ]] -- line: 189
    local v22 = if not _G.WISP_DENSITY then 1 else 0.85

    return arg5.Density * v22
end

local function waitForLoad(arg6) -- line: 194
    if arg6.SoundId == "" then
        return false
    end

    local clock = os.clock()

    while true do
        if arg6.IsLoaded then
            break
        end

        if not (os.clock() - clock < 10) then
            break
        end

        task.wait()
    end

    return arg6.IsLoaded
end

local t_4 = { 0.5, "Quad", Enum.EasingDirection.Out }
local v23 = 0

local function tweenLocationDisplay(arg7) -- line: 208
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] t_4 (copy)

    local v25

    for _, descendant in Parent:GetDescendants() do
        if not descendant:IsDescendantOf(script) then
            local v24 = nil

            if descendant:IsA("TextLabel") then
                v25 = if not arg7 then { TextTransparency = 1, TextStrokeTransparency = 1 } else {
                    TextTransparency = 0,
                    TextStrokeTransparency = 0.7
                } or { TextTransparency = 1, TextStrokeTransparency = 1 }
                v24 = v25
            elseif descendant:IsA("ImageLabel") then
                v25 = if not arg7 then { ImageTransparency = 1 } else { ImageTransparency = 0.35 } or {
                    ImageTransparency = 1
                }
                v24 = v25
            elseif descendant:IsA("UIStroke") then
                v25 = if not arg7 then { Transparency = 1 } else { Transparency = 0 } or {
                    Transparency = 1
                }
                v24 = v25
            end

            if v24 then
                _G.Tween(descendant, t_4, v24)
            end
        end
    end
end

local _ = function() --[[ showBanner ]] -- line: 230
    -- upvalues:
    --  [1] v23 (ref)
    --  [2] tweenLocationDisplay (copy)
    --  [3] v4 (copy)
    --  [4] v7 (ref)

    v23 += 1
    local v26 = v23
    tweenLocationDisplay(true)
    task.delay(v4, function() -- line: 237
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] v26 (copy)
        --  [3] v23 (ref)
        --  [4] tweenLocationDisplay (ref)

        if v7 and v26 == v23 then
            tweenLocationDisplay(false)
        end
    end)
end

local tweenInfo = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v27 = TweenService:Create(GameMusic, tweenInfo, { Volume = 0 })
local v28 = TweenService:Create(Action, tweenInfo, { Volume = 0.25 })
local v29 = TweenService:Create(Action, tweenInfo, { Volume = 0 })
local v30 = v29.Completed:Connect(function(playbackState) -- line: 250
    -- upvalues:
    --  [1] Action (copy)

    if playbackState == Enum.PlaybackState.Completed then
        Action:Stop()
    end
end)
table.insert(t_3, v30)
local v31 = 0
local v32 = nil
local v33 = nil

local _ = function(arg9) --[[ setMusicVolume ]] -- line: 261
    -- upvalues:
    --  [1] v33 (ref)
    --  [2] GameMusic (copy)

    if v33 and v33.PlaybackState == Enum.PlaybackState.Playing then
        return
    end

    GameMusic.Volume = arg9
end

local function playTrack(arg10, arg11, arg12, arg13) -- line: 269
    -- upvalues:
    --  [1] GameMusic (copy)
    --  [2] v2 (copy)
    --  [3] v27 (copy)
    --  [4] v31 (ref)
    --  [5] waitForLoad (copy)
    --  [6] v33 (ref)
    --  [7] TweenService (copy)

    if not arg10 or arg10 == 0 or arg10 == "" then
        return true
    end

    local v34 = "rbxassetid://" .. tostring(arg10)

    if GameMusic.SoundId ~= v34 then
        if not (if v2:GetAttribute("InCombat") then true else false) and GameMusic.Playing then
            v27:Play()
            v27.Completed:Wait()

            if arg12 ~= v31 then
                return false
            end
        end

        GameMusic.SoundId = v34
        waitForLoad(GameMusic)

        if arg12 ~= v31 then
            return false
        end

        if arg13 then
            if arg13 > 0 then
                if not (if v2:GetAttribute("InCombat") then true else false) then
                    if v33 then
                        v33:Cancel()
                    end

                    GameMusic.Volume = 0
                    v33 = TweenService:Create(
                        GameMusic,
                        TweenInfo.new(arg13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                        { Volume = arg11 }
                    )
                    GameMusic:Play()
                    v33:Play()
                else
                    GameMusic:Play()
                end
            else
                GameMusic:Play()
            end
        else
            GameMusic:Play()
        end
    elseif not GameMusic.Playing then
        GameMusic:Play()
    end

    if not (if v2:GetAttribute("InCombat") then true else false) and not (v33 and v33.PlaybackState == Enum.PlaybackState.Playing) then
        GameMusic.Volume = arg11
    end

    return true
end

local function playAmbience(arg14) -- line: 310
    -- upvalues:
    --  [1] Environment (copy)
    --  [2] Ambience (copy)
    --  [3] waitForLoad (copy)
    --  [4] v7 (ref)

    if arg14 and arg14:match("Inner Realm") then
        return
    end

    local v40 = arg14 and Environment:FindFirstChild(arg14) or Environment.Normal

    for index = 1, 3 do
        local v42 = Ambience:FindFirstChild((tostring(index)))

        if v42 then
            local v43 = v40:FindFirstChild((tostring(index)))

            if v43 then
                if v43:IsA("Sound") then
                    if v42.SoundId == v43.SoundId then
                        if not v42.Playing then
                            v42.SoundId = v43.SoundId
                            task.spawn(function() -- line: 328
                                -- upvalues:
                                --  [1] waitForLoad (ref)
                                --  [2] v42 (copy)
                                --  [3] v7 (ref)
                                --  [4] v43 (copy)

                                if waitForLoad(v42) and v7 and v42.SoundId == v43.SoundId then
                                    v42:Play()
                                end
                            end)
                        end
                    else
                        v42.SoundId = v43.SoundId
                        task.spawn(function() -- line: 328
                            -- upvalues:
                            --  [1] waitForLoad (ref)
                            --  [2] v42 (copy)
                            --  [3] v7 (ref)
                            --  [4] v43 (copy)

                            if waitForLoad(v42) and v7 and v42.SoundId == v43.SoundId then
                                v42:Play()
                            end
                        end)
                    end
                else
                    v42:Stop()
                    v42.SoundId = ""
                end
            else
                v42:Stop()
                v42.SoundId = ""
            end
        end
    end
end

local function updateMusic() -- line: 341
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] v31 (ref)
    --  [3] Locations_m (copy)
    --  [4] v32 (ref)
    --  [5] playAmbience (copy)
    --  [6] t_2 (copy)
    --  [7] DictionaryRandom_m (copy)
    --  [8] v2 (copy)
    --  [9] playTrack (copy)
    --  [10] Bin (copy)
    --  [11] v28 (copy)
    --  [12] v27 (copy)
    --  [13] v33 (ref)
    --  [14] Action (copy)
    --  [15] GameMusic (copy)
    --  [16] EventMusic (copy)
    --  [17] t_1 (copy)
    --  [18] waitForLoad (copy)
    --  [19] v29 (copy)

    if not v7 then
        return
    end

    v31 += 1
    local v44 = v31
    local v45 = script:GetAttribute("CurrentLocation")
    local v46 = v45

    if v46 then
        v46 = Locations_m:GetInfo(v45)
    end

    local v47, v48, v49

    if v46 then
        v32 = nil
        v47 = v46.Song
        v48 = v46.Volume or 0.25
        v49 = if v46.OverrideCombat ~= true then false else true
        playAmbience(v45)
    else
        if not v32 and next(t_2) then
            v32 = DictionaryRandom_m.DictionarySelectRandom(t_2)
        end

        v47 = v32
        v48 = 0.25
        v49 = false
        playAmbience(nil)
    end

    v45 = nil
    local MusicOverride = v2:GetAttribute("MusicOverride")

    if MusicOverride and (MusicOverride ~= "" and (not v46 or not v46.KeepSong)) then
        v47 = MusicOverride
        v48 = v2:GetAttribute("MusicOverrideVolume") or v48
        v49 = true
        v45 = v2:GetAttribute("MusicOverrideFade")
    end

    if not playTrack(v47, v48, v44, v45) then
        return
    end

    local str_2 = tostring(Bin.Event.Value)

    if str_2 ~= "" then
        v28:Cancel()
        v27:Cancel()

        if v33 then
            v33:Cancel()
        end

        Action.Volume = 0
        GameMusic.Volume = 0
        v46 = "rbxassetid://" .. str_2

        if EventMusic.SoundId ~= v46 then
            EventMusic:Stop()
            EventMusic.SoundId = v46
        end

        EventMusic.Volume = t_1[str_2] or 0.4

        if not waitForLoad(EventMusic) or v44 ~= v31 then
            return
        end

        if not EventMusic.Playing then
            EventMusic:Play()
        end

        return
    end

    if EventMusic.Playing then
        EventMusic:Stop()
    end

    if (if v2:GetAttribute("InCombat") then true else false) and not v49 then
        if v33 then
            v33:Cancel()
        end

        v27:Play()
        v29:Cancel()

        if not Action.Playing then
            Action:Play()
        end

        v28:Play()

        return
    end

    v28:Cancel()

    if Action.Playing then
        v29:Play()
    end

    v27:Cancel()

    if v33 and v33.PlaybackState == Enum.PlaybackState.Playing then
        return
    end

    GameMusic.Volume = v48
end

local function updateLocation() -- line: 437
    -- upvalues:
    --  [1] updateMusic (copy)
    --  [2] Locations_m (copy)
    --  [3] Place (copy)
    --  [4] Desc (copy)
    --  [5] v23 (ref)
    --  [6] tweenLocationDisplay (copy)
    --  [7] v4 (copy)
    --  [8] v7 (ref)
    --  [9] LocationAlert (copy)
    --  [10] ReplicatedStorage (copy)

    task.spawn(updateMusic)
    local CurrentLocation = script:GetAttribute("CurrentLocation")

    if not CurrentLocation then
        return
    end

    local v51 = Locations_m:GetInfo(CurrentLocation)

    if not v51 then
        return
    end

    Place.Text = CurrentLocation:split("_")[1]

    if typeof(v51.Color) == "Color3" then
        Place.TextColor3 = v51.Color
    end

    Desc.Text = v51.Desc or ""
    v23 += 1
    local v53 = v23
    tweenLocationDisplay(true)
    task.delay(v4, function() -- line: 237
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] v53 (copy)
        --  [3] v23 (ref)
        --  [4] tweenLocationDisplay (ref)

        if v7 and v53 == v23 then
            tweenLocationDisplay(false)
        end
    end)
    LocationAlert:Play()
    local DiscoverMap = ReplicatedStorage.Remotes:FindFirstChild("DiscoverMap")

    if DiscoverMap and DiscoverMap:IsA("RemoteFunction") then
        task.spawn(function() -- line: 461
            -- upvalues:
            --  [1] DiscoverMap (copy)
            --  [2] CurrentLocation (copy)

            local Success, Result = pcall(
                DiscoverMap.InvokeServer,
                DiscoverMap,
                "AddLocation",
                CurrentLocation
            )

            if not Success then
                warn("[LocationClient] DiscoverMap failed:", Result)
            end
        end)
    end
end

local v54 = Bin.Event:GetPropertyChangedSignal("Value"):Connect(updateMusic)
table.insert(t_3, v54)
local v55 = v2:GetAttributeChangedSignal("InCombat"):Connect(updateMusic)
table.insert(t_3, v55)
local v56 = v2:GetAttributeChangedSignal("MusicOverride"):Connect(updateMusic)
table.insert(t_3, v56)
local v57 = script:GetAttributeChangedSignal("CurrentLocation"):Connect(updateLocation)
table.insert(t_3, v57)
task.spawn(updateMusic)
local v58 = v2.Name .. "_EnvironmentPart"
local Effects = workspace:FindFirstChild("Effects")
local v59 = false

local function clearEnvironmentEffects(arg15) -- line: 480
    -- upvalues:
    --  [1] Effects (copy)
    --  [2] v58 (copy)
    --  [3] Debris (copy)

    if not Effects then
        return
    end

    for _, child in Effects:GetChildren() do
        if child.Name == v58 then
            child.Name = "."

            if arg15 then
                child:Destroy()
            else
                local ParticleEmitter = child:FindFirstChildWhichIsA("ParticleEmitter", true)

                if ParticleEmitter then
                    ParticleEmitter.Enabled = false
                end

                Debris:AddItem(child, 6)
            end
        end
    end
end

local function setEnvironmentEffect(arg16) -- line: 502
    -- upvalues:
    --  [1] v59 (ref)
    --  [2] clearEnvironmentEffects (copy)
    --  [3] Weather (copy)
    --  [4] Effects (copy)
    --  [5] v58 (copy)
    --  [6] HumanoidRootPart (copy)

    if arg16 == v59 then
        return
    end

    v59 = arg16
    clearEnvironmentEffects(false)
    local v60 = arg16

    if v60 then
        v60 = Weather:FindFirstChild(arg16)
    end

    if v60 and Effects then
        local v61 = v60:Clone()
        v61.Name = v58
        local Weld = Instance.new("Weld")
        Weld.Name = v58 .. "Motor"
        Weld.Part0 = HumanoidRootPart
        Weld.Part1 = v61
        Weld.C0 = CFrame.new(0, 100, 0)
        Weld.Parent = v61
        v61.Parent = Effects
    end
end

local v62 = nil
local v63 = false

local function setEnvironment(arg17, arg18) -- line: 529
    -- upvalues:
    --  [1] EnvironmentMaterials_m (copy)
    --  [2] Atmosphere (copy)
    --  [3] v62 (ref)
    --  [4] Lighting (copy)
    --  [5] v63 (ref)
    --  [6] ReplicatedStorage (copy)
    --  [7] t (copy)
    --  [8] setEnvironmentEffect (copy)
    --  [9] Clouds (copy)
    --  [10] Sky (copy)
    --  [11] Atmosphere_1 (ref)
    --  [12] ColorCorrection (copy)

    EnvironmentMaterials_m.Set(arg17)
    local v64 = arg18

    if not v64 then
        v64 = arg17 and Atmosphere:FindFirstChild(arg17) or Atmosphere.Normal
    end

    arg18 = v64
    local ClockTime_3 = Lighting.ClockTime
    v64 = ClockTime_3 >= 18 or ClockTime_3 < 6
    v62 = v64
    local v65 = arg17

    if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then
        v64 = false
    else
        v65 = v65 or "Normal"
        local v66 = Atmosphere:FindFirstChild(v65)
        v64 = not t[v65]

        if v64 then
            local v67 = v66

            if v67 then
                v67 = v66:FindFirstChild("setTime")
            end

            v64 = not v67
        end
    end

    v63 = v64
    Lighting:SetAttribute("BloodMoonLit", v63)

    if v63 then
        arg18 = script.BloodMoon
    elseif if script:GetAttribute("Weather") ~= true then false else true then
        arg18 = Atmosphere.Rain
    else
        local v69 = arg18
        local ClockTime_4 = Lighting.ClockTime
        arg18 = (ClockTime_4 >= 18 or ClockTime_4 < 6) and v69:FindFirstChild("Night") or v69
    end

    setEnvironmentEffect(arg17)
    task.spawn(function() -- line: 547
        -- upvalues:
        --  [1] arg18 (ref)
        --  [2] Lighting (ref)

        local v71 = arg18:FindFirstChild("Lighting") or script:FindFirstChild(".default")
        local HoldBrightness = arg18:FindFirstChild("HoldBrightness")
        local v72 = HoldBrightness

        if v72 then
            v72 = HoldBrightness.Value

            if v72 then
                v72 = v71

                if v72 then
                    v72 = v71:GetAttribute("Brightness")
                end
            end
        end

        Lighting:SetAttribute("HeldBrightness", v72 or nil)

        if v71 then
            _G.Tween(Lighting, { 1.25, "Smoother", Enum.EasingDirection.Out }, v71:GetAttributes())
        end
    end)
    task.spawn(function() -- line: 558
        -- upvalues:
        --  [1] arg18 (ref)
        --  [2] Clouds (ref)

        local v74 = arg18:FindFirstChild("Clouds") or script:FindFirstChild("defaultClouds")

        if Clouds and v74 then
            _G.Tween(Clouds, { 2, "Quad", Enum.EasingDirection.Out }, v74:GetAttributes())
        end
    end)
    task.spawn(function() -- line: 565
        -- upvalues:
        --  [1] arg18 (ref)
        --  [2] Sky (ref)

        local v76 = arg18:FindFirstChild("Sky") or script:FindFirstChild("defaultSky")

        if Sky and v76 then
            for key_3, val_1 in v76:GetAttributes() do
                Sky[key_3] = val_1
            end
        end
    end)
    task.spawn(function() -- line: 574
        -- upvalues:
        --  [1] arg18 (ref)
        --  [2] Atmosphere_1 (ref)

        local t_8 = {}

        for _, val_2 in { "Color", "Haze", "Glare", "Decay", "Offset" } do
            t_8[val_2] = arg18[val_2]
        end

        _G.Tween(
            Atmosphere_1,
            { 1.25, "Smoother", Enum.EasingDirection.Out },
            t_8,
            false,
            true
        )
        local t_9 = { Density = nil }
        local v77 = if not _G.WISP_DENSITY then 1 else 0.85
        local Tween_2 = _G.Tween
        local v78 = Atmosphere_1
        local t_10 = { 2, "Smoother", Enum.EasingDirection.InOut }
        t_9.Density = arg18.Density * v77
        Tween_2(v78, t_10, t_9)
    end)
    task.spawn(function() -- line: 583
        -- upvalues:
        --  [1] arg18 (ref)
        --  [2] Lighting (ref)

        local SetTime = arg18:FindFirstChild("setTime")

        if SetTime then
            Lighting:SetAttribute("ClockRunning", false)
            Lighting.ClockTime = SetTime.Value

            return
        end

        Lighting:SetAttribute("ClockRunning", not Lighting:GetAttribute("ClockDisabled"))
    end)
    local ColorCorrection_1 = arg18:FindFirstChild("ColorCorrection")

    if ColorCorrection and ColorCorrection_1 then
        local t_11 = {}

        for _, val_3 in { "Brightness", "Contrast", "Saturation", "TintColor" } do
            t_11[val_3] = ColorCorrection_1[val_3]
        end

        _G.Tween(ColorCorrection, { 2, "Quad", Enum.EasingDirection.Out }, t_11)
    end

    Atmosphere_1:SetAttribute("Active", arg17)
end

local Season_1 = ReplicatedStorage:GetAttributeChangedSignal("Season")
table.insert(t_3, (Season_1:Connect(function() -- line: 606
    -- upvalues:
    --  [1] v8 (ref)
    --  [2] ReplicatedStorage (copy)
    --  [3] Atmosphere (copy)
    --  [4] setEnvironment (copy)

    if v8 then
        local Season_2 = ReplicatedStorage:GetAttribute("Season")
        local v81 = if Season_2 then if Atmosphere:FindFirstChild(Season_2) then Season_2 else "Normal" else "Normal"
        setEnvironment(v81, v81 and Atmosphere:FindFirstChild(v81) or Atmosphere.Normal)
    end
end)))
local v90 = ReplicatedStorage.Remotes.Utility.Client.OnClientEvent:Connect(function(arguments) -- line: 614
    -- upvalues:
    --  [1] Atmosphere_1 (ref)
    --  [2] ReplicatedStorage (copy)
    --  [3] Atmosphere (copy)
    --  [4] t (copy)
    --  [5] Lighting (copy)

    if arguments == "LightWispOn" then
        _G.WISP_DENSITY = true
    elseif arguments == "LightWispOff" then
        _G.WISP_DENSITY = false
    else
        return
    end

    local t_12 = { Density = nil }
    local Tween_3 = _G.Tween
    local v84 = Atmosphere_1
    local t_13 = { 0.5, "Smoother", Enum.EasingDirection.InOut }
    local Active_1 = Atmosphere_1:GetAttribute("Active")
    local v85

    if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then
        v85 = false
    else
        Active_1 = Active_1 or "Normal"
        local v86 = Atmosphere:FindFirstChild(Active_1)
        v85 = not t[Active_1]

        if v85 then
            local v87 = v86

            if v87 then
                v87 = v86:FindFirstChild("setTime")
            end

            v85 = not v87
        end
    end

    local v88, v89

    if v85 then
        v88 = script.BloodMoon
    else
        v85 = if script:GetAttribute("Weather") ~= true then false else true

        if v85 then
            v88 = Atmosphere.Rain
        else
            v89 = Atmosphere_1:GetAttribute("Active")
            v85 = v89 and Atmosphere:FindFirstChild(v89) or Atmosphere.Normal
            local ClockTime_5 = Lighting.ClockTime
            v89 = ClockTime_5 >= 18 or ClockTime_5 < 6
            v88 = v89 and v85:FindFirstChild("Night") or v85
        end
    end

    v89 = if not _G.WISP_DENSITY then 1 else 0.85
    t_12.Density = v88.Density * v89
    Tween_3(v84, t_13, t_12)
end)
table.insert(t_3, v90)

local function syncWeather() -- line: 625
    -- upvalues:
    --  [1] ControlWeather_m (copy)
    --  [2] Atmosphere_1 (ref)
    --  [3] setEnvironment (copy)
    --  [4] Atmosphere (copy)

    local v91 = if script:GetAttribute("Weather") ~= true then false else true
    ControlWeather_m:ToggleRain(v91)
    local Active_2 = Atmosphere_1:GetAttribute("Active")

    if Active_2 or v91 then
        setEnvironment(
            Active_2,
            Active_2 and Atmosphere:FindFirstChild(Active_2) or Atmosphere.Normal
        )
    end
end

local v94 = script:GetAttributeChangedSignal("Weather"):Connect(syncWeather)
table.insert(t_3, v94)
v94 = if script:GetAttribute("Weather") ~= true then false else true
ControlWeather_m:ToggleRain(v94)
local Active_3 = Atmosphere_1:GetAttribute("Active")
local v97

if Active_3 or v94 then
    local v95 = setEnvironment
    v97 = Active_3 and Atmosphere:FindFirstChild(Active_3) or Atmosphere.Normal
    v95(Active_3, v97)
end

local t_14 = { 0.45, "Quad", Enum.EasingDirection.Out }

function _G.FLYZONEALERT() -- line: 639
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] t_14 (copy)
    --  [3] Services_m (copy)

    local v98 = script.NoFlyZone:Clone()
    v98.Parent = Parent

    for _, descendant_1 in v98:GetDescendants() do
        if descendant_1:IsA("TextLabel") then
            _G.Tween(descendant_1, t_14, { TextTransparency = 0, TextStrokeTransparency = 0.7 })
        elseif descendant_1:IsA("ImageLabel") then
            _G.Tween(descendant_1, t_14, { ImageTransparency = 0 })
        end
    end

    task.wait(0.75)

    for _, descendant_2 in v98:GetDescendants() do
        if descendant_2:IsA("TextLabel") then
            _G.Tween(descendant_2, t_14, { TextTransparency = 1, TextStrokeTransparency = 1 })
        elseif descendant_2:IsA("ImageLabel") then
            _G.Tween(descendant_2, t_14, { ImageTransparency = 1 })
        end
    end

    Services_m.Debris(v98, 1)
end

local t_15 = {}
local t_16 = {}

local function removeZone(arg20) -- line: 668
    -- upvalues:
    --  [1] t_15 (copy)
    --  [2] RegionManager_m (copy)
    --  [3] t_16 (copy)

    local v99 = t_15[arg20]

    if v99 then
        RegionManager_m.Remove(v99)
        t_15[arg20] = nil
    end

    t_16[arg20] = nil
end

local _ = function(arg21) --[[ toOrientation ]] -- line: 677
    if typeof(arg21) == "CFrame" then
        return arg21.Rotation
    end

    if typeof(arg21) == "Vector3" then
        return CFrame.fromOrientation(math.rad(arg21.X), math.rad(arg21.Y), (math.rad(arg21.Z)))
    end

    return CFrame.identity
end

function v97(arg22) --[[ addZone ]] -- line: 686
    -- upvalues:
    --  [1] Locations_m (copy)
    --  [2] t_15 (copy)
    --  [3] RegionManager_m (copy)
    --  [4] t_16 (copy)
    --  [5] Atmosphere (copy)
    --  [6] v7 (ref)

    if not arg22:IsA("Folder") then
        return
    end

    local Name = arg22.Name
    local v102 = Locations_m:GetInfo(Name)

    if not v102 or not v102.Position or not v102.Size then
        return
    end

    local v103 = t_15[arg22]

    if v103 then
        RegionManager_m.Remove(v103)
        t_15[arg22] = nil
    end

    t_16[arg22] = nil
    v103 = if not v102.Environment then "Normal" else if v102.Environment == "" then "Normal" else v102.Environment or "Normal"

    if not Atmosphere:FindFirstChild(v103) then
        warn(`[LocationClient] "{Name}" uses missing Atmosphere "{v103}", falling back to Normal`)
        v103 = "Normal"
    end

    local t_17 = {
        Name = Name,
        Environment = v103,
        Settings = Atmosphere[v103],
        Priority = tonumber(v102.Subsidiary) or 0,
        NoFlight = if v102.NOFLIGHT ~= true then false else true
    }
    local cframe = CFrame.new(v102.Position)
    local Orientation = v102.Orientation
    local v105 = if typeof(Orientation) == "CFrame" then Orientation.Rotation else if typeof(
        Orientation
    ) == "Vector3" then CFrame.fromOrientation(
        math.rad(Orientation.X),
        math.rad(Orientation.Y),
        (math.rad(Orientation.Z))
    ) else CFrame.identity
    local t_18 = { CallbackEnter = nil, CallbackExit = nil }

    function t_18.CallbackEnter() -- line: 716
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] t_16 (ref)
        --  [3] arg22 (copy)
        --  [4] t_17 (copy)

        if v7 then
            t_16[arg22] = t_17
        end
    end

    function t_18.CallbackExit() -- line: 721
        -- upvalues:
        --  [1] t_16 (ref)
        --  [2] arg22 (copy)

        t_16[arg22] = nil
    end

    t_15[arg22] = RegionManager_m.fromRegion(cframe * v105, v102.Size, t_18)
end

for _, descendant_3 in Locations:GetDescendants() do
    task.spawn(v97, descendant_3)
end

local v111 = Locations.DescendantAdded:Connect(v97)
table.insert(t_3, v111)
local v113 = Locations.DescendantRemoving:Connect(removeZone)
table.insert(t_3, v113)

local function cleanup() -- line: 733
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] t_15 (copy)
    --  [3] RegionManager_m (copy)
    --  [4] t_16 (copy)
    --  [5] t_3 (copy)
    --  [6] Effects (copy)
    --  [7] v58 (copy)

    if not v7 then
        return
    end

    v7 = false

    for _, val_4 in t_15 do
        RegionManager_m.Remove(val_4)
    end

    table.clear(t_15)
    table.clear(t_16)

    for _, val_5 in t_3 do
        val_5:Disconnect()
    end

    table.clear(t_3)

    if not Effects then
        return
    end

    for _, child_1 in Effects:GetChildren() do
        if child_1.Name == v58 then
            child_1.Name = "."
            child_1:Destroy()
        end
    end
end

script.Destroying:Connect(cleanup)

local function step() -- line: 755
    -- upvalues:
    --  [1] WeatherZones_m (copy)
    --  [2] v3 (copy)
    --  [3] Atmosphere_1 (ref)
    --  [4] v63 (ref)
    --  [5] ReplicatedStorage (copy)
    --  [6] Atmosphere (copy)
    --  [7] t (copy)
    --  [8] setEnvironment (copy)
    --  [9] v62 (ref)
    --  [10] Lighting (copy)
    --  [11] t_16 (copy)
    --  [12] Locations (copy)
    --  [13] v8 (ref)

    local v115 = script
    local v117 = if WeatherZones_m:InWeatherZone(v3) then true else false
    v115:SetAttribute("Weather", v117)
    local Active_4 = Atmosphere_1:GetAttribute("Active")
    local v119, v123, v124, v125, v126, v128

    if Active_4 then
        local v118 = v63
        v117 = Active_4

        if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then
            v119 = false
        else
            v117 = v117 or "Normal"
            local v120 = Atmosphere:FindFirstChild(v117)
            v119 = not t[v117]

            if v119 then
                local v121 = v120

                if v121 then
                    v121 = v120:FindFirstChild("setTime")
                end

                v119 = not v121
            end
        end

        if v118 ~= v119 then
            local v122 = setEnvironment
            v123 = Active_4 and Atmosphere:FindFirstChild(Active_4) or Atmosphere.Normal
            v122(Active_4, v123)
        elseif Active_4 and not v63 then
            v124 = v62
            v123 = Lighting.ClockTime
            v119 = v123 >= 18 or v123 < 6

            if v124 ~= v119 then
                v125 = Active_4 and Atmosphere:FindFirstChild(Active_4) or Atmosphere.Normal

                if v125:FindFirstChild("Night") then
                    v126 = setEnvironment
                    v128 = Active_4 and Atmosphere:FindFirstChild(Active_4) or Atmosphere.Normal
                    v126(Active_4, v128)
                end
            end
        end
    elseif Active_4 and not v63 then
        v124 = v62
        v123 = Lighting.ClockTime
        v119 = v123 >= 18 or v123 < 6

        if v124 ~= v119 then
            v125 = Active_4 and Atmosphere:FindFirstChild(Active_4) or Atmosphere.Normal

            if v125:FindFirstChild("Night") then
                v126 = setEnvironment
                v128 = Active_4 and Atmosphere:FindFirstChild(Active_4) or Atmosphere.Normal
                v126(Active_4, v128)
            end
        end
    end

    for key_12 in t_16 do
        if not key_12:IsDescendantOf(Locations) then
            t_16[key_12] = nil
        end
    end

    local CurrentLocation_1 = script:GetAttribute("CurrentLocation")
    local v129 = nil
    local v130 = -math.huge

    for _, val_6 in t_16 do
        if v130 < val_6.Priority or val_6.Priority == v130 and val_6.Name == CurrentLocation_1 then
            v129 = val_6
            v130 = val_6.Priority
        end
    end

    if not v129 then
        _G.NOFLYZONE = false

        if not v8 then
            v8 = true
            script:SetAttribute("CurrentLocation", nil)
            local Season_3 = ReplicatedStorage:GetAttribute("Season")
            v130 = if Season_3 then if Atmosphere:FindFirstChild(Season_3) then Season_3 else "Normal" else "Normal"
            setEnvironment(v130, v130 and Atmosphere:FindFirstChild(v130) or Atmosphere.Normal)
        end

        return
    end

    v8 = false
    _G.NOFLYZONE = v129.NoFlight
    script:SetAttribute("CurrentLocation", v129.Name)

    if Atmosphere_1:GetAttribute("Active") ~= v129.Environment then
        setEnvironment(v129.Environment, v129.Settings)
    end
end

while v7 do
    if not v3:IsDescendantOf(game) or not (Humanoid.Health > 0) then
        break
    end

    local Success_1, Result_1 = pcall(step)

    if not Success_1 then
        warn("[LocationClient] update failed:", Result_1)
    end

    task.wait(1)
end
