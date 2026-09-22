---
type: Process
title: "Verifying a slide change visually: nothing outside the 1280x720 boundary"
description: "How to actually check that a slide change renders correctly - constrain the slide box to 1280x720 in CSS rather than resizing the window, scan every slide including the hidden ones, and validate the scan with a deliberate positive control before trusting a clean result, because slides are viewport-sized and overflow silently with no scrollbar."
tags: [slides, verification, rendering, overflow, layout, browser]
generated: { by: "claude-code:claude-opus-5", at: "2026-09-22T04:46:31Z" }
status: stable
governance: constraint
code_refs: ["*/content/**", "*/shared/**", security-in-age-of-ai/index.html, ".agents/uw-slides/design-systems/**", .agents/rules/deck-conventions.md]
---

# Verifying a slide change visually

`deck-conventions.md` already requires it: "Verify by rendering. After a layout
change, serve the repo and render the deck locally; check the affected slides
fit." This concept is the **method** - how an agent actually performs that
check, and the traps that make a careless check worthless.

## The invariant

At the deck's target size, **nothing crosses the slide boundary**. No text,
image, card, table, or accent element extends past the edge, and nothing is
clipped or overlapping. The target is `1280x720` - the aspect fixed by
deck-conventions and by the workflow's `decktape --size 1280x720`.

## Why "it looked fine" is not evidence

A uw-slides fragment deck sizes each `section.slide` to the **viewport**, not
to a fixed 1280x720 box. Overflow is therefore a function of window size.
Measured 2026-09-22: the same deck reported a slide box of `1920x958` in a
maximized window and `1280x720` when constrained. Content that fits the first
can spill out of the second.

So a screenshot taken in whatever window happened to be open proves nothing.
Worse, `section.slide` computes `overflow: visible`, so a child that spills
produces **no scrollbar and no visual cue** on the slide itself - it just
quietly hangs outside the frame.

Two further traps:

- **Inactive slides measure as zero.** Only the active slide is `display:flex`;
  the rest are `display:none` and every rect on them is 0x0. A scan that does
  not temporarily display each slide silently passes all of them.
- **Window resizing may not work.** `resize_window` reported success against a
  fullscreen window while the viewport stayed at 1920 and `outerWidth` read
  `0`. Do not trust the window; constrain the slide box in CSS instead.

## The method (verified 2026-09-22 on a 31-slide deck)

1. Build the deck, then serve the repo: `python3 -m http.server 8000`. Open
   `<deck-slug>/build/index.html`.
2. **Use `http://127.0.0.1:8000`, not `localhost`.** See the note below.
3. Force the real target size rather than resizing the window - inject
   `section.slide { width:1280px!important; height:720px!important; }` so
   content reflows at 1280x720.
4. Walk **every** slide, not just the active one: temporarily give each slide
   `display:flex`, measure, then restore.
5. For each slide, compare every descendant's `getBoundingClientRect()` against
   the slide's own rect, with about 1px tolerance for rounding. Report any
   element exceeding it on any side, plus any slide whose `scrollWidth` or
   `scrollHeight` exceeds the target.
6. **Run a positive control before trusting a clean result.** Inject an element
   positioned deliberately outside the frame, confirm the scan flags it, then
   remove it and confirm the scan returns clean. A zero from an unvalidated
   detector is indistinguishable from a broken detector. This was done: a
   deliberately misplaced element was caught at 320px over, and the scan went
   back to clean on removal.
7. Reload the page to discard every injection before finishing.
8. **Also look at it.** Geometry catches what the eye misses at the wrong
   aspect; the eye catches what geometry cannot score - overlap, awkward
   wrapping, an image crop that ruins the point, a contrast problem. Neither
   check substitutes for the other.

Baseline from that run: 31 of 31 slides clean at 1280x720.

## Scope the check to the blast radius

"Check the affected slides" is right only for a change confined to one
fragment. A change to a deck's `shared/` header, or to a brand stylesheet
under `.agents/uw-slides/design-systems/`, affects **every** slide in every
deck that uses it. Scan the whole deck after any change to shared or global
styling, not the one slide that prompted the edit.

## Check the export too, not only the browser

Fitting in the browser does not guarantee fitting in the deposited artifact.
Render the PDF locally and page through it. This matters most for slides built
on rich elements, which do not survive the export at all - see
[[project/slide-content-hierarchy]] and
[[pipeline/fragment-decks-outside-pdf-workflow]].

## Trap: localhost resolves to IPv6 first

Chrome resolved `localhost` to `::1` while `curl` resolved it to `127.0.0.1`.
With a different service listening on IPv6 port 8000, `curl` returned the deck
with HTTP 200 while the browser showed that other service's JSON 404 - the
same URL, two different servers, and a confusing "the page is empty" symptom
in which a scan finds zero slides and reports no overflow.

Check for a real slide count before trusting any scan: if the page reports 0
slides, the finding is "wrong page", not "no overflow". Address the local
server as `127.0.0.1` explicitly, and check what already holds the port with
`lsof -nP -iTCP:8000 -sTCP:LISTEN` before assuming a new server bound.

# Related Concepts
- [How an agent builds a slide: audience, narrative, then the sourcing cascade](slide-content-hierarchy.md): The content hierarchy decides what goes on a slide; this check confirms what landed there actually fits inside it.
- [Fragment-based uw-slides decks are not covered by the PDF and Zenodo workflow](../pipeline/fragment-decks-outside-pdf-workflow.md): Fitting in the browser does not guarantee fitting in the deposited PDF, so the export needs its own pass.
