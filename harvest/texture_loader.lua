-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.services.texture_loader
-- Class: ModuleScript
-- bytes: 8911

local CollectionService = game:GetService("CollectionService")
local ObjObjectCache_m = require("../obj/ObjectCache")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local ModCommonFlipbook_m = require("../mod/common/flipbook")

return {
    init = function(arg1) --[[ init ]] -- line: 11
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] ObjObjectCache_m (copy)
        --  [3] ModCommonFlipbook_m (copy)
        --  [4] CollectionService (copy)

        local Decal = Instance.new("Decal")
        local DONOTREMOVEForgeTextureCache_Part = Instance.new("Part")
        DONOTREMOVEForgeTextureCache_Part.Name = "DO_NOT_REMOVE_ForgeTextureCache"
        DONOTREMOVEForgeTextureCache_Part.Transparency = 1
        DONOTREMOVEForgeTextureCache_Part.Size = Vector3.new(0, 0, 0)
        DONOTREMOVEForgeTextureCache_Part.Archivable = false
        DONOTREMOVEForgeTextureCache_Part.Anchored = true
        DONOTREMOVEForgeTextureCache_Part.CanCollide = false
        DONOTREMOVEForgeTextureCache_Part.CanQuery = false
        DONOTREMOVEForgeTextureCache_Part.Locked = true
        DONOTREMOVEForgeTextureCache_Part.Parent = workspace.Terrain
        ModUtility_m.protectParent(arg1, DONOTREMOVEForgeTextureCache_Part)
        local v1 = ObjObjectCache_m.new(Decal, DONOTREMOVEForgeTextureCache_Part, {
            size = 360,
            on_free = function(arg2) --[[ on_free ]] -- line: 29
                arg2.value.Texture = ""
            end
        })
        local t_1 = {}

        local function createLoader(u1: userdata, f1: (...any) -> ...any, f2: ((...any) -> ...any)?) -- line: 36
            -- upvalues:
            --  [1] ModUtility_m (ref)
            --  [2] v1 (copy)
            --  [3] t_1 (copy)

            local t_2 = {}
            local t_3 = {}
            table.insert(t_2, t_3)

            local function refresh() -- line: 46
                -- upvalues:
                --  [1] ModUtility_m (ref)
                --  [2] t_3 (copy)
                --  [3] v1 (ref)
                --  [4] f1 (copy)

                ModUtility_m.cleanupScope(t_3)

                local function add(s1: string) -- line: 49
                    -- upvalues:
                    --  [1] v1 (ref)
                    --  [2] t_3 (ref)

                    if s1 == "" then
                        return
                    end

                    v1:get(s1).Texture = s1
                    table.insert(t_3, function() -- line: 57
                        -- upvalues:
                        --  [1] v1 (ref)
                        --  [2] s1 (copy)

                        v1:free(s1)
                    end)
                end

                f1(add)
            end

            ModUtility_m.cleanupScope(t_3)
            f1(function(s2: string) --[[ add ]] -- line: 49
                -- upvalues:
                --  [1] v1 (ref)
                --  [2] t_3 (copy)

                if s2 == "" then
                    return
                end

                v1:get(s2).Texture = s2
                table.insert(t_3, function() -- line: 57
                    -- upvalues:
                    --  [1] v1 (ref)
                    --  [2] s2 (copy)

                    v1:free(s2)
                end)
            end)

            if ModUtility_m.PLUGIN_CONTEXT and f2 then
                for _, val in f2((ModUtility_m.reboundfn(1, refresh))) do
                    table.insert(t_2, val)
                end
            end

            t_1[u1] = t_2
        end

        local function loadTextures(u2: userdata) -- line: 78
            -- upvalues:
            --  [1] ModUtility_m (ref)
            --  [2] createLoader (copy)
            --  [3] ModCommonFlipbook_m (ref)

            if u2:IsDescendantOf(workspace.Terrain) then
                return
            end

            if ModUtility_m.isMeshVFX(u2) then
                local Start = u2:FindFirstChild("Start")

                if Start then
                    if not Start:IsA("BasePart") then
                        return
                    end

                    createLoader(u2, function(arg3) -- line: 90
                        -- upvalues:
                        --  [1] ModUtility_m (ref)
                        --  [2] u2 (copy)
                        --  [3] Start (copy)
                        --  [4] ModCommonFlipbook_m (ref)

                        local v2, v3 = ModUtility_m.getMeshDecals(u2, Start)

                        for _, val_1 in v2 do
                            local v5 = val_1.Texture

                            if typeof(val_1) == "string" or not v5 then
                                v5 = val_1
                            end

                            arg3(v5)
                        end

                        for _, val_2 in v3 do
                            local v6 = ModCommonFlipbook_m.getTexturePrefix(u2)

                            for _, val_3 in val_2 do
                                arg3(`{v6}{val_3}`)
                            end
                        end
                    end, function(arg4) -- line: 104
                        -- upvalues:
                        --  [1] Start (copy)

                        local _ = {}

                        return {
                            Start.DescendantAdded:Connect(arg4),
                            Start.DescendantRemoving:Connect(arg4)
                        }
                    end)

                    return
                else
                    return
                end
            else
                if u2:IsA("Beam") then
                    createLoader(u2, function(arg7) -- line: 111
                        -- upvalues:
                        --  [1] u2 (copy)
                        --  [2] ModCommonFlipbook_m (ref)

                        arg7(u2.Texture)
                        local v14 = ModCommonFlipbook_m.getFlipbookData(u2)

                        if v14 then
                            local v15 = ModCommonFlipbook_m.getTexturePrefix(u2)

                            for _, val_7 in v14 do
                                arg7(`{v15}{val_7}`)
                            end
                        end
                    end, function(arg8) -- line: 123
                        -- upvalues:
                        --  [1] u2 (copy)

                        local _ = {}

                        return {
                            u2:GetPropertyChangedSignal("Texture"):Connect(arg8),
                            u2.AttributeChanged:Connect(arg8)
                        }
                    end)

                    return
                end

                createLoader(u2, function(arg9) -- line: 130
                    -- upvalues:
                    --  [1] u2 (copy)

                    local _ = function(u3: userdata) --[[ check ]] -- line: 131
                        -- upvalues:
                        --  [1] arg9 (copy)

                        if u3:IsA("ParticleEmitter") then
                            arg9(u3.Texture)
                        end
                    end

                    local v17 = u2

                    if v17:IsA("ParticleEmitter") then
                        arg9(v17.Texture)
                    end

                    for _, descendant in u2:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            arg9(descendant.Texture)
                        end
                    end
                end, function(arg10) -- line: 142
                    -- upvalues:
                    --  [1] u2 (copy)

                    local _ = {}

                    return {
                        u2.DescendantAdded:Connect(arg10),
                        u2.DescendantRemoving:Connect(arg10)
                    }
                end)

                return
            end
        end

        for _, val_8 in CollectionService:GetTagged(ModUtility_m.TEXTURE_LOAD_TAG) do
            loadTextures(val_8)
        end

        CollectionService:GetInstanceAddedSignal(ModUtility_m.TEXTURE_LOAD_TAG):Connect(
            loadTextures
        )
        CollectionService:GetInstanceRemovedSignal(ModUtility_m.TEXTURE_LOAD_TAG):Connect(function(
            arg11
        ) -- line: 156
            -- upvalues:
            --  [1] t_1 (copy)
            --  [2] ModUtility_m (ref)

            local v20 = t_1[arg11]

            if v20 then
                ModUtility_m.cleanupScope(v20)
                t_1[arg11] = nil
            end
        end)
        table.insert(arg1, function() -- line: 165
            -- upvalues:
            --  [1] v1 (copy)
            --  [2] t_1 (copy)
            --  [3] ModUtility_m (ref)

            v1:destroy()

            for _, val_9 in t_1 do
                ModUtility_m.cleanupScope(val_9)
            end
        end)
    end
}
