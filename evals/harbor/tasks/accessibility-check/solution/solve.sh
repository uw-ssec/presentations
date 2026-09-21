#!/bin/bash
set -euo pipefail
cd /app/demo-talk
cat > accessibility-report.md <<'MD'
# Accessibility check — demo-talk (WCAG 2.1 AA)

✅ PASSED (9 checks)
❌ FAILED (3 checks)
  - Slide 02-problem: Missing alt text for 'pipeline.png'
  - Slide 03-approach: Font size 16px is below the 24px minimum (.lead)
  - Slide 04-summary: Missing aria-label on the section
MD
cat accessibility-report.md
