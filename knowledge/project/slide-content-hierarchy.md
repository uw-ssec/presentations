---
type: Decision
title: "How an agent builds a slide: audience, narrative, then the sourcing cascade"
description: "Slide authoring starts with who the audience is and what narrative and vocabulary reach them, then runs a sourcing cascade asking at each tier whether a video, visual or interactive element, table, or finally concise text could be found, clipped, or generated to carry the point - with agents expected to build such elements, and to leave a static frame behind because the Zenodo artifact is a PDF."
tags: [slides, content, design, pedagogy, visuals, authoring]
generated: { by: "claude-code:claude-opus-5", at: "2026-09-22T04:20:04Z" }
status: stable
governance: constraint
code_refs: ["*/SLIDES.md", "*/VISUALS.md", "*/content/**", security-in-age-of-ai/index.html, .agents/skills/new-deck/SKILL.md, .claude/skills/new-deck/SKILL.md, .agents/skills/apply-visuals/SKILL.md, .claude/skills/apply-visuals/SKILL.md]
sources:
  - resource: .agents/uw-slides/templates/VISUALS.md
---

# How an agent builds a slide

Two framing questions, then a sourcing cascade. Answer them in order; do not
start by writing slide text.

## 1. Who is the audience?

Decide this before any content exists. It sets the vocabulary ceiling.

- What do they already know, and what will they hear as jargon?
- Which terms must be defined on first use, and which would be condescending
  to define?
- What do they care about - what makes this worth their hour?

Jargon is not a fixed list; it is relative to the room. The same word is
precision for one audience and a wall for another. When a term is load-bearing
but unfamiliar, that is often itself a slide.

## 2. How does the material tell a narrative accessible to them?

A deck is an argument with an order, not a collection of facts. Before
choosing media, know what each slide is *for*: what the audience believes
before it and what they should believe after. A slide that does not move the
narrative should be cut, not decorated.

## 3. The sourcing cascade

For each slide, ask these in order and stop at the first yes. Each is an
*active* question - what could be found, clipped, or generated - not an
inventory of what happens to be on hand.

1. **Video.** Is there an existing video, on YouTube or another platform, that
   I could clip to demonstrate this point? If not, is there a video I could
   **generate** for it?
2. **Visual.** Is there an image, graph, chart, **interactive widget or
   element** I can access locally, find on the web, or **generate** that
   demonstrates this point?
3. **Table.** Is there a table I have access to, or could generate, that
   demonstrates this point?
4. **Text.** Is there concise text that demonstrates this point?

Drop a tier only when the tier above genuinely cannot carry the idea - not
when it would take more effort. "Faster to write" is not a reason.

### Use the fact that you are an agent

This cascade assumes a capability that did not used to exist. An AI agent can
**build** the artifact, not merely go looking for one: a small interactive
widget, a simulation the audience can watch run, a generated diagram, an
animated sequence, a chart drawn from real numbers. Elements that were
previously impractical for a talk are now a few minutes of work.

Treat generation as a first-class answer at every tier. The interesting
question is rarely "does an asset exist?" but "what is the clearest thing I
could make?" An interactive element that lets the audience watch a process
unfold serves the same purpose tier 1 does - showing change directly rather
than asking them to infer it - so reach for one whenever the concept has
moving parts.

## The tier order, and why

| Tier | Medium | Use when |
|---|---|---|
| **1** | Animation or video **illustrating the concept** | The idea involves change, process, causality, or sequence |
| **2** | Images, graphs, charts, analytics, interactive elements | The idea is a quantity, relationship, comparison, structure, or arrangement |
| **3** | Tables and similar structured elements | Genuine multi-dimensional lookup: several items across several attributes |
| **4** | Text | **Last resort.** Nothing above can carry it |

The tier-1 qualifier matters: motion must *illustrate the concept*. Decorative
motion, slide transitions, and ambient stock video are not tier 1 - they are
tier 4 wearing a costume, and worse than the text they replaced because they
also cost attention.

The ranking follows how an audience at a live talk encodes information:

