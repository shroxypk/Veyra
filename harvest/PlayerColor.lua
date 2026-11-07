-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.HumanoidHandler.PlayerColor
-- Class: ModuleScript
-- bytes: 1012

local t = {
    Color3.new(0.9921568627450981, 0.1607843137254902, 0.2627450980392157),
    Color3.new(0.00392156862745098, 0.6352941176470588, 1),
    Color3.new(0.00784313725490196, 0.7215686274509804, 0.3411764705882353),
    BrickColor.new("Bright violet").Color,
    BrickColor.new("Bright orange").Color,
    BrickColor.new("Bright yellow").Color,
    BrickColor.new("Light reddish violet").Color,
    BrickColor.new("Brick yellow").Color
}

local function GetNameValue(arg1) -- line: 13
    local v1 = 0

    for index = 1, #arg1 do
        local v3 = string.byte((string.sub(arg1, index, index)))
        local v2 = #arg1 - index + 1

        if #arg1 % 2 == 1 then
            v2 -= 1
        end

        if v2 % 4 >= 2 then
            v3 = -v3
        end

        v1 += v3
    end

    return v1
end

local function ComputeNameColor(arg2) -- line: 30
    -- upvalues:
    --  [1] t (copy)
    --  [2] GetNameValue (copy)

    return t[(GetNameValue(arg2) + 0) % #t + 1]
end

return ComputeNameColor
