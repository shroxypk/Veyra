-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Slider.Utils.SliderFuncs
-- Class: ModuleScript
-- bytes: 1849

local t = {
    snapToScale = function(n1: number, n2: number) --[[ snapToScale ]] -- line: 3
        return (math.clamp(math.round(n1 / n2) * n2, 0, 1))
    end
}

function lerp(n3: number, n4: number, n5: number) -- line: 7
    return (1 - n5) * n3 + n5 * n4
end

function t.map(
    n6: number,
    n7: number,
    n8: number,
    n9: number,
    n10: number,
    b1: boolean
) -- line: 11
    -- upvalues:
    --  [1] t (copy)

    local v2 = lerp(n9, n10, t.getAlphaBetween(n7, n8, n6))

    if not b1 then
        return v2
    end

    if n9 < n10 then
        n10, n9 = n9, n10
    end

    return (math.max(math.min(v2, n9), n10))
end

function t.getNewPosition(arg1) -- line: 24
    -- upvalues:
    --  [1] t (copy)

    local v4 = arg1._data.Button.AbsoluteSize[arg1._config.Axis]
    local v5 = arg1._holder.AbsoluteSize[arg1._config.Axis]
    local v6 = arg1._data.Button.AnchorPoint[arg1._config.Axis]
    local v7 = v6 * v4 / v5 + arg1._config.Padding / v5
    local v8 = t.map(
        arg1._data._percent,
        0,
        1,
        v7,
        1 - v7 + (2 * v4 * v6 - v4) / v5,
        true
    )

    if arg1._config.Axis == "X" then
        return (UDim2.fromScale(v8, arg1._data.Button.Position.Y.Scale))
    end

    return (UDim2.fromScale(arg1._data.Button.Position.X.Scale, v8))
end

function t.getScaleIncrement(arg2) -- line: 43
    return 1 / ((arg2._config.SliderData.End - arg2._config.SliderData.Start) / arg2._config.SliderData.Increment)
end

function t.getAlphaBetween(n11: number, n12: number, n13: number) -- line: 47
    return (n13 - n11) / (n12 - n11)
end

function t.getNewValue(arg3) -- line: 51
    local v9 = lerp(arg3._config.SliderData.Start, arg3._config.SliderData.End, arg3._data._percent)
    local v10 = 1 / arg3._config.SliderData.Increment

    return math.round(v9 * v10) / v10
end

return t
