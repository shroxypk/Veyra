-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.CreateBindableAction
-- Class: ModuleScript
-- bytes: 1192

local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local PadBinds_m = require(script.Parent.PadBinds)

local function createBindableAction(arg1, arg2, arg3, ...) -- line: 8
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] RunService (copy)
    --  [3] PadBinds_m (copy)

    local t = { ... }

    local function update() -- line: 11
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] ContextActionService (ref)
        --  [3] arg1 (copy)
        --  [4] arg3 (copy)
        --  [5] t (copy)

        local Value = arg2.Value
        local v1 = Enum.KeyCode:FromName(Value) or Enum.UserInputType:FromName(Value)
        ContextActionService:UnbindAction(arg1)

        if not v1 then
            return
        end

        ContextActionService:BindActionAtPriority(
            arg1,
            arg3,
            false,
            10,
            v1,
            table.unpack(t)
        )
    end

    arg2:GetPropertyChangedSignal("Value"):Connect(update)
    update()

    if RunService:IsClient() then
        PadBinds_m.bind(arg2.Name, arg3)
    end
end

return createBindableAction
