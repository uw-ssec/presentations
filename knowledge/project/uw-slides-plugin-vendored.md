---
type: Architecture
title: "The uw-slides plugin is vendored under .agents, not installed from a marketplace"
description: "Slide-building skills live in .agents/skills with .claude/skills symlinked to them, and plugin assets live in .agents/uw-slides, so the repository carries its own copy with repo-relative paths instead of a marketplace install."
tags: [project, uw-slides, skills, plugin, agents]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-21T22:15:09Z" }
status: stable
governance: context
code_refs: [".agents/skills/**", ".claude/skills/**", .agents/uw-slides/README.md]
sources:
  - resource: .agents/uw-slides/README.md
  - resource: AGENTS.md
---

## Architecture

The upstream uw-slides Claude Code plugin (linked from `AGENTS.md`) is copied into the repository:

- `.agents/skills/<name>/SKILL.md` holds the five skills (`new-deck`, `apply-visuals`, `design-review`, `accessibility-check`, `extract-to-markdown`).
- `.claude/skills` is a symlink to `../.agents/skills`, the same layout the llmoxie-analysis repository uses, so Claude Code loads them as project skills and other harnesses read `.agents/`.
- `.agents/uw-slides/` holds `design-systems/`, `templates/`, `references/`, the upstream license, and a README with the re-sync procedure.

## Why vendored

The project owner asked for the plugin to be built into the project rather than installed. A marketplace install (registering the repository in `extraKnownMarketplaces` and enabling the plugin in `.claude/settings.json`) was tried first and removed: it left the skills as a per-machine install resolved from the plugin cache, and the skills' hard-coded plugin paths would not have pointed at anything committed here.

## Non-obvious details a re-sync must preserve

- Upstream skills hard-code `~/.claude/plugins/local/uw-slides/` and invoke each other as `/uw-slides:<skill>`. The vendored copies use `.agents/uw-slides/` and `/<skill>`; re-apply both rewrites after copying new upstream versions.
- Skills reference assets by repo-relative path, so they must run from the repository root. The `new-deck` skill says so explicitly.
- Skills added through the `.claude/skills` symlink became available in a running Claude Code session without a restart.
- For okf drift checks, a skill file must be listed under both `.agents/skills/...` and `.claude/skills/...` because the drift check does not follow symlinks.
- Brands are `ssec` (default) and `uw`; CloudBank was removed on purpose. See the branding concepts.

## Related Concepts

- [SSEC is the default slide brand, adapted from the website design system](../branding/ssec-slide-brand.md): The SSEC brand is one of the two brands shipped inside the vendored plugin and is its default
- [Fragment-based uw-slides decks are not covered by the PDF and Zenodo workflow](../pipeline/fragment-decks-outside-pdf-workflow.md): Decks produced by the vendored plugin are the ones the PDF workflow does not yet render
- [New Decks Default to uw-slides HTML, Not Reveal.js](deck-format-default.md): The decision that makes this plugin's fragment format the default for every new deck.
- [Skill Evals with Inspect and Harbor](skill-evals.md): How the vendored skills are tested.
