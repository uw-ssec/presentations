# Repository Map

**Load when:** you need to know what this repository is, where a file lives, or
what CI runs against it.

## Repository Overview

**presentations** holds slide decks from the University of Washington
Scientific Software Engineering Center (SSEC), plus a GitHub Actions pipeline
that renders each deck to PDF and deposits it on Zenodo under the
[`uw-ssec`](https://zenodo.org/communities/uw-ssec/) community.

- `staging` → `sandbox.zenodo.org` (throwaway records)
- `main` → `zenodo.org` (real DOIs, permanent)
- Pull requests render but never publish.

Decks come in two flavours:

- **uw-slides fragment decks** — the default for every new deck. Built by the
  vendored [uw-slide-deck-plugin](https://github.com/aaarendt/uw-slide-deck-plugin)
  skills from `content/*.html` fragments into `<deck-slug>/build/index.html`
  (gitignored). Not yet wired into the PDF workflow; see
  [deck-conventions.md](deck-conventions.md).
- **Reveal.js decks** — legacy. Only `security-in-age-of-ai` uses it
  (`<deck-slug>/index.html`, Reveal.js from a CDN), and it is what the PDF
  workflow renders today.

## Project Structure & Key Files

```
.
├── .agents/
│   ├── rules/                   # On-demand rules referenced by AGENTS.md
│   ├── skills/                  # Project skills (/new-deck, /okf-memory, ...)
│   └── uw-slides/               # Vendored brand systems, templates, fonts, references
├── .claude/
│   └── skills -> ../.agents/skills  # Symlink so Claude Code discovers the skills
├── .github/
│   ├── scripts/zenodo_publish.py    # Creates or versions the Zenodo record for a deck
│   ├── scripts/requirements.txt     # Pinned deps for the publish script
│   └── workflows/
│       ├── build-pdf.yml            # Render decks with decktape; publish on staging/main
│       ├── skill-evals.yml          # Coverage test, Inspect smoke, Harbor oracle matrix (Docker)
│       └── zizmor.yml               # Static analysis of the workflows themselves
├── evals/                       # Skill evals: Inspect samples, Harbor base image and tasks, dry-run.sh; see evals/README.md
├── tests/test_skill_evals.py    # Every skill has a sample file and a complete Harbor task; scripts parse
├── knowledge/                   # Project memory (OKF bundle); read and write via /okf-memory
├── <deck-slug>/                 # One directory per deck (uw-slides fragment layout)
│   ├── SLIDES.md                # Slide order and content briefs
│   ├── VISUALS.md               # Pass-2 visual additions
│   ├── shared/                  # header.html (design tokens), footer.html
│   ├── content/                 # One <section> fragment per slide
│   ├── content-with-visuals/    # Pass-2 fragments written by /apply-visuals
│   ├── assets/                  # images/, diagrams/
│   ├── build.sh, build-visuals.sh
│   ├── build/index.html         # Built deck; gitignored
│   └── zenodo.json              # Zenodo metadata: slug, community, creators, license, pdf
├── security-in-age-of-ai/       # Legacy Reveal.js deck: index.html, styles.css, zenodo.json
├── index.html                   # Gallery page linking every deck
├── .mcp.json                    # Claude Code MCP server: `pixi run okf mcp knowledge`
├── .readthedocs.yaml            # Copies the gallery and decks into the Read the Docs output
├── pixi.toml                    # Local tool environment (okf-agent-memory); tasks
├── pixi.lock                    # Lock file (auto-generated, don't edit by hand)
├── AGENTS.md                    # Entry point for AI assistants
├── CLAUDE.md                    # Points Claude Code at AGENTS.md (@AGENTS.md)
├── README.md                    # Human-facing documentation
└── LICENSE
```

Current decks: `security-in-age-of-ai` (Reveal.js, legacy).

## Continuous Integration

**`build-pdf.yml`** runs on pull requests and on pushes to `main` and
`staging`, filtered to the deck directories and the workflow file itself. The
`build` job (read-only, no secrets) serves the repo over HTTP and renders each
deck with decktape at 1280×720. The `publish` job runs only on `staging` and
`main`, reads the `ZENODO_*` secrets, and calls `zenodo_publish.py <slug>`.

**`zizmor.yml`** lints the workflow files for security issues. Changes under
`.github/workflows/` must keep it passing.

**`skill-evals.yml`** runs on changes to the skills, rules, uw-slides assets,
`evals/`, `tests/`, or the pixi files: the coverage test, the Inspect smoke on
canned answers, and every Harbor task with the oracle agent (Docker on the
runner). The same minus Harbor is `pixi run verify` locally.

**Read the Docs** hosts the gallery and decks as static HTML using the
`commands:` in `.readthedocs.yaml`. A new deck directory must be added there
too.

## Further Reading

SSEC research software engineering guidelines:
https://rse-guidelines.readthedocs.io/en/latest/llms-full.txt
