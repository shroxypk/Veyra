-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.WindShakeController.WindShake
-- Class: ModuleScript
-- bytes: 12206

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Settings_m = require(script.Settings)
local VectorMap_m = require(script.VectorMap)
local _ = { WindDirection = Vector3.new(0.5, 0, 0.5), WindSpeed = 20, WindPower = 0.5 }
local BindableEvent = Instance.new("BindableEvent")
local BindableEvent_1 = Instance.new("BindableEvent")
local BindableEvent_2 = Instance.new("BindableEvent")
local BindableEvent_3 = Instance.new("BindableEvent")
local BindableEvent_4 = Instance.new("BindableEvent")

return {
    RenderDistance = 150,
    MaxRefreshRate = 0.016666666666666666,
    SharedSettings = Settings_m.new(script),
    ObjectMetadata = {},
    VectorMap = VectorMap_m.new(),
    Handled = 0,
    Active = 0,
    _partList = table.create(500),
    _cframeList = table.create(500),
    ObjectShakeAdded = BindableEvent.Event,
    ObjectShakeRemoved = BindableEvent_1.Event,
    ObjectShakeUpdated = BindableEvent_2.Event,
    Paused = BindableEvent_3.Event,
    Resumed = BindableEvent_4.Event,
    Connect = function(t1: table, s1: string, u1: userdata) --[[ Connect ]] -- line: 62
        local v1 = t1[s1]
        assert(if typeof(v1) ~= "function" then false else true, "Unknown function: " .. s1)

        return u1:Connect(function(...) -- line: 66
            -- upvalues:
            --  [1] v1 (copy)
            --  [2] t1 (copy)

            return v1(t1, ...)
        end)
    end,
    AddObjectShake = function(t2: table, u2: userdata, t3: table?) --[[ AddObjectShake ]] -- line: 71
        -- upvalues:
        --  [1] Settings_m (copy)
        --  [2] BindableEvent (copy)

        if typeof(u2) ~= "Instance" then
            return
        end

        if not u2:IsA("BasePart") and not u2:IsA("Bone") then
            return
        end

        local ObjectMetadata = t2.ObjectMetadata

        if ObjectMetadata[u2] then
            return
        end

        t2.Handled += 1
        local t_2 = {
            ChunkKey = t2.VectorMap:AddObject(
                if u2:IsA("Bone") then u2.WorldPosition else u2.Position,
                u2
            ),
            Settings = Settings_m.new(u2),
            Seed = math.random(5000) * 0.32,
            Origin = if u2:IsA("Bone") then u2.WorldCFrame else u2.CFrame,
            LastUpdate = os.clock()
        }
        ObjectMetadata[u2] = t_2

        if t3 then
            t2:UpdateObjectSettings(u2, t3)
        end

        BindableEvent:Fire(u2)
    end,
    RemoveObjectShake = function(t4: table, u3: userdata) --[[ RemoveObjectShake ]] -- line: 107
        -- upvalues:
        --  [1] BindableEvent_1 (copy)

        if typeof(u3) ~= "Instance" then
            return
        end

        local ObjectMetadata_1 = t4.ObjectMetadata
        local v5 = ObjectMetadata_1[u3]

        if v5 then
            t4.Handled -= 1
            ObjectMetadata_1[u3] = nil
            v5.Settings:Destroy()
            t4.VectorMap:RemoveObject(v5.ChunkKey, u3)

            if u3:IsA("BasePart") then
                u3.CFrame = v5.Origin
            elseif u3:IsA("Bone") then
                u3.WorldCFrame = v5.Origin
            end
        end

        BindableEvent_1:Fire(u3)
    end,
    Update = function(t5: table, n1: number) --[[ Update ]] -- line: 131
        debug.profilebegin("WindShake")
        local v6 = 0
        debug.profilebegin("Update")
        local clock = os.clock()
        local v7 = n1 * 3
        local v8 = math.min(1, n1 * 5)
        local PartList = t5._partList
        local CframeList = t5._cframeList
        table.clear(PartList)
        table.clear(CframeList)
        local CurrentCamera = workspace.CurrentCamera
        local RenderDistance = t5.RenderDistance
        local SharedSettings = t5.SharedSettings
        local ObjectMetadata_2 = t5.ObjectMetadata
        local Position = CurrentCamera.CFrame.Position
        local MaxRefreshRate = t5.MaxRefreshRate
        local WindDirection = SharedSettings.WindDirection
        local WindPower = SharedSettings.WindPower
        local WindSpeed = SharedSettings.WindSpeed
        local v9 = 0
        t5.VectorMap:ForEachObjectInView(CurrentCamera, RenderDistance, function(
            s2: string,
            u4: userdata
        ) -- line: 161
            -- upvalues:
            --  [1] ObjectMetadata_2 (copy)
            --  [2] Position (copy)
            --  [3] RenderDistance (copy)
            --  [4] v7 (copy)
            --  [5] MaxRefreshRate (copy)
            --  [6] clock (copy)
            --  [7] v6 (ref)
            --  [8] WindDirection (copy)
            --  [9] WindPower (copy)
            --  [10] WindSpeed (copy)
            --  [11] v8 (copy)
            --  [12] v9 (ref)
            --  [13] PartList (copy)
            --  [14] CframeList (copy)

            local v10 = ObjectMetadata_2[u4]
            local v11 = v10.LastUpdate or 0
            local v12 = if s2 ~= "Bone" then false else true
            local v13 = if not v12 then u4.CFrame else u4.WorldCFrame
            local v14 = (Position - v13.Position).Magnitude / RenderDistance
            local v15 = v14 * v14

            if v7 * v15 + MaxRefreshRate >= clock - v11 + 1 / math.random(60, 120) then
                return
            end

            v10.LastUpdate = clock
            v6 += 1
            local Settings = v10.Settings
            local v16 = Settings.WindDirection or WindDirection

            if v16.Magnitude < 1E-05 then
                return
            end

            local v18 = (Settings.WindPower or WindPower) * 0.2

            if v18 < 1E-05 then
                return
            end

            local v20 = clock * ((Settings.WindSpeed or WindSpeed) * 0.08)

            if v20 < 1E-05 then
                return
            end

            local Seed = v10.Seed
            local v21 = (math.noise(v20, 0, Seed) + 0.4) * v18
            local v22 = math.clamp(v8 + v15, 0.1, 0.5)
            local v23 = v18 / 3
            local v24 = Settings.PivotOffset
            local Origin = v10.Origin

            if not v24 then
                v24 = CFrame.identity
            end

            local v25 = Origin * v24
            local v26 = v25:VectorToObjectSpace(v16)

            if v12 then
                u4.Transform = u4.Transform:Lerp(
                    CFrame.fromAxisAngle(v26:Cross(Vector3.new(0, 1, 0)), -v21) * CFrame.Angles(
                        math.noise(Seed, 0, v20) * v23,
                        math.noise(Seed, v20, 0) * v23,
                        math.noise(v20, Seed, 0) * v23
                    ) + v26 * v21 * v18,
                    v22
                )

                return
            end

            v9 += 1
            PartList[v9] = u4
            local v32 = CframeList
            local v33 = v9
            local v38 = v25 * CFrame.fromAxisAngle(v26:Cross(Vector3.new(0, 1, 0)), -v21) * CFrame.Angles(
                math.noise(Seed, 0, v20) * v23,
                math.noise(Seed, v20, 0) * v23,
                math.noise(v20, Seed, 0) * v23
            )
            local v35 = Settings.PivotOffsetInverse or CFrame.identity
            v32[v33] = v13:Lerp(v38 * v35 + v16 * v21 * (v18 * 2), v22)
        end)
        t5.Active = v6
        debug.profileend()
        workspace:BulkMoveTo(PartList, CframeList, Enum.BulkMoveMode.FireCFrameChanged)
        debug.profileend()
    end,
    Pause = function(arg1) --[[ Pause ]] -- line: 247
        -- upvalues:
        --  [1] BindableEvent_3 (copy)

        if arg1.UpdateConnection then
            arg1.UpdateConnection:Disconnect()
            arg1.UpdateConnection = nil
        end

        arg1.Active = 0
        arg1.Running = false
        BindableEvent_3:Fire()
    end,
    Resume = function(arg2) --[[ Resume ]] -- line: 259
        -- upvalues:
        --  [1] RunService (copy)
        --  [2] BindableEvent_4 (copy)

        if arg2.Running then
            return
        end

        arg2.Running = true
        arg2.UpdateConnection = arg2:Connect("Update", RunService.Heartbeat)
        BindableEvent_4:Fire()
    end,
    Init = function(t6: table, t7: table) --[[ Init ]] -- line: 272
        -- upvalues:
        --  [1] CollectionService (copy)

        if t6.Initialized then
            return
        end

        local WindPower_1 = script:GetAttribute("WindPower")
        local WindSpeed_1 = script:GetAttribute("WindSpeed")
        local WindDirection_1 = script:GetAttribute("WindDirection")

        if typeof(WindPower_1) ~= "number" then
            script:SetAttribute("WindPower", 0.5)
        end

        if typeof(WindSpeed_1) ~= "number" then
            script:SetAttribute("WindSpeed", 20)
        end

        if typeof(WindDirection_1) ~= "Vector3" then
            script:SetAttribute("WindDirection", Vector3.new(0.5, 0, 0.5))
        end

        t6:Cleanup()
        t6.Initialized = true
        t6.AddedConnection = t6:Connect(
            "AddObjectShake",
            (CollectionService:GetInstanceAddedSignal("WindShake"))
        )
        t6.RemovedConnection = t6:Connect(
            "RemoveObjectShake",
            (CollectionService:GetInstanceRemovedSignal("WindShake"))
        )

        for _, val in CollectionService:GetTagged("WindShake") do
            t6:AddObjectShake(val)
        end

        if t7 and t7.MatchWorkspaceWind then
            t6:MatchWorkspaceWind()
            t6.WorkspaceWindConnection = workspace:GetPropertyChangedSignal("GlobalWind"):Connect(
                function() -- line: 312
                    -- upvalues:
                    --  [1] t6 (copy)

                    t6:MatchWorkspaceWind()
                end
            )
        end

        t6:Resume()
    end,
    Cleanup = function(arg3) --[[ Cleanup ]] -- line: 321
        if not arg3.Initialized then
            return
        end

        arg3:Pause()

        if arg3.AddedConnection then
            arg3.AddedConnection:Disconnect()
            arg3.AddedConnection = nil
        end

        if arg3.RemovedConnection then
            arg3.RemovedConnection:Disconnect()
            arg3.RemovedConnection = nil
        end

        if arg3.WorkspaceWindConnection then
            arg3.WorkspaceWindConnection:Disconnect()
            arg3.WorkspaceWindConnection = nil
        end

        table.clear(arg3.ObjectMetadata)
        arg3.VectorMap:ClearAll()
        arg3.Handled = 0
        arg3.Active = 0
        arg3.Initialized = false
    end,
    UpdateObjectSettings = function(t8: table, u5: userdata, t9: table) --[[ UpdateObjectSettings ]] -- line: 351
        -- upvalues:
        --  [1] BindableEvent_2 (copy)

        if typeof(u5) ~= "Instance" then
            return
        end

        if typeof(t9) ~= "table" then
            return
        end

        if not t8.ObjectMetadata[u5] and u5 ~= script then
            return
        end

        for key_1, val_1 in t9 do
            u5:SetAttribute(key_1, val_1)
        end

        BindableEvent_2:Fire(u5)
    end,
    UpdateAllObjectSettings = function(t10: table, t11: table) --[[ UpdateAllObjectSettings ]] -- line: 371
        -- upvalues:
        --  [1] BindableEvent_2 (copy)

        if typeof(t11) ~= "table" then
            return
        end

        for key_2, _ in t10.ObjectMetadata do
            for key_3, val_3 in t11 do
                key_2:SetAttribute(key_3, val_3)
            end

            BindableEvent_2:Fire(key_2)
        end
    end,
    SetDefaultSettings = function(t12: table, t13: table) --[[ SetDefaultSettings ]] -- line: 384
        t12:UpdateObjectSettings(script, t13)
    end,
    MatchWorkspaceWind = function(arg4) --[[ MatchWorkspaceWind ]] -- line: 388
        local GlobalWind_1 = workspace.GlobalWind
        local v40 = 0
        local v41 = 0
        local Magnitude = GlobalWind_1.Magnitude
        local Unit = GlobalWind_1.Unit

        if Magnitude > 0 then
            v41 = if Magnitude > 1 then math.log10(Magnitude) + 0.2 else 0.3
            v40 = if not (Magnitude < 100) then 125 else Magnitude * 1.2 + 5
        end

        arg4:SetDefaultSettings({ WindDirection = Unit, WindSpeed = v40, WindPower = v41 })
    end
}
