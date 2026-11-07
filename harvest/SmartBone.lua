-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone
-- Class: ModuleScript
-- bytes: 18212

local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Components = script:WaitForChild("Components")
local Dependencies = script:WaitForChild("Dependencies")
local CeiveImOverlay_m = require(Dependencies:WaitForChild("CeiveImOverlay"))
local Config_m = require(Dependencies:WaitForChild("Config"))
local Frustum_m = require(Dependencies:WaitForChild("Frustum"))
local Utilities_m = require(Dependencies:WaitForChild("Utilities"))
local v5 = nil
local Bone_m = require(Components:WaitForChild("Bone"))
local BoneTree_m = require(Components:WaitForChild("BoneTree"))
local ColliderObject_m = require(
    Components:WaitForChild("Collision"):WaitForChild("ColliderObject")
)

local _ = function(u1: userdata, u2: userdata) --[[ CopyPasteAttributes ]] -- line: 22
    for key, val in u1:GetAttributes() do
        u2:SetAttribute(key, val)
    end
end

local SBINDENTLOG = Utilities_m.SB_INDENT_LOG
local SBUNINDENTLOG = Utilities_m.SB_UNINDENT_LOG
local SBVERBOSELOG = Utilities_m.SB_VERBOSE_LOG
local SBVERBOSEWARN = Utilities_m.SB_VERBOSE_WARN
local t = {}
local Runtime = Dependencies:WaitForChild("Runtime")
t.__index = t

function t.new() -- line: 73
    -- upvalues:
    --  [1] HttpService (copy)
    --  [2] t (copy)

    return (setmetatable(
        {
            ID = HttpService:GenerateGUID(false),
            BoneTrees = {},
            ColliderObjects = {},
            ShouldDestroy = false
        },
        t
    ))
end

function t.m_AppendBone(
    _: table,
    arg1: any,
    u3: userdata,
    n1: number,
    n2: number
) -- line: 96
    -- upvalues:
    --  [1] Utilities_m (copy)
    --  [2] Bone_m (copy)
    --  [3] SBVERBOSELOG (copy)

    local v9 = Utilities_m.GatherBoneSettings(u3)
    local v10 = Bone_m.new(u3, arg1.Root, arg1.RootPart)

    for key_1, val_1 in v9 do
        v10[key_1] = if val_1 == "\194\172" then nil else val_1 or nil
    end

    local v12 = arg1.Bones[n1]

    if n1 > 0 then
        local Magnitude = (v12.Position - v10.Position).Magnitude
        v10.FreeLength = Magnitude
        v10.Weight = Magnitude * 0.7
        v10.HeirarchyLength = n2
        v12.HasChild = true
    end

    if n2 <= arg1.Settings.AnchorDepth then
        SBVERBOSELOG("Anchoring bone")
        v10.Anchored = true
    end

    v10.ParentIndex = n1
    table.insert(arg1.Bones, v10)
end

