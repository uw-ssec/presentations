# Project
* [The uw-slides plugin is vendored under .agents, not installed from a marketplace](uw-slides-plugin-vendored.md) - Slide-building skills live in .agents/skills with .claude/skills symlinked to them, and plugin assets live in .agents/uw-slides, so the repository carries its own copy with repo-relative paths instead of a marketplace install.
* [New Decks Default to uw-slides HTML, Not Reveal.js](deck-format-default.md) - New presentations are uw-slides fragment decks scaffolded with /new-deck and built to build/index.html; Reveal.js is legacy, kept only for security-in-age-of-ai.
