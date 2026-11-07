-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.DebugUi
-- Class: ModuleScript
-- bytes: 13449

local t = {}
local t_1 = {}

local function infoText(arg1, arg2) -- line: 4
    arg1.PushConfig({ TextColor = arg1._config.TextDisabledColor })
    arg1.Text({ arg2 })
    arg1.PopConfig()
end

local function helpMarker(arg3, arg4) -- line: 10
    arg3.PushConfig({ TextColor = arg3._config.TextDisabledColor })
    local v1 = arg3.Text({ "(?)" })
    arg3.PopConfig()
    local t_4 = { ContentWidth = UDim.new(0, 350) }
    arg3.PushConfig(t_4)

    if v1.hovered() then
        arg3.Tooltip({ arg4 })
    end

    arg3.PopConfig()
end

local function BoneEditor(arg5, arg6) -- line: 22
    -- upvalues:
    --  [1] t (copy)

    local v2 = arg5.Window({ `Editing bone: {arg6.Bone.Name}` })
    v2.isOpened.value = true
    arg6.Radius = arg5.InputNum({ "Radius", 0.1, 0, math.huge, "%.3f" }, { number = arg6.Radius }).number.value
    arg6.RotationLimit = arg5.InputNum(
        { "Rotation Limit", 0.1, 0, 180, "%.3f" },
        { number = arg6.RotationLimit }
    ).number.value
    arg6.Anchored = arg5.Checkbox({ "Anchored" }, { isChecked = arg6.Anchored }).isChecked.value
    arg5.Text("Axis Lock")
    arg5.Indent()
    arg5.SameLine()
    arg5.Text("X: ")
    local v3 = arg5.Checkbox({ "" }, { isChecked = arg6.AxisLocked[1] })
    arg5.Text("Y: ")
    local v4 = arg5.Checkbox({ "" }, { isChecked = arg6.AxisLocked[2] })
    arg5.Text("Z: ")
    local v5 = arg5.Checkbox({ "" }, { isChecked = arg6.AxisLocked[3] })
    arg5.End()
    arg5.End()
    local v6 = arg5.State(Vector2.new(arg6.XAxisLimits.Min, arg6.XAxisLimits.Max))
    local v7 = arg5.State(Vector2.new(arg6.YAxisLimits.Min, arg6.YAxisLimits.Max))
    local v8 = arg5.State(Vector2.new(arg6.ZAxisLimits.Min, arg6.ZAxisLimits.Max))
    arg5.Text("Axis Limits")
    arg5.Indent()
    arg5.DragVector2(
        { "X Axis Limit", 0.05, nil, nil, { "Min: %.2f", "Max: %.2f" } },
        { number = v6 }
    )
    arg5.DragVector2(
        { "Y Axis Limit", 0.05, nil, nil, { "Min: %.2f", "Max: %.2f" } },
        { number = v7 }
    )
    arg5.DragVector2(
        { "Z Axis Limit", 0.05, nil, nil, { "Min: %.2f", "Max: %.2f" } },
        { number = v8 }
    )
    arg5.End()
    arg5.End()
    arg6.AxisLocked[1] = v3.isChecked.value
    arg6.AxisLocked[2] = v4.isChecked.value
    arg6.AxisLocked[3] = v5.isChecked.value
    arg6.XAxisLimits = NumberRange.new(v6:get().X, v6:get().Y)
    arg6.YAxisLimits = NumberRange.new(v7:get().X, v7:get().Y)
    arg6.ZAxisLimits = NumberRange.new(v8:get().X, v8:get().Y)

    if v2.closed() then
        t[arg6] = nil
    end
end