function t.m_CreateBoneTree(t2: table, u4: userdata, u5: userdata) -- line: 134
    -- upvalues:
    --  [1] Utilities_m (copy)
    --  [2] BoneTree_m (copy)
    --  [3] SBVERBOSELOG (copy)
    --  [4] SBINDENTLOG (copy)
    --  [5] SBUNINDENTLOG (copy)

    local v13 = Utilities_m.GatherObjectSettings(u4)
    local v14 = BoneTree_m.new(u5, u4)
    v14.Settings = v13
    SBVERBOSELOG(`Creating bone tree {u4.Name}; {u5.Name}`)
    SBINDENTLOG()

    local function AddChildren(arg2, arg3, arg4) -- line: 143
        -- upvalues:
        --  [1] SBVERBOSELOG (ref)
        --  [2] SBINDENTLOG (ref)
        --  [3] t2 (copy)
        --  [4] v14 (copy)
        --  [5] AddChildren (copy)
        --  [6] SBUNINDENTLOG (ref)

        SBVERBOSELOG(`Adding bone: {arg2.Name}; {arg3}; {arg4}`)
        SBINDENTLOG()
        local children = arg2:GetChildren()

        for _, val_2 in children do
            if val_2:IsA("Bone") then
                t2:m_AppendBone(v14, val_2, arg3, arg4)
                AddChildren(val_2, #v14.Bones, arg4 + 1)
            end
        end

        if #children == 0 then
            SBVERBOSELOG("Adding tail bone")
            local Parent = arg2.Parent
            local v17 = Parent:IsA("Bone") and Parent.WorldPosition or Parent.Position
            local v18 = arg2.WorldCFrame + arg2.WorldCFrame.UpVector.Unit * (arg2.WorldPosition - v17).Magnitude
            v17 = Instance.new("Bone")
            v17.Parent = arg2
            v17.Name = arg2.Name .. "_Tail"
            v17.WorldCFrame = v18

            for key_3, val_3 in arg2:GetAttributes() do
                v17:SetAttribute(key_3, val_3)
            end

            t2:m_AppendBone(v14, v17, #v14.Bones, arg4)
        end

        SBUNINDENTLOG()
    end

    t2:m_AppendBone(v14, u5, 0, 0)
    AddChildren(u5, 1, 1)
    table.insert(t2.BoneTrees, v14)
    SBUNINDENTLOG()
end

function t.m_UpdateViewFrustum(arg5) -- line: 190
    -- upvalues:
    --  [1] Frustum_m (copy)
    --  [2] Config_m (copy)

    debug.profilebegin("SmartBone2::m_UpdateViewFrustum")
    local v20, v21, v22, v23, v24, v25, v26, v27, v28 = Frustum_m.GetCFrames(
        workspace.CurrentCamera,
        Config_m.FAR_PLANE
    )

    for _, val_4 in arg5.BoneTrees do
        debug.profilebegin("BoneTree::m_UpdateViewFrustum")
        val_4.InView = Frustum_m.ObjectInFrustum(
            { CFrame = val_4.BoundingBoxCFrame, Size = val_4.BoundingBoxSize },
            v20,
            v21,
            v22,
            v23,
            v24,
            v25,
            v26,
            v27,
            v28
        )
        debug.profileend()
    end

    debug.profileend()
end

function t.m_CleanColliders(arg6) -- line: 206
    -- upvalues:
    --  [1] SBVERBOSEWARN (copy)
    --  [2] SBINDENTLOG (copy)
    --  [3] SBUNINDENTLOG (copy)

    debug.profilebegin("Clean Colliders")

    if #arg6.ColliderObjects ~= 0 then
        for key_5, val_5 in arg6.ColliderObjects do
            if #val_5.Colliders == 0 or val_5.Destroyed == true then
                SBVERBOSEWARN("Deleting Collider Object")
                SBINDENTLOG()
                val_5:Destroy()
                SBUNINDENTLOG()
                table.remove(arg6.ColliderObjects, key_5)
            end
        end
    end

    debug.profileend()
end

function t.m_ConstrainBoneTree(t3: table, arg7: any, n3: number) -- line: 230
    debug.profilebegin("SmartBone2::m_ConstrainBoneTree")
    arg7:Constrain(t3.ColliderObjects, n3)
    debug.profileend()
end

function t.m_UpdateBoneTree(t4: table, arg8: any, n4: number, n5: number) -- line: 247
    -- upvalues:
    --  [1] SBVERBOSELOG (copy)

    debug.profilebegin("SmartBone2::m_UpdateBoneTree")

    if arg8.Destroyed then
        arg8:Destroy()
        table.remove(t4.BoneTrees, n4)
        debug.profileend()

        return
    end

    if arg8.FirstSkipUpdate then
        local Position = arg8.RootPart.Position
        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera and (Position - CurrentCamera.CFrame.Position).Magnitude > arg8.Settings.ActivationDistance then
            arg8.ObjectPreviousPosition = Position
            arg8.UpdateRate = 0
            debug.profileend()

            return
        end
    end

    arg8:PreUpdate(n5)

    if arg8.InView then
        if math.floor(arg8.UpdateRate) == 0 then
            local FirstSkipUpdate = arg8.FirstSkipUpdate
            arg8:SkipUpdate()
            debug.profileend()

            if not FirstSkipUpdate then
                task.synchronize()
                arg8:ApplyTransform()
                SBVERBOSELOG(
                    (("Skipping BoneTree, InView: %*, Update Rate == 0: %*"):format(
                        arg8.InView,
                        if math.floor(arg8.UpdateRate) ~= 0 then false else true
                    ))
                )
            end

            return
        end

        debug.profilebegin("Step Colliders")

        for _, val_6 in t4.ColliderObjects do
            val_6:Step()
        end

        debug.profileend()
        local v32 = 1 / arg8.UpdateRate
        local v33 = false
        arg8.AccumulatedDelta += n5

        while true do
            if not (v32 < arg8.AccumulatedDelta) then
                break
            end

            arg8.AccumulatedDelta -= v32
            v33 = true
            arg8:StepPhysics(v32)
            t4:m_ConstrainBoneTree(arg8, n5)
            arg8:SolveTransform(v32)
        end

        debug.profileend()

        if v33 then
            task.synchronize()
            arg8:ApplyTransform()
        end

        return
    else
        local FirstSkipUpdate_1 = arg8.FirstSkipUpdate
        arg8:SkipUpdate()
        debug.profileend()

        if not FirstSkipUpdate_1 then
            task.synchronize()
            arg8:ApplyTransform()
            SBVERBOSELOG(
                (("Skipping BoneTree, InView: %*, Update Rate == 0: %*"):format(
                    arg8.InView,
                    if math.floor(arg8.UpdateRate) ~= 0 then false else true
                ))
            )
        end

        return
    end
end

function t.m_CheckDestroy(arg9) -- line: 325
    arg9.ShouldDestroy = false

    if #arg9.BoneTrees == 0 then
        arg9.ShouldDestroy = true

        return true
    end

    return false
end

function t.LoadObject(t5: table, u6: userdata) -- line: 341
    local Roots = u6:GetAttribute("Roots")

    if not Roots then
        warn(`[SmartBone2::LoadObject] Cannot load an object with no roots defined {u6.Name}`)

        return
    end

    local v34 = Roots:split(",")
    local t_3 = {}

    for _, descendant in u6:GetDescendants() do
        if descendant:IsA("Bone") then
            if t_3[descendant.Name] then
                warn(
                    `[SmartBone2::LoadObject] Duplicate bones of name: {descendant.Name} in RootPart: {u6.Name}`
                )
            else
                t_3[descendant.Name] = descendant
            end
        end
    end

    for _, val_8 in v34 do
        local v35 = t_3[val_8]

        if not v35 then
            warn(
                `[SmartBone2::LoadObject] Couldn't find Root Bone of name: {val_8} in RootPart: {u6.Name}`
            )
        else
            t5:m_CreateBoneTree(u6, v35)
        end
    end
end

function t.LoadColliderModule(t6: table, u7: userdata, u8: userdata) -- line: 382
    -- upvalues:
    --  [1] HttpService (copy)
    --  [2] ColliderObject_m (copy)

    assert(u7, "[SmartBone2::LoadColliderModule] No collider module passed in")
    local v36 = HttpService:JSONDecode((require(u7)))
    table.insert(t6.ColliderObjects, (ColliderObject_m.new(v36, u8)))
end

function t.LoadRawCollider(t7: table, arg10: any, u9: userdata) -- line: 397
    -- upvalues:
    --  [1] ColliderObject_m (copy)

    local v37 = ColliderObject_m.new(arg10, u9)
    table.insert(t7.ColliderObjects, v37)
end

function t.SkipUpdate(arg11) -- line: 405
    debug.profilebegin("SmartBone2::SkipUpdate")

    for _, val_9 in arg11.BoneTrees do
        val_9:SkipUpdate()
    end

    debug.profileend()
end

function t.StepBoneTrees(t8: table, n6: number) -- line: 416
    -- upvalues:
    --  [1] SBVERBOSEWARN (copy)

    if t8:m_CheckDestroy() then
        return
    end

    if n6 <= 0 then
        SBVERBOSEWARN("DeltaTime is zero or sub zero, not updating.")

        return
    end

    t8:m_CleanColliders()
    t8:m_UpdateViewFrustum()

    for key_11, val_10 in t8.BoneTrees do
        t8:m_UpdateBoneTree(val_10, key_11, n6)
    end
end

function t.DrawDebug(
    t9: table,
    b1: boolean,
    b2: boolean,
    b3: boolean,
    b4: boolean,
    b5: boolean,
    b6: boolean,
    b7: boolean,
    b8: boolean,
    b9: boolean,
    b10: boolean,
    b11: boolean,
    b12: boolean,
    b13: boolean
) -- line: 449
    for _, val_11 in t9.BoneTrees do
        val_11:DrawDebug(
            b2,
            b3,
            b4,
            b5,
            b6,
            b11,
            b12,
            b13
        )
    end

    if b1 then
        for _, val_12 in t9.ColliderObjects do
            val_12:DrawDebug(b7, b8, b9, b10)
        end
    end
end

function t.DrawOverlay(t10: table, t11: table) -- line: 488
    -- upvalues:
    --  [1] Config_m (copy)

    if not Config_m.DEBUG_OVERLAY_ENABLED then
        return
    end

    local color = Color3.new(1, 0.431373, 0.713725)
    local color_1 = Color3.new(1, 1, 1)
    local color_2 = Color3.new(0.486275, 0.431373, 1)
    local color_3 = Color3.new(1, 1, 1)
    t11.Begin(`SmartBone Instance ID: {t10.ID}`, color, color_1)
    t11.Text(`Frame Counter: {shared.FrameCounter}`)

    if Config_m.DEBUG_OVERLAY_TREE then
        for key_14, val_13 in t10.BoneTrees do
            if Config_m.DEBUG_OVERLAY_MAX_TREES > 0 and key_14 >= Config_m.DEBUG_OVERLAY_TREE_OFFSET + Config_m.DEBUG_OVERLAY_MAX_TREES then
                break
            end

            if not (key_14 < Config_m.DEBUG_OVERLAY_TREE_OFFSET) then
                t11.Begin(`Bone Tree {key_14}`, color_2, color_3)
                val_13:DrawOverlay(t11)
                t11.End()
            end
        end
    end

    t11.End()
end

function t.Destroy(arg12) -- line: 524
    -- upvalues:
    --  [1] SBVERBOSELOG (copy)

    SBVERBOSELOG("Deleting SmartBone Object")

    for _, val_14 in arg12.BoneTrees do
        val_14:Destroy()
    end

    for _, val_15 in arg12.ColliderObjects do
        val_15:Destroy()
    end

    setmetatable(arg12, nil)
end

function t.Start() -- line: 542
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] t (copy)
    --  [3] Config_m (copy)
    --  [4] Players (copy)
    --  [5] v5 (ref)
    --  [6] CollectionService (copy)
    --  [7] SBVERBOSELOG (copy)
    --  [8] SBINDENTLOG (copy)
    --  [9] Utilities_m (copy)
    --  [10] Runtime (copy)
    --  [11] SBUNINDENTLOG (copy)
    --  [12] CeiveImOverlay_m (copy)

    if not RunService:IsClient() then
        warn("Smartbone.Start() can only be called in client context.")

        return
    end

    if t.Running then
        warn("Cannot call Smartbone.Start() multiple times")

        return
    end

    if Config_m.STARTUP_PRINT_ENABLED or Config_m.LOG_VERBOSE then
        print(`SmartBone2 v{Config_m.VERSION} Starting`)
    end

    t.Running = true
    local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")
    local SmartBoneActors_Folder = Instance.new("Folder")
    SmartBoneActors_Folder.Name = "SmartBone-Actors"
    SmartBoneActors_Folder.Parent = PlayerScripts
    local OverlayEvent_BindableEvent = Instance.new("BindableEvent")
    OverlayEvent_BindableEvent.Name = "OverlayEvent"
    OverlayEvent_BindableEvent.Parent = script
    OverlayEvent_BindableEvent.Event:Connect(function(arg13, ...) -- line: 570
        -- upvalues:
        --  [1] Config_m (ref)
        --  [2] v5 (ref)

        if not Config_m.DEBUG_OVERLAY_ENABLED then
            return
        end

        if arg13 == "Text" then
            v5:Text(...)

            return
        end

        if arg13 == "Begin" then
            v5:Begin(...)

            return
        end

        if arg13 == "End" then
            v5:End()
        end
    end)

    local function GatherColliders() -- line: 584
        -- upvalues:
        --  [1] CollectionService (ref)
        --  [2] SBVERBOSELOG (ref)
        --  [3] Config_m (ref)

        local t_4 = { Key = {}, Raw = {} }

        for _, val_16 in CollectionService:GetTagged("SmartCollider") do
            if val_16:IsA("BasePart") then
                local v43 = val_16:GetAttribute("ColliderKey")

                if v43 then
                    v43 = tostring(v43)

                    if not t_4.Key[v43] then
                        t_4.Key[v43] = {}
                    end

                    table.insert(t_4.Key[v43], val_16)
                end

                SBVERBOSELOG(`Adding collider: {val_16.Name}, Collider Key: {v43}`)
                table.insert(t_4.Raw, val_16)

                if Config_m.YIELD_ON_COLLIDER_GATHER then
                    task.wait()
                end
            end
        end

        return t_4
    end

    local function SetupObject(u10: userdata) -- line: 618
        -- upvalues:
        --  [1] SBVERBOSELOG (ref)
        --  [2] SBINDENTLOG (ref)
        --  [3] GatherColliders (copy)
        --  [4] Utilities_m (ref)
        --  [5] Runtime (ref)
        --  [6] SmartBoneActors_Folder (copy)
        --  [7] SBUNINDENTLOG (ref)

        if not u10:IsA("BasePart") then
            return
        end

        SBVERBOSELOG(`Setup Object: {u10.Name}`)
        SBINDENTLOG()
        local v46 = GatherColliders()
        local ColliderKey = u10:GetAttribute("ColliderKey")
        local v47, v48

        if ColliderKey then
            v47 = v46.Key[tostring(ColliderKey)] or {}
            v48 = v47
        else
            v47 = v46.Raw or {}
            v48 = v47
        end

        local t_5 = {}

        for _, val_17 in v48 do
            table.insert(t_5, { Utilities_m.GetCollider(val_17), val_17 })
        end

        v48 = Instance.new("Actor")
        local v49 = Runtime:Clone()
        v49.Parent = v48
        v49.Enabled = true
        v48.Parent = SmartBoneActors_Folder
        task.wait()
        v48:SendMessage("Setup", u10, t_5, script)
        SBVERBOSELOG("Runtime Started")
        SBUNINDENTLOG()
    end

    CollectionService:GetInstanceAddedSignal("SmartBone"):Connect(SetupObject)

    for _, val_18 in CollectionService:GetTagged("SmartBone") do
        SetupObject(val_18)
    end

    if Config_m.DEBUG_OVERLAY_ENABLED then
        v5 = CeiveImOverlay_m.new()
        local PlayerGui = Players.LocalPlayer.PlayerGui
        local SmartBoneDebugOverlay_ScreenGui = Instance.new("ScreenGui")
        SmartBoneDebugOverlay_ScreenGui.Name = "SmartBoneDebugOverlay"
        SmartBoneDebugOverlay_ScreenGui.IgnoreGuiInset = true
        SmartBoneDebugOverlay_ScreenGui.ResetOnSpawn = false
        SmartBoneDebugOverlay_ScreenGui.Parent = PlayerGui
        v5.BackFrame.Parent = SmartBoneDebugOverlay_ScreenGui
        RunService.RenderStepped:Connect(function() -- line: 678
            -- upvalues:
            --  [1] v5 (ref)

            v5:Render()
        end)
    end

    local t_7 = { Stop = nil }

    function t_7.Stop() -- line: 684
        -- upvalues:
        --  [1] Config_m (ref)
        --  [2] SmartBoneActors_Folder (copy)

        if not Config_m.RESET_BONE_ON_DESTROY then
            SmartBoneActors_Folder:Destroy()

            return
        end

        for _, child in SmartBoneActors_Folder:GetChildren() do
            child:SendMessage("Destroy")
        end
    end

    return t_7
end

return t
