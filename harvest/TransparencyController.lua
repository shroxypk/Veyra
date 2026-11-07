-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.TransparencyController
-- Class: ModuleScript
-- bytes: 7740

local VRService = game:GetService("VRService")
local t = {
    "BasePart",
    "Decal",
    "Beam",
    "ParticleEmitter",
    "Trail",
    "Fire",
    "Smoke",
    "Sparkles",
    "Explosion"
}
local CameraUtils_m = require(script.Parent:WaitForChild("CameraUtils"))
local Success, Result = pcall(function() -- line: 27
    return UserSettings():IsUserFeatureEnabled("UserHideCharacterParticlesInFirstPerson")
end)
local v2 = Success and Result
local t_1 = {}
t_1.__index = t_1

function t_1.new() -- line: 38
    -- upvalues:
    --  [1] t_1 (copy)

    local t_2 = setmetatable({}, t_1)
    t_2.transparencyDirty = false
    t_2.enabled = false
    t_2.lastTransparency = nil
    t_2.descendantAddedConn, t_2.descendantRemovingConn = nil, nil
    t_2.toolDescendantAddedConns = {}
    t_2.toolDescendantRemovingConns = {}
    t_2.cachedParts = {}

    return t_2
end

function t_1.HasToolAncestor(t1: table, u1: userdata) -- line: 54
    if u1.Parent == nil then
        return false
    end

    assert(u1.Parent, "")

    return u1.Parent:IsA("Tool") or t1:HasToolAncestor(u1.Parent)
end

function t_1.IsValidPartToModify(t2: table, u2: userdata) -- line: 60
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] t (copy)

    if v2 then
        for _, val in t do
            if u2:IsA(val) then
                return not t2:HasToolAncestor(u2)
            end
        end
    elseif not u2:IsA("BasePart") then
        if u2:IsA("Decal") then
            return not t2:HasToolAncestor(u2)
        end
    else
        return not t2:HasToolAncestor(u2)
    end

    return false
end

function t_1.CachePartsRecursive(arg1, arg2) -- line: 76
    if arg2 then
        if arg1:IsValidPartToModify(arg2) then
            arg1.cachedParts[arg2] = true
            arg1.transparencyDirty = true
        end

        for _, val_1 in pairs(arg2:GetChildren()) do
            arg1:CachePartsRecursive(val_1)
        end
    end
end

function t_1.TeardownTransparency(arg3) -- line: 88
    for key_2, _ in pairs(arg3.cachedParts) do
        key_2.LocalTransparencyModifier = 0
    end

    arg3.cachedParts = {}
    arg3.transparencyDirty = true
    arg3.lastTransparency = nil

    if arg3.descendantAddedConn then
        arg3.descendantAddedConn:disconnect()
        arg3.descendantAddedConn = nil
    end

    if arg3.descendantRemovingConn then
        arg3.descendantRemovingConn:disconnect()
        arg3.descendantRemovingConn = nil
    end

    for key_3, val_3 in pairs(arg3.toolDescendantAddedConns) do
        val_3:Disconnect()
        arg3.toolDescendantAddedConns[key_3] = nil
    end

    for key_4, val_4 in pairs(arg3.toolDescendantRemovingConns) do
        val_4:Disconnect()
        arg3.toolDescendantRemovingConns[key_4] = nil
    end
end

