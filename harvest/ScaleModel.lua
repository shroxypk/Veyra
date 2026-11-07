-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ScaleModel
-- Class: ModuleScript
-- bytes: 873

local _ = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local function tweenScale(u1: userdata, n1: number, u2: userdata) -- line: 5
    -- upvalues:
    --  [1] TweenService (copy)

    if not u1 then
        return
    end

    local NumberValue = Instance.new("NumberValue")
    NumberValue.Value = u1:GetScale()
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- line: 13
        -- upvalues:
        --  [1] u1 (copy)
        --  [2] NumberValue (copy)

        u1:ScaleTo(NumberValue.Value)
    end)
    local v1 = TweenService:Create(NumberValue, u2, { Value = n1 })
    v1.Completed:Once(function() -- line: 18
        -- upvalues:
        --  [1] NumberValue (copy)

        NumberValue:Destroy()
    end)
    v1:Play()

    return v1
end

return tweenScale
