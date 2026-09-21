---
type: Fact
title: Measured WCAG contrast for SSEC slide colors differs from the website tables
description: "Computed contrast for the SSEC hex values shows the darker code teal and Heritage Gold on warm surfaces pass AA only as large text, and teal, gold-500, green, pink, and spirit gold fail as text on any light surface."
tags: [branding, ssec, accessibility, wcag, contrast]
status: stable
governance: constraint
code_refs:
  - .agents/uw-slides/design-systems/ssec-brand/DESIGN.md
  - .agents/uw-slides/design-systems/ssec-brand/colors_and_type.css
  - .agents/uw-slides/design-systems/ssec-brand/shared/header.html
  - .agents/skills/design-review/SKILL.md
  - .claude/skills/design-review/SKILL.md
sources:
  - resource: .agents/uw-slides/design-systems/ssec-brand/source/02-color-palette.md
  - resource: https://www.w3.org/TR/WCAG22/#contrast-minimum
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-21T21:56:36Z" }
---

## Fact

Ratios were computed with the WCAG relative-luminance formula for the exact hex values in `01-tokens.css`. The website's own tables round differently and, in one case, overstate a pass.

| Foreground | Background | Measured | Website claims | Consequence |
|---|---|---|---|---|
| `--text-code` #0f8a83 | white | 4.21:1 | 4.5:1 | AA only as large text (24px and up). Inline code on light slides must stay at `--slide-body` or larger. |
| `--color-gold-700` | `--color-gold-50` | 4.22:1 | not listed | Eyebrows on warm slides pass only at 24px and up. |
| `--color-gold-700` | white | 4.52:1 | 4.6:1 | Passes AA, barely. |
| white | `--color-purple-700` | 10.41:1 | 9.4:1 | Passes comfortably. |
| `--color-teal-500` | white | 1.88:1 | fail | Never text on light. |
| `--color-teal-600` | white | 2.46:1 | not listed | Never text on light. |
| `--color-gold-500` | white | 2.42:1 | not listed | Never text on light. |
| `--color-pink-500` | `--color-purple-700` | 2.83:1 | fail | Pink text only on purple-950 (5.2:1). |
| `--color-teal-500` | `--color-purple-950` | 10.14:1 | 8.2:1 | Code text on dark is safe. |

## Rules derived

- On light surfaces emphasis is `--color-purple-700` (10.4:1); teal is a bar, rule, marker, or glow, never text.
- Green, pink, and spirit gold text belong on `--color-purple-950` only.
- The focus ring is purple-500 on light slides and teal-500 on dark, because teal on white is 1.9:1 and fails the 3:1 non-text minimum. The header sets this through `--border-focus`.
- The `/design-review` skill encodes these as failures for `--brand=ssec`.

## Confirmation

Re-run the computation if any hex value in `source/01-tokens.css` changes. The full tables with every recommended pair are in section 2 of the brand `DESIGN.md`.
