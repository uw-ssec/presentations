#!/bin/bash
set -euo pipefail
cd /app
D=rse-meetup-2026
T=.agents/uw-slides
mkdir -p "$D/shared" "$D/content" "$D/content-with-visuals" "$D/assets/images" "$D/assets/diagrams"
cp "$T/design-systems/ssec-brand/shared/header.html" "$D/shared/header.html"
cp "$T/templates/shared/footer.html" "$D/shared/footer.html"
cp "$T/templates/build.sh" "$T/templates/build-visuals.sh" "$D/"
chmod +x "$D/build.sh" "$D/build-visuals.sh"
cp "$T/templates/VISUALS.md" "$D/VISUALS.md"
cat > "$D/SLIDES.md" <<'MD'
# Reproducible slides from HTML fragments

SSEC RSE Meetup talk on building decks from one HTML fragment per slide.

## 01-title

Title slide with SSEC branding.
- Presenter name, affiliation, date

## 02-overview

Key message: One fragment per slide, one build script.
MD
cat > "$D/README.md" <<'MD'
# Reproducible slides from HTML fragments

SSEC-branded presentation using a two-pass, fragment-based architecture.

## Pass 1 — Content and structure

1. Edit `SLIDES.md` to plan your presentation
2. Request slides through conversation (LLM reads SLIDES.md, writes to `content/`)
3. Build: `./build.sh`
4. Preview: `open build/index.html`

## Pass 2 — Visual additions

1. Edit `VISUALS.md`
2. Run `/apply-visuals`
3. Build: `./build-visuals.sh`
MD
printf 'build/\n.DS_Store\n*.swp\n*~\n' > "$D/.gitignore"
(cd "$D" && ./build.sh)
