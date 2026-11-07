-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dagon.Singularity_Reckoning_Fx.Bezier
-- Class: ModuleScript
-- bytes: 25560

local t = {}
t.__index = t

function B(n1: number, n2: number, n3: number) -- line: 20
    local function fact(n4: number) -- line: 23
        -- upvalues:
        --  [1] fact (copy)

        if n4 == 0 then
            return 1
        end

        return n4 * fact(n4 - 1)
    end

    local v1 = if n1 ~= 0 then n1 * fact(n1 - 1) else 1
    local v2 = if n2 ~= 0 then n2 * fact(n2 - 1) else 1
    local v3 = n1 - n2

    return v1 / (v2 * (if v3 ~= 0 then v3 * fact(v3 - 1) else 1)) * n3 ^ n2 * (1 - n3) ^ (n1 - n2)
end

function t.new(...) -- line: 38
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.Points = {}
    t_1.LengthIterations = 1000
    t_1.LengthIndeces = {}
    t_1.Length = 0
    t_1._connections = {}

    for _, val in pairs({ ... }) do
        if typeof(val) ~= "Vector3" then
            if typeof(val) == "Instance" then
                if val:IsA("BasePart") then
                    t_1:AddBezierPoint(val)
                else
                    error(
                        "The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!"
                    )
                end
            else
                error(
                    "The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!"
                )
            end
        else
            t_1:AddBezierPoint(val)
            error("The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!")
        end
    end

    return t_1
end

