---
name: accessibility-check
description: Validate WCAG 2.1 Level AA compliance. Checks contrast ratios, font sizes, alt text, ARIA labels, and semantic HTML.
---

# Accessibility Check Skill

## Purpose
Validate WCAG 2.1 Level AA compliance for slide decks.

## What Gets Checked
1. **Color Contrast** — 4.5:1 for text, 3:1 for large text
2. **Font Sizes** — Minimum 24px
3. **Alt Text** — All images must have descriptions
4. **ARIA Labels** — All slides have aria-label
5. **Semantic HTML** — Proper heading hierarchy
6. **Keyboard Navigation** — Arrow keys functional

## Usage
```bash
/accessibility-check
/accessibility-check --brand=uw
```

The optional `--brand=<ssec|uw>` parameter identifies which brand's approved contrast pairings to reference when reporting results. Defaults to `ssec`. The WCAG AA thresholds (4.5:1 text, 3:1 large text) apply to both brands. For the verified SSEC contrast tables, see `.agents/uw-slides/design-systems/ssec-brand/DESIGN.md` section 2; for UW, see `.agents/uw-slides/design-systems/uw-brand/DESIGN.md` section 6.

## Output
```
✅ PASSED (18 checks)
❌ FAILED (2 checks)
  - Slide 05: Missing alt text for 'diagram.png'
  - Slide 12: Contrast 3.2:1 (needs 4.5:1)
```

See `.agents/uw-slides/references/accessibility-requirements.md` for complete guidelines.
