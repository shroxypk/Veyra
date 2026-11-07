-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.RbxCharacterSounds
-- Class: LocalScript
-- bytes: 20326

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StateManager_m = require(game:GetService("ReplicatedStorage").Modules.StateManager)
local g_require = require

local _ = function(s1: string) --[[ loadFlag ]] -- line: 15
    local Success, Result = pcall(function() -- line: 16
        -- upvalues:
        --  [1] s1 (copy)

        return UserSettings():IsUserFeatureEnabled(s1)
    end)

    return Success and Result
end

local v1 = "UserSoundsUseRelativeVelocity2"
local v2 = g_require(script:WaitForChild("AtomicBinding"))
local Success_1, Result_1 = pcall(function() -- line: 16
    -- upvalues:
    --  [1] v1 (copy)

    return UserSettings():IsUserFeatureEnabled(v1)
end)
local v3 = "UserNewCharacterSoundsApi3"
local Success_2, Result_2 = pcall(function() -- line: 16
    -- upvalues:
    --  [1] v3 (copy)

    return UserSettings():IsUserFeatureEnabled(v3)
end)
local v4 = Success_2 and Result_2
local v5 = "UserFixCharSoundsEmitters"
local Success_3, Result_3 = pcall(function() -- line: 16
    -- upvalues:
    --  [1] v5 (copy)

    return UserSettings():IsUserFeatureEnabled(v5)
end)
local t = {
    Climbing = { SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looped = true },
    Died = { SoundId = "" },
    FreeFalling = { SoundId = "rbxasset://sounds/action_falling.ogg", Looped = true },
    GettingUp = { SoundId = "rbxasset://sounds/action_get_up.mp3" },
    Jumping = { SoundId = "rbxasset://sounds/action_jump.mp3" },
    Landing = { SoundId = "rbxasset://sounds/action_jump_land.mp3" },
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true,
        Pitch = 1.85
    },
    Splash = { SoundId = "rbxasset://sounds/impact_water.mp3" },
    Swimming = { SoundId = "rbxasset://sounds/action_swim.mp3", Looped = true, Pitch = 1.6 }
}
local t_1 = {
    Climbing = { AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3", Looping = true },
    Died = { AssetId = "" },
    FreeFalling = { AssetId = "rbxasset://sounds/action_falling.ogg", Looping = true },
    GettingUp = { AssetId = "rbxasset://sounds/action_get_up.mp3" },
    Jumping = { AssetId = "rbxasset://sounds/action_jump.mp3" },
    Landing = { AssetId = "rbxasset://sounds/action_jump_land.mp3" },
    Running = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true,
        PlaybackSpeed = 1.85
    },
    Splash = { AssetId = "rbxasset://sounds/impact_water.mp3" },
    Swimming = {
        AssetId = "rbxasset://sounds/action_swim.mp3",
        Looping = true,
        PlaybackSpeed = 1.6
    }
}

local _ = function(
    n1: number,
    n2: number,
    n3: number,
    n4: number,
    n5: number
) --[[ map ]] -- line: 99
    return (n1 - n2) * (n5 - n4) / (n3 - n2) + n4
end

local function getRelativeVelocity(arg1, arg2) -- line: 103
    if not arg1 then
        return arg2
    end

    local v6 = arg1.ActiveController

    if v6 then
        v6 = arg1.ActiveController:IsA("GroundController") and arg1.GroundSensor or arg1.ActiveController:IsA(
            "ClimbController"
        ) and arg1.ClimbSensor
    end

    if v6 and v6.SensedPart then
        return arg2 - v6.SensedPart:GetVelocityAtPosition(arg1.RootPart.Position)
    end

    return arg2
end

local _ = function(u1: userdata, b1: boolean?) --[[ playSound ]] -- line: 120
    -- upvalues:
    --  [1] v4 (copy)

    if not b1 then
        u1.TimePosition = 0
    end

    if v4 and u1:IsA("AudioPlayer") then
        u1:Play()

        return
    end

    u1.Playing = true
end

