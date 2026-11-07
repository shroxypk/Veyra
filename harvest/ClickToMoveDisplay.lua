-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.ClickToMoveDisplay
-- Class: ModuleScript
-- bytes: 19613

local t = {}
local v1 = "rbxasset://textures/ui/traildot.png"
local v2 = "rbxasset://textures/ui/waypoint.png"
local v3 = false
local udim2 = UDim2.new(0, 42, 0, 50)
local vec2 = Vector2.new(0, 0.5)
local vec2_1 = Vector2.new(0, 1)
local vec2_2 = Vector2.new(0, 0.5)
local vec2_3 = Vector2.new(0.1, 0.5)
local vec2_4 = Vector2.new(-0.1, 0.5)
local vec2_5 = Vector2.new(1.5, 1.5)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserRaycastPerformanceImprovements = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
).getUserFlag("UserRaycastPerformanceImprovements")
local LocalPlayer = Players.LocalPlayer

local function CreateWaypointTemplates() -- line: 55
    -- upvalues:
    --  [1] vec2_5 (ref)
    --  [2] v3 (ref)
    --  [3] v1 (ref)
    --  [4] udim2 (copy)
    --  [5] vec2 (copy)
    --  [6] v2 (ref)
    --  [7] vec2_2 (copy)

    local TrailDot_Part = Instance.new("Part")
    TrailDot_Part.Size = Vector3.new(1, 1, 1)
    TrailDot_Part.Anchored = true
    TrailDot_Part.CanCollide = false
    TrailDot_Part.Name = "TrailDot"
    TrailDot_Part.Transparency = 1
    local TrailDotImage_ImageHandleAdornment = Instance.new("ImageHandleAdornment")
    TrailDotImage_ImageHandleAdornment.Name = "TrailDotImage"
    TrailDotImage_ImageHandleAdornment.Size = vec2_5
    TrailDotImage_ImageHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    TrailDotImage_ImageHandleAdornment.AlwaysOnTop = v3
    TrailDotImage_ImageHandleAdornment.Image = v1
    TrailDotImage_ImageHandleAdornment.Adornee = TrailDot_Part
    TrailDotImage_ImageHandleAdornment.Parent = TrailDot_Part
    local Part_1 = Instance.new("Part")
    Part_1.Size = Vector3.new(2, 2, 2)
    Part_1.Anchored = true
    Part_1.CanCollide = false
    Part_1.Name = "EndWaypoint"
    Part_1.Transparency = 1
    local ImageHandleAdornment_1 = Instance.new("ImageHandleAdornment")
    ImageHandleAdornment_1.Name = "TrailDotImage"
    ImageHandleAdornment_1.Size = vec2_5
    ImageHandleAdornment_1.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    ImageHandleAdornment_1.AlwaysOnTop = v3
    ImageHandleAdornment_1.Image = v1
    ImageHandleAdornment_1.Adornee = Part_1
    ImageHandleAdornment_1.Parent = Part_1
    local EndWaypointBillboard_BillboardGui = Instance.new("BillboardGui")
    EndWaypointBillboard_BillboardGui.Name = "EndWaypointBillboard"
    EndWaypointBillboard_BillboardGui.Size = udim2
    EndWaypointBillboard_BillboardGui.LightInfluence = 0
    EndWaypointBillboard_BillboardGui.SizeOffset = vec2
    EndWaypointBillboard_BillboardGui.AlwaysOnTop = true
    EndWaypointBillboard_BillboardGui.Adornee = Part_1
    EndWaypointBillboard_BillboardGui.Parent = Part_1
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Image = v2
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.Parent = EndWaypointBillboard_BillboardGui
    local Part_2 = Instance.new("Part")
    Part_2.Size = Vector3.new(2, 2, 2)
    Part_2.Anchored = true
    Part_2.CanCollide = false
    Part_2.Name = "FailureWaypoint"
    Part_2.Transparency = 1
    local ImageHandleAdornment_2 = Instance.new("ImageHandleAdornment")
    ImageHandleAdornment_2.Name = "TrailDotImage"
    ImageHandleAdornment_2.Size = vec2_5
    ImageHandleAdornment_2.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    ImageHandleAdornment_2.AlwaysOnTop = v3
    ImageHandleAdornment_2.Image = v1
    ImageHandleAdornment_2.Adornee = Part_2
    ImageHandleAdornment_2.Parent = Part_2
    local BillboardGui_1 = Instance.new("BillboardGui")
    BillboardGui_1.Name = "FailureWaypointBillboard"
    BillboardGui_1.Size = udim2
    BillboardGui_1.LightInfluence = 0
    BillboardGui_1.SizeOffset = vec2_2
    BillboardGui_1.AlwaysOnTop = true
    BillboardGui_1.Adornee = Part_2
    BillboardGui_1.Parent = Part_2
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(0, 0, 0, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 0)
    Frame.Parent = BillboardGui_1
    local ImageLabel_1 = Instance.new("ImageLabel")
    ImageLabel_1.Image = v2
    ImageLabel_1.BackgroundTransparency = 1
    ImageLabel_1.Position = UDim2.new(0, -udim2.X.Offset / 2, 0, -udim2.Y.Offset)
    ImageLabel_1.Size = udim2
    ImageLabel_1.Parent = Frame

    return TrailDot_Part, Part_1, Part_2
