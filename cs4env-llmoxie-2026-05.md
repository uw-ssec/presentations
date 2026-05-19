---
marp: true
theme: ssec
size: 16:9
paginate: true
footer: 'Scientific Software Engineering Center - UW'
---

<style>
/* @theme ssec - SSEC Marp Theme, Scientific Software Engineering Center - UW */

@import url('https://fonts.googleapis.com/css2?family=Encode+Sans:wght@400;600;700;800&family=Encode+Sans+Compressed:wght@600&family=Open+Sans:wght@400;600&family=JetBrains+Mono:wght@400;500&display=swap');

section {
  font-family: 'Open Sans', system-ui, sans-serif;
  font-size: 22px;
  font-weight: 400;
  line-height: 1.625;
  color: #1a1d1f;
  background-color: #ffffff;
  padding: 60px 72px;
  width: 1280px;
  height: 720px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}

section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 5px;
  background: linear-gradient(90deg, #4b2e83 0%, #2ad2c9 100%);
}

section h1,
section h2,
section h3,
section h4 {
  font-family: 'Encode Sans', system-ui, sans-serif;
  color: #4b2e83;
  margin: 0 0 0.5em 0;
  line-height: 1.15;
  letter-spacing: -0.015em;
}

section h1 {
  font-size: 48px;
  font-weight: 800;
}

section h2 {
  font-size: 36px;
  font-weight: 700;
}

section h3 {
  font-size: 26px;
  font-weight: 600;
}

section h4 {
  font-size: 22px;
  font-weight: 600;
  letter-spacing: 0;
}

section p {
  margin: 0.4em 0;
  font-size: 20px;
}

section ul,
section ol {
  margin: 0.25em 0 0.25em 1.4em;
  padding: 0;
}

section li {
  margin-bottom: 0.35em;
  font-size: 20px;
  line-height: 1.5;
}

section li::marker {
  color: #4b2e83;
}

section code {
  font-family: 'JetBrains Mono', monospace;
  font-size: 15px;
  font-weight: 500;
  background: #e0d7f0;
  color: #32006e;
  padding: 2px 6px;
  border-radius: 3px;
}

section pre {
  background: #1a0038;
  border-radius: 6px;
  padding: 24px;
  margin: 0.5em 0;
  overflow: hidden;
}

section pre code {
  font-family: 'JetBrains Mono', monospace;
  font-size: 16px;
  font-weight: 400;
  background: transparent;
  color: #2ad2c9;
  padding: 0;
  border-radius: 0;
  line-height: 1.8;
}

section footer {
  position: absolute;
  bottom: 28px;
  left: 72px;
  right: 72px;
  font-family: 'Encode Sans Compressed', system-ui, sans-serif;
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.05em;
  color: #9a9fa4;
  text-transform: uppercase;
}

section::after {
  position: absolute;
  bottom: 28px;
  right: 72px;
  font-family: 'Encode Sans Compressed', system-ui, sans-serif;
  font-size: 14px;
  font-weight: 600;
  color: #9a9fa4;
  content: attr(data-marpit-pagination) ' / ' attr(data-marpit-pagination-total);
}

section.lead {
  justify-content: center;
  align-items: center;
  text-align: center;
  background: #32006e;
  color: #ffffff;
}

section.lead::before {
  background: #2ad2c9;
  height: 4px;
}

section.lead h1,
section.lead h2,
section.lead h3 {
  color: #ffffff;
  font-family: 'Encode Sans', system-ui, sans-serif;
}

section.lead h1 {
  font-size: 52px;
  font-weight: 800;
  letter-spacing: -0.03em;
  margin-bottom: 0.25em;
}

section.lead p,
section.lead li {
  color: #c5b4e3;
  font-size: 22px;
}

section.lead footer,
section.lead::after {
  color: #8b74be;
}

section.dark {
  background: #32006e;
  color: #e0d7f0;
}

section.dark h1,
section.dark h2,
section.dark h3,
section.dark h4 {
  color: #ffffff;
}

section.dark p,
section.dark li {
  color: #c5b4e3;
}

section.dark li::marker {
  color: #2ad2c9;
}

section.terminal {
  background: #1a0038;
  color: #e0d7f0;
}

section.terminal::before {
  background: #2ad2c9;
  height: 4px;
}

section.terminal h1,
section.terminal h2,
section.terminal h3,
section.terminal h4 {
  color: #2ad2c9;
  font-family: 'JetBrains Mono', monospace;
  letter-spacing: 0;
}

section.terminal p,
section.terminal li {
  color: #a899d0;
  font-family: 'JetBrains Mono', monospace;
  font-size: 18px;
}

section.terminal li::marker {
  color: #ffc700;
}

section.two-col .columns {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 48px;
  flex: 1;
}

section.two-col .columns > div {
  overflow: hidden;
}

section.two-col .columns > div h3 {
  font-size: 20px;
  color: #4b2e83;
  border-bottom: 2px solid #b7a57a;
  padding-bottom: 6px;
  margin-bottom: 12px;
}

section.stat {
  justify-content: center;
  background: #f0ecf7;
}

section.stat h2 {
  text-align: center;
  margin-bottom: 0.75em;
}

.stat-grid {
  display: flex;
  gap: 64px;
  justify-content: center;
  align-items: flex-start;
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.stat-number {
  font-family: 'Encode Sans', system-ui, sans-serif;
  font-size: 72px;
  font-weight: 800;
  color: #4b2e83;
  line-height: 1;
  letter-spacing: -0.03em;
}

.stat-label {
  font-family: 'Encode Sans Compressed', system-ui, sans-serif;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: #555a5e;
  margin-top: 8px;
}
</style>

<!-- _class: lead -->
<!-- _paginate: false -->

# CS4Env LLMoxie Talk

[Speaker] - [Event] - [Date]

---

## Source Intake Required

- Treat each markdown section beginning with `#` as one slide.
- Use the bullets under that heading as the slide content.
- Preserve bracketed photo placeholders such as `[insert picture of blank]`.
- Preserve technical claims, evidence, uncertainty, and citations exactly.

---
<!-- _class: two-col -->

## Planned Production Flow

<div class="columns">
<div>

### Input

- Source outline or markdown
- `#` headings define slide boundaries
- Bullets under each `#` become slide content
- Required figures, screenshots, or diagrams
- Bracketed photo placeholders remain visible for later replacement

</div>
<div>

### Output

- Marp source deck: `cs4env-llmoxie-2026-05.md`
- Exportable slides: PDF, PPTX, or HTML
- Speaker notes and asset placeholders where needed

</div>
</div>

---
<!-- _class: terminal -->

## Render Command

```bash
npx @marp-team/marp-cli cs4env-llmoxie-2026-05.md --pdf
npx @marp-team/marp-cli cs4env-llmoxie-2026-05.md --pptx
```

---
<!-- _class: dark -->

## Content Status

The deck is blocked until the detailed CS4Env LLMoxie outline or markdown is supplied.
