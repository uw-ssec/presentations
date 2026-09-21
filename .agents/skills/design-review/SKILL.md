---
name: design-review
description: Validate UW brand compliance. Checks color tokens, fonts, layout patterns, logo usage, and design system adherence.
---

# Design Review Skill

## Purpose
Ensure slide deck follows UW brand guidelines.

## What Gets Checked
1. **Color Tokens** — Use CSS variables, not hardcoded hex
2. **Font Usage** — Only approved fonts for the brand
3. **Font Size Floor** — All visible text must use `clamp()` with a minimum of `1.5rem` (24pt). Exception: source/citation lines and decorative uppercase labels may use `1rem` minimum. Hard-coded values below `1.5rem` for content text are a violation. Presentations are projected — small text is unreadable past the third row of an audience.
4. **Layout Patterns** — Use approved templates
5. **Logo Treatment** — Correct inversion on dark backgrounds
6. **Accent Bar** — Every slide must have a brand accent bar:
   - `--brand=uw`: 8px `--uw-spirit-gold` bar
   - `--brand=ssec`: 4px `--color-teal-500` bar (`.accent-bar-*`), or the `.angle-divider` gold bar on dark title and section slides
7. **Type Scale** — Follow brand hierarchy
8. **SSEC contrast rules** *(brand=ssec only)*
   - Any text whose foreground is `--color-teal-500`, `--color-teal-600`, `--color-gold-500`, `--color-spirit-gold`, `--color-green-500`, or `--color-pink-500` on a light surface (`--color-white`, `--color-gold-50`, `--color-purple-50`, `--surface-primary` outside `.dark`) → **FAIL** with: "<token> on light fails WCAG AA (teal-500 1.9:1, gold-500 2.4:1). Use `--color-purple-700` (10.4:1) for emphasis; teal on light is a bar, rule, or glow only."
   - `--color-pink-500` text on `--color-purple-700` → **FAIL** (2.8:1). Pink, green, and spirit-gold text belong on `--color-purple-950` only.
   - `--text-code` (#0f8a83) or `--color-gold-700` text on a light surface below `--slide-body` (24px) → **FAIL** (4.2:1 and 4.5:1 pass only as large text).
   - Sizes taken from the website's `--text-xs` … `--text-5xl` tokens → **FAIL**; slides use `--slide-*`.
   - Teal, green, pink, and spirit-gold together cover more than about 15% of a slide → **WARN**.
   - Title text set in uppercase Encode Sans → **WARN** ("SSEC titles are sentence case; uppercase is for `--font-compressed` labels").

## Usage
```bash
/design-review
/design-review --brand=uw
```

The optional `--brand=<ssec|uw>` parameter selects which brand rules to apply. Defaults to `ssec`.

## Output
```
✅ Brand Compliant
❌ Violations:
  - Slide 03: Hardcoded color #4b2e83 (use var(--uw-spirit-purple))
  - Slide 08: Missing accent bar
  - Slide 11 [ssec]: --color-teal-500 on light fails WCAG AA (1.9:1). Use --color-purple-700 for emphasis; teal on light is a bar, rule, or glow only.
```

See `.agents/uw-slides/design-systems/<brand>-brand/DESIGN.md` for complete brand requirements.
