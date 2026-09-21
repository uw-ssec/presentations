#!/bin/bash
# The legacy deck is Reveal.js; AGENTS.md and deck-conventions.md say every new
# deck is a uw-slides fragment deck. Scaffold that instead and say why.
set -euo pipefail
cd /app
echo "security-in-age-of-ai is the legacy Reveal.js deck. Per AGENTS.md, new decks default to uw-slides fragments; scaffolding ai-orchestration that way."
D=ai-orchestration
T=.agents/uw-slides
mkdir -p "$D/shared" "$D/content" "$D/content-with-visuals" "$D/assets/images" "$D/assets/diagrams"
cp "$T/design-systems/ssec-brand/shared/header.html" "$D/shared/header.html"
cp "$T/templates/shared/footer.html" "$D/shared/footer.html"
cp "$T/templates/build.sh" "$T/templates/build-visuals.sh" "$D/"
chmod +x "$D/build.sh" "$D/build-visuals.sh"
cp "$T/templates/VISUALS.md" "$D/VISUALS.md"
printf '# From Hand-Coding to AI Orchestration\n\nSSEC talk.\n\n## 01-title\n\nTitle slide with SSEC branding.\n' > "$D/SLIDES.md"
printf '# From Hand-Coding to AI Orchestration\n\nFragment-based SSEC deck. Plan in SLIDES.md, build with ./build.sh.\n' > "$D/README.md"
printf 'build/\n.DS_Store\n' > "$D/.gitignore"
(cd "$D" && ./build.sh)
