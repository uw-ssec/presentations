# SSEC Design System — Slides

> Scientific Software Engineering Center, University of Washington
> UW brand-compliant with the SSEC AI/tech identity layered on top. WCAG 2.2 AA.

This is the slide adaptation of the SSEC website design system. The upstream
system is vendored verbatim in [`source/`](source/) (from
[uw-ssec/uw-ssec.github.io](https://github.com/uw-ssec/uw-ssec.github.io)
`design-system/`, commit `d313f9e`, 2026-07-24). Read `source/DESIGN.md` for
the full rationale; read this file before writing any slide HTML. Where the two
disagree, this file wins for slides, because projected decks have stricter
size and contrast needs than a website.

Token names are the website's, unchanged (`--color-purple-700`,
`--font-compressed`, `--surface-terminal`, …), so a slide and a web page share
one vocabulary. The complete token sheet is
[`colors_and_type.css`](colors_and_type.css); `shared/header.html` inlines the
same tokens plus slide utilities.

## 1. Visual Theme

SSEC is **UW-anchored, research-grade, AI-native**. Spirit Purple and Husky
Gold carry the University of Washington heritage; a single teal signature marks
the AI and scientific-software work SSEC is known for. Slides should read as
*trustworthy but distinctive: deeply UW, unmistakably SSEC*.

The five principles from `source/00-principles.md`, applied to slides:

1. **Engineered Clarity** — one idea per slide, hierarchy obvious at a glance.
2. **Open by Default** — show the data, the code, the source line.
3. **Research-Grade Rigor** — every pair passes contrast, every size sits on
   the scale, every gap is a multiple of 4px.
4. **AI-Native Thinking** — terminal-dark surfaces, teal glows, monospace
   detail. Never chatbot decoration.
5. **Boundless Discovery** — the UW 15° angle as a structural motif: angled
   dividers, skewed rules and markers, rain texture.

**Key characteristics**

- Spirit Purple `#4b2e83` primary; Husky Purple `#32006e` and `#1a0038` for
  dark surfaces
- Husky Gold `#b7a57a` bars and borders; Heritage Gold `#85754d` for gold text
  on light; Light Gold `#e8e3d3` for body text on dark
- Teal `#2ad2c9` is the SSEC signature: accent bars, underlines, code text on
  dark, glows. Under 15% of any slide.
- Encode Sans (display), Encode Sans Compressed (eyebrows, labels), Open Sans
  (body), JetBrains Mono (code)
- Light and dark slides alternate; dark slides carry the 15° angled gold divider
- Minimum 24px for all content text; 4.5:1 contrast for all text

## 2. Color

Purple dominates, gold supports, teal accents. The full ramps live in
`colors_and_type.css`; these are the stops slides actually use.

### Primary — UW Purple

| Token | Hex | Slide role |
|---|---|---|
| `--color-purple-950` | `#1a0038` | Title, section, and terminal slide backgrounds |
| `--color-purple-900` | `#32006e` | Dark slide backgrounds, gradient partner to 950 |
| `--color-purple-700` | `#4b2e83` | **Primary.** Headings on light, emphasis, bullet markers, table headers |
| `--color-purple-500` | `#6b4fa6` | Focus ring on light slides |
| `--color-purple-200` | `#c5b4e3` | Lavender accent, data-viz pastel |
| `--color-purple-50`  | `#f0ecf7` | Inline code background on light |

### Secondary — UW Gold

| Token | Hex | Slide role |
|---|---|---|
| `--color-gold-700` | `#85754d` | Heritage Gold: eyebrows and gold text on white |
| `--color-gold-500` | `#b7a57a` | Husky Gold: angled dividers, heading underlines, quote bars, `$` prompt |
| `--color-gold-200` | `#e8e3d3` | Body and subtitle text on dark slides |
| `--color-gold-50`  | `#f9f7f2` | Warm surface: quotes, stats, every other content slide |

### Accent — SSEC identity (≤ 15% of any slide)

