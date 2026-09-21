# Pixi, Tools & Verification

**Load when:** running any command, adding a tool, editing `pixi.toml`, or
about to claim that something works.

## Pixi

[Pixi](https://pixi.sh) manages the local tool environment. Never use `pip`,
`conda`, `npm -g`, or `venv` to install tools for this repo; add them to
`pixi.toml` and run `pixi install`.

Two environments:

- **`default`**: `okf-agent-memory`, the `okf` CLI that reads and writes the
  project memory bundle.
- **`evals`** (own solve group, Python 3.12+): Inspect and Harbor for the skill
  evals under `evals/`, plus pytest for the coverage test. Installed on first
  `pixi run verify`; both frameworks come from PyPI on purpose (see the comment
  in `pixi.toml`).

```bash
pixi install                 # first, once per clone; idempotent
pixi run verify              # the gate: okf-validate, evals-check, inspect-smoke
pixi run okf <command>       # the bundle CLI, from the pixi env
pixi run okf-validate        # okf validate --strict --drift over knowledge/
pixi run -e evals harbor-dry-run   # every Harbor task without Docker
pixi task list               # every task
```

`pixi.toml` layout: `[workspace]` (name, channels, platforms),
`[environments]`, `[dependencies]` (conda packages, incl. the `uw-ssec` channel
for okf), `[tasks]`, `[feature.evals.*]`. Commit `pixi.lock` whenever
`pixi.toml` changes.

Quirks: tasks run in pixi's own shell, where `cp -R src/. dst/` nests the
directory (use `src/*`); extra arguments append to the task command
(`pixi run -e evals inspect-skill -T name=new-deck --model …`); an argument
containing `{{` is read as a placeholder, so call `.pixi/envs/default/bin/okf`
directly for such a body.

**Never run the `okf` on `PATH`** (`~/.local/bin/okf`). It is an older release
that disagrees with the pinned one on validation. The `presentations` MCP
server in `.mcp.json` runs `pixi run okf mcp knowledge` for the same reason.

## Rendering and publishing tools (not in pixi)

The PDF pipeline runs on GitHub runners with these pinned versions. Reproduce
them locally as needed; do not bump them without asking.

- Reveal.js 5.1.0 (loaded from `cdn.jsdelivr.net`)
- decktape 3.12.0 (pinned by commit SHA in the workflow)
- pnpm 9.15.0 via Corepack
- Python 3.12 + `requests==2.32.3` for the publish script
- GitHub-hosted `ubuntu-latest` runners

```bash
# Serve repo for local browsing / decktape
python3 -m http.server 8000

# Render a deck to PDF locally
npx decktape reveal --chrome-arg=--no-sandbox \
  --size 1280x720 --load-pause 500 \
  http://localhost:8000/<deck-slug>/index.html \
  <deck-slug>/<deck-slug>.pdf

# Dry-run the publish script against the sandbox
ZENODO_TOKEN='<sandbox-token>' ZENODO_SANDBOX=true \
  python .github/scripts/zenodo_publish.py <deck-slug>
```

## Verification

`pixi run verify` is the gate: the knowledge bundle, the eval coverage test and
shim self-test, and the Inspect smoke. Run it before any commit or PR, capture
its output to a file rather than a pipe, and check the exit code. Then run the
checks that match what changed and read the output before reporting:

| Changed                    | Check                                                          |
| -------------------------- | -------------------------------------------------------------- |
| A fragment deck            | `./build.sh` succeeds; open `build/index.html`; `/design-review`, `/accessibility-check` |
| The Reveal.js deck / gallery | Serve and render locally; confirm affected slides fit 1280×720 |
| `.github/workflows/`       | Workflow syntax stays valid; SHA pins and permissions intact; zizmor passes on the PR |
| `zenodo.json`              | Valid JSON; `slug` unchanged unless confirmed                  |
| `knowledge/`               | `pixi run okf-validate` → 0 errors, 0 warnings, gate passed    |
| `pixi.toml`                | `pixi install` succeeds; `pixi.lock` updated and staged        |
| `.mcp.json`                | Valid JSON; `pixi run okf mcp knowledge` answers an MCP `initialize` |
| A skill or `evals/`         | `pixi run verify`, then `pixi run -e evals harbor-dry-run` (oracle 1, nop 0); `harbor-oracle` where Docker exists |
