-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.LightningBolt.LightningSparks
-- Class: ModuleScript
-- bytes: 5037

local Parent_m = require(script.Parent)
local t = {}
local rng = Random.new()
local t_1 = {}
t_1.__index = t_1

function t_1.new(arg1, arg2) -- line: 11
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t (copy)

    local t_2 = setmetatable({}, t_1)
    t_2.Enabled = true
    t_2.LightningBolt = arg1
    t_2.MaxSparkCount = arg2 or 10
    t_2.MinSpeed, t_2.MaxSpeed = 4, 6
    t_2.MinDistance, t_2.MaxDistance = 3, 6
    t_2.MinPartsPerSpark, t_2.MaxPartsPerSpark = 8, 10
    t_2.SparksN = 0
    t_2.SlotTable = {}
    t_2.RefIndex = #t + 1
    t[t_2.RefIndex] = t_2

    return t_2
end

function t_1.Destroy(arg3) -- line: 34
    -- upvalues:
    --  [1] t (copy)

    t[arg3.RefIndex] = nil

    for key, val in pairs(arg3.SlotTable) do
        if val.Parts[1].Parent == nil then
            arg3.SlotTable[key] = nil
        end
    end
end

function RandomVectorOffset(arg4, arg5) -- line: 46
    -- upvalues:
    --  [1] rng (copy)

    local v2 = CFrame.lookAt(Vector3.new(), arg4) * CFrame.Angles(
        0,
        0,
        rng:NextNumber(0, 6.283185307179586)
    )
    local Angles_1 = CFrame.Angles
    local v5 = rng:NextNumber(math.cos(arg5), 1)

    return (v2 * Angles_1(math.acos(v5), 0, 0)).LookVector
end

game:GetService("RunService").Heartbeat:Connect(function() -- line: 50
    -- upvalues:
    --  [1] t (copy)
    --  [2] rng (copy)
    --  [3] Parent_m (copy)

    local v6

    for _, val_1 in pairs(t) do
        if val_1.Enabled == true and val_1.SparksN < val_1.MaxSparkCount then
            local LightningBolt = val_1.LightningBolt

            if LightningBolt.Parts[1].Parent == nil then
                val_1:Destroy()

                return
            end

            local Parts = LightningBolt.Parts
            v6 = #Parts
            local t_3 = {}

            for index = 1, #Parts do
                if Parts[index].Transparency < 0.3 then
                    t_3[#t_3 + 1] = (index - 0.5) / v6
                end
            end

            local v7 = nil
            local v8 = nil

            if #t_3 ~= 0 then
                v7 = math.ceil(t_3[1] * val_1.MaxSparkCount)
                v8 = math.ceil(t_3[#t_3] * val_1.MaxSparkCount)
            end

            local v9 = val_1.MaxSparkCount - val_1.SparksN

            for _ = 1, rng:NextInteger(1, v9) do
                if #t_3 == 0 then
                    break
                end

                local t_4 = {}

                for index_2 = v7, v8 do
                    local _ = rng:NextInteger(1, v9)

                    if val_1.SlotTable[index_2] == nil then
                        t_4[#t_4 + 1] = index_2
                    end
                end

                if #t_4 ~= 0 then
                    local v12 = t_4[rng:NextInteger(1, #t_4)]
                    local v13 = rng:NextNumber(-0.5, 0.5)
                    local v14 = (v12 - 0.5 + v13) / val_1.MaxSparkCount
                    local v15 = 10
                    local v16 = 1

                    for index_3 = 1, #t_3 do
                        local v17 = math.abs(t_3[index_3] - v14)

                        if v15 > v17 then
                            v15 = v17
                            v16 = math.floor(t_3[index_3] * v6 + 0.5 + 0.5)
                        end
                    end

                    v15 = Parts[v16]
                    local t_5 = {
                        WorldPosition = v15.Position + v13 * v15.CFrame.RightVector * v15.Size.X
                    }
                    local t_6 = {}
                    t_6.WorldPosition = t_5.WorldPosition + RandomVectorOffset(
                        v15.CFrame.RightVector,
                        0.7853981633974483
                    ) * rng:NextNumber(val_1.MinDistance, val_1.MaxDistance)
                    t_5.WorldAxis = (t_6.WorldPosition - t_5.WorldPosition).Unit
                    t_6.WorldAxis = t_5.WorldAxis
                    v16 = Parent_m.new(
                        t_5,
                        t_6,
                        rng:NextInteger(val_1.MinPartsPerSpark, val_1.MaxPartsPerSpark)
                    )
                    v16.MinRadius, v16.MaxRadius = 0, 0.8
                    v16.AnimationSpeed = 0
                    v16.Thickness = v15.Size.Y / 2
                    v16.MinThicknessMultiplier, v16.MaxThicknessMultiplier = 1, 1
                    v16.PulseLength = 0.5
                    v16.PulseSpeed = rng:NextNumber(val_1.MinSpeed, val_1.MaxSpeed)
                    v16.FadeLength = 0.25
                    local color, _, color_ret3 = Color3.toHSV(v15.Color)
                    v16.Color = Color3.fromHSV(color, 0.5, color_ret3)
                    val_1.SlotTable[v12] = v16
                end
            end
        end

        v6 = 0

        for key_2, val_2 in pairs(val_1.SlotTable) do
            if val_2.Parts[1].Parent ~= nil then
                v6 += 1
            else
                val_1.SlotTable[key_2] = nil
            end
        end

        val_1.SparksN = v6
    end
end)

return t_1
