---
type: Decision
title: "Onboarding Is a Read-Only, Checkpointed Guided Tour"
description: "The /onboarding skill walks a newcomer through setup, a real deck build, the repository map and the publish safety rules in four checkpointed phases, and never edits, commits, or changes git state"
tags: [onboarding, skills, contributor-experience]
generated: { by: "claude-code:claude-opus-5", at: "2026-09-23T08:59:06Z" }
status: stable
governance: constraint
code_refs: [.agents/skills/onboarding/SKILL.md, .claude/skills/onboarding/SKILL.md, evals/inspect/samples/onboarding.yaml]
---

The `/onboarding` skill walks one person through the repository in four
checkpointed phases: verify setup with `pixi install`, build a real fragment
deck and open it, map the rules and project memory, then name the rules that
bite (staging vs main, no attribution trailers, pixi-only, no PII).

**Read-only is the invariant.** The tour edits nothing tracked, commits
nothing, and changes no git state — no `fetch`, `merge`, `pull`, or branch
switch. Only the gitignored `build/` output may appear. A newcomer cannot
review a change they did not watch being made, and a clean `git status` at the
end is part of what the tour teaches.

Why these choices, against the alternatives considered and rejected:

- A tour that ends at a first change, at an open PR, or that branches by role
  was rejected: a newcomer's first session producing a real commit is the
  failure mode worth designing against, and read-only gives the skill a
  testable NEVER rule.
- Self-orientation for an agent, and a two-track skill serving both an agent
  and a person, were rejected. `AGENTS.md` and `.agents/rules/` already orient
  agents; the gap was a sequenced walkthrough for a human.
- One-shot delivery and a skip-ahead escape were rejected in favour of strict
  one-phase-per-turn pacing, so someone lost in phase 1 surfaces it in phase 1.

Baseline evidence: an agent given the same onboarding request without the
skill delivered all four phases as a single briefing, never ran `pixi install`,
never built a deck, spent roughly twenty greps hunting a typo that did not
exist, and fast-forwarded the checkout with `git merge --ff-only` — arguing a
fast-forward "is not a content edit". The same scenario with the skill in
context stopped after phase 1, ran three read-only git commands, and left both
the typo and the stale branch to the person. The rationalization table in the
skill is written directly from those observed excuses.

## Related Concepts
- [Skill Evals with Inspect and Harbor](skill-evals.md): The onboarding skill ships the Inspect sample and Harbor happy-path and guard tasks this eval architecture requires of every skill
