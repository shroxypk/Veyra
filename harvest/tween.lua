-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.tween
-- Class: ModuleScript
-- bytes: 4849

local RunService = game:GetService("RunService")
local Logger_m = require("./logger")
local Utility_m = require("./utility")
local ObjBezier_m = require("../obj/Bezier")
local t = { bezier_cache = {} }

function t.fromParams(
    s1: string,
    n1: number,
    f1: (...any) -> ...any,
    u1: userdata?,
    f2: ((...any) -> ...any)?,
    b1: boolean?,
    n2: number?
) -- line: 12
    -- upvalues:
    --  [1] t (copy)
    --  [2] Utility_m (copy)
    --  [3] Logger_m (copy)
    --  [4] ObjBezier_m (copy)
    --  [5] RunService (copy)

    local v1 = t.bezier_cache[s1]

    if not v1 then
        local Success, Result = pcall(function() -- line: 24
            -- upvalues:
            --  [1] Utility_m (ref)
            --  [2] s1 (copy)

            return Utility_m.deserializePath(s1)
        end)

        if not Success then
            Logger_m.error(`failed to decode bezier path data with error: {Result}`)
        end

        v1 = ObjBezier_m.new(Result, 0)
        t.bezier_cache[s1] = v1
    end

    local v2 = 0
    local v3 = nil

    local function step(arg1) -- line: 41
        -- upvalues:
        --  [1] b1 (copy)
        --  [2] v2 (ref)
        --  [3] n1 (copy)
        --  [4] v1 (ref)
        --  [5] f1 (copy)
        --  [6] u1 (copy)
        --  [7] v3 (ref)
        --  [8] f2 (copy)

        if not b1 and v2 == 0 then
            v2 = math.clamp(v2 + arg1, 0, (math.max(n1, 0)))
        end

        local v6 = f1(1 - v1:getEase((math.clamp(v2 / n1, 0, 1))).y, arg1, v2)

        if v6 ~= nil then
            if (if n1 == 0 then v2 > n1 else v2 >= n1) and (not u1 or not u1.Connected) then
                v3()

                if f2 then
                    f2(true)
                end

                return
            end

            if v6 then
                local v8 = v2 + v6
                local v9 = math.max(n1, 0.001)
                v2 = math.clamp(v8, 0, v9)
            end

            return
        end

        if not u1 or not u1.Connected then
            v3()

            if f2 then
                f2(true)
            end

            return
        end

        if v6 then
            v2 = math.clamp(v2 + v6, 0, (math.max(n1, 0.001)))
        end
    end

    if not n2 then
        local _ = nil
        local v12 = RunService.RenderStepped:Connect(step)

        function v3() -- line: 74
            -- upvalues:
            --  [1] v12 (ref)

            v12:Disconnect()
        end

        return v12
    end

    local v13 = Utility_m.getRandomId()
    RunService:BindToRenderStep(v13, n2, step)
    local v15 = true

    return function() -- line: 86
        -- upvalues:
        --  [1] v15 (ref)
        --  [2] RunService (ref)
        --  [3] v13 (copy)

        if not v15 then
            return
        end

        v15 = false
        RunService:UnbindFromRenderStep(v13)
    end
end

function t.timer(
    n3: number,
    f3: (...any) -> ...any,
    u2: userdata?,
    t1: table?,
    n4: number?
) -- line: 100
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] Utility_m (copy)

    local thread = coroutine.running()
    local v17 = 0
    local v18 = nil

    local function step_1(arg2) --[[ step ]] -- line: 113
        -- upvalues:
        --  [1] f3 (copy)
        --  [2] v17 (ref)
        --  [3] n3 (copy)
        --  [4] u2 (copy)
        --  [5] v18 (ref)
        --  [6] thread (copy)

        local v19 = f3(arg2, v17)

        if v19 ~= nil then
            if (if n3 == 0 then v17 > n3 else v17 >= n3) and (not u2 or not u2.Connected) then
                v18()
                task.spawn(thread)

                return
            end

            if v19 then
                local v21 = v17 + v19
                local v22 = math.max(n3, 0.001)
                v17 = math.clamp(v21, 0, v22)
            end

            return
        end

        if not u2 or not u2.Connected then
            v18()
            task.spawn(thread)

            return
        end

        if v19 then
            v17 = math.clamp(v17 + v19, 0, (math.max(n3, 0.001)))
        end
    end

    if not n4 then
        local v23 = RunService.RenderStepped:Connect(step_1)

        function v18() -- line: 133
            -- upvalues:
            --  [1] v23 (copy)

            v23:Disconnect()
        end
    else
        local v24 = Utility_m.getRandomId()
        RunService:BindToRenderStep(v24, n4, step_1)
        local v26 = true

        function v18() -- line: 143
            -- upvalues:
            --  [1] v26 (ref)
            --  [2] RunService (ref)
            --  [3] v24 (copy)

            if not v26 then
                return
            end

            v26 = false
            RunService:UnbindFromRenderStep(v24)
        end
    end

    if t1 then
        table.insert(t1, v18)
    end

    coroutine.yield()
end

return t
