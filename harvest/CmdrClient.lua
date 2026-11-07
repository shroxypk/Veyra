-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient
-- Class: ModuleScript
-- bytes: 3347

local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Shared = script:WaitForChild("Shared")
local Util_m = require(Shared:WaitForChild("Util"))

if RunService:IsClient() == false then
    error(
        "Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code."
    )
end

local t = {
    ReplicatedRoot = script,
    RemoteFunction = script:WaitForChild("CmdrFunction"),
    RemoteEvent = script:WaitForChild("CmdrEvent"),
    ActivationKeys = nil,
    Enabled = true,
    MashToEnable = false,
    ActivationUnlocksMouse = false,
    HideOnLostFocus = true,
    PlaceName = "Cmdr",
    Util = nil,
    Events = nil
}
local t_1 = {}
t_1[Enum.KeyCode.F2] = true
t.ActivationKeys = t_1
t.Util = Util_m
t.Events = {}
local t_3 = setmetatable(t, {
    __index = function(arg1, arg2) --[[ __index ]] -- line: 28
        local v2 = arg1.Dispatcher[arg2]

        if v2 and type(v2) == "function" then
            return function(_, ...) -- line: 31
                -- upvalues:
                --  [1] v2 (copy)
                --  [2] arg1 (copy)

                return v2(arg1.Dispatcher, ...)
            end
        end
    end
})
t_3.Registry = require(Shared.Registry)(t_3)
t_3.Dispatcher = require(Shared.Dispatcher)(t_3)

if StarterGui:WaitForChild("Cmdr") and wait() and LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild(
    "Cmdr"
) == nil then
    StarterGui.Cmdr:Clone().Parent = LocalPlayer.PlayerGui
end

local v4 = require(script.CmdrInterface)(t_3)

function t_3.SetActivationKeys(arg4, arg5) -- line: 49
    -- upvalues:
    --  [1] Util_m (copy)

    arg4.ActivationKeys = Util_m.MakeDictionary(arg5)
end

function t_3.SetPlaceName(arg6, arg7) -- line: 54
    -- upvalues:
    --  [1] v4 (copy)

    arg6.PlaceName = arg7
    v4.Window:UpdateLabel()
end

function t_3.SetEnabled(arg8, arg9) -- line: 60
    arg8.Enabled = arg9
end

function t_3.SetActivationUnlocksMouse(arg10, arg11) -- line: 65
    arg10.ActivationUnlocksMouse = arg11
end

function t_3.Show(arg12) -- line: 70
    -- upvalues:
    --  [1] v4 (copy)

    if not arg12.Enabled then
        return
    end

    v4.Window:Show()
end

function t_3.Hide(_) -- line: 79
    -- upvalues:
    --  [1] v4 (copy)

    v4.Window:Hide()
end

function t_3.Toggle(arg14) -- line: 84
    -- upvalues:
    --  [1] v4 (copy)

    if not arg14.Enabled then
        return arg14:Hide()
    end

    v4.Window:SetVisible(not v4.Window:IsVisible())
end

function t_3.SetMashToEnable(arg15, arg16) -- line: 93
    arg15.MashToEnable = arg16

    if arg16 then
        arg15:SetEnabled(false)
    end
end

function t_3.SetHideOnLostFocus(arg17, arg18) -- line: 102
    arg17.HideOnLostFocus = arg18
end

function t_3.HandleEvent(arg19, arg20, arg21) -- line: 107
    arg19.Events[arg20] = arg21
end

if RunService:IsServer() == false then
    t_3.Registry:RegisterTypesIn(script:WaitForChild("Types"))
    t_3.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end

t_3.RemoteEvent.OnClientEvent:Connect(function(arg22, ...) -- line: 118
    -- upvalues:
    --  [1] t_3 (ref)

    if t_3.Events[arg22] then
        t_3.Events[arg22](...)
    end
end)
require(script.DefaultEventHandlers)(t_3)

return t_3
