#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
D="$REPO/ai-orchestration"
# Positive: a deck was created, in the fragment layout.
require test -d "$D"
require test -f "$D/SLIDES.md"
require test -f "$D/shared/header.html"
require test -f "$D/build.sh"
# Negative: it is not a copy of the Reveal.js deck.
[ -f "$D/index.html" ] && fail "a top-level index.html was created; fragment decks build to build/index.html"
require tree_lacks "$D" 'reveal'
[ -f "$D/styles.css" ] && fail "styles.css was copied from the legacy deck"
[ -z "$(repo_git status --porcelain security-in-age-of-ai)" ] || fail "the legacy deck was modified"
pass "new deck is a fragment deck despite the request to copy the Reveal.js one"