function t.AddBezierPoint(t1: table, arg1: any, n5: number?) -- line: 70
    local _
    local v6, v8

    if arg1 then
        if typeof(arg1) == "Instance" then
            if not arg1:IsA("BasePart") then
                v6 = arg1

                if typeof(v6) == "Vector3" then
                    local t_3 = {
                        Type = if typeof(arg1) == "Vector3" then "StaicPoint" else "BasePartPoint",
                        Point = arg1
                    }

                    if t_3.Type == "BasePartPoint" then
                        _ = nil
                        v8 = arg1.Changed:Connect(function(arg2) -- line: 84
                            -- upvalues:
                            --  [1] t1 (copy)

                            if arg2 == "Position" then
                                t1:UpdateLength()
                            end
                        end)
                        local v10 = arg1.AncestryChanged:Connect(function(_, arg4) -- line: 91
                            -- upvalues:
                            --  [1] t1 (copy)
                            --  [2] t_3 (copy)
                            --  [3] v8 (ref)

                            if arg4 == nil then
                                local v9 = table.find(t1.Points, t_3)

                                if v9 then
                                    table.remove(t1.Points, v9)
                                end

                                v8:Disconnect()
                                v8:Disconnect()
                            end
                        end)

                        if not t1._connections[arg1] then
                            t1._connections[arg1] = {}
                        end

                        table.insert(t1._connections[arg1], v8)
                        table.insert(t1._connections[arg1], v10)
                    end

                    if n5 then
                        if type(n5) == "number" then
                            table.insert(t1.Points, n5, t_3)
                        elseif not n5 then
                            table.insert(t1.Points, t_3)
                        elseif type(n5) ~= "number" then
                            error(
                                "Bezier:AddBezierPoint() only accepts an integer as the second argument!"
                            )
                        end
                    elseif not n5 then
                        table.insert(t1.Points, t_3)
                    elseif type(n5) ~= "number" then
                        error(
                            "Bezier:AddBezierPoint() only accepts an integer as the second argument!"
                        )
                    end

                    t1:UpdateLength()

                    return
                end

                error(
                    "Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!"
                )

                return
            else
                local t_4 = {
                    Type = if typeof(arg1) == "Vector3" then "StaicPoint" else "BasePartPoint",
                    Point = arg1
                }

                if t_4.Type == "BasePartPoint" then
                    _ = nil
                    v8 = arg1.Changed:Connect(function(arg5) -- line: 84
                        -- upvalues:
                        --  [1] t1 (copy)

                        if arg5 == "Position" then
                            t1:UpdateLength()
                        end
                    end)
                    local v13 = arg1.AncestryChanged:Connect(function(_, arg7) -- line: 91
                        -- upvalues:
                        --  [1] t1 (copy)
                        --  [2] t_4 (copy)
                        --  [3] v8 (ref)

                        if arg7 == nil then
                            local v12 = table.find(t1.Points, t_4)

                            if v12 then
                                table.remove(t1.Points, v12)
                            end

                            v8:Disconnect()
                            v8:Disconnect()
                        end
                    end)

                    if not t1._connections[arg1] then
                        t1._connections[arg1] = {}
                    end

                    table.insert(t1._connections[arg1], v8)
                    table.insert(t1._connections[arg1], v13)
                end

                if n5 then
                    if type(n5) == "number" then
                        table.insert(t1.Points, n5, t_4)
                    elseif not n5 then
                        table.insert(t1.Points, t_4)
                    elseif type(n5) ~= "number" then
                        error(
                            "Bezier:AddBezierPoint() only accepts an integer as the second argument!"
                        )
                    end
                elseif not n5 then
                    table.insert(t1.Points, t_4)
                elseif type(n5) ~= "number" then
                    error("Bezier:AddBezierPoint() only accepts an integer as the second argument!")
                end

                t1:UpdateLength()

                return
            end
        else
            v6 = arg1

            if typeof(v6) == "Vector3" then
                local t_5 = {
                    Type = if typeof(arg1) == "Vector3" then "StaicPoint" else "BasePartPoint",
                    Point = arg1
                }

                if t_5.Type == "BasePartPoint" then
                    _ = nil
                    v8 = arg1.Changed:Connect(function(arg8) -- line: 84
                        -- upvalues:
                        --  [1] t1 (copy)

                        if arg8 == "Position" then
                            t1:UpdateLength()
                        end
                    end)
                    local v15 = arg1.AncestryChanged:Connect(function(_, arg10) -- line: 91
                        -- upvalues:
                        --  [1] t1 (copy)
                        --  [2] t_5 (copy)
                        --  [3] v8 (ref)

                        if arg10 == nil then
                            local v14 = table.find(t1.Points, t_5)

                            if v14 then
                                table.remove(t1.Points, v14)
                            end

                            v8:Disconnect()
                            v8:Disconnect()
                        end
                    end)

                    if not t1._connections[arg1] then
                        t1._connections[arg1] = {}
                    end

                    table.insert(t1._connections[arg1], v8)
                    table.insert(t1._connections[arg1], v15)
                end

                if n5 then
                    if type(n5) == "number" then
                        table.insert(t1.Points, n5, t_5)
                    elseif not n5 then
                        table.insert(t1.Points, t_5)
                    elseif type(n5) ~= "number" then
                        error(
                            "Bezier:AddBezierPoint() only accepts an integer as the second argument!"
                        )
                    end
                elseif not n5 then
                    table.insert(t1.Points, t_5)
                elseif type(n5) ~= "number" then
                    error("Bezier:AddBezierPoint() only accepts an integer as the second argument!")
                end

                t1:UpdateLength()

                return
            end

            error(
                "Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!"
            )

            return
        end
    else
        v6 = arg1

        if typeof(v6) == "Vector3" then
            local t_6 = {
                Type = if typeof(arg1) == "Vector3" then "StaicPoint" else "BasePartPoint",
                Point = arg1
            }

            if t_6.Type == "BasePartPoint" then
                _ = nil
                v8 = arg1.Changed:Connect(function(arg11) -- line: 84
                    -- upvalues:
                    --  [1] t1 (copy)

                    if arg11 == "Position" then
                        t1:UpdateLength()
                    end
                end)
                local v17 = arg1.AncestryChanged:Connect(function(_, arg13) -- line: 91
                    -- upvalues:
                    --  [1] t1 (copy)
                    --  [2] t_6 (copy)
                    --  [3] v8 (ref)

                    if arg13 == nil then
                        local v16 = table.find(t1.Points, t_6)

                        if v16 then
                            table.remove(t1.Points, v16)
                        end

                        v8:Disconnect()
                        v8:Disconnect()
                    end
                end)

                if not t1._connections[arg1] then
                    t1._connections[arg1] = {}
                end

                table.insert(t1._connections[arg1], v8)
                table.insert(t1._connections[arg1], v17)
            end

            if n5 then
                if type(n5) == "number" then
                    table.insert(t1.Points, n5, t_6)
                elseif not n5 then
                    table.insert(t1.Points, t_6)
                elseif type(n5) ~= "number" then
                    error("Bezier:AddBezierPoint() only accepts an integer as the second argument!")
                end
            elseif not n5 then
                table.insert(t1.Points, t_6)
            elseif type(n5) ~= "number" then
                error("Bezier:AddBezierPoint() only accepts an integer as the second argument!")
            end

            t1:UpdateLength()

            return
        end

        error("Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!")

        return
    end
