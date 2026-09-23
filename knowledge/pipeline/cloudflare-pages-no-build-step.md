---
type: Fact
title: Cloudflare Pages deploys the repository as static files with no build step
description: "Every push to staging gets a Cloudflare Pages deployment that serves the checkout as-is, so a fragment deck whose build/ output is git-ignored has no page there and every missing path falls back to the gallery with a 200, which makes a status code alone useless as evidence."
tags: [pipeline, cloudflare, preview, uw-slides, hosting]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-23T02:44:11Z" }
status: stable
governance: context
code_refs:
  - "index.html"
  - "*/build.sh"

---

## What is wired up

A Cloudflare Pages integration (GitHub app `cloudflare-workers-and-pages`) deploys the repository on pushes. Its result shows up on the commit as a check run named **Cloudflare Pages**, not as a GitHub Actions run, with a per-commit preview URL and a per-branch URL under `presentations-73a.pages.dev` (branch `staging` maps to `staging.presentations-73a.pages.dev`). The GitHub deployments API does not list these; they are visible only in the check run's summary.

There is no Cloudflare build configuration in the repository (no `wrangler.toml`, `_redirects`, or `_headers`), and the deployment runs no build command. The site is the checkout, served statically.

## Consequences (observed 2026-09-22)

- The legacy Reveal.js deck renders at its path because its `index.html` is committed.
- A uw-slides fragment deck is fragments under `content/` plus `build.sh`; its `build/index.html` is git-ignored, so the deployment has nothing to serve for it.
- Cloudflare Pages answers any missing path with the root `index.html` and HTTP 200. Checking the `<title>` (or any deck-specific marker) is the only way to tell a deck page from the gallery fallback.
- The gallery `index.html` only links decks that were added to it; a deck missing a card is invisible even when its page exists.

## Options raised, none chosen yet

1. Give Cloudflare Pages a build command that runs each fragment deck's `build.sh`, keeping `build/` ignored.
2. Build in GitHub Actions and publish the output separately.
3. Commit `build/index.html` for the deck, which conflicts with the deck conventions and needs a rebuild on every content change.

The choice belongs to the project owner; it interacts with the PDF/Zenodo gap recorded in the related concept.

## Related Concepts

- [Fragment-based uw-slides decks are not covered by the PDF and Zenodo workflow](fragment-decks-outside-pdf-workflow.md): Both describe why a fragment deck has no published page yet: the PDF/Zenodo workflow renders only Reveal.js, and the Cloudflare preview runs no build.
