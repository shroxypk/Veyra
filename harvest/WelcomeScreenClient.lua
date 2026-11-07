-- Decompiled with Veyra harvester
-- Instance: StarterGui.WelcomeUI.WelcomeScreenClient
-- Class: LocalScript
-- bytes: 5285

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local GamepadLayer_m = require(Modules.GamepadLayer)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()

if not v2:GetAttribute("Loaded") then
    v2:GetAttributeChangedSignal("Loaded"):Wait()
end

if script.WelcomeRemote:InvokeServer("Request") then
    script.Parent.Enabled = false

    return
end

task.wait(1)
local CustomizeFolder = v2:FindFirstChild("CustomizeFolder")
local v4 = CustomizeFolder and CustomizeFolder:WaitForChild("CharacterName").Value or v2.Name
local Binds = v2:WaitForChild("Binds")

local _ = function(arg1) --[[ highlight ]] -- line: 39
    return `[b][Color=#ffeba1]{arg1}[/Color][/b]`
end

local _ = function() --[[ usingController ]] -- line: 43
    -- upvalues:
    --  [1] GamepadLayer_m (copy)
    --  [2] UserInputService (copy)

    local v5 = GamepadLayer_m.isGamepadActive()

    if not v5 then
        v5 = UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled
    end

    return v5
end

local function keyName(arg2, arg3) -- line: 49
    -- upvalues:
    --  [1] Binds (copy)
    --  [2] UserInputService (copy)

    local v6 = Binds:FindFirstChild(arg2)
    local v7 = v6 and v6.Value or arg3
    local v8 = Enum.KeyCode:FromName(v7)

    if v8 then
        local v9 = UserInputService:GetStringForKeyCode(v8)

        if v9 and v9 ~= "" then
            return string.upper(v9)
        end
    end

    return v7
end

local _ = function(
    arg4,
    arg5,
    arg6,
    arg7,
    arg8
) --[[ control ]] -- line: 65
    -- upvalues:
    --  [1] GamepadLayer_m (copy)
    --  [2] UserInputService (copy)
    --  [3] keyName (copy)

    if GamepadLayer_m.isGamepadActive() or UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then
        local v11 = `[b][Color=#ffeba1]{arg8}[/Color][/b]`

        return `{arg7} {v11}`
    end

    return `{arg4} {`[b][Color=#ffeba1]{keyName(arg5, arg6)}[/Color][/b]`}`
end

local t = { DisplayName = "", start = "greeting", nodes = nil }
local t_1 = {
    greeting = {
        __yield = true,
        text = `Greetings [b]{v4}[/b]. Welcome to the continent of [b][Color=#f2ffcf]Elysium[/Color][/b]!`,
        after = "page2"
    },
    page2 = {
        __yield = true,
        text = "As you traverse through this charming land, you will have the opportunity to [Color=#ffeba1]defeat powerful beings, take on quests, and discover hidden secrets & items[/Color].",
        after = "map"
    },
    map = {
        __yield = true,
        text = function() --[[ text ]] -- line: 93
            -- upvalues:
            --  [1] GamepadLayer_m (copy)
            --  [2] UserInputService (copy)
            --  [3] keyName (copy)

            local v13 = if GamepadLayer_m.isGamepadActive() or UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then `tap [b][Color=#ffeba1]D-Pad Down[/Color][/b]` else `press {`[b][Color=#ffeba1]{keyName(
                "Map",
                "M"
            )}[/Color][/b]`}`

            return `If you ever get lost, {v13} to pull out your [b][Color=#ffeba1]Map[/Color][/b].`
        end,
        after = "page3"
    },
    page3 = {
        __yield = true,
        text = function() --[[ text ]] -- line: 102
            -- upvalues:
            --  [1] GamepadLayer_m (copy)
            --  [2] UserInputService (copy)
            --  [3] keyName (copy)

            local v15 = if GamepadLayer_m.isGamepadActive() or UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then `hold [b][Color=#ffeba1]D-Pad Right[/Color][/b]` else `hold down {`[b][Color=#ffeba1]{keyName(
                "Utility Spells",
                "U"
            )}[/Color][/b]`}`

            return `You can {v15} to open up your [b][Color=#ffeba1]Utility Spells[/Color][/b] menu.`
        end,
        after = "page4"
    },
    page4 = {
        __yield = true,
        text = function() --[[ text ]] -- line: 110
            -- upvalues:
            --  [1] GamepadLayer_m (copy)
            --  [2] UserInputService (copy)
            --  [3] keyName (copy)

            local v17 = if GamepadLayer_m.isGamepadActive() or UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then `hold [b][Color=#ffeba1]D-Pad Down[/Color][/b]` else `press {`[b][Color=#ffeba1]{keyName(
                "Quest Journal",
                "J"
            )}[/Color][/b]`}`

            return `Furthermore, you can {v17} to open your [b][Color=#ffeba1]Quest Index[/Color][/b]. This will allow you to view and [b]track[/b] your current quests!`
        end,
        after = "finish"
    },
    finish = {
        __yield = true,
        text = "Alright. That should be all for now. However, be warned: The land of [b]Elysium[/b] can be unforgivingly [Color=#ff5757]cruel[/Color] at times. I hope that your time will be filled with excitement, challenge, and reward.",
        action = function() --[[ action ]] -- line: 119
            script.WelcomeRemote:InvokeServer("Read")
        end
    }
}
t.nodes = t_1
_G.ForceChat(t)
