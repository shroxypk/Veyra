-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.PadBinds
-- Class: ModuleScript
-- bytes: 9128

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GamepadLayer_m = require(ReplicatedStorage.Modules.GamepadLayer)
local KeyCodeIcons_m = require(ReplicatedStorage.Modules.KeyCodeIcons)
local t = {}
t.ICONS = setmetatable(
    {
        [Enum.KeyCode.ButtonL3] = KeyCodeIcons_m[Enum.KeyCode.Thumbstick2],
        [Enum.KeyCode.ButtonR3] = KeyCodeIcons_m[Enum.KeyCode.Thumbstick1]
    },
    { __index = KeyCodeIcons_m }
)
t.FIXED = {
    Menu = { Enum.KeyCode.DPadLeft, "Tap" },
    ["Summon Spirit"] = { Enum.KeyCode.DPadLeft, "Hold" },
    Map = { Enum.KeyCode.DPadDown, "Tap" },
    ["Quest Journal"] = { Enum.KeyCode.DPadDown, "Hold" },
    Broom = { Enum.KeyCode.DPadRight, "Tap" },
    ["Utility Spells"] = { Enum.KeyCode.DPadRight, "Hold" },
    Interact = { Enum.KeyCode.ButtonX, "Press" }
}

function t.getIcon(arg1) -- line: 53
    -- upvalues:
    --  [1] t (copy)
    --  [2] UserInputService (copy)

    return t.ICONS[arg1] or UserInputService:GetImageForKeyCode(arg1)
end

local t_4 = {
    L2 = { Enum.KeyCode.ButtonL2 },
    R2 = { Enum.KeyCode.ButtonR2 },
    Both = { Enum.KeyCode.ButtonL2, Enum.KeyCode.ButtonR2 }
}

function t.parse(s1: string?) -- line: 66
    -- upvalues:
    --  [1] t_4 (copy)

    if type(s1) ~= "string" or s1 == "" then
        return nil
    end

    local v2 = string.split(s1, "+")
    local v4 = Enum.KeyCode:FromName((table.remove(v2)))

    if not v4 then
        return nil
    end

    local v5 = false
    local v3 = false

    for _, val in v2 do
        if val == "ButtonL2" then
            v5 = true
        elseif val == "ButtonR2" then
            v3 = true
        else
            return nil
        end
    end

    v2 = if not v5 then if not v5 then if not v3 then nil else "R2" else "L2" else if not v3 then if not v5 then if not v3 then nil else "R2" else "L2" else "Both"

    return { layer = v2, key = v4, modifiers = if not v2 then {} else t_4[v2] }
end

function t.getKeys(s2: string?) -- line: 98
    -- upvalues:
    --  [1] t (copy)

    local v7 = t.parse(s2)

    if not v7 then
        return {}
    end

    local t_9 = table.clone(v7.modifiers)
    table.insert(t_9, v7.key)

    return t_9
end

if not RunService:IsClient() then
    return t
end

local LocalPlayer = Players.LocalPlayer
local BindableEvent = Instance.new("BindableEvent")
t.Changed = BindableEvent.Event
local PadBinds = nil
local t_10 = {}

local _ = function() --[[ getFolder ]] -- line: 121
    -- upvalues:
    --  [1] PadBinds (ref)
    --  [2] LocalPlayer (copy)

    if not PadBinds then
        PadBinds = LocalPlayer:WaitForChild("PadBinds")
    end

    return PadBinds
end

function t.getValue(s3: string) -- line: 129
    -- upvalues:
    --  [1] PadBinds (ref)
    --  [2] LocalPlayer (copy)

    if not PadBinds then
        PadBinds = LocalPlayer:WaitForChild("PadBinds")
    end

    local v11 = PadBinds:FindFirstChild(s3)

    if v11 and v11:IsA("StringValue") then
        return v11.Value
    end

    return ""
end

function t.get(s4: string) -- line: 134
    -- upvalues:
    --  [1] t (copy)

    return t.parse(t.getValue(s4))
end

function t.isRebindable(s5: string) -- line: 139
    -- upvalues:
    --  [1] PadBinds (ref)
    --  [2] LocalPlayer (copy)

    if not PadBinds then
        PadBinds = LocalPlayer:WaitForChild("PadBinds")
    end

    return if PadBinds:FindFirstChild(s5) == nil then false else true
end

function t.isDown(s6: string) -- line: 144
    -- upvalues:
    --  [1] t (copy)
    --  [2] UserInputService (copy)

    if not t.get(s6) then
        return false
    end

    for _, val_1 in t.getKeys(t.getValue(s6)) do
        if not UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, val_1) then
            return false
        end
    end

    return true
end

local t_11 = {}
t_11[Enum.KeyCode.ButtonL2] = "L2"
t_11[Enum.KeyCode.ButtonR2] = "R2"
local v13 = nil

