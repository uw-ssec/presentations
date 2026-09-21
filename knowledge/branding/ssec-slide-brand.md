---
type: Decision
title: "SSEC is the default slide brand, adapted from the website design system"
description: "The uw-slides ssec brand vendors the uw-ssec.github.io design system with token names unchanged, a 24px-floor slide type scale, sentence-case titles, and Google Fonts; it replaced the upstream CloudBank brand and is the default for new decks."
tags: [branding, ssec, uw-slides, design-system]
status: stable
governance: constraint
code_refs:
  - .agents/uw-slides/design-systems/ssec-brand/**
  - .agents/skills/new-deck/SKILL.md
  - .claude/skills/new-deck/SKILL.md
sources:
  - resource: https://github.com/uw-ssec/uw-ssec.github.io/tree/d313f9ea08961a221f179a342dcc6ec918b42199/design-system
  - resource: .agents/uw-slides/design-systems/ssec-brand/DESIGN.md
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-21T21:56:49Z" }
---

## Decision

New fragment-based decks use `--brand=ssec` by default. The brand lives at `.agents/uw-slides/design-systems/ssec-brand/` and is an adaptation of `design-system/` from the uw-ssec/uw-ssec.github.io repository (commit `d313f9e`, 2026-07-24), which is vendored verbatim in its `source/` folder. `--brand=uw` remains available for a plain University of Washington deck. The upstream plugin's CloudBank brand was removed at the project owner's request and must not be re-added on a re-sync.

## What was kept from the website

- Tier-1 and tier-2 token names and values, verbatim: `--color-purple-700`, `--color-teal-500`, `--font-compressed`, `--surface-terminal`, `--text-code`, and so on. Slides and the website share one vocabulary, and the existing Reveal.js deck in this repository already used these names.
- The four families and their roles: Encode Sans (display), Encode Sans Compressed (eyebrows, labels), Open Sans (body), JetBrains Mono (code).
- Sentence-case titles with tight tracking. The upstream UW brand guide sets titles in uppercase Black 900; the SSEC website does not, and the website style wins for the SSEC brand.
- The 15 degree motif: angled gold divider on dark slides, skewed bullet markers and rules, 105 degree rain texture.
- Font loading from Google Fonts, exactly as the website does.

## What was changed for slides

- The website's 12 to 60px fluid text scale (`--text-xs` through `--text-5xl`) is not exposed. A `--slide-*` scale with a 1.5rem (24px) floor replaces it, because projected text below 24px is unreadable and the uw-slides review skills treat it as a violation.
- A `.dark` context flips the semantic aliases so one set of alias names works on light and dark slides.
- `--font-black` (900) is added, and `--font-display-compressed` / `--font-ui` alias `--font-compressed` so the uw-slides skills' token names resolve.

## Rejected alternatives

- Prefixing tokens `--ssec-*` to match the plugin's `--uw-*` / `--cb-*` convention. Rejected: it would break the shared vocabulary with the website and the existing deck for no gain.
- Copying Encode Sans into each deck as the UW brand does (about 9 MB per deck). Rejected: the website's documented strategy is Google Fonts, the existing deck and the CI runner already depend on it, and per-deck copies bloat the repository. The offline fallback (copy Normal and Compressed from `uw-brand/fonts/`) is documented in the brand guide.

## Re-sync

Re-sync from the website repository per section 12 of the brand `DESIGN.md`: copy the upstream folder over `source/`, diff `01-tokens.css` against the token blocks in `colors_and_type.css` and `shared/header.html`, recompute the contrast tables if any hex changed, update the commit reference.

## Related Concepts

- [Measured WCAG contrast for SSEC slide colors differs from the website tables](ssec-contrast-measurements.md): The contrast measurements set the text-color rules the SSEC brand guide and design-review skill enforce