end

local v4, v5, v6 = CreateWaypointTemplates()

local _ = function() --[[ getTrailDotParent ]] -- line: 141
    -- upvalues:
    --  [1] Workspace (copy)

    local CurrentCamera = Workspace.CurrentCamera
    local v7 = CurrentCamera:FindFirstChild("ClickToMoveDisplay")

    if not v7 then
        v7 = Instance.new("Model")
        v7.Name = "ClickToMoveDisplay"
        v7.Parent = CurrentCamera
    end

    return v7
end

local function placePathWaypoint(arg1: any, vec1: Vector3) -- line: 152
    -- upvalues:
    --  [1] UserRaycastPerformanceImprovements (copy)
    --  [2] raycastParams (copy)
    --  [3] Workspace (copy)
    --  [4] LocalPlayer (copy)

    if UserRaycastPerformanceImprovements then
        raycastParams.FilterDescendantsInstances = {
            Workspace.CurrentCamera,
            LocalPlayer.Character
        }
        local v9 = Workspace:Raycast(
            vec1 + Vector3.new(0, 2.5, 0),
            Vector3.new(-0, -10, -0),
            raycastParams
        )

        if v9 then
            arg1.CFrame = CFrame.lookAlong(v9.Position, v9.Normal)
            local CurrentCamera_1 = Workspace.CurrentCamera
            local v10 = CurrentCamera_1:FindFirstChild("ClickToMoveDisplay")

            if not v10 then
                v10 = Instance.new("Model")
                v10.Name = "ClickToMoveDisplay"
                v10.Parent = CurrentCamera_1
            end

            arg1.Parent = v10

            return
        end
    else
        local v11, v12, v13 = Workspace:FindPartOnRayWithIgnoreList(
            Ray.new(vec1 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)),
            { Workspace.CurrentCamera, LocalPlayer.Character }
        )

        if v11 then
            arg1.CFrame = CFrame.new(v12, v12 + v13)
            local CurrentCamera_2 = Workspace.CurrentCamera
            local v14 = CurrentCamera_2:FindFirstChild("ClickToMoveDisplay")

            if not v14 then
                v14 = Instance.new("Model")
                v14.Name = "ClickToMoveDisplay"
                v14.Parent = CurrentCamera_2
            end

            arg1.Parent = v14
        end
    end
end

local t_1 = {}
t_1.__index = t_1

function t_1.Destroy(arg2) -- line: 177
    arg2.DisplayModel:Destroy()
end

function t_1.NewDisplayModel(_, arg4) -- line: 181
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] placePathWaypoint (copy)

    local v15 = v4:Clone()
    placePathWaypoint(v15, arg4)

    return v15
end

function t_1.new(arg5, arg6) -- line: 187
    -- upvalues:
    --  [1] t_1 (copy)

    local t_2 = setmetatable({}, t_1)
    t_2.DisplayModel = t_2:NewDisplayModel(arg5)
    t_2.ClosestWayPoint = arg6

    return t_2
end

local t_3 = {}
t_3.__index = t_3

function t_3.Destroy(arg7) -- line: 199
    arg7.Destroyed = true
    arg7.Tween:Cancel()
    arg7.DisplayModel:Destroy()
end

function t_3.NewDisplayModel(_, arg9) -- line: 205
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] placePathWaypoint (copy)

    local v16 = v5:Clone()
    placePathWaypoint(v16, arg9)

    return v16
