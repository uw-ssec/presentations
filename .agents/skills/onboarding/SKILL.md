---
name: onboarding
description:
  Use when a person says they are new to this repository or to the SSEC
  presentations project, has just joined the team, asks to be shown around or
  oriented, asks to be gotten up to speed, or asks how this project works and
  where to start.
---

# Onboarding

Walk one person through this repository, one phase at a time, so they finish
able to build a deck themselves.

**The tour reads and builds. It never changes the repository.** The only thing
it may create is `<deck-slug>/build/`, which is generated and gitignored.

## Read-only

Nothing tracked is edited, staged, committed, or pushed. No branch is created
or switched. No `fetch`, `pull`, `merge`, `rebase`, or `reset` — the state of
their checkout is theirs, and a newcomer cannot review a change they did not
watch you make.

When they ask for a fix along the way — a typo, a stale link, a broken
command — **name it, locate it, and leave it.** Write the file path and line
number into the orientation as their first real task. A repository they can
still `git status` and see clean is part of what you are teaching.

Never hunt for a defect they describe but you cannot find. Say you could not
find it, ask them to point at it, and carry on with the tour.

## Pacing

One phase per turn. Each phase ends with what you found, then one question,
then you stop and wait. Do not run two phases in a single turn, and do not
deliver the whole tour as one briefing — a newcomer who is lost in phase 1
only discovers it at the end.

Keep each phase to roughly a screen. Read live repository state and report
that; do not recite this file or the rules back at them.

## The four phases

| # | Phase | Do | Say |
| - | ----- | -- | --- |
| 1 | Setup | `git status --short`, `git rev-parse --abbrev-ref HEAD`, then `pixi install` | Which branch they are on, that work branches off `staging`, and that Docker is optional — only `harbor-oracle` needs it |
| 2 | See a deck | `ls */SLIDES.md` to find a real fragment deck, `cd` there, `./build.sh`, then open `build/index.html` | With it on screen: `SLIDES.md` sets order, one `content/*.html` fragment per slide, `build/` is generated. `security-in-age-of-ai` is the one legacy Reveal.js deck |
| 3 | Map | `pixi run okf search "deck format" --limit 3` | `AGENTS.md` is the entry point and `.agents/rules/` holds the detail; skills in `.agents/skills/`; project memory is the bundle you just searched. Point at `repository-map.md` for the file tree instead of reading it aloud |
| 4 | What bites | Nothing to run | `staging` publishes to the Zenodo sandbox, `main` mints permanent DOIs, so never push to `main` and always PR to `staging`; no AI attribution trailers in commits; pixi is the only installer; `knowledge/` is public, so no PII |

Close by pointing them at `/new-deck` as their first real task.

## Rationalizations

| Excuse | Reality |
| ------ | ------- |
| "A fast-forward isn't a content edit" | It changes their checkout. Read-only includes git state. |
| "Their branch is behind, I'll just sync it" | Tell them it is behind. Updating it is their call, not yours. |
| "One turn is more efficient than four" | Efficiency is not the goal; their questions are. Stop after each phase. |
| "I can describe the deck format instead of building one" | The render is the lesson. Build it and put it on their screen. |
| "The fix is one line, it'd be rude not to" | An unreviewed commit in someone's first session is worse than a typo. |
| "I'll find that typo they mentioned if I grep harder" | Twenty greps is the tour they did not get. Ask them to point at it. |

## Red flags

- About to run `git` with anything but `status`, `log`, `diff`, `show`, `branch`, or `rev-parse`
- Writing the orientation before having built a deck
- Two phases in one message
- Reciting `repository-map.md` instead of showing live state

## Done

- `pixi install` ran and a real deck was built and opened
- Project memory was searched through `pixi run okf`, not described
- Each phase ended in a question and a stop
- `git status --short` is exactly as clean as it was when you started
