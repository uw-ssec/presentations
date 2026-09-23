---
type: Decision
title: Insert slides with suffixed names and keep order in SLIDES.md; displayed numbers drift from file numbers
description: "New slides added between existing ones are named with a letter suffix on the preceding number (08b, 29b) instead of renumbering later files, because SLIDES.md owns the order and renaming churns every file; displayed slide numbers therefore no longer match file prefixes, and the README slide count is maintained by hand."
tags: [uw-slides, slides, ordering, naming, build]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-23T02:44:11Z" }
status: stable
governance: constraint
code_refs:
  - "from-hand-coding-to-ai-orchestration/SLIDES.md"
  - "from-hand-coding-to-ai-orchestration/README.md"
  - "from-hand-coding-to-ai-orchestration/content/**"

---

## Decision

When a slide is inserted between two numbered fragments, name it after the preceding slide with a letter suffix (`08b-llmoxie-platform.html`, `29b-same-sheet-music.html`) and add its `## <name>` heading to `SLIDES.md` at the right position. Do not renumber the fragments after it.

## Why

- Deck conventions say to reorder by editing `SLIDES.md`, not by renaming files, and `build.sh` reads the order from `SLIDES.md` (headings matching `^## [0-9]`; a suffix still matches).
- Renumbering 20+ fragments produces a diff that hides the real change and breaks the `data-slide` selectors inside each fragment's scoped CSS.

## Consequences to keep in mind

- The slide number shown in the deck (and in `#N` URLs) is the position in `SLIDES.md`, not the file prefix. After an insertion, "slide 28" in conversation may be the file `27-…`. Resolve requests by position in `SLIDES.md`, then map to the file.
- `README.md` states the slide count in prose ("Browser Print exports all N slides"); update it on every insertion or removal.
- `build.sh` reports one more than the real count because it counts every `## ` heading, including the "How to render this deck" section; the `<section` count in `build/index.html` is the truth.
- Removing a slide means deleting its heading (the build then skips the file), and normally the fragment and its `NOTES.md` entry too.

## Related Concepts

- [New Decks Default to uw-slides HTML, Not Reveal.js](../project/deck-format-default.md): Suffix naming only works because fragment decks take their order from SLIDES.md, which the default deck format establishes.
