-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.screen
-- Class: ModuleScript
-- bytes: 2594

local RunService = game:GetService("RunService")
local ModAttributes_m = require("../mod/attributes")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")

return {
    emit = function(u1: userdata, arg1: any) --[[ emit ]] -- line: 9
        -- upvalues:
        --  [1] ModAttributes_m (copy)
        --  [2] ModUtility_m (copy)
        --  [3] RunService (copy)

        if not u1:GetAttribute("Enabled") then
            return
        end

        local v1 = ModAttributes_m.get(u1, "PartScale", Vector3.new(1, 1, 1))
        local v2 = ModAttributes_m.get(u1, "PartDistance", 1.5)
        local v3 = ModAttributes_m.get(u1, "OffsetPosition", Vector3.new(0, 0, 0))
        local v5 = ModAttributes_m.get(u1, "OffsetRotation", Vector3.new(0, 0, 0)) * ModUtility_m.DEG_TO_RAD
        local v6 = u1.CFrame
        local Size = u1.Size
        local CollisionGroup = u1.CollisionGroup
        u1.CollisionGroup = "ForgeMouseIgnore"
        table.insert(arg1, function() -- line: 26
            -- upvalues:
            --  [1] u1 (copy)
            --  [2] Size (copy)
            --  [3] v6 (copy)
            --  [4] CollisionGroup (copy)

            u1.Size = Size
            u1.CFrame = v6
            u1.CollisionGroup = if CollisionGroup == "" then "Default" else CollisionGroup or "Default"
        end)

        local function frame() -- line: 33
            -- upvalues:
            --  [1] v2 (copy)
            --  [2] u1 (copy)
            --  [3] v1 (copy)
            --  [4] v3 (copy)
            --  [5] v5 (copy)

            local CurrentCamera = workspace.CurrentCamera
            local v8 = math.rad(CurrentCamera.FieldOfView / 2)
            local v9 = math.tan(v8) * v2 * 2
            local v10 = CurrentCamera.ViewportSize.X / CurrentCamera.ViewportSize.Y * v9
            local v12 = CurrentCamera.CFrame * CFrame.new(0, 0, -v2)
            u1.Size = Vector3.new(v10, v9, u1.Size.Z) * v1
            u1.CFrame = v12 * CFrame.new(v3) * CFrame.fromOrientation(v5.x, v5.y, v5.z)
        end

        if not RunService:IsRunning() then
            table.insert(arg1, RunService.RenderStepped:Connect(frame))
        else
            local v16 = ModUtility_m.getRandomId()
            RunService:BindToRenderStep(v16, Enum.RenderPriority.Last.Value + 2 + arg1.depth, frame)
            table.insert(arg1, function() -- line: 53
                -- upvalues:
                --  [1] RunService (ref)
                --  [2] v16 (copy)

                RunService:UnbindFromRenderStep(v16)
            end)
        end

        return true
    end
}
