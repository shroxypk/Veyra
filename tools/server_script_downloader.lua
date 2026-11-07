-- Server Script Downloader (Veyra tool)
--
-- Based on Righted1's public ServerScriptDownloader (croak14_ / inferiousmalder),
-- rebuilt for Madium and wrapped with our house rules:
--   * Read-only. It reads hidden properties and loads package models with
--     InsertService:LoadLocalAsset — the same asset path the client uses to
--     render models. It never fires a remote, never writes game state.
--   * Only real packages are touched (SourceAssetId > 100). Everything else
--     is produced locally; no HTTP, no outsider requests.
--   * Dedupe by asset id, resume-aware (skips files already on disk), and it
--     records every script it writes in manifest.json (name, class, parent,
--     asset id, bytes, path).
--   * Failure-soft: one bad asset is logged and skipped, never fatal.
--   * Stoppable: getgenv().SD.stop()
--   * Also harvests client-visible Module bytecode (getscriptbytecode pass)
--     so state managers, command frameworks and other replicated modules are
--     captured for offline review. That pass is a *read*, same as the collector.
--
-- Usage:
--   loadstring(game:HttpGet("https://raw.githubusercontent.com/<you>/Veyra/main/tools/server_script_downloader.lua"))()
--   (or run the local file via Madium: run_executor_file Veyra/tools/server_script_downloader.lua)
--
-- Output (relative to the executor workspace):
--   serverscripts/<PlaceId>/<ScriptName>.lua   — sources from packages
--   serverscripts/<PlaceId>/manifest.json      — index of everything saved
--   serverscripts/<PlaceId>/bytecode/<path>.lua — harvested local modules,
--                                                  as bytecode-bearing copies

-- ============================================================
-- Config
-- ============================================================
local cfg = {
  SaveModules   = true,   -- also dump ModuleScripts found inside packages
  HarvestBytecode = true, -- extra pass: getscriptbytecode harvest
  SkipExisting  = true,   -- resume support
  MaxAssets     = 1000,   -- hard stop for huge places
}
if getgenv().SDcfg then
  for k, v in pairs(getgenv().SDcfg) do cfg[k] = v end
end

local PlaceId = game.PlaceId
local OUTDIR  = string.format("serverscripts/%d", PlaceId)
local manifest = { placeId = PlaceId, models = {}, bytecode = {}, failed = {} }

local stop = false
local SD = { doneCount = 0, scriptCount = 0 }
getgenv().SD = SD
function SD.stop() stop = true end

local function ensureDir(path)
  if type(makedir) == "function" and type(isfolder) == "function" then
    local ok, has = pcall(isfolder, path)
    if ok and not has then pcall(makedir, path) end
  end
end

ensureDir(OUTDIR)

-- ============================================================
-- 1) Enumerate real packages (SourceAssetId > 100, deduped)
-- ============================================================
local function collectIds()
  local seen, list = {}, {}
  for _, inst in ipairs(game:GetDescendants()) do
    if inst:IsA("Model") then
      local b
      if gethiddenproperty then
        local ok, v = pcall(gethiddenproperty, inst, "SourceAssetId")
        if ok then b = v end
      end
      if b == nil then
        local ok, v = pcall(function() return inst.SourceAssetId end)
        if ok then b = v end
      end
      if type(b) == "number" and b > 100 and not seen[b] then
        seen[b] = true
        list[#list + 1] = { id = b, name = inst.Name, path = inst:GetFullName() }
      end
    end
  end
  return list
end

-- ============================================================
-- 2) Load each package locally and dump scripts
-- ============================================================
local function sanitize(name)
  return (tostring(name):gsub("/", ""):gsub("%z", ""):gsub("%p", ""))
end

local function saveScript(script, assetId, counterRef)
  local name = sanitize(script.Name)
  if name == "" then name = "unnamed" end
  local path = string.format("%s/%s.lua", OUTDIR, name)
  if cfg.SkipExisting and type(isfile) == "function" then
    local ok, has = pcall(isfile, path)
    if ok and has then return path end
  end
  if type(isfile) == "function" then
    local ok, has = pcall(isfile, path)
    if ok and has then
      path = string.format("%s/%s_%d.lua", OUTDIR, name, counterRef.n)
      counterRef.n = counterRef.n + 1
    end
  end
  local ok, src = pcall(function() return script.Source end)
  if not ok or type(src) ~= "string" then return nil end
  local header = string.format(
    "-- Saved with ServerScriptDownloader (Veyra)\n-- Parent: %s\n-- AssetId: %d\n-- Class: %s\n\n",
    tostring(script.Parent and script.Parent.Name), assetId, script.ClassName)
  local wOk = pcall(writefile, path, header .. src)
  if not wOk then return nil end
  SD.scriptCount = SD.scriptCount + 1
  return { path = path, bytes = #src, class = script.ClassName,
           name = script.Name, parent = tostring(script.Parent and script.Parent.Name) }
