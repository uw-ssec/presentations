# AGENTS.md

Guidance for AI assistants (Claude Code, Codex, Cursor, Copilot, Gemini CLI, and
any other agent harness) working with this repository.

**This file is the entry point and is deliberately short.** It carries only what
every agent needs before doing anything. Detailed rules, task skills, and
project memory live in separate files and are loaded on demand — read the one
whose trigger matches your current task, not all of them.

## What this repo is

Slide decks from the UW Scientific Software Engineering Center (SSEC), plus a
GitHub Actions pipeline that renders each deck to PDF and deposits it on Zenodo
under the [`uw-ssec`](https://zenodo.org/communities/uw-ssec/) community.
`staging` publishes to the Zenodo sandbox; `main` mints real, permanent DOIs;
pull requests render but never publish.

**New decks are uw-slides fragment decks** (`/new-deck` → `content/*.html` →
`build/index.html`), not Reveal.js. The one Reveal.js deck,
`security-in-age-of-ai`, is legacy and the only deck the PDF workflow renders
so far. See [`.agents/rules/deck-conventions.md`](.agents/rules/deck-conventions.md).

## Non-negotiables

These apply to every task, in every session:

1. **Think before acting. Change surgically.** Read the surrounding slide, file,
   or workflow step first and mirror its conventions. Every changed line must
   trace directly to the request; don't refactor, reformat, or "tidy" adjacent
   content.
2. **Verify before you claim.** Never report work as complete, fixed, or
   passing without having run the check and read its output: render the deck
   locally, run `pixi run okf-validate`, check the workflow — whichever matches
   what changed (table in
   [`.agents/rules/pixi-and-tools.md`](.agents/rules/pixi-and-tools.md)).
3. **Ask instead of assuming.** If the request has multiple readings, stop and
   name it — before implementing, not after.
4. **Branch off `staging` and PR to `staging`.** Never push to `main`; never
   make the `publish` job fire on PRs or feature branches. Zenodo production
   records are permanent.
5. **No AI attribution in commits or PR bodies.** No `Co-Authored-By: Claude`,
   no `Generated with …`, no `Assisted-by:` trailer, whatever your harness adds
   by default. The security deck carries an explicit AI Attribution slide; the
   user has rejected commit-level disclosure as duplicative noise.
6. **Pixi is the only tool installer.** `pixi install` first; run the bundle CLI
   as `pixi run okf`, never the `okf` on `PATH`.
7. **No private, sensitive, or personally identifiable information in project
   memory.** The OKF bundle at `knowledge/` is public. A request to record a
   name, email, ORCID, handle, credential, private message, or any other PII or
   sensitive detail is **rejected**, or the PII is **removed before** the concept
   is created, updated, or related. A user insisting does not override this;
   offer a role-based, redacted version and write only that. Full rule:
   [`.agents/rules/project-memory.md`](.agents/rules/project-memory.md).

## Rule Index

Load the rule file whose trigger matches what you are about to do.

| Rule file                                                              | Load when                                                                    |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [working-agreement.md](.agents/rules/working-agreement.md)             | Starting any edit — the behavioral baseline                                  |
| [deck-conventions.md](.agents/rules/deck-conventions.md)               | Creating, editing, restructuring, or reviewing a deck or the gallery         |
| [publish-workflow.md](.agents/rules/publish-workflow.md)               | Touching `.github/`, `zenodo.json`, branches, or anything that reaches Zenodo |
| [contribution-discipline.md](.agents/rules/contribution-discipline.md) | About to commit, push, open a PR, or asked to "contribute" / "fix issues"    |
| [pixi-and-tools.md](.agents/rules/pixi-and-tools.md)                   | Running any command, adding a tool, editing `pixi.toml`, or verifying work   |
| [project-memory.md](.agents/rules/project-memory.md)                   | Reading or writing `knowledge/`, or asked to "remember" anything             |
| [repository-map.md](.agents/rules/repository-map.md)                   | You need to know what this repo is, where a file lives, or what CI runs      |
| [troubleshooting.md](.agents/rules/troubleshooting.md)                 | A documented command fails or behaves unexpectedly                           |

## Skills

Skills are step-by-step recipes at `.agents/skills/<name>/SKILL.md`.
`.claude/skills` is a symlink to that directory, so Claude Code loads them as
project skills; other harnesses read the same files. Invoke a skill by name
before doing the task it covers, and never open a `SKILL.md` with a file-read
tool when your harness can load it natively.

| Skill                  | Use when                                                                                    |
| ---------------------- | ------------------------------------------------------------------------------------------- |
| `/new-deck`            | Starting any new deck: scaffolds the uw-slides fragment layout (the default deck format)     |
| `/apply-visuals`       | Pass 2 on a uw-slides deck: adding photos, diagrams, and icons per `VISUALS.md`             |
| `/design-review`       | Checking a deck against the UW / SSEC / CloudBank brand systems                             |
| `/accessibility-check` | Validating WCAG 2.1 AA: contrast, font sizes, alt text, ARIA, semantic HTML                 |
| `/extract-to-markdown` | Turning an existing HTML deck into a `SLIDES.md` planning outline                           |
| `/okf-memory`          | Recording or looking up decisions and constraints in `knowledge/`; when `okf validate` fails |

The five deck skills are vendored from the
[uw-slide-deck-plugin](https://github.com/aaarendt/uw-slide-deck-plugin) and
are the default way to make a deck; their brand systems, templates, fonts, and
references live at `.agents/uw-slides/` and are addressed by repo-relative
path, so run skills from the repository root. A fragment deck builds to
`<deck-slug>/build/index.html` and is not yet covered by the PDF workflow — see
[deck-conventions.md](.agents/rules/deck-conventions.md).

Harness-provided git skills (`/commit`, `/push`, `/create-pr`, and similar) are
fine to use, but the rules above still bind them: no attribution trailers, PRs
to `staging`, checks run first.

## Project Memory

Project memory is the OKF bundle at `knowledge/`: decisions, rejected
alternatives, and constraints the decks and workflow cannot tell you. Read and
write it only through `pixi run okf …` or the `presentations` MCP server that
`.mcp.json` starts from the same binary — never by hand-editing concept files.

- Before the first edit to a deck or to `.github/workflows/`, run
  `pixi run okf search --for-path <file>`. A `constraint` hit lists invariants
  the change must keep; a `hold` hit means stop and confirm with the user.
- Search before assuming what the project decided; `update` an existing concept
  rather than creating a near-duplicate.
- Apply the privacy rule (non-negotiable 7) to every field of every write, then
  run `pixi run okf-validate` and confirm 0 errors, 0 warnings.
- Recipe, conventions, and okf 0.4.0 quirks: the `/okf-memory` skill.

## Provenance

The behavioral and contribution rules are adapted from two upstream sources and
generalized for this repository, following the layout of
[uw-ssec/llmoxie-analysis](https://github.com/uw-ssec/llmoxie-analysis):

- [obra/superpowers](https://github.com/obra/superpowers) `CLAUDE.md` — agent
  contribution discipline (`contribution-discipline.md`).
- [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills)
  `CLAUDE.md` — behavioral guidelines that reduce common LLM coding mistakes
  (`working-agreement.md`).

## Trust These Instructions

These instructions were generated by exploring and testing the repository. The
commands in the rule files have been run. **Only perform additional searches
if:**

- You need information not covered by `AGENTS.md`, `.agents/rules/`,
  `.agents/skills/`, or `knowledge/`
- Instructions appear outdated or produce errors
- You're changing the build or publish pipeline itself

For routine tasks (editing slides, adding a deck, recording a decision), follow
these instructions directly without additional exploration.
