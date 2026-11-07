-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.GetClientInput
-- Class: LocalScript
-- bytes: 3647

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local GetKeybind_m = require(ReplicatedStorage.Modules.GetKeybind)
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local _ = LocalPlayer:WaitForChild("Binds")
local _ = nil
local _ = nil
local t = { [Enum.UserInputType.MouseButton2] = Enum.KeyCode.ButtonL3 }

local function isPadButtonDown(arg1) -- line: 25
    -- upvalues:
    --  [1] UserInputService (copy)

    for _, val in UserInputService:GetConnectedGamepads() do
        if UserInputService:IsGamepadButtonDown(val, arg1) then
            return true
        end
    end

    return false
end

local function getAimPosition() -- line: 40
    -- upvalues:
    --  [1] mouse (copy)
    --  [2] LocalPlayer (copy)

    local UnitRay = mouse.UnitRay
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local t_1 = { LocalPlayer.Character, workspace.Effects, workspace.CurrentCamera }

    for _ = 1, 8 do
        raycastParams.FilterDescendantsInstances = t_1
        local v5 = workspace:Raycast(UnitRay.Origin, UnitRay.Direction * 1000, raycastParams)

        if not v5 then
            break
        end

        local v6 = v5.Instance

        if v6.CanCollide or v6.Transparency < 1 then
            return v5.Position
        end

        table.insert(t_1, v6)
    end

    return UnitRay.Origin + UnitRay.Direction * 1000
end

function ReplicatedStorage.Remotes.GetMousePosition.OnClientInvoke(arg2, arg3) -- line: 64
    -- upvalues:
    --  [1] getAimPosition (copy)
    --  [2] mouse (copy)

    if arg2 == "Aim" then
        return (getAimPosition())
    end

    return if not arg3 then arg2 and mouse.Hit or mouse.Hit.Position else mouse.Target
end

function ReplicatedStorage.Remotes.GetInput.OnClientInvoke(arg4, arg5) -- line: 74
    -- upvalues:
    --  [1] t (copy)
    --  [2] UserInputService (copy)
    --  [3] isPadButtonDown (copy)
    --  [4] GetKeybind_m (copy)

    if arg4 == "mouse" then
        local v7 = t[arg5]

        return UserInputService:IsMouseButtonPressed(arg5) or (if v7 == nil then false else isPadButtonDown(
            v7
        ))
    end

    if arg4 == "bind" then
        return (GetKeybind_m(arg5))
    end

    return UserInputService:IsKeyDown(arg5)
end

function ReplicatedStorage.Remotes.setClientMovers.OnClientInvoke(arg6, arg7) -- line: 86
    if not arg6 then
        return
    end

    for _, descendant in arg6:GetDescendants() do
        if not descendant:IsA("AlignPosition") then
            if descendant:IsA("BodyPosition") and not descendant:HasTag("Ignore") then
                descendant.Position = arg7
            end
        elseif not descendant:HasTag("Ignore") then
            descendant.Position = arg7
        end
    end
end

UserInputService.InputBegan:Connect(function(arg8, _) -- line: 96
    -- upvalues:
    --  [1] _ (ref)
    --  [2] _ (ref)

    if arg8.UserInputType == Enum.UserInputType.MouseButton1 then
        _ = true

        return
    end

    if arg8.UserInputType == Enum.UserInputType.MouseButton2 then
        _ = true
    end
end)
UserInputService.InputEnded:Connect(function(arg10, _) -- line: 103
    -- upvalues:
    --  [1] _ (ref)
    --  [2] _ (ref)

    if arg10.UserInputType == Enum.UserInputType.MouseButton1 then
        _ = false

        return
    end

    if arg10.UserInputType == Enum.UserInputType.MouseButton2 then
        _ = false
    end
end)
