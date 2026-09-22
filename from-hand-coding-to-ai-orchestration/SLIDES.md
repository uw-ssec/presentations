# From Hand Coding to AI Orchestration

CrossVISS 2026 session by Don Setiawan and Cordero Core, UW Scientific Software
Engineering Center. 80 minutes: about 60 of content and live demo, the rest for
questions. Audience: about 25 research software engineers and the Schmidt
Sciences VISS leadership, hybrid.

Two questions the session answers, stated at the start and again at the close:

1. How can a coding agent work in a repo it doesn't know?
2. How can a new contributor get started without us beside them?

Thesis: people and agents both need help finding the rules and understanding
past decisions. Keep that guidance in the repository so it travels with the code.

## How to render this deck (instructions for the slide generator)

Brand: `ssec` (`.agents/uw-slides/design-systems/ssec-brand/DESIGN.md`).
Fragments live in `content/`, one `<section>` per heading below, built by
`./build.sh` into `build/index.html`. This is a plain HTML deck, not Reveal.js.

Deck-specific conventions:

- Every section carries `data-presenter="don" | "cordero" | "both"`; the footer
  shows a colored badge for whoever is speaking (teal Don, gold Cordero).
- The footer also shows a running timer that starts when the deck leaves slide 1.
  `t` pauses and resumes, `r` resets. It turns gold at 50 minutes, pink at 60.
- The six-step progress strip appears on every section slide so the audience
  always knows where they are (feedback from the dry run).
- Each of the five framework sections has exactly two slides: (A) the human and
  agent problem, an illustration, and the prompt we will type, verbatim; (B) the
  Harness Augmentation Framework element we added and how it serves humans and
  agents. The presenter checks the section off on slide B.
- Slides marked "Mentimeter" are cue slides. The live poll runs in Mentimeter;
  the cue slide shows the question so the recording and the room stay oriented.
- Illustrations are generated with Codex (`assets/images/*.png`). Source images
  from the Mentimeter deck are in `assets/`.

## 01-title

Dark title slide. "From Hand Coding to AI Orchestration". Presenters, center,
event. Hero illustration: hands typing become a conductor's baton.

## 02-join-mentimeter

Join slide: QR code (cropped from the Mentimeter deck), "Scan to join".
Note aloud: informal, hands-on, fork the demo repo and open a Codespace if you
want to follow along, or sit back.

## 03-roadmap

"Getting started in an unfamiliar repo." State the two questions and introduce
the six stops and progress strip. Ask the audience to judge the answer before
and after the repo changes. Keep the grad-student prompt identical both times.

## 04-menti-characteristics

Mentimeter cue: "What characteristics make OSS easy to contribute to?" Word cloud.

## 05-characteristics

The seven characteristics Don calls out, with the pyOpenSci package lifecycle
image. Don's segment: this was the gold standard in 2023.

## 06-same-practice

Thesis slide: table mapping each human-friendly characteristic to its agent
equivalent. Agents need this context too.

## 07-agent-model-harness

"Agent = Model + Harness" with the Addy Osmani board illustration. Explain the
model and the software around it in plain language. Keep the source line.

## 08-haf

The Harness Augmentation Framework graphic (the anchor visual, per Anant's
feedback) with the six components listed. This is the repo layout the rest of
the session builds up.

## 09-llmoxie-context

One-minute context slide for LLMoxie analysis: traces from the gateway, a
package that normalizes, groups into sessions, transforms, writes Parquet. The
demo repo is a fork with the LLMoxie Data Pipeline epic copied in. Marked as a
placeholder to swap for the shared LLMoxie overview slide.

## 10-menti-which-agent

Mentimeter cue: "Which coding agent do you use most?" Both presenters answer.

## 11-grad-student-baseline

The baseline prompt on the bare repo, verbatim, in a prompt card. Run it live
in Sonnet 5, keep the session. Illustration: the new grad student facing the
repository.

## 12-menti-grade-before

Mentimeter cue: "You are that grad student. How helpful was that answer?"
Rating 1 to 5. Before-grade.

## 13-journey

