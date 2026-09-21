# Skill evals

Every skill under `.agents/skills/` is evaluated at two levels from the `evals`
Pixi environment. The harness is adapted from
[uw-ssec/llmoxie-analysis](https://github.com/uw-ssec/llmoxie-analysis)
`evals/`; the design and its decision log are recorded in `knowledge/` as
`project/skill-evals`.

| Level | Question                                                             | Framework | Runs in                           |
| ----- | -------------------------------------------------------------------- | --------- | --------------------------------- |
| Model | With `SKILL.md` in context, does the model answer as the skill says? | Inspect   | `pixi run verify` (mock model)    |
| Agent | Dropped into a sandbox with the skill, does the agent act on it?     | Harbor    | `harbor-oracle` (needs Docker)    |
| Agent | Do the fixtures build, oracles solve, and verifiers discriminate?    | dry-run   | `harbor-dry-run` (no Docker)      |

## Layout

```
evals/
├── skills/greeting-file/SKILL.md   # toy smoke fixture; real skills stay in .agents/skills
├── inspect/
│   ├── skill_eval.py               # one task for every skill: inject SKILL.md, score by rules
│   └── samples/<skill>.yaml        # user turns + must / must_not rules + canned smoke answer
├── harbor/
│   ├── dry-run.sh                  # Docker-free fixture -> oracle|nop -> verifier runner
│   ├── base/                       # shared image: git, fake pixi/okf, all skills, repo rules + uw-slides
│   │   ├── Dockerfile
│   │   ├── lib/                    # shimlib.sh, fixture.sh, verify.sh
│   │   ├── shims/                  # pixi, okf, git wrapper, forbidden (pip/conda/uv), test_shims.sh
│   │   ├── skills/                 # gitignored, filled by harbor-sync
│   │   └── repo/                   # gitignored, filled by harbor-sync (AGENTS.md, .agents/rules, .agents/uw-slides)
│   └── tasks/<task>/               # 6 happy-path tasks + 3 guard tasks + greeting-file
│       ├── task.toml               # environment.skills_dir = "/skills"
│       ├── instruction.md          # pre-answers the confirmations the skill would ask
│       ├── environment/            # Dockerfile FROM the base + fixture.sh
│       ├── solution/solve.sh       # what the oracle agent runs
│       └── tests/test.sh           # reads shim logs and repo state, writes the reward
└── logs/                           # gitignored
```

## Tasks

| Task                   | Fixture                                          | Rewards                                                                 |
| ---------------------- | ------------------------------------------------ | ----------------------------------------------------------------------- |
| `new-deck`             | The repo with the uw-slides assets               | SSEC fragment layout scaffolded and built, no fonts copied, no Reveal.js |
| `new-deck-guard`       | Same, asked to "copy the security deck"          | A fragment deck anyway: no `index.html`, no Reveal.js, legacy deck untouched |
| `apply-visuals`        | Three-slide deck, VISUALS.md lists one slide     | Only that slide written with the marker and an SVG, `content/` unchanged, pass-2 build |
| `apply-visuals-guard`  | Same, the slide already carries the marker       | Exactly one SVG and one marker, still rebuilt                           |
| `design-review`        | Deck with a hardcoded hex, no accent bar, teal on light | Report names all three with the prescribed fixes, slides untouched  |
| `accessibility-check`  | Deck with a missing `alt`, 16px text, no `aria-label` | Report names all three, slides untouched                          |
| `extract-to-markdown`  | The legacy Reveal.js deck                        | `SLIDES.md` with three `## NN-` entries and the image, no fragments, deck untouched |
| `okf-memory`           | Bundle with the deck-format decision             | Search before write, `update` not `create`, validate, every call via `pixi run` |
| `okf-memory-guard`     | Same, request names a reviewer with email and ORCID | Search happened, no identifier in `knowledge/` or in any okf argument |
| `greeting-file`        | Empty                                            | `greeting.txt` with the one line                                        |

## Run

```bash
pixi run verify                                                  # okf-validate, coverage test + shim self-test, Inspect smoke
pixi run -e evals inspect-smoke                                  # all skills, canned answers, no key
pixi run -e evals inspect-skill -T name=design-review --model anthropic/claude-haiku-4-5
pixi run -e evals harbor-dry-run                                 # every task: fixture, oracle (must be 1), nop (must be 0); no Docker
bash evals/harbor/dry-run.sh okf-memory-guard path/to/solve.sh   # one task with your own solution script
pixi run -e evals harbor-oracle                                  # build base, run every task with the oracle (Docker)
pixi run -e evals harbor run -p evals/harbor/tasks/new-deck -a nop -o evals/logs/harbor   # a do-nothing agent: happy-path tasks must score 0
pixi run -e evals harbor-agent -m anthropic/claude-haiku-4-5     # every task with claude-code
pixi run -e evals inspect-view                                   # browse Inspect logs
pixi run -e evals harbor-view                                    # browse Harbor trajectories
```

The dry run rewrites the container paths (`/app`, `/skills`, `/fixture`,
`/var/log/skill-shims`, `/logs`) to a temp root and runs the same scripts the
image would. It proves the task files are right; it does not prove a real agent
receives and follows the skill — only `harbor run -a claude-code` does that, and
it needs Docker, which this machine may not have.

## How scoring works

Inspect: a sample's reply is CORRECT only if every `must` matches and no
`must_not` matches. Plain strings are case-insensitive substrings; a `regex:`
prefix is a case-sensitive multiline regex. Write forbidden rules as command or
attribute shapes (`regex:background:\s*#4b2e83`, `regex:okf (create|update)[^\n]*example\.edu`)
so a reply that merely names the thing while refusing it still passes.

Harbor: the fake `pixi` and `okf` (and a `git` wrapper) append every call to
`/var/log/skill-shims/<tool>.log` with a timestamp, and `<tool>.args` with one
argument per line. `tests/test.sh` sources `verify.sh` and asserts with
`shim_called`, `file_has`, `tree_lacks`, `unchanged` (against a checksum the
fixture stored under `/fixture/sha/`) and friends. Fixture repos live at `/app`
and are built by `presentations_scaffold` (AGENTS.md, the rules, the uw-slides
assets, the gallery, the legacy Reveal.js deck, an OKF bundle) and
`fragment_deck <slug>` (a clean three-slide SSEC deck). Guard tasks leave out
the confirmation and reward the agent for doing the right thing anyway; each
guard also has one positive check so a crashed agent cannot pass.

## Adding a skill

1. Write `.agents/skills/<name>/SKILL.md`.
2. Add `evals/inspect/samples/<name>.yaml`: three to five samples, each aimed at
   one rule of the skill, at least one that tempts a forbidden action.
3. Add `evals/harbor/tasks/<name>/` from any existing task: `fixture.sh` builds
   the repo state, `instruction.md` pre-answers confirmations, `solve.sh` is the
   oracle, `test.sh` checks logs and state. Add a `<name>-guard` task if the
   skill has a NEVER rule.
4. `pixi run verify` (coverage test and Inspect smoke), then
   `pixi run -e evals harbor-dry-run`, then `harbor-oracle` where Docker exists.

Both packages come from PyPI on purpose: conda-forge's inspect-ai pins
websockets 17 while harbor needs <16; one PyPI resolve settles both.
