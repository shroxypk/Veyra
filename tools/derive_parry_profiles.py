"""Derive parry profiles from keyframe pose speed instead of authored markers.

Usage: python tools/derive_parry_profiles.py path/to/pose_probe.json

The probe is produced in-game by walking every ``Keyframe`` of an
``Animation`` through ``KeyframeSequenceProvider`` and recording, per keyframe,
the fastest world-space pose movement (studs/second). Authored hit markers are
stripped from fetched sequences, but the pose data is not, and an impact lands
on -- or a few frames after -- the fastest part of the swing.

Heuristic checked against 25 marker-authored profiles: 23/26 impacts were
within 0.125s; median error 0.030s, p90 0.128s. This is not a success-rate
measurement and does not prove unseen attacks follow the same timing.

* threshold = max(4 studs/s, 15% of the clip's peak speed);
* a burst ends when speed drops under half the threshold;
* the burst peak is the fastest frame inside it;
* bursts closer than 0.28s are one swing (a single granted parry covers them);
* impact = cluster centre + 0.03s;
* impacts before 0.20s are conservatively dropped from derived guesses;
  this does not establish that early authored hits are impossible to parry.

Keyframes must be sorted by ``Time`` first; ``GetChildren`` order is not time
order for every clip, and an unsorted pass reports peaks past the clip length.
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

# Readable names for assets whose instance name is not exposed to the client.
NAMES = {
    "9924282016": "AlkeCombo",
}

MIN_SPEED = 4.0
PEAK_FRACTION = 0.15
CLUSTER = 0.28
IMPACT_LEAD = 0.03
MIN_IMPACT = 0.20


def bursts(frames):
    if not frames:
        return []
    peak = max(frame["s"] for frame in frames) or 1.0
    threshold = max(MIN_SPEED, peak * PEAK_FRACTION)
    peaks, index = [], 0
    while index < len(frames):
        if frames[index]["s"] < threshold:
            index += 1
            continue
        stop = index
        while stop < len(frames) and frames[stop]["s"] >= threshold * 0.5:
            stop += 1
        segment = frames[index:stop]
        peaks.append(max(segment, key=lambda frame: frame["s"])["t"])
        index = stop
    return peaks


def hits(peaks, length):
    if not peaks:
        return []
    impacts, cluster = [], [peaks[0]]
    for time in peaks[1:]:
        if time - cluster[-1] <= CLUSTER:
            cluster.append(time)
        else:
            impacts.append((cluster[0] + cluster[-1]) / 2 + IMPACT_LEAD)
            cluster = [time]
    impacts.append((cluster[0] + cluster[-1]) / 2 + IMPACT_LEAD)
    return [round(value, 3) for value in impacts
            if MIN_IMPACT <= value <= length + 0.05]


def covered_ids():
    """Assets that already have marker-authored profiles, which win."""
    path = ROOT / "src/parry_profiles.lua"
    if not path.exists():
        return set()
    return set(re.findall(r'\["(\d+)"\]', path.read_text(encoding="utf-8"))) - set(known_names())


def known_names():
    """Names already resolved for these assets, so a rerun keeps them."""
    path = ROOT / "tools/derived_parry_profiles.json"
    if not path.exists():
        return {}
    data = json.loads(path.read_text(encoding="utf-8"))
    return {asset: profile["name"]
            for asset, profile in (data.get("profiles") or {}).items()
            if profile.get("name")}


def build(records):
    skip = covered_ids()
    names = known_names()
    profiles = {}
    for record in records:
        asset = str(record.get("id") or "")
        if not record.get("ok") or not asset or asset in skip:
            continue
        length = float(record.get("length") or 0)
        if length <= 0:
            continue
        found = hits(bursts(record.get("frames") or []), length)
        if not found:
            continue
        profiles[asset] = {
            "name": NAMES.get(asset) or names.get(asset)
                    or record.get("name") or f"asset {asset}",
            "length": round(length, 6),
            "hits": found,
        }
    return profiles


if __name__ == "__main__":
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    records = json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))
    profiles = build(records)
    output = ROOT / "tools/derived_parry_profiles.json"
    document = {
        "_comment": ("Pose-derived mob attack profiles: impact = fastest pose "
                     "movement + 0.03s. See docs/parry.md."),
        "version": 1,
        "profiles": profiles,
    }
    output.write_text(json.dumps(document, indent=1, sort_keys=True) + "\n",
                      encoding="utf-8")
    print(f"wrote {len(profiles)} derived profiles")
