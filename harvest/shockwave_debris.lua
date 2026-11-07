-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.shockwave_debris
-- Class: ModuleScript
-- bytes: 11571

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local PkgPromise_m = require("../pkg/Promise")
local _ = require("../obj/ObjectCache")
local rng = Random.new()
local t = {}
local t_1 = {}
local v1 = nil
local v2 = nil

function t.init(arg1) -- line: 20
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] v1 (ref)
    --  [3] ModUtility_m (copy)
    --  [4] RunService (copy)
    --  [5] t_1 (copy)

    if v2 then
        return
    end

    v1 = arg1

    if ModUtility_m.PLUGIN_CONTEXT then
        v2 = RunService.RenderStepped:Connect(function(deltaTime) -- line: 28
            -- upvalues:
            --  [1] t_1 (ref)

            if #t_1 == 0 then
                return
            end

            workspace:StepPhysics(deltaTime, t_1)
        end)
    end
end

function t.deinit() -- line: 38
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] v1 (ref)
    --  [3] t_1 (copy)

    if v2 then
        v2:Disconnect()
        v2 = nil
    end

    v1 = nil

    for _, val in t_1 do
        val:Destroy()
    end

    table.clear(t_1)
end

function t.emit(u1: userdata, u2: userdata, arg3: any) -- line: 53
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] ModAttributes_m (copy)
    --  [3] CollectionService (copy)
    --  [4] rng (copy)
    --  [5] ModUtility_m (copy)
    --  [6] t_1 (copy)
    --  [7] ModTween_m (copy)
    --  [8] PkgPromise_m (copy)

    if not v1 then
        return
    end

    local overlapParams = nil
    local v4 = ModAttributes_m.get(u2, "InheritanceEnabled", true)
    local v5 = ModAttributes_m.get(u2, "InheritanceRadius", 5)
    local v6 = ModAttributes_m.get(u1, "RayCollisionGroup", "Default")
    local v7 = ModAttributes_m.get(u1, "FilterTag", "")
    local v8 = ModAttributes_m.get(u1, "FilterType", "Exclude")
    local v9 = ModAttributes_m.get(u1, "IgnoreCanCollide", false)

    if v4 then
        local v10 = ModAttributes_m.get(u2, "InheritanceMaxResults", 5)
        overlapParams = OverlapParams.new()
        overlapParams.MaxParts = v10
        overlapParams.CollisionGroup = v6
        overlapParams.RespectCanCollide = not v9
        overlapParams.FilterType = Enum.RaycastFilterType[v8]
        overlapParams.FilterDescendantsInstances = CollectionService:GetTagged(v7)

        if v8 == "Exclude" then
            overlapParams:AddToFilter({ workspace.Terrain })
        end
    end

    local v11 = ModAttributes_m.get(u2, "EmitDelay", 0)
    local Amount = ModAttributes_m.getRange(
        u2,
        "Amount",
        NumberRange.new(5, 10),
        NumberRange.new(0, math.huge)
    )
    local Lifetime = ModAttributes_m.getRange(
        u2,
        "Lifetime",
        NumberRange.new(2, 3),
        NumberRange.new(0, math.huge)
    )
    local Airtime = ModAttributes_m.getRange(
        u2,
        "Airtime",
        NumberRange.new(0.5, 0.5),
        NumberRange.new(0, math.huge)
    )
    local LinearMagnitude = ModAttributes_m.getRange(u2, "LinearMagnitude", NumberRange.new(15, 25))
    local AngularMagnitude = ModAttributes_m.getRange(
        u2,
        "AngularMagnitude",
        NumberRange.new(5, 15)
    )
    local v17 = ModAttributes_m.get(u2, "SizeScaleEnd", Vector3.new(0, 0, 0))
    local v18 = ModAttributes_m.get(u2, "MinSize", Vector3.new(2, 1, 2))
    local v19 = ModAttributes_m.get(u2, "MaxSize", Vector3.new(3, 2, 3))
    local v20 = ModAttributes_m.get(u2, "MinDirection", Vector3.new(-1, -1, -1))
    local v21 = ModAttributes_m.get(u2, "MaxDirection", Vector3.new(1, 1, 1))
    local v22 = rng:NextInteger(Amount.Min, Amount.Max)
    local v23 = ModAttributes_m.get(u2, "Size_Curve", ModUtility_m.default_bezier)
    local v24 = ModAttributes_m.get(u2, "Transparency_Curve", ModUtility_m.default_bezier)
    local v25 = ModAttributes_m.get(u2, "Transparency_Duration", 0.5)
    local v26 = ModAttributes_m.get(u2, "Size_Duration", 0.5)
    local v27 = ModAttributes_m.get(u2, "Transparency_Start", 0)
    local v28 = ModAttributes_m.get(u2, "Transparency_End", 1)
    local t_2 = {}
    local t_3 = {}
    u2.CanCollide = false
    local v29 = ModUtility_m.getTransformedOriginExtents(u1)
    local Position = v29.Position
    local v30

    if overlapParams then
        for _, val_1 in (workspace:GetPartBoundsInRadius(Position, v5, overlapParams)) do
            if val_1.Transparency ~= 1 then
                v30 = table.insert
                v30(t_2, val_1)
            end
        end
    end

    task.wait(v11)
    local v37

    for _ = 1, v22 do
        v11 = false

        if #t_2 ~= 0 then
            v30 = #t_2
            v11 = t_2[rng:NextInteger(1, v30)]
        end

        local v31 = ModUtility_m.getRandomId()
        local v32 = v1:get(v31)
        local v33 = v32._getReal()
        v30 = v33
        ModUtility_m.copyProperties(u2, v30, ModUtility_m.COPY_PART_PROPERTIES)
        v30 = v33
        ModUtility_m.copyProperties(u2, v30, ModUtility_m.COPY_EXTENDED_PART_PROPERTIES)

        if #u2:GetChildren() ~= 0 then
            local v34 = u2:Clone()

            for _, child in v34:GetChildren() do
                child.Parent = v33
            end

            v34:Destroy()
        end

        v30 = arg3
        local v35 = arg3.effects.prepareEmitOnFinish(v33, v30)
        v30 = v33
        local v36 = arg3.effects.prepareEmitFolder(v30, "EmitOnImpact", arg3)

        if v36 then
            v30 = #v36:GetChildren()

            if v30 > 0 then
                v30 = nil
                v30 = v33.Touched:Connect(function(otherPart) -- line: 162
                    -- upvalues:
                    --  [1] v9 (copy)
                    --  [2] v33 (copy)
                    --  [3] v8 (copy)
                    --  [4] v7 (copy)
                    --  [5] v30 (ref)
                    --  [6] arg3 (copy)
                    --  [7] v36 (copy)
                    --  [8] t_3 (copy)

                    if not v9 then
                        if otherPart:CanCollideWith(v33) then
                            if not otherPart:IsDescendantOf(workspace.Terrain) then
                                if v8 == "Exclude" and otherPart:HasTag(v7) then
                                    return
                                end

                                v30:Disconnect()
                                table.insert(
                                    t_3,
                                    arg3.effects.emitFromFolder(v36, v33, arg3.depth + 1, arg3).Finished
                                )

                                return
                            end

                            return
                        else
                            return
                        end
                    else
                        if not otherPart:IsDescendantOf(workspace.Terrain) then
                            if v8 == "Exclude" and otherPart:HasTag(v7) then
                                return
                            end

                            v30:Disconnect()
                            table.insert(
                                t_3,
                                arg3.effects.emitFromFolder(v36, v33, arg3.depth + 1, arg3).Finished
                            )

                            return
                        end

                        return
                    end
                end)
                table.insert(arg3, function() -- line: 177
                    -- upvalues:
                    --  [1] v30 (ref)

                    if v30 then
                        v30:Disconnect()
                        v30 = nil
                    end
                end)
            end
        end

        v37 = false
        v32.Anchored = v37
        v37 = true
        v32.CanCollide = v37
        v37 = v32.CollisionGroup

        if v37 == "Default" then
            v37 = "ForgeDebris"
            v32.CollisionGroup = v37
        end

        v37 = CFrame.new(Position)
        v32.CFrame = v37
        local v38 = rng:NextNumber(v18.X, v19.X)
        local v39 = rng:NextNumber(v18.Y, v19.Y)
        v37 = Vector3.new(v38, v39, rng:NextNumber(v18.Z, v19.Z))
        v32.Size = v37

        if v11 then
            v32.Material = v11.Material
            v32.Color = v11.Color
            v32.Transparency = v11.Transparency
        else
            v32.Transparency = v27
        end

        table.insert(arg3, function() -- line: 210
            -- upvalues:
            --  [1] t_1 (ref)
            --  [2] v33 (copy)
            --  [3] v1 (ref)
            --  [4] v31 (copy)

            local v40 = table.find(t_1, v33)

            if v40 then
                table.remove(t_1, v40)
            end

            if v1 then
                v1:free(v31)
            end
        end)
        table.insert(t_1, v33)
        v32.AssemblyLinearVelocity = v29:VectorToWorldSpace(v32.AssemblyLinearVelocity)
        local v41 = v29:VectorToWorldSpace((ModUtility_m.randomUnitVector(v20, v21)))
        v32:ApplyImpulse(
            v32.AssemblyMass * ModUtility_m.getImpulseForce(
                Position,
                Position + v41.Unit * rng:NextNumber(LinearMagnitude.Min, LinearMagnitude.Max),
                rng:NextNumber(Airtime.Min, Airtime.Max)
            )
        )
        v32:ApplyAngularImpulse(
            v32.AssemblyMass * rng:NextUnitVector() * rng:NextNumber(
                AngularMagnitude.Min,
                AngularMagnitude.Max
            )
        )
        table.insert(t_3, arg3.effects.emitNested(v33, arg3.depth + 1, arg3).Finished)
        task.delay(rng:NextNumber(Lifetime.Min, Lifetime.Max), function() -- line: 243
            -- upvalues:
            --  [1] v32 (copy)
            --  [2] v37 (copy)
            --  [3] v17 (copy)
            --  [4] arg3 (copy)
            --  [5] ModTween_m (ref)
            --  [6] v23 (copy)
            --  [7] v26 (copy)
            --  [8] v28 (copy)
            --  [9] v24 (copy)
            --  [10] v25 (copy)
            --  [11] ModUtility_m (ref)
            --  [12] v35 (copy)
            --  [13] v33 (copy)
            --  [14] t_3 (copy)

            local Size = v32.Size
            local Transparency_1 = v32.Transparency

            if Size ~= v37 * v17 then
                table.insert(arg3, ModTween_m.fromParams(v23, v26, function(arg5, arg6) -- line: 250
                    -- upvalues:
                    --  [1] v32 (ref)
                    --  [2] Size (copy)
                    --  [3] v37 (ref)
                    --  [4] v17 (ref)

                    v32.Size = Size:Lerp(v37 * v17, arg5)

                    return arg6
                end))
            end

            if Transparency_1 ~= v28 then
                table.insert(arg3, ModTween_m.fromParams(v24, v25, function(arg7, arg8) -- line: 260
                    -- upvalues:
                    --  [1] v32 (ref)
                    --  [2] ModUtility_m (ref)
                    --  [3] Transparency_1 (copy)
                    --  [4] v28 (ref)

                    v32.Transparency = ModUtility_m.lerp(Transparency_1, v28, arg7)

                    return arg8
                end))
            end

            table.insert(t_3, arg3.effects.emitOnFinish(v35, v33, arg3.depth + 1, arg3).Finished)
        end)
    end

    task.wait(Lifetime.Max + math.max(v25, v26))
    PkgPromise_m.all(t_3):await()
end

return t
