# Pipeline
* [Fragment-based uw-slides decks are not covered by the PDF and Zenodo workflow](fragment-decks-outside-pdf-workflow.md) - A uw-slides deck builds to <slug>/build/index.html, which is git-ignored and not Reveal.js, so the workflow that renders <slug>/index.html with decktape reveal needs a dedicated build and render step before such a deck can publish.
