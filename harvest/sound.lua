-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.sound
-- Class: ModuleScript
-- bytes: 11315

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local PkgPromise_m = require("../pkg/Promise")
local rng = Random.new()
local t = {}
local v1 = nil

local function selectRandomSound(u1: userdata) -- line: 17
    -- upvalues:
    --  [1] ModAttributes_m (copy)
    --  [2] CollectionService (copy)
    --  [3] rng (copy)

    local v2 = ModAttributes_m.get(u1, "SoundPoolTag", "")

    if v2 == "" then
        return u1
    end

    local t_1 = {}
    local t_2 = {}
    local v3 = 0

    for _, val in (CollectionService:GetTagged(v2)) do
        if val:IsA("Sound") then
            table.insert(t_2, val)
            local v4 = ModAttributes_m.get(val, "SoundPoolWeight", 1)
            table.insert(t_1, v4)
            v3 += v4
        end
    end

    if #t_2 == 0 then
        return u1
    end

    if v3 > 0 then
        local v5 = rng:NextNumber() * v3
        local v6 = 0

        for key_1, val_1 in t_1 do
            v6 += val_1

            if v5 <= v6 then
                return t_2[key_1]
            end
        end
    end

    return t_2[rng:NextInteger(1, #t_2)]
end

local function createSoundClone(u2: userdata, u3: userdata, arg1: any) -- line: 64
    -- upvalues:
    --  [1] ModUtility_m (copy)
    --  [2] v1 (ref)

    local v8 = u3:Clone()

    for _, val_2 in v8:GetTags() do
        v8:RemoveTag(val_2)
    end

    local v9 = u2:FindFirstAncestorWhichIsA("BasePart")
    local SoundEmitter_Part = nil

    if ModUtility_m.PLUGIN_CONTEXT then
        if v9 then
            SoundEmitter_Part = Instance.new("Part")
            SoundEmitter_Part.Name = "SoundEmitter"
            SoundEmitter_Part.Anchored = true
            SoundEmitter_Part.CanCollide = false
            SoundEmitter_Part.CanQuery = false
            SoundEmitter_Part.CanTouch = false
            SoundEmitter_Part.Transparency = 1
            SoundEmitter_Part.Size = Vector3.new(1, 1, 1)
            SoundEmitter_Part.CFrame = v9.CFrame
            SoundEmitter_Part.Parent = v1
            v8.Parent = SoundEmitter_Part
            table.insert(arg1, SoundEmitter_Part)
        else
            v8.Parent = v1
            table.insert(arg1, v8)
        end
    else
        if v9 then
            v8.Parent = v9
        else
            v8.Parent = workspace.Terrain
        end

        table.insert(arg1, v8)
    end

    return v8, SoundEmitter_Part
end

local function playSingleSound(
    u4: userdata,
    u5: userdata,
    u6: userdata,
    u7: userdata?,
    arg2: any,
    n1: number
) -- line: 109
    -- upvalues:
    --  [1] ModAttributes_m (copy)
    --  [2] ModTween_m (copy)
    --  [3] ModUtility_m (copy)
    --  [4] RunService (copy)

    local PlaybackSpeed = u6.PlaybackSpeed
    local v11 = ModAttributes_m.get(u5, "Volume_End", u6.Volume)
    local v12 = ModAttributes_m.get(u5, "Volume_Start", u6.Volume)
    u6.Volume = v12

    if v12 ~= v11 then
        local v13 = ModAttributes_m.get(u5, "Volume_Duration", u6.TimeLength)
        table.insert(arg2, ModTween_m.fromParams(ModAttributes_m.get(
            u5,
            "Volume_Curve",
            ModUtility_m.default_bezier
        ), v13, function(arg3, arg4) -- line: 129
            -- upvalues:
            --  [1] u6 (copy)
            --  [2] ModUtility_m (ref)
            --  [3] v12 (copy)
            --  [4] v11 (copy)
            --  [5] PlaybackSpeed (ref)

            u6.Volume = ModUtility_m.lerp(v12, v11, arg3)

            return arg4 * PlaybackSpeed
        end))
    else
        u6.Volume = v12
    end

    local v16 = ModAttributes_m.get(u5, "Speed_End", u6.PlaybackSpeed)
    local v17 = ModAttributes_m.get(u5, "Speed_Start", u6.PlaybackSpeed)
    local PlaybackSpeed = v17
    local v18 = nil

    if v17 ~= v16 then
        local v19 = ModAttributes_m.get(u5, "Speed_Duration", u6.TimeLength)
        v18 = ModTween_m.fromParams(ModAttributes_m.get(
            u5,
            "Speed_Curve",
            ModUtility_m.default_bezier
        ), v19, function(arg5, arg6) -- line: 151
            -- upvalues:
            --  [1] PlaybackSpeed (ref)
            --  [2] ModUtility_m (ref)
            --  [3] v17 (copy)
            --  [4] v16 (copy)
            --  [5] u6 (copy)

            PlaybackSpeed = ModUtility_m.lerp(v17, v16, arg5)
            u6.PlaybackSpeed = PlaybackSpeed

            return arg6
        end)
        table.insert(arg2, v18)
    else
        u6.PlaybackSpeed = v17
    end

    local v21 = ModAttributes_m.get(u5, "RollOff_End", u6.RollOffMinDistance)
    local v22 = ModAttributes_m.get(u5, "RollOff_Start", u6.RollOffMinDistance)
    local FromParams_2
    local v23, v24

    if v22 ~= v21 then
        v23 = ModAttributes_m.get(u5, "RollOff_Duration", u6.TimeLength)
        FromParams_2 = ModTween_m.fromParams
        v24 = ModAttributes_m.get(u5, "RollOff_Curve", ModUtility_m.default_bezier)
        table.insert(arg2, FromParams_2(v24, v23, function(arg7, arg8) -- line: 174
            -- upvalues:
            --  [1] u6 (copy)
            --  [2] ModUtility_m (ref)
            --  [3] v22 (copy)
            --  [4] v21 (copy)
            --  [5] PlaybackSpeed (ref)

            u6.RollOffMinDistance = ModUtility_m.lerp(v22, v21, arg7)

            return arg8 * PlaybackSpeed
        end, v18))
    end

    local _ = FromParams_2(v24, v23, function(arg7, arg8) -- line: 174
        -- upvalues:
        --  [1] u6 (copy)
        --  [2] ModUtility_m (ref)
        --  [3] v22 (copy)
        --  [4] v21 (copy)
        --  [5] PlaybackSpeed (ref)

        u6.RollOffMinDistance = ModUtility_m.lerp(v22, v21, arg7)

        return arg8 * PlaybackSpeed
    end, v18)

    if u6.PlayOnRemove and not ModUtility_m.PLUGIN_CONTEXT then
        u6:Destroy()
    else
        u6:Play()
    end

    if u7 then
        local v27 = u4:FindFirstAncestorWhichIsA("BasePart")

        if v27 then
            table.insert(arg2, RunService.Heartbeat:Connect(function() -- line: 195
                -- upvalues:
                --  [1] u7 (copy)
                --  [2] v27 (copy)

                if u7.Parent then
                    u7.CFrame = v27.CFrame
                end
            end))
        end
    end

    if n1 > 0 then
        task.wait(n1)
        u6:Stop()
    else
        ModTween_m.timer(u6.TimeLength, function(arg9, arg10) -- line: 208
            -- upvalues:
            --  [1] u6 (copy)
            --  [2] v18 (ref)

            return if u6.PlaybackSpeed > 0 then arg9 * u6.PlaybackSpeed else if not (arg10 > 0) then nil else if not v18 then nil else if not v18.Connected then nil else arg9 * u6.PlaybackSpeed
        end, v18, arg2)
    end

    return v18
end

function t.init() -- line: 218
    -- upvalues:
    --  [1] ModUtility_m (copy)
    --  [2] v1 (ref)

    if not ModUtility_m.PLUGIN_CONTEXT then
        return
    end

    local v28 = script:FindFirstAncestorOfClass("Plugin")

    if not v28 then
        return
    end

    v1 = v28:CreateDockWidgetPluginGui(
        "VFXForgeSoundPlayer",
        DockWidgetPluginGuiInfo.new(
            Enum.InitialDockState.Float,
            false,
            true,
            200,
            100,
            100,
            50
        )
    )

    if v1 then
        v1.Name = "VFXForgeSoundPlayer"
    end
end

function t.deinit() -- line: 239
    -- upvalues:
    --  [1] v1 (ref)

    if v1 then
        v1:Destroy()
        v1 = nil
    end
end

function t.emit(u8: userdata, arg11: any) -- line: 246
    -- upvalues:
    --  [1] ModAttributes_m (copy)
    --  [2] selectRandomSound (copy)
    --  [3] PkgPromise_m (copy)
    --  [4] createSoundClone (copy)
    --  [5] playSingleSound (copy)
    --  [6] rng (copy)

    if u8.Playing then
        u8:Stop()
    end

    local v29 = ModAttributes_m.get(u8, "SoundPoolIsSource", false)
    local v30 = ModAttributes_m.get(u8, "SoundPoolInheritAttributes", false)
    local v31

    if v30 then
        v31 = if v29 then u8 else selectRandomSound(u8) or u8
        u8 = v31
    end

    v31 = ModAttributes_m.get(u8, "EmitDelay", 0)
    local v32 = ModAttributes_m.get(u8, "EmitDuration", 0)
    local v33 = ModAttributes_m.get(u8, "EmitCount", 1)
    local EmitInterval = ModAttributes_m.getRange(u8, "EmitInterval", NumberRange.new(0, 0))
    local v35 = ModAttributes_m.get(u8, "RepeatCount", 1)
    local RepeatInterval = ModAttributes_m.getRange(u8, "RepeatInterval", NumberRange.new(0, 0))
    task.wait(v31)
    local t_3 = {}

    for index = 1, v33 do
        local v37 = if not v30 then if v29 then u8 else selectRandomSound(u8) or u8 else u8 or (if v29 then u8 else selectRandomSound(
            u8
        ) or u8)

        if v37 then
            local v38 = if not v30 then u8 else if v37 == u8 then u8 else v37

            for index_1 = 1, v35 do
                table.insert(t_3, PkgPromise_m.new(function(arg12) -- line: 283
                    -- upvalues:
                    --  [1] createSoundClone (ref)
                    --  [2] u8 (ref)
                    --  [3] v37 (copy)
                    --  [4] arg11 (copy)
                    --  [5] playSingleSound (ref)
                    --  [6] v38 (copy)
                    --  [7] v32 (copy)

                    local v39, v40 = createSoundClone(u8, v37, arg11)
                    playSingleSound(
                        u8,
                        v38,
                        v39,
                        v40,
                        arg11,
                        v32
                    )

                    if v40 then
                        v40:Destroy()
                    else
                        v39:Destroy()
                    end

                    arg12()
                end))
                local _ = PkgPromise_m.new(function(arg12) -- line: 283
                    -- upvalues:
                    --  [1] createSoundClone (ref)
                    --  [2] u8 (ref)
                    --  [3] v37 (copy)
                    --  [4] arg11 (copy)
                    --  [5] playSingleSound (ref)
                    --  [6] v38 (copy)
                    --  [7] v32 (copy)

                    local v39, v40 = createSoundClone(u8, v37, arg11)
                    playSingleSound(
                        u8,
                        v38,
                        v39,
                        v40,
                        arg11,
                        v32
                    )

                    if v40 then
                        v40:Destroy()
                    else
                        v39:Destroy()
                    end

                    arg12()
                end)

                if v35 > index_1 and RepeatInterval.Max > 0 then
                    task.wait(rng:NextNumber(RepeatInterval.Min, RepeatInterval.Max))
                end
            end

            local _ = rng:NextNumber(RepeatInterval.Min, RepeatInterval.Max)

            if v33 > index and EmitInterval.Max > 0 then
                task.wait(rng:NextNumber(EmitInterval.Min, EmitInterval.Max))
            end
        end
    end

    PkgPromise_m.all(t_3):await()
end

return t
