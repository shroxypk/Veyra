-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.BaseOcclusion
-- Class: ModuleScript
-- bytes: 963

local t = {}
t.__index = t
setmetatable(t, {
    __call = function(_, ...) --[[ __call ]] -- line: 10
        -- upvalues:
        --  [1] t (copy)

        return t.new(...)
    end
})

function t.new() -- line: 15
    -- upvalues:
    --  [1] t (copy)

    return (setmetatable({}, t))
end

function t.CharacterAdded(_: table, _: userdata, _: userdata) -- line: 21
end

function t.CharacterRemoving(_: table, _: userdata, _: userdata) -- line: 25
end

function t.OnCameraSubjectChanged(_, _) -- line: 28
end

function t.GetOcclusionMode(_) -- line: 32
    warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes")

    return nil
end

function t.Enable(_: table, _: boolean) -- line: 38
    warn("BaseOcclusion Enable must be overridden by derived classes")
end

function t.Update(_: table, _: number, u5: CFrame, u6: CFrame) -- line: 42
    warn("BaseOcclusion Update must be overridden by derived classes")

    return u5, u6
end

return t
