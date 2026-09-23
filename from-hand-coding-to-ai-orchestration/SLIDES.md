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
- Each framework section keeps its problem/demo and solution pair. Live prompts
  stay verbatim. Primary visuals show the actual steps or relationships, with
  detailed explanation in `NOTES.md`. The solution advances the progress strip.
- Slides marked "Mentimeter" are cue slides. The live poll runs in Mentimeter;
  the cue slide shows the question so the recording and the room stay oriented.
- Illustrations are generated with Codex (`assets/images/*.png`). Source images
  from the Mentimeter deck are in `assets/`.

## 01-title

**Primary carrier: tier 2.** Keep the existing title artwork and event identification. This is orientation, not a procedural claim.

Dark title slide. "From Hand Coding to AI Orchestration". Presenters, center,
event. Hero illustration: hands typing become a conductor's baton.

## 02-join-mentimeter

**Primary carrier: tier 2.** The QR code is the action. Spoken setup instructions move to NOTES.md.

Join slide: menti.com, the code 4985 6011, and the Mentimeter QR code.
Note aloud: informal, hands-on, fork the demo repo and open a Codespace if you
want to follow along, or sit back.

## 03-roadmap

**Primary carrier: tier 1.** A presenter-stepped before/build/after sequence shows the experiment. No external video can show this unrun live comparison. All steps remain as the static frame.

"Getting started in an unfamiliar repo." State the two questions and introduce
the six stops and progress strip. Ask the audience to judge the answer before
and after the repo changes. Keep the grad-student prompt identical both times.

## 04-menti-characteristics

**Primary carrier: tier 4.** The live poll supplies interaction. The prompt must be read verbatim; illustration or a table cannot ask the question more clearly.

Mentimeter cue: "What characteristics make OSS easy to contribute to?" Word cloud.

## 05-characteristics

**Primary carrier: tier 2.** The existing package-lifecycle diagram carries the relationships. It is a structure, so motion adds no information. Seven short labels preserve the original coverage.

The seven characteristics Don calls out, with the pyOpenSci package lifecycle
image. Don's segment: this was the gold standard in 2023.

## 06-same-practice

**Primary carrier: tier 2.** A shared-source diagram replaces the two-column mapping table. The claim is a relationship, not a time sequence.

Shared-source diagram: a contributor and an agent consult the same repo context.

## 07-agent-model-harness

**Primary carrier: tier 2.** The existing board diagram directly depicts the parts and their relationship. Two labels define the terms.

"Agent = Model + Harness" with the Addy Osmani board illustration. Explain the
model and the software around it in plain language. Keep the source line.

## 08-haf

**Primary carrier: tier 2.** Keep the framework anchor graphic and pair it with a file-tree structure. This is a static architecture, so no video is needed.

The Harness Augmentation Framework graphic (the anchor visual, per Anant's
feedback) with the six components listed. This is the repo layout the rest of
the session builds up.

## 08b-llmoxie-platform

**Primary carrier: tier 2.** The LLMoxie architecture diagram shows the gateway the data flows through. It is a structure, so no motion is needed. Three short steps carry the story; one line hands off to the demo project.

Background that leads into slide 09: we have been collecting human and AI
interactions through the LLMoxie AI gateway (arXiv:2607.02703). We now have a
lot of data from the internal team and the workshops we have run, and we are
building an analysis library to normalize it and support future analysis.
Don's segment.

## 09-llmoxie-context

**Primary carrier: tier 1.** A stepped data-flow diagram demonstrates transformation. This is a schematic, not recorded output; every stage stays visible for print.

One-minute context slide for LLMoxie analysis: traces from the gateway, a
package that normalizes, groups into sessions, transforms, writes Parquet. The
demo repo is a fork with the LLMoxie Data Pipeline epic copied in. Marked as a
placeholder to swap for the shared LLMoxie overview slide.

## 10-menti-which-agent

**Primary carrier: tier 4.** The live poll supplies interaction. The prompt must be read verbatim; illustration or a table cannot ask the question more clearly.

Mentimeter cue: "Which coding agent do you use most?" Both presenters answer.

## 11-grad-student-baseline

