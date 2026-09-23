. /usr/local/lib/skill-evals/fixture.sh
new_repo
presentations_scaffold
fragment_deck demo-talk
commit_file README.md '# presentations

Slide decks from the UW Scientific Software Engineering Center, rendered to PDF
and deposited on Zenodo. See AGENTS.md before making any change.

New decks are uw-slides fragment decks; `security-in-age-of-ai` is the one
legacy Reveal.js deck.' "docs: add the contributor README" 5
commit_all "feat(demo-talk): pass-1 deck" 2
# The tour reads and builds; every tracked file it touched must still match.
mkdir -p /fixture/sha
for f in README.md AGENTS.md index.html demo-talk/SLIDES.md demo-talk/content/01-title.html; do
  sha256sum "$REPO/$f" | cut -d' ' -f1 > "/fixture/sha/$(echo "$f" | tr / _)"
done
mkdir -p /fixture/okf
printf 'project/deck-format-default  Decision  New presentations are uw-slides fragment decks scaffolded with /new-deck and built to build/index.html  (governance: constraint)\n' > /fixture/okf/search.txt
finish_fixture
