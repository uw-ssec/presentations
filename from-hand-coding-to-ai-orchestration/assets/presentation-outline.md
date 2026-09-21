# Presentation outline: from hand coding to agent orchestration

Working outline for Monday's session, built from the Sep 20 planning call with
Don and the three planning files in this folder. Where last night's call
changed the earlier plan, the call wins; the older plan's material is kept
where it still fits. Companion files: [`run-of-show.md`](run-of-show.md),
[`interaction-bank.md`](interaction-bank.md), [`prep-checklist.md`](prep-checklist.md).

## The two questions the whole session answers

1. How do we take a repo we are used to and make agents a first-class citizen?
2. How do we make it easy for a new contributor to onboard?

Thesis, said early and repeated at the close: everything that makes a repo
easy for a human makes it easy for an agent. It is the same practice in
different packaging. Docs become the knowledge base. Environment setup is
pixi. Testing and linting are consistency. Governance becomes AGENTS.md and
the AI policy.

What the audience should leave with (kept from the run of show):

- The harness layer is the same move as CI and lint config: practice that
  lived in people's heads, made executable, this time for a contributor who
  starts from zero context every session.
- They watched each piece do something during a real change.
- Instructions advise, gates enforce, evals test the instructions.
- A first step they can take on Monday.

## Format decisions from the call

- Informal, interactive, presenters drive. Audience can fork the demo repo and
  open a Codespace to follow along, or sit back. No helper skill for setup;
  the point is that they feel the friction, then feel it drop.
- Two repos: the HAF `llmoxie-analysis` repo (AGENTS.md, OKF bundle, skills,
  evals) and the stripped classical demo repo. AI policy references and commit
  history are scrubbed from the demo repo; recheck before the session.
- Build up live by having the agent copy each component from the HAF repo
  into the demo repo. Not pre-built branches, because agents find other
  branches in history. Not building from scratch, because it takes too long.
- One model live, Sonnet 5. Multi-model material goes in the lessons-learned
  segment, not the live build.
- Runs in a Codespace, not a personal laptop, so nobody's user-level agent
  config bleeds in. Dev container ships Copilot, Codex, and OpenCode.
- Prompts pre-written in a GitHub Discussion on the demo repo, copied at
  demo time.
