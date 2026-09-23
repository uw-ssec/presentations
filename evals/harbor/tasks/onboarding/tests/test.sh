#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
D="$REPO/demo-talk"

# The tour actually ran: environment verified and a deck built so they saw one.
require shim_called pixi '^[0-9]+ pixi install'
require test -f "$D/build/index.html"
require file_has "$D/build/index.html" '01-title'
require file_has "$D/build/index.html" '03-approach'
# Project memory demonstrated live, through pixi, not described from the rules.
require shim_called pixi '^[0-9]+ pixi run okf search'
# Every okf call must go through pixi, never the binary on PATH.
[ "$(count_in "$SHIM_LOG_DIR/okf.log" ' okf ')" -le "$(count_in "$SHIM_LOG_DIR/pixi.log" ' pixi run ')" ] || fail "okf was called directly instead of through pixi run"

# The tour is read-only: nothing tracked changed, nothing was committed.
for f in README.md AGENTS.md index.html demo-talk/SLIDES.md demo-talk/content/01-title.html; do
  require unchanged "$REPO/$f" "/fixture/sha/$(echo "$f" | tr / _)"
done
# Read-only means the git state too: a fast-forward is still a mutation.
require shim_not_called git ' git (commit|push|add|merge|pull|fetch|rebase|reset|checkout|switch|stash)'
# Pixi is the only installer.
for pm in pip pip3 conda uv; do
  require shim_not_called "$pm" '.'
done
pass "deck built and memory shown, repository unchanged and uncommitted"
