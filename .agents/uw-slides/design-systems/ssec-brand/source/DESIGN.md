---
version: alpha
name: SSEC Design System
description: Design system for the Scientific Software Engineering Center at the University of Washington — UW brand-compliant with an AI/tech identity layered on top.

colors:
  # UW Primary — Purple
  purple-950: "#1a0038"
  purple-900: "#32006e"
  purple-800: "#3d1a7a"
  purple-700: "#4b2e83"
  purple-600: "#5a3d94"
  purple-500: "#6b4fa6"
  purple-400: "#8b74be"
  purple-300: "#a899d0"
  purple-200: "#c5b4e3"
  purple-100: "#e0d7f0"
  purple-50:  "#f0ecf7"

  # UW Secondary — Gold
  gold-900: "#5a4a2e"
  gold-800: "#6e5d3a"
  gold-700: "#85754d"
  gold-600: "#9e8d63"
  gold-500: "#b7a57a"
  gold-400: "#c9bb96"
  gold-300: "#dbd1b4"
  gold-200: "#e8e3d3"
  gold-100: "#f2efe6"
  gold-50:  "#f9f7f2"

  # UW Accent — capped at 15% page coverage
  teal-600: "#1fb8b0"
  teal-500: "#2ad2c9"
  teal-400: "#5cddd6"
  teal-300: "#8fe9e4"
  teal-200: "#c2f3f0"
  teal-100: "#e6faf9"
  green-600: "#8ab818"
  green-500: "#aadb1e"
  green-400: "#bce44e"
  green-300: "#d1ed85"
  pink-600: "#d4289a"
  pink-500: "#e93cac"
  pink-400: "#ee66bf"
  spirit-gold: "#ffc700"

  # Neutrals
  neutral-950: "#0d0f10"
  neutral-900: "#1a1d1f"
  neutral-800: "#2a2e31"
  neutral-700: "#373a3c"
  neutral-600: "#555a5e"
  neutral-500: "#72777c"
  neutral-400: "#9a9fa4"
  neutral-300: "#c2c6ca"
  neutral-200: "#d5d8de"
  neutral-100: "#eceef0"
  neutral-50:  "#f6f7f8"
  white: "#ffffff"
  black: "#000000"

  # Semantic aliases
  primary: "#4b2e83"
  primary-hover: "#32006e"
  accent: "#2ad2c9"
  surface: "#ffffff"
  surface-inverse: "#32006e"
  surface-terminal: "#1a0038"
  text-primary: "#1a1d1f"
  text-secondary: "#555a5e"
  text-inverse: "#ffffff"
  text-link: "#4b2e83"
  text-code: "#0f8a83"
  border-default: "#d5d8de"
  border-focus: "#6b4fa6"
  success: "#2e7d32"
  warning: "#f57c00"
  error: "#c62828"

typography:
  hero:
    fontFamily: Encode Sans
    fontSize: 60px
    fontWeight: 800
    lineHeight: 1.05
    letterSpacing: -0.03em
  h1:
    fontFamily: Encode Sans
    fontSize: 48px
    fontWeight: 800
    lineHeight: 1.15
    letterSpacing: -0.015em
  h2:
    fontFamily: Encode Sans
    fontSize: 40px
    fontWeight: 700
    lineHeight: 1.15
    letterSpacing: -0.015em
  h3:
    fontFamily: Encode Sans
    fontSize: 32px
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: 0em
  h4:
    fontFamily: Encode Sans
    fontSize: 24px
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: 0em
  h5:
    fontFamily: Encode Sans Compressed
    fontSize: 20px
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: 0.025em
  h6:
    fontFamily: Encode Sans Compressed
    fontSize: 16px
    fontWeight: 600
    lineHeight: 1.5
    letterSpacing: 0.05em
  lead:
    fontFamily: Open Sans
    fontSize: 20px
    fontWeight: 400
    lineHeight: 1.625
    letterSpacing: 0em
  body:
    fontFamily: Open Sans
    fontSize: 16px
    fontWeight: 400
    lineHeight: 1.625
    letterSpacing: 0em
  body-small:
    fontFamily: Open Sans
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: 0em
  caption:
    fontFamily: Open Sans
    fontSize: 12px
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: 0em
  label:
    fontFamily: Encode Sans Compressed
    fontSize: 14px
    fontWeight: 600
    lineHeight: 1.5
    letterSpacing: 0.05em
  tag:
    fontFamily: Encode Sans Compressed
    fontSize: 12px
    fontWeight: 600
    lineHeight: 1.5
    letterSpacing: 0.1em
  code-inline:
    fontFamily: JetBrains Mono
    fontSize: 14px
    fontWeight: 500
    lineHeight: 1.5
    letterSpacing: 0em
  code-block:
    fontFamily: JetBrains Mono
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.8
    letterSpacing: 0em
  stat-number:
    fontFamily: Encode Sans
    fontSize: 60px
    fontWeight: 800
    lineHeight: 1
    letterSpacing: -0.03em
  button:
    fontFamily: Encode Sans Compressed
    fontSize: 14px
    fontWeight: 600
    lineHeight: 1
    letterSpacing: 0.025em

