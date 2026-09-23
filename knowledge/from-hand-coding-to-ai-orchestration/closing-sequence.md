---
type: Decision
title: "Closing sequence: Monday ladder, orchestra metaphor, shared-source callback, plain thank-you"
description: "The deck ends with the adoption ladder, an orchestra slide mapping repo parts to sheet music (worded as repeatable, not deterministic), the callback to the shared-source diagram with an empty Your repo hub, and a plain thank-you slide; the backup horror-stories slide was removed and filling the hub with the six parts was rejected as a repeat of the ladder."
tags: [uw-slides, narrative, closing, orchestra]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-23T02:44:11Z" }
status: stable
governance: constraint
code_refs:
  - "from-hand-coding-to-ai-orchestration/content/29-start-monday.html"
  - "from-hand-coding-to-ai-orchestration/content/29b-same-sheet-music.html"
  - "from-hand-coding-to-ai-orchestration/content/30-thank-you.html"
  - "from-hand-coding-to-ai-orchestration/content/31-questions.html"

---

## Final order

1. `29-start-monday`: the six-rung adoption ladder. The only place the six framework parts are listed as steps.
2. `29b-same-sheet-music`: the orchestra metaphor. Score = `AGENTS.md` and `rules/`; pencil marks from rehearsal = `knowledge/`; parts practiced until routine = `skills/`; tuning before the concert = `evals/`; same instruments in tune = `pixi.toml`. Closing line: nobody plays from memory, same score and same margin notes, so the orchestration is **repeatable**.
3. `30-thank-you`: the callback to the shared-source diagram from slide 6, hub left as an empty "Your repo", with the three project links.
4. `31-questions`: plain "Thank you" and "Questions?" with the same links.

## Rejected alternatives (all tried in one session, 2026-09-22)

- **Filling the "Your repo" hub with the six parts** to separate it from slide 6. Rejected: it duplicated the ladder on the previous slide, and adjacency made the repeat worse than the one it fixed.
- **Cutting the callback slide** for a shorter ending. Reverted: the callback closes the argument opened on slide 6 and the plan values it.
- **"Deterministic" in the orchestra line.** The owner chose "repeatable" because agents are never strictly deterministic and the word invites pushback.
- **Backup horror-stories Mentimeter slide** at the very end. Removed; nothing referenced it.

## Invariants

The six parts appear as a list exactly once in the closing run (the ladder). A closing slide that repeats them is a regression. Links stay on the last slide.

## Related Concepts

- [How an agent builds a slide: audience, narrative, then the sourcing cascade](../project/slide-content-hierarchy.md): The closing slides follow the sourcing cascade: ladder and orchestra mapping are tier 2 structures, the thank-you is deliberately tier 4 text.
