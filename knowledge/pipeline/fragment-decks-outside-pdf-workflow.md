---
type: Requirement
title: Fragment-based uw-slides decks are not covered by the PDF and Zenodo workflow
description: "A uw-slides deck builds to <slug>/build/index.html, which is git-ignored and not Reveal.js, so the workflow that renders <slug>/index.html with decktape reveal needs a dedicated build and render step before such a deck can publish."
tags: [pipeline, uw-slides, decktape, zenodo, ci]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-21T21:58:23Z" }
status: draft
governance: constraint
code_refs: [.github/workflows/build-pdf.yml, .agents/uw-slides/templates/build.sh]
sources:
  - resource: AGENTS.md
  - resource: .agents/uw-slides/templates/build.sh
---

## Constraint

The render-and-publish workflow in `.github/workflows/build-pdf.yml` assumes each deck is a Reveal.js site at `<deck-slug>/index.html` and renders it with `decktape reveal`. A deck scaffolded by `/new-deck` is different in two ways:

1. Its presentation is assembled by `./build.sh` into `<deck-slug>/build/index.html`, and `build/` is ignored by the repository root `.gitignore`, so the rendered file is never in the checkout.
2. The assembled page is the plugin's own slide system (one `section.slide` shown at a time by inline JavaScript), not Reveal.js, so the `reveal` decktape plugin will not step through it.

## What wiring a fragment deck into CI needs

- A build step that runs the deck's `build.sh` on the runner before rendering.
- A decktape invocation that can drive the plugin's navigation (its `generic` plugin sends key presses; the footer handles arrow keys, space, Home, and End). This has not been tested in CI yet; treat it as inferred until a run confirms it.
- The path filter, `zenodo.json`, slug rules, and the staging-then-main promotion in `AGENTS.md` all still apply.

Do not change the workflow for this without the project owner's go-ahead; `AGENTS.md` lists workflow changes under "confirm before doing".

## Related Concepts

- [New Decks Default to uw-slides HTML, Not Reveal.js](../project/deck-format-default.md): The decision that makes fragment decks the default, which turns this gap from an edge case into the normal path.
