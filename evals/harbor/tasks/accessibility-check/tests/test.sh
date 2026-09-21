#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
D="$REPO/demo-talk"
R="$D/accessibility-report.md"
require test -f "$R"
require file_has "$R" 'alt'
require file_has "$R" 'pipeline\.png'
require file_has "$R" '02'
require file_has "$R" '16 ?px'
require file_has "$R" '03'
require file_has "$R" 'aria-label'
require file_has "$R" '04'
for f in 01-title 02-problem 03-approach 04-summary; do
  require unchanged "$D/content/$f.html" "/fixture/sha/$f"
done
pass "all three accessibility failures reported, slides untouched"