rounded:
  none: 0
  sm: 4px
  md: 8px
  lg: 12px
  xl: 16px
  2xl: 24px
  full: 9999px

spacing:
  0: 0
  px: 1px
  0-5: 2px
  1: 4px
  1-5: 6px
  2: 8px
  2-5: 10px
  3: 12px
  4: 16px
  5: 20px
  6: 24px
  8: 32px
  10: 40px
  12: 48px
  16: 64px
  20: 80px
  24: 96px
  32: 128px

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.white}"
    typography: "{typography.button}"
    rounded: "{rounded.none}"
    padding: 8px 20px
    height: 40px
  button-secondary:
    backgroundColor: transparent
    textColor: "{colors.primary}"
    typography: "{typography.button}"
    rounded: "{rounded.none}"
    padding: 8px 20px
    height: 40px
  button-ghost:
    backgroundColor: transparent
    textColor: "{colors.primary}"
    typography: "{typography.button}"
    rounded: "{rounded.none}"
    padding: 8px 20px
    height: 40px
  button-inverse:
    backgroundColor: "{colors.white}"
    textColor: "{colors.primary}"
    typography: "{typography.button}"
    rounded: "{rounded.none}"
    padding: 8px 20px
    height: 40px
  button-accent:
    backgroundColor: "{colors.teal-500}"
    textColor: "{colors.purple-950}"
    typography: "{typography.button}"
    rounded: "{rounded.none}"
    padding: 8px 20px
    height: 40px
  button-destructive:
    backgroundColor: "{colors.error}"
    textColor: "{colors.white}"
    typography: "{typography.button}"
    rounded: "{rounded.none}"
    padding: 8px 20px
    height: 40px
  card-default:
    backgroundColor: "{colors.white}"
    textColor: "{colors.text-primary}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    padding: 24px
  card-elevated:
    backgroundColor: "{colors.white}"
    textColor: "{colors.text-primary}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    padding: 24px
  card-outlined:
    backgroundColor: transparent
    textColor: "{colors.text-primary}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    padding: 24px
  card-dark:
    backgroundColor: "{colors.purple-950}"
    textColor: "{colors.white}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    padding: 24px
  card-warm:
    backgroundColor: "{colors.gold-50}"
    textColor: "{colors.text-primary}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    padding: 24px
  input:
    backgroundColor: "{colors.white}"
    textColor: "{colors.text-primary}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    padding: 10px 12px
    height: 44px
  nav:
    backgroundColor: "{colors.purple-900}"
    textColor: "{colors.gold-200}"
    typography: "{typography.label}"
    rounded: "{rounded.none}"
    padding: 16px 32px
  code-block:
    backgroundColor: "{colors.purple-950}"
    textColor: "{colors.teal-500}"
    typography: "{typography.code-block}"
    rounded: "{rounded.md}"
    padding: 24px
  stat:
    backgroundColor: transparent
    textColor: "{colors.primary}"
    typography: "{typography.stat-number}"
    rounded: "{rounded.none}"
    padding: 0
