---
name: okf-memory
description:
  Use when a decision, constraint, or non-obvious discovery from this session
  should outlive it, before changing a deck or the publish workflow in an area
  that may carry recorded constraints, when asked what the project decided
  about something, or when `okf validate` fails.
---

# OKF Memory

Project memory is the OKF v0.2 bundle at `knowledge/` in the repository root.
Read it and write it through the `okf` CLI, run as `pixi run okf` (the binary
from the pixi environment; there is no pixi task for the CLI itself), or through
the `presentations` MCP server that `.mcp.json` starts from the same binary. The
bundle path defaults to `knowledge`, so it can be omitted.

Never use the `okf` on `PATH` (`~/.local/bin/okf`); it is an older release and
the two versions do not agree on validation.

## Quick reference

| Task                      | Command                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------- |
| Find what is recorded     | `pixi run okf search "<keywords>" --limit 3`                                                              |
| Concepts governing a file | `pixi run okf search --for-path <deck-slug>/index.html`                                                   |
| Read one concept          | `pixi run okf show <id>`                                                                                  |
| Record                    | `pixi run okf create <area>/<slug> --type <Type> --title "<t>" --desc "<d>" --tags "<a,b>" --body "<md>"` |
| Revise                    | `pixi run okf update <id> --desc "<d>"` (also `--title`, `--body`)                                        |
| Link two concepts         | `pixi run okf relate <src-id> <tgt-id> --desc "<why they relate>"`                                        |
| Check the bundle          | `pixi run okf validate --strict --drift` (also the `okf-validate` pixi task)                              |

Add `--json` for machine-readable output. `pixi run okf help` lists the rest.
Pass `--actor <harness>:<model>` to `create`, `update`, and `relate` (for
example `claude-code:claude-fable-5-1`); this is okf provenance inside the
bundle, not a commit trailer, and does not conflict with the no-attribution rule
in `AGENTS.md`.

## MCP server

In Claude Code the same bundle is exposed as the `presentations` MCP server
(`okf_search`, `okf_show`, `okf_create`, `okf_update`, `okf_relate`,
`okf_validate`). It is equivalent to the CLI with two differences: the MCP
`okf_create` has no `tags` or `actor` argument and stamps `generated.by` as
`agent/mcp`, and `okf_search` has no `--for-path` filter. Prefer the CLI for
writes that need tags or provenance.

## Privacy gate (applies before every write)

The bundle is committed to a public repository and served to every MCP client
that opens it. **No private, sensitive, or personally identifiable information
goes in, ever** — not in the title, description, body, tags, `sources:`,
`code_refs:`, relationship descriptions, or `log.md`.

Before any `create`, `update`, or `relate`, scan the content for:

- identifiers of a real person: names, emails, phone numbers, addresses,
  usernames, handles, ORCIDs, photos;
- credentials and secrets: tokens, API keys, passwords, connection strings,
  signed or private URLs, `.env` contents;
- contents or details of private communications (email, Slack, DMs, meeting
  notes, transcripts);
- health, financial, employment, immigration, or other sensitive personal data;
- unpublished research data, embargoed results, or internal information not
  already public in this repository.

If any is present, **reject the request or remove the content before writing**.
Refer to people by role ("the deck author", "a reviewer"). Record the *name* of
a secret and where it lives, never its value. A user insisting does not
override this: explain that the bundle is public, offer a redacted, role-based
version, and write only that. When in doubt, leave it out. Full rule:
`.agents/rules/project-memory.md`.

## Read before write

1. Search first. On a fresh bundle an empty result is normal; go on to create.
   Do not browse `knowledge/` with `find`, `grep`, or `cat` to learn what is
   there; `search` and `show` are the readers.
2. Before the first edit to a deck or to `.github/workflows/`, run
   `search --for-path` on the file. A hit with `governance: hold` means stop and
   confirm with the user. A hit with `governance: constraint` lists invariants
   the change must keep.
