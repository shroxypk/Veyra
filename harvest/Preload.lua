-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Preload
-- Class: LocalScript
-- bytes: 4630

local v1 = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local v2 = v1.LocalPlayer
local t = {
    Animation = { "AnimationId" },
    Sound = { "SoundId" },
    Decal = { "Texture" },
    Texture = { "Texture" },
    ParticleEmitter = { "Texture" },
    MeshPart = { "MeshId", "TextureID" },
    SpecialMesh = { "MeshId", "TextureId" },
    Shirt = { "ShirtTemplate" },
    Pants = { "PantsTemplate" }
}
local t_1 = {}
local t_2 = {}

local function collect(arg1, arg2, arg3) -- line: 39
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t (copy)
    --  [3] t_1 (copy)

    arg3 = arg3 or t_2

    for _, descendant in arg1:GetDescendants() do
        local v4 = t[descendant.ClassName]

        if v4 then
            local v5 = false

            for _, val in v4 do
                local v6 = descendant[val]

                if typeof(v6) == "string" and v6 ~= "" and not arg3[v6] then
                    arg3[v6] = true
                    t_1[v6] = descendant
                    v5 = true
                end
            end

            if v5 then
                table.insert(arg2, descendant)
            end
        elseif descendant:IsA("SurfaceAppearance") then
            table.insert(arg2, descendant)
        end
    end

    return arg2
end

local function preload(arg4, arg5) -- line: 64
    -- upvalues:
    --  [1] ContentProvider (copy)
    --  [2] RunService (copy)
    --  [3] t_1 (copy)

    if #arg4 == 0 then
        return
    end

    local clock = os.clock()
    ContentProvider:PreloadAsync(arg4, function(arg6, arg7) -- line: 70
        -- upvalues:
        --  [1] RunService (ref)
        --  [2] t_1 (ref)

        if arg7 ~= Enum.AssetFetchStatus.Success and RunService:IsStudio() then
            local v7 = t_1[arg6]
            warn("Failed to preload:", arg6, arg7, v7 and v7:GetFullName() or "")
        end
    end)

    if RunService:IsStudio() then
        print(("Preloaded %d %s instances in %.1fs"):format(#arg4, arg5, os.clock() - clock))
    end
end

local _ = function(arg8, arg9) --[[ preloadFolder ]] -- line: 82
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] preload (copy)
    --  [3] collect (copy)

    local v11 = ReplicatedStorage:FindFirstChild(arg8)

    if v11 then
        preload(collect(v11, {}), arg9)
    end
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local function waitForDungeonPreload() -- line: 99
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    local v13 = os.clock() + 15

    repeat
        local DungeonPreload = ReplicatedStorage:FindFirstChild("DungeonPreload")

        if DungeonPreload then
            return DungeonPreload
        end

        local InstanceSource = workspace:GetAttribute("InstanceSource")

        if InstanceSource and InstanceSource ~= "KamoDungeon" then
            return nil
        end

        task.wait(0.1)
    until v13 < os.clock()

    return nil
end

task.spawn(function() -- line: 117
    -- upvalues:
    --  [1] waitForDungeonPreload (copy)
    --  [2] preload (copy)
    --  [3] collect (copy)

    local v14 = waitForDungeonPreload()

    if not v14 then
        return
    end

    preload(collect(v14, {}, {}), "dungeon")
    local Loaded = v14:FindFirstChild("Loaded")

    if Loaded then
        Loaded:FireServer()
    end
end)
local Animations = ReplicatedStorage:FindFirstChild("Animations")

if Animations then
    preload(collect(Animations, {}), "animation")
end

if not v2.Character then
    v2.CharacterAdded:Wait()
end

local t_3 = {}

for _, val_1 in v1:GetPlayers() do
    if val_1.Character then
        collect(val_1.Character, t_3)
    end
end

preload(t_3, "character")
v2:SetAttribute("Preloaded", true)
local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
v1 = Remotes

if v1 then
    v1 = Remotes:FindFirstChild("PreloadReady")
end

if v1 then
    v1:FireServer()
end

local Effects = ReplicatedStorage:FindFirstChild("Effects")

if Effects then
    preload(collect(Effects, {}), "effect")
end

v1 = ReplicatedStorage:FindFirstChild("SFX")

if v1 then
    preload(collect(v1, {}), "sound")
end

local PlayerScripts = v2:WaitForChild("PlayerScripts", 30)
v2 = PlayerScripts

if v2 then
    v2 = PlayerScripts:WaitForChild("CloverClient", 30)
end

if v2 then
    preload(collect(v2, {}), "client effect")
end

local HalloweenPreload = ReplicatedStorage:FindFirstChild("HalloweenPreload")

if HalloweenPreload then
    preload(collect(HalloweenPreload, {}), "Halloween model")
end
