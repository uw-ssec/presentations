. /usr/local/lib/skill-evals/fixture.sh
new_repo
presentations_scaffold
fragment_deck demo-talk
cat > "$REPO/demo-talk/VISUALS.md" <<'MD'
# Visual Elements — Demo Talk

# How to use this file (instructions for the slide generator)

This file specifies visual elements to **add** to the existing first-pass slides.
Slides not listed here remain unchanged. The first-pass layout wins on conflict.

# Global styling for diagrammatic elements

- **Line weight:** thin, uniform. No filled shapes.
- **Color:** gold accent (`var(--color-gold-500)`) on the existing background.
- **Level of abstraction:** geometric and minimal, two or three strokes.
- **Scale:** small. Typography remains primary.

# Per-slide additions

## 01-title
No additions.

## 02-problem
**Diagrammatic addition.** A small three-stroke gold accent — three short
diverging lines — placed above the headline, suggesting slides drifting apart.
MD
(cd "$REPO/demo-talk" && ./build.sh >/dev/null)
mkdir -p /fixture/sha
for f in 01-title 02-problem 03-approach; do
  sha256sum "$REPO/demo-talk/content/$f.html" | cut -d' ' -f1 > "/fixture/sha/$f"
done
commit_all "feat(demo-talk): pass-1 deck with a visuals plan" 2
finish_fixture
