-- Decompiled with Veyra harvester
-- Instance: Workspace.FightableNPCS.Kamo Guard Respawnable.Path
-- Class: ModuleScript
-- bytes: 290

local Points = script.Points
local t = { ID = 1, Points = {}, CurrentPoint = 1, TotalPaths = 0, Direction = "+" }

for index = 1, #Points:GetChildren() do
    local _ = #Points:GetChildren()
    t.Points[index] = Points[index].Position
    t.TotalPaths += 1
end

Points:Destroy()

return t