| Token | Hex | Slide role |
|---|---|---|
| `--color-teal-500` | `#2ad2c9` | **Signature.** Accent bars, `.signature-rule`, code text on dark, glows |
| `--color-teal-400` | `#5cddd6` | Links on dark |
| `--color-teal-300` | `#8fe9e4` | Eyebrows on dark |
| `--color-green-500` | `#aadb1e` | Success or growth marker, dark slides only |
| `--color-pink-500` | `#e93cac` | Rare alert, dark slides only |
| `--color-spirit-gold` | `#ffc700` | Decorative only, dark slides only |

### Neutrals

| Token | Hex | Slide role |
|---|---|---|
| `--color-neutral-900` | `#1a1d1f` | Body text on light |
| `--color-neutral-600` | `#555a5e` | Secondary text, captions, sources on light |
| `--color-neutral-200` | `#d5d8de` | Borders, table rules |
| `--color-white` | `#ffffff` | Default light surface; text on dark |

### Semantic aliases

Prefer aliases inside slide CSS so a slide can be flipped to dark by adding
`class="dark"` to its `<section>`:

- `--surface-primary` (white, dark: purple-950), `--surface-secondary`
  (gold-50, dark: purple-900), `--surface-terminal` (purple-950)
- `--text-primary` (neutral-900, dark: white), `--text-secondary`
  (neutral-600, dark: gold-200), `--text-brand` (purple-700, dark: gold-500),
  `--text-code` (`#0f8a83`, dark: teal-500)
- `--border-default`, `--border-accent` (teal-500), `--border-focus`

### Verified contrast

Ratios computed with the WCAG relative-luminance formula for the exact hex
values above (the website's tables round differently; these are the numbers
to trust for slides).

**Dark surfaces** (purple-950 unless noted)

| Foreground | Background | Ratio | Use |
|---|---|---|---|
| white | purple-950 | 19.1:1 | Titles |
| white | purple-900 | 15.4:1 | Titles |
| white | purple-700 | 10.4:1 | Titles |
| gold-200 | purple-950 | 14.9:1 | Body, subtitles |
| gold-200 | purple-700 | 8.1:1 | Body |
| teal-300 | purple-950 | 13.6:1 | Eyebrows |
| teal-400 | purple-950 | 11.6:1 | Links |
| teal-500 | purple-950 | 10.1:1 | Code text, emphasis |
| teal-500 | purple-700 | 5.5:1 | Emphasis (AA) |
| gold-500 | purple-950 | 7.9:1 | Gold text, `$` prompt |
| gold-500 | purple-900 | 6.4:1 | Gold text |
| purple-200 | purple-950 | 10.0:1 | Lavender accent text |
| spirit-gold | purple-950 | 12.2:1 | Decorative highlight |
| green-500 | purple-950 | 11.7:1 | Success marker |
| pink-500 | purple-950 | 5.2:1 | Alert (AA) |

**Light surfaces**

| Foreground | Background | Ratio | Use |
|---|---|---|---|
| neutral-900 | white | 16.9:1 | Body |
| neutral-900 | gold-50 | 15.8:1 | Body |
| purple-700 | white | 10.4:1 | Headings, emphasis |
| purple-700 | gold-50 | 9.7:1 | Headings |
| purple-900 | gold-50 | 14.4:1 | Headings |
| neutral-600 | white | 7.0:1 | Secondary text, sources |
| neutral-600 | gold-50 | 6.5:1 | Secondary text |
| gold-700 | white | 4.5:1 | Eyebrows (AA, exactly) |
| gold-700 | gold-50 | 4.2:1 | Eyebrows at ≥ 24px only (AA large) |
| `--text-code` #0f8a83 | white | 4.2:1 | Inline code at ≥ 24px only (AA large) |

**Fails on light — never as text on white, gold-50, or purple-50**

| Foreground | Background | Ratio |
|---|---|---|
| teal-500 | white | 1.9:1 |
| teal-600 | white | 2.5:1 |
| gold-500 | white | 2.4:1 |
| spirit-gold | white | 1.6:1 |
| green-500 | white | 1.6:1 |
| pink-500 | purple-700 | 2.8:1 |

Rules that follow:

- Teal is **never text on a light slide**. Emphasis on light slides is
  `--color-purple-700`. Teal on light is a bar, a rule, a glow, or a marker.
