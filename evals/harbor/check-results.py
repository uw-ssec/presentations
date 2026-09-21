"""Fail unless every trial in the latest Harbor job scored 1.0 with no exception.

Harbor records rewards and exceptions in ``result.json`` and exits 0 either
way, so a green ``harbor run`` proves nothing on its own. Usage::

    pixi run -e evals harbor-check            # latest job under evals/logs/harbor
    python evals/harbor/check-results.py <job-dir-or-result.json>
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
LOGS = ROOT / "evals" / "logs" / "harbor"


def latest_result() -> Path:
    jobs = sorted(p for p in LOGS.glob("*/result.json"))
    if not jobs:
        sys.exit(f"no result.json under {LOGS}")
    return jobs[-1]


def main(argv: list[str]) -> int:
    path = Path(argv[1]) if len(argv) > 1 else latest_result()
    if path.is_dir():
        path = path / "result.json"
    job = json.loads(path.read_text())
    trials = job.get("trial_results") or []
    if not trials:
        # harbor run writes stats only to the job-level file; each trial has
        # its own <job-dir>/<trial>/result.json with verifier_result.rewards.
        trials = [
            json.loads(child.read_text())
            for child in sorted(path.parent.glob("*/result.json"))
            if child.read_text().strip()
        ]
    if not trials:
        print(f"no trials in {path} or its trial directories")
        return 1
    bad = 0
    for t in sorted(trials, key=lambda t: t.get("task_name", "")):
        name = t.get("task_name", "?")
        exc = t.get("exception_info")
        rewards = (t.get("verifier_result") or {}).get("rewards") or {}
        values = [v for v in rewards.values() if isinstance(v, (int, float))]
        if exc:
            bad += 1
            msg = exc.get("exception_message", "").strip().splitlines()
            print(f"EXC  {name}: {exc.get('exception_type')}: {msg[-1] if msg else ''}")
        elif not values or any(v != 1 for v in values):
            bad += 1
            print(f"FAIL {name}: rewards={rewards}")
        else:
            print(f"ok   {name}")
    print(f"{len(trials) - bad}/{len(trials)} trials scored 1.0 ({path})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
