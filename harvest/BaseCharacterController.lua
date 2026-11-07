-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.BaseCharacterController
-- Class: ModuleScript
-- bytes: 985

local ConnectionUtil_m = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("ConnectionUtil")
)
local t = {}
local vec3 = Vector3.new()
t.__index = t

function t.new() -- line: 33
    -- upvalues:
    --  [1] t (copy)
    --  [2] vec3 (copy)
    --  [3] ConnectionUtil_m (copy)

    local t_1 = setmetatable({}, t)
    t_1.enabled = false
    t_1.moveVector = vec3
    t_1.moveVectorIsCameraRelative = true
    t_1.isJumping = false
    t_1._connectionUtil = ConnectionUtil_m.new()

    return t_1
end

function t.GetMoveVector(arg1) -- line: 45
    return arg1.moveVector
end

function t.IsMoveVectorCameraRelative(arg2) -- line: 49
    return arg2.moveVectorIsCameraRelative
end

function t.GetIsJumping(arg3) -- line: 53
    return arg3.isJumping
end

function t.Enable(_: table, _: boolean) -- line: 59
    error(
        "BaseCharacterController:Enable must be overridden in derived classes and should not be called."
    )

    return false
end

return t
