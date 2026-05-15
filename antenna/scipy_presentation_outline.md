# Presentation Outline

**Efficient Federated Inference on Entomology Images with PyTorch**

SciPy 2026 · 30-minute talk · Author: Carlos Garcia Jurado Suarez

---

## Talk Overview

| Time    | Section                                                          |
| ------- | ---------------------------------------------------------------- |
| ~3 min  | Introduction — Antenna platform, problem statement, talk roadmap |
| ~11 min | Part 1 — Async Pull Architecture (Processing Service v2)         |
| ~11 min | Part 2 — PyTorch GPU Inference Optimization                      |
| ~5 min  | Results, takeaways, Q&A                                          |

---

## Section 1 — Introduction

Goal: orient a generalist Python/data science audience to the domain and motivate both engineering problems. Keep it tight — 3 minutes.

### Slide 1: Title slide `[30 sec]`

- Talk title, speaker name, affiliation (UW eScience Institute / Mila Institute)
- Conference name and date

> 📝 Clean title slide. No heavy graphics needed. Placeholder for: small Antenna logo or a single camera-trap insect photo as background.
> Website for context/logo/images: https://www.insectai.org/

---

### Slide 2: What is Antenna? `[1.5 min]`

- Open-source platform from the Mila Institute
- Processes images from automated wildlife camera traps in the field
- Classifies insect species using deep learning — supporting biodiversity monitoring at scale
- Used by multiple research institutions across different deployment environments

> 📝 **PLACEHOLDER:** Screenshot of the Antenna web interface (image catalog view or monitoring dashboard). One clear screenshot is enough. Caption: "Antenna web platform — researchers submit image batches and review classification results."
>
> Keep the explanation brief. One sentence on biodiversity monitoring is sufficient — this is context, not the talk topic.

---

### Slide 3: The scaling problem `[1 min]`

- As adoption grew: jobs went from hundreds to millions of images
- Two interconnected problems emerged:
  - Third-party researchers couldn't easily integrate their own ML pipelines
  - The platform couldn't scale processing to large jobs or multiple models
- This talk: two engineering changes that solve both

> 📝 This slide sets up the two-part structure. Use a simple two-column or two-row layout with the two problems side by side, visually foreshadowing the two parts.

---

## Section 2 — Part 1: Async Pull Architecture

Goal: explain what was broken in the original design and how inverting the communication model fixed it. Conceptual, no deep code.

### Slide 4: How the original system worked `[2 min]`

- Antenna pushed image batches to external ML processing services (PS) over HTTP
- Each PS had to expose a public HTTP endpoint — hard to deploy in university HPC environments, behind firewalls, etc.
- Processing was synchronous: Antenna waited for each response before moving on
- Scalability was entirely the PS implementor's problem

> 📝 **DIAGRAM A — Push model (before).** Mermaid sequence diagram. Flow: Antenna → HTTP push → Processing Service → synchronous response → Antenna. Show that PS requires a public endpoint. Highlight two pain points: (1) arrow from internet to PS labeled "requires public endpoint", (2) blocking return arrow labeled "synchronous — waits for response."

---

### Slide 5: The redesign — pull model `[3 min]`

- Invert the direction: PS workers poll Antenna's job queue and pull task batches on their own schedule
- PS no longer needs a public endpoint — it initiates all outbound connections
- Workers can run behind a firewall, on a university HPC cluster, or on a local machine
- Multiple workers can poll the same queue independently — horizontal scaling falls out naturally
- Different ML pipelines register with Antenna and pull only jobs matching their pipeline

> 📝 **DIAGRAM B — Pull model (after).** Mermaid sequence diagram. Flow: PS Worker polls Antenna jobs API → Antenna returns task batch → PS processes locally → PS posts results back. Show two worker instances to illustrate horizontal scale. Key contrast: PS worker is now the initiator, not the receiver.

---

### Slide 6: Worker implementation — `ami worker` `[2 min]`

