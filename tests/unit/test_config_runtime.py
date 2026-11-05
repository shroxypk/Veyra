"""Execute the settings store with mocked file I/O and a controlled task queue."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]
LUAU = os.environ.get("LUAU_BIN") or shutil.which("luau")


@unittest.skipUnless(LUAU, "Set LUAU_BIN or install luau to execute settings tests")
class ConfigRuntimeTests(unittest.TestCase):
    def test_merge_debounce_reset_failure_and_unload(self):
        prefix = '''
local G,queue={},{}
local writes,fail=0,false
local saved={flag=false,range="bad",nested={value=7},unknown=true}
local function getgenv() return G end
local function readfile() return "saved" end
local function writefile()
 if fail then error("disk unavailable") end
 writes+=1
end
local function makefolder() end
local game={GetService=function()
 return {JSONDecode=function() return saved end,JSONEncode=function() return "json" end}
end}
local task={delay=function(_,fn) table.insert(queue,fn) end}
local state=(function()
'''
        suffix = '''
end)()
local prefs=state.load({flag=true,range=14,nested={value=1}})
assert(prefs.flag==false and prefs.range==14 and prefs.nested.value==7)
assert(prefs.unknown==nil)
state.set("range",15) state.set("range",16)
assert(#queue==1 and writes==0)
table.remove(queue,1)()
assert(writes==1 and not state.dirty)
fail=true state.set("range",17)
table.remove(queue,1)()
assert(state.dirty and state.lastError)
fail=false assert(state.flush()) assert(not state.lastError)
state.patch("nested",{value=99})
local reset=state.reset()
assert(reset.nested.value==1 and reset.flag==true)
reset.nested.value=22
assert(state.reset().nested.value==1, "reset must deep-copy defaults")
state.set("range",18)
state.stop()
local stoppedWrites=writes
for _,fn in ipairs(queue) do fn() end
assert(writes==stoppedWrites and G.VeyraConfig==nil and not state.alive)
print("PASS: settings merge, debounce, write retry, reset, teardown")
'''
        with tempfile.TemporaryDirectory() as directory:
            script = Path(directory) / "config_check.luau"
            script.write_text(prefix + (ROOT / "src/config.lua").read_text(encoding="utf-8")
                              + suffix, encoding="utf-8")
            result = subprocess.run([LUAU, str(script)], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
