-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.common.flipbook
-- Class: ModuleScript
-- bytes: 2381

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local t = {
    serialize = function(t1: table) --[[ serialize ]] -- line: 6
        local buf = buffer.create(#t1 * 8)

        for key, val in t1 do
            buffer.writef64(buf, (key - 1) * 8, val)
        end

        return buf
    end,
    deserialize = function(arg1) --[[ deserialize ]] -- line: 16
        local v1 = typeof(arg1) == "string" and buffer.fromstring(arg1) or arg1
        local t_1 = {}

        for index = 0, buffer.len(v1) / 8 - 1 do
            local _ = buffer.len(v1) / 8 - 1
            table.insert(t_1, (buffer.readf64(v1, index * 8)))
        end

        return t_1
    end,
    isLocalFlipbook = function(u1: userdata) --[[ isLocalFlipbook ]] -- line: 29
        -- upvalues:
        --  [1] RunService (copy)
        --  [2] CollectionService (copy)

        if not RunService:IsStudio() then
            return false
        end

        for _, val_1 in CollectionService:GetTags(u1) do
            if val_1:match("^_local_flipbook_") then
                return true
            end
        end

        return false
    end
}

function t.getTexturePrefix(u2: userdata) -- line: 43
    -- upvalues:
    --  [1] t (copy)

    if t.isLocalFlipbook(u2) then
        return "rbxtemp://"
    end

    return "rbxassetid://"
end

function t.getFlipbookData(u3: userdata) -- line: 47
    -- upvalues:
    --  [1] t (copy)

    if not u3:GetAttribute("FlipbookEnabled") then
        return nil
    end

    local FlipbookTextures = u3:GetAttribute("FlipbookTextures")

    if not FlipbookTextures then
        return nil
    end

    local v3 = t.deserialize(FlipbookTextures)

    if #v3 == 0 then
        return nil
    end

    return v3
end

function t.getChangeDuration(t2: table) -- line: 81
    return if t2.ref:GetAttribute("SyncDuration") then t2.effectDuration else t2.duration
end

function t.createUpdateCallback(t3: table) -- line: 91
    -- upvalues:
    --  [1] t (copy)

    local v5 = t.getTexturePrefix(t3.ref)

    return function(arg2, arg3) -- line: 94
        -- upvalues:
        --  [1] t3 (copy)
        --  [2] v5 (copy)

        local v6 = math.round(#t3.frames * arg2)
        local v7 = math.max(v6, 1)
        t3.setTexture(`{v5}{t3.frames[v7]}`)

        return arg3 * t3.getSpeed()
    end
end

return t
