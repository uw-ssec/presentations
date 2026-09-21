#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
require shim_called okf '^[0-9]+ okf search'
first_write="$(shim_log okf | grep -E ' okf (create|update|relate)' | head -1 | cut -d' ' -f1)"
require before "$(shim_first_ts okf 'okf search')" "$first_write"
require shim_called okf '^[0-9]+ okf update project/deck-format-default'
require shim_not_called okf 'okf create project/deck-format-default'
require shim_called okf '^[0-9]+ okf validate'
# Every okf call must go through pixi, never the binary on PATH.
[ "$(count_in "$SHIM_LOG_DIR/okf.log" ' okf ')" -le "$(count_in "$SHIM_LOG_DIR/pixi.log" ' pixi run ')" ] || fail "okf was called directly instead of through pixi run"
require file_has "$REPO/knowledge/project/deck-format-default.md" 'without touching'
pass "existing concept refined through pixi run okf"
