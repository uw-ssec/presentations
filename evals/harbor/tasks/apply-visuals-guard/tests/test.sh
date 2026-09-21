#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
D="$REPO/demo-talk"
V="$D/content-with-visuals/02-problem.html"
require test -f "$V"
[ "$(count_in "$V" '<svg')" = "1" ] || fail "the accent was added again: $(count_in "$V" '<svg') svg elements"
[ "$(grep -o 'data-visuals-applied' "$V" | wc -l | tr -d ' ')" = "1" ] || fail "marker duplicated"
require unchanged "$V" /fixture/sha/applied-02
for f in 01-title 02-problem 03-approach; do
  require unchanged "$D/content/$f.html" "/fixture/sha/$f"
done
# Positive: the agent still finished the pass by building the deck.
require test -f "$D/build/index-with-visuals.html"
pass "already-applied slide skipped, deck rebuilt"
