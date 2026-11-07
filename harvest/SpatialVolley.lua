-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Shared.SpatialVolley
-- Class: ModuleScript
-- bytes: 3639

local Volley = require(game:GetService("ReplicatedStorage").Modules.Skills):LookupSkill(
    "Spatial Volley"
).Volley
local t = {
    shotCount = function() --[[ shotCount ]] -- line: 24
        -- upvalues:
        --  [1] Volley (copy)

        local v1 = math.floor(Volley.Duration * Volley.ProjectilesPerSecond)

        return (math.max(v1, 1))
    end,
    spawnTime = function(n1: number) --[[ spawnTime ]] -- line: 29
        -- upvalues:
        --  [1] Volley (copy)

        return (n1 - 1) / Volley.ProjectilesPerSecond
    end,
    travelTime = function(vec1: Vector3, vec2: Vector3) --[[ travelTime ]] -- line: 33
        -- upvalues:
        --  [1] Volley (copy)

        return (vec2 - vec1).Magnitude / Volley.ProjectileSpeed
    end,
    encode = function(vec4: Vector3, t1: table, t2: table) --[[ encode ]] -- line: 48
        local v7 = #t1
        local buf_3 = buffer.create(v7 * 12 + 2)
        buffer.writeu16(buf_3, 0, v7)

        for index = 1, v7 do
            local v8 = (index - 1) * 12 + 2
            local v9 = t1[index] - vec4
            buffer.writei16(buf_3, v8, (math.round(math.clamp(v9.X, -511.984375, 511.984375) * 64)))
            buffer.writei16(
                buf_3,
                v8 + 2,
                (math.round(math.clamp(v9.Y, -511.984375, 511.984375) * 64))
            )
            buffer.writei16(
                buf_3,
                v8 + 4,
                (math.round(math.clamp(v9.Z, -511.984375, 511.984375) * 64))
            )
            local v15 = v8 + 6
            local v16 = t2[index] - vec4
            buffer.writei16(
                buf_3,
                v15,
                (math.round(math.clamp(v16.X, -511.984375, 511.984375) * 64))
            )
            buffer.writei16(
                buf_3,
                v15 + 2,
                (math.round(math.clamp(v16.Y, -511.984375, 511.984375) * 64))
            )
            buffer.writei16(
                buf_3,
                v15 + 4,
                (math.round(math.clamp(v16.Z, -511.984375, 511.984375) * 64))
            )
        end

        return buf_3
    end,
    decode = function(vec5: Vector3, buf3: buffer) --[[ decode ]] -- line: 64
        local buf_4 = buffer.readu16(buf3, 0)
        local t_1 = table.create(buf_4)
        local t_2 = table.create(buf_4)

        for index_1 = 1, buf_4 do
            local v22 = (index_1 - 1) * 12 + 2
            local buf_5 = buffer.readi16(buf3, v22)
            local buf_6 = buffer.readi16(buf3, v22 + 2)
            t_1[index_1] = vec5 + Vector3.new(buf_5, buf_6, (buffer.readi16(buf3, v22 + 4))) / 64
            local v23 = v22 + 6
            local buf_8 = buffer.readi16(buf3, v23)
            local buf_9 = buffer.readi16(buf3, v23 + 2)
            t_2[index_1] = vec5 + Vector3.new(buf_8, buf_9, (buffer.readi16(buf3, v23 + 4))) / 64
        end

        return t_1, t_2
    end
}

local _ = function(buf1: buffer, n2: number, vec3: Vector3) --[[ writeOffset ]] -- line: 37
    local v2 = math.round(math.clamp(vec3.X, -511.984375, 511.984375) * 64)
    buffer.writei16(buf1, n2, v2)
    local v3 = n2 + 2
    local v4 = math.round(math.clamp(vec3.Y, -511.984375, 511.984375) * 64)
    buffer.writei16(buf1, v3, v4)
    local v5 = n2 + 4
    local v6 = math.round(math.clamp(vec3.Z, -511.984375, 511.984375) * 64)
    buffer.writei16(buf1, v5, v6)
end

local _ = function(buf2: buffer, n3: number) --[[ readOffset ]] -- line: 43
    local buf = buffer.readi16(buf2, n3)
    local buf_1 = buffer.readi16(buf2, n3 + 2)
    local buf_2 = buffer.readi16(buf2, n3 + 4)

    return Vector3.new(buf, buf_1, buf_2) / 64
end

return t
