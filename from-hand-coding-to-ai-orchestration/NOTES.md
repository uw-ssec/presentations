# Presenter notes

The projected slides carry the visual argument. These notes retain the fuller
explanations and trial observations from the copy pass. Live prompts remain
verbatim on their slides. Schematic workflows show intended steps, not captured
agent output. Use the original model names and observations as reported trial
results, not as a benchmark ranking.

## 01-title

CrossVISS 2026 · UW Scientific Software Engineering Center

From Hand Coding to AI Orchestration

Helping people and coding agents find their way around your research repo.

Don Setiawan · Principal Research Software EngineerCordero Core · Senior Research Software Engineer

## 02-join-mentimeter

Before we start

Scan to join

Join the polls from your phone: menti.com, code 4985 6011, or scan the QR code.

We'll show you what worked, what failed, and what we changed.

To follow along, fork the demo repo and open a Codespace. Ask your agent to copy the demo issues.

You're also welcome to just watch and ask questions.

## 03-roadmap

Today's walkthrough

Getting started in an unfamiliar repo

How can a coding agent work in a repo it doesn't know?

How can a new contributor get started without us beside them?

People and agents both need help finding the rules and understanding past decisions.

We'll ask an agent for help, improve the repo, then repeat the task. You judge whether the answer gets better.

1Orientation

2Agent environment

3Instruction entry point

4Project memory

5Agent skills

6Skill evals

## 04-menti-characteristics

Mentimeter

What characteristics make open-source software easy to contribute to?

Think of a project you enjoyed contributing to. What made it easy? Add as many answers as you like.

## 05-characteristics

What helped in 2023

What helps a new contributor

Docs that answer real questions

A setup that works

Code checks with pre-commit and linting

Clear contribution and community rules

Tests and benchmarks you can run

Security practices you can check

Reliable packaging and distribution

Source: pyOpenSci Python packaging guide

## 06-same-practice

What carries over

Agents need this context too

What helps contributors | How we give it to agents

Useful project docs | Project knowledge in the OKF bundle

Easy environment setup | A locked environment with pixi

Consistency, linting, pre-commit | Skills that run the required checks

Governance, contributing docs | AGENTS.md, on-demand rules, AI policy, disclosure

Benchmarking and test infrastructure | Skill evals in CI

Security, packaging, supply chain | Pinned tools, one package manager

We already write down code standards and check them in CI. We can do the same for the context an agent needs to contribute.

## 07-agent-model-harness

How a coding agent works

Agent = Model + Harness

The model interprets your request and chooses what to do next.

The harness supplies context and tools. It controls what the model can do and remember.

Claude Code, Copilot, Cursor, Codex, and OpenCode provide that surrounding software.

We keep project guidance in the repo so it can travel with us when we switch agent tools.

Source: addyosmani.com/blog/agent-harness-engineering

## 08-haf

The repo we'll build

Harness Augmentation Framework

Six parts give an agent a way to find the rules and do the work.

Instruction entry points

On-demand rules

Skills

Project memory

Skill evaluations

Agent environment

The package is still at the center. We'll build the support around it, one part at a time.

## 08b-llmoxie-platform

Where the demo data comes from

LLMoxie is SSEC's AI gateway: one endpoint in front of cloud and on-prem models, with authentication, budgets, PII masking, and observability in the control plane.

Every human and AI exchange that goes through it is logged.

We have been collecting those interactions from our internal team and from the workshops we have run. That is now a lot of data.

So we are building an analysis library: normalize the data first, then support whatever analysis we want to do later.

That library is the demo project. Next slide.

Paper: arXiv:2607.02703.

## 09-llmoxie-context

Our demo project

The project: llmoxie-analysis

LLMoxie gives users access to multiple models through one API key and logs each request.

We have a year of logs from workshops and daily work to study how people use coding agents.

llmoxie-analysis normalizes the logs and groups them into sessions, then writes relational tables to Parquet.

Our fork includes the LLMoxie Data Pipeline issues. We'll work on the source adapter.

Gateway traces→Normalize→Sessions→Tables→Parquet

This demo builds on the LLMoxie overview from earlier in the convening.

## 10-menti-which-agent

Mentimeter

Which coding agent do you use most?

Pick your usual tool, or choose none yet. If you switched tomorrow, how much would you have to explain again?

## 11-grad-student-baseline

Before we change the repo

A new grad student's first task

Let's ask Sonnet 5 to help a new grad student on the original 2023 repo. We'll save the answer to compare later.

Live demo prompt

I'm a new grad student and I've been asked to work on the source-adapter issue.

Get me up to speed: what do I need to know about this project before I start?

Watch for what you'd still need to ask a maintainer before starting the issue.

## 12-menti-grade-before

Mentimeter

You are that grad student. How helpful was that answer?