- Inline code on light slides uses `--text-code`, which is AA only at slide
  sizes (≥ 24px, i.e. large text). Keep code at `--slide-body` or larger.
- Gold text on light is Heritage Gold `--color-gold-700`, at ≥ 24px on
  gold-50.
- Green, pink, and Spirit Gold live on purple-950 only.
- Do not rely on color alone; pair every colored state with a label or shape.

## 3. Typography

Four families, each with one job. Two display/body families per slide at most;
the mono family is additive.

| Role | Family | Token | Weights | Use |
|---|---|---|---|---|
| Display | Encode Sans | `--font-display` | 700–900 | Titles, key messages, stat numbers |
| UI | Encode Sans Compressed | `--font-compressed` | 600–700 | Eyebrows, tags, section numbers, table headers, uppercase labels |
| Reading | Open Sans | `--font-body` | 400–600 | Body, bullets, captions, sources |
| Code | JetBrains Mono | `--font-mono` | 400–500 | Code blocks, inline code, terminal text |

The website's 12–60px fluid scale is **not** used on slides. Use the slide
scale from `colors_and_type.css`; all sizes are `clamp()` with a 1.5rem floor.

| Token | Range | Family, weight | Use |
|---|---|---|---|
| `--slide-hero` | 56–86px | Encode Sans 800–900 | Title and section slides |
| `--slide-title` | 40–56px | Encode Sans 800 | Slide h1 |
| `--slide-subtitle` | 28–40px | Encode Sans 700 | h2, column heads |
| `--slide-lead` | 26–34px | Open Sans 400–600 | Key message, lead sentence |
| `--slide-body` | 24–28px | Open Sans 400 | Body, bullets |
| `--slide-code` | 24–26px | JetBrains Mono 400 | Code blocks |
| `--slide-stat` | 64–120px | Encode Sans 800 | Stat numbers |
| `--slide-label` | 16–20px | Encode Sans Compressed 600–700, uppercase, `--tracking-widest` | Eyebrows, tags (decorative exception) |
| `--slide-source` | 16–20px | Open Sans 400 | Citations only (the one content exception) |

Rules:

- Headings keep sentence case with `--tracking-tight` (the website style).
  Uppercase belongs to Encode Sans Compressed labels, never to Encode Sans
  titles. This is the visible difference from the plain UW brand, which sets
  titles in uppercase Black 900.
- Title-slide h1 gets a `.signature-rule` (112×4px teal, skewed 15°) beneath it.
- Content-slide h1 on light surfaces gets a 3px `--color-gold-500` bottom
  border.
- Line height: `--leading-tight` (1.15) for titles, `--leading-relaxed`
  (1.625) for body. Body copy stays under 75 characters per line.
- Never hard-code a size below 1.5rem for content text. If text overflows,
  cut words, not pixels.

### Font loading

Fonts load from Google Fonts, exactly as the SSEC website does
(`shared/header.html` carries the `<link>`). No fonts are copied into the deck.
For a venue without network access, copy the Encode Sans Normal and
Compressed files from `../uw-brand/fonts/` to the deck's `assets/fonts/` and
add matching `@font-face` rules ahead of the tokens in `shared/header.html`;
Open Sans and JetBrains Mono fall back to the system stacks in the token
values.

## 4. Layout and the 15° motif

- Slide padding: `--space-20` (80px) default, `--space-16` (64px) for dense
  slides. Content sits in the center 80% of the frame.
- Spacing is the website's 4px scale. Heading to body `--space-6`, between
  bullets `--space-4`, between content blocks `--space-8`, column gap
  `--space-12`.
- Light and dark slides alternate. A run of more than three light slides
  should be broken by a warm (gold-50) slide or a dark slide. Section
  transitions are always dark.
- The UW 15° angle (`--angle-brand`) is the structural signature:
  - `.angle-divider`: 72px Husky Gold bar along the bottom of dark slides,
    cut at 15°
  - `.signature-rule`: teal rule skewed 15° under title-slide headings
  - Bullet markers: 10×7px purple-700 blocks with `skewX(-15deg)`
  - `.rain-texture`: repeating 105° hairlines at 3.5% white on dark, 7% purple
    on light, kept to a corner or the lower third
