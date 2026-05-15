# AGENTS.md

Operating rules for AI agents working in this repo. Read this before doing anything. Cross-reference `README.md` for the human-facing version.

## What this repo is

Reveal.js presentations + a GitHub Actions pipeline that renders each deck to PDF and deposits it to Zenodo under the [`uw-ssec`](https://zenodo.org/communities/uw-ssec/) community.

- `staging` → `sandbox.zenodo.org` (throwaway records)
- `main` → `zenodo.org` (real DOIs, permanent)
- PRs render but never publish.

## Core principles

- **Think before acting.** Read the surrounding file/slide first. Mirror its conventions instead of inventing new ones.
- **Make surgical changes.** Touch only what the task requires. Don't reformat, rename, or "tidy" adjacent code.
- **Prefer the boring option.** Inline `style="…"` everywhere? Keep it. SHA-pinned actions? Keep it. The deck preaches these patterns — don't break them.
- **State what changed and why** in your final reply. Don't bury edits in long preambles.

## Project rules

- **Branch off `staging`.** PRs target `staging`. After staging publishes successfully to sandbox, the user opens a separate PR `staging` → `main`.
- **SHA-pin every `uses:` action** with a 40-char commit SHA and a `# vX.Y.Z` tag comment. The deck literally argues for this; the workflow has to model it.
- **Workflow permissions are deny-by-default.** `permissions: {}` at the top, each job opts in. `build` is `contents: read`; `publish` is `contents: read` and reads secrets only.
- **Versioning is CalVer (`YYYY.MM.DD`).** Same-day re-publishes bump `.N`. Do not switch to git-SHA versioning.
- **Existing Zenodo records are found by keyword tag `uw-ssec-deck:<slug>`.** Changing a deck's slug orphans its DOI history. Don't change slugs casually.
- **Reveal.js aspect is `1280×720`.** Match the workflow's `--size`.
- **Preserve slide `id` attributes** when restructuring — they're deep links.
- **Footnote citations stay.** Every slide ending in a `.footnote` block keeps it. Trim wording, don't drop sources.
- **Fix slide overflow inline**, on the offending element (font-size / line-height / shorter wording). Don't edit global CSS for one slide's problem.
- **Path filter list stays in sync** with the deck directories the workflow handles (`<deck>/**`).

## Never do

- ❌ **Never add AI attribution to commit messages or PR bodies.** No `Co-Authored-By: Claude …`, no `🤖 Generated with Claude Code`. The deck has an explicit AI Attribution slide; commit-level disclosure is duplicative noise the user has already rejected.
- ❌ **Never push directly to `main`.** Promote via PR from `staging`.
- ❌ **Never make the `publish` job fire on PRs or feature branches.** That would mint real (or sandbox) Zenodo records from unreviewed code.
- ❌ **Never run the publish script against production from a local machine** without explicit go-ahead — Zenodo production records are permanent.
- ❌ **Never replace SHA-pins with tag refs** (`actions/checkout@v4`). Always full-SHA + comment.
- ❌ **Never bump `decktape`, `pnpm`, or Python without asking.** Versions are pinned for a reason.
- ❌ **Never delete a deck's `zenodo.json` or change its `slug`/`community`** without explicit confirmation.
- ❌ **Never invent new CSS classes** to do what `card`, `card-red`, `card-blue`, `card-green`, `check-item`, `footnote`, etc. already do.
- ❌ **Never re-Read a file** you just edited to "verify" — the harness errors on failed edits.
- ❌ **Never use the Read tool on a skill file.** Invoke skills via the `Skill` tool.

## Patterns to match

**Slide hardening — fix overflow on the offending pre/list, not global CSS:**

```html
<!-- ❌ -->
<style>.content pre { font-size: 10pt; }</style>

<!-- ✅ -->
<pre style="… font-size: 10pt; line-height: 1.3; …">…</pre>
```

**Workflow actions — always SHA + comment:**

```yaml
# ❌
- uses: actions/checkout@v4

# ✅
- uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd  # v6.0.2
```

**Untrusted event data — bind via env, not interpolation:**

```yaml
# ❌
- run: echo "${{ github.event.pull_request.title }}"

# ✅
- env:
    PR_TITLE: ${{ github.event.pull_request.title }}
  run: echo "$PR_TITLE"
```

**Headless Chrome on GitHub runners — always pass --no-sandbox:**

```bash
# ✅
decktape reveal --chrome-arg=--no-sandbox …
```

## Adding a new deck

1. Create `<deck-slug>/index.html` plus assets.
2. Add a gallery card to root `index.html`.
3. Add `<deck-slug>/zenodo.json` with: `slug`, `community: "uw-ssec"`, `title`, `upload_type: "presentation"`, `description` (HTML ok), `creators` with ORCIDs, `keywords`, `license`, `pdf`.
4. Extend `.github/workflows/build-pdf.yml`: add a build step that renders this deck and a publish step that runs `python .github/scripts/zenodo_publish.py <deck-slug>`. Update the path filter.
5. Open a PR to `staging`. Verify the sandbox record. Then user opens `staging` → `main`.

## Confirm before doing

- Any change that would create or update a real Zenodo record.
- Changing a deck's `slug`, `community`, `creators`, or ORCIDs.
- Moving `.github/scripts/` or top-level directories.
- Switching package managers, Python versions, or pinned tool versions.

## Local commands

```bash
# Serve repo for local browsing / decktape
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

Sandbox records can be deleted from the UI; production records cannot. Default to sandbox when in doubt.

## Tech stack

- Reveal.js 5.1.0 (loaded from `cdn.jsdelivr.net`).
- decktape 3.12.0 (pinned by commit SHA in the workflow).
- pnpm 9.15.0 via Corepack.
- Python 3.12 + `requests==2.32.3` for the publish script.
- GitHub-hosted `ubuntu-latest` runners.
