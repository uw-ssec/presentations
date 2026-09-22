# From Hand Coding to AI Orchestration

CrossVISS 2026 session by Don Setiawan and Cordero Core (UW SSEC): how the
Harness Augmentation Framework makes a research repository a place where
humans and coding agents both start on day one.

SSEC-branded, fragment-based HTML deck built with the vendored uw-slides
skills. Not Reveal.js.

## Build and present

```bash
./build.sh              # content/*.html -> build/index.html
open build/index.html   # arrow keys, space, or click to advance
```

In the deck:

- The bottom-left badge shows who is speaking (teal Don, gold Cordero).
- The timer next to it starts when you leave slide 1. `t` pauses and resumes,
  `r` resets. It turns gold at 50 minutes and pink at 60.
- `#N` in the URL jumps to slide N.

## Files

- `SLIDES.md`: the plan, one `## slide-id` heading per slide, in order.
  Reorder slides here and rebuild.
- `content/`: one `<section>` fragment per slide, scoped styles inline.
- `shared/slide-base.css`: the SSEC design tokens, base styles, slide
  system, and utilities. `shared/header.html` links it, and so does every
  fragment, so a file in `content/` opened on its own is styled. Edit the
  CSS here, not in the header. `shared/footer.html`: navigation plus this
  deck's presenter badge and timer.
- `assets/images/`: illustrations generated with Codex, plus the Mentimeter QR
  crop. `assets/`: the framework graphic, the agent board, the pyOpenSci
  lifecycle, the Mentimeter screenshots, and the planning notes.
- `VISUALS.md`: pass-two visual additions spec (not used yet).
- `build/`: generated output, git-ignored.

## Live parts

Slides marked Mentimeter are cue slides; the poll runs in Mentimeter. The
prompts to type into the agent are printed verbatim on the slides. The demo
runs in a Codespace on the demo fork of llmoxie-analysis with Sonnet 5.

## Publishing

The repository's PDF and Zenodo workflow renders Reveal.js decks only, so this
deck is presented from `build/index.html` locally until the workflow gains a
fragment build step. `zenodo.json` is in place for when it does.