end

function t_3.CreateTween(arg10) -- line: 211
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] vec2_1 (copy)

    local tweenInfo = TweenInfo.new(
        0.5,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out,
        -1,
        true
    )
    local v17 = TweenService:Create(
        arg10.DisplayModel.EndWaypointBillboard,
        tweenInfo,
        { SizeOffset = vec2_1 }
    )
    v17:Play()

    return v17
end

function t_3.TweenInFrom(t1: table, vec3: Vector3) -- line: 222
    -- upvalues:
    --  [1] TweenService (copy)

    t1.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(
        0,
        (vec3 - t1.DisplayModel.Position).Y,
        0
    )
    local tweenInfo_1 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v18 = TweenService:Create(
        t1.DisplayModel.EndWaypointBillboard,
        tweenInfo_1,
        { StudsOffset = Vector3.new(0, 0, 0) }
    )
    v18:Play()

    return v18
end

function t_3.new(vec4: Vector3, n1: number?, vec5: Vector3?) -- line: 236
    -- upvalues:
    --  [1] t_3 (copy)

    local t_5 = setmetatable({}, t_3)
    t_5.DisplayModel = t_5:NewDisplayModel(vec4)
    t_5.Destroyed = false

    if vec5 and (vec5 - vec4).Magnitude > 5 then
        t_5.Tween = t_5:TweenInFrom(vec5)
        coroutine.wrap(function() -- line: 243
            -- upvalues:
            --  [1] t_5 (copy)

            t_5.Tween.Completed:Wait()

            if not t_5.Destroyed then
                t_5.Tween = t_5:CreateTween()
            end
        end)()
    else
        t_5.Tween = t_5:CreateTween()
    end

    t_5.ClosestWayPoint = n1

    return t_5
end

local t_6 = {}
t_6.__index = t_6

function t_6.Hide(arg11) -- line: 260
    arg11.DisplayModel.Parent = nil
end

function t_6.Destroy(arg12) -- line: 264
    arg12.DisplayModel:Destroy()
end

function t_6.NewDisplayModel(_, arg14) -- line: 268
    -- upvalues:
    --  [1] v6 (ref)
    --  [2] placePathWaypoint (copy)
    --  [3] UserRaycastPerformanceImprovements (copy)
    --  [4] raycastParams (copy)
    --  [5] Workspace (copy)
    --  [6] LocalPlayer (copy)

    local v20 = v6:Clone()
    placePathWaypoint(v20, arg14)

    if UserRaycastPerformanceImprovements then
        raycastParams.FilterDescendantsInstances = {
            Workspace.CurrentCamera,
            LocalPlayer.Character
        }
        local v22 = Workspace:Raycast(
            arg14 + Vector3.new(0, 2.5, 0),
            Vector3.new(-0, -10, -0),
            raycastParams
        )

        if v22 then
            v20.CFrame = CFrame.lookAlong(v22.Position, v22.Normal)
            local CurrentCamera_3 = Workspace.CurrentCamera
            local v23 = CurrentCamera_3:FindFirstChild("ClickToMoveDisplay")

            if not v23 then
                v23 = Instance.new("Model")
                v23.Name = "ClickToMoveDisplay"
                v23.Parent = CurrentCamera_3
            end

            v20.Parent = v23

            return v20
        end
    else
        local v24, v25, v26 = Workspace:FindPartOnRayWithIgnoreList(
            Ray.new(arg14 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)),
            { Workspace.CurrentCamera, LocalPlayer.Character }
        )

        if v24 then
            v20.CFrame = CFrame.new(v25, v25 + v26)
            local CurrentCamera_4 = Workspace.CurrentCamera
            local v27 = CurrentCamera_4:FindFirstChild("ClickToMoveDisplay")

            if not v27 then
                v27 = Instance.new("Model")
                v27.Name = "ClickToMoveDisplay"
                v27.Parent = CurrentCamera_4
            end

            v20.Parent = v27
        end
    end

    return v20
end

