# uw-slides (vendored)

Brand systems, templates, fonts, and reference docs for the fragment-based
slide builder, vendored from
[aaarendt/uw-slide-deck-plugin](https://github.com/aaarendt/uw-slide-deck-plugin)
(MIT, see `LICENSE`). Upstream version: 0.1.0.

The plugin's skills live one directory up at `.agents/skills/`, and
`.claude/skills` is a symlink to that directory. Claude Code therefore loads
them as project skills with no marketplace install:

| Skill                  | Purpose                                                      |
| ---------------------- | ------------------------------------------------------------ |
| `/new-deck`            | Scaffold a new presentation directory                        |
| `/apply-visuals`       | Pass 2: add photos, diagrams, and icons per `VISUALS.md`     |
| `/design-review`       | Brand compliance review                                      |
| `/accessibility-check` | WCAG 2.1 AA validation                                       |
| `/extract-to-markdown` | Convert an existing HTML deck to a `SLIDES.md` outline       |

Run the skills from the repository root. They reference this directory by the
repo-relative path `.agents/uw-slides/`.

## Layout

```
.agents/uw-slides/
├── design-systems/
│   ├── ssec-brand/          # default — DESIGN.md (slide guide), colors_and_type.css, shared/header.html, source/
│   └── uw-brand/            # DESIGN.md, colors_and_type.css, fonts/, shared/header.html
├── templates/               # build.sh, build-visuals.sh, SLIDES.md, VISUALS.md, shared/, examples/
├── references/              # accessibility-requirements.md, markdown-schema.md
└── LICENSE                  # upstream MIT license
```

Read `design-systems/<brand>-brand/DESIGN.md` before generating any slide HTML.

## Brands

| Brand  | Flag          | What it is                                                                 |
| ------ | ------------- | -------------------------------------------------------------------------- |
| `ssec` | default       | The SSEC website design system, adapted for slides. See below.             |
| `uw`   | `--brand=uw`  | The plain University of Washington brand as shipped by the upstream plugin. |

The upstream plugin's CloudBank brand was replaced by SSEC and is intentionally
absent; do not re-add it on a re-sync.

`ssec-brand/` integrates `design-system/` from
[uw-ssec/uw-ssec.github.io](https://github.com/uw-ssec/uw-ssec.github.io)
(commit `d313f9e`, 2026-07-24):

- `source/` is that folder, verbatim: `DESIGN.md`, `00`–`07` topic files,
  `01-tokens.css`, `README.md`.
- `colors_and_type.css` carries the website's tier-1 and tier-2 tokens with the
  names unchanged, so slides and web pages share one vocabulary. The website's
  12–60px text scale is replaced by a `--slide-*` scale with a 24px floor.
- `shared/header.html` inlines the same tokens plus slide utilities (`.accent-bar-*`,
  `.angle-divider`, `.rain-texture`, `.eyebrow`, `.signature-rule`, `.code-block`,
  `.stat`, `.source`) and loads the four SSEC families from Google Fonts.
- `DESIGN.md` is the slide guide the skills read: colors with contrast ratios
  computed for the exact hex values, the slide type scale, the 15° motif, slide
  types, and three example fragments.

## Workflow

```bash
/new-deck my-talk                    # SSEC brand (default)
/new-deck my-talk --brand=uw         # plain UW brand

# Pass 1: plan in SLIDES.md, ask for slides, then build
cd my-talk && ./build.sh && open build/index.html

# Pass 2: describe visuals in VISUALS.md, then
/apply-visuals && ./build-visuals.sh
```

SSEC decks load Encode Sans, Encode Sans Compressed, Open Sans, and JetBrains
Mono from Google Fonts and copy nothing, matching the SSEC website. `new-deck`
copies the 45 Encode Sans fonts (about 9 MB) into a UW-brand deck's
`assets/fonts/` so that deck is self-contained. Deck `build/` output is
git-ignored by the repository root `.gitignore`.

A uw-slides deck is not Reveal.js and builds to `<deck>/build/index.html`, so
the repository's PDF and Zenodo workflow does not yet cover it. See
`AGENTS.md`.

## Re-syncing from upstream

1. Copy upstream `design-systems/`, `templates/`, and `references/` over the
   directories here, and each `skills/<name>/SKILL.md` over
   `.agents/skills/<name>/SKILL.md`.
2. Re-apply the path rewrites the vendored skills depend on:
   - `~/.claude/plugins/local/uw-slides/` becomes `.agents/uw-slides/`
   - `/uw-slides:<skill>` becomes `/<skill>`
   - bare `design-systems/...` and `references/...` links become
     `.agents/uw-slides/design-systems/...` and `.agents/uw-slides/references/...`
3. Keep the note in `new-deck/SKILL.md` that paths are relative to the
   repository root.
4. Update the upstream version noted at the top of this file.
5. Leave `design-systems/ssec-brand/` alone; it re-syncs from
   uw-ssec.github.io instead, per section 12 of its `DESIGN.md`.
