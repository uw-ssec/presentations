# Publish Workflow & Zenodo

**Load when:** touching `.github/`, `zenodo.json`, branches, or anything that
could create, version, or orphan a Zenodo record.

## Branches

- **Branch off `staging`.** PRs target `staging`. After `staging` publishes
  successfully to the sandbox, the user opens a separate PR `staging` → `main`.
- **Never push directly to `main`.** Promote via PR from `staging`.
- **Never make the `publish` job fire on PRs or feature branches.** That would
  mint real (or sandbox) Zenodo records from unreviewed code.

## Workflow hardening

The security deck argues for these patterns; the workflow has to model them.

- **SHA-pin every `uses:` action** with a 40-character commit SHA and a
  `# vX.Y.Z` tag comment. Never replace a pin with a tag ref.
- **Permissions are deny-by-default.** `permissions: {}` at the top; each job
  opts in. `build` is `contents: read`; `publish` is `contents: read` and
  reads secrets only.
- **Bind untrusted event data via `env`, never interpolate it into `run:`.**
- **Headless Chrome on GitHub runners needs `--no-sandbox`.**
- **The path filter list stays in sync** with the deck directories
  (`<deck>/**`), in both the `pull_request` and `push` triggers.
- **Keep `zizmor.yml` green** after any workflow change.

```yaml
# ❌
- uses: actions/checkout@v4
# ✅
- uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd  # v6.0.2

# ❌
- run: echo "${{ github.event.pull_request.title }}"
# ✅
- env:
    PR_TITLE: ${{ github.event.pull_request.title }}
  run: echo "$PR_TITLE"
```

```bash
decktape reveal --chrome-arg=--no-sandbox …
```

## Zenodo records

- **Versioning is CalVer (`YYYY.MM.DD`).** Same-day re-publishes bump `.N`.
  Do not switch to git-SHA versioning.
- **Existing records are found by keyword tag `uw-ssec-deck:<slug>`.**
  Changing a slug orphans its DOI history.
- **Never delete a deck's `zenodo.json`, or change its `slug`, `community`,
  `creators`, or ORCIDs,** without explicit confirmation.
- **Never run the publish script against production from a local machine**
  without explicit go-ahead. Sandbox records can be deleted from the UI;
  production records cannot. Default to sandbox when in doubt.

## Pinned versions

`decktape`, `pnpm`, and Python are pinned for a reason. **Never bump them
without asking.** Current pins are in [pixi-and-tools.md](pixi-and-tools.md).

## Confirm before doing

- Any change that would create or update a real Zenodo record.
- Changing a deck's `slug`, `community`, `creators`, or ORCIDs.
- Moving `.github/scripts/` or top-level directories.
- Switching package managers, Python versions, or pinned tool versions.
- Changing the PDF workflow to build a uw-slides deck.
