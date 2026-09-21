#!/bin/bash
# Self-test for the fake CLIs. Runs on the host (bash 3.2 or newer, no Docker):
# points the shims at a temp dir and exercises each branch of behaviour.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
export SKILL_SHIM_LIB="$here/../lib/shimlib.sh"
export SKILL_SHIM_LOG_DIR="$tmp/logs"
export SKILL_SHIM_FIXTURE_DIR="$tmp/fixture"
export SKILL_SHIM_GIT="$(command -v git)"
PATH="$here:$PATH"
fails=0
check() { if "$@"; then :; else echo "not ok: $*"; fails=$((fails + 1)); fi; }
check_not() { if "$@"; then echo "not ok (expected failure): $*"; fails=$((fails + 1)); fi; }
mkdir -p "$tmp/fixture/okf" "$tmp/work"
cd "$tmp/work"

# pixi: version, install, task passthrough, okf forwarding (with and without -e)
check test "$(pixi --version)" = "pixi 0.64.0"
check grep -q installed <<<"$(pixi install)"
check grep -q 'ok' <<<"$(pixi run some-task)"
check grep -q 'Conformant' <<<"$(pixi run okf-validate)"
check grep -q 'Conformant' <<<"$(pixi run -e evals okf validate --strict --drift)"
check grep -Eq '^[0-9]+ pixi run okf-validate' "$SKILL_SHIM_LOG_DIR/pixi.log"
check grep -Eq '^[0-9]+ okf validate --strict --drift' "$SKILL_SHIM_LOG_DIR/okf.log"

# okf: search from fixture, create/update touch knowledge/, unknown id fails
printf 'project/x  Decision  x  (governance: constraint)\n' > "$tmp/fixture/okf/search.txt"
check grep -q 'project/x' <<<"$(okf search anything --limit 3)"
check grep -q 'project/x' <<<"$(okf search --for-path some/file.html)"
okf create project/y --type Decision --title "Y" --desc "why y" --tags "a,b" --body "$(printf 'Body\nline two')" --actor a:b >/dev/null
check grep -q '^description: why y' knowledge/project/y.md
check grep -q '^line two' knowledge/project/y.md
# multi-line argument is line-addressable in the .args log
check grep -q '^line two$' "$SKILL_SHIM_LOG_DIR/okf.args"
# single-line flag value lookup returns the whole title
check test "$(awk -v flag="--title" 'prev == flag { print; exit } { prev = $0 }' "$SKILL_SHIM_LOG_DIR/okf.args")" = "Y"
okf update project/y --desc "new desc" --body "more" >/dev/null
check grep -q '^description: new desc' knowledge/project/y.md
check grep -q '^more' knowledge/project/y.md
check grep -q '^title: Y' <<<"$(okf show project/y)"
check_not okf update project/missing --desc d 2>/dev/null
check_not okf show project/missing 2>/dev/null
check grep -q 'related project/y -> project/x' <<<"$(okf relate project/y project/x --desc why)"

# git wrapper logs then delegates; forbidden shim logs then fails
check grep -q 'git version' <<<"$("$here/git" --version)"
check grep -Eq '^[0-9]+ git --version' "$SKILL_SHIM_LOG_DIR/git.log"
check_not "$here/forbidden" install x 2>/dev/null
check test -s "$SKILL_SHIM_LOG_DIR/forbidden.log"

if [ "$fails" -eq 0 ]; then echo "shims ok"; else echo "$fails shim checks failed"; exit 1; fi
