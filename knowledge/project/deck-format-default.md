---
type: Decision
title: "New Decks Default to uw-slides HTML, Not Reveal.js"
description: "New presentations are uw-slides fragment decks scaffolded with /new-deck and built to build/index.html; Reveal.js is legacy, kept only for security-in-age-of-ai."
tags: [decision, decks, uw-slides, reveal-js, default]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-21T22:15:09Z" }
---

The first deck in this repository, `security-in-age-of-ai`, is a Reveal.js
presentation. On 2026-09-21 the project owner directed that going forward the
default for every new deck is the plain-HTML, fragment-based format produced by
the vendored uw-slides skills: scaffold with `/new-deck`, write one `<section>`
fragment per slide under `content/`, and concatenate with `build.sh` into
`<deck-slug>/build/index.html`. Reveal.js is not used for new decks.

## What this changes

- `/new-deck` (default brand `ssec`) is the starting point for a new deck.
  Do not copy `security-in-age-of-ai/index.html` as a template.
- Deck-level rules that are Reveal.js-specific (CDN load, `--size` matching
  the Reveal config, `decktape reveal`) apply only to the legacy deck.
- Brand, accessibility, and review pass through `/design-review` and
  `/accessibility-check` rather than hand-maintained CSS.

## Open constraint

The PDF and Zenodo workflow still renders only `<deck-slug>/index.html` with
`decktape reveal`; a fragment deck is not published until the workflow gains
its own build and render step, and the owner wants to be consulted before that
change. The details are in [[pipeline/fragment-decks-outside-pdf-workflow]].
Until then a new deck is built and presented locally only.

## Superseded

The earlier implicit default, that a new deck mirrors the Reveal.js structure
of the first one, is withdrawn. The reasoning for the switch was not stated
beyond the owner's direction; if a rationale is later given (for example the
fragment format being easier for agents to edit slide by slide), record it
here rather than in a new concept.

## Related Concepts

- [Fragment-based uw-slides decks are not covered by the PDF and Zenodo workflow](../pipeline/fragment-decks-outside-pdf-workflow.md): The workflow gap that keeps a default-format deck from publishing until CI gains a fragment build step.
- [The uw-slides plugin is vendored under .agents, not installed from a marketplace](uw-slides-plugin-vendored.md): The vendored skills and assets that produce the default deck format.
- [Skill Evals with Inspect and Harbor](skill-evals.md): The guard task that checks a new deck is a fragment deck even when asked to copy the Reveal.js one.
