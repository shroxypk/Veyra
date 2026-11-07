-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule
-- Class: ModuleScript
-- bytes: 547

local t = {}
t.__index = t

function t.new() -- line: 12
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.cameras = require(script:WaitForChild("CameraModule"))
    t_1.controls = require(script:WaitForChild("ControlModule"))

    return t_1
end

function t.GetCameras(arg1) -- line: 19
    return arg1.cameras
end

function t.GetControls(arg2) -- line: 23
    return arg2.controls
end

function t.GetClickToMoveController(arg3) -- line: 27
    return arg3.controls:GetClickToMoveController()
end

return t.new()