function t_1.SetupTransparency(arg4, arg5) -- line: 114
    arg4:TeardownTransparency()

    if arg4.descendantAddedConn then
        arg4.descendantAddedConn:disconnect()
    end

    arg4.descendantAddedConn = arg5.DescendantAdded:Connect(function(descendant_2) -- line: 118
        -- upvalues:
        --  [1] arg4 (copy)
        --  [2] arg5 (copy)

        if arg4:IsValidPartToModify(descendant_2) then
            arg4.cachedParts[descendant_2] = true
            arg4.transparencyDirty = true

            return
        end

        if descendant_2:IsA("Tool") then
            if arg4.toolDescendantAddedConns[descendant_2] then
                arg4.toolDescendantAddedConns[descendant_2]:Disconnect()
            end

            arg4.toolDescendantAddedConns[descendant_2] = descendant_2.DescendantAdded:Connect(function(
                descendant
            ) -- line: 126
                -- upvalues:
                --  [1] arg4 (ref)

                arg4.cachedParts[descendant] = nil

                if not descendant:IsA("BasePart") then
                    if descendant:IsA("Decal") then
                        descendant.LocalTransparencyModifier = 0
                    end
                else
                    descendant.LocalTransparencyModifier = 0
                end
            end)

            if arg4.toolDescendantRemovingConns[descendant_2] then
                arg4.toolDescendantRemovingConns[descendant_2]:disconnect()
            end

            arg4.toolDescendantRemovingConns[descendant_2] = descendant_2.DescendantRemoving:Connect(
                function(descendant_1) -- line: 134
                    -- upvalues:
                    --  [1] arg5 (ref)
                    --  [2] arg4 (ref)

                    wait()

                    if arg5 and descendant_1 and descendant_1:IsDescendantOf(arg5) and arg4:IsValidPartToModify(
                        descendant_1
                    ) then
                        arg4.cachedParts[descendant_1] = true
                        arg4.transparencyDirty = true
                    end
                end
            )
        end
    end)

    if arg4.descendantRemovingConn then
        arg4.descendantRemovingConn:disconnect()
    end

    arg4.descendantRemovingConn = arg5.DescendantRemoving:connect(function(descendant_3) -- line: 146
        -- upvalues:
        --  [1] arg4 (copy)

        if arg4.cachedParts[descendant_3] then
            arg4.cachedParts[descendant_3] = nil
            descendant_3.LocalTransparencyModifier = 0
        end
    end)
    arg4:CachePartsRecursive(arg5)
end

function t_1.Enable(t3: table, b1: boolean) -- line: 157
    if t3.enabled ~= b1 then
        t3.enabled = b1
    end
end

function t_1.SetSubject(arg10, arg11) -- line: 163
    local v5 = if arg11 and arg11:IsA("VehicleSeat") and arg11.Occupant then arg11.Occupant.Parent else if arg11 and arg11:IsA(
        "Humanoid"
    ) then arg11.Parent else nil

    if v5 then
        arg10:SetupTransparency(v5)

        return
    end

    arg10:TeardownTransparency()
end

function t_1.Update(arg12, arg13) -- line: 178
    -- upvalues:
    --  [1] CameraUtils_m (copy)
    --  [2] VRService (copy)

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera and arg12.enabled then
        local Magnitude = (CurrentCamera.Focus.p - CurrentCamera.CoordinateFrame.p).magnitude
        local v6 = Magnitude < 2 and 1 - (Magnitude - 0.5) / 1.5 or 0

        if v6 < 0.5 then
            v6 = 0
        end

        if arg12.lastTransparency and (v6 < 1 and arg12.lastTransparency < 0.95) then
            local v7 = 2.8 * arg13
            v6 = arg12.lastTransparency + math.clamp(v6 - arg12.lastTransparency, -v7, v7)
        else
            arg12.transparencyDirty = true
        end

        v6 = math.clamp(CameraUtils_m.Round(v6, 2), 0, 1)

        if arg12.transparencyDirty or arg12.lastTransparency ~= v6 then
            for key_5, _ in pairs(arg12.cachedParts) do
                if VRService.VREnabled and VRService.AvatarGestures then
                    local t_3 = {
                        [Enum.AccessoryType.Hat] = true,
                        [Enum.AccessoryType.Hair] = true,
                        [Enum.AccessoryType.Face] = true,
                        [Enum.AccessoryType.Eyebrow] = true,
                        [Enum.AccessoryType.Eyelash] = true
                    }

                    if if not key_5.Parent:IsA("Accessory") then not (key_5.Name ~= "Head") else t_3[key_5.Parent.AccessoryType] or not (key_5.Name ~= "Head") then
                        key_5.LocalTransparencyModifier = v6
                    else
                        key_5.LocalTransparencyModifier = 0
                    end
                else
                    key_5.LocalTransparencyModifier = v6
                end
            end

            arg12.transparencyDirty = false
            arg12.lastTransparency = v6
        end
    end
end

return t_1
