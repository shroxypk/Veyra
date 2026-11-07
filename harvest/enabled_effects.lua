-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.services.enabled_effects
-- Class: ModuleScript
-- bytes: 7376

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ModAttributes_m = require("../mod/attributes")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local Emitters_m = require("../emitters")

return {
    init = function(arg1, arg2, arg3) --[[ init ]] -- line: 11
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] Emitters_m (copy)
        --  [3] ModAttributes_m (copy)
        --  [4] RunService (copy)
        --  [5] CollectionService (copy)

        local t_1 = {}
        local t_2 = {}

        local _ = function(u1: userdata) --[[ removeEnabledEffect ]] -- line: 15
            -- upvalues:
            --  [1] t_1 (copy)
            --  [2] ModUtility_m (ref)

            local v1 = t_1[u1]

            if v1 then
                ModUtility_m.cleanupScope(v1)
            end

            t_1[u1] = nil
        end

        local function removeEnabledEffectFull(u2: userdata) -- line: 25
            -- upvalues:
            --  [1] t_1 (copy)
            --  [2] ModUtility_m (ref)
            --  [3] t_2 (copy)

            local v2 = t_1[u2]

            if v2 then
                ModUtility_m.cleanupScope(v2)
            end

            t_1[u2] = nil
            local v3 = t_2[u2]

            if v3 then
                v3:Disconnect()
                t_2[u2] = nil
            end
        end

        local function addEnabledEffect(u3: userdata) -- line: 36
            -- upvalues:
            --  [1] Emitters_m (ref)
            --  [2] t_1 (copy)
            --  [3] t_2 (copy)
            --  [4] addEnabledEffect (copy)
            --  [5] ModUtility_m (ref)
            --  [6] ModAttributes_m (ref)
            --  [7] RunService (ref)
            --  [8] arg3 (copy)
            --  [9] arg2 (copy)

            local v4 = nil

            for _, val in Emitters_m.enabled_registry do
                if val.check(u3) then
                    v4 = val
                    break
                end
            end

            if not v4 then
                return
            end

            local t_3 = {}
            local t_4 = {}
            table.insert(t_4, t_3)
            t_1[u3] = t_4

            if not t_2[u3] then
                t_2[u3] = u3.AncestryChanged:Connect(function() -- line: 59
                    -- upvalues:
                    --  [1] u3 (copy)
                    --  [2] t_1 (ref)
                    --  [3] addEnabledEffect (ref)
                    --  [4] ModUtility_m (ref)

                    if not u3:IsDescendantOf(workspace) then
                        local v5, v6

                        if u3.Parent then
                            if u3.Parent:HasTag("AllowEmitting") then
                                if not t_1[u3] then
                                    addEnabledEffect(u3)

                                    return
                                end
                            else
                                v5 = u3
                                v6 = t_1[v5]

                                if v6 then
                                    ModUtility_m.cleanupScope(v6)
                                end

                                t_1[v5] = nil
                            end

                            return
                        end

                        v5 = u3
                        v6 = t_1[v5]

                        if v6 then
                            ModUtility_m.cleanupScope(v6)
                        end

                        t_1[v5] = nil

                        return
                    else
                        if not t_1[u3] then
                            addEnabledEffect(u3)

                            return
                        end

                        return
                    end
                end)
            end

            local function onEnabled(b1: boolean?) -- line: 70
                -- upvalues:
                --  [1] ModAttributes_m (ref)
                --  [2] u3 (copy)
                --  [3] ModUtility_m (ref)
                --  [4] t_3 (copy)
                --  [5] RunService (ref)
                --  [6] arg3 (ref)
                --  [7] v4 (ref)
                --  [8] arg2 (ref)

                if b1 == nil then
                    b1 = ModAttributes_m.get(u3, "Enabled", true)
                end

                local v8 = ModUtility_m.isForceEmitting(u3) or (u3:IsDescendantOf(workspace) or u3.Parent and u3.Parent:HasTag(
                    "AllowEmitting"
                ))

                if b1 and not v8 then
                    return
                end

                if b1 then
                    ModUtility_m.cleanupScope(t_3)
                    local v10 = 0
                    v8 = { _promises = {}, _scopes = {} }
                    ModUtility_m.setEnabledCancelToken(u3, v8)
                    table.insert(t_3, RunService.RenderStepped:Connect(function() -- line: 93
                        -- upvalues:
                        --  [1] ModAttributes_m (ref)
                        --  [2] u3 (ref)
                        --  [3] v10 (ref)
                        --  [4] arg3 (ref)
                        --  [5] v8 (copy)
                        --  [6] v4 (ref)
                        --  [7] arg2 (ref)
                        --  [8] ModUtility_m (ref)

                        local v11 = ModAttributes_m.get(u3, "Rate", 5)
                        local SpeedOverride = ModAttributes_m.getState(u3, "SpeedOverride", 1)

                        if SpeedOverride == 0 then
                            return
                        end

                        if os.clock() - v10 <= 1 / v11 / SpeedOverride then
                            return
                        end

                        v10 = os.clock()
                        local t_5 = { depth = 0, effects = arg3, _context = v8 }
                        table.insert(v8._scopes, t_5)
                        v4.emit(u3, t_5, arg2)
                        local v12 = table.find(v8._scopes, t_5)

                        if v12 then
                            table.remove(v8._scopes, v12)
                        end

                        ModUtility_m.cleanupScope(t_5)
                    end))

                    return
                end

                ModUtility_m.cleanupScope(t_3)
            end

            table.insert(t_4, ModAttributes_m.hook(u3, "Enabled", onEnabled))
            onEnabled()
        end

        for _, val_1 in CollectionService:GetTagged(ModUtility_m.ENABLED_VFX_TAG) do
            addEnabledEffect(val_1)
        end

        CollectionService:GetInstanceAddedSignal(ModUtility_m.ENABLED_VFX_TAG):Connect(
            addEnabledEffect
        )
        CollectionService:GetInstanceRemovedSignal(ModUtility_m.ENABLED_VFX_TAG):Connect(
            removeEnabledEffectFull
        )
        table.insert(arg1, function() -- line: 141
            -- upvalues:
            --  [1] t_1 (copy)
            --  [2] ModUtility_m (ref)
            --  [3] t_2 (copy)

            for _, val_2 in t_1 do
                ModUtility_m.cleanupScope(val_2)
            end

            for _, val_3 in t_2 do
                val_3:Disconnect()
            end

            table.clear(t_2)
        end)
    end
}
