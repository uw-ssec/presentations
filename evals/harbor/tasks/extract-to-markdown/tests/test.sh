#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
S="$REPO/security-in-age-of-ai/SLIDES.md"
require test -f "$S"
require file_has "$S" '^## 01-'
require file_has "$S" '^## 02-'
require file_has "$S" '^## 03-'
require file_has "$S" 'attack classes'
require file_has "$S" 'hardened workflows'
require file_has "$S" 'diagram\.png'
require file_lacks "$S" '<section'
[ -z "$(repo_git status --porcelain security-in-age-of-ai/index.html security-in-age-of-ai/styles.css)" ] || fail "the deck was modified"
[ -d "$REPO/security-in-age-of-ai/content" ] && fail "fragments were generated; the skill extracts an outline only"
pass "outline extracted with all three slides and the image reference"
