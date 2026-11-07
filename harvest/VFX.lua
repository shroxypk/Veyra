-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Shared.VFX
-- Class: ModuleScript
-- bytes: 14017

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ForgeVFX_m = require(ReplicatedStorage.Modules.Packages.ForgeVFX)
local Attributes_m = require(ReplicatedStorage.Modules.Packages.ForgeVFX.mod.attributes)
local t = {}
local v1 = false

function t.init() -- line: 33
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] ForgeVFX_m (copy)
    --  [3] ReplicatedStorage (copy)

    if v1 then
        return
    end

    v1 = true
    ForgeVFX_m.init()
    ForgeVFX_m.cacheAttributes(ReplicatedStorage.Effects.VFX)
end

function t.getAttribute(u1: userdata, s1: string, arg1: any) -- line: 54
    -- upvalues:
    --  [1] Attributes_m (copy)

    return Attributes_m.get(u1, s1, arg1, true)
end

function t.preload(t1: table) -- line: 61
    -- upvalues:
    --  [1] ContentProvider (copy)

    task.spawn(function() -- line: 62
        -- upvalues:
        --  [1] ContentProvider (ref)
        --  [2] t1 (copy)

        pcall(function() -- line: 63
            -- upvalues:
            --  [1] ContentProvider (ref)
            --  [2] t1 (ref)

            ContentProvider:PreloadAsync(t1)
        end)
    end)
end

function t.retime(u2: userdata, n1: number) -- line: 77
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    if n1 == 1 then
        return
    end

    ForgeVFX_m.retime(n1, u2)
end

local function place(u3: userdata, u4: CFrame) -- line: 84
    if u3:IsA("BasePart") then
        u3.CFrame = u4

        return
    end

    if u3:IsA("Model") then
        u3:PivotTo(u4)

        return
    end

    local children = u3:GetChildren()
    local v2 = nil

    for _, val in children do
        if val:IsA("Model") then
            v2 = val:GetPivot()
            break
        end

        if val:IsA("BasePart") then
            v2 = val.CFrame
            break
        end
    end

    if not v2 then
        return
    end

    for _, val_1 in children do
        if val_1:IsA("Model") then
            val_1:PivotTo(u4 * v2:ToObjectSpace(val_1:GetPivot()))
        elseif val_1:IsA("BasePart") then
            val_1.CFrame = u4 * v2:ToObjectSpace(val_1.CFrame)
        end
    end
end

local function weldRoots(u5: userdata, u6: userdata) -- line: 132
    if u5:IsA("BasePart") then
        u5.Massless = true
    end

    for _, descendant in u5:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Massless = true
        end
    end

    local _ = function(u7: userdata) --[[ weldPart ]] -- line: 142
        -- upvalues:
        --  [1] u6 (copy)

        u7.Anchored = false
        local Weld = Instance.new("Weld")
        Weld.Part0 = u6
        Weld.Part1 = u7
        Weld.C0 = u6.CFrame:ToObjectSpace(u7.CFrame)
        Weld.Parent = u7
    end

    local function weldTree(u8: userdata) -- line: 153
        -- upvalues:
        --  [1] u6 (copy)
        --  [2] weldTree (copy)

        if u8:IsA("BasePart") then
            u8.Anchored = false
            local Weld_1 = Instance.new("Weld")
            Weld_1.Part0 = u6
            Weld_1.Part1 = u8
            Weld_1.C0 = u6.CFrame:ToObjectSpace(u8.CFrame)
            Weld_1.Parent = u8

            return
        end

        if u8:IsA("Model") then
            local v4 = u8.PrimaryPart or u8:FindFirstChildWhichIsA("BasePart", true)

            if v4 then
                v4.Anchored = false
                local Weld_2 = Instance.new("Weld")
                Weld_2.Part0 = u6
                Weld_2.Part1 = v4
                Weld_2.C0 = u6.CFrame:ToObjectSpace(v4.CFrame)
                Weld_2.Parent = v4

                return
            end
        else
            for _, child in u8:GetChildren() do
                weldTree(child)
            end
        end
    end

    weldTree(u5)
end

local function hasConstantEffect(u9: userdata) -- line: 171
    if u9:HasTag("ConstantVFX") then
        return true
    end

    for _, descendant_1 in u9:GetDescendants() do
        if descendant_1:HasTag("ConstantVFX") then
            return true
        end
    end

    return false
end

local _ = function(u10: userdata, u11: CFrame, u12: userdata?) --[[ prepare ]] -- line: 183
    -- upvalues:
    --  [1] place (copy)

    local v5 = u10:Clone()
    place(v5, u11)
    v5.Parent = u12 or workspace

    return v5
end

