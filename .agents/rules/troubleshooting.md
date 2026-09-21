# Troubleshooting

**Load when:** a documented command fails or behaves unexpectedly.

## `okf: command not found`, or okf disagrees with the docs

Run `pixi install`, then use `pixi run okf …`. The `okf` on `PATH` is a
different, older release; never use it here.

## `okf validate` reports drift or an orphan

- **Drift:** a concept's `description:` no longer matches the bullet in its
  folder `index.md`. Fix it through `pixi run okf update <id> --desc …`, which
  rewrites both.
- **Orphan:** nothing links to the concept. Under `--strict` that is an error.
  Add a relationship with `okf relate`, then merge the H1 block it appends
  (see the `/okf-memory` skill).
- **Empty descriptions in search:** `description:` was folded onto multiple
  lines, usually by a formatter. Restore it to one line.

## The MCP server does not appear in Claude Code

`.mcp.json` runs `pixi run okf mcp knowledge` from the repo root. Check that
`pixi` is on `PATH`, `pixi install` has been run, and the JSON is valid. Test
by hand: run the command and send an MCP `initialize` request on stdin; it
should answer with `okf-agent-memory` as the server name.

## decktape renders blank or truncated slides

- Serve the repo over `http://`, not `file://`.
- Pass `--chrome-arg=--no-sandbox` on GitHub runners.
- Increase `--load-pause` if fonts or CDN assets are still loading.
- Confirm `--size 1280x720` matches the Reveal.js config.

## Modifying `pixi.toml` breaks the environment

```bash
pixi install            # re-solve
rm -rf .pixi && pixi install   # if still broken
```
