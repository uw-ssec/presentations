#!/bin/bash
# Docker-free dry run of the Harbor tasks: builds each task's fixture, runs the
# oracle solution (or nothing, for the nop agent), then the verifier, with the
# container paths (/app, /skills, /fixture, /var/log/skill-shims, /logs, ...)
# rewritten to a temp root. It proves fixtures build, oracles solve, and
# verifiers accept a correct trajectory and reject an empty one. It does not
# prove skill delivery to a real agent; only `harbor run -a claude-code` does.
#
#   evals/harbor/dry-run.sh                 # every task, oracle and nop
#   evals/harbor/dry-run.sh <task> [oracle|nop|<solve.sh>]
#
# Needs bash, git, python3, sha256sum (macOS has /sbin/sha256sum). Exits 1 if
# any oracle run scores 0 or any nop run scores 1.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TASKS="$ROOT/evals/harbor/tasks"

run_one() {
  local task="$1" agent="${2:-oracle}" T="$TASKS/$1" R
  R="$(mktemp -d)"
  mkdir -p "$R/app" "$R/opt/repo/.agents" "$R/skills" "$R/fixture" "$R/logs" "$R/out" "$R/lib" "$R/bin" "$R/task"
  cp -R "$ROOT/.agents/skills/"* "$R/skills/"; cp -R "$ROOT/evals/skills/"* "$R/skills/"
  cp -R "$ROOT/.agents/rules" "$R/opt/repo/.agents/"; cp -R "$ROOT/.agents/uw-slides" "$R/opt/repo/.agents/"
  cp "$ROOT/AGENTS.md" "$ROOT/CLAUDE.md" "$R/opt/repo/"
  local GIT; GIT="$(command -v git)"
  rewrite() {
    sed -E \
      -e "s#([ =\"'\`(:-])/usr/local/lib/skill-evals#\1$R/lib#g" \
      -e "s#([ =\"'\`(:-])/var/log/skill-shims#\1$R/logs#g" \
      -e "s#([ =\"'\`(:-])/opt/repo#\1$R/opt/repo#g" \
      -e "s#([ =\"'\`(:-])/skills#\1$R/skills#g" \
      -e "s#([ =\"'\`(:-])/fixture#\1$R/fixture#g" \
      -e "s#([ =\"'\`(:-])/logs#\1$R/out#g" \
      -e "s#([ =\"'\`(:-])/app#\1$R/app#g" \
      -e "s#([ =\"'\`(:-])/usr/bin/git#\1$GIT#g" \
      "$1" > "$2"
  }
  for f in shimlib fixture verify; do rewrite "$ROOT/evals/harbor/base/lib/$f.sh" "$R/lib/$f.sh"; done
  for s in pixi okf git; do rewrite "$ROOT/evals/harbor/base/shims/$s" "$R/bin/$s"; done
  for s in pip pip3 conda uv; do rewrite "$ROOT/evals/harbor/base/shims/forbidden" "$R/bin/$s"; done
  # GNU `date -d "<N> days ago"` on macOS
  cat > "$R/bin/date" <<'D'
#!/bin/bash
if [ "${1:-}" = "-d" ]; then n="$(echo "$2" | sed -E 's/^([0-9]+) days? ago$/\1/')"; shift 2; exec /bin/date -v-"${n}"d "$@"; fi
exec /bin/date "$@"
D
  [ "$(uname)" = "Linux" ] && rm -f "$R/bin/date"
  chmod +x "$R/bin/"*
  export SKILL_SHIM_LIB="$R/lib/shimlib.sh" SKILL_SHIM_LOG_DIR="$R/logs" SKILL_SHIM_FIXTURE_DIR="$R/fixture" SKILL_SHIM_GIT="$GIT" SKILL_EVAL_REPO="$R/app"
  export PATH="$R/bin:$PATH"
  export GIT_CONFIG_GLOBAL=/dev/null GIT_AUTHOR_NAME="Skill Evals" GIT_AUTHOR_EMAIL=evals@example.invalid GIT_COMMITTER_NAME="Skill Evals" GIT_COMMITTER_EMAIL=evals@example.invalid
  if [ -f "$T/environment/fixture.sh" ]; then
    rewrite "$T/environment/fixture.sh" "$R/task/fixture.sh"
    if ! bash "$R/task/fixture.sh" > "$R/fixture.log" 2>&1; then
      echo "[$task] FIXTURE FAILED"; tail -5 "$R/fixture.log"; rm -rf "$R"; return 2
    fi
  fi
  if [ "$agent" = "oracle" ] || [ -f "$agent" ]; then
    local src="$T/solution/solve.sh"; [ -f "$agent" ] && src="$agent"
    rewrite "$src" "$R/task/solve.sh"
    (cd "$R/app" && bash "$R/task/solve.sh") > "$R/solve.log" 2>&1 || { echo "[$task] solve exited non-zero"; tail -5 "$R/solve.log"; }
  fi
  rewrite "$T/tests/test.sh" "$R/task/test.sh"
  local out reward
  out="$(cd "$R/app" && bash "$R/task/test.sh" 2>&1)"
  reward="$(cat "$R/out/verifier/reward.txt" 2>/dev/null || echo none)"
  printf '%-22s %-7s reward=%s  %s\n' "$task" "$( [ -f "$agent" ] && echo custom || echo "$agent")" "$reward" "$(echo "$out" | tail -1)"
  if [ -n "${KEEP:-}" ]; then echo "  kept: $R"; else rm -rf "$R"; fi
  case "$agent" in
    oracle) [ "$reward" = "1" ] ;;
    nop) [ "$reward" = "0" ] ;;
    *) true ;;
  esac
}

if [ $# -gt 0 ]; then
  run_one "$1" "${2:-oracle}"
  exit $?
fi
fails=0
for t in "$TASKS"/*/; do
  t="$(basename "$t")"
  run_one "$t" oracle || fails=$((fails + 1))
  run_one "$t" nop || fails=$((fails + 1))
done
if [ "$fails" -eq 0 ]; then echo "dry run ok"; else echo "$fails dry-run checks failed"; exit 1; fi
