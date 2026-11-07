-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.BindToRender
-- Class: ModuleScript
-- bytes: 2482

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.ReplicatedStorage
local RunService = Services_m.RunService
local _ = Services_m.Maid.new()
local _ = RunService:IsStudio()
local _ = script.Binds
local t = {}
local t_1 = {}

local _ = function(arg1, arg2) --[[ clearBind ]] -- line: 14
    if arg1.bindedEvent then
        arg2.bindedEvent:Destroy()
    end
end

function t.createRender(arg3, arg4) -- line: 23
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)

    local t_2 = { ScriptObject = arg4, Name = arg3 }
    t:removeRender(arg3)
    local BindableEvent = Instance.new("BindableEvent", script.Binds)
    BindableEvent.Name = arg3
    t_2.bindedEvent = BindableEvent
    t_1[arg3] = t_2

    return BindableEvent
end

function t.removeRender(_, arg6) -- line: 35
    -- upvalues:
    --  [1] t_1 (copy)

    if t_1[arg6] and t_1[arg6].bindedEvent then
        t_1[arg6].bindedEvent:Destroy()
    end
end

RunService.RenderStepped:connect(function(deltaTime) -- line: 41
    -- upvalues:
    --  [1] t_1 (copy)

    for key, val in pairs(t_1) do
        if not val.ScriptObject then
            if not val.ScriptObject:IsA("Script") then
                if val.ScriptObject:IsA("LocalScript") and not val.ScriptObject.Disabled then
                    coroutine.resume(coroutine.create(function() -- line: 44
                        -- upvalues:
                        --  [1] val (copy)
                        --  [2] deltaTime (copy)

                        val.bindedEvent:Fire(deltaTime)
                    end))
                elseif key.bindedEvent then
                    val.bindedEvent:Destroy()
                end
            else
                coroutine.resume(coroutine.create(function() -- line: 44
                    -- upvalues:
                    --  [1] val (copy)
                    --  [2] deltaTime (copy)

                    val.bindedEvent:Fire(deltaTime)
                end))

                if key.bindedEvent then
                    val.bindedEvent:Destroy()
                end
            end
        else
            coroutine.resume(coroutine.create(function() -- line: 44
                -- upvalues:
                --  [1] val (copy)
                --  [2] deltaTime (copy)

                val.bindedEvent:Fire(deltaTime)
            end))

            if key.bindedEvent then
                val.bindedEvent:Destroy()
            end
        end
    end
end)

return t