function t_6.RunFailureTween(arg15) -- line: 292
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] vec2_3 (copy)
    --  [3] vec2_4 (copy)
    --  [4] vec2_2 (copy)

    wait(0.125)
    local tweenInfo_2 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v28 = TweenService:Create(
        arg15.DisplayModel.FailureWaypointBillboard,
        tweenInfo_2,
        { SizeOffset = vec2_3 }
    )
    v28:Play()
    TweenService:Create(
        arg15.DisplayModel.FailureWaypointBillboard.Frame,
        tweenInfo_2,
        { Rotation = 10 }
    ):Play()
    v28.Completed:wait()
    local t_8 = { SizeOffset = vec2_4 }
    local v29 = TweenService:Create(
        arg15.DisplayModel.FailureWaypointBillboard,
        TweenInfo.new(
            0.125,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            3,
            true
        ),
        t_8
    )
    v29:Play()
    local tweenInfo_3 = TweenInfo.new(
        0.125,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out,
        3,
        true
    )
    local t_9 = { ImageColor3 = Color3.new(0.75, 0.75, 0.75) }
    TweenService:Create(
        arg15.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel,
        tweenInfo_3,
        t_9
    ):Play()
    TweenService:Create(
        arg15.DisplayModel.FailureWaypointBillboard.Frame,
        tweenInfo_3,
        { Rotation = -10 }
    ):Play()
    v29.Completed:wait()
    local tweenInfo_4 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v31 = TweenService:Create(
        arg15.DisplayModel.FailureWaypointBillboard,
        tweenInfo_4,
        { SizeOffset = vec2_2 }
    )
    v31:Play()
    TweenService:Create(
        arg15.DisplayModel.FailureWaypointBillboard.Frame,
        tweenInfo_4,
        { Rotation = 0 }
    ):Play()
    v31.Completed:wait()
    wait(0.125)
end

function t_6.new(arg16) -- line: 341
    -- upvalues:
    --  [1] t_6 (copy)

    local t_11 = setmetatable({}, t_6)
    t_11.DisplayModel = t_11:NewDisplayModel(arg16)

    return t_11
end

local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://2874840706"
local v32 = nil

local _ = function(arg17) --[[ getFailureAnimationTrack ]] -- line: 355
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] Animation (copy)

    if arg17 == nil then
        return v32
    end

    v32 = arg17:LoadAnimation(Animation)
    assert(v32, "")
    v32.Priority = Enum.AnimationPriority.Action
    v32.Looped = false

    return v32
end

local _ = function() --[[ findPlayerHumanoid ]] -- line: 366
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local Character = LocalPlayer.Character

    if Character then
        return Character:FindFirstChildOfClass("Humanoid")
    end
end

