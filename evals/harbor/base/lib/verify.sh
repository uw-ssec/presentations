# Sourced by every tests/test.sh. Reads shim logs and repo state, writes the
# Harbor reward, always exits 0 so Harbor records the score.
SHIM_LOG_DIR="${SKILL_SHIM_LOG_DIR:-/var/log/skill-shims}"
REPO="${SKILL_EVAL_REPO:-/app}"

_finish() {
  mkdir -p /logs/verifier
  cp -R "$SHIM_LOG_DIR" /logs/verifier/shims 2>/dev/null || true
  echo "$1" > /logs/verifier/reward.txt
}
pass() { echo "PASS: $*"; _finish 1; exit 0; }
fail() { echo "FAIL: $*"; _finish 0; exit 0; }
# require <cmd...> -- fail with the command text if it returns non-zero
require() { "$@" || fail "$*"; }

shim_log() { cat "$SHIM_LOG_DIR/$1.log" 2>/dev/null; }
shim_called() { shim_log "$1" | grep -Eq -- "$2"; }
shim_not_called() { ! shim_called "$1" "$2"; }
shim_first_ts() { shim_log "$1" | grep -E -- "$2" | head -1 | cut -d' ' -f1; }
# shim_arg <tool> <flag> -- value that followed <flag> in the first matching call;
# single-line values only (titles, ids) -- for multi-line values such as bodies
# use shim_args_have with a line-anchored regex
shim_arg() { awk -v flag="$2" 'prev == flag { print; exit } { prev = $0 }' "$SHIM_LOG_DIR/$1.args" 2>/dev/null; }
shim_args_have() { grep -Eq -- "$2" "$SHIM_LOG_DIR/$1.args" 2>/dev/null; }
# before <ts_a> <ts_b> -- both non-empty and a <= b
before() { [ -n "$1" ] && [ -n "$2" ] && [ "$1" -le "$2" ]; }

repo_git() { /usr/bin/git -C "$REPO" "$@"; }
# file_has <path> <ERE> -- case-insensitive match anywhere in the file
file_has() { grep -Eiq -- "$2" "$1" 2>/dev/null; }
file_lacks() { ! file_has "$1" "$2"; }
# tree_has <dir> <ERE> -- case-insensitive match in any file under dir
tree_has() { grep -REiq -- "$2" "$1" 2>/dev/null; }
tree_lacks() { ! tree_has "$1" "$2"; }
# count_in <path> <ERE> -- number of matching lines
count_in() { grep -Eic -- "$2" "$1" 2>/dev/null || true; }
# unchanged <path> <sha256-file> -- the file still matches the fixture checksum
unchanged() { sha256sum "$1" 2>/dev/null | cut -d' ' -f1 | grep -qx "$(cat "$2" 2>/dev/null)"; }
