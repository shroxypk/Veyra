-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Headless.Headless_Cleave_Fx
-- Class: ModuleScript
-- bytes: 2869

local HeadlessFxUtil_m = require(script.Parent.HeadlessFxUtil)
local Assets = script.Assets
local t = setmetatable({}, { __mode = "k" })

local _ = function(u1: userdata) --[[ clearCharge ]] -- line: 9
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)

    local v1 = t[u1]
    t[u1] = nil

    if v1 then
        for _, val in v1 do
            HeadlessFxUtil_m.Remove(val)
        end
    end
end

return function(u2: userdata, s1: string) -- line: 19
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] Assets (copy)

    if s1 == "End" then
        local v2 = t[u2]
        t[u2] = nil

        if v2 then
            for _, val_1 in v2 do
                HeadlessFxUtil_m.Remove(val_1)
            end
        end

        return
    end

    local v3 = HeadlessFxUtil_m.Feet(u2)

    if not v3 then
        local v4 = t[u2]
        t[u2] = nil

        if v4 then
            for _, val_2 in v4 do
                HeadlessFxUtil_m.Remove(val_2)
            end
        end

        return
    end

    if s1 == "Begin" then
        local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart then
            HeadlessFxUtil_m.Sound("ReapersCleave", HumanoidRootPart)

            return
        end
    elseif s1 == "Charge" then
        local v5 = t[u2]
        t[u2] = nil

        if v5 then
            for _, val_3 in v5 do
                HeadlessFxUtil_m.Remove(val_3)
            end
        end

        local v6 = HeadlessFxUtil_m.FindBone(u2, "WeaponHandle.L")

        if not v6 then
            return
        end

        local t_1 = {}
        local v7 = Assets.BladeCharge:Clone()

        for _, child in v7:GetChildren() do
            local v8 = if child:IsA("Folder") then child:GetChildren() or { child } else { child }

            for _, val_4 in v8 do
                val_4.Parent = v6
                HeadlessFxUtil_m.Enable(val_4)
                table.insert(t_1, val_4)
            end
        end

        v7:Destroy()
        t[u2] = t_1

        return
    else
        if s1 == "Slash" then
            local v9 = t[u2]
            t[u2] = nil

            if v9 then
                for _, val_5 in v9 do
                    HeadlessFxUtil_m.Remove(val_5)
                end
            end

            for _, val_6 in { "Slash", "Final", "Smoke" } do
                local v10 = Assets:FindFirstChild(val_6)

                if v10 then
                    HeadlessFxUtil_m.Place(v10, v3)
                end
            end

            HeadlessFxUtil_m.Shake(
                v3.Position,
                6,
                12,
                0.8,
                200
            )

            return
        end

        if s1 == "GroundCut" then
            HeadlessFxUtil_m.Place(Assets.DelayedGround, v3)
        end
    end
end