local function clear(arg2, arg3) -- line: 165
    -- upvalues:
    --  [1] GamepadLayer_m (copy)
    --  [2] ContextActionService (copy)

    local Applied = arg3.applied
    arg3.applied = nil

    if not Applied then
        return
    end

    if Applied.layer then
        if GamepadLayer_m.getChord(Applied.layer, Applied.key) == arg3.chordFn then
            GamepadLayer_m.setChord(Applied.layer, Applied.key, nil)

            return
        end
    elseif Applied.trigger then
        if GamepadLayer_m.getTriggerTap(Applied.trigger) == arg3.chordFn then
            GamepadLayer_m.setTriggerTap(Applied.trigger, nil)

            return
        end
    else
        ContextActionService:UnbindAction("PadBind_" .. arg2)
    end
end

local function apply(arg4, arg5) -- line: 187
    -- upvalues:
    --  [1] clear (copy)
    --  [2] t (copy)
    --  [3] t_11 (copy)
    --  [4] GamepadLayer_m (copy)
    --  [5] ContextActionService (copy)

    clear(arg4, arg5)
    local v17 = t.get(arg4)

    if not v17 then
        return
    end

    local v18 = t_11[v17.key]

    if v17.layer then
        GamepadLayer_m.setChord(v17.layer, v17.key, arg5.chordFn)
    elseif v18 then
        GamepadLayer_m.setTriggerTap(v18, arg5.chordFn)
    else
        ContextActionService:BindActionAtPriority(
            "PadBind_" .. arg4,
            function(_, arg7, arg8) -- line: 203
                -- upvalues:
                --  [1] arg5 (copy)
                --  [2] arg4 (copy)

                return arg5.handler(arg4, arg7, arg8)
            end,
            false,
            10,
            v17.key
        )
    end

    local t_12 = {
        layer = v17.layer,
        key = v17.key,
        trigger = if v17.layer then nil else v18 or nil
    }
    arg5.applied = t_12
end

function t.bind(s7: string, arg9: any) -- line: 214
    -- upvalues:
    --  [1] t_10 (copy)
    --  [2] v13 (ref)

    local v21 = t_10[s7]

    if not v21 then
        v21 = {}

        function v21.chordFn(arg10, arg11) -- line: 218
            -- upvalues:
            --  [1] v21 (ref)
            --  [2] s7 (copy)

            if v21.handler then
                v21.handler(s7, arg10, arg11)
            end
        end

        t_10[s7] = v21
    end

    v21.handler = arg9
    v13()
end

function t.unbind(s8: string) -- line: 230
    -- upvalues:
    --  [1] t_10 (copy)
    --  [2] clear (copy)

    local v22 = t_10[s8]

    if v22 then
        v22.handler = nil
        clear(s8, v22)
    end
end

local t_13 = {}
local v23 = nil

local function watchForUI(arg12) -- line: 249
    -- upvalues:
    --  [1] t_13 (copy)
    --  [2] BindableEvent (copy)

    if not arg12:IsA("StringValue") then
        return
    end

    local v24 = t_13[arg12]

    if v24 and v24.Connected then
        return
    end

    t_13[arg12] = arg12:GetPropertyChangedSignal("Value"):Connect(function() -- line: 257
        -- upvalues:
        --  [1] BindableEvent (ref)
        --  [2] arg12 (copy)

        BindableEvent:Fire(arg12.Name, arg12.Value)
    end)
end

local function flushAll() -- line: 262
    -- upvalues:
    --  [1] PadBinds (ref)
    --  [2] LocalPlayer (copy)
    --  [3] watchForUI (copy)
    --  [4] v23 (ref)
    --  [5] t_10 (copy)
    --  [6] apply (copy)

    if not PadBinds then
        PadBinds = LocalPlayer:WaitForChild("PadBinds")
    end

    local v26 = PadBinds

    for _, child in v26:GetChildren() do
        watchForUI(child)
    end

    if not v23 or not v23.Connected then
        v23 = v26.ChildAdded:Connect(watchForUI)
    end

    for key_3, val_2 in t_10 do
        local v27 = v26:FindFirstChild(key_3)

        if v27 and v27:IsA("StringValue") then
            if not val_2.conn or not val_2.conn.Connected then
                val_2.conn = v27:GetPropertyChangedSignal("Value"):Connect(function() -- line: 278
                    -- upvalues:
                    --  [1] apply (ref)
                    --  [2] key_3 (copy)
                    --  [3] val_2 (copy)

                    apply(key_3, val_2)
                end)
            end

            apply(key_3, val_2)
        end
    end
end

local BindableEvent_1 = Instance.new("BindableEvent")
local v30 = false
local v31 = false

function v13() --[[ requestFlush ]] -- line: 291
    -- upvalues:
    --  [1] v30 (ref)
    --  [2] flushAll (copy)
    --  [3] v31 (ref)
    --  [4] BindableEvent_1 (copy)

    if not v30 then
        task.spawn(flushAll)

        return
    end

    if not v31 then
        v31 = true
        BindableEvent_1:Fire()
    end
end

function t._attachHost() -- line: 304
    -- upvalues:
    --  [1] v30 (ref)
    --  [2] BindableEvent_1 (copy)
    --  [3] v31 (ref)
    --  [4] flushAll (copy)

    if v30 then
        return
    end

    v30 = true
    BindableEvent_1.Event:Connect(function() -- line: 310
        -- upvalues:
        --  [1] v31 (ref)
        --  [2] flushAll (ref)

        v31 = false
        flushAll()
    end)
    task.spawn(flushAll)
end

v13()

return t
