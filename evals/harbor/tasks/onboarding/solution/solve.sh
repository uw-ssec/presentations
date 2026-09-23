#!/bin/bash
set -euo pipefail
cd /app

# Phase 1: where are we, and is the environment ready?
git rev-parse --abbrev-ref HEAD
git status --short
pixi install

# Phase 2: build a deck so they see one render.
cd /app/demo-talk
./build.sh
cd /app

# Phase 3: the map, with project memory shown live rather than described.
cat AGENTS.md
cat .agents/rules/repository-map.md
pixi run okf search "deck format" --limit 3

# Phase 4: the rules that bite. Read, never written.
cat .agents/rules/publish-workflow.md
cat .agents/rules/contribution-discipline.md
