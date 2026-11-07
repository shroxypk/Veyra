-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.CameraUI
-- Class: ModuleScript
-- bytes: 720

local StarterGui = game:GetService("StarterGui")
local v1 = false
local t = {}

function t.setCameraModeToastEnabled(b1: boolean) -- line: 10
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] t (copy)

    if not b1 and not v1 then
        return
    end

    if not v1 then
        v1 = true
    end

    if not b1 then
        t.setCameraModeToastOpen(false)
    end
end

function t.setCameraModeToastOpen(b2: boolean) -- line: 24
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] StarterGui (copy)

    assert(v1)

    if b2 then
        StarterGui:SetCore(
            "SendNotification",
            { Title = "Camera Control Enabled", Text = "Right click to toggle", Duration = 3 }
        )
    end
end

return t