end

function t.ChangeBezierPoint(t2: table, n6: number, arg14: any) -- line: 137
    if type(n6) ~= "number" then
        error("Bezier:ChangeBezierPoint() only accepts a number index as the first argument!")
    end

    local v18

    if arg14 then
        if typeof(arg14) == "Instance" then
            if not arg14:IsA("BasePart") then
                if typeof(arg14) == "Vector3" then
                    v18 = t2.Points[n6]

                    if v18 then
                        v18.Type = if typeof(arg14) == "Vector3" then "StaicPoint" else "BasePartPoint"
                        v18.Point = arg14
                        t2:UpdateLength()

                        return
                    end

                    error("Did not find BezierPoint at index " .. tostring(n6))

                    return
                else
                    error(
                        "Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!"
                    )

                    return
                end
            else
                v18 = t2.Points[n6]

                if v18 then
                    v18.Type = if typeof(arg14) == "Vector3" then "StaicPoint" else "BasePartPoint"
                    v18.Point = arg14
                    t2:UpdateLength()

                    return
                end

                error("Did not find BezierPoint at index " .. tostring(n6))

                return
            end
        elseif typeof(arg14) == "Vector3" then
            v18 = t2.Points[n6]

            if v18 then
                v18.Type = if typeof(arg14) == "Vector3" then "StaicPoint" else "BasePartPoint"
                v18.Point = arg14
                t2:UpdateLength()

                return
            end

            error("Did not find BezierPoint at index " .. tostring(n6))

            return
        else
            error(
                "Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!"
            )

            return
        end
    elseif typeof(arg14) == "Vector3" then
        v18 = t2.Points[n6]

        if v18 then
            v18.Type = if typeof(arg14) == "Vector3" then "StaicPoint" else "BasePartPoint"
            v18.Point = arg14
            t2:UpdateLength()

            return
        end

        error("Did not find BezierPoint at index " .. tostring(n6))

        return
    else
        error(
            "Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!"
        )

        return
    end
end

function t.GetAllPoints(arg15) -- line: 171
    local t_7 = {}

    for index = 1, #arg15.Points do
        local _ = #arg15.Points
        table.insert(t_7, arg15:GetPoint(index))
    end

    return t_7
end

function t.GetPoint(t3: table, n7: number) -- line: 189
    local Points = t3.Points

    if Points[n7] then
        local v21 = Points[n7].Point

        if typeof(Points[n7].Point) ~= "Vector3" or not v21 then
            v21 = Points[n7].Point.Position
        end

        return v21
    end

    error("Did not find a BezierPoint at index " .. tostring(n7) .. "!")
end

function t.RemoveBezierPoint(t4: table, n8: number) -- line: 202
    if t4.Points[n8] then
        local v22 = table.remove(t4.Points, n8)

        if typeof(v22.Point) == "Instance" and v22.Point:IsA("BasePart") then
            for _, val_1 in pairs(t4._connections[v22.Point]) do
                if val_1.Connected then
                    val_1:Disconnect()
                end
            end

            t4._connections[v22.Point] = nil
        end

        t4:UpdateLength()
    end
end

function t.UpdateLength(arg16) -- line: 225
    local v23 = arg16:GetAllPoints()
    local LengthIterations = arg16.LengthIterations

    if #v23 < 2 then
        return 0, { { 0, 0, 0 }, { 0, 0, 0 } }
    end

    v23 = 0
    local t_8 = {}

    for index_1 = 1, LengthIterations do
        local v25 = arg16:CalculateDerivativeAt((index_1 - 1) / (LengthIterations - 1))
        v23 += v25.Magnitude * (1 / LengthIterations)
        table.insert(t_8, { (index_1 - 1) / (LengthIterations - 1), v23, v25 })
    end

    arg16.Length = v23
    arg16.LengthIndeces = t_8
end

function t.CalculatePositionAt(t5: table, n9: number) -- line: 251
    if type(n9) ~= "number" then
        error("Bezier:CalculatePositionAt() only accepts a number, got " .. tostring(n9) .. "!")
    end

    if #t5.Points > 0 then
        local v26 = t5:GetAllPoints()
        local v27 = #v26
        local v28 = Vector3.new()

        for index_2 = 1, v27 do
            v28 += B(v27 - 1, index_2 - 1, n9) * v26[index_2]
        end

        return v28
    end

    error("Bezier:CalculatePositionAt() only works if there is at least 1 BezierPoint!")
end

