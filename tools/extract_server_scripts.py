#!/usr/bin/env python3
"""Extract per-script sources from server_script_downloader blobs.

Walks serverscripts/<placeId>/raw/*.blob, detects each payload type and
extracts embedded Script/ModuleScript/LocalScript source into
serverscripts/<placeId>/scripts/<assetId>/<Class>/<Name>.lua, plus an
index.json mapping every extracted script to its origin.

Payload handling:
  * Roblox XML  -> ElementTree walk for Script/ModuleScript/LocalScript
                   instances and their <string name="Source"> property.
  * JSON        -> recursive walk collecting Source/ScriptSource strings.
  * Plain Luau  -> the whole blob is the script source.
  * Binary model-> saved as-is with a "binary" note (needs an rbx-binary
                   parser; listed in index.json so nothing is silently lost).

Usage:
  python tools/extract_server_scripts.py [placeId]
"""
import json
import os
import re
import sys
import xml.etree.ElementTree as ET

SANITIZE = re.compile(r"[^A-Za-z0-9_.-]+")


def sanitize(name: str) -> str:
    name = SANITIZE.sub("_", name or "unnamed").strip("._-") or "unnamed"
    return name[:80]


def extract_xml(root: ET.Element, scripts: list) -> None:
    for item in root.iter("Item"):
        cls = item.get("class", "")
        if cls not in ("Script", "ModuleScript", "LocalScript"):
            continue
        props = item.find("Properties")
        if props is None:
            continue
        name_el = props.find("string[@name='Name']")
        src_el = props.find("string[@name='Source']")
        name = name_el.text if name_el is not None and name_el.text else "unnamed"
        source = src_el.text if src_el is not None and src_el.text else ""
        scripts.append({"class": cls, "name": name, "source": source})


def extract_json(node, scripts, context=""):
    if isinstance(node, dict):
        for k, v in node.items():
            if k in ("Source", "ScriptSource") and isinstance(v, str) and v:
                base = context or "json"
                scripts.append({"class": "Script", "name": base, "source": v})
            else:
                extract_json(v, scripts, context or str(k))
    elif isinstance(node, list):
        for i, v in enumerate(node):
            extract_json(v, scripts, f"{context}[{i}]")


def main() -> int:
    here = os.path.dirname(os.path.abspath(__file__))
    workspace = os.environ.get(
        "VENCO_WORKSPACE",
        os.path.expandvars(r"%LOCALAPPDATA%\Madium\Workspace") if os.name == "nt"
        else os.path.expanduser("~/Library/Application Support"),
    )
    base = os.path.join(workspace, "serverscripts")
    if len(sys.argv) > 1:
        place_ids = sys.argv[1:]
    else:
        place_ids = sorted(d for d in os.listdir(base) if os.path.isdir(os.path.join(base, d)))

    total_scripts = 0
    for place_id in place_ids:
        raw_dir = os.path.join(base, place_id, "raw")
        out_dir = os.path.join(base, place_id, "scripts")
        if not os.path.isdir(raw_dir):
            print(f"[{place_id}] no raw/ directory — run the Luau downloader first")
            continue
        index = {"placeId": place_id, "assets": {}}
        os.makedirs(out_dir, exist_ok=True)
        blobs = sorted(f for f in os.listdir(raw_dir) if f.endswith(".blob"))
        for fname in blobs:
            asset_id = os.path.splitext(fname)[0]
            blob_path = os.path.join(raw_dir, fname)
            with open(blob_path, "rb") as fh:
                data = fh.read()
            scripts, kind = [], "unknown"
            head = data[:64].decode("utf-8", errors="ignore")
            if head.lstrip().startswith("<"):
                try:
                    root = ET.fromstring(data.decode("utf-8", errors="ignore"))
                    extract_xml(root, scripts)
                    kind = "xml"
                except ET.ParseError:
                    kind = "binary-model" if "<roblox" in head else "xml-error"
            elif head.lstrip().startswith("{"):
                try:
                    extract_json(json.loads(data.decode("utf-8", errors="ignore")), scripts)
                    kind = "json"
                except json.JSONDecodeError:
                    kind = "json-error"
            else:
                scripts.append({"class": "Script", "name": "blob", "source": data.decode("utf-8", errors="ignore")})
                kind = "plain-source"
            asset_dir = os.path.join(out_dir, asset_id)
            saved = []
            for s in scripts:
                cls, name, src = s["class"], sanitize(s["name"]), s["source"]
                dest = os.path.join(asset_dir, sanitize(cls), f"{name}.lua")
                os.makedirs(os.path.dirname(dest), exist_ok=True)
                with open(dest, "w", encoding="utf-8") as fh:
                    fh.write(src)
                saved.append({"path": os.path.relpath(dest, out_dir), "bytes": len(src)})
            index["assets"][asset_id] = {"kind": kind, "scripts": saved}
            total_scripts += len(saved)
            print(f"[{place_id}] {asset_id}: {kind}, {len(saved)} script(s)")
        with open(os.path.join(out_dir, "index.json"), "w", encoding="utf-8") as fh:
            json.dump(index, fh, indent=1)
    print(f"done: extracted {total_scripts} script(s) total")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
