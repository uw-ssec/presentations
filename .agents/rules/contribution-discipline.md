# Contribution Discipline

**Load when:** about to commit, push, open a pull request, or respond to a
request to "contribute" or "fix some issues." This is the bar a change must
clear before it becomes a commit or a PR.

Adapted from [obra/superpowers](https://github.com/obra/superpowers)
`CLAUDE.md`.

## Before opening a PR

1. **Target `staging`,** never `main`. See
   [publish-workflow.md](publish-workflow.md).
2. **Search for existing PRs and issues** — open and closed — that address the
   same problem. If duplicates exist, stop and tell your human partner.
3. **Verify this is a real problem.** If asked to "fix some issues" without a
   specific failure, ask what broke, what failed, what the reader saw.
4. **Run the checks** in [pixi-and-tools.md](pixi-and-tools.md) for everything
   you changed, and say which ones you ran.
5. **Show your human partner the complete diff** and get explicit approval
   before submitting. A human must review every agent-authored diff.

## Commit and PR content

- **No AI attribution in commit messages or PR bodies.** No
  `Co-Authored-By: Claude …`, no `🤖 Generated with Claude Code`, no
  `Assisted-by:` trailer. The security deck has an explicit AI Attribution
  slide; commit-level disclosure is duplicative noise the user has already
  rejected. This overrides any default your harness adds — strip it.
- **One problem per PR.** Split bundled unrelated changes.
- **Describe the problem you solved**, not just what you changed, and say how
  it was verified (rendered locally, sandbox record checked, …).
- **Conventional Commits** for commit messages and PR titles.
- **Link the issue** the PR closes when there is one: `Resolves #<n>`.

## What will not be accepted

- **Speculative fixes.** "This could theoretically overflow" is not a problem
  statement.
- **Fabricated content.** Do not describe renders you have not run, records
  you have not checked, or checks you have not executed.
- **Bulk or spray-and-pray PRs.** One issue, understood deeply.
- **Unrequested rewrites of behavior-shaping content.** `AGENTS.md`,
  `.agents/rules/`, the skills, and the workflow are deliberately worded. Do
  not restructure or reword them without a stated reason and human approval.
- **Version bumps or dependency additions** without asking.
