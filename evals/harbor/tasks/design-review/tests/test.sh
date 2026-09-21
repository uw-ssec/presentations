#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
D="$REPO/demo-talk"
R="$D/design-review.md"
require test -f "$R"
require file_has "$R" 'violation'
require file_has "$R" '#4b2e83'
require file_has "$R" '02'
require file_has "$R" 'accent.bar'
require file_has "$R" 'teal-500'
require file_has "$R" 'purple-700'
require file_has "$R" '03'
for f in 01-title 02-problem 03-approach; do
  require unchanged "$D/content/$f.html" "/fixture/sha/$f"
done
pass "all three brand violations reported, slides untouched"
