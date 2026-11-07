-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.MagicCircle
-- Class: ModuleScript
-- bytes: 1301

local t = {}
local t_1 = {}
t_1.__index = t_1

function t_1.new(arg1, arg2) -- line: 7
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t (copy)

    local t_2 = setmetatable({}, t_1)
    t_2.LifeTime = arg2
    local v1 = script.MagicCircle:Clone()
    local v2 = arg1
    local Decal = v1.Decal

    if not v2 then
        v2 = Color3.fromRGB(255, 255, 255)
    end

    Decal.Color3 = v2
    v1.Anchored = true
    v1.Parent = workspace.Effects
    t_2.Part = v1
    t_2.Decal = v1.Decal
    t_2.Clock = os.clock()
    t_2.Index = #t + 1
    t[t_2.Index] = t_2

    return t_2
end

function t_1.Animate(_) -- line: 26
end

function t_1.Destroy(arg4) -- line: 30
    -- upvalues:
    --  [1] t (copy)

    _G.Tween(arg4.Decal, { 0.35, "Quad", "Out" }, { Transparency = 1 }, false)
    t[arg4.Index] = nil
    _G.Debris(arg4.Part, 1)
end

require(game.ReplicatedStorage.Modules.BindToRender).createRender("MagicCircle", script).Event:Connect(
    function() -- line: 42
        -- upvalues:
        --  [1] t (copy)

        for _, val in pairs(t) do
            if os.clock() - val.Clock < val.LifeTime then
                val.Part.CFrame = val.Part.CFrame * CFrame.fromEulerAnglesXYZ(0, 0.045, 0)
            else
                val:Destroy()
            end
        end
    end
)

return t_1
