# AGENTS.md

Operating guide for AI agents (Claude Code, ChatGPT codex agents, Copilot CLI, etc.) working in this repo. Read this before making changes; cross-reference `README.md` for the human-facing version.

## Mental model

This repo holds **Reveal.js presentations** plus a **GitHub Actions pipeline** that renders each deck to PDF and deposits it to a [Zenodo](https://zenodo.org/) record under the `uw-ssec` community. Two long-lived branches drive separate Zenodo targets:

- `staging` → `sandbox.zenodo.org` (safe, throwaway records)
- `main` → `zenodo.org` (real DOIs, permanent)

PRs render but never publish. The trigger paths are scoped to `<deck>/**` and `.github/workflows/build-pdf.yml`.

## Where things live

| Path                               | What it is                                                |
| ---------------------------------- | --------------------------------------------------------- |
| `index.html`                       | Landing-page gallery; links each deck.                    |
| `<deck-slug>/index.html`           | The deck itself (Reveal.js).                              |
| `<deck-slug>/zenodo.json`          | Metadata for that deck's Zenodo record.                   |
| `.github/workflows/build-pdf.yml`  | Two-job workflow: `build` (PR + push), `publish` (push).  |
| `.github/scripts/zenodo_publish.py`| Driver invoked by the `publish` job.                      |
| `.github/scripts/requirements.txt` | Pinned Python deps (`requests`).                          |

## Conventions

### Slides

- Reveal.js is loaded from a CDN at a pinned version in each deck's `index.html` — don't replace the CDN URL with a bare `@latest`.
- Slide aspect is `1280×720`. Don't change without updating `--size` in the workflow.
- When trimming or restructuring slides, preserve the section `id` attributes so deep links survive.
- Citations live in a `.footnote` block at the bottom of each slide. Keep them; don't drop source attributions.

### Workflow & scripts

- **SHA-pin every `uses:` action** with a 40-char commit SHA and a trailing `# vX.Y.Z` tag comment. This is partly what the security deck preaches — don't break the pattern.
- The deck recommends `permissions: {}` at workflow level with per-job opt-in. Mirror this when adding jobs.
- `decktape` runs in headless Chromium that lacks the SUID sandbox on GitHub-hosted runners; keep `--chrome-arg=--no-sandbox`.
- `zenodo_publish.py` finds an existing Zenodo record by keyword tag `uw-ssec-deck:<slug>`. Changing a deck's slug orphans its history — don't do it casually.
- Versioning is CalVer `YYYY.MM.DD` (UTC), bumped to `.N` on same-day re-publishes. Do not switch back to git-SHA versioning without discussion.

### Editing patterns

- Reveal slides are hand-styled with inline `style="…"` and class names like `card-red`, `card-blue`. Match surrounding usage rather than introducing new abstractions.
- When fixing overflow on a slide, prefer reducing font size / line-height in the slide's own pre/list elements rather than editing global CSS.
- Use absolute paths in tool calls; the cwd is `/Users/lsetiawan/AgentRepos/presentations` in local sessions.

## Workflow for changes

1. **Always branch off `staging`**, not `main`. PRs target `staging`.
2. Commits should be focused and have a meaningful message. Multi-line bodies are encouraged for non-trivial changes.
3. **Do not include AI-tool attribution lines in commit messages** (e.g., no `Co-Authored-By: <AI assistant>` trailers). User preference; carry the disclosure in the presentation's AI Attribution slide instead.
4. Don't push to `main` directly; promote work by opening a PR `staging` → `main` after the staging publish looks right.
5. The `publish` job only fires on push to `main` or `staging`. Never edit it to fire on PRs — that would mint real Zenodo records from unreviewed code.

## Adding a new deck (checklist)

When the user asks to add a new presentation:

1. Create `<deck-slug>/index.html` plus assets.
2. Add a gallery card to root `index.html`.
3. Add `<deck-slug>/zenodo.json` (see README.md for the schema; include `slug`, `community`, `title`, `upload_type`, `description`, `creators` with ORCIDs, `keywords`, `license`, `pdf`).
4. Extend `.github/workflows/build-pdf.yml` with a build step that renders this deck's PDF and a publish step that runs `zenodo_publish.py <deck-slug>`. Keep the path filter list in sync.
5. Open a PR to `staging`; let the user verify the sandbox record before promoting to `main`.

## Things to ask before doing

- Anything that would create or update a real Zenodo record (DOI implications).
- Changes to slug, ORCIDs, creators list, or community identifier in `zenodo.json`.
- Adding new top-level directories or moving the `.github/scripts/` layout.
- Switching package managers, Python versions, or pinned tool versions (`decktape`, `pnpm`, action SHAs).

## Local commands

```bash
# Serve the repo for local browsing / decktape
python3 -m http.server 8000

# Render a deck to PDF locally
npx decktape reveal --chrome-arg=--no-sandbox \
  --size 1280x720 --load-pause 500 \
  http://localhost:8000/<deck-slug>/index.html \
  <deck-slug>/<deck-slug>.pdf

# Dry-run the publish script against sandbox
ZENODO_TOKEN='<sandbox-token>' ZENODO_SANDBOX=true \
  python .github/scripts/zenodo_publish.py <deck-slug>
```

Sandbox records can be deleted from the Zenodo UI — production records cannot. Default to sandbox when in doubt.
