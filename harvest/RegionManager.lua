-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.RegionManager
-- Class: ModuleScript
-- bytes: 4907

local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local t = {}
t.__index = t
local Value = script.Configuration.CHECK_INTERVAL_FRAMES.Value
local t_1 = {}
local v1 = nil

local _ = function(arg1, arg2) --[[ IsInside ]] -- line: 19
    local v2 = arg1.CFrame:PointToObjectSpace(arg2.Position)
    local v3 = arg1.Size / 2
    local v4 = false

    if math.abs(v2.X) <= v3.X then
        v4 = false

        if math.abs(v2.Y) <= v3.Y then
            v4 = math.abs(v2.Z) <= v3.Z and true
        end
    end

    return v4
end

local _ = function() --[[ EnsureRenderStepped ]] -- line: 30
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] RunService (copy)
    --  [3] Value (ref)
    --  [4] LocalPlayer (copy)
    --  [5] t_1 (copy)

    if v1 then
        v1:Disconnect()
        v1 = nil
    end

    v1 = RunService.RenderStepped:Connect(function() -- line: 36
        -- upvalues:
        --  [1] Value (ref)
        --  [2] LocalPlayer (ref)
        --  [3] t_1 (ref)

        Value += 1

        if Value % 2 ~= 0 then
            return
        end

        local v8 = LocalPlayer.Character

        if v8 then
            v8 = LocalPlayer.Character.PrimaryPart
        end

        if not v8 then
            return
        end

        for _, val in pairs(t_1) do
            local v9 = val.CFrame:PointToObjectSpace(v8.Position)
            local v10 = val.Size / 2
            local v11 = false

            if math.abs(v9.X) <= v10.X then
                v11 = false

                if math.abs(v9.Y) <= v10.Y then
                    v11 = math.abs(v9.Z) <= v10.Z and true
                end
            end

            if v11 and not val.PlayerInside then
                val.PlayerInside = true

                if val.Callbacks.CallbackEnter then
                    task.spawn(val.Callbacks.CallbackEnter)
                end
            elseif not v11 and val.PlayerInside then
                val.PlayerInside = false

                if val.Callbacks.CallbackExit then
                    task.spawn(val.Callbacks.CallbackExit)
                end
            end
        end
    end)
end

function t.New(arg3: any, t1: table) -- line: 68
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] v1 (ref)
    --  [3] RunService (copy)
    --  [4] Value (ref)
    --  [5] LocalPlayer (copy)

    assert(if typeof(t1) ~= "table" then false else true, "Callbacks must be a table")
    local v16 = typeof(arg3)

    if v16 ~= "table" and v16 ~= "Instance" then
        error("The zone container must be a model, folder, basepart or table!")
    end

    local t_2 = { CFrame = arg3.CFrame, Size = arg3.Size, Callbacks = t1, PlayerInside = false }
    table.insert(t_1, t_2)

    if not v1 then
        if v1 then
            v1:Disconnect()
            v1 = nil
        end

        v1 = RunService.RenderStepped:Connect(function() -- line: 36
            -- upvalues:
            --  [1] Value (ref)
            --  [2] LocalPlayer (ref)
            --  [3] t_1 (ref)

            Value += 1

            if Value % 2 ~= 0 then
                return
            end

            local v17 = LocalPlayer.Character

            if v17 then
                v17 = LocalPlayer.Character.PrimaryPart
            end

            if not v17 then
                return
            end

            for _, val_1 in pairs(t_1) do
                local v18 = val_1.CFrame:PointToObjectSpace(v17.Position)
                local v19 = val_1.Size / 2
                local v20 = false

                if math.abs(v18.X) <= v19.X then
                    v20 = false

                    if math.abs(v18.Y) <= v19.Y then
                        v20 = math.abs(v18.Z) <= v19.Z and true
                    end
                end

                if v20 and not val_1.PlayerInside then
                    val_1.PlayerInside = true

                    if val_1.Callbacks.CallbackEnter then
                        task.spawn(val_1.Callbacks.CallbackEnter)
                    end
                elseif not v20 and val_1.PlayerInside then
                    val_1.PlayerInside = false

                    if val_1.Callbacks.CallbackExit then
                        task.spawn(val_1.Callbacks.CallbackExit)
                    end
                end
            end
        end)
    end

    return t_2
end

function t.fromRegion(u1: CFrame, vec1: Vector3, t2: table) -- line: 92
    -- upvalues:
    --  [1] t (copy)

    return t.New({ CFrame = u1, Size = vec1 }, t2)
end

function t.Remove(arg4) -- line: 101
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] v1 (ref)

    for key_2, val_2 in t_1 do
        if val_2 == arg4 then
            table.remove(t_1, key_2)
            break
        end
    end

    if not next(t_1) and v1 then
        v1:Disconnect()
        v1 = nil
    end
end

if v1 then
    v1:Disconnect()
end

return t
