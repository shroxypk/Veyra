-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.PathDisplay
-- Class: ModuleScript
-- bytes: 4515

local UserRaycastPerformanceImprovements = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
).getUserFlag("UserRaycastPerformanceImprovements")
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local t = {
    spacing = 8,
    image = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
    imageSize = Vector2.new(2, 2)
}
local t_1 = {}
local t_2 = {}
local PathDisplayPoints_Model = Instance.new("Model")
PathDisplayPoints_Model.Name = "PathDisplayPoints"
local PathDisplayAdornee_Part = Instance.new("Part")
PathDisplayAdornee_Part.Anchored = true
PathDisplayAdornee_Part.CanCollide = false
PathDisplayAdornee_Part.Transparency = 1
PathDisplayAdornee_Part.Name = "PathDisplayAdornee"
PathDisplayAdornee_Part.CFrame = CFrame.new(0, 0, 0)
PathDisplayAdornee_Part.Parent = PathDisplayPoints_Model
local t_3 = {}
local v1 = 30

for index = 1, v1 do
    local ImageHandleAdornment = Instance.new("ImageHandleAdornment")
    ImageHandleAdornment.Archivable = false
    ImageHandleAdornment.Adornee = PathDisplayAdornee_Part
    ImageHandleAdornment.Image = t.image
    ImageHandleAdornment.Size = t.imageSize
    t_3[index] = ImageHandleAdornment
end

local _ = function() --[[ retrieveFromPool ]] -- line: 41
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] v1 (ref)

    local v2 = t_3[1]

    if not v2 then
        return nil
    end

    t_3[1], t_3[v1] = t_3[v1], nil
    v1 -= 1

    return v2
end

local _ = function(u1: userdata) --[[ returnToPool ]] -- line: 52
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] t_3 (copy)

    v1 += 1
    t_3[v1] = u1
end

local function renderPoint(vec1: Vector3, _: any) -- line: 57
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] t_3 (copy)
    --  [3] UserRaycastPerformanceImprovements (copy)
    --  [4] raycastParams (copy)
    --  [5] PathDisplayPoints_Model (copy)

    if v1 == 0 then
        return nil
    end

    local v3 = t_3[1]
    local v4

    if not v3 then
        v4 = nil
    else
        t_3[1], t_3[v1] = t_3[v1], nil
        v1, v4 = v1 - 1, v3
    end

    if UserRaycastPerformanceImprovements then
        raycastParams.FilterDescendantsInstances = {
            game.Players.LocalPlayer.Character,
            workspace.CurrentCamera
        }
        local v6 = workspace:Raycast(
            vec1 + Vector3.new(0, 2, 0),
            Vector3.new(0, -8, 0),
            raycastParams
        )

        if not v6 then
            return nil
        end

        v4.CFrame = CFrame.lookAlong(v6.Position, v6.Normal)
        v4.Parent = PathDisplayPoints_Model

        return v4
    else
        local v7, v8, v9 = workspace:FindPartOnRayWithIgnoreList(
            Ray.new(vec1 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0)),
            { game.Players.LocalPlayer.Character, workspace.CurrentCamera }
        )

        if not v7 then
            return nil
        end

        v4.CFrame = CFrame.new(v8, v8 + v9)
        v4.Parent = PathDisplayPoints_Model

        return v4
    end
end

function t.setCurrentPoints(arg2) -- line: 89
    -- upvalues:
    --  [1] t_1 (ref)

    if typeof(arg2) == "table" then
        t_1 = arg2

        return
    end

    t_1 = {}
end

function t.clearRenderedPath() -- line: 97
    -- upvalues:
    --  [1] t_2 (ref)
    --  [2] v1 (ref)
    --  [3] t_3 (copy)
    --  [4] PathDisplayPoints_Model (copy)

    for _, val in ipairs(t_2) do
        val.Parent = nil
        v1 += 1
        t_3[v1] = val
    end

    t_2 = {}
    PathDisplayPoints_Model.Parent = nil
end

function t.renderPath() -- line: 106
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (ref)
    --  [3] t_2 (ref)
    --  [4] renderPoint (copy)
    --  [5] PathDisplayPoints_Model (copy)

    t.clearRenderedPath()

    if not t_1 or #t_1 == 0 then
        return
    end

    local v10 = #t_1
    local v11 = 0
    t_2[1] = renderPoint(t_1[v10], true)

    if not t_2[1] then
        return
    end

    while true do
        local v13 = t_1[v10]

        if v10 < 2 then
            break
        end

        local v14 = t_1[v10 - 1] - v13
        local Magnitude = v14.magnitude

        if v11 > Magnitude then
            v11 -= Magnitude
            v10 -= 1
            continue
        end

        local v15 = renderPoint(v13 + v14.unit * v11, false)

        if v15 then
            t_2[#t_2 + 1] = v15
        end

        v11 += t.spacing
    end

    PathDisplayPoints_Model.Parent = workspace.CurrentCamera
end

return t