- Corners: `--radius-md` (8px) for cards and code blocks; anything button-like
  is sharp (`--radius-none`); never above `--radius-2xl`.
- Depth comes from surface contrast and glows, not borders. `--shadow-sm` for
  cards on light; `--shadow-glow-teal-md` behind code and AI moments on dark.

## 5. Components (slide versions)

Utilities are defined once in `shared/header.html`; per-slide styles scope
everything else with `section[data-slide="…"]`.

**Accent bar** — `.accent-bar-top | -bottom | -left | -right`, 4px
`--color-teal-500`. Every content slide carries one, or a `.angle-divider` if
it is dark. This is the check `/design-review` runs.

**Angled divider** — `.angle-divider`, gold-500, bottom edge, 15° cut. Title
and section slides.

**Eyebrow** — `.eyebrow`: Encode Sans Compressed, uppercase, widest tracking,
gold-700 on light, teal-300 on dark. One per slide, above the h1.

**Signature rule** — `.signature-rule` under a hero h1.

**Bullets** — no default discs. `li::before` is a 10×7px purple-700 block
skewed 15°, positioned at `0.68em`; nested lists use gold-700 at 7×5px. Three
to five bullets per slide, one line each.

**Code block** — `.code-block`: purple-950, teal-500 JetBrains Mono at
`--slide-code`, 1px teal border at 15% alpha, `$ ` prompt in gold-500. Add
`.code-block--plain` to drop the prompt. Keep to eight lines; shorten, do not
shrink.

**Inline code** — bare `<code>` on light: `--text-code` on purple-50, at
≥ 24px. On dark: teal-500.

**Stat counter** — `.stat` > `.stat__number` + `.stat__label`. Numbers in
Encode Sans 800 purple-700 (gold-500 on dark), label compressed uppercase.
Three or four stats across a warm slide.

**Quote** — gold-50 block with a 7px inset gold-500 left bar; italic Open Sans
at `--slide-lead`, attribution in neutral-600.

**Table** — purple-700 header row with white compressed uppercase text;
neutral-200 row rules; gold-50 zebra rows; never below `--slide-body`.

**Cards** — white on gold-50 (or gold-50 on white), 1px neutral-200 border,
`--radius-md`, `--shadow-sm`, `--space-6` padding. Dark cards: purple-950 with
`--shadow-glow-teal-sm` for AI content.

## 6. Slide types

**Title slide** (dark)
- Background: `linear-gradient(135deg, purple-950, purple-900)` plus a teal
  radial glow at 16% alpha in the upper right, `.rain-texture`
- `.eyebrow` (event, date) in teal-300
- h1 at `--slide-hero`, white, sentence case, `.signature-rule` beneath
- Subtitle in gold-200 at `--slide-lead`
- Presenter block in gold-200, name in white
- `.angle-divider` at the bottom

**Section transition** (dark)
- Same surface as the title slide, no glow
- Section number in Encode Sans Compressed gold-500 at `--slide-label` scale
  ×2, then h1 at `--slide-hero`
- `.angle-divider`

**Content slide, light** (default)
- White with a faint 6% purple wash from the left edge
- `.accent-bar-left` or `.accent-bar-top`
- Optional `.eyebrow` in gold-700
- h1 in purple-700 at `--slide-title` with the 3px gold-500 underline
- Body in neutral-900; skewed purple bullets

**Content slide, warm**
- gold-50 with a 105° gold-500 wash at 18% from the left
- Same structure as light; use for quotes, stats, and to break light runs

**Code / AI slide** (dark)
- purple-950, `class="dark"` so aliases flip
- h1 white; `.code-block` fills the lower two thirds
- `.accent-bar-top` in teal or `.angle-divider`
- The only slide type where teal may exceed a hairline

**Closing slide** (dark)
- Title-slide surface; contact and repo links in teal-400; QR or wordmark
  bottom left; `.angle-divider`

## 7. Motion

Slide changes are cuts or fades only. Durations use `--duration-normal`
(200ms) and `--ease-out`. The website's data-stream and node-pulse animations
are not used on slides except a static rain texture. No animated text, no
spinning, no parallax. `shared/header.html` disables all animation under
`prefers-reduced-motion`.

