#!/usr/bin/env python3
"""Path index of server-side references in harvested sources (Syn Project style).

Scans every decompiled source for dot-path references like
`serverscriptservice.a.b` (case-insensitive) and builds:

  serverscripts/<placeId>/stubs/<Service>/<segments>.lua
      one placeholder ModuleScript per fully-referenced path (empty stubs,
      so the hierarchy can be opened in Studio as a skeleton)
  serverscripts/<placeId>/stubs/index.json
      every reference: path -> [{file, line}] provenance

Services known by default: ServerScriptService, ServerStorage,
ReplicatedStorage, ServerClock, RunService. Dot paths are normalized so
`ServerScriptService.Combat.Net.Blink` and `serverscriptservice.combat.net.blink`
collapse to the same key.

Usage:
  python tools/path_index.py [placeId] [--out DIR]
"""
import argparse
import json
import os
import re
import sys

SERVICES = {
    "serverscriptservice": "ServerScriptService",
    "serverstorage": "ServerStorage",
    "replicatedstorage": "ReplicatedStorage",
}

# serviceName . seg . seg ... (at least 2 segments)
PATH_RE = re.compile(
    r"\b(ServerScriptService|ServerStorage|ReplicatedStorage)"
    r"((?:\.[A-Za-z_][A-Za-z0-9_]*)+)",
    re.IGNORECASE,
)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("placeId", nargs="?", help="place id (default: every place under workspace/serverscripts)")
    ap.add_argument("--out", help="output root (default: <workspace>/serverscripts)")
    args = ap.parse_args()

    workspace = os.environ.get(
        "VENCO_WORKSPACE",
        os.path.expandvars(r"%LOCALAPPDATA%\Madium\Workspace") if os.name == "nt"
        else os.path.expanduser("~/Library/Application Support"),
    )
    base = args.out or os.path.join(workspace, "serverscripts")
    src_root = os.path.join(workspace, "sources") if os.path.isdir(os.path.join(workspace, "sources")) else None
    harvest_repo = os.path.join(os.path.dirname(__file__), "..", "harvest")
    places = [args.placeId] if args.placeId else []
    if not places:
        harvest_repo = os.path.normpath(harvest_repo)
        places = ["0"]

    refs = {}  # normalized path -> {source_file, line} list refs
    files_scanned = 0
    # Search harvested sources (repo copy first, else workspace)
    search_root = args.source if getattr(args, "source", None) else None
    roots = []
    if os.path.isdir(harvest_repo):
        roots.append(harvest_repo)
    if os.path.isdir(os.path.join(workspace, "serverscripts")):
        for place in sorted(os.listdir(os.path.join(workspace, "serverscripts"))):
            src = os.path.join(workspace, "serverscripts", place, "sources")
            if os.path.isdir(src):
                roots.append(src)
    for root in roots:
        for dirpath, _dirs, files in os.walk(root):
            for f in files:
                if not f.endswith(".lua"):
                    continue
                path = os.path.join(dirpath, f)
                try:
                    text = open(path, encoding="utf-8", errors="ignore").read()
                except OSError:
                    continue
                files_scanned += 1
                for lineno, line in enumerate(text.splitlines(), 1):
                    for m in PATH_RE.finditer(line):
                        service = SERVICES[m.group(1).lower()]
                        segs = [s for s in m.group(2).split(".") if s]
                        norm = ".".join([service] + segs)
                        refs.setdefault(norm, []).append(
                            {"file": os.path.relpath(path, root), "line": lineno}
                        )

    print(f"scanned {files_scanned} files, found {len(refs)} unique paths")
    # Group by service prefix for sorted output
    by_svc = {}
    for path in sorted(refs):
        by_svc.setdefault(path.split(".")[0], []).append(path)
    for svc, paths in sorted(by_svc.items()):
        print(f"\n[{svc}] {len(paths)} paths")
        for p in paths:
            src_files = refs[p][0]["file"]
            print(f"  {p}   (first seen in {src_files})")

    # Write stubs + index
    places_dir = base if not places or places == ["0"] else os.path.join(base, places[0])
    stubs_dir = os.path.join(places_dir, "stubs")
    os.makedirs(stubs_dir, exist_ok=True)
    index = {
        "paths": {p: refs[p] for p in sorted(refs)},
        "stats": {"filesScanned": files_scanned, "uniquePaths": len(refs)},
    }
    with open(os.path.join(stubs_dir, "index.json"), "w", encoding="utf-8") as fh:
        json.dump(index, fh, indent=1)
    for p in refs:
        segs = p.split(".")
        dest = os.path.join(stubs_dir, *segs) + ".lua"
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        with open(dest, "w", encoding="utf-8") as fh:
            fh.write("-- stub (Syn Project style)\n-- referenced as: " + p + "\n\nreturn {}\n")
    print(f"\nwrote {len(refs)} stubs + index.json to {stubs_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