---

## Overview

The SSEC design system expresses the Scientific Software Engineering Center as a UW-anchored, research-grade engineering organization with an AI-native edge. The personality is **engineered, open, rigorous, intelligent, and boundless**: confident University of Washington heritage in Spirit Purple and Husky Gold, plus a signature teal that signals the AI and scientific software work SSEC is known for.

The system is grounded in five principles:

1. **Engineered Clarity** — every element communicates its purpose with precision, like well-documented code.
2. **Open by Default** — content is accessible, transparency is the default, and the site itself reads as a reference implementation.
3. **Research-Grade Rigor** — colors pass WCAG 2.2 AA, type sits on a mathematical scale, spacing is a strict 4px grid, and UW brand guidelines are followed precisely.
4. **AI-Native Thinking** — interactions feel responsive and intelligent; motion and visualization suggest computation without resorting to chatbot decoration.
5. **Boundless Discovery** — cross-linked content invites traversal across projects, people, and publications.

The emotional intent is **trustworthy but distinctive**: deeply UW, unmistakably SSEC.

## Colors

The palette is organized as **primary (purple)**, **secondary (gold)**, and **accent (teal/green/pink/spirit-gold)**, plus a neutral ramp. Purple dominates the brand; gold supports; accents stay under 15% of any page per UW guidelines.

### Primary — UW Purple
Spirit Purple `{colors.purple-700}` is the primary interactive color for CTAs, links, and headings. Husky Purple `{colors.purple-900}` anchors dark surfaces; `{colors.purple-950}` is reserved for hero and terminal-style sections. Accent Lavender `{colors.purple-200}` is the lightest brand-approved purple.

### Secondary — UW Gold
Heritage Gold `{colors.gold-700}` provides strong gold text on white; Husky Gold `{colors.gold-500}` powers borders, badges, and accents; `{colors.gold-50}` and `{colors.gold-200}` warm the testimonial and stats surfaces.

### Accent — SSEC Identity
Teal `{colors.teal-500}` is the SSEC signature, used for AI-related CTAs, code highlights, hover glows, and data visualizations. Green `{colors.green-500}`, pink `{colors.pink-500}`, and spirit-gold `{colors.spirit-gold}` are decorative-only and must sit on dark backgrounds to satisfy contrast.

### Semantic Roles

- `{colors.primary}` — primary interactive (purple-700)
- `{colors.accent}` — AI/tech signature (teal-500)
- `{colors.surface}` — default page surface (white)
- `{colors.surface-inverse}` — dark hero/footer surface (purple-900)
- `{colors.surface-terminal}` — code/terminal blocks (purple-950)
- `{colors.text-primary}` / `{colors.text-secondary}` / `{colors.text-inverse}` — text hierarchy
- `{colors.text-link}` / `{colors.text-code}` — links and inline code
- `{colors.border-default}` / `{colors.border-focus}` — outlines and focus
- `{colors.success}` / `{colors.warning}` / `{colors.error}` — status

### Verified Contrast (WCAG 2.2 AA)

| Foreground | Background | Ratio |
|---|---|---|
| white | `{colors.primary}` | 9.4:1 |
| `{colors.primary}` | white | 9.4:1 |
| white | `{colors.purple-900}` | 12.6:1 |
| `{colors.text-primary}` | white | 16.3:1 |
| `{colors.accent}` | `{colors.purple-950}` | 8.2:1 |

Known failures (do **not** use): spirit-gold on white, teal-500 on white, pink-500 on purple-700, green-500 on white.

## Typography

Four font families, each with a distinct job. Maximum two display/body families per page; the monospace family is additive.

- **Encode Sans** — display: hero, h1–h4, stat numbers
- **Encode Sans Compressed** — UI: buttons, navigation, labels, tags, h5–h6
- **Open Sans** — reading: body, lead paragraphs, captions
- **JetBrains Mono** — code: inline code, code blocks, terminal text

### Levels