local function ColliderEditor(arg7, arg8) -- line: 77
    -- upvalues:
    --  [1] t_1 (copy)

    local v9 = arg7.Window({ `Editing collider of type: {arg8.Type}` })
    v9.isOpened.value = true
    local v10 = arg7.State(arg8.Type)
    local v11 = arg7.State(arg8.Scale)
    local v12 = arg7.State(arg8.Offset)
    local v13 = arg7.State(arg8.Rotation)
    arg7.Combo({ "Collider Type" }, { index = v10 })
    arg7.Selectable({ "Box", "Box" }, { index = v10 })
    arg7.Selectable({ "Sphere", "Sphere" }, { index = v10 })
    arg7.Selectable({ "Capsule", "Capsule" }, { index = v10 })
    arg7.End()
    arg7.DragVector3({ "Scale", 0.1, 0, nil }, { number = v11 })
    arg7.DragVector3({ "Offset", 0.1, nil, nil }, { number = v12 })
    arg7.DragVector3({ "Rotation", 0.5, -180, 180 }, { number = v13 })
    arg8.Type = v10:get()
    arg8.Scale = v11:get()
    arg8.Offset = v12:get()
    arg8.Rotation = v13:get()
    arg7.End()

    if v9.closed() then
        t_1[arg8] = nil
    end
end

