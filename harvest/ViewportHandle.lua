-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ViewportHandle
-- Class: ModuleScript
-- bytes: 3303

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local t = {}
local t_1 = {}
local Tools = ReplicatedStorage.Tools

function t_1.new(arg1, arg2, arg3) -- line: 12
    -- upvalues:
    --  [1] Tools (copy)
    --  [2] t (copy)

    local v1 = Tools:FindFirstChild(arg1)

    if not v1 then
        return
    end

    local v2 = v1:Clone()

    if not v2:IsA("Model") then
        local Model = Instance.new("Model")
        Model.Name = v2.Name
        v2.Parent = Model
        v2 = Model
    end

    local v3 = v2.PrimaryPart or v2:FindFirstChildWhichIsA("BasePart", true)
    v2.PrimaryPart = v3
    v3 = script.ViewportFrame:Clone()
    v3.Name = arg1
    local Camera = Instance.new("Camera")
    Camera.FieldOfView = 1
    Camera.Parent = v3
    v3.CurrentCamera = Camera
    v2.Parent = v3
    v3.Parent = arg2
    local v4, v5 = v2:GetBoundingBox()
    v2 = v4.Position
    local v6 = math.max(v5.X + 0.5, v5.Y + 0.5, v5.Z + 0.5)
    local v8 = math.tan((math.rad(Camera.FieldOfView)))
    local cframe = CFrame.new(v2)
    local cframe_1 = CFrame.new(0, 0, v6 / 2 + v6 / v8)

    local function updateCFrame(arg4) -- line: 55
        -- upvalues:
        --  [1] Camera (copy)
        --  [2] cframe (copy)
        --  [3] cframe_1 (copy)

        Camera.CFrame = cframe * arg4 * cframe_1
    end

    if arg3 then
        local t_5 = {
            { dir = v4.XVector, len = v5.X },
            { dir = v4.YVector, len = v5.Y },
            { dir = v4.ZVector, len = v5.Z }
        }
        table.sort(t_5, function(arg5, arg6) -- line: 65
            return arg5.len > arg6.len
        end)
        local v10 = t_5[1]
        local v11 = t_5[2]
        local v12 = t_5[3]
        local v14 = math.tan((math.rad(Camera.FieldOfView / 2))) * 2

        if v10.len > v11.len * 1.6 then
            local Unit = (v10.dir + v11.dir).Unit
            local Unit_1 = (v10.dir - v11.dir).Unit
            Camera.CFrame = CFrame.fromMatrix(
                v2 + Unit:Cross(Unit_1) * ((v10.len + v11.len) / 1.4142135623730951 * 1.08 / v14 + v12.len),
                Unit,
                Unit_1
            )

            return v3
        end

        local v16 = CFrame.Angles(0, 0.6108652381980153, 0) * CFrame.Angles(
            -0.20943951023931956,
            0,
            0
        )
        local v17 = math.max(v5.X, v5.Y, v5.Z) * 1.05
        Camera.CFrame = cframe * v16 * CFrame.new(0, 0, v17 / v14 + v17)

        return v3
    else
        t[v3] = updateCFrame

        return v3
    end
end

function t_1.Destroy(_, arg8) -- line: 91
    -- upvalues:
    --  [1] t (copy)

    if not arg8 then
        return
    end

    t[arg8] = nil
end

local v19 = 0
RunService.RenderStepped:Connect(function() -- line: 102
    -- upvalues:
    --  [1] v19 (ref)
    --  [2] t (copy)

    local now = tick()

    if now - v19 < 0.1 then
        return
    end

    v19 = now
    local v20 = CFrame.Angles(0, now % 6.283185307179586, 0) * CFrame.Angles(
        -0.03490658503988659,
        0,
        0
    )

    for key, val in t do
        if not key.Parent then
            t[key] = nil
        end

        val(v20)
    end
end)

return t_1