- `{typography.hero}` — page-defining headlines on the home hero
- `{typography.h1}` through `{typography.h6}` — sequential heading hierarchy, never skipped
- `{typography.lead}` — opening paragraphs and card descriptions
- `{typography.body}` — default reading text (minimum 16px)
- `{typography.body-small}` — secondary metadata
- `{typography.caption}` — footnotes, timestamps, image captions
- `{typography.label}` — form labels, uppercase UI text
- `{typography.tag}` — pill labels and category chips, all caps, widest tracking
- `{typography.code-inline}` / `{typography.code-block}` — code in body or in dedicated blocks
- `{typography.stat-number}` — hero metrics ("22 Projects", etc.)
- `{typography.button}` — uppercase compressed button text

All sizes are fluid via `clamp()` in the implementation; the values in frontmatter are the desktop targets. Maximum line length is 75 characters; minimum body size is 16px.

## Layout

The layout system is a **4px-based spacing scale on a 12-column grid**, with three container widths matching UW conventions.

### Containers
- `width-content: 960px` — articles and long-form text
- `width-wide: 1140px` — feature grids, default page width
- `width-full: 1400px` — full-bleed heroes

### Grid
Twelve fluid columns with a `{spacing.6}` (24px) gutter — the UW standard block gap. Responsive behavior compresses to four columns at 1280px, three at 1024px, two at 640px, and a single column below 640px.

### Spacing Strategy
The scale (`{spacing.1}` through `{spacing.32}`) supplies inline, stack, and section rhythm:

- **Inline** — `{spacing.2}` for related elements, `{spacing.4}` for default
- **Stack** — `{spacing.4}` between paragraphs, `{spacing.8}` between content blocks
- **Section** — `{spacing.12}` (subsections), `{spacing.16}` (primary), `{spacing.24}` (hero)

### Visual Rhythm
The home page alternates light and dark sections (nav-dark → hero-dark → stats-warm → projects-light → AI-dark → testimonials-warm → news-light → footer-dark) so transitions read as natural boundaries rather than divider lines.

### The 15° Motif
UW's brand uses a 15-degree angle (Boundless Bar, Angled Rain). SSEC adopts it for **angled section dividers** (clip-path transitions between dark/light sections), thin decorative borders behind hero text, and subtle 105° rain textures on dark surfaces.

## Elevation & Depth

Depth is created with **shadows, glows, and surface contrast** rather than heavy borders.

### Shadow Scale
- `shadow-xs` — hairline lift on inputs and chips
- `shadow-sm` — default cards
- `shadow-md` — elevated cards and dropdown menus
- `shadow-lg` — card hover state, popovers
- `shadow-xl` — modals
- `shadow-2xl` — feature spotlights, lightboxes

### Branded Glows
- `shadow-glow-sm/md/lg` — purple-tinted glows on dark sections for AI moments
- `shadow-glow-teal-sm/md` — teal-tinted glows accenting code and AI elements

### Z-Index Scale
`z-base (0)` → `z-raised (1)` → `z-dropdown (10)` → `z-sticky (20)` → `z-overlay (30)` → `z-modal (40)` → `z-toast (50)`.

### Hover Lift
Interactive cards translate `-2px` on Y and bump from `shadow-sm` to `shadow-lg` over `duration-normal` (200ms). All elevation transitions are disabled under `prefers-reduced-motion`.

## Shapes

The form language favors **sharp UW-correct edges on buttons** and **gentle rounding on containers**. Corner radius follows the `rounded` scale:

- `{rounded.none}` — buttons (UW brand requires sharp corners), section dividers
- `{rounded.sm}` — chips, badges, subtle rounding
- `{rounded.md}` — cards, inputs, code blocks (default)
- `{rounded.lg}` — larger containers, modal sheets
- `{rounded.xl}` — feature cards
- `{rounded.2xl}` — hero media elements
- `{rounded.full}` — pill labels, avatars, tag chips

The **15-degree angle** is the secondary shape language: clip-path polygons cut section transitions diagonally, echoing the UW Boundless Bar and giving SSEC a structural signature distinct from generic rounded-rectangle UIs.