- Ships as `ami worker` CLI command in the `ami-data-companion` package
- Configuration via environment variables or `.env` file (API URL, auth token, batch size)
- Worker loop: poll `/jobs` endpoint → fetch task batch → run ML pipeline → POST results back
- Supports multiple pipelines via; any number of workers can run in parallel

> 📝 **OPTIONAL CODE SNIPPET:** Show the 3-line usage pattern (`export` env vars, `ami worker register`, `ami worker`). Illustrative only — keep font large.
>
> No deep architecture diagram needed here. The sequence diagram from Slide 5 carries the conceptual weight. This slide makes it concrete for practitioners.

---

### Slide 7: Part 1 results `[2 min]`

- PS workers can now run anywhere with outbound HTTP — no public endpoint required
- Horizontal scaling: add more workers without changing Antenna
- Extensibility: new ML pipelines register and pull independently, researchers can build their own workers
- Workers can run across multiple research institutions running different hardware configurations

> 📝 If a before/after deployment diagram is available (e.g., showing a university HPC setup that was previously impossible), this is a good place for it. Otherwise keep as a clean bullet summary.

---

## Section 3 — Part 2: PyTorch GPU Inference Optimization

Goal: show the performance problem, walk through the four concrete fixes, and land the 15x number. Balanced between conceptual explanation and practical takeaways.

### Slide 8: The performance baseline `[2 min]`

- Original sync-mode processing service: **1,674 seconds** for 1,000 images on an RTX A6000
- GPU utilization was poor — significant idle gaps visible in profiling
- Root causes: CPU-GPU transfer bottlenecks, synchronous result posting, suboptimal data loading

> 📝 **DIAGRAM C — GPU utilization before optimization.** Horizontal timeline (Gantt style). Two rows: GPU and CPU. Show large idle gaps on the GPU row. If a real `nvidia-smi` or PyTorch profiler screenshot is available from PR #122, use that as reference or include directly.
>
> The 1,674 second number is the anchor. Make it large and typographically prominent on this slide.

---

### Slide 9: Fix 1 — Keep data on the GPU between stages `[2 min]`

- Detection and classification are two sequential model passes
- Original code converted intermediate tensors back to PIL images between passes
- This forced a GPU → CPU → GPU round-trip transfer for every image in the batch
- Fix: keep tensors on GPU and pass them directly from detector to classifier

> 📝 **DIAGRAM D — CPU-GPU data flow before/after.** Two rows. Before: `GPU → PIL Image (CPU) → GPU`. After: `GPU → GPU` (direct). Use color to highlight the unnecessary CPU hop in the before row.

---

### Slide 10: Fix 2 — Pinned memory and batch collation `[2 min]`

- `pin_memory=True` in the DataLoader enables DMA transfers — CPU memory is page-locked, avoiding an extra copy on the way to the GPU
- Batch collation (stacking images into a tensor) was happening in the main process
- For large images this stacking is slow and blocks the GPU pipeline
- Fix: move collation into DataLoader workers so it runs in parallel with GPU computation

> 📝 No diagram needed — bullet points are sufficient. Optional: one-line code snippet showing `pin_memory=True` in the DataLoader constructor. Keep font large.

---

### Slide 11: Fix 3 — CUDA streams for prefetching `[2 min]`

- GPU was idle waiting for the next batch to transfer from CPU
- CUDA streams allow concurrent execution: stream A processes batch N while stream B prefetches batch N+1 into GPU memory
- Result: near-continuous GPU utilization instead of alternating compute/transfer cycles

> 📝 **DIAGRAM E — CUDA stream pipeline before/after.** Two timelines. Before: Transfer → Compute → Transfer → Compute (sequential, with gaps). After: overlapping Transfer and Compute using two streams. A Gantt-style diagram works well.

---

### Slide 12: Fix 4 — Async result posting `[1.5 min]`

- After each batch, results were posted to Antenna synchronously — GPU sat idle during the HTTP request
- Fix: `ResultPoster` runs in a background thread
- Worker loads and processes batch N+1 while batch N results are being posted