Rate it from 1 to 5: could you start the issue with this answer? Remember your score. We'll ask again later.

## 13-journey

How we got here

How our repo changed as agents improved

We kept the setup that worked and added help where agents got stuck.

2023Environment setupWe copied code from chat. Pixi handled setup.

2024The Copilot eraWe gave agents a starting point: AGENTS.md.

2024RAGDocument search helped, but added a system to maintain.

2025Project memoryOKF kept linked project notes in the repo.

2025SkillsWe wrote repeatable workflows as skills.

2026EvalsWe began testing whether agents followed the skills.

## 14-env-problem

Section 1 of 5 · Agent environment · the problem

Setup can derail a simple task

For humans

You follow the setup steps, hit a dependency error, and spend the afternoon fixing your environment.

For agents

Sonnet ran pytest directly with pixi run pytest instead of the repo's pixi tasks. It kept trying different approaches instead of using the existing setup.

Live demo prompt

Add a hello-world module with a test, then run the test suite.

## 15-env-solution

Section 1 of 5 · Agent environment · what we added

✓ pixi, plus the dev container

The 2023 repo already had pixi and a dev container. That setup helps agents too, if they use it.

For contributors

pixi install sets up the project environment

Named tasks run the tests and required checks

The demo Codespace gives everyone the same starting setup

For agents

pixi run provides the commands the agent should use

The lockfile specifies the dependencies

Less time spent trying to repair the environment

## 16-entry-problem

Section 2 of 5 · Instruction entry point · the problem

It read the docs and still skipped the checklist

For humans

A contributor can read the guide and still miss a required check. Some expectations only come up in review.

For agents

The agent read README and pyproject, then listed generic rules. It wrote the module without a test and skipped pre-commit.

Live demo prompt

What are the non-negotiables in this repo? List them.

## 17-entry-solution

Section 2 of 5 · Instruction entry point · what we added

✓ AGENTS.md and on-demand rules

AGENTS.md puts six required rules up front and links to the details. CLAUDE.md and symlinks point other tools there.

For contributors

A short place to check what the project expects

Each rule says when it applies with a Load when line

Rules adapted from superpowers and Karpathy skills, with credit

For agents

Different agent tools can start from the same instructions

The agent reads detailed rules when the task needs them

Required checks and the repo's AI policy stay easy to find

## 18-memory-problem

Section 3 of 5 · Project memory · the problem

Who remembers why we did it this way?

For humans

The postdoc who knew the data leaves. You're left piecing together old discussions to find which decisions still apply.

For agents

Switch agent tools and past decisions may stay behind. RAG helped us search documents, but added another system to maintain.

Live demo prompt

What do you know about the headers in the LLMoxie spend logs?

## 19-memory-solution

Section 3 of 5 · Project memory · what we added

✓ The OKF knowledge bundle

OKF stores linked Markdown notes with YAML metadata alongside the code. The repo's verify command checks the bundle.

For contributors

The next contributor can find decisions and data caveats

Read the notes as files, without a separate database

A constraint records what a change must preserve

For agents

The instructions call for a search before answering project questions

Different models can consult the same project knowledge

Watch whether the agent finds and uses the relevant note

## 20-skills-problem

Section 4 of 5 · Agent skills · the problem

We keep explaining how to open a PR

For humans

A maintainer knows the commit format and PR checklist. A new contributor needs the steps, including checks and AI disclosure.

For agents

An agent may follow an earlier example, then skip a step on the next change. Repeating the instructions by hand gets old.

Live demo prompt

Commit this change.

Open a PR.

## 21-skills-solution

Section 4 of 5 · Agent skills · what we added

✓ Skills for recurring workflows

Each workflow gets a SKILL.md using the Agent Skills spec. Today we'll show commit and create-pr.

For contributors

The demo's commit skill adds its required Assisted-by: harness:model trailer

The PR checklist covers AI_POLICY.md, disclosure, and verification

Reviewers can see where AI helped with research software

For agents

The agent can load the workflow by name when it needs it

The steps spell out checks the agent might skip

We still need tests to see whether it follows those steps

## 22-evals-problem

Section 5 of 5 · Skill evals · the problem

How would we know if we just broke a skill?

For humans

A wording change can break a skill without any obvious error. We need a way to catch that before relying on it.

For agents

An agent may skip the skill, search the wrong files, or ignore a required step. We have to test its behavior.

We'll push the branch and watch the skill-evals workflow run.

Live demo prompt

What skills were evaluated using Inspect?

## 23-evals-solution

Section 5 of 5 · Skill evals · what we added

✓ Skill tests with Inspect and Harbor

Inspect checks responses. Harbor checks what the agent actually does.

For contributors

Inspect: 3–5 tasks with the skill loaded, including a tempting shortcut. Score must and must_not rules

