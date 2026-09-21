. /usr/local/lib/skill-evals/fixture.sh
new_repo
presentations_scaffold
fragment_deck demo-talk
# 02: image without alt text.
fragment "$REPO/demo-talk" 02-problem "Slide 2: Decks drift when every slide is hand-styled" \
  '<div class="wrap"><h1>Decks drift when every slide is hand-styled</h1><img src="assets/images/pipeline.png" class="slide-photo"></div>' \
  'background: var(--color-white); color: var(--text-primary);'
# 03: body text below the 24px floor.
cat > "$REPO/demo-talk/content/03-approach.html" <<'HTML'
<section data-slide="03-approach"
         aria-label="Slide 3: One fragment per slide, one build script"
         class="slide accent-bar-top">
  <div class="wrap"><h1>One fragment per slide, one build script</h1><p class="lead">Concatenate, rehearse, revise.</p></div>
  <style>
    section[data-slide="03-approach"] { background: var(--color-white); color: var(--text-primary); display: grid; place-items: center; padding: var(--space-16); }
    section[data-slide="03-approach"] h1 { font-family: var(--font-display); font-size: var(--slide-title); margin: 0 0 var(--space-4); }
    section[data-slide="03-approach"] .lead { font-family: var(--font-body); font-size: 16px; }
  </style>
</section>
HTML
# 04: no aria-label.
cat > "$REPO/demo-talk/content/04-summary.html" <<'HTML'
<section data-slide="04-summary"
         class="slide accent-bar-top">
  <div class="wrap"><h1>Summary</h1><p class="lead">Fragments, one build, rehearse.</p></div>
  <style>
    section[data-slide="04-summary"] { background: var(--color-white); color: var(--text-primary); display: grid; place-items: center; padding: var(--space-16); }
    section[data-slide="04-summary"] h1 { font-family: var(--font-display); font-size: var(--slide-title); }
    section[data-slide="04-summary"] .lead { font-family: var(--font-body); font-size: var(--slide-lead); }
  </style>
</section>
HTML
printf '\n## 04-summary\n\nKey message: Fragments, one build, rehearse.\n' >> "$REPO/demo-talk/SLIDES.md"
(cd "$REPO/demo-talk" && ./build.sh >/dev/null)
mkdir -p /fixture/sha
for f in 01-title 02-problem 03-approach 04-summary; do
  sha256sum "$REPO/demo-talk/content/$f.html" | cut -d' ' -f1 > "/fixture/sha/$f"
done
commit_all "feat(demo-talk): pass-1 deck" 2
finish_fixture
