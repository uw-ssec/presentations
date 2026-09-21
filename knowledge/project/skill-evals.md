---
type: Architecture
title: Skill Evals with Inspect and Harbor
description: "Every skill under .agents/skills has an Inspect sample file scored by must/must-not rules and a Harbor sandbox task with logging fake pixi/okf; three guard tasks cover the Reveal.js temptation, apply-visuals idempotency, and PII in memory; a Docker-free dry run stands in for Harbor on this machine."
tags: [evals, inspect, harbor, skills, testing]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-21T22:19:56Z" }
---

The `evals/` tree is a port of the llmoxie-analysis skill evals
(`~/Documents/llmoxie-analysis/evals`, merged there in PR #42), adapted on
2026-09-21 for this repository's six skills: the five vendored uw-slides skills
and okf-memory. Its layout, run commands, and per-task rewards are in
`evals/README.md`; this concept records what is not derivable from the files.

## What was kept from the reference

- Two levels: Inspect (model reply scored by deterministic `must` /
  `must_not` rules, no judge model) and Harbor (agent in a sandbox, fake CLIs
  that log every call to `/var/log/skill-shims`, verifiers that read logs and
  repo state). One task factory (`skill_eval.py`, copied unchanged) and one
  base image; per-task directories only build a fixture.
- Skills are read from `.agents/skills/`, never copied; a gitignored
  `harbor-sync` step copies them into the image build context with `cp -R
  src/*` because pixi's task shell nests `src/.`.
- Both frameworks from PyPI in a separate `evals` solve group (conda-forge
  inspect-ai pins websockets 17, harbor needs <16; harbor needs Python 3.12+).
- Pre-answered confirmations in `instruction.md`, guard tasks that omit them,
  and one positive check per guard so a crashed agent scores 0.

## What changed for this repository

- The `gh` shim is gone: no project skill calls GitHub. The `pixi` shim
  forwards `okf` and `okf-validate` and accepts `-e <env>`.
- The base image also carries `/opt/repo`: `AGENTS.md`, `.agents/rules`, and
  `.agents/uw-slides`, because `/new-deck` copies templates by repo-relative
  path and the new-deck guard depends on the agent reading the rules.
  `presentations_scaffold` in `lib/fixture.sh` copies them into `/app` with a
  gallery, the legacy Reveal.js deck, and an OKF bundle; `fragment_deck` builds
  a clean three-slide SSEC deck that review tasks then break on purpose.
- Verifier vocabulary gained `file_has`, `tree_lacks`, `count_in` and
  `unchanged` (checksums the fixture stores under `/fixture/sha/`), because
  deck skills produce files rather than git or gh calls.
- The three guards encode this repository's own rules: new decks are fragment
  decks even when asked to copy the Reveal.js one (`project/deck-format-default`),
  apply-visuals must honour `data-visuals-applied`, and no PII may reach the
  public bundle (AGENTS.md non-negotiable 7). The okf-memory happy path also
  fails if okf is called from PATH instead of `pixi run`.
- `pixi run verify` now exists: okf-validate, the coverage test plus shim
  self-test, and the Inspect smoke. It installs the `evals` environment on
  first use.

## Docker is absent on this machine

No Docker Desktop, colima, or podman was found, so `harbor-oracle` could not
run locally. `evals/harbor/dry-run.sh` (pixi task `harbor-dry-run`) was written
instead: it rewrites the container paths in the libs, shims, fixture, solution
and verifier to a temp root, shims GNU `date -d` on macOS, and runs fixture,
oracle-or-nothing, verifier. On 2026-09-21 all ten tasks scored 1 under the
oracle and 0 under nop, and four adversarial solutions (copying the Reveal.js
deck, re-applying the SVG, recording the reviewer's email, calling okf from
PATH) each scored 0. The dry run proves the task files; it does not prove skill
delivery to a real agent, which only `harbor run -a claude-code` shows.
The CI workflow `skill-evals.yml` runs the Docker half on ubuntu-latest and
targets `staging` and `main`; it has not yet run.

## Traps met while porting

- An Inspect `must` of `content/` failed the canned answer because the
  command line listed `rse-meetup-2026/content ` without a trailing slash;
  rules should name a distinctive token, not a path fragment.
- `sed` rewriting of `/skills` must be anchored on the preceding character,
  or `.agents/skills` is rewritten too.
- macOS has `/sbin/sha256sum` but no `date -d`; Linux needs neither shim.
- The repository .gitignore is the GitHub Python template, which ignores every
  `lib/` directory. `evals/harbor/base/lib/` therefore never reached the
  remote: the shim self-test passed locally and failed in CI with
  `shimlib.sh: No such file or directory`. The fix is a `!evals/harbor/base/lib/`
  negation placed after the template rule. Check `git ls-files` for any new
  directory named lib, build, dist, or similar before trusting a local pass.

## Related Concepts

- [The uw-slides plugin is vendored under .agents, not installed from a marketplace](uw-slides-plugin-vendored.md): The skills under test and the assets the base image carries for them.
- [New Decks Default to uw-slides HTML, Not Reveal.js](deck-format-default.md): The decision the new-deck guard task enforces.