Harbor: a sandbox with fake gh, pixi, okf, and git commands that log each call

CI checks changes to skills and evals

For agents

Results show which models follow the steps

A failed test tells us what to fix in the instructions

Our evals cover skills. We still need coverage for AGENTS.md and rules.

## 24-haf-table

The repo after the demo

What's now in the repo

Element | In the repo | For humans | For agents

✓Agent environment | pixi, dev container | A repeatable setup | Named commands to run

✓Instruction entry point | AGENTS.md, redirects | A short guide to expectations | A shared starting point

✓On-demand rules | rules/*.md, Load when | Detailed guidance for each task | Rules to load when needed

✓Project memory | OKF bundle | Past decisions you can look up | Project knowledge across tools

✓Agent skills | SKILL.md spec | Steps for recurring work | A workflow to follow

✓Skill evals | Inspect, Harbor, CI | Evidence that a skill still works | Feedback on missed steps

The next contributor can clone these files with the code. Let's see whether they help with the question we started with.

## 25-grad-student-again

The question we started with

Can the grad student get started now?

We'll ask the same question in a fresh Sonnet 5 session, now with the repo changes in place. Compare this answer with the first one.

Live demo prompt

I'm a new grad student and I've been asked to work on the source-adapter issue.

Get me up to speed: what do I need to know about this project before I start?

What can you do now that the first answer didn't help you do?

## 26-menti-grade-after

Mentimeter

Same grad student. How helpful was that answer?

Rate it from 1 to 5 again. We kept the task and model the same, and changed the repo. Did your score change?

## 27-models-matter

Our trial runs in Copilot in a Codespace

Models used the same repo differently

Model | Effort | What happened

Claude Sonnet 5 | 2 steps · 25 s | Searched the bundle and answered directly

Claude Haiku | 2 steps | Used the right tools and covered the same content in a simpler layout

Kimi K3 | 5 steps | Gave a useful answer quickly on slower hardware

GPT Terra | 7 steps | Fell back to regex over the files

GPT Luna | 10 steps · 1 m 44 s | Skipped pixi, wrote scripts, then read other chat sessions' storage

MAI Code 1.1 Flash | 5 steps · 54 s | Searched files until the prompt explicitly named OKF

Haiku covered the same content as Sonnet in this trial. That's worth testing on more tasks.

A cheaper model can cost you more time if you have to correct its work.

Draft with a capable model, then test with the models your contributors use.

Record what worked in the bundle. Define project terms, too: here, "headers" means spend-log columns.

## 28-future-directions

What we'd like to test next

What we still need to find out

A setup skillCould a skill help set up a new or existing repo, with a maintainer reviewing its work?

Models for research tasksWhich models and agent tools work well on real science tasks with this repo setup?

Scientific verificationWhat can a skill check about the science, and where would it need more tools?

Docs from project memoryCould the same notes power a docs site, with checks that keep it consistent?

Agents that update the notesCan agents record useful findings? What evals would catch bad additions?

Time spent on each taskWhat do LLMoxie traces tell us about where agents spend their effort?

This is a proof of concept. We need evidence from more research projects before we know how well it carries over.

## 29-start-monday

Back in your own repo

A starting point for Monday

Write a short AGENTS.md and provide one command that runs the required checks

Point your agent tools to that same file

Add skills for commit and create-pr

Put detailed rules in separate files that say when to read them

Record decisions and caveats the next contributor will need

Test whether agents follow the skills

You can stop after the first step and still have something useful. Keep the required checks as you add more.

## 29b-same-sheet-music

Why this works

Think of an orchestra. Every player reads the same score. During rehearsal they pencil notes into the margins, and those notes stay on the page for the next rehearsal and for whoever sits in that chair next.

That is what we set up today. AGENTS.md and the rules are the score. The knowledge bundle is the pencil marks: the decisions and the reasons behind them. Skills are the parts practiced until they are routine. Evals are the dress rehearsal before the concert: does the agent actually perform the part? Pixi gives everyone the same instruments and the same tuner: one environment, and tasks like pixi run test and pixi run verify that give the same answer no matter who runs them.

Nobody plays from memory. A new contributor and a coding agent open the same score and the same margin notes, so the orchestration is repeatable instead of depending on who is in the room.

## 30-thank-you

Thank you

Questions?

How do we help an agent work in an unfamiliar repo? How do we help a new contributor get started? Give both a place to find the rules and the reasons behind them.

github.com/uw-ssec/llmoxie-analysis

github.com/uw-ssec/rse-plugins

escience.washington.edu/software-engineering

UW Scientific Software Engineering Center

## 31-questions

Thank you

Questions?

github.com/uw-ssec/llmoxie-analysis

github.com/uw-ssec/rse-plugins

escience.washington.edu/software-engineering
