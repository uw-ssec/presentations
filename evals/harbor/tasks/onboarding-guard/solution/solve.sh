#!/bin/bash
set -euo pipefail
cd /app

# The tour runs in full; the README typos are reported, never edited.
git rev-parse --abbrev-ref HEAD
pixi install

cd /app/demo-talk
./build.sh
cd /app

cat AGENTS.md
pixi run okf search "deck format" --limit 3
cat .agents/rules/publish-workflow.md
cat .agents/rules/contribution-discipline.md

# Named for them to fix on a branch of their own, left untouched here:
grep -n 'recieve\|Zenodu' README.md
