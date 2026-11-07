-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CommonUtils.CharacterUtil
-- Class: ModuleScript
-- bytes: 3556

local Players = game:GetService("Players")
local t = {
    _connectionUtil = require(script.Parent:WaitForChild("ConnectionUtil")).new(),
    _boundEvents = {},
    getLocalPlayer = function() --[[ getLocalPlayer ]] -- line: 53
        -- upvalues:
        --  [1] Players (copy)

        return Players.LocalPlayer
    end
}
local _ = {
    LOCAL_PLAYER = "LOCAL_PLAYER",
    ON_LOCAL_PLAYER = "ON_LOCAL_PLAYER",
    CHARACTER_ADDED = "CHARACTER_ADDED",
    ON_CHARACTER = "ON_CHARACTER",
    CHARACTER_CHILD_ADDED = "CHARACTER_CHILD_ADDED"
}

function t.onLocalPlayer(arg1) -- line: 57
    -- upvalues:
    --  [1] t (copy)
    --  [2] Players (copy)

    local v1 = t.getLocalPlayer()

    if v1 then
        arg1(v1)
    end

    t._connectionUtil:trackConnection("LOCAL_PLAYER", Players:GetPropertyChangedSignal(
        "LocalPlayer"
    ):Connect(function() -- line: 66
        -- upvalues:
        --  [1] t (ref)

        local v2 = t.getLocalPlayer()
        assert(v2)
        t._getOrCreateBoundEvent("LOCAL_PLAYER"):Fire(v2)
    end))

    return t._getOrCreateBoundEvent("LOCAL_PLAYER").Event:Connect(arg1)
end

function t.getCharacter() -- line: 77
    -- upvalues:
    --  [1] t (copy)

    local v3 = t.getLocalPlayer()

    if not v3 then
        return nil
    end

    return v3.Character
end

function t.onCharacter(arg2) -- line: 85
    -- upvalues:
    --  [1] t (copy)

    t._connectionUtil:trackConnection("ON_LOCAL_PLAYER", t.onLocalPlayer(function(arg3) -- line: 89
        -- upvalues:
        --  [1] t (ref)
        --  [2] arg2 (copy)

        local v4 = t.getCharacter()

        if v4 then
            arg2(v4)
        end

        t._connectionUtil:trackConnection("CHARACTER_ADDED", arg3.CharacterAdded:Connect(function(
            character
        ) -- line: 98
            -- upvalues:
            --  [1] t (ref)

            assert(character)
            t._getOrCreateBoundEvent("CHARACTER_ADDED"):Fire(character)
        end))
    end))

    return t._getOrCreateBoundEvent("CHARACTER_ADDED").Event:Connect(arg2)
end

function t.getChild(s1: string, s2: string) -- line: 110
    -- upvalues:
    --  [1] t (copy)

    local v5 = t.getCharacter()

    if not v5 then
        return nil
    end

    local v6 = v5:FindFirstChild(s1)

    if v6 and v6:IsA(s2) then
        return v6
    end

    return nil
end

function t.onChild(s3: string, s4: string, arg5: any) -- line: 122
    -- upvalues:
    --  [1] t (copy)

    t._connectionUtil:trackConnection("ON_CHARACTER", t.onCharacter(function(arg6) -- line: 126
        -- upvalues:
        --  [1] t (ref)
        --  [2] s3 (copy)
        --  [3] s4 (copy)
        --  [4] arg5 (copy)

        local v7 = t.getChild(s3, s4)

        if v7 then
            arg5(v7)
        end

        t._connectionUtil:trackConnection("CHARACTER_CHILD_ADDED", arg6.ChildAdded:Connect(function(
            child
        ) -- line: 135
            -- upvalues:
            --  [1] s3 (ref)
            --  [2] s4 (ref)
            --  [3] t (ref)

            if child.Name == s3 and child:IsA(s4) then
                t._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. s3 .. s4):Fire(child)
            end
        end))
    end))

    return t._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. s3 .. s4).Event:Connect(arg5)
end

function t._getOrCreateBoundEvent(s5: string) -- line: 149
    -- upvalues:
    --  [1] t (copy)

    if not t._boundEvents[s5] then
        t._boundEvents[s5] = Instance.new("BindableEvent")
    end

    return t._boundEvents[s5]
end

return t
