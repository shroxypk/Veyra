-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.ZoomController
-- Class: ModuleScript
-- bytes: 3475

local Popper_m = require(script:WaitForChild("Popper"))
local math_clamp = math.clamp
local math_exp = math.exp
local math_min = math.min
local math_max = math.max
local LocalPlayer = game:GetService("Players").LocalPlayer
assert(LocalPlayer)
local CameraMinZoomDistance = nil
local CameraMaxZoomDistance = nil

local function updateBounds() -- line: 23
    -- upvalues:
    --  [1] CameraMinZoomDistance (ref)
    --  [2] LocalPlayer (copy)
    --  [3] CameraMaxZoomDistance (ref)

    CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
    CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
end

CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(updateBounds)
LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(updateBounds)
local t = {}
t.__index = t

function t.new(n1: number, n2: number, n3: number, n4: number) -- line: 37
    -- upvalues:
    --  [1] math_clamp (copy)
    --  [2] t (copy)

    n2 = math_clamp(n2, n3, n4)

    return (setmetatable({ freq = n1, x = n2, v = 0, minValue = n3, maxValue = n4, goal = n2 }, t))
end

function t.Step(t1: table, n5: number) -- line: 49
    -- upvalues:
    --  [1] math_exp (copy)

    local v4 = t1.freq * 2 * 3.141592653589793
    local V = t1.v
    local MinValue = t1.minValue
    local MaxValue = t1.maxValue
    local v5 = t1.goal
    local v6 = v5 - t1.x
    local v7 = v4 * n5
    local v8 = math_exp(-v7)
    local v9 = v5 + (V * n5 - v6 * (v7 + 1)) * v8
    v5 = ((v6 * v4 - V) * v7 + V) * v8

    if MinValue > v9 then
        v9 = MinValue
        v5 = 0
    elseif MaxValue < v9 then
        v9 = MaxValue
        v5 = 0
    end

    t1.x = v9
    t1.v = v5

    return v9
end

local v10 = t.new(4.5, 12.5, 0.5, CameraMaxZoomDistance)

local _ = function(n6: number, n7: number, n8: number, n9: number) --[[ stepTargetZoom ]] -- line: 87
    -- upvalues:
    --  [1] math_clamp (copy)

    n6 = math_clamp(n6 + n7 * (n6 * 0.0375 + 1), n8, n9)

    if n6 < 1 then
        n6 = n7 <= 0 and n8 or 1
    end

    return n6
end

local v12 = 0
local t_2 = {}

function t_2.Update(n10: number, u1: CFrame, arg1: any) -- line: 98
    -- upvalues:
    --  [1] v10 (copy)
    --  [2] v12 (ref)
    --  [3] CameraMinZoomDistance (ref)
    --  [4] CameraMaxZoomDistance (ref)
    --  [5] math_clamp (copy)
    --  [6] math_max (copy)
    --  [7] Popper_m (copy)
    --  [8] math_min (copy)

    local v13 = math.huge

    if v10.goal > 1 then
        local v14 = v10.goal
        local v15 = v12
        local v16 = CameraMinZoomDistance
        local X = v10.x
        v14 = math_clamp(v14 + v15 * (v14 * 0.0375 + 1), v16, CameraMaxZoomDistance)

        if v14 < 1 then
            v14 = v15 <= 0 and v16 or 1
        end

        local v18 = math_max(X, v14)
        v13 = Popper_m(u1 * CFrame.new(0, 0, 0.5), v18 - 0.5, arg1) + 0.5
    end

    v10.minValue = 0.5
    v10.maxValue = math_min(CameraMaxZoomDistance, v13)

    return v10:Step(n10)
end

function t_2.GetZoomRadius() -- line: 122
    -- upvalues:
    --  [1] v10 (copy)

    return v10.x
end

function t_2.SetZoomParameters(arg2, arg3) -- line: 126
    -- upvalues:
    --  [1] v10 (copy)
    --  [2] v12 (ref)

    v10.goal = arg2
    v12 = arg3
end

function t_2.ReleaseSpring() -- line: 131
    -- upvalues:
    --  [1] v10 (copy)

    v10.x = v10.goal
    v10.v = 0
end

return t_2
