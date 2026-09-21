# Working Agreement

**Load when:** starting any edit to a deck, the gallery, the publish workflow,
or the tooling. This is the behavioral baseline — how to think, how much to
change, and when to stop and ask.

Adapted from
[multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills)
`CLAUDE.md`.

**Tradeoff:** these guidelines bias toward caution over speed. For genuinely
trivial tasks, use judgment — but bias toward the guidelines when in doubt.

## 1. Think Before Editing

**Don't assume. Don't hide confusion. Surface tradeoffs.**

- Read the surrounding slide, file, or workflow step first. Mirror its
  conventions instead of inventing new ones.
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick one silently.
- If a simpler approach exists, say so. Push back when warranted.

## 2. Simplicity First

**Minimum change that solves the problem. Nothing speculative.**

- No slides, sections, CSS classes, or workflow steps beyond what was asked.
- No new abstractions for one-off content. Inline `style="…"` is the house
  style; keep it.
- Prefer the boring option. SHA-pinned actions, explicit permissions, and
  plain HTML are deliberate — the security deck argues for exactly these.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

- Don't "improve" adjacent slides, comments, or formatting.
- Don't reformat, rename, or "tidy" code you weren't asked to touch.
- Match existing style, even if you'd do it differently.
- If you notice an unrelated problem, mention it — don't fix it unasked.

The test: every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

- "Fix the overflow on slide 12" → render the deck locally and confirm the
  slide fits at 1280×720.
- "Add a deck" → the gallery card, `zenodo.json`, and workflow steps exist,
  and a PR render succeeds.
- "Record this decision" → `pixi run okf-validate` reports 0 errors, 0
  warnings.

For multi-step tasks, state a brief plan with a verification step per item.

## 5. Evidence Before Assertions

Never claim work is complete, fixed, or passing without having run the check
and read its output. "Should work" is not a result. When reporting:

- If a command failed, say so and include the relevant output.
- If a step was skipped, say which one and why.
- If something is done and verified, state it plainly without hedging.
- Don't re-read a file you just edited to "verify" the edit — the harness
  errors on a failed edit. Verify behavior (render, validate), not bytes.

The minimum checks for this repository are listed in
[pixi-and-tools.md](pixi-and-tools.md) under "Verification".

## 6. State What Changed and Why

End every task with a short, standalone summary: what changed, why, and what
was verified. Don't bury edits in long preambles.