Section divider: the chronological journey 2023 to now, as a timeline:
environment setup, the Copilot era and AGENTS.md, RAG, project memory (OKF),
skills, evals. Keep the setup that worked and add help where agents got stuck.

## 14-env-problem

Section 1 of 5, Agent environment. Problem: 2023 was copy-paste from a chat
window; every machine different; agents trained on pip revert to pip even when
pixi is configured and burn tokens cycling. Prompt: add a hello-world module
with a test and run the tests.

## 15-env-solution

Added: pixi (plus the dev container). The 2023 repo already had this
setup. Explain the shared environment, locked dependencies, and named tasks
that contributors and agents can use. Check.

## 16-entry-problem

Section 2, Instruction entry point. Problem: the agent reads README,
pyproject, CONTRIBUTING and still does not run pre-commit or write a test; it
has to reconstruct the conventions every session. Prompt: what are the
non-negotiables in this repo?

## 17-entry-solution

Added: AGENTS.md, short by design, with six non-negotiables; CLAUDE.md is one
line and the other entry points are symlinks; on-demand rules with "Load when"
lines so context is spent only when relevant. Repeat the prompt and look for the required rules. Check.

## 18-memory-problem

Section 3, Project memory. Problem: the postdoc leaves and the knowledge walks
out; decisions made with an agent live in that harness's memory and vanish on
switch; RAG tears documents apart to put them back together. Prompt: what do
you know about the headers in the LLMoxie spend logs?

## 19-memory-solution

Added: the OKF bundle, a document-based knowledge graph in markdown with YAML
frontmatter, versioned with the code, validated in the verify gate, readable by
any harness and by people. Watch whether the agent finds and uses the relevant note. Consult the bundle
before answering project questions. Check.

## 20-skills-problem

Section 4, Agent skills. Problem: the habits a maintainer does without thinking
(conventional commit, AI disclosure trailer, PR template, verify first) have to
be re-explained every session and there is no guarantee they stick. Prompt:
commit this change; then open a PR.

## 21-skills-solution

Added: skills following the Agent Skills spec, one SKILL.md per workflow;
commit and create-pr carry the Assisted-by trailer, the AI policy, and the PR
template's disclosure and verification sections. Provenance is a
research-integrity point. Only the spec, no MCPs or plugins today. Check.

## 22-evals-problem

Section 5, Skill evals. Problem: skills do not always trigger, some models go
off the rails, and an edit to a skill can silently break it. Driver's license
illustration. Prompt: what skills were evaluated using Inspect? Then push a
branch and watch the skill-evals workflow.

## 23-evals-solution

Added: Inspect as the written test (three to five tasks, one temptation,
must and must-not rules) and Harbor as the road test (sandboxed agent with
fake gh, pixi, okf, git), run by CI when skills or evals change. Inspect checks responses and Harbor checks actions. Preserve the limit: these
evals cover skills, with AGENTS.md and rule coverage still to add. Check.

## 24-haf-table

The framework in one table: element, what it does for humans, what it does
for agents. All six rows checked.

## 25-grad-student-again

The same prompt, verbatim, in a fresh session on the built-up repo. Compare
with the baseline answer.

## 26-menti-grade-after

Mentimeter cue: same grading question. After-grade.

## 27-models-matter

Lessons learned: same prompt, same AGENTS.md, same bundle, different models.
Table of what each did. Treat the results as observations from these trial runs, not a general model
ranking. Haiku covered the same content as Sonnet in this trial. Include the
time spent correcting errors when weighing cost. Test with the models
contributors use and record useful findings and vocabulary in the bundle.

## 28-future-directions

Open questions for the proof of concept: setup help for new and existing repos,
models for research tasks, scientific verification, docs from project memory,
agents updating notes, and time spent on each task. Frame these as work to test
across more research projects.

## 29-start-monday

Adoption ladder, six rungs, each useful on its own.

## 30-thank-you

Closing: connect both opening questions to a shared answer: give people and
agents a place to find the rules and the reasons behind them. Links. Questions.

## 31-backup-horror-stories

Backup Mentimeter cue: "In one line, the worst thing a coding agent has done
in your repo?" Use only if time allows.