function t.burst(u13: userdata, u14: CFrame, u15: userdata?, n2: number?) -- line: 196
    -- upvalues:
    --  [1] place (copy)
    --  [2] ForgeVFX_m (copy)

    local v7 = u13:Clone()
    place(v7, u14)
    v7.Parent = u15 or workspace
    local clock = os.clock()
    ForgeVFX_m.emit(v7).Finished:catch(function(arg2) -- line: 202
        -- upvalues:
        --  [1] u13 (copy)

        local g_warn = warn
        local v9 = u13:GetFullName()
        g_warn(`[VFX] emit failed for {v9}: {arg2}`)
    end):finally(function() -- line: 208
        -- upvalues:
        --  [1] n2 (copy)
        --  [2] clock (copy)
        --  [3] v7 (copy)

        local v12 = (n2 or 0) - (os.clock() - clock)

        if v12 > 0 then
            task.delay(v12, function() -- line: 211
                -- upvalues:
                --  [1] v7 (ref)

                v7:Destroy()
            end)

            return
        end

        v7:Destroy()
    end)

    return v7
end

function t.burstChild(u16: userdata, u17: CFrame, s2: string, u18: userdata?) -- line: 231
    -- upvalues:
    --  [1] place (copy)
    --  [2] ForgeVFX_m (copy)

    local v13 = u16:Clone()
    place(v13, u17)
    local v14 = u18 or workspace
    v13.Parent = v14
    v14 = v13:FindFirstChild(s2, true)

    if not v14 then
        v13:Destroy()

        return nil
    end

    ForgeVFX_m.emit(v14).Finished:catch(function(arg3) -- line: 242
        -- upvalues:
        --  [1] u16 (copy)
        --  [2] s2 (copy)

        local g_warn_1 = warn
        local v15 = u16:GetFullName()
        g_warn_1(`[VFX] emit failed for {v15}.{s2}: {arg3}`)
    end):finally(function() -- line: 245
        -- upvalues:
        --  [1] v13 (copy)

        v13:Destroy()
    end)

    return v13
end

function t.findBezier(u19: userdata) -- line: 261
    for _, descendant_2 in u19:GetDescendants() do
        if descendant_2:IsA("Attachment") and descendant_2:FindFirstChild("Points") then
            return descendant_2
        end
    end

    return nil
end

function t.findBowHandle(u20: userdata) -- line: 276
    local Points = u20:FindFirstChild("Points")

    if not Points then
        return nil
    end

    local v17 = nil
    local v18 = math.huge

    for _, child_1 in Points:GetChildren() do
        local num = tonumber(child_1.Name)

        if child_1:IsA("Attachment") and num and v18 > num then
            v17 = child_1
            v18 = num
        end
    end

    v18 = v17

    if v18 then
        v18 = v17:FindFirstChild("T0")
    end

    if v18 and v18:IsA("Attachment") then
        return v18
    end

    return nil
end

function t.burstBezier(
    u21: userdata,
    u22: CFrame,
    vec1: Vector3,
    vec2: Vector3?,
    u23: userdata?
) -- line: 301
    -- upvalues:
    --  [1] place (copy)
    --  [2] t (copy)
    --  [3] ForgeVFX_m (copy)

    local v19 = u21:Clone()
    place(v19, u22)
    local v20 = u23 or workspace
    v19.Parent = v20
    v20 = t.findBezier(v19)
    local v21 = v20

    if v21 then
        v21 = v20:FindFirstChild("End")
    end

    if v21 then
        if not v21:IsA("Attachment") then
            v19:Destroy()

            return nil
        end

        v21.WorldPosition = vec1

        if vec2 then
            v21 = t.findBowHandle(v20)

            if v21 then
                v21.WorldPosition = vec2
            end
        end

        ForgeVFX_m.emit(v19).Finished:finally(function() -- line: 327
            -- upvalues:
            --  [1] v19 (copy)

            v19:Destroy()
        end)

        return v19
    else
        v19:Destroy()

        return nil
    end
end

function t.sustainAttached(u24: userdata, u25: userdata, u26: CFrame, u27: userdata?) -- line: 337
    -- upvalues:
    --  [1] place (copy)
    --  [2] weldRoots (copy)
    --  [3] hasConstantEffect (copy)
    --  [4] ForgeVFX_m (copy)

    local v22 = u24:Clone()
    place(v22, u25.CFrame * u26)
    v22.Parent = u27 or u25
    weldRoots(v22, u25)
    local v23 = false

    if hasConstantEffect(v22) then
        task.defer(function() -- line: 351
            -- upvalues:
            --  [1] v23 (ref)
            --  [2] v22 (copy)
            --  [3] ForgeVFX_m (ref)

            if not v23 and v22.Parent then
                ForgeVFX_m.enable(v22)
            end
        end)
    else
        ForgeVFX_m.enable(v22)
    end

    local t_1 = { Instance = v22, Stop = nil }

    function t_1.Stop(n3: number?) -- line: 362
        -- upvalues:
        --  [1] v23 (ref)
        --  [2] ForgeVFX_m (ref)
        --  [3] v22 (copy)

        if v23 then
            return
        end

        v23 = true
        ForgeVFX_m.disable(v22)
        task.delay(n3 or 2, function() -- line: 369
            -- upvalues:
            --  [1] v22 (ref)

            v22:Destroy()
        end)
    end

    return t_1
end

