-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.CameraToggleStateController
-- Class: ModuleScript
-- bytes: 2786

local _ = game:GetService("Players")
local _ = game:GetService("UserInputService")
local _ = UserSettings():GetService("UserGameSettings")
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI_m = require(script.Parent:WaitForChild("CameraUI"))
local CameraUtils_m = require(script.Parent:WaitForChild("CameraUtils"))
local v4 = false
local now = tick()
CameraUI_m.setCameraModeToastEnabled(false)
local v5 = false
local v6 = false
local v7 = false

return function(b1: boolean) -- line: 20
    -- upvalues:
    --  [1] CameraInput_m (copy)
    --  [2] v4 (ref)
    --  [3] v5 (ref)
    --  [4] now (ref)
    --  [5] CameraUI_m (copy)
    --  [6] v6 (ref)
    --  [7] v7 (ref)
    --  [8] CameraUtils_m (copy)

    local v8 = CameraInput_m.getTogglePan()

    if b1 and v8 ~= v4 then
        v5 = true
    end

    local v9

    if v4 == v8 then
        if tick() - now > 3 then
            v9 = v8 and tick() - now < 3
            CameraUI_m.setCameraModeToastOpen(v9)

            if v8 then
                v5 = false
            end

            now = tick()
            v4 = v8
        end
    else
        v9 = v8 and tick() - now < 3
        CameraUI_m.setCameraModeToastOpen(v9)

        if v8 then
            v5 = false
        end

        now = tick()
        v4 = v8
    end

    if b1 ~= v6 then
        if b1 then
            v7 = CameraInput_m.getTogglePan()
            CameraInput_m.setTogglePan(true)
        elseif not v5 then
            CameraInput_m.setTogglePan(v7)
        end
    end

    if b1 then
        if CameraInput_m.getTogglePan() then
            CameraUtils_m.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
            CameraUtils_m.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
            CameraUtils_m.setRotationTypeOverride(Enum.RotationType.CameraRelative)
        else
            CameraUtils_m.restoreMouseIcon()
            CameraUtils_m.restoreMouseBehavior()
            CameraUtils_m.setRotationTypeOverride(Enum.RotationType.CameraRelative)
        end
    elseif CameraInput_m.getTogglePan() then
        CameraUtils_m.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
        CameraUtils_m.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
        CameraUtils_m.setRotationTypeOverride(Enum.RotationType.MovementRelative)
    elseif CameraInput_m.getHoldPan() then
        CameraUtils_m.restoreMouseIcon()
        CameraUtils_m.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
        CameraUtils_m.setRotationTypeOverride(Enum.RotationType.MovementRelative)
    else
        CameraUtils_m.restoreMouseIcon()
        CameraUtils_m.restoreMouseBehavior()
        CameraUtils_m.restoreRotationType()
    end

    v6 = b1
end
