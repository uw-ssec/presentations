# Sourced by each task's environment/fixture.sh during the image build.
# Builds a git repo at /app that looks like this repository.
set -euo pipefail
REPO=/app
G=/usr/bin/git   # bypass the logging wrapper while building fixtures
SRC=/opt/repo    # AGENTS.md, .agents/rules, .agents/uw-slides (synced at image build)

new_repo() {
  mkdir -p "$REPO"
  $G init -q -b main "$REPO"
}

# commit_file <path> <content> <message> [days_ago]
commit_file() {
  local path="$1" content="$2" msg="$3" days="${4:-0}"
  local when
  when="$(date -d "$days days ago" '+%Y-%m-%dT12:00:00')"
  mkdir -p "$REPO/$(dirname "$path")"
  printf '%s\n' "$content" > "$REPO/$path"
  $G -C "$REPO" add "$path"
  GIT_AUTHOR_DATE="$when" GIT_COMMITTER_DATE="$when" $G -C "$REPO" commit -q -m "$msg"
}

# commit_all <message> [days_ago] -- stage everything and commit
commit_all() {
  local msg="$1" days="${2:-0}"
  local when
  when="$(date -d "$days days ago" '+%Y-%m-%dT12:00:00')"
  $G -C "$REPO" add -A
  GIT_AUTHOR_DATE="$when" GIT_COMMITTER_DATE="$when" $G -C "$REPO" commit -q -m "$msg"
}