local _ = function(u2: userdata) --[[ stopSound ]] -- line: 131
    -- upvalues:
    --  [1] v4 (copy)

    if v4 and u2:IsA("AudioPlayer") then
        u2:Stop()

        return
    end

    u2.Playing = false
end

local _ = function(u3: userdata, b2: boolean) --[[ playSoundIf ]] -- line: 139
    -- upvalues:
    --  [1] v4 (copy)

    if v4 then
        if u3:IsA("AudioPlayer") then
            if u3.IsPlaying and not b2 then
                u3:Stop()

                return
            end

            if not u3.IsPlaying and b2 then
                u3:Play()

                return
            end
        else
            u3.Playing = b2
        end

        return
    end

    u3.Playing = b2
end

local _ = function(u4: userdata, b3: boolean) --[[ setSoundLooped ]] -- line: 151
    -- upvalues:
    --  [1] v4 (copy)

    if v4 and u4:IsA("AudioPlayer") then
        u4.Looping = b3

        return
    end

    u4.Looped = b3
end

local _ = function(arg3) --[[ shallowCopy ]] -- line: 159
    local t_2 = {}

    for key, val in pairs(arg3) do
        t_2[key] = val
    end

    return t_2
end

local v7 = Success_1 and Result_1
local v8 = Success_3 and Result_3