- **Two channels, not one.** Verbal and visual working memory are separate. A
  slide pairing the speaker's words with a visual uses both; a slide of text
  forces everything through the verbal channel twice.
- **Reading competes with listening.** The core failure of a text wall: faced
  with prose, an audience reads - and while reading, is not hearing the
  speaker. The slide suppresses the presenter.
- **Dynamic content wants a dynamic medium.** Animation shows a transformation
  directly instead of asking viewers to hold two states in memory and diff
  them.
- **Tables sit where they do deliberately.** Structured beats prose, but a
  table is still read serially and still competes with the speaker. A table
  holding two bullet points is a text wall with borders.

Inferred framing, not a measured result for these decks: an application of
standard multimedia-learning principles (dual coding, the multimedia and
redundancy effects). Honest caveat on tier 1 - animation's advantage is
strongest for inherently temporal or causal content and is not automatically
better than a well-chosen still for a static relationship. Between tiers 1 and
2, match the *shape of the idea*, not the flashier medium. What would confirm
the ordering for our audiences: post-talk recall or comprehension feedback,
which we do not collect.

## Text as a scalpel

Tier 4 is legitimate when reached honestly; a deck with no text is not the
goal. The rule is about *how* text is used.

- Only when no tier 1-3 option is available for that idea.
- **Concise and incredibly meaningful** - every word load-bearing. A phrase
  the speaker expands on, not a paragraph the speaker reads aloud.
- Shortest surviving form: a title over a sentence, a sentence over a list, a
  short list over a paragraph. Never a paragraph.
- If deleting it costs the audience nothing, delete it. If it could be spoken
  instead of shown, speak it.

## Two constraints this repository imposes

Neither overrides the cascade; both shape how a tier-1 or tier-2 slide is
built here.

**The archived artifact is a static PDF.** Decks render through
`decktape` and deposit on Zenodo, where records are permanent. Video, motion,
and interactivity do not survive that export - an interactive slide becomes a
blank or broken frame in the deposited record. So build the rich element for
the live talk **and** give the slide a static frame that carries the same
point on its own: a representative still, a final-state screenshot, a summary
chart. Check the rendered PDF, not just the browser. See
[[pipeline/fragment-decks-outside-pdf-workflow]].

**Third-party media must be licensed for it.** Clipping someone's YouTube
video into a deck that receives a permanent public DOI is a redistribution,
not a citation. Prefer material that is owned, Creative Commons, or clearly
licensed for reuse; prefer generating the asset; and when a clip is genuinely
irreplaceable, link to the source rather than embedding it, and attribute it
on the slide.

## When to choose the tier

During the **first** pass, while planning in SLIDES.md. The tier is a decision
about what the slide *is*, not a decoration applied later. Treating pass 2
(/apply-visuals, VISUALS.md) as where visuals get considered produces tier-4
slides with images attached, which is not a tier-2 slide.

### Reconciling with the VISUALS.md template

The vendored VISUALS.md template states "Typography remains primary" and calls
visual elements "accents, not focal elements." That is **scoped to the deck's
diagrammatic accents and icons** - small gold line-art marks - and governs
*their* scale. It is not a claim that text outranks imagery and does not
override this cascade. Accents stay subordinate; the slide's primary content
carrier is still chosen by tier.

# Related Concepts
- [New Decks Default to uw-slides HTML, Not Reveal.js](deck-format-default.md): The tier choice is made during the SLIDES.md planning pass of the two-pass fragment deck workflow this concept defines.
- [SSEC is the default slide brand, adapted from the website design system](../branding/ssec-slide-brand.md): Brand sets how a slide looks; the content hierarchy sets what carries its idea. A tier-2 chart still uses the ssec tokens and 24px type floor.
- [Fragment-based uw-slides decks are not covered by the PDF and Zenodo workflow](../pipeline/fragment-decks-outside-pdf-workflow.md): Rich tier-1 and tier-2 elements do not survive the decktape PDF export this concept governs, so every such slide needs a static fallback frame for the Zenodo deposit.
