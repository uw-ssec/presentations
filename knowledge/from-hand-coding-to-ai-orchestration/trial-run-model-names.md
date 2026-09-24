---
type: Fact
title: Trial-run model names on the models-matter chart
description: "The models-matter chart lists MAI Code 1.1 Flash (Microsoft AI), which an earlier draft misnamed MyCode; the label is a bare model name like the other bars, with no vendor suffix, and the same name appears in the NOTES.md row. The Qwen 3.8 bar was removed."
tags: [uw-slides, models, naming]
generated: { by: "claude-code:claude-opus-5-5", at: "2026-09-24T03:31:01Z" }
status: stable
governance: constraint
code_refs: [from-hand-coding-to-ai-orchestration/content/27-models-matter.html]
---

## Fact

The bar chart on the "Models took different routes" slide (`content/27-models-matter.html`) names the Microsoft AI coding model **MAI Code 1.1 Flash**. A draft called it "MyCode 1.1 Flash"; that was wrong and was corrected by the project owner on 2026-09-22.

## Keep

- Bars use bare model names (Sonnet 5, Haiku, Kimi K3, GPT Terra, GPT Luna, MAI Code 1.1 Flash). The Qwen 3.8 local 4-bit bar, which had no step count, was removed at the owner's request on 2026-09-23. Do not add vendor names in parentheses; the row fits at 1280x720 as is.
- The chart's `aria-label` repeats every bar's name and step count; update it together with the visible label.
- The `NOTES.md` table row for the slide carries the same name.

## Related Concepts

- [Insert slides with suffixed names and keep order in SLIDES.md; displayed numbers drift from file numbers](slide-order-and-insertions.md): The chart lives in file 27 but is displayed as slide 28 after the insertions; resolve by position in SLIDES.md.
