-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.FastMode
-- Class: LocalScript
-- bytes: 1607

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Settings = Players.LocalPlayer:WaitForChild("Settings")
local FastMode = Settings:WaitForChild("FastMode")
local LowGFX = Settings:WaitForChild("LowGFX")

local _ = function(arg1, arg2, arg3) --[[ connectSetting ]] -- line: 10
    local function apply() -- line: 11
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)
        --  [3] arg3 (copy)

        _G[arg2] = arg1.Value

        if arg3 then
            arg3(arg1.Value)
        end
    end

    arg1:GetPropertyChangedSignal("Value"):Connect(apply)
    _G[arg2] = arg1.Value

    if arg3 then
        arg3(arg1.Value)
    end
end

local function v1(arg4) -- line: 19
    -- upvalues:
    --  [1] Lighting (copy)

    Lighting.GlobalShadows = not arg4
end

local v2 = "MediumPerformance"

local function apply_1() --[[ apply ]] -- line: 11
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] FastMode (copy)
    --  [3] v1 (copy)

    _G[v2] = FastMode.Value

    if v1 then
        v1(FastMode.Value)
    end
end

FastMode:GetPropertyChangedSignal("Value"):Connect(apply_1)
_G.MediumPerformance = FastMode.Value

if v1 then
    Lighting.GlobalShadows = not FastMode.Value
end

local v3 = "LowPerformance"
local v4 = nil

local function apply_2() --[[ apply ]] -- line: 11
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] LowGFX (copy)
    --  [3] v4 (copy)

    _G[v3] = LowGFX.Value

    if v4 then
        v4(LowGFX.Value)
    end
end

LowGFX:GetPropertyChangedSignal("Value"):Connect(apply_2)
_G.LowPerformance = LowGFX.Value
