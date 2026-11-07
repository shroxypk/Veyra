-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX
-- Class: ModuleScript
-- bytes: 7735

local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SelfModLogger_m = require("@self/mod/logger")
local SelfModUtility_m = require("@self/mod/utility")
local SelfModAttributes_m = require("@self/mod/attributes")
local SelfEffectsSound_m = require("@self/effects/sound")
local SelfEffectsBezier_m = require("@self/effects/bezier")
local SelfEffectsLightning_m = require("@self/effects/lightning")
local SelfEffectsCameraShake_m = require("@self/effects/camera_shake")
local SelfEffectsShockwaveRing_m = require("@self/effects/shockwave_ring")
local SelfEffectsShockwaveLine_m = require("@self/effects/shockwave_line")
local SelfEffectsShockwaveDebris_m = require("@self/effects/shockwave_debris")
local SelfServicesCaches_m = require("@self/services/caches")
local SelfServicesEffects_m = require("@self/services/effects")
local SelfServicesTextureLoader_m = require("@self/services/texture_loader")
local SelfServicesEnabledEffects_m = require("@self/services/enabled_effects")
local PLUGINCONTEXT = SelfModUtility_m.PLUGIN_CONTEXT
local t = { scope = {}, setup = false }
local SERVERCONTEXT = SelfModUtility_m.SERVER_CONTEXT

function t.init(_: table?) -- line: 117
    -- upvalues:
    --  [1] t (copy)
    --  [2] SERVERCONTEXT (copy)
    --  [3] SelfModUtility_m (copy)
    --  [4] SelfModLogger_m (copy)
    --  [5] RunService (copy)
    --  [6] PLUGINCONTEXT (copy)
    --  [7] SelfServicesCaches_m (copy)
    --  [8] SelfServicesEffects_m (copy)
    --  [9] SelfServicesTextureLoader_m (copy)
    --  [10] SelfServicesEnabledEffects_m (copy)
    --  [11] SelfEffectsSound_m (copy)
    --  [12] SelfEffectsCameraShake_m (copy)
    --  [13] SelfEffectsBezier_m (copy)
    --  [14] SelfEffectsLightning_m (copy)
    --  [15] SelfEffectsShockwaveRing_m (copy)
    --  [16] SelfEffectsShockwaveLine_m (copy)
    --  [17] SelfEffectsShockwaveDebris_m (copy)

    if t.setup then
        return
    end

    if SERVERCONTEXT then
        task.spawn(function() -- line: 123
            -- upvalues:
            --  [1] SelfModUtility_m (ref)
            --  [2] SelfModLogger_m (ref)

            local v1 = 0
            local Result
            local v2

            repeat
                v1 += 1
                local Success
                Success, Result = pcall(
                    SelfModUtility_m.setCollisionGroups,
                    SelfModUtility_m.COLLISION_GROUPS
                )
                v2 = Success

                if not v2 then
                    task.wait(v1)
                end
            until v2 or v1 >= 5

            if not v2 then
                SelfModLogger_m.warn(
                    `couldn't register necessary collision groups after {v1} tries with the last error being: {Result}`
                )
            end
        end)
    end

    t.setup = true

    if RunService:IsServer() and not PLUGINCONTEXT then
        return
    end

    t.caches = SelfServicesCaches_m.init(t.scope)
    shared.vfx = t
    SelfServicesEffects_m.init(t)
    SelfServicesTextureLoader_m.init(t.scope)
    SelfServicesEnabledEffects_m.init(t.scope, t.caches.shared_part, SelfServicesEffects_m)
    SelfEffectsSound_m.init()
    SelfEffectsCameraShake_m.init()
    SelfEffectsBezier_m.init(t.caches.shared_part)
    SelfEffectsLightning_m.init(t.caches.shared_part)
    SelfEffectsShockwaveRing_m.init(t.caches.shared_part)
    SelfEffectsShockwaveLine_m.init(t.caches.shared_part)
    SelfEffectsShockwaveDebris_m.init(t.caches.shared_part)
end