## 8. Accessibility (WCAG 2.2 AA)

- Every text pair meets 4.5:1 (see Section 2). Large-text exceptions are
  listed explicitly and apply only at slide sizes.
- Every content text value ≥ 24px; labels and sources ≥ 16px.
- Every `<section>` has `class="slide"`, a unique `data-slide`, and an
  `aria-label`. Sequential headings, one h1 per slide.
- Every `<img>` has `alt`; decorative images use `alt=""`; complex figures get
  an adjacent text summary.
- Focus indicator: 3px purple-500 on light, teal-500 on dark (set in the
  header).
- Keyboard navigation comes from `shared/footer.html`.
- Color is never the only carrier of meaning.

## 9. Do and don't

**Do**

- Lead with purple-700; let gold support; keep teal to bars, rules, code, and
  glows.
- Alternate light, warm, and dark slides so the 15° divider carries the
  rhythm.
- Set titles in sentence case Encode Sans; reserve uppercase for compressed
  labels.
- Put code on purple-950 in JetBrains Mono, teal on dark.
- Use the semantic aliases and `class="dark"` rather than re-picking colors
  per slide.
- Cite sources in a `.source` line at the bottom.

**Don't**

- Don't put teal, green, pink, gold-500, or spirit-gold text on a light
  surface.
- Don't use the website's `--text-*` size tokens or any value under 1.5rem
  for content.
- Don't add a third display or body family, or use a serif or script face.
- Don't round buttons, and don't use radii above `--radius-2xl`.
- Don't drop the angled divider below 4rem of height; it reads as a mistake.
- Don't animate text or decorate with "AI" motifs; the intelligence is in the
  clarity.
- Don't invent new class names for things the header utilities already do.

## 10. Code

Example: title slide.

```html
<section data-slide="01-title" aria-label="Title: Security in the Age of AI"
         class="slide dark rain-texture">
  <div class="content">
    <p class="eyebrow">UW SSEC RSE Meetup · May 14, 2026</p>
    <h1>Security in the Age of AI<span class="signature-rule"></span></h1>
    <p class="subtitle">Open source supply chain security: threats, mitigations, hardened workflows</p>
    <p class="presenter"><strong>Presenter Name</strong><br>Scientific Software Engineering Center</p>
  </div>
  <div class="angle-divider"></div>

  <style>
    section[data-slide="01-title"] {
      background:
        radial-gradient(circle at 82% 26%, rgba(42, 210, 201, 0.16), transparent 25%),
        linear-gradient(135deg, var(--color-purple-950), var(--color-purple-900));
      align-items: center;
      padding: var(--space-20);
    }
    section[data-slide="01-title"] .content { max-width: 1100px; position: relative; z-index: var(--z-raised); }
    section[data-slide="01-title"] h1 {
      font-family: var(--font-display);
      font-size: var(--slide-hero);
      font-weight: var(--font-extrabold);
      letter-spacing: var(--tracking-tight);
      line-height: var(--leading-tight);
      color: var(--text-primary);
      margin: var(--space-4) 0 var(--space-6);
    }
    section[data-slide="01-title"] .subtitle {
      font-family: var(--font-body);
      font-size: var(--slide-lead);
      color: var(--text-secondary);
      max-width: 900px;
      margin-bottom: var(--space-10);
    }
    section[data-slide="01-title"] .presenter {
      font-size: var(--slide-body);
      color: var(--text-secondary);
      line-height: var(--leading-relaxed);
    }
    section[data-slide="01-title"] .presenter strong { color: var(--text-primary); }
  </style>
</section>
```

Example: light content slide.