function t.CalculatePositionRelativeToLength(t6: table, n10: number) -- line: 291
    if type(n10) ~= "number" then
        error(
            "Bezier:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(
                n10
            ) .. "!"
        )
    end

    if #t6.Points > 0 then
        local LengthIndeces = t6.LengthIndeces
        local _ = t6.LengthIterations
        local Length = t6.Length

        if #t6:GetAllPoints() > 1 then
            local v30 = Length * n10
            local v31 = nil
            local v32 = nil

            for key_2, val_2 in ipairs(LengthIndeces) do
                if v30 - val_2[2] <= 0 then
                    v31 = key_2
                    v32 = val_2
                    break
                elseif key_2 == #LengthIndeces then
                    v31 = key_2
                    v32 = val_2
                    break
                end
            end

            local v33, v34

            if LengthIndeces[v31 - 1] then
                v33 = t6:CalculatePositionAt(LengthIndeces[v31 - 1][1])
                v34 = t6:CalculatePositionAt(v32[1])
            else
                v33 = t6:CalculatePositionAt(v32[1])
                v34 = t6:CalculatePositionAt(LengthIndeces[v31 + 1][1])
            end

            return v33 + (v34 - v33) * (1 - (v32[2] - v30) / (v34 - v33).Magnitude)
        end

        return t6:CalculatePositionAt(0)
    else
        error(
            "Bezier:CalculatePositionRelativeToLength() only works if there is at least 1 BezierPoint!"
        )

        return
    end
end

function t.CalculateDerivativeAt(t7: table, n11: number) -- line: 357
    if type(n11) ~= "number" then
        error("Bezier:CalculateDerivativeAt() only accepts a number, got " .. tostring(n11) .. "!")
    end

    if #t7.Points > 1 then
        local v35 = t7:GetAllPoints()
        local v36 = #v35
        local _ = v36 - 1
        local v38 = Vector3.new()

        for index_3 = 1, v36 - 1 do
            v38 += B(v36 - 2, index_3 - 1, n11) * ((v36 - 1) * (v35[index_3 + 1] - v35[index_3]))
        end

        return v38
    end

    error("Bezier:CalculateDerivativeAt() only works if there are at least 2 BezierPoints!")
end

function t.CalculateDerivativeRelativeToLength(t8: table, n12: number) -- line: 400
    if type(n12) ~= "number" then
        error(
            "Bezier:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(
                n12
            ) .. "!"
        )
    end

    if #t8.Points > 1 then
        local LengthIndeces_1 = t8.LengthIndeces
        local _ = t8.LengthIterations
        local Length_1 = t8.Length
        local _ = t8:GetAllPoints()
        local v41 = Length_1 * n12
        local v42 = nil
        local v43 = nil

        for key_3, val_3 in ipairs(LengthIndeces_1) do
            if v41 - val_3[2] <= 0 then
                v42 = key_3
                v43 = val_3
                break
            elseif key_3 == #LengthIndeces_1 then
                v42 = key_3
                v43 = val_3
                break
            end
        end

        local v44, v45

        if LengthIndeces_1[v42 - 1] then
            v44 = t8:CalculateDerivativeAt(LengthIndeces_1[v42 - 1][1])
            v45 = t8:CalculateDerivativeAt(v43[1])
        else
            v44 = t8:CalculateDerivativeAt(v43[1])
            v45 = t8:CalculateDerivativeAt(LengthIndeces_1[v42 + 1][1])
        end

        return v44 + (v45 - v44) * (1 - (v43[2] - v41) / (v45 - v44).Magnitude)
    end

    error(
        "Bezier:CalculateDerivativeRelativeToLength() only works if there are at least 2 BezierPoints!"
    )
end

