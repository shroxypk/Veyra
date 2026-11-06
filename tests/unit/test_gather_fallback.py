"""Gathering must move on to the next node when the nearest one has no route."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]
LUAU = os.environ.get("LUAU_BIN") or shutil.which("luau")


@unittest.skipUnless(LUAU, "Set LUAU_BIN to execute gathering tests")
class GatherFallbackTests(unittest.TestCase):
    def test_unroutable_node_does_not_block_the_cycle(self):
        prefix = r'''
local clock=0
local os={clock=function() return clock end}
local G={VeyraMinigames={enabled=true,active=false}}
local function getgenv() return G end
local signals={}
local function signal()
 local s={listeners={}}
 function s:Connect(fn)
  local c={Connected=true}
  function c:Disconnect() self.Connected=false end
  table.insert(self.listeners,{fn=fn,c=c}) return c
 end
 table.insert(signals,s) return s
end
local vm={}
local function vec(x,y,z) return setmetatable({X=x,Y=y,Z=z},vm) end
vm.__sub=function(a,b) return vec(a.X-b.X,a.Y-b.Y,a.Z-b.Z) end
vm.__add=function(a,b) return vec(a.X+b.X,a.Y+b.Y,a.Z+b.Z) end
vm.__index=function(v,k) if k=="Magnitude" then return math.sqrt(v.X*v.X+v.Y*v.Y+v.Z*v.Z) end end
local Vector3={new=vec,zero=vec(0,0,0)}
local Enum={HumanoidRigType={R6=1,R15=2},RaycastFilterType={Exclude=1},Material={Water=1},
 PathStatus={Success=1,NoPath=2},PathWaypointAction={Jump=1}}
local RaycastParams={new=function() return {} end}
local CFrame={new=function(v) return v end}
local root={Position=vec(0,3,0),Size=vec(2,2,1)}
local moves,holds,maxGoalX=0,0,0
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
local function makeNode(x,name)
 local model={Name=name,GetAttribute=function() return nil end}
 local part={Position=vec(x,3,0),Parent=model,IsA=function(_,k) return k=="BasePart" end}
 local prompt={Name="HarvestPrompt",Parent=part,Enabled=true,MaxActivationDistance=7,HoldDuration=0}
 function prompt:IsA(k) return k=="ProximityPrompt" end
 function prompt:IsDescendantOf() return true end
 function prompt:InputHoldBegin() holds+=1 end
 function prompt:InputHoldEnd() end
 return prompt
end
local near=makeNode(2,"Near")
local far=makeNode(12,"Far")
local crops={}
local harvest={FindFirstChild=function(_,n) if n=="Crops" then return crops end end}
local map={FindFirstChild=function() return harvest end}
local workspace={DescendantAdded=signal(),DescendantRemoving=signal()}
function workspace:FindFirstChild() return map end
function workspace:GetDescendants() return {near,far} end
function workspace:Blockcast() return nil end
function workspace:Raycast(origin,direction)
 if direction.Y==-20 then return {Position=vec(origin.X,0,origin.Z),Material=0,Normal=vec(0,1,0)} end
 return nil
end
local task={}
local latest
function task.wait(t) clock+=t or 0.1 coroutine.yield() end
function task.spawn(fn) local t=coroutine.create(fn) latest=t assert(coroutine.resume(t)) return t end
function task.cancel(t) if coroutine.status(t)~="dead" then coroutine.close(t) end end
local services={Players={LocalPlayer=player},
 UserInputService={GetFocusedTextBox=function() return false end},
 VirtualInputManager={SendKeyEvent=function() end},
 PathfindingService={CreatePath=function()
  local p={Status=1,Blocked=signal()}
  function p:ComputeAsync(_,goal)
   if goal.X>maxGoalX then maxGoalX=goal.X end
   self.Status=goal.X<8 and 2 or 1
  end
  function p:GetWaypoints() return {{Position=vec(maxGoalX,0,0)}} end
  return p
 end}}
local game={GetService=function(_,name) return services[name] end}
local state=(function()
'''
        suffix = r'''
end)()
state.setEnabled(true)
for i=1,200 do
 assert(coroutine.resume(latest))
 if state.stats.skipped>=2 then break end
end
assert(maxGoalX>=8, "the next candidate must be planned after the nearest node has no route")
assert(state.stats.skipped>=2, "both unreachable nodes must be cooled down in the same cycle")
assert(not state.status:find("error"), state.status)
state.stop()
for _,s in ipairs(signals) do
 for _,l in ipairs(s.listeners) do assert(not l.c.Connected, "leaked listener") end
end
print("PASS: gathering falls through to the next candidate")
'''
        with tempfile.TemporaryDirectory() as directory:
            script = Path(directory) / "gather_fallback.luau"
            script.write_text(prefix + (ROOT / "src/gather.lua").read_text(encoding="utf-8")
                              + suffix, encoding="utf-8")
            result = subprocess.run([LUAU, str(script)], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
