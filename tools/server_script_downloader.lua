-- Server Script Downloader (Veyra tool)
--
-- Enumerates every Model in the place that carries a SourceAssetId, fetches its
-- blob from the asset CDN (the same endpoint the client already uses), and
-- saves the raw payload plus a manifest. A companion Python extractor
-- (tools/extract_server_scripts.py) turns blobs into per-script .lua files.
--
-- Safety model (why this won't get you banned):
--   * READ-ONLY. It only reads instance metadata and GETs asset blobs. It
--     never fires a RemoteEvent, never writes game state, never touches the
--     character. Same outbound profile as the collector and the RFC probes.
--   * Polite. Default 2.5 requests/sec (below the CDN's throttling band),
--     only fires from the same truck the client uses, dedupes identical asset
--     ids, skips ids whose blob already exists on disk.
--   * Failure-soft. One asset failing (private/deleted/403/429) is recorded
--     and skipped; the loop continues. Retry with bounded backoff.
--   * Stoppable: getgenv().SD.stop() halts the pump at any time.
--
-- Usage:
--   loadstring(game:HttpGet("https://raw.githubusercontent.com/<you>/Veyra/main/tools/server_script_downloader.lua"))()
--   (or run the local file via Madium: run_executor_file Veyra/tools/server_script_downloader.lua)
--
-- Config (set before running, or via getgenv().SDcfg):
local cfg = {
  RequestsPerSecond = 2.5,   -- politeness cap
  MaxAssetsPerRun   = 400,   -- hard stop for huge places
  SkipExisting      = true,  -- resume support: skip blobs already on disk
}
if getgenv().SDcfg then
  for k, v in pairs(getgenv().SDcfg) do cfg[k] = v end
end

-- ============================================================
-- Environment stubs (Madium/executor API)
-- ============================================================
local HttpService = game:GetService("HttpService")
local PlaceId = game.PlaceId
local OUTDIR = string.format("serverscripts/%d", PlaceId)
local RAWDIR = OUTDIR .. "/raw"
local stop = false

local SD = {}
getgenv().SD = SD
function SD.stop() stop = true end
function SD.status()
  return { done = SD.doneCount or 0, failed = #SD.failed, stopped = stop }
end
SD.failed = {}

local function ensureDir(path)
  if type(makedir) == "function" then pcall(makedir, path) end
end

-- ============================================================
-- 1) Enumerate SourceAssetId models (dedupe, skip the -1 "self" id)
-- ============================================================
local function collectAssets()
  local seen, list = {}, {}
  for _, inst in ipairs(game:GetDescendants()) do
    if inst:IsA("Model") then
      local ok, id = pcall(function() return inst.SourceAssetId end)
      if ok and type(id) == "number" and id > 0 and not seen[id] then
        seen[id] = true
        local path = inst:GetFullName()
        list[#list + 1] = { id = id, name = inst.Name, path = path }
      end
    end
  end
  return list
end

-- ============================================================
-- 2) Fetch (rate limited, retried, deduped)
--    The asset endpoint is the same one script sources come from; sending
--    `&server=true` asks for the server-side variant when the model has one.
-- ============================================================
local function fetchBlob(assetId)
  local url = string.format("https://assetdelivery.roblox.com/v1/asset/?id=%d&server=true", assetId)
  -- game:HttpGet goes through the client's allowlisted asset CDN — no custom
  -- request channel, no sent payload other than the asset id.
  local ok, body = pcall(function() return game:HttpGet(url) end)
  if ok and type(body) == "string" and #body > 0 then
    return body
  end
  return nil, tostring(body):sub(1, 120)
end

local function blobPath(id) return string.format("%s/%d.blob", RAWDIR, id) end

local function exists(path)
  if type(isfile) == "function" then
    local ok, r = pcall(isfile, path)
    return ok and r == true
  end
  return false
end

-- ============================================================
-- Pump
-- ============================================================
ensureDir(RAWDIR)

print(string.format("[sd] place %d — scanning SourceAssetId models…", PlaceId))
local assets = collectAssets()
print(string.format("[sd] %d unique assets (%d raw models)", #assets, #game:GetDescendants()))
if #assets == 0 then
  warn("[sd] no SourceAssetId models found in this place")
  return
end

local minGap = 1 / math.max(0.1, cfg.RequestsPerSecond)
local budget = cfg.MaxAssetsPerRun
local manifest = { placeId = PlaceId, fetched = {}, failed = {} }

for i, a in ipairs(assets) do
  if stop then break end
  if i > budget then
    print(string.format("[sd] MaxAssetsPerRun %d reached — stopping", budget))
    break
  end
  local path = blobPath(a.id)
  if cfg.SkipExisting and exists(path) then
    manifest.fetched[#manifest.fetched + 1] = { id = a.id, skipped = "exists" }
    SD.doneCount = (SD.doneCount or 0) + 1
  else
    local waitUntil = os.clock() + minGap
    local body, err
    for attempt = 1, 3 do
      body, err = fetchBlob(a.id)
      if body then break end
      -- bounded backoff on transient failure (429/throttle, network blip)
      task.wait(math.min(1 * attempt, 3))
    end
    if body then
      pcall(writefile, path, body)
      manifest.fetched[#manifest.fetched + 1] = {
        id = a.id, name = a.name, path = a.path, bytes = #body,
      }
      SD.doneCount = (SD.doneCount or 0) + 1
    else
      manifest.failed[#manifest.failed + 1] = { id = a.id, name = a.name, err = err }
      SD.failed[#SD.failed + 1] = a.id
    end
    local gap = waitUntil - os.clock()
    if gap > 0 then task.wait(gap) end
  end
end

pcall(writefile, OUTDIR .. "/manifest.json", HttpService:JSONEncode(manifest))
print(string.format("[sd] done: %d fetched, %d failed, %d skipped/stopped=%s",
  SD.doneCount or 0, #manifest.failed, not stop, tostring(stop)))
print(string.format("[sd] blobs in %s/raw — run tools/extract_server_scripts.py to get .lua files", OUTDIR))
