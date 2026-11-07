-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.All.AbilityAvailableClient
-- Class: ModuleScript
-- bytes: 4928

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local Trials_m = require(Modules.Trials)
local Skills_m = require(Modules.Skills)
local StatManager_m = require(Modules.StatManager)
local LocalPlayer = Players.LocalPlayer
local Upgrade = ReplicatedStorage.SFX.Misc:FindFirstChild("Upgrade")

local function main() -- line: 23
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] LocalPlayer (copy)
    --  [3] Skills_m (copy)
    --  [4] Trials_m (copy)
    --  [5] Upgrade (copy)

    task.spawn(function() -- line: 24
        -- upvalues:
        --  [1] StatManager_m (ref)
        --  [2] LocalPlayer (ref)
        --  [3] Skills_m (ref)
        --  [4] Trials_m (ref)
        --  [5] Upgrade (ref)

        local v1 = StatManager_m.require(LocalPlayer)
        local Skills = LocalPlayer:WaitForChild("Skills")
        local Inventory = LocalPlayer:WaitForChild("Inventory")
        local v2 = false

        local function evaluate() -- line: 34
            -- upvalues:
            --  [1] v1 (copy)
            --  [2] Skills_m (ref)
            --  [3] Trials_m (ref)
            --  [4] Skills (copy)
            --  [5] Inventory (copy)

            local Magic = v1:GetStat("Magic")

            if not Magic or Magic == "None" then
                return nil, false
            end

            local v3 = Skills_m.Skillsets[`{Magic}Info`]

            if not v3 then
                return nil, false
            end

            local v4, v5 = Trials_m.CountGameplaySkills(Skills, v3)

            if v4 >= v5 then
                return nil, false
            end

            local v6 = v4 + 1
            local v7 = `{Magic}:{v6}`
            local v8 = Trials_m.GetTrial(v4 + 1)

            if v4 == 0 or v8.Free then
                return v7, false
            end

            if v1:GetStat("MagicMaxed") then
                return v7, true
            end

            local t = { Insight = v1:GetStat("Insight") or 0, Level = nil }
            local v9
            t.Level, v9 = v1:GetStat("Level") or 0, v7

            return v9, Trials_m.MeetsRequirements(v8, t, Inventory)
        end

        local v10 = false
        local v11 = nil

        local function check() -- line: 71
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] evaluate (copy)
            --  [3] v11 (ref)
            --  [4] Upgrade (ref)

            if not v10 then
                return
            end

            local v12, v13 = evaluate()

            if not v13 or v12 == v11 then
                return
            end

            v11 = v12

            if _G.CreateSignificantAlert then
                _G.CreateSignificantAlert("NEW ABILITY AWAITS", Upgrade)
            end

            task.delay(3, function() -- line: 87
                if _G.CreateAlert then
                    _G.CreateAlert(
                        "A new ability stirs within you. Open your <b>Utility Spells</b> and enter your <b>Inner Realm</b>."
                    )
                end
            end)
        end

        local function queueCheck() -- line: 95
            -- upvalues:
            --  [1] v2 (ref)
            --  [2] check (copy)

            if v2 then
                return
            end

            v2 = true
            task.delay(0.5, function() -- line: 100
                -- upvalues:
                --  [1] v2 (ref)
                --  [2] check (ref)

                v2 = false
                check()
            end)
        end

        for _, val in { "Magic", "Level", "Insight", "MagicMaxed" } do
            v1:OnStatChanged(val, queueCheck)
        end

        Skills.ChildAdded:Connect(queueCheck)
        Skills.ChildRemoved:Connect(queueCheck)

        local _ = function(u1: userdata) --[[ hookItem ]] -- line: 113
            -- upvalues:
            --  [1] queueCheck (copy)

            u1:GetAttributeChangedSignal("Stock"):Connect(queueCheck)
        end

        for _, child in Inventory:GetChildren() do
            child:GetAttributeChangedSignal("Stock"):Connect(queueCheck)
        end

        Inventory.ChildAdded:Connect(function(child_1) -- line: 119
            -- upvalues:
            --  [1] queueCheck (copy)
            --  [2] v2 (ref)
            --  [3] check (copy)

            child_1:GetAttributeChangedSignal("Stock"):Connect(queueCheck)

            if v2 then
                return
            end

            v2 = true
            task.delay(0.5, function() -- line: 100
                -- upvalues:
                --  [1] v2 (ref)
                --  [2] check (ref)

                v2 = false
                check()
            end)
        end)
        task.wait(8)
        v10 = true
        check()

        while true do
            task.wait(10)
            check()
        end
    end)
end

return main
