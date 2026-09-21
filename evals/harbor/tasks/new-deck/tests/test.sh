#!/bin/bash
. /usr/local/lib/skill-evals/verify.sh
D="$REPO/rse-meetup-2026"
T="$REPO/.agents/uw-slides"
require test -d "$D"
for f in shared/header.html shared/footer.html build.sh build-visuals.sh SLIDES.md VISUALS.md README.md .gitignore; do
  require test -f "$D/$f"
done
for d in content content-with-visuals assets/images assets/diagrams; do
  require test -d "$D/$d"
done
cmp -s "$D/shared/header.html" "$T/design-systems/ssec-brand/shared/header.html" || fail "header.html is not the SSEC brand header"
cmp -s "$D/shared/footer.html" "$T/templates/shared/footer.html" || fail "footer.html is not the shared template footer"
require file_has "$D/.gitignore" '^build/'
[ -d "$D/assets/fonts" ] && fail "fonts were copied for the SSEC brand (only --brand=uw copies fonts)"
require tree_lacks "$D" 'reveal'
require test -f "$D/build/index.html"
require file_has "$D/build/index.html" '<html'
[ -z "$(repo_git status --porcelain security-in-age-of-ai index.html)" ] || fail "the existing deck or gallery was modified"
pass "fragment deck scaffolded from the SSEC templates and built"