function t.CreateVector3Tween(
    t9: table,
    arg17: any,
    t10: table,
    u1: userdata,
    b1: boolean?
) -- line: 458
    if #t9.Points == 0 then
        error(
            "Bezier:CreateVector3Tween() only works if there is at least 1 BezierPoint in the Bezier!"
        )
    end

    if typeof(arg17) ~= "Instance" and typeof(arg17) ~= "table" then
        error("Bezier:CreateVector3Tween() requires an Instance or a table as the first argument!")
    end

    if typeof(u1) ~= "TweenInfo" then
        error("Bezier:CreateVector3Tween() requires a TweenInfo object as the third argument!")
    end

    local Success, Result = pcall(function() -- line: 476
        -- upvalues:
        --  [1] t10 (copy)
        --  [2] arg17 (copy)

        for _, val_4 in pairs(t10) do
            if typeof(arg17[val_4]) ~= "Vector3" and typeof(arg17[val_4]) ~= "nil" then
                return false
            end
        end

        return true
    end)

    if Success and Result then
        local TweenService = game:GetService("TweenService")
        local NumberValue = Instance.new("NumberValue")
        local v47 = TweenService:Create(NumberValue, u1, { Value = 1 })
        local v48 = nil
        v47.Changed:Connect(function(arg18) -- line: 493
            -- upvalues:
            --  [1] v47 (copy)
            --  [2] v48 (ref)
            --  [3] NumberValue (copy)
            --  [4] t10 (copy)
            --  [5] arg17 (copy)
            --  [6] b1 (copy)
            --  [7] t9 (copy)

            if arg18 == "PlaybackState" then
                if v47.PlaybackState == Enum.PlaybackState.Playing then
                    v48 = NumberValue.Changed:Connect(function(arg19) -- line: 497
                        -- upvalues:
                        --  [1] t10 (ref)
                        --  [2] arg17 (ref)
                        --  [3] b1 (ref)
                        --  [4] t9 (ref)

                        local _

                        for _, val_5 in pairs(t10) do
                            local v49 = arg17
                            v49[val_5] = b1 and t9:CalculatePositionRelativeToLength(arg19) or t9:CalculatePositionAt(
                                arg19
                            )
                        end
                    end)

                    return
                end

                if v48 then
                    v48:Disconnect()
                    v48 = nil
                end
            end
        end)

        return v47
    end

    error(
        "Bezier:CreateVector3Tween() requires a matching property table with Vector3 or nil property names for the object as the second argument!"
    )
end

function t.CreateCFrameTween(
    t11: table,
    arg20: any,
    t12: table,
    u2: userdata,
    b2: boolean?
) -- line: 519
    if #t11.Points <= 1 then
        error(
            "Bezier:CreateVector3Tween() only works if there are at least 2 BezierPoints in the Bezier!"
        )
    end

    if typeof(arg20) ~= "Instance" and typeof(arg20) ~= "table" then
        error("Bezier:CreateCFrameTween() requires an Instance or a table as the first argument!")
    end

    if typeof(u2) ~= "TweenInfo" then
        error("Bezier:CreateCFrameTween() requires a TweenInfo object as the third argument!")
    end

    local Success_1, Result_1 = pcall(function() -- line: 537
        -- upvalues:
        --  [1] t12 (copy)
        --  [2] arg20 (copy)

        for _, val_6 in pairs(t12) do
            if typeof(arg20[val_6]) ~= "CFrame" and typeof(arg20[val_6]) ~= "nil" then
                return false
            end
        end

        return true
    end)

    if Success_1 and Result_1 then
        local TweenService_1 = game:GetService("TweenService")
        local NumberValue_1 = Instance.new("NumberValue")
        local v52 = TweenService_1:Create(NumberValue_1, u2, { Value = 1 })
        local v53 = nil
        v52.Changed:Connect(function(arg21) -- line: 554
            -- upvalues:
            --  [1] v52 (copy)
            --  [2] v53 (ref)
            --  [3] NumberValue_1 (copy)
            --  [4] t12 (copy)
            --  [5] b2 (copy)
            --  [6] t11 (copy)
            --  [7] arg20 (copy)

            if arg21 == "PlaybackState" then
                if v52.PlaybackState == Enum.PlaybackState.Playing then
                    v53 = NumberValue_1.Changed:Connect(function(arg22) -- line: 558
                        -- upvalues:
                        --  [1] t12 (ref)
                        --  [2] b2 (ref)
                        --  [3] t11 (ref)
                        --  [4] arg20 (ref)

                        for _, val_7 in pairs(t12) do
                            local v54 = b2 and t11:CalculatePositionRelativeToLength(arg22) or t11:CalculatePositionAt(
                                arg22
                            )
                            local v55 = b2 and t11:CalculateDerivativeRelativeToLength(arg22) or t11:CalculateDerivativeAt(
                                arg22
                            )
                            arg20[val_7] = CFrame.new(v54, v54 + v55)
                        end
                    end)

                    return
                end

                if v53 then
                    v53:Disconnect()
                    v53 = nil
                end
            end
        end)

        return v52
    end

    error(
        "Bezier:CreateCFrameTween() requires a matching property table with CFrame or nil property names for the object as the second argument!"
    )
end

return t