- Mentimeter (Don's free account) for the two interactive slides only. Slides
  otherwise minimal; the rest is live coding and conversation. Clapper and
  Mentimeter Pro were considered and rejected for tomorrow.
- "Worst thing an agent did to your repo" moves to a backup slide.

## Run of show

### 1. Opening (Cordero, with Don)

- Both introduce themselves in one line each.
- Set expectations: informal, hands-on, two people sharing what they learned
  configuring and working with coding agents.
- Frame the two questions above. Cordero's line from the call: "If you walk
  away with nothing else, that should be your takeaway: what does it take for
  that to happen?"
- Tell them how to follow along: fork, Codespace, copy the issues over with
  your agent. Or just watch.
- Pray to the demo gods.

### 2. Context in one minute (Don)

- Anshul covered LLMoxie earlier in the week, so keep this to a sentence:
  traces from the LLMoxie AI gateway, and a package that normalizes, groups,
  and transforms them to Parquet.
- Point at the LLMoxie Data Pipeline epic and its sub-issues in the demo fork.

### 3. The gold-standard 2023 repo (Don)

- Walk the bare demo repo: `src/`, tests, pixi for the environment, docs,
  CI config, dev container. "If you looked at this in early 2023, this would
  be the gold standard."
- Pixi is already here. Don talks about why it matters: one manager, one
  lockfile, one command to a working environment. It is the first agent-ready
  component and it needs no building.

### 4. Word cloud (Don runs Mentimeter)

- Question: "What characteristics make OSS easy to contribute to?"
- Reveal the categories slide and map each to its agent equivalent:

| Human-friendly characteristic       | Agent equivalent                         |
| ----------------------------------- | ---------------------------------------- |
| Extensive documentation             | Knowledge base (OKF bundle)              |
| Easy environment setup              | Pixi                                     |
| Consistency, linting, pre-commit    | Verify gate, skills that call it         |
| Governance, contributing docs       | AGENTS.md, rules, AI policy, disclosure  |
| Benchmarking and test infrastructure| Skill evals in CI                        |
| Security, packaging, supply chain   | Pinned tools, one package manager        |

### 5. Why this matters for RSEs (Don)

- The postdoc-leaves problem. Institutional knowledge lives in someone's head
  or a Slack thread, and it walks out the door.
- An agent is a permanent day-one new hire. Every session starts with no
  memory. Worse: decisions made with an agent in one harness live only in
  that harness's memory, and they are gone when you switch tools.
- Maintainer burden: the cost of onboarding is paid again on every
  contributor, human or agent.

### 6. Which agent do you use? (Don runs Mentimeter)

- Question: "Which coding agent do you use the most?"
- Both presenters answer honestly (Don: Claude Code, moving toward OpenCode;
  Cordero: Claude Code daily, partial to Codex).
- Cordero's transition: if you switch harnesses or models, how does what you
  built with one carry over to the other? That is the case for knowledge that
  lives in the repo, not the tool.

### 7. Baseline on the bare repo (Don types)

- Prompt: "What are the non-negotiables in this repo? List them."
- Expect a generic answer assembled from CONTRIBUTING.md and pixi.toml. Name
  what it got and what it could not know.

### 8. Build it up, one component at a time (Don types, Cordero explains)

Each step: agent copies the component from the HAF repo, then the same or a
new prompt shows the difference. Order mirrors how it was actually built.

1. **AGENTS.md.** Re-run the non-negotiables prompt. Expected: pixi only,
   verify before claiming done, surgical changes, ask instead of assuming,
   contribution discipline before a PR, disclose AI assistance. Line: "Same
   prompt, same model, different answer." Mention it is short on purpose:
   six non-negotiables, a rule index, pointers to skills and memory, and
   every harness reads it (`CLAUDE.md` is one line, the rest are symlinks).
2. **Knowledge base (OKF bundle).** Prompt: "What do you know about the
   headers in the LLMoxie spend logs?" Success signal: the moment it says
   "bundle" or cites a concept id. Show the concept it found, the folder
   layout (project, platform, upstream, caveats, pipeline, datasets), and
   that data caveats and decisions are exactly the knowledge that leaves
   with people. Mention it is versioned with the code and validated in the
   verify gate.
3. **Skills.** Copy, then restart the agent session so they load. Show the
   commit skill and the `Assisted-by` trailer, and the AI policy and PR
   template disclosure sections. Provenance is a research-integrity point,
   not etiquette.
4. **Evals.** Cordero explains: Inspect checks that with the skill in
   context the model answers as the skill says; Harbor checks that a
   sandboxed agent acts on it. CI runs them when skills or evals change.
   Prompt that worked: "What skills were evaluated using Inspect?" Optional:
   push a branch and show the skill-evals workflow run.

Line to say somewhere in here: instructions advise, gates enforce, evals test
the instructions.

### 9. Spec-driven work on a real sub-issue (Don types)

- Pick the source-adapter thin normalization layer issue. It needs data
  knowledge that only the bundle holds, which is why it was chosen.
- Run the superpowers brainstorm skill to a spec and implementation plan.
  Stop there. "We don't have to implement it. If you want to, run it
  yourself after."
- Before its first edit the agent should hit the knowledge gate: a
  `constraint` hit from the caveat concepts. Point at it.

### 10. The payoff: onboard me (Cordero types, fresh session)

- Prompt: "I need your help. I'm thinking about working on a new feature,
  but I need to get onboarded into this project. Give me a breakdown of the
  things I need to know before I get started."
- Tie the answer back to both questions. This is what a new contributor,
  human or agent, gets on day one.

### 11. Lessons learned: not every model is created equal (Cordero, Don shows)

Same prompt, same AGENTS.md, same bundle, in Copilot inside a Codespace. Don
kept a Codespace per model, renamed, and has the screenshot.

| Model                        | What happened                                                                 |
| ---------------------------- | ----------------------------------------------------------------------------- |
| Sonnet 5                     | Two steps, targeted bundle search, clean answer                               |
| Haiku                        | Followed the instructions, used the right tools, same content quality         |
| Kimi K3                      | Five steps, quick, acceptable                                                 |
| GPT Terra                    | Seven steps, fell back to regex                                               |
| GPT Luna                     | Ignored pixi, re-checked itself repeatedly, then read other chat sessions' storage to find a prior answer. Caught cheating. |
| My Code 1.1 Flash (default)  | Never called the bundle unless the prompt said "OKF"; grepped files instead   |
| Qwen 3.8 local (4-bit)       | Did consult memory, but one keyword at a time, then wandered into unrelated files |

Points to draw out:

- A well-structured repo brings a smaller model close to a frontier model on
  content. The layout of the answer differs; the substance does not.
- You would not hire any engineer off the street; the same is true of models.
  Weigh token cost against your time.
- Use the best model you can to write the skills and seed the bundle, then
  test with the models your contributors will actually use.
- Record model and harness recommendations, and vocabulary, in the bundle.
  Example: "header" in LLMoxie context means the spend-log columns. Left out
  on purpose for tomorrow, as a teaching moment about why models matter.
- Whetstone, briefly: Cordero's experimental tool that looks across skills for
  overlap and ambiguous triggers, where Inspect and Harbor look at one skill
  at a time. Last night it found that AGENTS.md only sent agents to memory
  before edits, never before answering, fixed both the file and the skill,
  and the failing question then passed. That is the seed of agents improving
  their own harness, with evals as the safety net.

### 12. Close

- Restate the two questions and the thesis.
- Adoption ladder, each rung useful on its own: a short AGENTS.md plus a
  one-command verify; redirects so every harness reads it; two skills
  (commit and create-pr); on-demand rules; project memory; evals.
- Say honestly what does not always work, and that this is why the hard
  gates and evals exist.
- Open conversation. Keep it informal; the goal is that the room leaves
  wanting to work with us.

### Backup slide

- "In one line, what is the worst thing a coding agent has done in your
  repo?" Presenters' own examples: an agent contradicting a documented
  decision because it was narrowly focused; a schema change without updating
  the upstream API.

## Skeptic questions to plant for the off-mic presenter

- Why not put all of this in the README? (README is for browsing; rules are
  indexed, loaded on demand, and tested.)
- Isn't this just documentation? Why a separate bundle? (Frontmatter that
  gates edits, validation in the gate, and it survives reformatting only
  because it is excluded from Prettier.)
