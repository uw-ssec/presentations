. /usr/local/lib/skill-evals/fixture.sh
new_repo
presentations_scaffold
fragment_deck demo-talk
# 02: hardcoded brand hex instead of the token.
fragment "$REPO/demo-talk" 02-problem "Slide 2: Decks drift when every slide is hand-styled" \
  '<div class="wrap"><h1>Decks drift when every slide is hand-styled</h1><p class="lead">Every talk reinvents its own type scale.</p></div>' \
  'background: #4b2e83; color: var(--color-white);'
# 03: no accent bar, and teal-500 as text on a light surface.
cat > "$REPO/demo-talk/content/03-approach.html" <<'HTML'
<section data-slide="03-approach"
         aria-label="Slide 3: One fragment per slide, one build script"
         class="slide">
  <div class="wrap"><h1>One fragment per slide, one build script</h1><p class="lead">Concatenate, rehearse, revise.</p></div>
  <style>
    section[data-slide="03-approach"] { background: var(--color-white); color: var(--text-primary); display: grid; place-items: center; padding: var(--space-16); }
    section[data-slide="03-approach"] h1 { font-family: var(--font-display); font-size: var(--slide-title); margin: 0 0 var(--space-4); }
    section[data-slide="03-approach"] .lead { font-family: var(--font-body); font-size: var(--slide-lead); color: var(--color-teal-500); }
  </style>
</section>
HTML
(cd "$REPO/demo-talk" && ./build.sh >/dev/null)
mkdir -p /fixture/sha
for f in 01-title 02-problem 03-approach; do
  sha256sum "$REPO/demo-talk/content/$f.html" | cut -d' ' -f1 > "/fixture/sha/$f"
done
commit_all "feat(demo-talk): pass-1 deck" 2
finish_fixture
