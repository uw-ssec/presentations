#!/bin/bash
set -euo pipefail
cd /app/demo-talk
cat > design-review.md <<'MD'
# Design review — demo-talk (brand: ssec)

❌ Violations:
  - Slide 02-problem: Hardcoded color #4b2e83 (use var(--color-purple-950))
  - Slide 03-approach: Missing accent bar (add .accent-bar-top, the 4px --color-teal-500 bar)
  - Slide 03-approach [ssec]: --color-teal-500 on light fails WCAG AA (1.9:1). Use --color-purple-700 (10.4:1) for emphasis; teal on light is a bar, rule, or glow only.

Slide 01-title: compliant.
MD
cat design-review.md
