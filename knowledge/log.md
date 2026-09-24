## 2026-09-24
* **Update**: Updated concept `from-hand-coding-to-ai-orchestration/closing-sequence.md`.
* **Update**: Updated concept `from-hand-coding-to-ai-orchestration/closing-sequence.md`.
* **Update**: Updated concept `from-hand-coding-to-ai-orchestration/trial-run-model-names.md`.

## 2026-09-23
* **Update**: Updated concept `from-hand-coding-to-ai-orchestration/closing-sequence.md`.
* **Update**: Linked `branding/partner-logo-lockup.md` to `from-hand-coding-to-ai-orchestration/presenter-controls.md` (The footer injects the lockup into every slide alongside the deck controls it already owns).
* **Update**: Linked `branding/partner-logo-lockup.md` to `project/slide-visual-verification.md` (Placing the lockup needs this verification method, extended to elements that merely paint such as decorative bands and dividers).
* **Update**: Linked `branding/partner-logo-lockup.md` to `branding/ssec-slide-brand.md` (The lockup is part of the SSEC slide brand and uses its spacing tokens and colour palette).
* **Creation**: Documented concept `branding/partner-logo-lockup.md` (Partner Logo Lockup: SSEC, eScience, UW on Every Slide).
* **Update**: Linked `project/onboarding-skill.md` to `project/skill-evals.md` (The onboarding skill ships the Inspect sample and Harbor happy-path and guard tasks this eval architecture requires of every skill).
* **Creation**: Documented concept `project/onboarding-skill.md` (Onboarding Is a Read-Only, Checkpointed Guided Tour).
* **Update**: Linked `from-hand-coding-to-ai-orchestration/trial-run-model-names.md` to `from-hand-coding-to-ai-orchestration/slide-order-and-insertions.md` (The chart lives in file 27 but is displayed as slide 28 after the insertions; resolve by position in SLIDES.md.).
* **Update**: Linked `from-hand-coding-to-ai-orchestration/llmoxie-background-slide.md` to `from-hand-coding-to-ai-orchestration/slide-order-and-insertions.md` (The LLMoxie slide is the first suffix-named insertion (08b); its file number and displayed number differ.).
* **Update**: Linked `from-hand-coding-to-ai-orchestration/slide-order-and-insertions.md` to `project/deck-format-default.md` (Suffix naming only works because fragment decks take their order from SLIDES.md, which the default deck format establishes.).
* **Update**: Linked `from-hand-coding-to-ai-orchestration/closing-sequence.md` to `project/slide-content-hierarchy.md` (The closing slides follow the sourcing cascade: ladder and orchestra mapping are tier 2 structures, the thank-you is deliberately tier 4 text.).
* **Update**: Linked `from-hand-coding-to-ai-orchestration/presenter-controls.md` to `project/slide-visual-verification.md` (Footer changes affect every slide; verify with the whole-deck scan and the iframe key harness described there.).
* **Update**: Linked `pipeline/cloudflare-pages-no-build-step.md` to `pipeline/fragment-decks-outside-pdf-workflow.md` (Both describe why a fragment deck has no published page yet: the PDF/Zenodo workflow renders only Reveal.js, and the Cloudflare preview runs no build.).
* **Creation**: Documented concept `from-hand-coding-to-ai-orchestration/presenter-controls.md` (Deck-level presenter controls live in shared/footer.html: walkthrough keys, progress bar, full-screen toggle).
* **Creation**: Documented concept `from-hand-coding-to-ai-orchestration/trial-run-model-names.md` (Trial-run model names on the models-matter chart).
* **Creation**: Documented concept `from-hand-coding-to-ai-orchestration/closing-sequence.md` (Closing sequence: Monday ladder, orchestra metaphor, shared-source callback, plain thank-you).
* **Creation**: Documented concept `from-hand-coding-to-ai-orchestration/llmoxie-background-slide.md` (The LLMoxie slide is background that leads into the demo project, not a platform tour).
* **Creation**: Documented concept `from-hand-coding-to-ai-orchestration/slide-order-and-insertions.md` (Insert slides with suffixed names and keep order in SLIDES.md; displayed numbers drift from file numbers).
* **Creation**: Documented concept `pipeline/cloudflare-pages-no-build-step.md` (Cloudflare Pages deploys the repository as static files with no build step).