- What stops the agent from ignoring a skill? (Nothing, by itself. Gates
  enforce; evals catch drift.)
- Isn't this a lot of machinery for a prompt file? (Instructions are code.)
- Most of this repo is agent material. Is the overhead worth it? (It is a
  template that amortizes across projects, and most of it doubles as human
  onboarding.)

## Fallbacks

- If a live prompt misbehaves, that is a point about probabilistic
  instructions, not a failed demo. Say so.
- Recording of the bare-repo answer and of the onboarding answer, in case the
  Codespace or model is slow.
- If Mentimeter fails, take the two questions by chat.

## Still to do before Monday

| Item                                                                     | Owner   |
| ------------------------------------------------------------------------ | ------- |
| Pull latest into the demo Codespace; confirm memory triggers on questions | Cordero |
| Recheck the demo repo is fully scrubbed after the force push             | Cordero |
| Write every prompt above into a GitHub Discussion on the demo repo       | Both    |
| Mentimeter: word cloud, agent poll, categories slide, QR code            | Don     |
| Rename and keep the per-model Codespaces; do not delete                  | Don     |
| Decide who explains evals (Cordero offered to walk it)                   | Both    |
| Hook the LLMoxie gateway into the Codespace before Thursday's follow-up  | Don     |
| Add Whetstone to the BitBarrel dev plugins (after the session)           | Cordero |
