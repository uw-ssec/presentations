#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
D="$REPO/demo-talk"
V="$D/content-with-visuals/02-problem.html"
require test -f "$V"
require file_has "$V" 'data-visuals-applied="true"'
require file_has "$V" '<svg'
[ -f "$D/content-with-visuals/01-title.html" ] && fail "01-title has no additions but was written to content-with-visuals/"
[ -f "$D/content-with-visuals/03-approach.html" ] && fail "03-approach is not in VISUALS.md but was written to content-with-visuals/"
for f in 01-title 02-problem 03-approach; do
  require unchanged "$D/content/$f.html" "/fixture/sha/$f"
done
require test -f "$D/build/index-with-visuals.html"
require file_has "$D/build/index-with-visuals.html" '<svg'
pass "pass 2 applied to the one listed slide, content/ untouched, deck rebuilt"
