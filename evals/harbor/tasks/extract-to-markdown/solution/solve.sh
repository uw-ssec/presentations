#!/bin/bash
set -euo pipefail
cd /app/security-in-age-of-ai
cat > SLIDES.md <<'MD'
# Extracted Presentation

Source: security-in-age-of-ai/index.html (Reveal.js, 3 slides)

## 01-title
Title: Security in the Age of AI
Content: Open source supply chain security: threats, mitigations and hardened workflows

## 02-attack-classes
Title: GitHub Actions attack classes
Main points:
- Mutable tags on third-party actions
- Script injection through event data
- Over-broad workflow permissions

Images: diagram.png (Attack surface of a CI workflow)
Source: GitHub security hardening guide

## 03-hardened-workflows
Title: Hardened workflows
Content: SHA-pin every action, deny permissions by default, bind untrusted data through env.

---
Extraction report: 3 slides, 1 image reference, 1 footnote.
MD
cat SLIDES.md
