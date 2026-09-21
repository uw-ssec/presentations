. /usr/local/lib/skill-evals/fixture.sh
new_repo
presentations_scaffold
fragment_deck demo-talk
cat > "$REPO/demo-talk/VISUALS.md" <<'MD'
# Visual Elements — Demo Talk

# Per-slide additions

## 01-title
No additions.

## 02-problem
**Diagrammatic addition.** A small three-stroke gold accent above the headline.
MD
# Pass 2 already ran once for 02-problem.
python3 - "$REPO/demo-talk/content/02-problem.html" "$REPO/demo-talk/content-with-visuals/02-problem.html" <<'PY'
import sys
src, dst = sys.argv[1], sys.argv[2]
html = open(src).read()
html = html.replace('class="slide accent-bar-top">', 'class="slide accent-bar-top" data-visuals-applied="true">', 1)
svg = '  <svg class="accent" viewBox="0 0 120 40" aria-hidden="true"><path d="M10 30 L40 10 M50 30 L60 8 M70 30 L110 12" fill="none" stroke="var(--color-gold-500)" stroke-width="2"/></svg>\n'
html = html.replace('<div class="wrap">', svg + '  <div class="wrap">', 1)
open(dst, 'w').write(html)
PY
(cd "$REPO/demo-talk" && ./build.sh >/dev/null)
mkdir -p /fixture/sha
for f in 01-title 02-problem 03-approach; do
  sha256sum "$REPO/demo-talk/content/$f.html" | cut -d' ' -f1 > "/fixture/sha/$f"
done
sha256sum "$REPO/demo-talk/content-with-visuals/02-problem.html" | cut -d' ' -f1 > /fixture/sha/applied-02
commit_all "feat(demo-talk): pass-2 applied to 02-problem" 1
finish_fixture
