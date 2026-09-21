#!/bin/bash
set -euo pipefail
cd /app/demo-talk
# 01-title: no additions. 03-approach: not listed. 02-problem: gold accent above the headline.
src=content/02-problem.html
dst=content-with-visuals/02-problem.html
if [ -f "$dst" ] && grep -q 'data-visuals-applied' "$dst"; then
  echo "02-problem — already applied, skipped"
else
  python3 - "$src" "$dst" <<'PY'
import sys
src, dst = sys.argv[1], sys.argv[2]
html = open(src).read()
html = html.replace('class="slide accent-bar-top">', 'class="slide accent-bar-top" data-visuals-applied="true">', 1)
svg = ('  <svg class="accent" viewBox="0 0 120 40" aria-hidden="true" width="120" height="40">'
       '<path d="M10 30 L40 10 M50 30 L60 8 M70 30 L110 12" fill="none" stroke="var(--color-gold-500)" stroke-width="2"/></svg>\n')
html = html.replace('<div class="wrap">', svg + '  <div class="wrap">', 1)
html = html.replace('</style>', '    section[data-slide="02-problem"] svg.accent { display: block; margin-bottom: var(--space-4); }\n  </style>', 1)
open(dst, 'w').write(html)
PY
  echo "02-problem — diagrammatic accent applied"
fi
./build-visuals.sh
