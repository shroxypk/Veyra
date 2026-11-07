-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.Buttons.Ability.ControlVisibility
-- Class: LocalScript
-- bytes: 1285

local _ = game:GetService("Players")
local Modules = game:GetService("ReplicatedStorage").Modules
local StatManager_m = require(Modules.StatManager)
local v1, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v3 = StatManager_m.require(v1)

if v3:GetStat("Magic") == "None" then
    local _ = v1:WaitForChild("Quests")
    v1 = false
else
    local _ = v1:WaitForChild("Quests")
    v1 = true
end

local Parent = script.Parent
Parent.Visible = false

local _ = function(arg1) --[[ makeVisible ]] -- line: 19
    -- upvalues:
    --  [1] Parent (copy)

    Parent.Visible = true

    if arg1 then
        Parent.New.Visible = true
        Parent.Activated:Once(function() -- line: 24
            -- upvalues:
            --  [1] Parent (ref)

            Parent.New.Visible = false
        end)
    end
end

if not v1 then
    local v6 = nil
    v6 = v3:OnStatChanged("Magic", function() -- line: 32
        -- upvalues:
        --  [1] v6 (ref)
        --  [2] Parent (copy)

        v6:Disconnect()
        Parent.Visible = true
        Parent.New.Visible = true
        Parent.Activated:Once(function() -- line: 24
            -- upvalues:
            --  [1] Parent (ref)

            Parent.New.Visible = false
        end)
    end)

    return
end

Parent.Visible = true
