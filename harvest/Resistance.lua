-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Resistance
-- Class: ModuleScript
-- bytes: 6465

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("ServerStorage")
local _ = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local StateManager_m = require(Modules.StateManager)
local Alchemy_m = require(Modules.Alchemy)

local _ = function(arg1, arg2) --[[ CalculateArmorDamageReduction ]] -- line: 12
    return arg2 * (arg1 / 100)
end

local _ = function(arg3, arg4) --[[ stackResistance ]] -- line: 19
    return 100 - (100 - arg3) * (100 - arg4) / 100
end

local function factorResistance(
    arg5,
    arg6,
    arg7,
    arg8,
    arg9
) -- line: 25
    -- upvalues:
    --  [1] StateManager_m (copy)
    --  [2] Alchemy_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] RunService (copy)

    if not arg5 then
        return arg7
    end

    local States = arg5:FindFirstChild("States")
    local v1 = States

    if v1 then
        v1 = States:FindFirstChild("Armor")
    end

    if not v1 then
        return arg7
    end

    local v4 = StateManager_m.require(arg5)
    local v6 = StateManager_m.require(arg8)
    local t = {}

    local _ = function(arg10, arg11) --[[ addResistance ]] -- line: 44
        -- upvalues:
        --  [1] t (copy)

        if not arg11 or not t[arg10] then
            return
        end

        local v7 = t
        local v8 = t[arg10]
        local num = tonumber(arg11)
        v7[arg10] = 100 - (100 - v8) * (100 - num) / 100
    end

    local function reduceResistance(arg12, arg13) -- line: 52
        -- upvalues:
        --  [1] t (copy)

        local v9 = t[arg12]

        if v9 and arg13 then
            t[arg12] = math.max(v9 - arg13, 0)
        end
    end

    local v11 = v1.Physical
    local Magic = v1.Magic
    v1 = 0
    local v12 = 0

    for _, val in arg6 do
        if val == "P" then
            t.Physical = v11.Value
        elseif val == "M" then
            t.Magic = Magic.Value
        end
    end

    if v4:HasState("PostureBroken") then
        t.Physical = 0
        t.Magic = 0
    else
        if v4:HasState("enGardeResistance") then
            if t.Physical then
                t.Physical = 100 - (100 - t.Physical) * (100 - tonumber(50)) / 100
            end

            if t.Magic then
                t.Magic = 100 - (100 - t.Magic) * (100 - tonumber(50)) / 100
            end
        end

        if v4:HasState("ManaShieldResistance") then
            if t.Physical then
                t.Physical = 100 - (100 - t.Physical) * (100 - tonumber(15)) / 100
            end

            if t.Magic then
                t.Magic = 100 - (100 - t.Magic) * (100 - tonumber(15)) / 100
            end
        end

        if v4:HasState("Strong Core") then
            if t.Physical then
                t.Physical = 100 - (100 - t.Physical) * (100 - tonumber(10)) / 100
            end

            if t.Magic then
                t.Magic = 100 - (100 - t.Magic) * (100 - tonumber(10)) / 100
            end
        end

        if arg5:FindFirstChild("Hyper Adrenaline") and arg5.Humanoid.Health < arg5.Humanoid.MaxHealth * 0.25 then
            if t.Physical then
                t.Physical = 100 - (100 - t.Physical) * (100 - tonumber(10)) / 100
            end

            if t.Magic then
                t.Magic = 100 - (100 - t.Magic) * (100 - tonumber(10)) / 100
            end
        end

        local Ironskin = Alchemy_m.GetEffect(arg5, "Ironskin")

        if Ironskin > 0 and Ironskin and t.Physical then
            t.Physical = 100 - (100 - t.Physical) * (100 - tonumber(Ironskin)) / 100
        end

        local Warding = Alchemy_m.GetEffect(arg5, "Warding")

        if Warding > 0 and Warding and t.Magic then
            t.Magic = 100 - (100 - t.Magic) * (100 - tonumber(Warding)) / 100
        end

        if arg8 and arg8:FindFirstChild("Enraged Warrior") and arg8.Humanoid.Health <= arg8.Humanoid.MaxHealth * 0.2 then
            local Tool = arg8:FindFirstChildWhichIsA("Tool")
            v11 = Tool

            if v11 then
                v11 = Tool:GetAttribute("Sword") or Tool:GetAttribute("Combat")
            end

            if v11 and table.find(
                require(ReplicatedStorage.Modules.Skills.WeaponInfo)["Enraged Warrior"].Type,
                v11
            ) then
                local Physical_5 = t.Physical

                if Physical_5 then
                    t.Physical = math.max(Physical_5 - 10, 0)
                end
            end
        end

        if arg8 then
            local States_1 = arg8:FindFirstChild("States")
            local v13 = States_1

            if v13 then
                v13 = States_1:FindFirstChild("Armor")
            end

            if v13 then
                if t.Physical and v13:FindFirstChild("PEN_PHYS") then
                    v12 = v13.PEN_PHYS.Value

                    if v6:HasState("Overflow") then
                        v12 += 15
                    end

                    local Physical_6 = t.Physical

                    if Physical_6 and v12 then
                        t.Physical = math.max(Physical_6 - v12, 0)
                    end
                end

                if t.Magic and v13:FindFirstChild("PEN_MAGIC") then
                    v1 = v13.PEN_MAGIC.Value
                    local Magic_6 = t.Magic

                    if Magic_6 and v1 then
                        t.Magic = math.max(Magic_6 - v1, 0)
                    end
                end
            end
        end

        if t.Magic and typeof(arg9) == "number" and arg9 > 0 then
            v1 += arg9
            local Magic_7 = t.Magic

            if Magic_7 and arg9 then
                t.Magic = math.max(Magic_7 - arg9, 0)
            end
        end
    end

    reduceResistance = 0

    for _, val_1 in t do
        reduceResistance = 100 - (100 - reduceResistance) * (100 - val_1) / 100
    end

    if v4:IsRagdolled() then
        reduceResistance = 100 - (100 - reduceResistance) * 90 / 100
    end

    reduceResistance = math.min(reduceResistance, 99)
    local v14 = math.clamp(arg7 - arg7 * (reduceResistance / 100), 1, math.huge)

    if RunService:IsStudio() then
        local v15 = v12 + v1
        print(
            `Total RES: {reduceResistance}% | Total PEN: {v15}% | Original Damage: {arg7} | Final Damage: {v14}`
        )
    end

    return v14
end

return factorResistance