local function initializeSoundSystem(t1: table) -- line: 167
    -- upvalues:
    --  [1] v7 (copy)
    --  [2] v4 (copy)
    --  [3] SoundService (copy)
    --  [4] v8 (copy)
    --  [5] Players (copy)
    --  [6] t_1 (copy)
    --  [7] t (copy)
    --  [8] StateManager_m (copy)
    --  [9] getRelativeVelocity (copy)
    --  [10] RunService (copy)

    local Humanoid = t1.humanoid
    local RootPart = t1.rootPart
    local v9 = if v7 then Humanoid.Parent:FindFirstChild("ControllerManager") else nil
    local t_3 = {}
    local v13

    if v4 and SoundService.CharacterSoundsUseNewApi == Enum.RolloutState.Enabled then
        local Character = nil
        local v11 = nil

        if v8 then
            v11 = Humanoid.RootPart
        else
            Character = Players.LocalPlayer.Character
        end

        local t_4 = { [150] = 0 }
        local v12 = 5

        while true do
            if not (v12 < 150) then
                break
            end

            t_4[v12] = 5 / v12
            v12 *= 1.25
        end

        v13 = if not v8 then Instance.new("AudioEmitter", Character) else Instance.new(
            "AudioEmitter",
            v11
        )
        local v14
        v13.Name, v14 = "RbxCharacterSoundsEmitter", t_4
        v13:SetDistanceAttenuation(v14)

        for key_1, val_1 in pairs(t_1) do
            v12 = Instance.new("AudioPlayer")
            v11 = Instance.new("Wire")
            v12.Name = key_1
            v11.Name = key_1 .. "Wire"
            v12.Archivable = false
            v12.Volume = 0.65

            for key_2, val_2 in pairs(val_1) do
                v12[key_2] = val_2
            end

            v12.Parent = RootPart
            v11.Parent = v12
            v11.SourceInstance = v12
            v11.TargetInstance = v13
            t_3[key_1] = v12
        end
    else
        for key_3, val_3 in pairs(t) do
            local Sound = Instance.new("Sound")
            Sound.Name = key_3
            Sound.Archivable = false
            Sound.RollOffMinDistance = 5
            Sound.RollOffMaxDistance = 150
            Sound.Volume = 0.65

            for key_4, val_4 in pairs(val_3) do
                Sound[key_4] = val_4
            end

            Sound.Parent = RootPart
            t_3[key_3] = Sound
        end
    end

    v13 = {}

    local function stopPlayingLoopedSounds(u5: userdata?) -- line: 243
        -- upvalues:
        --  [1] v13 (copy)
        --  [2] v4 (ref)

        u5 = u5 or nil
        local v15 = pairs
        local t_5 = {}

        for key_5, val_5 in pairs(v13) do
            t_5[key_5] = val_5
        end

        for key_6, _ in v15(t_5) do
            if key_6 ~= u5 then
                if v4 then
                    if key_6:IsA("AudioPlayer") then
                        key_6:Stop()
                    else
                        key_6.Playing = false
                    end
                else
                    key_6.Playing = false
                end

                v13[key_6] = nil
            end
        end
    end

    local t_6 = {
        [Enum.HumanoidStateType.FallingDown] = function() -- line: 255
            -- upvalues:
            --  [1] stopPlayingLoopedSounds (copy)

            stopPlayingLoopedSounds()
        end,
        [Enum.HumanoidStateType.GettingUp] = function() -- line: 259
            -- upvalues:
            --  [1] stopPlayingLoopedSounds (copy)
            --  [2] t_3 (copy)
            --  [3] v4 (ref)

            stopPlayingLoopedSounds()
            local GettingUp = t_3.GettingUp
            GettingUp.TimePosition = 0

            if v4 and GettingUp:IsA("AudioPlayer") then
                GettingUp:Play()

                return
            end

            GettingUp.Playing = true
        end,
        [Enum.HumanoidStateType.Jumping] = function() -- line: 264
            -- upvalues:
            --  [1] stopPlayingLoopedSounds (copy)
            --  [2] t_3 (copy)
            --  [3] v4 (ref)

            stopPlayingLoopedSounds()
            local Jumping = t_3.Jumping
            Jumping.TimePosition = 0

            if v4 and Jumping:IsA("AudioPlayer") then
                Jumping:Play()

                return
            end

            Jumping.Playing = true
        end,
        [Enum.HumanoidStateType.Swimming] = function() -- line: 269
            -- upvalues:
            --  [1] RootPart (copy)
            --  [2] t_3 (copy)
            --  [3] v4 (ref)
            --  [4] stopPlayingLoopedSounds (copy)
            --  [5] v13 (copy)

            local v16 = math.abs(RootPart.AssemblyLinearVelocity.Y)

            if v16 > 0.1 then
                t_3.Splash.Volume = math.clamp((v16 - 100) * 0.72 / 250 + 0.28, 0, 1)
                local Splash_1 = t_3.Splash
                Splash_1.TimePosition = 0

                if v4 then
                    if Splash_1:IsA("AudioPlayer") then
                        Splash_1:Play()
                    else
                        Splash_1.Playing = true
                    end
                else
                    Splash_1.Playing = true
                end
            end

            stopPlayingLoopedSounds(t_3.Swimming)
            local Swimming = t_3.Swimming

            if v4 then
                if Swimming:IsA("AudioPlayer") then
                    Swimming:Play()
                else
                    Swimming.Playing = true
                end
            else
                Swimming.Playing = true
            end

            v13[t_3.Swimming] = true
        end,
        [Enum.HumanoidStateType.Freefall] = function() -- line: 280
            -- upvalues:
            --  [1] t_3 (copy)
            --  [2] stopPlayingLoopedSounds (copy)
            --  [3] v4 (ref)
            --  [4] v13 (copy)

            t_3.FreeFalling.Volume = 0
            stopPlayingLoopedSounds(t_3.FreeFalling)
            local FreeFalling = t_3.FreeFalling

            if v4 then
                if FreeFalling:IsA("AudioPlayer") then
                    FreeFalling.Looping = true
                else
                    FreeFalling.Looped = true
                end
            else
                FreeFalling.Looped = true
            end

            if t_3.FreeFalling:IsA("Sound") then
                t_3.FreeFalling.PlaybackRegionsEnabled = true
            end

            t_3.FreeFalling.LoopRegion = NumberRange.new(2, 9)
            local FreeFalling_2 = t_3.FreeFalling
            FreeFalling_2.TimePosition = 0

            if v4 then
                if FreeFalling_2:IsA("AudioPlayer") then
                    FreeFalling_2:Play()
                else
                    FreeFalling_2.Playing = true
                end
            else
                FreeFalling_2.Playing = true
            end

            v13[t_3.FreeFalling] = true
        end,
        [Enum.HumanoidStateType.Landed] = function() -- line: 294
            -- upvalues:
            --  [1] stopPlayingLoopedSounds (copy)
            --  [2] StateManager_m (ref)
            --  [3] Humanoid (copy)
            --  [4] RootPart (copy)
            --  [5] t_3 (copy)
            --  [6] v4 (ref)

            stopPlayingLoopedSounds()
            local v17 = StateManager_m.require(Humanoid.Parent)

            if v17 and v17:IsFlying() then
                return
            end

            local v18 = math.abs(RootPart.AssemblyLinearVelocity.Y)

            if v18 > 75 then
                t_3.Landing.Volume = math.clamp((v18 - 50) * 1 / 50 + 0, 0, 1)
                local Landing_1 = t_3.Landing
                Landing_1.TimePosition = 0

                if v4 and Landing_1:IsA("AudioPlayer") then
                    Landing_1:Play()

                    return
                end

                Landing_1.Playing = true
            end
        end,
        [Enum.HumanoidStateType.Running] = function() -- line: 308
            -- upvalues:
            --  [1] stopPlayingLoopedSounds (copy)
            --  [2] t_3 (copy)
            --  [3] v4 (ref)
            --  [4] v13 (copy)

            stopPlayingLoopedSounds(t_3.Running)
            local Running = t_3.Running

            if v4 then
                if Running:IsA("AudioPlayer") then
                    Running:Play()
                else
                    Running.Playing = true
                end
            else
                Running.Playing = true
            end

            v13[t_3.Running] = true
        end,
        [Enum.HumanoidStateType.Climbing] = function() -- line: 314
            -- upvalues:
            --  [1] t_3 (copy)
            --  [2] RootPart (copy)
            --  [3] v7 (ref)
            --  [4] getRelativeVelocity (ref)
            --  [5] v9 (ref)
            --  [6] v4 (ref)
            --  [7] stopPlayingLoopedSounds (copy)
            --  [8] v13 (copy)

            local Climbing = t_3.Climbing
            local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity
            local v19 = if not v7 then AssemblyLinearVelocity else getRelativeVelocity(
                v9,
                AssemblyLinearVelocity
            )

            if math.abs(v19.Y) > 0.1 then
                if v4 then
                    if Climbing:IsA("AudioPlayer") then
                        Climbing:Play()
                    else
                        Climbing.Playing = true
                    end
                else
                    Climbing.Playing = true
                end

                stopPlayingLoopedSounds(Climbing)
            else
                stopPlayingLoopedSounds()
            end

            v13[Climbing] = true
        end,
        [Enum.HumanoidStateType.Seated] = function() -- line: 327
            -- upvalues:
            --  [1] stopPlayingLoopedSounds (copy)

            stopPlayingLoopedSounds()
        end,
        [Enum.HumanoidStateType.Dead] = function() -- line: 331
            -- upvalues:
            --  [1] stopPlayingLoopedSounds (copy)
            --  [2] t_3 (copy)
            --  [3] v4 (ref)

            stopPlayingLoopedSounds()
            local Died = t_3.Died
            Died.TimePosition = 0

            if v4 and Died:IsA("AudioPlayer") then
                Died:Play()

                return
            end

            Died.Playing = true
        end
    }
    local t_7 = {
        [t_3.Climbing] = function(_: number, u6: userdata, vec1: Vector3) -- line: 339
            -- upvalues:
            --  [1] v7 (ref)
            --  [2] getRelativeVelocity (ref)
            --  [3] v9 (ref)
            --  [4] v4 (ref)

            local v21 = (if not v7 then vec1 else getRelativeVelocity(v9, vec1)).Magnitude > 0.1

            if v4 then
                if u6:IsA("AudioPlayer") then
                    if u6.IsPlaying and not v21 then
                        u6:Stop()

                        return
                    end

                    if not u6.IsPlaying and v21 then
                        u6:Play()

                        return
                    end
                else
                    u6.Playing = v21
                end

                return
            end

            u6.Playing = v21
        end,
        [t_3.FreeFalling] = function(n7: number, u7: userdata, vec2: Vector3) -- line: 344
            if vec2.Magnitude > 75 then
                u7.Volume = math.clamp(u7.Volume + n7 * 0.9, 0, 1)

                return
            end

            u7.Volume = 0
        end,
        [t_3.Running] = function(_: number, u8: userdata, vec3: Vector3) -- line: 352
            -- upvalues:
            --  [1] StateManager_m (ref)
            --  [2] Humanoid (copy)
            --  [3] v4 (ref)

            local v22 = StateManager_m.require(Humanoid.Parent)
            local v23 = v22

            if v23 then
                v23 = v22:IsFlying()
            end

            local v24 = vec3.Magnitude > 0.5 and (Humanoid.MoveDirection.Magnitude > 0.5 and not v23)

            if v4 then
                if u8:IsA("AudioPlayer") then
                    if u8.IsPlaying and not v24 then
                        u8:Stop()

                        return
                    end

                    if not u8.IsPlaying and v24 then
                        u8:Play()

                        return
                    end
                else
                    u8.Playing = v24
                end

                return
            end

            u8.Playing = v24
        end
    }
    local t_8 = { [Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running }
    local v25 = t_8[Humanoid:GetState()] or Humanoid:GetState()

    local _ = function(arg4) --[[ transitionTo ]] -- line: 368
        -- upvalues:
        --  [1] t_6 (copy)
        --  [2] v25 (ref)

        local v26 = t_6[arg4]

        if v26 then
            v26()
        end

        v25 = arg4
    end

    local v27 = v25
    local v28 = t_6[v27]

    if v28 then
        v28()
    end

    v25 = v27
    local v30 = Humanoid.StateChanged:Connect(function(_, arg6) -- line: 380
        -- upvalues:
        --  [1] t_8 (copy)
        --  [2] v25 (ref)
        --  [3] t_6 (copy)

        arg6 = t_8[arg6] or arg6

        if arg6 ~= v25 then
            local v29 = t_6[arg6]

            if v29 then
                v29()
            end

            v25 = arg6
        end
    end)
    local v32 = RunService.Stepped:Connect(function(_: any, n9: number) -- line: 388
        -- upvalues:
        --  [1] v13 (copy)
        --  [2] t_7 (copy)
        --  [3] RootPart (copy)

        for key_7, _ in pairs(v13) do
            local v31 = t_7[key_7]

            if v31 then
                v31(n9, key_7, RootPart.AssemblyLinearVelocity)
            end
        end
    end)

    local function terminate() -- line: 399
        -- upvalues:
        --  [1] v30 (copy)
        --  [2] v32 (copy)
        --  [3] t_3 (copy)

        v30:Disconnect()
        v32:Disconnect()

        for _, val_8 in pairs(t_3) do
            val_8:Destroy()
        end

        table.clear(t_3)
    end

    return terminate
end

local v33 = v2.new({ humanoid = "Humanoid", rootPart = "HumanoidRootPart" }, initializeSoundSystem)
local t_9 = {}

local function characterAdded(arg8) -- line: 422
    -- upvalues:
    --  [1] v33 (copy)

    v33:bindRoot(arg8)
end

local function characterRemoving(arg9) -- line: 426
    -- upvalues:
    --  [1] v33 (copy)

    v33:unbindRoot(arg9)
end

local function playerAdded(u9: userdata) -- line: 430
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] v33 (copy)
    --  [3] characterAdded (copy)
    --  [4] characterRemoving (copy)

    local v34 = t_9[u9]

    if not v34 then
        v34 = {}
        t_9[u9] = v34
    end

    if u9.Character then
        v33:bindRoot(u9.Character)
    end

    table.insert(v34, u9.CharacterAdded:Connect(characterAdded))
    table.insert(v34, u9.CharacterRemoving:Connect(characterRemoving))
end

local function playerRemoving(u10: userdata) -- line: 444
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] v33 (copy)

    local v35 = t_9[u10]

    if v35 then
        for _, val_9 in ipairs(v35) do
            val_9:Disconnect()
        end

        t_9[u10] = nil
    end

    if u10.Character then
        v33:unbindRoot(u10.Character)
    end
end

for _, val_10 in ipairs(Players:GetPlayers()) do
    task.spawn(playerAdded, val_10)
end

Players.PlayerAdded:Connect(playerAdded)
Players.PlayerRemoving:Connect(playerRemoving)
