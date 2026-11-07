-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Runtime
-- Class: LocalScript
-- bytes: 4925

local Parent = script.Parent
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = false
local t = {}

local _ = function(u1: userdata) --[[ c ]] -- line: 11
    -- upvalues:
    --  [1] t (copy)

    table.insert(t, u1)
end

local _ = function() --[[ cleanup ]] -- line: 15
    -- upvalues:
    --  [1] t (copy)

    for _, val in t do
        val:Disconnect()
    end
end

local v6 = nil
v6 = Parent:BindToMessage("Setup", function(arg1, arg2, arg3) -- line: 22
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v2 (ref)
    --  [3] v3 (ref)
    --  [4] v4 (ref)
    --  [5] v5 (ref)
    --  [6] v6 (ref)

    v1 = arg1
    v2 = arg2
    v3 = arg3
    v4 = require(arg3)
    v5 = true
    v6:Disconnect()
end)

repeat
    task.wait()
until v5

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local v7 = v4.new()
local Dependencies = v3.Dependencies
local DebugUi_m = require(Dependencies.DebugUi)
local v8 = nil
local Config_m = require(Dependencies.Config)
local Utilities_m = require(Dependencies.Utilities)
local v9 = RunService:IsStudio() or Config_m.ALLOW_LIVE_GAME_DEBUG
local OverlayEvent = v3:WaitForChild("OverlayEvent")
local v10 = false
local t_1 = {
    Begin = function(...) --[[ Begin ]] -- line: 52
        -- upvalues:
        --  [1] OverlayEvent (copy)

        OverlayEvent:Fire("Begin", ...)
    end,
    End = function(...) --[[ End ]] -- line: 55
        -- upvalues:
        --  [1] OverlayEvent (copy)

        OverlayEvent:Fire("End", ...)
    end,
    Text = function(...) --[[ Text ]] -- line: 58
        -- upvalues:
        --  [1] OverlayEvent (copy)

        OverlayEvent:Fire("Text", ...)
    end
}
shared.FrameCounter = 0

if v9 then
    v8 = require(Dependencies.Iris)
    v8 = if v8.HasInit() then v8 else v8.Init()
end

Parent.Name = `{v1.Name} - {v7.ID}`
v7:LoadObject(v1)

for _, val_1 in v2 do
    v7:LoadRawCollider(val_1[1], val_1[2])
end

local v11 = if v9 then {
    DRAW_BONE = v8.State(false),
    DRAW_PHYSICAL_BONE = v8.State(false),
    DRAW_ROOT_PART = v8.State(false),
    DRAW_BOUNDING_BOX = v8.State(false),
    DRAW_AXIS_LIMITS = v8.State(false),
    DRAW_COLLIDERS = v8.State(false),
    DRAW_COLLIDER_INFLUENCE = v8.State(false),
    DRAW_COLLIDER_AWAKE = v8.State(false),
    DRAW_COLLIDER_BROADPHASE = v8.State(false),
    DRAW_FILL_COLLIDERS = v8.State(false),
    DRAW_CONTACTS = v8.State(false),
    DRAW_ROTATION_LIMITS = v8.State(false),
    DRAW_ACCELERATION_INFO = v8.State(false)
} else nil

if v9 then
    v8:Connect(function() -- line: 104
        -- upvalues:
        --  [1] v1 (ref)
        --  [2] DebugUi_m (copy)
        --  [3] v8 (ref)
        --  [4] v7 (copy)
        --  [5] v11 (ref)

        if v1:GetAttribute("Debug") ~= nil then
            DebugUi_m(v8, v7, v11)
        end
    end)
end

local SmartCollider = CollectionService:GetInstanceAddedSignal("SmartCollider")
table.insert(t, (SmartCollider:Connect(function(u2: userdata) -- line: 111
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] Utilities_m (copy)
    --  [3] v7 (copy)

    if not u2:IsA("BasePart") then
        return
    end

    local ColliderKey = u2:GetAttribute("ColliderKey")
    local ColliderKey_1 = v1:GetAttribute("ColliderKey")

    if tostring(ColliderKey) ~= tostring(ColliderKey_1) then
        return
    end

    v7:LoadRawCollider(Utilities_m.GetCollider(u2), u2)
end)))
local v12 = Parent:BindToMessage("Destroy", function() -- line: 128
    -- upvalues:
    --  [1] v10 (ref)

    v10 = true
end)
table.insert(t, v12)
local v27 = RunService.Heartbeat:ConnectParallel(function(arg4) -- line: 132
    -- upvalues:
    --  [1] v7 (copy)
    --  [2] v10 (ref)
    --  [3] t (copy)
    --  [4] Parent (copy)
    --  [5] v9 (copy)
    --  [6] v1 (ref)
    --  [7] v11 (ref)
    --  [8] t_1 (copy)

    local v13 = shared
    v13.FrameCounter += 1

    if shared.FrameCounter > 131072 then
        shared.FrameCounter = 0
    end

    v7:StepBoneTrees(arg4)

    if v7.ShouldDestroy or v10 then
        v7:Destroy()
        task.synchronize()

        for _, val_2 in t do
            val_2:Disconnect()
        end

        Parent:Destroy()

        return
    end

    if v9 and v1:GetAttribute("Debug") ~= nil then
        task.synchronize()
        v7:DrawDebug(
            v11.DRAW_COLLIDERS:get(),
            v11.DRAW_CONTACTS:get(),
            v11.DRAW_PHYSICAL_BONE:get(),
            v11.DRAW_BONE:get(),
            v11.DRAW_AXIS_LIMITS:get(),
            v11.DRAW_ROOT_PART:get(),
            v11.DRAW_FILL_COLLIDERS:get(),
            v11.DRAW_COLLIDER_INFLUENCE:get(),
            v11.DRAW_COLLIDER_AWAKE:get(),
            v11.DRAW_COLLIDER_BROADPHASE:get(),
            v11.DRAW_BOUNDING_BOX:get(),
            v11.DRAW_ROTATION_LIMITS:get(),
            v11.DRAW_ACCELERATION_INFO:get()
        )
        v7:DrawOverlay(t_1)
    end
end)
table.insert(t, v27)
