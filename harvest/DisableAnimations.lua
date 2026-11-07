-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.DisableAnimations
-- Class: ModuleScript
-- bytes: 4818

local _ = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local t = {
    "Punch",
    "Combat",
    "Uppercut",
    "Dodge",
    "Cancel",
    "AerialSlam",
    "Misdirect",
    "Spear",
    "Sword",
    "Rapier",
    "Greataxe",
    "Greatsword",
    "Dagger",
    "Staff",
    "Katana",
    "Trident",
    "Scythe",
    "Spirit",
    "Zombie",
    "Knockback",
    "Flinch"
}
local t_1 = {}
local t_2 = { "Idle", "Walk", "Run" }
local t_3 = { "HeavyGreatsword", "HeavyGreataxe" }
t_1.__index = t_1
t_1.KEEP_ON_PARRY = "Skill!KeepOnParry"

local _ = function(u1: userdata) --[[ stopAndDestroy ]] -- line: 26
    u1:Stop()
    task.delay(0.5, function() -- line: 32
        -- upvalues:
        --  [1] u1 (copy)

        u1:Destroy()
    end)
end

local function nameMatches(arg1, arg2) -- line: 37
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_2 (copy)
    --  [3] t_3 (copy)

    if arg2 then
        return arg1:match(arg2)
    end

    local v1 = nil
    local v2 = nil

    for _, val in t do
        if arg1:match(val) then
            v1 = true
            break
        end
    end

    for _, val_1 in t_2 do
        if arg1:match(val_1) then
            v2 = true
            break
        end
    end

    if table.find(t_3, arg1) then
        v2 = true
    end

    return v1 and not v2
end

local _ = function(u2: userdata) --[[ getAnimator ]] -- line: 65
    if u2:IsA("Humanoid") then
        return (u2:FindFirstChild("Animator"))
    end

    return u2
end

function t_1.DisableAnimation(_: table, u3: userdata, s1: string?, _: boolean?) -- line: 72
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] nameMatches (copy)

    local v4 = if u3:IsA("Humanoid") then u3:FindFirstChild("Animator") else u3

    if not v4 then
        return
    end

    if not s1 then
        t_1:DisableAttacks(v4)

        return
    end

    for _, val_2 in v4:GetPlayingAnimationTracks() do
        if nameMatches(val_2.Name, s1) then
            val_2:Stop()
            task.delay(0.5, function() -- line: 32
                -- upvalues:
                --  [1] val_2 (copy)

                val_2:Destroy()
            end)
        end
    end
end

function t_1.DisableAttackAnimation(_: table, u4: userdata, b2: boolean?) -- line: 92
    local v5 = if u4:IsA("Humanoid") then u4:FindFirstChild("Animator") else u4

    if not v5 then
        return
    end

    local v6 = if not b2 then "Attack!" else "Skill!"

    for _, val_3 in v5:GetPlayingAnimationTracks() do
        if val_3.Name:match(v6) then
            val_3:Stop()
            task.delay(0.5, function() -- line: 32
                -- upvalues:
                --  [1] val_3 (copy)

                val_3:Destroy()
            end)
        end
    end
end

function t_1.IsSkillKeptOnParry(_: table, u5: userdata) -- line: 110
    -- upvalues:
    --  [1] t_1 (copy)

    local v7 = if u5:IsA("Humanoid") then u5:FindFirstChild("Animator") else u5

    if not v7 then
        return false
    end

    for _, val_4 in v7:GetPlayingAnimationTracks() do
        if val_4.Name == t_1.KEEP_ON_PARRY and val_4.IsPlaying then
            return true
        end
    end

    return false
end

function t_1.DisableParriedAttacks(_: table, u6: userdata) -- line: 125
    -- upvalues:
    --  [1] t_1 (copy)

    local v8 = if u6:IsA("Humanoid") then u6:FindFirstChild("Animator") else u6

    if not v8 then
        return
    end

    for _, val_5 in v8:GetPlayingAnimationTracks() do
        local Name = val_5.Name

        if Name ~= t_1.KEEP_ON_PARRY then
            if not Name:match("Attack!") then
                if Name:match("Skill!") then
                    val_5:Stop()
                    task.delay(0.5, function() -- line: 32
                        -- upvalues:
                        --  [1] val_5 (copy)

                        val_5:Destroy()
                    end)
                end
            else
                val_5:Stop()
                task.delay(0.5, function() -- line: 32
                    -- upvalues:
                    --  [1] val_5 (copy)

                    val_5:Destroy()
                end)
            end
        end
    end
end

function t_1.DisableAttacks(_, arg4) -- line: 139
    -- upvalues:
    --  [1] t_1 (copy)

    t_1:DisableAttackAnimation(arg4)
    t_1:DisableAttackAnimation(arg4, true)
end

function t_1.DisableAll(_, arg6) -- line: 144
    local v9 = if arg6:IsA("Humanoid") then arg6:FindFirstChild("Animator") else arg6

    if not v9 then
        return
    end

    for _, val_6 in v9:GetPlayingAnimationTracks() do
        val_6:Stop()
        task.delay(0.5, function() -- line: 32
            -- upvalues:
            --  [1] val_6 (copy)

            val_6:Destroy()
        end)
    end
end

return t_1