**Primary carrier: tier 1.** The live agent run carries the evidence. The verbatim prompt and before/after label are the static cue; the actual answer is judged live.

The baseline prompt on the bare repo, verbatim, in a prompt card. Run it live
in Sonnet 5, keep the session. Illustration: the new grad student facing the
repository.

## 12-menti-grade-before

**Primary carrier: tier 4.** The live poll supplies interaction. The prompt must be read verbatim; illustration or a table cannot ask the question more clearly.

Mentimeter cue: "You are that grad student. How helpful was that answer?"
Rating 1 to 5. Before-grade.

## 13-journey

**Primary carrier: tier 2.** A dated timeline shows the chronology at once. The following paired slides supply the change over time, so animation here would duplicate that work.

Section divider: the chronological journey 2023 to now, as a timeline:
environment setup, the Copilot era and AGENTS.md, RAG, project memory (OKF),
skills, evals. Keep the setup that worked and add help where agents got stuck.

## 14-env-problem

**Primary carrier: tier 1.** The live hello-world task demonstrates the failure. This static mismatch diagram makes the observed wrong command legible without inventing terminal output.

Section 1 of 5, Agent environment. Problem: 2023 was copy-paste from a chat
window; every machine different; agents trained on pip revert to pip even when
pixi is configured and burn tokens cycling. Prompt: add a hello-world module
with a test and run the tests.

## 15-env-solution

**Primary carrier: tier 1.** Step through the real command sequence, without simulated success logs. The complete command sequence is the static fallback.

Added: pixi (plus the dev container). The 2023 repo already had this
setup. Explain the shared environment, locked dependencies, and named tasks
that contributors and agents can use. Check.

## 16-entry-problem

**Primary carrier: tier 1.** The live prompt carries the demonstration. A static causal sequence records the observed skipped checks; a generic stock clip would not demonstrate this repo behavior.

Section 2, Instruction entry point. Problem: the agent reads README,
pyproject, CONTRIBUTING and still does not run pre-commit or write a test; it
has to reconstruct the conventions every session. Prompt: what are the
non-negotiables in this repo?

## 17-entry-solution

**Primary carrier: tier 2.** A converging and branching diagram shows redirects and on-demand rules. The relationship is spatial, so a still is clearer than a clip.

Added: AGENTS.md, short by design, with six non-negotiables; CLAUDE.md is one
line and the other entry points are symlinks; on-demand rules with "Load when"
lines so context is spent only when relevant. Repeat the prompt and look for the required rules. Check.

## 18-memory-problem

**Primary carrier: tier 1.** The live question tests access to past decisions. The static paired causes frame why context gets lost, without claiming a fabricated trace.

Section 3, Project memory. Problem: the postdoc leaves and the knowledge walks
out; decisions made with an agent live in that harness's memory and vanish on
switch; RAG tears documents apart to put them back together. Prompt: what do
you know about the headers in the LLMoxie spend logs?

## 19-memory-solution

**Primary carrier: tier 2.** A shared knowledge hub replaces the prose and decorative memory image. All readers consult the same three kinds of notes.

Added: the OKF bundle, a document-based knowledge graph in markdown with YAML
frontmatter, versioned with the code, validated in the verify gate, readable by
any harness and by people. Watch whether the agent finds and uses the relevant note. Consult the bundle
before answering project questions. Check.

## 20-skills-problem

**Primary carrier: tier 1.** The live commit/PR demonstration is the first-tier carrier. The checklist sequence is the static fallback; fuller policy details stay in notes.

Section 4, Agent skills. Problem: the habits a maintainer does without thinking
(conventional commit, AI disclosure trailer, PR template, verify first) have to
be re-explained every session and there is no guarantee they stick. Prompt:
commit this change; then open a PR.

## 21-skills-solution

**Primary carrier: tier 1.** An interactive workflow shows how a skill supplies omitted steps. The live demo provides evidence, not invented output. The overview prints all steps.

Added: skills following the Agent Skills spec, one SKILL.md per workflow;
commit and create-pr carry the Assisted-by trailer, the AI policy, and the PR
template's disclosure and verification sections. Provenance is a
research-integrity point. Only the spec, no MCPs or plugins today. Check.