return function(arg9, arg10, arg11) -- line: 108
    -- upvalues:
    --  [1] t (copy)
    --  [2] BoneEditor (copy)
    --  [3] t_1 (copy)
    --  [4] ColliderEditor (copy)
    --  [5] helpMarker (copy)
    --  [6] infoText (copy)

    local t_23 = {}

    for _, val in arg10.BoneTrees do
        local RootPart = val.RootPart
        local v14 = t_23[RootPart]

        if not v14 then
            t_23[RootPart] = {}
            v14 = t_23[RootPart]
        end

        table.insert(v14, val)
    end

    for key_1, _ in t do
        local v15 = key_1.ParentIndex + 1
        arg9.PushId(`{arg10.ID} - {v15}`)
        BoneEditor(arg9, key_1)
        arg9.PopId()
    end

    for key_2, _ in t_1 do
        arg9.PushId(key_2.GUID)
        ColliderEditor(arg9, key_2)
        arg9.PopId()
    end

    local v17 = #arg10.BoneTrees
    local v18 = #arg10.ColliderObjects
    local v19 = v17
    local v20 = if v17 ~= 1 then "s" else ""
    local v21 = `{v19} BoneTree{v20}`
    v20 = v18
    local v23 = if v18 == 1 then "" else "s"
    arg9.Window(
        {
            `SmartBone Runtime Editor. {v21}, {("%* Collider%*"):format(v20, v23)}`,
            [arg9.Args.Window.NoClose] = true
        }
    )
    arg9.Tree({ "Debug Gizmos", true }, { isUncollapsed = true })
    arg9.SameLine()
    local t_25 = { isChecked = nil }
    local Checkbox = arg9.Checkbox
    t_25.isChecked = arg11.DRAW_BONE
    Checkbox({ "Draw Internal Bone" }, t_25)
    helpMarker(
        arg9,
        "Draws a sphere with the specified radius of the bone around where SmartBone believes the bone is."
    )
    arg9.End()
    arg9.SameLine()
    local t_27 = { isChecked = nil }
    local Checkbox_1 = arg9.Checkbox
    t_27.isChecked = arg11.DRAW_PHYSICAL_BONE
    Checkbox_1({ "Draw Physical Bone" }, t_27)
    helpMarker(arg9, "Draws the actual bone objects CFrame with axis arrows.")
    arg9.End()
    arg9.SameLine()
    local t_29 = { isChecked = nil }
    local Checkbox_2 = arg9.Checkbox
    t_29.isChecked = arg11.DRAW_ROOT_PART
    Checkbox_2({ "Draw Root Part" }, t_29)
    helpMarker(arg9, "Draws a bounding box and fills in the root part.")
    arg9.End()
    arg9.SameLine()
    local t_31 = { isChecked = nil }
    local Checkbox_3 = arg9.Checkbox
    t_31.isChecked = arg11.DRAW_BOUNDING_BOX
    Checkbox_3({ "Draw Bounding Box" }, t_31)
    helpMarker(arg9, "Draws the bounding box used for frustum culling")
    arg9.End()
    arg9.SameLine()
    local t_33 = { isChecked = nil }
    local Checkbox_4 = arg9.Checkbox
    t_33.isChecked = arg11.DRAW_AXIS_LIMITS
    Checkbox_4({ "Draw Axis Limits" }, t_33)
    helpMarker(arg9, "Draws the axis limits for each bone.")
    arg9.End()
    arg9.SameLine()
    local t_35 = { isChecked = nil }
    local Checkbox_5 = arg9.Checkbox
    t_35.isChecked = arg11.DRAW_ROTATION_LIMITS
    Checkbox_5({ "Draw Rotation Limits" }, t_35)
    helpMarker(arg9, "Draws the rotation limits for each bone.")
    arg9.End()
    arg9.SameLine()
    local t_37 = { isChecked = nil }
    local Checkbox_6 = arg9.Checkbox
    t_37.isChecked = arg11.DRAW_ACCELERATION_INFO
    Checkbox_6({ "Draw Acceleration Info" }, t_37)
    helpMarker(arg9, "Draws the acceleration and the required values to derive it.")
    arg9.End()
    arg9.SameLine()
    local t_39 = { isChecked = nil }
    local Checkbox_7 = arg9.Checkbox
    t_39.isChecked = arg11.DRAW_COLLIDERS
    Checkbox_7({ "Draw Colliders" }, t_39)
    helpMarker(arg9, "Draws all the colliders this root object can collide with.")
    arg9.End()
    arg9.SameLine()
    local t_41 = { isChecked = nil }
    local Checkbox_8 = arg9.Checkbox
    t_41.isChecked = arg11.DRAW_COLLIDER_INFLUENCE
    Checkbox_8({ "Draw Collider Influence" }, t_41)
    helpMarker(arg9, "Shows the sphere of influence around each collider.")
    arg9.End()
    arg9.SameLine()
    local t_43 = { isChecked = nil }
    local Checkbox_9 = arg9.Checkbox
    t_43.isChecked = arg11.DRAW_COLLIDER_AWAKE
    Checkbox_9({ "Draw Collider Awake" }, t_43)
    helpMarker(arg9, "Shows if a collider is awake or asleep.")
    arg9.End()
    arg9.SameLine()
    local t_45 = { isChecked = nil }
    local Checkbox_10 = arg9.Checkbox
    t_45.isChecked = arg11.DRAW_COLLIDER_BROADPHASE
    Checkbox_10({ "Draw Collider Broadphase" }, t_45)
    helpMarker(arg9, "Shows if a collider isn't reaching narrowphase.")
    arg9.End()
    arg9.SameLine()
    local t_47 = { isChecked = nil }
    local Checkbox_11 = arg9.Checkbox
    t_47.isChecked = arg11.DRAW_FILL_COLLIDERS
    Checkbox_11({ "Draw Fill Colliders" }, t_47)
    helpMarker(arg9, "Fills all colliders this root object can collide with.")
    arg9.End()
    arg9.SameLine()
    local t_49 = { isChecked = nil }
    local Checkbox_12 = arg9.Checkbox
    t_49.isChecked = arg11.DRAW_CONTACTS
    Checkbox_12({ "Draw Contacts" }, t_49)
    helpMarker(
        arg9,
        "Draws the position and normal of the points which bones collide with colliders."
    )
    arg9.End()
    arg9.End()
    arg9.Separator()
    infoText(arg9, "Simulated Objects")

    for key_3, val_3 in t_23 do
        arg9.Tree(`{key_3.Name} - Root Part`)

        for key_4, val_4 in val_3 do
            arg9.Tree(`BoneTree #{key_4}`)
            local v24 = string.format("%.1f", val_4.UpdateRate)
            infoText(
                arg9,
                `Throttled Update Rate: {v24} / {string.format("%.1f", val_4.Settings.UpdateRate)} fps`
            )
            infoText(arg9, `In View: {val_4.InView}`)
            local v27 = arg9.State(val_4.Settings.Constraint)
            local v28 = arg9.State(val_4.Settings.WindType)
            local v29 = arg9.State(val_4.Settings.UpdateRate)
            local v30 = arg9.State(val_4.Settings.ActivationDistance)
            local v31 = arg9.State(val_4.Settings.ThrottleDistance)
            arg9.SameLine()
            helpMarker(
                arg9,
                "The constraint used, distance is more flowy while spring is more rigid."
            )
            arg9.Combo({ "Constraint Type" }, { index = v27 })
            arg9.Selectable({ "Distance", "Distance" }, { index = v27 })
            arg9.Selectable({ "Spring", "Spring" }, { index = v27 })
            arg9.End()
            arg9.End()
            arg9.SameLine()
            helpMarker(
                arg9,
                "The wind solver used, sine is a smoother wind, noise is more chaotic and hybrid is a mix of the two."
            )
            arg9.Combo({ "Wind Type" }, { index = v28 })
            arg9.Selectable({ "Sine", "Sine" }, { index = v28 })
            arg9.Selectable({ "Noise", "Noise" }, { index = v28 })
            arg9.Selectable({ "Hybrid", "Hybrid" }, { index = v28 })
            arg9.End()
            arg9.End()
            arg9.SameLine()
            helpMarker(arg9, "The target update rate for the bone tree")
            arg9.SliderNum({ "Update Rate", 5, 0, 120 }, { number = v29 })
            arg9.End()
            arg9.SameLine()
            helpMarker(arg9, "The distance at which the bone tree stops updating")
            arg9.SliderNum({ "Activation Distance", 1, 0, 500 }, { number = v30 })
            arg9.End()
            arg9.SameLine()
            helpMarker(
                arg9,
                "The distance at which the bone tree starts throttling its update rate"
            )
            arg9.SliderNum({ "Throttle Distance", 1, 0, 500 }, { number = v31 })
            arg9.End()
            val_4.Settings.Constraint = v27:get()
            val_4.Settings.WindType = v28:get()
            val_4.Settings.UpdateRate = v29:get()
            val_4.Settings.ActivationDistance = v30:get()
            val_4.Settings.ThrottleDistance = v31:get()
            arg9.Table({ 4, false, false, false })
            arg9.NextColumn()
            arg9.Text("Bone #")
            arg9.NextColumn()
            arg9.Text("Bone Name")
            arg9.NextColumn()
            arg9.Text("Parent #")
            arg9.NextColumn()
            arg9.Text("Edit")
            arg9.End()
            arg9.Table({ 4 })

            for key_5, val_5 in val_4.Bones do
                arg9.NextColumn()
                arg9.Text((tostring(key_5)))
                arg9.NextColumn()
                arg9.Text(val_5.Bone.Name)
                arg9.NextColumn()
                arg9.Text((tostring(val_5.ParentIndex)))
                arg9.NextColumn()
                arg9.SameLine()
                arg9.Text("")

                if arg9.SmallButton({ "Edit" }).clicked() then
                    t[val_5] = true
                end

                arg9.End()
            end

            arg9.End()
            arg9.End()
        end

        arg9.End()
    end

    infoText(arg9, "Active Colliders")

    for _, val_6 in arg10.ColliderObjects do
        arg9.Tree({ val_6.m_Object.Name })
        infoText(arg9, "Colliders adorned to this object")
        arg9.Table({ 5, false, false, false })
        arg9.NextColumn()
        arg9.Text("Type")
        arg9.NextColumn()
        arg9.Text("Scale")
        arg9.NextColumn()
        arg9.Text("Offset")
        arg9.NextColumn()
        arg9.Text("Rotation")
        arg9.NextColumn()
        arg9.Text("Edit")
        arg9.End()
        arg9.Table({ 5 })

        for _, val_7 in val_6.Colliders do
            arg9.NextColumn()
            arg9.Text((tostring(val_7.Type)))
            arg9.NextColumn()
            arg9.Text((tostring(val_7.Scale)))
            arg9.NextColumn()
            arg9.Text((tostring(val_7.Offset)))
            arg9.NextColumn()
            arg9.Text((tostring(val_7.Rotation)))
            arg9.NextColumn()
            arg9.SameLine()
            arg9.Text("")

            if arg9.SmallButton({ "Edit" }).clicked() then
                t_1[val_7] = true
            end

            arg9.End()
        end

        arg9.End()
        arg9.End()
    end

    arg9.End()
end
