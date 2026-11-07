-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo
-- Class: ModuleScript
-- bytes: 8110

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Terrain = workspace:WaitForChild("Terrain")
assert(Terrain, "No terrain object found under workspace...")
local v1 = Terrain:FindFirstChild("AOTGizmoAdornment")
local v2 = Terrain:FindFirstChild("GizmoAdornment")

if not v1 then
    v1 = Instance.new("WireframeHandleAdornment")
    v1.Adornee = Terrain
    v1.ZIndex = 1
    v1.AlwaysOnTop = true
    v1.Name = "AOTGizmoAdornment"
    v1.Parent = Terrain
end

if not v2 then
    v2 = Instance.new("WireframeHandleAdornment")
    v2.Adornee = Terrain
    v2.ZIndex = 1
    v2.AlwaysOnTop = false
    v2.Name = "GizmoAdornment"
    v2.Parent = Terrain
end

local t = {}
local t_1 = {}
local t_2 = {}
local t_3 = {}
local t_4 = { AlwaysOnTop = true }
local t_5 = {}
local v3 = false

local function Retain(arg1, arg2) -- line: 44
    -- upvalues:
    --  [1] t_1 (copy)

    table.insert(t_1, { arg1, arg2 })
end

local function Register(arg3) -- line: 48
    -- upvalues:
    --  [1] t (ref)

    table.insert(t, arg3)
end

local function Release(arg4) -- line: 52
    -- upvalues:
    --  [1] t_5 (copy)

    local ClassName = arg4.ClassName

    if not t_5[ClassName] then
        t_5[ClassName] = {}
    end

    arg4:Remove()
    table.insert(t_5[ClassName], arg4)
end

local function Request(arg5) -- line: 63
    -- upvalues:
    --  [1] t_5 (copy)

    if not t_5[arg5] then
        return Instance.new(arg5)
    end

    if not t_5[arg5][1] then
        return Instance.new(arg5)
    end

    local v4 = t_5[arg5][1]
    table.remove(t_5[arg5], 1)

    return v4
end

local _ = function(arg6, arg7, arg8) --[[ Lerp ]] -- line: 76
    return arg6 + (arg7 - arg6) * arg8
end

local function deepCopy(arg9) -- line: 80
    -- upvalues:
    --  [1] deepCopy (copy)

    local t_6 = {}

    for key, val in pairs(arg9) do
        if type(val) == "table" then
            val = deepCopy(val)
        end

        t_6[key] = val
    end

    return t_6
end

local t_8 = {
    Enabled = true,
    ActiveRays = 0,
    ActiveInstances = 0,
    Styles = { Color = "Color3", Transparency = "Transparency", AlwaysOnTop = "AlwaysOnTop" },
    AOTWireframeHandle = v1,
    WireframeHandle = v2,
    GetPoolSize = function() --[[ GetPoolSize ]] -- line: 472
        -- upvalues:
        --  [1] t_5 (copy)

        local v5 = 0

        for _, val_1 in t_5 do
            v5 += #val_1
        end

        return v5
    end
}

function t_8.PushProperty(arg10, arg11) -- line: 482
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] v1 (ref)
    --  [3] v2 (ref)

    t_4[arg10] = arg11

    if arg10 == "AlwaysOnTop" then
        return
    end

    pcall(function() -- line: 489
        -- upvalues:
        --  [1] v1 (ref)
        --  [2] arg10 (copy)
        --  [3] arg11 (copy)
        --  [4] v2 (ref)

        v1[arg10] = arg11
        v2[arg10] = arg11
    end)
end

function t_8.PopProperty(arg12) -- line: 495
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] v1 (ref)

    if t_4[arg12] then
        return t_4[arg12]
    end

    return v1[arg12]
end

local Gizmos = script:WaitForChild("Gizmos")

function t_8.SetStyle(arg13, arg14, arg15) -- line: 503
    -- upvalues:
    --  [1] t_8 (copy)

    if arg13 and typeof(arg13) == "Color3" then
        t_8.PushProperty("Color3", arg13)
    end

    if arg14 and typeof(arg14) == "number" then
        t_8.PushProperty("Transparency", arg14)
    end

    if arg15 and typeof(arg15) == "boolean" then
        t_8.PushProperty("AlwaysOnTop", arg15)
    end
end