## 22-evals-problem

**Primary carrier: tier 1.** The live workflow run supplies the actual outcome. A change-and-question diagram creates the need for evals without claiming a fake pass or failure.

Section 5, Skill evals. Problem: skills do not always trigger, some models go
off the rails, and an edit to a skill can silently break it. Driver's license
illustration. Prompt: what skills were evaluated using Inspect? Then push a
branch and watch the skill-evals workflow.

## 23-evals-solution

**Primary carrier: tier 2.** Two short flow diagrams distinguish response checks from action checks. Actual execution is already live on the preceding slide; no invented results are shown.

Added: Inspect as the written test (three to five tasks, one temptation,
must and must-not rules) and Harbor as the road test (sandboxed agent with
fake gh, pixi, okf, git), run by CI when skills or evals change. Inspect checks responses and Harbor checks actions. Preserve the limit: these
evals cover skills, with AGENTS.md and rule coverage still to add. Check.

## 24-haf-table

**Primary carrier: tier 2.** An explorable repository map replaces the dense four-column table. Each file has one purpose. The complete map is visible in static export.

An interactive repo map: six files or folders, each with one purpose. All six
remain visible in the static frame.

## 25-grad-student-again

**Primary carrier: tier 1.** The live agent run carries the evidence. The verbatim prompt and before/after label are the static cue; the actual answer is judged live.

The same prompt, verbatim, in a fresh session on the built-up repo. Compare
with the baseline answer.

## 26-menti-grade-after

**Primary carrier: tier 4.** The live poll supplies interaction. The prompt must be read verbatim; illustration or a table cannot ask the question more clearly.

Mentimeter cue: same grading question. After-grade.

## 27-models-matter

**Primary carrier: tier 2.** A horizontal chart shows recorded step counts. Video cannot improve this comparison. Behavior labels prevent treating step count as quality; full reported times and caveats stay in NOTES.md.

Lessons learned: same prompt, same AGENTS.md, same bundle, different models.
Chart of recorded steps with brief behavior labels. Full trial observations
and recorded times remain in `NOTES.md`. Treat the results as observations from these trial runs, not a general model
ranking. Haiku covered the same content as Sonnet in this trial. Include the
time spent correcting errors when weighing cost. Test with the models
contributors use and record useful findings and vocabulary in the bundle.

## 28-future-directions

**Primary carrier: tier 2.** A research map locates six proposed investigations around the repo. These are future questions, so a video would imply evidence we do not have.

Open questions for the proof of concept: setup help for new and existing repos,
models for research tasks, scientific verification, docs from project memory,
agents updating notes, and time spent on each task. Frame these as work to test
across more research projects.

## 29-start-monday

**Primary carrier: tier 1.** A presenter-stepped adoption staircase shows order while keeping every useful stopping point visible. The static staircase preserves the sequence.

Adoption ladder, six rungs, each useful on its own.

## 29b-same-sheet-music

**Primary carrier: tier 2.** A native HTML mapping pairs each orchestra element with the repo part it corresponds to. The claim is a correspondence, so a table-like diagram carries it; no motion is needed.

Closing narrative: the pieces we demoed are the shared sheet music. Everyone,
human or agent, plays from the same score (AGENTS.md, rules), with the notes
scribbled during practice (knowledge) written on it rather than held in one
person's head. Parts are rehearsed (skills), the ensemble is tuned before the
concert (evals), and the instruments match (pixi). Nobody plays from memory,
which is what makes agent orchestration repeatable.

## 30-thank-you

**Primary carrier: tier 2.** Return to the shared-source visual from slide 6. The repeated structure closes the argument; links remain as sources.

Closing: connect both opening questions to a shared answer: give people and
agents a place to find the rules and the reasons behind them. Links. Questions.

## 31-questions

**Primary carrier: tier 4.** A plain final slide: thanks, the question prompt, and the links. Text is the right carrier for a closing prompt. A looping video of the uwssec.org partner logo bar sits under the prompt, on a light gold-50 slide that matches the video's background.

Last slide: thank you, questions, partner logos, links.