local function createTrailDots(t2: table, vec6: Vector3) -- line: 373
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t_3 (copy)

    local t_12 = {}
    local v33 = 1

    for index = 1, #t2 - 1 do
        local v34 = (t2[index].Position - t2[#t2].Position).Magnitude < 3

        if if index % 2 == 0 then not v34 else false then
            t_12[v33] = t_1.new(t2[index].Position, index)
            v33 += 1
        end
    end

    local v36 = t_3.new(t2[#t2].Position, #t2, vec6)
    table.insert(t_12, v36)
    local t_13 = {}
    v33 = 1

    for index_1 = #t_12, 1, -1 do
        t_13[v33] = t_12[index_1]
        v33 += 1
    end

    return t_13
end

local _ = function(n2: number, u1: Vector2) --[[ getTrailDotScale ]] -- line: 398
    return u1 * (math.clamp(n2 - 10, 0, 90) / 90 * 1.5 + 1)
end

local v37 = 0

function t.CreatePathDisplay(arg18, arg19) -- line: 407
    -- upvalues:
    --  [1] v37 (ref)
    --  [2] createTrailDots (copy)
    --  [3] RunService (copy)
    --  [4] Workspace (copy)
    --  [5] vec2_5 (ref)

    v37 += 1
    local v38 = createTrailDots(arg18, arg19)

    local function removePathBeforePoint(arg20) -- line: 411
        -- upvalues:
        --  [1] v38 (copy)

        for index_2 = #v38, 1, -1 do
            local v39 = v38[index_2]

            if not (arg20 >= v39.ClosestWayPoint) then
                break
            end

            v39:Destroy()
            v38[index_2] = nil

            return
        end
    end

    local v40 = "ClickToMoveResizeTrail" .. v37

    local function resizeTrailDots() -- line: 425
        -- upvalues:
        --  [1] v38 (copy)
        --  [2] RunService (ref)
        --  [3] v40 (copy)
        --  [4] Workspace (ref)
        --  [5] vec2_5 (ref)

        if #v38 == 0 then
            RunService:UnbindFromRenderStep(v40)

            return
        end

        local P = Workspace.CurrentCamera.CFrame.p

        for index_3 = 1, #v38 do
            local _ = #v38
            local TrailDotImage = v38[index_3].DisplayModel:FindFirstChild("TrailDotImage")

            if TrailDotImage then
                TrailDotImage.Size = vec2_5 * (math.clamp(
                    (v38[index_3].DisplayModel.Position - P).Magnitude - 10,
                    0,
                    90
                ) / 90 * 1.5 + 1)
            end
        end
    end

    RunService:BindToRenderStep(v40, Enum.RenderPriority.Camera.Value - 1, resizeTrailDots)

    local function removePath() -- line: 441
        -- upvalues:
        --  [1] removePathBeforePoint (copy)
        --  [2] arg18 (copy)

        removePathBeforePoint(#arg18)
    end

    return removePath, removePathBeforePoint
end

local v44 = nil

function t.DisplayFailureWaypoint(arg21) -- line: 449
    -- upvalues:
    --  [1] v44 (ref)
    --  [2] t_6 (copy)

    if v44 then
        v44:Hide()
    end

    local v45 = t_6.new(arg21)
    v44 = v45
    coroutine.wrap(function() -- line: 455
        -- upvalues:
        --  [1] v45 (ref)

        v45:RunFailureTween()
        v45:Destroy()
        v45 = nil
    end)()
end

function t.CreateEndWaypoint(arg22) -- line: 462
    -- upvalues:
    --  [1] t_3 (copy)

    return t_3.new(arg22)
end

function t.PlayFailureAnimation() -- line: 466
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] v32 (ref)
    --  [3] Animation (copy)

    local v46 = LocalPlayer.Character
    local v47 = if v46 then v46:FindFirstChildOfClass("Humanoid") else nil

    if v47 then
        if v47 == nil then
            v46 = v32
        else
            v32 = v47:LoadAnimation(Animation)
            assert(v32, "")
            v32.Priority = Enum.AnimationPriority.Action
            v32.Looped = false
            v46 = v32
        end

        v46:Play()
    end
end

function t.CancelFailureAnimation() -- line: 474
    -- upvalues:
    --  [1] v32 (ref)

    if v32 ~= nil and v32.IsPlaying then
        v32:Stop()
    end
end

function t.SetWaypointTexture(arg23) -- line: 480
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v4 (ref)
    --  [3] v5 (ref)
    --  [4] v6 (ref)
    --  [5] CreateWaypointTemplates (copy)

    v1 = arg23
    v4, v5, v6 = CreateWaypointTemplates()
end

function t.GetWaypointTexture() -- line: 485
    -- upvalues:
    --  [1] v1 (ref)

    return v1
end

function t.SetWaypointRadius(arg24) -- line: 489
    -- upvalues:
    --  [1] vec2_5 (ref)
    --  [2] v4 (ref)
    --  [3] v5 (ref)
    --  [4] v6 (ref)
    --  [5] CreateWaypointTemplates (copy)

    vec2_5 = Vector2.new(arg24, arg24)
    v4, v5, v6 = CreateWaypointTemplates()
end

function t.GetWaypointRadius() -- line: 494
    -- upvalues:
    --  [1] vec2_5 (ref)

    return vec2_5.X
end

function t.SetEndWaypointTexture(arg25) -- line: 498
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] v4 (ref)
    --  [3] v5 (ref)
    --  [4] v6 (ref)
    --  [5] CreateWaypointTemplates (copy)

    v2 = arg25
    v4, v5, v6 = CreateWaypointTemplates()
end

function t.GetEndWaypointTexture() -- line: 503
    -- upvalues:
    --  [1] v2 (ref)

    return v2
end

function t.SetWaypointsAlwaysOnTop(arg26) -- line: 507
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] v4 (ref)
    --  [3] v5 (ref)
    --  [4] v6 (ref)
    --  [5] CreateWaypointTemplates (copy)

    v3 = arg26
    v4, v5, v6 = CreateWaypointTemplates()
end

function t.GetWaypointsAlwaysOnTop() -- line: 512
    -- upvalues:
    --  [1] v3 (ref)

    return v3
end

return t
