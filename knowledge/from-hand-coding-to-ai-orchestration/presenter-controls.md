---
type: Architecture
title: "Deck-level presenter controls live in shared/footer.html: walkthrough keys, progress bar, full-screen toggle"
description: "The footer owns the deck controls for this deck: one walkthrough controller per slide driven by both the buttons and the Up and Down arrows, a fixed progress bar that replaces the static teal accent bar on screen only, and a full-screen handler for any element marked data-fullscreen, of which the title slide's translucent icon is the only instance."
tags: [uw-slides, footer, keyboard, progress, fullscreen, print]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-23T02:44:11Z" }
status: stable
governance: constraint
code_refs:
  - "from-hand-coding-to-ai-orchestration/shared/footer.html"
  - "from-hand-coding-to-ai-orchestration/content/01-title.html"
  - "from-hand-coding-to-ai-orchestration/shared/print.css"

---

## Where things live

All deck-wide behaviour is in `shared/footer.html` (markup, styles, and script). Fragments only mark hooks: `[data-walkthrough]` with `[data-stage]` children plus `[data-next]` and `[data-overview]` buttons, and `[data-fullscreen]` for a full-screen toggle.

## Walkthroughs

Each `[data-walkthrough]` registers a controller (`forward`, `back`, `reset`) in a `Map` keyed by its `section`. The buttons and the keys call the same functions, so the two can never disagree. On the active slide, **Down** is the next step and wraps from the last step back to the overview (mirroring the button); **Up** goes back one step and returns to the overview from step 1; at the overview Up does nothing. On slides without a walkthrough both keys are ignored. Walkthrough state is not reset when leaving a slide (pre-existing behaviour, kept).

## Progress bar

A fixed `.deck-progress` (4px, top of the viewport, teal fill on a 25% teal track) is set to `(current+1)/total` on every slide change, including hash navigation. On screen the per-slide `.accent-bar-top` is hidden with an `@media screen` rule in the footer, not in `slide-base.css`, so the shared stylesheet is untouched and **print keeps the static accent bars** while the progress bar is hidden by `@media print`. The bar appears on every slide, including the title and dark closing slides that never carried the accent bar.

## Full screen

The footer binds a click on any `[data-fullscreen]` to toggle `document.documentElement.requestFullscreen()` and updates the button's `aria-label` and `title` on `fullscreenchange`. The only instance is the icon on `content/01-title.html`: absolutely positioned top right, 0.35 opacity at rest, 0.9 on hover or focus, marked `data-interactive` so `print.css` hides it and click-to-advance ignores it. Real full screen needs a user gesture, so it cannot be verified headlessly; only that the click does not throw.

## Verifying changes here

The footer is shared by every slide, so after editing it scan the whole deck, and test the key bindings with the iframe harness described in the slide-visual-verification concept.

## Related Concepts

- [Verifying a slide change visually: nothing outside the 1280x720 boundary](../project/slide-visual-verification.md): Footer changes affect every slide; verify with the whole-deck scan and the iframe key harness described there.