# A minimal presentations lookalike: AGENTS.md and the rules, the vendored
# uw-slides assets, a gallery, the legacy Reveal.js deck, and an OKF bundle.
presentations_scaffold() {
  cp "$SRC/AGENTS.md" "$SRC/CLAUDE.md" "$REPO/"
  mkdir -p "$REPO/.agents"
  cp -R "$SRC/.agents/rules" "$REPO/.agents/rules"
  cp -R "$SRC/.agents/uw-slides" "$REPO/.agents/uw-slides"
  # The skills the agent receives through /skills also live where AGENTS.md says.
  mkdir -p "$REPO/.agents/skills"
  for s in /skills/*/; do
    n="$(basename "$s")"
    [ "$n" = "greeting-file" ] && continue
    cp -R "$s" "$REPO/.agents/skills/$n"
  done
  mkdir -p "$REPO/.claude" && ln -s ../.agents/skills "$REPO/.claude/skills"
  printf 'build/\n.pixi/\nknowledge/.obsidian/\n' > "$REPO/.gitignore"
  cat > "$REPO/index.html" <<'HTML'
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>SSEC Presentations</title></head>
<body>
<h1>SSEC Presentations</h1>
<ul class="gallery">
  <li><a href="security-in-age-of-ai/index.html">Security in the Age of AI</a></li>
</ul>
</body></html>
HTML
  legacy_reveal_deck
  mkdir -p "$REPO/knowledge"
  printf -- '---\nokf_version: "0.2"\n---\n\n# Knowledge Base\n\nProject memory for presentations.\n' > "$REPO/knowledge/index.md"
  printf '## 2026-09-01\n* **Creation**: Initialized OKF v0.2 knowledge bundle.\n' > "$REPO/knowledge/log.md"
  commit_all "chore: scaffold the presentations repository" 30
}

# The one Reveal.js deck, small enough to read in a verifier.
legacy_reveal_deck() {
  mkdir -p "$REPO/security-in-age-of-ai"
  cat > "$REPO/security-in-age-of-ai/index.html" <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Security in the Age of AI</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reveal.css">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="reveal"><div class="slides">
  <section id="title">
    <h1>Security in the Age of AI</h1>
    <p>Open source supply chain security: threats, mitigations and hardened workflows</p>
  </section>
  <section id="attack-classes">
    <h2>GitHub Actions attack classes</h2>
    <ul>
      <li>Mutable tags on third-party actions</li>
      <li>Script injection through event data</li>
      <li>Over-broad workflow permissions</li>
    </ul>
    <img src="diagram.png" alt="Attack surface of a CI workflow">
    <div class="footnote">Source: GitHub security hardening guide</div>
  </section>
  <section id="hardened-workflows">
    <h2>Hardened workflows</h2>
    <p>SHA-pin every action, deny permissions by default, bind untrusted data through env.</p>
  </section>
</div></div>
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reveal.js"></script>
<script>Reveal.initialize({ width: 1280, height: 720 });</script>
</body>
</html>
HTML
  printf '.footnote { font-size: 0.5em; }\n' > "$REPO/security-in-age-of-ai/styles.css"
  cat > "$REPO/security-in-age-of-ai/zenodo.json" <<'JSON'
{
  "slug": "security-in-age-of-ai",
  "community": "uw-ssec",
  "title": "Security in the Age of AI",
  "upload_type": "presentation",
  "description": "<p>Slides.</p>",
  "creators": [{"name": "Presenter, Example", "affiliation": "Example University"}],
  "keywords": ["security"],
  "license": "cc-by-4.0",
  "pdf": "security-in-age-of-ai.pdf"
}
JSON
}

# fragment_deck <slug> -- a scaffolded SSEC-brand uw-slides deck at /app/<slug>
# with three clean pass-1 fragments, exactly as /new-deck would lay it out.
fragment_deck() {
  local slug="$1" d="$REPO/$1" t="$SRC/.agents/uw-slides"
  mkdir -p "$d/shared" "$d/content" "$d/content-with-visuals" "$d/assets/images" "$d/assets/diagrams"
  cp "$t/design-systems/ssec-brand/shared/header.html" "$d/shared/header.html"
  cp "$t/templates/shared/footer.html" "$d/shared/footer.html"
  cp "$t/templates/build.sh" "$t/templates/build-visuals.sh" "$d/"
  chmod +x "$d/build.sh" "$d/build-visuals.sh"
  cp "$t/templates/VISUALS.md" "$d/VISUALS.md"
  cat > "$d/SLIDES.md" <<'MD'
# Demo Talk

A three-slide SSEC deck used by the skill evals.

## 01-title

Title slide. Key message: Reproducible slides from HTML fragments.

## 02-problem

Key message: Decks drift when every slide is hand-styled.

## 03-approach

Key message: One fragment per slide, one build script.
MD
  fragment "$d" 01-title "Slide 1: Reproducible slides from HTML fragments" \
    '<div class="wrap"><p class="eyebrow">SSEC RSE Meetup</p><h1>Reproducible slides from HTML fragments</h1><p class="lead">A demo talk</p></div>' \
    'background: var(--color-purple-950); color: var(--color-white);'
  fragment "$d" 02-problem "Slide 2: Decks drift when every slide is hand-styled" \
    '<div class="wrap"><h1>Decks drift when every slide is hand-styled</h1><p class="lead">Every talk reinvents its own type scale.</p></div>' \
    'background: var(--color-white); color: var(--text-primary);'
  fragment "$d" 03-approach "Slide 3: One fragment per slide, one build script" \
    '<div class="wrap"><h1>One fragment per slide, one build script</h1><p class="lead">Concatenate, rehearse, revise.</p></div>' \
    'background: var(--color-white); color: var(--text-primary);'
  printf 'build/\n.DS_Store\n' > "$d/.gitignore"
  printf '# Demo Talk\n\nSee SLIDES.md.\n' > "$d/README.md"
}

# fragment <deck-dir> <id> <aria-label> <inner-html> <section-css>
fragment() {
  local d="$1" id="$2" label="$3" inner="$4" css="$5"
  cat > "$d/content/$id.html" <<HTML
<section data-slide="$id"
         aria-label="$label"
         class="slide accent-bar-top">
  $inner
  <style>
    section[data-slide="$id"] { $css display: grid; place-items: center; padding: var(--space-16); }
    section[data-slide="$id"] h1 { font-family: var(--font-display); font-size: var(--slide-title); margin: 0 0 var(--space-4); }
    section[data-slide="$id"] .lead { font-family: var(--font-body); font-size: var(--slide-lead); }
  </style>
</section>
HTML
}

# Clears logs written while building, so verifiers only see the agent's calls.
finish_fixture() {
  rm -rf /var/log/skill-shims/*
}
