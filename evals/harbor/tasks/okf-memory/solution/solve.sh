#!/bin/bash
set -euo pipefail
cd /app
pixi run okf search "deck format default fragment" --limit 3
pixi run okf search --for-path .agents/skills/new-deck/SKILL.md
pixi run okf show project/deck-format-default
pixi run okf update project/deck-format-default \
  --body "Why: one fragment per slide lets an agent edit a single slide without touching the rest of the deck." \
  --actor claude-code:test-model
pixi run okf validate --strict --drift
