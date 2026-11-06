"""Run gathering lifecycle and cross-feature handoff against a controlled world."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]
LUAU = os.environ.get("LUAU_BIN") or shutil.which("luau")


@unittest.skipUnless(LUAU, "Set LUAU_BIN to execute gathering tests")
class GatherRuntimeTests(unittest.TestCase):
    def test_gating_handoff_blocked_paths_and_teardown(self):
        prefix = r'''
local clock=0
local os={clock=function() return clock end}
local G={VeyraMinigames={enabled=false,active=false}}
local function getgenv() return G end
local signals={}
local function signal()
 local s={listeners={}}
 function s:Connect(fn)
  local c={Connected=true}
  function c:Disconnect() self.Connected=false end
  table.insert(self.listeners,{fn=fn,c=c}) return c
 end
 function s:Fire(...)
  for _,v in ipairs(self.listeners) do if v.c.Connected then v.fn(...) end end
 end
 table.insert(signals,s) return s
end
local vm={}
local function vec(x,y,z) return setmetatable({X=x,Y=y,Z=z},vm) end
vm.__sub=function(a,b) return vec(a.X-b.X,a.Y-b.Y,a.Z-b.Z) end
vm.__add=function(a,b) return vec(a.X+b.X,a.Y+b.Y,a.Z+b.Z) end
vm.__index=function(v,k) if k=="Magnitude" then return math.sqrt(v.X*v.X+v.Y*v.Y+v.Z*v.Z) end end
local Vector3={new=vec,zero=vec(0,0,0)}
local Enum={HumanoidRigType={R6=1,R15=2},RaycastFilterType={Exclude=1},Material={Water=1},PathStatus={Success=1},PathWaypointAction={Jump=1}}
local RaycastParams={new=function() return {} end}
local OverlapParams={new=function() return {} end}
local CFrame={new=function(v) return v end}
local root={Position=vec(0,3,0),Size=vec(2,2,1)}
local moves,holds,ends,computes=0,0,0,0
local h={Health=100,MaxHealth=100,RootPart=root,HipHeight=2}
function h:MoveTo(v) moves+=1 self.goal=v end
function h:Move() end
local char={}
local leg={Size=vec(1,4,1)}
function char:FindFirstChildOfClass() return h end
function char:FindFirstChild(name) if name=="Left Leg" then return leg end return root end
function char:GetAttribute() return false end
local player={Character=char,CharacterRemoving=signal()}
function player:GetAttribute() return false end
local model={Name="Wheat",GetAttribute=function() return nil end}
local part={Position=vec(2,3,0),Parent=model,IsA=function(_,k) return k=="BasePart" end}
local prompt={Name="HarvestPrompt",Parent=part,Enabled=true,MaxActivationDistance=7,HoldDuration=0}
function prompt:IsA(k) return k=="ProximityPrompt" end
function prompt:IsDescendantOf() return true end
function prompt:InputHoldBegin() holds+=1 G.VeyraMinigames.active=true end
function prompt:InputHoldEnd() ends+=1 end
local crops={}
local harvest={FindFirstChild=function(_,n) if n=="Crops" then return crops end end}
local map={FindFirstChild=function() return harvest end}
local workspace={DescendantAdded=signal(),DescendantRemoving=signal()}
function workspace:FindFirstChild() return map end
function workspace:GetDescendants() return {prompt} end
local obstructedApproaches=false
function workspace:GetPartBoundsInBox() return obstructedApproaches and {part} or {} end
function workspace:Blockcast() return nil end
function workspace:Raycast(origin,direction)
 if direction.Y>0 and obstructedApproaches then return {Position=origin,Material=0,Normal=vec(0,1,0)} end
 if direction.Y==-20 then return {Position=vec(origin.X,0,origin.Z),Material=0,Normal=vec(0,1,0)} end
 return nil
end
local task={}
local latest
function task.wait(t) clock+=t or 0.1 coroutine.yield() end
function task.spawn(fn) local t=coroutine.create(fn) latest=t assert(coroutine.resume(t)) return t end
function task.cancel(t) if coroutine.status(t)~="dead" then coroutine.close(t) end end
local focused=false
local services={Players={LocalPlayer=player},UserInputService={GetFocusedTextBox=function() return focused end},
 VirtualInputManager={SendKeyEvent=function() error("Unexpected keyboard input") end},
 PathfindingService={CreatePath=function()
  local p={Status=1,Blocked=signal()}
  function p:ComputeAsync() computes+=1 end
  function p:GetWaypoints() return {{Position=vec(15,0,0)}} end
  return p
 end}}
local game={GetService=function(_,name) return services[name] end}
local state=(function()
'''
        suffix = r'''
end)()
assert(not state.enabled and holds==0 and moves==0)
state.setEnabled(true)
assert(holds==0 and moves==0 and state.status=="Enable Auto Minigames to gather")
state.setEnabled(false)
G.VeyraMinigames.enabled=true focused=true
state.setEnabled(true)
assert(holds==0 and state.status=="Paused for typing")
state.setEnabled(false) focused=false
G.VeyraMinigames.active=true
state.setEnabled(true)
assert(holds==0 and moves==0 and state.phase=="session")
state.setEnabled(false) G.VeyraMinigames.active=false
state.setEnabled(true)
assert(holds==1 and ends==1 and moves==0, "prompt must release on session handoff")
assert(G.VeyraMinigames.enabled and G.VeyraMinigames.active)
state.setEnabled(false)
assert(G.VeyraMinigames.active, "gather stop must not stop minigames")
G.VeyraMinigames.active=false
part.Position=vec(20,3,0)
state.setEnabled(true)
assert(computes==4 and moves==1, "ground path should begin after comparing approaches")
G.VeyraMinigames.active=true
assert(coroutine.resume(latest))
assert(h.goal==root.Position, "a minigame opening during travel must stop movement")
state.setEnabled(false) G.VeyraMinigames.active=false
state.setEnabled(true)
for i=1,100 do
 assert(coroutine.resume(latest))
 if state.stats.skipped==1 then break end
end
assert(computes<=16 and holds==1 and state.stats.stalls==1, "do not repeatedly walk into the same blocked segment")
assert(state.phase=="skipped" and state.stats.skipped==1, "failed node must enter cooldown")
state.setEnabled(false)
clock+=46
state.setEnabled(true)
local before=moves
player.CharacterRemoving:Fire()
assert(not state.enabled and moves==before+1 and h.goal==root.Position, "respawn must cancel movement")
obstructedApproaches=true
local plansBefore=computes
state.setEnabled(true)
assert(computes==plansBefore and not state.status:find("error"), "reject occupied approaches before pathfinding")
state.setEnabled(false)
-- Stale sessions stop gathering without changing the independent minigame module.
obstructedApproaches=false clock+=200
h.RigType=Enum.HumanoidRigType.R6 h.HipHeight=0
root.Position=vec(0,5,0) part.Position=vec(20,8,0)
local r6Moves=moves
state.setEnabled(true)
assert(moves>r6Moves, "R6 standing clearance must include leg height, not just HipHeight")
state.setEnabled(false)
G.VeyraMinigames.active=true
state.setEnabled(true)
clock+=31
assert(coroutine.resume(latest))
assert(state.enabled and state.phase=="session-stalled" and G.VeyraMinigames.active,
 "a stalled session must be abandoned without switching gathering off")
state.stop()
assert(G.VeyraGather==nil and not state.alive)
for _,s in ipairs(signals) do
 for _,l in ipairs(s.listeners) do assert(not l.c.Connected, "leaked listener") end
end
print("PASS: gathering gating, prompt handoff, path cancellation, respawn and teardown")
'''
        with tempfile.TemporaryDirectory() as directory:
            script = Path(directory) / "gather_check.luau"
            script.write_text(prefix + (ROOT / "src/gather.lua").read_text(encoding="utf-8")
                              + suffix, encoding="utf-8")
            result = subprocess.run([LUAU, str(script)], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
