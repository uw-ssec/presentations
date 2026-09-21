. /usr/local/lib/skill-evals/fixture.sh
new_repo
presentations_scaffold
commit_file knowledge/project/deck-format-default.md '---
id: project/deck-format-default
title: New Decks Default to uw-slides HTML, Not Reveal.js
type: Decision
description: New presentations are uw-slides fragment decks scaffolded with /new-deck and built to build/index.html
governance: constraint
code_refs:
  - .agents/skills/new-deck/SKILL.md
generated: true
---

New decks are uw-slides fragment decks. Reveal.js is legacy.' "feat(knowledge): record the deck format decision" 3
mkdir -p /fixture/okf
printf 'project/deck-format-default  Decision  New presentations are uw-slides fragment decks scaffolded with /new-deck and built to build/index.html  (governance: constraint)\n' > /fixture/okf/search.txt
finish_fixture