```html
<section data-slide="03-threats" aria-label="Slide 3: Three ways a dependency turns hostile" class="slide">
  <div class="accent-bar-left"></div>
  <div class="content">
    <p class="eyebrow">Threat model</p>
    <h1>Three ways a dependency turns hostile</h1>
    <ul>
      <li>Maintainer account takeover</li>
      <li>Build pipeline injection</li>
      <li>Typosquatted package names</li>
    </ul>
    <p class="source">Source: CNCF Software Supply Chain Best Practices, 2024</p>
  </div>

  <style>
    section[data-slide="03-threats"] {
      background: linear-gradient(90deg, rgba(75, 46, 131, 0.06), transparent 34%), var(--surface-primary);
      padding: var(--space-20);
    }
    section[data-slide="03-threats"] .content { display: flex; flex-direction: column; height: 100%; }
    section[data-slide="03-threats"] h1 {
      font-family: var(--font-display);
      font-size: var(--slide-title);
      font-weight: var(--font-extrabold);
      letter-spacing: var(--tracking-tight);
      line-height: var(--leading-tight);
      color: var(--text-brand);
      border-bottom: 3px solid var(--color-gold-500);
      padding-bottom: var(--space-3);
      margin: var(--space-2) 0 var(--space-8);
    }
    section[data-slide="03-threats"] ul { list-style: none; }
    section[data-slide="03-threats"] li {
      position: relative;
      padding-left: var(--space-8);
      margin-bottom: var(--space-4);
      font-size: var(--slide-body);
      line-height: var(--leading-relaxed);
    }
    section[data-slide="03-threats"] li::before {
      content: "";
      position: absolute;
      left: 0;
      top: 0.68em;
      width: 10px;
      height: 7px;
      background: var(--color-purple-700);
      transform: skewX(calc(-1 * var(--angle-brand)));
    }
    section[data-slide="03-threats"] .source { margin-top: auto; }
  </style>
</section>
```

Example: code slide.

```html
<section data-slide="07-pin" aria-label="Slide 7: Pin actions by commit SHA" class="slide dark">
  <div class="accent-bar-top"></div>
  <div class="content">
    <p class="eyebrow">Mitigation</p>
    <h1>Pin actions by commit SHA</h1>
    <pre class="code-block code-block--plain"># before
- uses: actions/checkout@v4

# after
- uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd  # v6.0.2</pre>
  </div>

  <style>
    section[data-slide="07-pin"] { background: var(--surface-terminal); padding: var(--space-20); }
    section[data-slide="07-pin"] h1 {
      font-family: var(--font-display);
      font-size: var(--slide-title);
      font-weight: var(--font-extrabold);
      color: var(--text-primary);
      margin: var(--space-2) 0 var(--space-8);
    }
    section[data-slide="07-pin"] .code-block { box-shadow: var(--shadow-glow-teal-md); }
  </style>
</section>
```

## 11. Checklist

Brand

- [ ] purple-700 is the primary; teal appears only as bar, rule, code, or glow
- [ ] Accent colors under 15% of the slide
- [ ] Titles in sentence-case Encode Sans; uppercase only on compressed labels
- [ ] Code in JetBrains Mono on purple-950
- [ ] Every content slide has an accent bar or angled divider
- [ ] Light, warm, and dark slides alternate

Accessibility

- [ ] Every text pair is in the verified table, or measured ≥ 4.5:1
- [ ] No teal, green, pink, gold-500, or spirit-gold text on light
- [ ] Content text ≥ 24px; labels and sources ≥ 16px
- [ ] `aria-label`, `data-slide`, `class="slide"` on every section
- [ ] `alt` on every image; sequential headings
- [ ] `prefers-reduced-motion` respected (header does this)

Technical

- [ ] All styles scoped with `section[data-slide="…"]`
- [ ] Tokens and header utilities used, no new hex values
- [ ] Sizes come from `--slide-*`, none below 1.5rem
- [ ] `class="dark"` on purple-950/900 slides so aliases flip

## 12. Source and re-sync

`source/` is a verbatim copy of `design-system/` from uw-ssec.github.io at
commit `d313f9e`. To re-sync:

1. Copy the upstream folder over `source/`.
2. Diff `source/01-tokens.css` against the tier-1 and tier-2 blocks in
   `colors_and_type.css` and `shared/header.html`; apply token changes to both.
   Leave the `--slide-*` scale and the utilities alone unless the brand
   changes.
3. Recompute the contrast tables in Section 2 if any hex value changed.
4. Update the commit reference at the top of this file.
