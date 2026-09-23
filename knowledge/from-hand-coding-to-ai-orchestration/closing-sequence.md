---
type: Decision
title: "Closing sequence: Monday ladder, orchestra metaphor, shared-source callback, thank-you with partner logos"
description: "The deck ends with the adoption ladder, an orchestra slide mapping repo parts to sheet music (worded as repeatable, not deterministic), the callback to the shared-source diagram with an empty Your repo hub, and a thank-you slide with a looping uwssec.org partner logo video; the backup horror-stories slide was removed and filling the hub with the six parts was rejected as a repeat of the ladder."
tags: [uw-slides, narrative, closing, orchestra]
generated: { by: "claude-code:claude-opus-5-5", at: "2026-09-23T16:29:49Z" }
status: stable
governance: constraint
code_refs: [from-hand-coding-to-ai-orchestration/content/29-start-monday.html, from-hand-coding-to-ai-orchestration/content/29b-same-sheet-music.html, from-hand-coding-to-ai-orchestration/content/30-thank-you.html, from-hand-coding-to-ai-orchestration/content/31-questions.html, from-hand-coding-to-ai-orchestration/assets/video/uwssec-partners.webm]
---

## Final order

1. `29-start-monday`: the six-rung adoption ladder. The only place the six framework parts are listed as steps.
2. `29b-same-sheet-music`: the orchestra metaphor. Score = `AGENTS.md` and `rules/`; pencil marks from rehearsal = `knowledge/`; parts practiced until routine = `skills/`; tuning before the concert = `evals/`; same instruments in tune = `pixi.toml`. Closing line: nobody plays from memory, same score and same margin notes, so the orchestration is **repeatable**.
3. `30-thank-you`: the callback to the shared-source diagram from slide 6, hub left as an empty "Your repo", with the three project links.
4. `31-questions`: "Thank you" and "Questions?" with the same links, plus a looping video of the partner logo bar from uwssec.org. This slide is light, on `--color-gold-50`, so it matches the video's background.

## Partner logo video on the last slide (2026-09-23)

The owner wanted the second section of uwssec.org (the "An initiative of" logos and the "Collaborating with researchers at" logo slider) on the last slide without copying the site's code.

- **An iframe was rejected: it cannot work.** The site allows framing, but the section has no id or route. The hero is `100vh - 80px` under an 88px sticky header, so the section always starts 8px below the frame's viewport, whatever size the frame is. A cross-origin frame cannot be scrolled from outside, and Chrome ignores `#:~:text=` fragments in cross-origin iframes (tested, the frame stayed at scrollY 0).
- **What shipped:** `assets/video/uwssec-partners.webm` (VP8, 2560x488, one 48s cycle so the loop is seamless) and a poster frame, `uwssec-partners-poster.jpg`. They were made by pausing the site's `partner-scroll` animation in headless Chromium, stepping `currentTime` at 30 fps, and screenshotting the section each frame. Re-record when the site's partner list changes.
- **Seam mask:** the site's own edge-fade overlays are a few levels off gold-50 and show as faint vertical lines at about 12% and 88% of the width. The slide masks those strips to transparent. Raising the bitrate did not remove them.
- **Offline:** the video is a local asset, so the slide does not need a network connection.

## Rejected alternatives (all tried in one session, 2026-09-22)

- **Filling the "Your repo" hub with the six parts** to separate it from slide 6. Rejected: it duplicated the ladder on the previous slide, and adjacency made the repeat worse than the one it fixed.
- **Cutting the callback slide** for a shorter ending. Reverted: the callback closes the argument opened on slide 6 and the plan values it.
- **"Deterministic" in the orchestra line.** The owner chose "repeatable" because agents are never strictly deterministic and the word invites pushback.
- **Backup horror-stories Mentimeter slide** at the very end. Removed; nothing referenced it.

## Invariants

The six parts appear as a list exactly once in the closing run (the ladder). A closing slide that repeats them is a regression. Links stay on the last slide.

## Related Concepts

- [How an agent builds a slide: audience, narrative, then the sourcing cascade](../project/slide-content-hierarchy.md): The closing slides follow the sourcing cascade: ladder and orchestra mapping are tier 2 structures, the thank-you is deliberately tier 4 text.