## Components

Seven foundational components form the SSEC library. Each obeys the tokens above; variants exist for context (light vs dark, primary vs accent).

### Button
Six variants — primary, secondary, ghost, inverse, accent, destructive — across three sizes (small 32px, medium 40px, large 48px). All use uppercase compressed text, sharp corners, and the UW focus ring (`0 0 0 0.2rem rgba(75, 46, 131, 0.5)`). Minimum touch target is 44×44px; loading state announces `aria-busy="true"`.

- `{components.button-primary}` — main CTAs
- `{components.button-secondary}` — 2px purple border, transparent fill
- `{components.button-ghost}` — nav and tertiary actions
- `{components.button-inverse}` — white on dark sections
- `{components.button-accent}` — AI-related CTAs only, used sparingly
- `{components.button-destructive}` — delete/remove

### Card
Five variants tuned to context: `{components.card-default}` (white + thin border + subtle shadow), `{components.card-elevated}` (no border, larger shadow), `{components.card-outlined}` (transparent, used in dense project grids), `{components.card-dark}` (purple-950 with teal glow for AI features), `{components.card-warm}` (gold-50 for testimonials). Hover lifts `-2px` and increases shadow. Image cards bleed to the card edges.

### Input
`{components.input}` covers text, email, search, textarea, and select. States — default, hover, focus, error, disabled — change border color and (for error) background. Labels are required and linked via `for`/`id`; error messages link via `aria-describedby`.

### Navigation Bar
`{components.nav}` — sticky, `{colors.purple-900}` background, white logo, gold-200 links that brighten to white on hover. The active link carries a 2px teal underline (the SSEC signature). Mobile collapses into a full-screen `{colors.purple-950}` overlay.

### Section Divider
A diagonal `clip-path` element that cuts between sections at the 15° brand angle, used at every transition between a light section and a dark section on the home page.

### Code Block
`{components.code-block}` — `{colors.purple-950}` background, teal text, JetBrains Mono, terminal-style `$` prefix in muted gold. The signature element of the AI Hub and any code-forward page.

### Stat Counter
`{components.stat}` — extrabold Encode Sans hero-sized number in primary purple, label below in uppercase compressed gray. Used on the home stats bar (`22 Projects`, `11+ Software`, etc.).

## Do's and Don'ts

### Do

- **Do** lead with Spirit Purple `{colors.primary}` for CTAs and brand moments.
- **Do** keep accent colors (teal, green, pink, spirit-gold) under 15% of any page.
- **Do** use teal `{colors.accent}` as the SSEC signature on AI-related surfaces — code blocks, hover glows, the active-nav underline.
- **Do** verify every text/background pair against the contrast table; aim for AA at minimum.
- **Do** keep buttons sharp-cornered (`{rounded.none}`); rounding buttons breaks UW brand.
- **Do** alternate light and dark sections on long pages so the 15° angled dividers carry the rhythm.
- **Do** respect `prefers-reduced-motion` — disable card lift, data-stream, and node-pulse animations.
- **Do** use sequential heading levels (no skipping h2 → h4).
- **Do** keep body copy at 16px minimum and line length around 75 characters.

### Don't

- **Don't** use teal, green, or pink for logos or large color fields — these are accents only.
- **Don't** put `{colors.spirit-gold}`, `{colors.teal-500}`, `{colors.green-500}`, or `{colors.pink-500}` as text on white; all four fail WCAG AA.
- **Don't** mix more than two display/body font families on a page (mono is additive).
- **Don't** use rounded corners on buttons or apply more than `{rounded.2xl}` anywhere outside hero media.
- **Don't** layer gratuitous animation — motion communicates state and hierarchy, never decoration.
- **Don't** crowd accent colors next to each other; teal is the SSEC voice, not the whole choir.
- **Don't** introduce off-grid spacing values — every gap is a multiple of 4px.
- **Don't** drop the 15° angle below 4rem of vertical height; it disappears and reads as a misalignment.
- **Don't** rebrand UW marks; logo usage follows UW restrictions on approved colors and clear space.