function t.deinit() -- line: 177
    -- upvalues:
    --  [1] t (copy)
    --  [2] RunService (copy)
    --  [3] PLUGINCONTEXT (copy)
    --  [4] SelfModUtility_m (copy)
    --  [5] SelfServicesEffects_m (copy)
    --  [6] SelfEffectsSound_m (copy)
    --  [7] SelfEffectsBezier_m (copy)
    --  [8] SelfEffectsLightning_m (copy)
    --  [9] SelfEffectsCameraShake_m (copy)
    --  [10] SelfEffectsShockwaveRing_m (copy)
    --  [11] SelfEffectsShockwaveLine_m (copy)
    --  [12] SelfEffectsShockwaveDebris_m (copy)
    --  [13] CollectionService (copy)

    if not t.setup then
        return
    end

    t.setup = false
    shared.vfx = nil

    if RunService:IsServer() and not PLUGINCONTEXT then
        return
    end

    SelfModUtility_m.cleanupScope(t.scope)
    SelfServicesEffects_m.deinit()
    SelfEffectsSound_m.deinit()
    SelfEffectsBezier_m.deinit()
    SelfEffectsLightning_m.deinit()
    SelfEffectsCameraShake_m.deinit()
    SelfEffectsShockwaveRing_m.deinit()
    SelfEffectsShockwaveLine_m.deinit()
    SelfEffectsShockwaveDebris_m.deinit()

    for _, val in (CollectionService:GetTagged(SelfModUtility_m.CLEANUP_TAG)) do
        val:Destroy()
    end
end

local function fullEmit(_: number, n2: number, ...) -- line: 209
    -- upvalues:
    --  [1] t (copy)
    --  [2] SelfModLogger_m (copy)
    --  [3] SelfServicesEffects_m (copy)

    if not t.setup then
        SelfModLogger_m.error("not initialized")
    end

    return SelfServicesEffects_m.emit(n2, ...)
end

function t.emit(arg1, ...) -- line: 217
    -- upvalues:
    --  [1] fullEmit (copy)

    if typeof(arg1) ~= "number" then
        return fullEmit(1, 0, arg1, ...)
    end

    return fullEmit(arg1, 0, ...)
end

function t.emitWithDepth(n3: number, ...) -- line: 225
    -- upvalues:
    --  [1] fullEmit (copy)

    return fullEmit(1, n3, ...)
end

function t.cacheAttributes(u1: userdata, b1: boolean) -- line: 229
    -- upvalues:
    --  [1] SelfModUtility_m (copy)
    --  [2] SelfModLogger_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] SelfModAttributes_m (copy)

    if SelfModUtility_m.SERVER_CONTEXT then
        SelfModLogger_m.error("attributes can only be cached in a client-side context")
    end

    if not u1:IsDescendantOf(ReplicatedStorage) then
        SelfModLogger_m.error("attributes can only be cached for VFX inside ReplicatedStorage")
    end

    SelfModAttributes_m.cache(u1)

    if b1 then
        return
    end

    for _, descendant in u1:GetDescendants() do
        SelfModAttributes_m.cache(descendant)
    end
end

function t.restoreAttributes(u2: userdata, b2: boolean?) -- line: 249
    -- upvalues:
    --  [1] SelfModUtility_m (copy)
    --  [2] SelfModLogger_m (copy)
    --  [3] SelfModAttributes_m (copy)

    if SelfModUtility_m.SERVER_CONTEXT then
        SelfModLogger_m.error("attributes can only be restored in a client-side context")
    end

    SelfModAttributes_m.restore(u2)

    if b2 then
        return
    end

    for _, descendant_1 in u2:GetDescendants() do
        SelfModAttributes_m.restore(descendant_1)
    end
end

local function setEnabled(u3: userdata, b3: boolean) -- line: 265
    -- upvalues:
    --  [1] SelfModAttributes_m (copy)

    if u3:IsA("ParticleEmitter") then
        u3.Enabled = b3

        return
    end

    if u3:IsA("Beam") then
        u3.Enabled = b3

        return
    end

    if SelfModAttributes_m.isCached(u3) then
        SelfModAttributes_m.trigger(u3, "Enabled", b3)

        return
    end

    u3:SetAttribute("Enabled", b3)
end

function t.enable(u4: userdata) -- line: 281
    -- upvalues:
    --  [1] setEnabled (copy)

    setEnabled(u4, true)

    for _, descendant_2 in u4:GetDescendants() do
        setEnabled(descendant_2, true)
    end
end

function t.disable(u5: userdata) -- line: 289
    -- upvalues:
    --  [1] setEnabled (copy)

    setEnabled(u5, false)

    for _, descendant_3 in u5:GetDescendants() do
        setEnabled(descendant_3, false)
    end
end

t.retime = require("@self/mod/retime").batch
t.resize = require("@self/mod/resize").batch
t.recolor = require("@self/mod/recolor")

return t
