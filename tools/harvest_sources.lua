-- Source Harvester (Veyra tool) — v2
--
-- Decompiles every client-readable LuaSourceContainer (ModuleScript, Script,
-- LocalScript) across all replicated trees into readable source under
--
--   serverscripts/<PlaceId>/sources/<instance path>.lua
--
-- plus serverscripts/<PlaceId>/sources/manifest.json. Containers that can't
-- be decompiled (e.g. server-side Scripts, which the client never compiles)
-- are listed in `failed` and skipped — no crash.
--
-- READ-ONLY, same safety profile as the rest of the toolkit: pure reads,
-- no remotes fired, no state writes. getscriptbytecode/decompile are opaque.
--
-- Usage:
--   loadstring(game:HttpGet("https://raw.githubusercontent.com/<you>/Veyra/main/tools/harvest_sources.lua"))()
--   (or run via Madium: run_executor_file Veyra/tools/harvest_sources.lua)
--
-- While it runs: getgenv().HS.status()  -> {done, total, failed}
-- Stop it any time: getgenv().HS.stop()

local HS = { done = 0, total = 0, failed = 0, stopped = false }
getgenv().HS = HS
function HS.stop() HS.stopped = true end
function HS.status()
  return { done = HS.done, total = HS.total, failed = HS.failed, stopped = HS.stopped, byTree = HS.byTree }
end

local PlaceId = game.PlaceId
local OUTDIR = string.format("serverscripts/%d/sources", PlaceId)
local HttpService = game:GetService("HttpService")
local manifest = { placeId = PlaceId, modules = {}, failed = {} }
HS.byTree = {}

local function ensureDir(path)
  if type(makedir) == "function" and type(isfolder) == "function" then
    local ok, has = pcall(isfolder, path)
    if ok and not has then pcall(makedir, path) end
  end
end

local function sanitize(name)
  return (tostring(name):gsub("[%z%p]", "_"))
end

local function writeSource(inst, source)
  local rel = sanitize(inst:GetFullName()):gsub("%.", "/")
  local parent = rel:match("^(.*)/[^/]*$") or ""
  local dir = OUTDIR .. (parent ~= "" and ("/" .. parent) or "")
  ensureDir(dir)
  local path = string.format("%s/%s.lua", dir, sanitize(inst.Name))
  local body = string.format(
    "-- Decompiled with Veyra harvester\n-- Instance: %s\n-- Class: %s\n-- bytes: %d\n\n%s",
    inst:GetFullName(), inst.ClassName, #source, source)
  return pcall(writefile, path, body) and path or nil
end

local function isCodeContainer(inst)
  return inst:IsA("ModuleScript") or inst:IsA("Script") or inst:IsA("LocalScript")
end

local CONTAINER_SERVICES = { "ReplicatedStorage", "ReplicatedFirst", "StarterGui", "StarterPlayer", "StarterPack" }

local function collect()
  local found, seen = {}, {}
  local containers = {}
  for _, svcName in ipairs(CONTAINER_SERVICES) do
    pcall(function()
      containers[#containers+1] = { name = svcName, inst = game:GetService(svcName) }
    end)
  end
  containers[#containers+1] = { name = "Workspace", inst = workspace }
  for _, c in ipairs(containers) do
    if c.inst then
      for _, inst in ipairs(c.inst:GetDescendants()) do
        if isCodeContainer(inst) and not seen[inst] then
          seen[inst] = true
          inst:SetAttribute("__harvestTree", c.name)
          found[#found + 1] = inst
        end
      end
    end
  end
  table.sort(found, function(a, b) return a:GetFullName() < b:GetFullName() end)
  return found
end

print(string.format("[hs] place %d — collecting all code containers…", PlaceId))
local modules = collect()
HS.total = #modules
print(string.format("[hs] %d code containers across all trees", HS.total))

for _, inst in ipairs(modules) do
  if HS.stopped then break end
  local ok, source = pcall(decompile, inst)
  if ok and type(source) == "string" and #source > 0 then
    local path = writeSource(inst, source)
    if path then
      local tree = inst:GetAttribute("__harvestTree") or "?"
      HS.byTree[tree] = (HS.byTree[tree] or 0) + 1
      manifest.modules[#manifest.modules + 1] = {
        path = inst:GetFullName(), class = inst.ClassName, tree = tree,
        bytes = #source, file = path,
      }
      HS.done = HS.done + 1
    else
      manifest.failed[#manifest.failed + 1] = { path = inst:GetFullName(), why = "write" }
      HS.failed = HS.failed + 1
    end
  else
    manifest.failed[#manifest.failed + 1] = { path = inst:GetFullName(), why = "not readable" }
    HS.failed = HS.failed + 1
  end
  if HS.done % 100 == 0 and HS.done > 0 then
    print(string.format("[hs] %d/%d…", HS.done, HS.total))
  end
  task.wait()
end

pcall(writefile, OUTDIR .. "/manifest.json", HttpService:JSONEncode(manifest))
print(string.format("[hs] done: %d decompiled (%d failed) across trees", HS.done, HS.failed))
for tree, n in pairs(HS.byTree) do
  print(string.format("[hs]   %-18s %d", tree, n))
end