function t.burstAttached(u28: userdata, u29: userdata, u30: CFrame, n4: number?) -- line: 380
    -- upvalues:
    --  [1] place (copy)
    --  [2] weldRoots (copy)
    --  [3] ForgeVFX_m (copy)

    local v24 = u28:Clone()
    place(v24, u29.CFrame * u30)
    v24.Parent = u29
    weldRoots(v24, u29)
    local clock_1 = os.clock()
    ForgeVFX_m.emit(v24).Finished:catch(function(arg4) -- line: 395
        -- upvalues:
        --  [1] u28 (copy)

        local g_warn_2 = warn
        local v25 = u28:GetFullName()
        g_warn_2(`[VFX] emit failed for {v25}: {arg4}`)
    end):finally(function() -- line: 398
        -- upvalues:
        --  [1] n4 (copy)
        --  [2] clock_1 (copy)
        --  [3] v24 (copy)

        local v28 = (n4 or 0) - (os.clock() - clock_1)

        if v28 > 0 then
            task.delay(v28, function() -- line: 401
                -- upvalues:
                --  [1] v24 (ref)

                v24:Destroy()
            end)

            return
        end

        v24:Destroy()
    end)

    return v24
end

function t.burstOnto(u31: userdata, u32: userdata, u33: CFrame?) -- line: 422
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    local t_2 = {}
    local v30

    for _, val_2 in if u31:IsA("Attachment") then { u31 } else u31:GetChildren() do
        if not val_2:IsA("Attachment") then
            if not val_2:IsA("ParticleEmitter") then
                if not val_2:IsA("Beam") then
                    if val_2:IsA("Trail") then
                        v30 = val_2:Clone()

                        if u33 and v30:IsA("Attachment") then
                            v30.CFrame = u33
                        end

                        v30.Parent = u32
                        table.insert(t_2, v30)
                    end
                else
                    v30 = val_2:Clone()

                    if u33 and v30:IsA("Attachment") then
                        v30.CFrame = u33
                    end

                    v30.Parent = u32
                    table.insert(t_2, v30)
                end
            else
                v30 = val_2:Clone()

                if u33 and v30:IsA("Attachment") then
                    v30.CFrame = u33
                end

                v30.Parent = u32
                table.insert(t_2, v30)
            end
        else
            v30 = val_2:Clone()

            if u33 and v30:IsA("Attachment") then
                v30.CFrame = u33
            end

            v30.Parent = u32
            table.insert(t_2, v30)
        end
    end

    if #t_2 == 0 then
        return t_2
    end

    ForgeVFX_m.emit(table.unpack(t_2)).Finished:finally(function() -- line: 447
        -- upvalues:
        --  [1] t_2 (copy)

        for _, val_3 in t_2 do
            val_3:Destroy()
        end
    end)

    return t_2
end

function t.randomPointInBox(u34: CFrame, vec3: Vector3, n5: number, u35: userdata?) -- line: 460
    local v31 = u35 or Random.new()
    local v32 = vec3 / 2

    for _ = 1, 8 do
        local v34 = v31:NextNumber(-v32.X, v32.X)
        local v36 = v31:NextNumber(-v32.Y, v32.Y)
        local vec3_1 = Vector3.new(v34, v36, v31:NextNumber(-v32.Z, v32.Z))

        if not (n5 <= 0) then
            if n5 <= Vector3.new(vec3_1.X, 0, vec3_1.Z).Magnitude then
                return (u34 * CFrame.new(vec3_1)).Position
            end
        else
            return (u34 * CFrame.new(vec3_1)).Position
        end
    end

    local v38 = v31:NextNumber() * 3.141592653589793 * 2
    local v39 = math.cos(v38) * n5
    local v41 = v31:NextNumber(-v32.Y, v32.Y)
    local vec3_2 = Vector3.new(v39, v41, math.sin(v38) * n5)

    return (u34 * CFrame.new(vec3_2)).Position
end

function t.sustain(u36: userdata, u37: CFrame, u38: userdata?) -- line: 488
    -- upvalues:
    --  [1] place (copy)
    --  [2] hasConstantEffect (copy)
    --  [3] ForgeVFX_m (copy)

    local v42 = u36:Clone()
    place(v42, u37)
    v42.Parent = u38 or workspace
    local v43 = false

    if hasConstantEffect(v42) then
        task.defer(function() -- line: 496
            -- upvalues:
            --  [1] v43 (ref)
            --  [2] v42 (copy)
            --  [3] ForgeVFX_m (ref)

            if not v43 and v42.Parent then
                ForgeVFX_m.enable(v42)
            end
        end)
    else
        ForgeVFX_m.enable(v42)
    end

    local t_3 = { Instance = v42, Stop = nil }

    function t_3.Stop(n6: number?) -- line: 507
        -- upvalues:
        --  [1] v43 (ref)
        --  [2] ForgeVFX_m (ref)
        --  [3] v42 (copy)

        if v43 then
            return
        end

        v43 = true
        ForgeVFX_m.disable(v42)
        task.delay(n6 or 2, function() -- line: 514
            -- upvalues:
            --  [1] v42 (ref)

            v42:Destroy()
        end)
    end

    return t_3
end

return t