function t_8.DoCleaning() -- line: 517
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v2 (ref)
    --  [3] t (ref)
    --  [4] t_5 (copy)
    --  [5] t_8 (copy)

    v1:Clear()
    v2:Clear()

    for _, val_2 in t do
        local ClassName_1 = val_2.ClassName

        if not t_5[ClassName_1] then
            t_5[ClassName_1] = {}
        end

        val_2:Remove()
        table.insert(t_5[ClassName_1], val_2)
    end

    t = {}
    t_8.ActiveRays = 0
    t_8.ActiveInstances = 0
end

function t_8.ScheduleCleaning() -- line: 531
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] t_8 (copy)

    if v3 then
        return
    end

    v3 = true
    task.delay(0, function() -- line: 538
        -- upvalues:
        --  [1] t_8 (ref)
        --  [2] v3 (ref)

        t_8.DoCleaning()
        v3 = false
    end)
end

function t_8.AddDebrisInSeconds(n1: number, arg16: any) -- line: 545
    -- upvalues:
    --  [1] t_2 (copy)

    local v6 = t_2
    local t_9 = { "Seconds", n1, os.clock(), arg16 }
    table.insert(v6, t_9)
end

function t_8.AddDebrisInFrames(n2: number, arg17: any) -- line: 549
    -- upvalues:
    --  [1] t_2 (copy)

    table.insert(t_2, { "Frames", n2, 0, arg17 })
end

function t_8.TweenProperties(t1: table, t2: table, u1: userdata) -- line: 553
    -- upvalues:
    --  [1] deepCopy (copy)
    --  [2] t_3 (copy)

    local t_10 = {
        p_Properties = t1,
        Properties = deepCopy(t1),
        Goal = t2,
        TweenInfo = u1,
        Time = 0
    }
    table.insert(t_3, t_10)
    local v8 = #t_3

    return function() -- line: 567
        -- upvalues:
        --  [1] t_3 (ref)
        --  [2] v8 (copy)

        table.remove(t_3, v8)
    end
end

function t_8.Init() -- line: 572
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] t_3 (copy)
    --  [3] TweenService (copy)
    --  [4] t_2 (copy)
    --  [5] t_1 (copy)

    RunService.RenderStepped:Connect(function(deltaTime) -- line: 573
        -- upvalues:
        --  [1] t_3 (ref)
        --  [2] TweenService (ref)
        --  [3] t_2 (ref)
        --  [4] t_1 (ref)

        local v12

        for key_3, val_3 in t_3 do
            val_3.Time += deltaTime
            local v9 = val_3.Time / val_3.TweenInfo.Time
            v9 = if not (v9 > 1) then v9 else 1

            local _ = function(arg19, arg20, arg21) --[[ LerpProperty ]] -- line: 582
                if type(arg19) == "number" then
                    return arg19 + (arg20 - arg19) * arg21
                end

                return arg19:Lerp(arg20, arg21)
            end

            for key_4, val_4 in val_3.Properties do
                if val_3.Goal[key_4] then
                    local v10 = TweenService:GetValue(
                        v9,
                        val_3.TweenInfo.EasingStyle,
                        val_3.TweenInfo.EasingDirection
                    )
                    local v11 = val_3.Goal[key_4]

                    if type(val_4) == "number" then
                        v12 = val_4 + (v11 - val_4) * v10
                    else
                        local _ = val_3.Goal
                        v12 = val_4:Lerp(v11, v10)
                    end

                    val_3.p_Properties[key_4] = v12
                end
            end

            if v9 == 1 then
                table.remove(t_3, key_3)
            end
        end

        for key_5, val_5 in t_2 do
            local v13 = val_5[2]
            local v14 = val_5[3]
            local v15 = val_5[4]

            if val_5[1] == "Seconds" then
                if v13 < os.clock() - v14 then
                    table.remove(t_2, key_5)
                else
                    v15()
                end
            elseif v13 < v14 then
                table.remove(t_2, key_5)
            else
                val_5[2] = val_5[2] + 1
                v15()
            end
        end

        for key_6, val_6 in t_1 do
            local v16 = val_6[2]

            if v16.Enabled then
                if v16.Destroy then
                    table.remove(t_1, key_6)
                end

                val_6[1]:Update(v16)
            end
        end
    end)
end

function t_8.SetEnabled(arg22) -- line: 649
    -- upvalues:
    --  [1] t_8 (copy)

    t_8.Enabled = arg22

    if arg22 == false then
        t_8.DoCleaning()
    end
end

for _, child in Gizmos:GetChildren() do
    t_8[child.Name] = require(child).Init(
        t_8,
        t_4,
        Request,
        Release,
        Retain,
        Register
    )
end

return t_8
