# Deck Conventions

**Load when:** creating, editing, restructuring, or reviewing any slide deck or
the gallery page.

## The default: uw-slides fragment decks

**Every new deck is a uw-slides fragment deck.** Scaffold it with `/new-deck`
(default brand `ssec`; `--brand=uw` for a plain UW deck), plan it in
`SLIDES.md`, write one `<section>` fragment per slide under `content/`, and
build with `./build.sh` into `<deck-slug>/build/index.html`. Do not start a new
deck from Reveal.js, and do not copy `security-in-age-of-ai/index.html` as a
template. Decision recorded as `project/deck-format-default` in `knowledge/`.

- Read `.agents/uw-slides/design-systems/<brand>-brand/DESIGN.md` before
  writing any fragment.
- Every fragment follows the pattern in the `/new-deck` skill: a `<section
  data-slide="NN-name" aria-label="…" class="slide">` with styles scoped by
  attribute selector. No global CSS edits for one slide.
- Reorder slides by editing `SLIDES.md`, not by renaming files.
- Review with `/design-review` (brand) and `/accessibility-check` (WCAG 2.1
  AA) before calling a deck done.
- `build/` is gitignored. Commit the fragments, `SLIDES.md`, `VISUALS.md`, and
  `shared/`; never the build output.
- **Publishing gap:** the PDF and Zenodo workflow renders only Reveal.js decks
  today (`knowledge/`: `pipeline/fragment-decks-outside-pdf-workflow`). A
  fragment deck is presented from `build/index.html` locally until the
  workflow gains a fragment build and render step. Ask before adding one.

## Legacy: the Reveal.js deck

`security-in-age-of-ai` is the only Reveal.js deck and stays that way. These
rules apply to it, and to no new deck:

- **Aspect is `1280×720`.** Match the workflow's `--size`. Never change one
  without the other.
- **Preserve slide `id` attributes** when restructuring — they are deep links
  and appear in published PDFs and DOIs.
- **Footnote citations stay.** Every slide ending in a `.footnote` block keeps
  it. Trim wording, don't drop sources.
- **Fix overflow inline**, on the offending element (`font-size`,
  `line-height`, shorter wording). Don't edit global CSS for one slide's
  problem.
- **Reuse the existing classes** — `card`, `card-red`, `card-blue`,
  `card-green`, `check-item`, `footnote`, and friends. Never invent a new class
  to do what one of these already does.
- **Inline `style="…"` is the house style.** Keep it.
- **Verify by rendering.** After a layout change, serve the repo and render the
  deck locally (commands in [pixi-and-tools.md](pixi-and-tools.md)); check the
  affected slides fit.

**Slide hardening — fix overflow on the offending element, not global CSS:**

```html
<!-- ❌ -->
<style>.content pre { font-size: 10pt; }</style>

<!-- ✅ -->
<pre style="… font-size: 10pt; line-height: 1.3; …">…</pre>
```

## The vendored plugin

The [uw-slide-deck-plugin](https://github.com/aaarendt/uw-slide-deck-plugin)
that produces fragment decks is vendored into this repo instead of installed
from a marketplace:

- Skills live at `.agents/skills/<name>/SKILL.md`; `.claude/skills` is a
  symlink to that directory. Invoke them by name (`/new-deck`,
  `/apply-visuals`, `/design-review`, `/accessibility-check`,
  `/extract-to-markdown`). Never open a `SKILL.md` with the Read tool.
- Brand design systems, scaffolding templates, fonts, and reference docs live at
  `.agents/uw-slides/`. Skills reference them by repo-relative path, so run
  them from the repository root.
- Upstream edits go to the plugin repo first; re-sync by copying its
  `skills/`, `design-systems/`, `templates/`, and `references/` over the
  vendored copies and re-applying the path rewrites noted in
  `.agents/uw-slides/README.md`.

## Adding a new deck

1. Run `/new-deck <deck-slug>` from the repository root. Choose the slug
   carefully — it becomes the Zenodo keyword `uw-ssec-deck:<slug>` that ties
   every future version to the same DOI history.
2. Plan in `SLIDES.md`, write the fragments, build, and rehearse from
   `build/index.html`. Run `/design-review` and `/accessibility-check`.
3. Add a gallery card to the root `index.html`.
4. Add `<deck-slug>/zenodo.json` with `slug`, `community: "uw-ssec"`,
   `title`, `upload_type: "presentation"`, `description` (HTML ok),
   `creators` with ORCIDs, `keywords`, `license`, and `pdf`.
5. Publishing needs the workflow to build and render fragment decks, which it
   does not do yet. Ask the user how they want to handle it; do not extend
   `.github/workflows/build-pdf.yml` or `.readthedocs.yaml` unasked. When the
   workflow does cover the deck, add `<deck-slug>/**` to both path filters.
6. Open a PR to `staging`. If the deck publishes, verify the sandbox record;
   then the user opens `staging` → `main`.
