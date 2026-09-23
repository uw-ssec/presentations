---
type: Decision
title: "The LLMoxie slide is background that leads into the demo project, not a platform tour"
description: "The slide before the llmoxie-analysis demo introduction shows the LLMoxie architecture diagram but frames it as where the demo data comes from (collect through the gateway, accumulate from the team and workshops, analyze with a new library), so the audience arrives at the demo knowing why the data exists."
tags: [uw-slides, narrative, llmoxie, demo]
generated: { by: "claude-code:claude-fable-5-1", at: "2026-09-23T02:44:53Z" }
status: stable
governance: constraint
code_refs: [from-hand-coding-to-ai-orchestration/content/08b-llmoxie-platform.html, from-hand-coding-to-ai-orchestration/content/09-llmoxie-context.html]
---

## Decision

`content/08b-llmoxie-platform.html` sits between the Harness Augmentation Framework slide and "What llmoxie-analysis does". It carries the three-tier LLMoxie architecture diagram (`assets/llmoxie-architecture.png`, sourced to arXiv:2607.02703) and three steps: **Collect** (every request through the AI gateway is logged), **Accumulate** (traces from the team and the workshops it runs), **Analyze** (a library to normalize the data and support future analysis). The hand-off line says that library is the demo project.

## Rejected framing

A first version described the platform's three layers (inference, control plane, application) as the slide's content. The project owner asked for the data-collection story instead, because the slide's job is to motivate the demo, and the layers are visible in the diagram already.

## Related slide

The earlier Mentimeter cue slide asks which coding agent people use; the demo slides then work on the source adapter of llmoxie-analysis. Keep the LLMoxie slide short: it is a bridge, not a section.

## Related Concepts

- [Insert slides with suffixed names and keep order in SLIDES.md; displayed numbers drift from file numbers](slide-order-and-insertions.md): The LLMoxie slide is the first suffix-named insertion (08b); its file number and displayed number differ.
