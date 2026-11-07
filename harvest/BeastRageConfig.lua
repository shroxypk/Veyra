-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.BeastRageConfig
-- Class: ModuleScript
-- bytes: 774

return {
    RAGE_ATTRIBUTE = "RageMode",
    STORE_ATTRIBUTE = "rageStore",
    MAX_ATTRIBUTE = "rageStoreMax",
    MAX_RAGE = 390,
    DRAIN_PER_TICK = 3,
    DRAIN_INTERVAL = 0.35714285714285715,
    RAGE_PER_DAMAGE = 1,
    MIN_RAGE_PER_HIT = 3,
    MAX_RAGE_PER_HIT = 20,
    STUDIO_FULL_RAGE = true,
    M1_SPEED_MULTIPLIER = 1.15,
    WALKSPEED_MULTIPLIER = 1.15,
    MISDIRECT_FX_COMBO = 4,
    MAUL_PROC_CHANCE = 0.2,
    MAUL_PROC_COOLDOWN = 2,
    MAUL_BITE_DAMAGE = 8,
    MAUL_BITE_DELAY = 0.05,
    MAUL_BITE_FROM = "BehindTarget",
    MAUL_BITE_DISTANCE = 14,
    MAUL_BITE_SPEED = 2,
    ROAR_SPEED = 1.15,
    ROAR_TICK_DAMAGE = 3,
    ROAR_FINAL_DAMAGE = 6,
    ROAR_FINAL_KNOCKBACK = { Direction = "Look", Force = 35, DisableRagdoll = false, Time = 1 }
}