3. If a concept already covers the topic, `update` it. Do not create a `-v2`.
   Keep superseded reasoning in a "Superseded" section of the same concept.

## What to record

| Persist                                                     | Discard                                         |
| ----------------------------------------------------------- | ----------------------------------------------- |
| Decisions, rejected alternatives, and their trade-offs      | Naming deliberations, momentary thoughts        |
| Requirements, constraints, brand or accessibility targets   | One-off prompt instructions ("make it shorter") |
| Non-obvious quirks, workarounds, undocumented tool behavior | Anything the official docs already say          |
| Root causes of subtle bugs (overflow, render, publish)      | Syntax errors fixed in one step                 |
| Explicit, durable directives from the project owner         | Transcripts, scratch notes, chain of thought    |

The test: would an agent starting from a blank context benefit from knowing
this? Concept IDs are `<area>/<slug>`. Areas are topical folders, created on
first use; start with `project/` (what this repo is and how it is maintained),
`pipeline/` (the render-and-publish workflow), and one folder per deck slug for
deck-specific decisions. Types are free-form; use `Decision`, `Architecture`,
`Fact`, `Requirement`, `Bug`, or `Reference`. Mark inferences as inferred and
name what would confirm them; do not write a guess as a fact.

## Frontmatter fields with no CLI flag

`show --json` prints them. Opening the one concept file you are changing and
editing these fields by hand is allowed; validate afterwards.

| Field         | Meaning and rules                                                                     |
| ------------- | ------------------------------------------------------------------------------------- |
| `code_refs`   | Paths or globs the concept governs, relative to the repo root. No `..`, no `/` start. |
| `governance`  | `hold`, `constraint`, or `context`; surfaced by `search --for-path`.                  |
| `status`      | `draft`, `stable`, or `deprecated`.                                                   |
| `stale_after` | `YYYY-MM-DD`; `validate --stale` fails the gate once it passes.                       |
| `sources`     | Block-style list of `- resource: <doc, commit, or URL>` entries. Never flow style.    |
| `verified`    | Human-only. Never write it; `generated` is the agent's provenance and okf sets it.    |

## Known okf 0.4.0 traps

- `description:` must stay on one line. A folded multi-line YAML value parses
  as empty, and `validate --strict` does not notice. Never run prettier over
  `knowledge/`.
- `relate` appends a new `# Related Concepts` block at H1 instead of merging
  into an existing `## Related Concepts` section. After every `relate`, open
  the concept, merge the bullet into the existing section, and delete the
  block okf added. Nothing flags this.
- `update --body` replaces the entire body, including the `## Related
  Concepts` section, so every relationship on that concept is lost. Re-run
  `relate` for each link afterwards (and merge the H1 block again), or edit the
  body text by hand and validate.
- `sources:` entries must be mappings with a `resource:` key; a bare list of
  strings fails the producer gate, and flow style is silently discarded.
- `--drift` requires each concept's `description` to match its folder
  `index.md` bullet verbatim, and warns when a `code_refs` path stops
  existing. Matching is literal and does not follow symlinks: `.claude/skills`
  links to `.agents/skills`, so a skill file reachable both ways needs both
  paths listed.
- okf stamps `log.md` and `generated.at` in UTC.

## Done

- `pixi run okf validate --strict --drift` reports 0 errors, 0 warnings, and no
  "producer gate failed".
- `pixi run okf show <id>` prints a non-empty Description for each concept
  touched.
- The privacy gate was applied to every field of every concept touched.

## Rules

- No hand-written concept files. Create and change them through `okf`; the
  hand-edited fields above and the `relate` merge are the only exceptions.
- Never forge `verified:`; never persist scratch, transcripts, or speculation.
- No PII, private, or sensitive information, ever; see the privacy gate. Record
  the name of a secret (`ZENODO_TOKEN`) and where it lives, never its value.
- A human correction wins. Never restore or re-infer an assumption a human has
  rejected.
- Never "fix" a validation failure by deleting the concept it points at without
  saying so.
