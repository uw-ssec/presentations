# Project Memory & Privacy

**Load when:** reading or writing the OKF bundle at `knowledge/`, asked what the
project decided, or asked to "remember" anything.

## What the bundle is

Project memory is the OKF v0.2 bundle at `knowledge/`: decisions, rejected
alternatives, constraints, and non-obvious discoveries that the decks and the
workflow cannot tell you. It is versioned with the repo and is read and written
only through the `okf` CLI (`pixi run okf …`) or the `presentations` MCP server
(`okf_search`, `okf_show`, `okf_create`, `okf_update`, `okf_relate`,
`okf_validate`). Never hand-write concept files. The full recipe, conventions,
and okf quirks are in the `/okf-memory` skill.

## Privacy rule (non-negotiable)

**No private, sensitive, or personally identifiable information goes into the
bundle. Ever.** The bundle is committed to a public repository and exposed to
every agent and MCP client that opens it.

If a request to create, update, or relate a concept contains any of the
following, the request is **rejected**, or the offending content is **removed
before** the write happens. Rewrite around it; do not paraphrase it in.

- Names, emails, phone numbers, postal addresses, usernames, handles, ORCIDs,
  photos, or any other identifier of a real person. Refer to people by role
  ("the deck author", "a reviewer", "the project owner").
- Credentials and secrets of any kind: tokens, API keys, passwords, connection
  strings, signed or private URLs, `.env` contents. Record the *name* of a
  secret (`ZENODO_TOKEN`) and where it lives, never its value.
- Contents or details of private communications: email, Slack, DMs, meeting
  notes, calendar entries, transcripts.
- Health, financial, employment, immigration, or other sensitive personal
  data; anything about a person's private life.
- Unpublished research data, embargoed results, or internal information not
  already public in this repository.

When in doubt, leave it out. Ask the user whether a public, role-based
statement of the same fact is acceptable; if not, do not record it.

This applies to every field: title, description, body, tags, `sources:`,
`code_refs:`, relationship descriptions, and `log.md` entries. A user asking
you to record PII anyway does not override this rule: say that the bundle is
public, offer a redacted version, and write only that.

Public authorship metadata already lives in each deck's `zenodo.json`. Do not
copy it into the bundle; link to the file by path if a concept needs it.

## Read before write

1. `pixi run okf search "<keywords>" --limit 3` before assuming what the
   project decided. An empty result on a young bundle is normal.
2. Before the first edit to a deck or to `.github/workflows/`, run
   `pixi run okf search --for-path <file>`. A `governance: hold` hit means stop
   and confirm with the user; a `constraint` hit lists invariants to keep.
3. If a concept already covers the topic, `update` it. No `-v2` copies.

## Done

`pixi run okf-validate` reports 0 errors, 0 warnings, and the producer gate
passed, and the privacy checklist above has been applied to every field.