## 2026-09-22
* **Update**: Linked `project/slide-visual-verification.md` to `pipeline/fragment-decks-outside-pdf-workflow.md` (Fitting in the browser does not guarantee fitting in the deposited PDF, so the export needs its own pass.).
* **Update**: Linked `project/slide-visual-verification.md` to `project/slide-content-hierarchy.md` (The content hierarchy decides what goes on a slide; this check confirms what landed there actually fits inside it.).
* **Creation**: Documented concept `project/slide-visual-verification.md` (Verifying a slide change visually: nothing outside the 1280x720 boundary).
* **Update**: Linked `project/slide-content-hierarchy.md` to `pipeline/fragment-decks-outside-pdf-workflow.md` (Rich tier-1 and tier-2 elements do not survive the decktape PDF export this concept governs, so every such slide needs a static fallback frame for the Zenodo deposit.).
* **Update**: Updated concept `project/slide-content-hierarchy.md`.
* **Update**: Linked `project/slide-content-hierarchy.md` to `branding/ssec-slide-brand.md` (Brand sets how a slide looks; the content hierarchy sets what carries its idea. A tier-2 chart still uses the ssec tokens and 24px type floor.).
* **Update**: Linked `project/slide-content-hierarchy.md` to `project/deck-format-default.md` (The tier choice is made during the SLIDES.md planning pass of the two-pass fragment deck workflow this concept defines.).
* **Creation**: Documented concept `project/slide-content-hierarchy.md` (Slide content hierarchy: animation, then visuals, then tables, then text).

## 2026-09-21
* **Update**: Linked `project/skill-evals.md` to `project/deck-format-default.md` (The decision the new-deck guard task enforces.).
* **Update**: Linked `project/skill-evals.md` to `project/uw-slides-plugin-vendored.md` (The skills under test and the assets the base image carries for them.).
* **Update**: Updated concept `project/skill-evals.md`.
* **Update**: Linked `project/deck-format-default.md` to `project/skill-evals.md` (The guard task that checks a new deck is a fragment deck even when asked to copy the Reveal.js one.).
* **Update**: Linked `project/uw-slides-plugin-vendored.md` to `project/skill-evals.md` (How the vendored skills are tested.).
* **Update**: Linked `project/skill-evals.md` to `project/deck-format-default.md` (The decision the new-deck guard task enforces.).
* **Update**: Linked `project/skill-evals.md` to `project/uw-slides-plugin-vendored.md` (The skills under test and the assets the base image carries for them.).
* **Creation**: Documented concept `project/skill-evals.md` (Skill Evals with Inspect and Harbor).
* **Update**: Linked `project/deck-format-default.md` to `project/uw-slides-plugin-vendored.md` (The vendored skills and assets that produce the default deck format.).
* **Update**: Linked `pipeline/fragment-decks-outside-pdf-workflow.md` to `project/deck-format-default.md` (The decision that makes fragment decks the default, which turns this gap from an edge case into the normal path.).
* **Update**: Linked `project/deck-format-default.md` to `pipeline/fragment-decks-outside-pdf-workflow.md` (The workflow gap that keeps a default-format deck from publishing until CI gains a fragment build step.).
* **Update**: Updated concept `project/deck-format-default.md`.
* **Update**: Linked `project/uw-slides-plugin-vendored.md` to `project/deck-format-default.md` (The decision that makes this plugin's fragment format the default for every new deck.).
* **Update**: Linked `project/deck-format-default.md` to `project/uw-slides-plugin-vendored.md` (The vendored skills and assets that produce the default deck format.).
* **Creation**: Documented concept `project/deck-format-default.md` (New Decks Default to uw-slides HTML, Not Reveal.js).
* **Update**: Linked `project/uw-slides-plugin-vendored.md` to `pipeline/fragment-decks-outside-pdf-workflow.md` (Decks produced by the vendored plugin are the ones the PDF workflow does not yet render).
* **Update**: Linked `project/uw-slides-plugin-vendored.md` to `branding/ssec-slide-brand.md` (The SSEC brand is one of the two brands shipped inside the vendored plugin and is its default).
* **Update**: Linked `branding/ssec-slide-brand.md` to `branding/ssec-contrast-measurements.md` (The contrast measurements set the text-color rules the SSEC brand guide and design-review skill enforce).
* **Creation**: Documented concept `pipeline/fragment-decks-outside-pdf-workflow.md` (Fragment-based uw-slides decks are not covered by the PDF and Zenodo workflow).
* **Creation**: Documented concept `project/uw-slides-plugin-vendored.md` (The uw-slides plugin is vendored under .agents, not installed from a marketplace).
* **Creation**: Documented concept `branding/ssec-contrast-measurements.md` (Measured WCAG contrast for SSEC slide colors differs from the website tables).
* **Creation**: Documented concept `branding/ssec-slide-brand.md` (SSEC is the default slide brand, adapted from the website design system).
* **Creation**: Initialized OKF v0.2 knowledge bundle.
