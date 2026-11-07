-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Headless.Headless_M1_Fx
-- Class: ModuleScript
-- bytes: 3098

local HeadlessFxUtil_m = require(script.Parent.HeadlessFxUtil)
local Assets = script.Assets
local t = { "Slash1Slice", [3] = "FInalHit" }
local t_1 = { true }
local t_2 = {}
local t_3 = { Name = "Smoke", Turn = CFrame.Angles(0, 1.5707963267948966, 0) }
local t_4 = { { "Slash1" }, { "Slash2" }, { "Slash3" } }
t_2[3] = t_3
local cframe = CFrame.new(0, 27.5, 0.3)

local _ = function(vec1: Vector3) --[[ flat ]] -- line: 31
    return (Vector3.new(vec1.X, 0, vec1.Z))
end

local function groundLine(u1: userdata, u2: CFrame, n1: number) -- line: 35
    -- upvalues:
    --  [1] Assets (copy)
    --  [2] t (copy)
    --  [3] t_1 (copy)
    --  [4] HeadlessFxUtil_m (copy)
    --  [5] cframe (copy)
    --  [6] t_2 (copy)

    local v1 = Assets:FindFirstChild(t[n1] or "")

    if v1 and t_1[n1] then
        HeadlessFxUtil_m.Place(v1, u2)

        return
    end

    local v2 = v1

    if v2 then
        v2 = HeadlessFxUtil_m.FindBone(u1, "WeaponHandle.L")
    end

    if not v2 then
        return
    end

    local TransformedWorldCFrame = v2.TransformedWorldCFrame
    v2 = (TransformedWorldCFrame * cframe).Position
    local v3 = TransformedWorldCFrame.Position - v2
    local vec3_2 = Vector3.new(v3.X, 0, v3.Z)

    if vec3_2.Magnitude < 1 then
        local v5 = -u2.LookVector
        vec3_2 = Vector3.new(v5.X, 0, v5.Z)
    end

    local v6 = (TransformedWorldCFrame.Position + v2) / 2
    local vec3 = Vector3.new(v6.X, u2.Position.Y - 1 + 0.15, v6.Z)
    HeadlessFxUtil_m.PlaceAt(v1, CFrame.lookAt(vec3, vec3 + vec3_2.Unit))
    local v7 = t_2[n1]
    v6 = v7

    if v6 then
        v6 = Assets:FindFirstChild(v7.Name)
    end

    if v6 then
        local v8 = v6:GetAttribute("Offset") or CFrame.identity
        local v9 = TransformedWorldCFrame.Position:Lerp(v2, 0.65)
        local vec3_1 = Vector3.new(v9.X, u2.Position.Y + v8.Y, v9.Z)
        HeadlessFxUtil_m.PlaceAt(
            v6,
            CFrame.lookAt(vec3_1, vec3_1 - vec3_2.Unit) * v7.Turn * v8.Rotation
        )
    end
end

return function(u3: userdata, arg1: any, n2: number?) -- line: 70
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] groundLine (copy)
    --  [3] t_4 (copy)
    --  [4] Assets (copy)

    local v10 = HeadlessFxUtil_m.Feet(u3)

    if not v10 then
        return
    end

    if arg1 == "Swing" then
        local v11 = u3:FindFirstChild("HumanoidRootPart") or u3.PrimaryPart

        if v11 then
            HeadlessFxUtil_m.Sound(`M1Swing{n2}`, v11)
        end

        return
    end

    if arg1 == "Ground" then
        groundLine(u3, v10, n2)

        if n2 == 3 then
            HeadlessFxUtil_m.Shake(
                v10.Position,
                4,
                10,
                0.6,
                150
            )
        end

        return
    end

    local v12 = t_4[arg1] or {}

    for _, val in v12 do
        local v13 = Assets:FindFirstChild(val)

        if v13 then
            HeadlessFxUtil_m.Place(v13, v10)
        end
    end

    HeadlessFxUtil_m.Shake(
        v10.Position,
        1.5,
        8,
        0.3,
        80
    )
end