end

local function processAsset(entry, counterRef)
  local model
  local ok, m = pcall(function()
    return game.InsertService:LoadLocalAsset("rbxassetid://" .. tostring(entry.id))
  end)
  if not ok or m == nil then
    manifest.failed[#manifest.failed + 1] = { id = entry.id, err = "load failed" }
    return
  end
  model = m
  local saved = {}
  local descendants = {}
  if typeof(model) == "Instance" then
    descendants = model:GetDescendants()
  elseif type(model) == "table" then
    for _, inst in ipairs(model) do
      if typeof(inst) == "Instance" then
        descendants[#descendants + 1] = inst
        for _, d in ipairs(inst:GetDescendants()) do descendants[#descendants + 1] = d end
      end
    end
  end
  for _, sc in ipairs(descendants) do
    if stop then break end
    local isServerScript = sc:IsA("Script") and sc.RunContext == Enum.RunContext.Server
    local isModule = cfg.SaveModules and sc:IsA("ModuleScript")
    if isServerScript or isModule then
      local rec = saveScript(sc, entry.id, counterRef)
      if rec then saved[#saved + 1] = rec end
    end
  end
  manifest.models[#manifest.models + 1] = {
    id = entry.id, name = entry.name, path = entry.path, scripts = saved,
  }
  SD.doneCount = SD.doneCount + 1
  print(string.format("[sd] %d %s → %d scripts", entry.id, entry.name, #saved))
end

print(string.format("[sd] place %d — enumerating packages…", PlaceId))
local assets = collectIds()
print(string.format("[sd] %d unique package assets", #assets))

local counterRef = { n = 1000 }
for i, entry in ipairs(assets) do
  if stop then break end
  if i > cfg.MaxAssets then
    print(string.format("[sd] MaxAssets %d reached — stopping", cfg.MaxAssets))
    break
  end
  processAsset(entry, counterRef)
  task.wait()
end

-- ============================================================
-- 3) Extra: bytecode harvest of client-visible modules
--    (state managers, command frameworks, replicated systems)
-- ============================================================
if cfg.HarvestBytecode and getscriptbytecode then
  local BDIR = OUTDIR .. "/bytecode"
  ensureDir(BDIR)
  local RS = game:GetService("ReplicatedStorage")
  local harvested, skipped = 0, 0
  for _, inst in ipairs(RS:GetDescendants()) do
    if stop then break end
    if inst:IsA("ModuleScript") then
      local ok, bytes = pcall(getscriptbytecode, inst)
      if ok and type(bytes) == "string" and #bytes > 0 then
        local rel = sanitize(inst:GetFullName()):gsub("%.", "/")
        local parent = rel:match("^(.*)/[^/]*$") or ""
        local dir = BDIR .. (parent ~= "" and ("/" .. parent) or "")
        ensureDir(dir)
        local path = dir .. "/" .. sanitize(inst.Name) .. ".lua"
        local body = "-- bytecode: " .. inst:GetFullName() .. "\n-- bytes: " .. tostring(#bytes) .. "\n"
        if pcall(writefile, path, body .. bytes) then
          manifest.bytecode[#manifest.bytecode + 1] = { path = inst:GetFullName(), bytes = #bytes }
          harvested = harvested + 1
        else
          skipped = skipped + 1
        end
      else
        skipped = skipped + 1
      end
    end
  end
  print(string.format("[sd] bytecode harvest: %d modules (%d skipped)", harvested, skipped))
end

pcall(writefile, OUTDIR .. "/manifest.json", game:GetService("HttpService"):JSONEncode(manifest))
print(string.format("[sd] done: %d assets, %d scripts, %d bytecode modules, %d failures",
  SD.doneCount, SD.scriptCount, #manifest.bytecode, #manifest.failed))
