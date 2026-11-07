-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.WindShakeController.WindShake.Settings
-- Class: ModuleScript
-- bytes: 2882

return {
    new = function(u1: userdata) --[[ new ]] -- line: 10
        local t_1 = {}
        local WindPower = u1:GetAttribute("WindPower")
        local WindSpeed = u1:GetAttribute("WindSpeed")
        local WindDirection = u1:GetAttribute("WindDirection")
        local v1 = if typeof(WindPower) == "number" then WindPower else nil
        t_1.WindPower = v1
        t_1.WindSpeed = if typeof(WindSpeed) == "number" then WindSpeed else nil
        t_1.WindDirection = if typeof(WindDirection) == "Vector3" then if WindDirection.Magnitude > 0 then WindDirection.Unit else Vector3.new(0, 0, 0) else nil
        t_1.PivotOffset = if u1:IsA("BasePart") then u1.PivotOffset else nil
        t_1.PivotOffsetInverse = if typeof(t_1.PivotOffset) == "CFrame" then t_1.PivotOffset:Inverse() else nil
        v1 = u1:GetAttributeChangedSignal("WindPower"):Connect(function() -- line: 30
            -- upvalues:
            --  [1] WindPower (ref)
            --  [2] u1 (copy)
            --  [3] t_1 (copy)

            WindPower = u1:GetAttribute("WindPower")
            t_1.WindPower = if typeof(WindPower) == "number" then WindPower else nil
        end)
        local WindSpeed_1 = u1:GetAttributeChangedSignal("WindSpeed"):Connect(function() -- line: 35
            -- upvalues:
            --  [1] WindSpeed (ref)
            --  [2] u1 (copy)
            --  [3] t_1 (copy)

            WindSpeed = u1:GetAttribute("WindSpeed")
            t_1.WindSpeed = if typeof(WindSpeed) == "number" then WindSpeed else nil
        end)
        local WindDirection_1 = u1:GetAttributeChangedSignal("WindDirection"):Connect(function() -- line: 40
            -- upvalues:
            --  [1] WindDirection (ref)
            --  [2] u1 (copy)
            --  [3] t_1 (copy)

            WindDirection = u1:GetAttribute("WindDirection")
            t_1.WindDirection = if typeof(WindDirection) == "Vector3" then if WindDirection.Magnitude > 0 then WindDirection.Unit else Vector3.new(0, 0, 0) else nil
        end)
        local v8 = if u1:IsA("BasePart") then u1:GetPropertyChangedSignal("PivotOffset"):Connect(
            function() -- line: 49
                -- upvalues:
                --  [1] t_1 (copy)
                --  [2] u1 (copy)

                t_1.PivotOffset = u1.PivotOffset
                t_1.PivotOffsetInverse = t_1.PivotOffset:Inverse()
            end
        ) else nil

        function t_1.Destroy(_) -- line: 57
            -- upvalues:
            --  [1] v1 (copy)
            --  [2] WindSpeed_1 (copy)
            --  [3] WindDirection_1 (copy)
            --  [4] v8 (ref)
            --  [5] t_1 (copy)

            v1:Disconnect()
            WindSpeed_1:Disconnect()
            WindDirection_1:Disconnect()

            if v8 then
                v8:Disconnect()
            end

            table.clear(t_1)
        end

        return t_1
    end
}