> 📝 This fix is the same principle as CUDA streams applied at the API layer — overlap I/O with compute. No separate diagram needed if Diagram E already illustrates the concept.

---

### Slide 13: Combined results `[2 min]`

- After all four optimizations: **108 seconds** for 1,000 images — a **15x improvement** on a single GPU
- 42,000-image job completed in 77 minutes with no interruptions
- Async architecture adds a further multiplier: multiple workers scale linearly
- Key insight: The system has multiple resources: GPU, CPU, Network and GPU/CPU bus - keep them all busy

> 📝 **DIAGRAM F — GPU utilization after optimization.** Mirror of Diagram C. Near-continuous GPU utilization. Use a real profiler screenshot from PR #122 if available.
>
> **OPTIONAL:** Side-by-side bar chart showing 1,674s vs. 108s.
>
> This is the climax slide of the talk. Give the **15x** number maximum visual weight — consider large-text treatment with the two raw numbers below it.

---

## Section 4 — Conclusion & Takeaways

### Slide 14: Summary and generalization `[2 min]`

- Part 1 takeaway: inverting push/pull makes distributed ML inference dramatically easier to deploy and scale
- Part 2 takeaway: four concrete PyTorch optimizations — each addressing a different bottleneck — compound to a 15x gain
- Both contributions generalize: applicable to any image classification workload, not just entomology
- Antenna is open source — links on next slide

> 📝 Optional: a single architectural overview diagram showing the full system (Antenna + multiple async workers) as a clean visual summary.

---

### Slide 15: Links and Q&A `[3 min]`

- Antenna platform: [insectai.org](https://www.insectai.org/)
- Worker + optimizations: [github.com/RolnickLab/ami-data-companion](https://github.com/RolnickLab/ami-data-companion)
- Antenna backend (async job queue API): [github.com/RolnickLab/antenna](https://github.com/RolnickLab/antenna)

> 📝 Keep this slide simple. White background, links, optional QR codes. Leave space for Q&A discussion.

---

## Diagram Summary

All six diagrams should be created as SVG for reuse across slides and poster.

| #   | Name                     | Type                     | Key content                                                                            |
| --- | ------------------------ | ------------------------ | -------------------------------------------------------------------------------------- |
| A   | Push model — before      | Mermaid sequence diagram | Antenna pushes to PS; PS requires public endpoint; synchronous blocking response       |
| B   | Pull model — after       | Mermaid sequence diagram | PS worker polls job queue; pulls batches; posts results; two workers shown for scale   |
| C   | GPU utilization — before | Gantt/timeline           | GPU and CPU rows; large idle gaps on GPU; reference nvidia-smi screenshot if available |
| D   | CPU-GPU data flow        | Horizontal flow diagram  | Before: GPU→CPU→GPU; After: GPU→GPU direct; color-code the unnecessary CPU hop         |
| E   | CUDA stream pipeline     | Gantt/timeline           | Before: sequential transfer/compute; After: overlapping streams                        |
| F   | GPU utilization — after  | Gantt/timeline           | Mirror of Diagram C; near-continuous GPU utilization                                   |

---

## Design Notes

- **Style:** Clean and minimal. White or off-white background. One or two accent colors (suggestion: deep blue `#1A5276` with a light complementary tone). No decorative elements.
- **Font:** Single sans-serif family throughout (e.g. Inter, Source Sans Pro). Body text no smaller than 24pt on slides.
- **Diagrams:** All as SVG. Consistent line weight and color palette across all six. Must also render legibly on an A0 conference poster.
- **Code snippets:** Monospace font with syntax highlighting. Limit to 5–8 lines per slide. Only include where they add concrete value.
- **Key numbers:** 1,674s, 108s, 15x, 42K images, 77 min — typographically prominent wherever they appear. Consider large-text treatment on results slides.
- **Placeholders:** Slides 2 and 13 require screenshots from the Antenna platform. These will be provided separately. Leave clearly labeled placeholder rectangles in the layout.
